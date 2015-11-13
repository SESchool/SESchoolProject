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
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file = "/jsp/back/common/commonInc.jsp"%>
<%@ page import ="com.sinc.common.CodeParamDTO"%>
<%	
	// 유통사 정보
	Box externalSalesCompInfo = (Box)box.getObject("externalSalesCompInfo");
	String v_comp_seq = "";						// 유통사정보 PK
	String v_compnm = "";						// 유통사 이름
	String v_startyear = "";					// 계약기간(시작)
	String v_endyear = "";						// 계약기간(끝)
	String v_manager = "";						// 담당자
	String v_monitoringid = "";					// 모니터링 계정
	String v_responsibilities = "";				// 담당업무
	String v_telephone = "";					// 전화번호
	String v_handphone = "";					// 휴대폰
	String v_email = "";						// 이메일
	
	v_comp_seq = externalSalesCompInfo.getString("COMP_SEQ");
	v_compnm = externalSalesCompInfo.getString("COMPNM");
	v_startyear = externalSalesCompInfo.getString("STARTYEAR");
	v_endyear = externalSalesCompInfo.getString("ENDYEAR");
	v_manager = externalSalesCompInfo.getString("MANAGER");
	v_monitoringid = externalSalesCompInfo.getString("MONITORINGID");
	v_responsibilities = externalSalesCompInfo.getString("RESPONSIBILITIES");
	v_telephone = externalSalesCompInfo.getString("TELEPHONE");
	v_handphone = externalSalesCompInfo.getString("HANDPHONE");
	v_email = externalSalesCompInfo.getString("EMAIL");
	
