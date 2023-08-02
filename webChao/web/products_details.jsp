<%@ page import="dao.ItemsDao" %>
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
    <title>products_details</title>
    <script type="text/javascript" src="js/js_frame/lhgcore.js"></script>
    <script type="text/javascript" src="js/js_frame/lhgdialog.js"></script>

    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/mycss.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        function selflog_show(id) {
            const num = document.getElementById("number").value;
            window.location.href='<%=path%>/servlet/CartServlet?id=' + id + '&num=' + num + '&action=add';
        }
        function add() {
            let num = parseInt(document.getElementById("number").value);
            if (num < 100) {
                document.getElementById("number").value = ++num;
            }
        }
        function sub() {
            let num = parseInt(document.getElementById("number").value);
            if (num > 1) {
                document.getElementById("number").value = --num;
            }
        }
    </script>
</head>
<body>
<div class="whole">
    <div class="container">
        <jsp:include page="header.jsp"/>
        <%
            ItemsDao itemDao = new ItemsDao();
            Items item = itemDao.getItemsById(request.getParameter("id"));
            DecimalFormat s1 = new DecimalFormat(".00");
            if(item != null) {
        %>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <td rowspan="2">
                        <div class="boader">
                            <img class="img-rounded" width='160' height='160' src="<%=item.getPicture()%>" alt=""/>
                        </div>
                    </td>
                    <td colspan="2">
                        <div class="max_fit">
                            <div class="boader">
                                <%=item.getName()%>
                            </div>
                            <div class="boader">
                                价格： <%=s1.format(item.getPrice())%>¥
                            </div>
                            <div class="boader">
                                <%=item.getDescribe()%>¥
                            </div>
                        </div>
                    </td>
                    <td colspan="2">
                        <div class="boader">
                            <table>
                                <tr>
                                    <td colspan="2">
                                        <div class="boader_sm">
                                            <label for="number">购买数量：</label><input type="text" class="form-control" id="number" name="number" value="1" size="2"/>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="boader_sm">
                                            <button type="button" class="btn btn-danger" id="sub" onclick="sub();">-</button>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="boader_sm">
                                            <button type="button" class="btn btn-danger" id="add" onclick="add();">+</button>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="boader_sm">
                            <button type="button" class="btn btn-danger btn-lg" onclick="window.open('buy_success.jsp')">立刻购买</button>
                        </div>
                    </td>
                    <td>
                        <div class="boader_sm">
                            <button type="button" class="btn btn-warning btn-lg" onclick="selflog_show(<%=item.getId()%>)">加入购物车</button>
                        </div>
                    </td>
                </tr>
            </table>
        </div>

        <%
            }
        %>
    </div>
</div>

</body>
</html>
