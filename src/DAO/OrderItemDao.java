package DAO;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;
import utils.DataSourceUtils;
import utils.OrderItem;
import utils.Product;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class OrderItemDao {
    static QueryRunner runner=new QueryRunner(DataSourceUtils.getDataSource());
    public static boolean insertOrders(OrderItem orderItem) throws SQLException {
        String sql="insert into lilshop.orderItem (orderId,productId,buyNum) values(?,?,?)";
        int num=runner.update(sql,orderItem.getOrderId(),orderItem.getProductId(),orderItem.getBuyNum());
        if(num>0) return true;
        return false;
    }
    public static List<Product> listAllProductOrderItem(String shopId) throws SQLException {
        String sql="SELECT\n" +
                "\tproductId,\n" +
                "\tsum(buynum) \n" +
                "FROM\n" +
                "\tlilshop.orderItem \n" +
                "WHERE\n" +
                "\tproductId IN ( SELECT id FROM lilshop.product WHERE shopid = ? ) \n" +
                "GROUP BY\n" +
                "\tproductId";

        List<Product> productList =new ArrayList<>();
            //调用queryrunner的query查询方法
        List<Map<String, Object>> result = runner.query( sql, new MapListHandler(),shopId);

        for (Map<String, Object> map : result) {
            for(String key:map.keySet()) {
                System.out.print(key + "\t" + map.get(key) + "\t");

            }

            Product product= ProductDao.getProductId((Integer) map.get("productId"));

            product.setPnum( Integer.parseInt(map.get("sum(buynum)").toString()));

            productList.add(product);

        }


//        List<OrderItem> list=runner.query(sql, new BeanListHandler<OrderItem>(OrderItem.class),shopId);
        return productList;
    }
}
