<%@ page contentType="text/html;charset=UTF-8" 	%>
<%@ include file = "/jsp/back/common/commonInc.jsp"	%>
<%
	String v_edustart_1     = box.getString("p_edustart_1");
	String v_subjseq		= box.getString("p_subjseq");
	String v_isonoff		= box.getString("v_isonoff");
	String v_pseq           = box.getString("p_pseq");
	
	Box courseInningChange = (Box)box.getObject("courseInningChange");   // 사용자 기본정보
	Box billReqInfo = (Box)box.getObject("billReqInfo");                 // 세금계산서 정보
	
	String v_rightno		 = courseInningChange.getString("RIGHTNO");
	String v_seq		     = courseInningChange.getString("SEQ");
	String v_applynum		 = courseInningChange.getString("APPLYNUM");
	String v_userid		     = courseInningChange.getString("USERID");

    String v_refundtype		= StringUtil.nvl(courseInningChange.get("REFUNDTYPE"));    	// 환불타입
	String payStatus = StringUtil.nvl(courseInningChange.get("RECOGSTATE"));
   	String payMethod = StringUtil.nvl(courseInningChange.get("PAYMETHOD"));
   	/* 환불 가능 기간 여부 */
   	String v_todate			= DateTimeUtil.getDate();
   	String v_isCancelPossible		= ( courseInningChange.getString("CANCELSTARTDT").compareTo(v_todate) > 0 &&  courseInningChange.getString("CANCELENDDT").compareTo(v_todate) < 0)  ? "N": "Y"  ;   
   	
   	String v_applygubun 	= StringUtil.nvl(billReqInfo.get("APPLYGUBUN"));    // 계산서 신청
   	String v_billreqdt		= StringUtil.nvl(billReqInfo.get("BILLREQDT"));		// 요청일 
  // 	if( v_billreqdt.length() > 7) {
   //		v_billreqdt = v_billreqdt.substring(0,4)+"-"+v_billreqdt.substring(4,6)+"-"+v_billreqdt.substring(6,8);
  // 	}
   	String v_pubgubun		= StringUtil.nvl(billReqInfo.get("PUBGUBUN"));		// 발행구분
   	String v_insurayn		= StringUtil.nvl(billReqInfo.get("INSURAYN"));		// 고용보험 적용
   	String v_docprepareyn	= StringUtil.nvl(billReqInfo.get("DOCPREPAREYN"));	// 증빙서류 완료 여부
   	String v_compnm			= StringUtil.nvl(billReqInfo.get("COMPNM"));		// 회사명
   	String v_chiefnm		= StringUtil.nvl(billReqInfo.get("CHIEFNM"));		// 대표자
   	String v_busregstno		= StringUtil.nvl(billReqInfo.get("REGSTNO"));		// 사업자등록번호
   	
   	String[] v_regstno		= null;
   	if(!v_busregstno.equals(""))
   			v_regstno 		= StringUtil.split(v_busregstno,"-");		
   	else 
   			v_regstno 		= new String[]{"","",""};
   	
   	
   	String v_businesscond	= StringUtil.nvl(billReqInfo.get("BUSINESSCOND"));	// 업태
   	String v_businesstype	= StringUtil.nvl(billReqInfo.get("BUSINESSTYPE"));	// 종목
   	String v_zipcode		= StringUtil.nvl(billReqInfo.get("ZIPCODE"));		// 우편번호 
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
   	String v_addr1			= StringUtil.nvl(billReqInfo.get("ADDR1"));			// 주소
   	String v_addr2			= StringUtil.nvl(billReqInfo.get("ADDR2"));			// 주소
   	String v_comtel			= StringUtil.nvl(billReqInfo.get("COMTEL"));			// 전화번호
   	String v_comfax			= StringUtil.nvl(billReqInfo.get("COMFAX"));			// 팩스번호   	
   	
   	String  v_display 		= v_pubgubun.equals("Y")?"disabled":"";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>::: 한국무역협회 무역아카데미 ::: 관리자페이지</TITLE>
