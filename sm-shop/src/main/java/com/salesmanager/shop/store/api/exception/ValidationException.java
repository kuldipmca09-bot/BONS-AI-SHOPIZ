package com.salesmanager.shop.store.api.exception;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Thrown for server-side validation failures that cannot be expressed
 * with Bean Validation annotations (e.g. cross-field rules, lookups
 * against existing data). Maps to HTTP 422.
 */
public class ValidationException extends GenericRuntimeException {

    private static final long serialVersionUID = 1L;
    private static final String DEFAULT_ERROR_CODE = "422";

    private final List<ErrorEntity.FieldError> fieldErrors;

    public ValidationException(String message) {
        super(DEFAULT_ERROR_CODE, message);
        this.fieldErrors = Collections.emptyList();
    }

    public ValidationException(String message, List<ErrorEntity.FieldError> fieldErrors) {
        super(DEFAULT_ERROR_CODE, message);
        this.fieldErrors = fieldErrors != null ? new ArrayList<>(fieldErrors) : Collections.emptyList();
    }

    public ValidationException(String errorCode, String message, List<ErrorEntity.FieldError> fieldErrors) {
        super(errorCode, message);
        this.fieldErrors = fieldErrors != null ? new ArrayList<>(fieldErrors) : Collections.emptyList();
    }

    public List<ErrorEntity.FieldError> getFieldErrors() {
        return Collections.unmodifiableList(fieldErrors);
    }
}
