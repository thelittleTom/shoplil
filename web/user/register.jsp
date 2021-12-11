<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>

<head>
    <meta charset="UTF-8">
    <title>注册页面</title>
    <meta name="description" content="Login - Register Template">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="main.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        body {
            background-color: #303641;
        }
    </style>
</head>

<body style="position: relative">
<div id="container-register">
    <div id="title">
        <i class="material-icons lock">lock</i> 注册
    </div>

    <form action="${pageContext.request.contextPath}/user/Regist"  method="post">
        <div id="message" style="color: brown">
            <% String  str=(String) request.getAttribute("message");
                if(str!=null)
                    out.print(str);
            %>
        </div>
<%--        <div>--%>
<%--            <label><input type="radio"  name="role" value="B"checked>我是用户</label>--%>
<%--            <label><input type="radio"  name="role" value="S" checked>我是企业</label>--%>
<%--        </div>--%>
        <div class="input">
            <div class="input-addon">
                <i class="material-icons">email</i>
            </div>
            <input id="email" placeholder="Email" type="email" required class="validate" autocomplete="off" name="email">
        </div>

        <div class="clearfix"></div>

        <div class="input">
            <div class="input-addon">
                <i class="material-icons">face</i>
            </div>
            <input id="username" placeholder="Username" type="text" required class="validate" autocomplete="off" name="username">
        </div>

        <div class="clearfix"></div>

        <div class="input">
            <div class="input-addon">
                <i class="material-icons">vpn_key</i>
            </div>
            <input id="password" placeholder="Password" type="password" required class="validate" autocomplete="off" name="password">
        </div>

        <div style="margin-top: 8%;">
            <input type="submit" value="注册" />
        </div>
    </form>


    <div class="register">
        已经有一个账户了？
        <a href="login.jsp"><button id="register-link">点击登录</button></a>
    </div>

</div>
<div style="left: 45%;top: 92%;position: absolute;">
    <a href="http://beian.miit.gov.cn/" class="text-center col-md-offset-5" style="color: aliceblue;text-decoration: none;">粤ICP备2021166258号-1</a>
</div>
</body>

</html>
