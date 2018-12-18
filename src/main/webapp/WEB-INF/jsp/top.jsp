<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
    <meta charset="utf-8">
    <title>Bootstrap 实例 - 一个简单的网页</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="jumbotron text-center" style="margin-bottom:0">
    <h1>用户管理系统</h1>
    <p>对用户的一些简单管理操作</p>
</div>

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">UMS用户管理系统</a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav">
                <li><a href="${pageContext.request.contextPath}/user/listAllUser?pageCode=1">主页</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-left">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        个人中心
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath }/user/queryByName?username=${msg}">个人资料</a></li>
                        <li><a href="${pageContext.request.contextPath }/user/updateByName?username=${msg}">资料修改</a></li>
                        <li><a href="${pageContext.request.contextPath }/user/updatePwd">密码修改</a></li>
                        <li><a href="${pageContext.request.contextPath }/user/listOrg">我的权限</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-left">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        用户中心
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath }/user/listAllUser">用户列表</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-left">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        权限管理
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath }/user/roleList">角色列表</a></li>
                        <li><a href="${pageContext.request.contextPath }/user/getUserRoleList">角色分配</a></li>
                        <li><a href="${pageContext.request.contextPath }/user/permissionList">权限列表</a></li>
                        <li><a href="${pageContext.request.contextPath }/user/getRolePermissionList">权限分配</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        ${msg} <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath }/user/queryByName?username=${msg}">个人资料</a></li>
                        <li><a href="${pageContext.request.contextPath }/user/logout">退出登录</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>


