<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <title>shopping cart - Bootdey.com</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="../BootStrap/js/jquery-1.10.2.min.js"></script>
    <script src="../BootStrap/js/bootstrap.min.js"></script>
    <link href="../BootStrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="../BootStrap/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="css/sellerCart.css">
</head>
<body>
<!--title-->
<% String username=CookieUtils.getCookieValue(request,"username");
    String userId=CookieUtils.getCookieValue(request,"userId");
    String shopName=CookieUtils.getCookieValue(request,"shopName");
    String shopId=CookieUtils.getCookieValue(request,"shopId");
%>
<jsp:include page="../user/head.jsp" />
</div>
<div class="container">
    <div class="row">
        <div class=" col-md-12 ">
            <div class="panel panel-success panel-shadow">
                <div class="panel-heading" >
                    <h3 id="addProductTitle">
                        添加商品
                    </h3>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" role="form"  enctype="multipart/form-data" action="${pageContext.request.contextPath}/Seller/addProduct" method="post" id="addProductForm" onsubmit="changeDescription(this);">
                        <div class="form-group">
                            <label for="name" class="col-md-1 control-label"><p class="text-center">商品名</p></label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" id="name" name="name"
                                       placeholder="请输入名字">
                            </div>
                            <label for="price" class="col-md-1 col-md-offset-1 control-label"><p class="text-center">价格</p></label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" id="price" name="price" onkeyup="this.value=(this.value.match(/^\d+\.?\d*/)||[''])[0]" placeholder="请输入价格"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="category" class="col-md-1 control-label"><p class="text-center">类别</p></label>
                            <div class="col-md-4" >
                                <select class="form-control" id="category" name="category">
                                    <option value="0">食物</option>
                                    <option value="1">衣物</option>
                                    <option value="2">书籍</option>
                                    <option value="3">电子产品</option>
                                    <option value="4">日常用品</option>
                                    <option value="5">其他</option>
                                </select>
                            </div>
                            <label for="pnum" class="col-md-1 col-md-offset-1 control-label"><p class="text-center">库存量</p></label>
                            <div class="col-md-4">
                                <input type="number" class="form-control" id="pnum" name="pnum" placeholder="请输入库存量">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="description" class="col-md-1 control-label"><p class="text-center" >商品介绍</p></label>
                            <div class="col-md-10">
                                <textarea class="form-control" rows="4" id="description" name="description"></textarea>
                            </div>
                        </div>
                        <input type="file" name="pimage" id="pimage" style="display: none; " onchange="if(this.value) document.getElementById('file-path').value=this.value;">
                        <div class="form-group">
                            <label for="image" class="col-md-1 control-label"><p class="text-center">商品图片</p></label>
                            <div class="col-md-4" >
                                <input type="text"  class="form-control" id="file-path" onclick="document.getElementById('pimage').click()" style="cursor:pointer;" readonly="readonly" >
                            </div>
                            <div class="col-md-1">
                                <input type="button" id="image" class="btn btn-info btn-sm" value="选择文件" onclick="document.getElementById('pimage').click()">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-offset-5 col-md-2">
                                <button type="submit" class="btn btn-success btn-lg" id="addProductBtn" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;添加&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
                            </div>
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
                                <%=shopName%>已有商品
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th>商品名</th>
                                        <th>价格</th>
                                        <th>类别</th>
                                        <th>库存量</th>
                                        <th id="descriptionTh">介绍</th>
                                        <th></th>
                                    </tr>
                                    </thead>
                                    <tbody id="product-show">

                                    <%
                                        List<Product> products=new ArrayList<Product>();
                                        products=ProductDao.listAllByShopId(shopId);
                                    %>
                                    <c:forEach items="<%=products%>" var="product" varStatus="idx">
                                        <tr>
<%--                                            onerror="location.reload();"--%>
                                            <td><img src="${pageContext.request.contextPath}${product.imgurl }"  class="img-cart" alt="请尝试刷新"></td>
                                            <td><strong>${product.name}</strong></td>
                                            <td>${product.price}</td>
                                            <td>${product.category}</td>
                                            <td>${product.pnum}</td>
                                            <td>${product.description}</td>
                                            <td><a href="${pageContext.request.contextPath}/Seller/deleteProduct?idProduct=${product.id}" id="${product.id}" class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span></a>
                                                <button class="btn btn-primary" id="${product.id}" onclick="changeProduct(this.id);" ><span class="glyphicon glyphicon-pencil"></span> </button></td></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                         </div>
                    </div>
                    <!--<a href="#" class="btn btn-success"><span class="glyphicon glyphicon-arrow-left"></span>&nbsp;Continue Shopping</a>
                    <a href="#" class="btn btn-primary pull-right">Next<span class="glyphicon glyphicon-chevron-right"></span></a>-->
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    function changeDescription(event) {
        let about= document.getElementById("description").value;
        about=about.replace(/\n/g,'<br/>');
        document.getElementById("description").value=about;
    }
    function insertTitle(tValue){
        let t1 = tValue.lastIndexOf("\\");
        let t2 = tValue.lastIndexOf(".");
        if(t1 >= 0 && t1 < t2 && t1 < tValue.length){
            document.getElementById("file-path").value = tValue.substring(t1 + 1, t2);
        }
    }
    function changeProduct(id) {
        let addProductTitle=document.getElementById("addProductTitle");
        addProductTitle.innerText="修改商品内容";
        addProductTitle.parentElement.style.backgroundColor="lavender";
        let btn=document.getElementById(id);
        let tr=btn.parentElement.parentElement;
        document.getElementById("name").value=tr.children[1].firstChild.innerHTML;
        document.getElementById("price").value=tr.children[2].innerHTML;
        document.getElementById("category").value=tr.children[3].innerHTML;
        document.getElementById("pnum").value=tr.children[4].innerHTML;
        document.getElementById("description").value=tr.children[5].innerHTML;
        document.getElementById("productShow").hidden=true;
        document.getElementById("image").value="修改文件";
        document.getElementById("file-path").value="原文件";
        let subBtn=document.getElementById("addProductBtn");
        subBtn.innerText="修改";
        subBtn.style.backgroundColor="lightblue";
        let idInput=document.createElement('input');
        idInput.name="id";
        idInput.hidden=true;
        idInput.value=id;
        let form=document.getElementById("addProductForm");
        form.action="${pageContext.request.contextPath}/Seller/changeProduct";
        form.appendChild(idInput);
    }
</script>

</body>
</html>