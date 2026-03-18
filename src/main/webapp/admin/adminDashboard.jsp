<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="../navbar.jsp" />

    <div class="container mt-4 flex-grow-1">
        <h2 class="mb-4">Admin Dashboard</h2>
        
        <div class="mb-4 bg-white p-3 rounded shadow-sm border d-flex justify-content-between align-items-center">
            <div>
                <a href="<%= request.getContextPath() %>/admin/addProduct.jsp" class="btn btn-warning px-4 fw-bold">Add New Product</a>
                <a href="<%= request.getContextPath() %>/adminOrders" class="btn btn-outline-dark px-4 ms-2">View Customer Orders</a>
            </div>
            <div class="text-muted small">Manage your store catalog</div>
        </div>
        
        <% if (request.getParameter("msg") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <strong>Success!</strong> Operation completed: <%= request.getParameter("msg") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <strong>Error!</strong> Operation failed: <%= request.getParameter("error") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <div class="table-responsive">
            <table class="table table-bordered table-custom shadow-sm bg-white table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th width="5%">ID</th>
                        <th width="10%">Image</th>
                        <th width="35%">Product Name</th>
                        <th width="15%">Category</th>
                        <th width="10%">Price</th>
                        <th width="25%">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Product> products = (List<Product>) request.getAttribute("productList");
                        if (products != null && !products.isEmpty()) {
                            for (Product p : products) {
                    %>
                    <tr>
                        <td class="text-center fw-bold"><%= p.getId() %></td>
                        <td class="text-center"><img src="<%= p.getImage() %>" alt="img" style="height:50px; width:50px; object-fit:contain;" class="img-thumbnail"></td>
                        <td><a href="<%= request.getContextPath() %>/productDetails?id=<%= p.getId() %>" class="text-decoration-none text-info fw-bold"><%= p.getName() %></a></td>
                        <td><span class="badge bg-secondary"><%= p.getCategory() %></span></td>
                        <td class="fw-bold">$<%= String.format("%.2f", p.getPrice()) %></td>
                        <td>
                            <a href="<%= request.getContextPath() %>/admin/editProduct.jsp?id=<%= p.getId() %>" class="btn btn-sm btn-outline-primary px-3 shadow-sm rounded-1">Edit</a>
                            <a href="<%= request.getContextPath() %>/deleteProduct?id=<%= p.getId() %>" class="btn btn-sm btn-outline-danger px-3 shadow-sm rounded-1 ms-1" onclick="return confirm('Are you sure you want to delete this product?');">Delete</a>
                        </td>
                    </tr>
                    <%      }
                        } else {
                    %>
                    <tr>
                        <td colspan="6" class="text-center py-5 text-muted">
                            <h5>No products found in catalog.</h5>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <jsp:include page="../footer.jsp" />
</body>
</html>
