<%--
 * @(#)Sample Template
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * T_LMS_STUDENT 테이블 List Template.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2011. 02. 09. hjkim       Initial Release
 ************************************************
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.sinc.common.FormatDate" %>
<%@ include file = "/jsp/front/common/commonInc.jsp" %>
<%
	DataSet list = (DataSet)box.getObject("dsfileBoxList");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
<title><%=PAGETITLE%></title>
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
<fmtag:jscommon />
<script type="text/javascript">
<!--
	function requestForm ( seq, subj, subjseq, year, paymethod, rightno, inningseq, applynum ) {
		if(paymethod == '100000000000' || paymethod == '01' ) {
			alert("카드결제는 계산서를 신청하실 수 없습니다"); 
			return; 
		}else {	
			var url = "/front/FileBox.do?cmd=requestForm&p_seq=" + seq +"&p_subj=" + subj + "&p_year=" + year + "&p_subjseq=" + subjseq+ "&p_rightno=" + rightno + "&p_inningseq=" + inningseq + "&p_applynum=" + applynum ;
			popWin = Center_Fixed_Popup2(url, "requestForm", 630, 580, "no");
		}	
	}
	
	/*
	function requestReceipt ( seq, subj, subjseq, year, rightno, inningseq, applynum, v_iscard ) {
		// 영수증 신청
		var f = document.form1;
		var url = "/front/FileBox.do?cmd=requestReceiptForm&p_seq=" + seq +"&p_subj=" + subj + "&p_year=" + year + "&p_subjseq=" + subjseq + "&p_rightno=" + rightno + "&p_inningseq=" + inningseq + "&p_applynum=" + applynum + "&p_iscard=" + v_iscard ;
		popWin = Center_Fixed_Popup2(url, "requestReceiptForm", 360, 300, "no");
	}
	*/
	function requestReceiptPop ( seq , subjnm , subjseqnm) {
		// 영수증 신청
		//alert("subjnm : " + subjnm);
		if(confirm("영수증을 발행 하시겠습니까?") == true) {
			var f1 = document.form1;
			var f = document.receiptForm;
			
			f.p_seq.value=seq;
			f.p_subjnm.value=subjnm;
			f.p_subjseqnm.value=subjseqnm;
			
			//var url = "/back/BillPublish.do?cmd=requestReceiptForm&p_seq="+seq + "&p_subjnm=" + subjnm;
			var url = "/back/BillPublish.do?cmd=requestReceiptForm"
			var pop = Center_Fixed_Popup2("","RequestReceipt", 420, 700, "no");
			
			f.target="RequestReceipt";      //띄운 창으로 타겟설정. 
		    f.action="/back/BillPublish.do?cmd=requestReceiptForm";
		    f.submit(); 

		}
	}

	function refundDocuments ( seq, subj, subjseq, year, userid) {
		var f = document.form1;
		var url = "/front/FileBox.do?cmd=refundDocuments&p_seq=" + seq +"&p_subj=" + subj + "&p_year=" + year + "&p_subjseq=" + subjseq + "&p_userid=" + userid ;
		popWin = Center_Fixed_Popup2(url, "refundDocuments", 365, 320, "no");
	}
//-->
</script>
</head>

<body>

<form name="receiptForm" method="post">
	<input type="hidden" name="p_seq" value="" />
	<input type="hidden" name="p_subjnm" value="" />
	<input type="hidden" name="p_subjseqnm" value="" />
</form>

<form name="form1" id="form1" method="post">
<input type="hidden" name="cmd" value="fileBoxList" />
<input type="hidden" name="p_subj" value="" />
<input type="hidden" name="p_year" value="" />
<input type="hidden" name="p_subjseq" value="" />
<input type="hidden" name="p_seq" value="" />
<div class="board-list">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<caption></caption>
	<colgroup>
		<col width="30" />
		<col width="50" />
		<col width="" />
		<col width="50" />
		<col width="70" />
		<col width="70" />
		<col width="70" />
		<col width="70" />
		<col width="70" />						
	</colgroup>
	<thead>
	<tr>
		<th>No</th>
		<th>구분</th>
		<th>과정명</th>
		<th>기수</th>
		<th>결제방식</th>
		<th>계산서</th>
		<th>영수증</th>
		<th>신청일</th>
		<th class="th_nosplit">환급서류</td>
	</tr>
	</thead>
	<tbody>
<%
	DataSet payInstalList = null;

	String v_subj = "";
	String v_year = "";
	String v_subjseq = "";

	String v_isinstallment = "";
	String rowspan = "";
	
	String v_applygubun = "";
	String v_pubgubun = "";
	String v_recogstate = "";
	String v_recogstaterequestyn = "";
	String v_billrecogstaterequestyn = "";
	String v_paymethod = "";
	String v_iscard = "";
	String v_islicense = "";
	String v_seq = "";
	String v_paymentseq = "";
	int num = 0;
	while ( list != null && list.next() ) {
		
		v_subj = list.getString("SUBJ");
		
		/* System.out.println("#####################################################");
		System.out.println(" v_subj : " +  v_subj);
		System.out.println("#####################################################"); */
		
		v_year = list.getString("YEAR");
		v_subjseq = list.getString("SUBJSEQ");	
		v_isinstallment = list.getString("ISINSTALLMENT");
		v_islicense = list.getString("ISLICENSE");
		v_seq = list.getString("SEQ");
		v_paymentseq = list.getString("PAYMENTSEQ");
		
		/* 
		System.out.println("#####################################################");
		System.out.println(" v_seq : " +  v_seq);
		System.out.println(" v_paymentseq : " +  v_paymentseq);
		System.out.println("#####################################################");
		*/
		/**
		신청버튼을 클릭시 -> billpubseq 테이블에 들어있는 출력시insert한 값을 'paymentseq'로 검색하여 삭제하고
			신청을 집어 넣는다.
		

		질문 : 
		1. 삭제시 구분을 짓는데...신청과 출력의 구분자는 무엇??? 신청구분/영수증-R/계산서-B/필요없음-N
		
		2. 만약 신청을 안한상태에서 출력을 하면, 출력을 insert해야하나?? 한다면 두번째로 출력버튼을 누르면 마지막출력시간을
	
		업데이트 하는것인가??
	
		3. 처음 만든것에서, 출력을 했을때 등록하는 이유가 이력을 남기기 위함인가?
	
		4. 신청을 하고 출력을 했을시엔....
		  - 신청으로 들어가있던 걸 삭제하고 출력으로 입력? 업뎃??
	
	
		출력버튼을 클릭시 -> jsp단이나 java단에서 신청버튼을 없애지 않도록 한다.
		
		**/
		v_applygubun = (list.getString("APPLYGUBUN").equals(null) )? "" : list.getString("APPLYGUBUN") ; 
		v_pubgubun = (list.getString("PUBGUBUN").equals(null) )? "" : list.getString("PUBGUBUN") ;
		v_recogstate = (list.getString("RECOGSTATE").equals(null) )? "" : list.getString("RECOGSTATE") ;
		v_recogstaterequestyn = ( v_recogstate.equals("Y")) ? "Y" : "N";
		v_billrecogstaterequestyn = ( v_recogstate.equals("Y") || v_recogstate.equals("N") ) ? "Y" : "N";
		v_paymethod = (list.getString("PAYMETHOD").equals("100000000000") || list.getString("PAYMETHOD").equals("01") ) ? "카드" : (list.getString("PAYMETHOD").equals("010000000000") || list.getString("PAYMETHOD").equals("02")) ? "가상계좌" :  (list.getString("PAYMETHOD").equals("001000000000") || list.getString("PAYMETHOD").equals("03")) ? "무통장" : (list.getString("PAYMETHOD").equals("04")) ? "핸드폰" : (list.getString("PAYMETHOD").equals("9998")) ? "마일리지" : "";
		v_iscard = (v_paymethod.equals("카드")) ? "Y" : "N";
%>
	<tr height="30">
		<td><%=(++num) %></td>
		<td><%=list.getString("ISONOFFNM") %></td>
		<td><%=list.getString("SUBJNM") %></td>
		<td><% if(!list.getString("SUBJSEQGR").equals("") ){ %><%=list.getString("SUBJSEQGR") %>기<% } %></td><!-- 기수 -->
		<td><%=v_paymethod %></td>
		<!-- 신청 버튼 2012.07.31 추가 (승인여부 Y && 결제방식 카드,마일리지 아닌것)-->
		<td>
			<% if( v_billrecogstaterequestyn.equals("Y") && !v_paymethod.equals("카드") &&  !v_paymethod.equals("마일리지") &&  ( v_applygubun.equals("") &&  !v_pubgubun.equals("Y") ||  v_applygubun.equals("N")) ){ %>
				<a href="#" onClick="requestForm('<%=list.getString("SEQ") %>','<%=list.getString("SUBJ") %>','<%=list.getString("SUBJSEQ") %>','<%=list.getString("YEAR") %>', '<%=list.getString("PAYMETHOD") %>', '<%=list.getString("RIGHTNO") %>','<%=list.getString("INNINGSEQ") %>','<%=list.getString("APPLYNUM") %>');"><img src="/images/home0/common/btn_tbl_balgeub.gif"></a>
			<% } else if( v_applygubun.equals("B") ||v_applygubun.equals("R")) {%>
				<a href="#" onClick="requestForm('<%=list.getString("SEQ") %>','<%=list.getString("SUBJ") %>','<%=list.getString("SUBJSEQ") %>','<%=list.getString("YEAR") %>', '<%=list.getString("PAYMETHOD") %>', '<%=list.getString("RIGHTNO") %>','<%=list.getString("INNINGSEQ") %>','<%=list.getString("APPLYNUM") %>');"><img src="/images/home0/common/btn_tbl_balgeub.gif"></a>
			<% } %>
		</td>
		
		<%-- <td>
			<% if( v_billrecogstaterequestyn.equals("Y") && !v_paymethod.equals("카드") &&  !v_paymethod.equals("마일리지") &&  ( v_applygubun.equals("") &&  !v_pubgubun.equals("Y") ||  v_applygubun.equals("N")) ){ %>
				<a href="#" onClick="requestForm('<%=list.getString("SEQ") %>','<%=list.getString("SUBJ") %>','<%=list.getString("SUBJSEQ") %>','<%=list.getString("YEAR") %>', '<%=list.getString("PAYMETHOD") %>', '<%=list.getString("RIGHTNO") %>','<%=list.getString("INNINGSEQ") %>','<%=list.getString("APPLYNUM") %>');"><img src="/images/home0/common/btn_tbl_balgeub.gif"></a>
			<% } else if( v_applygubun.equals("B")||v_applygubun.equals("R")){%>
				<a href="#" onClick="requestForm('<%=list.getString("SEQ") %>','<%=list.getString("SUBJ") %>','<%=list.getString("SUBJSEQ") %>','<%=list.getString("YEAR") %>', '<%=list.getString("PAYMETHOD") %>', '<%=list.getString("RIGHTNO") %>','<%=list.getString("INNINGSEQ") %>','<%=list.getString("APPLYNUM") %>');"><img src="/images/home0/common/btn_tbl_balgeub.gif"></a>
			<% } %>
		</td> --%>
		<%-- <td><% if( v_billrecogstaterequestyn.equals("Y") && !v_paymethod.equals("카드") &&  !v_paymethod.equals("마일리지") ){ %>
				<a href="#" onClick="requestForm('<%=list.getString("SEQ") %>','<%=list.getString("SUBJ") %>','<%=list.getString("SUBJSEQ") %>','<%=list.getString("YEAR") %>', '<%=list.getString("PAYMETHOD") %>', '<%=list.getString("RIGHTNO") %>','<%=list.getString("INNINGSEQ") %>','<%=list.getString("APPLYNUM") %>');"><img src="/images/home0/common/btn_tbl_balgeub.gif"></a>
			<% } %>
		</td> --%>
		<%-- 
		<td><% if( v_billrecogstaterequestyn.equals("Y") && !v_paymethod.equals("카드") &&  !v_paymethod.equals("마일리지") &&  ( v_applygubun.equals("") &&  !v_pubgubun.equals("Y") ||  v_applygubun.equals("N")) ){ %>
				<a href="#" onClick="requestForm('<%=list.getString("SEQ") %>','<%=list.getString("SUBJ") %>','<%=list.getString("SUBJSEQ") %>','<%=list.getString("YEAR") %>', '<%=list.getString("PAYMETHOD") %>', '<%=list.getString("RIGHTNO") %>','<%=list.getString("INNINGSEQ") %>','<%=list.getString("APPLYNUM") %>');"><img src="/images/home0/common/btn_tbl_balgeub.gif"></a>
			<% } else if( v_applygubun.equals("B") ) {%>
				신청완료
			<% } %>
		</td>
		 --%>
		 <!-- 출력 버튼(승인여부 Y && 결제방식 '마일리지' 아닌것) -->
		 <!-- 가장 최근 것 -->
		 <%-- 
		 <td><% if( v_recogstaterequestyn.equals("Y") &&  !v_paymethod.equals("마일리지") && ( v_applygubun.equals("") ||  v_applygubun.equals("N")) ){ %>
				<a href="#" onClick="requestReceiptPop('<%=list.getString("SEQ") %>', '<%=list.getString("SUBJNM") %>', '<%=list.getString("SUBJSEQGR") %>');" ><img src="/images/back/button/btn_output.gif"></a>
			<% } else if (v_recogstaterequestyn.equals("Y") &&  !v_paymethod.equals("마일리지") && (v_applygubun.equals("R") || v_applygubun.equals("B")) ) {%>
				<a href="#" onClick="requestReceiptPop('<%=list.getString("SEQ") %>', '<%=list.getString("SUBJNM") %>', '<%=list.getString("SUBJSEQGR") %>');" ><img src="/images/back/button/btn_output.gif"></a>
			<% } %>
		</td>  
		--%>
		<!-- 최근 것 -->
		 <%-- <td><% if( v_recogstaterequestyn.equals("Y") &&  !v_paymethod.equals("마일리지") && ( v_applygubun.equals("") &&  !v_pubgubun.equals("Y") ||  v_applygubun.equals("N")) ){ %>
				<a href="#" onClick="requestReceiptPop('<%=list.getString("SEQ") %>');" ><img src="/images/back/button/btn_output.gif"></a>
			<% } else if (v_recogstaterequestyn.equals("Y") &&  !v_paymethod.equals("마일리지") && ( v_pubgubun.equals("Y") && v_applygubun.equals("R") ||  v_applygubun.equals("B")) ){%>
				<a href="#" onClick="requestReceiptPop('<%=list.getString("SEQ") %>');" ><img src="/images/back/button/btn_output.gif"></a>
			<% } %>
		</td>  --%>
		<!-- 처음 것  영수증 발급 -->
		 <td>
		 	<% if( v_recogstaterequestyn.equals("Y") &&  !v_paymethod.equals("마일리지") && ( v_applygubun.equals("") &&  !v_pubgubun.equals("Y") ||  v_applygubun.equals("N") ||  v_applygubun.equals("R"))){ %>
				<a href="#" onClick="requestReceiptPop('<%=list.getString("SEQ") %>', '<%=list.getString("SUBJNM") %>', '<%=list.getString("SUBJSEQGR") %>' );" ><img src="/images/back/button/btn_output.gif"></a>
			<% } else {%>
				
			<% } %>
		</td>
		<td>
		<% if ( list.getString("APPDATE").length() > 0 ) {   %>
			<%=DateTimeUtil.getDateText(1,list.getString("APPDATE").substring(0,8)) %>
		<% } %>	</td>
					
	<% if(!list.getString("SUBJ").equals("") && list.getString("COSTSUPPORT").equals("1003") ){ %>		
		<td><a href="#" onClick="refundDocuments('<%=list.getString("SEQ") %>','<%=list.getString("SUBJ") %>','<%=list.getString("SUBJSEQ") %>','<%=list.getString("YEAR") %>','<%=list.getString("USERID") %>');"><img src="/images/home0/common/btn_tbl_balgeub.gif"></a></td>
	<% }else { %>	
		<td>&nbsp;</td>	
	<% }  %>
				
	</tr>
<%	} %>
	</tbody>
	</table>
</div>
<br/>
</form>
<!-- //Footer -->