package utils;

public class CartItem {
    private int userId;
    private  int productId;
    private  int buyNum;

    public int getBuyNum() {
        return buyNum;
    }

    public int getProductId() {
        return productId;
    }

    public int getUserId() {
        return userId;
    }

    public void setBuyNum(int buyNum) {
        this.buyNum = buyNum;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "userId=" + userId +
                ", productId=" + productId +
                ", buynum=" + buyNum +
                '}';
    }
}
