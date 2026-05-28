package com.salesmanager.shop.store.controller.error;

import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import com.salesmanager.shop.filter.RequestIdFilter;

/**
 * Global error handler for the MVC/view side of the shop. Scoped to
 * {@code com.salesmanager.shop.store.controller}; the REST API is covered by
 * {@link com.salesmanager.shop.store.api.exception.RestErrorHandler}.
 *
 * Exposes only a safe message and the request traceId to the view layer;
 * stack traces are kept in server-side logs only.
 */
@ControllerAdvice("com.salesmanager.shop.store.controller")
public class ShopErrorController {

	private static final Logger LOGGER = LoggerFactory.getLogger(ShopErrorController.class);

	private static final String GENERIC_MESSAGE = "An unexpected error occurred. Please contact support with the traceId.";

	@ExceptionHandler(AccessDeniedException.class)
	@ResponseStatus(HttpStatus.FORBIDDEN)
	@Produces({MediaType.APPLICATION_JSON})
	public ModelAndView handleAccessDenied(AccessDeniedException ex) {
		LOGGER.warn("Access denied: {}", ex.getMessage());
		ModelAndView model = new ModelAndView("error/access_denied");
		model.addObject("traceId", MDC.get(RequestIdFilter.MDC_KEY));
		return model;
	}

	@ExceptionHandler(Exception.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	@Produces({MediaType.APPLICATION_JSON})
	public ModelAndView handleException(Exception ex) {
		LOGGER.error("Unhandled exception in shop controller", ex);
		return genericErrorView();
	}

	@ExceptionHandler(RuntimeException.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	@Produces({MediaType.APPLICATION_JSON})
	public ModelAndView handleRuntimeException(RuntimeException ex) {
		LOGGER.error("Unhandled runtime exception in shop controller", ex);
		return genericErrorView();
	}

	@RequestMapping(value = "/error", method = RequestMethod.GET)
	public ModelAndView handleCatchAllException(Model model) {
		return genericErrorView();
	}

	private ModelAndView genericErrorView() {
		ModelAndView mav = new ModelAndView("error/generic_error");
		mav.addObject("errMsg", GENERIC_MESSAGE);
		mav.addObject("traceId", MDC.get(RequestIdFilter.MDC_KEY));
		return mav;
	}
}
