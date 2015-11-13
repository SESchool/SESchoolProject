<%@ page contentType="text/html;charset=utf-8" 		%>
<%@ page import="java.util.List"    					%>
<%@ page import="com.sinc.framework.persist.ListDTO"	%>
<%@ page import ="com.sinc.common.CodeParamDTO"%>
<%@ include file = "/jsp/front/common/commonBasicInc.jsp"	%>
<%
	 DataSet list = (DataSet)box.getObject("zipCodeList");
     String v_objname = box.getString("p_objname");
     //근무처 우편번호일경우 ozipcode='Y'
     String ozipcode = "";
     if(request.getParameter("ozipcode")!=null){
     	ozipcode = request.getParameter("ozipcode");
     }
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>::: 무역아카데미 트레이드캠퍼스 :::</title>
<fmtag:dwrcommon interfaceName="CommonUtilWork"/>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>

<!-- Open API 도로명주소 -->
<script language="javascript">
<%
if(box.getString("p_objname")!=null && (box.getString("p_objname").equals("home")||box.getString("p_objname").equals("glmphome")||box.getString("p_objname").equals("member")||box.getString("p_objname").equals("user")||box.getString("p_objname").equals("businessPLc"))){
}else{
	%>
	document.domain = "tradecampus.kita.net";	//aaa
	<%
}
%>

