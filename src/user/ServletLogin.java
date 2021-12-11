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

@WebServlet( "/user/Login")
public class ServletLogin extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user=new User();
        try {
            BeanUtils.populate(user, request.getParameterMap());
        } catch (IllegalAccessException | InvocationTargetException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        UserDao uDao=new UserDao();
        try {
            User db_user=uDao.getUsername(user.getUsername());
            System.out.println("exist  -d-");
            if(db_user!=null) {
                //存在此用户
                String pwd=db_user.getPassword();
                if(pwd.equals(user.getPassword())){
                    CookieUtils.createCookie(response,"username",user.getUsername());
                    CookieUtils.createCookie(response,"userId",Integer.toString( db_user.getId()));
                        System.out.print("cookie创建成功");

                    //密码正确
                    response.sendRedirect(request.getContextPath() + "/Buyer/buyerProduct.jsp");
                }else{
                    request.setAttribute("message", "密码错误！！");
                    RequestDispatcher dispatcher=request.getRequestDispatcher(request.getContextPath() + "/user/login.jsp");
                    dispatcher.forward(request,response);
                    return;
                }
            }else{
                request.setAttribute("message", "用户名不存在！！");
                RequestDispatcher dispatcher=request.getRequestDispatcher(request.getContextPath() + "/user/login.jsp");
                dispatcher.forward(request,response);
                return;
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
