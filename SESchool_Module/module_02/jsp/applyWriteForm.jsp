<%@ page contentType="text/html;charset=UTF-8" 	%>
<%@ include file = "/jsp/back/common/commonInc.jsp"	%>
<%
	String status = "";
	String isonoff = box.getString("ISONOFF");
	
	Box boxProposeApplyInfo = (Box)box.getObject("boxProposeApplyInfo");
	DataSet dsSubjectListBook = (DataSet)box.getObject("dsSubjectListBook");
	
	if ( boxProposeApplyInfo == null ) boxProposeApplyInfo = new Box("data");
	
	String v_btobyn = boxProposeApplyInfo.getString("BTOBYN");
	String v_trainingclass = box.getString("p_trainingclass");
	
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
	
	String proposeType = null;
	if ( v_btobyn.equals("Y") ) {
		proposeType = "B2B";
	} else {
		// 연수과정이 무역마스터, 아이디마스터, 글로벌인턴쉽일 경우
		if ( v_trainingclass.equals("03")||v_trainingclass.equals("04")||v_trainingclass.equals("08") ) {
			proposeType = "APP";
		} else {
			proposeType = "B2C";
		}
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE>::: 한국무역협회 무역아카데미 ::: 관리자페이지</TITLE>
<META http-equiv=Content-Type content="text/html; charset=UTF-8"> 
<script language="Javascript" src="/js/common/popupbox.js"></script>
<script language="Javascript" src="/js/common/prototype.js"></script>
<fmtag:csscommon point="back" />
<fmtag:jscommon />
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

		form.p_costsupport.value = v_costsupport;
		
		form.p_rcvrtel.value = form.p_rcvrtel1.value+"-"+form.p_rcvrtel2.value+"-"+form.p_rcvrtel3.value;
		form.p_rcvrmobile.value = form.p_rcvrmobile1.value+"-"+form.p_rcvrmobile2.value+"-"+form.p_rcvrmobile3.value;
		
		form.action = "/front/Propose.do?cmd=proposeWrite&p_proposetype=2&subj="+form.p_subj.value+"&year="+form.p_year.value+"&subjseq="+form.p_subjseq.value;
		form.cmd.value = "proposeWrite";
		//form.submit();
	}
	
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
		var form = document.form1;
		
		$("p_rcvraddr").setValue(addr);
		if( zipcode.search('-') > -1){
			$("p_rcvrzipcode1").setValue(zipcode.substr(0, 3));
			$("p_rcvrzipcode2").setValue(zipcode.substr(4, 7));
		} else {
			$("p_rcvrzipcode1").setValue(zipcode);
			$("p_rcvrzipcode2").setValue("");
			form.p_rcvrzipcode2.style.display = "none";
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
	function changeCostSupport(obj) {
		var f = document.form1;
		var objAAuth = document.getElementById("aAuth");
		var v_pricetype = $RF("form1", "p_pricetype");
		if ( v_pricetype == "member" ) {
			f.p_authtype[0].disabled = false;
			f.p_authtype[1].disabled = false;
			if ( f.p_authtype[0].checked == false && f.p_authtype[1].checked == false ) f.p_authtype[0].checked = true;
			f.p_authnum.disabled = false;
			objAAuth.onclick = doAuthCheck;

			if ( f.p_saleamt != undefined ) {
				if ( f.p_saleamt.length == undefined ) {
					if ( f.p_saleamt != undefined ) f.p_saleamt.disabled = true;
				} else {
					f.p_saleamt[0].disabled = true;
					f.p_saleamt[1].disabled = true
				}
			}
			
		} else if ( v_pricetype == "general" ) {
			f.p_authtype[0].disabled = true;
			f.p_authtype[1].disabled = true;
			f.p_authnum.disabled = true;
			objAAuth.onclick = "";
			
			if ( f.p_saleamt != undefined ) {
				if ( f.p_saleamt.length == undefined ) {
					if ( f.p_saleamt != undefined ) f.p_saleamt.disabled = true;
				} else {
					f.p_saleamt[0].disabled = true;
					f.p_saleamt[1].disabled = true
				}
			}
			
			
		} else if ( v_pricetype == "spacial" ) {
			f.p_authtype[0].disabled = true;
			f.p_authtype[1].disabled = true;
			f.p_authnum.disabled = true;
			objAAuth.onclick = "";

			if ( f.p_saleamt != undefined ) {
				if ( f.p_saleamt.length == undefined ) {
					if ( f.p_saleamt != undefined ) f.p_saleamt.disabled = false;
					if ( f.p_saleamt != undefined && f.p_saleamt.checked == false ) f.p_saleamt.checked = true;
				} else {
					f.p_saleamt[0].disabled = false;
					f.p_saleamt[1].disabled = false;
					if ( f.p_saleamt[0].checked == false && f.p_saleamt[1].checked == false ) f.p_saleamt[0].checked = true;
				}
			}
			
		}
	}
	function doAuthCheck() {
		alert ( '준비중입니다.' );
	}
</script>
<script type="text/javascript">
	function setPopupSize() {
		window.resizeTo(700,500);
		popupAutoResize();
	}
	Event.observe(window,"load", setPopupSize);
</script>
</head>
<a name="Top"></a>
<body style="margin:0px;">
<form name="form1" id="form1" method="post" enctype="multipart/form-data">
<input type="hidden" name="cmd" value="proposeWrite" />
<input type="hidden" name="p_proposetype" value="2" />
<input type="hidden" name="p_maxfilesize" value="10" />
<input type="hidden" name="p_isonoff" value="<%=boxProposeApplyInfo.getString("ISONOFF")%>" />
<input type="hidden" name="p_subj" value="<%=boxProposeApplyInfo.getString("SUBJ")%>" />
<input type="hidden" name="p_year" value="<%=boxProposeApplyInfo.getString("YEAR")%>" />
<input type="hidden" name="p_subjseq" value="<%=boxProposeApplyInfo.getString("SUBJSEQ")%>" />
<input type="hidden" name="p_subjnm" value="<%=boxProposeApplyInfo.getString("SUBJNM")%>" />
<input type="hidden" name="p_costsupport" value="" />
<input type="hidden" name="p_rcvrtel" value="" />
<input type="hidden" name="p_rcvrmobile" value="" />
<input type="hidden" name="p_rcvrzipcode" value="" />
<!--//-->

<table width="100%" height="100%" cellpadding="0" cellspacing="0">
<tr>
	<td align="center" height="100%" valign="top">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="42" background="/images/common/popup_header_bg.gif">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/common/popup_lecture_title.gif"></td>
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
							<td style="padding-top:4px;"><img src="/images/common/txt_name.gif"></td>
							<td><%=boxProposeApplyInfo.getString("NAME")%></td>
						</tr>
					<% if ( proposeType.equals("B2C") ) { %>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:3px;"><img src="/images/common/txt_eng_name.gif"></td>
							<td>
								<input type="text" name="p_engname" id="p_engname" value="<%=boxProposeApplyInfo.getString("ENGNAME") %>" style="width:360px; height:20px;">
							</td>
						</tr>
					<%	} %>
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
							<td style="padding-top:4px;"><img src="/images/common/txt_mobile.gif"></td>
							<td><%=boxProposeApplyInfo.getString("HANDPHONE") %></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_home_address.gif"></td>
							<td><%=boxProposeApplyInfo.getString("POST1") %> - <%=boxProposeApplyInfo.getString("POST2") %></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"></td>
							<td style="padding-top:4px;"></td>
							<td><%=boxProposeApplyInfo.getString("ADDR") %></td>
						</tr>
					<% if ( proposeType.equals("B2C") ) { %>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:3px;"><img src="/images/common/txt_jikwi.gif"></td>
							<td><%=boxProposeApplyInfo.getString("JIKCHEKNM") %></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:3px;"><img src="/images/common/txt_now_job.gif"></td>
							<td>
								<input type="file" name="p_bizlicenserealname" style="width:300px;"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:3px;"><img src="/images/common/txt_company_resno.gif"></td>
							<td>
								<input type="file" name="p_proofemprealname" style="width:300px;"/>
							</td>
						</tr>
					<%	} %>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>
 
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
									<input type="text" name="p_rcvrzipcode1" id="p_rcvrzipcode1" value="<%=boxProposeApplyInfo.getString("POST1") %>" style="width:60px;height:20px;" readonly>
									<input type="hidden" name="p_rcvrzipcode2" id="p_rcvrzipcode2"  value="<%=boxProposeApplyInfo.getString("POST2") %>" >
								<% } else { %>
									<input type="text" name="p_rcvrzipcode1" id="p_rcvrzipcode1" value="<%=boxProposeApplyInfo.getString("POST1") %>" style="width:60px;height:20px;" readonly>
									-
									<input type="text" name="p_rcvrzipcode2" id="p_rcvrzipcode2" value="<%=boxProposeApplyInfo.getString("POST2") %>" style="width:60px;height:20px;" readonly>
								<% } %>
								<a href="#none" onclick="searchZipCode()"><img src="/images/common/btn_popup_search_2.gif" alt="우편번호찾기"/></a>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"></td>
							<td style="padding-top:4px;"></td>
							<td>
								<input type="text" name="p_rcvraddr" id="p_rcvraddr"  value="<%=boxProposeApplyInfo.getString("ADDR") %>" style="width:360px; height:20px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_email.gif"></td>
							<td>
								<input type="text" name="p_rcvemail" value="<%=boxProposeApplyInfo.getString("EMAIL") %>" style="width:360px;height:20px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_phone.gif"></td>
							<td>
								<input name="p_rcvrtel1" type="text" size="4" dataType="integer" dispName="연락처" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>=2)?arrPhone[0]:"" %>" style="width:40px;height:20px;" onkeyup="checkIsDigit(this);"> -
								<input name="p_rcvrtel2" type="text" size="4" dataType="integer" dispName="연락처" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>=2)?arrPhone[1]:"" %>" style="width:60px;height:20px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_rcvrtel3" type="text" size="4" dataType="integer" dispName="연락처" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>=3)?arrPhone[2]:"" %>" style="width:60px;height:20px;" onkeyup="checkIsDigit(this);"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_mobile.gif"></td>
							<td>
								<input name="p_rcvrmobile1" type="text" size="4" dataType="integer" dispName="핸드폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=2)?arrHandPhone[0]:"" %>" style="width:40px;height:20px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_rcvrmobile2" type="text" size="4" dataType="integer" dispName="핸드폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=2)?arrHandPhone[1]:"" %>" style="width:60px;height:20px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_rcvrmobile3" type="text" size="4" dataType="integer" dispName="핸드폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=3)?arrHandPhone[2]:"" %>" style="width:60px;height:20px;" onkeyup="checkIsDigit(this);"/>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
