<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2018/12/13
  Time: 17:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<script>
    function deleteUserById(id){
        var flag = confirm("你确定要删除吗？");
        if (flag){
            $.ajax({
                url:"${pageContext.request.contextPath}/user/delUserById",
                type:"post",
                async:false,
                data:{id:id},
                dataType: 'json',
                success:function(){
                    if(data.stateCode.trim() == "1" ) {
                        window.location.reload();
                    }
                }
            })
        }
    }
</script>
<div>
    <jsp:include page="top.jsp"/>
</div>
<div style="float: left">
    <jsp:include page="left.jsp"/>
</div>
<div class="well well-lg" style="float: left;margin-left: 300px">
    <h3>用户信息</h3>
    <form class="listFrom" action="${pageContext.request.contextPath}/user/listAllUser">
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
                        <ul>
                            <li class="form-row">
                                <span style="white-space:pre">	</span><span class="form-lbl"><i class="tip form-tip">*</i>姓名：</span>
                                <label>
                                    <input type="text" name="username">
                                </label>
                                <span style="white-space:pre">	</span><span class="form-lbl"><i class="tip form-tip">*</i>密码：</span>
                                <label>
                                    <input type="text" name="username">
                                </label>
                            </li>
                            <li class="form-row">
                                <span style="white-space:pre">	</span><span class="form-lbl"><i class="tip form-tip">*</i>邮箱：</span>
                                <label>
                                    <input type="text" name="email">
                                </label>
                                <span style="white-space:pre">	</span><span class="form-lbl"><i class="tip form-tip">*</i>手机号：</span>
                                <label>
                                    <input type="text" name="phone">
                                </label>
                            </li>
                        </ul>
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

        <table class="table table-hover" style="width: 1000px">
            <caption>用户信息表</caption>
            <thead>
            <tr>
                <th>编辑</th>
                <th>用户编号</th>
                <th>姓名</th>
                <th>邮箱</th>
                <th>手机号</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${page.beanList}" var="user">
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
                    <td>
                        <strong>
                            <button id="deleteButton" class="layui-btn layui-btn-danger layui-btn-mini" onclick="deleteUserById('${user.id}')">删除</button>
                        </strong>
                    </td>
                </tr>
            </c:forEach>
            <tr>
                <td colspan="5">
                    <label style="color: #3a8ee6">
                        <strong>共<b>${page.totalCount}</b>条记录，共<b>${page.totalPage}</b>页</strong>&nbsp;&nbsp;
                        <strong>每页显示</strong>
                        <select class="from-control" name="pageSize">
                            <option value="2" <c:if test="${page.pageSize == 2}">selected <c:set var="pageSize" value="2"/> </c:if> >
                                2
                            </option>
                            <option value="3" <c:if test="${page.pageSize == 3}">selected <c:set var="pageSize" value="3"/></c:if> >
                                3
                            </option>
                            <option value="4" <c:if test="${page.pageSize == 4}">selected <c:set var="pageSize" value="4"/></c:if> >
                                4
                            </option>
                            <option value="5" <c:if test="${page.pageSize == 5}">selected <c:set var="pageSize" value="5"/></c:if> >
                                5
                            </option>
                        </select>
                        <strong>条</strong>&nbsp;&nbsp;
                        <strong>到第</strong>&nbsp;<input type="text" size="3" id="page" name="pageCode" class="from-control input-sm" style="width: 50px">&nbsp;<strong>页</strong>&nbsp;
                        <button type="submit" class="btn btn-sm btn-info">Go!</button>
                    </label>

                    <ul class="pagination" style="color: #50f300">
                        <li>
                            <a href="${pageContext.request.contextPath}/user/listAllUser?pageCode=1&pageSize=${pageSize}"><strong>首页</strong></a>
                        </li>

                        <li>
                            <c:if test="${page.pageCode gt 1}">
                                <a href="${pageContext.request.contextPath}/user/listAllUser?pageCode=${page.pageCode - 1}&pageSize=${pageSize}">
                                    <span class="glyphicon glyphicon-backward"></span>
                                </a>
                            </c:if>
                        </li>

                        <%--写关于分页页码的逻辑--%>
                        <c:choose>
                            <c:when test="${page.totalPage <= 5}">
                                <c:set var="begin" value="1"/>
                                <c:set var="end" value="${page.totalPage}"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="begin" value="${page.pageCode - 1}"/>
                                <c:set var="end" value="${page.pageCode + 3}"/>
                                <!--头溢出-->
                                <c:if test="${begin lt 1}">
                                    <c:set var="begin" value="1"/>
                                    <c:set var="end" value="5"/>
                                </c:if>
                                <!--尾溢出-->
                                <c:if test="${end gt page.totalPage}">
                                    <c:set var="begin" value="${page.totalPage - 4}"/>
                                    <c:set var="end" value="${page.totalPage}"/>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                        <%--显示页码--%>

                        <c:forEach var="i" begin="${begin}" end="${end}">
                            <%--判断是否是当前页--%>
                            <c:if test="${i == page.pageCode}">
                                <li class="active"><a href="javascript:void(0);">${i}</a></li>
                            </c:if>
                            <c:if test="${i != page.pageCode}">
                                <li>
                                    <a href="${pageContext.request.contextPath}/user/listAllUser?pageCode=${i}&pageSize=${pageSize}">${i}</a>
                                </li>
                            </c:if>
                        </c:forEach>

                        <li>
                            <c:if test="${page.pageCode lt page.totalPage}">
                                <a href="${pageContext.request.contextPath}/user/listAllUser?pageCode=${page.pageCode + 1}&pageSize=${pageSize}">
                                    <span class="glyphicon glyphicon-forward"></span>
                                </a>
                            </c:if>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/user/listAllUser?pageCode=${page.totalPage}&pageSize=${pageSize}"><strong>末页</strong></a>
                        </li>
                    </ul>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
</body>
</head>
