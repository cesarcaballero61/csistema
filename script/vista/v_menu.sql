DROP VIEW IF EXISTS v_menu;
DELIMITER $$
CREATE VIEW  v_menu AS(SELECT
		m1.idmenu
		,m1.parent
		,m1.texto
		,m1.comando
		,m1.nd_carpeta
		,IF(ISNULL(m2.texto),"INICIO",m2.texto) AS miembro
FROM menu m1  LEFT JOIN menu m2 ON m1.parent=m2.idmenu)