function getAddr(){	
	var f = document.form;
	var search = f.search.value;
	var pattern= /[~!@\#$%^&*\()\=+_']/gi;
	var keyword = "";
	
	if( isEmpty(search) ){
		alert("[에러] 검색할 도로명주소를 입력해주세요.");
		f.search.focus();
		return;
	}
	if(search.match(pattern)){
		alert("[에러] 특수문자는 입력하실 수 없습니다.");
		f.search.focus();
	   	return false;
	} 
	
	keyword = search;
	f.keyword.value = keyword;
	
	$.ajax({
		 url :"http://www.juso.go.kr/addrlink/addrLinkApiJsonp.do"  //인터넷망
		,type:"post"
		,data:$("#form").serialize()
		,dataType:"jsonp"
		,crossDomain:true
		,success:function(xmlStr){
			if(navigator.appName.indexOf("Microsoft") > -1){
				var xmlData = new ActiveXObject("Microsoft.XMLDOM");
				xmlData.loadXML(xmlStr.returnXml)
			}else{
				var xmlData = xmlStr.returnXml;
			}
			$("#list").html("");
			var errCode = $(xmlData).find("errorCode").text();
			var errDesc = $(xmlData).find("errorMessage").text();
			if(errCode != "0"){
				alert(errCode+"="+errDesc);
			}else{
				if(xmlStr != null){
					makeList(xmlData);
				}
			}
		}
	    ,error: function(xhr,status, error){
	    	alert("에러발생");
	    }
	});
}

function makeList(xmlStr){	
	var ADDR = '';					// 새로운 도로명주소
	var ADDR_OLD = '';				// 기존의 지번주소
	var ZIPCODE = '';				// 새로운 우편번호
	
	var htmlStr = "";
	htmlStr = '<table width="100%" cellpadding="0" cellspacing="0" border = "0">';
	htmlStr += '<colgroup><col width="60" /><col width="" /><col width="" /></colgroup>';

	$(xmlStr).find("juso").each(function(){
		ADDR = $(this).find('roadAddr').text();
		ADDR_OLD = $(this).find('jibunAddr').text();
		ZIPCODE = $(this).find('zipNo').text();
		
		htmlStr += '<tr height="40" onmouseover="changeBackground(this, 1);" onmouseout="changeBackground(this, 0);" >';
		htmlStr += '<td align="center"><a href="javascript:resultZipInfo(\''+ADDR+'\',\''+ZIPCODE+'\');" >'+ZIPCODE+'</a></td>';
		htmlStr += '<td><a href="javascript:resultZipInfo(\''+ADDR+'\',\''+ZIPCODE+'\');" >'+ADDR+'</a><br><a href="javascript:resultZipInfo(\''+ADDR_OLD+'\',\''+ZIPCODE+'\');" style="color:silver;">'+ADDR_OLD+'</a></td>';
		htmlStr += '</tr>';
	});
	htmlStr += "</table>";
	$("#list").html(htmlStr);
}

function enterSearch() {
	var evt_code = (window.netscape) ? ev.which : event.keyCode;
	if (evt_code == 13) {    
		event.keyCode = 0;  
		getAddr();
	} 
}
</script>
<!-- /Open API 도로명주소 -->
<script type="text/javascript">
// 공백여부 체크
function isEmpty(aString) {
    for(i=0 ; i<aString.length ; i++) {
       var ch = aString.charAt(i);
       if((ch != " ") && (ch != '\t'))
        return false;
    }
    return true;
}
// 마우스휠 이벤트
function changeBackground(element, number){
	switch (number) {
	case 0:
		// onmouseout
		element.style.backgroundColor = '#ffffff';
		break;
	case 1:
		// onmouseover
		element.style.backgroundColor = '#00CCFF';
		break;
	}
}
// 검색된 주소 클릭시
function resultZipInfo(addr,zipcode){
	var ozip;	
	ozip = '<%= ozipcode %>';
	
	if(ozip=='Y'){	//근무처 우편번호일경우
		opener.setOZipCodeInfo(addr,zipcode);
	}else{
		<%if(v_objname.equals("")||v_objname.equals("glmphome")){ %>
				opener.setZipCodeInfo(addr,zipcode);
		<% }else{ %>
		    opener.setZipCodeInfo('<%=v_objname%>', addr,zipcode);
		<%}%>
	}
	self.close();
}
</script>

<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
</head>
<body onload="form.search.focus();" style="margin:0px;width:460px;">
<form name="form" id="form" method="post">
<div style="display:none;">
	<input type="text" name="currentPage" value="1"/>
	<input type="text" name="countPerPage" value="200"/>
	<input type="text" name="keyword" value=""/> 
	<input type="hidden" name="confmKey" id="confmKey" value="U01TX0FVVEgyMDE1MTAwNTE1MDQ1MA=="/>
</div>
	
<br/>	
<table width="100%" height="100%" cellpadding="0" cellspacing="0">
<tr>
	<td align="center" height="100%" valign="top">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="42" background="/images/common/popup_header_bg.gif">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/common/popup_zipcode_title.gif"></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="100%" valign="top" align="center" style="padding:20px;">
				<table width="100%" cellpadding="0" cellspacing="0" style="border-top:solid 1px #696969; border-bottom: solid 1px #696969;">
				<colgroup>
					<col width="90" />
					<col width="" />
				</colgroup>				
				<tr>
					<td style="padding-left:10px; font-weight:bold; color:#696969; background-color:#eeeeee;">
						<img src="/images/template0/common/icon_pilsu.gif" hspace="5" /> 통합검색 :
					</td>
					<td style="padding-left:10px; font-weight:bold; color:#696969; background-color:#eeeeee;">
						<input type="text" name="search" value="" onkeydown="enterSearch();" style="border:solid 1px #a8abad; width:180px; height:19px;" autofocus="autofocus">
						<a href="#none" onClick ="getAddr();"><img src="/images/template0/common/btn_company_find.gif"></a>
					</td>
				</tr>
				<tr>
					<td style="padding-left:10px; font-weight:bold; color:#696969; background-color:#eeeeee;" colspan="2">
						ex) 도로명 : 영동대로 513<br>
						ex) 건물명 : 코엑스<br>
						ex) 지번 : 삼성동 159
						</p>
					</td>
				</tr>
				</table>
 
				<table width="100%" cellpadding="0" cellspacing="0" style="border-top:solid 1px #696969; border-bottom: solid 1px #696969; margin-top:15px;">
				<tr height="25" style="font-weight:bold; color:#696969; background-color:#eeeeee;">
					<td style="padding-left: 10px;">우편번호</td>
					<td>도로명주소</td>
				</tr>					
				<tr>
					<td colspan="2">
						<div id="list" style="overflow-y:scroll; height:250px;">
						<!-- 
							도로명주소 검색결과 리스트 출력
						 -->		
						</div>
					</td>
				</tr>
				</table>
 
			</td>
		</tr>
		<tr>
			<td height="25" background="/images/common/popup_footer_bg.gif" style="padding-left:20px; padding-right:20px;">
				<table width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/common/popup_footer_copyright.gif"></td>
					<td align="right">
						<a href="javascript:self.close();"><img src="/images/common/btn_popup_close.gif"></a></td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
	
</form>
</body>
</html>