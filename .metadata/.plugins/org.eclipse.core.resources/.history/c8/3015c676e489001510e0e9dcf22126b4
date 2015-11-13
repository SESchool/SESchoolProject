<%--
 * @(#)Sample Template
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * TC_ 테이블 List Template.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2009. 12. 09.  jangcw       Initial Release
 ************************************************
--%>
<%@ page contentType="text/html;charset=UTF-8" 		%>
<%@page import="com.sinc.common.FormatDate"%>
<%@ include file = "/jsp/front/common/commonInc.jsp"	%>
<%
DataSet list = (DataSet)box.getObject("proposeList");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
<title><%=PAGETITLE%></title>
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
<script type="text/javascript">
	function changeBook(subj, year, subjseq) {
		var url = "/front/Propose.do?cmd=changeBookWriteForm&p_subj=" + subj + "&p_year=" + year + "&p_subjseq=" + subjseq; 
		Center_Fixed_Popup2(url, "popPropose", 500, 400, "no");
	}
	
	function changeDelivery(subj, year, subjseq) {
		var url = "/front/Propose.do?cmd=changeDeliveryWriteForm&p_subj=" + subj + "&p_year=" + year + "&p_subjseq=" + subjseq;
		Center_Fixed_Popup2(url, "popPropose", 720, 400, "no");
	}

	function proposeCancel ( subj, year, subjseq, seq ) {
		if ( confirm("정말로 취소 하겠습니까?") ) {
			var f = document.form1;

			f.p_subj.value = subj;
			f.p_year.value = year;
			f.p_subjseq.value = subjseq;
			f.p_seq.value = seq;
			
			f.action = "/front/Propose.do?cmd=proposeWriteCancel";
			f.cmd.value = "proposeWriteCancel";
			f.method = "post";
			f.target = "";
			f.submit();
		}
	}

	function refundRequestWriteForm(subj, year, subjseq, seq, installment_seq ) {
		var f = document.form1;
		f.p_subj.value = subj;
		f.p_year.value = year;
		f.p_subjseq.value = subjseq;
		f.p_seq.value = seq;
		//f.p_installment_seq.value = installment_seq;
		var url = "";
		popWin = Center_Fixed_Popup2(url, "RefundRequestWriteForm", 600, 500, "yes");
		
		f.action = "/front/Propose.do?cmd=refundRequestWriteForm";
		f.cmd.value = "refundRequestWriteForm";
		f.method = "post";
		f.target = "RefundRequestWriteForm";
		f.submit();
		f.target = "";
	}

	// 수강신청서 보기
	function showProposeApplyPopup ( subj, year, subjseq, userid ) {
		var url = "/back/Apply.do?cmd=applyShowForm&p_subj="+subj+"&p_year="+year+"&p_subjseq="+subjseq+"&p_userid="+userid;
		popWin = Center_Fixed_Popup2(url, "ApplyShowForm", 600, 500, "yes");
	}
	// 지원신청서 보기
	function volunteerformShowPopup ( trainingclass, subj, year, subjseq, userid, applyno, noticeno ) {
		/*
		if ( trainingclass == "08" ) {
			var url = "/front/Internship.do?cmd=internshipResumeView&p_applyno="+applyno+"&p_noticeno="+noticeno;
	        Center_Fixed_Popup2(url, "internView", 1024, 700, "yes");
		} else {
			//var url = "/front/Volunteer.do?cmd=volunteerformShowPopup&p_subj="+subj+"&p_year="+year+"&p_subjseq="+subjseq+"&p_userid="+userid;
			//popWin = Center_Fixed_Popup3(url, "VolunteerformShowPopup", 650, 900, "yes");
			var url = "/front/Volunteer.do?cmd=volunteerWriteForm&p_subj="+subj+"&p_year="+year+"&p_subjseq="+subjseq+"&p_userid="+userid;
			popWin = Center_Fixed_Popup3(url, "VolunteerformShowPopup", 660, 900, "yes");
		}
		*/
		var url = "/front/Volunteer.do?cmd=volunteerWriteForm&p_subj="+subj+"&p_year="+year+"&p_subjseq="+subjseq+"&p_userid="+userid;
		popWin = Center_Fixed_Popup3(url, "VolunteerformShowPopup", 660, 900, "yes");
	}
</script>
</head>
<body>
<form name="form1" id="form1" method="post">
<input type="hidden" name="cmd" value="" />
<input type="hidden" name="p_subj" value="" />
<input type="hidden" name="p_year" value="" />
<input type="hidden" name="p_subjseq" value="" />
<input type="hidden" name="p_seq" value="" />
<input type="hidden" name="p_isinstallment" value="" />
<div class="board-list<%=G_HGRCODE.equals("0")?"-"+G_IMGID:"" %>">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<caption></caption>
	<colgroup>
		<col width="30" />
		<col width="50" />
		<col width="" />
		<col width="40" />
		<col width="80" />
		<col width="80" />
		<col width="50" />
		<col width="50" />
		<col width="50" />
		<col width="50" />
		<col width="50" />
	</colgroup>
	<thead>
	<tr>
		<th>No</th>
		<th>교육<br/>형태</th>
		<th>과정명</th>
		<th>기수</th>
		<th>수강신청일</th>
		<th>교육기간</th>
		<th>서류<br/>전형</th>
		<th>면접<br/>전형</th>
		<th>신청서<br/>보기</th>
		<th>수강<br/>승인</th>
		<th class="th_nosplit">수강<br/>취소</th>
	</tr>
	</thead>
	<tbody>
<%
	String v_subj = "";
	String v_year = "";
	String v_subjseq = "";
	String v_isonoff = "";
	String v_trainingclass = "";
	String v_isinstallment = "";
	String v_seq = "";
	String v_recogstate = "";
	String v_volunteeryn = "";
	String v_paperpassyn = "";
	String v_interviewpassyn = "";
	String v_chkfinal = "";
	boolean blIsCancel = false;
	
	/**
		01	단기연수
		02	위탁연수
		03	무역마스터
		04	IT마스터
		05	자격시험
		06	GLMP
		07	GTEP	
		08	글로벌인턴쉽
		09	이러닝	
		10	IT교육센터
	*/
	
	int num = 0;
	while ( list != null && list.next() ) {
		
		v_subj = list.getString("SUBJ");
		v_year = list.getString("YEAR");
		v_subjseq = list.getString("SUBJSEQ");
		v_isonoff = list.getString("ISONOFF");
		v_trainingclass = list.getString("TRAININGCLASS");
		v_volunteeryn = list.getString("VOLUNTEERYN");
		v_paperpassyn = list.getString("PAPERPASSYN");
		v_interviewpassyn = list.getString("INTERVIEWPASSYN");
		v_chkfinal = list.getString("CHKFINAL");
		v_recogstate = list.getString("RECOGSTATE");
		v_isinstallment = list.getString("ISINSTALLMENT");
		v_seq = list.getString("SEQ");
		
		if ( !v_chkfinal.equals("N") && !( v_trainingclass.equals("03") || v_trainingclass.equals("04") || v_trainingclass.equals("12") || v_trainingclass.equals("15")|| v_trainingclass.equals("16") )
/* 		중국마케팅 취소가능하도록 임시로 수정
if ( !v_chkfinal.equals("N") && !( v_trainingclass.equals("03") || v_trainingclass.equals("04") || v_trainingclass.equals("12") || v_trainingclass.equals("13") || v_trainingclass.equals("15")|| v_trainingclass.equals("16") ) */
				&& !( v_recogstate.equals("P") || v_recogstate.equals("R") || v_recogstate.equals("Y") )) {
			blIsCancel = true;
		}
		
		if ( v_paperpassyn.equals("Y") ) 		v_paperpassyn = "합격";
		else if ( v_paperpassyn.equals("N") ) 	v_paperpassyn = "불합격";
		else if ( v_paperpassyn.equals("") ) 	v_paperpassyn = "대기";
		
		if ( v_interviewpassyn.equals("Y") ) 		v_interviewpassyn = "합격";
		else if ( v_interviewpassyn.equals("N") ) 	v_interviewpassyn = "불합격";
		else if ( v_interviewpassyn.equals("") ) 	v_interviewpassyn = "대기";
%>
	<tr height="30">
		<td><%=(++num) %></td>
		<td><%=list.getString("ISONOFFNM") %></td>
		<td><%=list.getString("SUBJNM") %></td>
		<td><%=list.getString("SUBJSEQGR") %>회</td>
		<td><%=list.getString("APPDATE") %></td>
		<td><%=list.getString("EDUDATA") %></td>
		<td><%=v_paperpassyn %></td>
		<td><%=v_interviewpassyn %></td>
		<td><%if(v_volunteeryn.equals("Y")){%><a href="#none" onclick="volunteerformShowPopup('','<%=v_subj%>','<%=v_year%>','<%=v_subjseq%>','','','')"><img src="/images/template0/common/btn_mycampus_view.gif" alt="보기" /></a>
		<%}else{%>-<!-- <a href="#none" onclick="showProposeApplyPopup('<%=v_subj%>','<%=v_year%>','<%=v_subjseq%>','')"><img src="/images/template0/common/btn_mycampus_view.gif" alt="보기" /></a> --><%}%>
		</td>
		<td><%=list.getString("CHKFINALNM") %></td>
		<!-- 무역마스터(03), IT마스터(04), 섬유수출 전문가(12), 중국마케팅 전문가(13), 지부장기과정(15)인 경우[장기과정] -->
	<%	if ( v_trainingclass.equals("03") || v_trainingclass.equals("04") || v_trainingclass.equals("12") ||  v_trainingclass.equals("15")|| v_trainingclass.equals("16")){ %>
<%-- 	중국마케팅 수강취소 가능하도록 임시로 수정
<%	if ( v_trainingclass.equals("03") || v_trainingclass.equals("04") || v_trainingclass.equals("12") || v_trainingclass.equals("13") || v_trainingclass.equals("15")|| v_trainingclass.equals("16")){ %> --%>
		<%	if ( !v_seq.equals("") && v_recogstate.equals("Y") ) { %>
			<td><%="<a href=\"#none\" onclick=\"javascript:refundRequestWriteForm('"+v_subj+"','"+v_year+"','"+v_subjseq+"','"+v_seq+"','')\"><img src=\"/images/template0/common/btn_mycampus_cancel.gif\"></a>"%></td>
		<% 	} else { %>
				<td></td>
		<%  }%>
	<%	} else { %>
		<td><%if(blIsCancel){%><a href="#none" onclick="proposeCancel('<%=v_subj %>','<%=v_year %>','<%=v_subjseq %>','<%=v_seq %>');"><img src="/images/template0/common/btn_mycampus_cancel.gif" alt="취소" /></a><%} %></td>
	<%	} %>
		
	</tr>
<%	} %>
	</tbody>
	</table>
</div>

			
<table width="690" border="0" cellpadding="0" cellspacing="0" style="margin-top:25px;">
<tr valign="bottom">
	<td><img src="/images/template0/title/pagetitle_9_1_4.gif" alt="배송지변경 타이틀" /></td>				
</tr>
<tr><td height="5"></td></tr>
</table>

<div class="board-list<%=G_HGRCODE.equals("0")?"-"+G_IMGID:"" %>">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<caption></caption>
	<colgroup>
		<col width="" />
		<col width="60" />
		<col width="300" />
		<col width="80" />
	</colgroup>
	<thead>
	<tr>
		<th>과목명</th>
		<th>교재명</th>
		<th>배송주소</th>
		<th class="th_nosplit">주소변경</th>
	</tr>
	</thead>
	<tbody>
<%
	list.setPos();			
	while ( list != null && list.next() ) {
		HashMap param = list.getCurMap();
		DataSet bookList = (DataSet)param.get("BookList");
		DataSet deliveryList = (DataSet)param.get("DeliveryList");
		
		v_subj		= list.getString("SUBJ");
		v_year		= list.getString("YEAR");
		v_subjseq	= list.getString("SUBJSEQ");
		
		if ( bookList != null ) {
			String rowspan = bookList.getRow() > 0 ? "rowspan='" +bookList.getRow() + "'" : "";
			for ( int i=0; bookList.next(); i++ ) {
				String subjmonth = bookList.getString("SUBJMONTH");
				String bookid = bookList.getString("BOOKID");
				String booknm = bookList.getString("BOOKNM");
%>
	<tr height="30">
		<% if(i==0){ %><td <%=rowspan%>><%=list.getString("SUBJNM") %><br><%=DateTimeUtil.getDateText(1,list.getString("EDUSTART")) %></td><% } %>
		<td class="td_leftline"><%=subjmonth%>개월</td>
		<td class="td_leftline"><%=booknm %></td>
		<% if(i==0){ %>
		<td class="td_leftline"<%=rowspan%> valign="center">
		<a href="#1" onClick="changeBook('<%=v_subj%>', '<%=v_year%>','<%=v_subjseq%>')"><img src="/images/template0/common/btn_change_book.gif" alt="교재변경버튼" /></a><br/><br/>
		<a href="#1" onClick="changeDelivery('<%=v_subj%>', '<%=v_year%>','<%=v_subjseq%>')"><img src="/images/template0/common/btn_change_addr.gif" alt="주소변경버튼" /></a>
		</td><% } %>
	</tr>
<%			}
		}
	} %>						
	</tbody>
	</table>
</div>
</form>
<!-- //Body -->
</body>
</html>