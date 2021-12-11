package DAO;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import utils.DataSourceUtils;
import utils.Shop;

import java.sql.SQLException;

public class ShopDao {
    static QueryRunner runner=new QueryRunner(DataSourceUtils.getDataSource());
    public static Boolean insertProduct(Shop shop ) throws SQLException {
        String sql="insert into lilshop.shop (id,name,userId,description) values(?,?,?,?)";
        int num=runner.update(sql,shop.getId(), shop.getName(),shop.getUserId(),shop.getDescription());
        if(num>0) return true;
        return false;
    }
    public static String getShopName(String shopId) throws SQLException {
        String sql="select name from lilshop.shop where id=?";
        String shopName=(String) runner.query(sql, new ScalarHandler<>(),shopId);
        return shopName;
    }
    public static Shop getShopIdByUserId(int uId) throws SQLException {
        String sql="select * from lilshop.shop where userId=?";
        Shop shopName=(Shop) runner.query(sql, new BeanHandler<>(Shop.class),uId);
        return shopName;
    }
    public static void main(String args[]) throws SQLException {
        Shop shop=getShopIdByUserId(0);
        System.out.println(shop);
        if(shop==null) System.out.println("no this one guy");
    }
}
