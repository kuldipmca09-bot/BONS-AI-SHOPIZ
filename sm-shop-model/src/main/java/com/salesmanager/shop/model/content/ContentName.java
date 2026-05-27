package com.salesmanager.shop.model.content;

/**
 * Input object used in REST requests.
 *
 * @author carlsamson
 * @deprecated Superseded by types under {@code shop.model.content.common}.
 */
@Deprecated
public class ContentName extends Content {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public ContentName() {
		super();
	}
	
	public ContentName(String name) {
		super(name);
	}
	
	public ContentName(String name, String contentType) {
		super(name);
	}

	


}
