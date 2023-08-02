<%@ page contentType="text/html;charset=UTF-8"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>购买成功</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/mycss.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="whole">
    <div class="container">
        <h1>交易成功</h1>
        <jsp:include page="header.jsp"/>
            <%
                if(request.getSession().getAttribute("cart") != null) {
                    request.getSession().setAttribute("cart", null);
                }
            %>
            <form action="servlet/CartServlet?action=delete" method="post">
                <button class="btn btn-default" type="submit">返回</button>
            </form>
    </div>
</div>
</body>
</html>
