
    create table CATALOG (
       id number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        CODE varchar2(100 char) not null,
        DEFAULT_CATALOG number(1,0),
        SORT_ORDER number(10,0),
        VISIBLE number(1,0),
        MERCHANT_ID number(10,0) not null,
        primary key (id)
    );

    create table CATALOG_ENTRY (
       id number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        VISIBLE number(1,0),
        CATALOG_ID number(19,0) not null,
        CATEGORY_ID number(19,0) not null,
        primary key (id)
    );

    create table CATEGORY (
       CATEGORY_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        CATEGORY_IMAGE varchar2(100 char),
        CATEGORY_STATUS number(1,0),
        CODE varchar2(100 char) not null,
        DEPTH number(10,0),
        FEATURED number(1,0),
        LINEAGE varchar2(255 char),
        SORT_ORDER number(10,0),
        VISIBLE number(1,0),
        MERCHANT_ID number(10,0) not null,
        PARENT_ID number(19,0),
        primary key (CATEGORY_ID)
    );

    create table CATEGORY_DESCRIPTION (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        CATEGORY_HIGHLIGHT varchar2(255 char),
        META_DESCRIPTION varchar2(255 char),
        META_KEYWORDS varchar2(255 char),
        META_TITLE varchar2(120 char),
        SEF_URL varchar2(120 char),
        LANGUAGE_ID number(10,0) not null,
        CATEGORY_ID number(19,0) not null,
        primary key (DESCRIPTION_ID)
    );

    create table CONTENT (
       CONTENT_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        CODE varchar2(100 char) not null,
        CONTENT_POSITION varchar2(10 char),
        CONTENT_TYPE varchar2(10 char),
        LINK_TO_MENU number(1,0),
        PRODUCT_GROUP varchar2(255 char),
        SORT_ORDER number(10,0),
        VISIBLE number(1,0),
        MERCHANT_ID number(10,0) not null,
        primary key (CONTENT_ID)
    );

    create table CONTENT_DESCRIPTION (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        META_DESCRIPTION varchar2(255 char),
        META_KEYWORDS varchar2(255 char),
        META_TITLE varchar2(255 char),
        SEF_URL varchar2(120 char),
        LANGUAGE_ID number(10,0) not null,
        CONTENT_ID number(19,0) not null,
        primary key (DESCRIPTION_ID)
    );

    create table COUNTRY (
       COUNTRY_ID number(10,0) not null,
        COUNTRY_ISOCODE varchar2(255 char) not null,
        COUNTRY_SUPPORTED number(1,0),
        GEOZONE_ID number(19,0),
        primary key (COUNTRY_ID)
    );

    create table COUNTRY_DESCRIPTION (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        LANGUAGE_ID number(10,0) not null,
        COUNTRY_ID number(10,0) not null,
        primary key (DESCRIPTION_ID)
    );

    create table CURRENCY (
       CURRENCY_ID number(19,0) not null,
        CURRENCY_CODE varchar2(255 char),
        CURRENCY_CURRENCY_CODE varchar2(255 char) not null,
        CURRENCY_NAME varchar2(255 char),
        CURRENCY_SUPPORTED number(1,0),
        primary key (CURRENCY_ID)
    );

    create table CUSTOMER (
       CUSTOMER_ID number(19,0) not null,
        CUSTOMER_ANONYMOUS number(1,0),
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        BILLING_STREET_ADDRESS varchar2(256 char),
        BILLING_CITY varchar2(100 char),
        BILLING_COMPANY varchar2(100 char),
        BILLING_FIRST_NAME varchar2(64 char) not null,
        BILLING_LAST_NAME varchar2(64 char) not null,
        LATITUDE varchar2(100 char),
        LONGITUDE varchar2(100 char),
        BILLING_POSTCODE varchar2(20 char),
        BILLING_STATE varchar2(100 char),
        BILLING_TELEPHONE varchar2(32 char),
        CUSTOMER_COMPANY varchar2(100 char),
        RESET_CREDENTIALS_REQ varchar2(256 char),
        RESET_CREDENTIALS_EXP date,
        REVIEW_AVG number(19,2),
        REVIEW_COUNT number(10,0),
        CUSTOMER_DOB timestamp,
        DELIVERY_STREET_ADDRESS varchar2(256 char),
        DELIVERY_CITY varchar2(100 char),
        DELIVERY_COMPANY varchar2(100 char),
        DELIVERY_FIRST_NAME varchar2(64 char),
        DELIVERY_LAST_NAME varchar2(64 char),
        DELIVERY_POSTCODE varchar2(20 char),
        DELIVERY_STATE varchar2(100 char),
        DELIVERY_TELEPHONE varchar2(32 char),
        CUSTOMER_EMAIL_ADDRESS varchar2(96 char) not null,
        CUSTOMER_GENDER varchar2(1 char),
        CUSTOMER_NICK varchar2(96 char),
        CUSTOMER_PASSWORD varchar2(60 char),
        PROVIDER varchar2(255 char),
        BILLING_COUNTRY_ID number(10,0) not null,
        BILLING_ZONE_ID number(19,0),
        LANGUAGE_ID number(10,0) not null,
        DELIVERY_COUNTRY_ID number(10,0),
        DELIVERY_ZONE_ID number(19,0),
        MERCHANT_ID number(10,0) not null,
        primary key (CUSTOMER_ID)
    );

    create table CUSTOMER_ATTRIBUTE (
       CUSTOMER_ATTRIBUTE_ID number(19,0) not null,
        CUSTOMER_ATTR_TXT_VAL varchar2(255 char),
        CUSTOMER_ID number(19,0) not null,
        OPTION_ID number(19,0) not null,
        OPTION_VALUE_ID number(19,0) not null,
        primary key (CUSTOMER_ATTRIBUTE_ID)
    );

    create table CUSTOMER_GROUP (
       CUSTOMER_ID number(19,0) not null,
        GROUP_ID number(10,0) not null
    );

    create table CUSTOMER_OPT_VAL_DESCRIPTION (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        LANGUAGE_ID number(10,0) not null,
        CUSTOMER_OPT_VAL_ID number(19,0),
        primary key (DESCRIPTION_ID)
    );

    create table CUSTOMER_OPTIN (
       CUSTOMER_OPTIN_ID number(19,0) not null,
        EMAIL varchar2(255 char) not null,
        FIRST varchar2(255 char),
        LAST varchar2(255 char),
        OPTIN_DATE timestamp,
        VALUE clob,
        MERCHANT_ID number(10,0) not null,
        OPTIN_ID number(19,0),
        primary key (CUSTOMER_OPTIN_ID)
    );

    create table CUSTOMER_OPTION (
       CUSTOMER_OPTION_ID number(19,0) not null,
        CUSTOMER_OPT_ACTIVE number(1,0),
        CUSTOMER_OPT_CODE varchar2(255 char),
        CUSTOMER_OPTION_TYPE varchar2(10 char),
        CUSTOMER_OPT_PUBLIC number(1,0),
        SORT_ORDER number(10,0),
        MERCHANT_ID number(10,0) not null,
        primary key (CUSTOMER_OPTION_ID)
    );

    create table CUSTOMER_OPTION_DESC (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        CUSTOMER_OPTION_COMMENT varchar2(4000 char),
        LANGUAGE_ID number(10,0) not null,
        CUSTOMER_OPTION_ID number(19,0) not null,
        primary key (DESCRIPTION_ID)
    );

    create table CUSTOMER_OPTION_SET (
       CUSTOMER_OPTIONSET_ID number(19,0) not null,
        SORT_ORDER number(10,0),
        CUSTOMER_OPTION_ID number(19,0) not null,
        CUSTOMER_OPTION_VALUE_ID number(19,0) not null,
        primary key (CUSTOMER_OPTIONSET_ID)
    );

    create table CUSTOMER_OPTION_VALUE (
       CUSTOMER_OPTION_VALUE_ID number(19,0) not null,
        CUSTOMER_OPT_VAL_CODE varchar2(255 char),
        CUSTOMER_OPT_VAL_IMAGE varchar2(255 char),
        SORT_ORDER number(10,0),
        MERCHANT_ID number(10,0) not null,
        primary key (CUSTOMER_OPTION_VALUE_ID)
    );

    create table CUSTOMER_REVIEW (
       CUSTOMER_REVIEW_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        REVIEW_DATE timestamp,
        REVIEWS_RATING double precision,
        REVIEWS_READ number(19,0),
        STATUS number(10,0),
        CUSTOMERS_ID number(19,0),
        REVIEWED_CUSTOMER_ID number(19,0),
        primary key (CUSTOMER_REVIEW_ID)
    );

    create table CUSTOMER_REVIEW_DESCRIPTION (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        LANGUAGE_ID number(10,0) not null,
        CUSTOMER_REVIEW_ID number(19,0),
        primary key (DESCRIPTION_ID)
    );

    create table FILE_HISTORY (
       FILE_HISTORY_ID number(19,0) not null,
        ACCOUNTED_DATE timestamp,
        DATE_ADDED timestamp not null,
        DATE_DELETED timestamp,
        DOWNLOAD_COUNT number(10,0) not null,
        FILE_ID number(19,0),
        FILESIZE number(10,0) not null,
        MERCHANT_ID number(10,0) not null,
        primary key (FILE_HISTORY_ID)
    );

    create table GEOZONE (
       GEOZONE_ID number(19,0) not null,
        GEOZONE_CODE varchar2(255 char),
        GEOZONE_NAME varchar2(255 char),
        primary key (GEOZONE_ID)
    );

    create table GEOZONE_DESCRIPTION (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        LANGUAGE_ID number(10,0) not null,
        GEOZONE_ID number(19,0),
        primary key (DESCRIPTION_ID)
    );

    create table LANGUAGE (
       LANGUAGE_ID number(10,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        CODE varchar2(255 char) not null,
        SORT_ORDER number(10,0),
        primary key (LANGUAGE_ID)
    );

    create table MANUFACTURER (
       MANUFACTURER_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        CODE varchar2(100 char) not null,
        MANUFACTURER_IMAGE varchar2(255 char),
        SORT_ORDER number(10,0),
        MERCHANT_ID number(10,0) not null,
        primary key (MANUFACTURER_ID)
    );

    create table MANUFACTURER_DESCRIPTION (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        DATE_LAST_CLICK timestamp,
        MANUFACTURERS_URL varchar2(255 char),
        URL_CLICKED number(10,0),
        LANGUAGE_ID number(10,0) not null,
        MANUFACTURER_ID number(19,0) not null,
        primary key (DESCRIPTION_ID)
    );

    create table MERCHANT_CONFIGURATION (
       MERCHANT_CONFIG_ID number(19,0) not null,
        ACTIVE number(1,0),
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        CONFIG_KEY varchar2(255 char),
        TYPE varchar2(255 char),
        VALUE clob,
        MERCHANT_ID number(10,0),
        primary key (MERCHANT_CONFIG_ID)
    );

    create table MERCHANT_LANGUAGE (
       stores_MERCHANT_ID number(10,0) not null,
        languages_LANGUAGE_ID number(10,0) not null
    );

    create table MERCHANT_LOG (
       MERCHANT_LOG_ID number(19,0) not null,
        LOG clob,
        MODULE varchar2(25 char),
        MERCHANT_ID number(10,0) not null,
        primary key (MERCHANT_LOG_ID)
    );

    create table MERCHANT_STORE (
       MERCHANT_ID number(10,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        STORE_CODE varchar2(100 char) not null,
        CONTINUESHOPPINGURL varchar2(150 char),
        CURRENCY_FORMAT_NATIONAL number(1,0),
        DOMAIN_NAME varchar2(80 char),
        IN_BUSINESS_SINCE date,
        INVOICE_TEMPLATE varchar2(25 char),
        LINEAGE varchar2(255 char),
        IS_RETAILER number(1,0),
        SEIZEUNITCODE varchar2(5 char),
        STORE_EMAIL varchar2(60 char) not null,
        STORE_LOGO varchar2(100 char),
        STORE_TEMPLATE varchar2(25 char),
        STORE_ADDRESS varchar2(255 char),
        STORE_CITY varchar2(100 char),
        STORE_NAME varchar2(100 char) not null,
        STORE_PHONE varchar2(50 char),
        STORE_POSTAL_CODE varchar2(15 char),
        STORE_STATE_PROV varchar2(100 char),
        USE_CACHE number(1,0),
        WEIGHTUNITCODE varchar2(5 char),
        COUNTRY_ID number(10,0) not null,
        CURRENCY_ID number(19,0) not null,
        LANGUAGE_ID number(10,0) not null,
        PARENT_ID number(10,0),
        ZONE_ID number(19,0),
        primary key (MERCHANT_ID)
    );

    create table MODULE_CONFIGURATION (
       MODULE_CONF_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        CODE varchar2(255 char) not null,
        DETAILS clob,
        CONFIGURATION varchar2(4000 char),
        CUSTOM_IND number(1,0),
        IMAGE varchar2(255 char),
        MODULE varchar2(255 char),
        REGIONS varchar2(255 char),
        TYPE varchar2(255 char),
        primary key (MODULE_CONF_ID)
    );

    create table OPTIN (
       OPTIN_ID number(19,0) not null,
        CODE varchar2(255 char) not null,
        DESCRIPTION varchar2(255 char),
        END_DATE timestamp,
        TYPE varchar2(255 char) not null,
        START_DATE timestamp,
        MERCHANT_ID number(10,0),
        primary key (OPTIN_ID)
    );

    create table ORDER_ACCOUNT (
       ORDER_ACCOUNT_ID number(19,0) not null,
        ORDER_ACCOUNT_BILL_DAY number(10,0) not null,
        ORDER_ACCOUNT_END_DATE date,
        ORDER_ACCOUNT_START_DATE date not null,
        ORDER_ID number(19,0) not null,
        primary key (ORDER_ACCOUNT_ID)
    );

    create table ORDER_ACCOUNT_PRODUCT (
       ORDER_ACCOUNT_PRODUCT_ID number(19,0) not null,
        ORDER_ACCOUNT_PRODUCT_ACCNT_DT date,
        ORDER_ACCOUNT_PRODUCT_END_DT date,
        ORDER_ACCOUNT_PRODUCT_EOT timestamp,
        ORDER_ACCOUNT_PRODUCT_L_ST_DT timestamp,
        ORDER_ACCOUNT_PRODUCT_L_TRX_ST number(10,0) not null,
        ORDER_ACCOUNT_PRODUCT_PM_FR_TY number(10,0) not null,
        ORDER_ACCOUNT_PRODUCT_ST_DT date not null,
        ORDER_ACCOUNT_PRODUCT_STATUS number(10,0) not null,
        ORDER_ACCOUNT_ID number(19,0) not null,
        ORDER_PRODUCT_ID number(19,0) not null,
        primary key (ORDER_ACCOUNT_PRODUCT_ID)
    );

    create table ORDER_ATTRIBUTE (
       ORDER_ATTRIBUTE_ID number(19,0) not null,
        IDENTIFIER varchar2(255 char) not null,
        VALUE varchar2(255 char) not null,
        ORDER_ID number(19,0) not null,
        primary key (ORDER_ATTRIBUTE_ID)
    );

    create table ORDER_PRODUCT (
       ORDER_PRODUCT_ID number(19,0) not null,
        ONETIME_CHARGE number(19,2) not null,
        PRODUCT_NAME varchar2(64 char) not null,
        PRODUCT_QUANTITY number(10,0),
        PRODUCT_SKU varchar2(255 char),
        ORDER_ID number(19,0) not null,
        primary key (ORDER_PRODUCT_ID)
    );

    create table ORDER_PRODUCT_ATTRIBUTE (
       ORDER_PRODUCT_ATTRIBUTE_ID number(19,0) not null,
        PRODUCT_ATTRIBUTE_IS_FREE number(1,0) not null,
        PRODUCT_ATTRIBUTE_NAME varchar2(255 char),
        PRODUCT_ATTRIBUTE_PRICE number(15,4) not null,
        PRODUCT_ATTRIBUTE_VAL_NAME varchar2(255 char),
        PRODUCT_ATTRIBUTE_WEIGHT number(15,4),
        PRODUCT_OPTION_ID number(19,0) not null,
        PRODUCT_OPTION_VALUE_ID number(19,0) not null,
        ORDER_PRODUCT_ID number(19,0) not null,
        primary key (ORDER_PRODUCT_ATTRIBUTE_ID)
    );

    create table ORDER_PRODUCT_DOWNLOAD (
       ORDER_PRODUCT_DOWNLOAD_ID number(19,0) not null,
        DOWNLOAD_COUNT number(10,0) not null,
        DOWNLOAD_MAXDAYS number(10,0) not null,
        ORDER_PRODUCT_FILENAME varchar2(255 char) not null,
        ORDER_PRODUCT_ID number(19,0) not null,
        primary key (ORDER_PRODUCT_DOWNLOAD_ID)
    );

    create table ORDER_PRODUCT_PRICE (
       ORDER_PRODUCT_PRICE_ID number(19,0) not null,
        DEFAULT_PRICE number(1,0) not null,
        PRODUCT_PRICE number(19,2) not null,
        PRODUCT_PRICE_CODE varchar2(64 char) not null,
        PRODUCT_PRICE_NAME varchar2(255 char),
        PRODUCT_PRICE_SPECIAL number(19,2),
        PRD_PRICE_SPECIAL_END_DT timestamp,
        PRD_PRICE_SPECIAL_ST_DT timestamp,
        ORDER_PRODUCT_ID number(19,0) not null,
        primary key (ORDER_PRODUCT_PRICE_ID)
    );

    create table ORDER_STATUS_HISTORY (
       ORDER_STATUS_HISTORY_ID number(19,0) not null,
        COMMENTS clob,
        CUSTOMER_NOTIFIED number(10,0),
        DATE_ADDED timestamp not null,
        status varchar2(255 char),
        ORDER_ID number(19,0) not null,
        primary key (ORDER_STATUS_HISTORY_ID)
    );

    create table ORDER_TOTAL (
       ORDER_ACCOUNT_ID number(19,0) not null,
        MODULE varchar2(60 char),
        CODE varchar2(255 char) not null,
        ORDER_TOTAL_TYPE varchar2(255 char),
        ORDER_VALUE_TYPE varchar2(255 char),
        SORT_ORDER number(10,0) not null,
        TEXT clob,
        TITLE varchar2(255 char),
        VALUE number(15,4) not null,
        ORDER_ID number(19,0) not null,
        primary key (ORDER_ACCOUNT_ID)
    );

    create table ORDERS (
       ORDER_ID number(19,0) not null,
        BILLING_STREET_ADDRESS varchar2(256 char),
        BILLING_CITY varchar2(100 char),
        BILLING_COMPANY varchar2(100 char),
        BILLING_FIRST_NAME varchar2(64 char) not null,
        BILLING_LAST_NAME varchar2(64 char) not null,
        LATITUDE varchar2(100 char),
        LONGITUDE varchar2(100 char),
        BILLING_POSTCODE varchar2(20 char),
        BILLING_STATE varchar2(100 char),
        BILLING_TELEPHONE varchar2(32 char),
        CHANNEL varchar2(255 char),
        CONFIRMED_ADDRESS number(1,0),
        CARD_TYPE varchar2(255 char),
        CC_CVV varchar2(255 char),
        CC_EXPIRES varchar2(255 char),
        CC_NUMBER varchar2(255 char),
        CC_OWNER varchar2(255 char),
        CURRENCY_VALUE number(19,2),
        CUSTOMER_AGREED number(1,0),
        CUSTOMER_EMAIL_ADDRESS varchar2(50 char) not null,
        CUSTOMER_ID number(19,0),
        DATE_PURCHASED date,
        DELIVERY_STREET_ADDRESS varchar2(256 char),
        DELIVERY_CITY varchar2(100 char),
        DELIVERY_COMPANY varchar2(100 char),
        DELIVERY_FIRST_NAME varchar2(64 char),
        DELIVERY_LAST_NAME varchar2(64 char),
        DELIVERY_POSTCODE varchar2(20 char),
        DELIVERY_STATE varchar2(100 char),
        DELIVERY_TELEPHONE varchar2(32 char),
        IP_ADDRESS varchar2(255 char),
        LAST_MODIFIED timestamp,
        LOCALE varchar2(255 char),
        ORDER_DATE_FINISHED timestamp,
        ORDER_TYPE varchar2(255 char),
        PAYMENT_MODULE_CODE varchar2(255 char),
        PAYMENT_TYPE varchar2(255 char),
        SHIPPING_MODULE_CODE varchar2(255 char),
        CART_CODE varchar2(255 char),
        ORDER_STATUS varchar2(255 char),
        ORDER_TOTAL number(19,2),
        BILLING_COUNTRY_ID number(10,0) not null,
        BILLING_ZONE_ID number(19,0),
        CURRENCY_ID number(19,0),
        DELIVERY_COUNTRY_ID number(10,0),
        DELIVERY_ZONE_ID number(19,0),
        MERCHANTID number(10,0),
        primary key (ORDER_ID)
    );

    create table PERMISSION (
       PERMISSION_ID number(10,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        PERMISSION_NAME varchar2(255 char),
        primary key (PERMISSION_ID)
    );

    create table PERMISSION_GROUP (
       GROUP_ID number(10,0) not null,
        PERMISSION_ID number(10,0) not null,
        primary key (GROUP_ID, PERMISSION_ID)
    );

    create table PRODUCT (
       PRODUCT_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        AVAILABLE number(1,0),
        COND number(10,0),
        DATE_AVAILABLE timestamp,
        PREORDER number(1,0),
        PRODUCT_HEIGHT number(19,2),
        PRODUCT_FREE number(1,0),
        PRODUCT_LENGTH number(19,2),
        QUANTITY_ORDERED number(10,0),
        REVIEW_AVG number(19,2),
        REVIEW_COUNT number(10,0),
        PRODUCT_SHIP number(1,0),
        PRODUCT_VIRTUAL number(1,0),
        PRODUCT_WEIGHT number(19,2),
        PRODUCT_WIDTH number(19,2),
        REF_SKU varchar2(255 char),
        RENTAL_DURATION number(10,0),
        RENTAL_PERIOD number(10,0),
        RENTAL_STATUS number(10,0),
        SKU varchar2(255 char),
        SORT_ORDER number(10,0),
        MANUFACTURER_ID number(19,0),
        MERCHANT_ID number(10,0) not null,
        CUSTOMER_ID number(19,0),
        TAX_CLASS_ID number(19,0),
        PRODUCT_TYPE_ID number(19,0),
        primary key (PRODUCT_ID)
    );

    create table PRODUCT_ATTRIBUTE (
       PRODUCT_ATTRIBUTE_ID number(19,0) not null,
        PRODUCT_ATTRIBUTE_DEFAULT number(1,0),
        PRODUCT_ATTRIBUTE_DISCOUNTED number(1,0),
        PRODUCT_ATTRIBUTE_FOR_DISP number(1,0),
        PRODUCT_ATTRIBUTE_REQUIRED number(1,0),
        PRODUCT_ATTRIBUTE_FREE number(1,0),
        PRODUCT_ATRIBUTE_PRICE number(19,2),
        PRODUCT_ATTRIBUTE_WEIGHT number(19,2),
        PRODUCT_ATTRIBUTE_SORT_ORD number(10,0),
        PRODUCT_ID number(19,0) not null,
        OPTION_ID number(19,0) not null,
        OPTION_VALUE_ID number(19,0) not null,
        primary key (PRODUCT_ATTRIBUTE_ID)
    );

    create table PRODUCT_AVAILABILITY (
       PRODUCT_AVAIL_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        AVAILABLE number(1,0),
        HEIGHT number(19,2),
        LENGTH number(19,2),
        WEIGHT number(19,2),
        WIDTH number(19,2),
        OWNER varchar2(255 char),
        DATE_AVAILABLE date,
        FREE_SHIPPING number(1,0),
        QUANTITY number(10,0),
        QUANTITY_ORD_MAX number(10,0),
        QUANTITY_ORD_MIN number(10,0),
        STATUS number(1,0),
        REGION varchar2(255 char),
        REGION_VARIANT varchar2(255 char),
        SKU varchar2(255 char),
        MERCHANT_ID number(10,0),
        PRODUCT_ID number(19,0) not null,
        PRODUCT_VARIANT number(19,0),
        primary key (PRODUCT_AVAIL_ID)
    );

    create table PRODUCT_CATEGORY (
       PRODUCT_ID number(19,0) not null,
        CATEGORY_ID number(19,0) not null,
        primary key (PRODUCT_ID, CATEGORY_ID)
    );

    create table PRODUCT_DESCRIPTION (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        META_DESCRIPTION varchar2(255 char),
        META_KEYWORDS varchar2(255 char),
        META_TITLE varchar2(255 char),
        DOWNLOAD_LNK varchar2(255 char),
        PRODUCT_HIGHLIGHT varchar2(255 char),
        SEF_URL varchar2(255 char),
        LANGUAGE_ID number(10,0) not null,
        PRODUCT_ID number(19,0) not null,
        primary key (DESCRIPTION_ID)
    );

    create table PRODUCT_DIGITAL (
       PRODUCT_DIGITAL_ID number(19,0) not null,
        FILE_NAME varchar2(255 char) not null,
        PRODUCT_ID number(19,0) not null,
        primary key (PRODUCT_DIGITAL_ID)
    );

    create table PRODUCT_IMAGE (
       PRODUCT_IMAGE_ID number(19,0) not null,
        DEFAULT_IMAGE number(1,0),
        IMAGE_CROP number(1,0),
        IMAGE_TYPE number(10,0),
        PRODUCT_IMAGE varchar2(255 char),
        PRODUCT_IMAGE_URL varchar2(255 char),
        SORT_ORDER number(10,0),
        PRODUCT_ID number(19,0) not null,
        primary key (PRODUCT_IMAGE_ID)
    );

    create table PRODUCT_IMAGE_DESCRIPTION (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        ALT_TAG varchar2(100 char),
        LANGUAGE_ID number(10,0) not null,
        PRODUCT_IMAGE_ID number(19,0) not null,
        primary key (DESCRIPTION_ID)
    );

    create table PRODUCT_OPT_SET_OPT_VALUE (
       ProductOptionSet_PRODUCT_OPTION_SET_ID number(19,0) not null,
        values_PRODUCT_OPTION_VALUE_ID number(19,0) not null
    );

    create table PRODUCT_OPT_SET_PRD_TYPE (
       ProductOptionSet_PRODUCT_OPTION_SET_ID number(19,0) not null,
        productTypes_PRODUCT_TYPE_ID number(19,0) not null,
        primary key (ProductOptionSet_PRODUCT_OPTION_SET_ID, productTypes_PRODUCT_TYPE_ID)
    );

    create table PRODUCT_OPTION (
       PRODUCT_OPTION_ID number(19,0) not null,
        PRODUCT_OPTION_CODE varchar2(255 char),
        PRODUCT_OPTION_SORT_ORD number(10,0),
        PRODUCT_OPTION_TYPE varchar2(10 char),
        PRODUCT_OPTION_READ number(1,0),
        MERCHANT_ID number(10,0) not null,
        primary key (PRODUCT_OPTION_ID)
    );

    create table PRODUCT_OPTION_DESC (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        PRODUCT_OPTION_COMMENT varchar2(4000 char),
        LANGUAGE_ID number(10,0) not null,
        PRODUCT_OPTION_ID number(19,0) not null,
        primary key (DESCRIPTION_ID)
    );

    create table PRODUCT_OPTION_SET (
       PRODUCT_OPTION_SET_ID number(19,0) not null,
        PRODUCT_OPTION_SET_CODE varchar2(255 char),
        PRODUCT_OPTION_SET_DISP number(1,0),
        PRODUCT_OPTION_ID number(19,0) not null,
        MERCHANT_ID number(10,0) not null,
        primary key (PRODUCT_OPTION_SET_ID)
    );

    create table PRODUCT_OPTION_VALUE (
       PRODUCT_OPTION_VALUE_ID number(19,0) not null,
        PRODUCT_OPTION_VAL_CODE varchar2(255 char),
        PRODUCT_OPT_FOR_DISP number(1,0),
        PRODUCT_OPT_VAL_IMAGE varchar2(255 char),
        PRODUCT_OPT_VAL_SORT_ORD number(10,0),
        MERCHANT_ID number(10,0) not null,
        primary key (PRODUCT_OPTION_VALUE_ID)
    );

    create table PRODUCT_OPTION_VALUE_DESCRIPTION (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        LANGUAGE_ID number(10,0) not null,
        PRODUCT_OPTION_VALUE_ID number(19,0),
        primary key (DESCRIPTION_ID)
    );

    create table PRODUCT_PRICE (
       PRODUCT_PRICE_ID number(19,0) not null,
        PRODUCT_PRICE_CODE varchar2(255 char) not null,
        DEFAULT_PRICE number(1,0),
        PRODUCT_IDENTIFIER_ID number(19,0),
        PRODUCT_PRICE_AMOUNT number(19,2),
        PRODUCT_PRICE_SPECIAL_AMOUNT number(19,2),
        PRODUCT_PRICE_SPECIAL_END_DATE date,
        PRODUCT_PRICE_SPECIAL_ST_DATE date,
        PRODUCT_PRICE_TYPE varchar2(20 char),
        PRODUCT_AVAIL_ID number(19,0) not null,
        primary key (PRODUCT_PRICE_ID)
    );

    create table PRODUCT_PRICE_DESCRIPTION (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        PRICE_APPENDER varchar2(255 char),
        LANGUAGE_ID number(10,0) not null,
        PRODUCT_PRICE_ID number(19,0) not null,
        primary key (DESCRIPTION_ID)
    );

    create table PRODUCT_RELATIONSHIP (
       PRODUCT_RELATIONSHIP_ID number(19,0) not null,
        ACTIVE number(1,0),
        CODE varchar2(255 char),
        PRODUCT_ID number(19,0),
        RELATED_PRODUCT_ID number(19,0),
        MERCHANT_ID number(10,0) not null,
        primary key (PRODUCT_RELATIONSHIP_ID)
    );

    create table PRODUCT_REVIEW (
       PRODUCT_REVIEW_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        REVIEW_DATE timestamp,
        REVIEWS_RATING double precision,
        REVIEWS_READ number(19,0),
        STATUS number(10,0),
        CUSTOMERS_ID number(19,0),
        PRODUCT_ID number(19,0),
        primary key (PRODUCT_REVIEW_ID)
    );

    create table PRODUCT_REVIEW_DESCRIPTION (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        LANGUAGE_ID number(10,0) not null,
        PRODUCT_REVIEW_ID number(19,0),
        primary key (DESCRIPTION_ID)
    );

    create table PRODUCT_TYPE (
       PRODUCT_TYPE_ID number(19,0) not null,
        PRD_TYPE_ADD_TO_CART number(1,0),
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        PRD_TYPE_CODE varchar2(255 char),
        PRD_TYPE_VISIBLE number(1,0),
        MERCHANT_ID number(10,0),
        primary key (PRODUCT_TYPE_ID)
    );

    create table PRODUCT_TYPE_DESCRIPTION (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        LANGUAGE_ID number(10,0) not null,
        PRODUCT_TYPE_ID number(19,0) not null,
        primary key (DESCRIPTION_ID)
    );

    create table PRODUCT_VAR_IMAGE (
       PRODUCT_VAR_IMAGE_ID number(19,0) not null,
        DEFAULT_IMAGE number(1,0),
        PRODUCT_IMAGE varchar2(255 char),
        PRODUCT_VARIANT_GROUP_ID number(19,0) not null,
        primary key (PRODUCT_VAR_IMAGE_ID)
    );

    create table PRODUCT_VAR_IMAGE_DESCRIPTION (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        ALT_TAG varchar2(100 char),
        LANGUAGE_ID number(10,0) not null,
        PRODUCT_ID number(19,0) not null,
        PRODUCT_VAR_IMAGE_ID number(19,0) not null,
        primary key (DESCRIPTION_ID)
    );

    create table PRODUCT_VARIANT (
       PRODUCT_VARIANT_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        AVAILABLE number(1,0),
        CODE varchar2(255 char),
        DATE_AVAILABLE timestamp,
        DEFAULT_SELECTION number(1,0),
        SKU varchar2(255 char),
        SORT_ORDER number(10,0),
        PRODUCT_ID number(19,0) not null,
        PRODUCT_VARIANT_GROUP_ID number(19,0),
        PRODUCT_VARIATION_ID number(19,0),
        PRODUCT_VARIATION_VALUE_ID number(19,0),
        primary key (PRODUCT_VARIANT_ID)
    );

    create table PRODUCT_VARIANT_GROUP (
       PRODUCT_VARIANT_GROUP_ID number(19,0) not null,
        MERCHANT_ID number(10,0) not null,
        primary key (PRODUCT_VARIANT_GROUP_ID)
    );

    create table PRODUCT_VARIATION (
       PRODUCT_VARIATION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        CODE varchar2(100 char) not null,
        SORT_ORDER number(10,0),
        VARIANT_DEFAULT number(1,0),
        MERCHANT_ID number(10,0) not null,
        PRODUCT_OPTION_ID number(19,0) not null,
        OPTION_VALUE_ID number(19,0) not null,
        primary key (PRODUCT_VARIATION_ID)
    );

    create table SHIPING_ORIGIN (
       SHIP_ORIGIN_ID number(19,0) not null,
        ACTIVE number(1,0),
        STREET_ADDRESS varchar2(256 char),
        CITY varchar2(100 char),
        POSTCODE varchar2(20 char),
        STATE varchar2(100 char),
        COUNTRY_ID number(10,0),
        MERCHANT_ID number(10,0) not null,
        ZONE_ID number(19,0),
        primary key (SHIP_ORIGIN_ID)
    );

    create table SHIPPING_QUOTE (
       SHIPPING_QUOTE_ID number(19,0) not null,
        CART_ID number(19,0),
        CUSTOMER_ID number(19,0),
        DELIVERY_STREET_ADDRESS varchar2(256 char),
        DELIVERY_CITY varchar2(100 char),
        DELIVERY_COMPANY varchar2(100 char),
        DELIVERY_FIRST_NAME varchar2(64 char),
        DELIVERY_LAST_NAME varchar2(64 char),
        DELIVERY_POSTCODE varchar2(20 char),
        DELIVERY_STATE varchar2(100 char),
        DELIVERY_TELEPHONE varchar2(32 char),
        SHIPPING_NUMBER_DAYS number(10,0),
        FREE_SHIPPING number(1,0),
        QUOTE_HANDLING number(19,2),
        IP_ADDRESS varchar2(255 char),
        MODULE varchar2(255 char) not null,
        OPTION_CODE varchar2(255 char),
        OPTION_DELIVERY_DATE timestamp,
        OPTION_NAME varchar2(255 char),
        OPTION_SHIPPING_DATE timestamp,
        ORDER_ID number(19,0),
        QUOTE_PRICE number(19,2),
        QUOTE_DATE timestamp,
        DELIVERY_COUNTRY_ID number(10,0),
        DELIVERY_ZONE_ID number(19,0),
        primary key (SHIPPING_QUOTE_ID)
    );

    create table SHOPPING_CART (
       SHP_CART_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        CUSTOMER_ID number(19,0),
        IP_ADDRESS varchar2(255 char),
        ORDER_ID number(19,0),
        PROMO_ADDED timestamp,
        PROMO_CODE varchar2(255 char),
        SHP_CART_CODE varchar2(255 char) not null,
        MERCHANT_ID number(10,0) not null,
        primary key (SHP_CART_ID)
    );

    create table SHOPPING_CART_ATTR_ITEM (
       SHP_CART_ATTR_ITEM_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        PRODUCT_ATTR_ID number(19,0) not null,
        SHP_CART_ITEM_ID number(19,0) not null,
        primary key (SHP_CART_ATTR_ITEM_ID)
    );

    create table SHOPPING_CART_ITEM (
       SHP_CART_ITEM_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        PRODUCT_ID number(19,0) not null,
        QUANTITY number(10,0),
        SKU varchar2(255 char),
        PRODUCT_VARIANT number(19,0),
        SHP_CART_ID number(19,0) not null,
        primary key (SHP_CART_ITEM_ID)
    );

    create table SM_GROUP (
       GROUP_ID number(10,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        GROUP_NAME varchar2(255 char),
        GROUP_TYPE varchar2(255 char),
        primary key (GROUP_ID)
    );

    create table SM_SEQUENCER (
       SEQ_NAME varchar2(255 char) not null,
        SEQ_COUNT number(19,0),
        primary key (SEQ_NAME)
    );

    create table SM_TRANSACTION (
       TRANSACTION_ID number(19,0) not null,
        AMOUNT number(19,2),
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DETAILS clob,
        PAYMENT_TYPE varchar2(255 char),
        TRANSACTION_DATE timestamp,
        TRANSACTION_TYPE varchar2(255 char),
        ORDER_ID number(19,0),
        primary key (TRANSACTION_ID)
    );

    create table SYSTEM_CONFIGURATION (
       SYSTEM_CONFIG_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        CONFIG_KEY varchar2(255 char),
        VALUE varchar2(255 char),
        primary key (SYSTEM_CONFIG_ID)
    );

    create table SYSTEM_NOTIFICATION (
       SYSTEM_NOTIF_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        END_DATE date,
        CONFIG_KEY varchar2(255 char),
        START_DATE date,
        VALUE varchar2(255 char),
        MERCHANT_ID number(10,0),
        USER_ID number(19,0),
        primary key (SYSTEM_NOTIF_ID)
    );

    create table TAX_CLASS (
       TAX_CLASS_ID number(19,0) not null,
        TAX_CLASS_CODE varchar2(10 char) not null,
        TAX_CLASS_TITLE varchar2(32 char) not null,
        MERCHANT_ID number(10,0),
        primary key (TAX_CLASS_ID)
    );

    create table TAX_RATE (
       TAX_RATE_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        TAX_CODE varchar2(255 char),
        PIGGYBACK number(1,0),
        STORE_STATE_PROV varchar2(100 char),
        TAX_PRIORITY number(10,0),
        TAX_RATE number(7,4) not null,
        COUNTRY_ID number(10,0) not null,
        MERCHANT_ID number(10,0) not null,
        PARENT_ID number(19,0),
        TAX_CLASS_ID number(19,0) not null,
        ZONE_ID number(19,0),
        primary key (TAX_RATE_ID)
    );

    create table TAX_RATE_DESCRIPTION (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        LANGUAGE_ID number(10,0) not null,
        TAX_RATE_ID number(19,0),
        primary key (DESCRIPTION_ID)
    );

    create table USER_GROUP (
       USER_ID number(19,0) not null,
        GROUP_ID number(10,0) not null
    );

    create table UserConnection (
       providerId varchar2(255 char) not null,
        providerUserId varchar2(255 char) not null,
        userId varchar2(255 char) not null,
        accessToken varchar2(255 char),
        displayName varchar2(255 char),
        expireTime number(19,0),
        imageUrl varchar2(255 char),
        profileUrl varchar2(255 char),
        refreshToken varchar2(255 char),
        secret varchar2(255 char),
        userRank number(10,0) not null,
        primary key (providerId, providerUserId, userId)
    );

    create table USERS (
       USER_ID number(19,0) not null,
        ACTIVE number(1,0),
        ADMIN_EMAIL varchar2(255 char),
        ADMIN_NAME varchar2(100 char),
        ADMIN_PASSWORD varchar2(60 char),
        ADMIN_A1 varchar2(255 char),
        ADMIN_A2 varchar2(255 char),
        ADMIN_A3 varchar2(255 char),
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        RESET_CREDENTIALS_REQ varchar2(256 char),
        RESET_CREDENTIALS_EXP date,
        ADMIN_FIRST_NAME varchar2(255 char),
        LAST_ACCESS timestamp,
        ADMIN_LAST_NAME varchar2(255 char),
        LOGIN_ACCESS timestamp,
        ADMIN_Q1 varchar2(255 char),
        ADMIN_Q2 varchar2(255 char),
        ADMIN_Q3 varchar2(255 char),
        LANGUAGE_ID number(10,0),
        MERCHANT_ID number(10,0) not null,
        primary key (USER_ID)
    );

    create table ZONE (
       ZONE_ID number(19,0) not null,
        ZONE_CODE varchar2(255 char) not null,
        COUNTRY_ID number(10,0) not null,
        primary key (ZONE_ID)
    );

    create table ZONE_DESCRIPTION (
       DESCRIPTION_ID number(19,0) not null,
        DATE_CREATED timestamp,
        DATE_MODIFIED timestamp,
        UPDT_ID varchar2(60 char),
        DESCRIPTION clob,
        NAME varchar2(120 char) not null,
        TITLE varchar2(100 char),
        LANGUAGE_ID number(10,0) not null,
        ZONE_ID number(19,0) not null,
        primary key (DESCRIPTION_ID)
    );

    alter table CATALOG 
       add constraint UK32mubpubtaqu30n34bwl7xiis unique (MERCHANT_ID, CODE);

    alter table CATALOG_ENTRY 
       add constraint UK5q8159i414r299kia2w9re90k unique (CATEGORY_ID, CATALOG_ID);
create index IDXlctdd0gcnad49kass3ntxv54n on CATEGORY (LINEAGE);

    alter table CATEGORY 
       add constraint UK3mq9i6qmgquvoieslx39pej6x unique (MERCHANT_ID, CODE);

    alter table CATEGORY_DESCRIPTION 
       add constraint UKbuesqq6cyx7e5hy3mf30cfieq unique (CATEGORY_ID, LANGUAGE_ID);
create index CODE_IDX on CONTENT (CODE);

    alter table CONTENT 
       add constraint UKt1v2ld0mrwviquqourql4uub0 unique (MERCHANT_ID, CODE);

    alter table CONTENT_DESCRIPTION 
       add constraint UKn0w5r7ctbp88r4rvk7ayklofm unique (CONTENT_ID, LANGUAGE_ID);

    alter table COUNTRY 
       add constraint UK_dqb99v22pt27v0tgeqo958e6x unique (COUNTRY_ISOCODE);

    alter table COUNTRY_DESCRIPTION 
       add constraint UKt7nshki1rbp6157ed0v6cx4y4 unique (COUNTRY_ID, LANGUAGE_ID);

    alter table CURRENCY 
       add constraint UK_1ubr7n96hjajamtggqp090a4x unique (CURRENCY_CODE);

    alter table CURRENCY 
       add constraint UK_m7ku15ekud52vp67ry73a36te unique (CURRENCY_CURRENCY_CODE);

    alter table CURRENCY 
       add constraint UK_7r1k69cbk5giewqr5c9r4v6f unique (CURRENCY_NAME);

    alter table CUSTOMER 
       add constraint UK6v48av32rli7qu9m3ksb32art unique (MERCHANT_ID, CUSTOMER_NICK);

    alter table CUSTOMER_ATTRIBUTE 
       add constraint UK46kbpre88yh963gewm3kmdni1 unique (OPTION_ID, CUSTOMER_ID);

    alter table CUSTOMER_OPT_VAL_DESCRIPTION 
       add constraint UKge7f2t1d31r87wnk09h9u1tnv unique (CUSTOMER_OPT_VAL_ID, LANGUAGE_ID);

    alter table CUSTOMER_OPTIN 
       add constraint UKc4fnyu0pvxxtrbko10rm1jqyw unique (EMAIL, OPTIN_ID);
create index CUST_OPT_CODE_IDX on CUSTOMER_OPTION (CUSTOMER_OPT_CODE);

    alter table CUSTOMER_OPTION 
       add constraint UKrov34a6g4dhhiqukvhp1ggm0u unique (MERCHANT_ID, CUSTOMER_OPT_CODE);

    alter table CUSTOMER_OPTION_DESC 
       add constraint UK6ovl4t1ciag1wubtcebaoo7vi unique (CUSTOMER_OPTION_ID, LANGUAGE_ID);

    alter table CUSTOMER_OPTION_SET 
       add constraint UK4peli2ritnnq2xqpyq188srm6 unique (CUSTOMER_OPTION_ID, CUSTOMER_OPTION_VALUE_ID);
create index CUST_OPT_VAL_CODE_IDX on CUSTOMER_OPTION_VALUE (CUSTOMER_OPT_VAL_CODE);

    alter table CUSTOMER_OPTION_VALUE 
       add constraint UKcb1fmv71nrx7m1rlx1ff5qvdt unique (MERCHANT_ID, CUSTOMER_OPT_VAL_CODE);

    alter table CUSTOMER_REVIEW 
       add constraint UK2momthbfrtgico2yyod8w18pk unique (CUSTOMERS_ID, REVIEWED_CUSTOMER_ID);

    alter table CUSTOMER_REVIEW_DESCRIPTION 
       add constraint UK1va9q0nhoe3wli25ktpmouvyh unique (CUSTOMER_REVIEW_ID, LANGUAGE_ID);

    alter table FILE_HISTORY 
       add constraint UKav35sb3v4nxq8v1n1rkxufir unique (MERCHANT_ID, FILE_ID);

    alter table GEOZONE_DESCRIPTION 
       add constraint UKsoq8o99w3c8ys3ntamt5i4mat unique (GEOZONE_ID, LANGUAGE_ID);
create index CODE_IDX2 on LANGUAGE (CODE);

    alter table MANUFACTURER 
       add constraint UK6brqfdkga7jc78n8dh3v595y3 unique (MERCHANT_ID, CODE);

    alter table MANUFACTURER_DESCRIPTION 
       add constraint UKlpv09p83sc887clxe04nroup6 unique (MANUFACTURER_ID, LANGUAGE_ID);

    alter table MERCHANT_CONFIGURATION 
       add constraint UKj0c3h8onw3m6hjcr3yylst9fb unique (MERCHANT_ID, CONFIG_KEY);
create index IDXrkmg1f192v53wcxln88wrwgrx on MERCHANT_STORE (LINEAGE);

    alter table MERCHANT_STORE 
       add constraint UK_4pvtsnqv4nlao8725n9ldpguf unique (STORE_CODE);
create index MODULE_CONFIGURATION_MODULE on MODULE_CONFIGURATION (MODULE);

    alter table OPTIN 
       add constraint UKmanlx6siq6ddf14cud40k8gw6 unique (MERCHANT_ID, CODE);

    alter table PERMISSION 
       add constraint UK_ss26hgwetkj8ms5y5jn2co4j3 unique (PERMISSION_NAME);

    alter table PRODUCT 
       add constraint UKs8ofsn9pehdrstjg52j5qabxh unique (MERCHANT_ID, SKU);
create index IDX6h8m6ocg2jhu3bfieqa0dupb1 on PRODUCT_ATTRIBUTE (PRODUCT_ID);

    alter table PRODUCT_ATTRIBUTE 
       add constraint UKo0c6cfxcfejwfa2877gfgpuco unique (OPTION_ID, OPTION_VALUE_ID, PRODUCT_ID);
create index PRD_AVAIL_STORE_PRD_IDX on PRODUCT_AVAILABILITY (PRODUCT_ID, MERCHANT_ID);
create index PRD_AVAIL_PRD_IDX on PRODUCT_AVAILABILITY (PRODUCT_ID);

    alter table PRODUCT_AVAILABILITY 
       add constraint UK75h2ri3r4y4b5n6q8v4dmjgbk unique (MERCHANT_ID, PRODUCT_ID, PRODUCT_VARIANT, REGION_VARIANT);
create index PRODUCT_DESCRIPTION_SEF_URL on PRODUCT_DESCRIPTION (SEF_URL);

    alter table PRODUCT_DESCRIPTION 
       add constraint UKq4dnkx5b776ayqas2h4rr2d8q unique (PRODUCT_ID, LANGUAGE_ID);

    alter table PRODUCT_DIGITAL 
       add constraint UKjuk1qgkh9v5w7ghvb18krwo8v unique (PRODUCT_ID, FILE_NAME);

    alter table PRODUCT_IMAGE_DESCRIPTION 
       add constraint UKn7yhdj6ccydgf201gibb882cd unique (PRODUCT_IMAGE_ID, LANGUAGE_ID);
create index PRD_OPTION_CODE_IDX on PRODUCT_OPTION (PRODUCT_OPTION_CODE);

    alter table PRODUCT_OPTION 
       add constraint UKhfcw5oi9ulljlog1b7ns1r9tu unique (MERCHANT_ID, PRODUCT_OPTION_CODE);

    alter table PRODUCT_OPTION_DESC 
       add constraint UKmkcm8isyyyqbjd1yyb8mrpkuw unique (PRODUCT_OPTION_ID, LANGUAGE_ID);

    alter table PRODUCT_OPTION_SET 
       add constraint UKk1qq8j685uj17bylgnkra1n5f unique (MERCHANT_ID, PRODUCT_OPTION_SET_CODE);
create index PRD_OPTION_VAL_CODE_IDX on PRODUCT_OPTION_VALUE (PRODUCT_OPTION_VAL_CODE);

    alter table PRODUCT_OPTION_VALUE 
       add constraint UKixbpi4hxrhljh935c3xfvnvsh unique (MERCHANT_ID, PRODUCT_OPTION_VAL_CODE);

    alter table PRODUCT_OPTION_VALUE_DESCRIPTION 
       add constraint UKasgc60ot1wy0uho96n0j8429p unique (PRODUCT_OPTION_VALUE_ID, LANGUAGE_ID);

    alter table PRODUCT_PRICE_DESCRIPTION 
       add constraint UKfrsw8d41sxxogvxxoyd8nwaxu unique (PRODUCT_PRICE_ID, LANGUAGE_ID);

    alter table PRODUCT_REVIEW 
       add constraint UK9ew5idgdbk8a77534hbnhd4yb unique (CUSTOMERS_ID, PRODUCT_ID);

    alter table PRODUCT_REVIEW_DESCRIPTION 
       add constraint UKqno5wjdtcj8pm3ykkkh7t4rxj unique (PRODUCT_REVIEW_ID, LANGUAGE_ID);

    alter table PRODUCT_TYPE_DESCRIPTION 
       add constraint UKbnra4lwqjkju4yh04824sw6be unique (PRODUCT_TYPE_ID, LANGUAGE_ID);

    alter table PRODUCT_VAR_IMAGE_DESCRIPTION 
       add constraint UKimi0kpikvll5gf63n36x3yrwt unique (PRODUCT_VAR_IMAGE_ID, LANGUAGE_ID);
create index IDX9ngqm1gg8oivkujmhee4wt0ox on PRODUCT_VARIANT (PRODUCT_ID);

    alter table PRODUCT_VARIANT 
       add constraint UKlhuo20v01wa867oa7bjqagv72 unique (PRODUCT_ID, SKU);

    alter table PRODUCT_VARIATION 
       add constraint UKi8sa74fv4io0sigmgvqxypp0d unique (MERCHANT_ID, PRODUCT_OPTION_ID, OPTION_VALUE_ID);
create index SHP_CART_CODE_IDX on SHOPPING_CART (SHP_CART_CODE);
create index SHP_CART_CUSTOMER_IDX on SHOPPING_CART (CUSTOMER_ID);

    alter table SHOPPING_CART 
       add constraint UK_8ld8p40fwrjobi7t3n95pna35 unique (SHP_CART_CODE);
create index SM_GROUP_GROUP_TYPE on SM_GROUP (GROUP_TYPE);

    alter table SM_GROUP 
       add constraint UK_t83rjsoml3o785oj37lpqpyko unique (GROUP_NAME);

    alter table SYSTEM_NOTIFICATION 
       add constraint UKnpdnlc390vgr2mhepib1mtrmr unique (MERCHANT_ID, CONFIG_KEY);
create index TAX_CLASS_CODE_IDX on TAX_CLASS (TAX_CLASS_CODE);

    alter table TAX_CLASS 
       add constraint UKa4q5q57a8oeh2ojeo8dhr935k unique (MERCHANT_ID, TAX_CLASS_CODE);

    alter table TAX_RATE 
       add constraint UK8gh6l9n0xq03b91sglp62oelu unique (TAX_CODE, MERCHANT_ID);

    alter table TAX_RATE_DESCRIPTION 
       add constraint UKt3xg8pl88yacdxg49nb46effg unique (TAX_RATE_ID, LANGUAGE_ID);
create index USR_NAME_IDX on USERS (ADMIN_NAME);

    alter table USERS 
       add constraint UK7cwrowcnjlfxpxpdd1op9ymab unique (MERCHANT_ID, ADMIN_NAME);

    alter table ZONE 
       add constraint UK_4tq3p5w8k4h4easyf5t3n1jdr unique (ZONE_CODE);

    alter table ZONE_DESCRIPTION 
       add constraint UKm64laxgrv9fxm6io232ap4su9 unique (ZONE_ID, LANGUAGE_ID);

    alter table CATALOG 
       add constraint FKranq0rweb0r6j31j565ak51g8 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table CATALOG_ENTRY 
       add constraint FKqp2j48hb3vodovb8gn2o4gox 
       foreign key (CATALOG_ID) 
       references CATALOG;

    alter table CATALOG_ENTRY 
       add constraint FK374wks7em54d0oghju0earttl 
       foreign key (CATEGORY_ID) 
       references CATEGORY;

    alter table CATEGORY 
       add constraint FK8a09asq5fcx0a88i4m8nsixy 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table CATEGORY 
       add constraint FKn3kekntr7pm8g9v8ask698ato 
       foreign key (PARENT_ID) 
       references CATEGORY;

    alter table CATEGORY_DESCRIPTION 
       add constraint FKl4j5boteutpu1p8f67kydpnmd 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table CATEGORY_DESCRIPTION 
       add constraint FKa58u7d0ydfgref1iaux5efyov 
       foreign key (CATEGORY_ID) 
       references CATEGORY;

    alter table CONTENT 
       add constraint FKfmoi0fkjbtfty3o8fs94t11r1 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table CONTENT_DESCRIPTION 
       add constraint FK47yxf681u0rfw2kvarhqb0r3v 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table CONTENT_DESCRIPTION 
       add constraint FKk7fabfxn2flvcofwwpyg5sys 
       foreign key (CONTENT_ID) 
       references CONTENT;

    alter table COUNTRY 
       add constraint FKd2q9e14kh1j6tm1gpbct2xwws 
       foreign key (GEOZONE_ID) 
       references GEOZONE;

    alter table COUNTRY_DESCRIPTION 
       add constraint FKersrbjot9p9nfukxfd2l27c7t 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table COUNTRY_DESCRIPTION 
       add constraint FKkd2sy7q97wr2ahvyiiqc4txji 
       foreign key (COUNTRY_ID) 
       references COUNTRY;

    alter table CUSTOMER 
       add constraint FK5pas8t9mknk4kkin55t4v300l 
       foreign key (BILLING_COUNTRY_ID) 
       references COUNTRY;

    alter table CUSTOMER 
       add constraint FKp0xcpa3i2mgdr0kq43xiibx40 
       foreign key (BILLING_ZONE_ID) 
       references ZONE;

    alter table CUSTOMER 
       add constraint FKdgjqmj04qt89gmfloo4ofojcw 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table CUSTOMER 
       add constraint FKbxyooiceli2ko29bupdye6jgn 
       foreign key (DELIVERY_COUNTRY_ID) 
       references COUNTRY;

    alter table CUSTOMER 
       add constraint FK3k21jw28bbx043c2mnhevg9w4 
       foreign key (DELIVERY_ZONE_ID) 
       references ZONE;

    alter table CUSTOMER 
       add constraint FK8122nrpakxu3umk1od4v0xxoa 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table CUSTOMER_ATTRIBUTE 
       add constraint FKc3318o13i2bpxkci1bh52we5a 
       foreign key (CUSTOMER_ID) 
       references CUSTOMER;

    alter table CUSTOMER_ATTRIBUTE 
       add constraint FK4xugs9yd9w4o3sw11fisb8tj5 
       foreign key (OPTION_ID) 
       references CUSTOMER_OPTION;

    alter table CUSTOMER_ATTRIBUTE 
       add constraint FK9fl7iexvdeeeoch9fh35o5vw4 
       foreign key (OPTION_VALUE_ID) 
       references CUSTOMER_OPTION_VALUE;

    alter table CUSTOMER_GROUP 
       add constraint FKgrr5v89l1m9sl2qol62bbctq4 
       foreign key (GROUP_ID) 
       references SM_GROUP;

    alter table CUSTOMER_GROUP 
       add constraint FK257h3e27f4ujw08doqtq46hho 
       foreign key (CUSTOMER_ID) 
       references CUSTOMER;

    alter table CUSTOMER_OPT_VAL_DESCRIPTION 
       add constraint FK6rfssi3qfx4pswicxrfb18c1 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table CUSTOMER_OPT_VAL_DESCRIPTION 
       add constraint FKhwrs6fyqk6vh11yvcflu42yef 
       foreign key (CUSTOMER_OPT_VAL_ID) 
       references CUSTOMER_OPTION_VALUE;

    alter table CUSTOMER_OPTIN 
       add constraint FKk5v94dvhsgibaw89hv4m8o5yw 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table CUSTOMER_OPTIN 
       add constraint FK7qym878m07cwvs4foe68lvqjt 
       foreign key (OPTIN_ID) 
       references OPTIN;

    alter table CUSTOMER_OPTION 
       add constraint FKcmqnh0rn2hukdfowean5tdy8k 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table CUSTOMER_OPTION_DESC 
       add constraint FKm4iu7v9db17wk2a03xqbqdlfa 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table CUSTOMER_OPTION_DESC 
       add constraint FKc2yiucjbw0wjha8ww7a01qfeo 
       foreign key (CUSTOMER_OPTION_ID) 
       references CUSTOMER_OPTION;

    alter table CUSTOMER_OPTION_SET 
       add constraint FK1y5qtsuabhpwft3dyhqrgmtb4 
       foreign key (CUSTOMER_OPTION_ID) 
       references CUSTOMER_OPTION;

    alter table CUSTOMER_OPTION_SET 
       add constraint FKj9vnvyh6hhhftjbcsymgiodm9 
       foreign key (CUSTOMER_OPTION_VALUE_ID) 
       references CUSTOMER_OPTION_VALUE;

    alter table CUSTOMER_OPTION_VALUE 
       add constraint FKho87ssg5rnvwauj3y690a96g6 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table CUSTOMER_REVIEW 
       add constraint FKayt6tbxp7d4g1qyg8crw2n73p 
       foreign key (CUSTOMERS_ID) 
       references CUSTOMER;

    alter table CUSTOMER_REVIEW 
       add constraint FK7pmqdk9od2af7cl6alx82fkek 
       foreign key (REVIEWED_CUSTOMER_ID) 
       references CUSTOMER;

    alter table CUSTOMER_REVIEW_DESCRIPTION 
       add constraint FK5pkgrlk32uqaxkrbve5mws1hj 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table CUSTOMER_REVIEW_DESCRIPTION 
       add constraint FKhf88oagf6t62k28afn8uaijc7 
       foreign key (CUSTOMER_REVIEW_ID) 
       references CUSTOMER_REVIEW;

    alter table FILE_HISTORY 
       add constraint FK2k8h4penkjlbtc23vamwyek2g 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table GEOZONE_DESCRIPTION 
       add constraint FK1t2hp628edebe5d6co2whbla9 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table GEOZONE_DESCRIPTION 
       add constraint FKn82te2yb2st4hk2qlhl8ileb9 
       foreign key (GEOZONE_ID) 
       references GEOZONE;

    alter table MANUFACTURER 
       add constraint FKhswph4nthrqwffjekccudsrt2 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table MANUFACTURER_DESCRIPTION 
       add constraint FK20t33wr4tp1kt1uyw7s8a3afl 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table MANUFACTURER_DESCRIPTION 
       add constraint FKre4iys57n5cfbgpg3qqgewtrh 
       foreign key (MANUFACTURER_ID) 
       references MANUFACTURER;

    alter table MERCHANT_CONFIGURATION 
       add constraint FKf9bkgf0ysbp5fo9j69shm0pri 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table MERCHANT_LANGUAGE 
       add constraint FKjwy0pjijh1qmcoivq50o2jgec 
       foreign key (languages_LANGUAGE_ID) 
       references LANGUAGE;

    alter table MERCHANT_LANGUAGE 
       add constraint FKiisj0tmoujv6n3iqmytvo39kn 
       foreign key (stores_MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table MERCHANT_LOG 
       add constraint FKto727b9r68qrtn2vvdqdvd4ic 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table MERCHANT_STORE 
       add constraint FK2gn7vpkd9x832urw7c6jlawnn 
       foreign key (COUNTRY_ID) 
       references COUNTRY;

    alter table MERCHANT_STORE 
       add constraint FK63hlw9wp1k1x3f5tke7t2us7s 
       foreign key (CURRENCY_ID) 
       references CURRENCY;

    alter table MERCHANT_STORE 
       add constraint FKdnemo9tl8tjhkxko83psvkv19 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table MERCHANT_STORE 
       add constraint FKgkoele515h76u39b9defibkm9 
       foreign key (PARENT_ID) 
       references MERCHANT_STORE;

    alter table MERCHANT_STORE 
       add constraint FK5o24aky9161jyofyxmg0g53vv 
       foreign key (ZONE_ID) 
       references ZONE;

    alter table OPTIN 
       add constraint FK37xvfo4the20avv7f1e1771fh 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table ORDER_ACCOUNT 
       add constraint FKi6l5isodh81m5hy8ua06hx73n 
       foreign key (ORDER_ID) 
       references ORDERS;

    alter table ORDER_ACCOUNT_PRODUCT 
       add constraint FK7oxc8ygov7vd2ajt185jhiwts 
       foreign key (ORDER_ACCOUNT_ID) 
       references ORDER_ACCOUNT;

    alter table ORDER_ACCOUNT_PRODUCT 
       add constraint FK5kiyyb8ekqi9bfowytww8atcx 
       foreign key (ORDER_PRODUCT_ID) 
       references ORDER_PRODUCT;

    alter table ORDER_ATTRIBUTE 
       add constraint FK4nw5yrtgb4in6leve76bmdnua 
       foreign key (ORDER_ID) 
       references ORDERS;

    alter table ORDER_PRODUCT 
       add constraint FKf0sghmn59s14cxrjtrvkvi5yk 
       foreign key (ORDER_ID) 
       references ORDERS;

    alter table ORDER_PRODUCT_ATTRIBUTE 
       add constraint FK7j86rvwaysbok1nuofrnmhmkx 
       foreign key (ORDER_PRODUCT_ID) 
       references ORDER_PRODUCT;

    alter table ORDER_PRODUCT_DOWNLOAD 
       add constraint FKstrda0eweharld63j8pxa2o2r 
       foreign key (ORDER_PRODUCT_ID) 
       references ORDER_PRODUCT;

    alter table ORDER_PRODUCT_PRICE 
       add constraint FKnkukiqxrieonyulercgnh857s 
       foreign key (ORDER_PRODUCT_ID) 
       references ORDER_PRODUCT;

    alter table ORDER_STATUS_HISTORY 
       add constraint FKmhghgf1xy3o0npsp8xkj6wyvq 
       foreign key (ORDER_ID) 
       references ORDERS;

    alter table ORDER_TOTAL 
       add constraint FK1tfvgk5smm80efdcc8uop4he3 
       foreign key (ORDER_ID) 
       references ORDERS;

    alter table ORDERS 
       add constraint FKipesu5tupnriahutgle6xu9ed 
       foreign key (BILLING_COUNTRY_ID) 
       references COUNTRY;

    alter table ORDERS 
       add constraint FKit6ti99mv5uvuxqskhurv3y59 
       foreign key (BILLING_ZONE_ID) 
       references ZONE;

    alter table ORDERS 
       add constraint FKfusivmw6q3gjxnmp47n9s74qi 
       foreign key (CURRENCY_ID) 
       references CURRENCY;

    alter table ORDERS 
       add constraint FKnlx97vjyorunxglhy5bird06c 
       foreign key (DELIVERY_COUNTRY_ID) 
       references COUNTRY;

    alter table ORDERS 
       add constraint FKn9uvjl8105fsly4doo8rqnv5b 
       foreign key (DELIVERY_ZONE_ID) 
       references ZONE;

    alter table ORDERS 
       add constraint FKaodv5ffayq8x50q311o2y8m1 
       foreign key (MERCHANTID) 
       references MERCHANT_STORE;

    alter table PERMISSION_GROUP 
       add constraint FK77ly3khyuu40odly02d351s84 
       foreign key (PERMISSION_ID) 
       references PERMISSION;

    alter table PERMISSION_GROUP 
       add constraint FKr7ylutdgqp1nrlbhjwit6y17g 
       foreign key (GROUP_ID) 
       references SM_GROUP;

    alter table PRODUCT 
       add constraint FKra5mmrdxn3ci86hod7q1u3vu9 
       foreign key (MANUFACTURER_ID) 
       references MANUFACTURER;

    alter table PRODUCT 
       add constraint FKhhoq1nd9e0i4m7rt8gkh7d67h 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table PRODUCT 
       add constraint FKqtt5f0aht5h7ough5rbkkcb33 
       foreign key (CUSTOMER_ID) 
       references CUSTOMER;

    alter table PRODUCT 
       add constraint FKb8oqtc3j8sqo0t8xdrne7pg69 
       foreign key (TAX_CLASS_ID) 
       references TAX_CLASS;

    alter table PRODUCT 
       add constraint FKeiirvj8eu40h103fth8es1mt0 
       foreign key (PRODUCT_TYPE_ID) 
       references PRODUCT_TYPE;

    alter table PRODUCT_ATTRIBUTE 
       add constraint FKml3nvemdjya159a7669qt1gjd 
       foreign key (PRODUCT_ID) 
       references PRODUCT;

    alter table PRODUCT_ATTRIBUTE 
       add constraint FK2st60u9twmvvaowwn88mt3lrx 
       foreign key (OPTION_ID) 
       references PRODUCT_OPTION;

    alter table PRODUCT_ATTRIBUTE 
       add constraint FK3rleultg9fn2dxruefbb18d5t 
       foreign key (OPTION_VALUE_ID) 
       references PRODUCT_OPTION_VALUE;

    alter table PRODUCT_AVAILABILITY 
       add constraint FKmjs1xqdsgji88j5uduj83bntl 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table PRODUCT_AVAILABILITY 
       add constraint FK5sbh4dx25pmjcqx958hr9ys8h 
       foreign key (PRODUCT_ID) 
       references PRODUCT;

    alter table PRODUCT_AVAILABILITY 
       add constraint FKm9cb3uvgql005wcsqi906pjhg 
       foreign key (PRODUCT_VARIANT) 
       references PRODUCT_VARIANT;

    alter table PRODUCT_CATEGORY 
       add constraint FK3xw1sbaa29r534jvedimdd7md 
       foreign key (CATEGORY_ID) 
       references CATEGORY;

    alter table PRODUCT_CATEGORY 
       add constraint FKa7245ly271mb0crlhxwhhppsq 
       foreign key (PRODUCT_ID) 
       references PRODUCT;

    alter table PRODUCT_DESCRIPTION 
       add constraint FK6esjdaa6vu2t5vjin788a8og6 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table PRODUCT_DESCRIPTION 
       add constraint FKm46yjcu59q79qrokgglwq2ove 
       foreign key (PRODUCT_ID) 
       references PRODUCT;

    alter table PRODUCT_DIGITAL 
       add constraint FK47fmb5cg68pws7k26txyl1il6 
       foreign key (PRODUCT_ID) 
       references PRODUCT;

    alter table PRODUCT_IMAGE 
       add constraint FKgab836d8rxqg8vv55nm02r65i 
       foreign key (PRODUCT_ID) 
       references PRODUCT;

    alter table PRODUCT_IMAGE_DESCRIPTION 
       add constraint FKlhdnpki4sf98wev0pcj2bvnih 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table PRODUCT_IMAGE_DESCRIPTION 
       add constraint FK1dhldo18nj9l2y6qympgucynq 
       foreign key (PRODUCT_IMAGE_ID) 
       references PRODUCT_IMAGE;

    alter table PRODUCT_OPT_SET_OPT_VALUE 
       add constraint FK9dwatblxwc64a5la3bb7qnwd8 
       foreign key (values_PRODUCT_OPTION_VALUE_ID) 
       references PRODUCT_OPTION_VALUE;

    alter table PRODUCT_OPT_SET_OPT_VALUE 
       add constraint FK3u6iyag8x8w9tkt7sqcoibjq6 
       foreign key (ProductOptionSet_PRODUCT_OPTION_SET_ID) 
       references PRODUCT_OPTION_SET;

    alter table PRODUCT_OPT_SET_PRD_TYPE 
       add constraint FKiem30u1enm0p25i7t53jganf4 
       foreign key (productTypes_PRODUCT_TYPE_ID) 
       references PRODUCT_TYPE;

    alter table PRODUCT_OPT_SET_PRD_TYPE 
       add constraint FK4655h91s0eiinonako9n4h9ha 
       foreign key (ProductOptionSet_PRODUCT_OPTION_SET_ID) 
       references PRODUCT_OPTION_SET;

    alter table PRODUCT_OPTION 
       add constraint FKp8cski5t5f5m4et4fw0uilcgu 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table PRODUCT_OPTION_DESC 
       add constraint FK8fiwk5o1gbn2r2u8529yaf9xt 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table PRODUCT_OPTION_DESC 
       add constraint FKgjqmfofile4hwv867irsnvuc0 
       foreign key (PRODUCT_OPTION_ID) 
       references PRODUCT_OPTION;

    alter table PRODUCT_OPTION_SET 
       add constraint FK4njy17416fn86muojmtbav1d0 
       foreign key (PRODUCT_OPTION_ID) 
       references PRODUCT_OPTION;

    alter table PRODUCT_OPTION_SET 
       add constraint FK8d5vylmhvmckmframdehgwqau 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table PRODUCT_OPTION_VALUE 
       add constraint FKnd3nw0mamlk8bkxo8ad5m85pq 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table PRODUCT_OPTION_VALUE_DESCRIPTION 
       add constraint FK19mnby7atlt85exlypxdxhacx 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table PRODUCT_OPTION_VALUE_DESCRIPTION 
       add constraint FKqttc6b79yp2s1hyrhg4thag6s 
       foreign key (PRODUCT_OPTION_VALUE_ID) 
       references PRODUCT_OPTION_VALUE;

    alter table PRODUCT_PRICE 
       add constraint FK1dic7jnnk1qikgvwcrf4dw12r 
       foreign key (PRODUCT_AVAIL_ID) 
       references PRODUCT_AVAILABILITY;

    alter table PRODUCT_PRICE_DESCRIPTION 
       add constraint FK7bmbrjr8ar5icwdpt8myj6gei 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table PRODUCT_PRICE_DESCRIPTION 
       add constraint FKbwxw861ipjsct606j3dagdjsf 
       foreign key (PRODUCT_PRICE_ID) 
       references PRODUCT_PRICE;

    alter table PRODUCT_RELATIONSHIP 
       add constraint FKso3cvinykac5wdwu1tjgfotor 
       foreign key (PRODUCT_ID) 
       references PRODUCT;

    alter table PRODUCT_RELATIONSHIP 
       add constraint FKfskwtawyt85g9h6761fa69ya5 
       foreign key (RELATED_PRODUCT_ID) 
       references PRODUCT;

    alter table PRODUCT_RELATIONSHIP 
       add constraint FKnprvswtbgrm6bjfq3cbdl3qsm 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table PRODUCT_REVIEW 
       add constraint FK7tm0jrt0hiugo3ep49t3subou 
       foreign key (CUSTOMERS_ID) 
       references CUSTOMER;

    alter table PRODUCT_REVIEW 
       add constraint FKbfi8de7kxultg1vevq6jc1hn7 
       foreign key (PRODUCT_ID) 
       references PRODUCT;

    alter table PRODUCT_REVIEW_DESCRIPTION 
       add constraint FK7byc5jsf5bm4lk674ac44e50m 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table PRODUCT_REVIEW_DESCRIPTION 
       add constraint FKmjivhigdcxmytndlpjuhf4o25 
       foreign key (PRODUCT_REVIEW_ID) 
       references PRODUCT_REVIEW;

    alter table PRODUCT_TYPE 
       add constraint FKswkvtaq4om2di6x8cd4m22ofn 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table PRODUCT_TYPE_DESCRIPTION 
       add constraint FK81q74whco5y9fd51aa330hlc0 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table PRODUCT_TYPE_DESCRIPTION 
       add constraint FKpwc89ulk7c9asbp2nfy2t4x2j 
       foreign key (PRODUCT_TYPE_ID) 
       references PRODUCT_TYPE;

    alter table PRODUCT_VAR_IMAGE 
       add constraint FKa691h70ypyp8liquow7qrg81h 
       foreign key (PRODUCT_VARIANT_GROUP_ID) 
       references PRODUCT_VARIANT_GROUP;

    alter table PRODUCT_VAR_IMAGE_DESCRIPTION 
       add constraint FKinpkcxbxyg8yni5ftcvjlt1sp 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table PRODUCT_VAR_IMAGE_DESCRIPTION 
       add constraint FKibpkivbdn6wqe92gb40l5hffl 
       foreign key (PRODUCT_ID) 
       references PRODUCT;

    alter table PRODUCT_VAR_IMAGE_DESCRIPTION 
       add constraint FKo6dx44u06sx0mlvq15oy2wlnj 
       foreign key (PRODUCT_VAR_IMAGE_ID) 
       references PRODUCT_VAR_IMAGE;

    alter table PRODUCT_VARIANT 
       add constraint FK88qb5xufd31481gt7epc8scau 
       foreign key (PRODUCT_ID) 
       references PRODUCT;

    alter table PRODUCT_VARIANT 
       add constraint FKs1gvb7qb19cuowmhrhuwo7lcv 
       foreign key (PRODUCT_VARIANT_GROUP_ID) 
       references PRODUCT_VARIANT_GROUP;

    alter table PRODUCT_VARIANT 
       add constraint FK8nqskhly5tfk07g0padic9am9 
       foreign key (PRODUCT_VARIATION_ID) 
       references PRODUCT_VARIATION;

    alter table PRODUCT_VARIANT 
       add constraint FKsa5ijtdrt6dge0op121ox56a0 
       foreign key (PRODUCT_VARIATION_VALUE_ID) 
       references PRODUCT_VARIATION;

    alter table PRODUCT_VARIANT_GROUP 
       add constraint FKqkn1or09hw4s03b8n1kdwhcsr 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table PRODUCT_VARIATION 
       add constraint FKqlm3c2178neue84l5kx51ovoq 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table PRODUCT_VARIATION 
       add constraint FK5jr2rc6t2p27nwdo5eqwa7658 
       foreign key (PRODUCT_OPTION_ID) 
       references PRODUCT_OPTION;

    alter table PRODUCT_VARIATION 
       add constraint FKy6gamyvrpds502pdcqq4voyg 
       foreign key (OPTION_VALUE_ID) 
       references PRODUCT_OPTION_VALUE;

    alter table SHIPING_ORIGIN 
       add constraint FKpqig59usqvs9h0dw4lm8rv7yy 
       foreign key (COUNTRY_ID) 
       references COUNTRY;

    alter table SHIPING_ORIGIN 
       add constraint FKp0dbwsv3sdsp57ex7j5k9b0oq 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table SHIPING_ORIGIN 
       add constraint FK6k73f1n18kr7mqp708aiwq047 
       foreign key (ZONE_ID) 
       references ZONE;

    alter table SHIPPING_QUOTE 
       add constraint FK9vb7tbjl8ivygdiqw883fewx7 
       foreign key (DELIVERY_COUNTRY_ID) 
       references COUNTRY;

    alter table SHIPPING_QUOTE 
       add constraint FKiioesp0vl6x4om1jeajj4uy1t 
       foreign key (DELIVERY_ZONE_ID) 
       references ZONE;

    alter table SHOPPING_CART 
       add constraint FKqvghr5rmjefe3lw9mcolk30a0 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table SHOPPING_CART_ATTR_ITEM 
       add constraint FKp42tpa623hyo9ww69v0ohb3er 
       foreign key (SHP_CART_ITEM_ID) 
       references SHOPPING_CART_ITEM;

    alter table SHOPPING_CART_ITEM 
       add constraint FK2gbimdwe9uysd5xadnfl0xq83 
       foreign key (SHP_CART_ID) 
       references SHOPPING_CART;

    alter table SM_TRANSACTION 
       add constraint FK7j0s1gqh2tue1fyh5nyj5kwkp 
       foreign key (ORDER_ID) 
       references ORDERS;

    alter table SYSTEM_NOTIFICATION 
       add constraint FKs6qk7l06e0s6m9n04momedgt7 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table SYSTEM_NOTIFICATION 
       add constraint FK3dykr9pm9ln1uektuw18blb6m 
       foreign key (USER_ID) 
       references USERS;

    alter table TAX_CLASS 
       add constraint FK82i8puujghcv7fc82qwsgjg8w 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table TAX_RATE 
       add constraint FK6wm34jcwoembe1qsmle2wtwnv 
       foreign key (COUNTRY_ID) 
       references COUNTRY;

    alter table TAX_RATE 
       add constraint FKfwp6yka2qps9jna473e6c6yc1 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table TAX_RATE 
       add constraint FKt8isen27i3ioa0tw3bl8qlvdh 
       foreign key (PARENT_ID) 
       references TAX_RATE;

    alter table TAX_RATE 
       add constraint FK7bpa9pbl1gnj5y3xbgs3wc0eg 
       foreign key (TAX_CLASS_ID) 
       references TAX_CLASS;

    alter table TAX_RATE 
       add constraint FKm9snpf6o1nb4j1t80nas8d1ix 
       foreign key (ZONE_ID) 
       references ZONE;

    alter table TAX_RATE_DESCRIPTION 
       add constraint FKsicb2ydx42o04pvlnxw2mlx0w 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table TAX_RATE_DESCRIPTION 
       add constraint FK65c2lqslk5kx25dpkem2r0vxq 
       foreign key (TAX_RATE_ID) 
       references TAX_RATE;

    alter table USER_GROUP 
       add constraint FK75kainrhn4kh8j3sw2xbe7v61 
       foreign key (GROUP_ID) 
       references SM_GROUP;

    alter table USER_GROUP 
       add constraint FK9op4wv63nonsby8y9myjhtho 
       foreign key (USER_ID) 
       references USERS;

    alter table USERS 
       add constraint FK4yb3ho4yxvcjniqg09opbm7ja 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table USERS 
       add constraint FKtpio656e5t0cja7kx7p79rkh6 
       foreign key (MERCHANT_ID) 
       references MERCHANT_STORE;

    alter table ZONE 
       add constraint FKhn2c1w3e1twhjg7tiwv7vuk67 
       foreign key (COUNTRY_ID) 
       references COUNTRY;

    alter table ZONE_DESCRIPTION 
       add constraint FK69ybu7r3bgpcq65c77ji1udh3 
       foreign key (LANGUAGE_ID) 
       references LANGUAGE;

    alter table ZONE_DESCRIPTION 
       add constraint FKpv4elin6w3b03756obqvk447f 
       foreign key (ZONE_ID) 
       references ZONE;
