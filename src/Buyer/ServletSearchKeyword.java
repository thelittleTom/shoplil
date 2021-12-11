package Buyer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import DAO.ProductDao;
import utils.Product;
import utils.SearchKeyword;

@WebServlet("/Buyer/searchKeyword")
public class ServletSearchKeyword extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword=request.getParameter("keyword");
        String category=request.getParameter("category");
        System.out.println(category);
        List<Product> products = new ArrayList<Product>();
        if(category.equals("-1")){
            try {
                products = ProductDao.listAll();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }else{
            try {
                products=ProductDao.listAllByCategory(category);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        String rst="_";
        for(int i=0;i<products.size();i++){
            if(SearchKeyword.isContenKeyword(keyword,products.get(i).getName())){
                rst+=products.get(i).getId()+"_";
            }
        }
        System.out.println("rst |"+rst);
        response.sendRedirect(request.getContextPath()+"/Buyer/buyerProduct.jsp?productIds="+rst);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
