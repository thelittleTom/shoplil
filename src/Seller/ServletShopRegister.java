package Seller;

import DAO.ShopDao;
import DAO.UserDao;
import org.apache.commons.beanutils.BeanUtils;
import utils.CookieUtils;
import utils.IdUtils;
import utils.Shop;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;

@WebServlet("/Seller/shopRegister")
public class ServletShopRegister extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Shop shop=new Shop();
        try {
            BeanUtils.populate(shop, request.getParameterMap());
        } catch (IllegalAccessException | InvocationTargetException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        shop.setId(IdUtils.getUUID());
        System.out.println(shop);
        try {
            ShopDao.insertProduct(shop);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        CookieUtils.createCookie(response,"shopName",shop.getName());
        CookieUtils.createCookie(response,"shopId",shop.getId());
        response.sendRedirect(request.getContextPath()+"/Seller/sellerCart.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
