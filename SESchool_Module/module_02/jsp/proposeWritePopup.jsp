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
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file = "/jsp/front/common/commonInc.jsp" %>
<%
	String status = "";
	String isonoff = box.getString("ISONOFF");
	
	Box boxProposeApplyInfo = (Box)box.getObject("boxProposeApplyInfo");
	DataSet dsSubjectListBook = (DataSet)box.getObject("dsSubjectListBook");
	
	String v_btobyn = boxProposeApplyInfo.getString("BTOBYN");
	String v_isdelivery = boxProposeApplyInfo.getString("ISDELIVERY");
	
	boolean useBook = false;
	boolean useDelivery = false;
	boolean usePhone = false;
	
	int bookcnt = 0; 
	int usebookcnt = 0;
	
	if ( G_TMPL.equals("") ) G_TMPL = "1";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=PAGETITLE%></title>
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
<script language="Javascript" src="/js/home/template<%=G_TMPL%>.js"></script>
<fmtag:jscommon point="front" />
<script type="text/javascript">
	var office_post = "<%=boxProposeApplyInfo.getString("ZIP") %>";
	var office_addr = "<%=boxProposeApplyInfo.getString("COMPADDR") %>";
	
	var home_post1 = "<%=boxProposeApplyInfo.getString("POST1") %>";
	var home_post2 = "<%=boxProposeApplyInfo.getString("POST2") %>";
	var home_addr = "<%=boxProposeApplyInfo.getString("ADDR") %>";
	
	var handphone = "<%=boxProposeApplyInfo.getString("HANDPHONE") %>";
	var hometel = "<%=boxProposeApplyInfo.getString("HOMETEL") %>";
	var comptel = "<%=boxProposeApplyInfo.getString("COMTEL") %>";
	var email = "<%=boxProposeApplyInfo.getString("EMAIL") %>";
	
	function changeAddr() {
		var form = document.form1;
		var addr_type = $RF("form1", "addr_type");
			
		if(addr_type == "H") {
			$("p_rcvraddr").value = home_addr;
			$("p_rcvrzipcode1").value = home_post1;
			$("p_rcvrzipcode2").value = home_post2;
			$("p_rcvrtel").value = hometel;
		} else if(addr_type == "C") {
			$("p_rcvraddr").value = office_addr;
			$("p_rcvrtel").value = comptel;			
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
		} else if(addr_type == "N") {
			$("p_rcvraddr").value = "";
			$("p_rcvrzipcode1").value = "";
			$("p_rcvrzipcode2").value = "";
		}
	}
	
	function proposeWrite(type) {
		
		var form = document.form1;
		
		form.action = "/front/Propose.do?cmd=proposeWrite&p_proposetype=1";
		form.cmd.value = "proposeWrite";
		
		if($("p_rcvrzipcode1")) {
			if( $("p_rcvrzipcode2").value == null || $("p_rcvrzipcode2").value == ""){
				form.p_rcvrzipcode.value = $F("p_rcvrzipcode1");
			} else {
				form.p_rcvrzipcode.value = $F("p_rcvrzipcode1") + "-" + $F("p_rcvrzipcode2");
			}
		}
		
		if(!validate(form)) return;

		
		form.submit();
	}
	
	function validate(f) {
		//교재 선택여부 확인
		for(i = 1; i <=12; i++) {
			if($("subjmonth" + i)) {
				if($("subjmonth" + i).value =="") {
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
		if($("p_rcvrtel") && $("p_rcvrtel").value == "") {
			alert("전화번호를 입력하세요.");
			$("p_rcvrtel").focus();
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
</script>
<script>
	//Event.observe(window,"load", popupAutoResize);
</script>
<script type="text/javascript">
	function setPopupSize() {
		window.resizeTo(765,500);
		popupAutoResize();
	}
	Event.observe(window,"load", setPopupSize);
</script>
</HEAD>
<a name="Top"></a>
<body style="margin:0px;">

<!--//-->
<form name="form1" id="form1" method="POST" onSubmit="return proposeWrite()">
<input type="hidden" name="cmd" value="proposeWrite" />
<input type="hidden" name="p_proposetype" value="1" />
<input type="hidden" name="p_isonoff" value="<%=boxProposeApplyInfo.getString("ISONOFF")%>" />
<input type="hidden" name="p_subj" value="<%=boxProposeApplyInfo.getString("SUBJ")%>" />
<input type="hidden" name="p_year" value="<%=boxProposeApplyInfo.getString("YEAR")%>" />
<input type="hidden" name="p_gyear" value="<%=boxProposeApplyInfo.getString("YEAR")%>" />
<input type="hidden" name="p_subjseq" value="<%=boxProposeApplyInfo.getString("SUBJSEQ")%>" />
<input type="hidden" name="p_usebook" value="<%=useBook ? "Y" : "N"%>" />
<input type="hidden" name="p_subjnm" value="<%=boxProposeApplyInfo.getString("SUBJNM")%>" />
<input type="hidden" name="p_biyong" value="<%=boxProposeApplyInfo.getString("BIYONG")%>" />
<input type="hidden" name="p_rcvrzipcode" value="" />
<%	if ( box.getString("_where").equals("B") ) { %>
<input type="hidden" name="_where" value="<%=box.getString("_where")%>" />
<input type="hidden" name="p_userid" value="<%=box.getString("p_userid")%>" />
<input type="hidden" name="p_comp" value="<%=box.getString("p_comp")%>" />
<%	} %>

<table width="700" height="100%" cellpadding="0" cellspacing="0">
<tr>
	<td align="center" height="100%" valign="top">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="40" bgcolor="#399fb1" align="center">
				<table width="660" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/template0/common/popup_personal_label.gif"></td>
					<td align="right">
						<a href="javascript:self.close();"><img src="/images/template0/common/btn_popup_close.gif"></a></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="100%" valign="top" align="center" style="padding-top:20px;">
				<table width="660" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<img src="/images/template0/common/popup_label01.gif" alt="개인정보확인 타이틀" /></td>
				</tr>
				<tr><td height="5"></td></tr>
				</table>
 
				<div class="board-view">
					<table width="660" border="0" cellpadding="0" cellspacing="0">
					<caption>수강신청 - 개인정보확인</caption>
					<colgroup>
						<col width="80" />
						<col width="250" />
						<col width="40" />
						<col width="" />
					</colgroup>
					<tbody>
					<tr>
						<td style="padding-left:20px;"><img src="/images/template0/common/txt_lecture_name.gif"></td>
						<td colspan="3"><%=boxProposeApplyInfo.getString("SUBJNM")%></td>
					</tr>
					<tr>
						<td style="padding-left:20px;"><img src="/images/template0/common/txt_name.gif"></td>
						<td colspan="3"><%=boxProposeApplyInfo.getString("NAME")%></td>
					</tr>
					<tr>
						<td style="padding-left:20px;"><img src="/images/template0/common/txt_company.gif"></td>
						<td colspan="3"><%=boxProposeApplyInfo.getString("COMPNM")%></td>
					</tr>
					<tr>
						<td style="padding-left:20px;"><img src="/images/template0/common/txt_email.gif"></td>
						<td><%=boxProposeApplyInfo.getString("EMAIL")%></td>
						<td style="padding-left:20px;"><img src="/images/template0/common/txt_mobile.gif"></td>
						<td><%=boxProposeApplyInfo.getString("HANDPHONE")%></td>
					</tr>
					<tr>
						<td style="padding-left:20px;"><img src="/images/template0/common/txt_home_addr.gif"></td>
						<td colspan="3"><%=boxProposeApplyInfo.getString("ADDR")%></td>
					</tr>
					<tr>
						<td style="padding-left:20px;"><img src="/images/template0/common/txt_comp_addr.gif"></td>
						<td colspan="3"><%=boxProposeApplyInfo.getString("COMPADDR")%></td>
					</tr>
					</tbody>
					</table>
				</div>
				
				
				<table width="660" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td><img src="/images/common/popup_lecture_label04.gif"></td>
				</tr>
				<tr><td height="5"></td></tr>
				</table>
				
				<div class="board-view">
				<!-- 교재신청정보 -->
					<table width="660" border="0" cellpadding="0" cellspacing="0">
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
			<%
				String v_subj = "";
				String v_year = "";
				String v_subjseq = "";
				String v_subjnm = "";
				String v_usebook = "";
				String v_bookappstate = "";
				int v_bookcnt = 0;
				
				HashMap<String,String> hmParam = null;//new HashMap<String,String>();
				while ( dsSubjectListBook != null && dsSubjectListBook.next() ) {
					v_subj		= dsSubjectListBook.getString("SUBJ");
					v_year		= dsSubjectListBook.getString("YEAR");
					v_subjseq	= dsSubjectListBook.getString("SUBJSEQ");
					v_subjnm	= dsSubjectListBook.getString("SUBJNM");
					v_bookcnt 	= dsSubjectListBook.getInt("BOOKCNT");
					if ( dsSubjectListBook.getString("USEBOOK").equals("N") || dsSubjectListBook.getString("ESSENYN").equals("N") ) {
						v_bookappstate = "disabled";
					} else {
						usebookcnt++;
						if ( dsSubjectListBook.getString("ISONOFF").equals("READ") ) {
							v_bookappstate = "disabled checked";
						} else {
							v_bookappstate = "checked";
						}
					}
			%>
						<tr>
							<td align="center" class="td_leftline"><%=dsSubjectListBook.getString("ISONOFFNM")%></td>
							<td align="center" class="td_leftline"><%=dsSubjectListBook.getString("SUBJNM")%></td>
							<td align="center" class="td_leftline">
				<%	if ( v_bookcnt > 0 ) { %>
								<img src="/images/common/icon_info.gif" vspace="5">&nbsp;<span style="color:#f58c59;">개월차 교재를 선택해 주세요.</span>
				<%
						hmParam = new HashMap<String,String>();
						hmParam.put("p_subj", dsSubjectListBook.getString("SUBJ"));
						hmParam.put("p_year", dsSubjectListBook.getString("YEAR"));
						hmParam.put("p_subjseq", dsSubjectListBook.getString("SUBJSEQ"));
						hmParam.put("objNm", "p_bookmonth");
						hmParam.put("first", "선택");
						hmParam.put("selected", "");
						hmParam.put("dwrYn", "N");
						hmParam.put("_where", "propose");
						for ( int i=0; i < v_bookcnt; i++ ) {
							hmParam.put("p_bookmonth", Integer.toString(i+1));
				%>
								<br>
								<%=(i+1) %>개월차 교재
								<%=CommonUtil.selectSubjSeqBook(hmParam,request) %>
				<%		}
					} else { %>
								<% if("".equals(dsSubjectListBook.getString("BOOKNAME"))) {%>
									교재없음
								<% } else {
									dsSubjectListBook.getString("BOOKNAME");
								   } %>
				<%		} %>
							</td>
							<td align="center" class="border_bottom">
							<input type="checkbox" name="p_bookappyn" value="<%=v_subj+"_"+v_year+"_"+v_subjseq+"_Y" %>" style="border:none;" <%=v_bookappstate%>>
							</td>
						</tr>
				<%	} %>
					</table>
				</div>

 			<%	if ( v_isdelivery.equals("Y") && usebookcnt > 0 ) { %>
 				<script>alert('교재 배송을 위해 현재 거주하시는 주소를 입력해 주시기 바랍니다.\r\n배송전화 안내를 위해 휴대폰(집) 전화번호를 입력해 주시기 바랍니다.');</script>
				<table width="660" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<img src="/images/template0/common/popup_label02.gif" alt="개인정보확인 타이틀" /></td>
					<td align="right">
						<input type="radio" name="addr_type" value="H" style="border:none;" checked onClick="changeAddr()"> 집주소
						<input type="radio" name="addr_type" value="C" style="border:none;" onClick="changeAddr()"> 회사주소
						<input type="radio" name="addr_type" value="N" style="border:none;" onClick="changeAddr()"> 새로입력
					</td>
				</tr>
				<tr><td height="5"></td></tr>
				</table>
 
				<div class="board-view">
					<table width="660" border="0" cellpadding="0" cellspacing="0">
					<caption>수강신청 - 배송상품 및 배송지 정보확인</caption>
					<colgroup>
						<col width="80" />
						<col width="250" />
						<col width="40" />
						<col width="" />
					</colgroup>
					<tbody>
					<tr>
						<td style="padding-left:20px;"><img src="/images/template0/common/txt_delivery_addr.gif"></td>
						<td colspan="3">
							<% if( boxProposeApplyInfo.getString("POST2") == null || boxProposeApplyInfo.getString("POST2").equals("")){ %>
								<input type="text" name="p_rcvrzipcode1" id="p_rcvrzipcode1" value="<%=boxProposeApplyInfo.getString("POST1") %>" class="input01" style="width:80px;" readonly>
								<input type="hidden" name="p_rcvrzipcode2" id="p_rcvrzipcode2" value="<%=boxProposeApplyInfo.getString("POST2") %>" class="input01" />	
							<% } else { %>
								<input type="text" name="p_rcvrzipcode1" id="p_rcvrzipcode1" value="<%=boxProposeApplyInfo.getString("POST1") %>" class="input01" style="width:80px;" readonly>
								-
								<input type="text" name="p_rcvrzipcode2" id="p_rcvrzipcode2"  value="<%=boxProposeApplyInfo.getString("POST2") %>" class="input01" style="width:80px;" readonly> 
							<% } %>
							<a href="#1" onClick="searchZipCode()"><img src="/images/common/btn_zipcode.gif" alt="우편번호찾기" border="0" align="absmiddle"/></a><br>
							<input type="text" name="p_rcvraddr" id="p_rcvraddr"  value="<%=boxProposeApplyInfo.getString("ADDR") %>" class="input01" style="width:520px;">
						</td>
					</tr>
					<tr>
						<td style="padding-left:20px;"><img src="/images/template0/common/txt_email.gif"></td>
						<td colspan="3">
							<input type="text" name="p_rcvemail"  id="p_rcvemail" value="<%=boxProposeApplyInfo.getString("EMAIL") %>" class="input01" style="width:520px;">
						</td>
					</tr>
					<tr>
						<td style="padding-left:20px;"><img src="/images/template0/common/txt_phone.gif"></td>
						<td>
							<input type="text" name="p_rcvrtel"  id="p_rcvrtel"  value="<%=boxProposeApplyInfo.getString("HOMETEL") %>" class="input01" style="width:195px;">
						</td>
						<td style="padding-left:20px;"><img src="/images/template0/common/txt_mobile.gif"></td>
						<td>
							<input type="text" name="p_rcvrmobile"  id="p_rcvrmobile"  value="<%=boxProposeApplyInfo.getString("HANDPHONE") %>" class="input01" style="width:195px;"">
						</td>
					</tr>
					</tbody>
					</table>
				</div>
		<%	} %>
				<!-- 버튼 -->
				<table width="660" cellpadding="0" cellspacing="0" style="margin-top:10px;">
				<tr>
					<td align="center">
						<a href="#none" onfocus="this.blur()" onclick="proposeWrite('')"><img src="/images/template0/common/btn_popup_lecture.gif" alt="수강신청" /></a>
						<!-- a href="#"><img src="/images/template0/common/btn_popup_book.gif" alt="수강신청+교재신청" /></a--></td>
				</tr>
				</table>
				<!-- // -->
			</td>
		</tr>
		<tr>
			<td height="5" bgcolor="#399fb1"></td>
		</tr>
		</table>
 
<!-- 푸터 -->
	</td>
</tr>
</table>

</form>
</body>
</html>
<!-- // -->
