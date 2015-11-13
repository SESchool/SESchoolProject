<%--
 * @(#)SystemCode Template
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * T_LMS_CODEGUBUN 테이블 List Template.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2010. 11. 06.  leehj       Initial Release
 ************************************************
--%>
<%@ page contentType="text/html;charset=UTF-8" 	%>
<%@ include file = "/jsp/back/common/commonInc.jsp"	%>
<%
	String  v_seq		    = box.getString("p_seq");
    String  v_subj		    = box.getString("p_subj");
	String  v_year		    = box.getString("p_year");
	String  v_subjseq		= box.getString("p_subjseq");
	String  v_userid		= box.getString("p_userid");
	
	String  v_rightno		= box.getString("p_rightno");
	String  v_inningseq		= box.getString("p_inningseq");
	String  v_applynum		= box.getString("p_applynum");

    Box ds = (Box)box.getObject("billReqInfo");    
   	
   	String v_applygubun 	= StringUtil.nvl(ds.get("APPLYGUBUN"));    	// 계산서 신청
   	String v_billreqdt		= StringUtil.nvl(ds.get("BILLREQDT"));		// 요청일 
   	if( v_billreqdt.length() > 7) {
   		v_billreqdt = v_billreqdt.substring(0,4)+"-"+v_billreqdt.substring(4,6)+"-"+v_billreqdt.substring(6,8);
   	}
   	String v_pubgubun		= StringUtil.nvl(ds.get("PUBGUBUN"));		// 발행구분
   	String v_insurayn		= StringUtil.nvl(ds.get("INSURAYN"));		// 고용보험 적용
   	String v_docprepareyn	= StringUtil.nvl(ds.get("DOCPREPAREYN"));	// 증빙서류 완료 여부
   	String v_compnm			= StringUtil.nvl(ds.get("COMPNM"));			// 회사명
   	String v_chiefnm		= StringUtil.nvl(ds.get("CHIEFNM"));		// 대표자
   	String v_busregstno		= StringUtil.nvl(ds.get("REGSTNO"));		// 사업자등록번호
   	
   	String[] v_regstno		= null;
   	if(!v_busregstno.equals(""))
   			v_regstno 		= StringUtil.split(v_busregstno,"-");		
   	else 
   			v_regstno 		= new String[]{"","",""};
   	
   	String v_businesscond	= StringUtil.nvl(ds.get("BUSINESSCOND"));	// 업태
   	String v_businesstype	= StringUtil.nvl(ds.get("BUSINESSTYPE"));	// 종목
   
   	String v_addr1			= StringUtil.nvl(ds.get("ADDR1"));			// 주소
   	String v_addr2			= StringUtil.nvl(ds.get("ADDR2"));			// 주소
   	String v_comtel			= StringUtil.nvl(ds.get("COMTEL"));			// 전화번호
   	String v_comfax			= StringUtil.nvl(ds.get("COMFAX"));			// 팩스번호   	
   	
	String v_zipcode		= StringUtil.nvl(ds.get("ZIPCODE"));		// 우편번호 
   	String v_zipcode1;
   	String v_zipcode2;
   	if( !StringUtil.isNull(v_zipcode) && !v_zipcode.equals("-")){
   		if(v_zipcode.contains("-")){
   			v_zipcode1 = v_zipcode.substring(0, v_zipcode.indexOf("-"));
   			v_zipcode2 = v_zipcode.substring(v_zipcode.indexOf("-")+1, v_zipcode.length());
   		} else if (v_zipcode.length() > 5){
   			v_zipcode1 = v_zipcode.substring(0, 3);
   			v_zipcode2 = v_zipcode.substring(3, v_zipcode.length());
   		} else {
   			v_zipcode1 = v_zipcode;
   			v_zipcode2 = "";
   		}
   	} else {
   		v_zipcode1 = "";
   		v_zipcode2 = "";
   	}
   	
   	String  v_display 		= v_pubgubun.equals("Y")?"disabled":"";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>::: 한국무역협회 무역아카데미 ::: 관리자페이지</TITLE>
<META http-equiv=Content-Type content="text/html; charset=UTF-8"> 
<fmtag:csscommon point="back" />
<fmtag:jscommon />
<script language="Javascript" src="/js/common/popupbox.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
	function billReqConfirm() {
		var f = document.form1;
		if(!validate(f)) return;
	
	    f.cmd.value="billReqWrite";
		f.submit();
	
	}
	
	function searchZipCode(objname) {
		var url = "/front/Common.do?cmd=selectZipCode&p_objname="+objname; 
		Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
	}
	function setZipCodeInfo(objname, addr, zipcode) {	
		var form = document.form1;

	    if ( objname == "home" ) {
			form.p_addr1.value = addr;
			if(zipcode.search('-') > -1){	
				form.p_post1.value = zipcode.substr(0, 3) ;
				form.p_post2.value = zipcode.substr(4, 7) ;	
			} else {
				form.p_post1.value = zipcode;		// 새로운 우편주소, 하나의 텍스트란에 넣음
				form.p_post2.value = "";
				form.p_post2.style.display="none";
			}
			form.p_addr2.value = "";
			form.p_addr2.focus();
	    }
	}

	function moveNext(strfrom,strto,maxSize) {

		var cur = document.getElementById(strfrom).value;
		curSize = cur.length;
		numFlag = isNumeric(cur);

		if ( !numFlag && curSize >= 1 && cur != '00' &&  cur != '000') {
			alert('숫자를 넣어주세요');
			document.getElementById(strfrom).value='';
			document.getElementById(strfrom).focus();
			return false;
		}
		if (curSize == maxSize) {
			document.getElementById(strto).focus();
			return true;
		}
	}

	
//-->
</SCRIPT>
</HEAD>
<BODY leftMargin=0 topMargin=0 marginheight="0" marginwidth="0" >
	<form name="form1" action="/back/BillPublish.do" method="post" onSubmit="return false;">
	<input type="hidden" name="cmd" value="billReqWritePop">
  	<input type="hidden" name="p_subj"		value="<%=v_subj%>">
  	<input type="hidden" name="p_year"		value="<%=v_year%>">	  	
  	<input type="hidden" name="p_subjseq"	value="<%=v_subjseq%>">
  	<input type="hidden" name="p_userid"	value="<%=v_userid%>">  		
  	<input type="hidden" name="p_seq"	value="<%=v_seq%>">
  	
  	<input type="hidden" name="p_rightno"	value="<%=v_rightno%>">
  	<input type="hidden" name="p_inningseq"	value="<%=v_inningseq%>">
  	<input type="hidden" name="p_applynum"	value="<%=v_applynum%>">
  	
	<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td class="pad_left_15">
		     <!-- 메뉴명 -->
			<table width="640" cellpadding="0" cellspacing="0" class="mar_top_20">
			<colgroup>
				<col width="10" />
				<col width="" />
				<col width="15" />
			</colgroup>
			<tr>
				<td><img src="/images/back/common/bullet_title.gif"></td>
				<td class="t_title">세금계산서 신청 정보 </td>
				<td align="right" valign="bottom"></td>
			</tr>
			</table>
		</td>
	</tr>	
	<tr>
		<td class="pad_left_15">
			<div class="board-view">
			<table width="640" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="100" />
				<col width="220" />
				<col width="100" />
				<col width="220" />			
			</colgroup>
			<tr>
				<th class="th_top_bd">이름</th>
				<td class="td_top_bd">
	             	<%=ds.getString("NAME") %>
				</td>
				<th class="th_top_bd">영문이름</th>
				<td class="td_top_bd">
					<%=ds.getString("ENG_NAME") %>
				</td>
			</tr>
			<tr>
				<th>아이디</th>
				<td>
	             	<%=ds.getString("USERID") %>
				</td>
				<th>주민등록번호</th>
				<td>
					<%=ds.getString("RESNO") %>
				</td>
			</tr>			
			<tr>
				<th>전화번호</th>
				<td><%=ds.getString("HOMETEL") %></td>
				<th>핸드폰번호</th>
				<td><%=ds.getString("HANDPHONE") %></td>
			</tr>
			<tr>
				<th>주소</th>
				<td colspan="3">
					<%=ds.getString("POST1") %> -  <%=ds.getString("POST2") %><br/>
					<%=ds.getString("ADDR") %>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td colspan="3">
					<%=ds.getString("EMAIL") %>
				</td>
				</td>
			</tr>
			<tr>
				<th>회사명</th>
				<td colspan="3">
					<%=ds.getString("COMPNM") %>
				</td>
			</tr>
			</table>
			</div>
		</td>
	</tr>
	<!-- 결제정보 -->
	<tr>
		<td class="pad_left_15">
			<div class="board-view">
			<table width="640" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="100" />
				<col width="220" />
				<col width="100" />
				<col width="220" />			
			</colgroup>
			<tr>
				<th class="th_top_bd">계산서 신청</th>
				<td class="td_top_bd">
					<input name="p_applygubun" type="radio" value="N" dispName="계산서신청"  <%=v_applygubun.equals("N")?"checked":(v_applygubun.equals("")?"checked":"") %> <%=v_display %> /> 필요없음 
	             	<input name="p_applygubun" type="radio" value="R" dispName="계산서신청"  <%=v_applygubun.equals("R")?"checked":"" %> <%=v_display %> /> 영수증
	             	<input name="p_applygubun" type="radio" value="C" dispName="계산서신청"  <%=v_applygubun.equals("C")?"checked":"" %> <%=v_display %> /> 현금영수증
	             	<input name="p_applygubun" type="radio" value="B" dispName="계산서신청"  <%=v_applygubun.equals("B")?"checked":"" %> <%=v_display %> /> 계산서
				</td>
				<th class="th_top_bd">요청일</th>
				<td class="td_top_bd">
					<input name="p_billreqdt" type="text" size="20" dispName="요청일" lenCheck="10" maxLength="10" value="<%=v_billreqdt %>" /> ex) 2006-09-01
				</td>
			</tr>
			<tr>
				<th>발행구분</th>
				<td>
					<input name="p_pubgubun" type="radio" value="N" dispName="발행구분"  <%=v_pubgubun.equals("N")?"checked":(v_pubgubun.equals("")?"checked":"") %> <%=v_display %> /> 미발행
	             	<input name="p_pubgubun" type="radio" value="Y" dispName="발행구분"  <%=v_pubgubun.equals("Y")?"checked":"" %> <%=v_display %> /> 발행
				</td>
				<th>고용보험적용</th>
				<td>
					<input name="p_insurayn" type="radio" value="Y" dispName="고용보험적용"  <%=v_insurayn.equals("Y")?"checked":"" %> <%=v_display %> /> 적용
	             	<input name="p_insurayn" type="radio" value="N" dispName="고용보험적용"  <%=v_insurayn.equals("N")?"checked":(v_insurayn.equals("")?"checked":"") %> <%=v_display %> /> 미적용
				</td>
			</tr>
			<tr>
				<th>증빙서류완료여부</th>
				<td colspan="3">
					<input name="p_docprepareyn" type="radio" value="Y" dispName="증빙서류완료여부"  <%=v_docprepareyn.equals("Y")?"checked":"" %> /> 완료
	             	<input name="p_docprepareyn" type="radio" value="N" dispName="증빙서류완료여부"  <%=v_docprepareyn.equals("N")?"checked":(v_docprepareyn.equals("")?"checked":"") %>  /> 미완료
	            </td>
			</tr>
			<tr>
				<th>회사명</th>
				<td><input name="p_compnm" type="text" size="20" dispName="회사명" isNull="N" lenCheck="50" maxLength="50" value="<%=v_compnm %>"/></td>
				<th>대표자</th>
				<td><input name="p_chiefnm" type="text" size="20" dispName="대표자" isNull="N" lenCheck="30" maxLength="30" value="<%=v_chiefnm %>"/></td>
			</tr>
			<tr>
				<th>사업자등록번호</th>
				<td colspan="3">	
					<input name="p_regstno1" type="text" size="3" dataType="integer" dispName="사업자등록번호" isNull="N" lenCheck="3" maxLength="3" value="<%=v_regstno[0] %>" onKeyup="moveNext('p_regstno1','p_regstno2',3);"/>
					-
					<input name="p_regstno2" type="text" size="2" dataType="integer" dispName="사업자등록번호" isNull="N" lenCheck="2" maxLength="2" value="<%=v_regstno[1] %>" onKeyup="moveNext('p_regstno2','p_regstno3',2);"/>
					-
					<input name="p_regstno3" type="text" size="5" dataType="integer" dispName="사업자등록번호" isNull="N" lenCheck="5" maxLength="5" value="<%=v_regstno[2] %>" />
	            </td>
			</tr>
			<tr>
				<th>업태</th>
				<td><input name="p_businesscond" type="text" size="20" dispName="업태" lenCheck="50" isNull="N" maxLength="50" value="<%=v_businesscond %>"/></td>
				<th>종목</th>
				<td><input name="p_businesstype" type="text" size="20" dispName="종목" lenCheck="50" isNull="N" maxLength="50" value="<%=v_businesstype %>"/></td>
			</tr>			
			<tr>
				<th height="45">주소</th>
				<td colspan="3">

					<% if( v_zipcode2 == null || v_zipcode2.equals("")){ %>
						<input name="p_post1" type="text" size="3" dataType="integer" dispName="우편번호" isNull="Y" lenCheck="5" maxLength="5" value="<%=v_zipcode1 %>" readonly="readonly"/>
						<input name="p_post2" type="hidden" dispName="우편번호" value="<%=v_zipcode2 %>"/>
					<% } else { %>
						<input name="p_post1" type="text" size="3" dataType="integer" dispName="우편번호" isNull="Y" value="<%=v_zipcode1 %>" readonly="readonly"/>
						-
						<input name="p_post2" type="text" size="3" dataType="integer" dispName="우편번호" value="<%=v_zipcode2 %>" readonly="readonly" />	
					<% } %>
					<a href="#none" onclick="searchZipCode('home')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a><br/>
					<input name="p_addr1" type="text" size="40" dispName="주소" isNull="N" lenCheck="100" maxLength="100" value="<%=v_addr1 %>" readonly="readonly"/>
					<input name="p_addr2" type="text" size="40" dispName="주소" isNull="Y" lenCheck="100" maxLength="100" value="<%=v_addr2 %>"/>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input name="p_comtel" type="text" size="20" dispName="전화번호" lenCheck="20" maxLength="20" value="<%=v_comtel %>"/></td>
				<th>팩스번호</th>
				<td><input name="p_comfax" type="text" size="20" dispName="팩스번호" lenCheck="20" maxLength="20" value="<%=v_comfax %>"/></td>
			</tr>
			</table>
			</div>
		</td>
	</tr>
	<!-- // -->		
	</table>

    <!-- 버튼 -->
	<table width="560" cellpadding="0" cellspacing="0" class="mar_top_10">
	<tr>
		<td align="center">
			<table cellpadding="0" cellspacing="0">
			<tr>
			  <td>
				<%if(s_menucontrol.equals("RW")) {%>
				<fmtag:button type="1" value="저장" func="billReqConfirm()" />&nbsp;
				<% } %>
	  			<fmtag:button type="1" value="취 소" func="window.close()" /></td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
	</form>	
	<!-- // -->
	
  <!--푸터부분 시작-->
  <%@ include file = "/jsp/back/common/popBottom.jsp"%>
  <!--푸터부분 끝-->	
