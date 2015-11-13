<%--
 * @(#)SystemCode Template
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * T_LMS_CODEGUBUN 테이블 List Template.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2010. 11. 06.  leehj       Initial Release
 ************************************************
--%>
<%@ page contentType="text/html;charset=UTF-8" 	%>
<%@ include file = "/jsp/back/common/commonInc.jsp"	%>
<%
	String  v_comp_seq	= box.getString("p_comp_seq");
	String  v_compnm	= box.getString("p_compnm");
	String  v_memo 		= box.getString("MemoInfo");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>::: 한국무역협회 무역아카데미 ::: 관리자페이지</TITLE>
<META http-equiv=Content-Type content="text/html; charset=UTF-8"> 
<fmtag:csscommon point="back" />
<fmtag:jscommon />
<script language="Javascript" src="/js/common/popupbox.js"></script>
<SCRIPT LANGUAGE="JavaScript">
function memoConfirm() {
	var f = document.form1;

	f.action = "/back/Comp.do?cmd=externalCompMemo";
	f.cmd.value="externalCompMemo";
	f.method = "post";
    f.submit();
}
</SCRIPT>
</HEAD>
<BODY leftMargin=0 topMargin=0 marginheight="0" marginwidth="0" >
	<form name="form1" action="/back/Refund.do" method="post" onSubmit="return false;">
	<input type="hidden" name="cmd" value="externalCompMemoForm">
  	<input type="hidden" name="p_comp_seq"		value="<%=v_comp_seq%>"> 
  		
	<table width="750" cellpadding="0" cellspacing="0">
	<tr>
		<td class="pad_left_15">

		     <!-- 메뉴명 -->
			<table width="560" cellpadding="0" cellspacing="0" class="mar_top_20">
			<colgroup>
				<col width="10" />
				<col width="" />
				<col width="15" />
			</colgroup>
			<tr>
				<td><img src="/images/back/common/bullet_title.gif"></td>
				<td class="t_title"> 메모 </td>
				<td align="right" valign="bottom"></td>
			</tr>
			</table>
		  </td>
	</tr>	
	<tr>
		<td class="pad_left_15">
			<div class="board-view">
			<table width="720" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="720" />			
			</colgroup>
			<tr>
				<td class="td_top_bd">
	             	<%=v_compnm %>의 메모입니다.
				</td>
			</tr>
			<tr>
				<td class="td_top_bd" height="330">
	             	<textarea name="p_memo" cols="115" rows="30"><%=v_memo %></textarea>
				</td>
			</tr>
			</table>
			</div>
		</td>
	</tr>
	<!-- // -->
	</table>

    <!-- 버튼 -->
	<table width="750" cellpadding="0" cellspacing="0" class="mar_top_10">
	<tr>
		<td align="center">
			<table cellpadding="0" cellspacing="0">
			<tr>
			  <td>
				<fmtag:button type="1" value="저장" func="memoConfirm()" />&nbsp;
	  			<fmtag:button type="1" value="취 소" func="window.close()" /></td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
	</form>	
	<!-- // -->
</BODY>
</HTML>	