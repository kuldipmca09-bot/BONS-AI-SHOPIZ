package com.salesmanager.shop.store.api.exception;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Thrown for application-level validation failures that aren't surfaced by
 * Bean Validation (e.g. cross-field invariants, lookups against persisted
 * state). Maps to HTTP 400.
 *
 * Carries an optional list of field-level errors so the global handler can
 * emit them in the ApiError.errors array without losing structure.
 */
public class ValidationException extends GenericRuntimeException {

    private static final long serialVersionUID = 1L;
    private static final String DEFAULT_CODE = "400";

    private final List<FieldViolation> violations;

    public ValidationException(String message) {
        super(DEFAULT_CODE, message);
        this.violations = Collections.emptyList();
    }

    public ValidationException(String message, List<FieldViolation> violations) {
        super(DEFAULT_CODE, message);
        this.violations = violations != null ? new ArrayList<>(violations) : Collections.emptyList();
    }

    public ValidationException(String errorCode, String message, List<FieldViolation> violations) {
        super(errorCode, message);
        this.violations = violations != null ? new ArrayList<>(violations) : Collections.emptyList();
    }

    public List<FieldViolation> getViolations() {
        return Collections.unmodifiableList(violations);
    }

    public static class FieldViolation {
        private final String field;
        private final Object rejectedValue;
        private final String message;

        public FieldViolation(String field, Object rejectedValue, String message) {
            this.field = field;
            this.rejectedValue = rejectedValue;
            this.message = message;
        }

        public String getField() { return field; }
        public Object getRejectedValue() { return rejectedValue; }
        public String getMessage() { return message; }
    }
}
