package com.salesmanager.shop.filter;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.MDC;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

/**
 * Assigns a correlation id to every request and propagates it via SLF4J MDC
 * so that all log lines emitted while handling the request can be tied back
 * to a single trace. Also echoes the id on the response so clients can quote
 * it when reporting issues.
 *
 * Honours an incoming X-Request-Id header when present (validated to a safe
 * subset to prevent log/response splitting), otherwise generates a UUID.
 */
@Component
@Order(Ordered.HIGHEST_PRECEDENCE)
public class RequestIdFilter extends OncePerRequestFilter {

    public static final String HEADER = "X-Request-Id";
    public static final String MDC_KEY = "traceId";

    private static final int MAX_LEN = 64;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws ServletException, IOException {
        String id = sanitize(request.getHeader(HEADER));
        if (!StringUtils.hasText(id)) {
            id = UUID.randomUUID().toString();
        }
        MDC.put(MDC_KEY, id);
        try {
            response.setHeader(HEADER, id);
            chain.doFilter(request, response);
        } finally {
            MDC.remove(MDC_KEY);
        }
    }

    private String sanitize(String raw) {
        if (raw == null) {
            return null;
        }
        String trimmed = raw.trim();
        if (trimmed.isEmpty() || trimmed.length() > MAX_LEN) {
            return null;
        }
        for (int i = 0; i < trimmed.length(); i++) {
            char c = trimmed.charAt(i);
            boolean ok = (c >= 'a' && c <= 'z')
                    || (c >= 'A' && c <= 'Z')
                    || (c >= '0' && c <= '9')
                    || c == '-' || c == '_';
            if (!ok) {
                return null;
            }
        }
        return trimmed;
    }
}
