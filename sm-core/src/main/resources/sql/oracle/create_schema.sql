--
-- Shopizer - Oracle schema bootstrap
--
-- Run this ONCE as a DBA (SYS or SYSTEM) before starting the application for
-- the first time. It replaces the MySQL bootstrap that used to be documented as
-- comments in the database.properties files:
--
--     mysql> CREATE DATABASE SALESMANAGER;
--     mysql> CREATE USER shopizer IDENTIFIED BY '...';
--     mysql> GRANT ALL ON SALESMANAGER.* TO shopizer;
--
-- In MySQL a database and a user are separate things. In Oracle they are not:
-- a schema IS a user, and it is created implicitly with the user. That is why
-- there is no "CREATE DATABASE" or "CREATE SCHEMA" statement below, and why
-- db.schema in database.properties must name the user that owns the tables.
--
-- Usage (Oracle 12c+ / 18c / 19c / 21c, pluggable database):
--     sqlplus sys/<password>@//localhost:1521/XEPDB1 as sysdba
--     SQL> @create_schema.sql
--
-- The application itself creates the tables: hibernate.hbm2ddl.auto=update
-- generates them on first boot from the JPA entities. A snapshot of exactly
-- what that produces is checked in next to this file as schema.sql, for review
-- and for sites that prefer to apply DDL manually rather than let Hibernate do
-- it. If you apply schema.sql by hand, set hibernate.hbm2ddl.auto=validate.
--

-- Change this password before running.
DEFINE shopizer_password = 'change-this-password'

--
-- The Shopizer schema owner. The application connects as this user, and
-- db.schema=SALESMANAGER in database.properties must match this name.
--
CREATE USER SALESMANAGER IDENTIFIED BY "&shopizer_password";

--
-- Connect and create objects. RESOURCE covers TABLE, SEQUENCE, TRIGGER, TYPE
-- and INDEX. CREATE VIEW is granted separately because RESOURCE does not
-- include it; Shopizer does not define any views today, but the grant keeps
-- Hibernate's schema tooling from failing if one is ever added.
--
GRANT CREATE SESSION TO SALESMANAGER;
GRANT RESOURCE TO SALESMANAGER;
GRANT CREATE TABLE TO SALESMANAGER;
GRANT CREATE SEQUENCE TO SALESMANAGER;
GRANT CREATE VIEW TO SALESMANAGER;

--
-- Without a tablespace quota the very first INSERT fails with ORA-01950, even
-- though the CREATE TABLE succeeds. Replace USERS if this database keeps
-- application data elsewhere.
--
ALTER USER SALESMANAGER QUOTA UNLIMITED ON USERS;

--
-- Shopizer stores multi language catalogue content (see the *_DESCRIPTION
-- tables, which carry a LANGUAGE_ID and a CLOB body). The database must have
-- been created with a Unicode character set, otherwise non ASCII product and
-- category text is silently mangled on insert. Verify with:
--
--     SELECT parameter, value FROM nls_database_parameters
--      WHERE parameter IN ('NLS_CHARACTERSET', 'NLS_NCHAR_CHARACTERSET');
--
-- NLS_CHARACTERSET should be AL32UTF8. This cannot be fixed by a grant; it is
-- fixed at database creation time, so check it before loading any data.
--
-- The generated DDL declares string columns with explicit character semantics
-- (varchar2(120 char), not varchar2(120)), so a 120 character value fits
-- regardless of how many bytes it occupies in AL32UTF8.
--

EXIT;
