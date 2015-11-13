<%--
 * @(#)SystemCode Template
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * T_LMS_COMPCLASS 테이블 List Template.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2009. 11. 06.  leehj       Initial Release
 ************************************************
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file = "/jsp/back/common/commonInc.jsp"%>
<%@ page import ="com.sinc.common.CodeParamDTO"%>
<%
    String v_mode = box.getString("p_mode");
    Box comp = (Box)box.getObject("Comp");
    if(comp == null) comp = new Box("Comp");
    String v_gubun = comp.getString("GUBUN");
    String v_comp = comp.getString("COMP");
    String v_uppercomp = comp.getString("UPPERCOMP");
    
    String zip = comp.getString("ZIP");
  	String zip1;
  	String zip2;
  	if( !StringUtil.isNull(zip) && !zip.equals("-")){
  		if(zip.contains("-")){
  			zip1 = zip.substring(0, zip.indexOf("-"));
  			zip2 = zip.substring(zip.indexOf("-")+1, zip.length());
  		} else if (zip.length() > 5){
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
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>고객사등록</title>
<fmtag:csscommon point="back" />
<fmtag:jscommon />
<script language="Javascript" src="/js/common/calendar.js"></script>
<fmtag:dwrcommon interfaceName="CompWork"/>
<script language="javascript">

    function compWrite(){
       	var f = document.form1;

        if(!validate(f)) return;
        <% if(v_mode.equals("W")){ %>  
         var gubun = getRadioValue(f, "p_gubun");
        <%}else{%>
         var gubun = f.p_gubun.value;
        <%}%>

	     <% if(v_mode.equals("W")){ %>  
         if(f.p_prefix.value == ""){
           alert("Prefix를 입력해 주십시요.");
           return;
         }
         
         if(f.checkPrefix.value == "N"){
           alert("Prefix 중복 검사를 해주십시요.");
           return;
         }
	     <%}%>
	     
        f.p_compresno.value=f.p_compresno1.value+"-"+f.p_compresno2.value+"-"+f.p_compresno3.value;
        f.p_telno.value=f.p_telno1.value+"-"+f.p_telno2.value+"-"+f.p_telno3.value;
        f.p_faxno.value=f.p_faxno1.value+"-"+f.p_faxno2.value+"-"+f.p_faxno3.value;
        if( f.p_zip2.value == null || f.p_zip2.value == ""){
        	f.p_zip.value=f.p_zip1.value;
        } else {
        	f.p_zip.value=f.p_zip1.value+"-"+f.p_zip2.value;
        }
        f.action = "/back/Comp.do?cmd=compWrite";
 	    f.submit();
    }
	
	function compList(){
	    var f = document.form1;

	   f.encoding = "application/x-www-form-urlencoded";
	   f.cmd.value= "compPageList";   
	   f.submit(); 
	}
	
	function changeGubun(idx){
		var compobjtr = document.getElementById("compObjTr");
		var prefixtr = document.getElementById("prefixTr");
		
	    if(idx == 3) {
	    	compobjtr.style.display="";
	    	prefixtr.style.display="";
	    }else if(idx == 2){
	        compobjtr.style.display="none";
	        prefixtr.style.display="";
	    }else{
	        compobjtr.style.display="none";
	        prefixtr.style.display="none";
	    }    
	}
	
	function prefixCheck(){
	     var f = document.form1;
	     var prefix = f.p_prefix.value;
	     
	     
	     if(prefix.length < 1){
	        alert("Prefix를 입력해 주십시요");
	        return;
	     }
	     
	     CompWork.prefixCheckCallBack(prefix, prefixCheckCallBack);
	}
	
	function prefixCheckCallBack(check){
	   var f = document.form1;
	   if(parseInt(check) < 1){
	       alert("사용가능한 Prefix입니다.");
	       f.checkPrefix.value = "Y";
	   }else{
	       alert("이미 사용중인 Prefix입니다.");
	       f.checkPrefix.value = "N";
	       f.p_prefix.value = "";
	       f.p_prefix.focus();
	   }
	}
	
	function compDelete(){
	   var f = document.form1;
	   
	   if(!confirm("현재 고객사 정보를 수정하시겠습니까?")) return;
	   
	   f.encoding = "application/x-www-form-urlencoded";
	   f.cmd.value="compDelete";   
	   f.submit();
	}

	function compPageList(){
	   var f = document.form1;
	   
	   f.encoding = "application/x-www-form-urlencoded";	   
	   f.cmd.value="compPageList";   
	   f.submit();     
    }

	function searchZipCode(objname) {
		var url = "/front/Common.do?cmd=selectZipCode&p_objname="+objname; 
		Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
	}
	function setZipCodeInfo(objname, addr, zipcode) {	
		var form = document.form1;

	    if ( objname == "home" ) {
			form.p_addr.value = addr;
			if(zipcode.search('-') > -1){	
				form.p_zip1.value = zipcode.substr(0, 3) ;
				form.p_zip2.value = zipcode.substr(4, 7) ;	
			} else {
				form.p_zip1.value = zipcode;		// 새로운 우편주소, 하나의 텍스트란에 넣음
				form.p_zip2.value = "";
				form.p_zip2.style.display="none";
			}
	    }
	}
</script>
</head>

<body onLoad="firstTextFocus()">
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
	<td class="pad_left_15">
<form name="form1" method="post" action="/back/Comp.do"  onSubmit="return false;"  enctype="multipart/form-data">
<input type="hidden" name="cmd" 			value="compWrite">
<input type="hidden" name="l_pageno" 	value="<%=box.getString("l_pageno") %>">
<input type="hidden" name="l_sortorder" 	value="<%=box.getString("l_sortorder") %>">
<input type="hidden" name="l_gubun" 	value="<%=box.getString("l_gubun") %>">
<input type="hidden" name="l_compnm" 	value="<%=box.getString("l_compnm") %>">
<input type="hidden" name="p_mode" 			value="<%=v_mode %>">
<input type="hidden" name="p_groupyn" 			value="N">
<input type="hidden" name="p_oldfile" 	value="<%=comp.getString("COMPLOGO") %>">
<input type="hidden" name="p_oldfile1" 	value="<%=comp.getString("COMPLOGOBOTTOM") %>">

    <!-- 메뉴명 -->
	<table width="985" cellpadding="0" cellspacing="0" class="mar_top_10">
	<colgroup>
		<col width="10" />
		<col width="" />
		<col width="15" />
	</colgroup>
	<tr>
		<td><img src="/images/back/common/bullet_title.gif"></td>
		<td class="t_title"><%=s_menunavi %></td>
		<td align="right" valign="bottom"></td>
	</tr>
	</table>
	<!-- // -->	

		<!-- 입력폼 -->
		<div class="board-view">
			<table width="985" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="200" />
				<col width="" />
				<col width="200" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="th_top_bd">고객사구분</th>
				<td colspan="3" class="td_top_bd">
				<%=CommonUtil.getCodeListBox("radio","0004","p_gubun",v_gubun,null,null)%>
				</td>
			</tr>
			<tr>
				<th >그룹사</th>
				<td colspan="3" >
			 		<%
						CodeParamDTO param = new CodeParamDTO();
						param.setTableName("T_LMS_COMPCLASS");
						param.setCodeCol("COMP as CODE");
						param.setNameCol("COMPNM as CODENM");
						param.setFirst("-없음-");
						param.setCondStmt(" groupyn = 'Y' ");
						param.setSelected(v_uppercomp);
						param.setName("p_uppercomp");
					%>
					<%=CommonUtil.getCodeListBox(param)%>
				</td>
			</tr>
			<tr>
				<th >고객사코드</th>
				<td colspan="3" >
				   <% if(v_mode.equals("E")){ %>
				       <%=comp.getString("COMP")%>
				       <input type="hidden" name="p_comp" value="<%=comp.getString("COMP")%>">
				   <% }else{ %>  
				   	  <input name="p_comp" type="text" size="50" dispName="고객사코드" isNull="N" lenCheck="6" maxLength="6" value="<%=comp.getString("COMP")%>" />
				   <% } %>
				</td>
			</tr>
			<tr>
				<th >고객사명</th>
				<td colspan="3" ><input name="p_compnm" type="text" size="50" dispName="고객사명" isNull="N" lenCheck="50" maxLength="50" value="<%=comp.getString("COMPNM")%>" /></td>
			</tr>
			<tr>
				<th >Prefix</th>
				<td colspan="3" >
			   <table  cellpadding="0" cellspacing="0" ><tr><td>
			   <input type="text" name="p_prefix" size="20" value="<%=comp.getString("PREFIX") %>" dispName="Prefix " isNull="Y" lenCheck="2" maxLength="2" <%=v_mode.equals("E")?"readOnly":"" %>>
               <input type="hidden" name="checkPrefix" value="<%=!comp.getString("PREFIX").equals("")?"Y":"N" %>">
               </td><td>
               <% if(v_mode.equals("W")){ %>
               <fmtag:button type="2" value="Prefix중복확인" func="prefixCheck()" />
               <% } %>
               </td>
               </table>
				</td>
			</tr>
			<tr>
				<th >대표자이름</th>
				<td >
				     <input type="text" name="p_coname" dispName="대표이름" isNull="Y" lenCheck="30" value="<%=comp.getString("CONAME") %>"> 
				</td>
				<th >사업자등록번호</th>
				<td >
               <%
                  String v_compresno = comp.getString("COMPRESNO");
                  String[] v_compresnoInfo = null;
                  if(!v_compresno.equals(""))
                  	v_compresnoInfo = StringUtil.split(v_compresno,"-");
                  else
                  	v_compresnoInfo = new String[]{"","",""};
                  
                %> 
               <input type="text" name="p_compresno1" dispName="사업자등록번호" isNull="Y" size="5" maxLength="3" dataType="number" value="<%=v_compresnoInfo[0] %>">&nbsp;-&nbsp;
               <input type="text" name="p_compresno2" dispName="사업자등록번호" isNull="Y" size="5" maxLength="2" dataType="number" value="<%=v_compresnoInfo[1] %>">&nbsp;-&nbsp;
               <input type="text" name="p_compresno3" dispName="사업자등록번호" isNull="Y" size="5" maxLength="5" dataType="number" value="<%=v_compresnoInfo[2] %>">
               <input type="hidden" name="p_compresno" value="<%=v_compresno %>" >   
  				</td>
			</tr>
			<tr>
				<th >대표자전화번호</th>
				<td >
				 <%
                   String v_telno = comp.getString("TELNO");
                   String[] v_telnoInfo = new String[]{"","",""};
                   if(!v_telno.equals("")){
                       v_telnoInfo = StringUtil.split(v_telno,"-"); 
                   }
                 %> 
                <input type="hidden" name="p_telno" value="<%=v_telno %>">
                <input type="text" name="p_telno1" dispName="대표전화번호" isNull="Y" size="5" dataType="number" value="<%=v_telnoInfo[0] %>" maxlength="4">&nbsp;-&nbsp;
                <input type="text" name="p_telno2" dispName="대표전화번호" isNull="Y" size="5" dataType="number" value="<%=v_telnoInfo[1] %>" maxlength="4">&nbsp;-&nbsp;
                <input type="text" name="p_telno3" dispName="대표전화번호" isNull="Y" size="5" dataType="number" value="<%=v_telnoInfo[2] %>" maxlength="4">
				</td>
				<th >팩스번호</th>
				<td >
                <%
                   String v_faxno = comp.getString("FAXNO");
                   String[] v_faxnoInfo = new String[]{"","",""};
                   if(!v_faxno.equals("")){
                       v_faxnoInfo = StringUtil.split(v_faxno,"-"); 
                   }
                 %> 
                <input type="hidden" name="p_faxno" value="<%=v_faxno %>">
                <input type="text" name="p_faxno1" dispName="팩스번호" isNull="Y"  size="5" dataType="number" value="<%=v_faxnoInfo[0] %>" maxlength="4">&nbsp;-&nbsp;
                <input type="text" name="p_faxno2" dispName="팩스번호" isNull="Y"  size="5" dataType="number" value="<%=v_faxnoInfo[1] %>" maxlength="4">&nbsp;-&nbsp;
                <input type="text" name="p_faxno3" dispName="팩스번호" isNull="Y"  size="5" dataType="number" value="<%=v_faxnoInfo[2] %>" maxlength="4">				
				</td>
			</tr>			
			<tr>
				<th >우편번호</th>
				<td colspan="3" >

                <input type="hidden" name="p_zip" value="<%=zip %>">
                <% if( zip2 == null || zip2.equals("")){ %>
					<input type="text" name="p_zip1" dispName="우편번호" isNull="Y"  size="5" dataType="number" value="<%=zip1 %>" maxlength="5" readonly="readonly">
              	  	<input type="hidden" name="p_zip2" dispName="우편번호" size="5" value="<%=zip2 %>" >	
				<% } else { %>
				  	<input type="text" name="p_zip1" dispName="우편번호" isNull="Y"  size="5" dataType="number" value="<%=zip1 %>" readonly="readonly">&nbsp;-&nbsp;
              	  	<input type="text" name="p_zip2" dispName="우편번호" size="5" value="<%=zip2 %>" readonly="readonly">	
				<% } %>	
				<a href="#none" onclick="searchZipCode('home')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a>
				</td>
			</tr>			
			<tr>
				<th >사업장주소</th>
				<td colspan="3" >
                <input type="text" name="p_addr" dispName="사업장주소" isNull="Y" size="80" lenCheck="100" value="<%=comp.getString("ADDR") %>" >    				
				</td>
			</tr>			
			<tr>
				<th >대내여부</th>
				<td >
<input type="radio" name="p_foreinteryn" dispName="대내여부" isNull="Y" <%=comp.getString("FOREINTERYN").equals("I")||comp.getString("FOREINTERYN").equals("")?"checked":"" %> value="I">대내
&nbsp;
<input type="radio" name="p_foreinteryn" dispName="대내여부" isNull="Y" <%=comp.getString("FOREINTERYN").equals("O")?"checked":"" %> value="O">대외				
				</td>
				<!-- th >IDP/CDP여부</th>
				<td >
<input type="radio" name="p_idpcdpyn" dispName="IDP/CDP여부" isNull="Y" <%=comp.getString("IDPCDPYN").equals("N")||comp.getString("IDPCDPYN").equals("")?"checked":"" %> value="N">해당없음
&nbsp;
<input type="radio" name="p_idpcdpyn" dispName="IDP/CDP여부" isNull="Y" <%=comp.getString("IDPCDPYN").equals("I")?"checked":"" %> value="I">IDP
&nbsp;
<input type="radio" name="p_idpcdpyn" dispName="IDP/CDP여부" isNull="Y" <%=comp.getString("IDPCDPYN").equals("C")?"checked":"" %> value="C">CDP				
				</td>
			</tr>			
			<tr-->
				<th >신청제한개수</th>
				<td>
<input type="text" name="p_applycnt" dispName="신청제한개수" isNull="Y"  size="5" dataType="number" value="<%=comp.getInt("APPLYCNT") %>" maxlength="3">				
				</td>
			</tr>			
			<tr>
				<th >고객사로고</th>
				<td colspan="3" >
			    <% if(!comp.getString("COMPLOGO").equals("")){ %>
	                  <a href="javascript:fileDownload('<%=comp.getString("COMPLOGO") %>', '<%=comp.getString("COMPLOGO") %>', '')"><img src="/upload/comp/<%=comp.getString("COMPLOGO")%>"></a><br>
	            <% } %>
	            <input name="p_file" type="file" size="70" class="input2"/>
				</td>
			</tr>
			<tr>
				<th >고객사로고하단</th>
				<td colspan="3" >
			    <% if(!comp.getString("COMPLOGOBOTTOM").equals("")){ %>
	                  <a href="javascript:fileDownload('<%=comp.getString("COMPLOGOBOTTOM") %>', '<%=comp.getString("COMPLOGOBOTTOM") %>', '')"><img src="/upload/comp/<%=comp.getString("COMPLOGOBOTTOM")%>"></a><br>
	            <% } %>
	            <input name="p_file1" type="file" size="70" class="input2"/>
				</td>
			</tr>						
			<tr>
				<th >훈련기관번호</th>
				<td colspan="3" >
              <input type="text" name="p_trainorgno" dispName="훈련기관번호" isNull="Y" size="80" lenCheck="100" value="<%=comp.getString("TRAINORGNO") %>">    							
				</td>
			</tr>			
			<tr>
				<th >운영자</th>
				<td >
              <input type="text" name="p_manager" dispName="운영자" isNull="Y" size="30" lenCheck="100" value="<%=comp.getString("MANAGER") %>">    							
				</td>
				<th >영업담당자</th>
				<td >
              <input type="text" name="p_salecharge" dispName="영업담당자" isNull="Y" size="30" lenCheck="100" value="<%=comp.getString("SALECHARGE") %>">    							
				</td>
			</tr>	
			<tr>
				<th >대기업여부</th>
				<td >
<input type="radio" name="p_enterpriseyn" dispName="대기업여부" isNull="Y" <%=comp.getString("ENTERPRISEYN").equals("Y")||comp.getString("ENTERPRISEYN").equals("")?"checked":"" %> value="Y">대기업
&nbsp;
<input type="radio" name="p_enterpriseyn" dispName="대기업여부" isNull="Y" <%=comp.getString("ENTERPRISEYN").equals("N")?"checked":"" %> value="N">중소기업							
				</td>
				<th >BtoB/BtoC여부</th>
				<td >
<input type="radio" name="p_btobyn" dispName="BtoB/BtoC여부" isNull="Y" <%=comp.getString("BTOBYN").equals("Y")||comp.getString("BTOBYN").equals("")?"checked":"" %> value="Y">BtoB
&nbsp;
<input type="radio" name="p_btobyn" dispName="BtoB/BtoC여부" isNull="Y" <%=comp.getString("BTOBYN").equals("N")?"checked":"" %> value="N">BtoC								
				</td>
			</tr>						
			<tr>
				<th>수강신청기간</th>
				<td>
				   <%
				       String v_applystart = comp.getString("APPLYSTART");
				       String v_applyend = comp.getString("APPLYEND");
				   %>
				   <fmtag:calendar seq="1" name="form1" property="p_applystart" dispName="수강신청기간" date="<%=v_applystart %>" defaultYn="N" position="right"/>~
				   <fmtag:calendar seq="2" name="form1" property="p_applyend" dispName="수강신청기간" date="<%=v_applyend %>" defaultYn="N" position="right"/>
				</td>
				<th>수료증 출력여부</th>
				<td >
				   <%
				       String certificates = comp.getString("CERTIFICATES");				       
				   %>
				   <select name="p_certificates">
				   	<option value="N">N</option>
				   	<option value="Y" <%if("Y".equals(certificates)){ %>selected<%} %>>Y</option>
				   </select>
				</td>
			</tr>			
			<tr>
				<th>하단주소표시</th>
				<td colspan="3" >
					<textarea name="p_compaddr" cols="120" rows="4" dispName="하단주소표시" isNull="Y" lenCheck="2000"><%=comp.getString("COMPADDR")%></textarea>
				</td>
			</tr>			
			</table>
		</div>
		<!-- // -->

		<!-- 버튼 -->
		<table width="985" cellpadding="0" cellspacing="0" class="mar_top_10">
		<tr>
			<td align="center">
				<table cellpadding="0" cellspacing="0">
				<tr>
					<td>
			<%
	      if(s_menucontrol.equals("RW")) {
		    if(v_mode.equals("E")) {
		    	if("N".equals(comp.getString("ISDELETED"))){
            %>
            		<input name="p_isdeleted" type="hidden" value="Y">
					<fmtag:button type="1" value="수 정" func="compWrite()" />&nbsp;
					<fmtag:button type="1" value="미사용" func="compDelete()" />&nbsp;
			<%
		    	}else{
		    %>
		    		<input name="p_isdeleted" type="hidden" value="N">
		    		<fmtag:button type="1" value="수 정" func="compWrite()" />&nbsp;
					<fmtag:button type="1" value="사용" func="compDelete()" />&nbsp;
					
			<%
		    	}
		    } else {
            %>
					<fmtag:button type="1" value="저 장" func="compWrite()" />&nbsp;
	      <% }
		   } %>				
					<fmtag:button type="1" value="취 소" func="compPageList()" />
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
		<!-- // -->
</form>		
	  <!--푸터부분 시작-->
	  <%@ include file = "/jsp/back/common/bottom.jsp"%>
	  <!--푸터부분 끝-->