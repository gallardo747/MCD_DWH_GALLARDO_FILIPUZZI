-- DDL TP FINAL DWH MCD 2025
------------------------------------------------------------------------------------
-- STEP 1: Creación de Schemas
CREATE SCHEMA DWH AUTHORIZATION dbo; 
CREATE SCHEMA STG AUTHORIZATION dbo; 
CREATE SCHEMA TMP AUTHORIZATION dbo; 
CREATE SCHEMA LOG AUTHORIZATION dbo; 
------------------------------------------------------------------------------------
-- STEP 2: Creación de Tablas de Negocio
CREATE TABLE DWH.LK_REGIONS
(
	Region_Id int IDENTITY(1,1) PRIMARY KEY,
	Region_CD varchar (10) NOT NULL,
	Region_Description varchar(50) NOT NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTIVE_FLAG int NOT NULL
);



CREATE TABLE STG.LK_REGIONS
(
	Region_CD varchar (10) NOT NULL,
	Region_Description varchar(50) NOT NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTION varchar(50) NOT NULL
);


CREATE TABLE TMP.REGIONS
(
	Region_CD varchar (10) NULL,
	Region_Description varchar(50) NULL,
);



CREATE TABLE DWH.LK_TERRITORIES
(
	Territory_Id int IDENTITY(1,1) PRIMARY KEY,
	Territory_CD varchar (10) NOT NULL,
	Territory_Description varchar(50) NOT NULL,
	Territory_Region_Id int NOT NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTIVE_FLAG int NOT NULL,
	CONSTRAINT FK_Territory_Regions FOREIGN KEY(Territory_Region_Id) REFERENCES DWH.LK_REGIONS (Region_Id)
);

CREATE TABLE STG.LK_TERRITORIES
(
	Territory_CD varchar (10) NOT NULL,
	Territory_Description varchar(50) NOT NULL,
	Territory_Region_Id int NOT NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTION varchar(50) NOT NULL
);


CREATE TABLE TMP.TERRITORIES
(
	Territory_CD varchar (10) NULL,
	Territory_Description varchar(50) NULL,
	Region_CD varchar (10) NULL
);


CREATE TABLE DWH.LK_CATEGORIES
(
	Category_Id int IDENTITY(1,1) PRIMARY KEY,
	Category_CD varchar (10) NULL,
	Category_Name varchar(50) NULL,
	Category_Description varchar (200) NULL,
	Category_Pincture varchar (2000) NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTIVE_FLAG int NOT NULL
);

CREATE TABLE STG.LK_CATEGORIES
(
	Category_CD varchar (10) NULL,
	Category_Name varchar(50) NULL,
	Category_Description varchar (200) NULL,
	Category_Pincture varchar (2000) NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTION varchar(50) NOT NULL
);

 
CREATE TABLE TMP.CATEGORIES
(
	Category_CD varchar (10) NULL,
	Category_Name varchar(50) NULL,
	Category_Description varchar (200) NULL,
	Category_Picture varchar (2000) NULL,
);


CREATE TABLE DWH.LK_CATEGORIES
(
	Territory_Id int IDENTITY(1,1) PRIMARY KEY,
	Category_CD varchar (10) NULL,
	Category_Name varchar(50) NULL,
	Category_Description varchar (200) NULL,
	Category_Pincture varchar (2000) NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTIVE_FLAG int NOT NULL
);

CREATE TABLE STG.LK_CATEGORIES
(
	Category_CD varchar (10) NULL,
	Category_Name varchar(50) NULL,
	Category_Description varchar (200) NULL,
	Category_Pincture varchar (2000) NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTION varchar(50) NOT NULL
);


