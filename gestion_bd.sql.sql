DROP DATABASE IF EXISTS tienda_libros;

CREATE DATABASE IF NOT EXISTS tienda_libros;
USE tienda_libros;


-- Tabla Autor
CREATE TABLE Autor (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  nacionalidad VARCHAR(50)
);

-- Tabla Libro
CREATE TABLE Libro (
  id INT PRIMARY KEY AUTO_INCREMENT,
  titulo VARCHAR(100) NOT NULL,
  anio_publicacion INT,
  precio DECIMAL(10, 2),
  autor_id INT,
  FOREIGN KEY (autor_id) REFERENCES Autor(id)
);

-- Tabla Cliente
CREATE TABLE Cliente (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(100)
);

-- Tabla Pedido
CREATE TABLE Pedido (
  id INT PRIMARY KEY AUTO_INCREMENT,
  cliente_id INT,
  fecha DATE,
  FOREIGN KEY (cliente_id) REFERENCES Cliente(id)
);

-- Tabla DetallePedido
CREATE TABLE DetallePedido (
  id INT PRIMARY KEY AUTO_INCREMENT,
  pedido_id INT,
  libro_id INT,
  cantidad INT,
  precio_unitario DECIMAL(10, 2),
  FOREIGN KEY (pedido_id) REFERENCES Pedido(id),
  FOREIGN KEY (libro_id) REFERENCES Libro(id)
);


-- Autores
INSERT INTO Autor (nombre, nacionalidad) VALUES 
('Gabriel García Márquez', 'Colombiano'),
('Isabel Allende', 'Chilena'),
('Mario Vargas Llosa', 'Peruano');

-- Libros
INSERT INTO Libro (titulo, anio_publicacion, precio, autor_id) VALUES 
('Cien Años de Soledad', 1967, 50.00, 1),
('El amor en los tiempos del cólera', 1985, 45.00, 1),
('La casa de los espíritus', 1982, 55.00, 2),
('Paula', 1994, 48.00, 2),
('La ciudad y los perros', 1963, 40.00, 3);

-- Clientes
INSERT INTO Cliente (nombre, email) VALUES 
('Juan Pérez', 'juan@gmail.com'),
('Ana Gómez', 'ana@gmail.com'),
('Luis Torres', 'luis@gmail.com'),
('Carla Díaz', 'carla@gmail.com');

-- Pedidos
INSERT INTO Pedido (cliente_id, fecha) VALUES 
(1, '2024-06-01'),
(2, '2024-06-02'),
(3, '2024-06-03');

-- Detalles de Pedidos
INSERT INTO DetallePedido (pedido_id, libro_id, cantidad, precio_unitario) VALUES 
(1, 1, 1, 50.00),
(1, 2, 2, 45.00),
(2, 3, 1, 55.00),
(3, 4, 1, 48.00),
(3, 5, 2, 40.00);

-- 4. Consultas Básicas

-- Libros publicados después de 1980 ordenados por año
SELECT * FROM Libro
WHERE anio_publicacion > 1980
ORDER BY anio_publicacion;

-- Autores y cantidad total de libros
SELECT a.nombre, COUNT(l.id) AS cantidad_libros
FROM Autor a
JOIN Libro l ON a.id = l.autor_id
GROUP BY a.nombre;

-- 5. Consultas Avanzadas (JOIN)

-- Lista de pedidos con nombre de cliente y fecha
SELECT p.id AS pedido_id, c.nombre AS cliente, p.fecha
FROM Pedido p
JOIN Cliente c ON p.cliente_id = c.id;

-- Detalles de un pedido
SELECT l.titulo, d.cantidad, (d.cantidad * d.precio_unitario) AS subtotal
FROM DetallePedido d
JOIN Libro l ON d.libro_id = l.id
WHERE d.pedido_id = 1;

-- 6. Actualización y Eliminación

-- Modificar precio unitario
UPDATE DetallePedido
SET precio_unitario = 60.00
WHERE id = 1;

-- Eliminar libro
DELETE FROM Libro WHERE id = 5;

-- 7. Transacciones

START TRANSACTION;

-- Nuevo pedido
INSERT INTO Pedido (cliente_id, fecha) VALUES (4, CURDATE());

SET @pedido_id = LAST_INSERT_ID();

INSERT INTO DetallePedido (pedido_id, libro_id, cantidad, precio_unitario) VALUES
(@pedido_id, 1, 1, 50.00),
(@pedido_id, 3, 2, 55.00);

COMMIT;

-- 8. Vista de Pedidos
CREATE VIEW Vista_Pedidos AS
SELECT p.id, c.nombre, p.fecha,
       SUM(d.cantidad * d.precio_unitario) AS total
FROM Pedido p
JOIN Cliente c ON p.cliente_id = c.id
JOIN DetallePedido d ON d.pedido_id = p.id
GROUP BY p.id, c.nombre, p.fecha;

-- Consulta sobre la vista
SELECT * FROM Vista_Pedidos
WHERE total > 50;
