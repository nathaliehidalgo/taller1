-- CREATE DATABASE Revistas;
-- 
-- USE Revistas;

-- ******************CREACION DE TABLAS******************

CREATE TABLE Revista(
cod_revista varchar(20) not null primary key,
nombre varchar(50)
); 

DELIMITER $$
CREATE TRIGGER tg_revista_insert
BEFORE INSERT ON revista
FOR EACH ROW
BEGIN
 DECLARE revistaCount INT;
 SET revistaCount = (select count(*) from revista);
 SET NEW.cod_revista = (select concat('R', LPAD(revistaCount + 1, 4, 0))); 
END$$
DELIMITER ;

insert into revista (nombre) values ('Ecoturismo en El Salvador');
insert into revista (nombre) values ('Boda pasó a paso');
insert into revista (nombre) values ('Ella');
insert into revista (nombre) values ('TECHlife');


insert into revista (nombre) values ('El economista');
insert into revista (nombre) values ('Motor');
insert into revista (nombre) values ('Séptimo Sentido');
insert into revista (nombre) values ('Mujeres');
insert into revista (nombre) values ('Vértice');
insert into revista (nombre) values ('Guanaquin');
insert into revista (nombre) values ('Planeta Alternativo');


CREATE TABLE Editorial(
id_editor varchar(20) not null primary key,
nombre varchar(50)
);

DELIMITER $$
CREATE TRIGGER tg_editorial_insert
BEFORE INSERT ON editorial
FOR EACH ROW
BEGIN
  DECLARE editorialCount INT;
  SET editorialCount = (select count(*) from editorial);
  SET NEW.id_editor = (select concat('E', LPAD(editorialCount + 1, 4, 0)));
END$$
DELIMITER ;

insert into editorial (nombre) values ('Grupo Dutriz');
insert into editorial (nombre) values ('Boda paso a paso');
insert into editorial (nombre) values ('Ministerio de Turismo El Salvador');
insert into editorial (nombre) values ('Grupo Editorial Altamirano');


CREATE TABLE Coleccion(
cod_revista varchar(20),
id_editor varchar(20),
precio decimal(6,2)
);

alter table Coleccion add constraint fk_coleccionrevista foreign key (cod_revista) REFERENCES revista(cod_revista);
alter table Coleccion add constraint fk_coleccioneditorial foreign key (id_editor) REFERENCES editorial(id_editor);


insert into coleccion (cod_revista, id_editor) values ('R0001', 'E0003');
insert into coleccion (cod_revista, id_editor, precio) values ('R0002', 'E0002', '7.00');
insert into coleccion (cod_revista, id_editor, precio) values ('R0003', 'E0001', '3.50');
insert into coleccion (cod_revista, id_editor, precio) values ('R0004', 'E0001', '5.75');
insert into coleccion (cod_revista, id_editor, precio) values ('R0005', 'E0001', '1.50');
insert into coleccion (cod_revista, id_editor, precio) values ('R0006', 'E0001', '4.00');
insert into coleccion (cod_revista, id_editor, precio) values ('R0007', 'E0001', '3.25');
insert into coleccion (cod_revista, id_editor) values ('R0008', 'E0004');
insert into coleccion (cod_revista, id_editor, precio) values ('R0009', 'E0004', '3.50');
insert into coleccion (cod_revista, id_editor, precio) values ('R0010', 'E0004', '2.00');



-- ******************EJERCICIO 41******************
select nombre as NombreRevista FROM revista;

-- ******************EJERCICIO 42******************
select nombre as NombreEditorial FROM editorial;

-- ******************EJERCICIO 43******************
select ROUND(AVG(precio), 2) as PrecioPromedioRevistas FROM coleccion; 

-- ******************EJERCICIO 44******************
select revista.cod_revista AS CodigoRevista, revista.nombre AS NombreRevista, editorial.nombre AS NombreEditorial FROM revista 
INNER JOIN coleccion ON revista.cod_revista = coleccion.cod_revista
INNER JOIN editorial ON coleccion.id_editor = editorial.id_editor
WHERE revista.nombre = 'Guanaquin';

-- ******************EJERCICIO 45******************
select editorial.id_editor AS IdEditorial, editorial.nombre AS NombreEditorial, GROUP_CONCAT(revista.nombre) AS RevistasDeEditorial FROM editorial 
INNER JOIN coleccion ON editorial.id_editor = coleccion.id_editor
INNER JOIN revista ON coleccion.cod_revista = revista.cod_revista
WHERE editorial.nombre = 'Grupo Dutriz'
GROUP BY editorial.id_editor;

-- ******************EJERCICIO 46******************
select revista.nombre AS NombreDeRevistaMasCara, MAX(coleccion.precio) AS Precio FROM coleccion
INNER JOIN revista ON coleccion.cod_revista = revista.cod_revista;

-- ******************EJERCICIO 47******************
select revista.nombre AS 5_RevistasMasCaras, editorial.nombre AS NombreEditorial, coleccion.precio AS PrecioRevista FROM coleccion
INNER JOIN editorial ON coleccion.id_editor = editorial.id_editor
INNER JOIN revista ON coleccion.cod_revista = revista.cod_revista
order by coleccion.precio desc
limit 5;

-- ******************EJERCICIO 48******************
select editorial.nombre AS Editorial, COUNT(cod_revista) AS NumeroDeRevistas FROM coleccion
INNER JOIN editorial ON coleccion.id_editor = editorial.id_editor
GROUP BY coleccion.id_editor;

-- ******************EJERCICIO 49******************

select revista.nombre AS NombreRevista, coleccion.precio AS PrecioRevista FROM coleccion 
INNER JOIN revista ON coleccion.cod_revista = revista.cod_revista
WHERE coleccion.precio BETWEEN 3.00 AND 5.00 ORDER BY coleccion.precio asc; 

-- ******************EJERCICIO 50******************

UPDATE coleccion SET precio = precio + 0.10;

-- ******************EJERCICIO 51 y 52******************

UPDATE revista SET revista.nombre = 'Ella LPG' WHERE cod_revista = 'R0003';
UPDATE revista SET revista.nombre  = 'Mujeres EDH' WHERE cod_revista = 'R0008';

-- ******************EJERCICIO 53******************

DELETE FROM coleccion WHERE id_editor IN(SELECT editorial.id_editor FROM editorial WHERE editorial.nombre = 'Boda paso a paso');
SELECT COUNT(*) AS RevistasBodaPasoAPaso FROM coleccion INNER JOIN editorial ON coleccion.id_editor = editorial.id_editor WHERE editorial.nombre = 'Boda paso a paso';




