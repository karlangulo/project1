
/*******************************************************************************
   Project1 Database - Version 1
   Script: project1_ddl.sql
   Description: Creates and populates the Project1 database.
   DB Server: PostgreSql
   Author: Adonis Hernandez, Henry Banchon, Karla Angulo
********************************************************************************/
SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL SERIALIZABLE;


/*******************************************************************************
   Create Tables
********************************************************************************/
CREATE TABLE "benefits"
(
    "benefit_id" INT NOT NULL,
    "name" VARCHAR(160) NOT NULL,
    "min_avg_purchase" NUMERIC(10,2) NOT NULL,
	"max_avg_purchase" NUMERIC(10,2) NOT NULL,
	"discount_percentage" FLOAT8 NOT NULL,
    CONSTRAINT "benefit_id" PRIMARY KEY  ("benefit_id")
);

CREATE TABLE "customer"
(
    "customer_id" INT NOT NULL,
    "first_name" VARCHAR(160) NOT NULL,
    "last_name" VARCHAR(160) NOT NULL,
	"email" VARCHAR(160) NOT NULL,
	"phone" INT NOT NULL,
	"billing_state" VARCHAR(160),
	"billing_address" VARCHAR(160),
	"postal_code" VARCHAR(160),
	"benefit_id" INT NOT NULL,
	"age" INT NOT NULL,
    CONSTRAINT "PK_customer" PRIMARY KEY  ("customer_id")
);

CREATE TABLE "department"
(
    "department_id" INT NOT NULL,
    "name" VARCHAR(160) NOT NULL,
    CONSTRAINT "PK_department" PRIMARY KEY  ("department_id")
);

CREATE TABLE "category"
(
    "category_id" INT NOT NULL,
    "name" VARCHAR(160) NOT NULL,
    CONSTRAINT "PK_category" PRIMARY KEY  ("category_id")
);

CREATE TABLE "provider"
(
    "provider_id" INT NOT NULL,
    "contact_name" VARCHAR(160) NOT NULL,
	"phone_number" INT NOT NULL,
    CONSTRAINT "PK_provider" PRIMARY KEY  ("provider_id")
);

CREATE TABLE "inventory"
(
    "product_id" INT NOT NULL,
    "name" VARCHAR(160) NOT NULL,
    "category_id" INT NOT NULL,
	"department_id" INT NOT NULL,
	"provider_id" INT NOT NULL,
	"unit_cost" NUMERIC(10,2) NOT NULL,
	"unit_sale_price" NUMERIC(10,2) NOT NULL,
	"stock" INT NOT NULL,
    CONSTRAINT "PK_inventory" PRIMARY KEY  ("product_id")
);

CREATE TABLE "employee"
(
    "employee_id" INT NOT NULL,
	"department_id" INT NOT NULL,
    "first_name" VARCHAR(160) NOT NULL,
    "last_name" VARCHAR(160) NOT NULL,
	"role" VARCHAR(160) NOT NULL,
    CONSTRAINT "PK_employee" PRIMARY KEY  ("employee_id")
);

CREATE TABLE "fact_invoice"
(
    "invoice_id" INT NOT NULL,
    "customer_id" INT NOT NULL,
    "employee_id" INT NOT NULL,
	"total_sale" NUMERIC(10,2) NOT NULL,
	"date" DATE NOT NULL,
	"sale_type" VARCHAR(160) NOT NULL,
	CONSTRAINT "PK_fact_invoice" PRIMARY KEY  ("invoice_id")
);

CREATE TABLE "fact_invoice_line"
(
    "invoice_line_id" INT NOT NULL,
    "invoice_id" INT NOT NULL,
	"product_id" INT NOT NULL,
    "quantity" INT NOT NULL,
	"unit_sale_price" NUMERIC(10,2) NOT NULL,
	"marketing_id"  INT,
	CONSTRAINT "PK_invoice_line_id" PRIMARY KEY  ("invoice_line_id")
);

CREATE TABLE "fact_marketing"
(
    "marketing_id" INT NOT NULL,
    "campaign_offer" VARCHAR(160) NOT NULL,
	"marketing_method" VARCHAR(160) NOT NULL,
    "campaign_start" DATE NOT NULL,
	"campaign_end" DATE NOT NULL,
	"sale_type" VARCHAR(160) NOT NULL,
	CONSTRAINT "PK_fact_marketing" PRIMARY KEY  ("marketing_id")
);

CREATE TABLE "marketing_line"
(
    "mkt_line_id" INT NOT NULL,
	"marketing_id" INT NOT NULL,
    "category_offer" VARCHAR(160) NOT NULL,
	"discount_percentage" FLOAT8 NOT NULL,
    "purchase_min" NUMERIC(10,2) NOT NULL,
	CONSTRAINT "PK_mkt_line_id" PRIMARY KEY  ("mkt_line_id")
);

/*******************************************************************************
   Create Primary Key Unique Indexes & Foreign Keys
********************************************************************************/

