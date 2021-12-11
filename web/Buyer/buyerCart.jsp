<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 张晓桐
  Date: 2021/11/15
  Time: 22:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@page import="utils.Product" %>
    <%@page import="DAO.ProductDao" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="java.sql.SQLException" %>
    <%@ page import="DAO.CartItemDao" %>
    <%@ page import="java.util.Collections" %>
    <%@ page import="utils.CartItem" %>
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
                                购物车
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th></th>
                                        <th>商品名</th>
                                        <th>价格</th>
                                        <th>数量</th>
                                        <th>总金额</th>
                                        <th style="width: 50px"></th>
                                    </tr>
                                    </thead>
                                    <tbody id="product-show">
                                    <%
                                        int userId= Integer.parseInt(request.getParameter("userId"));
                                        List<CartItem> cartItems=CartItemDao.listAllByUserId(userId);
                                        List<Product> products=new ArrayList<Product>();
                                        for (CartItem cartItem : cartItems) {
                                            int productId = cartItem.getProductId();
                                            Product product = ProductDao.getProductId(productId);
                                            System.out.println(cartItem);
                                            product.setPnum(cartItem.getBuyNum());
                                            System.out.println(product);
                                            products.add(product);
                                        }

                                    %>
                                    <c:forEach items="<%=products%>" var="product" varStatus="idx">
                                        <tr>
                                            <td><input type="checkbox" id="${product.id}_check" onchange="checkProduct(this,${product.id});" class="checkbox"></td>
                                            <td><img src="${pageContext.request.contextPath}${product.imgurl }"  class="img-cart" alt="请尝试刷新"></td>
                                            <td><strong>${product.name}</strong></td>
                                            <td id="${product.id}_price">${product.price}</td>
                                            <td><input type="number" step="1" min="1" value="${product.pnum}" id="${product.id}_buyNum" oldBuyNum="${product.pnum}"
                                                       onchange="ajaxChangeBuyNum(this.parentElement,${product.id},<%=request.getParameter("userId")%>,this.value,${product.price});
                                                               changeTotal(this,${product.id});" ></td>
                                            <td   style="color: #ac2925">${product.price*product.pnum}</td>
                                            <td><a href="${pageContext.request.contextPath}/Buyer/deleteCartItem?productId=${product.id}&userId=<%=request.getParameter("userId")%>"
                                                   class="btn btn-danger"><span class="glyphicon glyphicon-remove" ></span></a></td>
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
<!--底部导航栏-->
<nav class="navbar navbar-default navbar-fixed-bottom" role="navigation">
    <div class="container">
<%--        <div class="navbar-header">--%>
<%--            <a class="navbar-brand" href="#">菜鸟教程</a>--%>
<%--        </div>--%>
        <div class="row">
            <div class="col-md-5 col-md-offset-7">
                <ul class="nav" style="display: flex;align-items: center">
                    <li class="col-md-4">已选 &nbsp;<span id="totalProduct" style="color: #ff1f00">&nbsp;0</span>&nbsp; 件商品</li>
                    <li class="col-md-4">总计￥&nbsp;<span id="totalMoney" style="color: #ff1f00">&nbsp;0</span></li>
                    <li class="col-md-4" ><a href="#" class="btn btn-warning" onclick="settleAccounts(this);" id="settleBtn" style="visibility: hidden">结算</a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<script>
    function ajaxChangeBuyNum(t,pId,uId,buyNum,price) {
        let s=price*buyNum;
       t.nextElementSibling.innerText=s;
        let xmlHttpRequest;  // 创建XMLHttpRequest对象，即一个用于保存异步调用对象的变量
        if(window.ActiveXObject){ // IE浏览器的创建方式
            xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");
        }else if(window.XMLHttpRequest){ // Netscape浏览器中的创建方式
            xmlHttpRequest = new XMLHttpRequest();
        }
        xmlHttpRequest.onreadystatechange=function(){ // 设置响应http请求状态变化的事件
            console.log('请求过程', xmlHttpRequest.readyState);
            if(xmlHttpRequest.readyState === 4){ // 判断异步调用是否成功,若成功开始局部更新数据
                console.log('状态码为', xmlHttpRequest.status);
                if(xmlHttpRequest.status === 200) {
                    console.log('异步调用返回的数据为：', xmlHttpRequest .responseText);
                } else { // 如果异步调用未成功,弹出警告框,并显示错误状态码
                    alert("error:HTTP状态码为:"+xmlHttpRequest.status);
                }
            }
        }
        let str="userId="+uId+"&productId="+pId+"&buyNum="+buyNum;
        xmlHttpRequest.open("GET","${pageContext.request.contextPath}/Buyer/changeBuyNum?"+str,true); // 创建http请求，并指定请求得方法（get）、url（https://www.runoob.com/try/ajax/ajax_info.txt）以及验证信息
        xmlHttpRequest.send(null); // 发送请求
    }
    function changeTotal(event,pId) {
        let tProduct=document.getElementById("totalProduct");
        let tMoney=document.getElementById("totalMoney");
        let price=document.getElementById(pId+"_price");
        let old=event.getAttribute("oldBuyNum");
        let pNum=+event.value- +old;
        event.setAttribute("oldBuyNum",event.value);
            tMoney.innerText=(+price.innerText)*(+pNum) + +tMoney.innerText;
            tProduct.innerText=+pNum + +tProduct.innerText;

    }
    function checkProduct(event,pId) {
        let isCheck=event.checked;
        let tProduct=document.getElementById("totalProduct");
        let tMoney=document.getElementById("totalMoney");
        let pNum=document.getElementById(pId+"_buyNum").value;
        let price=document.getElementById(pId+"_price");
        if(isCheck){
            tMoney.innerText=(+price.innerText)*(+pNum) + +tMoney.innerText;
            tProduct.innerText=+pNum + +tProduct.innerText;
        }
        else{
            tMoney.innerText= +tMoney.innerText - ((+price.innerText)*(+pNum));
            tProduct.innerText= +tProduct.innerText -  +pNum;
        }

        if(+tProduct.innerText==0){
            document.getElementById("settleBtn").style.visibility="hidden";

        }else{
            document.getElementById("settleBtn").style.visibility="visible";
        }
    }
    function settleAccounts(event) {
        let checkBoxs=document.getElementsByClassName("checkbox");
        if(checkBoxs.length<=0) return;

        let href="${pageContext.request.contextPath}/Buyer/buyerSettleAccounts.jsp?username=<%=request.getParameter("username")%>&userId=<%=request.getParameter("userId")%>&productId=";
        for (let checkBox of checkBoxs){
            let isCheck=checkBox.checked;
            if(isCheck){
                let id_check=checkBox.getAttribute("id");
                let idx=id_check.indexOf("_");
                let id=id_check.substring(0,idx+1);
                href=href+id;
            }
        }
        href=href.substr(0,href.length-1);
        event.setAttribute("href",href);
    }
</script>
</body>
</html>
