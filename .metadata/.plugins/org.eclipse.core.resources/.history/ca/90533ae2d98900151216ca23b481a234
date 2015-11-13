<%--
 * @(#)Sample Template
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * T_LMS_STUDENT 테이블 List Template.
 *
 ************************************************ㄷ
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2010. 11. 21.  bgcho       Initial Release
 ************************************************
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.sinc.common.FormatDate" %>
<%@ page import="java.io.*,java.util.*,java.lang.*" %>
<%@ include file = "/jsp/front/common/commonInc.jsp" %>

<%
	DataSet list = (DataSet)box.getObject("dsProposePayState");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
<title><%=PAGETITLE%></title>
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
<script type="text/javascript">
	function proposeWriteForm(subj, year, subjseq, installment_seq, proposeyn, isoptsubjectselect , trainingarea) {
		var f = document.form1;
		f.p_subj.value = subj;
		f.p_year.value = year;
		f.p_subjseq.value = subjseq;
		f.p_installment_seq.value = installment_seq;
		f.p_trainingarea.value=trainingarea;
		var url = "";
		popWin = Center_Fixed_Popup2(url, "ProposeWriteForm", 600, 500, "yes");
		
		f.action = "/front/Propose.do?cmd=proposeWriteForm";
		f.cmd.value = "proposeWriteForm";
		f.method = "post";
		f.target = "ProposeWriteForm";
		f.submit();
		f.target = "";
	}
	function paymentChange(subj, year, subjseq, installment_seq, proposeyn, isoptsubjectselect, tid ) {
		
		if(!confirm("가상계좌의 경우 이전에 받은 계좌정보는 사용 할 수 없습니다 \n변경하시겠습니까?")){
			return;
		}
		var f = document.form1;
		f.p_subj.value = subj;
		f.p_year.value = year;
		f.p_subjseq.value = subjseq;
		f.p_installment_seq.value = installment_seq;
		f.p_tid.value = tid;
		var url = "";
		popWin = Center_Fixed_Popup2(url, "ProposeWriteForm", 600, 500, "yes");
		<%-- 부모창 새로고침 후 팝업이 되도록 --%>
		window.location.reload();
		
		f.action = "/front/Propose.do?cmd=paymentChange";
		f.cmd.value = "paymentChange";
		f.method = "post";
		f.target = "ProposeWriteForm";
		f.submit();
		f.target = "";
	}
	function refundRequestWriteForm(subj, year, subjseq, seq, installment_seq ) {
		var f = document.form1;
		f.p_subj.value = subj;
		f.p_year.value = year;
		f.p_subjseq.value = subjseq;
		f.p_seq.value = seq;
		f.p_installment_seq.value = installment_seq;
		var url = "";
		popWin = Center_Fixed_Popup2(url, "RefundRequestWriteForm", 600, 500, "yes");
		
		f.action = "/front/Propose.do?cmd=refundRequestWriteForm";
		f.cmd.value = "refundRequestWriteForm";
		f.method = "post";
		f.target = "RefundRequestWriteForm";
		f.submit();
		f.target = "";
	}
	function showAccountInfo ( type, tid, paymethod ) {
		var f = document.form1;
		f.p_paymethod.value = type;
		f.p_tid.value = tid;
		
		popWin = Center_Fixed_Popup2("", "ShowAccountPopup", 600, 500, "yes");

		f.action = "/front/Propose.do?cmd=showAccountPopup";
		f.cmd.value = "showAccountPopup";
		f.method = "post";
		f.target = "ShowAccountPopup";
        f.submit();
        f.target = "";
	}
	// 대표id 전용, 수강생정보 확인하기
	function showStudentInfo( represent, subj, subjseq, recogstate ){
		var f = document.form1;
		f.p_represent.value = represent;
		f.p_represent_subj.value = subj;
		f.p_represent_subjseq.value = subjseq;
		f.p_represent_recogstate.value = recogstate;
		
		popWin = Center_Fixed_Popup2("", "showStudentPopup", 600, 500, "yes");

		f.action = "/front/Propose.do?cmd=showStudentPopup";
		f.method = "post";
		f.target = "showStudentPopup";
        f.submit();
        f.target = "";
	}
</script>
</head>

<body>
<form name="form1" id="form1" method="post">
<input type="hidden" name="cmd" value="proposeWriteForm" />
<input type="hidden" name="p_subj" value="" />
<input type="hidden" name="p_year" value="" />
<input type="hidden" name="p_subjseq" value="" />
<input type="hidden" name="p_installment_seq" value="" />
<input type="hidden" name="p_proposeyn" value="" />
<input type="hidden" name="p_isoptsubjectselect" value="" />
<input type="hidden" name="p_paymethod" value="" />
<input type="hidden" name="p_tid" value="" />
<input type="hidden" name="p_seq" value="" />
<input type="hidden" name="p_trainingarea" value="" />
<input type="hidden" name="p_userid" value="" />
<input type="hidden" name="p_represent" value="" />
<input type="hidden" name="p_represent_subj" value="" />
<input type="hidden" name="p_represent_subjseq" value="" />
<input type="hidden" name="p_represent_recogstate" value="" />

<div class="board-list">
<!-- div class="board-list<%=G_HGRCODE.equals("0")?"-"+G_IMGID:"" %>"-->
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<caption></caption>
	<colgroup>
		<col width="30" />
		<col width="50" />
		<col width="" />
		<col width="30" />
		<col width="80" />
		<col width="70" />
		<col width="60" />
		<col width="60" />
		<col width="70" />
		<col width="60" />
	</colgroup>
	<thead>
	<tr>
		<th>No</th>
		<th>구분</th>
		<th>과정명</th>
		<th>기수</th>
		<th>수강신청일</th>
		<th>결제기간</th>
		<th>결제방식</th>
		<th>결제금액</th>
		<th>상태</th>
		<th class="th_nosplit">환불신청</th>
	</tr>
	</thead>
	<tbody>
<%
	DataSet payInstalList = null;

	String v_subj = "";
	String v_year = "";
	String v_subjseq = "";
	String v_trainingclass = "";
	String v_installment_seq = "";
	String v_seq = "";
	String v_tid = "";
	String v_isonoff = "";
	String v_volunteeryn = "";
	String v_paperpassyn = "";
	String v_interviewpassyn = "";
	String v_proposeyn = "";
	String v_chkfinal = "";
	String v_isgraduated = "";
	String v_isinstallment = "";
	String v_isoptsubjectselect = "";
	String v_paystate = "";
	String v_recogstate = "";
	String v_recogstatenm = "";
	String v_paydayyn = "";
	String rowspan = "";
	String payable = "";
	String v_paymethod = "";
	String v_paymethodnm = "";
	String v_edustart = "";
	String v_eduend = "";
	String v_isgoyong = "";
	String v_trainingarea = ""; /* 추가_2013.12.10 */
	String interviewpassyn = "";
	String v_outsourcingtype = "";	//포팅:01 / 링크:그외
	String v_studentindate = "";	//입과된날(환불기준적용시에 사용)
	/* 추가_2015.09.10 */
	String v_represent = "";		// 대표 id
	
	int num = 0;
	// 환불신청기간 지정 변수 (환불가능기간 = 수업이 시작된 날 + 변수일)
	//int shortTraining = 10; 	// 단기연수
	int eLearning = 7;			// e러닝 (2013.10.18 수강시작일로 부터 7일이내 이후 환불불가)
	//int itEduCenter= 10;		// IT교육센터
	//int businessForeign = 10;	// 비지니스외국어
	
	int classDays = 0;			// 수업일수 (수업기간의 1/3같은걸 할때 사용)
	
	while ( list != null && list.next() ) {
		
		v_subj = list.getString("SUBJ");
		v_year = list.getString("YEAR");
		v_subjseq = list.getString("SUBJSEQ");
		v_trainingclass = list.getString("TRAININGCLASS");
		v_seq = list.getString("SEQ");
		v_tid = list.getString("TID");
		v_isonoff = list.getString("ISONOFF");
		v_volunteeryn = list.getString("VOLUNTEERYN");
		v_proposeyn = list.getString("PROPOSEYN");
		v_paperpassyn = list.getString("PAPERPASSYN");
		v_interviewpassyn = list.getString("INTERVIEWPASSYN");
		v_chkfinal = list.getString("CHKFINAL");
		v_isgraduated = list.getString("ISGRADUATED");
		v_isinstallment = list.getString("ISINSTALLMENT");
		v_isoptsubjectselect = list.getString("ISOPTSUBJECTSELECT");
		v_recogstate = list.getString("RECOGSTATE");
		v_paydayyn = list.getString("PAYDAYYN");
		v_recogstatenm = list.getString("RECOGSTATENM");
		v_paystate = v_recogstatenm;
		v_paymethod = list.getString("PAYMETHOD");
		v_paymethodnm = list.getString("PAYMETHODNM");
		v_edustart = list.getString("EDUSTART");
		v_eduend = list.getString("EDUEND");
		v_isgoyong = list.getString("ISGOYONG");
		v_trainingarea = list.getString("TRAININGAREA");  /* 추가_2013.12.10 */
		v_outsourcingtype  = list.getString("OUTSOURCINGTYPE");	//01:포팅
		v_studentindate = list.getString("STINDATE");	//입과된날
		v_represent = list.getString("REPRESENT");
		
		
		// 대표id의 경우, 입금완료 or 입금대기 밑에 수강생정보를 확인할 수 있는 버튼 추가.
		if ( !v_represent.equals("") && v_recogstate.equals("Y") ) {
			// 수강생 정보확인하는 버튼추가
			v_recogstatenm = "완료<br/><a href=\"#none\" onclick=\"showStudentInfo('"+v_represent+"','"+v_subj+"','"+v_subjseq+"','"+v_recogstate+"');\"><img src=\"/images/template0/common/btn_mycampus_student.gif\"></a>";
		} else if ( !v_represent.equals("") && v_recogstate.equals("N") ){
			v_recogstatenm = "입금대기<br/><a href=\"#none\" onclick=\"showStudentInfo('"+v_represent+"','"+v_subj+"','"+v_subjseq+"','"+v_recogstate+"');\"><img src=\"/images/template0/common/btn_mycampus_student.gif\"></a>";
		}
		
		if ( v_paymethod.equals("9999") ) {
			v_paymethodnm = "개인수강금";
		}
		
		if ( v_paymethod.equals("010000000000") || v_paymethod.equals("02") ) {	// 가상계좌
			v_paymethodnm = "가상계좌<br/><a href=\"#none\" onclick=\"showAccountInfo('"+v_paymethod+"','"+list.getString("TID")+"');\"><img src=\"/images/template0/common/btn_mycampus_view.gif\"></a>";
		} else if ( v_paymethod.equals("001000000000") || v_paymethod.equals("03") ) {	// 무통장
			v_paymethodnm = "무통장<br/><a href=\"#none\" onclick=\"showAccountInfo('"+v_paymethod+"','"+list.getString("TID")+"');\"><img src=\"/images/template0/common/btn_mycampus_view.gif\"></a>";
		}
		
		if ( v_paydayyn.equals("Y") ) {
			// 결제내역이 없거나, 결제상태가 취소(C),  결제실패(F) 이면 결제 가능   ( 환불완료(E) 제외) 
			payable = (v_recogstate.equals("")||v_recogstate.equals("C")|| v_recogstate.equals("F")) ? "Y" : "N";
		} else {
			payable = "N";
		}
		//payable = "Y";
		
		if ( v_paperpassyn.equals("Y") ) 		v_paperpassyn = "합격";
		else if ( v_paperpassyn.equals("N") ) 	v_paperpassyn = "불합격";
		else if ( v_paperpassyn.equals("") ) 	v_paperpassyn = "대기";
		
		if ( v_interviewpassyn.equals("Y") ){ 		v_interviewpassyn = "합격";  interviewpassyn="Y"; }
		else if ( v_interviewpassyn.equals("N") ) 	v_interviewpassyn = "불합격";
		else if ( v_interviewpassyn.equals("") ) 	v_interviewpassyn = "대기";
		
		if ( v_isinstallment.equals("Y") ) {
			HashMap param = list.getCurMap();
			payInstalList = (DataSet)param.get("payInstalList");
			//if ( payInstalList != null || payInstalList.getRow() > 0 ) {
				rowspan = " rowspan='"+payInstalList.getRow()+"'";
			//}
			
			for ( int i=0; payInstalList.next(); i++ ) {
				v_tid = payInstalList.getString("TID");
				v_seq = payInstalList.getString("SEQ");
				v_installment_seq = payInstalList.getString("INSTALLMENT_SEQ");
				v_recogstate = payInstalList.getString("RECOGSTATE");
				v_paydayyn = payInstalList.getString("PAYDAYYN");
				v_recogstatenm = payInstalList.getString("RECOGSTATENM");
				v_paystate = v_recogstatenm;
					
				if ( v_paydayyn.equals("Y") ) {
					// 결제내역이 없거나, 결제상태가 취소, 환불완료, 결제실패 이면 결제 가능
					payable = (v_recogstate.equals("")||v_recogstate.equals("C")||v_recogstate.equals("E")||v_recogstate.equals("F")) ? "Y" : "N";
				} else {
					payable = "N";
				}
				
				v_paymethod = payInstalList.getString("PAYMETHOD");
				v_paymethodnm = payInstalList.getString("PAYMETHODNM");
				if ( v_paymethod.equals("010000000000") ) {	// 가상계좌
					v_paymethodnm = "가상계좌<br/><a href=\"#none\" onclick=\"showAccountInfo('"+v_paymethod+"','"+payInstalList.getString("TID")+"');\"><img src=\"/images/template0/common/btn_mycampus_view.gif\"></a>";
				} else if ( v_paymethod.equals("001000000000") ) {	// 무통장
					v_paymethodnm = "무통장<br/><a href=\"#none\" onclick=\"showAccountInfo('"+v_paymethod+"','"+payInstalList.getString("TID")+"');\"><img src=\"/images/template0/common/btn_mycampus_view.gif\"></a>";
				}
%>
	<tr height="30">
		<%if(i==0){%>
		<td<%=rowspan%>><%=(++num) %></td>
		<td<%=rowspan%>><%=list.getString("ISONOFFNM") %><input type="hidden" value="<%=v_trainingarea%>" name="p_trainingarea"/></td>
		<td<%=rowspan%>><%=list.getString("SUBJNM") %></td>
		<td<%=rowspan%>><%=list.getString("SUBJSEQGR") %>기</td>
		<td<%=rowspan%>><%=list.getString("APPDATE") %></td>
		<%}%>
		<td><%=payInstalList.getString("PAYDATE") %></td>
		<td><%=v_paymethodnm%></td>
		<td><%=payInstalList.getString("PAYAMT") %></td>
		<td>
			<% 
			if(payable.equals("Y") && interviewpassyn.equals("Y")){ 	// 장기과정 합격자인지 확인
					%><a href="#none" onclick="javascript:proposeWriteForm('<%=v_subj %>','<%=v_year%>','<%=v_subjseq%>','<%=v_installment_seq%>','<%=v_proposeyn%>','<%=v_isoptsubjectselect%>','<%=v_trainingarea%>');"><img src="/images/template0/common/btn_mycampus_approve.gif"></a><%
			} else if(payable.equals("N") && interviewpassyn.equals("Y") && !v_recogstate.equals("Y") ){ 		// 결제 불가능하고 장기과정 합격자면서 결제 완료가 아닐경우
					/* 현재 결제기간인지 확인  */
					if(v_paydayyn.equals("Y")){
					/* 무역마스터(03), IT마스터(04),섬유수출 전문가(12, 16), 중국마케팅 전문가(13)인 경우만 */ 
						if(v_trainingclass.equals("03") || v_trainingclass.equals("04") || v_trainingclass.equals("12") || v_trainingclass.equals("13")|| v_trainingclass.equals("16"))	
						{%>
							<%=v_recogstatenm%><br><a href="#none" onclick="paymentChange('<%=v_subj %>','<%=v_year%>','<%=v_subjseq%>','<%=v_installment_seq%>','<%=v_proposeyn%>','<%=v_isoptsubjectselect%>','<%=v_tid%>');"><img src="/images/template0/common/btn_mycampus_payment_change.gif"></a>
						<%} else {%>
							<%=v_recogstatenm%>
						<%}
					} else {%>
						<%=v_recogstatenm%>
					<%}
			}else{
				%>
				<%=v_recogstatenm%>
				<%
			}
			%>
		</td>
		<!-- 장기과정의 경우  환불신청 버튼이 활성화 되지 않도록 수정 - 무역실무연수실 요청 (2013.2.21) -->
		<td><!-- <%=(v_recogstate.equals("Y")&&v_isgraduated.equals("")&&!v_seq.equals(""))?"<a href=\"#none\" onclick=\"javascript:refundRequestWriteForm('"+v_subj+"','"+v_year+"','"+v_subjseq+"','"+v_seq+"','"+v_installment_seq+"')\"><img src=\"/images/common/btn_request01.gif\"></a>":"" %> --></td>
	</tr>
<%			}
		} else { %>
	<tr height="30">
		<td><%=(++num) %></td>
		<td><%=list.getString("ISONOFFNM") %><input type="hidden" value="<%=v_trainingarea%>" name="p_trainingarea"/></td>
		<td><%=list.getString("SUBJNM") %></td>
		<td><%=list.getString("SUBJSEQGR") %>기</td>
		<td><%=list.getString("APPDATE") %></td>
		<td><%=list.getString("PAYDATE") %></td>
		<td><%=v_paymethodnm %></td>
		<td><%=StringUtil.nvl(list.getString("AMOUNT"),list.getString("PRICE")) %></td>
		<td>
			<% 
				if(payable.equals("Y") && v_chkfinal.equals("Y")){ 	// 장기과정 합격자인지 확인
					%><a href="#none" onclick="javascript:proposeWriteForm('<%=v_subj %>','<%=v_year%>','<%=v_subjseq%>','<%=v_installment_seq%>','<%=v_proposeyn%>','<%=v_isoptsubjectselect%>');"><img src="/images/template0/common/btn_mycampus_approve.gif"></a><%
				} else if(payable.equals("N") && interviewpassyn.equals("Y") && !v_recogstate.equals("Y") ){ 		// 결제 불가능하고 장기과정 합격자면서 결제 완료가 아닐경우
					/* 현재 결제기간인지 확인 & 결제 완료상태가 아닌지 확인 */
					if(v_paydayyn.equals("Y") && !(v_recogstate.equals("Y"))){
					/* 무역마스터(03), IT마스터(04),섬유수출 전문가(12, 16), 중국마케팅 전문가(13), 지부장기과정(15)인 경우만 */ 
						if(v_trainingclass.equals("03") || v_trainingclass.equals("04") || v_trainingclass.equals("12") || v_trainingclass.equals("16") || v_trainingclass.equals("13") || (v_trainingclass.equals("15")&&v_isonoff.equals("LONG")))	
						{%>
							<%=v_recogstatenm%><br><a href="#none" onclick="paymentChange('<%=v_subj %>','<%=v_year%>','<%=v_subjseq%>','<%=v_installment_seq%>','<%=v_proposeyn%>','<%=v_isoptsubjectselect%>','<%=v_tid%>');"><img src="/images/template0/common/btn_mycampus_payment_change.gif"></a>
						<%} else {%>
							<%=v_recogstatenm%>
						<%}
					} else {%>
						<%=v_recogstatenm%>
					<%}
				}else{
					%>
					<%=v_recogstatenm%>
					<%
				}			
			%><br>
		</td>
		<% String refunddate = list.getString("REFUNDEND"); %>
		<% if ("".equals(refunddate)) { /* 환불을 하지 않았다면 */ %>
		<% 
			int compareDate = 0;
		
			// 현재 날짜를 구한다.
			java.util.Calendar gc = new GregorianCalendar();
			SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
			Date d = gc.getTime();
			String str = sf.format(d);
			SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyyMMdd");
			FormatDate fdt = new FormatDate();
	
			Date curDate = dateFormatter.parse(str);
			Date eduDate;
			if(v_edustart.equals("")){	// 개강날짜 정보가 없을 경우 예외 처리
				eduDate = dateFormatter.parse(str);
			} else {
			
				/* 환불기간 => e러닝: 7일!! 
				T_LMS_STUDENT 테이블에 INDATE 컬럼추가 > 
				수강생등록일(입과일, INDATE)이 교육시작일 이전일경우 교육시작일로부터 7일 
				수강생등록일(입과일, INDATE)이 교육시작일 이후일경우 수강생들록일 이후부터 7일 */
				if(v_studentindate.equals("")){
					v_studentindate = fdt.getRelativeDate(fdt.getDate("yyyyMMdd"), -365 );	//입과일이 없으면(null) 환불버튼 안나오게 입과일을 임시로 1년전으로지정
					//System.out.println(v_studentindate);
				}
				if(Integer.parseInt(v_studentindate)>=Integer.parseInt(v_edustart)){	//교육시작일보다 입과일이 늦으면 입과일로부터 7일간환불가능
					eduDate = dateFormatter.parse(v_studentindate);
				}else{	//교육시작일보다 입과일이 빠를경우 교육시작일로부터 7일간 환불가능
					eduDate = dateFormatter.parse(v_edustart);
				}
			}
			// 수업 시작일로 부터 현재까지 몇일이 지났는지 계산
			compareDate = (int)((eduDate.getTime()-curDate.getTime())/(1000*60*60*24));
			compareDate *= -1;
			
			// 수업 일수를 구한다(정확하게는 수업 일수가 아니라 수업 기간)
			if(v_eduend.equals("")){	// 수업종료 날짜 정보가 없을 경우 예외 처리
				System.out.println("수업 종료일이 공백");
				classDays = 2; // 수업 종료일이 없으면 수업일수를 0으로 만들어 환불버튼이 활성화 되지 않도록 한다.
			} else {
				Date eduEnd = dateFormatter.parse(v_eduend);
				classDays = (int)((eduEnd.getTime()-eduDate.getTime())/(1000*60*60*24))+1;
			}
		%>
			<%
				if (v_trainingclass.equals("01")  || (v_trainingclass.equals("15")&&v_isonoff.equals("OFF")) ||v_trainingclass.equals("05") ){				// 단기연수일 경우%>
					<%-- <% if(shortTraining >= compareDate) {%> --%>
						<td><%=(v_recogstate.equals("Y")&&v_isgraduated.equals("")&&!v_seq.equals(""))?"<a href=\"#none\" onclick=\"javascript:refundRequestWriteForm('"+v_subj+"','"+v_year+"','"+v_subjseq+"','"+v_seq+"','')\"><img src=\"/images/common/btn_request01.gif\"></a>":"" %></td>
					<%-- <%}%> --%>
				<%} else if (v_trainingclass.equals("09")  || (v_trainingclass.equals("15")&&v_isonoff.equals("ON")) ) {	// e러닝일 경우%> 
					<% if(v_isgoyong.equals("Y")) {	// 환급과정일 경우  // 수업시작일로부터 현재까지의 기간이 총수업일수의 1/2보다 작을경우 환불가능%>
						<% if((classDays/2) >= compareDate) {%>
							<td><%=(v_recogstate.equals("Y")&&v_isgraduated.equals("")&&!v_seq.equals(""))?"<a href=\"#none\" onclick=\"javascript:refundRequestWriteForm('"+v_subj+"','"+v_year+"','"+v_subjseq+"','"+v_seq+"','')\"><img src=\"/images/common/btn_request01.gif\"></a>":"" %></td>
						<%} else {%>
							<td></td>
						<%} %>
					<%} else {	// 비환급과정일 경우 %>
					
					
							<!-- 환불기간 => e러닝: 7일!! 
								T_LMS_STUDENT 테이블에 INDATE 컬럼추가 > 
								수강생등록일(입과일, INDATE)이 교육시작일 이전일경우 교육시작일로부터 7일 
								수강생등록일(입과일, INDATE)이 교육시작일 이후일경우 수강생들록일 이후부터 7일  
							-->					
							<%if(eLearning >= compareDate){	%>
							<td><%=(v_recogstate.equals("Y")&&v_isgraduated.equals("")&&!v_seq.equals(""))?"<a href=\"#none\" onclick=\"javascript:refundRequestWriteForm('"+v_subj+"','"+v_year+"','"+v_subjseq+"','"+v_seq+"','')\"><img src=\"/images/common/btn_request01.gif\"></a>":"" %></td>
							<%} else { %>
							<td></td>
							<%} %>
						 
					<%} %>
				<%} else if (v_trainingclass.equals("10")) {	// IT교육센터일 경우%>
					<%-- <% if(itEduCenter >= compareDate) {%> --%>
						<td><%=(v_recogstate.equals("Y")&&v_isgraduated.equals("")&&!v_seq.equals(""))?"<a href=\"#none\" onclick=\"javascript:refundRequestWriteForm('"+v_subj+"','"+v_year+"','"+v_subjseq+"','"+v_seq+"','')\"><img src=\"/images/common/btn_request01.gif\"></a>":"" %></td>
					<%-- <%}%> --%>
				<%} else if (v_trainingclass.equals("14")) {	// 비지니스 외국어(itab)일 경우(아직 trainingclass에 등록되지 않음)%>
					<%-- <% if(businessForeign >= compareDate) {%> --%>
						<td><%=(v_recogstate.equals("Y")&&v_isgraduated.equals("")&&!v_seq.equals(""))?"<a href=\"#none\" onclick=\"javascript:refundRequestWriteForm('"+v_subj+"','"+v_year+"','"+v_subjseq+"','"+v_seq+"','')\"><img src=\"/images/common/btn_request01.gif\"></a>":"" %></td>
					<%-- <%}%> --%>
				<%} else {%>
					<td></td>
				<%} %>
		<% } else {	/* 환불을 했다면 */
			SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHH");
			Date now = new Date();	
			Date refundTime = null;
			if (!"".equals(refunddate)) {
				refundTime = format.parse(refunddate);
			}
		%>
			<td><%=(v_recogstate.equals("Y")&&v_isgraduated.equals("")&&!v_seq.equals("")&&(now.getTime() < refundTime.getTime()))?"<a href=\"#none\" onclick=\"javascript:refundRequestWriteForm('"+v_subj+"','"+v_year+"','"+v_subjseq+"','"+v_seq+"','')\"><img src=\"/images/common/btn_request01.gif\"></a>":"" %></td>
		<% } %>
	</tr>
<%		} %>
<%	} %>
	</tbody>
	</table>
</div>
</form>
</body>
</html>
<!-- //Footer -->