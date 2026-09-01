package com.salesmanager.core.business.repositories.catalog.product;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.salesmanager.core.model.catalog.product.Product;


public interface ProductRepository extends JpaRepository<Product, Long>, ProductRepositoryCustom {


	/**
	 * Returns the number of products (or product variants) in the given store
	 * matching the sku. Callers treat any non zero count as "sku exists".
	 *
	 * This used to select CASE WHEN COUNT(*) > 0 THEN true ELSE false END. Oracle
	 * has no boolean literal in SQL, so that rendered as an invalid statement
	 * (ORA-00920). Counting instead is dialect neutral and preserves the exact
	 * same matching semantics.
	 */
	@Query(value="SELECT COUNT(p) " +
			"FROM " +
			"Product p " +
			"JOIN MerchantStore m ON m.id = ?2 " +
			"LEFT JOIN ProductVariant pv ON pv.product.id = p.id " +
			"WHERE (pv.sku = ?1 OR p.sku = ?1)")
	long countBySku(String sku, Integer store);

	default boolean existsBySku(String sku, Integer store) {
		return countBySku(sku, store) > 0;
	}
	
	/**
	 * Product ids in the given store whose sku, or one of whose variant skus,
	 * matches.
	 *
	 * Was a native query selecting p.PRODUCT_ID. Native scalar selects return a
	 * vendor specific numeric type -- BigInteger on MySQL but BigDecimal on
	 * Oracle -- and callers cast the result, so the native form broke with a
	 * ClassCastException on Oracle. Expressing it as JPQL lets Hibernate return
	 * the mapped Long and removes the need for {h-schema} prefixing.
	 *
	 * The odd "p.sku = ?1 or i.sku = ?1 and m.id = ?2" precedence of the original
	 * (AND binds tighter than OR, so the store only ever constrained the variant
	 * branch) is preserved deliberately: tightening it would change which
	 * products getBySku resolves.
	 */
	@Query("select p.id from Product p "
			+ "join p.merchantStore m "
			+ "left join p.variants i "
			+ "where p.sku = ?1 or i.sku = ?1 and m.id = ?2")
	List<Long> findBySku(String sku, Integer consultId);

}
