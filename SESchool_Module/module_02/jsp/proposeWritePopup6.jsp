<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file = "/jsp/front/common/commonInc.jsp" %>
<%
	String status = "";
	String isonoff = box.getString("ISONOFF");
	
	Box boxProposeApplyInfo = (Box)box.getObject("boxProposeApplyInfo");
	
	String v_name = boxProposeApplyInfo.getString("NAME");
	String v_btobyn = boxProposeApplyInfo.getString("BTOBYN");
	String v_isdelivery = boxProposeApplyInfo.getString("ISDELIVERY");
	
	String v_cardmethod = boxProposeApplyInfo.getString("CARDMETHOD");
	String v_acntmethod = boxProposeApplyInfo.getString("ACNTMETHOD");
	String v_bankmethod = boxProposeApplyInfo.getString("BANKMETHOD");
	String payable = "Y";
	if ( v_cardmethod.equals("N") && v_acntmethod.equals("N") && v_bankmethod.equals("N") ) {
		payable = "N";
	}
	/*
	v_cardmethod = "Y";
	v_acntmethod = "Y";
	v_bankmethod = "Y";
	*/
	
	String  v_mileage = box.getStringDefault("p_mileage", "0");    // 적립된 마일리지
	String  v_ismileage = boxProposeApplyInfo.getString("ISMILEAGE");
	
	if ( G_TMPL.equals("") ) G_TMPL = "0";
	
	if ( box.getString("rn_resultMsg").trim().length() == 0 ) {
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- 브라우져결제 - 주석제거 -->
<meta http-equiv="Cache-Control" content="no-cache"/>  
<meta http-equiv="Expires" content="0"/>  
<meta http-equiv="Pragma" content="no-cache"/>
<title><%=PAGETITLE%></title>
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
<script language="Javascript" src="/js/home/template<%=G_TMPL%>.js"></script>
<fmtag:jscommon point="front" />
<fmtag:dwrcommon interfaceName="ProposeFWork"/>
<!-- 플러그인 6.0 위변조 모듈 : pay40_sec.js -->
<!-- <script language=javascript src="http://plugin.inicis.com/pay40_sec_uni.js"></script> -->
<!-- 브라우져결제 - 위의 pay40_sec_uni.js 제거  아래 js로 교체   -->
<script language=javascript src="http://plugin.inicis.com/pay61_secuni_cross.js"></script>
<script language=javascript> 
	StartSmartUpdate();
</script>
<script language=javascript>
	var openwin;

	function jsIniPayPrice(){
		var f				=	document.ini;		
		var param = {p_price:f.p_price.value
					,p_trainingclass:f.p_trainingclass.value };
		ProposeFWork.inipaySetPriceCallBack(param,jsIniPayPriceCall);
	}
	
	function jsIniPayPriceCall(data){		 
		var f				=	document.ini;
		var  tmp = data.split("|:");
		
		var filed = tmp[0];
		var tid = tmp[1];

		f.ini_encfield.value = filed;
		f.ini_certid.value = tid;
		
		pay();
	}
	function pay() {
		var f = document.ini;		
		<%
		// MakePayMessage()를 호출함으로써 플러그인이 화면에 나타나며, Hidden Field
		// 에 값들이 채워지게 됩니다. 일반적인 경우, 플러그인은 결제처리를 직접하는 것이
		// 아니라, 중요한 정보를 암호화 하여 Hidden Field의 값들을 채우고 종료하며,
		// 다음 페이지인 INIsecureresult.php로 데이터가 포스트 되어 결제 처리됨을 유의하시기 바랍니다.
		// 필수항목 체크 (상품명, 상품가격, 구매자명, 구매자 이메일주소, 구매자 전화번호)
		%>
		if ( document.ini.clickcontrol.value == "enable" ) {
			// 플러그인 설치유무 체크
			//if ( document.INIpay == null || document.INIpay.object == null ) {
			//브라우져결제 - 윗줄제거, 아래 주석제거
			if( ( navigator.userAgent.indexOf("MSIE") >= 0 || navigator.appName == 'Microsoft Internet Explorer' ) && (document.INIpay == null || document.INIpay.object == null) ) { // 플러그인 설치유무 체크 
				alert("\n이니페이 플러그인 128이 설치되지 않았습니다. \n\n안전한 결제를 위하여 이니페이 플러그인 128의 설치가 필요합니다. \n\n다시 설치하시려면 Ctrl + F5키를 누르시거나 메뉴의 [보기/새로고침]을 선택하여 주십시오.");
				return;
			}
			if ( f.buyeremail.value == "" ) {
				alert("이메일을 입력하세요.");
				$("p_email").focus();
				return;
			} else {
				var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
				if ( !regExp.test(document.ini.buyeremail.value) ) {
					alert ( "이메일주소를 확인해 주십시요" );
					$("p_email").focus();
					return;
				}
			}
			if( document.ini.buyertel.value == "" ) {
				alert("전화번호를 입력하세요.");
				$("p_handphone").focus();
				return;
			} else {
				var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
				if ( !regExp.test(document.ini.buyertel.value) ) {
					alert ( "핸드폰번호를 확인해 주십시요\n- 를 포함하여 입력해 주십시요" );
					$("p_handphone").focus();
					return;
				}
			}
			if($("f.p_rcvrzipcode1") && $("f.p_rcvrzipcode1").value == "") {
				alert("배송주소를 입력하세요.");
				return;
			}
			if($("p_rcvraddr") && $("p_rcvraddr").value == "") {
				alert("배송주소를 입력하세요.");
				return;
			}
			if($("p_rcvrtel1") && $("p_rcvrtel1").value == "") {
				alert("전화번호를 입력하세요.");
				$("p_rcvrtel1").focus();
				return;
			}
			if($("p_rcvrtel2") && $("p_rcvrtel2").value == "") {
				alert("전화번호를 입력하세요.");
				$("p_rcvrtel2").focus();
				return;
			}
			if($("p_rcvrtel3") && $("p_rcvrtel3").value == "") {
				alert("전화번호를 입력하세요.");
				$("p_rcvrtel3").focus();
				return;
			}
			if($("p_rcvrmobile1") && $("p_rcvrmobile1").value == "") {
				alert("전화번호를 입력하세요.");
				$("p_rcvrmobile1").focus();
				return;
			}
			if($("p_rcvrmobile2") && $("p_rcvrmobile2").value == "") {
				alert("전화번호를 입력하세요.");
				$("p_rcvrmobile2").focus();
				return;
			}
			if($("p_rcvrmobile3") && $("p_rcvrmobile3").value == "") {
				alert("전화번호를 입력하세요.");
				$("p_rcvrmobile3").focus();
				return;
			}
			
			var v_paymethod = $RF("ini", "p_paymethod");

			// 결제 금액이 "0" 원 && 차감된 마일리지가 0 보다 크면 전액 마일리지 결제 임. 
			if(document.ini.p_price.value == 0 && document.ini.p_usemileage.value > 0) {
				document.ini.p_paymethod.value = "9998";
				v_paymethod = "9998";
			}
			if ( v_paymethod == "100000000000" ) {											// 신용카드
				f.gopaymethod.value = "Card";
			} else if ( v_paymethod == "010000000000" || v_paymethod == "001000000000" ) { 	// 무통장이나 가상계좌
				f.gopaymethod.value = "VBank";
			}
			
			if($("p_rcvrzipcode1")) {
				if( $("p_rcvrzipcode2").value == null || $("p_rcvrzipcode2").value == ""){
					f.p_rcvrzipcode.value = $F("p_rcvrzipcode1");
				} else {
					f.p_rcvrzipcode.value = $F("p_rcvrzipcode1") + "-" + $F("p_rcvrzipcode2");
				}
			}
			if($("p_rcvrtel1")) {
				f.p_rcvrtel.value = f.p_rcvrtel1.value+"-"+f.p_rcvrtel2.value+"-"+f.p_rcvrtel3.value;
				f.p_rcvrmobile.value = f.p_rcvrmobile1.value+"-"+f.p_rcvrmobile2.value+"-"+f.p_rcvrmobile3.value;
			}
			
			// 무통장입금일 경우 결제프로세스를 타지 않는다.
			if ( v_paymethod == "001000000000" || v_paymethod == "9999" || v_paymethod == "9998") {   // 9998 : 전액 마일리지 결제	
				disable_click();				
				f.action = "/front/Propose.do?cmd=proposeWrite";
				//f.cmd.value = "proposeWrite";
				//f.target = "childwin";
				f.submit();
				f.target = "";

				return;
				
			} else {
				/******
				 * 플러그인이 참조하는 각종 결제옵션을 이곳에서 수행할 수 있습니다.
				 * (자바스크립트를 이용한 동적 옵션처리)
				 */				 	
				if ( MakePayMessage(f) ) {
					disable_click();
					
					//openwin = window.open("/jsp/common/INIpay50/childwin.html","childwin","width=299,height=149");
	
					f.action = "/front/Propose.do?cmd=proposeWrite";
					//f.cmd.value = "proposeWrite";
					//f.target = "childwin";
					f.submit();
					f.target = "";
					
				} else {
					//	 브라우져결제 - 주석제거 , 아래 경고창 제거
					if( IsPluginModule() )     //plugin타입 체크
					{
						alert("결제를 취소하셨습니다.");
					}
					
					//alert("결제를 취소하셨습니다.");
					return;
				}
			}
		} else {
			return;
		}
	}
	
	function enable_click() {
		document.ini.clickcontrol.value = "enable";
	}
	
	function disable_click() {
		document.ini.clickcontrol.value = "disable";
	}
	
	function focus_control() {
		if(document.ini.clickcontrol.value == "disable")
			openwin.focus();
	}
	
	function commify(n){
		var reg = /(^[+-]?\d+)(\d{3})/;
		n += '';
		while(reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
		return n;
	}
	
	function changeResidueMileage() {
		var f = document.ini;
		var objMileage = document.getElementById("reMileage");
		
		var total_mileage = '<%=v_mileage%>';		
		var usemileage = f.p_usemileage.value ; 
		if( !isNumber2(f.p_usemileage ) ){
			return; 
		}

		if( parseInt(usemileage) >  parseInt(total_mileage) ) {
			alert("차감할 마일리지가  "+ total_mileage +"M를  초과하였습니다");
			f.p_usemileage.value = '0';
			return;
		}
		objMileage.innerHTML = commify( parseInt(total_mileage) -  parseInt(usemileage) )+" M";
	}
	function checkMilage(){
		// 금액이 천원단위인지 확인한다. 
		// 차감할 마일리지 금액이 교육비보다 크면 교육비 만큼만 
		// 최종 결제 금액 변경하기.
		
		var f = document.ini;
		var v_usemileage = parseInt(f.p_usemileage.value) ;
		var old_price	 = parseInt(f.p_old_price.value) ;
		if(v_usemileage < 1000) {
			alert("마일리지는 1,000 M 이상 사용하셔야 합니다.");
			f.p_usemileage.value = 0; 
			return;
		}
		var v_tmp = parseInt(v_usemileage /1000) * 1000;

		if(v_usemileage != v_tmp ) {
			alert("사용할 마일리지 입력 시 1,000 M 단위로만 가능합니다.");
			f.p_usemileage.value = 0; 
			return;
		}
		if(old_price < v_usemileage ) {
			alert("마일리지는 교육비 이상 사용하실수 없습니다. ");
			f.p_usemileage.value = old_price;
			v_usemileage = old_price;
		}
		var last_price = old_price - v_usemileage;
		var objLastPrice = document.getElementById("LastPrice");	
		objLastPrice.innerHTML = commify( last_price )+" 원";

		var objMileage = document.getElementById("reMileage");
		var total_mileage = '<%=v_mileage%>';	
		objMileage.innerHTML = commify( parseInt(total_mileage) -  v_usemileage )+" M";
		f.p_price.value = last_price ;
	}
	
</script>
<script language="JavaScript" type="text/JavaScript">
<!--
	function MM_reloadPage(init) {  //reloads the window if Nav4 resized
	  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
	    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
	  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
	}
	MM_reloadPage(true);
	
	function MM_jumpMenu(targ,selObj,restore){ //v3.0
	  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
	  if (restore) selObj.selectedIndex=0;
	}
//-->
</script>
<script type="text/javascript">
	function validate(f) {
		var v_pricetype = $RF("form1", "p_pricetype");
		if ( v_pricetype == null || v_pricetype == "" ) {
			alert("수강금액을 선택해 주십시요");
			return false;
		}
		
		//교재 선택여부 확인
		for ( i=1; i <= 12; i++ ) {
			if($("p_bookmonth" + i)) {
				if($("p_bookmonth" + i).value == "") {
					alert(i+ "개월차 교재를 선택하세요.");
					return false; 
				}
			}
		}
		
		if($("p_rcvrzipcode1") && $("p_rcvrzipcode1").value == "") {
			alert("배송주소를 입력하세요.");
			return false;
		}
		if($("p_rcvraddr") && $("p_rcvraddr").value == "") {
			alert("배송주소를 입력하세요.");
			return false;
		}
		if($("p_rcvrtel1") && $("p_rcvrtel1").value == "") {
			alert("전화번호를 입력하세요.");
			$("p_rcvrtel1").focus();
			return false;
		}
		if($("p_rcvrtel2") && $("p_rcvrtel2").value == "") {
			alert("전화번호를 입력하세요.");
			$("p_rcvrtel2").focus();
			return false;
		}
		if($("p_rcvrtel3") && $("p_rcvrtel3").value == "") {
			alert("전화번호를 입력하세요.");
			$("p_rcvrtel3").focus();
			return false;
		}
		if($("p_rcvrmobile1") && $("p_rcvrmobile1").value == "") {
			alert("전화번호를 입력하세요.");
			$("p_rcvrmobile1").focus();
			return false;
		}
		if($("p_rcvrmobile2") && $("p_rcvrmobile2").value == "") {
			alert("전화번호를 입력하세요.");
			$("p_rcvrmobile2").focus();
			return false;
		}
		if($("p_rcvrmobile3") && $("p_rcvrmobile3").value == "") {
			alert("전화번호를 입력하세요.");
			$("p_rcvrmobile3").focus();
			return false;
		}
	
		return true;
	}

	function searchZipCode() {
		var url = "/front/Common.do?cmd=selectZipCode"; 
		Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
	}
	function setZipCodeInfo(addr, zipcode) {
		var form = document.ini;
		
		$("p_rcvraddr").setValue(addr);
		if(zipcode.search('-') > -1){	// 기존의 지번주소
			$("p_rcvrzipcode1").setValue(zipcode.substr(0, 3));
			$("p_rcvrzipcode2").setValue(zipcode.substr(4, 7));
		} else {						// 새로운 우편주소
			$("p_rcvrzipcode1").setValue(zipcode);
			$("p_rcvrzipcode2").setValue("");
			form.p_rcvrzipcode2.style.display="none";
		}
	}
	function checkIsDigit(obj) {
		var str = obj.value;
		for ( var i=0; i < str.length; i++ ) {
			if ( str.substr(i,1) == " " || isNaN(str.charAt(i)) ) {
				alert ("숫자만 입력할수 있습니다.");
				obj.value = str.substr(0,i);
				obj.focus();
				break;
			}
		}
	}
</script>
<script type="text/javascript">
	function setPopupSize() {
		window.resizeTo(550,500);
		enable_click();
		popupAutoResize();
	}
	Event.observe(window,"load", setPopupSize);
</script>
<a name="Top"></a>
<body style="margin:0px;" onfocus="javascript:focus_control()">
<form name="ini" method="post">
<input type="hidden" name="cmd" value="proposeWrite" />
<input type="hidden" name="p_proposetype" value="6" />
<input type="hidden" name="p_payprocess" value="6" />
<input type="hidden" name="p_subj" value="<%=boxProposeApplyInfo.getString("SUBJ")%>" />
<input type="hidden" name="p_year" value="<%=boxProposeApplyInfo.getString("YEAR")%>" />
<input type="hidden" name="p_gyear" value="<%=boxProposeApplyInfo.getString("YEAR")%>" />
<input type="hidden" name="p_subjseq" value="<%=boxProposeApplyInfo.getString("SUBJSEQ")%>" />
<input type="hidden" name="p_trainingclass" value="<%=boxProposeApplyInfo.getString("TRAININGCLASS")%>" />
<input type="hidden" name="p_installment_seq" value="<%=box.getString("p_installment_seq")%>" />
<input type="hidden" name="gopaymethod" value="" />
<input type="hidden" name="oid" value="<%=boxProposeApplyInfo.getString("MOID")%>" />
<input type="hidden" name="goodname" value="<%=boxProposeApplyInfo.getString("SUBJNM")%>" />
<input type="hidden" name="buyername" value="<%=boxProposeApplyInfo.getString("NAME")%>" />
<input type="hidden" name="buyeremail" value="<%=boxProposeApplyInfo.getString("EMAIL")%>" />
<input type="hidden" name="buyertel" value="<%=boxProposeApplyInfo.getString("HANDPHONE")%>" />
<input type="hidden" name="p_rcvrtel" value="" />
<input type="hidden" name="p_rcvrmobile" value="" />
<input type="hidden" name="p_rcvrzipcode" value="" />
<input type="hidden" name="p_old_price" value="<%=boxProposeApplyInfo.getString("PRICE")%>" />
<%	if ( box.getString("_where").equals("B") ) { %>
<input type="hidden" name="_where" value="<%=box.getString("_where")%>" />
<input type="hidden" name="p_userid" value="<%=box.getString("p_userid")%>" />
<input type="hidden" name="p_comp" value="<%=box.getString("p_comp")%>" />
<%	} %>
<!--  opener 가 팝업인지 확인  -->
<input type="hidden" name="p_ppopup" value="<%=box.getString("p_ppopup")%>" />
<!--//-->
 
<table width="100%" height="100%" cellpadding="0" cellspacing="0">
<tr>
	<td align="center" height="100%" valign="top">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="42" background="/images/common/popup_header_bg.gif">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/template0/common/popup_goldpath_title.gif" alt="골드패스" /></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="100%" valign="top" align="center" style="padding:20px;">
				<!-- 개인정보확인 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/template0/common/popup_approve_label01.gif"></td>
				</tr>
				<tr><td height="5"></td></tr>
				</table>
 
				<div class="board-list-popup">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<caption>수강신청 - 개인정보확인</caption>
					<colgroup>
						<col width="120" />
						<col width="" />
					</colgroup>
					<tr>
						<th>이름</th>
						<td class="td_lefttext2"><%=boxProposeApplyInfo.getString("NAME") %></td>
					</tr>
					<tr>
						<th>신청과정명</th>
						<td class="td_lefttext2"><%=boxProposeApplyInfo.getString("SUBJNM") %></td>
					</tr>
					<tr>
						<th>회사명</th>
						<td class="td_lefttext2"><%=boxProposeApplyInfo.getString("COMPNM") %></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td class="td_lefttext2">
					<%	if ( !boxProposeApplyInfo.getString("EMAIL").equals("") ) { %>
					<%=boxProposeApplyInfo.getString("EMAIL") %>
					<%	} else { %>
							<input type="text" name="p_email" value="<%=boxProposeApplyInfo.getString("EMAIL") %>" style="border:solid 1px #d7d7d7; background-color:#FFFFFF; width:300px; height:20px;" onkeyup="document.ini.buyeremail.value=this.value">
					<%	} %>
						</td>
					</tr>
					<tr>
						<th>휴대폰</th>
						<td class="td_lefttext2">
					<%	if ( !boxProposeApplyInfo.getString("HANDPHONE").equals("") ) { %>
						<%=boxProposeApplyInfo.getString("HANDPHONE") %>
					<%	} else { %>
							<input name="p_handphone" style="width:300px;" onkeyup="document.ini.buyertel.value=this.value"/>
					<%	} %>
						</td>
					</tr>
					</table>
				</div>
			<%	if ( false && v_isdelivery.equals("Y") ) { %>
				<!-- 배송상품 및 배송지 정보확인 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td><img src="/images/template0/common/popup_approve_label02.gif"></td>
				</tr>
				<tr><td height="5"></td></tr>
				</table>
 
				<div class="board-list-popup">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<caption>수강신청 - 개인정보확인</caption>
					<colgroup>
						<col width="120" />
						<col width="" />
					</colgroup>
					<!-- tr>
						<th>배송상품(교재명)</th>
						<td class="td_lefttext2"><%=boxProposeApplyInfo.getString("NAME")%></td>
					</tr-->
					<tr>
						<th>배송주소</th>
						<td class="td_lefttext2">
							
							<% if( boxProposeApplyInfo.getString("POST2") == null || boxProposeApplyInfo.getString("POST2").equals("") ){ %>
								<input type="text" name="p_rcvrzipcode1" id="p_rcvrzipcode1" value="<%=boxProposeApplyInfo.getString("POST1") %>" style="width:60px;" readonly>
								<input type="hidden" name="p_rcvrzipcode2" id="p_rcvrzipcode2"  value="<%=boxProposeApplyInfo.getString("POST2") %>" >
							<% } else { %>
								<input type="text" name="p_rcvrzipcode1" id="p_rcvrzipcode1" value="<%=boxProposeApplyInfo.getString("POST1") %>" style="width:60px;" readonly>
								-
								<input type="text" name="p_rcvrzipcode2" id="p_rcvrzipcode2"  value="<%=boxProposeApplyInfo.getString("POST2") %>" style="width:60px;" readonly>
							<% } %>	
							<a href="#none" onclick="searchZipCode()"><img src="/images/template0/common/btn_popup_search_3.gif" align="absmiddle" vspace="3"></a><br/>
							<input type="text" name="p_rcvraddr" id="p_rcvraddr"  value="<%=boxProposeApplyInfo.getString("ADDR") %>" style="width:360px;">
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td class="td_lefttext2">
							<input type="text" name="p_rcvemail" value="<%=boxProposeApplyInfo.getString("EMAIL") %>" style="border:solid 1px #d7d7d7; background-color:#FFFFFF; width:300px; height:20px;">
						</td>
					</tr>
					<%
						String[] arrPhone = boxProposeApplyInfo.getString("HOMETEL").split("-");
						String[] arrHandPhone = boxProposeApplyInfo.getString("HANDPHONE").split("-");
					%>
					<tr>
						<th>전화번호</th>
						<td class="td_lefttext2">
							<input name="p_rcvrtel1" type="text" size="4" dataType="integer" dispName="연락처" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>=2)?arrPhone[0]:"" %>" style="width:40px;" onkeyup="checkIsDigit(this);"> -
							<input name="p_rcvrtel2" type="text" size="4" dataType="integer" dispName="연락처" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>=2)?arrPhone[1]:"" %>" style="width:60px;" onkeyup="checkIsDigit(this);"/> -
							<input name="p_rcvrtel3" type="text" size="4" dataType="integer" dispName="연락처" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>=3)?arrPhone[2]:"" %>" style="width:60px;" onkeyup="checkIsDigit(this);"/>
						</td>
					</tr>
					<tr>
						<th>휴대폰</th>
						<td class="td_lefttext2">
							<input name="p_rcvrmobile1" type="text" size="4" dataType="integer" dispName="핸드폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=2)?arrHandPhone[0]:"" %>" style="width:40px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_rcvrmobile2" type="text" size="4" dataType="integer" dispName="핸드폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=2)?arrHandPhone[1]:"" %>" style="width:60px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_rcvrmobile3" type="text" size="4" dataType="integer" dispName="핸드폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=3)?arrHandPhone[2]:"" %>" style="width:60px;" onkeyup="checkIsDigit(this);"/>
						</td>
					</tr>
					</table>
				</div>
			<%	} %>
				<!-- 배송상품 및 배송지 정보확인 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td><img src="/images/template0/common/popup_edu_label01.gif"></td>
				</tr>
				<tr><td height="5"></td></tr>
				</table>
 
				<div class="board-list-popup">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<caption>교육비정보</caption>
					<colgroup>
						<col width="120" />
						<col width="" />
					</colgroup>
					<tr>
					<td style="padding-left:10px; color:#696969; background-color: #eeeeee; border-right: solid 1px #959595; border-bottom: solid 1px #959595;">교육비구분</td>
					<td style="padding:8px; border-bottom: solid 1px #959595;"> 교육비</td>
					</tr>
					<tr bgcolor="#eeeeee">
						<td style="padding-left:10px; color:#696969; background-color: #eeeeee; border-right: solid 1px #959595; border-bottom: solid 1px #959595;">코스과정</td>
						<td style="padding:8px; border-bottom: solid 1px #959595; font-weight:bold;"><%=StringUtil.getMoneyType(boxProposeApplyInfo.getString("PRICE")) %> 원</td>
					</tr>
					<!--  마일리지  시작  -->
			<% 
				//  v_ismileage = "Y";
				if(v_ismileage.equals("Y")) { 
			%>
					<tr bgcolor="#eeeeee">
						<td colspan="2" style="padding-left:10px; color:#696969; padding-top:5px;">현재 <span style="color: #11818e;"><%=v_name %></span> 님의 적립된 마일리지는 <span style="color: #11818e;"><%=StringUtil.getMoneyType(v_mileage) %> M </span>입니다.</td>					
					</tr>
				<% if(Integer.parseInt(v_mileage) >= 1000) { %>	
					<tr bgcolor="#eeeeee">
						<td colspan="2" style="padding-left:10px; color:#696969; padding-top:5px; padding-bottom:8px;">차감할 마일리지는 <input type="text" name="p_usemileage" value="0" dataType="integer" dispName="차감할 마일리지"  style="text-align: right; padding-right:5px; border:solid 1px #a8abad; width:50px; height:19px;" onKeyup ="changeResidueMileage()" onBlur="checkMilage()">M 이고 
							차감 후 잔여 마일리지는 <span style="color: #11818e;" id="reMileage"><%=StringUtil.getMoneyType(v_mileage) %> M </span>입니다.</td>
					</tr>
				<% } else { %>	
						<input type="hidden" name="p_usemileage" value="0">
				<% }%>
					<tr bgcolor="#eeeeee">
						<td colspan="2" style="padding-left:10px; color:#696969; padding-top:5px; padding-bottom:8px; border-bottom: solid 1px #959595;">* 사용할 마일리지 입력 시 1,000 M 단위 이상으로만 가능합니다.</td>
					</tr>
			<% }else { %>	
					<input type="hidden" name="p_usemileage" value="0" >
			<% }%>	
					<!--  마일리지 종료  -->
					<tr>
						<td style="padding-left:10px; color:#696969; font-weight:bold; border-right: solid 1px #959595; border-bottom: solid 1px #696969;">최종 결제금액</td>
						<td style="padding:8px; border-bottom: solid 1px #696969;  font-weight:bold;" id="LastPrice" > <%=StringUtil.getMoneyType(boxProposeApplyInfo.getString("PRICE")) %> 원</td>
					</tr>
					</table>
				</div>
				
				<table width="100%" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td style="border: solid 1px #c7c7c7; line-height:20px; font-size:11px; padding:5px;">
						<table width="100%" cellpadding="0" cellspacing="0">
						<tr>
							<td width="10" style="padding-left:5px; padding-right:20px;"><img src="/images/template0/common/popup_approve_label03.gif" alt="결재정보 타이틀" /></td>
							<td>
							<%	if ( box.getString("_where").equals("B") ) { %>
								<input type="radio" name="p_paymethod" value="100000000000" style="border:none;" checked> 신용카드&nbsp;&nbsp;&nbsp;
								<input type="radio" name="p_paymethod" value="001000000000" style="border:none;" checked> 무통장&nbsp;&nbsp;&nbsp;
								<input type="radio" name="p_paymethod" value="010000000000" style="border:none;" checked> 가상계좌
							<%	} else { %>
								<%if(v_cardmethod.equals("Y")){%><input type="radio" name="p_paymethod" value="100000000000" style="border:none;" checked> 신용카드&nbsp;&nbsp;&nbsp;<%}%>
								<%if(v_acntmethod.equals("Y")){%><input type="radio" name="p_paymethod" value="010000000000" style="border:none;" checked> 가상계좌&nbsp;&nbsp;&nbsp;<%}%>
								<%if(v_bankmethod.equals("Y")){%><input type="radio" name="p_paymethod" value="001000000000" style="border:none;" checked> 무통장<%}%>
							<%	} %>
							</td>
							<td align="right">
								<%if(true||payable.equals("Y")){%><a href="#none" onclick="jsIniPayPrice();"><img src="/images/common/btn_account_05.gif" alt="결제하기 버튼" /></a><%}else{%>결제할 수단이 없습니다.<%}%>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="25" background="/images/common/popup_footer_bg.gif" style="padding-left:20px; padding-right:20px;">
				<table width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/common/popup_footer_copyright.gif"></td>
					<td align="right">
						<a href="javascript:self.close();"><img src="/images/common/btn_popup_close.gif"></a></td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<div id="sbHtml" name="sbHtml" >
