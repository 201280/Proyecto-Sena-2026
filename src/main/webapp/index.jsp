<%
    Producto pEditar = (Producto) request.getAttribute("productoEditar");
    boolean esEdicion = (pEditar != null);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.proyectowebproductos.ProductoDAO"%>
<%@page import="com.mycompany.proyectowebproductos.Producto"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inventario - Panadería y Pastelería</title>
    <!-- Estilos CSS integrados para diseño temático -->
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #fcf8f2;
            color: #4a3b32;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            background: #ffffff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            border-top: 6px solid #d97706;
        }

        /* Encabezado con Logo */
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 2px solid #f3e8ff;
            padding-bottom: 15px;
            margin-bottom: 25px;
        }

        .header-title {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo-icon {
            font-size: 42px;
            background: #fef3c7;
            padding: 10px;
            border-radius: 50%;
            border: 2px solid #f59e0b;
        }

        h1 {
            margin: 0;
            color: #78350f;
            font-size: 26px;
        }

        p.subtitle {
            margin: 3px 0 0 0;
            color: #92400e;
            font-size: 14px;
        }

        /* Formulario */
        .card-form {
            background-color: #fffbeb;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #fde68a;
            margin-bottom: 30px;
        }

        .card-form h2 {
            margin-top: 0;
            color: #92400e;
            font-size: 18px;
            border-bottom: 1px solid #fcd34d;
            padding-bottom: 8px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 15px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: 600;
            margin-bottom: 5px;
            font-size: 13px;
            color: #78350f;
        }

        input[type="text"],
        input[type="number"] {
            padding: 10px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
        }

        input:focus {
            border-color: #d97706;
        }

        .btn-submit {
            background-color: #d97706;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 15px;
            font-weight: bold;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.2s;
            width: 100%;
        }

        .btn-submit:hover {
            background-color: #b45309;
        }

        /* Tabla de Productos */
        .table-title {
            color: #78350f;
            font-size: 20px;
            margin-bottom: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            overflow: hidden;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }

        th {
            background-color: #b45309;
            color: white;
            text-align: left;
            padding: 12px 15px;
            font-size: 14px;
        }

        td {
            padding: 12px 15px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 14px;
        }

        tr:nth-child(even) {
            background-color: #fffbeb;
        }

        tr:hover {
            background-color: #fef3c7;
        }
    </style>
</head>
<body>

    <div class="container">
        <!-- Encabezado con Logo y Título -->
        <!-- Encabezado con Logo Profesional -->
        <div class="header">
            <div class="header-title">
               <img src="logo.png" 
     alt="Logo Panadería" 
     style="width: 85px; height: auto; border-radius:8px;">
                <div>
                    <h1>Panadería & Pastelería "El Buen Pan"</h1>
                    <p class="subtitle">Sistema de Control de Inventario</p>
                </div>
            </div>
        </div>

        <!-- Formulario de Registro -->
        <div class="card-form">
            <h2>📝 Registrar Nuevo Producto</h2>
           <form action="${pageContext.request.contextPath}/ProductoServlet" method="POST">
                <!-- Campo oculto para el ID -->
                <input type="hidden" name="id" value="<%= esEdicion ? pEditar.getId() : "" %>">

                <div class="form-grid">
                    <div class="form-group">
                        <label>Nombre del Producto:</label>
                        <input type="text" name="nombre" required 
                               value="<%= esEdicion ? pEditar.getNombre() : "" %>" 
                               placeholder="Ej: Pan Aliñado">
                    </div>
                    <div class="form-group">
    <label for="categoria">Categoría:</label>
    <select name="categoria" id="categoria" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;" required>
        <option value="Panes">Panes</option>
        <option value="Bebidas">Bebidas</option>
        <option value="Verduras">Verduras</option>
        <option value="Enlatados">Enlatados</option>
        <option value="Harinas">Harinas</option>
        <option value="Azucar">Azucar</option>
        <option value="Productos Varios">Productos Varios</option>
    </select>
</div>
                    <div class="form-group">
                        <label>Precio ($):</label>
                        <input type="number" step="0.01" name="precio" required 
                               value="<%= esEdicion ? pEditar.getPrecio() : "" %>" 
                               placeholder="0.00">
                    </div>
                    <div class="form-group">
                        <label>Stock Inicial:</label>
                        <input type="number" name="stock" required 
                               value="<%= esEdicion ? pEditar.getStock() : "" %>" 
                               placeholder="Cantidad">
                    </div>
                </div>

                <button type="submit" class="btn-guardar" style="width: 100%; padding: 12px; background: #ea580c; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: bold; margin-top: 10px;">
                    <%= esEdicion ? "💾 Actualizar Producto" : "💾 Guardar Producto en Inventario" %>
                </button>
            </form>
        </div>

        <!-- Tabla de Registros -->
        <h2 class="table-title">📋 Productos en Inventario</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Código</th>
                    <th>Nombre</th>
                    <th>Categoría</th>
                    <th>Precio</th>
                    <th>Stock</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ProductoDAO dao = new ProductoDAO();
                    List<Producto> lista = dao.listar();
                    if (lista != null && !lista.isEmpty()) {
                        for (Producto p : lista) {
                %>
                <tr>
                    <td><%= p.getId() %></td>
                    <td><%= p.getCodigo() %></td>
                    <td><%= p.getNombre() %></td>
                    <td><%= p.getCategoria() %></td>
                    <td><%= String.format(new java.util.Locale("es", "CO"), "%,.2f", p.getPrecio()) %></td>
                    <td><%= p.getStock() %></td>
                    <td>
    <a href="ProductoServlet?accion=eliminar&id=<%= p.getId() %>" 
       onclick="return confirm('¿Seguro que deseas eliminar este producto?');"
       style="color: #dc2626; text-decoration: none; font-weight: bold; background: #fee2e2; padding: 4px 8px; border-radius: 4px;">
       🗑️ Eliminar
    </a>
       <a href="ProductoServlet?accion=editar&id=<%= p.getId() %>" 
   style="color: #0284c7; text-decoration: none; font-weight: bold; background: #e0f2fe; padding: 4px 8px; border-radius: 4px; margin-left: 5px;">
   ✏️ Editar
</a>
</td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5" style="text-align: center; color: #94a3b8;">No hay productos registrados actualmente.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

</body>
</html>