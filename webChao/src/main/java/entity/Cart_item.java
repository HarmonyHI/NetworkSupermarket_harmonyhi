package entity;

public class Cart_item {
    private final String out_cart_id;
    private final String user_id;
    private final String goods_id;
    private final String goods_type_id;
    private final double goods_number;
    private final double discount;
    private final double actually_money;

    public String getOut_cart_id() {
        return out_cart_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public String getGoods_id() {
        return goods_id;
    }

    public String getGoods_type_id() {
        return goods_type_id;
    }

    public double getGoods_number() {
        return goods_number;
    }

    public double getDiscount() {
        return discount;
    }

    public String getPicture(){
        return "";
    }

    public String getName(){
        return "宝贝名称";
    }

    public double getPrice() {
        return actually_money;
    }
    public Cart_item(String out_cart_id, String user_id, String goods_id, String goods_type_id, double goods_number, double discount, double actually_money) {
        this.out_cart_id = out_cart_id;
        this.user_id = user_id;
        this.goods_id = goods_id;
        this.goods_type_id = goods_type_id;
        this.goods_number = goods_number;
        this.discount = discount;
        this.actually_money = actually_money;
    }

}
