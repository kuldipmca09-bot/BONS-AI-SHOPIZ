package com.salesmanager.core.model.customer.connection;

import javax.persistence.Entity;

/**
 * Persistent record for the legacy Spring Social user-connection flow.
 *
 * @deprecated Spring Social integration has been removed. Social login should
 *             be handled through an external OAuth/OIDC identity provider; no
 *             direct replacement class is provided.
 */
@Deprecated
@Entity
public class UserConnection extends AbstractUserConnectionWithCompositeKey {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


}