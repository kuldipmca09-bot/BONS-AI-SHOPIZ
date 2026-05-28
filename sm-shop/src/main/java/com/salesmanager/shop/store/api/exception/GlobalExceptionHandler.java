package com.salesmanager.shop.store.api.exception;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.dao.OptimisticLockingFailureException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.NoHandlerFoundException;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import com.salesmanager.core.business.exception.ServiceException;

/**
 * Single source of truth for translating exceptions raised under
 * {@code com.salesmanager.shop.store.api} into JSON error responses.
 *
 * Replaces the prior {@code RestErrorHandler} and {@code FileUploadExceptionAdvice}.
 * Stack traces are never serialized; they are logged with the request traceId
 * (populated by {@code RequestCorrelationFilter}) for correlation.
 */
@Order(Ordered.HIGHEST_PRECEDENCE)
@RestControllerAdvice(basePackages = "com.salesmanager.shop.store.api")
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {

    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);
    private static final String GENERIC_500_MESSAGE = "Internal server error";

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorEntity> handleNotFound(ResourceNotFoundException ex, HttpServletRequest request) {
        log.warn("Resource not found: {}", ex.getErrorMessage());
        return build(HttpStatus.NOT_FOUND, ex.getErrorCode(), ex.getErrorMessage(), request);
    }

    @ExceptionHandler(EmptyResultDataAccessException.class)
    public ResponseEntity<ErrorEntity> handleEmptyResult(EmptyResultDataAccessException ex, HttpServletRequest request) {
        log.warn("Entity not found: {}", ex.getMessage());
        return build(HttpStatus.NOT_FOUND, "404", "Resource not found", request);
    }

    @ExceptionHandler(UnauthorizedException.class)
    public ResponseEntity<ErrorEntity> handleUnauthorized(UnauthorizedException ex, HttpServletRequest request) {
        log.warn("Unauthorized: {}", ex.getErrorMessage());
        return build(HttpStatus.UNAUTHORIZED, ex.getErrorCode(), ex.getErrorMessage(), request);
    }

    @ExceptionHandler(AuthenticationException.class)
    public ResponseEntity<ErrorEntity> handleAuthentication(AuthenticationException ex, HttpServletRequest request) {
        log.warn("Authentication failed: {}", ex.getMessage());
        return build(HttpStatus.UNAUTHORIZED, "401", "Authentication failed", request);
    }

    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<ErrorEntity> handleAccessDenied(AccessDeniedException ex, HttpServletRequest request) {
        log.warn("Access denied: {}", ex.getMessage());
        return build(HttpStatus.FORBIDDEN, "403", "Access denied", request);
    }

    @ExceptionHandler(OperationNotAllowedException.class)
    public ResponseEntity<ErrorEntity> handleOperationNotAllowed(OperationNotAllowedException ex, HttpServletRequest request) {
        log.warn("Operation not allowed: {}", ex.getErrorMessage());
        return build(HttpStatus.FORBIDDEN, ex.getErrorCode(), ex.getErrorMessage(), request);
    }

    @ExceptionHandler(BusinessException.class)
    public ResponseEntity<ErrorEntity> handleBusiness(BusinessException ex, HttpServletRequest request) {
        log.warn("Business rule violation: {}", ex.getErrorMessage());
        return build(ex.getHttpStatus(), ex.getErrorCode(), ex.getErrorMessage(), request);
    }

    @ExceptionHandler(ValidationException.class)
    public ResponseEntity<ErrorEntity> handleValidation(ValidationException ex, HttpServletRequest request) {
        log.warn("Validation failed: {}", ex.getErrorMessage());
        ErrorEntity body = ErrorEntity.of(HttpStatus.UNPROCESSABLE_ENTITY, ex.getErrorCode(), ex.getErrorMessage(), request);
        if (ex.getFieldErrors() != null && !ex.getFieldErrors().isEmpty()) {
            body.setFieldErrors(new ArrayList<>(ex.getFieldErrors()));
        }
        return new ResponseEntity<>(body, HttpStatus.UNPROCESSABLE_ENTITY);
    }

    @ExceptionHandler(ConstraintViolationException.class)
    public ResponseEntity<ErrorEntity> handleConstraintViolation(ConstraintViolationException ex, HttpServletRequest request) {
        log.warn("Constraint violation: {}", ex.getMessage());
        ErrorEntity body = ErrorEntity.of(HttpStatus.UNPROCESSABLE_ENTITY, "422", "Validation failed", request);
        for (ConstraintViolation<?> v : ex.getConstraintViolations()) {
            body.addFieldError(v.getPropertyPath().toString(), v.getInvalidValue(), v.getMessage());
        }
        return new ResponseEntity<>(body, HttpStatus.UNPROCESSABLE_ENTITY);
    }

    @ExceptionHandler(ConstraintException.class)
    public ResponseEntity<ErrorEntity> handleConstraint(ConstraintException ex, HttpServletRequest request) {
        log.warn("Constraint conflict: {}", ex.getErrorMessage());
        return build(HttpStatus.CONFLICT, ex.getErrorCode(), ex.getErrorMessage(), request);
    }

    @ExceptionHandler(DataIntegrityViolationException.class)
    public ResponseEntity<ErrorEntity> handleDataIntegrity(DataIntegrityViolationException ex, HttpServletRequest request) {
        log.warn("Data integrity violation: {}", ex.getMostSpecificCause() != null ? ex.getMostSpecificCause().getMessage() : ex.getMessage());
        return build(HttpStatus.CONFLICT, "409", "Data integrity violation", request);
    }

    @ExceptionHandler(OptimisticLockingFailureException.class)
    public ResponseEntity<ErrorEntity> handleOptimisticLock(OptimisticLockingFailureException ex, HttpServletRequest request) {
        log.warn("Optimistic lock failure: {}", ex.getMessage());
        return build(HttpStatus.CONFLICT, "409", "The resource was modified concurrently; please retry", request);
    }

    @ExceptionHandler(ConversionRuntimeException.class)
    public ResponseEntity<ErrorEntity> handleConversion(ConversionRuntimeException ex, HttpServletRequest request) {
        log.warn("Conversion error: {}", ex.getErrorMessage());
        return build(HttpStatus.BAD_REQUEST, ex.getErrorCode(), ex.getErrorMessage(), request);
    }

    @ExceptionHandler(RestApiException.class)
    public ResponseEntity<ErrorEntity> handleRestApi(RestApiException ex, HttpServletRequest request) {
        log.warn("Rest API error: {}", ex.getErrorMessage());
        return build(HttpStatus.BAD_REQUEST, ex.getErrorCode(), ex.getErrorMessage(), request);
    }

    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public ResponseEntity<ErrorEntity> handleMaxUploadSize(MaxUploadSizeExceededException ex, HttpServletRequest request) {
        log.warn("Upload too large: {}", ex.getMessage());
        return build(HttpStatus.PAYLOAD_TOO_LARGE, "413", "Uploaded file exceeds the maximum allowed size", request);
    }

    @ExceptionHandler(ServiceRuntimeException.class)
    public ResponseEntity<ErrorEntity> handleServiceRuntime(ServiceRuntimeException ex, HttpServletRequest request) {
        log.error("Service runtime exception", ex);
        HttpStatus status = HttpStatus.INTERNAL_SERVER_ERROR;
        String message = ex.getErrorMessage() != null ? ex.getErrorMessage() : GENERIC_500_MESSAGE;
        return build(status, ex.getErrorCode(), message, request);
    }

    @ExceptionHandler(ServiceException.class)
    public ResponseEntity<ErrorEntity> handleService(ServiceException ex, HttpServletRequest request) {
        log.error("Service exception leaked to controller advice", ex);
        return build(HttpStatus.INTERNAL_SERVER_ERROR, "500", GENERIC_500_MESSAGE, request);
    }

    /**
     * Final fallback. Logs the full stack server-side but never leaks it to the client.
     */
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorEntity> handleAny(Exception ex, HttpServletRequest request) {
        log.error("Unhandled exception", ex);
        return build(HttpStatus.INTERNAL_SERVER_ERROR, "500", GENERIC_500_MESSAGE, request);
    }

    // --- Overrides of ResponseEntityExceptionHandler so Spring's built-ins emit ErrorEntity ---

    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex,
                                                                  HttpHeaders headers, HttpStatus status, WebRequest webRequest) {
        HttpServletRequest request = extract(webRequest);
        ErrorEntity body = ErrorEntity.of(HttpStatus.UNPROCESSABLE_ENTITY, "422", "Validation failed", request);
        populateFieldErrors(body, ex.getBindingResult());
        log.warn("Validation failed on {}: {} field error(s)", request != null ? request.getRequestURI() : "?",
                body.getFieldErrors() != null ? body.getFieldErrors().size() : 0);
        return new ResponseEntity<>(body, HttpStatus.UNPROCESSABLE_ENTITY);
    }

    @Override
    protected ResponseEntity<Object> handleBindException(BindException ex, HttpHeaders headers,
                                                         HttpStatus status, WebRequest webRequest) {
        HttpServletRequest request = extract(webRequest);
        ErrorEntity body = ErrorEntity.of(HttpStatus.BAD_REQUEST, "400", "Invalid request", request);
        populateFieldErrors(body, ex.getBindingResult());
        return new ResponseEntity<>(body, HttpStatus.BAD_REQUEST);
    }

    @Override
    protected ResponseEntity<Object> handleHttpMessageNotReadable(org.springframework.http.converter.HttpMessageNotReadableException ex,
                                                                  HttpHeaders headers, HttpStatus status, WebRequest webRequest) {
        log.warn("Malformed request body: {}", ex.getMostSpecificCause() != null ? ex.getMostSpecificCause().getMessage() : ex.getMessage());
        ErrorEntity body = ErrorEntity.of(HttpStatus.BAD_REQUEST, "400", "Malformed request body", extract(webRequest));
        return new ResponseEntity<>(body, HttpStatus.BAD_REQUEST);
    }

    @Override
    protected ResponseEntity<Object> handleHttpRequestMethodNotSupported(HttpRequestMethodNotSupportedException ex,
                                                                         HttpHeaders headers, HttpStatus status, WebRequest webRequest) {
        ErrorEntity body = ErrorEntity.of(HttpStatus.METHOD_NOT_ALLOWED, "405",
                "HTTP method " + ex.getMethod() + " not supported for this endpoint", extract(webRequest));
        return new ResponseEntity<>(body, HttpStatus.METHOD_NOT_ALLOWED);
    }

    @Override
    protected ResponseEntity<Object> handleHttpMediaTypeNotSupported(HttpMediaTypeNotSupportedException ex,
                                                                     HttpHeaders headers, HttpStatus status, WebRequest webRequest) {
        ErrorEntity body = ErrorEntity.of(HttpStatus.UNSUPPORTED_MEDIA_TYPE, "415",
                "Unsupported media type: " + ex.getContentType(), extract(webRequest));
        return new ResponseEntity<>(body, HttpStatus.UNSUPPORTED_MEDIA_TYPE);
    }

    @Override
    protected ResponseEntity<Object> handleMissingServletRequestParameter(MissingServletRequestParameterException ex,
                                                                           HttpHeaders headers, HttpStatus status, WebRequest webRequest) {
        ErrorEntity body = ErrorEntity.of(HttpStatus.BAD_REQUEST, "400",
                "Missing required parameter: " + ex.getParameterName(), extract(webRequest));
        return new ResponseEntity<>(body, HttpStatus.BAD_REQUEST);
    }

    @Override
    protected ResponseEntity<Object> handleNoHandlerFoundException(NoHandlerFoundException ex, HttpHeaders headers,
                                                                   HttpStatus status, WebRequest webRequest) {
        ErrorEntity body = ErrorEntity.of(HttpStatus.NOT_FOUND, "404",
                "No endpoint " + ex.getHttpMethod() + " " + ex.getRequestURL(), extract(webRequest));
        return new ResponseEntity<>(body, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(MethodArgumentTypeMismatchException.class)
    public ResponseEntity<ErrorEntity> handleTypeMismatch(MethodArgumentTypeMismatchException ex, HttpServletRequest request) {
        String required = ex.getRequiredType() != null ? ex.getRequiredType().getSimpleName() : "expected type";
        ErrorEntity body = ErrorEntity.of(HttpStatus.BAD_REQUEST, "400",
                "Parameter '" + ex.getName() + "' must be a valid " + required, request);
        return new ResponseEntity<>(body, HttpStatus.BAD_REQUEST);
    }

    // --- helpers ---

    private ResponseEntity<ErrorEntity> build(HttpStatus status, String code, String message, HttpServletRequest request) {
        ErrorEntity body = ErrorEntity.of(status, code, message, request);
        return new ResponseEntity<>(body, status);
    }

    private HttpServletRequest extract(WebRequest webRequest) {
        if (webRequest instanceof org.springframework.web.context.request.ServletWebRequest) {
            return ((org.springframework.web.context.request.ServletWebRequest) webRequest).getRequest();
        }
        return null;
    }

    private void populateFieldErrors(ErrorEntity body, BindingResult br) {
        List<org.springframework.validation.FieldError> errors = br.getFieldErrors();
        for (org.springframework.validation.FieldError fe : errors) {
            body.addFieldError(fe.getField(), fe.getRejectedValue(), fe.getDefaultMessage());
        }
    }
}
