<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file = "/jsp/back/common/commonInc.jsp"%>

<%

    String  v_mode   = box.getString("p_mode");
    
    Box ds = null;
    if(v_mode.equals("E")){
    	ds = (Box)box.getObject("BusinessPlc");
    } else {
    	ds = new Box("BusinessPlc");
    }
%>
<HTML>
<HEAD>
<TITLE>::: 한국무역협회 무역아카데미 ::: 관리자페이지</TITLE>
<META http-equiv=Content-Type content="text/html; charset=UTF-8"> 
<fmtag:csscommon point="back" />
<fmtag:jscommon />
<SCRIPT LANGUAGE="JavaScript">
<!--
	function businessPlcWrite() {
		var f = document.form1;
		if(!validate(f)) return;

        f.p_businessresno.value=f.p_businessresno1.value+"-"+f.p_businessresno2.value+"-"+f.p_businessresno3.value;
        f.p_telno.value=f.p_telno1.value+"-"+f.p_telno2.value+"-"+f.p_telno3.value;
        f.p_faxno.value=f.p_faxno1.value+"-"+f.p_faxno2.value+"-"+f.p_faxno3.value;
        f.p_zip.value=f.p_zip1.value+"-"+f.p_zip2.value;
		
        f.cmd.value="businessPlcWrite";
	    f.submit();
	}
	
	function businessPlcDelete() {
		var f = document.form1;
		if (confirm("사업장을 정말 삭제하시겠습니까?")) {
			f.p_mode.value = "D";
	        f.cmd.value="businessPlcDelete";
		    f.submit();
		}
	}

	function businessPlcList(){
		var f = document.form1;
		
        f.cmd.value="businessPlcList";
	    f.submit();
	}
	
	function searchZipCode(objname) {
		var url = "/front/Common.do?cmd=selectZipCode&p_objname="+objname; 
		Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
	}
	function setZipCodeInfo(objname, addr, zipcode) {	
		var form = document.form1;

	    if ( objname == "businessPLc" ) {
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
//-->
</SCRIPT>
</HEAD>
<BODY leftMargin=0 topMargin=0 marginheight="0" marginwidth="0">
	<form name="form1" action="/back/Comp.do" method="post" onSubmit="return false;">
	<input type="hidden" name="cmd" value="businessPlcWriteForm">
    <input type="hidden" name="p_mode" 	value="<%= v_mode %>">
    <input type="hidden" name="p_comp" 	value="<%= box.getString("p_comp") %>">
    <input type="hidden" name="p_compnm" 	value="<%= box.getString("p_compnm") %>">
    
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
	<td class="pad_left_15">    
    
    	<!-- 메뉴명 -->
		<table width="300" cellpadding="0" cellspacing="0" class="mar_top_15">
		<tr>
			<td width="15"><img src="/images/back/common/bullet_title.gif"></td>
			<td class="txt_black_b">사업장등록</td>
		</tr>
		</table>
        <!-- //  -->
        
        <!-- 입력폼 -->
		<div class="board-view">
			<table width="600" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="150" />
				<col width="" />
				<col width="150" />
				<col width="" />
			</colgroup>
		    <tr>
				<th class="th_top_bd">사업장코드</th>
				<td class="td_top_bd" colspan="3" >
				  <% if(v_mode.equals("W")){ %>
					<input name="p_businesscd" type="text" size="10" dispName="사업장코드" isNull="N" lenCheck="6" maxLength="6" value="<%=ds.getString("BUSINESSCD")%>" />
				  <% }else{ %>
				    <%=ds.getString("BUSINESSCD")%>  
    				<input type="hidden" name="p_businesscd" 	value="<%= box.getString("p_businesscd") %>">
				  <% } %>	
				</td>
			</tr>
		    <tr>
				<th>사업장명</th>
				<td colspan="3" ><input name="p_businessnm" type="text" size="50" dispName="사업장명" isNull="N" lenCheck="50" maxLength="50" value="<%=ds.getString("BUSINESSNM")%>" /></td>
			</tr>
			<tr>
				<th >대표자이름</th>
				<td >
				     <input type="text" name="p_coname" dispName="대표이름" isNull="Y" lenCheck="30" value="<%=ds.getString("CONAME") %>"> 
				</td>
				<th >사업자등록번호</th>
				<td >
               <%
                  String v_businessresno = ds.getString("BUSINESSRESNO");
                  String[] v_businessresnoInfo = null;
                  if(!v_businessresno.equals(""))
                	  v_businessresnoInfo = StringUtil.split(v_businessresno,"-");
                  else
                	  v_businessresnoInfo = new String[]{"","",""};
                  
                %> 
               <input type="text" name="p_businessresno1" dispName="사업자등록번호" isNull="Y" size="5" maxLength="3" dataType="number" value="<%=v_businessresnoInfo[0] %>">&nbsp;-&nbsp;
               <input type="text" name="p_businessresno2" dispName="사업자등록번호" isNull="Y" size="5" maxLength="2" dataType="number" value="<%=v_businessresnoInfo[1] %>">&nbsp;-&nbsp;
               <input type="text" name="p_businessresno3" dispName="사업자등록번호" isNull="Y" size="5" maxLength="5" dataType="number" value="<%=v_businessresnoInfo[2] %>">
               <input type="hidden" name="p_businessresno" value="<%=v_businessresno %>" >   
  				</td>
			</tr>
			<tr>
				<th >대표자전화번호</th>
				<td >
				 <%
                   String v_telno = ds.getString("TELNO");
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
                   String v_faxno = ds.getString("FAXNO");
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

                <%
                	String zip = ds.getString("ZIP");
                  	String zip1;
                  	String zip2;
                  	if(zip.contains("-")){
                  		zip1 = zip.substring(0, zip.indexOf("-"));
                  		zip2 = zip.substring(zip.indexOf("-")+1, zip.length());
                  	} else {
                  		zip1 = zip;
                  		zip2 = "";
                  	}
                 %> 
                <input type="hidden" name="p_zip" value="<%=zip %>">
                <% if( zip2 == null || zip2.equals("")){ %>
					<input type="text" name="p_zip1" dispName="우편번호" isNull="Y"  size="5" dataType="number" value="<%=zip1 %>" maxlength="5" readonly="readonly">
              	  	<input type="hidden" name="p_zip2" dispName="우편번호" size="5" value="<%=zip2 %>" >	
				<% } else { %>
				  	<input type="text" name="p_zip1" dispName="우편번호" isNull="Y"  size="5" dataType="number" value="<%=zip1 %>"  readonly="readonly">&nbsp;-&nbsp;
              	  	<input type="text" name="p_zip2" dispName="우편번호" size="5" value="<%=zip2 %>" readonly="readonly">	
				<% } %>	
				<a href="#none" onclick="searchZipCode('businessPLc')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a>
				</td>
			</tr>			
			<tr>
				<th >사업장주소</th>
				<td colspan="3" >
                <input type="text" name="p_addr" dispName="사업장주소" isNull="Y" size="80" lenCheck="100" value="<%=ds.getString("ADDR") %>">    				
				</td>
			</tr>			
			</table>
		</div>
		<!-- // -->
		
	    <!-- 버튼 -->
		<table width="600" cellpadding="0" cellspacing="0" class="mar_top_10">
		<tr>
			<td align="center">
				<table cellpadding="0" cellspacing="0">
				<tr><td>
			<%
	      if(s_menucontrol.equals("RW")) {
		    if(v_mode.equals("E")) {
            %>
					<fmtag:button type="1" value="수 정" func="businessPlcWrite()" />&nbsp;
					<fmtag:button type="1" value="삭 제" func="businessPlcDelete()" />&nbsp;
			<%
		    } else {
            %>
					<fmtag:button type="1" value="저 장" func="businessPlcWrite()" />&nbsp;
	      <% }
		   } %>				
		            <fmtag:button type="1" value="목 록" func="businessPlcList()" />&nbsp;
					<fmtag:button type="1" value="닫 기" func="window.close()" />
				</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
		<!-- // -->