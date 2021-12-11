<%@ page import="utils.Product" %>
<%@ page import="DAO.ProductDao" %>
<%@ page import="utils.CookieUtils" %><%--
  Created by IntelliJ IDEA.
  User: 张晓桐
  Date: 2021/11/29
  Time: 17:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品详情页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="../BootStrap/js/jquery-1.10.2.min.js"></script>
    <script src="../BootStrap/js/bootstrap.min.js"></script>
    <link href="../BootStrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="../BootStrap/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="css/buyerProduct.css">
</head>
<body>
<jsp:include page="../user/head.jsp" />
<div class="container" style="margin-top: 20px">
    <%
        String productId=request.getParameter("productId");
        Product product= ProductDao.getProductId(Integer.parseInt(productId));
        CookieUtils.updateCookie(request,response,"history",productId);
    %>
    <div class="row">
        <div class=" col-md-12 ">
            <div class="panel panel-default panel-shadow">
                <div class="panel-heading" >
                    <h3 id="addProductTitle">
                        <%=product.getName()%>
                    </h3>
                    <h4 style="color: #ac2925">￥<%=product.getPrice()%>&nbsp;&nbsp;&nbsp;&nbsp;库存量<%=product.getPnum()%></h4>
                    <div class="text-right"><i class="glyphicon glyphicon-home"></i>&nbsp;&nbsp;<%=product.getShopName()%></div>
                </div>
                <div class="panel-body" style="height: 70%">
                    <div class="col-md-6">
                        <img src="${pageContext.request.contextPath}<%=product.getImgurl()%>"  class="img-cart" alt="请尝试刷新" style="width: 100%;height: 100%;">
                    </div>
                    <div class="col-md-6">
                        <%=product.getDescription()%>
                    </div>
                    <div style="position: absolute;top: 90%;left:79%;">
                        <div class="row">
                            <div class="col-md-4 col-md-push-1">
                                <input type="number" step="1" min="1" value="1" style="width: 100%;padding: 6px 9px;" id="buyNum">
                            </div>
                            <div class="col-md-6">
                                <a class="btn btn-danger" href="${pageContext.request.contextPath}/Buyer/addToCart?productId=<%=product.getId()%>&buyNum=" onclick="addToCart(this);">加入购物车</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function addToCart(event) {
        let input=document.getElementById("buyNum");
        let num=input.value;
        event.href=event.href+num;
    }
</script>
</body>
</html>