CREATE TABLE DWH.LK_SUPPLIERS
(
	Supp_Supplier_Id int IDENTITY(1,1) PRIMARY KEY,
	Supp_CD varchar (10) NULL,
	Supp_companyName varchar(50) NULL,
	Supp_contactName varchar (50) NULL,
	Supp_contactTitle varchar (50) NULL,
	Supp_address varchar(100) NULL,
	Supp_City varchar(100) NULL,
	Supp_Id_Region int NOT NULL,
	Supp_PostalCode varchar(20) NULL,
	Supp_Id_Country int NOT NULL,
	Supp_ID_DatoContacto int NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTIVE_FLAG int NOT NULL,
	CONSTRAINT FK_Suppliers_Country FOREIGN KEY(Supp_Id_Country) REFERENCES DWH.LK_COUNTRIES (Ctry_Country_Id),
	CONSTRAINT FK_Suppliers_Region FOREIGN KEY(Supp_Id_Region) REFERENCES DWH.LK_REGIONS (Region_Id),
	CONSTRAINT FK_Suppliers_DatoContacto FOREIGN KEY(Supp_ID_DatoContacto) REFERENCES DWH.LK_SUPPLIERS_DATOS_Contacto (DatC_Contacto_Id)

);


CREATE TABLE STG.LK_SUPPLIERS
(
	Supp_CD varchar (10) NULL,
	Supp_companyName varchar(50) NULL,
	Supp_contactName varchar (50) NULL,
	Supp_contactTitle varchar (50) NULL,
	Supp_address varchar(100) NULL,
	Supp_City varchar(100) NULL,
	Supp_Id_Region int NOT NULL,
	Supp_PostalCode varchar(20) NULL,
	Supp_Id_Country int NOT NULL,
	Supp_ID_DatoContacto int NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTION varchar(50) NOT NULL
);


CREATE TABLE DWH.LK_SUPPLIERS_DATOS_Contacto
(
	DatC_Contacto_Id int IDENTITY(1,1) PRIMARY KEY,
	Dat_SupplierId int NOT NULL,
	Dat_Phone varchar (50) NULL,
	Dat_Fax varchar (50) NULL,
	Dat_HomePage varchar (50) NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTIVE_FLAG int NOT NULL
	CONSTRAINT FK_DatosCOntacto FOREIGN KEY(Dat_SupplierId) REFERENCES DWH.LK_SUPPLIERS (Supp_Supplier_Id)
);

CREATE TABLE STG.LK_SUPPLIERS_DATOS_Contacto
(
	Dat_SupplierId int NOT NULL,
	Dat_Phone varchar (50) NULL,
	Dat_Fax varchar (50) NULL,
	Dat_HomePage varchar (50) NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTION varchar(50) NOT NULL
);


CREATE TABLE TMP.SUPPLIERS
(
	Supp_CD varchar (10) NULL,
	Supp_companyName varchar(50) NULL,
	Supp_contactName varchar (50) NULL,
	Supp_contactTitle varchar (50) NULL,
	Supp_address varchar(100) NULL,
	Supp_City varchar(100) NULL,
	Supp_Region varchar(100) NULL,
	Supp_PostalCode varchar(20) NULL,
	Supp_Country varchar(50) NULL,
	Supp_Phone varchar(50) NULL,
	Supp_Fax varchar(50) NULL,
	Supp_HomePage varchar(100) NULL
);

CREATE TABLE DWH.LK_REL_REGION_COUNTRIES
(
	RELRC_RegionCountry_Id int IDENTITY(1,1) PRIMARY KEY,
	RELRC_RegionId int NOT NULL,
	RELRC_CountryId int NOT NULL,
	CONSTRAINT FK_RegionsC_Region FOREIGN KEY(RELRC_RegionId) REFERENCES DWH.LK_REGIONS (Region_Id),
	CONSTRAINT FK_RegionsC_Countries FOREIGN KEY(RELRC_CountryId) REFERENCES DWH.LK_Countries (Ctry_Country_Id)
);

 
CREATE TABLE DWH.LK_COUNTRIES
(
	Ctry_Country_Id int IDENTITY(1,1) PRIMARY KEY,
	Ctry_Name varchar (10) NULL,
);
  
CREATE TABLE DWH.LK_CUSTOMER_DEMOGRAPHICS
(
	CusDem_Customer_Type_Id int IDENTITY(1,1) PRIMARY KEY,
	CusDem_Customer_Type varchar (10) NULL,
	CusDem_Customer_Description varchar (10) NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTIVE_FLAG int NOT NULL
);

