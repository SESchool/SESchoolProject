<%--
 * @(#)ClassifySubject Template
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * T_LMS_SUBJ 테이블 List Template.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2010. 11. 11.  bluedove       Initial Release
 ************************************************
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file = "/jsp/back/common/commonInc.jsp"%>
<%@ page import ="java.util.StringTokenizer"%>
<%@ page import ="com.sinc.common.CodeParamDTO"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>::: 한국무역협회 무역아카데미 ::: 관리자페이지</title>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<%
	String v_mode = box.getStringDefault("p_mode","W");

	String v_gubun  	= box.getString("p_gubun");	// 고객사:1, CP사:2, Agent:3
	String v_gubunname  	= "";
	if(v_gubun.equals("2")){
		v_gubunname = "CP";
	}else if(v_gubun.equals("3")){
		v_gubunname = "Agent";
	}

	String v_cpresno1 = "";
	String v_cpresno2 = "";
	String v_cpresno3 = "";
	
	String v_post1 = "";
	String v_post2 = "";
	
	String v_comtel1 = "";
	String v_comtel2 = "";
	String v_comtel3 = "";

	String v_handphone1 = "";
	String v_handphone2 = "";
	String v_handphone3 = "";	
	
	StringTokenizer st_cpresno = null;
	StringTokenizer st_zip = null;
	StringTokenizer st_comtel = null;
	StringTokenizer st_handphone = null;
	

	Box ds1 = null;
	if(v_mode.equals("E")){
		ds1 = (Box)box.getObject("CompInfo"); //외주업체정보
		
		// 사업자등록번호
		st_cpresno = new StringTokenizer(ds1.getString("COMPRESNO"),"-",false);
		while(st_cpresno.hasMoreElements())
		{
			if(st_cpresno.hasMoreTokens()) v_cpresno1 = st_cpresno.nextToken();
			if(st_cpresno.hasMoreTokens()) v_cpresno2 = st_cpresno.nextToken();
			if(st_cpresno.hasMoreTokens()) v_cpresno3 = st_cpresno.nextToken();
		}
		// 우편번호
		st_zip = new StringTokenizer(ds1.getString("ZIP"), "-",false);
		while(st_zip.hasMoreElements())
		{
			if(st_zip.hasMoreTokens()) v_post1 = st_zip.nextToken();
			if(st_zip.hasMoreTokens()) v_post2 = st_zip.nextToken();			
		}	
				
		// 전화번호
		st_comtel = new StringTokenizer(ds1.getString("COMPTEL"),"-",false);
		while(st_comtel.hasMoreElements())
		{
			if(st_comtel.hasMoreTokens()) v_comtel1 = st_comtel.nextToken();
			if(st_comtel.hasMoreTokens()) v_comtel2 = st_comtel.nextToken();
			if(st_comtel.hasMoreTokens()) v_comtel3 = st_comtel.nextToken();
		}
		// 휴대폰번호
		st_handphone = new StringTokenizer(ds1.getString("HANDPHONE"),"-",false);
		while(st_handphone.hasMoreElements())
		{
			if(st_handphone.hasMoreTokens()) v_handphone1 = st_handphone.nextToken();
			if(st_handphone.hasMoreTokens()) v_handphone2 = st_handphone.nextToken();
			if(st_handphone.hasMoreTokens()) v_handphone3 = st_handphone.nextToken();
		}		
		
	}
	else {
    	ds1 = new Box("DATASET");
    }


%>    
<fmtag:csscommon point="back" />
<fmtag:jscommon />

<SCRIPT LANGUAGE="JavaScript">
<!--

	//삭제
	function cpCompDelete()
	{
		var f = document.form1;
		if(confirm("삭제하시겠습니까?"))
		{
			f.p_mode.value="D";
        	f.action="/back/CPComp.do?cmd=cpCompDelete";
        	f.submit();
        }
	}
	
	//목록으로
	function cpCompGoList()
	{
		var f = document.form1;
        f.action="/back/CPComp.do?cmd=cpCompList";
        f.submit();
	}

	//저장
	function cpCompSave()
	{
		var f = document.form1;
		if(!validate(f)) return;
<%
	if(!v_mode.equals("E"))
	{
%>
		if(f.p_pwd.value == ""){
			alert("비밀번호 입력 해주세요.");
			f.p_pwd.focus();
			return ;
		}
		if(f.p_pwd2.value == ""){
			alert("비밀번확인을 입력 해주세요.");
			f.p_pwd.focus();
			return ;
		}		
		if(f.p_pwd.value != f.p_pwd2.value){
			alert("비밀번호 확인을 다시 해주세요.");
			f.p_pwd2.focus();
			return;		
		}
		if(f.p_compcheck.value!="OK")
		{
			alert('CP회사코드 중복체크를  해주세요');
			return;
		}
		if(f.p_idcheck.value!="OK")
		{
			alert('ID중복체크를  해주세요');
			return;
		}
<%
	}else {
%>
		if (  f.p_pwd.value  != "" || f.p_pwd2.value  != "" ) {
			if(f.p_pwd.value == ""){
				alert("비밀번호 입력 해주세요.");
				f.p_pwd.focus();
				return ;
			}
			if(f.p_pwd2.value == ""){
				alert("비밀번확인을 입력 해주세요.");
				f.p_pwd.focus();
				return ;
			}		
			if(f.p_pwd.value != f.p_pwd2.value){
				alert("비밀번호 확인을 다시 해주세요.");
				f.p_pwd2.focus();
				return;		
			}			
		}		
<%
	}
%>
		
		f.p_cpresno.value = f.p_cpresno1.value+"-"+f.p_cpresno2.value+"-"+f.p_cpresno3.value;
		f.p_handphone.value = f.p_handphone1.value+"-"+f.p_handphone2.value+"-"+f.p_handphone3.value;
		f.p_comtel.value = f.p_comtel1.value+"-"+f.p_comtel2.value+"-"+f.p_comtel3.value;

		if(confirm("저장하시겠습니까?"))
		{
			f.p_mode.value="<%=v_mode%>";
			f.action="/back/CPComp.do?cmd=cpCompWrite";
			f.submit();		
		}
	}
	
	//ID중복확인체크
	function cpCompIdCheck()
	{
		var f = document.form1;
		if(f.p_userid.value=="")
		{
			alert('ID를 입력하세요');
			return;
		}
		f.target = "hiddenFrame";
		f.action="/back/CPComp.do?cmd=cpCompCheckId";
		f.submit();
		f.target = "";
	}
	function checkUserId(val)
	{	
		document.form1.p_idcheck.value=val;
	}
	
	//CP 코드 중복여부 체크
	function cpCompCodeCheck()
	{
		var f = document.form1;
		if(f.p_comp.value=="")
		{
			alert('회사코드를 입력하세요');
			return;
		}
		f.target = "hiddenFrame";
		f.action="/back/CPComp.do?cmd=checkCompCode";
		f.submit();
		f.target = "";
	}
	function checkCompCode(val)
	{	
		document.form1.p_compcheck.value=val;
	}		

	function searchZipCode(objname) {
		var url = "/front/Common.do?cmd=selectZipCode&p_objname="+objname; 
		Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
	}
	function setZipCodeInfo(objname, addr, zipcode) {	 
		var form = document.form1;

	    if ( objname == "user" ) {
			form.p_address.value = addr;
			if( zipcode.search('-') > -1 ){
				form.p_post1.value = zipcode.substr(0, 3);
				form.p_post2.value = zipcode.substr(4, 7);
				form.p_zip.value = form.p_post1.value + "-" + form.p_post2.value;
			} else {
				form.p_post1.value = zipcode;
				form.p_post2.value = "";
				form.p_zip.value = form.p_post1.value;
				form.p_post2.style.display = "none";
			}			
	    }
	}		
	function changeTaxInc(){
		var f = document.form1;
		
		if(f.p_taxyn.checked == true){
			f.p_tax.value = "Y";
		}else{
			f.p_tax.value = "N";
		}
		
	}
//-->
</SCRIPT>
</HEAD>
<body leftMargin="0" topMargin="0" marginheight="0" marginwidth="0">
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
  <td class="pad_left_15">
	<form name="form1" action="/back/CPComp.do" method="post" onSubmit="return false;">
	<input type="hidden" name="p_mode" value="">
	<input type="hidden" name="p_gubun" value="<%=v_gubun%>">
	<input type="hidden" name="p_zip" value="">
	<input type="hidden" name="p_cpseq" value="<%=ds1.getString("COMP") %>">
	<input type="hidden" name="p_idcheck" value="">
	<input type="hidden" name="p_compcheck" value="">
	<input type="hidden" name="p_cpresno" value="">
	<input type="hidden" name="p_comtel" value="">
	<input type="hidden" name="p_handphone" value="">
	<input type="hidden" name="p_tax" value="N">
	
	<!-- 메뉴명 -->
    <table width="985" cellpadding="0" cellspacing="0" class="mar_top_10">
	<colgroup>
	  <col width="10" />
	  <col width="" />
	  <col width="15" />
	</colgroup>
	<tr>
	  <td><img src="/images/back/common/bullet_title.gif"></td>
	  <td class="t_title"><%=s_menunavi %></td>
	  <td align="right" valign="bottom"><a href="javascript:showMenuDesc();"><img id="MenuDescBtn" src="/images/back/button/btn_tbl_close.gif" alt="메뉴설명 닫기"></a></td>
	</tr>
	</table>
	<!-- // -->	
	
	<!-- 해당메뉴 설명 -->
	<table width="985" cellpadding="0" cellspacing="0" class="mar_top_5" style="display:" id="MenuDescTb">
 	  <tr>
  		<td class="border_gray" align="center">    
   		<table width="100%" cellpadding="0" cellspacing="0">
   		  <tr valign="top">
    		<td id="menuDesc"></td>
   		  </tr>
   		</table>
  		</td>
 	  </tr>
 	</table>
 	<!-- // -->
	
	<div class="board-view">
	<table width="985" cellpadding="0" cellspacing="0" class="mar_top_5">
	<tr>
	<colgroup>
		<col width="200"/>
		<col/>
		<col width="200"/>
		<col/>		
	</colgroup>
	</tr>
	<tr>
		<th class="th_top_bd"><%=v_gubunname%>코드</th>
		<td class="td_top_bd" colspan="3">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
            <td align="left" width="20%"><input name="p_comp" type="text" maxlength="6" isNull="N" lenCheck="6" dispName="<%=v_gubunname%>코드" style="width:150px; height:18px;" size="10" value="<%=ds1.getString("COMP") %>" <%=v_mode.equals("E")?"readonly":"" %>></td>
            <%
            if(!v_mode.equals("E")){
            %>
            <td align="left" width="15%"><fmtag:button type="1" value="코드중복확인" func="cpCompCodeCheck()" icon="but_icon_confirm.gif"  /></td>
            <%
            }
            %>
            <td align="left">*<%=v_gubunname%>코드는 한번등록한이후 변경이 불가합니다.</td>
          </tr>
        </table>		
		</td>
	</tr>
	<tr>
		<th>사업자 등록번호* </th>
		<td colspan="3">
        <input name="p_cpresno1" type="text" isNull="N" lenCheck="10" dispName="사업자 등록번호" dataType="number" style="width:100px; height:18px;" size="15" value="<%=v_cpresno1 %>">
        - <input name="p_cpresno2" type="text" isNull="N" lenCheck="5" dispName="사업자 등록번호" dataType="number" style="width:100px; height:18px;" size="10" value="<%=v_cpresno2 %>">
        - <input name="p_cpresno3" type="text" isNull="N" lenCheck="10" dispName="사업자 등록번호" dataType="number" style="width:100px; height:18px;" size="15" value="<%=v_cpresno3 %>">
		</td>
	</tr>
	<tr>
		<th>업체명*</th>
		<td  colspan="3">
		<input name="p_cpnm" type="text" isNull="N" lenCheck="30" dispName="업체명" style="width:700px; height:18px;" size="60" value="<%=ds1.getString("COMPNM") %> " style="width:700px; height:18px;">
		</td>
	</tr>
	<tr>
		<th>홈페이지</th>
		<td  colspan="3">
		<input name="p_homepage" type="text" lenCheck="50" dispName="홈페이지" style="width:700px; height:18px;" size="100" value="<%=ds1.getString("HOMEPAGE") %>">
		</td>
	</tr>
        <tr>
			<th>우편번호</th>
			<td colspan="3">

                <% if( v_post2 == null || v_post2.equals("")){ %>
					<input type="text" name="p_post1" dispName="우편번호" isNull="Y" maxLength="5" dataType="number" value="<%=v_post1 %>" style="width:60" readonly="readonly">
               		<input type="hidden" name="p_post2" dispName="우편번호" isNull="Y" value="<%=v_post2 %>">
				<% } else { %>
					<input type="text" name="p_post1" dispName="우편번호" isNull="Y" maxLength="5" dataType="number" value="<%=v_post1 %>" style="width:60" readonly="readonly">&nbsp;-
               		<input type="text" name="p_post2" dispName="우편번호" isNull="Y" value="<%=v_post2 %>" style="width:60" readonly="readonly">
				<% } %>
                &nbsp;<a href="#none" onclick="searchZipCode('user')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a>
     		</td>
        </tr>  	
	<tr>
		<th>주소</th>
		<td  colspan="3">
		  <input name="p_address" type="text" lenCheck="100" dispName="주소" style="width:700px; height:18px;" size="100" value="<%=ds1.getString("ADDR") %>" >
		</td>
	</tr>
	<tr>
		<th>담당자ID*</th>
		<td  colspan="3">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
            <td align="left" width="20%"><input name="p_userid" type="text" isNull="N" lenCheck="20" dispName="담당자ID" style="width:150px; height:18px;" size="20" value="<%=ds1.getString("USERID") %>" <%=v_mode.equals("E")?"readonly":"" %>></td>
            <%
            if(!v_mode.equals("E")){
            %>
            <td align="left" width="15%"><fmtag:button type="1" value="ID중복확인" func="cpCompIdCheck()" icon="but_icon_confirm.gif"  /></td>
            <%
            }
            %>
            <td align="left">*담당자ID는 한번등록한이후 변경이 불가합니다.</td>
          </tr>
        </table>
      </td>
	</tr>
	<tr>
		<th>담당자명*</th>
		<td  colspan="3">
		  <input name="p_name" type="text" isNull="N" dispName="담당자명" style="width:150px; height:18px;" size="20" value="<%=ds1.getString("NAME") %>" >
		</td>
	</tr>
	<tr>
		<th>비밀번호*</th>
		<td>
		  <input name="p_pwd" type="password" isNull="Y" lenCheck="20" dispName="비밀번호" style="width:150px; height:18px;" size="20" value="">&nbsp;
		</td>
		<th>비밀번호확인*</th>
		<td>
		  <input name="p_pwd2" type="password" isNull="Y" lenCheck="20" dispName="비밀번호확인" style="width:150px; height:18px;" size="20" value="">
		</td>		
	</tr>
	<%if(v_gubun.equals("2")){ %>
	<tr>
		<th>CP 수익배분율 (포팅/링크)</th>
		<td  colspan="3">
          <input name="p_cprate" type="text" dataType="number" lenCheck="3" dispName="CP수익배분율(포팅)" style="width:100px; height:18px;" size="5" value="<%=ds1.getString("CPRATE") %>">
          /
          <input name="p_cpratel" type="text" dataType="number" lenCheck="3" dispName="CP수익배분율(링크)" style="width:100px; height:18px;" size="5" value="<%=ds1.getString("CPRATEL") %>">
          &nbsp;&nbsp;<input name="p_taxyn" type="checkbox" <% if(ds1.getString("SURTAXINCLUDEYN").equals("Y")){ %>checked<%} %> onClick="changeTaxInc();" /> 부가세 포함 여부
		</td>
	</tr>
	<%} %>
	<tr>
		<th>핸드폰</th>
		<td  colspan="3">
          <input name="p_handphone1" type="text" dataType="number" maxlength="3" lenCheck="3" dispName="연락처" style="width:100px; height:18px;" size="5" value="<%=v_handphone1 %>">
          - <input name="p_handphone2" type="text" dataType="number" maxlength="4" lenCheck="4" dispName="연락처" style="width:100px; height:18px;" size="5" value="<%=v_handphone2 %>">
          - <input name="p_handphone3" type="text" dataType="number" maxlength="4" lenCheck="4" dispName="연락처" style="width:100px; height:18px;" size="5" value="<%=v_handphone3 %>">
		</td>
	</tr>	
	<tr>
		<th>전화번호</th>
		<td  colspan="3">
          <input name="p_comtel1" type="text" dataType="number" maxlength="3" lenCheck="3" dispName="연락처" style="width:100px; height:18px;" size="5" value="<%=v_comtel1 %>">
          - <input name="p_comtel2" type="text" dataType="number" maxlength="4" lenCheck="4" dispName="연락처" style="width:100px; height:18px;" size="5" value="<%=v_comtel2 %>">
          - <input name="p_comtel3" type="text" dataType="number" maxlength="4" lenCheck="4" dispName="연락처" style="width:100px; height:18px;" size="5" value="<%=v_comtel3 %>">
		</td>
	</tr>	
	<tr>
		<th>E-Mail</th>
		<td  colspan="3">
		  <input name="p_email" type="text" lenCheck="50" dispName="E-Mail" style="width:215px; height:18px;" size="50" value="<%=ds1.getString("EMAIL") %>">
		</td>
	</tr>
	<tr>
		<th>계약 상태</th>
		<td colspan="3">
			<select	name="p_contractstate">				
				<option value="CO" <%if (ds1.getString("CONTRACTSTATE").equals("CO")) {%> selected <%}%>>계약</option>
				<option value="EX" <%if (ds1.getString("CONTRACTSTATE").equals("EX")) {%> selected <%}%>>만료</option>
			</select> 
		</td>
	</tr>	
	</table>
	</div>
	<!--  -->
	
	<!-- 버튼 -->
    <table width="985" border="0" cellpadding="0" cellspacing="0" class="mar_top_5">
      <tr>
       <td align="center">
       	<% if(s_menucontrol.equals("RW")){ %>
       	<fmtag:button type="1" value="저장" func="cpCompSave()" icon="icon_element_add.gif"  />&nbsp;
       		<%if(v_mode.equals("E")){ %><fmtag:button type="1" value="삭제" func="cpCompDelete()" icon="icon_element_delete.gif"  />&nbsp;<%} %>
       	<%} %>
       	<fmtag:button type="1" value="취소" func="cpCompGoList()" icon="icon_cancel.gif"  />&nbsp;
	   </td> 
      </tr>
     </table> 
	<!-- // -->
  </form>
  <!--푸터부분 시작-->
  <%@ include file = "/jsp/back/common/bottom.jsp"%>
  <!--푸터부분 끝-->