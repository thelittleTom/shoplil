<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.Product" %>
<%@ page import="DAO.ProductDao" %>
<%@ page import="utils.CartItem" %>
<%@ page import="DAO.CartItemDao" %><%--
  Created by IntelliJ IDEA.
  User: 张晓桐
  Date: 2021/11/17
  Time: 23:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>结算页面</title>
    <script src="../BootStrap/js/jquery-1.10.2.min.js"></script>
    <script src="../BootStrap/js/bootstrap.min.js"></script>
    <link href="../BootStrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="../BootStrap/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="../Seller/css/sellerCart.css">
</head>

<style>
    th{
        width: auto;
    }
</style>
<body>
<script>
    let sum1=0;
</script>
<%
    int total=0;
    String products=request.getParameter("productId");
    String name1 = new String(products);


    String pIds[]=products.split("_");


    String uId=request.getParameter("userId");
    int userId=Integer.parseInt(uId);
    List<Integer> buyNums=new ArrayList<>();
    List<Product> productList=new ArrayList<>();
    for(int i=0;i<pIds.length;i++){
        int pId=Integer.parseInt(pIds[i]);
        Product product= ProductDao.getProductId(pId);

        CartItem cartItem=new CartItem();
        cartItem.setProductId(pId);cartItem.setUserId(userId);
        product.setPnum(CartItemDao.getBuyNum(cartItem));
        productList.add(product);
    }


%>
<jsp:include page="../user/head.jsp" />
<!--填写地址等信息-->
<div class="container">
    <div class="row">
        <div class=" col-md-12 ">
            <div class="panel panel-success panel-shadow">
                <div class="panel-heading" >
                    <h3 id="addProductTitle">
                       填写信息
                    </h3>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" role="form" action="${pageContext.request.contextPath}/Buyer/settleAccounts" method="post" id="settle" >
                        <input  name="userId" hidden="true" value="<%=request.getParameter("userId")%>">
                        <input  name="productId" hidden="true" value="<%=products%>">
                        <div class="form-group">
                            <label for="name" class="col-md-1 control-label"><p class="text-center">收货人</p></label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" id="name" name="receiverName"
                                       placeholder="请输入名字">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="telephone" class="col-md-1 control-label"><p class="text-center">联系方式</p></label>
                            <div class="col-md-4">
                                <input type="tel" class="form-control" id="telephone" name="receiverPhone"
                                       placeholder="请输入电话号码">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="address" class="col-md-1 control-label"><p class="text-center">收货地址</p></label>
                            <div class="col-md-10">
                                <textarea class="form-control" rows="4" id="address" name="receiverAddress"></textarea>
                            </div>
                        </div>
                            <div class="col-md-offset-5 col-md-2">
                                <button type="submit" class="btn btn-success btn-lg" id="addProductBtn">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;提交订单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
                            </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row" id="productShow">
        <div class="col-md-12 ">
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-primary panel-shadow">
                        <div class="panel-heading">
                            <h3>
                                购买商品
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th>商品名</th>
                                        <th>价格</th>
                                        <th>类别</th>
                                        <th>购买数目</th>
                                        <th id="descriptionTh">介绍</th>
                                    </tr>
                                    </thead>
                                    <tbody id="product-show">

                                    <c:forEach items="<%=productList%>" var="product" varStatus="idx">
                                        <tr>
                                            <td><img src="${pageContext.request.contextPath}${product.imgurl }"  class="img-cart" alt="请尝试刷新"></td>
                                            <td><strong>${product.name}</strong></td>
                                            <td>${product.price}</td>
                                            <td>${product.category}</td>
                                            <td>${product.pnum}</td>
                                            <td>${product.description}</td>
                                        </tr>
                                        <script>
                                            sum1=sum1+${product.price}*${product.pnum};
                                        </script>
                                    </c:forEach>
                                    <tr>
                                        <td colspan="5" class="text-right">商品总金额</td>
                                        <td id="totalMoney"></td>
                                    </tr>
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

<script>
    document.getElementById("totalMoney").innerText=sum1;
    let input=document.createElement("input");
    input.hidden=true;
    input.name="money";
    input.value=sum1;
    document.getElementById("settle").appendChild(input);
</script>
</body>
</html>
