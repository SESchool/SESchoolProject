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
 * 2010. 11. 21.  bgcho       Initial Release
 ************************************************
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.sinc.common.FormatDate" %>
<%@ include file = "/jsp/front/common/commonInc.jsp" %>
<%
	DataSet list = (DataSet)box.getObject("proposeList");
	//학습 제한 여부를 가져온다.
	String v_studycontrol= box.getStringDefault("StudyControl","1");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
<title><%=PAGETITLE%></title>
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
<script type="text/javascript">
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

	function goSearch() {
		var form = document.form1;
		form1.submit();
	}

	function goLecture(subj, year, subjseq){
	   <% if(v_studycontrol.equals("0")){ %>
       alert("학습 제약 시간이므로 학습을 진행할 수 없습니다.\n많은 양해 부탁드립니다.");
       return;
        <% } %>

    	var url = "/front/MyClass.do?cmd=classroomMain&p_subj="+subj+"&p_year="+year+"&p_subjseq="+subjseq;
    	Center_Fixed_Popup2(url, "GoLecture", 870, 900, "no");
    }

	function goOutLecture(subj, year, subjseq, cpsubj, cpsubjseq, edustart, eduend){
       <% if(v_studycontrol.equals("0")){ %>
      alert("학습 제약 시간이므로 학습을 진행할 수 없습니다.\n많은 양해 부탁드립니다.");
      return;
       <% } %>

	    var url = "/front/Propose.do?cmd=cpSubjectLink" + "&p_subj=" + subj + "&p_year=" + year  + "&p_subjseq=" + subjseq + "&p_cpsubj=" + cpsubj + "&p_cpsubjseq="+ cpsubjseq + "&p_edustart=" + edustart + "&p_eduend=" + eduend;
    	Center_Fixed_Popup2(url, "_blank", 900, 720, "yes");

    }

	function goOldLecture(subj, year, subjseq) {
       <% if(v_studycontrol.equals("0")){ %>
       alert("학습 제약 시간이므로 학습을 진행할 수 없습니다.\n많은 양해 부탁드립니다.");
       return;
        <% } %>

        var url = "http://learning.shinsegae.com/jsp/user/study/edulink_go.jsp?p_userid=<%=box.getString("s_userid")%>&p_subj="+subj+"&p_year="+year+"&p_subjseq="+subjseq;
    	window.open(url, "GoOldLecture","toolbar=no, location=no, directories=no, menubar=no, resizable=no, scrollbars=yes, status=yes width=900 height=720");
    	//Center_Fixed_Popup2(url, "GoOldLecture", 900, 720, "no");
    //	GoOldLecture.focus();
	}
    function viewTotalResult() {
  		 var url = "/front/Propose.do?cmd=proposeTotalResult";
		Center_Fixed_Popup2(url, "popTotalResult", 760, 540, "yes");
    }
	//수료증 출력
	function certificateReportFPopup(subjseq, subjnm, isgraduated){
		var f = document.form1;
		//if( !ozValidateEtc(f)) return;
		if( isgraduated != 'Y' ){
			alert("수료 처리가 되지 않았습니다.");
			return;
		}
		/*
		var v_width = "800";
		var v_height = "600";

		Center_Fixed_Popup2("", "certificateReportFPopup", v_width, v_height, "no");

        f.p_subjseq.value = subjseq;
        f.p_subjnm.value = subjnm;
		f.action = "/front/Propose.do";
		f.cmd.value = "certificateReportFPopup";
		f.method = "post";
		f.target = "certificateReportFPopup";

		f.submit();
		*/
		window.open("http://webdocu.kita.net/", "webdocu", "", "");
	}
	
	
	//수료증 출력(b2b과정 직접 수료증 출력기능)
	function certificateReportFPopup2(userid, subj, year, subjseq, isgraduated){
		var f = document.form2;
		//if( !ozValidateEtc(f)) return;
		if( isgraduated != 'Y' ){
			alert("수료 처리가 되지 않았습니다.");
			return;
		}
		
		alert("수료증 발급되었어용 뿌잉");
		Center_Fixed_Popup2("about:blank", "PersonalCertificatePop", 540, 768, "yes");
		f.p_personinfo.value = userid+"/"+subj+"/"+year+"/"+subjseq+"/"+isgraduated;
		f.action = "/front/Finish.do";
		f.target = "PersonalCertificatePop";
		f.cmd.value = "certificatePop";
		f.submit();		
	}
	/* 
	function personalCertificationPop(userid, subj,year,subjseq,isgraduate){
		var f				=	document.form1;
		var pop = Center_Fixed_Popup2("about:blank", "PersonalCertificatePop", 540, 768, "yes");		
		f.p_personinfo.value = userid+"/"+subj+"/"+year+"/"+subjseq+"/"+isgraduate;
	   	f.action = "/back/Finish.do";
	    f.target = "PersonalCertificatePop";
    	f.cmd.value = "certificatePop";
    	f.p_type.value = "p";
    	f.submit();
	    f.action = "/back/Finish.do";
	    f.target = "";
	    f.cmd.value = "subjectList";
	    f.p_type.value = "";
	} */
	
