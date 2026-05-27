package com.salesmanager.shop.model.order.v0;

import java.io.Serializable;

import com.salesmanager.shop.model.entity.BaseEntity;

/**
 * v0 order DTO retained only for backward compatibility with older clients.
 *
 * @deprecated Use {@link com.salesmanager.shop.model.order.v1.Order} instead.
 */
@Deprecated
public class Order extends BaseEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

}
