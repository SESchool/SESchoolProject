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
DataSet list = (DataSet)box.getObject("myToeflListData");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
<title><%=PAGETITLE%></title>
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />

<SCRIPT LANGUAGE="JavaScript">
<!--
	function approvalCancelWrite(year, subj, subjseq) {
		if (confirm("취소요청 하시겠습니까?")) {
			var f = document.form1;
			/*
			f.p_gyear.value		= gyear; 
			f.p_subj.value 		= subj;
			f.p_subjseq.value	= subjseq;
	        f.cmd.value="courseApprovalCancelWriteForm";
	        f.submit();
	        */
	        var url = "/front/Approval.do?cmd=courseApprovalCancelWriteForm&p_year="+ year+  "&p_subj=" + subj+ "&p_subjseq=" + subjseq;
			popWin = Center_Fixed_Popup2(url, "approvalCancel", 500, 400, "no");	
	      
		}
	}
//-->



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
	
	
	function goTestStart(gubun,inst, name, prn1, prn2){
		
		if(gubun==2 ){	//방문시험접수장일경우 그래도 시험칠건지 묻기
			if(!confirm("본시험은 방문테스트로 접수되어있습니다\n셀프테스트 화면으로 이동하시겠습니까?")){
				return;
			}
		}
		
		/* alert(inst+"/"+name+"/"+prn1+"/"+prn2+"/"); */
		var f = document.form2;
		f.INST.value = inst;
		f.NAME.value = name;
		f.PRN1.value = prn1;
		f.PRN2.value = prn2;
		f.target = "_new";
		f.submit();
	}
	
	
	
	//동의화면 띄우기 및 시험시작
	function popToeflAgreeForm(gubun,inst, name, prn1, prn2, agreeYn, applynum) {
		var f = document.form2;
		var url = "";
		/* if(agreeYn=="Y"){	//동의된 상태이면 바로 이동
			url = "http://etest.chosun.com/tpo/direct_index.jsp";
		}else{
			url = "/front/ToeflF.do?cmd=popToeflAgreeForm";
		} */
		url = "/front/ToeflF.do?cmd=popToeflAgreeForm";
		popWin = Center_Fixed_Popup2("", "toeflAgreeForm", 800, 600, "no");
		f.INST.value = inst;
		f.NAME.value = name;
		f.PRN1.value = prn1;
		f.PRN2.value = prn2;
		f.APPLYNUM.value = applynum;
		f.p_moid.value = applynum;
		f.AGREEYN.value = agreeYn;
		f.action = url;
		f.target = "toeflAgreeForm";
		f.submit();
	}
	
	
	//환불요청 (2015.03.16 모의 토플 결제 시의 주의사항 기재에 따른 환불 신청버튼 삭제)
/* 	function reqRefund(applynum, testdate){
		var f = document.form2;
		
		if(f.cudate.value >= testdate){
			alert("시험시작일 이후에는 환불 불가능 합니다");
			return;
		}
		
		if (!confirm("환불요청 하시겠습니까?")) {
			return;
		}
		f.action = "/front/ToeflF.do";
		f.cmd.value = "reqRefund";
		f.p_applynum.value = applynum; 
		f.submit();		
	} */
</script>

</head>

