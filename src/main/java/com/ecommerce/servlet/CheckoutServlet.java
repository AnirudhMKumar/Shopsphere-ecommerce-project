package com.ecommerce.servlet;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.ecommerce.dao.CartDAO;
import com.ecommerce.dao.OrderDAO;
import com.ecommerce.model.Cart;
import com.ecommerce.model.User;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }

        CartDAO cartDAO = new CartDAO();
        List<Cart> cartList = cartDAO.getCartItemsByUser(currentUser.getId());
        
        if (cartList == null || cartList.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart?error=empty");
            return;
        }
        
        OrderDAO orderDAO = new OrderDAO();
        if (orderDAO.placeOrder(currentUser.getId(), cartList)) {
            response.sendRedirect(request.getContextPath() + "/user/orderSuccess.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/cart?error=checkoutFailed");
        }
    }
}
