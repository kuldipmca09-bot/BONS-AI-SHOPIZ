package com.salesmanager.shop.store.api.exception;

import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.dao.OptimisticLockingFailureException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.NoHandlerFoundException;

import com.salesmanager.core.business.exception.ServiceException;
import com.salesmanager.shop.filter.RequestIdFilter;

/**
 * Centralized exception handler for the REST API surface
 * ({@code com.salesmanager.shop.store.api}).
 *
 * Responsibilities:
 *  - Map every exception to a deterministic HTTP status.
 *  - Produce a uniform {@link ApiError} body with timestamp, status, code,
 *    message, path, traceId, and field-level errors when relevant.
 *  - Log with full context server-side; never leak stack traces or raw
 *    persistence-layer messages (SQL, constraint names) to clients.
 *
 * The advice is package-scoped to the REST API only, so the legacy MVC
 * {@code ShopErrorController} continues to handle view-rendered errors.
 */
@Order(Ordered.HIGHEST_PRECEDENCE)
@RestControllerAdvice(basePackages = "com.salesmanager.shop.store.api")
public class RestErrorHandler {

    private static final Logger log = LoggerFactory.getLogger(RestErrorHandler.class);

    private static final String GENERIC_MESSAGE = "An unexpected error occurred. Please contact support with the traceId.";
    private static final String DB_MESSAGE = "Request could not be completed due to a data integrity error.";

    // ----- Validation ------------------------------------------------------

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ApiError> handleMethodArgumentNotValid(MethodArgumentNotValidException ex,
                                                                 HttpServletRequest req) {
        ApiError body = base(HttpStatus.BAD_REQUEST, "Validation failed for request body", req).withCode("400");
        for (FieldError fe : ex.getBindingResult().getFieldErrors()) {
            body.addFieldError(fe.getField(), fe.getRejectedValue(), fe.getDefaultMessage());
        }
        logClientError(ex, req, HttpStatus.BAD_REQUEST);
        return ResponseEntity.badRequest().body(body);
    }

    @ExceptionHandler(BindException.class)
    public ResponseEntity<ApiError> handleBind(BindException ex, HttpServletRequest req) {
        ApiError body = base(HttpStatus.BAD_REQUEST, "Validation failed for request parameters", req).withCode("400");
        for (FieldError fe : ex.getBindingResult().getFieldErrors()) {
            body.addFieldError(fe.getField(), fe.getRejectedValue(), fe.getDefaultMessage());
        }
        logClientError(ex, req, HttpStatus.BAD_REQUEST);
        return ResponseEntity.badRequest().body(body);
    }

    @ExceptionHandler(ConstraintViolationException.class)
    public ResponseEntity<ApiError> handleConstraintViolation(ConstraintViolationException ex,
                                                              HttpServletRequest req) {
        ApiError body = base(HttpStatus.BAD_REQUEST, "Constraint violation", req).withCode("400");
        Set<ConstraintViolation<?>> violations = ex.getConstraintViolations();
        if (violations != null) {
            for (ConstraintViolation<?> v : violations) {
                String field = v.getPropertyPath() != null ? v.getPropertyPath().toString() : null;
                body.addFieldError(field, v.getInvalidValue(), v.getMessage());
            }
        }
        logClientError(ex, req, HttpStatus.BAD_REQUEST);
        return ResponseEntity.badRequest().body(body);
    }

    @ExceptionHandler(ValidationException.class)
    public ResponseEntity<ApiError> handleAppValidation(ValidationException ex, HttpServletRequest req) {
        ApiError body = base(HttpStatus.BAD_REQUEST, ex.getErrorMessage(), req).withCode(ex.getErrorCode());
        for (ValidationException.FieldViolation v : ex.getViolations()) {
            body.addFieldError(v.getField(), v.getRejectedValue(), v.getMessage());
        }
        logClientError(ex, req, HttpStatus.BAD_REQUEST);
        return ResponseEntity.badRequest().body(body);
    }

    // ----- HTTP plumbing ---------------------------------------------------

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<ApiError> handleNotReadable(HttpMessageNotReadableException ex, HttpServletRequest req) {
        logClientError(ex, req, HttpStatus.BAD_REQUEST);
        return ResponseEntity.badRequest().body(
                base(HttpStatus.BAD_REQUEST, "Malformed JSON request", req).withCode("400"));
    }

    @ExceptionHandler(MissingServletRequestParameterException.class)
    public ResponseEntity<ApiError> handleMissingParam(MissingServletRequestParameterException ex,
                                                      HttpServletRequest req) {
        logClientError(ex, req, HttpStatus.BAD_REQUEST);
        return ResponseEntity.badRequest().body(
                base(HttpStatus.BAD_REQUEST,
                        "Missing required parameter: " + ex.getParameterName(),
                        req).withCode("400"));
    }

