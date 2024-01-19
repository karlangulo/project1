# Formulación de la base de datos Proyecto 1
## Resumen del proyecto:
El objetivo principal del proyecto es desarrollar un almacén de datos que cumpla con los requisitos comerciales de la organización, para que la información sea útil y eficiente para las operaciones comerciales de la misma.

# Acerca de la base de datos
La organización es de tamaño mediano y se dedica a la venta por departamentos. La base de datos contiene detalles de una empresa ficticia llamada "XXXX". Contiene información de los productos vendidos, las ventas realizadas, los clientes, los empleados de la tienda, los proveedores con los que se cuentan.  

El conjunto de datos incluye una serie de datos como los siguientes:

Clientes: personas que compran los productos ofrecidos.
Empleados: los encargados de atender a los clientes y asistir en tienda.
Ventas: contiene los detalles de las ventas.
Productos: contiene los productos que se tiene en bodega y para la venta.
Categorías: las listas de productos agrupados con los que se cuentan en los departamentos.
Proveedores: vendedores o empresas que suplen los pedidos de XXXXXXXX.

# Convención de Nombre

Todo se encuentra escrito en minúscula con "_" separando diferentes palabras (reemplazo de los espacios entre palabras). 

# Entidades y Tablas de Hechos

## Customer
Los clientes son las personas que realizan las compras dentro de la organización. Esta tabla contempla: el código de cliente, nombres, correo electrónico, números de teléfono, datos del estado donde se genera la compra y datos de contácto como el código postal.

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|       customer_id      |         INT         |       25       |  UNIQUE Not Null   |
|        first_name      |       VARCHAR       |       25       |      Not Null      |
|        last_name       |       VARCHAR       |       25       |      Not Null      |
|          email         |       VARCHAR       |       50       |      Not Null      |
|       phone_number     |         INT         |       10       |      Not Null      |
|      billing_state     |       VARCHAR       |       10       |      Not Null      |
|     billing_address    |       VARCHAR       |      100       |      Not Null      |
|       postal_code      |         INT         |       10       |      Not Null      |

## Employee
Los empleados son los responsables de mediar las ventas y asistir a los clientes con el fin de lograr cerrar la venta. Esta tabla incluye: el código de empleado, el código de departamento y el nombre del empleado. 

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|       employee_id      |         INT         |       25       |  UNIQUE Not Null   |
|      department_id     |         INT         |       25       |  UNIQUE Not Null   |
|        first_name      |       VARCHAR       |       25       |      Not Null      |
|        last_name       |       VARCHAR       |       25       |      Not Null      |

## Department

El departamento es el lugar donde se agrupan los productos de una misma clase. Por ejemplo, departamento de Hogar, departamento de mujeres, departamento de juguetes, etc. Bajo esta tabla se encuentra: el código de departamento y el nombre del mismo.

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|      department_id     |         INT         |       25       |  UNIQUE Not Null   |
|          name          |       VARCHAR       |       25       |      Not Null      |

## Invoice (FACT)

La tabla de hechos de facturas es donde se detalla el total de las ventas realizadas. Se enlistan detalles importantes como: el código de la factura, el código del cliente, el código del empleado, el total de la venta, la fecha y el tipo de venta realizada.

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|       invoice_id       |         INT         |       25       |  UNIQUE Not Null   |
|       customer_id      |         INT         |       25       |  UNIQUE Not Null   |
|       employee_id      |         INT         |       25       |  UNIQUE Not Null   |
|        total_sale      |        FLOAT        |        4       |      Not Null      |
|          date          |         DATE        |        6       |      Not Null      |
|        sale_type       |       VARCHAR       |       15       |      Not Null      |

## Inventory

El inventario es el producto con el que se cuenta en bodega listo para la venta. La información pertinente a esta tabla es: el código de producto, nombre del producto, el código de categoría, el código de departamento, código de proveedor, costo unitario, precio de venta unitario, total de existencias del producto.

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|      *product_id*      |         INT         |       25       |  UNIQUE Not Null   |
|          name          |       VARCHAR       |       25       |      Not Null      |
|       category_id      |         INT         |       25       |  UNIQUE Not Null   |
|      department_id     |         INT         |       25       |  UNIQUE Not Null   |
|       provider_id      |         INT         |       25       |  UNIQUE Not Null   |
|        unit_cost       |        FLOAT        |        4       |      Not Null      |
|     unit_sale_price    |        FLOAT        |        4       |      Not Null      |
|          stock         |         INT         |      200       |      Not Null      |

## Invoice Line

En esta sección se encuentra el detalle de cantidades vendidas por factura. Los datos proporcinados son: el código de la línea de facturación, código de la factura, código del producto, cantidad y el precio unitario. 

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|    invoice_line_id     |         INT         |       25       |  UNIQUE Not Null   |
|       invoice_id       |         INT         |       25       |  UNIQUE Not Null   |
|      *product_id*      |         INT         |       25       |  UNIQUE Not Null   |
|        quantity        |         INT         |      200       |      Not Null      |
|       unit_price       |        FLOAT        |        4       |      Not Null      |

## Category

La categoría es la agrupación de productos destinados a un uso o área en común. Esto no se debe confundir con Departamento. Por ejemplo: si se cuentan con productos para todo lo que se necesita para amueblar una cocina, el departamento se llama ¨Cocina¨, dentro de la cocina se encuentra las categorías de ¨platos¨, ¨cristalería¨, ¨ollas y sartenes¨, ¨mantelería¨,etc. El detalle de la tabla es: código de categoría y nombre de la categoría.

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|       category_id      |         INT         |       25       |  UNIQUE Not Null   |
|          name          |       VARCHAR       |       25       |      Not Null      |

## Provider

Los proveedores son los encargados de suplir las ordenes de compras realizadas para reabastecimiento de los productos que se quieren vender. La tabla presenta datos como: código asignado al proveedor, nombre del contacto, número telefónico. 

|    Nombre del Campo    |    Tipo de Datos    |    Longitud    |    Restriciones    |
|------------------------|---------------------|----------------|--------------------|
|      provider_id       |         INT         |       25       |  UNIQUE Not Null   |
|      contact_name      |       VARCHAR       |       25       |      Not Null      |
|       phone_number     |         INT         |       10       |      Not Null      |

# Diagrama Entidad- Relación

# Data Definition Language

# Data