CREATE TABLE STG.LK_CUSTOMER_DEMOGRAPHICS
(
	CusDem_Customer_Type varchar (10) NULL,
	CusDem_Customer_Description varchar (10) NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTION varchar(50) NOT NULL
);


CREATE TABLE TMP.CUSTOMER_DEMOGRAPHICS
(
	Customer_Type varchar (10) NULL,
	Customer_Description varchar(50) NULL
);

CREATE TABLE TMP.PRODUCTS
(
	product_CD varchar (10) NULL,
	product_name varchar(50) NULL,
	supplier_cd varchar(10) NULL,
	category_cd varchar(10) NULL,
	Quantity_per_unit varchar(10) NULL,
	unit_price varchar(10) NULL,
	units_in_stock varchar(10) NULL,
	units_on_order varchar(10) NULL,
	reorder_level varchar(10) NULL,
	discontinued varchar(10) NULL
);

CREATE TABLE STG.LK_PRODUCTS
(
	prod_product_CD varchar (10) NULL,
	prod_product_name varchar(50) NULL,
	prod_supplier_id int NOT NULL,
	prod_category_id int NOT NULL,
	prod_Quantity_per_unit DECIMAL(10,2) NULL,
	prod_unit_price DECIMAL(10,2) NULL,
	prod_units_in_stock DECIMAL(10,2) NULL,
	prod_units_on_order DECIMAL(10,2) NULL,
	prod_reorder_level int NULL,
	prod_discontinued bit NOT NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTION varchar(50) NOT NULL
);

CREATE TABLE DWH.LK_PRODUCTS
(
	prod_product_id int IDENTITY(1,1) PRIMARY KEY,
	prod_product_CD varchar (10) NULL,
	prod_product_name varchar(50) NULL,
	prod_supplier_id int NOT NULL,
	prod_category_id int NOT NULL,
	prod_Quantity_per_unit DECIMAL(10,2) NULL,
	prod_unit_price DECIMAL(10,2) NULL,
	prod_units_in_stock DECIMAL(10,2) NULL,
	prod_units_on_order DECIMAL(10,2) NULL,
	prod_reorder_level int NULL,
	prod_discontinued bit NOT NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTIVE_FLAG int NOT NULL,
	CONSTRAINT FK_Products_Categories FOREIGN KEY(prod_category_id) REFERENCES DWH.LK_CATEGORIES (Category_Id),
	CONSTRAINT FK_Products_Suppliers FOREIGN KEY(prod_supplier_id) REFERENCES DWH.LK_SUPPLIERS (Supp_Supplier_Id),
);


CREATE TABLE TMP.EMPLOYEES
(
	Employee_CD varchar (50) NULL,
	Last_name varchar(50) NULL,
	First_name varchar(50) NULL,
	title varchar(50) NULL,
	title_of_courtesy varchar(50) NULL,
	birth_date varchar(10) NULL,
	hire_date varchar(10) NULL,
	address varchar(100) NULL,
	city varchar(50) NULL,
	region_cd varchar(50) NULL,
	postal_Code varchar(50) NULL,
	home_phone varchar(50) NULL,
	extension varchar(10) NULL,
	photo varchar(400) NULL,
	notes varchar(1000) NULL,
	report_to varchar(50) NULL,
	photo_path varchar(50) NULL
);

CREATE TABLE STG.LK_EMPLOYEES
(
	Emp_Employee_CD varchar (50) NOT NULL,
	Emp_Last_name varchar(50) NOT NULL,
	Emp_First_name varchar(50) NOT NULL,
	Emp_title varchar(50) NULL,
	Emp_title_of_courtesy varchar(50) NULL,
	Emp_birth_date DATE NULL,
	Emp_hire_date DATE NULL,
	Emp_address varchar(100) NULL,
	Emp_city varchar(50) NULL,
	Emp_Region_id varchar(50) NULL,
	Emp_postal_Code varchar(50) NULL,
	Emp_home_phone varchar(50) NULL,
	Emp_extension varchar(10) NULL,
	Emp_photo varchar(400) NULL,
	Emp_notes varchar(1000) NULL,
	Emp_report_to_id int NOT NULL,
	Emp_photo_path varchar(50) NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTION varchar(50) NOT NULL
);


