package com.salesmanager.shop.audit;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

/**
 * Centralized audit logging for every REST controller method under
 * {@code com.salesmanager.shop.store.api}.
 *
 * Writes a single structured line per call to the dedicated {@code AUDIT} logger,
 * decoupling audit routing from regular application logging.
 * Captures the resolved controller method (not the URL), the authenticated principal
 * if any, the call duration, and the success/failure outcome — never request bodies.
 */
@Aspect
@Component
public class ApiAuditAspect {

    private static final Logger AUDIT = LoggerFactory.getLogger("AUDIT");
    private static final String MDC_USER_ID = "userId";
    private static final String ANONYMOUS = "anonymous";

    @Pointcut("within(com.salesmanager.shop.store.api..*)")
    public void underApiPackage() {}

    @Pointcut("@within(org.springframework.web.bind.annotation.RestController) "
            + "|| @within(org.springframework.stereotype.Controller)")
    public void anyController() {}

    @Around("underApiPackage() && anyController()")
    public Object audit(ProceedingJoinPoint pjp) throws Throwable {
        String user = resolvePrincipal();
        if (user != null) {
            MDC.put(MDC_USER_ID, user);
        }
        String method = methodName(pjp);
        String traceId = MDC.get("traceId");
        String httpMethod = MDC.get("method");
        String path = MDC.get("path");
        long start = System.currentTimeMillis();
        try {
            Object result = pjp.proceed();
            long durationMs = System.currentTimeMillis() - start;
            AUDIT.info("event=api.call traceId={} userId={} method={} http={} path={} durationMs={} outcome=success",
                    nullToDash(traceId), nullToDash(user), method,
                    nullToDash(httpMethod), nullToDash(path), durationMs);
            return result;
        } catch (Throwable ex) {
            long durationMs = System.currentTimeMillis() - start;
            AUDIT.warn("event=api.call traceId={} userId={} method={} http={} path={} durationMs={} outcome=failure errorClass={}",
                    nullToDash(traceId), nullToDash(user), method,
                    nullToDash(httpMethod), nullToDash(path), durationMs,
                    ex.getClass().getSimpleName());
            throw ex;
        } finally {
            MDC.remove(MDC_USER_ID);
        }
    }

    private String methodName(ProceedingJoinPoint pjp) {
        MethodSignature sig = (MethodSignature) pjp.getSignature();
        return sig.getDeclaringType().getSimpleName() + "." + sig.getName();
    }

    private String resolvePrincipal() {
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth == null || !auth.isAuthenticated()) {
                return ANONYMOUS;
            }
            Object principal = auth.getPrincipal();
            if (principal instanceof UserDetails) {
                return ((UserDetails) principal).getUsername();
            }
            if (principal instanceof String) {
                return (String) principal;
            }
            return auth.getName();
        } catch (Exception e) {
            return ANONYMOUS;
        }
    }

    private static String nullToDash(String s) {
        return s == null || s.isEmpty() ? "-" : s;
    }
}
