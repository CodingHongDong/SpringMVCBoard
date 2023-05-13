<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring MVC</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
<script type="text/javascript">
	$(document).ready(function() {
		if(${!empty msgType}) {
			$("#message").attr("class", "modal-content panel-warning");
			$("#myMessage").modal("show");
		}
	});

	function registerCheck() {
		var memID = $("#memID").val();
		$.ajax({
			url : "${contextPath}/memRegisterCheck.do",
			type : "get",
			data : {"memID" : memID},
			success : function(result) {
				// 중복유무 출력(result=1 : 사용할수있는 아이디, 0 : 사용할수 없는 아이디)
				if(result == 1) {
					$("#checkMessage").html("사용 할 수 있는 아이디 입니다.");
					$("#checkType").attr("class", "modal-content panel-success");
				} else {
					$("#checkMessage").html("사용 할 수 없는 아이디 입니다.")
					$("#checkType").attr("class", "modal-content panel-warning");
				}
				$("#myModal").modal("show");
			},
			error : function() {alert("error");}
		});
	}
	
	function passwordCheck() {
		var memPassword1 = $("#memPassword1").val();
		var memPassword2 = $("#memPassword2").val();
		if(memPassword1 != memPassword2) {
			$("#passMessage").html("비밀번호가 서로 일치하지 않습니다");
		}else {
			$("#passMessage").html("");
			$("#memPassword").val(memPassword2);
		}
	}

	function goInsert() {
		var memAge = $("#memAge").val();
		if(memAge == null || memAge == "" || memAge == 0) {
			alert('나이를 입력하세요');
			return false;
		}
		document.frm.submit();
	}
	
</script>  
  
</head>
<body>
<div class="container">
<jsp:include page="../common/header.jsp" /> 
  <div class="panel panel-default">
    <div class="panel-heading">회원가입</div>
    <div class="panel-body">
    	<form name="frm" action="${contextPath}/memRegister.do" method="post">
    		<input type="hidden" id="memPassword" name="memPassword" value="">
    		<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd;">
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">아이디</td>
    				<td><input class="form-control" type="text" id="memID" name="memID" maxlength="20" placeholder="아이디를 입력하세요."></td>
    				<td style="width: 110px;"><button class="btn btn-primary btn-sm" type="button" onclick="registerCheck()">중복확인</button></td>
    			</tr>
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">비밀번호</td>
    				<td colspan="2"><input class="form-control" type="password" onkeyup="passwordCheck()" id="memPassword1" name="memPassword1" maxlength="20" placeholder="비밀번호를 입력하세요."></td>
    			</tr>
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">비밀번호확인</td>
    				<td colspan="2"><input class="form-control" type="password" onkeyup="passwordCheck()" id="memPassword2" name="memPassword2" maxlength="20" placeholder="비밀번호를 확인하세요."></td>
    			</tr>
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">사용자 이름</td>
    				<td colspan="2"><input class="form-control" type="text" id="memName" name="memName" maxlength="20" placeholder="이름을 입력하세요."></td>
    			</tr>
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">나이</td>
    				<td colspan="2"><input class="form-control" type="number" id="memAge" name="memAge" maxlength="20" placeholder="나이를 입력하세요."></td>
    			</tr>
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">성별</td>
    				<td colspan="2">
    					<div class="form-group" style="text-align: center; margin: 0 auto;">
    						<div class="btn-group" data-toggle="buttons">
    							<label class="btn btn-primary active">
    								<input type="radio" id="memGender" name="memGender" autocomplete="off" value="남자" checked/>남자
    							</label>
    							<label class="btn btn-primary active">
    								<input type="radio" id="memGender" name="memGender" autocomplete="off" value="여자"/>여자
    							</label>
    						</div>
    					</div>
    				</td>
    			</tr>
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">이메일</td>
    				<td colspan="2"><input class="form-control" type="email" id="memEmail" name="memEmail" maxlength="20" placeholder="이메일을 입력하세요."></td>
    			</tr>
    			
    			<!-- 권한 체크박스 추가 -->
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">사용자 권한</td>
    				<td colspan="2">
    					<input type="checkbox" name="authList[0].auth" value="ROLE_USER"> ROLE_USER
    					<input type="checkbox" name="authList[1].auth" value="ROLE_MANAGER"> ROLE_MANAGER
    					<input type="checkbox" name="authList[2].auth" value="ROLE_ADMIN"> ROLE_ADMIN
    				</td>
    			</tr>
    			
    			<tr>
    				<td colspan="3" style="text-align: left;">
    					<span id="passMessage" style="color: red;"></span><input type="button" class="btn btn-primary btn-sm pull-right" value="등록" onclick="goInsert()"/>
    				</td>
    			</tr>
    		</table>
    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    	</form>
    </div>
    <!-- 모달창 -->
    <div id="myModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	    <!-- Modal content-->
	    <div id="checkType" class="modal-content panel-info">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">메세지 확인</h4>
	      </div>
	      <div class="modal-body">
	        <p id="checkMessage"></p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
    
    <!-- 실패 메세지를 출력(modal) -->
    <div id="myMessage" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	    <!-- Modal content-->
	    <div id="message" class="modal-content panel-info">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">${msgType}</h4>
	      </div>
	      <div class="modal-body">
	        <p>${msg}</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
    
    <div class="panel-footer">CodingHongDong</div>
  </div>
</div>