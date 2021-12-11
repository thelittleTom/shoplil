package Buyer;

import DAO.*;
import org.apache.commons.beanutils.BeanUtils;
import utils.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.Date;

@WebServlet( "/Buyer/settleAccounts")
public class ServletSettleAccounts extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Orders orders=new Orders();
        try {
            BeanUtils.populate(orders, request.getParameterMap());
        } catch (IllegalAccessException | InvocationTargetException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        Date reDate=new Date(System.currentTimeMillis());
        orders.setOrderTime(reDate);
        String idstr=IdUtils.getUUID();
        orders.setId(idstr);
        System.out.println(orders);
        try {
            OrdersDao.insertOrders(orders);
            String products=request.getParameter("productId");
            String pIds[]=products.split("_");
            for(int i=0;i<pIds.length;i++){
                int proId=Integer.parseInt(pIds[i]);
                OrderItem orderItem=new OrderItem();
                orderItem.setProductId(proId);
                orderItem.setOrderId(idstr);
                CartItem cartItem=new CartItem();
                cartItem.setUserId(orders.getUserId());
                cartItem.setProductId(proId);

                int buyNum=CartItemDao.getBuyNum(cartItem);
                orderItem.setBuyNum(buyNum);
                OrderItemDao.insertOrders(orderItem);

                ProductDao.updatePnum(proId,buyNum);

                CartItemDao.deleteCartItem(orders.getUserId(),proId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

//        response.sendRedirect(request.getContextPath()+"/Buyer/buyerProduct.jsp");
        request.getRequestDispatcher("/Buyer/buyerProduct.jsp").forward(request,response);
        //发送邮件
        User tmpuser= null;
        try {
            tmpuser = UserDao.getUserById(orders.getUserId());
            System.out.println(tmpuser);
            MailUtils.sendMail(tmpuser.getEmail(),"用户"+tmpuser.getUsername()+"\n\t您已购买了商品，请耐心等待商品送达","lilShop");
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
