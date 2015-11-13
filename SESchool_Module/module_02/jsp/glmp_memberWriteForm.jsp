<%--
 * @(#)SystemCode Template
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * T_LMS_MEMBER 테이블 List Template.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2010. 11. 06.  leehj       Initial Release
 ************************************************
--%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file = "/jsp/back/common/commonInc.jsp"%>
<%@ page import ="com.sinc.common.CodeParamDTO"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>원우명단등록</title>
<fmtag:csscommon point="back" />
<fmtag:jscommon />
<script language="Javascript" src="/js/common/calendar.js"></script>
<script type="text/JavaScript" language="JavaScript" src="/js/common/util.js"></script>
<fmtag:dwrcommon interfaceName="MemberWork"/>
<fmtag:dwrcommon interfaceName="CommonUtilWork"/>
<%

	//협회 ip대역이 아닌곳에서 접근시 ip접근제한
	String ipis = request.getHeader("Proxy-Client-IP");
	if(ipis==null){
		ipis = request.getLocalAddr();
	}
	String check_ip = "203.233.";
	if( !(ipis.contains(check_ip+"199") || ipis.contains(check_ip+"201")) ){
		%>
		<script>
		alert("지정된 관리자 IP대역이 아닙니다");
		top.location.href="http://tradecampus.kita.net/jsp/back/";
		</script>
<%
	}
	
	Box userdata = (Box)box.getObject("glmpuserinfo");
	if(userdata==null) userdata = new Box("glmpuserinfo");

%>
<script language="javascript">

    function memberWrite(){
       	var f = document.form1;
       	
       	
       	
       	
		/* if(f.p_handphone1.value !="" && f.p_handphone2.value !="" && f.p_handphone3.value!=""){
			f.p_handphone.value = f.p_handphone1.value+"-" +f.p_handphone2.value+"-"+f.p_handphone3.value;
       	}
		if(f.p_comptel1.value !="" && f.p_comptel2.value !="" &&  f.p_comptel3.value!=""){
			f.p_comptel.value = f.p_comptel1.value+"-" + f.p_comptel2.value+"-" + f.p_comptel3.value;
       	}
		if(f.p_fax1.value !="" &&  f.p_fax2.value !="" &&  f.p_fax3.value!=""){
			f.p_fax.value = f.p_fax1.value+"-" + f.p_fax2.value+"-" + f.p_fax3.value;
       	} */
       	
       	
       	var month, day;
       	if(f.p_birth1.value!=""&&f.p_birth2.value!=""&&f.p_birth3.value!=""){
	       	if(f.p_birth2.value!="" && f.p_birth2.value<10){
	       		month ="0"+f.p_birth2.value;
	       	}else{
	       		month = f.p_birth2.value;
	       	}
	       	if(f.p_birth3.value!="" && f.p_birth3.value<10){
	       		day ="0"+f.p_birth3.value;
	       	}else{
	       		day = f.p_birth3.value;
	       	}
	       	f.p_birth.value = f.p_birth1.value + month +day;
       	}
       	
       	if(f.p_glmpseq.value==""){
       		alert("기수를 입력하세요");
       		return;
       	}       	
        f.action = "/back/Glmp.do?cmd=glmpMemberWrite&glmpseq="+f.p_glmpseq.value+"&p_mode="+f.p_mode.value;
        
         
        /* if(!validate(f)) return; */
        /* f.encoding = "application/x-www-form-urlencoded"; */  
	    f.submit();
    }
	
	function memberList(){
	    var f = document.form1;
	    
	    f.method = "get";
	    f.encoding	= "application/x-www-form-urlencoded";
	    f.cmd.value="glmpMemberList";   
	    f.submit();
	}
	
	
	
	function memberDelete(){
   	    var f = document.form1;
	    
	    if(!confirm("현재 사용자를 삭제하시겠습니까?")) return;
	    
	    f.encoding	= "application/x-www-form-urlencoded";
	    f.cmd.value="glmpMemberDelete";   
	    f.submit();
	}

	function searchZipCode(objname) {
		var url = "/front/Common.do?cmd=selectZipCode&p_objname="+objname; 
		Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
	}
	function setZipCodeInfo(objname, addr, zipcode) {
		var form = document.form1;

	    if ( objname == "user" ) {
			form.p_addr.value = addr;
			if(zipcode.search('-') > -1){	
				form.p_post1.value = zipcode.substr(0, 3) ;
				form.p_post2.value = zipcode.substr(4, 7) ;	
			} else {
				form.p_post1.value = zipcode;		// 새로운 우편주소, 하나의 텍스트란에 넣음
				form.p_post2.value = "";
				form.p_post2.style.display="none";
			}
	    }
	}	

	function selectPostGb(){
		var f = document.form1;
		var postgb = f.p_postgb.value;
		var homeTr = null, compTr = null;
		 
	}

	function fileDownload(rfileName, sfileName, filePath) {
		  var loc = "/fileDownServlet?rFileName="+rfileName+"&sFileName="+sfileName+"&filePath="+filePath;
		  location.href = loc;
		  hiddenFrame.location.href = loc;
	}

    function oldFileDel(idx){
    	var f = document.form1;
    	var oldImg = document.getElementById("OldFile"+idx);
    	var oldFile = f["p_oldfile"+idx];
    	var oldRealFile = f["p_oldrealfile"+idx];

         oldImg.style.display = "none";
         oldFile.value = "";
         oldRealFile.value = "";      	
    }

    function chngUserGubun(){
    	var f = document.form1;
    
    	f.encoding	= "application/x-www-form-urlencoded";
   	    f.cmd.value="glmpMemberWriteForm";
    	f.action = "/back/Member.do";
    	f.submit();
    }
    
    function fileUploadPreview(thisObj, preViewer) {

		var f = document.form1;
		
		/* f.p_ispicturedelete.value = "Y"; */
		
	    if(!/(\.gif|\.jpg|\.jpeg|\.png)$/i.test(thisObj.value)) {
	        alert("이미지 형식의 파일을 선택하십시오");
	        return;
	    }

	    preViewer = (typeof(preViewer) == "object") ? preViewer : document.getElementById(preViewer);
	    preViewer.innerHTML = "";
	    var ua = window.navigator.userAgent;

	    if (ua.indexOf("MSIE 8") > -1) {
	        thisObj.select();

	        var selectionRange = document.selection.createRange();
	        var selectionText = selectionRange.text.toString();

	        preViewer.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='file://" + selectionText +"', sizingMethod='scale')";
	        thisObj.blur();
	    } else if (ua.indexOf("MSIE 7") > -1) {
	        preViewer.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='file://" + thisObj.value +"', sizingMethod='scale')";
	    } else {
	        preViewer.innerHTML = "";
	        var W = preViewer.offsetWidth;
	        var H = preViewer.offsetHeight;
	        var tmpImage = document.createElement("img");
	        preViewer.appendChild(tmpImage);

	        tmpImage.onerror = function () {
	            return preViewer.innerHTML = "";
	        }

	        tmpImage.onload = function () {
	            if (this.width > W) {
	                this.height = this.height / (this.width / W);
	                this.width = W;
	            }
	            if (this.height > H) {
	                this.width = this.width / (this.height / H);
	                this.height = H;
	            }
	        }
	        if (ua.indexOf("Firefox/3") > -1) {
	            var picData = thisObj.files.item(0).getAsDataURL();
	            tmpImage.src = picData;
	        } else {
	            tmpImage.src = "file://" + thisObj.value;
	        }
	    }
	}
