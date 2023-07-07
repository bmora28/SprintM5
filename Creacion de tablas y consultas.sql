-- Creando tablas 
CREATE TABLE `categorias` (
  `idcategorias` int NOT NULL AUTO_INCREMENT,
  `Nombre_Categoria` varchar(45) NOT NULL,
  PRIMARY KEY (`idcategorias`)
) ;
CREATE TABLE `cliente` (
  `idcliente` int NOT NULL,
  `Nombre` varchar(45) DEFAULT NULL,
  `Apellido` varchar(45) DEFAULT NULL,
  `Direccion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idcliente`)
);
CREATE TABLE `proveedores` (
  `idproveedores` int NOT NULL,
  `NombreLegal` varchar(45) DEFAULT NULL,
  `NombreCorp` varchar(45) DEFAULT NULL,
  `Telefono1` varchar(45) DEFAULT NULL,
  `Telefono2` varchar(45) DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `Categoria` int NOT NULL,
  PRIMARY KEY (`idproveedores`),
  KEY `idcategorias_idx` (`Categoria`),
  CONSTRAINT `idcategorias` FOREIGN KEY (`Categoria`) REFERENCES `categorias` (`idcategorias`)
);
CREATE TABLE `productos` (
  `idproductos` int NOT NULL,
  `Stock` int NOT NULL,
  `precio` int DEFAULT NULL,
  `color` varchar(45) DEFAULT NULL,
  `Categoria_producto` int NOT NULL,
  `Proveedor` int NOT NULL,
  PRIMARY KEY (`idproductos`),
  KEY `idproveedores_idx` (`Proveedor`),
  KEY `idcategorias_idx` (`Categoria_producto`),
  CONSTRAINT `idcategorias_producto` FOREIGN KEY (`Categoria_producto`) REFERENCES `categorias` (`idcategorias`),
  CONSTRAINT `idproveedores` FOREIGN KEY (`Proveedor`) REFERENCES `proveedores` (`idproveedores`)
);
CREATE TABLE `compra` (
  `idcompra` int NOT NULL,
  `Id_Cliente` int DEFAULT NULL,
  `Id_Producto` int DEFAULT NULL,
  PRIMARY KEY (`idcompra`),
  KEY `clientecompra_idx` (`Id_Cliente`),
  KEY `productocompra_idx` (`Id_Producto`),
  CONSTRAINT `clientecompra` FOREIGN KEY (`Id_Cliente`) REFERENCES `cliente` (`idcliente`),
  CONSTRAINT `productocompra` FOREIGN KEY (`Id_Producto`) REFERENCES `productos` (`idproductos`)
);

  -- Llenando las tablas de datos
INSERT INTO categorias (idcategorias, Nombre_Categoria) VALUES (1, 'Electronica y Computacion'),
 (2, 'Hogar'),
 (3, 'Telefonia'),
 (4, 'Carpinteria');

INSERT INTO proveedores (idproveedores, NombreLegal, NombreCorp, Telefono1, Telefono2, Email, Categoria) VALUES (1, 'NombreLegal1', 'NombreCorp1', '12345678', '12345678', 'Correo1', 1),
(2, 'NombreLegal2', 'NombreCorp2', '12345678', '12345678', 'Correo2', 1),
(3, 'NombreLegal3', 'NombreCorp3', '12345678', '12345678', 'Correo3', 2),
(4, 'NombreLegal4', 'NombreCorp4', '12345678', '12345678', 'Correo4', 1),
(5, 'NombreLegal5', 'NombreCorp5', '12345678', '12345678', 'Correo5', 3);

INSERT INTO cliente (idCliente, Nombre, Apellido, Direccion) VALUES (1, 'Cliente', '1', 'Direccion 1'),
(2, 'Cliente', '2', 'Direccion 2'),
(3, 'Cliente', '3', 'Direccion 3'),
(4, 'Cliente', '4', 'Direccion 4'),
(5, 'Cliente', '5', 'Direccion 5');

INSERT INTO productos (idproductos, Stock, precio, color, Categoria_producto, Proveedor) VALUES (1, 2, 1000, 'Rojo', 1, 1),
(2, 3, 1500, 'Rojo', 2, 1),
(3, 1, 1400, 'Rojo', 1, 2),
(4, 2, 1200, 'Rojo', 1, 3),
(5, 3, 500, 'Verde', 1, 4),
(6, 5, 650, 'Verde', 1, 1),
(7, 7, 450, 'Verde', 2, 1),
(8, 4, 100, 'Azul', 3, 1),
(9, 2, 1500, 'Naranjo', 3, 2),
(10, 3, 2000, 'Amarillo', 4, 2);

-- Cuál es la categoría de productos que más se repite.
select Nombre_Categoria, Categoria_producto, count(*) from sm5.productos
inner join sm5.categorias
on sm5.categorias.idcategorias = sm5.productos.Categoria_producto
group by Categoria_producto ;

-- Cuáles son los productos con mayor stock
select idproductos, Stock  from sm5.productos
where Stock = (select max(Stock) from sm5.productos);

 -- Qué color de producto es más común en nuestra tienda.
 select count(*), color  from sm5.productos
 group by color limit 1;
 
-- Cual o cuales son los proveedores con menor stock de productos.

select SUM(Stock) AS TOTAL,Proveedor  from sm5.productos
group by Proveedor
ORDER BY TOTAL ASC;

