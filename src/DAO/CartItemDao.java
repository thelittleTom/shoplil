package DAO;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import utils.CartItem;
import utils.DataSourceUtils;

import java.sql.SQLException;
import java.util.List;

public class CartItemDao {
    static QueryRunner runner=new QueryRunner(DataSourceUtils.getDataSource());
    public static boolean addToCart(CartItem cartItem) throws SQLException {
        String sql="insert into lilshop.cartItem (productId,userId,buynum) values(?,?,?)";
        int num=runner.update(sql, cartItem.getProductId(),cartItem.getUserId(),cartItem.getBuyNum());
        if(num>0) return true;
        return false;
    }
    public static int  getBuyNum(CartItem cartItem) throws SQLException {
        String sql="select * from lilshop.cartItem where userId=? and productId=?";
        CartItem cartItem1=(CartItem) runner.query(sql, new BeanHandler(CartItem.class),new Object[] {cartItem.getUserId(),cartItem.getProductId()});
        if(cartItem1==null) return 0;
        else  return  cartItem1.getBuyNum();
    }
    public static boolean updateBuyNum(int productId,int userId,int newBuyNUm) throws SQLException {
        int num=-1;
        String sql="update lilshop.cartItem set buynum=? where userId=? and productId=?";
        num=runner.update(sql,newBuyNUm,userId,productId);
        if(num>0) return true;
        return false;
    }
    public static boolean updateBuyNumByHaveBuyNum(int productId,int userId,int haveBuyNUm) throws SQLException {
        int num=-1;
        String sql="update lilshop.cartItem set buynum=buynum-? where userId=? and productId=?";
        num=runner.update(sql,haveBuyNUm,userId,productId);
        if(num>0) return true;
        return false;
    }
    public static List<CartItem> listAllByUserId(int uId) throws SQLException {
        String sql = "select * from lilshop.cartItem where userId="+uId;
        return runner.query(sql, new BeanListHandler<>(CartItem.class));
    }
    public static boolean deleteCartItem(int uId,int pId) throws SQLException {
        String sql="DELETE FROM lilshop.cartItem WHERE userId=? and productId=?";
        int num=runner.update(sql,uId,pId);
        if(num>0) return true;
        else return  false;
    }
}