<body>
<%
DateTimeUtil dtu = new DateTimeUtil();
String cudate = dtu.getDate();
%>
<form name="form1" id="form1" method="post">
<input type = "hidden" name="cmd" value=""/>
<input type = "hidden" name="p_paymethod" value=""/>
<input type = "hidden" name="p_tid" value=""/>





		
		
        <!-- Body -->
		<div class="board-list">
				<table width="800" border="0" cellpadding="0" cellspacing="0">
				<caption></caption>
				<colgroup>
					<col width="40" />
					<col width="" />
					<col width="100" />
					<col width="80" />
					<col width="80" />
					<col width="80" />
					<col width="70" />					
					<col width="80" />					
				</colgroup>
				<thead>
				<tr>
					<th>No.</th>
					<th>시험명</th>
					<th>시험일</th>
					<th>결제상태</th>					
					<th>결제일시</th>					
					<th>결제금액</th>
					<th>결제방식</th>					
					<th class="th_nosplit">시험</th>
				</tr>
				</thead>
				<tbody>
				<%int cnt = 0;
					if(list.getRow() > 0 ) {
						cnt = list.getRow();
						while(list.next()){%>					
							<tr><td><%=cnt%></td>
							<td><%=list.getString("TESTNM")%></td>
							<td>
							<%=FormatDate.getFormatDate(list.getString("TESTDATE").substring(0, 8), "yyyy/MM/dd") %><br />
							<%=Integer.parseInt(list.getString("TESTDATE").substring(8, 10))%>:<%=list.getString("TESTDATE").substring(10, 12)%>
							</td>
							<td>
								<%if(list.getString("RECOGSTATE").equals("Y") && list.getString("APPLYSTATE").equals("PF") && list.getString("REFUND").equals("") ){ %>
										완 료
										<%if(!list.getString("AGREEYN").equals("Y")&&list.getString("RECOGSTATE").equals("Y") && list.getString("APPLYSTATE").equals("PF")){ %>
										<!-- 2015.03.16 모의 토플 결제 시의 주의사항 기재에 따른 환불 신청버튼 삭제 -->
										<%-- <br /><a href="#" onclick="reqRefund('<%=list.getString("APPLYNUM")%>', '<%=list.getString("TESTDATE").substring(0, 8)%>')"><img src="/images/template0/common/btn_mycampus_refund.gif" alt="환불신청" /></a> --%>
										<%} %>
								<%} else if(list.getString("PAYMETHOD").equals("010000000000") && list.getString("APPLYSTATE").equals("PI") && list.getString("REFUND").equals("")){%>
										입금대기
								<%} else if(list.getString("RECOGSTATE").equals("Y") && list.getString("APPLYSTATE").equals("PF") && list.getString("REFUND").equals("R")){ %>
										환불중
								<%} else if(list.getString("RECOGSTATE").equals("Y") && list.getString("APPLYSTATE").equals("D") && list.getString("REFUND").equals("D")){ %>
										환불완료
								<%} %>								
							</td>
							<td><%=FormatDate.getFormatDate(list.getString("PAYDATE"), "yyyy/MM/dd")%></td>
							<td><%=list.getString("AMOUNT")%></td>
							<td>
							<%
							if(list.getString("PAYMETHOD").equals("100000000000")) {%>
							카 드
							<%}else if(list.getString("PAYMETHOD").equals("010000000000")) {%>
							가상계좌
							<a href="#" onclick="showAccountInfo('<%=list.getString("PAYMETHOD") %>','<%=list.getString("TID") %>');"><img src="/images/template0/common/btn_mycampus_view.gif"></a>
							<%
							}
							else if(list.getString("PAYMETHOD").equals("001000000000")) {%>
							<%	
							}
							%>						
							</td>
							<td>
								<%if(list.getString("RECOGSTATE").equals("Y") && list.getString("APPLYSTATE").equals("PF") && list.getString("REFUND").equals("")){ %>
									<%-- <a href="#" onclick="goTestStart('<%=list.getString("GUBUN")%>','ISEEN','<%=list.getString("NAME")%>','<%=list.getString("USERPRN1")%>','<%=list.getString("USERPRN2")%>')">
									시험시작
									</a> --%>
									
									<a href="#" onclick="popToeflAgreeForm('<%=list.getString("GUBUN")%>','ISEEN','<%=list.getString("NAME")%>','<%=list.getString("USERPRN1")%>','<%=list.getString("USERPRN2")%>', '<%=list.getString("AGREEYN")%>', '<%=list.getString("APPLYNUM")%>' )">
										<img src="/images/template0/common/btn_mycampus_toeflstart.gif" alt="시험시작" />
									</a>
									
								<%} %>
							</td></tr>
				<%	cnt--;
						}						
					}else{ %>
					<tr><td colspan="8">신청 내역이 없습니다</td></tr>
				<%}%>
			</tbody>
			</table>
		</div>
		<!-- //Body -->

		<!--푸터부분 시작-->
		<%-- <%@ include file = "/jsp/front/common/subBottom.jsp"%> --%>
		<!--푸터부분 끝-->
		</form>
		
		<form  name="form2" method="post" action="">
			<input type="hidden" name="INST" value="ISEEN" />
			<input type="hidden" name="NAME" value="" />
			<input type="hidden" name="PRN1" value="" />
			<input type="hidden" name="PRN2" value="" />		
			<input type="hidden" name="APPLYNUM" value="" />		
			<input type="hidden" name="p_applynum" value="" />		
			<input type="hidden" name="p_moid" value="" />		
			<input type="hidden" name="AGREEYN" value="" />		
			<input type="hidden" name="cmd" value="" />		
			<input type="hidden" name="cudate" value="<%=cudate %>" />		
		</form>
		
</body>
</html>
<!-- //Footer -->