</script>
</head>
<body>
<form name="form1" id="form1" method="post" onSubmit="return proposeWrite()">
<input type="hidden" name="cmd" value="proposeList" />
<input type="hidden" name="type" value="done" />
<input type="hidden" name="p_compnm" value=""/>
<input type="hidden" name="p_subjseq" value="" />
<input type="hidden" name="p_subjnm" value="" />
<input type="hidden" name="p_personinfo" value="" />

<table width="100%" cellpadding="0" cellspacing="0">
<tr>
	<td align="right">
		<a href="#none" onclick="viewTotalResult()"><img src="/images/template0/common/btn_total_result.gif"></a>

		<select name="p_gyear" style="width:80px;" onchange="goSearch()">
		<option value="">교육년도</option>
		<%=CommonUtil.getYearOption("", "", box.getString("p_gyear"), false)%>
		</select>
		<%=CommonUtil.getCodeListBoxWithOption("select","0001","p_isonoff",box.getString("p_isonoff"),"goSearch()","교육구분","style='width:80px'")%>
	</td>
</tr>
</table>

<div class="board-list-2line">
<!-- div class="board-list<%=G_HGRCODE.equals("0")?"-"+G_IMGID:"" %>line"-->
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<caption></caption>
	<colgroup>
		<col width="30" />
		<col width="60" />
		<col width="" />
		<col width="40" />
		<col width="80" />
		<col width="30" />
		<col width="30" />
		<col width="30" />
		<col width="30" />
		<col width="30" />
		<col width="30" />
		<col width="50" />
		<col width="50" />
	</colgroup>
	<thead>
	<!-- <tr><td height="5" colspan="13"></td></tr> -->
	<tr>
		<th rowspan="2" valign="top" style="padding-top: 9px">No</th>
		<th rowspan="2" valign="top" style="padding-top: 9px">구분</th>
		<th rowspan="2" valign="top" style="padding-top: 9px">과정명</th>
		<th rowspan="2" valign="top" style="padding-top: 9px">차수</th>
		<th rowspan="2" valign="top" style="padding-top: 9px">복습기간</th>
		<th colspan="4" valign="top" style="padding-top: 9px">평가항목</th>
		<th rowspan="2" valign="top" style="padding-top: 9px">성적</th>
		<th rowspan="2" valign="top" style="padding-top: 9px">수료</th>
		<th rowspan="2" valign="top" style="padding-top: 9px">강의실</th>
		<th rowspan="2" valign="top" class="th_nosplit" style="padding-top: 9px">수료증</th>
	</tr>
	<tr valign="top">
		<th class="th_graytxt" style="padding-bottom: 10px">진도</th>
		<th class="th_graytxt" style="padding-bottom: 10px">중간</th>
		<th class="th_graytxt" style="padding-bottom: 10px">최종</th>
		<th class="th_graytxt" style="padding-bottom: 10px">과제</th>
	</tr>
	<!-- <tr><td height="5" colspan="13"></td></tr> -->
	</thead>
	<tbody>
