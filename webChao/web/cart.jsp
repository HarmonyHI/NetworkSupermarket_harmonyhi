<%@ page import="entity.Cart" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.Cart_item" %>
<%@ page contentType="text/html;charset=UTF-8"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>购物车</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/mycss.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="whole">
    <div class="container">
        <jsp:include page="header.jsp"/>
        <h1>购物车</h1>
        <%
                Cart cart1 = (Cart) request.getSession().getAttribute("cart");
                System.out.println("已获取购物车 "+cart1.show());
                ArrayList<Cart_item> goods = cart1.getGoods();
                DecimalFormat s1 = new DecimalFormat( ".00");
        %>
        <div class="table-responsive">
            <table class="table">
        <%
            int iter=1;
            int wid=4;
            for (Cart_item good : goods) {
        %>
                <%if(iter%wid==1){%>
                <tr>
                    <%}%>
                <td>
                        <a href="products_details.jsp?id=<%=good.getGoods_id()%>">
                            <dl>
                                <dt>
                                    <div class="boader_sm">
                                        <img class="img-rounded" width='100' height='100' src="<%=good.getPicture()%>" alt=""/>
                                    </div>
                                </dt>
                                <dd>
                                    <h2>
                                        <%=good.getName()%>
                                    </h2>
                                </dd>
                                <dd>
                                    已选型号:<%=good.getGoods_type_id()%>
                                </dd>
                                <dd>
                                    折扣:<%=s1.format(good.getDiscount())%>
                                </dd>
                                <dd>
                                    价格:¥<%=s1.format(good.getPrice())%>
                                </dd>
                                <dd>
                                    数量:¥<%=s1.format(good.getGoods_number())%>
                                </dd>
                            </dl>
                        </a>
                    </td>
                    <%if((iter+1)%wid==1){%>
                </tr>
                <%}%>
                <%
                        iter++;
                    }
                %>
            </table>
        </div>
                <div class="total">
                   <h2 id="total">
                       总计：<%=s1.format(cart1.getTotalPrice()) %>¥
                   </h2>
                </div>
                <div class="boader">
                    <button class="btn btn-warning btn-lg" onclick="window.location.href='buy_success.jsp'">结算</button>
                    <%if(!goods.isEmpty()){%>
                    <button class="btn btn-danger btn-lg" onclick="window.location.href='servlet/CartServlet?action=delete'">清空</button>
                    <%}%>
                </div>
            </div>
</div>
</body>
</html>
