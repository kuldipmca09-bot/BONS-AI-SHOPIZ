package com.salesmanager.shop.filter;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.MDC;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

/**
 * Populates a per-request correlation ID into the SLF4J {@link MDC} so that
 * every log line emitted while handling the request can be correlated.
 *
 * <ul>
 *   <li>Accepts an inbound {@code X-Request-ID} header; if absent generates a UUID.</li>
 *   <li>Echoes the value back as the {@code X-Request-ID} response header so clients
 *       can correlate their own logs.</li>
 *   <li>Clears MDC on exit to avoid leakage between thread-pool reuses.</li>
 * </ul>
 */
@Component
@Order(Ordered.HIGHEST_PRECEDENCE + 10)
public class RequestCorrelationFilter extends OncePerRequestFilter {

    public static final String TRACE_ID_HEADER = "X-Request-ID";
    public static final String MDC_TRACE_ID = "traceId";
    public static final String MDC_PATH = "path";
    public static final String MDC_METHOD = "method";

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                    FilterChain chain) throws ServletException, IOException {
        String traceId = request.getHeader(TRACE_ID_HEADER);
        if (StringUtils.isBlank(traceId)) {
            traceId = UUID.randomUUID().toString();
        }
        try {
            MDC.put(MDC_TRACE_ID, traceId);
            MDC.put(MDC_PATH, request.getRequestURI());
            MDC.put(MDC_METHOD, request.getMethod());
            response.setHeader(TRACE_ID_HEADER, traceId);
            chain.doFilter(request, response);
        } finally {
            MDC.remove(MDC_TRACE_ID);
            MDC.remove(MDC_PATH);
            MDC.remove(MDC_METHOD);
        }
    }
}
