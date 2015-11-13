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

		if(!validate(form)) return;
		
		if($("p_rcvrzipcode1")) {
			if( $("p_rcvrzipcode2").value == null || $("p_rcvrzipcode2").value == ""){
				form.p_rcvrzipcode.value = $F("p_rcvrzipcode1");
			} else {
				form.p_rcvrzipcode.value = $F("p_rcvrzipcode1") + "-" + $F("p_rcvrzipcode2");
			}
		}
		
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
		
		form.action = "/front/Propose.do?cmd=proposeWrite&p_proposetype=2&subj="+form.p_subj.value+"&year="+form.p_year.value+"&subjseq="+form.p_subjseq.value+"&p_ppopup="+form.p_ppopup.value+"&p_istoeic=Y";
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
		
		if( $("p_handphone") ) {
			if ( $("p_handphone").value == "" ) {
				alert("전화번호를 입력하세요.");
				$("p_handphone").focus();
				return false;
			} else {
				var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
				if ( !regExp.test(f.p_handphone.value) ) {
					alert ( "핸드폰번호를 확인해 주십시요\n- 를 포함하여 입력해 주십시요" );
					$("p_handphone").focus();
					return;
				}
			}
		}
		
		if (f.p_isstudent.value == "") {
			alert("회원 구분을 입력해 주세요");
			return false;
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
					, parameters:Form.serialize('form2')
					, onSuccess: function(contents) {
						var ret = contents.responseText.substr(0,1);
						if ( ret == "Y" ) {
							f.p_regchkyn.value = "Y";
							alert ( "무역협회 회원사로 확인 되었습니다." );
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
		)
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
			if (cost == "98") {
				ctl = document.getElementById("kitamember");
				ctl.style.display = "block";
			} else {
				ctl = document.getElementById("kitamember");
				ctl.style.display = "none";
			}	
		}
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
<input type="hidden" name="p_costsupport" value="" />
<input type="hidden" name="p_rcvrtel" value="" />
<input type="hidden" name="p_rcvrmobile" value="" />
<input type="hidden" name="p_rcvrzipcode" value="" />
<input type="hidden" name="p_regchkyn" value="N" />
<input type="hidden" name="p_bookpricesum" value="" />
<input type="hidden" name="p_totprice" value="" />
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
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/images/common/popup_toeic.gif"></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="100%" valign="top" align="center" style="padding:20px;">
				<!-- 수강신청서 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_lecture_toeic01.gif"></td>
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
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_sinchung_lecture_name.gif"></td>
							<td><%=boxProposeApplyInfo.getString("SUBJNM")%></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_phone.gif"></td>
							<td><%=boxProposeApplyInfo.getString("HOMETEL") %></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_email.gif"></td>
							<td>
						<%	if ( !boxProposeApplyInfo.getString("EMAIL").equals("") ) { %>
						<%=boxProposeApplyInfo.getString("EMAIL") %>
						<%	} else { %>
								<input type="text" name="p_email" value="<%=boxProposeApplyInfo.getString("EMAIL") %>" style="width:200px;">
						<%	} %>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_mobile.gif"></td>
							<td>
						<%	if ( !(boxProposeApplyInfo.getString("HANDPHONE").equals("")||boxProposeApplyInfo.getString("HANDPHONE").equals("--")) ) { %>
							<%=boxProposeApplyInfo.getString("HANDPHONE") %>
						<%	} else { %>
								<input name="p_handphone" style="width:200px;"/>
						<%	} %>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_student.gif"></td>
							<td><input type="text" name="p_isstudent" maxlength="20" style="width:200px;"> ex) 무역마스터, SMART IT마스터, 일반회원</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_recive.gif"></td>
							<td><input type="radio" name="p_recive" value="Y" checked>우편배송 <input type="radio" name="p_recive" value="N">직접수령</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"></td>
							<td style="padding-top:4px;"></td>
							<td><font color="red">* 우편배송 선택 시 회원정보수정에서 수령 주소를 정확히 입력해 주세요</font></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_recive_address.gif"></td>
							<td><%=boxProposeApplyInfo.getString("POST1") %> - <%=boxProposeApplyInfo.getString("POST2") %></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"></td>
							<td style="padding-top:4px;"></td>
							<td><%=boxProposeApplyInfo.getString("ADDR") %></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>
			<% if ( v_isdelivery.equals("Y") ) { %>
				<!-- 배송상품 및 배송지 정보확인 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_lecture_label02.gif"></td>
							<td align="right">
								<input type="radio" name="addr_type" value="H" style="border:none;" checked onClick="changeAddr()"> 집주소
								<input type="radio" name="addr_type" value="C" style="border:none;" onClick="changeAddr()"> 회사주소
								<input type="radio" name="addr_type" value="N" style="border:none;" onClick="changeAddr()"> 새로입력
							</td>
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
							<td style="padding-top:4px;"><img src="/images/common/txt_product_name.gif"></td>
							<td><%=boxProposeApplyInfo.getString("NAME")%></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_delivery_address.gif"></td>
							<td>
								<% if( boxProposeApplyInfo.getString("POST2") == null || boxProposeApplyInfo.getString("POST2").equals("")){ %>
									<input type="text" name="p_rcvrzipcode1" id="p_rcvrzipcode1" value="<%=boxProposeApplyInfo.getString("POST1") %>" style="width:60px;" readonly>
									<input type="hidden" name="p_rcvrzipcode2" id="p_rcvrzipcode2"  value="<%=boxProposeApplyInfo.getString("POST2") %>" >
								<% } else { %>
									<input type="text" name="p_rcvrzipcode1" id="p_rcvrzipcode1" value="<%=boxProposeApplyInfo.getString("POST1") %>" style="width:60px;" readonly>
									-
									<input type="text" name="p_rcvrzipcode2" id="p_rcvrzipcode2"  value="<%=boxProposeApplyInfo.getString("POST2") %>" style="width:60px;" readonly>
								<% } %>	
								<a href="#none" onclick="searchZipCode()"><img src="/images/common/btn_popup_search_2.gif" alt="우편번호찾기"/></a>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"></td>
							<td style="padding-top:4px;"></td>
							<td>
								<input type="text" name="p_rcvraddr" id="p_rcvraddr"  value="<%=boxProposeApplyInfo.getString("ADDR") %>" style="width:360px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_email.gif"></td>
							<td>
								<input type="text" name="p_rcvemail" value="<%=boxProposeApplyInfo.getString("EMAIL") %>" style="width:360px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_phone.gif"></td>
							<td>
								<input name="p_rcvrtel1" type="text" size="4" dataType="integer" dispName="연락처" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>=2)?arrPhone[0]:"" %>" style="width:40px;" onkeyup="checkIsDigit(this);"> -
								<input name="p_rcvrtel2" type="text" size="4" dataType="integer" dispName="연락처" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>=2)?arrPhone[1]:"" %>" style="width:60px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_rcvrtel3" type="text" size="4" dataType="integer" dispName="연락처" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>=3)?arrPhone[2]:"" %>" style="width:60px;" onkeyup="checkIsDigit(this);"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_mobile.gif"></td>
							<td>
								<input name="p_rcvrmobile1" type="text" size="4" dataType="integer" dispName="핸드폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=2)?arrHandPhone[0]:"" %>" style="width:40px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_rcvrmobile2" type="text" size="4" dataType="integer" dispName="핸드폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=2)?arrHandPhone[1]:"" %>" style="width:60px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_rcvrmobile3" type="text" size="4" dataType="integer" dispName="핸드폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=3)?arrHandPhone[2]:"" %>" style="width:60px;" onkeyup="checkIsDigit(this);"/>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>
			<%	} %>
				
				<!-- 교육비정보 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr><td><img src="/images/common/popup_lecture_toeic06.gif"></td></tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-top:10px;">
						<table width="100%" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="45%" />
							<col width="55%" />
						</colgroup>
						<tr><td colspan="2" height="1" bgcolor="#c7c7c7"></td></tr>
						<tr height="30">
							<td align="center"><img src="/images/common/txt_toeic_gubun.gif"></td>
							<td align="center"><img src="/images/common/txt_toeic_price.gif"></td>
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
							<td style="border-right:solid 1px #c7c7c7; border-bottom:solid 1px #c7c7c7;">
								<input type="radio" name="p_pricetype" value="<%=dsDiscountSubj.getString("TARGETCD") %>" style="border:none;" onclick="javascript:changeCostSupport(this)"><%=dsDiscountSubj.getString("TARGETNM") %>
								<input type="hidden" name="p_special_<%=dsDiscountSubj.getString("TARGETCD") %>" value="<%=dsDiscountSubj.getString("DCAMT") %>" />
							</td>
						</tr>
					<%	} %>
					<%	if ( !blIsITmaster && !(v_subj.equals("2324"))) { %>
						<tr height="30">
							<td style="border-right:solid 1px #c7c7c7;">
								<input type="radio" name="p_pricetype" value="98" style="border:none;" onclick="javascript:changeCostSupport(this)">
								<input type="hidden" name="p_memberbiyong" value="<%=boxProposeApplyInfo.getString("MEMBERBIYONG") %>" />무역협회 회원사
							</td>
						</tr>
					<%	} %>
						<tr><td colspan="2" height="1" bgcolor="#c7c7c7"></td></tr>
						</table>
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
						<table width="100%" cellpadding="0" cellspacing="0">
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
				
				<tr>
					<td style="padding-top:10px; padding-bottom:10px;">
						<table width="100%" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="12" />
							<col width="" />
						</colgroup>
					<%	if ( blIsITmaster ) { %>
						<tr valign="top">
							<td style="color:#178f9d; padding-left:5px; padding-top:3px;">*</td>
							<td>결제 시에 질문 사항이 있으시면 02)6000-5376/5739으로 연락주시기 바랍니다.</td>
						</tr>
					<%	} else { %>
						</table>
						<table id="kitamember" style="display:none" width="100%" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="12" />
							<col width="" />
						</colgroup>
						<tr valign="top">
							<td style="color:#178f9d; padding-left:5px; padding-top:3px;">*</td>
							<td>
								무역협회 회원사여부 조회 :
								<select name="p_authtype" style="width:100px;">
								<option value=""></option>
								<option value="member_id" selected>회원사 번호</option>
								<option value="enter_reg_no">사업자등록번호</option>
								</select>
								<input type="text" name="p_authnum" value="" style="width:120px;" onblur="if(this.value!=document.form2.p_authnum.value){document.form1.p_regchkyn.value='N';};" onkeyup="checkIsDigit(this);">
								<a id="aAuth" href="#none" onclick="javascript:doAuthCheck();"><img src="/images/common/btn_popup_confirm.gif"></a>
							</td>
						</tr>
						<tr><td height="5"></td></tr>
						<tr valign="top">
							<td style="color:#178f9d; padding-left:5px; padding-top:3px;">*</td>
							<td>
								재직증명서 파일첨부 :
								&nbsp;&nbsp;
								<input type="file" name="p_proofemprealname" value="" style="width:300px; background-color:#FFFFFF;">
							</td>
						</tr>
						<tr><td height="5"></td></tr>
						<tr valign="top">
							<td style="color:#178f9d; padding-left:5px; padding-top:3px;">*</td>
							<td>
								사업자등록증 파일첨부 :
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
						<tr valign="top">
							<td style="color:#178f9d; padding-left:5px;">*</td>
							<td>특별할인 대상자의 경우, (재직/재학)증명서를 개강3일전까지<br><span style="color:#178f9d;">팩스(02-6000-5500)</span>로 보내주세요.</td>
						</tr>
					<%	if ( boxProposeApplyInfo.getString("TRAININGCLASS").equals("09") ) { %>
						<tr><td height="5"></td></tr>
						<tr valign="top">
							<td style="color:#178f9d; padding-left:5px;">*</td>
							<td>이러닝과정은 특별할인 적용 시 고용보험환급을 받으실 수 없습니다.</td>
						</tr>
					<%	} %>
						<tr valign="top">
							<td style="color:#178f9d; padding-left:5px;">*</td>
							<td><span style="color:#178f9d;">재직증명서 및 사업자등록증 파일 첨부 후 수강신청 오류가 발생할 경우 첨부파일을 삭제하고,<br> 
							서류는 신청 후 팩스로 보내주세요</span></td>
						</tr>
					<%	} %>
						</table>
					</td>
				</tr>
				<!-- <tr><td height="1" bgcolor="#c7c7c7"></td></tr> -->
				</table>
		<%	if ( !blIsITmaster && !boxProposeApplyInfo.getString("ISONOFF").equals("OFF") && !v_subj.equals("2324") ) { %>
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
							<%=StringUtil.getMoneyType(dsSubjectListBook.getString("BOOKPRICE"))%>
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
				<tr>
					<td align="center">
						<%if(v_cardcost.equals("Y")){%><img src="/images/common/btn_account_toeic.gif" onclick="proposeWrite('1004')" alt="일반과정" style="cursor:hand"/><%}else{%><img src="/images/common/btn_account_04_off.gif" alt="일반과정" /><%}%>
					</td>
				</tr>
				</table>
				<!-- // -->
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
<form name="form2" method="post">
<input type="hidden" name="p_authnum" value="" />
<input type="hidden" name="p_authtype" value="" />
</form>
</body>
</html>