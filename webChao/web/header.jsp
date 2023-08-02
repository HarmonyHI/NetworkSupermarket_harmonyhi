<%@ page contentType="text/html;charset=UTF-8"%>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/mycss.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>Title</title>
</head>
<body>
<div class="whole">
  <div class="container">
      <div class="boader">
          <h1>山寨商城</h1>
      </div>
      <div class="boader">
          <%if(request.getSession().getAttribute("userid") == null){%>
          <a href="index.jsp">
              <button class="btn btn-warning">
                  商城主页
              </button>
          </a>&nbsp;
          <a href="login.jsp">
              <button class="btn btn-success">
                  登录
              </button>
          </a>&nbsp;
          <a href="register.jsp">
              <button class="btn btn-info">
                  注册
              </button></a>&nbsp;
          <a href="vendor.jsp">
              <button class="btn btn-danger">
                  商家中心
              </button></a>&nbsp;
          <%} else {%>
          <p><%=(String)request.getSession().getAttribute("userid")%>&nbsp;欢迎您</p>
          <a href="index.jsp">
              <button class="btn btn-warning">
                  商城主页
              </button></a>&nbsp;
          <a href="order.jsp">
              <button class="btn btn-danger">
                  我的订单
              </button></a>&nbsp;
          <a href="servlet/CartServlet">
              <button class="btn btn-danger">
                  购物车
              </button></a>
          <a href="vendor.jsp">
              <button class="btn btn-primary">
                  商家中心
              </button></a>&nbsp;
          <a href="servlet/LoginActionServlet?mode=exit">
              <button class="btn btn btn-success">
                  注销
              </button></a>
          <%}%>
      </div>
  </div>
</div>
</body>
</html>
