<%--
  Created by IntelliJ IDEA.
  User: 张晓桐
  Date: 2021/11/19
  Time: 21:00
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
    <title>店铺注册</title>
</head>
<body>
<div class="container">
    <div class="row">
        <div class=" col-md-12 ">
            <div class="panel panel-success panel-shadow">
                <div class="panel-heading" >
                    <h3 id="addProductTitle">
                        店铺注册
                    </h3>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" role="form"  action="${pageContext.request.contextPath}/Seller/shopRegister?userId=<%=request.getParameter("userId")%>" method="post" >
                        <input type="number" hidden="true" value="<%=request.getParameter("userId")%>">
                        <div class="form-group">
                            <label for="name" class="col-md-1 control-label"><p class="text-center">店铺名</p></label>
                            <div class="col-md-4">
                                <input type="text" class="form-control" id="name" name="name"
                                       placeholder="请输入名字">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="description" class="col-md-1 control-label"><p class="text-center">店铺介绍</p></label>
                            <div class="col-md-10">
                                <textarea class="form-control" rows="4" id="description" name="description"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-offset-5 col-md-2">
                                <button type="submit" class="btn btn-success btn-lg" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注册&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
