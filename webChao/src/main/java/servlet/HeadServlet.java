package servlet;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CartServlet")
public class HeadServlet extends HttpServlet{
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
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        doPost(request, response);
    }

}
