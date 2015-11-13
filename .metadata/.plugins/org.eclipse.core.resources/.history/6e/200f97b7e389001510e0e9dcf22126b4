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
 * 2009. 12. 09.  jangcw       Initial Release
 ************************************************
--%>
<%@ page contentType="text/html;charset=UTF-8" 		%>
<%@page import="com.sinc.common.FormatDate"%>
<%@ include file = "/jsp/front/common/commonInc.jsp"	%>
<%
	Box data = (Box)box.getObject("billReqInfo");
	String v_subj = data.getString("SUBJ") ; 
	String v_year = data.getString("YEAR") ; 
	String v_subjseq = data.getString("SUBJSEQ") ;
	String v_userid = data.getString("USERID") ; 
	String v_seq = data.getString("SEQ") ; 
	String v_billreqdt = data.getString("BILLREQDT") ; 
	String v_compnm = data.getString("COMPNM") ;
	String v_chiefnm = data.getString("CHIEFNM") ;
	String v_busregstno		= StringUtil.nvl(data.getString("REGSTNO"));
	String[] v_regstno		= null;
   	if(!v_busregstno.equals(""))
   			v_regstno 		= StringUtil.split(v_busregstno,"-");		
   	else 
   			v_regstno 		= new String[]{"","",""};
   	
	String v_businesscond = data.getString("BUSINESSCOND") ;
	String v_businesstype = data.getString("BUSINESSTYPE") ;
	String v_zipcode = data.getString("ZIPCODE") ;
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
	
	String v_addr1 = data.getString("ADDR1") ;
	String v_addr2 = data.getString("ADDR2") ;
	String v_demandyn = data.getString("DEMANDYN");
	String v_pubgubun = data.getString("PUBGUBUN");
	
	String v_comtel = data.getString("COMTEL");
	String v_comfax = data.getString("COMFAX");
	String v_applygubun = data.getString("APPLYGUBUN");
	String v_rightno 	= data.getString("RIGHTNO");
	String v_inningseq 	= data.getString("INNINGSEQ");
	String v_applynum 	= data.getString("APPLYNUM");
	
	String v_bizlicenserealname = data.getString("BIZLICENSEREALNAME");
	String v_bizlicensesavename = data.getString("BIZLICENSESAVENAME");
%>
<!-- !DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
<html xmlns="http://www.w3.org/1999/xhtml" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
<title>::::::::::</title>
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
<fmtag:jscommon />
<script type="text/javascript" src="/js/common/calendar.js"></script>
<script language="javascript">
<!--
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
	    }
	    
	}
	function doBillRequest(){
	       var f = document.form1;
	       if(!validate(f)) return;
	       if(f.p_regstno1.value.length != 3 || f.p_regstno2.value.length != 2 || f.p_regstno3.value.length != 5) {
	    	   alert('사업자 등록번호가 잘못되었습니다.');
	    	   return;
	       }
	       if(f.p_bizlicenserealname.value.length < 1){
	    	   alert('사업자등록증 이미지파일을 첨부하여 주세요.');
	    	   return;
	       }
	       f.action = "/front/FileBox.do?cmd=billRequestWrite&subj="+f.p_subj.value+"&year="+f.p_year.value+"&subjseq="+f.p_subjseq.value;
		   f.cmd.value = "billRequestWrite";
	       f.submit();
	}
	function billrequestPopFileDown(rFile, sFile) {
		var f = document.form1;
		f.action		  = "/fileDownServlet";
		f.method		  = "get";
		f.rFileName.value = rFile;
		f.sFileName.value = sFile;
		f.filePath.value  = "/billpubreq/"+f.p_subj.value+"/"+f.p_year.value+"/"+f.p_subjseq.value;
		f.submit();
	}	
//-->
</script>
</head>
 
<a name="Top"></a>
<body style="margin:0px;"> 
<!--//-->
<form name="form1" method="post" onSubmit="return false;" enctype="multipart/form-data">
<input type="hidden" name="cmd" value="billRequestWrite">
<input type="hidden" name="p_subj"		value="<%=v_subj%>">
<input type="hidden" name="p_year"		value="<%=v_year%>">	  	
<input type="hidden" name="p_subjseq"	value="<%=v_subjseq%>">
<input type="hidden" name="p_userid"	value="<%=v_userid%>">  		
<input type="hidden" name="p_rightno"	value="<%=v_rightno%>">
<input type="hidden" name="p_inningseq"	value="<%=v_inningseq%>">
<input type="hidden" name="p_applynum"	value="<%=v_applynum%>">
<input type="hidden" name="p_seq"	value="<%=v_seq%>">
<input type="hidden" name="p_applygubun"	value="B">
<input type="hidden" name="p_pubgubun"	value="N">
<input type="hidden" name="rFileName"	value="">
<input type="hidden" name="sFileName"	value="">
<input type="hidden" name="filePath"	value="">

