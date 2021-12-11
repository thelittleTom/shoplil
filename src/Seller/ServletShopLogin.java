package Seller;

import DAO.ShopDao;
import DAO.UserDao;
import utils.CookieUtils;
import utils.Shop;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet( "/Seller/shopLogin")
public class ServletShopLogin extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId=request.getParameter("userId");
        int uId=Integer.parseInt(userId);
        try {
            Shop shop=ShopDao.getShopIdByUserId(uId);
            if(shop==null){
                //还没有店铺
                response.sendRedirect(request.getContextPath()+"/Seller/sellerShopRegister.jsp?userId="+userId);
            }
            else {
               CookieUtils.createCookie(response,"shopName",shop.getName());
               CookieUtils.createCookie(response,"shopId",shop.getId());
               response.sendRedirect(request.getContextPath()+"/Seller/sellerCart.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
