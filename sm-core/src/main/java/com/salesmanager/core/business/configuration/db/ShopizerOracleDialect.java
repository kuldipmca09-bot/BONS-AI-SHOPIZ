package com.salesmanager.core.business.configuration.db;

import java.sql.Types;

import org.hibernate.dialect.Oracle12cDialect;

/**
 * Oracle dialect used by Shopizer.
 *
 * <p>
 * The stock Oracle dialects map JDBC {@code LONGVARCHAR} to the Oracle
 * {@code LONG} type. Shopizer annotates its free text columns with
 * {@code @Type(type = "org.hibernate.type.TextType")}, which is
 * {@code LONGVARCHAR} backed, so on Oracle those columns would be created as
 * {@code LONG}. That is wrong for this application in three ways:
 * </p>
 *
 * <ul>
 * <li>{@code LONG} is deprecated by Oracle and only one {@code LONG} column is
 * allowed per table, which blocks any future free text column being added to
 * the 25 tables that already have one.</li>
 * <li>A {@code LONG} column cannot appear in {@code SELECT DISTINCT}, in
 * {@code GROUP BY} or in a join condition. Roughly thirty repository queries do
 * {@code select distinct c from Category c left join fetch c.descriptions},
 * which selects the description column, so they would all fail at runtime.</li>
 * <li>{@code LONG} cannot be read out of order in a result set, which breaks
 * Hibernate's normal column access pattern for wide rows.</li>
 * </ul>
 *
 * <p>
 * On MySQL these columns were {@code LONGTEXT}. The faithful Oracle equivalent
 * is {@code CLOB}, which has none of the restrictions above, so this dialect
 * remaps {@code LONGVARCHAR} accordingly. Existing behaviour is preserved: the
 * entities still expose the columns as {@code String}, and Hibernate's
 * materialized CLOB handling reads and writes them transparently.
 * </p>
 */
public class ShopizerOracleDialect extends Oracle12cDialect {

	public ShopizerOracleDialect() {
		super();
		registerColumnType(Types.LONGVARCHAR, "clob");
		registerColumnType(Types.LONGNVARCHAR, "nclob");
	}

}
