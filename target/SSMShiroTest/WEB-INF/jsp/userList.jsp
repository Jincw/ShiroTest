<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2018/12/13
  Time: 17:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>用户信息</title>
</head>
<body>
<div>
    <jsp:include page="top.jsp"/>
</div>
<div style="float: left">
    <jsp:include page="left.jsp"/>
</div>
<div class="well well-lg" style="float: left;margin-left: 300px">
    <h3>用户信息</h3>
    <form action="#">
        <input value="添加" type="button" style="background-color: #0066bb; color: white" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
        <!-- 模态框（Modal） -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h2 class="modal-title" id="myModalLabel">
                            添加用户信息
                        </h2>
                    </div>
                    <div>
                        <li class="form-row">
                            <span style="white-space:pre">	</span><span class="form-lbl"><i class="tip form-tip">*</i>姓名：</span>
                            <input type="text" name="username">
                            <span style="white-space:pre">	</span><span class="form-lbl"><i class="tip form-tip">*</i>密码：</span>
                            <input type="text" name="username">
                        </li>
                        <li class="form-row">
                            <span style="white-space:pre">	</span><span class="form-lbl"><i class="tip form-tip">*</i>邮箱：</span>
                            <input type="text" name="email">
                            <span style="white-space:pre">	</span><span class="form-lbl"><i class="tip form-tip">*</i>手机号：</span>
                            <input type="text" name="phone">
                        </li>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal" >关闭
                        </button>
                        <button type="button" class="btn btn-primary">
                            提交更改
                        </button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
        <table class="table table-hover">
            <caption>用户信息表</caption>
            <thead>
            <tr>
                <th>操作</th>
                <th>用户编号</th>
                <th>姓名</th>
                <th>邮箱</th>
                <th>手机号</th>
            </tr>
            </thead>


            <script type="text/javascript">
                $(function(){
                    $("#myAlert").bind('closed.bs.alert', function () {
                        alert("确认删除？");
                    });
                });
            </script>

            <tbody>
            <c:forEach items="${userList}" var="user">
                <tr>
                    <td>
                        <p>
                            <a href="#" class="btn btn-info btn-lg">
                                <span class="glyphicon glyphicon-pencil"></span>
                            </a>
                        </p>
                    </td>
                    <td>
                        <strong>${user.id}</strong>
                    </td>
                    <td>
                        <strong>${user.username}</strong>
                    </td>
                    <td>
                        <strong>${user.email}</strong>
                    </td>
                    <td>
                        <strong>${user.phone}</strong>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>
