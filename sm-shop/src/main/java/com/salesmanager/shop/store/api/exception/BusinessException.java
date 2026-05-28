package com.salesmanager.shop.store.api.exception;

/**
 * Thrown when a request is syntactically valid but violates a business rule
 * (e.g. cannot delete a product that is in an open order). Maps to HTTP 409.
 *
 * Sits in the existing hierarchy alongside ServiceRuntimeException so it
 * inherits the errorCode / errorMessage contract used by the legacy
 * RestErrorHandler.
 */
public class BusinessException extends GenericRuntimeException {

    private static final long serialVersionUID = 1L;
    private static final String DEFAULT_CODE = "409";

    public BusinessException(String message) {
        super(DEFAULT_CODE, message);
    }

    public BusinessException(String errorCode, String message) {
        super(errorCode, message);
    }

    public BusinessException(String message, Throwable cause) {
        super(DEFAULT_CODE, message, cause);
    }

    public BusinessException(String errorCode, String message, Throwable cause) {
        super(errorCode, message, cause);
    }
}
