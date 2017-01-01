<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String imgPath = basePath + "image/";
%>
<!DOCTYPE html>
<html>
      <head>
             <title>日向blog</title>
             <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
             <link type="text/css" rel="stylesheet" href="<%=basePath %>css/show_article.css" media="all" />
              <link rel="stylesheet" type="text/css" href="<%=basePath %>wangEditor/dist/css/wangEditor.min.css">
              <script type="text/javascript" src="<%=basePath %>Jquery/jquery-2.2.3.min.js"></script>
              <script type="text/javascript" src="<%=basePath %>Jquery/jquery-form.js"></script>   
             <script type="text/javascript" src="<%=basePath %>wangEditor/dist/js/wangEditor.js"></script>
             <script type="text/javascript">             
 			  $(document).ready(function() { 
				  $('#commentForm').ajaxForm({ 
			             dataType:      'json',
						 beforeSubmit:  validate,   
						 success:       successFunc
			   	  }); 
   
       	          var editor = new wangEditor('content');

                   // 上传图片
                  editor.config.uploadImgUrl = '/upload';
                  editor.config.uploadParams = {
                      // token1: 'abcde',
                      // token2: '12345'
                  };
                  editor.config.uploadHeaders = {
                      // 'Accept' : 'text/x-json'
                   }

                   // 表情显示项
                   editor.config.emotionsShow = 'value';
                   editor.config.emotions = {
                      'default': {
                          title: '默认',
                          data: './emotions.data'
                       },
                      'weibo': {
                          title: '微博表情',
                      data: [
                         {
                             icon: 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/7a/shenshou_thumb.gif',
                             value: '[草泥马]'    
                          },
                         {
                              icon: 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/60/horse2_thumb.gif',
                              value: '[神马]'    
                         },
                         {
                              icon: 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/bc/fuyun_thumb.gif',
                              value: '[浮云]'    
                         },
                         {
                               icon: 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/c9/geili_thumb.gif',
                               value: '[给力]'    
                         },
                         {
                               icon: 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/f2/wg_thumb.gif',
                               value: '[围观]'    
                          },
                         {
                                icon: 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/70/vw_thumb.gif',
                                value: '[威武]'
                         }
                       ]
                      }
                   };

                  // onchange 事件
                  editor.onchange = function () {
                       console.log(this.$txt.html());
                   };
                   editor.create();
		       });
		       
		       
			   function validate(formData, jqForm, options) {
			       for(var i=0; i < formData.length; i++) {
			        	if(!formData[i].value.trim()) {
			        	    alert("评论内容不可为空");
			        		return false;
			        	}
			        } 
			        var queryString = $.param(formData);
                    return true; 
				}
				function successFunc(data) {
					if (data.success) {
					    var old_url = window.location.href;
					    var index = old_url.search("currentPage"); 
					    if (index != -1) {
					        //若当前不是第一页，则评论成功后跳转到第一页
					    	str_to_replace = old_url.substring(index, old_url.length);
					    	new_url = old_url.replace(str_to_replace, "");
					    	location.href = new_url;
					    } else {
					        //若当前是第一页，则评论成功后刷新当前页
					    	window.location.reload();
					    }
					}
					else {
						alert(data.msg);
					}
				}
               </script>
      </head>
      <body>
             <div id="header">
			  	<div id="navigator">
			  		<ul id="navList">
			  			<li><font>日   向  博  客&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</font></li>
			  			<c:if test="${empty username}"><li><a href ="/RiXiang_blog/login/show.form">登录</a></li></c:if>
			  			<c:if test="${empty username}"><li><a href ="/RiXiang_blog/register/show.form">注册</a></li></c:if>
			  			<li><a href ="/RiXiang_blog/article/list.form">主页</a></li>
			  			<c:if test="${!empty username}"><li><a href ="/RiXiang_blog/space/list.form">个人主页 - ${username}</a></li></c:if>
			  			<c:if test="${!empty username}"><li><a href ="/RiXiang_blog/mine/show.form">个人空间 - ${username}</a></li></c:if>
			  			<c:if test="${!empty username}"><li><a href ="/RiXiang_blog/article/writeArticlePage.form">写博客</a></li></c:if>
			  			<li><a href ="/RiXiang_blog/game/snake.form">贪吃蛇</a></li>
			  			<li><a href ="/RiXiang_blog/sonne/blog.form">作者-博客开发记录</a></li>
			  		</ul>
			  	</div>
			  </div>
              <div id = "page_content">
                    <h id = "article_title">${article.title}</h> <br><br>
                    <p> ${article.content}</p>
                    <div id = "author">by：${article.authorName}</div> <br/> <br/> 
                    
                    <!-- JiaThis Button BEGIN -->
                    <div class="jiathis_style_24x24">
                      	<a class="jiathis_button_qzone"></a>
	                    <a class="jiathis_button_tsina"></a>
	                    <a class="jiathis_button_tqq"></a>
                    	<a class="jiathis_button_weixin"></a>
	                    <a class="jiathis_button_renren"></a>
                     	<a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jtico jtico_jiathis" target="_blank"></a>
	                    <a class="jiathis_counter_style"></a>
                    </div>
                    <script type="text/javascript" src="http://v3.jiathis.com/code_mini/jia.js" charset="utf-8"></script>
                    <!-- JiaThis Button END -->
                    <br/>
                    <br/>
                    
					<div class="comment">
                          <c:forEach items="${comments_page.content}" var="comment">
								<div class="comment_box">
                                    <span class = "date">#${comment.floor}楼  &nbsp${fn:substring(comment.date,0,16)}</span> &nbsp&nbsp<span class = "author">${comment.authorName}</span><br> 
                                     <p>${comment.content}</p>
								</div>                          
                          </c:forEach>
                          
                        <div id = "page_select">   
                           共${comments_page.pageInfo.totalCount}条纪录，当前第${comments_page.pageInfo.currentPage}/${comments_page.pageInfo.totalPage}页，每页${comments_page.pageInfo.everyPage}条纪录
                             <c:choose>
                                    <c:when test = "${comments_page.pageInfo.hasPrePage}">
                                     			<a href="<%=basePath %>article/show.form?id=${article_id}&currentPage=1">首页</a>
				                                <a href="<%=basePath %>article/show.form?id=${article_id}&currentPage=${comments_page.pageInfo.currentPage-1}">上一页</a>
                                    </c:when>
                                    <c:otherwise>
                                           		   首页
				                                                                                          上一页
                                    </c:otherwise>
                            </c:choose>
                            <c:choose>
                                     <c:when test = "${comments_page.pageInfo.hasNextPage}">
                                                <a href="<%=basePath %>article/show.form?id=${article_id}&currentPage=${comments_page.pageInfo.currentPage+1}">下一页</a> 
				                                <a href="<%=basePath %>article/show.form?id=${article_id}&currentPage=${comments_page.pageInfo.totalPage}">尾页</a>
                                     </c:when>
                                     <c:otherwise>
                                                                                                                                          下一页
                                                                                                                                            尾页
                                     </c:otherwise>
                            </c:choose>
                        </div>
                         <p>写评论：</p>
                             <c:choose>
                                <c:when test = "${empty username}">
                                      <p id="login_before_comment"> 【登录后发表你的看法 (ฅ´ω`ฅ)】 </p>
                                </c:when>
                                <c:otherwise>
                                      <form id="commentForm" action="/RiXiang_blog/comment/writeComment.form" method="post">
                                            <textarea id="comment_txt" name="content">
                                            </textarea> 
                                            <input type="text" style="display:none" name="article_id" value="${article.id}"><br/>
                                            &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                                            <input name="提交" type="submit" class="button" style="height:30px;width:100px;background:black;color:white" value="写完了（￣ c￣）y" />
                                      </form> 
                               </c:otherwise>
                          </c:choose>                                   
                         <!--    共${page.pageInfo.totalCount}条评论，当前第${page.pageInfo.currentPage}/${page.pageInfo.totalPage}页，每页${page.pageInfo.everyPage}条评论  -->
                    </div>
               </div>
      </body>
</html>