package com.salesmanager.shop.store.api.exception;

import org.springframework.http.HttpStatus;

/**
 * Thrown to signal a business-rule violation that should be surfaced to the
 * API client with a meaningful 4xx status. Prefer this over the generic
 * {@link ServiceRuntimeException} (which is reserved for unexpected
 * server-side failures and maps to 500).
 */
public class BusinessException extends GenericRuntimeException {

    private static final long serialVersionUID = 1L;
    private static final String DEFAULT_ERROR_CODE = "400";

    private final HttpStatus httpStatus;

    public BusinessException(String message) {
        super(DEFAULT_ERROR_CODE, message);
        this.httpStatus = HttpStatus.BAD_REQUEST;
    }

    public BusinessException(String errorCode, String message) {
        super(errorCode, message);
        this.httpStatus = HttpStatus.BAD_REQUEST;
    }

    public BusinessException(HttpStatus httpStatus, String message) {
        super(String.valueOf(httpStatus.value()), message);
        this.httpStatus = httpStatus;
    }

    public BusinessException(HttpStatus httpStatus, String errorCode, String message) {
        super(errorCode, message);
        this.httpStatus = httpStatus;
    }

    public BusinessException(String message, Throwable cause) {
        super(DEFAULT_ERROR_CODE, message, cause);
        this.httpStatus = HttpStatus.BAD_REQUEST;
    }

    public HttpStatus getHttpStatus() {
        return httpStatus;
    }
}
