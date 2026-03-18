package com.ecommerce.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.ecommerce.model.Cart;
import com.ecommerce.model.Order;
import com.ecommerce.util.DBConnection;

public class OrderDAO {

    public boolean placeOrder(int userId, List<Cart> cartList) {
        boolean isSuccess = false;
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false); // Enable transaction

            // Calculate total amount
            double totalAmount = 0.0;
            for (Cart c : cartList) {
                totalAmount += c.getProduct().getPrice() * c.getQuantity();
            }

            // Insert into orders table
            String orderQuery = "INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, ?)";
            PreparedStatement orderPst = con.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS);
            orderPst.setInt(1, userId);
            orderPst.setDouble(2, totalAmount);
            orderPst.setString(3, "Processing");
            orderPst.executeUpdate();

            // Get generated order ID
            ResultSet rs = orderPst.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // Insert into order_items table
            String itemQuery = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            PreparedStatement itemPst = con.prepareStatement(itemQuery);
            for (Cart c : cartList) {
                itemPst.setInt(1, orderId);
                itemPst.setInt(2, c.getProductId());
                itemPst.setInt(3, c.getQuantity());
                itemPst.setDouble(4, c.getProduct().getPrice());
                itemPst.addBatch();
            }
            itemPst.executeBatch();

            // Clear the user's cart
            String clearCartQuery = "DELETE FROM cart WHERE user_id=?";
            PreparedStatement clearCartPst = con.prepareStatement(clearCartQuery);
            clearCartPst.setInt(1, userId);
            clearCartPst.executeUpdate();

            con.commit(); // Commit transaction
            isSuccess = true;
        } catch (Exception e) {
            try {
                if (con != null) con.rollback(); // Rollback on failure
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return isSuccess;
    }

    public List<Order> getUserOrders(int userId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE user_id=? ORDER BY id DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(query)) {
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getDouble("total_amount"),
                    rs.getTimestamp("order_date"),
                    rs.getString("status")
                );
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders ORDER BY id DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(query)) {
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getDouble("total_amount"),
                    rs.getTimestamp("order_date"),
                    rs.getString("status")
                );
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        boolean isSuccess = false;
        String query = "UPDATE orders SET status=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(query)) {
            pst.setString(1, status);
            pst.setInt(2, orderId);
            int rowCount = pst.executeUpdate();
            if (rowCount > 0) isSuccess = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }
}
