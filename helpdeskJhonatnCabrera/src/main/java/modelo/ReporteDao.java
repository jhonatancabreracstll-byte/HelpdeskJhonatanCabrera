package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReporteDao {
    private final ConexionMySQL cn = new ConexionMySQL();

    private Connection conectar() throws SQLException {
        Connection conexion = cn.getConexion();
        if (conexion == null) {
            throw new SQLException("No se pudo conectar a MySQL. Verifica que MySQL esté iniciado en XAMPP y que exista la base actividad15jhonatancabrera.");
        }
        return conexion;
    }

    public List<Object[]> listar(String estado, String categoria, String prioridad) throws SQLException {
        List<Object[]> lista = new ArrayList<>();
        String sql = "SELECT i.ticket, i.fecha, i.hora, i.titulo, i.prioridad, "
                + "CONCAT(u.nombres, ' ', u.apellidos) AS usuario, "
                + "COALESCE(CONCAT(t.nombres, ' ', t.apellidos), 'Sin asignar') AS tecnico, "
                + "c.nombre AS categoria, e.nombre AS estado "
                + "FROM incidencia i "
                + "INNER JOIN usuario u ON i.usuario_id = u.id_usuario "
                + "LEFT JOIN tecnico t ON i.tecnico_id = t.id_tecnico "
                + "INNER JOIN categoria c ON i.categoria_id = c.id_categoria "
                + "INNER JOIN estado e ON i.estado_id = e.id_estado "
                + "WHERE (? IS NULL OR e.nombre = ?) "
                + "AND (? IS NULL OR c.nombre = ?) "
                + "AND (? IS NULL OR i.prioridad = ?) "
                + "ORDER BY i.fecha DESC, i.hora DESC";
        try (Connection conn = conectar(); PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, estado);
            pst.setString(2, estado);
            pst.setString(3, categoria);
            pst.setString(4, categoria);
            pst.setString(5, prioridad);
            pst.setString(6, prioridad);
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    lista.add(new Object[]{rs.getString("ticket"), rs.getDate("fecha"),
                        rs.getTime("hora"), rs.getString("titulo"), rs.getString("prioridad"),
                        rs.getString("usuario"), rs.getString("tecnico"),
                        rs.getString("categoria"), rs.getString("estado")});
                }
            }
        }
        return lista;
    }

    public List<String[]> reporteIncidencias(String estado, String categoria) throws SQLException {
        List<String[]> lista = new ArrayList<>();
        for (Object[] datos : listar("Todos".equals(estado) ? null : estado,
                "Todas".equals(categoria) ? null : categoria, null)) {
            String[] fila = new String[datos.length];
            for (int i = 0; i < datos.length; i++) {
                fila[i] = datos[i] == null ? "" : datos[i].toString();
            }
            lista.add(fila);
        }
        return lista;
    }

    public List<String[]> reporteIncidenias(String estado, String categoria) throws SQLException {
        return reporteIncidencias(estado, categoria);
    }

    public List<String[]> reportePorTecnico() throws SQLException {
        List<String[]> lista = new ArrayList<>();
        String sql = "SELECT CONCAT(t.nombres, ' ', t.apellidos) AS tecnico, "
                + "COUNT(i.id_incidencia) AS total FROM tecnico t "
                + "LEFT JOIN incidencia i ON t.id_tecnico = i.tecnico_id "
                + "GROUP BY t.id_tecnico, t.nombres, t.apellidos ORDER BY total DESC";
        try (Connection conn = conectar(); PreparedStatement pst = conn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                lista.add(new String[]{rs.getString("tecnico"), rs.getString("total")});
            }
        }
        return lista;
    }
    public List<String[]> reportePorCategoria() throws SQLException {
        List<String[]> lista = new ArrayList<>();
        String sql = "SELECT c.nombre AS categoria, COUNT(i.id_incidencia) AS total "
                + "FROM categoria c LEFT JOIN incidencia i ON c.id_categoria = i.categoria_id "
                + "GROUP BY c.id_categoria, c.nombre ORDER BY total DESC";
        try (Connection conn = conectar(); PreparedStatement pst = conn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                lista.add(new String[]{rs.getString("categoria"), rs.getString("total")});
            }
        }
        return lista;
    }
}