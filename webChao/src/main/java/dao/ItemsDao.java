package dao;
import entity.Items;
import util.DBHelper;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ItemsDao {
    public ArrayList<Items> ItemsReader(ResultSet rs, boolean once) throws SQLException {
        ArrayList<Items>  list = new ArrayList<>();
        while (rs.next()) {
            list.add(
                    new Items(
                            rs.getString("goods_id"),
                            rs.getString("goods_name"),
                            rs.getString("goods_describe"),
                            rs.getFloat("amount"),
                            rs.getFloat("price"),
                            rs.getString("vendor_id"),
                            rs.getDate("listing_time"),
                            rs.getFloat("goods_score"),
                            rs.getInt("goods_status"),
                            rs.getString("unit"),
                            rs.getString("head_photo")
                    )
            );
            if(once){
                break;
            }
        }
        return list;
    }
    public ArrayList<Items> getAllItems(int nums){
        PreparedStatement stmt;
        try {
            if(nums==-1){
                stmt = DBHelper.getSQL(34);
            }
            else {
                stmt = DBHelper.getSQL(47);
                stmt.setInt(1,nums);
            }
            ResultSet rs = stmt.executeQuery();
            return ItemsReader(rs, false);
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }
        return null;
    }
    public Items getItemsById(String id){
        try{
            PreparedStatement stmt = DBHelper.getSQL(39);
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            return ItemsReader(rs, true).get(0);
        }
        catch (Exception err){
            System.out.println(err.getMessage());
        }
        return null;
    }
}
