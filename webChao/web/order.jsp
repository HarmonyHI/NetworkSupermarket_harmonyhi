<%@ page import="entity.Cart" %>
<%@ page import="entity.Items" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Set" %>
<%@ page contentType="text/html;charset=UTF-8"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>我的订单</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/mycss.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="whole">
    <div class="container">
        <jsp:include page="header.jsp"/>
        <%
            if(request.getSession().getAttribute("cart") != null) {
                Cart cart = (Cart)request.getSession().getAttribute("cart");
                HashMap<Items, Integer> goods = cart.getGoods();
                Set<Items> items = goods.keySet();
                for (Items i : items) {
        %>
        <div>
            <dl>
                <dt>
                    <img src="images/<%=i.getPicture()%>" alt=""/>
                </dt>
                <dd>
                    <a href="products_details.jsp?id=<%=i.getId()%>"><%=i.getName()%></a>
                    <%=i.getPrice()%>
                    <%=i.getPrice() * goods.get(i)%>
                    <span><%=goods.get(i)%></span>
                    <input type="hidden" value=""/>
                </dd>
            </dl>
        </div>
        <%
            }
        %>
        <div class="total">
           <span id="total">
               总计：<%=cart.getTotalPrice() %>¥
           </span>
        </div>
        <%
            }
        %>
    </div>
</div>
</body>
</html>
