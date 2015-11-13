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
    String  v_subj		    = box.getString("p_subj");
	String  v_year		    = box.getString("p_year");
	String  v_subjseq		= box.getString("p_subjseq");
	String  v_seq		    = box.getString("p_seq");
	String  v_userid		= box.getString("p_userid");

	String  v_rightno		= box.getString("p_rightno");
	String  v_inningseq		= box.getString("p_inningseq");
	String  v_applynum		= box.getString("p_applynum");
	String  v_ispayment 	= box.getString("ispayment");
	
    Box ds = (Box)box.getObject("RefundInfo");
    
    String v_memberNm 		= ds.getString("NAME");
    String v_memberHP 		= ds.getString("HANDPHONE");
    String v_memberCOMPNM 	= ds.getString("COMPNM");
    String v_engname		= ds.getString("ENG_NAME");
    String v_hometel		= ds.getString("HOMETEL");
    String v_memberemail	= ds.getString("EMAIL");
    String v_memberpost1	= ds.getString("POST1");
    String v_memberpost2	= ds.getString("POST2");
    String v_memberaddr1	= ds.getString("MEMBERADDR");
    String v_memberaddr2	= ds.getString("MEMBERADDR2");
    String v_usemileage		= ds.getString("USEMILEAGE");
    
    
   	if(ds == null) {
   		out.println("<script>alert('결제정보가 없습니다.');self.close();</script>");
   		return;
   	}
   	
   	String payStatus = StringUtil.nvl(ds.get("RECOGSTATE"));
   	String payMethod = StringUtil.nvl(ds.get("PAYMETHOD"));
   	String v_isgraduated = StringUtil.nvl(ds.get("ISGRADUATED"));
   	String v_recogstate = StringUtil.nvl(ds.get("RECOGSTATE"));
   	String v_amount 		= ds.getString("AMOUNT");
   	if(v_recogstate.equals("C") || v_recogstate.equals("F")|| v_recogstate.equals("I")|| v_recogstate.equals("N")) v_amount = "0"; 
   	
   	String v_pay_paper_state = StringUtil.nvl(ds.get("PAY_PAPER_STATE"));
   	String v_repay_paper_state = StringUtil.nvl(ds.get("REPAY_PAPER_STATE"));
   	
    String v_refundtype		= StringUtil.nvl(ds.get("REFUNDTYPE"));    	// 환불타입
    String v_todate			= DateTimeUtil.getDate();

	String v_isStartEdu		= ( ds.getString("EDUSTART").compareTo(v_todate) > 0)  ? "N": "Y"  ;    
    
   	String v_applygubun 	= StringUtil.nvl(ds.get("APPLYGUBUN"));    	// 계산서 신청
   	String v_billreqdt		= StringUtil.nvl(ds.get("BILLREQDT"));		// 요청일 
   
   	String v_pubgubun		= StringUtil.nvl(ds.get("PUBGUBUN"));		// 발행구분
   	String v_returnyn		= StringUtil.nvl(ds.get("CONSTSUPPORT"));	// 환급여부
   	String v_documentyn		= StringUtil.nvl(ds.get("DOCUMENTSYN"));	// 서류제출 여부
   	String v_insurayn		= ( ds.getString("INSURAYN").equals("Y" ) )? "Y": "N" ;		// 고용보험 적용
   	
   	String v_docprepareyn	= StringUtil.nvl(ds.get("DOCPREPAREYN"));	// 증빙서류 완료 여부
   	String v_billcompnm			= StringUtil.nvl(ds.get("BILLCOMPNM"));			// 회사명
   	String v_chiefnm		= StringUtil.nvl(ds.get("CHIEFNM"));		// 대표자
   	String v_busregstno		= StringUtil.nvl(ds.get("REGSTNO"));		// 사업자등록번호
   	
   	String v_regstno		= "";
   	String v_regstno1		= "";
   	String v_regstno2		= "";
   	String v_regstno3		= "";
   	
   	if(!v_busregstno.equals("")){
   		v_regstno = StringUtil.ReplaceAll(v_busregstno,"-","");	
   		v_regstno1		= v_regstno.substring(0,3);
   	   	v_regstno2		= v_regstno.substring(3,5);
   	   	v_regstno3		= v_regstno.substring(5,10);
   	}
   	
   	String v_businesscond	= StringUtil.nvl(ds.get("BUSINESSCOND"));	// 업태
   	String v_businesstype	= StringUtil.nvl(ds.get("BUSINESSTYPE"));	// 종목
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
   	
   	String v_addr1			= StringUtil.nvl(ds.get("ADDR1"));			// 주소
   	String v_addr2			= StringUtil.nvl(ds.get("ADDR2"));			// 주소
   	String v_comtel			= StringUtil.nvl(ds.get("COMTEL"));			// 전화번호
   	String v_comfax			= StringUtil.nvl(ds.get("COMFAX"));			// 팩스번호   	
   	
   	String  v_display 		= v_pubgubun.equals("Y")?"disabled":"";
   	
	//System.out.println(); 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>::: 한국무역협회 무역아카데미 ::: 관리자페이지</TITLE>
