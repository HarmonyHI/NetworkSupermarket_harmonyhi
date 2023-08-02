<%@ page import="java.net.URLDecoder" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta charset="utf-8">
    <title>login</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/mycss.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        function reloadCode(){
            const time = new Date().getTime();
            document.getElementById("imageCode").src="servlet/ImageServlet?d="+time;
        }
    </script>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    String userName = "";
    String userPassword = "";
    Cookie[] cookies = request.getCookies();
    if(cookies != null && cookies.length > 0) {
        for(Cookie c : cookies) {
            if(c.getName().equals("loginUser")) {
                userName = URLDecoder.decode(c.getValue(), "utf-8");
            }
            if(c.getName().equals("loginPassword")) {
                userPassword = URLDecoder.decode(c.getValue(), "utf-8");
            }
        }
    }
%>
<div class="whole">
    <div class="container">
        <jsp:include page="header.jsp"/>
        <form action="servlet/LoginActionServlet" class="form-horizontal" role="form" method="post">
            <div class="form-group">
                <label for="username" class="col-sm-2 control-label">账号:&nbsp;</label>
                <div class="col-sm-10">
                    <div class="input-group input-group-sm">
                        <input type="text" class="form-control" id="username" name="loginUser" placeholder="请输入用户名" maxlength="300px">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="col-sm-2 control-label">密码:&nbsp;</label>
                <div class="col-sm-10">
                    <div class="input-group input-group-sm">
                        <input type="text" class="form-control" id="password" name="loginPassword" placeholder="请输入密码" maxlength="300px">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="check" class="col-sm-2 control-label">验证码:&nbsp;</label>
                <div class="col-sm-10">
                    <table>
                        <tr>
                            <td>
                                <div class="input-group input-group-sm">
                                    <input type="text" class="form-control" id="check" name="checkCode" placeholder="请输入验证码">
                                </div>
                            </td>
                            <td>
                                <div class="checkcode">
                                    <a href="javascript: reloadCode();">
                                        <img alt="验证码" id="imageCode" src="servlet/ImageServlet" class="img-rounded">
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="isUseCookie">记住我
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <p>
                        <button type="submit" class="btn btn-default">登录</button>
                        <button class="btn btn-default" onclick="window.open('vendor_register.jsp')">商家注册</button>
                    </p>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
