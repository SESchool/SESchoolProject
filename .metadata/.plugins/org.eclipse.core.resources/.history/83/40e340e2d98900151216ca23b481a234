<%--
 * @(#)Sample Template
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * TC_ 테이블 List Template.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2010. 11. 21.  bgcho       Initial Release
 ************************************************
--%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file = "/jsp/front/common/commonInc.jsp" %>
<%
	String status = "";
	String isonoff = box.getString("ISONOFF");
	
	Box boxProposeApplyInfo = (Box)box.getObject("boxProposeApplyInfo");
	DataSet dsSubjectListBook = (DataSet)box.getObject("dsSubjectListBook");
	DataSet dsDiscountSubj = (DataSet)box.getObject("dsDiscountSubj");
	
	String v_name = boxProposeApplyInfo.getString("NAME");
	String v_subj = boxProposeApplyInfo.getString("SUBJ");
	String v_btobyn = boxProposeApplyInfo.getString("BTOBYN");
	String v_isdelivery = boxProposeApplyInfo.getString("ISDELIVERY");
	
	String v_saleviewyn1 = boxProposeApplyInfo.getString("SALEVIEWYN1");
	String v_saleviewyn2 = boxProposeApplyInfo.getString("SALEVIEWYN2");
	
	String v_saleamt1 = boxProposeApplyInfo.getString("SALEAMT1");
	String v_saleamt2 = boxProposeApplyInfo.getString("SALEAMT2");
	
	String v_personcost = boxProposeApplyInfo.getString("PERSONCOST");	// 개인수강지원금 YN
	String v_commcost = boxProposeApplyInfo.getString("COMMCOST");		// 능력개발카드 환급 YM
	String v_goyongcost = boxProposeApplyInfo.getString("GOYONGCOST");	// 고용보험환급 YN
	String v_cardcost = boxProposeApplyInfo.getString("CARDCOST");		// 일반 YN
	
	String v_resno1 = (boxProposeApplyInfo.getString("RESNO").length() >= 6) ? boxProposeApplyInfo.getString("RESNO").substring(0,6) : "";
	String v_resno2 = (boxProposeApplyInfo.getString("RESNO").length() >= 13) ? boxProposeApplyInfo.getString("RESNO").substring(6,13) : "";
	
	String[] arrPhone = boxProposeApplyInfo.getString("HOMETEL").split("-");
	String[] arrCompPhone = boxProposeApplyInfo.getString("COMTEL").split("-");
	String[] arrHandPhone = boxProposeApplyInfo.getString("HANDPHONE").split("-");
	
	String  v_mileage = box.getStringDefault("p_mileage", "0");    // 적립된 마일리지
	DecimalFormat df = new DecimalFormat("#,###,##0");
	String v_mileage2 = df.format(Double.parseDouble(v_mileage));

	String  v_ismileage = boxProposeApplyInfo.getString("ISMILEAGE");
	
	if ( G_TMPL.equals("") ) G_TMPL = "1";
	
	boolean blIsITmaster = false;
	if ( boxProposeApplyInfo.getString("TRAININGCLASS").equals("10") || v_subj.equals("906") || v_subj.equals("3") || v_subj.equals("907") || v_subj.equals("905") || v_subj.equals("908") ) {
		blIsITmaster = true;
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=PAGETITLE%></title>
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
<script language="Javascript" src="/js/home/template<%=G_TMPL%>.js"></script>
<script language="Javascript" src="/js/common/prototype.js"></script>
<script type='text/javascript' src="/js/home/jquery-1.4.min.js"></script>
<fmtag:jscommon point="front" />
<script type="text/javascript">
	var office_post = "<%=boxProposeApplyInfo.getString("ZIP") %>";
	var office_addr = "<%=boxProposeApplyInfo.getString("COMPADDR") %>";
	
	var home_post1 = "<%=boxProposeApplyInfo.getString("POST1") %>";
	var home_post2 = "<%=boxProposeApplyInfo.getString("POST2") %>";
	var home_addr = "<%=boxProposeApplyInfo.getString("ADDR") %>";
	
	var handphone1 = "<%=(arrHandPhone.length>=2)?arrHandPhone[0]:"" %>";
	var handphone2 = "<%=(arrHandPhone.length>=2)?arrHandPhone[1]:"" %>";
	var handphone3 = "<%=(arrHandPhone.length>=3)?arrHandPhone[2]:"" %>";
	var hometel1 = "<%=(arrPhone.length>=2)?arrPhone[0]:"" %>";
	var hometel2 = "<%=(arrPhone.length>=2)?arrPhone[1]:"" %>";
	var hometel3 = "<%=(arrPhone.length>=3)?arrPhone[2]:"" %>";
	var comptel1 = "<%=(arrCompPhone.length>=2)?arrCompPhone[0]:"" %>";
	var comptel2 = "<%=(arrCompPhone.length>=2)?arrCompPhone[1]:"" %>";
	var comptel3 = "<%=(arrCompPhone.length>=3)?arrCompPhone[2]:"" %>";
	
	var email = "<%=boxProposeApplyInfo.getString("EMAIL") %>";
	
	function changeAddr() {
		var form = document.form1;
		var addr_type = $RF("form1", "addr_type");
			
		if(addr_type == "H") {
			$("p_rcvraddr").value = home_addr;
			$("p_rcvrzipcode1").value = home_post1;
			$("p_rcvrzipcode2").value = home_post2;
			$("p_rcvrtel1").value = hometel1;
			$("p_rcvrtel2").value = hometel2;
			$("p_rcvrtel3").value = hometel3;
			$("p_rcvrmobile1").value = handphone1;
			$("p_rcvrmobile2").value = handphone2;
			$("p_rcvrmobile3").value = handphone3;
		} else if(addr_type == "C") {
			if( office_post != null && office_post != "-"){
				if( office_post.search('-') > -1 ){
					$("p_rcvrzipcode1").value = office_post.substring(0, office_post.indexOf('-'));
					$("p_rcvrzipcode2").value = office_post.substring(office_post.indexOf('-')+1, office_post.length);
				} else if( office_post.length > 5){
					$("p_rcvrzipcode1").value = office_post.substring(0, 3);
					$("p_rcvrzipcode2").value = office_post.substring(3, office_post.length);
				} else {
					$("p_rcvrzipcode1").value = office_post;
					$("p_rcvrzipcode2").value = "";
				}
			} else {
				$("p_rcvrzipcode1").value = "";
				$("p_rcvrzipcode2").value = "";
			}
			$("p_rcvraddr").value = office_addr;
			$("p_rcvrtel1").value = comptel1;
			$("p_rcvrtel2").value = comptel2;
			$("p_rcvrtel3").value = comptel3;
			$("p_rcvrmobile1").value = handphone1;
			$("p_rcvrmobile2").value = handphone2;
			$("p_rcvrmobile3").value = handphone3;
		} else if(addr_type == "N") {
			$("p_rcvraddr").value = "";
			$("p_rcvrzipcode1").value = "";
			$("p_rcvrzipcode2").value = "";
			$("p_rcvrtel1").value = "";
			$("p_rcvrtel2").value = "";
			$("p_rcvrtel3").value = "";
			$("p_rcvrmobile1").value = "";
			$("p_rcvrmobile2").value = "";
			$("p_rcvrmobile3").value = "";
		}
		
	}

	/**
	 1001 - PERSONCOST - 멤버
	 1002 - COMMCOST 개인수강금
	 1003 - GOYONGCOST 고용보험
	 1004 - CARDCOST 일반
	*/
	function proposeWrite(v_costsupport) {
		
		var form = document.form1;
		
		//수강신청 버튼 이 활성화 상태가 아니면 리턴
		if(document.getElementById("propbtn").src.indexOf("_off")>0){
			return;
		}
		
		

		if(!validate(form)) return;
		
		//첨부파일 첨부여부 체크
		/*
		파일첨부 없이 등록 가능하게수정
		if(form.p_fileadd.value == 'Y'){
			if(!fileAddCheck()){
				return;	
			}		
		}
		else{
			alert("첨부파일은 Fax로 송부 바랍니다\n Fax : ");
		} */
		
		//alert("여기까지왔으면 된거아니니?!");
		//return;
		
		if($("p_rcvrzipcode1")) {
			if( $("p_rcvrzipcode2").value == null || $("p_rcvrzipcode2").value == ""){
				form.p_rcvrzipcode.value = $F("p_rcvrzipcode1");
			} else {
				form.p_rcvrzipcode.value = $F("p_rcvrzipcode1") + "-" + $F("p_rcvrzipcode2");
			}
		}
		
		form.p_hometel.value = form.p_hometel1.value + "-" + form.p_hometel2.value + "-" + form.p_hometel3.value;
		form.p_handphone.value = form.p_handphone1.value + "-" + form.p_handphone2.value + "-" + form.p_handphone3.value;
		form.p_addr.value = form.p_addr1.value + "" + form.p_addr2.value;
		
		if ( form.p_authnum != undefined && form.p_authnum.value == "" ) {
			form.p_authtype.value = "";
		}
		
		form.p_costsupport.value = v_costsupport;
		form.p_bookpricesum.value = doBookPriceCalc();
		form.p_totprice.value = doPriceCalc() - parseInt( form.p_usemileage.value); 

		if ( form.p_rcvrtel1 != undefined ) {
			form.p_rcvrtel.value = form.p_rcvrtel1.value+"-"+form.p_rcvrtel2.value+"-"+form.p_rcvrtel3.value;
			form.p_rcvrmobile.value = form.p_rcvrmobile1.value+"-"+form.p_rcvrmobile2.value+"-"+form.p_rcvrmobile3.value;
		}
		
		form.p_deptnam.value = form.v_deptnam.value;
		form.p_jikcheknm.value = form.v_jikcheknm.value;
		
		form.action = "/front/Propose.do?cmd=proposeWrite&p_proposetype=2&subj="+form.p_subj.value+"&year="+form.p_year.value+"&subjseq="+form.p_subjseq.value+"&p_ppopup="+form.p_ppopup.value;
		form.cmd.value = "proposeWrite";
		
		form.submit();
		
	}
	
	function validate(f) {
		var v_pricetype = $RF("form1", "p_pricetype");
		if ( v_pricetype == null || v_pricetype == "" ) {
			alert("수강금액을 선택해 주십시요");
			return false;
		}
		
		if ( v_pricetype == "98" ) {
			if ( f.p_regchkyn.value == "N" ) {
				alert ( "무역협회회원사 인증을 해 주십시요" );
				return false;
			}
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
		
		if($("p_hometel1") && $("p_hometel1").value == "") {
			alert("전화번호를 입력하세요");
			$("p_hometel1").focus();
			return false;
		}
		
		if($("p_hometel2") && $("p_hometel2").value == "") {
			alert("전화번호를 입력하세요");
			$("p_hometel2").focus();
			return false;
		}
		
		if($("p_hometel3") && $("p_hometel3").value == "") {
			alert("전화번호를 입력하세요");
			$("p_hometel3").focus();
			return false;
		}

		if( $("p_email") ) {
			if ( $("p_email").value == "" ) {
				alert("이메일을 입력하세요.");
				$("p_email").focus();
				return false;
			} else {
				var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
				if ( !regExp.test(f.p_email.value) ) {
					alert ( "이메일주소를 확인해 주십시요" );
					$("p_email").focus();
					return;
				}
			}
		}
		
		if($("p_compnm")) {
			if($("p_compnm").value == "") {
				alert("회사/학교명을 입력하세요");
				$("p_compnm").focus();
				return false;
			}
		}
		
		if($("p_handphone1") && $("p_handphone1").value == "") {
			alert("휴대전화번호를 입력하세요");
			$("p_handphone1").focus();
			return false;
		}
		
		if($("p_handphone2") && $("p_handphone2").value == "") {
			alert("휴대전화번호를 입력하세요");
			$("p_handphone2").focus();
			return false;
		}
		
		if($("p_handphone3") && $("p_handphone3").value == "") {
			alert("휴대전화번호를 입력하세요");
			$("p_handphone3").focus();
			return false;
		}
		
	/* 	if($("p_zipcode1") && $("p_zipcode1").value == "") {
			alert("우편번호를 입력하세요");
			$("p_zipcode1").focus();
			return false;
		}
	*/
		
		/* if($("p_addr1") && $("p_addr1").value == "") {
			alert("주소를 입력하세요");
			$("p_addr1").focus();
			return false;
		}
		
		if($("p_addr2") && $("p_addr2").value == "") {
			alert("상세 주소를 입력하세요");
			$("p_addr2").focus();
			return false;
		} */
		
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
		document.domain = "tradecampus.kita.net";
	}
	
	function searchZipCode2() {
		var url = "/front/Common.do?cmd=selectZipCode2"; 
		Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
	}
	
	function setZipCodeInfo(addr, zipcode) {
		var form = document.form1;
		
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
	
	function setZipCodeInfo2(addr, zipcode) {
		var form = document.form1;
		
		$("p_addr1").setValue(addr);
		if(zipcode.search('-') > -1){	// 기존의 지번주소
			$("p_zipcode1").setValue(zipcode.substr(0, 3));
			$("p_zipcode2").setValue(zipcode.substr(4, 7));
		} else {						// 새로운 우편주소
			$("p_zipcode1").setValue(zipcode);
			$("p_zipcode2").setValue("");
			form.p_zipcode2.style.display="none";
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
	
	function commify(n){
		var reg = /(^[+-]?\d+)(\d{3})/;
		n += '';
		while(reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
		return n;
	}

	// 교재비 계산
	function doBookPriceCalc() {
		var objBookAppYn = document.getElementsByName("p_bookappyn");
		var bookprice = 0;
		var tmp = 0;
		var objTmp = "";
		for ( var i=0; i < objBookAppYn.length; i++ ) {
			objTmp = objBookAppYn[i];
			tmp = (objTmp.checked) ? objTmp.value.substr(objTmp.value.lastIndexOf('_')+1, objTmp.value.length) : 0;
			bookprice += parseInt(tmp);
		}
		return bookprice;
	}

	// 교육비 계산
	function doPriceCalc() {
		var f = document.form1;
		var v_bookprice = doBookPriceCalc();
		var v_pricetype = $RF("form1", "p_pricetype");

		var v_totprice = 0;
		if ( v_pricetype == "98" ) {
			v_totprice = f.p_memberbiyong.value;
		} else if ( v_pricetype == "99" ) {
			v_totprice = f.p_biyong.value;
		} else {
			var objSpecialPrice = eval("f.p_special_"+v_pricetype);
			v_totprice = objSpecialPrice.value;
		}
		
		v_totprice = parseInt(v_totprice) + v_bookprice;

		return v_totprice;
	}
	
	function updatePrice(obj) {
		var f = document.form1;
		var v_pricetype = $RF("form1", "p_pricetype");

		if ( v_pricetype == null || v_pricetype == "" ) {
			alert("교육비구분을 선택해 주십시요");
			obj.checked = !obj.checked;
			return;
		}
		
		var objPrice = document.getElementById("LastPrice");
		
		var v_totprice = objPrice.innerHTML.replace(/[, 원]*/g, '');
		var v_bookprice = obj.value.substr(obj.value.lastIndexOf('_')+1, obj.value.length);
		v_bookprice = (!obj.checked) ? parseInt(-v_bookprice) : v_bookprice;
		v_totprice = parseInt(v_totprice)+parseInt(v_bookprice);
		
		objPrice.innerHTML = commify(v_totprice)+" 원";
	}
	
	function disableGoYongBtn() {
		var v_trainingclass = document.form1.p_trainingclass.value;
		var objGoYongImg = document.getElementById("imgGoYong");
		if ( objGoYongImg.use == "Y" ) {
			objGoYongImg.src = objGoYongImg.src.replace(/btn_account_02.gif/, 'btn_account_02_off.gif');
			objGoYongImg.onclick = "";
			objGoYongImg.style.cursor = "";
		}
	}
	function enableGoYongBtn() {
		var v_trainingclass = document.form1.p_trainingclass.value;
		var objGoYongImg = document.getElementById("imgGoYong");
		if ( objGoYongImg.use == "Y" ) {
			objGoYongImg.src = objGoYongImg.src.replace(/btn_account_02_off.gif/, 'btn_account_02.gif');
			objGoYongImg.onclick = function(){proposeWrite('1003')};
			objGoYongImg.style.cursor = "hand";
		}
	}
	// 회원사 : 98
	// 일반 : 99
	function changeCostSupport(obj) {
		var f = document.form1;
		var v_trainingclass = f.p_trainingclass.value;
		var objAAuth = document.getElementById("aAuth");
		var v_pricetype = $RF("form1", "p_pricetype");
		var objPrice = document.getElementById("spanPrice");
		var objLastPrice = document.getElementById("LastPrice");
		var goyongYN = "<%=v_goyongcost%>";
		//goyongYN = "N";
		changeKitaMember(v_pricetype);
		var v_totprice = 0;
		objPrice.style.display = "";
		if ( v_pricetype == "98" ) {
			if ( f.p_regchkyn.value == "N" ) {
				var msg = "무역협회 회원사를 인증해 주십시요";
				if ( v_trainingclass == "09" && goyongYN == "Y" ) {
					msg += "\n\n이러닝과정은 특별할인 적용 시 고용보험환급을 받으실 수 없습니다.";
					disableGoYongBtn();
				}
				alert ( msg );
			}
			f.p_authnum.focus();
		} else if ( goyongYN == "Y" ) {
			if ( v_pricetype == "99" ) {
				enableGoYongBtn();
			} else if ( v_pricetype != "99" && v_trainingclass == "09" ) {
				disableGoYongBtn();
				alert ( "이러닝과정은 특별할인 적용 시 고용보험환급을 받으실 수 없습니다." );
			}
		}/* else if ( v_pricetype == "일반" && goyongYN == "Y" ) {
			enableGoYongBtn();
		} else if ( v_pricetype != "일반" && v_trainingclass == "09" && goyongYN == "Y" ) {
			disableGoYongBtn();
			alert ( "이러닝과정은 특별할인 적용 시 고용보험환급을 받으실 수 없습니다." );
		}*/

		v_totprice = doPriceCalc();
		
		objPrice.innerHTML = commify(v_totprice)+" 원";
		objLastPrice.innerHTML = commify(v_totprice)+" 원";
		<% if(v_ismileage.equals("Y") ) {%>
		var objMileage = document.getElementById("reMileage");
		objMileage.innerHTML = commify(<%=v_mileage%>)+" M";
		<% }%>
		f.p_usemileage.value = 0; 
		
	}
	
	function doAuthCheck() {
		var f = document.form1;
		var f2 = document.form2;
		//var v_authtype = $RF("form1","p_authtype");
		var v_authtype = f.p_authtype.value;
		var v_authnum = f.p_authnum.value;
		f2.p_authnum.value = v_authnum;
		f2.p_authtype.value = v_authtype;
		
		if ( v_authnum == "" ) {
			alert ( "회원사번호나 사업자등록번호를 입력해 주십시요" );
			return;
		}
		if ( v_authtype == "" || v_authtype == null ) {
			alert ( "회원사번호인지 사업자등록번호인지 선택해 주십시요" );
			return;
		}
		
 		var url = "/front/Propose.do?cmd=doKitaAuthCheck";
		 
		
		  
		var _ajax = new Ajax.Request (
				url
				, { method:'post'
					//, parameters:Form.serialize('form2')		
					, parameters: jQuery("#form2").serialize()	//익스플로러10에 적용안되서 jQuery 이용하여 수정 - 20130515
					, onSuccess: function(contents) {
						var ret = contents.responseText.substr(0,1);
						if ( ret == "Y" ) {
							f.p_regchkyn.value = "Y";
							var rets = contents.responseText.split('||'); //회원사 이름 기입하기 - 2015.08.04 by 안성현
							document.getElementById("p_compnm").value = rets[1];
							document.getElementById("p_compnm").disabled='disabled';
							alert ( "무역협회 회원사로 확인 되었습니다.\n직장/학교 란에 '"+rets[1]+"' 이(가) 기입됩니다.");
							//인증 완료 후 step2보이기
							document.getElementById("step2").style.display="block";
						} else if (ret == "M"){
							f.p_regchkyn.value = "N";
							f.p_authnum.value = "";
							alert ( "회비 미납중입니다.\n회비 납부후 할인을 받으실 수 있습니다.\n회비 납부 등 자세한 사항은 1566-5114로 문의하시기 바랍니다." );
						} else {
							f.p_regchkyn.value = "N";
							f.p_authnum.value = "";
							alert ( "무역협회 회원사가 아닙니다." );
						}
					}
				}
		);
	}
	//무역마스터 인증
	function doTradeMasterCheck() {
		var f = document.form1;
		var f3 = document.form3;
		
 		var url = "/front/Propose.do?cmd=doTradeGraduCheck";		 
		
		var _ajax = new Ajax.Request (
				url
				, { method:'post'
					//, parameters:Form.serialize('form2')		
					, parameters: jQuery("#form3").serialize()
					, onSuccess: function(contents) {
						var ret = contents.responseText.substr(0,1);
						/* alert(contents.responseText); */
						if ( ret == "Y" ) {
							f.p_trademastercheck.value = "Y";
							f.p_trademasterseq.value = contents.responseText.substr(1, contents.responseText.length);
							alert ( "무역마스터 "+contents.responseText.substr(1, contents.responseText.length)+"기로 확인 되었습니다" );
							goStep(2, 'trademaster', '');
						} else {
							f.p_trademastercheck.value = "N";
							alert ( "무역마스터 학생이 아닙니다" );
						}
					}
				}
		);
	}

	function doSaveAnswerQuality() {
		var f = document.form1;
		var url = "/front/StudyQnaBoard.do?cmd=doSaveAnswerQuality";
		var _ajax = new Ajax.Request (
				url
				, { method:'post'
					, parameters:Form.serialize('form1')
					, onSuccess: function(contents) {  
						alert ( contents.responseText );
					}
				}
		);
	}

	function changeResidueMileage() {
		var f = document.form1;
		
		var v_pricetype = $RF("form1", "p_pricetype");
		var objMileage = document.getElementById("reMileage");
		
		if(v_pricetype == "" || v_pricetype == null ) {
			alert("교육비 구분을  먼저 선택해 주세요"); 
			f.p_usemileage.value = '0';
			return; 
		}
		var total_mileage = '<%=v_mileage%>';
		var midprice =  doPriceCalc();
		var usemileage = f.p_usemileage.value ; 
		if( !isNumber2(f.p_usemileage ) ){
			return; 
		}

		if( parseInt(usemileage) >  parseInt(total_mileage) ) {
			alert("차감할 마일리지가  "+ total_mileage +"M를  초과하였습니다");
			f.p_usemileage.value = '0';
			return;
		}
		
		if(usemileage != "") {
			objMileage.innerHTML = commify( parseInt(total_mileage) -  parseInt(usemileage) )+" M";	
		}
	}
	
	function checkMilage(){
		// 금액이 천원단위인지 확인한다. 
		// 차감할 마일리지 금액이 교육비보다 크면 교육비 만큼만 
		// 최종 결제 금액 변경하기.
		
		var f = document.form1;
		var v_usemileage = parseInt(f.p_usemileage.value) ;
		var v_totprice = doPriceCalc();
		var v_pricetype = $RF("form1", "p_pricetype");
		var objMileage = document.getElementById("reMileage");
		var objLastPrice = document.getElementById("LastPrice");
		
		if(v_pricetype == "" || v_pricetype == null ) {
			f.p_usemileage.value = '0';
			return; 
		}
		
		if(v_usemileage != 0 && v_usemileage < 1000) {
			alert("마일리지는 1,000 M 이상 사용하셔야 합니다.");
			f.p_usemileage.value = 0; 
			objLastPrice.innerHTML = commify(doPriceCalc() )+" 원";
			return;
		}
		/*
		var v_tmp = parseInt(v_usemileage /1000) * 1000;

		if(v_usemileage != v_tmp ) {
			alert("사용할 마일리지 입력 시 1,000 M 단위로만 가능합니다.");
			f.p_usemileage.value = 0; 
			objLastPrice.innerHTML = commify(doPriceCalc() )+" 원";
			return;
		}
		*/
		
		if((v_totprice - v_usemileage) < 0) {
			alert("마일리지 사용은 총 교육 금액을 초과할 수 없습니다.");
			f.p_usemileage.value = 0; 
			objLastPrice.innerHTML = commify(doPriceCalc() )+" 원";
			return;
		}
			
		objLastPrice.innerHTML = commify(doPriceCalc()- v_usemileage )+" 원";
	}
	

	/*
	' ------------------------------------------------------------------
	' Function    : fc_chk_byte()
	' Description : 입력한 글자수를 체크
	' Argument    : Object Name(글자수를 제한할 컨트롤)
	' Return      :
	' ------------------------------------------------------------------
	*/
	function fc_chk_byte(is)
	{
	   var f = document.form1;
	   var ls_str     = is.value; // 이벤트가 일어난 컨트롤의 value 값
	   var li_str_len = ls_str.length;  // 전체길이
	   // 변수초기화
	   var li_max      = 1500; // 제한할 글자수 크기  ex)2000
	   var i           = 0;  // for문에 사용
	   var li_byte     = 0;  // 한글일경우는 2 그밗에는 1을 더함
	   var li_len      = 0;  // substring하기 위해서 사용
	   var ls_one_char = ""; // 한글자씩 검사한다
	   var ls_str2     = ""; // 글자수를 초과하면 제한할수 글자전까지만 보여준다.

	   for(i=0; i< li_str_len; i++)
	   {
	      // 한글자추출
	      ls_one_char = ls_str.charAt(i);

	      // 한글이면 2를 더한다.
	      if (escape(ls_one_char).length > 4){
	         li_byte += 2;
		  }else if(ls_one_char != '\r'){
			li_byte++;
		  }
		//  alert("현재 바이트: "+li_byte)

	      // 전체 크기가 li_max를 넘지않으면
	      if(li_byte <= li_max)
	      {
	         li_len = i + 1;
	      }
	   }

	   //document.all.recv_no.value=li_byte; //확인용

	   // 전체길이를 초과하면
	   if(li_byte > li_max)
	   {
	      alert( li_max + " byte를 초과 입력할수 없습니다. \n 초과된 내용은 자동으로 삭제 됩니다. ");
	      ls_str2 = ls_str.substr(0, li_len);
	      is.value = ls_str2;
	      f.byte1.value = ls_str2.length;
	      is.focus();
	   }else{
		   f.byte1.value = li_byte; 
	   }


	}// --- end --- fc_chk_byte ---
	
</script>
<script type="text/javascript">
	function setPopupSize() {
		window.resizeTo(700,500);
		popupAutoResize();
	}
	Event.observe(window,"load", setPopupSize);
</script>
<script type="text/javascript">
	function changeKitaMember(cost) {
		var blIsITmaster = <%=blIsITmaster%>
		if (!blIsITmaster) {
			if (cost == "98" || cost=="33") { //협회 회원사 이거나 회원사이면서 선수과정 신청Y인경우
				ctl = document.getElementById("kitamember");
				ctl.style.display = "block";
			} else {
				ctl = document.getElementById("kitamember");
				ctl.style.display = "none";
			}	
		}
	}
</script>


<script type="text/javascript">
/* 외환관리사 과정 전용 스크립트 */

//금액선택 스크립트 - 설문내역에따라 결제금액을 바꿔줘야할때 써야한단다
function checkMoney(targetcd){
	var checkcheck = document.form1.p_pricetype;
	var iii = false;
	for(var xx=0; xx<document.form1.p_pricetype.length; xx++){			
		if(checkcheck[xx].value==targetcd){
			checkcheck[xx].checked =true;
			changeCostSupport(checkcheck[xx]);
			iii = true;
		}
	}	
	return iii;
	
}

//라디오박스 기타영역  disable 스크립트
function goCheckValue(aa){
	var checkObj = document.getElementsByName(aa.name);
	var objlength = checkObj.length;
	for(var xxx=0; xxx<objlength; xxx++){			
		if(checkObj[xxx].checked==true && xxx ==objlength-1 ){
			document.getElementsByName(aa.name+"Value")[0].value="";
			document.getElementsByName(aa.name+"Value")[0].disabled =false;
		}else{
			document.getElementsByName(aa.name+"Value")[0].value="";	//객체가 하나기때문에 0번째설정
			document.getElementsByName(aa.name+"Value")[0].disabled =true;									
		}
	}
}
//div이동 스크립트
function goPayInfo(aa, bb){
	//aa==열어야할 div
	//bb==닫아야할 div
	var form = document.form1;
	if(aa==2){	//교육비 정보 가기전 수강신청서 페이지 유효성체크
		if(!validate(form)) return;
		
		if(form.p_engname.value==""){
			alert("영문명을 입력해주세요");
			form.p_engname.focus();
			return;
		}
	
		var obj = null;
		var objlength = 0;
		var checkis = false;
		//직군 입력 유효성체크
		obj = document.getElementsByName("p_jikgun");
		objlength = obj.length;
		for(var i = 0; i<objlength; i++){
			if(obj[i].checked ==true){
				checkis = true;
				if(obj[i].value=="기타" && document.getElementsByName("p_jikgunValue")[0].value.replace(" ","")=="" ){
					checkis = false;
				}				
			}
		}
		if(checkis==false){
			alert("직군을 입력해 주세요 ");
			return;
		}
		checkis=false;
	
		//필수항목 설문조사(sulmun1~sulmun3) 유효성체크
		
		for(var i = 1; i<=3; i++){
			obj = document.getElementsByName("sulmun"+i);
			objlength = obj.length;
			for(var j=0; j<objlength ; j++){
				if(obj[j].checked==true){
					if(obj[j].value==0 && document.getElementsByName("sulmun"+i+"Value")[0].value.replace(" ","")=="" ){
						checkis = false;
					}else{
						checkis = true;
					}
				}				
			}
			if(checkis==false){
				alert("설문조사 "+i+"번을 입력해 주세요");
				return;
			}
			checkis=false;
		}
		
	
	}else if(aa==1){	//교육비정보페이지 유효성체크
		
	}
	document.getElementById("viewDiv"+aa).style.display = "block";
	document.getElementById("viewDiv"+bb).style.display = "none";				
}

//다음 DIV열기
function goStep(a, b, c, d){
	var f = document.form1;
	
	//이버튼을 클릭하면 결제버튼이 활성화 안되어야함
	if(document.getElementById("propbtn").src.indexOf("_off")<0){
		document.getElementById("propbtn").src = document.getElementById("propbtn").src.replace(".gif", "_off.gif");
	}
	
	//첨부파일 정보 숨기기
	document.getElementById("banker_file").style.display = "none";
	f.p_bankerrealname.value = "";	
	document.getElementById("fxmlicense_file").style.display = "none";
	f.p_fxmlicenserealname.value = "";	
	document.getElementById("collegian_file").style.display = "none";
	f.p_collegianrealname.value = "";	
	document.getElementById("kitamember_file").style.display = "none";
	f.p_proofemprealname.value = "";	
	f.p_bizlicenserealname.value = "";		
	
	//첫번째 setp선택한경우 인증한정보값삭제
	if(a==2){
		f.p_fxmlicense.value = "";
	}
	
	//b:회원구분 의 값이 공백이 아닐경우 회원정보 셋팅
	
	if(b!=''){
		f.p_memberinfo.value=b;
	}
	//현재 클릭한 라디오 버튼보다 하위스텝 숨기기
	for(var x=a; x<6 ; x++){	
		document.getElementById("step"+x).style.display = "none";	 
		var sulmObj = document.getElementsByName("sulmun"+(a+3));	
		//해당스텝의 라디오박스 체크 해제
		for(var z = 0; z<sulmObj.length; z++){
			sulmObj[z].checked = false;
		}
	}
	
	//회원사 아닐경우에 회원사인증 숨기기
	//alert(f.p_memberinfo.value+f.p_regchkyn.value);
	if(f.p_memberinfo.value!='kitamember'){
		changeKitaMember(1000);
	} 
	
	if(f.p_memberinfo.value=='trademaster' && f.p_trademastercheck.value=="N"){//무역마스터면서 인증안되었으면 인증버튼보이기
		document.getElementById("trademastermember").style.display = "block";
		return;
	}else{
		document.getElementById("trademastermember").style.display = "none";
	}
	
	//무역마스터이면서 인증된사용자라면 바로 결제로 이동
	if(b=='trademaster' && f.p_trademastercheck.value=="Y"){
		var sulmObj = document.getElementsByName("sulmun6");
		//설문6번(선수과정여부) Y로 고정
		for(var z = 0; z<sulmObj.length; z++){
			if(sulmObj[z].value=="1"){
				sulmObj[z].checked = true;
			}
		}
		goProposeFinal('Y', 4);	//무역마스터이면 선수과정 수강여부는 Y
		return;
	}
	
	
	if(f.p_memberinfo.value=='kitamember' && f.p_regchkyn.value !="Y"){	//회원사이면서 인증안된사람은 인증폼보이기
		changeKitaMember(98);	//회원사일경우 인증 페이지 보이기
		return;
	}else if(f.p_memberinfo.value=='kitamember' && f.p_regchkyn.value =="Y"){
		changeKitaMember(98);	//회원사일경우 인증 페이지 보이기
	}
	
	
	//자격증 정보 넘어오면 자격증 유무 셋팅
	if(c!=''){
		f.p_fxmlicense.value = c;
	}
	
	//자격증없으면 4step 없이 바로 결제show 
	if(c=='N' && a==3){	// 선수과목 수강여부는 No
		var sulmObj = document.getElementsByName("sulmun6");	
		//설문6번(선수과정여부) Y로 고정
		for(var z = 0; z<sulmObj.length; z++){
			if(sulmObj[z].value=="1"){
				sulmObj[z].checked = true;
			}
		}
		goProposeFinal('Y', 4);
		return;
	}
	
	document.getElementById("step"+a).style.display = "block";
	
	
	
}

//자격시험 과정 수강신청 버튼
function goProposeFinal(a, b){
	var f = document.form1;
	f.p_fxmedu.value = a;
	//자격증 정보가 있거나, 회원사, 대학생일경우 step4열기
	if(f.p_fxmlicense.value=='Y' || f.p_memberinfo.value=='collegian' || f.p_memberinfo.value=='kitamember' || f.p_memberinfo.value == 'banker'){
		goStep(b, '', '', '');
		if(f.p_fxmlicense.value=='Y'){
			//자격시험 파일업로드 부분 보이기
			document.getElementById("fxmlicense_file").style.display = "block";
		}							
		if(f.p_memberinfo.value=='collegian'){
			//대학생 재학증명서 파일업로드 보이기
			document.getElementById("collegian_file").style.display = "block";
		}
		if(f.p_memberinfo.value=='kitamember'){
			document.getElementById("kitamember").style.display = "block";
			//회원사 인증관련 첨부파일 정보 보이기
			document.getElementById("kitamember_file").style.display = "block";
		}
		if(f.p_memberinfo.value=='banker'){
			//대학생 재학증명서 파일업로드 보이기
			document.getElementById("banker_file").style.display = "block";
		}
	}
	//최종 결제금액 결정
	/* 일반 - 99
	일반 - 선수과정 참여자 - 34
	회원사 - 98
	회원사 - 선수과정참여자 - 33
	대학생 - 11
	대학생 - 선수과정 참여자 - 35
	무역마스터 - 10 
	금융관련업종 => 14	
	*/
	var iii = false;
	if(f.p_memberinfo.value=='trademaster'){	//무역마스터
		iii= checkMoney('10');
	}else if(f.p_memberinfo.value=='normal'){//일반
		if(f.p_fxmedu.value=='Y'){	//선수과정참여자
			iii= 	checkMoney('99');
		}else{
			iii= checkMoney('34');								
		}
	}else if(f.p_memberinfo.value=='collegian'){//대학생
		if(f.p_fxmedu.value=='Y'){	//선수과정참여자
			iii= checkMoney('11');
		}else{
			iii= checkMoney('35');								
		}
	}else if(f.p_memberinfo.value=='kitamember'){//회원사
		if(f.p_fxmedu.value=='Y'){	//선수과정참여자
			iii= checkMoney('98');
		}else{
			iii= checkMoney('33');								
		}
	}else if(f.p_memberinfo.value=='banker'){//금융사관련
		if(f.p_fxmedu.value=='Y'){	//선수과정참여자
			iii= checkMoney('14');
		}else{
			iii= checkMoney('38');								
		}
	}else{
		alert("오류입니다 관리자에게 문의하세요\nTel : 02-6000-7139"+f.p_memberinfo.value);
		return;
	}
	if(iii==false){
		alert("교육비 정보가 없습니다");
		return;
	}
	
	//최종결제금액보이기
	document.getElementById("step5").style.display = "block";
	//신청하기 버튼 on
	document.getElementById("propbtn").src = document.getElementById("propbtn").src.replace("_off", "");
		
}

//첨부파일 첨부 여부 체크 스크립트
function fileAddCheck(){
	var f = document.form1;
	if(f.p_fxmlicense.value=='Y' && f.p_fxmlicenserealname.value ==""){	//자격증
		alert("자격증 파일을 첨부해주세요");
		return false;
	}							
	if(f.p_memberinfo.value=='collegian' && f.p_collegianrealname.value==""){ //대학생증명
		alert("재학 또는 휴학증명서를 첨부해주세요");
		return false;
	}
	if(f.p_memberinfo.value=='banker' && f.p_bankerrealname.value==""){ //금융사 재직증명서
		alert("재직증명서를 첨부해주세요");
		return false;
	}
	if(f.p_memberinfo.value=='kitamember' && (f.p_proofemprealname.value=="" || f.p_bizlicenserealname.value=="" )){ //회원사증명
		alert("회원사 첨부파일을 첨부해주세요");
		return false;
	}
	return true;
}

//첨부파일 첨부할지 말지 선택(수강신청 수강신청서 이미지 옆에 숨겨져있음)
function changeFileAdd(){
	var f = document.form1;
	if(confirm("첨부파일 없이 진행하시겠습니까?")){
		f.p_fileadd.value = 'N';
	}else{
		f.p_fileadd.value = 'Y';
	}
}




//문자 보내기
function sendSMS(){
	var f				=	document.form4;
	var ff = document.form1;
	
	/* 핸드폰번호체크 */
	if(ff.p_handphone1.value =="" || ff.p_handphone2.value =="" || ff.p_handphone3.value==""){
		alert("핸드폰번호를 입력하세요");
	}
	f.p_userinfo.value = '<%=box.getString("p_userid")%>/<%=box.getString("p_userid")%>/ /'+ff.p_handphone1.value + "-" + ff.p_handphone2.value + "-" + ff.p_handphone3.value;
	f.p_receiver.value = ff.p_handphone1.value + "-" + ff.p_handphone2.value + "-" + ff.p_handphone3.value;

	if(f.p_sendphone.value=="") {
		alert('보내는 전화번호을 입력해 주세요.');
		return ;
	}

  	var regExp = "";
	//regExp = /[0-9]-[0-9]{3,4}-[0-9]{4}/;
	regExp = /[0-9][0-9]{3,4}[0-9]{4}/;
	if ( !regExp.test(f.p_sendphone.value) ) {
		alert(f.p_sendphone.value);
		alert ( "보내는 전화번호 형식이 잘못되었습니다." );
		return ;
	}

	var url = "/front/Propose.do?cmd=sendLocationSMS";
	
	//문자발송
	var _ajax = new Ajax.Request (
			url
			, { method:'post'
				//, parameters:Form.serialize('form2')		
				, parameters: jQuery("#form4").serialize()	//익스플로러10에 적용안되서 jQuery 이용하여 수정 - 20130515
				, onSuccess: function(contents) {
					var ret = contents.responseText.substr(contents.responseText.length-2, 1);
					if ( ret > 0 ) {
						alert ( "발송되었습니다");
					} else {
						alert ( "발송에 실패하였습니다");
					}
				}
			}
	);
	 return;

   /* var v_userinfo = f.p_userinfo; */
   /* for(var i =0; i < v_userinfo.options.length;i++){
      v_userinfo.options[i].selected = true;
   } */
   
}

</script>

</head>
<a name="Top"></a>
<body style="margin:0px;" onLoad="changeCostSupport('99')">
<form name="form1" id="form1" method="post" enctype="multipart/form-data">
<input type="hidden" name="cmd" value="proposeWrite" />
<input type="hidden" name="p_proposetype" value="2" />
<input type="hidden" name="p_maxfilesize" value="10" />
<input type="hidden" name="p_isonoff" value="<%=boxProposeApplyInfo.getString("ISONOFF")%>" />
<input type="hidden" name="p_subj" value="<%=boxProposeApplyInfo.getString("SUBJ")%>" />
<input type="hidden" name="p_year" value="<%=boxProposeApplyInfo.getString("YEAR")%>" />
<input type="hidden" name="p_gyear" value="<%=boxProposeApplyInfo.getString("YEAR")%>" />
<input type="hidden" name="p_subjseq" value="<%=boxProposeApplyInfo.getString("SUBJSEQ")%>" />
<input type="hidden" name="p_subjnm" value="<%=boxProposeApplyInfo.getString("SUBJNM")%>" />
<input type="hidden" name="p_trainingclass" value="<%=boxProposeApplyInfo.getString("TRAININGCLASS")%>" />
<input type="hidden" name="p_hometel" value="" />
<input type="hidden" name="p_handphone" value="" />
<input type="hidden" name="p_addr" value="" />
<input type="hidden" name="p_costsupport" value="" />
<input type="hidden" name="p_rcvrtel" value="" />
<input type="hidden" name="p_rcvrmobile" value="" />
<input type="hidden" name="p_rcvrzipcode" value="" />
<input type="hidden" name="p_regchkyn" value="N" />
<input type="hidden" name="p_bookpricesum" value="" />
<input type="hidden" name="p_totprice" value="" />
<input type="hidden" name="p_deptnam" value="" />
<input type="hidden" name="p_jikcheknm" value="" />
<input type="hidden" name="p_memberinfo" value="" />	<!-- 설문의 회원정보 구분 --> 
<input type="hidden" name="p_trademastercheck" value="N" />	<!-- 무역마스터여부 --> 
<input type="hidden" name="p_trademasterseq" value="N" />	<!-- 무역마스터기수 --> 
<input type="hidden" name="p_fxmlicense" value="" />	<!-- 설문의 외환관련 자격증 정보 구분 --> 
<input type="hidden" name="p_fxmedu" value="" />	<!-- 설문의 외환관리사 선수과정 신청여부 --> 
<input type="hidden" name="p_fileadd" value="Y" />	<!-- 첨부파일 등록여부 --> 
<%	if ( box.getString("_where").equals("B") ) { %>
<input type="hidden" name="_where" value="<%=box.getString("_where")%>" />
<input type="hidden" name="p_userid" value="<%=box.getString("p_userid")%>" />
<input type="hidden" name="p_comp" value="<%=box.getString("p_comp")%>" />
<%	} %>
<!--//-->
<!--  opener 가 팝업인지 확인  -->
<input type="hidden" name="p_ppopup" value="<%=box.getString("p_ppopup")%>" />
<input type="hidden" name="isView" value="N">
<table width="100%" height="100%" cellpadding="0" cellspacing="0">
<tr>
	<td align="center" height="100%" valign="top">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="42" background="/images/common/popup_header_bg.gif">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<!-- 첨부파일 없이 진행하려면 아래 점 클릭 -->
					<td><img src="/images/common/popup_lecture_title.gif"></td><td><a onclick="changeFileAdd()">.</a></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="100%" valign="top" align="center" style="padding:20px;">
			
			
			
			
			<!--수강신청DIV -->
			<div  id="viewDiv1">
				<!-- 수강신청서 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_lecture_label01.gif"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-top:10px; padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="15" />
							<col width="80" />
							<col width="" />
						</colgroup>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_sinchung_lecture_name.gif"></td>
							<td><%=boxProposeApplyInfo.getString("SUBJNM")%></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_name.gif"></td>
							<td><%=boxProposeApplyInfo.getString("NAME")%></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:3px;"><img src="/images/common/txt_eng_name.gif"></td>
							<td>
								<input type="text" name="p_engname" id="p_engname" value="<%=boxProposeApplyInfo.getString("ENGNAME") %>" style="width:360px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"></td>
							<td align="center" style="padding-top:5px;"></td>
							<td align="left" colspan="2" style="color: red;">
								※ 자격증 발급을 위해 영문명을 정확히 입력해주시기 바랍니다
							</td>
						</tr>
						
						
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_email.gif"></td>
							<td><input type="text" name="p_email" style="width:250px;" maxLength="100" value="<%=boxProposeApplyInfo.getString("EMAIL") %>"></td>
						</tr>
						
						<!-- 직군추가 (자격시험 설문에 추가될사항)-->
						<tr valign="top" height="50">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_jikgun.gif"></td>
							<td>
							
								<input type="radio" name="p_jikgun"   onclick="goCheckValue(this)" value="대학생" style="border: 0px;" />대학생&nbsp;&nbsp;&nbsp;
								<input type="radio" name="p_jikgun"  onclick="goCheckValue(this)"  value="금융기관(은행)"  style="border: 0px;" />금융기관(은행)&nbsp;&nbsp;
								<input type="radio" name="p_jikgun"  onclick="goCheckValue(this)"  value="금융관련 회사"  style="border: 0px;" />금융관련 회사&nbsp;&nbsp;
								<input type="radio" name="p_jikgun"  onclick="goCheckValue(this)"  value="일반 기업체 임직원"  style="border: 0px;" />일반 기업체 임직원&nbsp;&nbsp;<br />
								<input type="radio" name="p_jikgun"  onclick="goCheckValue(this)"   value="무역마스터"  style="border: 0px;" />무역마스터&nbsp;&nbsp;
								<input type="radio" name="p_jikgun" onclick="goCheckValue(this)"  value="기타"  style="border: 0px;" />기타
								<input type="text" name="p_jikgunValue" value="" disabled="disabled">
							</td>
						</tr>
						
						<!-- //직군추가 -->
						
						
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_compnm.gif"></td>
							<td><input type="text" name="p_compnm" id="p_compnm" style="width:250px;" maxLength="200" value="<%=boxProposeApplyInfo.getString("COMPNM") %>"></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_dept_name.gif"></td>
							<td><input type="text" name="v_deptnam" style="width:250px;" maxLength="200" value="<%=boxProposeApplyInfo.getString("DEPTNAM") %>"></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_jikchek_name.gif"></td>
							<td><input type="text" name="v_jikcheknm" style="width:250px;" maxLength="200" value="<%=boxProposeApplyInfo.getString("JIKCHEKNM") %>"></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_mobile.gif"></td>
							<td>
								<input type="text" name="p_handphone1" size="4" dataType="integer" dispName="핸드폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=2)?arrHandPhone[0]:"" %>" style="width:40px;" onkeyup="checkIsDigit(this);"> -
								<input type="text" name="p_handphone2" size="4" dataType="integer" dispName="핸드폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=2)?arrHandPhone[1]:"" %>" style="width:40px;" onkeyup="checkIsDigit(this);"> -
								<input type="text" name="p_handphone3" size="4" dataType="integer" dispName="핸드폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=2)?arrHandPhone[2]:"" %>" style="width:40px;" onkeyup="checkIsDigit(this);">
								<input type="button" value="약도전송" onclick="sendSMS()" />
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_phone.gif"></td>
							<td>
								<input type="text" name="p_hometel1" size="4" dataType="integer" dispName="연락처" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>2)?arrPhone[0]:"" %>" style="width:40px;" onkeyup="checkIsDigit(this);"> -
								<input type="text" name="p_hometel2" size="4" dataType="integer" dispName="연락처" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>2)?arrPhone[1]:"" %>" style="width:40px;" onkeyup="checkIsDigit(this);"> -
								<input type="text" name="p_hometel3" size="4" dataType="integer" dispName="연락처" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>2)?arrPhone[2]:"" %>" style="width:40px;" onkeyup="checkIsDigit(this);">
							</td>
						</tr>
						<tr valign="top" height="26" style="display: none;">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_home_address.gif"></td>
							<td>
								<% if( boxProposeApplyInfo.getString("POST2") == null || boxProposeApplyInfo.getString("POST2").equals("") ){ %>
									<input type="text" name="p_zipcode1" id="p_zipcode1" value="<%=boxProposeApplyInfo.getString("POST1") %>" style="width:60px;" readonly />
									<input type="hidden" name="p_zipcode2" id="p_zipcode2" value="<%=boxProposeApplyInfo.getString("POST2") %>" />	
								<% } else { %>
									<input type="text" name="p_zipcode1" id="p_zipcode1" value="<%=boxProposeApplyInfo.getString("POST1") %>" style="width:60px;" readonly>
									-
									<input type="text" name="p_zipcode2" id="p_zipcode2"  value="<%=boxProposeApplyInfo.getString("POST2") %>" style="width:60px;" readonly>
								<% } %>
								<a href="#none" onclick="searchZipCode2()"><img src="/images/common/btn_popup_search_2.gif" alt="우편번호찾기"/></a>
							</td>
						</tr>
						<!-- 주소 숨기기 -->
						<tr valign="top" height="26" style="display: none;">
							<td align="center" style="padding-top:5px;"></td>
							<td style="padding-top:4px;"></td>
							<td>
								<input type="text" name="p_addr1" id="p_addr1"  value="<%=boxProposeApplyInfo.getString("ADDR") %>" style="width:360px;" readonly>
								<input type="text" name="p_addr2" id="p_addr2"  value="<%=boxProposeApplyInfo.getString("ADDR2") %>" style="width:360px;">
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>
				<!-- //수강신청서 -->
				
				<!-- 수강설문 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td><img src="/images/common/popup_lecture_label07.gif" alt="수강정보"></td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<%
				if(boxProposeApplyInfo.getString("SUBJ").equals("145") && boxProposeApplyInfo.getString("SUBJSEQ").equals("0048")){
				%>
				<tr><td height="20" style="color:red; font-weight: bold;">
					※ 이 과정은 특별과정으로 외환은행 직원만을 위한 과정입니다.
				</td></tr>
				<%} %>
				<tr>
					<td style="padding-top:20px; padding-bottom:5px;">
						<h5>1. 본 교육과정을 신청하시는 목적은 무엇입니까?(*)</h5>
					</td>
				</tr>
				<tr>
					<td style="padding-left:20px;">
						<input type="radio" style="border:none;" name="sulmun1" value="1" onclick="goCheckValue(this)" />관련업무 활용
						<input type="radio" style="border:none;" name="sulmun1" value="2" onclick="goCheckValue(this)" />승진 등 인사상의 혜택
						<input type="radio" style="border:none;" name="sulmun1" value="3" onclick="goCheckValue(this)" />취업준비
						<input type="radio" style="border:none;" name="sulmun1" value="0" onclick="goCheckValue(this)" />기타 
						<input type="text" name="sulmun1Value" style="width:150" maxLength="60" disabled="true">					
					</td>
				</tr>
				<tr>
					<td style="padding-top:20px; padding-bottom:5px;">
						<h5>2. 어떤 경로를 통해 본 교육과정에 대한 정보를 얻으셨습니까?(*)</h5>
					</td>
				</tr>
				<tr>
					<td style="padding-left:20px;">
						<input type="radio" style="border:none;" name="sulmun2" value="1" onclick="goCheckValue(this)" />인터넷 검색
						<input type="radio" style="border:none;" name="sulmun2" value="2" onclick="goCheckValue(this)" />홍보 이메일 수신
						<input type="radio" style="border:none;" name="sulmun2" value="3" onclick="goCheckValue(this)" />무역협회 홈페이지(kita.net)<br>
						<input type="radio" style="border:none;" name="sulmun2" value="4" onclick="goCheckValue(this)" />사내인트라넷 공지사항
						<input type="radio" style="border:none;" name="sulmun2" value="5" onclick="goCheckValue(this)" />지인추천
						<input type="radio" style="border:none;" name="sulmun2" value="6" onclick="goCheckValue(this)" />회사의 업무규정
						<input type="radio" style="border:none;" name="sulmun2" value="0" onclick="goCheckValue(this)" />기타
						<input type="text"  name="sulmun2Value" style="width:150" maxLength="50" disabled="true">			
					</td>
				</tr>
				<tr>
					<td style="padding-top:20px; padding-bottom:5px;">
						<h5>3. 본 자격증 취득을 위한 사전 준비는 어떻게 하셨나요?(*)</h5>
					</td>
				</tr>
				<tr>
					<td style="padding-left:20px;">
						<input type="radio" style="border:none;" name="sulmun3" value="1" onclick="goCheckValue(this)" />타 외환자격증 취득
						<input type="radio" style="border:none;" name="sulmun3" value="2" onclick="goCheckValue(this)" />외환관련 과정 이수
						<input type="radio" style="border:none;" name="sulmun3" value="3" onclick="goCheckValue(this)" />회사 외환업무 수행<br>
						<input type="radio" style="border:none;" name="sulmun3" value="4" onclick="goCheckValue(this)" />회사내 외환매뉴얼 숙지
						<input type="radio" style="border:none;" name="sulmun3" value="0" onclick="goCheckValue(this)" />기타
						<input type="text"  name="sulmun3Value" style="width:150" maxLength="50" disabled="true">
					</td>
				</tr>
				<tr><td height="20"></td></tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>
				<!-- //수강설문 -->
				
				<!-- 교육비선택버튼 -->
				<table width="100%" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td align="center">
						<img src="/images/common/btn_selectEduInfo.gif" onclick="goPayInfo(2, 1)" alt="교육비선택" style="cursor:hand"/>
					</td>
				</tr>
				</table>
				<!-- 교육비선택버튼 -->
				</div>
				<!-- //수강신처어 DIV -->
				
				
				
				<!-- 교육비정보 -->
				<div style="display: none;" id="viewDiv2">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:10px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr><td><img src="/images/common/popup_lecture_label06.gif"></td></tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				</table>
				<!-- Step1 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0"  id="step1">
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr><td height="3"></td></tr>				
				<tr>
					<td align="left">
						<img src="/images/common/btn_step1.gif"  alt="회원구분" style="cursor:hand"/>
					</td>
				</tr>				
				<tr>
					<td style="padding-left:20px; padding-top:15px; padding-bottom:5px;">
					
						<input type="radio" style="border:none;" name="sulmun4" value="1"  onclick="goStep(2, 'normal', '')" />일반
						<input type="radio" style="border:none;" name="sulmun4" value="2" onclick="goStep(2, 'kitamember', '')" />회원사
						<input type="radio" style="border:none;" name="sulmun4" value="3"  onclick="goStep(2, 'collegian', '')"  />대학생
						<input type="radio" style="border:none;" name="sulmun4" value="4"  onclick="goStep(2, 'trademaster', '')" />무역마스터
						<!-- 금융관련업 할인 추가  -->
						<input type="radio" style="border:none;" name="sulmun4" value="5"  onclick="goStep(2, 'banker', '')" />금융기관(은행)
						<input type="button" value="인증하기" onclick="doTradeMasterCheck()"  id="trademastermember" style="display: none;" />						
					</td>
				</tr>
				<tr><td>
					<!-- 회원사인증 -->
					<table id="kitamember" style="display:none" width="100%" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="12" />
							<col width="" />
						</colgroup>
						<tr valign="top">
							<td style="color:#178f9d; padding-left:25px; padding-top:3px;">*</td>
							<td>
								무역협회 회원사여부 조회 :
								<select name="p_authtype" style="width:100px;">
								<option value="" selected>=== 선 택 ===</option>
								<option value="member_id" >회원사 번호</option>
								<option value="enter_reg_no">사업자등록번호</option>
								</select>
								<input type="text" name="p_authnum" value="" style="width:120px;" onblur="if(this.value!=document.form2.p_authnum.value){document.form1.p_regchkyn.value='N';};" onkeyup="checkIsDigit(this);">
								<a id="aAuth" href="#none" onclick="javascript:doAuthCheck();"><img src="/images/common/btn_popup_confirm.gif"></a>
							</td>
						</tr>
					</table>
					<!-- //회원사인증 -->
				</td></tr>
				</table>
				<!-- Step2 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px; display: none;" id="step2">
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr><td height="3"></td></tr>
				<tr>
					<td align="left">
						<img src="/images/common/btn_step2.gif"  alt="회원구분" style="cursor:hand"/>
					</td>
				</tr>
				<tr>
					<td style="padding-top:15px; padding-bottom:5px; padding-left:20px;">
						<h5>◎ 외환관련 전문자격증 보유여부?</h5>
					</td>
				</tr>								
				<tr>
					<td style="padding-left:30px;">
						<input type="radio" style="border:none;" name="sulmun5" value="1"  onclick="goStep(3, '', 'Y')" />외환전문역(1종) 
						<input type="radio" style="border:none;" name="sulmun5" value="2"   onclick="goStep(3, '', 'Y')"  />파생상품투자상담사 
						<input type="radio" style="border:none;" name="sulmun5" value="3"    onclick="goStep(3, '', 'Y')"  />재무위험관리사 							
						<input type="radio" style="border:none;" name="sulmun5" value="4"    onclick="goStep(3, '', 'Y')"  />FRM
						<!-- 2014년도에만 임시로 추가 --> 									
						<br><input type="radio" style="border:none;" name="sulmun5" value="5"    onclick="goStep(3, '', 'Y')"  />2013년 1차 자격이론시험 합격자 									
						<input type="radio" style="border:none;" name="sulmun5" value="0"   onclick="goStep(3, '', 'N')"  />없다  									
					</td>
				</tr>				
				</table>
				<!-- Step3 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px; display: none;" id="step3">
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr><td height="3"></td></tr>				
				<tr>
					<td align="left">
						<img src="/images/common/btn_step3.gif"  alt="회원구분" style="cursor:hand"/>
					</td>
				</tr>	
				<tr>
					<td style="padding-top:15px; padding-bottom:5px; padding-left:20px;">
						<h5>◎ 선수과목(외환관리기초, 6시간)의 과정 참여 의사여부(*)</h5>
					</td>
				</tr>	
				<tr>
					<td style="padding-left:30px;">
					
						<input type="radio" style="border:none;" name="sulmun6" value="1"  onclick="goProposeFinal('Y', 4)" />수강 참석
						<input type="radio" style="border:none;" name="sulmun6" value="2"  onclick="goProposeFinal('N', 4)" />수강 불참석										
					</td>
				</tr>
				</table>
				<!-- Step4 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px; display: none;" id="step4">
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr><td height="3"></td></tr>				
				<tr>
					<td align="left">
						<img src="/images/common/btn_step4.gif"  alt="첨부파일" style="cursor:hand"/>
					</td>
				</tr>	
				<tr>
					<td style="padding-top:10px; padding-bottom:10px;">
						
						<table style="display:block" width="100%" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="12" />
							<col width="" />
						</colgroup>						
						<tr><td height="5"></td></tr>
						
						<!-- 회원사 첨부파일 -->
						<tr>
							<td colspan="2">
								<table id="kitamember_file" style="display: none;">
									<tr valign="top">
										<td style="color:#178f9d; padding-left:5px; padding-top:3px;">*</td>
										<td>
											&nbsp;재직증명서 파일첨부 :
											&nbsp;&nbsp;
											<input type="file" name="p_proofemprealname" value="" style="width:300px; background-color:#FFFFFF;">
										</td>
									</tr>
									<tr valign="top">
										<td style="color:#178f9d; padding-left:5px; padding-top:3px;">*</td>
										<td>
											&nbsp;사업자등록증 파일첨부 :
											<input type="file" name="p_bizlicenserealname" value="" style="width:300px; background-color:#FFFFFF;">
										</td>
									</tr>
									<tr><td height="5"></td></tr>
									<tr valign="top">
										<td style="color:#178f9d; padding-left:5px;">*</td>
										<td>무역협회 회원사의 경우, 상단 검색창에서 회원임을 확인하셔야 할인가능합니다.</td>
									</tr>
									<tr><td height="5"></td></tr>
									<tr valign="top">
										<td style="color:#178f9d; padding-left:5px;">*</td>
										<td>무역협회 회원 중 회비미납인 회원은 무역협회 회원할인이 불가합니다.</td>
									</tr>
									<tr><td height="5"></td></tr>	
								</table>
							</td>
						</tr>				
						<!-- 대학생첨부파일 -->
						<tr>
							<td colspan="2">
								<table id="collegian_file" style="display: none;">
									<tr valign="top">
										<td style="color:#178f9d; padding-left:5px; padding-top:3px;">* </td>
										<td>
											&nbsp;재학 / 휴학 증명서 스캔파일 첨부 :
											&nbsp;&nbsp;
											<input type="file" name="p_collegianrealname" value="" style="width:300px; background-color:#FFFFFF;">
										</td>
									</tr>
									<tr><td height="5"></td></tr>
								</table>
							</td>
						</tr>
						<!-- 자격증 첨부파일 -->
						<tr>
							<td colspan="2">
								<table id="fxmlicense_file" style="display: none;">
									<tr valign="top">
										<td style="color:#178f9d; padding-left:5px; padding-top:3px;">* </td>
										<td>
											&nbsp;외환관련 전문자격증 스캔 파일 첨부 :
											&nbsp;&nbsp;
											<input type="file" name="p_fxmlicenserealname" value="" style="width:300px; background-color:#FFFFFF;">
										</td>
									</tr>
									<tr><td height="5"></td></tr>
								</table>
							</td>
						</tr>
						
						<!-- 금융사 첨부파일 -->
						<tr>
							<td colspan="2">
								<table id="banker_file" style="display: none;">
									<tr valign="top">
										<td style="color:#178f9d; padding-left:5px; padding-top:3px;">* </td>
										<td>
											&nbsp;금융기관(은행) 재직증명서 파일 첨부 :
											&nbsp;&nbsp;
											<input type="file" name="p_bankerrealname" value="" style="width:300px; background-color:#FFFFFF;">
											
										</td>
									</tr>
									<tr><td height="5"></td></tr>
								</table>
							</td>
						</tr>
					
						<tr valign="top">
							<td style="color:#178f9d; padding-left:5px;">*</td>
							<td><span style="color:#178f9d;">재직증명서 및 사업자등록증 파일 첨부 후 수강신청 오류가 발생할 경우 첨부파일을 삭제하고,<br> 
							서류는 신청 후 팩스(02-6000-5066)로 보내주세요</span></td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
				
				
				
				
				
				
				<!-- 최종결제금액표시부분 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="display: none;" id="step5" >
				
				<!-- <tr><td height="2" bgcolor="#c7c7c7"></td></tr> -->
				<tr><td height="3"></td></tr>				
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:10px;">
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr><td><img src="/images/common/popup_lecture_label08.gif"></td></tr>
									</table>
								</td>
							</tr>
							<tr><td height="3"></td></tr>
							<tr>
								<td style="padding-left:10px;" >
								 	<input type="hidden" name="sulmun7"  value="" />
									<textarea onkeyup="fc_chk_byte(this)"  rows="5" cols="40" name="sulmun7Value" style="height: 50px; width: 100%;" ></textarea> 									
								</td>
							</tr>	
							<tr><td align="right">
							<INPUT style="BORDER-RIGHT: #ffffff 0px solid; PADDING-RIGHT: 0px; BORDER-TOP: #ffffff 0px solid; PADDING-LEFT: 0px; FONT-SIZE: 9pt; PADDING-BOTTOM: 0px; BORDER-LEFT: #ffffff 0px solid; WIDTH: 30px; COLOR: #FF0033; PADDING-TOP: 0px; BORDER-BOTTOM: #ffffff 0px solid; FONT-FAMILY: 굴림체; POSITION: relative; TOP: -2px; HEIGHT: 12px; BACKGROUND-COLOR: #ffffff; TEXT-ALIGN: right" tabIndex=100 readOnly size=4 value=0 name=byte1>
							/<span id="smsMaxLength">1500</span></td></tr>
						</table>						
					</td>
				</tr>
				<tr>
					<td style="padding-top:10px;">
					
					
					<!-- 할인결제정보 선택부분   // dsDiscountSubj.getString("TARGETCD") => 공통코드의 할인코드 -->
						<table width="100%" cellpadding="0" cellspacing="0" style="display: none;">
						<colgroup>
							<col width="45%" />
							<col width="55%" />
						</colgroup>
						<tr><td colspan="2" height="1" bgcolor="#c7c7c7"></td></tr>
						<tr height="30">
							<td align="center"><img src="/images/common/txt_education_gubun.gif"></td>
							<td align="center"><img src="/images/common/txt_education_price.gif"></td>
						</tr>
						<tr><td colspan="2" height="1" bgcolor="#c7c7c7"></td></tr>
						<tr height="30">
						<%	if (!v_subj.equals("2324")) { %>
							<td style="border-right:solid 1px #c7c7c7; border-bottom:solid 1px #c7c7c7;">
								<input type="radio" name="p_pricetype" value="99" style="border:none;" onclick="javascript:changeCostSupport(this)" checked >일반 수강자
								<input type="hidden" name="p_biyong" value="<%=boxProposeApplyInfo.getString("BIYONG") %>" />
							</td>
						<% } else { %>
							<td style="border-right:solid 1px #c7c7c7; border-bottom:solid 1px #c7c7c7;">
								&nbsp;&nbsp;&nbsp;&nbsp;시험 선택
							</td>
						<% } %>
					<%
						int nRowSpan = 2;
						nRowSpan += dsDiscountSubj.getRow();
					%>
							<td rowspan="<%=nRowSpan %>" align="center"><span id="spanPrice" style="font-weight:bold; font-size:14px; color:#0078a5; display:none"></span></td>
						</tr>
					<%	while ( dsDiscountSubj != null && dsDiscountSubj.getRow() > 0 && dsDiscountSubj.next() ) { %>
						<tr height="30">
							<td style="border-right:solid 1px #c7c7c7; border-bottom:solid 1px #c7c7c7;"><%=dsDiscountSubj.getString("TARGETCD") %>/
								<input type="radio" name="p_pricetype" value="<%=dsDiscountSubj.getString("TARGETCD") %>" style="border:none;" onclick="javascript:changeCostSupport(this)"><%=dsDiscountSubj.getString("TARGETNM") %>
								<input type="hidden" name="p_special_<%=dsDiscountSubj.getString("TARGETCD") %>" value="<%=dsDiscountSubj.getString("DCAMT") %>" />
							</td>
						</tr>
					<%	} %>
					<%	if ( !blIsITmaster && !(v_subj.equals("2324"))) { %>
						<tr height="30">
							<td style="border-right:solid 1px #c7c7c7;">
								<input type="radio" name="p_pricetype" value="98" style="border:none;" onclick="javascript:changeCostSupport(this)">무역협회 회원사
								<input type="hidden" name="p_memberbiyong" value="<%=boxProposeApplyInfo.getString("MEMBERBIYONG") %>" />
							</td>
						</tr>
					<%	} %>
						<tr><td colspan="2" height="1" bgcolor="#c7c7c7"></td></tr>
						</table>
						<!-- //할인결제정보 선택부분 -->
						
					</td>
				</tr>
				<!--  마일리지  시작  -->
			<%  
				// v_ismileage = "Y";
				if(v_ismileage.equals("Y")) { 
			%>	
				<tr>
					<td style="padding-top:10px; padding-bottom:10px;">
						<table width="100%" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="12" />
							<col width="" />
						</colgroup>
						<tr valign="top">
							<td>
								현재 <span style="color:#178f9d;"><%=v_name %></span> 님의 적립된 마일리지는 <span style="color:#178f9d;"><%=v_mileage2 %> M</span> 입니다.
							</td>
						</tr>
					<% if(Integer.parseInt(v_mileage) >= 1000) { %>	
						<tr><td height="5"></td></tr>
						<tr valign="top">
							<td>
								차감할 마일리지는
								<input type="text" name="p_usemileage" value="0" dataType="integer" dispName="차감할 마일리지" style="width:70px; padding-left:5px; color:#178f9d;" onKeyup ="changeResidueMileage()" onBlur="checkMilage()">
								M 이고 차감 후 잔여 마일리지는 <span id="reMileage" style="color:#178f9d;"><%=v_mileage %> M</span> 입니다.
							</td>
						</tr>
					<% } else { %>	
							<input type="hidden" name="p_usemileage" value="0" style="width:70px; padding-left:5px; color:#178f9d;">
					<% }%>
						<tr><td height="5"></td></tr>
						<tr valign="top">
							<td>
								 <span style="color:#178f9d; padding-left:5px;">*</span>
								 사용할 마일리지 입력 시 1,000 M 단위 이상으로만 가능합니다.
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<% }else { %>	
					<input type="hidden" name="p_usemileage" value="0" style="width:70px; padding-left:5px; color:#178f9d;">
				<% }%>
				<tr>
					<td>
						<table width="100%" cellpadding="0" cellspacing="0" style="margin-top: 20px;">
						<colgroup>
							<col width="45%" />
							<col width="55%" />
						</colgroup>
						<tr><td colspan="2" height="1" bgcolor="#c7c7c7"></td></tr>
						<tr height="50">
							<td align="center" style="font-weight:bold; font-size:14px; color:#0078a5; border-right:solid 1px #c7c7c7;">최종 결제금액</td>
							<td align="center" id="LastPrice" style="font-weight:bold; font-size:14px; color:#0078a5;"></td>
						</tr>
						<tr><td colspan="2" height="1" bgcolor="#c7c7c7"></td></tr>
						</table>
					</td>
				</tr>
				<!--  마일리지 종료  -->
				
				
				<!-- <tr><td height="1" bgcolor="#c7c7c7"></td></tr> -->
				</table>
		<%	if ( !blIsITmaster && !boxProposeApplyInfo.getString("ISONOFF").equals("OFF") ) { %>
				<!-- 교재신청정보 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_lecture_label04.gif"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="5%" />
							<col width="30%" />
							<col width="" />
							<col width="30%" />
							<col width="10%" />
						</colgroup>
						<tr><td colspan="5" height="2" bgcolor="#c7c7c7"></td></tr>
						<tr height="30">
							<td align="center" class="border_rightbottom"><img src="/images/common/txt_lecture_gubun.gif"></td>
							<td align="center" class="border_rightbottom"><img src="/images/common/txt_lecture_subjectname.gif"></td>
							<td align="center" class="border_rightbottom"><img src="/images/common/txt_lecture_bookname.gif"></td>
							<td align="center" class="border_rightbottom"><img src="/images/common/txt_lecture_bookcharge.gif"></td>
							<td align="center" class="border_bottom"><img src="/images/common/txt_lecture_yesno.gif"></td>
						</tr>
						<tr><td colspan="5" height="2" bgcolor="#c7c7c7"></td></tr>
			<%
				v_subj = "";
				String v_year = "";
				String v_subjseq = "";
				String v_subjnm = "";
				String v_isonoff = "";
				String v_usebook = "";
				String v_bookappstate = "";
				int v_bookcnt = 0;
				int notusebookcnt = 0;
				
				HashMap<String,String> hmParam = null;//new HashMap<String,String>();
				while ( dsSubjectListBook != null && dsSubjectListBook.next() ) {
					v_subj		= dsSubjectListBook.getString("SUBJ");
					v_year		= dsSubjectListBook.getString("YEAR");
					v_subjseq	= dsSubjectListBook.getString("SUBJSEQ");
					v_subjnm	= dsSubjectListBook.getString("SUBJNM");
					v_isonoff 	= dsSubjectListBook.getString("ISONOFF");
					v_bookcnt 	= dsSubjectListBook.getInt("BOOKCNT");
					
					if ( v_isonoff.equals("OFF") ) {
						continue;
					}
					
					if ( dsSubjectListBook.getString("USEBOOK").equals("N") || dsSubjectListBook.getString("ESSENYN").equals("N") ) {
						notusebookcnt++;
						v_bookappstate = "disabled";
					} else {
						if ( dsSubjectListBook.getString("ISONOFF").equals("READ") ) {
							v_bookappstate = "disabled checked";
						} else {
							//v_bookappstate = "checked";
						}
					}
			%>
						<tr>
							<td align="center" class="border_rightbottom"><%=dsSubjectListBook.getString("ISONOFFNM")%></td>
							<td align="center" class="border_rightbottom"><%=dsSubjectListBook.getString("SUBJNM")%></td>
							<td align="center" class="border_rightbottom">
				<%	if ( v_bookcnt > 0 ) { %>
								<img src="/images/common/icon_info.gif" vspace="5">&nbsp;<span style="color:#f58c59;">개월차 교재를 선택해 주세요.</span>
				<%
						hmParam = new HashMap<String,String>();
						hmParam.put("p_subj", dsSubjectListBook.getString("SUBJ"));
						hmParam.put("p_year", dsSubjectListBook.getString("YEAR"));
						hmParam.put("p_subjseq", dsSubjectListBook.getString("SUBJSEQ"));
						hmParam.put("first", "선택");
						hmParam.put("selected", "");
						hmParam.put("dwrYn", "N");
						hmParam.put("_where", "propose");
						for ( int i=0; i < v_bookcnt; i++ ) {
							hmParam.put("objNm", "p_bookmonth");
							hmParam.put("objId", "p_bookmonth"+(i+1));
							hmParam.put("p_bookmonth", Integer.toString(i+1));
				%>
								<br>
								<%=(i+1) %>개월차 교재
								<%=CommonUtil.selectSubjSeqBook(hmParam,request) %>
				<%		}
					} else { %>
								<%=(dsSubjectListBook.getString("BOOKNAME").equals(""))?"교재없음":dsSubjectListBook.getString("BOOKNAME")%>
				<%		} %>
							</td>
							<td align="center" class="border_rightbottom">
							<%=StringUtil.getMoneyType(dsSubjectListBook.getString("BOOKPRICE")) %>
							</td>
							<td align="center" class="border_bottom">
							<input type="checkbox" name="p_bookappyn" value="<%=v_subj+"_"+v_year+"_"+v_subjseq+"_Y_"+dsSubjectListBook.getString("BOOKPRICE")%>" style="border:none;" <%=v_bookappstate%> onclick="updatePrice(this)">
							</td>
						</tr>
						<tr><td colspan="5" height="1" bgcolor="#c7c7c7"></td></tr>
				<%	} %>
					</table>
					</td>
				</tr>
				</table>
		<%	} %>
				<!-- 버튼 -->
				<table width="100%" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr><td height="10"></td></tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td align="center">
						<%-- <%if(v_personcost.equals("Y")){%><img src="/images/common/btn_account_01.gif" onclick="proposeWrite('1001')" alt="개인수강지원금과정" style="cursor:hand"/><%}else{%><img src="/images/common/btn_account_01_off.gif" alt="개인수강지원금과정" /><%}%>
						<%if(v_goyongcost.equals("Y")){%><img id="imgGoYong" src="/images/common/btn_account_02.gif" onclick="proposeWrite('1003')" alt="고용보험환급과정" style="cursor:hand" use="Y"/><%}else{%><img id="imgGoYong" src="/images/common/btn_account_02_off.gif" alt="고용보험환급과정" use="N"/><%}%>
						<%if(v_commcost.equals("Y")){%><img src="/images/common/btn_account_03.gif" onclick="proposeWrite('1002')" alt="능력개발카드환급과정" style="cursor:hand"/><%}else{%><img src="/images/common/btn_account_03_off.gif" alt="능력개발카드환급과정" /><%}%>
						<%if(v_cardcost.equals("Y")){%><img src="/images/common/btn_account_04.gif" onclick="proposeWrite('1004')" alt="일반과정" style="cursor:hand"/><%}else{%><img src="/images/common/btn_account_04_off.gif" alt="일반과정" /><%}%> --%>
						
						<!-- 수강신청서수정 -->
						<img src="/images/common/btn_propmodify.gif" onclick="goPayInfo(1, 2)" alt="수강신청서수정" style="cursor:hand"/>
						<!-- 결제하기버튼 -->
						<%if(v_cardcost.equals("Y")){%>
						<img src="/images/common/btn_propose_off.gif" onclick="proposeWrite('1004')" alt="일반과정" style="cursor:hand" id="propbtn" />
						<%}else{%><img src="/images/common/btn_propose_off.gif" alt="일반과정" /><%}%>
					</td>
				</tr>
				
				</table>
				<!-- // -->
				
				</div>
				<!-- //교육비정보 -->
				
				
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
</form>
<form name="form2" method="post" id="form2">
<input type="hidden" name="p_authnum" value="" />
<input type="hidden" name="p_authtype" value="" />
</form>
<form name="form3" method="post" id="form3">
<input type="hidden" name="p_authnum" value="<%=box.getString("p_userid")%>" />
</form>


<form name="form4" method="post" id="form4"  action="/back/Message.do">
<input type="hidden" name="p_usernum" value="" />
<input type="hidden" name="p_content" value="http://goo.gl/derQHc" />
<!-- <input type="hidden" name="p_content" value="http://edu.tradecampus.com/upload/UserFiles/Image/20140404171437.jpg" /> -->
<input type="hidden" name="p_sendphone" value="0260005378" />
<input type="hidden" name="p_sender" value="0260005378" />
<input type="hidden" name="p_userinfo" value="" />
<input type="hidden" name="p_receiver" value="" />
</form>

</body>
</html>