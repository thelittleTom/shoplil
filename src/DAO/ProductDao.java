package DAO;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import utils.DataSourceUtils;
import utils.Product;

import java.sql.SQLException;
import java.util.List;

public class ProductDao {
    public static Boolean insertProduct(Product product ) throws SQLException{
        QueryRunner runner=new QueryRunner(DataSourceUtils.getDataSource());
        String sql="insert into lilshop.product (name,price,category,pnum,imgurl,description,shopId) values(?,?,?,?,?,?,?)";
        int num=runner.update(sql, product.getName(),product.getPrice(),product.getcategory(),product.getPnum(),product.getImgurl(),product.getDescription(),product.getShopId());
        if(num>0) return true;
        return false;
    }
    public static Product getProductId(int productId) throws SQLException {
        QueryRunner runner=new QueryRunner(DataSourceUtils.getDataSource());
        String sql="SELECT p.*,s.`name` as shopName FROM lilshop.shop as s ,lilshop.product as p where s.id=p.shopId and p.id=?";
        Product product=(Product) runner.query(sql, new BeanHandler(Product.class),new Object[] {productId});
        return product;
    }
    public static List<Product> listAll() throws SQLException {
        String sql = "SELECT p.*,s.`name` as shopName FROM lilshop.shop as s ,lilshop.product as p where s.id=p.shopId";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanListHandler<Product>(Product.class));
    }
    public static List<Product> listAllByCategory(String Category) throws SQLException {
        String sql = "SELECT p.*,s.`name` as shopname FROM lilshop.shop as s ,lilshop.product as p where s.id=p.shopId and category="+Category;
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        return runner.query(sql, new BeanListHandler<Product>(Product.class));
    }
    public static List<Product> listAllByShopId(String shopId) throws SQLException {
        String sql = "select * from lilshop.product where shopId=?";
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        System.out.println(sql);
        List<Product> productList= runner.query(sql, new BeanListHandler<Product>(Product.class),shopId);
        System.out.println(productList.size());
        return productList;
    }
    public static boolean deleteProductById(int id) throws SQLException {
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        String sql="DELETE FROM lilshop.product WHERE `id` = "+id;
        int num=runner.update(sql);
        if(num>0) return true;
        else return  false;
    }
    public static boolean updatePnum(int proudctId,int buyNum) throws SQLException {
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        String sql="update lilshop.product set pnum=pnum-? where id=?";
        int num=runner.update(sql, buyNum,proudctId);
        if(num>0) return true;
        return  false;
    }
    public static boolean changeProduct(Product product) throws SQLException {
        QueryRunner runner = new QueryRunner(DataSourceUtils.getDataSource());
        int num=-1;
        if(product.getImgurl()==null){
            String sql="update lilshop.product set name=?,price=?,category=?,pnum=?,description=? where id=?";
             num=runner.update(sql, product.getName(),product.getPrice(),product.getcategory(),product.getPnum(),product.getDescription(),product.getId());
        }
        else{
            String sql="update lilshop.product set name=?,price=?,category=?,pnum=?,imgurl=?,description=? where id=?";
            num=runner.update(sql, product.getName(),product.getPrice(),product.getcategory(),product.getPnum(),product.getImgurl(),product.getDescription(),product.getId());
        }
        if(num>0) return true;
        return false;
    }
}
