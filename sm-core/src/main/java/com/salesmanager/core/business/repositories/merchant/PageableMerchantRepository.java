package com.salesmanager.core.business.repositories.merchant;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.salesmanager.core.model.merchant.MerchantStore;

public interface PageableMerchantRepository extends PagingAndSortingRepository<MerchantStore, Long> {

	/*
	 * List by parent store
	 */
	@Query(value = "select distinct m from MerchantStore m left join fetch m.parent mp left join fetch m.country mc left join fetch m.currency mc left join fetch m.zone mz left join fetch m.defaultLanguage md left join fetch m.languages mls where mp.code = ?1", countQuery = "select count(distinct m) from MerchantStore m join m.parent mp where mp.code = ?1")
	Page<MerchantStore> listByStore(String code, Pageable pageable);

	@Query(value = "select distinct m from MerchantStore m left join fetch m.parent mp left join fetch m.country mc left join fetch m.currency mc left join fetch m.zone mz left join fetch m.defaultLanguage md left join fetch m.languages mls where (?1 is null or m.storename like %?1%)", countQuery = "select count(distinct m) from MerchantStore m where (?1 is null or m.storename like %?1%)")
	Page<MerchantStore> listAll(String storeName, Pageable pageable);

	@Query(value = "select distinct m from MerchantStore m left join fetch m.parent mp "
			+ "left join fetch m.country mc " + "left join fetch m.currency mc left " + "join fetch m.zone mz "
			+ "left join fetch m.defaultLanguage md " + "left join fetch m.languages mls "
			+ "where m.retailer = true and (?1 is null or m.storename like %?1%)", countQuery = "select count(distinct m) from MerchantStore m join m.parent "
					+ "where m.retailer = true and (?1 is null or m.storename like %?1%)")
	Page<MerchantStore> listAllRetailers(String storeName, Pageable pageable);

	@Query(value = "select distinct m from MerchantStore m left join m.parent mp " + "left join fetch m.country pc "
			+ "left join fetch m.currency pcu " + "left join fetch m.languages pl " + "left join fetch m.zone pz "
			+ "where mp.code = ?1 or m.code = ?1 "
			+ "and (?2 is null or (m.storename like %?2% or mp.storename like %?2%))", countQuery = "select count(distinct m) from MerchantStore m left join m.parent mp "
					+ "where mp.code = ?1 or m.code = ?1 and (?2 is null or (m.storename like %?2% or mp.storename like %?2%))")
	Page<MerchantStore> listChilds(String storeCode, String storeName, Pageable pageable);

	/**
	 * Paged variant of the store-group listing, optionally filtered by store name.
	 *
	 * Was a native "select * from MERCHANT_STORE" combined with a Pageable. That
	 * form was unusable on Oracle for three reasons: a bare "? is null" bind has
	 * no inferable type (ORA-00932/ORA-01722); Hibernate has to wrap "select *"
	 * in its own pagination subquery, which duplicates the ROWNUM/ROW_NUMBER
	 * column and confuses the MerchantStore entity mapping; and the main query
	 * omitted the {h-schema} prefix its own countQuery used, so it resolved
	 * against the connecting user's schema instead of SALESMANAGER.
	 *
	 * As JPQL, Hibernate derives both the pagination and the count query itself,
	 * so no explicit countQuery is needed and the result set maps cleanly.
	 */
	@Query("select m from MerchantStore m left join m.parent mp "
			+ "where (m.code = ?1 or (?2 is null or mp.id = ?2)) "
			+ "and (?3 is null or m.storename like %?3%)")
	Page<MerchantStore> listByGroup(String storeCode, Integer id, String storeName, Pageable pageable);

}
