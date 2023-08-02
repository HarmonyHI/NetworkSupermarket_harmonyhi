<%@ page import="dao.ItemsDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.Items" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>products_list</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/mycss.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="whole">
    <div class="container">
        <jsp:include page="header.jsp"/>
        <div class="table-responsive">
            <table class="table">
                <%
                    ItemsDao itemsDao = new ItemsDao();
                    ArrayList<Items> list = itemsDao.getAllItems(-1);
                    DecimalFormat s1 = new DecimalFormat(".00");
                    int iter=1;
                    int wid=5;
                    if (list != null && list.size() > 0) {
                        for(Items item : list) {
                %>
                <%if(iter%wid==1){%>
                <tr>
                    <%}%>
                    <td>
                        <div class="boader">
                                <a href="products_details.jsp?id=<%=item.getId()%>">
                                    <dl>
                                        <dt>
                                            <div class="boader_sm">
                                                <img class="img-rounded" width='100' height='100' src="<%=item.getPicture()%>" alt=""/>
                                            </div>
                                        </dt>
                                        <dd>
                                            商品名:<%=item.getName()%>
                                        </dd>
                                        <dd>
                                            价格:¥<%=s1.format(item.getPrice())%>
                                        </dd>
                                        <dd>
                                            剩余库存:<%=s1.format(item.getAmount())%>
                                        </dd>
                                    </dl>
                                </a>
                            </div>
                    </td>
                    <%if((iter+1)%wid==1){%>
                </tr>
                <%}%>
                <%
                            iter++;
                        }
                    }
                %>
            </table>

        </div>
    </div>
</div>
</body>
</html>
