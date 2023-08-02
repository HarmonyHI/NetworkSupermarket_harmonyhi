package servlet;

import util.DBHelper;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "LoginActionServlet")
public class LoginActionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        String loginUser = request.getParameter("loginUser");
        String loginPassword = request.getParameter("loginPassword");
        String mode = request.getParameter("mode");
        if(mode != null){
            if(mode.equals("exit")){
                request.getSession().setAttribute("userid", null);
                System.out.println("注销成功");
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        }
        else {
            try {
                Connection con = DBHelper.getConnection();
                if (con != null) {
                    String piccode = (String) request.getSession().getAttribute("piccode");
                    String checkcode = request.getParameter("checkCode");
                    checkcode = checkcode.toUpperCase();
                    if(!checkcode.equals(piccode)){
                        System.out.println("验证码输入不正确");
                        request.setAttribute("login_status", "err_chk_code");
                        response.sendRedirect(request.getContextPath() + "/login.jsp");
                    }
                    else {
                        PreparedStatement stmt = DBHelper.getSQL(50);
                        stmt.setString(1,loginUser);
                        stmt.setString(2,loginPassword);
                        ResultSet resultSet = stmt.executeQuery();
                        if (resultSet.next()) {
                            String userid = resultSet.getString(1);
                            request.getSession().setAttribute("userid", userid);
                            System.out.println("登录成功！欢迎 "+userid);
                            response.sendRedirect(request.getContextPath() + "/index.jsp");
                        }
                        else {
                            System.out.println("用户名或密码错误");
                            response.sendRedirect(request.getContextPath() + "/login.jsp");
                        }
                    }
                }
            } catch (Exception ee) {
                System.out.println(ee.getMessage());
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            }
        }

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }
}
