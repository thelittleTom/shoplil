package user;

import DAO.UserDao;
import org.apache.commons.beanutils.BeanUtils;
import utils.CookieUtils;
import utils.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;

@WebServlet("/user/Regist")
public class ServletRegist extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user=new User();
        try {
            BeanUtils.populate(user, request.getParameterMap());
        } catch (IllegalAccessException | InvocationTargetException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        try {
            if(UserDao.getUsername(user.getUsername())!=null) {
                request.setAttribute("message", "!!用户名已存在");
                RequestDispatcher dispatcher=request.getRequestDispatcher(request.getContextPath() + "/user/register.jsp");
                dispatcher.forward(request,response);
                return;
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        try {
            UserDao.insertUser(user);
        } catch (SQLException e) {
            request.setAttribute("message", "注册出现错误，请重新注册");
            RequestDispatcher dispatcher=request.getRequestDispatcher(request.getContextPath() + "/user/register.jsp");
            dispatcher.forward(request,response);
            e.printStackTrace();
            return;
        }
        try {
            User du= UserDao.getUsername(user.getUsername());
            CookieUtils.createCookie(response,"username",user.getUsername());
            CookieUtils.createCookie(response,"userId",Integer.toString(du.getId()));
            System.out.print("cookie创建成功");
            response.sendRedirect(request.getContextPath() + "/Buyer/buyerProduct.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