%>
<%
	// 전화번호 ex) 02-000-0000
	String v_telephone1 = "";
	String v_telephone2 = "";
	String v_telephone3 = "";
	
	// 휴대폰 ex) 010-0000-0000
	String v_handphone1 = "";
	String v_handphone2 = "";
	String v_handphone3 = "";
	
	if( !v_telephone.equals("") ){
		String[] result_telephone = v_telephone.split("-");
		v_telephone1 = result_telephone[0];
		v_telephone2 = result_telephone[1];
		v_telephone3 = result_telephone[2];
		
	}
	
	if( !v_handphone.equals("") ){
		String[] result_handphone = v_handphone.split("-");
		v_handphone1 = result_handphone[0];
		v_handphone2 = result_handphone[1];
		v_handphone3 = result_handphone[2];
		
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>::: 한국무역협회 무역아카데미 ::: 관리자페이지</title>
<fmtag:csscommon point="back" />
<fmtag:jscommon />
<fmtag:dwrcommon interfaceName="CompWork"/>
<script type="text/JavaScript" language="JavaScript" src="/js/common/util.js"></script>
<script language="javascript">
function jsInitPage(){
	contentsList();
}
function contentsList(){
	var f =	document.form1;
	var comp_seq = "";
	<% if( v_comp_seq != "" ){ %>
		comp_seq = '<%= v_comp_seq %>';
	<% } %>
	
	var param = {
			p_comp_seq:comp_seq
	};
	CompWork.externalSalesContentsListCallBack(param,contentsListCallBack); 
}

function contentsListCallBack(ds){
	var temp1 = 'CONTENTS_DEL_ROW';
	var CONTSNM = '';						// 컨텐츠명
	var CONTSID = '';						// 컨텐츠 코드
	var info;
	var rowNum = 0;
	rowNum = ds.length;
	
	var temp = '';
	temp = '<table width="100%" id="contentsTable" cellpadding="0" cellspacing="0" border = "1">';
	temp += '<colgroup><col width="90%" /><col width="10%" /></colgroup>';
	
	if(rowNum != 0){
		for(var i = 0; i < rowNum; i++){
			info = ds[i];
			CONTSNM = info["CONTSNM"];
			CONTSID = info["CONTSID"];
			temp += '<tr height="25" style="text-align:center;">';
			temp += '<td>'+CONTSNM+'<input type="hidden" name = "p_contsid" id="p_contsid'+CONTSID+'" value ="'+CONTSID+'" ></td>';
			temp += '<td><input type="button" value="삭제" onclick="main(\''+temp1+'\');"></td>';
			temp += '</tr>';
		}
		temp += '</table>';
		document.getElementById('div_contents').innerHTML = temp;
	} else {
		temp += '</table>';
		document.getElementById('div_contents').innerHTML = temp;
	}
}

// 취소 버튼 클릭
function goExternalSalesCompList(){
	var f = document.form1;
	 
	f.action = "/back/Comp.do?cmd=externalSalesCompList";
	f.cmd.value="externalSalesCompList";
	f.method = "post";
    f.submit();
}

function main (arg1,arg2,arg3,arg4){
	switch (arg1) {
	case 'SELECTCONTENTS':					// 추가 버튼 클릭
		var f =	document.form1;
		var comp_seq = '';
		<% if( v_comp_seq != "" ){ %>
			comp_seq = '<%= v_comp_seq %>';
		<% } %>
		popWin = Center_Fixed_Popup2("", "externalSalesCompSearchContents", 1100, 600, "yes");
		
		f.action = "/back/Comp.do?cmd=externalSalesCompSearchContents";
		f.cmd.value="externalSalesCompSearchContents";
		f.p_comp_seq.value = comp_seq;
		f.method = "post";
		f.target = "externalSalesCompSearchContents";
	    f.submit();
	    f.target = "";
		break;
	case 'CONTENTS_ADD_ROW' :
		var temp1 = 'CONTENTS_DEL_ROW';
		var rowNum = 0 ;
		var myRow = document.all.contentsTable.insertRow();
		myRow.onmouseover=function(){contentsTable.clickedRowIndex=this.rowIndex};
		
		var rowNum = document.all.contentsTable.rows.length;
		var myCell1 = myRow.insertCell();
		var myCell2 = myRow.insertCell();
		
		myCell1.innerHTML = arg4+'<input type="hidden" name ="p_contsid" id="p_contsid'+arg3+'" value ="'+arg3+'" >';
		myCell2.innerHTML = '<input type="button" value="삭제" onclick="main(\''+temp1+'\');">';
		
		myCell1.align = "center";
		myCell2.align = "center";
		break;
	case 'CONTENTS_DEL_ROW' :
		var objTable = document.all.contentsTable;
		objTable.deleteRow(objTable.clickedRowIndex);
		break;
	case 'CONTENTS_DEL_ROW2' :
		var objTable = document.all.contentsTable;
		var contentsList = document.all.p_contsid;
		var rowNum ;
		rowNum = objTable.rows.length;
		for(var inx = 0 ; inx < rowNum ; inx++) {
	    	if(contentsList[inx].value == arg3){
	    		objTable.deleteRow(inx);
	    	}
		} 
		break;
	case 'WRITE' :
		if(checkInput() == true){
			form1.action = "/back/Comp.do?cmd=externalSalesCompInfoWrite";
			form1.cmd.value="externalSalesCompInfoWrite";
			form1.method = "post";
			form1.submit();	
		} else {
			return;
		}
		break;
	case 'UPDATE' :
		checkInput();		// 유효성 검사
		if(checkInput() == true){
			if (confirm("정말 수정하시겠습니까??") == true){    //확인
				form1.action = "/back/Comp.do?cmd=externalSalesCompInfoUpdate";
				form1.cmd.value="externalSalesCompInfoUpdate";
				form1.method = "post";
				form1.submit();
			}
		} else {
			return;
		}
		break;
	case 'DELETE' :
		if(checkInput() == true){
			if (confirm("정말 삭제하시겠습니까??") == true){    //확인
				form1.action = "/back/Comp.do?cmd=externalSalesCompInfoDelete";
				form1.cmd.value="externalSalesCompInfoDelete";
				form1.method = "post";
				form1.submit();
			}
		} else {
			return;
		}
		break;
	default:
		break;
	}
}

// 컨텐츠 검색 팝업창으로 부터 받은 값
function setData( mode, comp_seq, contsid, contsnm) {
	switch (mode) {
		case "SET_CONTENTS" :
			// SET_CONTENTS, comp_seq, contsid, contsnm
			var contentsList = document.form1.p_contsid;
    		var rowNum ;
		    // 중복 여부를 체크해준다.
		    if(contentsList != undefined ) {
			    rowNum  = contentsList.length ;
				if(rowNum > 0) {
					for(var inx = 0 ; inx < rowNum ; inx++) {
				    	if(contentsList[inx].value == contsid)return ;
					}   
			    }else {
			    	if(contentsList.value == contsid)return ;
			    }
		    } 
		    main("CONTENTS_ADD_ROW", comp_seq, contsid, contsnm);
		  	break;
		case 'DEL_CONTENTS':
			main("CONTENTS_DEL_ROW2", comp_seq, contsid, contsnm);
			break;
	}
}

// 유효성 검사
function checkInput(){
	var result = true;
	var p_compnm = '';							// 유통사명
	var p_startyear = '';						// 계약기간(시작)
	var p_endyear = '';							// 계약기간(끝)
	var p_manager = '';							// 담당자명
	var p_monitoringid = '';					// 모니터링 계정
	var p_responsibilities = '';				// 담당업무
	var p_telephone1 = '';						// 전화번호
	var p_telephone2 = '';						// 전화번호
	var p_telephone3 = '';						// 전화번호
	var p_handphone1 = '';						// 휴대폰
	var p_handphone2 = '';						// 휴대폰
	var p_handphone3 = '';						// 휴대폰
	var p_email = '';							// 이메일
	
	p_compnm = form1.p_compnm.value;
	p_startyear = form1.p_startyear.value;
	p_endyear = form1.p_endyear.value;
	p_manager = form1.p_manager.value;
	p_monitoringid = form1.p_monitoringid.value;
	p_responsibilities = form1.p_responsibilities.value;
	p_telephone1 = form1.p_telephone1.value;
	p_telephone2 = form1.p_telephone2.value;
	p_telephone3 = form1.p_telephone3.value;
	p_handphone1 = form1.p_handphone1.value;
	p_handphone2 = form1.p_handphone2.value;
	p_handphone3 = form1.p_handphone3.value;
	p_email = form1.p_email.value;
	
	// 전화번호, 휴대폰 번호 형식으로 변환
	form1.p_telephone.value = p_telephone1+"-"+p_telephone2+"-"+p_telephone3;
	form1.p_handphone.value = p_handphone1+"-"+p_handphone2+"-"+p_handphone3;
	
	// 업체명
	if(isEmpty(p_compnm)){
		alert('[업체명]을 입력해주세요.');
		form1.p_compnm.focus();
		return false;
	}
	// 계약기간(시작)
	if(isEmpty(p_startyear)){
		alert('[계약기간]을 입력해주세요.');
		form1.p_startyear.focus();
		return false;
	}
	if(isNaN(p_startyear)){
		alert('[계약기간]은 숫자로 입력해주세요.\n ex) 20151004');
		form1.p_startyear.focus();
		return false;
	}	
	if(p_startyear.length < 8){
		alert('[계약기간]은 8자리 숫자로 입력해주세요.\n ex) 20151004');
		form1.p_startyear.focus();
		return false;
	}	
	if( p_startyear.substring(0, 4) < 1999 || p_startyear.substring(0, 4) > 3000 ){
		alert('[계약기간]중 년은 2000 ~ 3000년도 이내로 입력가능.\n ex) 20151004');
		form1.p_startyear.focus();
		return false;
	}
	if( p_startyear.substring(4, 6) > 12 ){
		alert('[계약기간]중 월은 01 ~ 12월 사이의 숫자로 입력가능.\n ex) 20151004');
		form1.p_startyear.focus();
		return false;
	}
	if( p_startyear.substring(6) > 31 ){
		alert('[계약기간]중 일은 01 ~ 31일 사이의 숫자로 입력가능.\n ex) 20151004');
		form1.p_startyear.focus();
		return false;
	}
	// 계약기간(끝)
	if(isEmpty(p_endyear)){
		alert('[계약기간]을 입력해주세요.');
		form1.p_endyear.focus();
		return false;
	}
	if(isNaN(p_endyear)){
		alert('[계약기간]은 숫자로 입력해주세요.\nex) 20151004');
		form1.p_endyear.focus();
		return false;
	}
	if(p_endyear.length < 8){
		alert('[계약기간]은 8자리 숫자로 입력해주세요.\n ex) 20151004');
		form1.p_endyear.focus();
		return false;
	}
	if( p_endyear.substring(0, 4) < 1999 || p_endyear.substring(0, 4) > 3000 ){
		alert('[계약기간]중 년은 2000 ~ 3000년도 이내로 입력가능.\n ex) 20151004');
		form1.p_endyear.focus();
		return false;
	}
	if( p_endyear.substring(4, 6) > 12 ){
		alert('[계약기간]중 월은 01 ~ 12월 사이의 숫자로 입력가능.\n ex) 20151004');
		form1.p_endyear.focus();
		return false;
	}
	if( p_endyear.substring(6) > 31 ){
		alert('[계약기간]중 일은 01 ~ 31일 사이의 숫자로 입력가능.\n ex) 20151004');
		form1.p_endyear.focus();
		return false;
	}
	// 담당자
	if(isEmpty(p_manager)){
		alert('[담당자]를 입력해주세요.');
		form1.p_manager.focus();
		return false;
	}
	// 모니터링 계정
	if(isEmpty(p_monitoringid)){
		alert('[모니터링 계정]을 입력해주세요.');
		form1.p_monitoringid.focus();
		return false;
	}
	// 담당업무
	if(isEmpty(p_responsibilities)){
		alert('[담당업무]를 입력해주세요.');
		form1.p_responsibilities.focus();
		return false;
	}
	// 전화번호
	if(isEmpty(p_telephone1)){
		alert('[전화번호]를 입력해주세요.');
		form1.p_telephone1.focus();
		return false;
	}
	if(isNaN(p_telephone1)){
		alert('[전화번호]는 숫자로 입력해주세요.\n ex) 02');
		form1.p_telephone1.focus();
		return false;
	}
	if(p_telephone1.length < 2){
		alert('[전화번호]를 올바른 형식으로 입력해주세요.\n ex) 02');
		form1.p_telephone1.focus();
		return false;
	}
	if(isEmpty(p_telephone2)){
		alert('[전화번호]를 입력해주세요.');
		form1.p_telephone2.focus();
		return false;
	}
	if(isNaN(p_telephone2)){
		alert('[전화번호]는 숫자로 입력해주세요.\n ex) 1234');
		form1.p_telephone2.focus();
		return false;
	}
	if(p_telephone2.length < 3){
		alert('[전화번호]를 올바른 형식으로 입력해주세요.\n ex) 555');
		form1.p_telephone2.focus();
		return false;
	}
	if(isEmpty(p_telephone3)){
		alert('[전화번호]를 입력해주세요.');
		form1.p_telephone3.focus();
		return false;
	}
	if(isNaN(p_telephone3)){
		alert('[전화번호]는 숫자로 입력해주세요.\n ex) 5678');
		form1.p_telephone3.focus();
		return false;
	}
	if(p_telephone3.length < 4){
		alert('[전화번호]를 올바른 형식으로 입력해주세요.\n ex) 1234');
		form1.p_telephone3.focus();
		return false;
	}
	// 휴대폰
	if(isEmpty(p_handphone1)){
		alert('[휴대폰]을 입력해주세요.');
		form1.p_handphone1.focus();
		return false;
	}
	if(isNaN(p_handphone1)){
		alert('[휴대폰]은 숫자로 입력해주세요.\n ex) 010');
		form1.p_handphone1.focus();
		return false;
	}
	if(p_handphone1.length < 3){
		alert('[휴대폰]를 올바른 형식으로 입력해주세요.\n ex) 010');
		form1.p_handphone1.focus();
		return false;
	}
	if(isEmpty(p_handphone2)){
		alert('[휴대폰]을 입력해주세요.');
		form1.p_handphone2.focus();
		return false;
	}
	if(isNaN(p_handphone2)){
		alert('[휴대폰]은 숫자로 입력해주세요.\n ex) 1234');
		form1.p_handphone2.focus();
		return false;
	}
	if(p_handphone2.length < 3){
		alert('[휴대폰]를 올바른 형식으로 입력해주세요.\n ex) 5555');
		form1.p_handphone2.focus();
		return false;
	}
	if(isEmpty(p_handphone3)){
		alert('[휴대폰]을 입력해주세요.');
		form1.p_handphone3.focus();
		return false;
	}
	if(isNaN(p_handphone3)){
		alert('[휴대폰]은 숫자로 입력해주세요.\n ex) 5678');
		form1.p_handphone3.focus();
		return false;
	}
	if(p_handphone3.length < 4){
		alert('[휴대폰]를 올바른 형식으로 입력해주세요.\n ex) 5678');
		form1.p_handphone3.focus();
		return false;
	}
	// 이메일
	if(isEmpty(p_email)){
		alert('[이메일]을 입력해주세요.');
		form1.p_email.focus();
		return false;
	}
	if(!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(p_email))){
		alert('[이메일]은 형식에 맞게 입력하여 주세요.\n ex) kitamember@kita.net');
		form1.p_email.focus();
		return false;
	}
	
	return result;
}

