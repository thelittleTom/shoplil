package Buyer;

import DAO.CartItemDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/Buyer/changeBuyNum")
public class ServletChangeBuyNum extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int uId=Integer.parseInt(request.getParameter("userId"));
        int pId=Integer.parseInt(request.getParameter("productId"));
        int buyNum=Integer.parseInt(request.getParameter("buyNum"));
        System.out.println(uId+"-"+pId+"-"+buyNum);
        try {
            CartItemDao.updateBuyNum(pId,uId,buyNum);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