<META http-equiv=Content-Type content="text/html; charsezt=UTF-8"> 
<fmtag:csscommon point="back" />
<fmtag:jscommon />
<script language="Javascript" src="/js/common/popupbox.js"></script>
<SCRIPT LANGUAGE="JavaScript">

	//유효성체크(입력값이 특정 문자열(chars)만사용하는가를 체크)
	function containsCharsOnly(input,chars) {
	    for (var inx = 0; inx < input.length; inx++) {
	       if (chars.indexOf(input.charAt(inx)) == -1)
	           return false;
	    }
	    return true;
	}
	
	//숫자만사용되게 유효성체크
	function isNumber(str) {
	    var chars = "0123456789";
	    return containsCharsOnly(str,chars);
	}
	
	
	//요청일 유효성체크
	function dateCheck(){
		var f = document.form1;
		if(f.p_billreqdt.value!=""){
			if(jsByteLength(f.p_billreqdt.value)!=8 || !isNumber(f.p_billreqdt.value)){				
				alert("요청일을 형식에 맞게 입력해 주세요");
				return false;
			}
		}
		return true;
	}
	
	
	/* function refundreqdtchk(){  // 환불요청일 체크
		var f = document.form1;
		
		var year = f.p_refundreqdt.value.substr(0,4);
		var month = f.p_refundreqdt.value.substr(4,2);
		var day = f.p_refundreqdt.value.substr(6,2);
		
			if(year<1900||year>2100){
				alert('[환불요청일] 년도를 다시 입력해주세요');
				return false;}
			if(month<1||month>12){
				alert('[환불요청일] 월을 다시 입력해주세요');
				return false;}
			if(day<1||day>31){
				alert('[환불요청일] 일자를 다시 입력해주세요');
				return false;}
			return true;
		} */

	function refundConfirm() {
		var f = document.form1;
		if(!dateCheck()) return;
		if(!validate(f)) return;
		var v_recogstate = f.p_recogstate.value; 
		var v_refundstate = "";
		for(var i=0  ; i < document.getElementsByName('p_refundstate').length; i++){
			if(document.getElementsByName('p_refundstate')[i].checked) {
				v_refundstate = document.getElementsByName('p_refundstate')[i].value;
				break;
			}
		}
		if(!f.p_amount.value) {
			alert("결제금액을 입력해 주세요");
			f.p_amount.focus();
			return; 
		} 
		
	  <%if(!"100000000000".equals(ds.getString("PAYMETHOD")) ) {  // 카드 결제가 아닌경우 %>
		if( v_refundstate == "R" &&  v_recogstate != v_refundstate )  {	 
			if (confirm("환불요청 하시겠습니까?")) {
				validate(f);
		        f.cmd.value="refundWrite";
			    f.submit();
			}
		}else {
			if (confirm("저장 하시겠습니까?")) {
		        f.cmd.value="refundWrite";
			    f.submit();
			}
		}	
	  <% }else { %>
	 		if(f.p_refundtype.value == "F" && !(v_recogstate == "C") && !(v_recogstate == "E") && !(v_recogstate == "D")  ) {
		 		if( confirm("강제환불 하시겠습니까?") ) {
			 		
		 			if(f.p_refundamount.value =="" ) {
						alert("환불받을 금액을 입력하세요.");
						return false;
					}	
			 		f.p_refundstate[0].checked = false;
			 		f.p_refundstate[1].checked = false;
			 		f.p_refundstate[2].checked = false;
			 		f.p_refundstate[3].checked = false;
			 		f.p_refundstate[4].checked = false;
			 					 		
			 		f.p_refundstate[3].disabled = false; 
			 		f.p_refundstate[3].checked = true;
			 		
			 		if(f.p_refundreqdt.value == "") {
			 			f.p_refundreqdt.value = "<%=v_todate%>" ; 
			 		}
			 		f.cmd.value="refundWrite";
				    f.submit();
		 		}
	 		} else {
	 			if( v_refundstate == "R" &&  v_recogstate != v_refundstate )  {	 
	 				if (confirm("환불요청 하시겠습니까?")) {
	 					validate(f);
	 			        f.cmd.value="refundWrite";
	 				    f.submit();
	 				}
	 			}else {
		 			if (confirm("저장 하시겠습니까?")) {
				        f.cmd.value="refundWrite";
					    f.submit();
		 			}    
				}
	 		}	
	 <% }%>
	}

	function refundCancel() {
		var f = document.form1;
		var v_refundstate = f.p_recogstate.value; 
	
		if( v_refundstate == "R" || v_refundstate == "P"   )  {	 
			if (confirm("환불요청을 취소하시겠습니까?")) {				
		        f.cmd.value="refundCancelWrite";
			    f.submit();
			}
		}
	}

	function refundFinish() {
		var f = document.form1;
		var v_refundstate = f.p_recogstate.value; 
	
		if( v_refundstate == "D"  )  {
		        f.cmd.value="refundFinishWrite";
			    f.submit();			
		}
	}
	
	function validate(f) {		

		<%if(! "100000000000".equals(ds.getString("PAYMETHOD"))) {  // 카드 결제가 아닌경우 %>				 	
			if(f.p_refundreqdt.value =="" && !f.p_refundstate[0].checked) {
				alert("환불요청일을 입력하세요.");
				return false;
			}			
			if(f.p_refundbankcd.value =="" && !f.p_refundstate[0].checked) {
				alert("환불받을 은행을  선택하세요.");
				return false;
			}
			if(f.p_refundaccount.value =="" &&  !f.p_refundstate[0].checked) {
				alert("환불받을 계좌를  입력하세요.");
				return false;
			}
			if(f.p_refundamount.value =="" && !f.p_refundstate[0].checked) {
				alert("환불받을 금액을 입력하세요.");
				return false;
			}
			if(f.p_refunddepositor.value =="" && !f.p_refundstate[0].checked) {
				alert("예금주를  입력하세요.");
				return false;
			}
		<% } else if( "100000000000".equals(ds.getString("PAYMETHOD"))) {  // 카드 결제가 아닌경우 %>				 	
			if(f.p_refundreqdt.value =="" && !f.p_refundstate[0].checked) {
				alert("환불요청일을 입력하세요.");
				return false;
			}
			if(f.p_refundamount.value =="" && !f.p_refundstate[0].checked) {
				alert("환불받을 금액을 입력하세요.");
				return false;
			}
			
			
			var year = f.p_refundreqdt.value.substr(0,4);
			var month = f.p_refundreqdt.value.substr(4,2);
			var day = f.p_refundreqdt.value.substr(6,2);
			
				if(year<1900||year>2100){
					alert('[환불요청일] 년도를 다시 입력해주세요');
					return false;}
				if(month<1||month>12){
					alert('[환불요청일] 월을 다시 입력해주세요');
					return false;}
				if(day<1||day>31){
					alert('[환불요청일] 일자를 다시 입력해주세요');
					return false;}
			
			
		<% } %>
		
		if(f.p_applygubun[3].checked) {

			if(f.p_regstno1.value =="" || f.p_regstno1.value.length != 3) {
				alert("사업자등록번호를 정확히 입력해주세요.");
				return false;
			}
			if(f.p_regstno2.value =="" || f.p_regstno2.value.length != 2) {
				alert("사업자등록번호를 정확히 입력해주세요.");
				return false;
			}
			if(f.p_regstno3.value =="" || f.p_regstno3.value.length != 5) {
				alert("사업자등록번호를 정확히 입력해주세요.");
				return false;
			}
		}
		return true;
	}

	function moveNext(strfrom,strto,maxSize) {

		var cur = document.getElementById(strfrom).value;
		curSize = cur.length;
		numFlag = isNumber(cur);

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

	function searchZipCode(objname) {
		var url = "/front/Common.do?cmd=selectZipCode&p_objname="+objname; 
		Center_Fixed_Popup2(url, "_zipcode", 500, 600, "no");
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
	    }else  if ( objname == "member" ) {
			form.p_memberaddr1.value = addr;
			form.p_memberpost1.value = zipcode.substr(0, 3);
			form.p_memberpost2.value = zipcode.substr(4, 7);
			
			if(zipcode.search('-') > -1){	
				form.p_memberpost1.value = zipcode.substr(0, 3) ;
				form.p_memberpost2.value = zipcode.substr(4, 7) ;	
			} else {
				form.p_memberpost1.value = zipcode;		// 새로운 우편주소, 하나의 텍스트란에 넣음
				form.p_memberpost2.value = "";
				form.p_memberpost2.style.display="none";
			}
			form.p_memberaddr2.value = "";
			form.p_memberaddr2.focus();
	    }
	}
	function changeRefundType(refundtype){
		var f = document.form1;
		var v_recogstate = f.p_recogstate.value; 
		if(refundtype == "F" ) {
			if("100000000000" == "<%=payMethod%>" && "<%=v_isStartEdu%>" == "N"  && !(v_recogstate == "C") && !(v_recogstate == "E") && !(v_recogstate == "D") ) {  // 개강전 (카드결제)
				 
			}else {
				alert("카드결제가 아니거나  이미 개강하였습니다.");
				f.p_refundtype.value ="";
				return; 
			}
		}
	}
	