<META http-equiv=Content-Type content="text/html; charset=UTF-8"> 
<fmtag:csscommon point="back" />
<fmtag:jscommon />
<script type="text/JavaScript" language="JavaScript" src="/js/common/util.js"></script>
<script type="text/JavaScript" language="JavaScript" src="/js/common/main.js"></script>
<script language="Javascript" src="/js/common/popupbox.js"></script>
<script language="Javascript" src="/js/common/calendar.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
/*
function setPopupSize() {
	window.resizeTo(1050,1000);
	popupAutoResize();
}
Event.observe(window,"load", setPopupSize);
*/
//결재정보, 환불정보 저장하기..
function applicationAcceptViewSave(){
	var f = document.form1;
	var v_recogstate = f.p_recogstate.value; 
	
	for(var i=0  ; i < document.getElementsByName('p_refundstate').length; i++){
		if(document.getElementsByName('p_refundstate')[i].checked) {
			v_refundstate = document.getElementsByName('p_refundstate')[i].value;
			break;
		}
	}

<% if (!v_pseq.equals("")) { %>
	<%if(!"신용카드".equals(courseInningChange.getString("PAYMETHOD")) ) {  // 카드 결제가 아닌경우    %>
		if( v_refundstate == "R" &&  v_recogstate != v_refundstate )  {	 
			if (confirm("환불요청 하시겠습니까?")) {
				if(!validate(f)) return;
		        f.cmd.value="applicationAcceptViewSave";
			    f.submit();
			}else return; 
		}else {
			if (confirm("저장 하시겠습니까?")) {
		        f.cmd.value="applicationAcceptViewSave";
			    f.submit();
			}else return; 
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
			 		f.cmd.value="applicationAcceptViewSave";
				    f.submit();
		 		}
	 		} else {	
	 			if( v_refundstate == "R" &&  v_recogstate != v_refundstate )  {	 
	 				if (confirm("환불요청 하시겠습니까?")) {
	 					if(!validate(f)) return;
	 			        f.cmd.value="applicationAcceptViewSave";
	 				    f.submit();
	 				}else return; 
	 			}else {
		 			if (confirm("저장 하시겠습니까?")) {
				        f.cmd.value="applicationAcceptViewSave";
					    f.submit();
		 			} else return;    
				}
	 		}	
	 <% }%>
<% }else { %> 
		f.method = "post";
		f.cmd.value = "applicationAcceptViewSave";
		f.submit();
<% }%>	
}

