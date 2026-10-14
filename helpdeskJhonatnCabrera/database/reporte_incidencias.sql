CREATE VIEW reporte_incidencias AS
SELECT i.ticket, i.fecha, i.hora, i.titulo, i.prioridad,
CONCAT(u.nombres, ' ', u.apellidos) AS usuario,
CONCAT(t.nombres, ' ', t.apellidos) AS tecnico,
c.nombre AS categoria, e.nombre AS estado
FROM incidencia i
INNER JOIN usuario u ON i.usuario_id = u.id_usuario
LEFT JOIN tecnico t ON i.tecnico_id = t.id_tecnico
INNER JOIN categoria c ON i.categoria_id = c.id_categoria
INNER JOIN estado e ON i.estado_id = e.id_estado;

SELECT * FROM reporte_incidencias ORDER BY fecha DESC, hora DESC;
