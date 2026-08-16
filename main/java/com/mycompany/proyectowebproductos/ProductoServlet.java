package com.mycompany.proyectowebproductos;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ProductoServlet")
public class ProductoServlet extends HttpServlet {

    // Método POST para recibir los datos del formulario HTML
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String categoria = request.getParameter("categoria");
        double precio = Double.parseDouble(request.getParameter("precio"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        
       ProductoDAO dao = new ProductoDAO();

        if (idStr != null && !idStr.trim().isEmpty()) {
            // Edición de producto existente
            int id = Integer.parseInt(idStr);
            Producto pExistente = dao.obtenerPorId(id);
            pExistente.setNombre(nombre);
            pExistente.setCategoria(categoria);
            pExistente.setPrecio(precio);
            pExistente.setStock(stock);
            dao.actualizar(pExistente);
        } else {
            // Producto nuevo con código automático
            Producto nuevoProducto = new Producto(nombre, categoria, precio, stock);
            int nuevoCodigo = dao.generarCodigoNumerico(categoria);
            nuevoProducto.setCodigo(nuevoCodigo);
            dao.insertar(nuevoProducto);
        }

        response.sendRedirect("ProductoServlet");
    }

    // Método GET para consultas directas
   
  @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductoDAO dao = new ProductoDAO();
            dao.eliminar(id);
            response.sendRedirect("index.jsp");
        } else if ("editar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductoDAO dao = new ProductoDAO();
            Producto p = dao.obtenerPorId(id);
            request.setAttribute("productoEditar", p);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
    }
     }