<%
	String v_trainingclass = "";
	String v_subjtype = null;
	String v_finishtreatrule = null;
	String v_test = null;
	String v_proj = null;
	String v_step = null;
	String v_reviewlink = null;
	String v_idx = null;
	int num = 0;
	String viewnum = "";
	String bgcolor = "";

	while ( list != null && list.next() ) {
		v_trainingclass = list.getString("TRAININGCLASS");
		v_subjtype = list.getString("SUBJTYPE");
		v_finishtreatrule = list.getString("FINISHTREATRULE");

		if ( v_subjtype.equals("C") ) {
			/*
			if ( list.getString("OUTSOURCINGTYPE").equals("02") ) {
				v_reviewlink = "<a href=\"javascript:goOutLecture('"+list.getString("SUBJ")+"','"+list.getString("YEAR")+"','"+list.getString("SUBJSEQ")+"','"+list.getString("CPSUBJ")+"','"+list.getString("CPSUBJSEQ")+"','"+list.getString("EDUSTART")+"','"+list.getString("EDUEND")+"')\"><img src=\"/images/template0/common/btn_lecture_restudy.gif\" alt=\"복습\" /></a>";
			} else  {
				v_reviewlink = "<a href=\"javascript:goLecture('"+list.getString("SUBJ")+"','"+list.getString("YEAR")+"','"+list.getString("SUBJSEQ")+"')\"><img src=\"/images/template0/common/btn_lecture_restudy.gif\" alt=\"복습\" /></a>";
			}
			*/
			if ( v_trainingclass.equals("11") ) {
				v_reviewlink = "";
			} else {
				v_reviewlink = "<a href=\"javascript:goLecture('"+list.getString("SUBJ")+"','"+list.getString("YEAR")+"','"+list.getString("SUBJSEQ")+"')\"><img src=\"/images/template0/common/btn_lecture_restudy.gif\" alt=\"복습\" /></a>";
			}
		} else {
			v_reviewlink = "";
		}
%>
	<tr height="30">
		<td><%=++num %></td>
		<td><%=list.getString("ISONOFFNM") %></td>
		<td><%=list.getString("SUBJNM") %></td>
		<td><%=list.getString("SUBJSEQGR")%></td>
		<%if(v_trainingclass.equals("01")){ %>
			<td>-</td>
		<%}else{ %>
			<td><%=list.getString("REVIEWSTART") %> ~ <%=list.getString("REVIEWEND") %></td>
		<%} %>
		<td><%=list.getString("TSTEP") %></td>
		<td><%=list.getString("MTEST") %></td>
		<td><%=list.getString("FTEST") %></td>
		<td><%=list.getString("REPORT") %></td>
		<td><%=list.getString("SCORE") %></td>
		<td><%=list.getString("ISGRADUATED") %></td>
		<td><%=v_reviewlink%></td>
		<td align="center">
		
		<%	//btob일경우 수료증 출력버튼 출력안함
		if(box.getString("p_btobyn").equals("Y")){ %>
			<%if(box.getString("p_certificates").equals("Y")) {	//위탁고객사관리의 수료증 여부가 Y 일경우 KITA수료증발급이 아닌 직접 발급 기능 이용 가능
			%>
			<a href="javascript:certificateReportFPopup2('<%=box.getString("s_userid") %>','<%=list.getString("SUBJ") %>','<%=list.getString("YEAR") %>','<%=list.getString("SUBJSEQ") %>', '<%=list.getString("ISGRADUATED") %>')"><img src="/images/template0/common/btn_lecture_print.gif" alt="출력" /></a>
			<%}else{ //수료증 발급 버튼 출력 안함%>
				
			<%} %>
		<%}else{ %>
		<a href="javascript:certificateReportFPopup('<%=list.getString("SUBJSEQ") %>', '<%=list.getString("SUBJNM") %> ', '<%=list.getString("ISGRADUATED") %>')"><img src="/images/template0/common/btn_lecture_print.gif" alt="출력" /></a>
		<%} %>
		</td>
	</tr>
<%	}  %>
<%	if ( list == null || list.getRow() == 0 ) { %>
	<tr>
	  <td height="30" colspan="13" align="center" style="text-align:center">내역이 없습니다.</td>
	</tr>
<%	} %>
	</tbody>
	</table>
</div>

</form>

<form action="" name="form2" method="post">
	<input type="hidden" name="cmd" value="" />
	<input type="hidden" name="p_personinfo" value="" />
</form>

</body>
</html>
<!-- //Footer -->