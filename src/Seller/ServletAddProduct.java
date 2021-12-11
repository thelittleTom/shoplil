package Seller;

import DAO.ProductDao;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import utils.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

//@WebServlet("/Seller/addProduct")
//public class ServletAddProduct extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        Product product=new Product();
//        try {
//            BeanUtils.populate(product, request.getParameterMap());
//            System.out.println(request.getParameterMap());
//        } catch (IllegalAccessException | InvocationTargetException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }
//        System.out.println(product);
//        try {
//            ProductDao.insertProduct(product);
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return;
//        }
//        System.out.println(product);
//        request.setAttribute("message", "ok");
//        RequestDispatcher dispatcher=request.getRequestDispatcher(request.getContextPath() + "/Seller/sellerCart.jsp");
//        dispatcher.forward(request,response);
//    }
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        doPost(request,response);
//    }
//}

//上传文件的Servlet类
@WebServlet("/Seller/addProduct")
public class ServletAddProduct extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cookie []cookies=request.getCookies();//获取所有的Cookie
        String shopId=null;

        for (Cookie cookie : cookies) {
            if(cookie.getName().equals("shopId")){//寻找需要的值
                shopId=cookie.getValue();
            }
        }
        request.getSession().setAttribute("add",false);
        Map<String,Object> map=new HashMap<String, Object>();
        try {
            // 创建DiskFileItemFactory工厂对象
            DiskFileItemFactory factory = new DiskFileItemFactory();
            //设置文件缓存目录，如果该目录不存在则新创建一个
            File f = new File("/usr/java/tomcat/cash");
            if (!f.exists()) {
                f.mkdirs();
            }
            System.out.println(factory.getSizeThreshold());
            // 设置文件的缓存路径
            factory.setRepository(f);
            // 创建 ServletFileUpload对象
            ServletFileUpload fileupload = new ServletFileUpload(factory);
            //设置字符编码
            fileupload.setHeaderEncoding("utf-8");
            // 解析 request，得到上传文件的FileItem对象
            List<FileItem> fileitems = fileupload.parseRequest(request);
            // 遍历集合
            for (FileItem fileitem : fileitems) {
                // 判断是否为普通字段
                if (fileitem.isFormField()) {
                    // 获得字段名和字段值
                    String name = fileitem.getFieldName();
                    map.put(name,fileitem.getString("utf-8"));
                    System.out.println(name+fileitem.getString("utf-8"));
                } else {
                    // 获取上传的文件名
                    String filename = fileitem.getName();
                    //处理上传文件
                    if(filename != null && !filename.equals("")){
                        System.out.print("上传的文件名称是：" + filename + "<br>");
                        // 截取出文件名
                        filename = filename.substring(filename.lastIndexOf("\\") + 1);
                        // 文件名需要唯一
                        filename = UUID.randomUUID().toString() + "_" + filename;
                        // 在服务器创建同名文件
                        String webPath ="/upload/";
                        //将服务器中文件夹路径与文件名组合成完整的服务器端路径
                        String filepath = getServletContext().getRealPath(webPath + filename);
                        System.out.println(filepath);
                        // 创建文件
                        File file = new File(filepath);
                        file.getParentFile().mkdirs();
 //                       file.createNewFile();
                        // 获得上传文件流
                        fileitem.write(file);
//                        InputStream in = fileitem.getInputStream();
//                        // 使用FileOutputStream打开服务器端的上传文件
//                        FileOutputStream out = new FileOutputStream(file);
//                        // 流的对拷
//                        byte[] buffer = new byte[1024];//每次读取1个字节
//                        int len;
//                        //开始读取上传文件的字节，并将其输出到服务端的上传文件输出流中
//                        while ((len = in.read(buffer)) > 0)
//                            out.write(buffer, 0, len);
//                        out.getFD().sync();
//                        // 关闭流
//                        in.close();
//                        out.close();
                        // 删除临时文件
                        fileitem.delete();
                       System.out.print("上传文件成功！<br>");
                       map.put("imgurl",webPath + filename);
                    }
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        Product product=new Product();
        try {
            BeanUtils.populate(product, map);
        } catch (IllegalAccessException | InvocationTargetException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        product.setShopId(shopId);
        System.out.println(product);
        try {
            ProductDao.insertProduct(product);
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }
        request.getSession().setAttribute("add",true);
        response.sendRedirect(request.getContextPath() + "/Seller/sellerCart.jsp");
//        RequestDispatcher dispatcher=request.getRequestDispatcher(request.getContextPath() + "/Seller/sellerCart.jsp");
//        dispatcher.forward(request,response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
