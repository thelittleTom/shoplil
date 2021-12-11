package DAO;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import utils.DataSourceUtils;
import utils.Orders;

import java.sql.SQLException;
import java.util.List;

public class OrdersDao {
     static QueryRunner runner=new QueryRunner(DataSourceUtils.getDataSource());
    public static boolean insertOrders(Orders orders) throws SQLException {
        String sql="insert into lilshop.orders (id,money,receiverAddress,receiverName,receiverPhone,orderTime,userId) values(?,?,?,?,?,?,?)";
        int num=runner.update(sql, orders.getId(),orders.getMoney(),orders.getReceiverAddress(),orders.getReceiverName(),orders.getReceiverPhone(),orders.getOrderTime(),orders.getUserId());
        if(num>0) return true;
        return false;
    }
    public static List<Orders> listAllByShopId(String shopId) throws SQLException {
        String sql="select * from lilshop.orders where id in (select orderid from lilshop.orderItem where productId IN (select id from lilshop.product where shopid=?))";
        List<Orders> list=runner.query(sql, new BeanListHandler<Orders>(Orders.class),shopId);
        return list;
    }
    public static List<Orders> listAllByUserId(int userId) throws SQLException {
        String sql="select * from lilshop.orders where userId="+userId;
        List<Orders> list=runner.query(sql, new BeanListHandler<Orders>(Orders.class));
        return list;
    }
}
