package entity;
import dao.CartDao;

import java.util.ArrayList;
public class Cart {
    private final CartDao cartDao;
    private final String uid;
    public Cart(String uid){
        cartDao = new CartDao();
        this.uid=uid;
        System.out.println("创建uid为"+uid+"的购物车成功");
    }
    public ArrayList<Cart_item> getGoods() {
        return cartDao.getCarts(this.uid);
    }

    public double getTotalPrice() {
        double sum = 0;
        ArrayList<Cart_item> list = getGoods();
        for (Cart_item item:list){
            sum += item.getPrice();
        }
        return sum;
    }
    public void add(Items item, double num){
        this.cartDao.cartWriter(item, num, this.uid, 1);
    }
    public void delete(){
        this.cartDao.clearCarts(this.uid);
    }
    public String show(){
        return "购物车用户ID为"+ this.uid;
    }
}