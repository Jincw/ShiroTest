<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2018/12/13
  Time: 17:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="panel panel-default" style="width: 125px;margin-top: 10px;margin-left: 25px">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a data-toggle="collapse" data-parent="#accordion"
               href="#collapseThree" style="color: #0066bb">
                用户中心
            </a>
        </h4>
    </div>
    <div id="collapseThree" class="panel-collapse collapse">
        <div class="panel-body">
            <h5><a href="${pageContext.request.contextPath}/user/listAllUser?pageCode=1" style="color: #0066bb">用户管理</a></h5>
            <h5><a href="${pageContext.request.contextPath}/file/toUpload" style="color: #0066bb">上传图片</a></h5>
        </div>
    </div>
</div>