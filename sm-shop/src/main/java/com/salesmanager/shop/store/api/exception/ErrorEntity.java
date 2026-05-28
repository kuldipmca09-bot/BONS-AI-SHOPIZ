package com.salesmanager.shop.store.api.exception;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.MDC;
import org.springframework.http.HttpStatus;

import com.fasterxml.jackson.annotation.JsonInclude;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class ErrorEntity {

    private String errorCode;
    private String message;

    private Instant timestamp;
    private Integer status;
    private String error;
    private String path;
    private String traceId;
    private List<FieldError> fieldErrors;

    public ErrorEntity() {
        this.timestamp = Instant.now();
        this.traceId = MDC.get("traceId");
    }

    public static ErrorEntity of(HttpStatus httpStatus, String code, String message, HttpServletRequest request) {
        ErrorEntity entity = new ErrorEntity();
        entity.status = httpStatus.value();
        entity.error = httpStatus.getReasonPhrase();
        entity.errorCode = code != null ? code : String.valueOf(httpStatus.value());
        entity.message = message;
        if (request != null) {
            entity.path = request.getRequestURI();
        }
        return entity;
    }

    public ErrorEntity addFieldError(String field, Object rejectedValue, String message) {
        if (this.fieldErrors == null) {
            this.fieldErrors = new ArrayList<>();
        }
        this.fieldErrors.add(new FieldError(field, rejectedValue, message));
        return this;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Instant getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Instant timestamp) {
        this.timestamp = timestamp;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getTraceId() {
        return traceId;
    }

    public void setTraceId(String traceId) {
        this.traceId = traceId;
    }

    public List<FieldError> getFieldErrors() {
        return fieldErrors;
    }

    public void setFieldErrors(List<FieldError> fieldErrors) {
        this.fieldErrors = fieldErrors;
    }

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

        public String getField() {
            return field;
        }

        public void setField(String field) {
            this.field = field;
        }

        public Object getRejectedValue() {
            return rejectedValue;
        }

        public void setRejectedValue(Object rejectedValue) {
            this.rejectedValue = rejectedValue;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }
    }
}