CREATE TABLE DWH.LK_EMPLOYEES
(
	Emp_Employee_id int IDENTITY(1,1) PRIMARY KEY,
	Emp_Employee_CD varchar (50) NOT NULL,
	Emp_Last_name varchar(50) NOT NULL,
	Emp_First_name varchar(50) NOT NULL,
	Emp_title varchar(50) NULL,
	Emp_title_of_courtesy varchar(50) NULL,
	Emp_birth_date DATE NULL,
	Emp_hire_date DATE NULL,
	Emp_address varchar(100) NULL,
	Emp_city varchar(50) NULL,
	Emp_Region_id int NULL,
	Emp_postal_Code varchar(50) NULL,
	Emp_home_phone varchar(50) NULL,
	Emp_extension varchar(10) NULL,
	Emp_photo varchar(400) NULL,
	Emp_notes varchar(1000) NULL,
	Emp_report_to_id int NOT NULL,
	Emp_photo_path varchar(50) NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTIVE_FLAG int NOT NULL,
	CONSTRAINT FK_Employee_Report FOREIGN KEY(Emp_Employee_id) REFERENCES DWH.LK_EMPLOYEES (Emp_Employee_id),
	CONSTRAINT FK_Employee_Regions FOREIGN KEY(Emp_Region_id) REFERENCES DWH.LK_REGIONS (Region_Id)
);


CREATE TABLE TMP.EMPLOYEES_TERRITORIES
(
	Employee_CD varchar (50) NULL,
	Territory_CD varchar(50) NULL
);

CREATE TABLE STG.LK_EMPLOYEES_TERRITORIES
(
	EmpTer_Employee_CD varchar (50) NULL,
	EmpTer_Territory_CD varchar(50) NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTION varchar(50) NOT NULL
);

CREATE TABLE DWH.LK_EMPLOYEES_TERRITORIES
(
	EmpTer_EmployeeTerritory_id int IDENTITY(1,1) PRIMARY KEY,
	EmpTer_Employee_id int NOT NULL,
	EmpTer_Territory_Id int NOT NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTIVE_FLAG int NOT NULL,
	CONSTRAINT FK_EmployeeEmp FOREIGN KEY(EmpTer_Employee_id) REFERENCES DWH.LK_EMPLOYEES (Emp_Employee_id),
	CONSTRAINT FK_Employee_Territory FOREIGN KEY(EmpTer_Territory_Id) REFERENCES DWH.LK_TERRITORIES (Territory_Id)
);

	
CREATE TABLE TMP.CUSTOMERS
(
	Customer_CD varchar (50) NULL,
	Company_Name varchar(50) NULL,
	Contact_Name varchar(50) NULL,
	Contact_Title varchar(50) NULL,
	address varchar(50) NULL,
	city varchar(50) NULL,
	Region varchar(50) NULL,
	POstal_Code varchar(50) NULL,
	Country varchar(50) NULL,
	Phone varchar(50) NULL,
	fax varchar(50) NULL
);

CREATE TABLE STG.LK_CUSTOMERS
(
	Cus_Customer_CD varchar (50) NOT NULL,
	Cus_Company_Name varchar(50) NOT NULL,
	Cus_Contact_Name varchar(50) NULL,
	Cus_Contact_Title varchar(50) NULL,
	Cus_address varchar(50) NULL,
	Cus_City varchar(50) NULL,
	Cus_Region_id int NOT NULL,
	Cus_Postal_Code varchar(50) NULL,
	Cus_Country_id int NOT NULL,
	Cus_Phone varchar(50) NULL,
	Cus_fax varchar(50) NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTION varchar(50) NOT NULL
);

