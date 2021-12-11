package utils;

public class OrderItem {
    private int productId;
    private String orderId;
    private int buyNum;

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getProductId() {
        return productId;
    }

    public void setBuyNum(int buyNum) {
        this.buyNum = buyNum;
    }

    public int getBuyNum() {
        return buyNum;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getOrderId() {
        return orderId;
    }

    @Override
    public String toString() {
        return "OrderItem{" +
                "productId=" + productId +
                ", orderId=" + orderId +
                ", buyNum=" + buyNum +
                '}';
    }
}