    @ExceptionHandler(MethodArgumentTypeMismatchException.class)
    public ResponseEntity<ApiError> handleTypeMismatch(MethodArgumentTypeMismatchException ex,
                                                       HttpServletRequest req) {
        logClientError(ex, req, HttpStatus.BAD_REQUEST);
        String message = "Parameter '" + ex.getName() + "' has an invalid value";
        return ResponseEntity.badRequest().body(
                base(HttpStatus.BAD_REQUEST, message, req).withCode("400"));
    }

    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public ResponseEntity<ApiError> handleMethodNotSupported(HttpRequestMethodNotSupportedException ex,
                                                             HttpServletRequest req) {
        logClientError(ex, req, HttpStatus.METHOD_NOT_ALLOWED);
        return ResponseEntity.status(HttpStatus.METHOD_NOT_ALLOWED).body(
                base(HttpStatus.METHOD_NOT_ALLOWED, ex.getMessage(), req).withCode("405"));
    }

    @ExceptionHandler(HttpMediaTypeNotSupportedException.class)
    public ResponseEntity<ApiError> handleMediaType(HttpMediaTypeNotSupportedException ex, HttpServletRequest req) {
        logClientError(ex, req, HttpStatus.UNSUPPORTED_MEDIA_TYPE);
        return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE).body(
                base(HttpStatus.UNSUPPORTED_MEDIA_TYPE, ex.getMessage(), req).withCode("415"));
    }

    @ExceptionHandler(NoHandlerFoundException.class)
    public ResponseEntity<ApiError> handleNoHandler(NoHandlerFoundException ex, HttpServletRequest req) {
        logClientError(ex, req, HttpStatus.NOT_FOUND);
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                base(HttpStatus.NOT_FOUND, "No endpoint " + ex.getHttpMethod() + " " + ex.getRequestURL(), req)
                        .withCode("404"));
    }

    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public ResponseEntity<ApiError> handleMaxUpload(MaxUploadSizeExceededException ex, HttpServletRequest req) {
        logClientError(ex, req, HttpStatus.PAYLOAD_TOO_LARGE);
        return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE).body(
                base(HttpStatus.PAYLOAD_TOO_LARGE, "Uploaded file exceeds the allowed size", req).withCode("413"));
    }

    // ----- Domain ----------------------------------------------------------

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ApiError> handleNotFound(ResourceNotFoundException ex, HttpServletRequest req) {
        logClientError(ex, req, HttpStatus.NOT_FOUND);
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                base(HttpStatus.NOT_FOUND, ex.getErrorMessage(), req)
                        .withCode(orDefault(ex.getErrorCode(), "404")));
    }

    @ExceptionHandler(BusinessException.class)
    public ResponseEntity<ApiError> handleBusiness(BusinessException ex, HttpServletRequest req) {
        logClientError(ex, req, HttpStatus.CONFLICT);
        return ResponseEntity.status(HttpStatus.CONFLICT).body(
                base(HttpStatus.CONFLICT, ex.getErrorMessage(), req)
                        .withCode(orDefault(ex.getErrorCode(), "409")));
    }

    @ExceptionHandler(OperationNotAllowedException.class)
    public ResponseEntity<ApiError> handleOperationNotAllowed(OperationNotAllowedException ex,
                                                              HttpServletRequest req) {
        logClientError(ex, req, HttpStatus.FORBIDDEN);
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(
                base(HttpStatus.FORBIDDEN, ex.getErrorMessage(), req)
                        .withCode(orDefault(ex.getErrorCode(), "403")));
    }

    @ExceptionHandler(ConstraintException.class)
    public ResponseEntity<ApiError> handleConstraintApp(ConstraintException ex, HttpServletRequest req) {
        logClientError(ex, req, HttpStatus.CONFLICT);
        return ResponseEntity.status(HttpStatus.CONFLICT).body(
                base(HttpStatus.CONFLICT, ex.getErrorMessage(), req)
                        .withCode(orDefault(ex.getErrorCode(), "409")));
    }

    @ExceptionHandler(ConversionRuntimeException.class)
    public ResponseEntity<ApiError> handleConversion(ConversionRuntimeException ex, HttpServletRequest req) {
        logClientError(ex, req, HttpStatus.BAD_REQUEST);
        return ResponseEntity.badRequest().body(
                base(HttpStatus.BAD_REQUEST, ex.getErrorMessage(), req)
                        .withCode(orDefault(ex.getErrorCode(), "400")));
    }

    @ExceptionHandler(ServiceRuntimeException.class)
    public ResponseEntity<ApiError> handleService(ServiceRuntimeException ex, HttpServletRequest req) {
        // ServiceRuntimeException is the catch-all wrapper many existing
        // controllers throw; treat as 400 to preserve previous behavior but
        // log server-side at error level with the cause chain.
        logServerError(ex, req, HttpStatus.BAD_REQUEST);
        return ResponseEntity.badRequest().body(
                base(HttpStatus.BAD_REQUEST, ex.getErrorMessage(), req)
                        .withCode(orDefault(ex.getErrorCode(), "400")));
    }

    @ExceptionHandler(ServiceException.class)
    public ResponseEntity<ApiError> handleCheckedService(ServiceException ex, HttpServletRequest req) {
        // Core checked ServiceException -- preserve old behavior of treating
        // as a server error (these come from the persistence/business core
        // and weren't user-facing client errors before).
        logServerError(ex, req, HttpStatus.INTERNAL_SERVER_ERROR);
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
                base(HttpStatus.INTERNAL_SERVER_ERROR, GENERIC_MESSAGE, req).withCode("500"));
    }

    @ExceptionHandler(RestApiException.class)
    public ResponseEntity<ApiError> handleRestApi(RestApiException ex, HttpServletRequest req) {
        logClientError(ex, req, HttpStatus.BAD_REQUEST);
        return ResponseEntity.badRequest().body(
                base(HttpStatus.BAD_REQUEST, ex.getErrorMessage(), req)
                        .withCode(orDefault(ex.getErrorCode(), "400")));
    }

    // ----- Security --------------------------------------------------------

    @ExceptionHandler(UnauthorizedException.class)
    public ResponseEntity<ApiError> handleUnauthorized(UnauthorizedException ex, HttpServletRequest req) {
        logClientError(ex, req, HttpStatus.UNAUTHORIZED);
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(
                base(HttpStatus.UNAUTHORIZED, ex.getErrorMessage(), req)
                        .withCode(orDefault(ex.getErrorCode(), "401")));
    }

    @ExceptionHandler(AuthenticationException.class)
    public ResponseEntity<ApiError> handleAuthentication(AuthenticationException ex, HttpServletRequest req) {
        logClientError(ex, req, HttpStatus.UNAUTHORIZED);
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(
                base(HttpStatus.UNAUTHORIZED, "Authentication failed", req).withCode("401"));
    }

    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<ApiError> handleAccessDenied(AccessDeniedException ex, HttpServletRequest req) {
        logClientError(ex, req, HttpStatus.FORBIDDEN);
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(
                base(HttpStatus.FORBIDDEN, "Access denied", req).withCode("403"));
    }

    // ----- Persistence -----------------------------------------------------

    @ExceptionHandler(DataIntegrityViolationException.class)
    public ResponseEntity<ApiError> handleDataIntegrity(DataIntegrityViolationException ex, HttpServletRequest req) {
        // Never echo the SQL-layer message to clients: it leaks schema names,
        // constraint names, and sometimes parameter values.
        logServerError(ex, req, HttpStatus.CONFLICT);
        return ResponseEntity.status(HttpStatus.CONFLICT).body(
                base(HttpStatus.CONFLICT, DB_MESSAGE, req).withCode("409"));
    }

    @ExceptionHandler(EmptyResultDataAccessException.class)
    public ResponseEntity<ApiError> handleEmptyResult(EmptyResultDataAccessException ex, HttpServletRequest req) {
        logClientError(ex, req, HttpStatus.NOT_FOUND);
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                base(HttpStatus.NOT_FOUND, "Resource not found", req).withCode("404"));
    }

    @ExceptionHandler(OptimisticLockingFailureException.class)
    public ResponseEntity<ApiError> handleOptimisticLock(OptimisticLockingFailureException ex,
                                                         HttpServletRequest req) {
        logServerError(ex, req, HttpStatus.CONFLICT);
        return ResponseEntity.status(HttpStatus.CONFLICT).body(
                base(HttpStatus.CONFLICT,
                        "Resource was modified concurrently; please retry", req).withCode("409"));
    }

    // ----- Fallback --------------------------------------------------------

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ApiError> handleGeneric(Exception ex, HttpServletRequest req) {
        logServerError(ex, req, HttpStatus.INTERNAL_SERVER_ERROR);
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
                base(HttpStatus.INTERNAL_SERVER_ERROR, GENERIC_MESSAGE, req).withCode("500"));
    }

    // ----- Helpers ---------------------------------------------------------

    private static ApiError base(HttpStatus status, String message, HttpServletRequest req) {
        String traceId = MDC.get(RequestIdFilter.MDC_KEY);
        String path = req != null ? req.getRequestURI() : null;
        String safeMessage = message != null ? message : status.getReasonPhrase();
        return ApiError.of(status.value(), status.getReasonPhrase(), safeMessage, path, traceId);
    }

    private static String orDefault(String value, String fallback) {
        return (value == null || value.isEmpty()) ? fallback : value;
    }

    private static void logClientError(Exception ex, HttpServletRequest req, HttpStatus status) {
        // 4xx -- client's fault, log at WARN without full stack trace to keep
        // logs scannable. The message + traceId are sufficient for diagnosis.
        if (log.isWarnEnabled()) {
            log.warn("client error status={} method={} path={} ex={} msg={}",
                    status.value(),
                    req != null ? req.getMethod() : "-",
                    req != null ? req.getRequestURI() : "-",
                    ex.getClass().getSimpleName(),
                    ex.getMessage());
        }
    }

    private static void logServerError(Exception ex, HttpServletRequest req, HttpStatus status) {
        // 5xx (or unexpected) -- log with full stack trace for ops.
        log.error("server error status={} method={} path={} ex={}",
                status.value(),
                req != null ? req.getMethod() : "-",
                req != null ? req.getRequestURI() : "-",
                ex.getClass().getSimpleName(),
                ex);
    }
}
