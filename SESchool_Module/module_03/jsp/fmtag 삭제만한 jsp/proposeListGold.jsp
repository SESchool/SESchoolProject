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
 * 2011. 03. 24.  bgcho       Initial Release
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
	function goLecture(subj, year, subjseq){
	   <% if(v_studycontrol.equals("0")){ %>
       alert("학습 제약 시간이므로 학습을 진행할 수 없습니다.\n많은 양해 부탁드립니다.");
       return;
        <% } %>

    	var url = "/front/MyClass.do?cmd=classroomMain&p_subj="+subj+"&p_year="+year+"&p_subjseq="+subjseq;
    	Center_Fixed_Popup2(url, "GoLecture", 870, 720, "no");
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
		<col width="" />
		<col width="150" />
		<col width="100" />
	</colgroup>
	<thead>
	<tr>
		<th>No</th>
		<th>코스명</th>						
		<th>교육기간</th>
		<th class="th_nosplit">나의강의실</th>
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
	int num = 0;
	String viewnum = "";
	String bgcolor = "";

	while ( list != null && list.next() ) {
		v_subjtype = list.getString("SUBJTYPE");
		v_finishtreatrule = list.getString("FINISHTREATRULE");

		if ( list.getString("OUTSOURCINGTYPE").equals("02") ) {
			v_status = "<a href=\"javascript:goOutLecture('"+list.getString("CSUBJ")+"','"+list.getString("CYEAR")+"','"+list.getString("CSUBJSEQ")+"','"+list.getString("CPSUBJ")+"','"+list.getString("CPSUBJSEQ")+"','"+list.getString("EDUSTART")+"','"+list.getString("EDUEND")+"')\"><img src=\"/images/common/btn_lecture_join.gif\" alt=\"강의실입장\" /></a>";
		} else  {
			v_status = "<a href=\"javascript:goLecture('"+list.getString("CSUBJ")+"','"+list.getString("CYEAR")+"','"+list.getString("CSUBJSEQ")+"')\"><img src=\"/images/template0/common/btn_lecture_open.gif\" alt=\"강의실입장\" /></a>";
		}

		v_test = "<span style='color:#399fb1;'>"+list.getString("EXAMAPPLYCNT")+"</span>"+ "/" + list.getString("EXAMCNT");
		v_proj = "<span style='color:#399fb1;'>"+list.getString("PROJAPPLYCNT")+"</span>"+ "/" + list.getString("PROJCNT");
		v_step = list.getString("TSTEP") + "%";

		//bgcolor = "bgcolor=\"#e8fcff\"";
		//bgcolor = "bgcolor=\"#fffee8\"";
		
%>
	<tr height="25" <%=bgcolor %>>
		<td><%=++num%></td>
		<td><%=list.getString("SUBJNM") %></td>
		<td><%=StringUtil.ReplaceAll(list.getString("EDUDATE"),"~"," ~ ")%></td>
		<td class="th_nosplit"><%=v_status%></td>
	</tr>
<%	}  %>
<%	if ( list == null || list.getRow() == 0 ) { %>
	<tr>
	  <td height="25" colspan="4" align="center" style="text-align:center">내역이 없습니다.</td>
	</tr>
<%	} %>
	</tbody>
	</table>
</div>
</body>
</html>
<!-- //Footer -->