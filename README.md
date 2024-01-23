# Formulación de la base de datos Proyecto 1
## Resumen del proyecto:
El objetivo principal del proyecto es desarrollar un almacén de datos que cumpla con los requisitos comerciales de la organización, para que la información sea útil y eficiente para las operaciones comerciales de la misma.

# Acerca de la base de datos
La organización es de tamaño mediano y se dedica a la venta por departamentos. La base de datos contiene detalles de una empresa ficticia llamada "Macie". Contiene información de los productos vendidos, las ventas realizadas, los clientes, los empleados de la tienda, los proveedores con los que se cuentan y los medios y herramientas utilizadas para promocionarse.  

El conjunto de datos incluye una serie información valiosa como los siguientes puntos:

Clientes: personas que compran los productos ofrecidos.
Empleados: los encargados de atender a los clientes y asistir en tienda.
Ventas: contiene los detalles de las ventas.
Productos: contiene los productos que se tiene en bodega y para la venta.
Categorías: las listas de productos agrupados con los que se cuentan en los departamentos.
Proveedores: vendedores o empresas que suplen los pedidos de Macie.
Marketing: herramientas útiles para generar impacto en las ventas y darse a conocer al mercado.
Beneficios: ofertas especiales y reconocimiento por la fidelidad de clientes.

# Convención de Nombre

Todo se encuentra escrito en minúscula con "_" separando diferentes palabras (reemplazo de los espacios entre palabras). 

# Entidades y Tablas de Hechos

## Benefits
Los clientes tienen asignado categorías con las que pueden obtener beneficios con la empresa, todo depende si cumplen con los requisitos que dependen de la compra mínima o máxima que hagan para asignar el porcentaje de descuento. Las categorías a las que pueden aplicar son: Bronze, Silver, Gold, Platinum, Diamond. 

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|       benefit_id      |         INT         |       160       |  UNIQUE Not Null   |
|          name          |       VARCHAR       |       160       |      Not Null      |
|        min_avg_purchase      |        NUMERIC      |       10,2     |      Not Null      |
|        max_avg_purchase      |        NUMERIC      |       10,2     |      Not Null      |
|        discount_percentage      |        FLOAT      |            |      Not Null      |


## Customer
Los clientes son las personas que realizan las compras dentro de la organización. Esta tabla contempla: el código de cliente, nombres, correo electrónico, números de teléfono, datos del estado donde se genera la compra, datos de contácto como el código postal, la categoría con la que cuenta el cliente dentro de la empresa, asi como su edad.

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|       customer_id      |         INT         |       160       |  UNIQUE Not Null   |
|        first_name      |       VARCHAR       |       160       |      Not Null      |
|        last_name       |       VARCHAR       |       160       |      Not Null      |
|          email         |       VARCHAR       |       160       |      Not Null      |
|       phone     |         INT         |              |      Not Null      |
|      billing_state     |       VARCHAR       |       160       |            |
|     billing_address    |       VARCHAR       |      160       |            |
|       postal_code      |       VARCHAR       |       160       |           |
|       customer_category      |       VARCHAR       |       160       |           |
|       age      |       INT       |              |      Not Null     |


## Department

El departamento es el lugar donde se agrupan los productos de una misma clase. Por ejemplo, departamento de Hogar, departamento de mujeres, departamento de juguetes, etc. Bajo esta tabla se encuentra: el código de departamento y el nombre del mismo.

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|      department_id     |         INT         |              |  UNIQUE Not Null   |
|          name          |       VARCHAR       |       160       |      Not Null      |


## Category

La categoría es la agrupación de productos destinados a un uso o área en común. Esto no se debe confundir con Departamento. Por ejemplo: si se cuentan con productos para todo lo que se necesita para amueblar una cocina, el departamento se llama ¨Cocina¨, dentro de la cocina se encuentra las categorías de ¨platos¨, ¨cristalería¨, ¨ollas y sartenes¨, ¨mantelería¨,etc. El detalle de la tabla es: código de categoría y nombre de la categoría.

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|       category_id      |         INT         |              |  UNIQUE Not Null   |
|          name          |       VARCHAR       |       160       |      Not Null      |


## Provider

