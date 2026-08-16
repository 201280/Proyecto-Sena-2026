package com.mycompany.proyectowebproductos;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

  public int generarCodigoNumerico(String categoria) {
        int prefijoBase = 100;

        if (categoria != null) {
            String cat = categoria.toLowerCase().trim();
            if (cat.contains("bebida")) {
                prefijoBase = 200;
            } else if (cat.contains("verdura") || cat.contains("fruta")) {
                prefijoBase = 300;
            } else if (cat.contains("harina") || cat.contains("insumo")) {
                prefijoBase = 400;
            } else if (cat.contains("enlatado")) {
                prefijoBase = 500;
            } else if (cat.contains("azuc") || cat.contains("azú")) {
                prefijoBase = 600;
            } else {
                prefijoBase = 100;
            }
        }

        // 1. LAS VARIABLES SE DECLARAN AQUÍ AFUERA DEL TRY
        int rangoInicio = prefijoBase + 1;
        int rangoFin = prefijoBase + 99;
        int ultimoCodigo = 0;

        String sql = "SELECT MAX(codigo) FROM productos WHERE codigo BETWEEN ? AND ?";

        // 2. CONSULTA A LA BASE DE DATOS
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, rangoInicio);
            ps.setInt(2, rangoFin);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ultimoCodigo = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // 3. RETORNO DE VALORES (AQUÍ YA TIENE ACCESO A LAS VARIABLES)
        if (ultimoCodigo == 0) {
            return rangoInicio;
        } else {
            return ultimoCodigo + 1;
        }
    }
    public List<Producto> listar() {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM productos";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Producto p = new Producto();
                p.setId(rs.getInt("id"));
                p.setCodigo(rs.getInt("codigo"));
                p.setNombre(rs.getString("nombre"));
                p.setCategoria(rs.getString("categoria"));
                p.setPrecio(rs.getDouble("precio"));
                p.setStock(rs.getInt("stock"));
                lista.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean insertar(Producto p) {
        String sql = "INSERT INTO productos (codigo, nombre, categoria, precio, stock) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, p.getCodigo());
            ps.setString(2, p.getNombre());
            ps.setString(3, p.getCategoria());
            ps.setDouble(4, p.getPrecio());
            ps.setInt(5, p.getStock());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Producto obtenerPorId(int id) {
        Producto p = null;
        String sql = "SELECT * FROM productos WHERE id = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                p = new Producto();
                p.setId(rs.getInt("id"));
                p.setCodigo(rs.getInt("codigo"));
                p.setNombre(rs.getString("nombre"));
                p.setCategoria(rs.getString("categoria"));
                p.setPrecio(rs.getDouble("precio"));
                p.setStock(rs.getInt("stock"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return p;
    }

    public boolean actualizar(Producto p) {
        String sql = "UPDATE productos SET nombre = ?, categoria = ?, precio = ?, stock = ? WHERE id = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getCategoria());
            ps.setDouble(3, p.getPrecio());
            ps.setInt(4, p.getStock());
            ps.setInt(5, p.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM productos WHERE id = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}