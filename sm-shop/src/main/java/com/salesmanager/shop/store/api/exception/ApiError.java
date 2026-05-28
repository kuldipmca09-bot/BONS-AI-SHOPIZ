package com.salesmanager.shop.store.api.exception;

import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Standard error response body returned by the global exception handler.
 *
 * Why: callers need a stable, predictable shape with correlation id so client
 * reports can be tied back to server logs without exposing stack traces.
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ApiError {

    @JsonFormat(shape = JsonFormat.Shape.STRING)
    private OffsetDateTime timestamp;
    private int status;
    private String error;
    private String code;
    private String message;
    private String path;
    private String traceId;
    private List<FieldError> errors;

    public ApiError() {
        this.timestamp = OffsetDateTime.now();
    }

    public static ApiError of(int status, String error, String message, String path, String traceId) {
        ApiError e = new ApiError();
        e.status = status;
        e.error = error;
        e.message = message;
        e.path = path;
        e.traceId = traceId;
        return e;
    }

    public ApiError withCode(String code) {
        this.code = code;
        return this;
    }

    public ApiError addFieldError(String field, Object rejectedValue, String message) {
        if (errors == null) {
            errors = new ArrayList<>();
        }
        errors.add(new FieldError(field, rejectedValue, message));
        return this;
    }

    public OffsetDateTime getTimestamp() { return timestamp; }
    public void setTimestamp(OffsetDateTime timestamp) { this.timestamp = timestamp; }
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
    public String getError() { return error; }
    public void setError(String error) { this.error = error; }
    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    /**
     * Backwards-compatible alias for legacy clients that read `errorCode`
     * from the response body (the shape produced by ErrorEntity).
     */
    @JsonProperty("errorCode")
    public String getErrorCode() { return code; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public String getPath() { return path; }
    public void setPath(String path) { this.path = path; }
    public String getTraceId() { return traceId; }
    public void setTraceId(String traceId) { this.traceId = traceId; }
    public List<FieldError> getErrors() { return errors; }
    public void setErrors(List<FieldError> errors) { this.errors = errors; }

    public static class FieldError {
        private String field;
        private Object rejectedValue;
        private String message;

        public FieldError() {}

        public FieldError(String field, Object rejectedValue, String message) {
            this.field = field;
            this.rejectedValue = rejectedValue;
            this.message = message;
        }

        public String getField() { return field; }
        public void setField(String field) { this.field = field; }
        public Object getRejectedValue() { return rejectedValue; }
        public void setRejectedValue(Object rejectedValue) { this.rejectedValue = rejectedValue; }
        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
    }
}
