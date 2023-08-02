package servlet;

import dao.ItemsDao;
import entity.Cart;
import entity.Items;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CartServlet")
public class CartServlet extends HttpServlet{
    private final ItemsDao idao = new ItemsDao();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("text/html;charset=utf-8");
        System.out.println("购物车Servelet生成服务开始");
        if(request.getSession().getAttribute("userid") == null){
            System.out.println("请先登录");
            try {
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
            catch (Exception e){
                System.out.println(e.getMessage());
            }
        }
        else {
            String uid = (String) request.getSession().getAttribute("userid");
            System.out.println("获得用户ID为" + uid);
            if (request.getSession().getAttribute("cart") == null){
                System.out.println("未发现购物车，创建新购物车");
                Cart cart1 = new Cart(uid);
                System.out.println("创建购物车uuid为" + cart1);
                request.getSession().setAttribute("cart", cart1);
                System.out.println("购物车存入Session");
            }
                String action = request.getParameter("action");
                System.out.println("获取购物车动作指令成功，为"+action);
            if(action == null) {
                System.out.println("购物车没有命令，直接打开购物车");
                try {
                    request.getRequestDispatcher("/cart.jsp").forward(request, response);
                }
                catch (Exception e){
                    System.out.println("CartServelet77行直接打开购物车出现错误"+e.getMessage());
                }
            }
            else {
                if (action.equals("add")) {
                    System.out.println("接收到加入命令");
                    try {
                        addToCart(request);
                    } catch (Exception e) {
                        System.out.println("加入出现错误，错误信息 "+e.getMessage());
                    }
                    finally {
                        try {
                            request.getRequestDispatcher("/products_details.jsp").forward(request, response);
                        }
                        catch (Exception e){
                            System.out.println("添加商品后的转回页面出现错误，错误信息 "+e.getMessage());
                        }
                    }
                }
                else if(action.equals("delete")) {
                    System.out.println("接收到清空命令");
                    try {
                        deleteFromCart(request);
                    } catch (Exception e) {
                        System.out.println("删除出现错误，错误信息 "+e.getMessage());
                        throw new RuntimeException(e);
                    }
                    finally {
                        try {
                            request.getRequestDispatcher("/cart.jsp").forward(request, response);
                        }
                        catch (Exception e){
                            System.out.println("删除商品后的转回页面出现错误，错误信息 "+e.getMessage());
                        }
                    }
                }
            }

        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        doPost(request, response);
    }

    private void addToCart(HttpServletRequest request) {
        if (request.getSession().getAttribute("cart") == null) {
            System.out.println("发生错误，CartServelet处发现购物车不存在");
        }
        System.out.println("加入购物车函数");
        String id = request.getParameter("id");
        System.out.println("获取商品信息"+id);
        double number = Double.parseDouble(request.getParameter("num"));
        System.out.println("获取商品数目"+number);
        Items item = idao.getItemsById(id);
        System.out.println("获取商品对象UUID"+item.toString());
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        System.out.println("获得购物车UUID "+cart.toString()+cart.show());
        cart.add(item, number);
        System.out.println("购物车添加商品成功");
    }

    private void deleteFromCart(HttpServletRequest request) {
        Cart cart = (Cart)request.getSession().getAttribute("cart");
        cart.delete();
    }
}
