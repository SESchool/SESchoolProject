<%@ page contentType="text/html;charset=UTF-8" 		%>
<%@ page import ="com.sinc.framework.data.DataSet"%>
<%@ page import ="com.sinc.framework.data.Box"%>
<%@ page import ="com.sinc.framework.persist.ListDTO"%>
<%@ page import ="com.sinc.common.FormatDate"%>
<%@ page import ="com.sinc.framework.util.DateTimeUtil"%>
<%@ page import ="org.apache.commons.configuration.Configuration"%>
<%@ page import ="com.sinc.framework.configuration.ConfigurationFactory"%>
<%@ page import ="or.keris.sinc.web.lcms.common.Util"%>
<%@ include file = "/jsp/front/common/commonBasicInc.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
<%@page import="com.sinc.common.FormatDate"%>
<%@page import ="com.sinc.framework.persist.ListDTO"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
<%
	DataSet refundList = (DataSet)box.getObject("refundList");
	String v_searchtype	= box.getString("p_searchType");
	String v_year	= box.getString("p_year");
%>
<title><%=PAGETITLE%></title>
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
<fmtag:dwrcommon interfaceName="CommonUtilWork"/>
<fmtag:dwrcommon interfaceName="SubjSeqInfoFWork"/>
<script language="Javascript" src="/js/common/util.js"></script>
<script language="Javascript" >
function goSearch() {
	var f = document.form1;

	f.submit();
}
</script>
</head>

<body>
    <!-- Body -->
	<!-- Page Contents -->
	<form name="form1" action="/front/Refund.do?cmd=refundList" method="post"  onSubmit="return false;">
	<input type="hidden" name="cmd" value="refundList"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0"  bgcolor="#f8f8f8">
			<td align="left" style="border: solid 1px #e6e6e6; background-color:#f7f7f6; padding:7px;">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td align="left">
							※ 환급금액은 과정종료 후 확정되오니,<br> 하기의 금액은 변동될 수 있습니다.
						</td>
						<td align="right">
							<select name="p_searchType">
								<option value="A" <%=(v_searchtype.equals("A")?" selected":"")%>>단기</option>
								<option value="B" <%=(v_searchtype.equals("B")?" selected":"")%>>이러닝</option>
							</select>
							<select name="p_year">
								<option value="2016" <%=(v_year.equals("2016")?" selected":"")%>>2016년</option>
								<option value="2015" <%=(v_year.equals("2015")?" selected":"")%>>2015년</option>
								<option value="2014" <%=(v_year.equals("2014")?" selected":"")%>>2014년</option>
								<option value="2013" <%=(v_year.equals("2013")?" selected":"")%>>2013년</option>
								<option value="2012" <%=(v_year.equals("2012")?" selected":"")%>>2012년</option>
								<option value="2011" <%=(v_year.equals("2011")?" selected":"")%>>2011년</option>
								<option value="2010" <%=(v_year.equals("2010")?" selected":"")%>>2010년</option>
								<option value="2009" <%=(v_year.equals("2009")?" selected":"")%>>2009년</option>
								<option value="2008" <%=(v_year.equals("2008")?" selected":"")%>>2008년</option>
							</select>
							&nbsp;
							<a href="#" onclick="goSearch();">
								<img src="/images/template0/common/btn_search_common.gif" align="absmiddle" alt="검색" />
							</a>
							&nbsp;
						</td>
					</tr>
				</table>						
			</td>
		</tr>					
		</table>					

		<div class="board-list<%=G_HGRCODE.equals("0")?"-"+G_IMGID:"" %>">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<caption></caption>
			<colgroup >
				<col width="80" />
				<col width="80" />
				<col width="" />
				<col width="80" />
				<col width="75" />
				<%if(!v_searchtype.equals("B")){ %>
				<col width="75" />
				<%} %>
				<col width="100" />
			</colgroup>
			<thead>
			<tr>
				<th>과정구분</th>
				<th>과정기수</th>
				<th>과정명</th>
				<th>교육기간</th>
				<th>대기업
				<%if(!v_searchtype.equals("B")){ %>
				<br />(1000인↑)</th>
				<th>대기업<br />(1000인↓)
				<%} %>
				</th>
				<th class="th_nosplit">우선지원기업</td>
			</tr>
			</thead>
			<tbody>
			<%
      		if(refundList != null && refundList.getRow() > 0){
      			while(refundList.next()){
	      	%>	
			<tr>
				<td class="td_center"><%=refundList.getString("TR_NM") %></td>
				<td class="td_center"><%=refundList.getString("SUBJSEQGR") %></td>
				<td class="td_left"><%=refundList.getString("SUBJNM") %></td>
				<td class="td_center"><%=Util.getMonthBetween(refundList.getString("EDUSTART"), refundList.getString("EDUEND"))%></td>
				<td class="td_left"><%=Util.makeComma(refundList.getString("GOYONGPRICE"))%>
				<%if(!v_searchtype.equals("B")){ %>
				</td>
				<td class="td_left"><%=Util.makeComma(refundList.getString("GOYONGPRICE2"))%>
				<%} %>
				</td>
				<td class="td_left"><%=Util.makeComma(refundList.getString("SGOYONGPRICE"))%></td>
			</tr>
			<% }
      		} else {%>
      		<tr>
      			<td colspan="6">조회된 내역이 없습니다.</td>
      		</tr>
      		<% }%>
			</tbody>
			</table>
		</div>
	</form>
	<!-- //Body -->
</body>
</html>
<!-- //Footer -->
