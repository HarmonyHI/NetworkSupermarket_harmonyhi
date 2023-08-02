package servlet;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.DBHelper;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "RegisterActionServlet")
public class RegisterActionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        String regUserName = request.getParameter("regUserName");
        String regPassword = request.getParameter("regPassword");
        System.out.println(regUserName);
        Connection con;
        ResultSet rs;
        boolean isValide = false;
        try{
            con = DBHelper.getConnection();
            if (con != null) {
                PreparedStatement stmt1 = DBHelper.getSQL(43);
                stmt1.setString(1, regUserName);
                rs = stmt1.executeQuery();
                if (!rs.next()) {
                    PreparedStatement stmt2 = DBHelper.getSQL(25);
                    stmt2.setString(1, regUserName);
                    stmt2.setString(2, regPassword);
                    stmt2.executeUpdate();
                    isValide = true;
                }
            }
        }
        catch (Exception ignored){}
        if (isValide) {
            System.out.println("注册成功！请登录");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            System.out.println("用户名已经存在！");
            response.sendRedirect(request.getContextPath() + "/register.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println("zhuce");
        doPost(request, response);
    }
}
