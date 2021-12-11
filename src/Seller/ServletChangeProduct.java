package Seller;

import DAO.ProductDao;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import utils.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
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

@WebServlet("/Seller/changeProduct")
public class ServletChangeProduct extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String,Object> map= new HashMap<>();
        try {
            // 创建DiskFileItemFactory工厂对象
            DiskFileItemFactory factory = new DiskFileItemFactory();
            //设置文件缓存目录，如果该目录不存在则新创建一个
            File f = new File("F:\\Java\\CODE\\file");
            if (!f.exists()) {
                f.mkdirs();
            }
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
                    if(name=="imgurl" &&fileitem.getString("utf-8")==null){
                        continue;
                    }
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
                        String webPath = "/upload/";
                        //将服务器中文件夹路径与文件名组合成完整的服务器端路径
                        String filepath = getServletContext().getRealPath(webPath + filename);
                        System.out.println(filepath);
                        // 创建文件
                        File file = new File(filepath);
                        file.getParentFile().mkdirs();
                        // 获得上传文件流
                        fileitem.write(file);
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
        System.out.println(product);
        try {
            ProductDao.changeProduct(product);
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }
        response.sendRedirect(request.getContextPath() + "/Seller/sellerCart.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
