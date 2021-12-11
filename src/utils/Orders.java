package utils;

import java.util.Date;

public class Orders {
    private String id;
    private double money;
    private String receiverAddress;
    private String receiverName;
    private String receiverPhone;
    private int payState;
    private Date orderTime;
    private int userId;
    private String shopId;

    public String getShopId() {
        return shopId;
    }

    public void setShopId(String shopId) {
        this.shopId = shopId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getUserId() {
        return userId;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public double getMoney() {
        return money;
    }

    public void setMoney(double money) {
        this.money = money;
    }

    public void setPayState(int payState) {
        this.payState = payState;
    }

    public int getPayState() {
        return payState;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getId() {
        return id;
    }


    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    @Override
    public String toString() {
        return "Orders{" +
                "id=" + id +
                ", money=" + money +
                ", receiverAddress='" + receiverAddress + '\'' +
                ", receiverName='" + receiverName + '\'' +
                ", receiverPhone='" + receiverPhone + '\'' +
                ", payState=" + payState +
                ", orderTime=" + orderTime +
                ", userId=" + userId +
                '}';
    }
}
