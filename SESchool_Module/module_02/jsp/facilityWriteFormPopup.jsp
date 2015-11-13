<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file = "/jsp/back/common/commonInc.jsp" %>
<%@ page import ="com.sinc.common.CodeParamDTO" %>
<%
	Box boxFacility = (Box)box.getObject("boxFacility");
	String v_gubun = StringUtil.nvl( boxFacility.getString("GUBUN"), "" );
	String v_facilnm = StringUtil.nvl( boxFacility.getString("FACILNM"), "" );
	String v_capacity = StringUtil.nvl( boxFacility.getString("CAPACITY"), "" );
	String v_area = StringUtil.nvl( boxFacility.getString("AREA"), "" );
	String v_owner = StringUtil.nvl( boxFacility.getString("OWNER"), "" );
	
	String v_post = StringUtil.nvl( boxFacility.getString("POST"), "");
	String v_post1 = "";
	String v_post2 = "";
	
	if( !StringUtil.isNull(v_post) && !v_post.equals("-") ){
		if( v_post.contains("-") ){
			v_post1 = v_post.substring(0, 3);
			v_post2 = v_post.substring(4, 7);
		} else if( v_post.length() > 5 ){
			v_post1 = v_post.substring(0, 3);
			v_post2 = v_post.substring(3, v_post.length());
		} else {
			v_post1 = v_post;
			v_post2 = "";
		}
	} else {
		v_post1 = "";
		v_post2 = "";
	}

	String v_addr = StringUtil.nvl( boxFacility.getString("ADDR"), "" );
	String v_facildesc = StringUtil.nvl( boxFacility.getString("FACILDESC"), "" );
	
	String v_facilno = box.getString("p_facilno");
	String v_process = box.getString("p_process");
	String v_comp = box.getString("p_comp");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>::: 한국무역협회 무역아카데미 ::: 관리자페이지</TITLE>
<META http-equiv=Content-Type content="text/html; charset=UTF-8"> 
<fmtag:csscommon point="back" />
<fmtag:jscommon />
<script type="text/javascript" src="/js/common/popupbox.js"></script>
<script type="text/javascript">
	function facilityWrite(v_process) {
		
		var f = document.form1;
		
		if ( !selectBoxCheck(f.p_gubun) ) {
			alert ( "시설구분을 선택해 주십시요" );
			return;
		}
		if(!validate(form1)) return;
		
		f.p_post.value = f.p_post1.value +"-"+ f.p_post2.value;
		f.p_process.value = v_process;
		f.submit();
	}
	function selectBoxCheck ( formObject ) {
		var slIdx = formObject.selectedIndex;
		var opt = formObject.options[ slIdx ];
		if ( opt.value == "" ) {
			return false;
		} else {
			return true;
		}
	}
	//우편번호 검색
	function searchZipCode(objname) {
		var url = "/front/Common.do?cmd=selectZipCode&p_objname="+objname; 
		Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
	}
	//우편번호 팝업창에서 우편번호 받아오기..
	function setZipCodeInfo(objname, addr, zipcode) {	
		var form = document.form1;

	    if ( objname == "user" ) {
			form.p_addr.value = addr;
			form.p_post1.value = zipcode.substr(0, 3);
			form.p_post2.value = zipcode.substr(4, 7);
	    }
	}