<%	if ( proposeType.equals("B2C") ) { %>
				<tr>
					<td style="padding-top:10px; padding-bottom:5px;">
						<table width="100%" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="15" />
							<col width="" />
						</colgroup>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;">
								<input type="radio" name="p_pricetype" value="member" style="border:none;" onclick="javascript:changeCostSupport(this)">무역협회 회원사
								<input type="radio" name="p_authtype" value="member_id" style="border:none;">회원사 번호
								<input type="radio" name="p_authtype" value="enter_reg_no" style="border:none;">사업자등록번호
								<input type="text" name="p_authnum" value="" style="width:50px; height:20px;">
								<a id="aAuth" href="#none" onclick="javascript:doAuthCheck();"><img src="/images/common/btn_popup_confirm.gif"></a>
								<span style="color:#666666; font-weight:bold;"><%=boxProposeApplyInfo.getString("MEMBERBIYONG") %>원</span>
								<input type="hidden" name="p_memberbiyong" value="<%=boxProposeApplyInfo.getString("MEMBERBIYONG") %>" />
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;">
								<input type="radio" name="p_pricetype" value="general" style="border:none;" onclick="javascript:changeCostSupport(this)">일반 수강자
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span style="color:#666666; font-weight:bold;"><%=boxProposeApplyInfo.getString("BIYONG") %>원</span>
								<input type="hidden" name="p_biyong" value="<%=boxProposeApplyInfo.getString("BIYONG") %>" />
							</td>
						</tr>
			<%	if ( !v_saleviewyn1.equals("") || !v_saleviewyn2.equals("") ) { %>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;">
								<input type="radio" name="p_pricetype" value="spacial" style="border:none;" onclick="javascript:changeCostSupport(this)">특별 할인
				<%	if ( !v_saleviewyn1.equals("") ) { %>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name="p_saleamt" value="<%=v_saleamt1%>" style="border:none;"><%=v_saleamt1 %>원
				<%	} %>
				<%	if ( !v_saleviewyn2.equals("") ) { %>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name="p_saleamt" value="<%=v_saleamt2%>" style="border:none;"><%=v_saleamt2 %>원
				<%	} %>
							</td>
						</tr>
			<%	} %>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-top:10px; padding-bottom:5px;">
						<table width="100%" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="12" />
							<col width="" />
						</colgroup>
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
							<td>특별할인 대상자의 경우, (재직/재학)증명서를 개강3일전까지 <span style="color:#178f9d;">팩스(02-6000-5500)</span>로<br>보내주세요.</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
<%	} %>
				</table>
				
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
							<col width="60" />
							<col width="120" />
							<col width="" />
							<col width="60" />
						</colgroup>
						<tr><td colspan="4" height="2" bgcolor="#c7c7c7"></td></tr>
						<tr height="30">
							<td align="center" class="border_rightbottom"><img src="/images/common/txt_lecture_gubun.gif"></td>
							<td align="center" class="border_rightbottom"><img src="/images/common/txt_lecture_subjectname.gif"></td>
							<td align="center" class="border_rightbottom"><img src="/images/common/txt_lecture_bookname.gif"></td>
							<td align="center" class="border_bottom"><img src="/images/common/txt_lecture_yesno.gif"></td>
						</tr>
						<tr><td colspan="4" height="2" bgcolor="#c7c7c7"></td></tr>
			<%
				String v_subj = "";
				String v_year = "";
				String v_subjseq = "";
				String v_subjnm = "";
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
					v_bookcnt 	= dsSubjectListBook.getInt("BOOKCNT");
					if ( dsSubjectListBook.getString("USEBOOK").equals("N") ) {
						notusebookcnt++;
						v_bookappstate = "disabled";
					} else {
						if ( dsSubjectListBook.getString("ISONOFF").equals("READ") ) {
							v_bookappstate = "disabled checked";
						} else {
							v_bookappstate = "checked";
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
								<%=dsSubjectListBook.getString("SUBJSEQ")%>
				<%		} %>
							</td>
							<td align="center" class="border_bottom">
							<input type="checkbox" name="p_bookappyn" value="<%=v_subj+"_"+v_year+"_"+v_subjseq+"_Y" %>" style="border:none;" <%=v_bookappstate%>>
							</td>
						</tr>
						<tr><td colspan="4" height="1" bgcolor="#c7c7c7"></td></tr>
				<%	} %>
					</table>
					</td>
				</tr>
				</table>