<%=((StringBuilder)box.getObject("sbHtml")).toString()%>
</div>
<input type="hidden" name="p_price" value="<%=boxProposeApplyInfo.getString("PRICE")%>"/>
</form>
</body>
</html>
<%	} else { %>
<html>
<head>
<title>INIpay50 데모</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-- 브라우져결제 - 주석제거 -->
<meta http-equiv="Cache-Control" content="no-cache"/>  
<meta http-equiv="Expires" content="0"/>  
<meta http-equiv="Pragma" content="no-cache"/> 
<link rel="stylesheet" href="css/group.css" type="text/css">
<style>
body, tr, td {font-size:10pt; font-family:굴림,verdana; color:#433F37; line-height:19px;}
table, img {border:none}

/* Padding ******/
.pl_01 {padding:1 10 0 10; line-height:19px;}
.pl_03 {font-size:20pt; font-family:굴림,verdana; color:#FFFFFF; line-height:29px;}

/* Link ******/
.a:link  {font-size:9pt; color:#333333; text-decoration:none}
.a:visited { font-size:9pt; color:#333333; text-decoration:none}
.a:hover  {font-size:9pt; color:#0174CD; text-decoration:underline}

.txt_03a:link  {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:visited {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:hover  {font-size: 8pt;line-height:18px;color:#EC5900; text-decoration:underline}
</style>
</head>
<body>
<center>
<table align='center' width="70%">
    <tr>
        <td>암호화 필수항목 누락 및 비정규 형식에 따른 에러 발생입니다. 확인 바랍니다.<br/><%=box.getString("rn_resultMsg")%>
        </td>
    </tr>
</table>
</center>
</body>
</html>
<%	} %>