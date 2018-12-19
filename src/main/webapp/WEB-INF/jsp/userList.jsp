<%--suppress ALL --%>
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
    //全选/全不选
    function ckAll(){
        var flag=document.getElementById("allChecks").checked;
        var cks=document.getElementsByName("check");
        for(var i=0;i<cks.length;i++){
            cks[i].checked=flag;
        }
    }
    //批量删除
    function delAllUser(){
        var cks=document.getElementsByName("check");
        var str="";
        //拼接所有的图书id
        for(var i=0;i<cks.length;i++){
            if(cks[i].checked){
                str+="id="+cks[i].value+"&";
            }
        }
        if (str.length===0){
            alert("未选中用户信息！");
            return;
        }
        if(!confirm("确定要删除这些用户信息吗？")){
            return ;
        }
        str=str.substring(0, str.length-1);//去掉字符串末尾的‘&’
        location.href="${pageContext.request.contextPath}/user/delAlluser?"+str;
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
        <button type="button" class="btn btn-warning" onclick="delAllUser()">删除选中</button>
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
                <th align="center" width="12%">
                    <label>
                        <input type="checkbox" id="allChecks"  onclick="ckAll()" /> 全选/全不选
                    </label>
                </th>
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
                    <td style="CURSOR: hand; HEIGHT: 22px" align="center" width="23">
                        <label>
                            <input type="checkbox" name="check" value="${user.id}">
                        </label>
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
                            <button id="deleteButton" type="button" class="btn btn-danger" onclick="deleteUserById('${user.id}')">删除</button>
                            <button id ="updateButton" type="button" class="btn btn-warning"><a href="${pageContext.request.contextPath}/user/updUserById?id=${user.id}">编辑</a></button>
                        </strong>
                    </td>
                </tr>
            </c:forEach>
            <tr>
                <td colspan="4">
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
                </td>

                <td colspan="2">
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