</script>
</head>

<body>
<form name="form1" method="post" action="/back/Glmp.do"  onSubmit="return false;" enctype="multipart/form-data">
<input type="hidden" name="cmd" 			value="glmpMemberWrite">
<input type="hidden" name="p_num" 			value="<%=userdata.getInt("NUM")%>">
<input type="hidden" name="p_mode" 			value="<%=box.getString("p_mode")%>">

<table width="100%" cellpadding="0" cellspacing="0">
<tr>
	<td class="pad_left_15">

     <!-- 메뉴명 -->
	<table width="985" cellpadding="0" cellspacing="0" class="mar_top_20">
	<colgroup>
		<col width="10" />
		<col width="" />
		<col width="15" />
	</colgroup>
	<tr>
		<td><img src="/images/back/common/bullet_title.gif"></td>
		<td class="t_title"><%=s_menunavi %></td>
		<td align="right" valign="bottom"></td>
	</tr>
	</table>
	<!-- // -->		
	
       <!-- 입력폼 -->
	<div class="board-view">
		<table width="985" cellpadding="0" cellspacing="0" class="mar_top_5">
		<colgroup>
			<col width="200" />
			<col width="" />
			<col width="200" />
			<col width="" />
		</colgroup>
		<tr>
			<th class="th_top_bd">기수</th>
			<td class="td_top_bd" colspan="2">
				<select name="p_glmpseq">
					<option value="">-선택-</option>
					<%for(int x=1; x<box.getInt("maxseq")+20; x++){%>
						<option value="<%=x%>" <%if(userdata.getInt("GLMPSEQ")==x ){%>selected<%} %>><%=x%>기</option>
					<%}%>
				</select>
			</td>
			<td rowspan="16" style="text-align: center; border-bottom: 0;">
				<table border="0">
					<tr>
						<td style="width: 80px; height: 250px; border: 0px #0000ff solid; ">
							<div id="preView" class="preView" title="이미지미리보기">			
								<%
									String imgpath = null;
									if(!userdata.getString("SAVEFILENAME").equals("")){ 
									
									imgpath = "http://"+request.getServerName()+box.getString("UPLOAD_CONTEXT")+"/glmp/member/"+userdata.getString("GLMPSEQ")+"/"+userdata.getString("SAVEFILENAME");							
									%>
									<img width="200px" height="250px" src="<%=imgpath %>" alt="사진" />
								<%}else{ 
									imgpath="/m_image/glmp_noimg.gif";
									%>
									<img width="200px" height="250px" src="<%=imgpath %>" alt="사진" />								
								<%} %>
							</div>
						</td>
					</tr>
					<tr>
						<td  style="border-bottom: 0px;">
							<input type="file" name="p_realfilename" value="" onchange="fileUploadPreview(this, 'preView')" style="display:; width:200px; height:18px; background-color:#FFFFFF;" dispName="사진" isNull="Y">
						</td>
					</tr>
				</table>
			</td>
        </tr>  		
		<tr>
			<th>성명</th>
			<td colspan="2">
			 <%-- <input type="text" name="p_name" dispName="성명" isNull="N" lenCheck="30" value="<%=member.getString("NAME") %>"> --%>  
			 <input type="text" name="p_name" dispName="성명" isNull="N" lenCheck="30" value="<%=userdata.getString("NAME")%>">  
			</td>
        </tr>
        <tr style="display: none;"> 
			<th>성별</th>
			<td colspan="2">
				<select name="p_sex">
					<option value="">- 선택 -</option>
					<option value="M" <%if(userdata.getString("SEX").equals("M")){%>selected<%} %>>남</option>
					<option value="F" <%if(userdata.getString("SEX").equals("F")){%>selected<%} %> >여</option>
				</select>
			</td>
        </tr>        
		<tr>
		<%int year= 0;
			int month = 0;
			int day = 0;
			Calendar cal =Calendar.getInstance();
			if(userdata.getString("BIRTH")!=""){
				year = Integer.parseInt(userdata.getString("BIRTH").substring(0, 4));
				month = Integer.parseInt(userdata.getString("BIRTH").substring(4, 6));
				day = Integer.parseInt(userdata.getString("BIRTH").substring(6, 8));
			}
		%>
			<th>생년월일</th>
			<td colspan = "2">
				<%-- <fmtag:calendar seq="1" name="form1" property="p_birth" date="" dispName="생년월일" defaultYn="N" isNull="Y" position="right"/> --%>
				<input type="hidden" name="p_birth" /> 
				<select name="p_birth1">
					<option value="">-</option>
					<%for(int x=1900; x<=cal.get(Calendar.YEAR); x++){%>
						<option value="<%=x%>" <%if(year==x ){%>selected<%} %>><%=x%></option>
					<%}%>
				</select>년
				<select name="p_birth2">
					<option value="">-</option>
					<%for(int x=1; x<=12; x++){%>
						<option value="<%=x%>" <%if(month==x ){%>selected<%} %>><%=x%></option>
					<%}%>
				</select>월
				<select name="p_birth3">
					<option value="">-</option>
					<%for(int x=1; x<=31; x++){%>
						<option value="<%=x%>" <%if(day==x ){%>selected<%} %>><%=x%></option>
					<%}%>
				</select>일
			</td>					
        </tr>
		<tr>
			<th>이메일</th>
			<td colspan="2">
               <input type="text" name="p_email" dispName="이메일" isNull="N" lenCheck="50" style="width:400" value="<%=userdata.getString("EMAIL")%>">
     		</td>
        </tr> 
        <tr>
			<th>휴대폰</th>
			<td colspan="2">
             <input type="text" name="p_handphone" lenCheck="50" style="width:200" value="<%=userdata.getStringDefault("HANDPHONE", "") %>">
              <%--    <input type="text" name="p_handphone1" dispName="핸드폰" isNull="Y" dataType="number" value="<%=userdata.getStringDefault("HANDPHONE", " - - ").split("-")[0].replaceAll(" ", "") %>" maxlength="4" style="width:60"> -
                <input type="text" name="p_handphone2" dispName="핸드폰" isNull="Y" dataType="number" value="<%=userdata.getStringDefault("HANDPHONE", " - - ").split("-")[1].replaceAll(" ", "") %>" maxlength="4" style="width:60"> -
                <input type="text" name="p_handphone3" dispName="핸드폰" isNull="Y" dataType="number" value="<%=userdata.getStringDefault("HANDPHONE", " - - ").split("-")[2].replaceAll(" ", "") %>" maxlength="4" style="width:60"> --%>
                ex) 010-1234-5678
     		</td>
        </tr>
   		<tr style="display: none;">
			<th>우편번호</th>
			<td colspan="2">
				<input type="text" name="p_post1" dispName="우편번호" isNull="Y" maxLength="5" dataType="number" value="" style="width:40" placeholder="우편번호찾기를 해주세요" readonly="readonly">
             	<input type="hidden" name="p_post2" dispName="우편번호" value="" >
                &nbsp;<a href="#none" onclick="searchZipCode('user')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a>
     		</td>
        </tr>  
        <tr>
			<th>주소</th>
			<td  colspan="2">
               <input type="text" name="p_addr" dispName="주소1" isNull="Y" lenCheck="1000" style="width:400; " value="<%=userdata.getString("ADDR")%>"><br />
               <input type="text" name="p_addr2" dispName="상세주소" isNull="Y" lenCheck="1000" style="width:400; display: none;" value="<%=userdata.getString("ADDR2")%>">
     		</td>
        </tr>
        
        
        <tr>
			<th>회사명</th>
			<td colspan="2">
              <input name="p_compnm" type="text" isNull="Y" dispName="회사명" lenCheck="50" value="<%=userdata.getString("COMPNM")%>"/>
     		</td>
        </tr>
        <tr>
			<th>직위</th>
			<td colspan="2">
              <input name="p_compposition" type="text" isNull="Y" dispName="직위" lenCheck="50" value="<%=userdata.getString("COMPPOSITION")%>"/>
     		</td>
        </tr>
        <tr>
			<th>회사전화번호</th>
			<td colspan="2">
              <input type="text" name="p_comptel" value="<%=userdata.getStringDefault("COMPTEL", "")%>" style="width:200">
                <%-- <input type="text" name="p_comptel1" dispName="회사번호" isNull="Y" dataType="number" value="<%=userdata.getStringDefault("COMPTEL", " - - ").split("-")[0].replaceAll(" ", "") %>" maxlength="4" style="width:60"> -
                <input type="text" name="p_comptel2" dispName="회사번호" isNull="Y" dataType="number" value="<%=userdata.getStringDefault("COMPTEL", " - - ").split("-")[1].replaceAll(" ", "") %>" maxlength="4" style="width:60"> -
                <input type="text" name="p_comptel3" dispName="회사번호" isNull="Y" dataType="number" value="<%=userdata.getStringDefault("COMPTEL", " - - ").split("-")[2].replaceAll(" ", "") %>" maxlength="4" style="width:60"> --%>
                ex) 010-1234-5678
     		</td>
        </tr>
        <tr>
			<th>팩스번호</th>
			<td colspan="2">
              <input type="text" name="p_fax" value="<%=userdata.getStringDefault("FAX", "")%>" style="width:200">
                <%-- <input type="text" name="p_fax1" dispName="팩스" isNull="Y" dataType="number" value="<%=userdata.getStringDefault("FAX", " - - ").split("-")[0].replaceAll(" ", "") %>" maxlength="4" style="width:60"> -
                <input type="text" name="p_fax2" dispName="팩스" isNull="Y" dataType="number" value="<%=userdata.getStringDefault("FAX", " - - ").split("-")[1].replaceAll(" ", "") %>" maxlength="4" style="width:60"> -
                <input type="text" name="p_fax3" dispName="팩스" isNull="Y" dataType="number" value="<%=userdata.getStringDefault("FAX", " - - ").split("-")[2].replaceAll(" ", "") %>" maxlength="4" style="width:60"> --%>
     		</td>
   		</tr>
		</table>
	</div>	
	
	</td></tr></table></form>
	
	
	<!-- ------------------------- -->
    <!-- 버튼 -->
	<table width="985" cellpadding="0" cellspacing="0" class="mar_top_10">
	<tr>
		<td align="center">
			<table cellpadding="0" cellspacing="0">
			<tr>
			  <td>
			  <%if(box.getString("p_mode").equals("E")){ %>
				<fmtag:button type="1" value="수 정" func="memberWrite()" />&nbsp;
				<fmtag:button type="1" value="삭 제" func="memberDelete()" />&nbsp;
			  <%}else{ %>
				<fmtag:button type="1" value="저 장" func="memberWrite()" />&nbsp;
			  <%} %>
				<fmtag:button type="1" value="취 소" func="memberList()" />
			  </td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
	<!-- // -->
	
	  <!--푸터부분 시작-->
	  <%@ include file = "/jsp/back/common/bottom.jsp"%>
	  <!--푸터부분 끝-->	