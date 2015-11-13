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

	function goLecture(subj, year, subjseq){
	   <% if(v_studycontrol.equals("0")){ %>
       alert("학습 제약 시간이므로 학습을 진행할 수 없습니다.\n많은 양해 부탁드립니다.");
       return;
        <% } %>

    	var url = "/front/MyClass.do?cmd=classroomMain&p_subj="+subj+"&p_year="+year+"&p_subjseq="+subjseq;
    	Center_Fixed_Popup2(url, "GoLecture", 870, 900, "no");
    	//강의실입장시 팝업공지
    	window.open("/jsp/front/common/course/info_Lecture.jsp","GoLecturePopNotice","width=540, height=800, resizable=no, scrollbars=yes, status=no;");
    }

    function goOutLecture(subj, year, subjseq, cpsubj, cpsubjseq, edustart, eduend){
 	   <% if(v_studycontrol.equals("0")){ %>
       alert("학습 제약 시간이므로 학습을 진행할 수 없습니다.\n많은 양해 부탁드립니다.");
       return;
        <% } %>

        var url = "/front/Propose.do?cmd=cpSubjectLink" + "&p_subj=" + subj + "&p_year=" + year  + "&p_subjseq=" + subjseq + "&p_cpsubj=" + cpsubj + "&p_cpsubjseq="+ cpsubjseq + "&p_edustart=" + edustart + "&p_eduend=" + eduend;
    	Center_Fixed_Popup2(url, "_blank", 900, 720, "yes");

    }
</script>
</head>

<body>
<div class="board-list<%=G_HGRCODE.equals("0")?"-"+G_IMGID:"" %>">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<caption></caption>
	<colgroup>
		<col width="30" />
		<col width="60" />
		<col width="" />
		<col width="40" />
		<col width="130" />
		<!-- 평가 <col width="40" />
		과제<col width="40" />-->
		<col width="40" />
		<col width="60" />
	</colgroup>
	<thead>
	<tr>
		<th>No</th>
		<th>교육형태</th>
		<th>과정명</th>
		<th>차수</th>
		<th>교육기간</th>
		<!-- <th>평가</th>
		<th>과제</th> -->
		<th>진도율</th>
		<th class="th_nosplit">강의실</th>
	</tr>
	</thead>
	<tbody>
<%
	String v_subjtype = null;
	String v_finishtreatrule = null;
	String v_test = null;
	String v_proj = null;
	String v_step = null;
	String v_status = null;
	String v_idx = null;
	String v_recogstate = null;
	int num = 0;
	String viewnum = "";
	String bgcolor = "";

	while ( list != null && list.next() ) {
		v_subjtype = list.getString("SUBJTYPE");
		
		v_recogstate = list.getCurBox().get("RECOGSTATE");
		
		v_finishtreatrule = list.getString("FINISHTREATRULE");
		/*
		if ( list.getString("OUTSOURCINGTYPE").equals("02") ) {
			v_status = "<a href=\"javascript:goOutLecture('"+list.getString("CSUBJ")+"','"+list.getString("CYEAR")+"','"+list.getString("CSUBJSEQ")+"','"+list.getString("CPSUBJ")+"','"+list.getString("CPSUBJSEQ")+"','"+list.getString("EDUSTART")+"','"+list.getString("EDUEND")+"')\"><img src=\"/images/common/btn_lecture_join.gif\" alt=\"강의실입장\" /></a>";
		} else  {
			v_status = "<a href=\"javascript:goLecture('"+list.getString("CSUBJ")+"','"+list.getString("CYEAR")+"','"+list.getString("CSUBJSEQ")+"')\"><img src=\"/images/template0/common/btn_lecture_open.gif\" alt=\"강의실입장\" /></a>";
		}
		*/
		v_status = "<a href=\"javascript:goLecture('"+list.getString("CSUBJ")+"','"+list.getString("CYEAR")+"','"+list.getString("CSUBJSEQ")+"')\"><img src=\"/images/template0/common/btn_lecture_open.gif\" alt=\"강의실입장\" /></a>";

		v_test = "<span style='color:#399fb1;'>"+list.getString("EXAMAPPLYCNT")+"</span>"+ "/" + list.getString("EXAMCNT");
		v_proj = "<span style='color:#399fb1;'>"+list.getString("PROJAPPLYCNT")+"</span>"+ "/" + list.getString("PROJCNT");
		v_step = list.getString("TSTEP") + "%";

		//bgcolor = "bgcolor=\"#e8fcff\"";
		//bgcolor = "bgcolor=\"#fffee8\"";
		
%>
	<tr height="25" <%=bgcolor %>>
		<!-- td><%=viewnum %></td-->
		<td><%=++num%></td>
		<td><%=list.getString("ISONOFFNM") %></td>
		<td><%=list.getString("SUBJNM") %></td>
		<td><%=list.getString("SUBJSEQGR")%></td>
		<td><%=list.getString("EDUDATE")%></td>
		<!--<%=v_test%>
		<%=v_proj%> -->
		<td><span style="color:#e78000;"><%=v_step%></span></td>
<%
		/*
			2011.11.9 사이버연수유닛 요청
			결제상태가 환불요청(R), 환불처리중(P), 환불완료확인(D) 상태일때도 강의실 입장을 못하게 한다.
		*/ 
		if (v_recogstate.equals("R") || v_recogstate.equals("P") || v_recogstate.equals("D")) {%>
			<td class="th_nosplit">환불</td>
<% 		} else {%>
			<td class="th_nosplit"><%=v_status%></td>
<%		} %>
	</tr>
<%	}  %>
<%	if ( list == null || list.getRow() == 0 ) { %>
	<tr>
	  <td height="25" colspan="15" align="center" style="text-align:center">내역이 없습니다.</td>
	</tr>
<%	} %>
	</tbody>
	</table>
</div>

</body>
</html>
<!-- //Footer -->