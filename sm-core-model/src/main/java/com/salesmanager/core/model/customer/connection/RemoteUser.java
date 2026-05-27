package com.salesmanager.core.model.customer.connection;

//import org.springframework.social.UserIdSource;

/**
 * Profile contract for a remote (third-party) user identity, originally
 * implemented by {@code org.springframework.social.UserIdSource}.
 *
 * @deprecated Spring Social integration has been removed. No direct replacement.
 */
@Deprecated
public interface RemoteUser { //extends UserIdSource{

	public String getUserId();
	
	public void setUserId(String id);
	/*
	 * Provider identifier: Facebook, Twitter, LinkedIn etc
	 */
	public String getProviderUserId();

	public void setProviderUserId(String provider);

	public String getProviderId();

	public void setProviderId(String providerId);

	public int getRank();

	public void setRank(int rank);

	public String getSecret();

	public void setSecret(String secret);

	public String getDisplayName();

	public void setDisplayName(String displayName);

	public String getProfileUrl();

	public void setProfileUrl(String profileUrl);

	public String getImageUrl();

	public void setImageUrl(String imageUrl);

	public String getAccessToken();

	public void setAccessToken(String accessToken);

	public String getRefreshToken();

	public void setRefreshToken(String refreshToken);

	public Long getExpireTime();

	public void setExpireTime(Long expireTime);
	
}