</SCRIPT>
</HEAD>
<BODY leftMargin=0 topMargin=0 marginheight="0" marginwidth="0" >
	<form name="form1" action="/back/Refund.do" method="post" onSubmit="return false;">
	<input type="hidden" name="cmd" value="refundWriteForm">
  	<input type="hidden" name="p_subj"		value="<%=v_subj%>">
  	<input type="hidden" name="p_year"		value="<%=v_year%>">	  	
  	<input type="hidden" name="p_subjseq"	value="<%=v_subjseq%>">
  	<input type="hidden" name="p_userid"	value="<%=v_userid%>">
  	<input type="hidden" name="p_seq"		value="<%=v_seq%>">  
  	<input type="hidden" name="p_reasoncd"	value="1">  	
  	<input type="hidden" name="p_reason" 	value="본인요구(환불)">  
  	<input type="hidden" name="p_recogstate" 	value="<%=v_recogstate %>">
  	<input type="hidden" name="p_isopensubj" 	value="N">
  	  	
	<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td class="pad_left_15">
		     <!-- 메뉴명 -->
			<table width="700" cellpadding="0" cellspacing="0" class="mar_top_20">
			<colgroup>
				<col width="10" />
				<col width="" />
				<col width="15" />
			</colgroup>
			<tr>
				<td><img src="/images/back/common/bullet_title.gif"></td>
				<td class="t_title">결제 및 환불 정보 관리</td>
				<td align="right" valign="bottom"></td>
			</tr>
			</table>
		</td>
	</tr>	
	<!-- 결제정보 -->
	<tr>
		<td class="pad_left_15">
			<div class="board-view">
			<table width="700" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="100" />
				<col width="250" />
				<col width="100" />
				<col width="250" />			
			</colgroup>
			<tr>
				<th class="th_top_bd">이름</th>
				<td class="td_top_bd">
					<input type="Hidden" name="p_oldmembernm" value ="<%=v_memberNm %>"/>
					<input name="p_membernm" type="text" size="20"  maxlength="100" dispName="이름" isNull="N" value="<%=v_memberNm %>" />
				</td>
				<th class="th_top_bd">영문이름</th>
				<td class="td_top_bd">
					<input type="Hidden" name="p_oldmemberengname" value ="<%=v_engname %>"/>
					<input name="p_memberengname" type="text" size="20"  maxlength="100" dispName="영문이름" isNull="Y" value="<%=v_engname %>" />
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
				<td>
					<input type="Hidden" name="p_oldmemberhometel" value ="<%=v_hometel %>"/>
					<input name="p_memberhometel" type="text" size="20"  maxlength="50" dispName="전화번호" isNull="Y" value="<%=v_hometel %>" /></td>
				<th>핸드폰번호</th>
				<td>
					<input type="Hidden" name="p_oldmemberhp" value ="<%=v_memberHP %>"/>
					<input name="p_memberhp" type="text" size="20"  maxlength="50" dispName="핸드폰번호" isNull="N" value="<%=v_memberHP %>" /></td>
			</tr>
			<tr>
				<th>주소</th>
				<td colspan="3">
					<input type="hidden" name="p_oldmemberpost1" value="<%=v_memberpost1 %>" />
					<input type="hidden" name="p_oldmemberpost2" value="<%=v_memberpost2 %>" />
					<input type="hidden" name="p_oldmemberaddr1" value="<%=v_memberaddr1 %>" />
					<input type="hidden" name="p_oldmemberaddr2" value="<%=v_memberaddr2 %>" />	

					<% if( v_memberpost2 == null || v_memberpost2.equals("")){ %>
						<input name="p_memberpost1" type="text" size="5" dataType="integer" dispName="우편번호" isNull="Y" lenCheck="5" maxLength="5" value="<%=v_memberpost1 %>" readonly="readonly"/>
						<input name="p_memberpost2" type="hidden" dispName="우편번호" value="<%=v_memberpost2 %>"/>
					<% } else { %>
						<input name="p_memberpost1" type="text" size="5" dataType="integer" dispName="우편번호" isNull="Y" maxLength="5" value="<%=v_memberpost1 %>" readonly="readonly"/>
						-
						<input name="p_memberpost2" type="text" size="5" dataType="integer" dispName="우편번호" value="<%=v_memberpost2 %>" readonly="readonly"/>
					<% } %>							
					<a href="#none" onclick="searchZipCode('member')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a><br/>
					<input name="p_memberaddr1" type="text" size="40" dispName="주소" isNull="N" lenCheck="200" maxLength="200" value="<%=v_memberaddr1 %>" readonly="readonly"/>
					<input name="p_memberaddr2" type="text" size="40" dispName="주소" isNull="Y" lenCheck="100" maxLength="100" value="<%=v_memberaddr2 %>"/>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td colspan="3">
					<input type="Hidden" name="p_oldmemberemail" value ="<%=v_memberemail %>"/>
					<input name="p_memberemail" type="text" size="50"  maxlength="100" dispName="이메일" isNull="Y" value="<%=v_memberemail %>" />
				</td>
				</td>
			</tr>
			<tr>
				<th>회사/학교</th>
				<td colspan="3">
					<input type="Hidden" name="p_oldmembercompnm" value ="<%=v_memberCOMPNM %>"/>
					<input name="p_membercompnm" type="text" size="50"  maxlength="100" dispName="회사/학교" isNull="Y" value="<%=v_memberCOMPNM %>" />
				</td>
			</tr>
			</table>
			</div>
		</td>
	</tr>
	<!-- // -->
	<!-- 결제 정보 -->
	<tr>
		<td class="pad_left_15">
			<div class="board-view">
			<table width="700" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="100" />
				<col width="250" />
				<col width="100" />
				<col width="250" />			
			</colgroup>
			<tr>
				<th class="th_top_bd">과정명</th>
				<td class="td_top_bd"><%=ds.getString("SUBJNM") %>(<%=ds.getString("SUBJSEQNM") %>)</td>		
				<th class="th_top_bd">학습기간</th>
				<td class="td_top_bd"><%=DateTimeUtil.getDateType(1, ds.getString("EDUSTART"))  %> ~ <%=DateTimeUtil.getDateType(1, ds.getString("EDUEND"))  %></td>
			</tr>		
			<%if("100000000000".equals(ds.getString("PAYMETHOD"))) {  // 카드 결제%>
	 		<tr>
				<th>결제구분</th>
				<td>
					<input type="Hidden" name="p_paymethod" value="100000000000"/>
					카드</td>		
				<th>영문이름</th>
				<td></td>
			</tr>	
			<tr>
				<th>승인시간</th>
				<td><%=DateTimeUtil.getDateType(0, ds.getString("APPLDATE"))%></td>
		
				<th>승인번호</th>
				<td><%=ds.getString("APPLNUM")%></td>
			</tr>			
			<%} else if("010000000000".equals(ds.getString("PAYMETHOD"))) {  // 가상계좌 %>
			<tr>
				<th>결제유형</th>
				<td>
					<select name="p_paymethod">
						<option value="010000000000" selected >가상계좌</option>
						<option value="001000000000">무통장</option>
					</select>
				</td>
				<th>입금은행</th>
				<td><%=ds.getString("BANK_NAME")%></td>
			</tr>	
			<tr>
				<th>입금일</th>
				<td><%=DateTimeUtil.getDateType(0, ds.getString("PAYDATE"))%></td>		
				<th>계좌번호</th>
				<td><%=ds.getString("VACT_NUM")%></td>
			</tr>			
			<%} else if("001000000000".equals(ds.getString("PAYMETHOD"))) {%>
			<tr>
				<th>결제유형</th>
				<td>
					<select name="p_paymethod">
						<option value="010000000000">가상계좌</option>
						<option value="001000000000"  selected >무통장</option>
					</select>
				</td>		
				<th>입금은행</th>
				<td><%=ds.getString("BANK_NAME")%></td>
			</tr>	
			<tr>
				<th>입금일</th>
				<td><%=DateTimeUtil.getDateType(0, ds.getString("PAYDATE"))%></td>
		
				<th>승인번호</th>
				<td><%=ds.getString("APPLNUM")%></td>
			</tr>		
			<% }  else if("9998".equals(ds.getString("PAYMETHOD"))) {  // 마일리지  %>
			<tr>
				<th>결제유형</th>
				<input type="Hidden" name="p_paymethod" value="9998"/>
				<td colspan="3" >
					마일리지
				</td>
			</tr>
			<% } %>
			<tr>
				<th>결제금액/수강료</th>
				<td>
				<input name="p_orgamount" type="Hidden" value ="<%=ds.getString("AMOUNT") %>" />
				<input name="p_amount" type="text" size="10" dataType="integer" dispName="결제금액" isNull="Y" value="<%=v_amount %>"/> / <%=ds.getString("BIYONG")%>
				<% if ( v_recogstate.equals("N") ){ %>
					&nbsp;&nbsp;<input type="checkbox" name="p_paymentComplete" value="Y" /> 입금완료
				<% } %>
				</td>
				<!--  무통장입금(입금전)에만 금액수정 가능함. -->
				<th>할인구분</th>
				<td><%=ds.getString("PRICETYPENM") %></td>
			</tr>
			</table>
			</div>
		</td>
	</tr>
	<!-- // -->
	<!-- 환불정보 -->
	<tr>
		<td class="pad_left_15">
			<div class="board-view">
			<table width="700" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="100" />
				<col width="250" />
				<col width="100" />
				<col width="250" />			
			</colgroup>
			<%if("100000000000".equals(ds.getString("PAYMETHOD"))) {%>
						
			<% } %>
			<% 
				String v_chckboxabled1 = "";
				String v_chckboxabled2 = "";
				String v_chckboxabled3 = "";
				String v_chckboxabled4 = "";
				String v_chckboxabled5 = "";
				
				/*
				* 환불 진행상태 변경 관련
				* RECOGSTATE  : C(취소),F( 결제실패),  N( 입금대기 ), I (결제진행중) 이면  모두  disabled
				* RECOGSTATE  : Y(입금완료) -->  요청 체크 가능  
				* RECOGSTATE  : R(환불요청) , REPAY_PAPER_STATE ='' --> 요청, 미요청 체크 가능 --> 미요청을 체크했을 경우 상태값은 (Y) 로 변경
				* RECOGSTATE  : P(환불처리중), REPAY_PAPER_STATE ='1'  --> 처리중만 체크 가능함.
				* RECOGSTATE  : D(환불처리완료) E(환불완료)  OR (P, REPAY_PAPER_STATE ='9') 이면 --> 환불 완료 체크  --> 상태값 변경 불가. 
				*/
				
				if( payStatus.equals("C") || payStatus.equals("F") || payStatus.equals("N") || payStatus.equals("I") || payStatus.equals("D") ) {
					v_chckboxabled1 ="disabled" ;
					v_chckboxabled2 ="disabled" ;
					v_chckboxabled3 ="disabled" ;
					v_chckboxabled4 ="disabled" ;
					v_chckboxabled5 ="disabled" ;
				}
				else if((  payStatus.equals("Y") || payStatus.equals("R") || payStatus.equals("P"))  &&  "9998".equals(ds.getString("PAYMETHOD"))  ) {
					v_chckboxabled1 ="disabled" ;
					v_chckboxabled2 ="disabled" ;
					v_chckboxabled3 ="disabled" ;
					v_chckboxabled4 ="" ;
					v_chckboxabled5 ="disabled" ;					
				}
				else if( payStatus.equals("P")){	// 처리중 일 경우
					v_chckboxabled1 ="disabled" ;
					v_chckboxabled2 ="disabled" ;
					v_chckboxabled3 ="disabled" ;
					v_chckboxabled4 ="" ;
					v_chckboxabled5 ="disabled" ;
				}
				else if( payStatus.equals("Y") ){
					v_chckboxabled1 ="disabled" ;
					v_chckboxabled2 ="" ;
					v_chckboxabled3 ="disabled" ;
					v_chckboxabled4 ="disabled" ;
					v_chckboxabled5 ="disabled" ;
				}
				else if( payStatus.equals("R") &&  v_repay_paper_state.equals("") ){
					v_chckboxabled1 ="disabled" ;
					v_chckboxabled2 ="disabled" ;
					v_chckboxabled3 ="disabled" ;
					v_chckboxabled4 ="disabled" ;
					v_chckboxabled5 ="disabled" ;					
				}
				else {
					v_chckboxabled1 ="disabled" ;
					v_chckboxabled2 ="disabled" ;
					v_chckboxabled3 ="disabled" ;
					v_chckboxabled4 ="disabled" ;
					v_chckboxabled5 ="disabled" ;
				}
				
			%> 
			<tr>
				<th class="th_top_bd">환불진행상태</th>
				<td class="td_top_bd" colspan="3" >
	             	<input name="p_refundstate" type="radio" value=""  <%=ds.getString("REFUNDSTATUS").equals("미요청")?"checked":"" %> <%=v_chckboxabled1 %> /> 미요청 
	             	<input name="p_refundstate" type="radio" value="R"  <%=ds.getString("REFUNDSTATUS").equals("요청")?"checked":"" %>  <%=v_chckboxabled2 %> /> 요청
	             	<input name="p_refundstate" type="radio" value="P"  <%=ds.getString("REFUNDSTATUS").equals("처리중")?"checked":"" %> <%=v_chckboxabled3 %>  /> 처리중
	             	<input name="p_refundstate" type="radio" value="D"  <%=ds.getString("REFUNDSTATUS").equals("처리완료")?"checked":"" %> <%=v_chckboxabled4 %> /> 처리완료
	             	<input name="p_refundstate" type="radio" value="E"  <%=ds.getString("REFUNDSTATUS").equals("완료")?"checked":"" %> <%=v_chckboxabled5 %> /> 완료
				</td>
			</tr>
			<tr>	
				<th>환불요청일</th>
				<td colspan="3"  >
	             <input name="p_refundreqdt" type="text" size="13" maxlength="8" dispName="환불요청일" value="<%=ds.getString("REFUNDREQDT")%>"/  <%=v_refundtype.equals("F")?"readonly":"" %>> ex)20101030</td>	
				</td>
			</tr>
			<tr>
				<th>환불타입</th>
				<td>
					<select id="p_refundtype"  name="p_refundtype" style=""   align="absMiddle" onChange="changeRefundType(this.value)" <%=v_refundtype.equals("F")?"disabled":"" %>> 
						<option value=""  <%= v_refundtype.equals("")? "selected":"" %>>-선택-</option>
						<option value="N" <%= v_refundtype.equals("N")? "selected":"" %>>일반환불</option>
						<option value="F" <%= v_refundtype.equals("F")? "selected":"" %>>강제환불</option>
					</select>	             	
				</td>				
				<th>환불처리일</th>
				<td><%=DateTimeUtil.getDateType(0, ds.getString("REFUNDCOMPLETE")) %></td>	
				</td>
			</tr>
			<tr>
				<th>환불사유</th>
				<td> 
					<% if(v_refundtype.equals("F")) { %>
	             		<%=CommonUtil.getCodeListBoxWithOption("select","0087","p_refundreason", ds.getString("REFUNDREASON"),"","-선택-","disabled" )%>
	             	<% }else { %>
	             		<%=CommonUtil.getCodeListBox("select","0087","p_refundreason", ds.getString("REFUNDREASON"),"","-선택-" )%>
	             	<% } %>		
				</td>				
				<th>환불금액</th>
				<td><input name="p_refundamount" type="text" size="10" dataType="integer" dispName="환불금액" isNull="Y" value="<%=ds.getString("REFUNDAMOUNT")%>" <%=v_refundtype.equals("F")?"readonly":"" %> /></td>	
				</td>
			</tr>			
			<% //if("010000000000".equals(ds.getString("PAYMETHOD")) || "001000000000".equals(ds.getString("PAYMETHOD"))) {%>
			<tr>
				<th>계좌정보</th>
				<td>	
					은행 :
					<% if(v_refundtype.equals("F")) { %>
	             		<%=CommonUtil.getCodeListBoxWithOption("select","0050","p_refundbankcd", ds.getString("REFUNDBANKCD"),"","선택하세요","disabled")%>
	             	<% }else { %>
	             		<%=CommonUtil.getCodeListBox("select","0050","p_refundbankcd", ds.getString("REFUNDBANKCD"),"","선택하세요")%>
	             	<% } %>	
					<br/>
					계좌 :<input type="text" name="p_refundaccount" value="<%=ds.getString("REFUNDACCOUNT")%>" size="20" <%=v_refundtype.equals("F")?"readonly":"" %>>
				</td>
				<th>예금주</th>
				<td><input type="text" name="p_refunddepositor" value="<%=ds.getString("REFUNDDEPOSITOR")%>" size="20" <%=v_refundtype.equals("F")?"readonly":"" %>></td>
			</tr>
			<% //} %>
			
			</table>
			</div>
		</td>
	</tr>
	<!-- // -->
	<!-- 계산서 정보  -->
	<tr>
		<td class="pad_left_15">
			<div class="board-view">
			<table width="700" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="100" />
				<col width="250" />
				<col width="100" />
				<col width="250" />			
			</colgroup>
			<tr>
				<th class="th_top_bd">계산서 신청</th>
				<td class="td_top_bd" colspan="3">
					<input name="p_applygubun" type="radio" value="N" dispName="계산서신청"  <%=v_applygubun.equals("N")?"checked":(v_applygubun.equals("")?"checked":"") %> <%=v_display %> /> 필요없음 
	             	<input name="p_applygubun" type="radio" value="R" dispName="계산서신청"  <%=v_applygubun.equals("R")?"checked":"" %> <%=v_display %> /> 영수증
	             	<input name="p_applygubun" type="radio" value="C" dispName="계산서신청"  <%=v_applygubun.equals("C")?"checked":"" %> <%=v_display %> /> 현금영수증
	             	<input name="p_applygubun" type="radio" value="B" dispName="계산서신청"  <%=v_applygubun.equals("B")?"checked":"" %> <%=v_display %> /> 계산서
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
					<input name="p_insurayn" type="radio" value="Y" dispName="고용보험적용"  <%=v_insurayn.equals("Y")?"checked":"" %> /> 적용
	             	<input name="p_insurayn" type="radio" value="N" dispName="고용보험적용"  <%=v_insurayn.equals("N")?"checked":(v_insurayn.equals("")?"checked":"") %> /> 미적용
				</td>
			</tr>			
			<tr>
				<th>회사명</th>
				<td><input name="p_compnm" type="text" size="20" dispName="회사명" isNull="N" lenCheck="50" maxLength="50" value="<%=v_billcompnm %>"/></td>
				<th>대표자</th>
				<td><input name="p_chiefnm" type="text" size="20" dispName="대표자" isNull="N" lenCheck="30" maxLength="30" value="<%=v_chiefnm %>"/></td>
			</tr>
			<tr>
				<th>사업자등록번호</th>
				<td>	
					<input name="p_regstno1" type="text" size="3" dataType="integer" dispName="사업자등록번호" isNull="N" lenCheck="3" maxLength="3" value="<%=v_regstno1 %>" onKeyup="moveNext('p_regstno1','p_regstno2',3);"/>
					-
					<input name="p_regstno2" type="text" size="2" dataType="integer" dispName="사업자등록번호" isNull="N" lenCheck="2" maxLength="2" value="<%=v_regstno2 %>" onKeyup="moveNext('p_regstno2','p_regstno3',2);"/>
					-
					<input name="p_regstno3" type="text" size="5" dataType="integer" dispName="사업자등록번호" isNull="N" lenCheck="5" maxLength="5" value="<%=v_regstno3 %>" />
	            </td>
	            <th>요청일</th>
				<td>
					<input name="p_billreqdt" type="text" size="20" dispName="요청일" lenCheck="10" maxLength="10" value="<%=v_billreqdt %>" /> ex) 20101030
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
						<input name="p_post1" type="text" size="5" dataType="integer" dispName="우편번호" isNull="Y" lenCheck="5" maxLength="5" value="<%=v_zipcode1 %>" readonly="readonly"/>
						-
						<input name="p_post2" type="hidden" dispName="우편번호" value="<%=v_zipcode2 %>"/>
					<% } else { %>
						<input name="p_post1" type="text" size="5" dataType="integer" dispName="우편번호" isNull="Y" maxLength="5" value="<%=v_zipcode1 %>" readonly="readonly"/>
						-
						<input name="p_post2" type="text" size="5" dispName="우편번호" value="<%=v_zipcode2 %>" readonly="readonly"/>		
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
	<table width="700" cellpadding="0" cellspacing="0" class="mar_top_10">
	<tr>
		<td align="center">
			<table cellpadding="0" cellspacing="0">
			<tr>
			  <td>
				<%if(s_menucontrol.equals("RW")&& !v_refundtype.equals("F") ) {%>
				<fmtag:button type="1" value="저장" func="refundConfirm()" />&nbsp;
				<% } %>
				<%if(s_menucontrol.equals("RW") && (payStatus.equals("R") || payStatus.equals("P"))  ) {%>
				<fmtag:button type="1" value="환불요청취소" func="refundCancel()" />&nbsp;
				<% } %>				
	  			<fmtag:button type="1" value="닫 기" func="window.close()" />&nbsp;
	  			<%if(s_menucontrol.equals("RW") && (payStatus.equals("D"))  ) {%>
				<fmtag:button type="1" value="환불완료처리" func="refundFinish()" />
				<% } %>
	  			</td>
			</tr>
			<tr>
			  <td height="20">&nbsp;</td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
	</form>	
	<!-- // -->