Los proveedores son los encargados de suplir las ordenes de compras realizadas para reabastecimiento de los productos que se quieren vender. La tabla presenta datos como: código asignado al proveedor, nombre del contacto, número telefónico. 

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|      provider_id       |         INT         |              |  UNIQUE Not Null   |
|      contact_name      |       VARCHAR       |       160       |      Not Null      |
|       phone_number     |         INT         |              |      Not Null      |


## Inventory

El inventario es el producto con el que se cuenta en bodega listo para la venta. La información pertinente a esta tabla es: el código de producto, nombre del producto, el código de categoría, el código de departamento, código de proveedor, costo unitario, precio de venta unitario, total de existencias del producto.

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|      *product_id*      |         INT         |              |  UNIQUE Not Null   |
|          name          |       VARCHAR       |       160       |      Not Null      |
|       category_id      |         INT         |              |  UNIQUE Not Null   |
|      department_id     |         INT         |              |  UNIQUE Not Null   |
|       provider_id      |         INT         |              |  UNIQUE Not Null   |
|        unit_cost       |       NUMERIC      |       10,2     |      Not Null      |
|     unit_sale_price    |       NUMERIC      |       10,2     |      Not Null      |
|          stock         |         INT         |             |      Not Null      |


## Employee
Los empleados son los responsables de mediar las ventas y asistir a los clientes con el fin de lograr cerrar la venta. Esta tabla incluye: el código de empleado, el código de departamento, el nombre del empleado y su rol. 

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|       employee_id      |         INT         |              |  UNIQUE Not Null   |
|      department_id     |         INT         |              |  UNIQUE Not Null   |
|        first_name      |       VARCHAR       |       160       |      Not Null      |
|        last_name       |       VARCHAR       |       160       |      Not Null      |
|        role      |       VARCHAR       |       160       |      Not Null      |


## Invoice (FACT)

La tabla de hechos de facturas es donde se detalla el total de las ventas realizadas. Se enlistan detalles importantes como: el código de la factura, el código del cliente, el código del empleado, el total de la venta, la fecha y el tipo de venta realizada.

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|       invoice_id       |         INT         |              |  UNIQUE Not Null   |
|       customer_id      |         INT         |              |  UNIQUE Not Null   |
|       employee_id      |         INT         |              |  UNIQUE Not Null   |
|        total_sale      |        NUMERIC      |       10,2     |      Not Null      |
|          date          |         DATE        |               |      Not Null      |
|        sale_type       |       VARCHAR       |       160       |      Not Null      |


## Invoice Line (FACT)

En esta sección se encuentra el detalle de cantidades vendidas por factura. Los datos proporcinados son: el código de la línea de facturación, código de la factura, código del producto, cantidad y el precio unitario. 

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|    invoice_line_id     |         INT         |              |  UNIQUE Not Null   |
|       invoice_id       |         INT         |              |  UNIQUE Not Null   |
|      *product_id*      |         INT         |              |  UNIQUE Not Null   |
|        quantity        |         INT         |             |      Not Null      |
|       unit_sale_price              NUMERIC      |       10,2     |      Not Null      |


## Marketing (FACT)

La tabla de hechos de marketing muestra el tipo de oferta de campaña, el método de marketing utilizado para el lanzamiento, el tiempo de inicio y fin de la campaña y el tipo de venta realizado.

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|    marketing_id     |         INT         |              |  UNIQUE Not Null   |
|        campaign_offer       |       VARCHAR       |       160       |      Not Null      |
|        marketing_method       |       VARCHAR       |       160       |      Not Null      |
|          campaign_start         |         DATE        |               |      Not Null      |
|          campaign_end         |         DATE        |               |      Not Null      |


## Marketing Line

En esta tabla se detallan las campañas de marketing que se lanzaron, la categoría de la oferta, el porcentaje de descuento aplicado por la campaña y la restricción de aplicación que es dependiendo de la compra mínima. 

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|    mkt_line_id     |         INT         |              |  UNIQUE Not Null   |
|    marketing_id     |         INT         |              |  UNIQUE Not Null   |
|        category_offer       |       VARCHAR       |       160       |      Not Null      |
|        discount_percentage      |        FLOAT      |            |      Not Null      |
|       purchase_min              NUMERIC      |       10,2     |      Not Null      |
|        sale_type       |       VARCHAR       |       160       |      Not Null      |


# Diagrama Entidad- Relación

<img title="Database Diagram" src="/database_diagram.jpeg">
# Data Definition Language

# Data