</script>
</HEAD>
<body style="background-image:url('/images/popup_bg.gif');">
<form name="form1" action="/back/Facility.do" method="post" onSubmit="return false;">
<input type="hidden" name="cmd" value="facilityWrite" />
<input type="hidden" name="p_comp" value ="<%=v_comp %>" />
<input type="hidden" name="p_process" value="<%=v_process %>" />
<input type="hidden" name="p_facilno" value="<%=v_facilno %>" />
<input type="hidden" name="p_post" value="" />
<table width="800" cellpadding="0" cellspacing="0">
<tr>
	<td align="center">
		<!-- 메뉴명 -->
		<table width="760" cellpadding="0" cellspacing="0" class="mar_top_10">
		<colgroup>
			<col width="10" />
			<col width="" />
			<col width="15" />
		</colgroup>
		<tr>
			<td><img src="/images/back/common/bullet_title.gif"></td>
			<td class="t_title">시설등록</td>
		</tr>
		</table>
		<!-- // -->
 
		<!-- 입력폼 -->
		<div class="board-view">
			<table width="760" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="100" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="th_top_bd">구분</th>
				<td class="td_top_bd">
				<%=CommonUtil.getCodeListBox("select","0045","p_gubun",v_gubun,null,"-전체-")%>
				</td>
			</tr>
			<tr>
				<th>시설명</th>
				<td>
					<input name="p_facilnm" type="text" size="100" dispName="시설명" isNull="N" lenCheck="100" maxLength="100" value="<%=v_facilnm%>"/>
				</td>
			</tr>
			<tr>
				<th>정원</th>
				<td>
					<input name="p_capacity" type="text" size="30" dataType="integer" dispName="정원" isNull="Y" lenCheck="4" maxLength="4" value="<%=v_capacity%>"/>명
				</td>
			</tr>
			<tr>
				<th>면적</th>
				<td>
					<input name="p_area" type="text" size="30" dataType="integer" dispName="면적" isNull="Y" lenCheck="5" maxLength="5" value="<%=v_area%>"/>(m2)
				</td>
			</tr>
			<tr>
				<th>소유</th>
				<td>
					<input name="p_owner" type="text" size="30" dispName="소유" isNull="Y" lenCheck="30" maxLength="30" value="<%=v_owner%>"/>
				</td>
			</tr>
			<tr>
				<!-- th>소재지 주소</th>
				<td>
					<input name="p_post" type="text" size="15" dispName="우편번호" isNull="Y" lenCheck="7" maxLength="7" value="<//%=v_post%>"/>
					<br/>
					<input name="p_addr" type="text" size="100" dispName="소재지주소" isNull="Y" lenCheck="80" maxLength="80" value="<//%=v_addr%>"/>
				</td -->
				
				<th>소재지 주소</th>
				<td colspan="3" style="padding-top:5px; padding-bottom:5px;">

	            <% if( v_post2 == null || v_post2.equals("")){ %>
					<input type="text" name="p_post1" dispName="우편번호" isNull="Y" maxLength="5" dataType="number" value="<%=v_post1 %>" style="width:60" readonly="readonly">
                	<input type="hidden" name="p_post2" dispName="우편번호" value="<%=v_post2 %>" >
				<% } else { %>
					<input type="text" name="p_post1" dispName="우편번호" isNull="Y" maxLength="5" dataType="number" value="<%=v_post1 %>" style="width:60" readonly="readonly">&nbsp;-
                	<input type="text" name="p_post2" dispName="우편번호" value="<%=v_post2 %>" style="width:60" readonly="readonly">
				<% } %>
	                &nbsp;<a href="#none" onclick="searchZipCode('user')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a>
	     			<br/>
					<input name="p_addr" type="text" size="100" dispName="소재지주소" isNull="Y" lenCheck="80" maxLength="80" value="<%=v_addr%>"/>
	     		</td>
			</tr>
			<tr>
				<th>설명</th>
				<td>
					<textarea name="p_facildesc" cols="70" rows="10" dispName="설명" isNull="Y" lenCheck="1000" maxLength="1000"><%=v_facildesc%></textarea>
				</td>
			</tr>
			</table>
		</div>
		<!-- // -->
 
		<!-- 버튼 -->
		<table width="300" cellpadding="0" cellspacing="0" class="mar_top_10">
		<tr>
		  <td align="center">
			<table cellpadding="0" cellspacing="0">
			  <tr>
			  	<td>
<%
	if ( s_menucontrol.equals("RW") ) {
		if ( v_process.equals("W") ) {
%>
					<fmtag:button type="1" value="등록" func="facilityWrite('W')" />
<%
		} else if ( v_process.equals("E") ) {
%>
					<fmtag:button type="1" value="수정" func="facilityWrite('E')" />
					<fmtag:button type="1" value="삭제" func="facilityWrite('D')" />
<%		}
	} %>
					<fmtag:button type="1" value="취소" func="window.close()" />
				</td>
			  </tr>
			</table>
		  </td>
		</tr>
		</table>
		<!-- // -->
 
		<!-- 푸터 -->
		<!-- 공백 -->
		<table width="460" cellpadding="0" cellspacing="0" class="mar_top_20">
		<tr><td></td></tr>
		</table>
	</td>
</tr>
</table>
</form>
</body>
</html>