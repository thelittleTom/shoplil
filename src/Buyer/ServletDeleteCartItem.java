package Buyer;

import DAO.CartItemDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/Buyer/deleteCartItem")
public class ServletDeleteCartItem extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uId=request.getParameter("userId");
        String pId=request.getParameter("productId");
        int userId=Integer.parseInt(uId);
        int productId=Integer.parseInt(pId);
        try {
            CartItemDao.deleteCartItem(userId,productId);
            response.sendRedirect(request.getContextPath()+"/Buyer/buyerCart.jsp?userId="+uId+"&productId="+pId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
