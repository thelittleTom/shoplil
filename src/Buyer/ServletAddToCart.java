package Buyer;

import DAO.CartItemDao;
import org.apache.commons.beanutils.BeanUtils;
import utils.CartItem;
import utils.CookieUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;

@WebServlet("/Buyer/addToCart")
public class ServletAddToCart extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId= CookieUtils.getCookieValue(request,"userId");
        CartItem cartItem=new CartItem();
        try {
            BeanUtils.populate(cartItem, request.getParameterMap());
        } catch (IllegalAccessException | InvocationTargetException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        cartItem.setUserId(Integer.parseInt(userId));
        System.out.println(cartItem);

        try {
            int buyNum=CartItemDao.getBuyNum(cartItem);
           if(buyNum==0)  CartItemDao.addToCart(cartItem);
           else{
                CartItemDao.updateBuyNum(cartItem.getProductId(),cartItem.getUserId(),buyNum+1);
           }
            request.setAttribute("cart",true);
            request.getRequestDispatcher("/Buyer/buyerProduct.jsp").forward(request,response);
        } catch (SQLException e) {
            request.setAttribute("cart",false);
            request.getRequestDispatcher("/Buyer/buyerProduct.jsp").forward(request,response);
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
