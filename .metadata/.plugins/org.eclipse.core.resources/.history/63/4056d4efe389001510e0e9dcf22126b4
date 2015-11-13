<%--
 * @(#)SystemCode Template
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * T_LMS_MEMBER 테이블 List Template.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2010. 11. 06.  leehj       Initial Release
 ************************************************
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file = "/jsp/back/common/commonInc.jsp"%>
<%@ page import ="com.sinc.common.CodeParamDTO"%>
<%

//협회 ip대역이 아닌곳에서 접근시 ip접근제한
	String ipis = request.getHeader("Proxy-Client-IP");
	if(ipis==null){
		ipis = request.getLocalAddr();
	}
	String check_ip = "203.233.";
	if( !(ipis.contains(check_ip+"199") || ipis.contains(check_ip+"201")) ){
		%>
		<!-- b2b 회원추가창 IP 대역으로 제한 해제 
		<script>
		alert("지정된 관리자 IP대역이 아닙니다");
		top.location.href="http://tradecampus.kita.net/jsp/back/";
		</script> -->
		<%
	}
    String v_mode = box.getString("p_mode");
    Box member = (Box)box.getObject("MemberInfo");
    if(member == null) member = new Box("MemberInfo");
    String v_comp = member.getString("COMP");
    String v_gadmin = box.getString("s_gadmin");
    String v_fgadmin = "";
    if(!v_gadmin.equals("H1") && v_gadmin.substring(0,1).equals("H")) v_fgadmin = v_gadmin.substring(0,3); 
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>사용자등록</title>
<fmtag:csscommon point="back" />
<fmtag:jscommon />
<fmtag:dwrcommon interfaceName="MemberWork"/>
<fmtag:dwrcommon interfaceName="CommonUtilWork"/>
<script type="text/JavaScript" language="JavaScript" src="/js/common/util.js"></script>
<script language="javascript">

    function memberWrite(){
       	var f = document.form1;
        
   	     if(f.p_comp.value == ""){
   	         alert("회사명을 선택해 주십시요.");
   	         return;
   	     }
       	
        if(!validate(f)) return;
        if( f.p_mode.value == "W") {
            if( ncCom_Empty(f.p_pwd1.value )  ) {
                alert( "비밀번호를 입력하세요") ;
                f.p_pwd1.focus();
                return ;
            }
            if( ncCom_Empty(f.p_pwd2.value)  ) {
                alert( "비밀번호확인을 입력하세요") ;
                f.p_pwd2.focus();
                return ;
            }
	        if( f.p_pwd1.value != f.p_pwd2.value){
	            alert("비밀번호가 맞지 않습니다.");
	            return;
	        }
        }else {
            if( ncCom_Empty(f.p_pwd1.value)  && ncCom_Empty(f.p_pwd2.value)   ) {

            }else {
            
		        if(f.p_pwd1.value != f.p_pwd2.value){
		            alert("비밀번호가 맞지 않습니다.");
		            return;
		        }
            }            
        }
        f.p_pwd.value = f.p_pwd1.value; 
        if(f.p_mode.value == "W") f.p_resno.value=f.p_resno1.value+f.p_resno2.value;
        f.p_comptel.value=f.p_comptel1.value+"-"+f.p_comptel2.value+"-"+f.p_comptel3.value;
        f.p_handphone.value=f.p_handphone1.value+"-"+f.p_handphone2.value+"-"+f.p_handphone3.value;
        f.p_hometel.value=f.p_hometel1.value+"-"+f.p_hometel2.value+"-"+f.p_hometel3.value;
        if(f.p_email.value != "" && !isEmail(f.p_email.value)) return;
        //주민등록번호 유효성 체크 삭제
        //if(f.p_mode.value == "W" && !jsCheckJumin1(f.p_resno)) return;

        if(f.p_businessplc.value != ""){
        	f.p_businessplcnm.value = f.p_businessplc.options[f.p_businessplc.selectedIndex].text;          
        } 
        if(f.p_jikmu.value != ""){
        	f.p_jikmunm.value = f.p_jikmu.options[f.p_jikmu.selectedIndex].text;          
        } 
        if(f.p_jikup.value != ""){
        	f.p_jikupnm.value = f.p_jikup.options[f.p_jikup.selectedIndex].text;          
        } 
        if(f.p_jikchek.value != ""){
        	f.p_jikcheknm.value = f.p_jikchek.options[f.p_jikchek.selectedIndex].text;          
        } 
        var v_officegbn = getRadioValue(f,"p_officegbn");
        if(v_officegbn == "Y") f.p_officegbnnm.value = "재직";
        else f.p_officegbnnm.value = "퇴직";
        f.cmd.value="memberWrite";   
	    f.submit();
    }
	
	function memberList(){
	    var f = document.form1;
	    
	    f.method = "get";
	    f.cmd.value="memberPageList";   
	    f.submit();
	}
	
	function useridCheck(){
	    var f = document.form1;
	    
	    var userid = f.p_userid.value;
	     if(userid.length < 1){
	        alert("아이디를 입력해 주십시요");
	        return;
	     }
	     
	     if(f.p_comp.value == ""){
	           alert("회사를 선택해 주십시요");
	           return;
	     }
	     
	     var param = {p_userid:f.p_userid.value,p_comp:f.p_comp.value};
	     MemberWork.useridCheckCallBack(param, useridCheckCallBack);	 
	}
	
	function useridCheckCallBack(check){
	   var f = document.form1;
	   if(parseInt(check) < 1){
	       alert("사용가능한 아이디입니다.");
	       f.checkUserid.value = "Y";
	   }else{
	       alert("이미 사용중인 아이디입니다.");
	       f.checkUserid.value = "N";
	       f.p_userid.value = "";
	       f.p_userid.focus();
	   }
	}
	
	function memberDelete(){
   	    var f = document.form1;
	    
	    if(!confirm("현재 사용자를 삭제하시겠습니까?")) return;
	    
	    f.cmd.value="memberDelete";   
	    f.submit();
	}

	function selectComp(){
  	    var f = document.form1;
        var v_comp = f.p_comp.value;

        var param = {p_comp:v_comp,dwrYn:"Y"};
        CommonUtilWork.getBusinessPlc(param,getBusinessPlcCallBack);
        CommonUtilWork.getJikmu(param,getJikmuCallBack);
        CommonUtilWork.getJikchek(param,getJikchekCallBack);
        CommonUtilWork.getJikup(param,getJikupCallBack);
	}

	function getBusinessPlcCallBack(list){
		selectbox_insertlist("p_businessplc", list);
	}
	
	function getJikmuCallBack(list){
		selectbox_insertlist("p_jikmu", list);
	}

	function getJikchekCallBack(list){
		selectbox_insertlist("p_jikchek", list);
	}

	function getJikupCallBack(list){
		selectbox_insertlist("p_jikup", list);
	}

	function searchOrgan(){
        var f = document.form1;

        if(f.p_comp.value == ""){
           alert("회사명을 선택해 주십시요.");
           return;
        }
        
        var url = "/back/Organ.do?cmd=organSearch&p_parentorgcode=000000&comp_code="+f.p_comp.value;
	    Center_Fixed_Popup2(url, "SearchOrgan", 640, 520, "no");  	 
	}

	function setOrgan(orgcd, orgnm){
        var f = document.form1;
        f.p_deptcod.value = orgcd;
        f.p_deptnam.value = orgnm;
	}

	function searchZipCode(objname) {
		var url = "/front/Common.do?cmd=selectZipCode&p_objname="+objname; 
		Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
	}
	function setZipCodeInfo(objname, addr, zipcode) {	
		var form = document.form1;

		if ( objname == "user" ) {
			form.p_addr.value = addr;
			if(zipcode.search('-') > -1){	
				form.p_post1.value = zipcode.substr(0, 3) ;
				form.p_post2.value = zipcode.substr(4, 7) ;	
			} else {
				form.p_post1.value = zipcode;		// 새로운 우편주소, 하나의 텍스트란에 넣음
				form.p_post2.value = "";
				form.p_post2.style.display="none";
			}
	    }
	}	
</script>
</head>

<body>
<form name="form1" method="post" action="/back/Member.do"  onSubmit="return false;">
<input type="hidden" name="cmd" 			value="memberWrite">
<input type="hidden" name="p_mode" 			value="<%=v_mode %>">
<input type="hidden" name="l_pageno" 	value="<%=box.getString("l_pageno") %>">
<input type="hidden" name="l_sortorder" 	value="<%=box.getString("l_sortorder") %>">
<input type="hidden" name="l_comp" 	value="<%=box.getString("l_comp") %>">
<input type="hidden" name="l_jikchek" 	value="<%=box.getString("l_jikchek") %>">
<input type="hidden" name="l_userid" 	value="<%=box.getString("l_userid") %>">
<input type="hidden" name="l_name" 	value="<%=box.getString("l_name") %>">
<input type="hidden" name="p_businessplcnm" 	value="<%=member.getString("BUSINESSPLCNM") %>">
<input type="hidden" name="p_jikmunm" 	value="<%=member.getString("JIKMUNM") %>">
<input type="hidden" name="p_jikupnm" 	value="<%=member.getString("JIKUPNM") %>">
<input type="hidden" name="p_jikcheknm" 	value="<%=member.getString("JIKCHEKNM") %>">
<input type="hidden" name="p_deptcod" 	value="<%=member.getString("DEPTCOD") %>">
<input type="hidden" name="p_officegbnnm" 	value="<%=member.getString("OFFICE_GBNNM") %>">

<table width="100%" cellpadding="0" cellspacing="0">
<tr>
	<td class="pad_left_15">

     <!-- 메뉴명 -->
	<table width="985" cellpadding="0" cellspacing="0" class="mar_top_20">
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
			<th class="th_top_bd">*회사명</th>
			<td class="td_top_bd" colspan="3">
			 <% 
			    HashMap param = new HashMap();
			    if(v_mode.equals("W")){ 
					param.put("objNm","p_comp");
					param.put("event","selectComp()");
					param.put("first","선택");
					param.put("selected",v_comp);
					param.put("groupView","N");
			 %>
			 <%=CommonUtil.getComp(param, request) %>
            <%}else{%> 
                <%=member.getString("COMPNM2") %> 
                <input type="hidden" name="p_comp" value="<%=member.getString("COMP") %>">
            <% } %> 
			</td>
		</tr>
		<tr>
			<th>사업장</th>
			<td>
			 <%  
			        param = new HashMap();
					param.put("objNm","p_businessplc");
					param.put("first","선택");
					param.put("selected",member.getString("BUSINESSPLC"));
					param.put("p_comp",v_comp);
			 %> 
			 <%=CommonUtil.getBusinessPlc(param, request) %>
			</td>
			<th >직무</th>		
			<td >
			 <%  
			        param = new HashMap();
					param.put("objNm","p_jikmu");
					param.put("first","선택");
					param.put("selected",member.getString("JIKMU"));
					param.put("p_comp",v_comp);
			 %> 
			 <%=CommonUtil.getJikmu(param, request) %>			
			</td>
		</tr>
		<tr>
			<th>직급</th>
			<td>
			 <%  
			        param = new HashMap();
					param.put("objNm","p_jikup");
					param.put("first","선택");
					param.put("selected",member.getString("JIKUP"));
					param.put("p_comp",v_comp);
			 %> 
			 <%=CommonUtil.getJikup(param, request) %>
			</td>
			<th >직책</th>		
			<td >
			 <%  
			        param = new HashMap();
					param.put("objNm","p_jikchek");
					param.put("first","선택");
					param.put("selected",member.getString("JIKCHEK"));
					param.put("p_comp",v_comp);
			 %> 
			 <%=CommonUtil.getJikchek(param, request) %>			
			</td>
		</tr>		
		<tr>
			<th>*사용자ID</th>
			<td colspan="3">
                <% if(v_mode.equals("W")){ %>
                <input type="text" name="p_userid" dispName="사용자ID" isNull="N" lenCheck="20" value="<%=member.getString("USERID") %>"><%=member.getString("USERID") %>
                <input type="hidden" name="checkUserid" value="N">
                <fmtag:button type="2" value="중복확인" func="useridCheck()" />
                <%}else{%>
                  <%=member.getString("USERID") %>
                  <input type="hidden" name="p_userid" 	value="<%=member.getString("USERID") %>">
                <%}%>			
			</td>
        </tr>  
		<tr>
			<th>*비밀번호</th>
			<td>
			 <input type="password" name="p_pwd1" dispName="비밀번호" lenCheck="20" value="">  
			</td>
			<th>*비밀번호확인</th>
			<td>
                <input type="password" name="p_pwd2" dispName="비밀번호확인" lenCheck="20" value="">
                <input type="hidden" name="p_pwd" value="" >   			
			</td>
        </tr>          		
		<tr>
			<th>*성명</th>
			<td>
			 <input type="text" name="p_name" dispName="성명" isNull="N" lenCheck="30" value="<%=member.getString("NAME") %>">  
			</td>
			<th>부서</th>
			<td>
                <input type="text" name="p_deptnam" value="<%=member.getString("DEPTNAM") %>" size="30" >
                <fmtag:button type="4" value="검색" func="searchOrgan()" />   			
			</td>
        </tr>
		<tr>
			<th>*주민등록번호</th>
			<td colspan="3">
                <%
                   String v_resno = member.getString("RESNO");
                   String v_resno1 ="", v_resno2 ="";
                   if(!v_resno.equals("")){
                       v_resno1 = v_resno.substring(0,6);
                       v_resno2 = v_resno.substring(6,13);
                   }
                   if(v_mode.equals("W")){
                 %> 
                <input type="text" name="p_resno1" dispName="주민등록번호" isNull="N" maxLength="6" dataType="number" value="<%=v_resno1 %>"> - *******
                <input type="hidden" name="p_resno2" dispName="주민등록번호" isNull="N" maxLength="7" dataType="number" value="1000000" >
                <% }else { %>
                <%=v_resno1 %> - <%=v_resno2 %>
                <% } %>
                <input type="hidden" name="p_resno" value="<%=v_resno %>" > 
			</td>
        </tr>          
        <tr>
			<th>우편번호</th>
			<td colspan="3">	
			<% if( member.getString("POST2") == null || member.getString("POST2").equals("")){ %>
				<input type="text" name="p_post1" dispName="우편번호" isNull="Y" maxLength="5" dataType="number" value="<%=member.getString("POST1") %>" style="width:60" readonly="readonly">
				<input type="hidden" name="p_post2" dispName="우편번호" value="<%=member.getString("POST1") %>">
			<% } else { %>
				<input type="text" name="p_post1" dispName="우편번호" isNull="Y" dataType="number" value="<%=member.getString("POST1") %>" style="width:60" readonly="readonly">&nbsp;-
                <input type="text" name="p_post2" dispName="우편번호" dataType="number" value="<%=member.getString("POST2") %>" style="width:60" readonly="readonly">
			<% } %>
                &nbsp;<a href="#none" onclick="searchZipCode('user')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a>
     		</td>
        </tr>  
        <tr>
			<th>주소</th>
			<td colspan="3">
               <input type="text" name="p_addr" dispName="주소" isNull="Y" lenCheck="1000" style="width:503" value="<%=member.getString("ADDR") %>">
     		</td>
        </tr>                                    		
        <tr>
			<th>E-Mail</th>
			<td colspan="3">
               <input type="text" name="p_email" dispName="Email" isNull="Y" lenCheck="50" style="width:275" value="<%=member.getString("EMAIL") %>">
     		</td>
        </tr>                                    		
        <tr>
			<th>회사전화번호</th>
			<td colspan="3">
                <%
                  String v_comptel = member.getString("COMPTEL");
                  String[] v_comptelInfo = new String[]{"","",""};
                  if(!v_comptel.equals("")){
                      String[] v_comptelInfo2 = StringUtil.split(v_comptel,"-"); 
                      System.arraycopy(v_comptelInfo2, 0, v_comptelInfo, 0, v_comptelInfo2.length); 
                  }
                %> 
               <input type="hidden" name="p_comptel" value="<%=v_comptel %>">
               <input type="text" name="p_comptel1" dispName="회사전화번호" isNull="Y"  dataType="number" value="<%=v_comptelInfo[0] %>" maxlength="4" style="width:60">&nbsp;-
               <input type="text" name="p_comptel2" dispName="회사전화번호" isNull="Y"  dataType="number" value="<%=v_comptelInfo[1] %>" maxlength="4" style="width:60">&nbsp;-
               <input type="text" name="p_comptel3" dispName="회사전화번호" isNull="Y"  dataType="number" value="<%=v_comptelInfo[2] %>" maxlength="4" style="width:60">
     		</td>
        </tr> 
        <tr>
			<th>이동전화번호</th>
			<td colspan="3">
                <%
                   String v_handphone = member.getString("HANDPHONE");
                   String[] v_handphoneInfo = new String[]{"","",""};
                   if(!v_handphone.equals("")){
                       String[] v_handphoneInfo2 = StringUtil.split(v_handphone,"-"); 
                       System.arraycopy(v_handphoneInfo2, 0, v_handphoneInfo, 0, v_handphoneInfo2.length); 
                   }
                 %> 
                <input type="hidden" name="p_handphone" value="<%=v_handphone %>">
                <input type="text" name="p_handphone1" dispName="이동전화번호" isNull="Y"  dataType="number" value="<%=v_handphoneInfo[0] %>" maxlength="4" style="width:60">&nbsp;-
                <input type="text" name="p_handphone2" dispName="이동전화번호" isNull="Y"  dataType="number" value="<%=v_handphoneInfo[1] %>" maxlength="4" style="width:60">&nbsp;-
                <input type="text" name="p_handphone3" dispName="이동전화번호" isNull="Y"  dataType="number" value="<%=v_handphoneInfo[2] %>" maxlength="4" style="width:60">
     		</td>
        </tr> 
        <tr>
			<th>자택전화번호</th>
			<td colspan="3">
               <%
                   String v_hometel = member.getString("HOMETEL");
                   String[] v_hometelInfo = new String[]{"","",""};
                   if(!v_hometel.equals("")){
                       String[] v_hometelInfo2 = StringUtil.split(v_hometel,"-"); 
                       System.arraycopy(v_hometelInfo2, 0, v_hometelInfo, 0, v_hometelInfo2.length); 
                   }
                 %> 
                <input type="hidden" name="p_hometel" value="<%=v_hometel %>">
                <input type="text" name="p_hometel1" dispName="자택전화번호" isNull="Y" dataType="number" value="<%=v_hometelInfo[0] %>" maxlength="4" style="width:60">&nbsp;-
                <input type="text" name="p_hometel2" dispName="자택전화번호" isNull="Y" dataType="number" value="<%=v_hometelInfo[1] %>" maxlength="4" style="width:60">&nbsp;-
                <input type="text" name="p_hometel3" dispName="자택전화번호" isNull="Y" dataType="number" value="<%=v_hometelInfo[2] %>" maxlength="4" style="width:60">
     		</td>
        </tr> 
       <tr>
			<th>재직여부</th>
			<td>
               <input type="radio" name="p_officegbn" value="Y" <%=member.getString("OFFICE_GBN").equals("Y")||member.getString("GUBUN").equals("")?"checked":"" %>>재직&nbsp;
              <input type="radio" name="p_officegbn" value="N" <%=member.getString("OFFICE_GBN").equals("N")?"checked":"" %>>퇴직&nbsp; 
     		</td>
   			<th>인증여부</th>
			<td>
               <input type="radio" name="p_certiyn" value="Y" <%=member.getString("CERTIYN").equals("Y")?"checked":"" %>>Yes&nbsp;
              <input type="radio" name="p_certiyn" value="N" <%=member.getString("CERTIYN").equals("N")||member.getString("CERTIYN").equals("")?"checked":"" %>>No&nbsp; 
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
           %>
				<fmtag:button type="1" value="수 정" func="memberWrite()" />&nbsp;
				<fmtag:button type="1" value="삭 제" func="memberDelete()" />&nbsp;
		<%
	    } else {
           %>
				<fmtag:button type="1" value="저 장" func="memberWrite()" />&nbsp;
      <% }
	   } %>				
				<fmtag:button type="1" value="취 소" func="memberList()" />
			  </td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
	<!-- // -->
	
	  <!--푸터부분 시작-->
	  <%@ include file = "/jsp/back/common/bottom.jsp"%>
	  <!--푸터부분 끝-->	