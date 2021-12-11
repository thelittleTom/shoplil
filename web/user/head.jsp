<%@ page import="utils.CookieUtils" %><%--
  Created by IntelliJ IDEA.
  User: 张晓桐
  Date: 2021/11/20
  Time: 15:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container-fluid"  style="background:white;">
    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <ul class="breadcrumb" style="margin-bottom: 3px;background-color: white">
                    <%
                        String  username=CookieUtils.getCookieValue(request,"username");
                       String userId = CookieUtils.getCookieValue(request,"userId");
                    %>
                    <li class="active"><%out.print(username);%>,欢迎您</li>
                    <li><a href="${pageContext.request.contextPath}/user/login.jsp" onclick="quit();">退出登录</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/logOut?userId=<%=userId%>" onclick="quit()">注销</a></li>
                </ul>
            </div>
            <div class="col-md-5 col-md-offset-4">
                <ul class="breadcrumb" style="margin-bottom: 3px;background-color: white">
                    <li><a href="${pageContext.request.contextPath}/Buyer/buyerProduct.jsp">商品首页</a></li>
                    <li><a href="${pageContext.request.contextPath}/Buyer/buyerCart.jsp?username=<%=username%>&userId=<%=userId%>">购物车</a></li>
                    <li><a href="${pageContext.request.contextPath}/Buyer/buyerHistory.jsp">足迹</a> </li>
                    <li><a href="${pageContext.request.contextPath}/Buyer/buyerOrder.jsp">我的订单</a> </li>
                    <li id="myShopCheck"><a href="${pageContext.request.contextPath}/Seller/shopLogin?username=<%=username%>&userId=<%=userId%>">我的店铺</a></li>
                    <li  id="myShopDrop" class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            我的店铺
                            <b class="caret"></b>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="${pageContext.request.contextPath}/Seller/shopLogin?username=<%=username%>&userId=<%=userId%>">商品管理</a></li>
                            <li><a href="${pageContext.request.contextPath}/Seller/sellerOrder.jsp">订单查看</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<script>
    function quit() {
        document.cookie = "username=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/";
        document.cookie = "shopId=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/";
        document.cookie = "history=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/";
    }
    <%
        boolean drophidden=true;
        String shopId=CookieUtils.getCookieValue(request,"shopId");
        if(shopId!=null) drophidden=false;
    %>
    if(<%=drophidden%>){
        document.getElementById("myShopDrop").remove();
    }else{
        document.getElementById("myShopCheck").remove();
    }
</script>