<table width="100%" height="100%" cellpadding="0" cellspacing="0">
<tr>
	<td align="center" height="100%" valign="top">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="42" background="/images/common/popup_header_bg.gif">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/common/popup_bill_title.gif"></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="100%" valign="top" align="center" style="padding:20px;">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td style="color:#FF6600;">
						<img src="/images/common/icon_info.gif"> 회사정보를 입력하셔야 계산서 발급이 가능합니다.
					</td>
				</tr>
				</table>
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:5px;">
				<colgroup>
					<col width="15" />
					<col width="80" />
					<col width="221" />
					<col width="15" />
					<col width="50" />
					<col width="209" />
				</colgroup>
				<tr><td height="2" colspan="6" bgcolor="#c7c7c7"></td></tr>
				<tr height="35">
					<td align="center" style="padding-top:2px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
					<td style="padding-top:1px;"><img src="/images/common/txt_bill_txt01.gif"></td>
					<td>
						<input type="text" name="p_compnm" value="<%=v_compnm %>" dispName="회사명" isNull="N" lenCheck="50"  style="width:200px; padding:1px 0px 0px 2px;">
					</td>
					<td align="center" style="padding-top:2px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
					<td style="padding-top:1px;"><img src="/images/common/txt_bill_txt02.gif"></td>
					<td>
						<input type="text" name="p_comtel" value="<%=v_comtel %>" dispName="전화번호" isNull="N" lenCheck="20" maxLength="20" style="width:180px; padding:1px 0px 0px 2px;">
					</td>
				</tr>
				<tr><td height="1" colspan="6" bgcolor="#c7c7c7"></td></tr>
				<tr height="35">
					<td align="center" style="padding-top:2px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
					<td style="padding-top:1px;"><img src="/images/common/txt_bill_txt03.gif"></td>
					<td>
						<input name="p_regstno1" type="text" size="3" dataType="integer" dispName="사업자등록번호" isNull="N" lenCheck="3" maxLength="3" value="<%=v_regstno[0] %>" style="padding:1px 0px 0px 2px;"/>
						-
						<input name="p_regstno2" type="text" size="2" dataType="integer" dispName="사업자등록번호" isNull="N" lenCheck="2" maxLength="2" value="<%=v_regstno[1] %>" style="padding:1px 0px 0px 2px;"/>
						-
						<input name="p_regstno3" type="text" size="5" dataType="integer" dispName="사업자등록번호" isNull="N" lenCheck="5" maxLength="5" value="<%=v_regstno[2] %>" style="padding:1px 0px 0px 2px;"/>
					</td>
					<td align="center" style="padding-top:2px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
					<td style="padding-top:1px;"><img src="/images/common/txt_bill_txt04.gif"></td>
					<td>
						<input type="text" name="p_comfax" value="<%=v_comfax %>" dispName="팩스번호" isNull="N" lenCheck="20" maxLength="20" style="width:180px; padding:1px 0px 0px 2px;">
					</td>
				</tr>
				<tr><td height="1" colspan="6" bgcolor="#c7c7c7"></td></tr>
				<tr height="35">
					<td align="center" style="padding-top:2px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
					<td style="padding-top:1px;"><img src="/images/common/txt_bill_txt05.gif"></td>
					<td colspan="4">
						<input type="text" name="p_chiefnm" value="<%=v_chiefnm %>" dispName="대표자" isNull="N" style="width:490px; padding:1px 0px 0px 2px;">
					</td>
				</tr>
				<tr><td height="1" colspan="6" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td align="center" style="padding-top:2px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
					<td style="padding-top:1px;"><img src="/images/common/txt_bill_txt06.gif"></td>
					<td colspan="4" style="padding-top:4px; padding-bottom:9px;">
						
						<% if( v_zipcode2 == null || v_zipcode2.equals("")){ %>
							<input type="text" name="p_post1" value="<%= v_zipcode1 %>" dispName="우편번호" isNull="N" lenCheck="5" maxLength="5" style="width:50px;" readonly="readonly">
							<input type="hidden" name="p_post2" value="<%= v_zipcode2 %>" dispName="우편번호" >
						<% } else { %>
							<input type="text" name="p_post1" value="<%= v_zipcode1 %>" dispName="우편번호" isNull="N" style="width:50px;" readonly="readonly"> -
							<input type="text" name="p_post2" value="<%= v_zipcode2 %>" dispName="우편번호" style="width:50px;" readonly="readonly">
						<% } %>
						<a href="#none" onclick="searchZipCode('home')"><img src="/images/common/btn_popup_search_2.gif" vspace="3"></a><br>
						<input type="text" name="p_addr1" value="<%=v_addr1 %>" dispName="주소" isNull="N" lenCheck="100" maxLength="100" style="width:280px; padding:1px 0px 0px 2px;" readonly="readonly">
						<input type="text" name="p_addr2" value="<%=v_addr2 %>" dispName="주소" isNull="Y" lenCheck="100" maxLength="100" style="width:200px; padding:1px 0px 0px 2px;">
					</td>
				</tr>
				<tr><td height="1" colspan="6" bgcolor="#c7c7c7"></td></tr>
				<tr height="35">
					<td align="center" style="padding-top:2px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
					<td style="padding-top:1px;"><img src="/images/common/txt_bill_txt07.gif"></td>
					<td>
						<input type="text" name="p_businesscond" value="<%=v_businesscond %>"  dispName="업태" lenCheck="50" isNull="N"  style="width:200px; padding:1px 0px 0px 2px;">
					</td>
					<td align="center" style="padding-top:2px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
					<td style="padding-top:1px;"><img src="/images/common/txt_bill_txt08.gif"></td>
					<td>
						<input type="text" name="p_businesstype" value="<%=v_businesstype %>" dispName="종목" lenCheck="50" isNull="N" style="width:180px; padding:1px 0px 0px 2px;">
					</td>
				</tr>
				<tr><td height="1" colspan="6" bgcolor="#c7c7c7"></td></tr>
				<tr height="50">
					<td align="center" style="padding-top:2px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
					<td style="padding-top:1px;"><img src="/images/common/txt_bill_txt09.gif"></td>
					<td colspan="4">
						* 별도의 날짜 변경이 없을 경우 아래 표시된 날짜(오늘)로 발행됩니다.<br><br>
						* 발행요청일이 속한 분기 이전의 계산서와 결제일 이전 날짜의 영수 계산서는<br>&nbsp;&nbsp;발행이 불가합니다.<br><br>
						  <fmtag:calendar seq="1" name="form1" property="p_billreqdt" date="<%=v_billreqdt %>" dispName="발행일" defaultYn="Y" isNull="N" position="right"/>
					</td>
				</tr>
				
				<!-- 사업자등록증 파일첨부 -->
				<tr><td height="1" colspan="6" bgcolor="#c7c7c7"></td></tr>
				<tr height="35">
					<td align="center" style="padding-top:2px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
					<td style="padding-top:1px;"><img src="/images/common/txt_bizlicense_txt.gif"></td>
					<td>
						<% if( !v_applygubun.equals("B") && !v_applygubun.equals("C") && (v_bizlicenserealname == null || v_bizlicenserealname.equals("")) ){ %>
							<input type="file" name="p_bizlicenserealname" value="" style="width:300px; background-color:#FFFFFF;">
						<% } else { %>
				  			<a href="#" onClick="billrequestPopFileDown('<%=v_bizlicenserealname%>','<%=v_bizlicensesavename%>')"><img src="../../images/back/icon/icon_file.gif" align="absMiddle"> <%=v_bizlicenserealname%></a>
						<% } %>
					</td>
				</tr>
				
				<tr><td height="1" colspan="6" bgcolor="#c7c7c7"></td></tr>				
				</table>
 
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:10px;">
				<tr>
					<td align="right">
						<%-- <% if ((v_pubgubun.equals("N") || v_pubgubun.equals("")) && !v_applygubun.equals("R") && !v_applygubun.equals("C") ){ %>
						<a href="#" onClick="doBillRequest()"><img src="/images/home0/common/btn_tbl_request.gif"></a>
						<% } %> --%>
						<% if (!v_applygubun.equals("B") && !v_applygubun.equals("C") ){ %> 
						<a href="#" onClick="doBillRequest()"><img src="/images/home0/common/btn_tbl_request.gif"></a>
						<% } %>
						<a href="javascript:self.close()"><img src="/images/common/btn_popup_cancel.gif"></a></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="26" background="/images/common/popup_footer_bg.gif" style="padding-left:20px; padding-right:20px;">
				<table width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/common/popup_footer_copyright.gif"></td>
					<td align="right">
						<a href="javascript:self.close()"><img src="/images/common/btn_popup_close.gif"></a></td>
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

