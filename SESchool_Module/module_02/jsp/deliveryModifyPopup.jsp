<%@ page contentType="text/html;charset=UTF-8" 		%>
<%@ include file = "/jsp/front/common/commonInc.jsp"	%>
<%

	String status = "";
	Box userInfo = (Box)box.getObject("userInfo");
	Box compInfo = (Box)box.getObject("compInfo");
	Box subjSeqInfo = (Box)box.getObject("subjSeqInfo");
	Box deliveryInfo = (Box)box.getObject("deliveryInfo");
	String isonoff = box.getString("ISONOFF");
	String zip = deliveryInfo.getString("RCVRZIPCODE");
//	String zip1 = deliveryInfo.getString("RCVRZIPCODE").length() > 5 ? deliveryInfo.getString("RCVRZIPCODE").substring(0,3) : zip;
//	String zip2 = deliveryInfo.getString("RCVRZIPCODE").length() > 5 ? deliveryInfo.getString("RCVRZIPCODE").substring(4,7) : "";
	String zip1;
	String zip2;	
	if( !StringUtil.isNull(zip) && !zip.equals("-") ){
		if( zip.contains("-") ){
			zip1 = zip.substring(0, zip.indexOf("-"));
			zip2 = zip.substring(zip.indexOf("-")+1, zip.length())
		} else if( zip.length() > 5 ){
			zip1 = zip.substring(0, 3);
			zip2 = zip.substring(3, zip.length());
		} else {
			zip1 = zip;
			zip2 = "";
		}
	} else {
		zip1 = "";
		zip2 = "";
	}
	
	String deliverYn = deliveryInfo.getString("DELIVERYN");
	
	if(deliverYn.equals("Y")) {
		out.println("<script>alert('배송이 완료되어  정보를 수정할수 없습니다.');self.close();</script>");
		return;
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=PAGETITLE%></title>
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
<script language="Javascript" src="/js/home/template<%=G_TMPL%>.js"></script>
<fmtag:jscommon point="front" />
<script type="text/javascript">

function changeDeivery(type) {
	
	var form = document.form1;
	
	form.action = "/front/Propose.do";
	form.cmd.value = "changeDeliveryWrite";
	if( form.p_zip2.value == null || form.p_zip2.value == ""){
		form.p_rcvrzipcode.value = form.p_zip1.value;
	} else {
		form.p_rcvrzipcode.value = form.p_zip1.value+"-"+form.p_zip2.value;
	}
	
	if(!validate(form)) return;
	form.submit();
}
function searchZipCode() {
	var url = "/front/Common.do?cmd=selectZipCode"; 
	Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
}
function setZipCodeInfo(addr, zipcode) {
	var form = document.form1;
	
	form.p_rcvraddr.value = addr;
	if(zipcode.search('-') > -1){	
		form.p_zip1.value = zipcode.substr(0, 3) ;
		form.p_zip2.value = zipcode.substr(4, 7) ;	
	} else {
		form.p_zip1.value = zipcode;		// 새로운 우편주소, 하나의 텍스트란에 넣음
		form.p_zip2.value = "";
		form.p_zip2.style.display="none";
	}
}
</script>
<script>
//Event.observe(window,"load", popupAutoResize); 
</script>
</HEAD>
<a name="Top"></a>
<body style="margin:0px;">
 
<!--//-->
 <form name="form1" id="form1" method="POST">
<input type="hidden" name="cmd" value="changeDeliveryWrite" />
<input type="hidden" name="p_subj" value="<%=box.getString("p_subj")%>" />
<input type="hidden" name="p_year" value="<%=box.getString("p_year")%>" />
<input type="hidden" name="p_subjseq" value="<%=box.getString("p_subjseq")%>" />
<input type="hidden" id="p_rcvrzipcode" name="p_rcvrzipcode" value="" />
<table width="700" height="100%" cellpadding="0" cellspacing="0">
<tr>
	<td align="center" height="100%" valign="top">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="40" bgcolor="#399fb1" align="center">
				<table width="660" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/template0/common/popup_title_mypage.gif"></td>
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
						<img src="/images/template0/common/popup_bookaddr_label.gif" alt="교재배송지 변경" /></td>
				</tr>
				<tr><td height="5"></td></tr>
				</table>
 
				<div class="board-view">
					<table width="660" border="0" cellpadding="0" cellspacing="0">
					<caption>수강신청 - 개인정보확인</caption>
					<colgroup>
						<col width="60" />
						<col width="50" />
						<col width="150" />
						<col width="50" />
						<col width="" />
					</colgroup>
					<tbody>
					<tr>
						<td style="padding-left:20px;" rowspan="3"><img src="/images/template0/common/label_current_delivery.gif"></td>
						<td><img src="/images/template0/common/txt_zipcode.gif"></td>
						<td colspan="3"><%=deliveryInfo.getString("RCVRZIPCODE") %></td>
					</tr>
					<tr>
						<td><img src="/images/template0/common/txt_addr.gif"></td>
						<td colspan="3"><%=deliveryInfo.getString("RCVRADDR") %></td>
					</tr>
					<tr>
						<td><img src="/images/template0/common/txt_home_phone.gif"></td>
						<td><%=deliveryInfo.getString("RCVRTEL") %></td>
						<td><img src="/images/template0/common/txt_mobile.gif"></td>
						<td><%=deliveryInfo.getString("RCVRMOBILE") %></td>
					</tr>
					<tr>
						<td style="padding-left:20px;"><img src="/images/template0/common/label_addr.gif"></td>
						<td colspan="4">
							<input type="text" id="p_zip1" name="p_zip1" value="" class="input01" maxLength=5 readOnly dispName="우편번호" isNull="N" style="width:70px;">
							<input type="hidden" id="p_zip2" name="p_zip2" value=""dispName="우편번호" class="input01" >
							<a href="#1" onClick="searchZipCode()"><img src="/images/common/btn_zipcode.gif" alt="우편번호찾기" border="0" align="absmiddle"/></a><br>
							<input type="text" id="p_rcvraddr" name="p_rcvraddr" value="" dispName="주소" isNull="N" class="input01" style="width:450px;">
						</td>
					</tr>
					</tbody>
					</table>
				</div>
				<!-- 버튼 -->
				<table width="660" cellpadding="0" cellspacing="0" style="margin-top:10px;">
				<tr>
					<td align="right">
						<a href="#none" onfocus="this.blur()" onclick="changeDeivery()"><img src="/images/template0/common/btn_popup_save.gif" alt="저장" /></a></td>
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

