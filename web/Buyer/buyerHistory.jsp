<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="utils.CookieUtils" %>
<%@ page import="utils.Product" %>
<%@ page import="DAO.ProductDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %><%--
  Created by IntelliJ IDEA.
  User: 张晓桐
  Date: 2021/11/29
  Time: 22:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的足迹</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="../BootStrap/js/jquery-1.10.2.min.js"></script>
    <script src="../BootStrap/js/bootstrap.min.js"></script>
    <link href="../BootStrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="../BootStrap/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="css/buyerProduct.css">
</head>
<body>
<%
    List<Product> products = new ArrayList<Product>();
    String history= CookieUtils.getCookieValue(request,"history");
    if(history!=null){
        String[] ids=history.split("_");
        System.out.println(ids.length);

        for(int i=0;i<ids.length;i++){
            String id=ids[i];
            System.out.println("id |"+id);
            Product product= ProductDao.getProductId(Integer.parseInt(id));
            products.add(product);
        }
    }
    request.setAttribute("products", products);
%>
<jsp:include page="../user/head.jsp"/>
<div class="container">
    <div class="row product-list">
        <c:forEach items="${products}" var="product" varStatus="idx">
            <div class="col-md-3 product-container">
                <section class="panel ele">
                    <a href="${pageContext.request.contextPath}/Buyer/buyerProductDetail.jsp?productId=${product.id}">
                        <div class="pro-img-box">
                            <img src="${pageContext.request.contextPath}${product.imgurl}" alt="" class="image-card"/>
                            <a href="${pageContext.request.contextPath}/Buyer/addToCart?productId=${product.id}&buyNum=1"
                               class="adtocart btn btn-padding btn-info">
                                <i class="glyphicon glyphicon-shopping-cart"></i>
                            </a>
                        </div>

                        <div class="panel-body text-center">
                            <h4>
                                <a href="${pageContext.request.contextPath}/Buyer/buyerProductDetail.jsp?productId=${product.id}"  class="pro-title" style=" display:block;             /*内联对象需加*/
    word-break:keep-all;       /* 不换行 */

    white-space:nowrap;        /* 不换行 */

    overflow:hidden;           /* 内容超出宽度时隐藏超出部分的内容 */

    text-overflow:ellipsis;">
                                        ${product.name}
                                </a>
                            </h4>
                            <p class="price">￥${product.price}</p>
                            <div class="text-right"><i class="glyphicon glyphicon-home"></i>&nbsp;&nbsp;${product.shopName}</div>
                        </div>
                    </a>
                </section>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>
