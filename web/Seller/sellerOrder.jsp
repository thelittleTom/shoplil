<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="DAO.OrdersDao" %>
<%@ page import="utils.CookieUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="utils.Orders" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.OrderItem" %>
<%@ page import="DAO.OrderItemDao" %>
<%@ page import="utils.Product" %>
<%@ page import="DAO.ProductDao" %><%--
  Created by IntelliJ IDEA.
  User: 张晓桐
  Date: 2021/11/18
  Time: 23:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="../BootStrap/js/jquery-1.10.2.min.js"></script>
<script src="../BootStrap/js/bootstrap.min.js"></script>
<link href="../BootStrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../BootStrap/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="css/sellerCart.css">
<html>
<head>
    <title>所有订单</title>
</head>
<body>
<%
    String shopId= CookieUtils.getCookieValue(request,"shopId");
%>
<jsp:include page="../user/head.jsp" />

<div class="container">
    <ul class="nav nav-tabs" id="myTab" style="margin-top: 20px">
        <li class="active"><a href="#byUser">客户总订单</a></li>
        <li><a href="#byProduct">商品总订单</a></li>
    </ul>
</div>

<div class="tab-content">
    <div class="tab-pane" id="byUser">
        <div class="container">
            <div class="row" id="productShow">
                <div class="col-md-12 ">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel panel-primary panel-shadow">
                                <div class="panel-heading">
                                    <h3>
                                        客户总订单
                                    </h3>
                                </div>
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover table-striped">
                                            <thead>
                                            <tr>
                                                <th>收件人</th>
                                                <th>联系电话</th>
                                                <th>地址</th>
                                                <th>总价</th>
                                                <th>订单生成时间</th>
                                                <th></th>
                                            </tr>
                                            </thead>
                                            <tbody id="product-show">
                                            <%
                                                List<Orders>  ordersList=new ArrayList<Orders>();
                                                ordersList= OrdersDao.listAllByShopId(shopId);
                                            %>

                                            <c:forEach items="<%=ordersList%>" var="orders" varStatus="idx">
                                                <tr>
                                                    <td>${orders.receiverName}</td>
                                                    <td>${orders.receiverPhone}</td>
                                                    <td>${orders.receiverAddress}</td>
                                                    <td>${orders.money}</td>
                                                    <td>${orders.orderTime}</td>
                                                    <td><a href="${pageContext.request.contextPath}/Seller/deleteProduct?idProduct=${product.id}" id="${product.id}" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span></a>
                                                        <button class="btn btn-primary" id="${product.id}" onclick="changeProduct(this.id);" ><span class="glyphicon glyphicon-pencil"></span> </button></td></td>
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
    </div>
    <div class="tab-pane" id="byProduct">
        <div class="container">
            <div class="row" >
                <div class="col-md-12 ">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel panel-info panel-shadow">
                                <div class="panel-heading">
                                    <h3>
                                        商品总订单
                                    </h3>
                                </div>
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover table-striped">
                                            <thead>
                                            <tr>
                                                <th></th>
                                                <th>商品名</th>
                                                <th>商品价格</th>
                                                <th>总销售量</th>
                                                <th>总销售金额</th>
                                                <th></th>
                                            </tr>
                                            </thead>
                                            <tbody >
                                            <%
                                                List<Product> productList=new ArrayList<>();
                                               productList= OrderItemDao.listAllProductOrderItem(shopId);


                                            %>

                                            <c:forEach items="<%=productList%>" var="orders" varStatus="idx">
                                                <tr>
                                                    <td><img src="${pageContext.request.contextPath}${orders.imgurl }"  class="img-cart" alt="请尝试刷新"></td>
                                                    <td>${orders.name}</td>
                                                    <td>${orders.price}</td>
                                                    <td>${orders.pnum}</td>
                                                    <td>${orders.price*orders.pnum}</td>
                                                    <td><a href="${pageContext.request.contextPath}/Seller/deleteProduct?idProduct=${product.id}" id="${product.id}" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span></a>
                                                        <button class="btn btn-primary" id="${product.id}" onclick="changeProduct(this.id);" ><span class="glyphicon glyphicon-pencil"></span> </button></td></td>
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
    </div>
</div>

<script>
    $(function () {
        $('#myTab a:last').tab('show');
    })
    $('#myTab a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    })
</script>


</body>
</html>
