package dao;

import entity.Cart_item;
import entity.Items;
import util.DBHelper;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class CartDao {
    public ArrayList<Cart_item> getCarts(String uid){
        PreparedStatement stmt;
        try {
            stmt = DBHelper.getSQL(44);
            stmt.setString(1,uid);
            ResultSet rs = stmt.executeQuery();
            ArrayList<Cart_item> list = new ArrayList<>();
            while (rs.next()) {
                list.add(
                        new Cart_item(
                                rs.getString("out_cart_id"),
                                rs.getString("user_id"),
                                rs.getString("goods_id"),
                                rs.getString("goods_type_id"),
                                rs.getFloat("goods_number"),
                                rs.getFloat("discount"),
                                rs.getFloat("actually_money")
                        )
                );
            }
            return list;
        }
        catch (Exception e){
            System.out.println("getCarts发生错误");
        }
        return null;
    }
    public void clearCarts(String uid){
        try {
            PreparedStatement stmt = DBHelper.getSQL(4);
            stmt.setString(1,uid);
            stmt.executeQuery();
        }
        catch (Exception e){
            System.out.println("clearCarts发生错误");
        }
    }
    public void cartWriter(Items item, Double num, String uid, double discount){
        try {
            PreparedStatement stmt = DBHelper.getSQL(6);
            stmt.setString(1,uid);
            stmt.setString(2,item.getId());
            stmt.setDouble(3,num);
            stmt.setDouble(4,discount);
            System.out.println("cartWriter查询语句为"+stmt);
            stmt.executeQuery();
        }
        catch (Exception e){
            System.out.println("CartWriter发生错误，错误信息"+e.getMessage());
        }
    }
}
