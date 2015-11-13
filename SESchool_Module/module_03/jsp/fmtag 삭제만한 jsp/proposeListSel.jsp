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
    function goContentsShow ( v_contsid, v_itemid ) {
		var f = document.form1;
		
		var url = "/front/Contents.do?cmd=selectedOpenContentsFrame&p_contsid="+v_contsid+"&p_itemid="+v_itemid;
		Contents_Popup2(url, "CourseContents", '1024','700');
	}
</script>
</head>

<body>
<div class="board-list<%=G_HGRCODE.equals("0")?"-"+G_IMGID:"" %>">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<caption></caption>
	<colgroup>						
		<col width="" />
		<col width="80" />
		<col width="130" />
		<col width="80" />
	</colgroup>
	<thead>
	<tr>
		<th>선택 강의명</th>						
		<th>수강신청일</th>
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
	
	String v_title = null;
	String v_appdate = null;
	String v_edudate = null;
	int v_depth = 0;
	int v_depth1_idx = 0;
	int v_depth2_idx = 0;
	int v_depth3_idx = 0;
	int num = 0;
	String viewnum = "";
	String bgcolor = "";
	String tdstyle = "";

	while ( list != null && list.next() ) {
		int depth = list.getInt("DEPTH");
		if ( depth == 1 ) {
			v_depth1_idx++;
			v_depth2_idx = 0;
			v_depth3_idx = 0;
			viewnum = ""+v_depth1_idx;
			v_status = "";
			bgcolor = "bgcolor=\"#cccccc\"";
		} else if ( depth == 2 ) {
			v_depth2_idx++;
			v_depth3_idx = 0;
			viewnum = "&nbsp;&nbsp;&nbsp;"+v_depth2_idx;
			bgcolor = "bgcolor=\"#eeeeee\"";
			v_status = "";
		} else if ( depth == 3 ) {
			v_depth3_idx++;
			viewnum = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+v_depth3_idx;
			bgcolor = "bgcolor=\"#fffee8\"";			
			v_status = "<a href=\"javascript:goContentsShow('"+list.getString("CONTSID")+"','"+list.getString("ITEMID")+"')\"><img src=\"/images/common/btn_lecture_join.gif\" alt=\"강의실입장\" /></a>";
		}
%>
	<tr height="25" <%=bgcolor %>>
		<td style="text-align:left;font-family:돋움; font-size:12px; padding:0 0 0 <%=(depth==1)?"20":"40" %>;"><img src="/images/template0/common/bullet_leftmenu_<%=(depth==1)?"on":"off" %>.gif"/>&nbsp;&nbsp;<%=list.getString("TITLE") %></td>
		<td><%=list.getString("APPDATE") %></td>
		<td><%=list.getString("EDUDATA") %></td>
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