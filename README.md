# Sistema de Gestión de Librería - MySQL

Este proyecto implementa una base de datos relacional en **MySQL Workbench** que simula el funcionamiento de una tienda de libros.

##  Estructura del Modelo

- **Autor**: id, nombre, nacionalidad.  
- **Libro**: id, título, año de publicación, precio, autor_id (FK).  
- **Cliente**: id, nombre, correo.  
- **Pedido**: id, cliente_id (FK), fecha.  
- **DetallePedido**: id, pedido_id (FK), libro_id (FK), cantidad, precio_unitario.  

##  Relaciones

- Un **autor** puede tener muchos **libros**.  
- Un **cliente** puede hacer muchos **pedidos**.  
- Un **pedido** puede tener varios **detalles**.  
- Un **libro** puede aparecer en varios **detalles**.  

##  Funcionalidades

- Consultas simples y avanzadas (JOIN, GROUP BY).  
- Transacciones con COMMIT / ROLLBACK.  
- Vista `Vista_Pedidos` con resumen de pedidos por cliente.  
- Diagrama ER hecho en MySQL Workbench.  

##  Evidencias

- Capturas de la ejecución de consultas y vistas.  
- Diagrama ER exportado en imagen PNG.  

##  Conclusión

Este proyecto permite comprender cómo construir y consultar una base de datos relacional completa usando MySQL y aplicar buenas prácticas de modelado de datos.
