<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ShopSphere - Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <div class="container mt-4 flex-grow-1">
        <% 
            String searchQuery = (String) request.getAttribute("searchQuery");
            if (searchQuery != null) {
        %>
            <h4 class="mb-4">Search Results for: "<%= searchQuery %>"</h4>
        <% } else { %>
            <div class="p-4 mb-5 bg-white rounded-3 shadow-sm border text-center" style="background: linear-gradient(180deg, #f8f9fa 0%, #e9ecef 100%);">
                <h1 class="display-5 fw-bold text-dark">Welcome to ShopSphere</h1>
                <p class="col-md-8 mx-auto fs-5 text-muted">Your simple destination for amazing products.</p>
            </div>
            <h3 class="mb-4 text-start">Featured Products</h3>
        <% } %>

        <% 
            String error = request.getParameter("error");
            if ("CartFailed".equals(error)) {
        %>
            <div class="alert alert-danger">Failed to add item to cart. Please log in first.</div>
        <% } %>

        <div class="row row-cols-1 row-cols-md-4 g-4 mb-5">
            <% 
                List<Product> products = (List<Product>) request.getAttribute("productList");
                if (products != null && !products.isEmpty()) {
                    for (Product p : products) {
            %>
            <div class="col">
                <div class="card h-100 p-2">
                    <% String imgSrc = (p.getImage() != null && !p.getImage().isEmpty()) ? p.getImage() : "https://via.placeholder.com/200"; %>
                    <img src="<%= imgSrc %>" class="card-img-top product-img" alt="<%= p.getName() %>">
                    <div class="card-body d-flex flex-column pt-1">
                        <h5 class="card-title text-truncate mb-1" title="<%= p.getName() %>"><%= p.getName() %></h5>
                        <p class="card-text text-muted small mb-2"><%= p.getCategory() %></p>
                        <h4 class="card-text text-dark mb-3">$<%= String.format("%.2f", p.getPrice()) %></h4>
                        <div class="mt-auto">
                            <a href="<%= request.getContextPath() %>/addToCart?productId=<%= p.getId() %>" class="btn btn-warning w-100 rounded-pill mb-2 shadow-sm">Add to Cart</a>
                            <a href="<%= request.getContextPath() %>/productDetails?id=<%= p.getId() %>" class="btn btn-outline-secondary btn-sm w-100 rounded-pill">View Details</a>
                        </div>
                    </div>
                </div>
            </div>
            <% 
                    }
                } else {
            %>
            <div class="col-12 text-center mt-5">
                <h4 class="text-muted">No products found.</h4>
            </div>
            <% } %>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>
