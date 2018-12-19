<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2018/12/19
  Time: 11:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<head>
    <title>多图片上传</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/index.css">
</head>
<body>
<div>
    <jsp:include page="top.jsp"/>
</div>
<div style="float: left">
    <jsp:include page="left.jsp"/>
</div>
<div style="float: left">

    <div class="fozero-demo">
        <div class="title"><b>图片上传示例说明</b></div>
        <div class="item">标题：<span>多文件上传</span></div>
        <div class="item">描述：<span>1.支持图片上传预览 2.支持单个图片移除 3.支持图片格式及大小限制</span></div>
    </div>
    <%--<form action="${pageContext.request.contextPath}/file/filesUpload" method="POST" enctype="multipart/form-data">
        <div class="upload-content">
            <div class="content-img">
                <ul class="content-img-list">
                    <!-- <li class="content-img-list-item"><img src="https://www.baidu.com/img/bd_logo1.png" alt=""><a class="delete-btn"><i class="ico-delete"></i></a></li> -->
                </ul>
                <div class="file">
                    <i class="ico-plus">上传图片，支持jpg/png</i>
                    <input type="file" name="myfiles" accept="img/*" id="upload" >
                </div>
            </div>
            <div class="upload-tips">
                最多上传4张图片，单张最大1M
            </div>
        </div>
        <div class="upload-submit">
            <input type="submit" class="btn btn-success" value="提交 ">
        </div>
    </form>--%>
    <form action="${pageContext.request.contextPath}/file/filesUpload" method="POST"
          enctype="multipart/form-data">
        <table>
            <tr>
                <td>身份证图片上传：</td>
                <td><input type=file name="myfiles" id="doc"
                           onchange="showImage();">
                </td>
                <div id="localImag">
                    <img id="preview" width=-1 height=-1 style="diplay:none"  src=""/>
                </div>
            </tr>
            <tr>
                <td>公司运营情况:</td>
                <!-- 为了实现张图片上传，上传框这个name要都一样 -->
                <td><input type="file" name="myfiles" id="doc1" onchange="showImage()"></td>
                <td>
                </td>
            </tr>
            <tr>
                <td><input type="submit" class="btn btn-success" value="提交" />
                </td>
            </tr>
        </table>
    </form>
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/index.js"></script>
    <script type="text/javascript">
        function showImage() {
            var docObj = document.getElementById("doc");
            var imgObjPreview = document.getElementById("preview");
            if (docObj.files && docObj.files[0]) {
                //火狐下，直接设img属性
                imgObjPreview.style.display = 'block';
                imgObjPreview.style.width = '300px';
                imgObjPreview.style.height = '120px';
                //imgObjPreview.src = docObj.files[0].getAsDataURL();
                //火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式
                imgObjPreview.src = window.URL.createObjectURL(docObj.files[0]);
            } else {
                //IE下，使用滤镜
                docObj.select();
                var imgSrc = document.selection.createRange().text;
                var localImagId = document.getElementById("localImag");
                //必须设置初始大小
                localImagId.style.width = "250px";
                localImagId.style.height = "200px";
                //图片异常的捕捉，防止用户修改后缀来伪造图片
                try {
                    localImagId.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                    localImagId.filters
                        .item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;
                } catch (e) {
                    alert("您上传的图片格式不正确，请重新选择!");
                    return false;
                }
                imgObjPreview.style.display = 'none';
                document.selection.empty();
            }
            return true;
        }
    </script>
</div>
</body>
