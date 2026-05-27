package com.salesmanager.core.business.utils;

/**
 * Legacy helper for masking and validating raw credit-card numbers.
 *
 * @deprecated Credit-card data must not be handled directly inside the
 *             application for PCI compliance. Use a tokenizing payment
 *             provider (e.g. Stripe, Braintree) and store only the returned
 *             token. This class will be removed in a future release.
 */
@Deprecated
public class CreditCardUtils {
	
	
	public static final int MASTERCARD = 0, VISA = 1;
	public static final int AMEX = 2, DISCOVER = 3, DINERS = 4;

	public static String maskCardNumber(String clearcardnumber)
			throws Exception {

		if (clearcardnumber.length() < 10) {
			throw new Exception("Invalid number of digits");
		}

		int length = clearcardnumber.length();

		String prefix = clearcardnumber.substring(0, 4);
		String suffix = clearcardnumber.substring(length - 4);

		return new StringBuilder()
				.append(prefix)
				.append("XXXXXXXXXX")
				.append(suffix)
				.toString();
	}
}