ALTER TABLE "fact_invoice"
	ADD CONSTRAINT "FK_fact_invoice_customer_id"
	FOREIGN KEY ("customer_id") REFERENCES "customer" ("customer_id") ON DELETE NO ACTION ON UPDATE NO ACTION,
	ADD CONSTRAINT "FK_fact_invoice_employee_id"
	FOREIGN KEY ("employee_id") REFERENCES "employee" ("employee_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_fact_invoice_customer_id" ON "fact_invoice" ("customer_id");
CREATE INDEX "IFK_fact_invoice_employee_id" ON "fact_invoice" ("employee_id");

ALTER TABLE "employee"
	ADD CONSTRAINT "FK_employee_department_id"
	FOREIGN KEY ("department_id") REFERENCES "department" ("department_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
	
CREATE INDEX "IFK_employee_department_id" ON "employee" ("department_id");

ALTER TABLE "fact_invoice_line"
	ADD CONSTRAINT "FK_fact_invoice_line_invoice_id"
	FOREIGN KEY ("invoice_id") REFERENCES "fact_invoice" ("invoice_id") ON DELETE NO ACTION ON UPDATE NO ACTION,
	ADD CONSTRAINT "FK_fact_invoice_line_product_id"
	FOREIGN KEY ("product_id") REFERENCES "inventory" ("product_id") ON DELETE NO ACTION ON UPDATE NO ACTION,
	ADD CONSTRAINT "FK_fact_invoice_line_fact_marketing_id"
	FOREIGN KEY ("marketing_id") REFERENCES "fact_marketing" ("marketing_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
	
CREATE INDEX "IFK_fact_invoice_line_invoice_id" ON "fact_invoice_line" ("invoice_id");
CREATE INDEX "IFK_fact_invoice_line_product_id" ON "fact_invoice_line" ("product_id");
CREATE INDEX "IFK_fact_invoice_line_marketing_id" ON "fact_invoice_line" ("marketing_id");


ALTER TABLE "inventory"
	ADD CONSTRAINT "FK_inventory_category_id"
	FOREIGN KEY ("category_id") REFERENCES "category" ("category_id") ON DELETE NO ACTION ON UPDATE NO ACTION,
	ADD CONSTRAINT "FK_inventory_provider_id"
	FOREIGN KEY ("provider_id") REFERENCES "provider" ("provider_id") ON DELETE NO ACTION ON UPDATE NO ACTION,
	ADD CONSTRAINT "FK_inventory_department_id"
	FOREIGN KEY ("department_id") REFERENCES "department" ("department_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
	
CREATE INDEX "IFK_inventory_category_id" ON "inventory" ("category_id");
CREATE INDEX "IFK_inventory_provider_id" ON "inventory" ("provider_id");
CREATE INDEX "IFK_inventory_department_id" ON "inventory" ("department_id");

ALTER TABLE "customer"
ADD CONSTRAINT "FK_benefit_id"
	FOREIGN KEY ("benefit_id") REFERENCES "benefits" ("benefit_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "FK_benefit_id" ON "customer" ("benefit_id");

ALTER TABLE "marketing_line"
ADD CONSTRAINT "FK_marketing_id"
	FOREIGN KEY ("marketing_id") REFERENCES "fact_marketing" ("marketing_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "FK_marketing_id" ON "fact_marketing" ("marketing_id");

/***************************************************************************************************************
Creation of View #1: Objetivo es mostrar productos más vendidos, tipos de clientes y patrones de compra
****************************************************************************************************************/

CREATE VIEW view1 AS
SELECT i.name AS product_name, SUM(fil.quantity) as product_quantity, SUM(fi.total_sale) as product_sales, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, b.name AS customer_category, c.age AS customer_age
FROM inventory AS i
INNER JOIN fact_invoice_line AS fil 
	ON i.product_id = fil.product_id
INNER JOIN fact_invoice AS fi
	ON fil.invoice_id = fi.invoice_id
INNER JOIN customer AS c
	ON fi.customer_id = c.customer_id
INNER JOIN benefits AS b
	ON c.benefit_id = b.benefit_id
GROUP BY i.name, customer_name, customer_category
ORDER BY 
	product_quantity DESC,
	product_sales DESC;

/*********************************************************************************************************************************************************************
Creation of View #2: Objetivo es mostrar lista de productos con menos stock, productos que se estan agotando y nivel de rotación de los mismos
**********************************************************************************************************************************************************************/

CREATE VIEW view2 AS
SELECT i.name, i.stock AS remaining_product, AVG(fil.quantity) AS rotation_level, i.unit_cost as product_unit_cost, p.contact_name
FROM inventory AS i
INNER JOIN provider as p
ON i.provider_id = p.provider_id
INNER JOIN fact_invoice_line as fil
ON i.product_id = fil.product_id
GROUP BY i.name, remaining_product, i.unit_cost, p.contact_name
ORDER BY i.stock ASC

/************************************************************************************************************************
Creation of View #3: Objetivo es mostrar las ventas totales durante las campañas de marketing, y sus fechas de campaña 
*************************************************************************************************************************/

CREATE VIEW view3 AS
SELECT fm.campaign_offer, fm.marketing_method, fm.campaign_start, fm.campaign_end, SUM(fi.total_sale) as sales
FROM fact_marketing AS fm
INNER JOIN fact_invoice_line AS fil
ON fm.marketing_id = fil.marketing_id
INNER JOIN fact_invoice AS fi
ON fil.invoice_id = fi.invoice_id
GROUP BY fm.campaign_offer, fm.marketing_method, fm.campaign_start, fm.campaign_end