CREATE TABLE DWH.LK_CUSTOMERS
(
	Cus_Customer_id int IDENTITY(1,1) PRIMARY KEY,
	Cus_Customer_CD varchar (50) NOT NULL,
	Cus_Company_Name varchar(50) NOT NULL,
	Cus_Contact_Name varchar(50) NULL,
	Cus_Contact_Title varchar(50) NULL,
	Cus_address varchar(50) NULL,
	Cus_City varchar(50) NULL,
	Cus_Region_id int NOT NULL,
	Cus_Postal_Code varchar(50) NULL,
	Cus_Country_id int NOT NULL,
	Cus_Phone varchar(50) NULL,
	Cus_fax varchar(50) NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTIVE_FLAG int NOT NULL,
	CONSTRAINT FK_Customer_Region FOREIGN KEY(Cus_Region_id) REFERENCES DWH.LK_REGIONS (Region_Id),
	CONSTRAINT FK_Customer_Country FOREIGN KEY(Cus_Country_id) REFERENCES DWH.LK_COUNTRIES (Ctry_Country_Id)
);


CREATE TABLE STG.LK_REL_CUSTOMERS_CUSDEMO
(
	CusCusDemo_Customer_id int NOT NULL,
	CusCusDemo_Customer_Type_id int NOT NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTION varchar(50) NOT NULL
);

CREATE TABLE DWH.LK_REL_CUSTOMERS_CUSDEMO
(
	CusCusDemo_Customer_CusDEMO_id int IDENTITY(1,1) PRIMARY KEY,
	CusCusDemo_Customer_id int NOT NULL,
	CusCusDemo_Customer_Type_id int NOT NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTIVE_FLAG int NOT NULL,
	CONSTRAINT FK_Customer_Demo FOREIGN KEY(CusCusDemo_Customer_id) REFERENCES DWH.LK_CUSTOMERS (Cus_Customer_id),
	CONSTRAINT FK_Customer_TypeDemo FOREIGN KEY(CusCusDemo_Customer_Type_id) REFERENCES DWH.LK_CUSTOMER_DEMOGRAPHICS (CusDem_Customer_Type_Id)
);


CREATE TABLE TMP.ORDERS
(
	Order_CD varchar (50) NULL,
	Customer_cd varchar(50) NULL,
	Employee_cd varchar(50) NULL,
	Order_Date varchar(50) NULL,
	Required_Date varchar(50) NULL,
	Shipped_Date varchar(50) NULL,
	Ship_Via varchar(50) NULL,
	Freight varchar(50) NULL,
	Ship_name varchar(50) NULL,
	Ship_Address varchar(50) NULL,
	Ship_City varchar(50) NULL,
	Ship_Region varchar(50) NULL,
	Ship_PostalCode varchar(50) NULL,
	Ship_Country varchar(50) NULL
);

CREATE TABLE STG.LK_ORDERS
(
	Ord_Order_CD varchar (50) NULL,
	Ord_Customer_id int NULL,
	Ord_Employee_id int NULL,
	Ord_Order_Date date NOT NULL,
	Ord_Required_Date date NULL,
	Ord_Shipped_Date date NULL,
	Ord_Ship_Via varchar(50) NULL,
	Ord_Freight varchar(50) NULL,
	Ord_Ship_name varchar(50) NULL,
	Ord_Ship_Address varchar(50) NULL,
	Ord_Ship_City varchar(50) NULL,
	Ord_Ship_Region_Id int NOT NULL,
	Ord_Ship_PostalCode varchar(50) NULL,
	Ord_Ship_Country_id int NOT NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTION varchar(50) NOT NULL
);

