<%--
  Created by IntelliJ IDEA.
  User: 张晓桐
  Date: 2021/11/13
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <!--  This file has been downloaded from bootdey.com @bootdey on twitter -->
    <!--  All snippets are MIT license http://bootdey.com/license -->
    <%@page import="utils.Product" %>
    <%@page import="DAO.ProductDao" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
    <%@page import="utils.CookieUtils" %>
    <%@ page import="java.sql.SQLException" %>
    <title>首页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="../BootStrap/js/jquery-1.10.2.min.js"></script>
    <script src="../BootStrap/js/bootstrap.min.js"></script>
    <link href="../BootStrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="../BootStrap/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="css/buyerProduct.css">
</head>
<body>
<jsp:include page="../user/head.jsp"/>
<div class="container ">
    <%
        List<Product> products = new ArrayList<Product>();
        if(request.getParameter("productIds")==null){
            try {
                products = ProductDao.listAll();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }else {
            String productIds=request.getParameter("productIds");
            String ids[]=productIds.split("_");

            for(int i=1;i<ids.length;i++){
                String id=ids[i];

                Product product=ProductDao.getProductId(Integer.parseInt(id));
                products.add(product);
            }
        }
        request.setAttribute("products", products);
    %>
    <div class="row product-list">
        <form class="form-horizontal" role="search" method="post"
              action="${pageContext.request.contextPath}/Buyer/searchKeyword"
              style=" margin-top: 10px;margin-bottom: 10px;">
            <div class="form-group">
                <div>
                    <label for="category" class="col-md-1 col-md-offset-1 control-label"><p class="text-right">&nbsp;&nbsp;&nbsp;范围</p></label>
                    <div class="col-md-3" >
                        <select class="form-control" id="category" name="category">
                            <option value="-1">全部</option>
                            <option value="0">食物</option>
                            <option value="1">衣物</option>
                            <option value="2">书籍</option>
                            <option value="3">电子产品</option>
                            <option value="4">日常用品</option>
                            <option value="5">其他</option>
                        </select>
                    </div>
                </div>
                <div class="input-group col-md-offset-6 col-md-4">
                    <input type="text" class="form-control" name="keyword" placeholder="关键词检索">
                    <span class="input-group-btn"><button type="submit" class="btn btn-success">搜索</button></span>
                </div><!-- /input-group -->
            </div>

        </form>
<%--        <div style="border-top:1px solid #ff0000;margin:12px"></div>--%>
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
                                <a href="${pageContext.request.contextPath}/Buyer/buyerProductDetail.jsp?productId=${product.id}" class="pro-title" style=" display:block;             /*内联对象需加*/
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
<jsp:include page="../user/bottom.jsp"/>
<script>
    window.onload = function () {
        let flag =<%=request.getAttribute("cart")%>;
        if (flag == null) return;
        if (flag) {
            alert("添加成功");
        } else {
            alert("添加失败");
        }
    }
</script>
</body>
</html>