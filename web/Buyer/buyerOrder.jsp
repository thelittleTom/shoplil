<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="utils.CookieUtils" %>
<%@ page import="DAO.OrdersDao" %>
<%@ page import="java.util.List" %>
<%@ page import="utils.Orders" %><%--
  Created by IntelliJ IDEA.
  User: 张晓桐
  Date: 2021/12/1
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的订单</title>
    <meta charset="utf-8">
    <title>shopping cart - Bootdey.com</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="../BootStrap/js/jquery-1.10.2.min.js"></script>
    <script src="../BootStrap/js/bootstrap.min.js"></script>
    <link href="../BootStrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="../BootStrap/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="../Seller/css/sellerCart.css">
</head>
<body>
<%
    String userId= CookieUtils.getCookieValue(request,"userId");
    List<Orders> ordersList= OrdersDao.listAllByUserId(Integer.parseInt(userId));
%>
<jsp:include page="../user/head.jsp" />

<!--内容-->
<div class="container">
    <div class="row">
        <div class="col-md-12 ">
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-primary panel-shadow">
                        <div class="panel-heading">
                            <h3>
                                &nbsp;&nbsp;我的订单
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>收货人</th>
                                        <th>收货地址</th>
                                        <th>电话号码</th>
                                        <th>总金额</th>
                                        <th>订单时间</th>
                                    </tr>
                                    </thead>
                                    <tbody id="product-show">
                                    <c:forEach items="<%=ordersList%>" var="orders" varStatus="idx">
                                        <tr>
                                            <td><strong>${orders.receiverName}</strong></td>
                                            <td>${orders.receiverAddress}</td>
                                            <td>${orders.receiverPhone}</td>
                                            <td>${orders.money}</td>
                                            <td>${orders.orderTime}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
