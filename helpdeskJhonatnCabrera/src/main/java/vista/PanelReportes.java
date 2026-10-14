package vista;
import java.awt.*;
import java.util.*;
import javax.swing.*;
import javax.swing.table.*;

public class PanelReportes extends JPanel {
    public final JComboBox<String> filtroEstado = new JComboBox<>(new String[]{"Todos"});
    public final JComboBox<String> filtroCategoria = new JComboBox<>(new String[]{"Todas"});
    public final JComboBox<String> filtroPrioridad = new JComboBox<>(new String[]{"Todas"});
    public final JTextField institucion = new JTextField("INSTITUCIÓN", 25);
    public final JButton actualizar = new JButton("Actualizar");
    public final JButton exportarPDF = new JButton("Exportar PDF");
    public final JLabel estado = new JLabel(" ");
    private final DefaultTableModel modelo = new DefaultTableModel(new String[]{"Ticket", "Fecha", "Hora", "Título", "Prioridad", "Usuario", "Técnico", "Categoría", "Estado"},0) {
        public boolean isCellEditable(int row,int column) {return false;}
    };
    public final JTable tabla = new JTable(modelo);
    public PanelReportes() {
        super(new BorderLayout(8,8)); setBorder(BorderFactory.createEmptyBorder(12,12,12,12));
        JPanel cabecera=new JPanel(new GridLayout(2,1));
        JPanel acciones=new JPanel(new FlowLayout(FlowLayout.LEFT));
        acciones.add(new JLabel("Institución:")); acciones.add(institucion); acciones.add(actualizar); acciones.add(exportarPDF);
        JPanel filtros=new JPanel(new FlowLayout(FlowLayout.LEFT));
        filtros.add(new JLabel("Estado:")); filtros.add(filtroEstado);
        filtros.add(new JLabel("Categoría:")); filtros.add(filtroCategoria);
        filtros.add(new JLabel("Prioridad:")); filtros.add(filtroPrioridad);
        cabecera.add(acciones); cabecera.add(filtros); add(cabecera,BorderLayout.NORTH);
        tabla.setAutoCreateRowSorter(true); tabla.setAutoResizeMode(JTable.AUTO_RESIZE_OFF); tabla.setRowHeight(25);
        int[] anchos={100,100,90,260,90,160,160,180,110};
        for(int i=0;i<anchos.length;i++) tabla.getColumnModel().getColumn(i).setPreferredWidth(anchos[i]);
        add(new JScrollPane(tabla),BorderLayout.CENTER); add(estado,BorderLayout.SOUTH);
    }
    public String seleccionado(JComboBox<String> filtro) { return filtro.getSelectedIndex()<=0 ? null : (String)filtro.getSelectedItem(); }
    public void opciones(java.util.List<Object[]> filas) {
        llenar(filtroEstado,filas,8); llenar(filtroCategoria,filas,7); llenar(filtroPrioridad,filas,4);
    }
    private void llenar(JComboBox<String> filtro,java.util.List<Object[]> filas,int columna) {
        Set<String> valores=new TreeSet<>();
        for(Object[] fila:filas) if(fila[columna]!=null) valores.add(fila[columna].toString());
        for(String valor:valores) filtro.addItem(valor);
    }
    public void mostrar(java.util.List<Object[]> filas) {
        modelo.setRowCount(0); for(Object[] fila:filas) modelo.addRow(fila);
        estado.setText("Total de incidencias: "+filas.size());
    }
    public java.util.List<Object[]> filasVisibles() {
        java.util.List<Object[]> filas=new ArrayList<>();
        for(int i=0;i<tabla.getRowCount();i++) { Object[] fila=new Object[9]; for(int j=0;j<9;j++) fila[j]=tabla.getValueAt(i,j); filas.add(fila); }
        return filas;
    }
    public void ocupado(boolean valor) {
        actualizar.setEnabled(!valor); exportarPDF.setEnabled(!valor);
        filtroEstado.setEnabled(!valor); filtroCategoria.setEnabled(!valor); filtroPrioridad.setEnabled(!valor); institucion.setEnabled(!valor);
    }
}
