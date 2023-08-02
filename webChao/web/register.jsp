<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>register</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/mycss.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/register.js"></script>
</head>
<body>
<div class="whole">
    <div class="container">
        <jsp:include page="header.jsp"/>
        <div class="boader">
            <h1>注册</h1>
            <p id="info"></p>
            <form action="servlet/RegisterActionServlet" method="post" class="form-horizontal" onsubmit="return is_ok()" role="form">
                <div class="form-group">
                    <label for="regname" class="col-sm-2 control-label">手机号:&nbsp;</label>
                    <div class="col-sm-10">
                        <div class="input-group">
                            <input type="text" class="form-control" id="regname" name="regUserName" placeholder="注册手机号码" maxlength="400px" onkeyup="checkUser()">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="pwd" class="col-sm-2 control-label">密码:&nbsp;</label>
                    <div class="col-sm-10">
                        <div class="input-group">
                            <input type="password" class="form-control" id="pwd" name="regPassword" placeholder="请输入密码" maxlength="400px">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="cfmpwd" class="col-sm-2 control-label">确认密码:&nbsp;</label>
                    <div class="col-sm-10">
                        <div class="input-group">
                            <input type="password" class="form-control" id="cfmpwd" name="confirmPassword" placeholder="确认密码" maxlength="400px" onkeyup="checkPwd()">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <p>
                            <button class="square_btn" type="submit">注册</button>
                        </p>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
