package com.salesmanager.core.business.services.system;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.salesmanager.core.business.repositories.system.MerchantLogRepository;
import com.salesmanager.core.business.services.common.generic.SalesManagerEntityServiceImpl;
import com.salesmanager.core.model.system.MerchantLog;

@Service("merchantLogService")
public class MerchantLogServiceImpl extends
		SalesManagerEntityServiceImpl<Long, MerchantLog> implements
		MerchantLogService {

	private MerchantLogRepository merchantLogRepository;
	
	@Inject
	public MerchantLogServiceImpl(
			MerchantLogRepository merchantLogRepository) {
			super(merchantLogRepository);
			this.merchantLogRepository = merchantLogRepository;
	}


	




}
