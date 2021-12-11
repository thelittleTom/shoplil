<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="UTF-8">
    <title>登录页面</title>
    <meta name="description" content="Login - Register Template">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="main.css">

    <style>
        body {
            background-color: #303641;
        }
    </style>
</head>

<body style="position: relative">
    <div id="container-login">
        <div id="title">
            <i class="material-icons lock">lock</i>登录
        </div>

        <form action="${pageContext.request.contextPath}/user/Login" method="post" id="loginForm">
            <div id="message" style="color: brown">
                <% String  str=(String) request.getAttribute("message");
                    if(str!=null)
                        out.print(str);
                %>
            </div>
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

            <div style="margin-top: 5%;">
                <input type="submit" value="登录" />
            </div>
            
        </form>

        <div class="forgot-password">
            <a href="#">忘记密码？</a>
        </div>

        <div class="register">
            没有账户？
            <a href="register.jsp"><button id="register-link">点击注册</button></a>
        </div>
    </div>
    <div style="left: 45%;top: 92%;position: absolute">
        <a href="http://beian.miit.gov.cn/" class="text-center col-md-offset-5" style="color: aliceblue;text-decoration: none;">粤ICP备2021166258号-1</a>
    </div>
</body>

</html>
