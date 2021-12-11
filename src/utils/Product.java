package utils;

public class Product {
    int  id;
    String name;
    double price;
    String category;
    int pnum;
    String imgurl;
    String description;
    String shopId;
    String shopName;
    public void setShopId(String shopId) {
        this.shopId = shopId;
    }

    public String  getShopId() {
        return shopId;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setId(int id){
        this.id=id;
    }
    public int getId(){
        return id;
    }
    public void setName(String name){
        this.name=name;
    }
    public String getName(){
        return name;
    }
    public void setPrice(double price){
        this.price=price;
    }
    public double getPrice(){
        return price;
    }
    public void setcategory(String category){
        this.category=category;
    }
    public String getcategory(){
        return category;
    }
    public void setPnum(int pnum){
        this.pnum=pnum;
    }
    public int getPnum(){
        return pnum;
    }
    public void setImgurl(String imgurl){
        this.imgurl=imgurl;
    }
    public String getImgurl(){
        return imgurl;
    }
    public void setDescription(String description){
        this.description=description;
    }
    public String getDescription(){
        return description;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    @Override
    public String toString() {
        return "Product [id=" + id + ", username=" + name + ", imgurl="
                + imgurl + ", pnum=" + pnum + ", category=" + category
                + ", price=" + price + ", description=" + description
                + "]";
    }
}
