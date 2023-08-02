package util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBHelper {
    private static final String driver = "com.mysql.jdbc.Driver";
    private static final String url = "jdbc:mysql://localhost:3306/network_supermarket?serverTimezone=Asia/Shanghai&&characterEncoding=utf8&&useSSL=false&&allowPublicKeyRetrieval=true";
    private static final String username="root";
    private static final String password="Hc766443";
    private static final String[] SQLGROUP = {
            "CALL `cart-使用购物车创建订单`( ?,  ?,  ?)"
            ,"CALL `cart-修改购物车某商品的数量`( ?, ?,  ?)"
            ,"CALL `cart-删除购物车的某个商品`( ?, ?) "
            ,"CALL `cart-直接删除某个用户购物车中所有商品`( ?)"
            ,"CALL `comments_media_url_用户向评论中添加一个图片或视频的`( ?,  ?)"
            ,"CALL `goods&goods_type&cart-向购物车中添加不含型号商品`( ?, ?, ?, ?)"
            ,"CALL `goods&goods_type&cart-向购物车中添加含型号商品`( ?, ?, ?, ?, ?)"
            ,"CALL `goods&goods_type-商家为某商品添加属于某商品的型号`( ?,  ?,  ?)"
            ,"CALL `goods-商家上架一款商品`( ?,  ?,  ?,  ?,  ?,  ?)"
            ,"CALL `goods-商家修改商品信息`( ?,  ?,  ?,  ?,  ?)"
            ,"CALL `goods-商家删除某个商品`( ?)"
            ,"CALL `goods_media_url-商家向某个商品中添加图片视频`( ?,  ?)"
            ,"CALL `order-使用一个含型号商品直接创建某用户的订单`( ?,  ?,  ?,  ?,  ?)"
            ,"CALL `order-使用一个无型号商品直接创建某用户的订单`( ?,  ?,  ?,  ?,  ?)"
            ,"CALL `order-商家于用户商品状态操作`( ?,  ?)"
            ,"CALL `order-商家填写物流单号`( ?,  ?)"
            ,"CALL `order-用户于订单状态操作`( ?,  ?)"
            ,"CALL `order-用户修改订单收货地址`( ?,  ?)"
            ,"CALL `order-用户修改订单电话号码`( ?,  ?)"
            ,"CALL `order-用户填写退货单号`( ?,  ?)"
            ,"CALL `purchase-用户上传一条某商品评论`( ?,  ?)"
            ,"CALL `purchase-用户于单商品状态操作`( ?,  ?)"
            ,"CALL `purchase-用户对一条某商品评分`( ?,  ?)"
            ,"CALL `users-修改一个用户的信息`( ?,  ?,  ?,  ?,  ?,  ?,  ?)"
            ,"CALL `users-创建一个新用户`( ?,  ?)"
            ,"CALL `users-注销一个用户`( ?)"
            ,"CALL `vendor-修改商家信息`( ?,  ?,  ?,  ?,  ?,  ?)"
            ,"CALL `vendor-创建商家`( ?,  ?,  ?,  ?,  ?)"
            ,"CALL `vendor-注销商家`( ?)"
            ,"CALL `按ID查询商品`( ?)"
            ,"CALL `按ID查询用户`( ?)"
            ,"CALL `按名称查询用户`( ?)"
            ,"CALL `按商品名称查询商品库里商品的描述与首张图`( ?,  ?, ?)"
            ,"CALL `查询所有的商品`()"
            ,"CALL `查询所有的用户`()"
            ,"CALL `查询某个商家所有商品的描述与首张图`(?,  ?, ?)"
            ,"CALL `查询某商品所有型号详细信息`( ?)"
            ,"CALL `查询某商品的图片视频`( ?)"
            ,"CALL `查询某商品的所有文字信息`( ?)"
            ,"CALL `查询某商品的所有文字评论`( ?)"
            ,"CALL `查询某商家特定状态的交易列表`(?,  ?)"
            ,"CALL `查询某用户特定状态的订单`( ?,  ?)"
            ,"CALL `查询某用户的信息`( ?)"
            ,"CALL `查询某用户的购物车内容`( ?)"
            ,"CALL `查询某订单的详细信息`( ?)"
            ,"CALL `查询某评论的图片视频`( ?)"
            ,"CALL `随机推送某数量商品`( ?)"
            ,"SELECT `BOOL检查商家账号密码（可用手机号做账号）`( ?,  ?)"
            ,"SELECT `BOOL检查用户账号密码（可用手机号做账号）`( ?,  ?)"
            ,"CALL `users-检查用户账号密码（可用手机号做账号）`( ?,  ?)"
            ,"CALL `vendor-检查商家账号密码（可用手机号做账号）`( ?,  ?)"
    };
    private static Connection conn = null;
    static {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    public static Connection getConnection() throws Exception{
        if(conn == null){
            conn = DriverManager.getConnection(url, username, password);
            return conn;
        }
        return conn;
    }
    public static PreparedStatement getSQL(int no) throws Exception {
        Connection conn;
        PreparedStatement stmt;
        conn = getConnection();
        stmt = conn.prepareStatement(SQLGROUP[no-1]);
        return stmt;
    }
    public static void main(String[] args){
        try {
            Connection connection = DBHelper.getConnection();
            if(connection != null){
                System.out.println("TEST数据库连接正常");
            }
            if(connection == null){
                System.out.println("TEST数据库连接异常");
            }
            PreparedStatement stmt = (DBHelper.getSQL(47));
            stmt.setInt(1, 15);
            ResultSet resultSet = stmt.executeQuery();
            while (resultSet.next()){
                System.out.println(resultSet.getString(1) + ' ' + resultSet.getString(2) );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