// 공백체크
function isEmpty(aString) {
    for(i=0 ; i<aString.length ; i++) {
       var ch = aString.charAt(i);
       if((ch != " ") && (ch != '\t'))
        return false;
    }
    return true;
}
</script>
</head>

<body style="margin:0px;" onLoad="jsInitPage();">
<form name="form1" id="form1" method="post">
<input type="hidden" name="cmd" value="" />
<input type="hidden" name="p_comp_seq" value="<%= v_comp_seq %>" />
<input type="hidden" name="p_telephone" value="" />
<input type="hidden" name="p_handphone" value="" />
<!--//-->

<table width="600px" height="100%" cellpadding="0" cellspacing="0">
<tr>
	<td align="center" height="100%" valign="top">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td class="pad_left_15">
				<!-- 메뉴명 -->
				<table width="100%" cellpadding="0" cellspacing="0" class="mar_top_10">
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
				<table width="100%" cellpadding="0" cellspacing="0" class="mar_top_5" style="display:"  id="MenuDescTb">
				<tr>
					<td class="border_gray" align="center">				
						<table width="100%" cellpadding="0" cellspacing="0">
						<tr valign="top">
							<!-- CP/유통사 현황과 실적 등을 관리할 수 있는 모듈 -->
							<td id="menuDesc"></td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
				<!-- // -->	
			</td>
		</tr>
		<tr>
			<td height="205" valign="top" align="center" style="padding:20px;">
				<table width="100%" class="mar_top_5" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/template0/common/popup_studentList_label01.gif" alt="기본정보" /></td>
				</tr>
				<tr><td height="5"></td></tr>
				</table>
 				
 				<!-- 유통사 정보  출력 -->
 				<table width="100%" class="mar_top_5" border="0" cellpadding="0" cellspacing="0" style="border-top:solid 1px #696969; border-bottom: solid 1px #696969; margin-top:15px;">
				<tr height="25">
					<th style="font-weight:bold; background-color: #eeeeee; text-align:center;">업체명</th>
					<td colspan="2"><input type="text" name="p_compnm" value="<%= v_compnm %>" style="width: 50%" maxlength="50"></td>
				</tr>
				<tr height="25">
					<th style="font-weight:bold; background-color: #eeeeee; text-align:center;">계약기간</th>
					<td colspan="2">
						계약일 : <input type="text" name="p_startyear" value="<%= v_startyear %>" maxlength="8"><img src="/images/back/common/txt_padding.gif">
						만료일 : <input type="text" name="p_endyear" value="<%= v_endyear %>" maxlength="8">
					</td>
				</tr>
				<tr height="25">
					<th style="font-weight:bold; background-color: #eeeeee; text-align:center;">담당자</th>
					<td colspan="2"><input type="text" name="p_manager" value="<%= v_manager %>" style="width: 50%" maxlength="100"></td>
				</tr>
				<tr height="25">
					<th style="font-weight:bold; background-color: #eeeeee; text-align:center;">모니터링 계정</th>
					<td colspan="2"><input type="text" name="p_monitoringid" value="<%= v_monitoringid %>" style="width: 50%" maxlength="20"></td>
				</tr>
				<tr height="25">
					<th style="font-weight:bold; background-color: #eeeeee; text-align:center;">담당업무</th>
					<td colspan="2"><input type="text" name="p_responsibilities" value="<%= v_responsibilities %>" style="width: 50%" maxlength="20"></td>
				</tr>
				<tr height="25">
					<th style="font-weight:bold; background-color: #eeeeee; text-align:center;">전화번호</th>
					<td colspan="2">
						<input type="text" name="p_telephone1" value="<%= v_telephone1 %>" maxlength="3"  style="width: 20%"> - 
						<input type="text" name="p_telephone2" value="<%= v_telephone2 %>" maxlength="4"  style="width: 20%"> - 
						<input type="text" name="p_telephone3" value="<%= v_telephone3 %>" maxlength="4"  style="width: 20%">
					</td>
				</tr>
				<tr height="25">
					<th style="font-weight:bold; background-color: #eeeeee; text-align:center;">휴대폰</th>
					<td colspan="2">
						<input type="text" name="p_handphone1" value="<%= v_handphone1 %>" maxlength="3" style="width: 20%"> -
						<input type="text" name="p_handphone2" value="<%= v_handphone2 %>" maxlength="4" style="width: 20%"> -
						<input type="text" name="p_handphone3" value="<%= v_handphone3 %>" maxlength="4" style="width: 20%">
					</td>
				</tr>
				<tr height="25">
					<th style="font-weight:bold; background-color: #eeeeee; text-align:center;">이메일</th>
					<td colspan="2"><input type="text" name="p_email" value="<%= v_email %>" style="width: 70%" maxlength="100"></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="100%" valign="top" align="center" style="padding:20px;">
				<table width="100%" class="mar_top_5" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/template0/common/popup_studentList_label01.gif" alt="컨텐츠 정보" /></td>
					<td align="right"><fmtag:button type="3" value="추가" func="main('SELECTCONTENTS');" /></td>
				</tr>
				<tr><td height="5"></td></tr>
				</table>
 				
 				<!-- 
 				<div id="div_contents" style="overflow-y:scroll; height: 300px;" >
				
					컨텐츠 검색결과 리스트 출력
					
				</div> -->
				
				<table width="100%" class="mar_top_5" border="1" cellpadding="0" cellspacing="0" style="border-top:solid 1px #696969; border-bottom: solid 1px #696969; margin-top:15px;">
				<colgroup><col width="87%" /><col width="13%" /></colgroup>
				<tr height="25" style="font-weight:bold; background-color: #eeeeee; text-align:center;">	
					<th>컨텐츠명</th>
					<th>삭제</th>
				</tr>	
				<tr>
					<td colspan="3">
						<div id="div_contents" style="overflow-y:scroll; height: 300px;" >
						<!-- 
							컨텐츠 검색결과 리스트 출력
						 -->		
						</div>
					</td>
				</tr>
				</table>
				
				<!-- 등록, 취소 버튼 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" >
				<tr><td height="20"></td></tr>
				<tr align="center">
				<% if ( v_comp_seq == "" ){ %>
					<td><fmtag:button type="1" value="등록" func="main('WRITE');" />&nbsp;&nbsp;<fmtag:button type="1" value="취소" func="goExternalSalesCompList();" /></td>
				<% } else { %>
					<td>
						<fmtag:button type="1" value="수정" func="main('UPDATE');" />&nbsp;&nbsp;<fmtag:button type="1" value="취소" func="goExternalSalesCompList();" />
						<br>
						<div align="right">
							<fmtag:button type="3" value="유통사정보 삭제" func="main('DELETE');" />
						</div>
					</td>
				<% } %>
				</tr>
				</table>
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