CREATE TABLE DWH.LK_ORDERS
(
	Ord_Order_id int IDENTITY(1,1) PRIMARY KEY,
	Ord_Order_CD varchar (50) NULL,
	Ord_Customer_id int NULL,
	Ord_Employee_id int NULL,
	Ord_Order_Date date NOT NULL,
	Ord_Required_Date date NULL,
	Ord_Shipped_Date date NULL,
	Ord_Ship_Via varchar(50) NULL,
	Ord_Freight varchar(50) NULL,
	Ord_Ship_name varchar(50) NULL,
	Ord_Ship_Address varchar(50) NULL,
	Ord_Ship_City varchar(50) NULL,
	Ord_Ship_Region_Id int NOT NULL,
	Ord_Ship_PostalCode varchar(50) NULL,
	Ord_Ship_Country_id int NOT NULL,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTIVE_FLAG int NOT NULL,
	CONSTRAINT FK_Order_Customer FOREIGN KEY(Ord_Customer_id) REFERENCES DWH.LK_CUSTOMERS (Cus_Customer_id),
	CONSTRAINT FK_Order_Employee FOREIGN KEY(Ord_Employee_id) REFERENCES DWH.LK_EMPLOYEES (Emp_Employee_id),
	CONSTRAINT FK_Order_Region FOREIGN KEY(Ord_Ship_Region_Id) REFERENCES DWH.LK_REGIONS (Region_Id),
	CONSTRAINT FK_Order_Country FOREIGN KEY(Ord_Ship_Country_id) REFERENCES DWH.LK_COUNTRIES (Ctry_Country_Id)
);

CREATE TABLE TMP.ORDERS_DETAILS
(
	Order_CD varchar (50) NULL,
	Product_cd varchar(50) NULL,
	Unit_Price varchar(50) NULL,
	Order_Date varchar(50) NULL,
	Quantity varchar(50) NULL,
	Discount varchar(50) NULL
);

CREATE TABLE STG.LK_ORDERS_DETAILS
(
	OrdDet_Order_id int NOT NULL,
	OrdDet_Product_id int NOT NULL,
	OrdDet_Unit_Price DECIMAL(10,2) NULL,
	OrdDet_Order_Date DATE NOT NULL,
	OrdDet_Quantity DECIMAL(10,2) NULL,
	OrdDet_Discount DECIMAL(10,2) NULL	,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTION varchar(50) NOT NULL
);

CREATE TABLE DWH.LK_ORDERS_DETAILS
(
	OrdDet_Order_Detail_id int IDENTITY(1,1) PRIMARY KEY,
	OrdDet_Order_id int NOT NULL,
	OrdDet_Product_id int NOT NULL,
	OrdDet_Unit_Price DECIMAL(10,2) NULL,
	OrdDet_Order_Date DATE NOT NULL,
	OrdDet_Quantity DECIMAL(10,2) NULL,
	OrdDet_Discount DECIMAL(10,2) NULL	,
	AUD_INSERT_DT datetime NOT NULL,
	AUD_USER_INSERT varchar(50) NOT NULL,
	AUD_ACTIVE_FLAG int NOT NULL,
	CONSTRAINT FK_OrderDet_Order FOREIGN KEY(OrdDet_Order_id) REFERENCES DWH.LK_ORDERS (Ord_Order_id),
	CONSTRAINT FK_OrderDet_Product FOREIGN KEY(OrdDet_Product_id) REFERENCES DWH.LK_PRODUCTS (prod_product_id)
);

------------------------------------------------------------------------------------
-- STEP 3: Creación de Tablas de Auditoria

CREATE TABLE LOG.AUDIT_PROCESS_DATE
(
	AUDPD_Id int IDENTITY(1,1) PRIMARY KEY,
	AUDPD_JobId int NOT NULL,
	AUDPD_Start_Date DATETIME NOT NULL,
	AUDPD_END_Data DATETIME NULL,
	AUDPD_Status_ID INT NOT NULL,
	AUDPD_Observations VARCHAR(100) NULL,
	CONSTRAINT FK_Status_Process FOREIGN KEY(AUDPD_Status_ID) REFERENCES LOG.AUDIT_STATUS_PROCESS (AUDSP_Status_Id)
);


CREATE TABLE LOG.AUDIT_STATUS_PROCESS
(
	AUDSP_Status_Id int IDENTITY(1,1) PRIMARY KEY,
	AUDPD_Status Varchar(50) NOT NULL,
	AUDPD_INSERT_DT datetime NOT NULL,
	AUDPD_USER_INSERT varchar(50) NOT NULL,
	AUDPD_ACTIVE_FLAG int NOT NULL
);
