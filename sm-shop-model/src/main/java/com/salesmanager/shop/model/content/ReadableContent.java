package com.salesmanager.shop.model.content;

/**
 * A simple piece of content.
 *
 * @author carlsamson
 * @deprecated Superseded by
 *             {@link com.salesmanager.shop.model.content.common.Content} and
 *             related types under {@code shop.model.content.common}.
 */
@Deprecated
public class ReadableContent extends Content {
  
  /**
   * 
   */
  private static final long serialVersionUID = 1L;
  private String content;

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

}