<%	if ( proposeType.equals("B2C") ) { %>
				<!-- 버튼 -->
				<table width="100%" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td align="center">
						<%if(v_personcost.equals("Y")){%><a href="#none" onclick="proposeWrite('1001')"><img src="/images/common/btn_account_01.gif" alt="개인수강지원금과정" /></a><%}%>
						<%if(v_commcost.equals("Y")){%><a href="#none" onclick="proposeWrite('1002')"><img src="/images/common/btn_account_02.gif" alt="고용보험환급과정" /></a><%}%>
						<%if(v_goyongcost.equals("Y")){%><a href="#none" onclick="proposeWrite('1003')"><img src="/images/common/btn_account_03.gif" alt="능력개발카드환급과정" /></a><%}%>
						<%if(v_cardcost.equals("Y")){%><a href="#none" onclick="proposeWrite('1004')"><img src="/images/common/btn_account_04.gif" alt="일반과정" /></a><%}%>
					</td>
				</tr>
				</table>
				<!-- // -->
<%	} else { %>
				<!-- 버튼 -->
				<table width="100%" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td align="center">
						<a href="#none" onfocus="this.blur()" onclick="proposeWrite('')"><img src="/images/template0/common/btn_popup_lecture.gif" alt="수강신청" /></a>
						<!-- a href="#"><img src="/images/template0/common/btn_popup_book.gif" alt="수강신청+교재신청" /></a--></td>
				</tr>
				</table>
				<!-- // -->
<%	} %>
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
</body>
</html>