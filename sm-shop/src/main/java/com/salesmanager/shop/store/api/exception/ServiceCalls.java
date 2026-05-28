package com.salesmanager.shop.store.api.exception;

import com.salesmanager.core.business.exception.ServiceException;

/**
 * Small helper that removes the repetitive
 * {@code try { ... } catch (ServiceException e) { throw new ServiceRuntimeException(e); }}
 * boilerplate found across the facade layer.
 *
 * The checked {@link ServiceException} is translated into the most appropriate
 * runtime exception based on its {@code exceptionType}, so the
 * {@link GlobalExceptionHandler} can map it to the right HTTP status.
 */
public final class ServiceCalls {

    private ServiceCalls() {}

    @FunctionalInterface
    public interface ThrowingRunnable {
        void run() throws ServiceException;
    }

    @FunctionalInterface
    public interface ThrowingSupplier<T> {
        T get() throws ServiceException;
    }

    /** Run a {@link ServiceException}-throwing operation, translating failures into runtime exceptions. */
    public static void run(ThrowingRunnable action, String contextMessage) {
        try {
            action.run();
        } catch (ServiceException e) {
            throw translate(e, contextMessage);
        }
    }

    /** Same as {@link #run} but returns a value. */
    public static <T> T call(ThrowingSupplier<T> action, String contextMessage) {
        try {
            return action.get();
        } catch (ServiceException e) {
            throw translate(e, contextMessage);
        }
    }

    private static RuntimeException translate(ServiceException e, String contextMessage) {
        String message = contextMessage != null ? contextMessage : e.getMessage();
        switch (e.getExceptionType()) {
            case ServiceException.EXCEPTION_VALIDATION:
                return new BusinessException(message, e);
            case ServiceException.EXCEPTION_PAYMENT_DECLINED:
            case ServiceException.EXCEPTION_TRANSACTION_DECLINED:
                return new BusinessException("402", message);
            case ServiceException.EXCEPTION_INVENTORY_MISMATCH:
                return new BusinessException("409", message);
            default:
                return new ServiceRuntimeException(message, e);
        }
    }
}