function validate(f) {		

	<%if(! "신용카드".equals(courseInningChange.getString("PAYMETHOD")) ) {  // 카드 결제가 아닌경우 %>				 	
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
	<% } else if( "신용카드".equals(courseInningChange.getString("PAYMETHOD"))) {  // 카드 결제가 아닌경우 %>				 	
		if(f.p_refundreqdt.value =="" && !f.p_refundstate[0].checked) {
			alert("환불요청일을 입력하세요.");
			return false;
		}
		if(f.p_refundamount.value =="" && !f.p_refundstate[0].checked) {
			alert("환불받을 금액을 입력하세요.");
			return false;
		}
	<% } %>
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

function changeRefundType(refundtype){
	var f = document.form1;
	var v_recogstate = f.p_recogstate.value; 
	if(refundtype == "F" ) {
	
		if("신용카드" == "<%=payMethod%>" && "<%=v_isCancelPossible%>" == "Y"  && !(v_recogstate == "C") && !(v_recogstate == "E") && !(v_recogstate == "D") ) {  // 개강전 (카드결제)
			 
		}else {
			alert("카드결제가 아니거나  취소 기간이 아닙니다.");
			f.p_refundtype.value ="";
			return; 
		}
	}
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
    }else  if ( objname == "member" ) {
		form.p_memberaddr1.value = addr;
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

function refundCancel() {
	var f = document.form1;
	var v_refundstate = f.p_recogstate.value; 

	if( v_refundstate == "R" || v_refundstate == "P"   )  {	 
		if (confirm("환불요청을 취소하시겠습니까?")) {				
	        f.cmd.value="applicationRefundCancelSave";
		    f.submit();
		}
	}
}

function refundFinish(){
	var f = document.form1;
	var v_refundstate = f.p_recogstate.value; 

	if( v_refundstate == "D"  )  {
	        f.cmd.value="refundFinishWrite";
		    f.submit();			
	}
}

//-->
</SCRIPT>
</HEAD>
<BODY leftMargin=0 topMargin=0 marginheight="0" marginwidth="0" >
	<form name="form1" action="/back/RightTestMenagement.do" method="post" onSubmit="return false;">
	<input type="hidden" name="cmd" value="">
  	<input type="hidden" name="p_rightno"     value="<%=v_rightno %>">	  	
  	<input type="hidden" name="p_seq"	      value="<%=v_seq %>">
  	<input type="hidden" name="p_userid"      value="<%=v_userid %>">
  	<input type="hidden" name="p_applynum"    value="<%=v_applynum %>">
  	<input type="hidden" name="p_recogstate"  value="<%=payStatus %>" />
  	<input type="hidden" name="p_reasoncd"	  value="1">  	
  	<input type="hidden" name="p_reason" 	  value="본인요구(환불)">  
  	<input type="hidden" name="p_pseq"        value="<%=v_pseq %>">
  	
	<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td class="pad_left_15">
		     <!-- 메뉴명 -->
			<table width="560" cellpadding="0" cellspacing="0" class="mar_top_20">
			<colgroup>
				<col width="10" />
				<col width="" />
				<col width="15" />
			</colgroup>
			<tr>
				<td><img src="/images/back/common/bullet_label.gif"></td>
				<td class="t_title"> 사용자 정보</td>
				<td align="right" valign="bottom"></td>
			</tr>
			</table>
		</td>
	</tr>	
	<!-- 과정기수변경  -->
	<tr>
		<td class="pad_left_15">
			<div class="board-view">
			<table width="1000" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="200" />
				<col width="300" />
				<col width="200" />
				<col width="300" />			
			</colgroup>
			<tr>
				<th class="th_top_bd">접수자명</th>
				<td class="td_top_bd">
					<input type="Hidden" name="p_oldmembernm" value ="<%=courseInningChange.getString("NAME") %>"/>
					<input name="p_membernm" type="text" size="20"  maxlength="100" dispName="이름" isNull="N" value="<%=courseInningChange.getString("NAME") %>" />
				</td>
				<th class="th_top_bd">주민번호</th>
				<td class="td_top_bd"">
            	    <%=courseInningChange.getString("RESNO") %>
				</td>
			</tr>
			<tr>
				<th>핸드폰</th>
				<td>
					<input type="Hidden" name="p_oldmemberhp" value ="<%=courseInningChange.getString("HANDPHONE") %>"/>
					<input name="p_memberhp" type="text" size="20"  maxlength="50" dispName="핸드폰번호" isNull="N" value="<%=courseInningChange.getString("HANDPHONE") %>" />
				</td>
				<th>전화번호</th>
				<td>
					<input type="Hidden" name="p_oldmemberhometel" value ="<%=courseInningChange.getString("HOMETEL") %>"/>
					<input name="p_memberhometel" type="text" size="20"  maxlength="50" dispName="전화번호" isNull="Y" value="<%=courseInningChange.getString("HOMETEL") %>" />
				</td>
			</tr>
			<tr>
				<th>이메일주소</th>
				<td>
					<input type="Hidden" name="p_oldmemberemail" value ="<%=courseInningChange.getString("EMAIL") %>"/>
					<input name="p_memberemail" type="text" size="50"  maxlength="100" dispName="이메일" isNull="Y" value="<%=courseInningChange.getString("EMAIL") %>" />
				</td>
				<th>회사명</th>
				<td>
            	    <%=courseInningChange.getString("COMPNM") %>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td colspan="3">
					<input type="hidden" name="p_oldmemberpost1" value="<%=courseInningChange.getString("POST1") %>" />
					<input type="hidden" name="p_oldmemberpost2" value="<%=courseInningChange.getString("POST2") %>" />
					<input type="hidden" name="p_oldmemberaddr1" value="<%=courseInningChange.getString("ADDR") %>" />
					<input type="hidden" name="p_oldmemberaddr2" value="<%=courseInningChange.getString("ADDR2") %>" />
					<% if( courseInningChange.getString("POST2") == null || courseInningChange.getString("POST2").equals("")){ %>
						<input name="p_memberpost1" type="text" size="5" dataType="integer" dispName="우편번호" isNull="Y" lenCheck="5" maxLength="5" value="<%=courseInningChange.getString("POST1") %>" readonly="readonly"/>
						<input name="p_memberpost2" type="hidden" dispName="우편번호" value="<%=courseInningChange.getString("POST2") %>"/>
					<% } else { %>
						<input name="p_memberpost1" type="text" size="5" dataType="integer" dispName="우편번호" isNull="Y" maxLength="5" value="<%=courseInningChange.getString("POST1") %>" readonly="readonly"/>
						-
						<input name="p_memberpost2" type="text" size="5" dispName="우편번호" value="<%=courseInningChange.getString("POST2") %>" readonly="readonly"/>
					<% } %>										
					<a href="#none" onclick="searchZipCode('member')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a><br/>
					<input name="p_memberaddr1" type="text" size="40" dispName="주소" isNull="N" lenCheck="200" maxLength="200" value="<%=courseInningChange.getString("ADDR") %>" readonly="readonly"/>
					<input name="p_memberaddr2" type="text" size="40" dispName="주소" isNull="Y" lenCheck="100" maxLength="100" value="<%=courseInningChange.getString("ADDR2") %>"/>
				</td>
			</tr>
			</table>
		  </div>
	    </td>
      </tr>	
    <!--  -->
    
    <!-- 라벨 -->
    <tr>
    	<td class="pad_left_15">
		<table width="1000" cellpadding="0" cellspacing="0" class="mar_top_15">
		<tr>
			<td width="15"><img src="/images/back/common/bullet_label.gif"></td>
			<td class="t_title">결재정보</td>
		</tr>
		</table>
		</td>
    </tr>
    <!--  -->
    
    <!-- 결재정보 -->
    <tr>
		<td class="pad_left_15">
			<div class="board-view">
			<table width="1000" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="200" />
				<col width="300" />
				<col width="200" />
				<col width="300" />			
			</colgroup>
			<tr>
				<th class="th_top_bd">시험명</th>
				<td class="td_top_bd">
            	    <%=courseInningChange.getString("KORNM") %>
				</td>
				<th class="th_top_bd">시험일</th>
				<td class="td_top_bd"">
            	    <%=courseInningChange.getString("TESTDATE") %>
				</td>
			</tr>
			<tr>
				<th>시험지역</th>
				<td>
            	    <select id="p_testarea" name="p_testarea">
            	      <option value="10" <%if(courseInningChange.getString("TESTAREA").equals("10")){%> selected <%} %>>서울A</option>
            	      <option value="75" <%if(courseInningChange.getString("TESTAREA").equals("75")){%> selected <%} %>>서울B</option>
            	      <option value="80" <%if(courseInningChange.getString("TESTAREA").equals("80")){%> selected <%} %>>서울C</option>
            	      <option value="85" <%if(courseInningChange.getString("TESTAREA").equals("85")){%> selected <%} %>>서울D</option>
            	      <option value="15" <%if(courseInningChange.getString("TESTAREA").equals("15")){%> selected <%} %>>부산</option>
            	      <option value="20" <%if(courseInningChange.getString("TESTAREA").equals("20")){%> selected <%} %>>인천</option>
            	      <option value="25" <%if(courseInningChange.getString("TESTAREA").equals("25")){%> selected <%} %>>수원</option>
            	      <option value="30" <%if(courseInningChange.getString("TESTAREA").equals("30")){%> selected <%} %>>대전</option>
            	      <option value="35" <%if(courseInningChange.getString("TESTAREA").equals("35")){%> selected <%} %>>청주</option>
            	      <option value="40" <%if(courseInningChange.getString("TESTAREA").equals("40")){%> selected <%} %>>광주</option>
            	      <option value="45" <%if(courseInningChange.getString("TESTAREA").equals("45")){%> selected <%} %>>전주</option>
            	      <option value="50" <%if(courseInningChange.getString("TESTAREA").equals("50")){%> selected <%} %>>대구</option>
            	      <option value="55" <%if(courseInningChange.getString("TESTAREA").equals("55")){%> selected <%} %>>창원</option>
            	      <option value="60" <%if(courseInningChange.getString("TESTAREA").equals("60")){%> selected <%} %>>울산</option>
            	      <option value="65" <%if(courseInningChange.getString("TESTAREA").equals("65")){%> selected <%} %>>강원</option>
            	      <option value="70" <%if(courseInningChange.getString("TESTAREA").equals("70")){%> selected <%} %>>제주</option>
            	      <option value="90" <%if(courseInningChange.getString("TESTAREA").equals("90")){%> selected <%} %>>목포</option>
            	    </select>
				</td>
				<th>수험번호</th>
				<td>
            	    <%=courseInningChange.getString("EXAMINNUM") %>
				</td>
			</tr>
			<tr>
				<th>결재금액</th>
				<td>
					<input type="hidden" name ="p_amount" value="<%=courseInningChange.getString("AMOUNT") %>"/>
            	    <%=courseInningChange.getString("AMOUNT") %>
				</td>
				<th>결재여부</th>
				<td>
            	    <%=courseInningChange.getString("PAYSTATUS") %>
				</td>
			</tr>
			<tr>
				<th>결재일</th>
				<td>
            	    <%=courseInningChange.getString("PAYDATE") %>
				</td>
				<th>결재방식</th>
				<td>
            	    <%=courseInningChange.getString("PAYMETHOD") %>
				</td>
			</tr>
				</table>
		  </div>
	    </td>
      </tr>	
    <!--  -->
    
<% if(v_pseq != "") { //PAYMENT 테이블의 값이 NULL 이 아닌경우만 계산서신청 폼을 보여준다%>

 <!-- 라벨 -->
    <tr>
    	<td class="pad_left_15">
		<table width="1000" cellpadding="0" cellspacing="0" class="mar_top_15">
		<tr>
			<td width="15"><img src="/images/back/common/bullet_label.gif"></td>
			<td class="t_title">환불정보</td>
		</tr>
		</table>
		</td>
    </tr>
    <!--  -->
    
    <!-- 결재정보 -->
    <!-- 환불정보 -->
    <tr>
		<td class="pad_left_15">
			<div class="board-view">
			<table width="1000" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="200" />
				<col width="300" />
				<col width="200" />
				<col width="300" />			
			</colgroup>
			<tr>
				<th class="th_top_bd">환불신청여부</th>
				<td class="td_top_bd" colspan="3">
					<input name="p_refundstate" type="radio" value=""  <%=courseInningChange.getString("REFUNDSTATUS").equals("미요청")?"checked":"" %> disabled /> 미요청 
	             	<input name="p_refundstate" type="radio" value="R"  <%=courseInningChange.getString("REFUNDSTATUS").equals("요청")?"checked":"" %>  <%=payStatus.equals("Y")?"":"disabled" %> /> 요청
	             	<input name="p_refundstate" type="radio" value="P"  <%=courseInningChange.getString("REFUNDSTATUS").equals("처리중")?"checked":"" %> disabled  /> 처리중
	             	<input name="p_refundstate" type="radio" value="D"  <%=courseInningChange.getString("REFUNDSTATUS").equals("처리완료")?"checked":"" %> disabled /> 처리완료
	             	<input name="p_refundstate" type="radio" value="E"  <%=courseInningChange.getString("REFUNDSTATUS").equals("완료")?"checked":"" %> disabled /> 완료
				</td>
			</tr>
			<tr>
				<th>환불신청일</th>
				<td>
            	    <input name="p_refundreqdt" type="text" size="13" maxlength="10" dispName="환불요청일" value="<%=courseInningChange.getString("REFUNDREQDT")%>" <%=v_refundtype.equals("F")?"readonly":"" %>/> ex)20101030</td>
				</td>
				<th>환불처리일</th>
				<td>
            	    <%=DateTimeUtil.getDateType(0, courseInningChange.getString("REFUNDCOMPLETE"))%>
				</td>
			</tr>
			<tr>
				<th>환불은행명</th>
				<td>
					<% if(v_refundtype.equals("F")) { %>
	             		<%=CommonUtil.getCodeListBoxWithOption("select","0050","p_refundbankcd", courseInningChange.getString("REFUNDBANKCD"),"","선택하세요","disabled")%>
	             	<% }else { %>
	             		<%=CommonUtil.getCodeListBox("select","0050","p_refundbankcd", courseInningChange.getString("REFUNDBANKCD"),"","선택하세요")%>
	             	<% } %>	
				</td>
				<th>환불계좌번호</th>
				<td>
            	    <input name="p_refundaccount" type="text" size="45" dispName="" isNull="Y" lenCheck="50" maxLength="20" value="<%=courseInningChange.getString("REFUNDACCOUNT") %>"  <%=v_refundtype.equals("F")?"readonly":"" %>/>
				</td>
			</tr>
			<tr>
				<th>환불계좌 소유주</th>
				<td>
            	    <input name="p_refunddepositor" type="text" size="45" dispName="" isNull="Y" lenCheck="50" maxLength="20" value="<%=courseInningChange.getString("REFUNDDEPOSITOR") %>" <%=v_refundtype.equals("F")?"readonly":"" %>/>
				</td>
				<th>환불타입</th>
				<td>
					<select id="p_refundtype"  name="p_refundtype" style=""   align="absMiddle" onChange="changeRefundType(this.value)" <%=courseInningChange.getString("REFUNDTYPE").equals("F")?"disabled":"" %>> 
						<option value=""  <%= courseInningChange.getString("REFUNDTYPE").equals("")? "selected":"" %>>-선택-</option>
						<option value="N" <%= courseInningChange.getString("REFUNDTYPE").equals("N")? "selected":"" %>>일반환불</option>
						<option value="F" <%= courseInningChange.getString("REFUNDTYPE").equals("F")? "selected":"" %>>강제환불</option>
					</select>
			    </td>
			</tr>
			<tr>
				<th>환불사유</th>
				<td>
					<% if(v_refundtype.equals("F")) { %>
	             		<%=CommonUtil.getCodeListBoxWithOption("select","0087","p_refundreason", courseInningChange.getString("REFUNDREASON"),"","-선택-","disabled" )%>
	             	<% }else { %>
	             		<%=CommonUtil.getCodeListBox("select","0087","p_refundreason", courseInningChange.getString("REFUNDREASON"),"","-선택-" )%>
	             	<% } %>	
			    </td>
			    <th>환불금액</th>
				<td>
					<input name="p_refundamount" type="text" size="10" dataType="integer" dispName="환불금액" isNull="Y" value="<%=courseInningChange.getString("REFUNDAMOUNT")%>" <%=courseInningChange.getString("REFUNDTYPE").equals("F")?"readonly":"" %> />
			    </td>
			</tr>
			</table>
		  </div>
	    </td>
      </tr>	
    <!--  -->
    
    <!-- 라벨 -->
    <tr>
    	<td class="pad_left_15">
		<table width="1000" cellpadding="0" cellspacing="0" class="mar_top_15">
		<tr>
			<td width="15"><img src="/images/back/common/bullet_label.gif"></td>
			<td class="t_title">계산서신청</td>
		</tr>
		</table>
		</td>
    </tr>
    <!--  -->
    <!-- 계산서신청 -->
    <tr>
		<td class="pad_left_15">
			<div class="board-view">
			<table width="1000" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="200" />
				<col width="300" />
				<col width="200" />
				<col width="300" />			
			</colgroup>
			<tr>
				<th class="th_top_bd">계산서신청</th>
				<td class="td_top_bd">
            	    <input name="p_applygubun" type="radio" value="N" dispName="계산서신청"  <%=v_applygubun.equals("N")?"checked":(v_applygubun.equals("")?"checked":"") %> <%=v_display %> /> 필요없음 
	             	<input name="p_applygubun" type="radio" value="R" dispName="계산서신청"  <%=v_applygubun.equals("R")?"checked":"" %> <%=v_display %> /> 영수증
	             	<input name="p_applygubun" type="radio" value="C" dispName="계산서신청"  <%=v_applygubun.equals("C")?"checked":"" %> <%=v_display %> /> 현금영수증
	             	<input name="p_applygubun" type="radio" value="B" dispName="계산서신청"  <%=v_applygubun.equals("B")?"checked":"" %> <%=v_display %> /> 계산서
				</td>
				<th class="th_top_bd">계산서발행요청일</th>
				<td class="td_top_bd">
					<input name="p_billreqdt" type="text" size="20" dispName="요청일" lenCheck="10" maxLength="10" value="<%=v_billreqdt %>" /> ex) 20110101
				</td>
			</tr>
			<tr>
				<th>계산서발행여부</th>
				<td colspan="3">
            	    <input name="p_pubgubun" type="radio" value="N" dispName="발행구분"  <%=v_pubgubun.equals("N")?"checked":(v_pubgubun.equals("")?"checked":"") %> <%=v_display %> /> 미발행
	             	<input name="p_pubgubun" type="radio" value="Y" dispName="발행구분"  <%=v_pubgubun.equals("Y")?"checked":"" %> <%=v_display %> /> 발행
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
					<input name="p_regstno3" type="text" size="5" dataType="integer" dispName="사업자등록번호" isNull="N" lenCheck="5" maxLength="5" value="<%=v_regstno[2] %>"/>
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
<%   } %>   
    <!--  -->

	
	</table>			
    <!-- 버튼 -->
	<table width="100%" cellpadding="0" cellspacing="0" class="mar_top_10">
	<tr>
		<td align="center">
			<table cellpadding="0" cellspacing="0">
			<tr>
			  <td>
			   <%if(s_menucontrol.equals("RW") && !v_refundtype.equals("F") ) {%>
				<fmtag:button type="1" value="저장" func="applicationAcceptViewSave()" />&nbsp;
				<% } %>
				<%if(s_menucontrol.equals("RW") && (payStatus.equals("R") || payStatus.equals("P"))  ) {%>
				<fmtag:button type="1" value="환불요청취소" func="refundCancel()" />&nbsp;
				<% } %>
	  			<fmtag:button type="1" value="닫기" func="window.close()" />
	  			<%if(s_menucontrol.equals("RW") && (payStatus.equals("D"))  ) {%>
				<fmtag:button type="1" value="환불완료처리" func="refundFinish()" />
				<% } %>
				</td>
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
