<%--
 * @(#)Sample Template
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * Template.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2009. 12. 09.  jangcw       Initial Release
 ************************************************
--%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.sinc.framework.data.DataSet"%>
<%@page import="com.sinc.framework.persist.ListDTO"%>
<%@ include file = "/jsp/front/common/commonInc.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" 		%>
<%
	ListDTO listDto = (ListDTO)box.getObject("ListData");
	String v_nowpoint = box.getString("nowpoint");	
	DecimalFormat df = new DecimalFormat("#,###,##0");
	String nowpoint = df.format(Double.parseDouble(v_nowpoint));
%>
<title><%=PAGETITLE%></title>
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
<script type="text/javascript">
<!--
	function bbsBoardList() {
		var f = document.form1;
		f.action	= "/front/Mileage.do";
	    f.cmd.value = "mileageHistoryList";
		f.submit();
	}
	function goPage(page,type){
		var f = document.form1;
	   	f.p_pageno.value = page;
	   	bbsBoardList();
	}
//-->
</script>
<form name="form1" action="/front/Mileage.do" method="post" onSubmit="return false;">
<input type="hidden" name="cmd" value="bbsBoardPageList"/>
<input type="hidden" name="p_pageno" value="<%=box.getString("p_pageno")%>" />
			<!-- Page Contents -->

			<table width="100%" cellpadding="0" cellspacing="0" class="mar_top_10">
			<tr>
				<td align="center" style="border: solid 1px #e6e6e6; background-color:#f7f7f6; padding:6px 6px 6px 20px;">
					<table width="100%" cellpadding="0" cellspacing="0">
					<colgroup>
						<col width="85" />
						<col width="70" />
						<col width="" />
					</colgroup>
					<tr>
						<td><img src="/images/template0/common/txt_mileage_1.gif" alt="마일리지 내역"></td>
						<td style="color:#178f9d; font-weight:bold; font-size:14px;"><%= nowpoint %>M</td>
						<td style="border:solid 1px #e6e6e6; padding:7px 15px 6px 15px; background-color:#FFFFFF;">
							&nbsp;
							<!--
							<table cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="/images/template0/common/txt_mileage_2.gif"></td>
								<td style="padding-left:7px; color:#178f9d;">500M</td>
								<td style="padding-left:30px;"><img src="/images/template0/common/txt_mileage_3.gif"></td>
								<td style="padding-left:7px; color:#178f9d;">500M</td>
								<td style="padding-left:30px;"><img src="/images/template0/common/txt_mileage_4.gif"></td>
								<td style="padding-left:7px; color:#178f9d;">500M</td>
							</tr>
							</table>
							 -->
						</td>
					</tr>
					</table>
				</td>
			</tr>
			</table>

			<table width="100%" cellpadding="0" cellspacing="0" style="margin-top:20px;">
			<tr>
				<td><img src="/images/template0/common/menu9_4_label02.gif" alt="마일리지 내역"></td>
			</tr>
			</table>

			<div class="board-list">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<caption></caption>
				<colgroup>
					<col width="60" />
					<col width="100" />
					<col width="100" />
					<col width="" />
					<col width="100" />
					<col width="100" />
				</colgroup>
				<thead>
				<tr>
					<th>No</th>
					<th>날짜</th>
					<th>분류</th>
					<th>내용</th>
					<th>마일리지내역</th>
					<th class="th_nosplit">잔여마일리지</td>
				</tr>
				</thead>
				<tbody>
				<%
					DataSet ds1 = null;
					if(listDto != null) {
						ds1 = listDto.getItemList();
					}
					int listNum = 0;
					if ( ds1 != null && ds1.getRow() > 0 ) {
						listNum = listDto.getStartPageNum();
						while ( ds1.next() ) {
				%>
				<tr height="30">
					<td><%=listNum--%></td>
					<td><%=DateTimeUtil.getDateText(1,ds1.getString("USEDATE"),"-") %></td>
					<td><%=ds1.getString("USE") %></td>
					<td><%=ds1.getString("USECONTENT") %></td>
					<td><%=new DecimalFormat("#,###,##0").format(Double.parseDouble(ds1.getString("POINT"))) %></td>
					<td><%=new DecimalFormat("#,###,##0").format(Double.parseDouble(ds1.getString("RESTANTPOINT"))) %></td>
				</tr>
				<%
						}
					}
				%>
				</tbody>
				</table>
			</div>

			<!-- 페이지 -->
			<table width="100%" cellpadding="0" cellspacing="0" class="mar_top_10">
			<tr align="center">
				<td><% if(listDto != null) out.print(listDto.getPagging("goPage")); %></td>
			</tr>
			</table>


			<!-- //Page Contents -->

</form>