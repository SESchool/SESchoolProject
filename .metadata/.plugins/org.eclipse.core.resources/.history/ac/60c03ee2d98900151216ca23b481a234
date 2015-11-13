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
		<script>
		alert("지정된 관리자 IP대역이 아닙니다");
		top.location.href="http://tradecampus.kita.net/jsp/back/";
		</script>
		<%
	}
    String v_mode = box.getString("p_mode");
    Box member = (Box)box.getObject("MemberInfo");
    if(member == null) member = new Box("MemberInfo");
    Box interest = (Box)box.getObject("MemberInterest");
    if(interest == null) interest = new Box("MemberInterest");
    Box field = (Box)box.getObject("MemberField");
    if(field == null) field = new Box("MemberField");
    Box join = (Box)box.getObject("MemberJoin");
    if(join == null) join = new Box("MemberJoin");

    String v_comp = member.getString("COMP");
    String v_gadmin = box.getString("s_gadmin");

    String v_usergubun = box.getStringDefault("p_usergubun","KC");  
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>사용자등록</title>
<fmtag:csscommon point="back" />
<fmtag:jscommon />
<script language="Javascript" src="/js/common/calendar.js"></script>
<script type="text/JavaScript" language="JavaScript" src="/js/common/util.js"></script>
<fmtag:dwrcommon interfaceName="MemberWork"/>
<fmtag:dwrcommon interfaceName="CommonUtilWork"/>
<script language="javascript">

    function memberWrite(){
       	var f = document.form1;
         	
        if(!validate(f)) return;

        if(f.checkUserid.value == "N"){
            alert("사용자ID 중복확인을 해주십시요.");
            return;
        }
        
        if( f.p_mode.value == "W") {
            if( ncCom_Empty(f.p_pwd1.value )  ) {
                alert( "비밀번호를 입력하세요") ;
                f.p_pwd1.focus();
                return ;
            }
            if( ncCom_Empty(f.p_pwdconfirm.value) ) {
                alert( "비밀번호확인을 입력하세요") ;
                f.p_pwdconfirm.focus();
                return ;
            }
	        if( f.p_pwd1.value != f.p_pwdconfirm.value){
	            alert("비밀번호가 맞지 않습니다.");
	            return;
	        }
        }else {
            if( ncCom_Empty(f.p_pwd1.value)  && ncCom_Empty(f.p_pwdconfirm.value)   ) {

            }else {
            
		        if(f.p_pwd1.value != f.p_pwdconfirm.value){
		            alert("비밀번호가 맞지 않습니다.");
		            return;
		        }
            }            
        }
        f.p_pwd.value = f.p_pwd1.value; 
        <% if(v_usergubun.equals("KC") || v_usergubun.equals("KF")){ // 외국인일 경우 제외%>
        if(f.p_mode.value == "W") f.p_resno.value=f.p_resno01.value+f.p_resno02.value;
        f.p_hometel.value=f.p_hometel1.value+"-"+f.p_hometel2.value+"-"+f.p_hometel3.value;
        f.p_handphone.value=f.p_handphone1.value+"-"+f.p_handphone2.value+"-"+f.p_handphone3.value;
        f.p_homefax.value=f.p_homefax1.value+"-"+f.p_homefax2.value+"-"+f.p_homefax3.value;
        f.p_saupjano.value=f.p_saupjano1.value+"-"+f.p_saupjano2.value+"-"+f.p_saupjano3.value; 
        <%-- 주민등록번호 유효성검사 제거
        <% if ( v_usergubun.equals("KC") ) { %>
        	if( f.p_mode.value == "W" && !jsCheckJumin1(f.p_resno) ) return;
        <%}%> --%>
        
        if(f.p_jobc_csenr.value != "") f.p_jobc_name.value = f.p_jobc_csenr.options[f.p_jobc_csenr.selectedIndex].text;  
        <% }else if (v_usergubun.equals("FK")) {  // 해외거주 한국인%>
        	if(f.p_mode.value == "W") f.p_resno.value=f.p_resno01.value;
        <%}%>   
        if(f.p_email.value != "" && !isEmail(f.p_email.value)) return;

        var v_officegbn = getRadioValue(f,"p_office_gbn");
        if(v_officegbn == "Y") f.p_office_gbnnm.value = "재직";
        else f.p_office_gbnnm.value = "퇴직";


        <% if(!v_usergubun.equals("FC")){ %>
        var v_jobgb = "";
        for(var i = 0; i < f.p_seljobgb.length;i++){
            if(f.p_seljobgb[i].checked == true) v_jobgb += "Y";
            else v_jobgb += "N";
        }   
        f.p_jobgb.value = v_jobgb;
        
        var v_localgb = "";
        for(var i = 0; i < f.p_sellocalgb.length;i++){
            if(f.p_sellocalgb[i].checked == true) v_localgb += "Y";
            else v_localgb += "N";
        }   
        f.p_localgb.value = v_localgb;

        var v_tradegb = "";
        for(var i = 0; i < f.p_seltradegb.length;i++){
            if(f.p_seltradegb[i].checked == true) v_tradegb += "Y";
            else v_tradegb += "N";
        }   
        f.p_tradegb.value = v_tradegb;
        <% }else{ %>
        var v_btype = "";
        for(var i = 0; i < f.p_seltype.length;i++){
            if(f.p_seltype[i].checked == true) v_btype += "Y";
            else v_btype += "N";
        }   
        f.p_btype.value = v_btype;        
        <% } %>
        f.action="/back/Member.do?cmd=btocMemberWrite";   
	    f.submit();
    }
	
	function memberList(){
	    var f = document.form1;
	    
	    f.method = "get";
	    f.encoding	= "application/x-www-form-urlencoded";
	    f.cmd.value="btocMemberPageList";   
	    f.submit();
	}
	
	function useridCheck(){
	    var f = document.form1;
	    
	    var userid = f.p_userid.value;
	     if(userid.length < 1){
	        alert("사용자ID를 입력해 주십시요");
	        return;
	     }
	     
	     var param = {p_userid:f.p_userid.value,p_comp:f.p_comp.value};
	     MemberWork.useridCheckCallBack(param, useridCheckCallBack);	 
	}
	
	function useridCheckCallBack(check){
	   var f = document.form1;
	   if(parseInt(check) < 1){
	       alert("사용가능한 사용자ID입니다.");
	       f.checkUserid.value = "Y";
	   }else{
	       alert("이미 사용중인 사용자ID입니다.");
	       f.checkUserid.value = "N";
	       f.p_userid.value = "";
	       f.p_userid.focus();
	   }
	}
	
	function memberDelete(){
   	    var f = document.form1;
	    
	    if(!confirm("현재 사용자를 삭제하시겠습니까?")) return;
	    
	    f.encoding	= "application/x-www-form-urlencoded";
	    f.cmd.value="btocMemberDelete";   
	    f.submit();
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

	function selectPostGb(){
		var f = document.form1;
		var postgb = f.p_postgb.value;
		var homeTr = null, compTr = null;
		 
	}

	function fileDownload(rfileName, sfileName, filePath) {
		  var loc = "/fileDownServlet?rFileName="+rfileName+"&sFileName="+sfileName+"&filePath="+filePath;
		  location.href = loc;
		  hiddenFrame.location.href = loc;
	}

    function oldFileDel(idx){
    	var f = document.form1;
    	var oldImg = document.getElementById("OldFile"+idx);
    	var oldFile = f["p_oldfile"+idx];
    	var oldRealFile = f["p_oldrealfile"+idx];

         oldImg.style.display = "none";
         oldFile.value = "";
         oldRealFile.value = "";      	
    }

    function chngUserGubun(){
    	var f = document.form1;
    
    	f.encoding	= "application/x-www-form-urlencoded";
   	    f.cmd.value="btocMemberWriteForm";
    	f.action = "/back/Member.do";
    	f.submit();
    }
</script>
</head>

<body>
<form name="form1" method="post" action="/back/Member.do"  onSubmit="return false;" enctype="multipart/form-data">
<input type="hidden" name="cmd" 			value="btocMemberWrite">
<input type="hidden" name="p_mode" 			value="<%=v_mode %>">
<input type="hidden" name="l_pageno" 	value="<%=box.getString("l_pageno") %>">
<input type="hidden" name="l_sortorder" 	value="<%=box.getString("l_sortorder") %>">
<input type="hidden" name="l_comp" 	value="<%=box.getString("l_comp") %>">
<input type="hidden" name="l_userid" 	value="<%=box.getString("l_userid") %>">
<input type="hidden" name="l_name" 	value="<%=box.getString("l_name") %>">
<input type="hidden" name="p_office_gbnnm" 	value="<%=member.getString("OFFICE_GBNNM") %>">
<input type="hidden" name="p_oldfile1" value="<%=member.getString("FILE1") %>">
<input type="hidden" name="p_oldrealfile1" value="<%=member.getString("REALFILE1") %>">
<input type="hidden" name="p_oldfile2" value="<%=member.getString("FILE2") %>">
<input type="hidden" name="p_oldrealfile2" value="<%=member.getString("REALFILE2") %>">
<input type="hidden" name="p_jobc_name" value="<%=member.getString("JOBC_NAME") %>">

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
			<th class="th_top_bd">회원구분</th>
			<td class="td_top_bd" colspan="3">
                <% if(v_mode.equals("W")){ %>
           		    <select name="p_usergubun" style="width:150px;" onChange = "chngUserGubun();">
						<option value="KC" <%=v_usergubun.equals("KC")||v_usergubun.equals("")?"selected":"" %> >일반회원</option>
						<option value="KF" <%=v_usergubun.equals("KF")?"selected":"" %> >국내거주외국인 </option>
						<option value="FK" <%=v_usergubun.equals("FK")?"selected":"" %> >해외거주교포 </option>
						<option value="FC" <%=v_usergubun.equals("FC")?"selected":"" %> >해외거주외국인 </option>
					</select>
                <%}else{%>
                  <%
                     if(member.getString("USERGUBUN").equals("KC")) out.print("일반회원");
                     else if(member.getString("USERGUBUN").equals("KF")) out.print("국내거주외국인");
                     else if(member.getString("USERGUBUN").equals("FK")) out.print("해외거주교포");
                     else if(member.getString("USERGUBUN").equals("FC")) out.print("해외거주외국인");
                  %>
			      <input type="hidden" name="p_usergubun" value="<%=member.getString("USERGUBUN") %>">
                <%}%>			
			</td>
        </tr>
        <% if(v_usergubun.equals("FC")){ %>  
    	<tr>
			<th>국가</th>
			<td colspan="3">
			<% String v_engcountry = member.getString("ENGCOUNTRY"); %>
			            <select name="p_engcountry"  style="width:200px;" >
                          <option value="US" <%=v_engcountry.equals("US")?"selected":""%>>U.S.A</option>
                          <option value="CN" <%=v_engcountry.equals("CN")?"selected":""%>>China</option>
                          <option value="IN" <%=v_engcountry.equals("IN")?"selected":""%>>India</option>
                          <option value="PK" <%=v_engcountry.equals("PK")?"selected":""%>>Pakistan</option>
                          <option value="SG" <%=v_engcountry.equals("SG")?"selected":""%>>Singapore</option>
                          <option value="HK" <%=v_engcountry.equals("HK")?"selected":""%>>HongKong</option>
                          <option value="TW" <%=v_engcountry.equals("TW")?"selected":""%>>Taiwan</option>
                          <option value="AS" <%=v_engcountry.equals("AS")?"selected":""%>>A.Samoa</option>
                          <option value="AF" <%=v_engcountry.equals("AF")?"selected":""%>>Afghanistan</option>
                          <option value="AL" <%=v_engcountry.equals("AL")?"selected":""%>>Albania</option>
                          <option value="DZ" <%=v_engcountry.equals("DZ")?"selected":""%>>Algeria</option>
                          <option value="AD" <%=v_engcountry.equals("AD")?"selected":""%>>Andorra</option>
                          <option value="AO" <%=v_engcountry.equals("AO")?"selected":""%>>Angola</option>
                          <option value="AI" <%=v_engcountry.equals("AI")?"selected":""%>>Anguilla</option>
                          <option value="AQ" <%=v_engcountry.equals("AQ")?"selected":""%>>Antarctica</option>
                          <option value="AG" <%=v_engcountry.equals("AG")?"selected":""%>>AntiguaBarbuda</option>
                          <option value="AR" <%=v_engcountry.equals("AR")?"selected":""%>>Argentina</option>
                          <option value="AM" <%=v_engcountry.equals("AM")?"selected":""%>>Armenia</option>
                          <option value="AW" <%=v_engcountry.equals("AW")?"selected":""%>>Aruba</option>
                          <option value="AU" <%=v_engcountry.equals("AU")?"selected":""%>>Australia</option>
                          <option value="AT" <%=v_engcountry.equals("AT")?"selected":""%>>Austria</option>
                          <option value="AZ" <%=v_engcountry.equals("AZ")?"selected":""%>>Azerbaijani</option>
                          <option value="IO" <%=v_engcountry.equals("IO")?"selected":""%>>B.I.O.T</option>
                          <option value="BS" <%=v_engcountry.equals("BS")?"selected":""%>>Bahamas</option>
                          <option value="BH" <%=v_engcountry.equals("BH")?"selected":""%>>Bahrain</option>
                          <option value="BD" <%=v_engcountry.equals("BD")?"selected":""%>>Bangladesh</option>
                          <option value="BB" <%=v_engcountry.equals("BB")?"selected":""%>>Barbados</option>
                          <option value="BY" <%=v_engcountry.equals("BY")?"selected":""%>>Belarus</option>
                          <option value="BE" <%=v_engcountry.equals("BE")?"selected":""%>>Belgium</option>
                          <option value="BZ" <%=v_engcountry.equals("BZ")?"selected":""%>>Belize</option>
                          <option value="BJ" <%=v_engcountry.equals("BJ")?"selected":""%>>Benin</option>
                          <option value="BM" <%=v_engcountry.equals("BM")?"selected":""%>>Bermuda</option>
                          <option value="BT" <%=v_engcountry.equals("BT")?"selected":""%>>Bhutan</option>
                          <option value="BO" <%=v_engcountry.equals("BO")?"selected":""%>>Bolivia</option>
                          <option value="BA" <%=v_engcountry.equals("BA")?"selected":""%>>Bosnia-Herzegov</option>
                          <option value="BW" <%=v_engcountry.equals("BW")?"selected":""%>>Botswana</option>
                          <option value="BV" <%=v_engcountry.equals("BV")?"selected":""%>>BouvetIsland</option>
                          <option value="BQ" <%=v_engcountry.equals("BQ")?"selected":""%>>Br.Antarc.T</option>
                          <option value="VG" <%=v_engcountry.equals("VG")?"selected":""%>>Br.VirginIs.</option>
                          <option value="BR" <%=v_engcountry.equals("BR")?"selected":""%>>Brazil</option>
                          <option value="BN" <%=v_engcountry.equals("BN")?"selected":""%>>Brunei</option>
                          <option value="BG" <%=v_engcountry.equals("BG")?"selected":""%>>Bulgaria</option>
                          <option value="BF" <%=v_engcountry.equals("BF")?"selected":""%>>BurkinaFaso</option>
                          <option value="BI" <%=v_engcountry.equals("BI")?"selected":""%>>Burundi</option>
                          <option value="DM" <%=v_engcountry.equals("DM")?"selected":""%>>C.Dominica</option>
                          <option value="KH" <%=v_engcountry.equals("KH")?"selected":""%>>Cambodia</option>
                          <option value="CM" <%=v_engcountry.equals("CM")?"selected":""%>>Cameroon</option>
                          <option value="CA" <%=v_engcountry.equals("CA")?"selected":""%>>Canada</option>
                          <option value="PZ" <%=v_engcountry.equals("PZ")?"selected":""%>>CanalZone</option>
                          <option value="CT" <%=v_engcountry.equals("CT")?"selected":""%>>CantonIs</option>
                          <option value="CV" <%=v_engcountry.equals("CV")?"selected":""%>>CapeVerde</option>
                          <option value="KY" <%=v_engcountry.equals("KY")?"selected":""%>>Cayman</option>
                          <option value="CF" <%=v_engcountry.equals("CF")?"selected":""%>>Cen.Afr.</option>
                          <option value="TD" <%=v_engcountry.equals("TD")?"selected":""%>>Chad</option>
                          <option value="CL" <%=v_engcountry.equals("CL")?"selected":""%>>Chile</option>
                          <option value="CN" <%=v_engcountry.equals("CN")?"selected":""%>>China</option>
                          <option value="CX" <%=v_engcountry.equals("CX")?"selected":""%>>ChristmasIs.</option>
                          <option value="CC" <%=v_engcountry.equals("CC")?"selected":""%>>CocosIslands</option>
                          <option value="CO" <%=v_engcountry.equals("CO")?"selected":""%>>Colombia</option>
                          <option value="KM" <%=v_engcountry.equals("KM")?"selected":""%>>Comoros</option>
                          <option value="CG" <%=v_engcountry.equals("CG")?"selected":""%>>Congo</option>
                          <option value="CK" <%=v_engcountry.equals("CK")?"selected":""%>>Cook(Br)</option>
                          <option value="CR" <%=v_engcountry.equals("CR")?"selected":""%>>CostaRica</option>
                          <option value="CI" <%=v_engcountry.equals("CI")?"selected":""%>>CoteDivoire</option>
                          <option value="HR" <%=v_engcountry.equals("HR")?"selected":""%>>Croatia</option>
                          <option value="CU" <%=v_engcountry.equals("CU")?"selected":""%>>Cuba</option>
                          <option value="CY" <%=v_engcountry.equals("CY")?"selected":""%>>Cyprus</option>
                          <option value="CZ" <%=v_engcountry.equals("CZ")?"selected":""%>>CzechoRepublic</option>
                          <option value="CS" <%=v_engcountry.equals("CS")?"selected":""%>>Czechoslovakia</option>
                          <option value="ZR" <%=v_engcountry.equals("ZR")?"selected":""%>>DemocratRepublicOfCongo(Zaire)</option>
                          <option value="CD" <%=v_engcountry.equals("CD")?"selected":""%>>DemocratRepublicOfCongo(Zaire)</option>
                          <option value="DK" <%=v_engcountry.equals("DK")?"selected":""%>>Denmark</option>
                          <option value="DJ" <%=v_engcountry.equals("DJ")?"selected":""%>>Djibouti</option>
                          <option value="DO" <%=v_engcountry.equals("DO")?"selected":""%>>DominicanRep.</option>
                          <option value="NQ" <%=v_engcountry.equals("NQ")?"selected":""%>>Dro.M.L</option>
                          <option value="GQ" <%=v_engcountry.equals("GQ")?"selected":""%>>E.Guinea</option>
                          <option value="TP" <%=v_engcountry.equals("TP")?"selected":""%>>EastTimor</option>
                          <option value="EC" <%=v_engcountry.equals("EC")?"selected":""%>>Ecuador</option>
                          <option value="EG" <%=v_engcountry.equals("EG")?"selected":""%>>Egypt</option>
                          <option value="SV" <%=v_engcountry.equals("SV")?"selected":""%>>ElSalvador</option>
                          <option value="ER" <%=v_engcountry.equals("ER")?"selected":""%>>Eritrea</option>
                          <option value="EE" <%=v_engcountry.equals("EE")?"selected":""%>>Estonia</option>
                          <option value="ET" <%=v_engcountry.equals("ET")?"selected":""%>>Ethiopia</option>
                          <option value="EU" <%=v_engcountry.equals("EU")?"selected":""%>>EuropeUnion</option>
                          <option value="GF" <%=v_engcountry.equals("GF")?"selected":""%>>F.Guiana</option>
                          <option value="PF" <%=v_engcountry.equals("PF")?"selected":""%>>F.Polynesia</option>
                          <option value="TF" <%=v_engcountry.equals("TF")?"selected":""%>>F.S.A.T</option>
                          <option value="FK" <%=v_engcountry.equals("FK")?"selected":""%>>Falkland</option>
                          <option value="FO" <%=v_engcountry.equals("FO")?"selected":""%>>FaroeIs.</option>
                          <option value="FJ" <%=v_engcountry.equals("FJ")?"selected":""%>>Fiji</option>
                          <option value="FI" <%=v_engcountry.equals("FI")?"selected":""%>>Finland</option>
                          <option value="FR" <%=v_engcountry.equals("FR")?"selected":""%>>France</option>
                          <option value="FX" <%=v_engcountry.equals("FX")?"selected":""%>>France,Metropolitan</option>
                          <option value="GW" <%=v_engcountry.equals("GW")?"selected":""%>>G.Bissau</option>
                          <option value="GA" <%=v_engcountry.equals("GA")?"selected":""%>>Gabon</option>
                          <option value="GM" <%=v_engcountry.equals("GM")?"selected":""%>>Gambia</option>
                          <option value="GE" <%=v_engcountry.equals("GE")?"selected":""%>>Georgia</option>
                          <option value="DE" <%=v_engcountry.equals("DE")?"selected":""%>>Germany</option>
                          <option value="GH" <%=v_engcountry.equals("GH")?"selected":""%>>Ghana</option>
                          <option value="GI" <%=v_engcountry.equals("GI")?"selected":""%>>Gibraltar</option>
                          <option value="GR" <%=v_engcountry.equals("GR")?"selected":""%>>Greece</option>
                          <option value="GL" <%=v_engcountry.equals("GL")?"selected":""%>>Greenland</option>
                          <option value="GD" <%=v_engcountry.equals("GD")?"selected":""%>>Grenada</option>
                          <option value="GP" <%=v_engcountry.equals("GP")?"selected":""%>>Guadeloupe</option>
                          <option value="GU" <%=v_engcountry.equals("GU")?"selected":""%>>Guam(Usa)</option>
                          <option value="GT" <%=v_engcountry.equals("GT")?"selected":""%>>Guatemala</option>
                          <option value="GN" <%=v_engcountry.equals("GN")?"selected":""%>>Guinea</option>
                          <option value="GY" <%=v_engcountry.equals("GY")?"selected":""%>>Guyana</option>
                          <option value="HM" <%=v_engcountry.equals("HM")?"selected":""%>>H.M.Isl</option>
                          <option value="HT" <%=v_engcountry.equals("HT")?"selected":""%>>Haiti</option>
                          <option value="HN" <%=v_engcountry.equals("HN")?"selected":""%>>Honduras</option>
                          <option value="HK" <%=v_engcountry.equals("HK")?"selected":""%>>HongKong</option>
                          <option value="HU" <%=v_engcountry.equals("HU")?"selected":""%>>Hungary</option>
                          <option value="IS" <%=v_engcountry.equals("IS")?"selected":""%>>Iceland</option>
                          <option value="IN" <%=v_engcountry.equals("IN")?"selected":""%>>India</option>
                          <option value="ID" <%=v_engcountry.equals("ID")?"selected":""%>>Indonesia</option>
                          <option value="IR" <%=v_engcountry.equals("IR")?"selected":""%>>Iran</option>
                          <option value="IQ" <%=v_engcountry.equals("IQ")?"selected":""%>>Iraq</option>
                          <option value="IE" <%=v_engcountry.equals("IE")?"selected":""%>>Ireland</option>
                          <option value="IL" <%=v_engcountry.equals("IL")?"selected":""%>>Israel</option>
                          <option value="IT" <%=v_engcountry.equals("IT")?"selected":""%>>Italy</option>
                          <option value="JM" <%=v_engcountry.equals("JM")?"selected":""%>>Jamaica</option>
                          <option value="JP" <%=v_engcountry.equals("JP")?"selected":""%>>Japan</option>
                          <option value="JT" <%=v_engcountry.equals("JT")?"selected":""%>>JohnstonIs</option>
                          <option value="JO" <%=v_engcountry.equals("JO")?"selected":""%>>Jordan</option>
                          <option value="KZ" <%=v_engcountry.equals("KZ")?"selected":""%>>Kazakhstan</option>
                          <option value="KE" <%=v_engcountry.equals("KE")?"selected":""%>>Kenya</option>
                          <option value="KI" <%=v_engcountry.equals("KI")?"selected":""%>>Kiribati</option>
                          <option value="KR" <%=v_engcountry.equals("KR")?"selected":""%>>Korea</option>
                          <option value="KP" <%=v_engcountry.equals("KP")?"selected":""%>>Korea,D.P.R</option>
                          <option value="KW" <%=v_engcountry.equals("KW")?"selected":""%>>Kuwait</option>
                          <option value="KG" <%=v_engcountry.equals("KG")?"selected":""%>>Kyrgyzstan</option>
                          <option value="LA" <%=v_engcountry.equals("LA")?"selected":""%>>Laos</option>
                          <option value="LV" <%=v_engcountry.equals("LV")?"selected":""%>>Latvia</option>
                          <option value="LB" <%=v_engcountry.equals("LB")?"selected":""%>>Lebanon</option>
                          <option value="LS" <%=v_engcountry.equals("LS")?"selected":""%>>Lesotho</option>
                          <option value="LR" <%=v_engcountry.equals("LR")?"selected":""%>>Liberia</option>
                          <option value="LY" <%=v_engcountry.equals("LY")?"selected":""%>>Libya</option>
                          <option value="LI" <%=v_engcountry.equals("LI")?"selected":""%>>Liechtenstein</option>
                          <option value="LT" <%=v_engcountry.equals("LT")?"selected":""%>>Lithuania</option>
                          <option value="LU" <%=v_engcountry.equals("LU")?"selected":""%>>Luxembourg</option>
                          <option value="MO" <%=v_engcountry.equals("MO")?"selected":""%>>Macao</option>
                          <option value="YM" <%=v_engcountry.equals("YM")?"selected":""%>>Macedonia</option>
                          <option value="MK" <%=v_engcountry.equals("MK")?"selected":""%>>Macedonia</option>
                          <option value="MG" <%=v_engcountry.equals("MG")?"selected":""%>>Madagascar</option>
                          <option value="MW" <%=v_engcountry.equals("MW")?"selected":""%>>Malawi</option>
                          <option value="MY" <%=v_engcountry.equals("MY")?"selected":""%>>Malaysia</option>
                          <option value="MV" <%=v_engcountry.equals("MV")?"selected":""%>>Maldives</option>
                          <option value="ML" <%=v_engcountry.equals("ML")?"selected":""%>>Mali</option>
                          <option value="MT" <%=v_engcountry.equals("MT")?"selected":""%>>Malta</option>
                          <option value="MH" <%=v_engcountry.equals("MH")?"selected":""%>>Marshalls</option>
                          <option value="MQ" <%=v_engcountry.equals("MQ")?"selected":""%>>Martinique</option>
                          <option value="MR" <%=v_engcountry.equals("MR")?"selected":""%>>Mauritania</option>
                          <option value="MU" <%=v_engcountry.equals("MU")?"selected":""%>>Mauritius</option>
                          <option value="YT" <%=v_engcountry.equals("YT")?"selected":""%>>Mayotte</option>
                          <option value="MX" <%=v_engcountry.equals("MX")?"selected":""%>>Mexico</option>
                          <option value="FM" <%=v_engcountry.equals("FM")?"selected":""%>>Micronesia</option>
                          <option value="MI" <%=v_engcountry.equals("MI")?"selected":""%>>MidwayIs(Us)</option>
                          <option value="PU" <%=v_engcountry.equals("PU")?"selected":""%>>Misc,PacificIsland.(Us)</option>
                          <option value="MD" <%=v_engcountry.equals("MD")?"selected":""%>>Moldova</option>
                          <option value="MC" <%=v_engcountry.equals("MC")?"selected":""%>>Monaco</option>
                          <option value="MN" <%=v_engcountry.equals("MN")?"selected":""%>>Mongolia</option>
                          <option value="MS" <%=v_engcountry.equals("MS")?"selected":""%>>Montserrat</option>
                          <option value="MA" <%=v_engcountry.equals("MA")?"selected":""%>>Morocco</option>
                          <option value="MZ" <%=v_engcountry.equals("MZ")?"selected":""%>>Mozambique</option>
                          <option value="MM" <%=v_engcountry.equals("MM")?"selected":""%>>Myanmar</option>
                          <option value="NC" <%=v_engcountry.equals("NC")?"selected":""%>>N.Caledonia</option>
                          <option value="MP" <%=v_engcountry.equals("MP")?"selected":""%>>N.Marianas</option>
                          <option value="NZ" <%=v_engcountry.equals("NZ")?"selected":""%>>N.Zealand</option>
                          <option value="NA" <%=v_engcountry.equals("NA")?"selected":""%>>Namibia</option>
                          <option value="NR" <%=v_engcountry.equals("NR")?"selected":""%>>Nauru</option>
                          <option value="NP" <%=v_engcountry.equals("NP")?"selected":""%>>Nepal</option>
                          <option value="AN" <%=v_engcountry.equals("AN")?"selected":""%>>Neth.Antilles</option>
                          <option value="NL" <%=v_engcountry.equals("NL")?"selected":""%>>Netherland</option>
                          <option value="NT" <%=v_engcountry.equals("NT")?"selected":""%>>NeutralZone</option>
                          <option value="NH" <%=v_engcountry.equals("NH")?"selected":""%>>NewHebrides</option>
                          <option value="NI" <%=v_engcountry.equals("NI")?"selected":""%>>Nicaragua</option>
                          <option value="NE" <%=v_engcountry.equals("NE")?"selected":""%>>Niger</option>
                          <option value="NG" <%=v_engcountry.equals("NG")?"selected":""%>>Nigeria</option>
                          <option value="NU" <%=v_engcountry.equals("NU")?"selected":""%>>Niue</option>
                          <option value="NF" <%=v_engcountry.equals("NF")?"selected":""%>>NorfolkIs</option>
                          <option value="NO" <%=v_engcountry.equals("NO")?"selected":""%>>Norway</option>
                          <option value="OM" <%=v_engcountry.equals("OM")?"selected":""%>>Oman</option>
                          <option value="ZY" <%=v_engcountry.equals("ZY")?"selected":""%>>Others</option>
                          <option value="PC" <%=v_engcountry.equals("PC")?"selected":""%>>P.I.T.T</option>
                          <option value="PK" <%=v_engcountry.equals("PK")?"selected":""%>>Pakistan</option>
                          <option value="PW" <%=v_engcountry.equals("PW")?"selected":""%>>Palau</option>
                          <option value="PS" <%=v_engcountry.equals("PS")?"selected":""%>>Palestine(Polisario)</option>
                          <option value="PA" <%=v_engcountry.equals("PA")?"selected":""%>>Panama</option>
                          <option value="PG" <%=v_engcountry.equals("PG")?"selected":""%>>PapuaN.Gunea</option>
                          <option value="PY" <%=v_engcountry.equals("PY")?"selected":""%>>Paraguay</option>
                          <option value="PE" <%=v_engcountry.equals("PE")?"selected":""%>>Peru</option>
                          <option value="PH" <%=v_engcountry.equals("PH")?"selected":""%>>Philippines</option>
                          <option value="PN" <%=v_engcountry.equals("PN")?"selected":""%>>PitcairnIs</option>
                          <option value="PO" <%=v_engcountry.equals("PO")?"selected":""%>>Plo</option>
                          <option value="PL" <%=v_engcountry.equals("PL")?"selected":""%>>Poland</option>
                          <option value="PT" <%=v_engcountry.equals("PT")?"selected":""%>>Portugal</option>
                          <option value="PR" <%=v_engcountry.equals("PR")?"selected":""%>>PuertoRico</option>
                          <option value="QA" <%=v_engcountry.equals("QA")?"selected":""%>>Qatar</option>
                          <option value="RE" <%=v_engcountry.equals("RE")?"selected":""%>>ReunionIs</option>
                          <option value="RO" <%=v_engcountry.equals("RO")?"selected":""%>>Romania</option>
                          <option value="RU" <%=v_engcountry.equals("RU")?"selected":""%>>Russia</option>
                          <option value="RW" <%=v_engcountry.equals("RW")?"selected":""%>>Rwanda</option>
                          <option value="SJ" <%=v_engcountry.equals("SJ")?"selected":""%>>S.J.M.I</option>
                          <option value="ST" <%=v_engcountry.equals("ST")?"selected":""%>>S.TIs</option>
                          <option value="YD" <%=v_engcountry.equals("YD")?"selected":""%>>S.Yemen</option>
                          <option value="WS" <%=v_engcountry.equals("WS")?"selected":""%>>Samoa</option>
                          <option value="SM" <%=v_engcountry.equals("SM")?"selected":""%>>SanMarino</option>
                          <option value="SA" <%=v_engcountry.equals("SA")?"selected":""%>>SaudiArabia</option>
                          <option value="SN" <%=v_engcountry.equals("SN")?"selected":""%>>Senegal</option>
                          <option value="SC" <%=v_engcountry.equals("SC")?"selected":""%>>Seychelles</option>
                          <option value="SL" <%=v_engcountry.equals("SL")?"selected":""%>>SierraLeone</option>
                          <option value="SG" <%=v_engcountry.equals("SG")?"selected":""%>>Singapore</option>
                          <option value="SK" <%=v_engcountry.equals("SK")?"selected":""%>>Slovak</option>
                          <option value="SI" <%=v_engcountry.equals("SI")?"selected":""%>>Slovenia</option>
                          <option value="SB" <%=v_engcountry.equals("SB")?"selected":""%>>Solomon</option>
                          <option value="SO" <%=v_engcountry.equals("SO")?"selected":""%>>Somalia</option>
                          <option value="ZA" <%=v_engcountry.equals("ZA")?"selected":""%>>SouthAfrica</option>
                          <option value="GS" <%=v_engcountry.equals("GS")?"selected":""%>>SouthGeorgia</option>
                          <option value="ES" <%=v_engcountry.equals("ES")?"selected":""%>>Spain</option>
                          <option value="LK" <%=v_engcountry.equals("LK")?"selected":""%>>SriLanka</option>
                          <option value="SH" <%=v_engcountry.equals("SH")?"selected":""%>>St.Helena</option>
                          <option value="KN" <%=v_engcountry.equals("KN")?"selected":""%>>St.Kitts-Nevis</option>
                          <option value="LC" <%=v_engcountry.equals("LC")?"selected":""%>>St.Lucia</option>
                          <option value="PM" <%=v_engcountry.equals("PM")?"selected":""%>>St.P</option>
                          <option value="VC" <%=v_engcountry.equals("VC")?"selected":""%>>St.Vincent</option>
                          <option value="SD" <%=v_engcountry.equals("SD")?"selected":""%>>Sudan</option>
                          <option value="SR" <%=v_engcountry.equals("SR")?"selected":""%>>Suriname</option>
                          <option value="SZ" <%=v_engcountry.equals("SZ")?"selected":""%>>Swaziland</option>
                          <option value="SE" <%=v_engcountry.equals("SE")?"selected":""%>>Sweden</option>
                          <option value="CH" <%=v_engcountry.equals("CH")?"selected":""%>>Switzerland</option>
                          <option value="SY" <%=v_engcountry.equals("SY")?"selected":""%>>Syria</option>
                          <option value="TT" <%=v_engcountry.equals("TT")?"selected":""%>>T.Tobago</option>
                          <option value="TJ" <%=v_engcountry.equals("TJ")?"selected":""%>>Tadjikstan</option>
                          <option value="TW" <%=v_engcountry.equals("TW")?"selected":""%>>Taiwan</option>
                          <option value="TZ" <%=v_engcountry.equals("TZ")?"selected":""%>>Tanzania</option>
                          <option value="TH" <%=v_engcountry.equals("TH")?"selected":""%>>Thailand</option>
                          <option value="TL" <%=v_engcountry.equals("TL")?"selected":""%>>Timor</option>
                          <option value="TG" <%=v_engcountry.equals("TG")?"selected":""%>>Togo</option>
                          <option value="TK" <%=v_engcountry.equals("TK")?"selected":""%>>Tokelau</option>
                          <option value="TO" <%=v_engcountry.equals("TO")?"selected":""%>>Tonga</option>
                          <option value="TN" <%=v_engcountry.equals("TN")?"selected":""%>>Tunisia</option>
                          <option value="TR" <%=v_engcountry.equals("TR")?"selected":""%>>Turkey</option>
                          <option value="TM" <%=v_engcountry.equals("TM")?"selected":""%>>Turkmenistan</option>
                          <option value="TC" <%=v_engcountry.equals("TC")?"selected":""%>>Turks</option>
                          <option value="TV" <%=v_engcountry.equals("TV")?"selected":""%>>Tuvalu</option>
                          <option value="AE" <%=v_engcountry.equals("AE")?"selected":""%>>U.A.E.</option>
                          <option value="GB" <%=v_engcountry.equals("GB")?"selected":""%>>U.Kingdom</option>
                          <option value="US" <%=v_engcountry.equals("US")?"selected":""%>>U.S.A</option>
                          <option value="UM" <%=v_engcountry.equals("UM")?"selected":""%>>U.S.M.I</option>
                          <option value="UG" <%=v_engcountry.equals("UG")?"selected":""%>>Uganda</option>
                          <option value="UA" <%=v_engcountry.equals("UA")?"selected":""%>>Ukraine</option>
                          <option value="ZZ" <%=v_engcountry.equals("ZZ")?"selected":""%>>Unknown</option>
                          <option value="UY" <%=v_engcountry.equals("UY")?"selected":""%>>Uruguay</option>
                          <option value="SU" <%=v_engcountry.equals("SU")?"selected":""%>>Ussr</option>
                          <option value="UZ" <%=v_engcountry.equals("UZ")?"selected":""%>>Uzbekistan</option>
                          <option value="VU" <%=v_engcountry.equals("VU")?"selected":""%>>Vanuatu</option>
                          <option value="VA" <%=v_engcountry.equals("VA")?"selected":""%>>VaticanCity</option>
                          <option value="VE" <%=v_engcountry.equals("VE")?"selected":""%>>Venezuela</option>
                          <option value="VN" <%=v_engcountry.equals("VN")?"selected":""%>>VietNam</option>
                          <option value="VI" <%=v_engcountry.equals("VI")?"selected":""%>>VirginIs.(Us)</option>
                          <option value="WF" <%=v_engcountry.equals("WF")?"selected":""%>>W.A.F.I</option>
                          <option value="WK" <%=v_engcountry.equals("WK")?"selected":""%>>WakeIsland</option>
                          <option value="EH" <%=v_engcountry.equals("EH")?"selected":""%>>WesternSahara</option>
                          <option value="YE" <%=v_engcountry.equals("YE")?"selected":""%>>Yemen</option>
                          <option value="YU" <%=v_engcountry.equals("YU")?"selected":""%>>Yugoslavia</option>
                          <option value="ZM" <%=v_engcountry.equals("ZM")?"selected":""%>>Zambia</option>
                          <option value="ZW" <%=v_engcountry.equals("ZW")?"selected":""%>>Zimbabwe</option>
						  </select>			
			</td>
        </tr>    
        <% }else{ %>
            <input type="hidden" name="p_engcountry" value="">
        <%} %>  
		<tr>
			<th>*사용자ID</th>
			<td colspan="3">
			    <input type="hidden" name="p_comp" value="10000">
                <% if(v_mode.equals("W")){ %>
                <input type="text" name="p_userid" dispName="사용자ID" isNull="N" maxlength = "10" lenCheck="10" value="<%=member.getString("USERID") %>"><%=member.getString("USERID") %>
                <input type="hidden" name="checkUserid" value="N">
                <fmtag:button type="2" value="중복확인" func="useridCheck()" />
                <%}else{%>
                  <%=member.getString("USERID") %>
                  <input type="hidden" name="p_userid" 	value="<%=member.getString("USERID") %>">
                  <input type="hidden" name="checkUserid" value="Y">
                <%}%>			
			</td>
        </tr>  
		<tr>
			<th>*비밀번호</th>
			<td>
			 <input type="password" name="p_pwd1" dispName="비밀번호" isNull="Y" lenCheck="20" value="">  
			</td>
			<th>*비밀번호확인</th>
			<td>
                <input type="password" name="p_pwdconfirm" dispName="비밀번호확인" isNull="Y" lenCheck="20" value="">
                <input type="hidden" name="p_pwd" value="" >   			
			</td>
        </tr>          		
		<tr>
			<th>*성명</th>
			<td colspan="3">
			 <input type="text" name="p_name" dispName="성명" isNull="N" lenCheck="30" value="<%=member.getString("NAME") %>">  
			</td>
        </tr>
        <tr>
			<th>성별</th>
			<td colspan="3">
				<% if(v_mode.equals("W")){ %>
				<select name="p_sex">
					<option value="M" checked>남</option>
					<option value="F">여</option>
				</select>
                <%}else{%>
                <% if ("M".equals(member.getString("SEX"))) { %>남자
                <% } else if ("F".equals(member.getString("SEX"))) { %>여자
                <% } else { %>없음
                <% } %>
                <%}%>				
			  
			</td>
        </tr>
        <% if(v_usergubun.equals("KC") || v_usergubun.equals("KF")){ %>
		<tr>
			<th><% if(v_usergubun.equals("KC")){%>*주민등록번호<% }else if(v_usergubun.equals("KF")){ %>*외국인등록번호<%} %></th>
			<td>
                <%
                   String v_resno = member.getString("RESNO");
                   String v_resno1 ="", v_resno2 ="";
                   if(!v_resno.equals("")){
                       v_resno1 = v_resno.substring(0,6); 
                       v_resno2 = v_resno.substring(6,13);
                   }
                   if(v_mode.equals("W")){
                 %> 
                <input type="text" name="p_resno01" dispName="<% if(v_usergubun.equals("KC")){%>주민등록번호<% }else if(v_usergubun.equals("KF")){ %>외국인등록번호<%} %>" isNull="N" maxLength="6" dataType="number" value="<%=v_resno1 %>" style="width:80"> -
                <input type="text" name="p_resno02" dispName="<% if(v_usergubun.equals("KC")){%>주민등록번호<% }else if(v_usergubun.equals("KF")){ %>외국인등록번호<%} %>" isNull="N" maxLength="7" dataType="number" value="<%=v_resno2 %>" style="width:80">
                
                <font color="red">ex) 801212 - 1000000</font>
                <% }else { %>
                <%=v_resno1 %> - <%=v_resno2 %>
                <% } %>
                <input type="hidden" name="p_resno" value="<%=v_resno %>" > 
			</td>
			<th>우편물접수처</th>
			<td>
				<%=CommonUtil.getCodeListBox("select","0092","p_postgb","","selectPostGb()","")%>		
			</td>			
        </tr>   
               

		
<%        	
        }else{
        	 if (v_usergubun.equals("FK")) {
%>
		<tr>
			<th>*생일</th>
			<td colspan = "3">
                <%
                   String v_resno = member.getString("RESNO");
                   String v_resno1 ="", v_resno2 ="";
                   if(!v_resno.equals("")){
                       v_resno1 = v_resno.substring(0,6); 
                       v_resno2 = v_resno.substring(6,13);
                   }
                   if(v_mode.equals("W")){
                 %> 
	                <input type="text" name="p_resno01" dispName="생일" isNull="N" maxLength="6" dataType="number" value="" style="width:80">
	                <input type="hidden" name="p_resno02" value = "">
                <% }else { %>
                <%=v_resno1 %>
                <% } %>
                <input type="hidden" name="p_resno" value="<%=v_resno %>" > 
			</td>
					
        </tr> 
 
<%
								
        		 
        	 }else {
%>
                <input type="hidden" name="p_resno01" value="111111">-
                <input type="hidden" name="p_resno02" value="1111111" >
                <input type="hidden" name="p_resno" value="1111111111111" >
              
                 
<%
        	 }
%>        	 
        	  <input type="hidden" name="p_postgb" value="">
<%        	  
  		} 
%>
        <tr style="display:<%=v_usergubun.equals("KC")||v_usergubun.equals("KF")?"":"none" %>">
			<th>직업</th>
			<td colspan="3">
                <%=CommonUtil.getCodeListBox("select","0093","p_jobc_csenr",member.getString("JOBC_CSENR"),"","- 선택 -")%>
     		</td>
        </tr>
        <% if(v_usergubun.equals("KC") || v_usergubun.equals("KF")){ %>
        <tr>
			<th>직장/학교</th>
			<td colspan="3">
              <input name="p_corpnm" type="text" isNull="Y" dispName="직장/학교" lenCheck="50" value="<%=member.getString("COMPNM") %>"/>
     		</td>
        </tr>
        <% } %>
        <tr style="display:<%=v_usergubun.equals("KC")||v_usergubun.equals("KF")?"":"none" %>">
			<th>전화번호</th>
			<td colspan="3">
               <%
                   String v_hometel = member.getString("HOMETEL");
                   String[] v_hometelInfo = new String[]{"","",""};
	               	if(  !StringUtil.isNull(v_hometel) && !"--".equals(v_hometel)) {
	               		v_hometelInfo = v_hometel.split("-");
	            	   
	            	}
	               	v_hometelInfo = StringUtil.telConvert(v_hometelInfo);
                 
                 %> 
                <input type="hidden" name="p_hometel" value="<%=v_hometel %>">
                <input type="text" name="p_hometel1" dispName="전화번호" isNull="Y" dataType="number" value="<%=v_hometelInfo[0] %>" maxlength="4" style="width:60"> -
                <input type="text" name="p_hometel2" dispName="전화번호" isNull="Y" dataType="number" value="<%=v_hometelInfo[1] %>" maxlength="4" style="width:60"> -
                <input type="text" name="p_hometel3" dispName="전화번호" isNull="Y" dataType="number" value="<%=v_hometelInfo[2] %>" maxlength="4" style="width:60">
     		</td>
        </tr>         
        <tr style="display:<%=v_usergubun.equals("KC")||v_usergubun.equals("KF")?"":"none" %>">
			<th>핸드폰번호</th>
			<td colspan="3">
                <%
                   String v_handphone = member.getString("HANDPHONE");
                   String[] v_handphoneInfo = new String[]{"","",""};
                  
	               	if(  !StringUtil.isNull(v_handphone) && !"--".equals(v_handphone)) {
	               		v_handphoneInfo = v_handphone.split("-");
	            	   
	            	}   
	               	v_handphoneInfo = StringUtil.telConvert(v_handphoneInfo);
                 %> 
                <input type="hidden" name="p_handphone" value="<%=v_handphone %>">
                <input type="text" name="p_handphone1" dispName="핸드폰번호" isNull="Y"  dataType="number" value="<%=v_handphoneInfo[0] %>" maxlength="4" style="width:60">&nbsp;-
                <input type="text" name="p_handphone2" dispName="핸드폰번호" isNull="Y"  dataType="number" value="<%=v_handphoneInfo[1] %>" maxlength="4" style="width:60">&nbsp;-
                <input type="text" name="p_handphone3" dispName="핸드폰번호" isNull="Y"  dataType="number" value="<%=v_handphoneInfo[2] %>" maxlength="4" style="width:60">
     		</td>
        </tr>
         <% if(v_usergubun.equals("KC") || v_usergubun.equals("KF")){ %>
        <tr>
			<th>팩스번호</th>
			<td colspan="3">
                <%
	            	String[] v_homefax_temp = member.getString("HOMEFAX").split("-");
	            	String[] v_homefax = {"","",""};
	            	v_homefax =StringUtil.telConvert(v_homefax_temp);
	            	
                %> 
				<input type="hidden" name="p_homefax" value="<%=member.getString("HOMEFAX") %>">
				<input name="p_homefax1" type="text" size="3" isNull="Y" dispName="팩스번호" dataType="number" value="<%=v_homefax[0] %>" maxLength="3" style="width:60"/> - 
				<input name="p_homefax2" type="text" size="4" isNull="Y" dispName="팩스번호" dataType="number" value="<%=v_homefax[1]%>" maxLength="4" style="width:60"/> - 
				<input name="p_homefax3" type="text" size="4" isNull="Y" dispName="팩스번호" dataType="number" value="<%=v_homefax[2]%>" maxLength="4" style="width:60"/>
     		</td>
       </tr>  
       <%}else if(v_usergubun.equals("FC")){ %>
        <tr>
			<th>FAX</th>
			<td colspan="3">
				<input type="text" name="p_homefax" value="<%=member.getString("HOMEFAX") %>" isNull="Y" dispName="FAX" dataType="string" style="width:200px;">
     		</td>
       </tr>  
       <% } %>
       <tr>
			<th>*이메일</th>
			<td colspan="3">
               <input type="text" name="p_email" dispName="이메일" isNull="N" lenCheck="50" style="width:503" value="<%=member.getString("EMAIL") %>">
     		</td>
        </tr>           
        <tr style="display:<%=v_usergubun.equals("KC")||v_usergubun.equals("KF")?"":"none" %>">
			<th>우편번호</th>
			<td colspan="3">	
			<% if( member.getString("POST2") == null || member.getString("POST2").equals("") ){ %>
				<input type="text" name="p_post1" dispName="우편번호" isNull="Y" maxLength="5" dataType="number" value="<%=member.getString("POST1") %>" style="width:40" readonly="readonly">
				<input type="hidden" name="p_post2" dispName="우편번호" value="<%=member.getString("POST2") %>">
			<% } else { %>
			 	<input type="text" name="p_post1" dispName="우편번호" isNull="Y" dataType="number" value="<%=member.getString("POST1") %>" style="width:40" readonly="readonly">&nbsp;-
                <input type="text" name="p_post2" dispName="우편번호" dataType="number" value="<%=member.getString("POST2") %>" style="width:40" readonly="readonly">
			<% } %>
                &nbsp;<a href="#none" onclick="searchZipCode('user')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a>
     		</td>
        </tr>  
        <tr style="display:<%=v_usergubun.equals("KC")||v_usergubun.equals("KF")?"":"none" %>">
			<th>주소</th>
			<td>
               <input type="text" name="p_addr" dispName="주소" isNull="Y" lenCheck="1000" style="width:400" value="<%=member.getString("ADDR") %>">
     		</td>
     		<td colspan="2">
               <input type="text" name="p_addr2" dispName="상세주소" isNull="Y" lenCheck="1000" style="width:400" value="<%=member.getString("ADDR2") %>">
     		</td>
        </tr>                                    		
	<tr style="display:<%=!v_usergubun.equals("FC")?"":"none" %>">
		<th>첨부파일1</th>
		<td colspan="3">
		<%
			if (!member.getString("FILE1").equals("")) {
		%><span id="OldFile1">
		<a href="javascript:fileDownload('<%=member.getString("REALFILE1")%>', '<%=member.getString("FILE1")%>', '/member');"><%=member.getString("FILE1")%></a>&nbsp;
		<img src="/images/back/icon/ico_del.gif" onClick="oldFileDel(1)" align="absmiddle">
		</span><br>
		<%
			}
		%> <input name="p_file1" type="file" size="50"></td>
		</td>
	</tr>
	<tr style="display:<%=!v_usergubun.equals("FC")?"":"none" %>">
		<th>첨부파일2</th>
		<td colspan="3">
		<%
			if (!member.getString("FILE2").equals("")) {
		%><span id="OldFile2">
		<a href="javascript:fileDownload('<%=member.getString("REALFILE2")%>', '<%=member.getString("FILE2")%>', '/member');"><%=member.getString("FILE2")%></a>&nbsp;
		<img src="/images/back/icon/ico_del.gif" onClick="oldFileDel(2)" align="absmiddle">
		</span><br>
		<%
			}
		%> <input name="p_file2" type="file" size="50"></td>
		</td>
	   </tr> 
       <tr style="display:<%=v_usergubun.equals("KC")||v_usergubun.equals("KF")?"":"none" %>">
			<th>채용공고등록신청</th>
			<td colspan="3">
			신청여부
            <select name="p_jobapply" style="width:150px;">
				<option value="N" <% if(member.getString("JOBAPPLY").equals("N") || member.getString("JOBAPPLY").equals("") ) out.println("selected");  %> >신청안함</option>
				<option value="Y" <% if(member.getString("JOBAPPLY").equals("Y") ) out.println("selected");  %> >신청</option>
			</select>
			<%
	            	String[] v_saupjano_temp = member.getString("SAUPJANO").split("-");
	            	String[] v_saupjano = {"","",""};
	            	if(v_saupjano_temp.length==3) v_saupjano = v_saupjano_temp;
            %>
                               사업자등록번호 
			<input type="hidden" name="p_saupjano" value="<%=member.getString("SAUPJANO") %>">
			<input type="text" name="p_saupjano1" value="<%=v_saupjano[0]%>" dispName="사업자등록번호" isNull="Y" maxLength="3" dataType="number" style="width:60px;"/> -
			<input type="text" name="p_saupjano2" value="<%=v_saupjano[1]%>"  dispName="사업자등록번호" isNull="Y" maxLength="2" dataType="number" style="width:100px;"/> -
			<input type="text" name="p_saupjano3" value="<%=v_saupjano[2]%>"  dispName="사업자등록번호" isNull="Y" maxLength="5" dataType="number" style="width:60px;"/>
     		</td>
        </tr>	                 
       <tr>
			<th>재직여부</th>
			<td colspan="3">
               <input type="radio" name="p_office_gbn" value="Y" <%=member.getString("OFFICE_GBN").equals("Y")||member.getString("OFFICE_GBN").equals("")?"checked":"" %>>재직&nbsp;
              <input type="radio" name="p_office_gbn" value="N" <%=member.getString("OFFICE_GBN").equals("N")?"checked":"" %>>퇴직&nbsp; 
     		</td>
        </tr>         
		</table>
	</div>
	<!-- // -->
	<table width="985" cellpadding="0" cellspacing="0" class="mar_top_15">
		<tr>
			<td width="15"><img src="/images/back/common/bullet_label.gif"></td>
			<td class="txt_black_b">선택정보</td>
		</tr>
	</table>
	
	
	<div class="board-view">
	   <table width="985" cellpadding="0" cellspacing="0" class="mar_top_5">
		<colgroup>
			<col width="200" />
			<col width="" />
		</colgroup>
        <% if(!v_usergubun.equals("FC")){ %>
		<tr>
			<th class="th_top_bd">관심업종</th>
			<td class="td_top_bd">
			<% String v_jobgb = interest.getString("JOBGB"); 
			   if(v_jobgb.equals("")) v_jobgb = "NNNNNNNNNNNN";
			%>
			    <input type="hidden" name="p_jobgb" value="<%=v_jobgb %>">
				<input type="checkbox" name="p_seljobgb" value="Y"  <% if("Y".equals( v_jobgb.substring(0,1)) )out.println(" checked ");%> style="border:none;" /> 농수산물
				<input type="checkbox" name="p_seljobgb" value="Y" <% if("Y".equals( v_jobgb.substring(1,2)) )out.println(" checked ");%> style="border:none;" /> 화학제품
				<input type="checkbox" name="p_seljobgb" value="Y" <% if("Y".equals( v_jobgb.substring(2,3)) )out.println(" checked ");%> style="border:none;" /> 철강금속
				<input type="checkbox" name="p_seljobgb" value="Y" <% if("Y".equals( v_jobgb.substring(3,4)) )out.println(" checked ");%> style="border:none;" /> 기계류
				<input type="checkbox" name="p_seljobgb" value="Y" <% if("Y".equals( v_jobgb.substring(4,5)) )out.println(" checked ");%> style="border:none;" /> 섬유류
				<input type="checkbox" name="p_seljobgb" value="Y" <% if("Y".equals( v_jobgb.substring(5,6)) )out.println(" checked ");%> style="border:none;" /> 전자전기
				<input type="checkbox" name="p_seljobgb" value="Y" <% if("Y".equals( v_jobgb.substring(6,7)) )out.println(" checked ");%> style="border:none;" /> 생활용품<br>
				<input type="checkbox" name="p_seljobgb" value="Y" <% if("Y".equals( v_jobgb.substring(7,8)) )out.println(" checked ");%> style="border:none;" /> 비금속제품
				<input type="checkbox" name="p_seljobgb" value="Y" <% if("Y".equals( v_jobgb.substring(8,9)) )out.println(" checked ");%> style="border:none;" /> 고무플라스틱
				<input type="checkbox" name="p_seljobgb" value="Y" <% if("Y".equals( v_jobgb.substring(9,10)) )out.println(" checked ");%> style="border:none;" /> 가죽제품
				<input type="checkbox" name="p_seljobgb" value="Y" <% if("Y".equals( v_jobgb.substring(10,11)) )out.println(" checked ");%> style="border:none;" /> 잡제품
				<input type="checkbox" name="p_seljobgb" value="Y" <% if("Y".equals( v_jobgb.substring(11,12)) )out.println(" checked ");%> style="border:none;" /> 정보통신<br>
					관심업종 1&nbsp;
					<input type="text" name="p_etc1" value="<%=interest.getString("ETC1")%>" style="width:200px;" maxlength = "50" />
					관심업종 2&nbsp;
				<input type="text" name="p_etc2" value="<%=interest.getString("ETC2")%>" style="width:200px;" maxlength = "50"/>
			</td>
        </tr>  
		<tr>
			<th>관심지역</th>
			<td>
			<% String v_localgb = interest.getString("LOCALGB");
			   if(v_localgb.equals("")) v_localgb = "NNNNNNNN";
			%>
			    <input type="hidden" name="p_localgb" value="<%=v_localgb %>">
				<input type="checkbox" name="p_sellocalgb" value="Y" <% if("Y".equals( v_localgb.substring(0,1)) )out.println(" checked ");%> style="border:none;" /> 북미
				<input type="checkbox" name="p_sellocalgb" value="Y" <% if("Y".equals( v_localgb.substring(1,2)) )out.println(" checked ");%> style="border:none;" /> 중남미
				<input type="checkbox" name="p_sellocalgb" value="Y" <% if("Y".equals( v_localgb.substring(2,3)) )out.println(" checked ");%> style="border:none;" /> 아시아
				<input type="checkbox" name="p_sellocalgb" value="Y" <% if("Y".equals( v_localgb.substring(3,4)) )out.println(" checked ");%> style="border:none;" /> 대양주
				<input type="checkbox" name="p_sellocalgb" value="Y" <% if("Y".equals( v_localgb.substring(4,5)) )out.println(" checked ");%> style="border:none;" /> 유럽
				<input type="checkbox" name="p_sellocalgb" value="Y" <% if("Y".equals( v_localgb.substring(5,6)) )out.println(" checked ");%>  style="border:none;" /> 중동
				<input type="checkbox" name="p_sellocalgb" value="Y" <% if("Y".equals( v_localgb.substring(6,7)) )out.println(" checked ");%> style="border:none;" /> 아프리카
				<input type="checkbox" name="p_sellocalgb" value="Y" <% if("Y".equals( v_localgb.substring(7,8)) )out.println(" checked ");%> style="border:none;" />  한국<br>
				관심국가 1&nbsp;
				<input type="text" name="p_etc3" value="<%=interest.getString("ETC3")%>" style="width:200px;" maxlength = "50"/>
				관심국가 2&nbsp;
				<input type="text" name="p_etc4" value="<%=interest.getString("ETC4")%>" style="width:200px;" maxlength = "50" />
			</td>
        </tr>
		<tr>
			<th>무역분야</th>
			<td>
			<% String v_tradegb = interest.getString("TRADEGB");
			   if(v_tradegb.equals("")) v_tradegb = "NNNNNNNN";
			%>
			    <input type="hidden" name="p_tradegb" value="<%=v_tradegb %>">
				<input type="checkbox" name="p_seltradegb" value="Y" <% if("Y".equals( v_tradegb.substring(0,1)) )out.println(" checked ");%> style="border:none;" /> 무역정책
				<input type="checkbox" name="p_seltradegb" value="Y" <% if("Y".equals( v_tradegb.substring(1,2)) )out.println(" checked ");%> style="border:none;" /> 외환
				<input type="checkbox" name="p_seltradegb" value="Y" <% if("Y".equals( v_tradegb.substring(2,3)) )out.println(" checked ");%> style="border:none;" /> 관세
				<input type="checkbox" name="p_seltradegb" value="Y" <% if("Y".equals( v_tradegb.substring(3,4)) )out.println(" checked ");%> style="border:none;" /> 무역영어
				<input type="checkbox" name="p_seltradegb" value="Y" <% if("Y".equals( v_tradegb.substring(4,5)) )out.println(" checked ");%>  style="border:none;" /> 무역결제
				<input type="checkbox" name="p_seltradegb" value="Y" <% if("Y".equals( v_tradegb.substring(5,6)) )out.println(" checked ");%> style="border:none;" /> 사이버무역
				<input type="checkbox" name="p_seltradegb" value="Y" <% if("Y".equals( v_tradegb.substring(6,7)) )out.println(" checked ");%> style="border:none;" /> 수출마케팅
				<input type="checkbox" name="p_seltradegb" value="Y" <% if("Y".equals( v_tradegb.substring(7,8)) )out.println(" checked ");%> style="border:none;" /> 물류
			</td>
        </tr>                  
        <% }else{ %>
        <tr>
			<th class="th_top_bd">Company/Organization Name</th>
			<td class="td_top_bd">
				<input type="text" name="p_corpnm" dispName="Company/Organization Name" isNull="Y" lenCheck="50" value="<%=member.getString("COMPNM") %>">
			</td>
        </tr>
        <tr>
			<th>Phone</th>
			<td>
				<input type="text" name="p_comptel" dispName="Phone" isNull="Y" lenCheck="30" value="<%=member.getString("COMPTEL") %>">
			</td>
        </tr> 
        <tr>
			<th colspan="2">Address</th>
		</tr>	        
        <tr>
			<th> - Street</th>
			<td>
				<input type="text" name="p_engstreet" dispName="Street" isNull="Y" lenCheck="100" value="<%=member.getString("ENGSTREET") %>">
			</td>
        </tr>   
        <tr>
			<th> - City</th>
			<td>
				<input type="text" name="p_engcity" dispName="City" isNull="Y" lenCheck="100" value="<%=member.getString("ENGCITY") %>">
			</td>
        </tr>   
        <tr>
			<th> - State/Province</th>
			<td>
				<input type="text" name="p_engstate" dispName="Street" isNull="Y" lenCheck="100" value="<%=member.getString("ENGSTATE") %>">
			</td>
        </tr>   
        <tr>
			<th> - Zip Code</th>
			<td>
				<input type="text" name="p_engzip" dispName="Street" isNull="Y" lenCheck="50" value="<%=member.getString("ENGZIP") %>">
			</td>
        </tr>   
        <tr>
			<th>Business Type</th>
			<td>
			<% String v_btype = interest.getString("BTYPE"); 
			   if(v_btype.equals("")) v_btype = "NNNNNNNN";
			%>
			    <input type="hidden" name="p_btype" value="<%=v_btype %>">
				<input type="checkbox" name="p_seltype" value="Y"  <% if("Y".equals( v_btype.substring(0,1)) )out.println(" checked ");%> style="border:none;" /> Manufacturer
				<input type="checkbox" name="p_seltype" value="Y" <% if("Y".equals( v_btype.substring(1,2)) )out.println(" checked ");%> style="border:none;" /> Exporter
				<input type="checkbox" name="p_seltype" value="Y" <% if("Y".equals( v_btype.substring(2,3)) )out.println(" checked ");%> style="border:none;" /> Importer
				<input type="checkbox" name="p_seltype" value="Y" <% if("Y".equals( v_btype.substring(3,4)) )out.println(" checked ");%> style="border:none;" /> Distributor
				<input type="checkbox" name="p_seltype" value="Y" <% if("Y".equals( v_btype.substring(4,5)) )out.println(" checked ");%> style="border:none;" /> Wholesaler/Retailer
				<input type="checkbox" name="p_seltype" value="Y" <% if("Y".equals( v_btype.substring(5,6)) )out.println(" checked ");%> style="border:none;" /> Service<br>
				<input type="checkbox" name="p_seltype" value="Y" <% if("Y".equals( v_btype.substring(6,7)) )out.println(" checked ");%> style="border:none;" /> Agent
				<input type="checkbox" name="p_seltype" value="Y" <% if("Y".equals( v_btype.substring(7,8)) )out.println(" checked ");%> style="border:none;" /> Other
			</td>
        </tr>  
        <% } %>
		</table>
	</div>
	
	<table width="985" cellpadding="0" cellspacing="0" class="mar_top_15" style="display:<%=!v_usergubun.equals("FC")?"":"none" %>">
		<tr>
			<td width="15"><img src="/images/back/common/bullet_label.gif"></td>
			<td class="txt_black_b">추가정보</td>
		</tr>
	</table>
	
	<div class="board-view"  style="display:<%=!v_usergubun.equals("FC")?"":"none" %>">
	   <table width="985" cellpadding="0" cellspacing="0" class="mar_top_5">
		<colgroup>
			<col width="200" />
			<col width="" />
			<col width="200" />
			<col width="" />
		</colgroup>
		<tr>
			<th class="th_top_bd"  colspan="4">01. 무역아카데미 홈페이지를 가입하시는 동기는?</th>
		</tr>
		<tr>	
			<td colspan="4">
				<input type="checkbox" name="p_joincd" value="01" style="border:none;" <% if("Y".equals( join.getString("JOINCD01") ) )out.println(" checked ");%>> 무역정보 획득
				<input type="checkbox" name="p_joincd" value="02" style="border:none;" <% if("Y".equals( join.equals("JOINCD02") ) )out.println(" checked ");%>> 오프라인 교육연수 신청
				<input type="checkbox" name="p_joincd" value="03" style="border:none;" <% if("Y".equals( join.equals("JOINCD03") ) )out.println(" checked ");%> > 사이버 교육 신청
				<input type="checkbox" name="p_joincd" value="04" style="border:none;" <% if("Y".equals( join.equals("JOINCD04") ) )out.println(" checked ");%> > 국제무역사 응시
				<input type="checkbox" name="p_joincd" value="05" style="border:none;" <% if("Y".equals( join.equals("JOINCD05") ) )out.println(" checked ");%> > 외환관리사 응시
				<input type="checkbox" name="p_joincd" value="06" style="border:none;" <% if("Y".equals( join.equals("JOINCD06") ) )out.println(" checked ");%> > 회사권유<br>
				<input type="checkbox" name="p_joincd" value="07" style="border:none;" <% if("Y".equals( join.equals("JOINCD07") ) )out.println(" checked ");%> > 차세대인력양성과정 관심(무역마스터, IT마스터, 글로벌인턴쉽 등)<br>
				기타<input type="text" name="p_joinetc" value="<%=member.getString("JOINETC") %>" style="width:200px;">
			</td>
        </tr>  
		<tr>
			<th colspan="4">02. 관심분야</th>
		</tr>
		<tr>	
			<td colspan="4">
				<input type="checkbox" name="p_fieldcd" value="01" style="border:none;" <% if("Y".equals( field.getString("FIELDCD01") ) )out.println(" checked ");%> > 무역실무
				<input type="checkbox" name="p_fieldcd" value="02" style="border:none;" <% if("Y".equals( field.getString("FIELDCD02") ) )out.println(" checked ");%> > 외환/금융
				<input type="checkbox" name="p_fieldcd" value="03" style="border:none;" <% if("Y".equals( field.getString("FIELDCD03") ) )out.println(" checked ");%> > 자격증(국제무역사, 외환관리사)
				<input type="checkbox" name="p_fieldcd" value="04" style="border:none;" <% if("Y".equals( field.getString("FIELDCD04") ) )out.println(" checked ");%> > 비즈니스 외국어
				<input type="checkbox" name="p_fieldcd" value="05" style="border:none;" <% if("Y".equals( field.getString("FIELDCD05") ) )out.println(" checked ");%> > 글로벌 비즈니스<br>
				기타 <input type="text" name="p_fieldetc" value="<%=member.getString("FIELDETC") %>" style="width:200px;" maxlength = '50'><br>
				* 관심분야 설정 시 맞춤 정보 제공 및 메일링 서비스를 받아보실 수 있습니다.
				</td>
        </tr>  
        <tr>	
            <th>결혼기념일</th>
			<td>
			<%
			  String v_anniversary = member.getString("ANNIVERSARY");
			%>
			<fmtag:calendar seq="1" name="form1" property="p_anniversary" date="<%=v_anniversary %>" dispName="결혼기념일" defaultYn="N" isNull="Y" position="right"/>
			</td>
            <th>자녀수</th>
			<td>
			<input type="text" name="p_children" dispName="자녀수" isNull="Y"  dataType="number" value="<%=member.getString("CHILDREN") %>" maxlength="4" style="width:60">
			</td>
        </tr>  
        <tr>	
            <th>최종학력</th>
			<td>
			<input type="text" name="p_finaldegree" dispName="최종학력" isNull="Y"  dataType="string" value="<%=member.getString("FINALDEGREE") %>" style="width:100">
			</td>
            <th>월평균소득</th>
			<td>
			<input type="text" name="p_income" dispName="월평균소득" isNull="Y"  dataType="string" value="<%=member.getString("INCOME") %>" style="width:100">
			</td>
        </tr>        
        <tr>	
            <th>메일수신설정</th>
			<td>
			<input type="radio" name="p_ismailing" value="Y" style="border:none;" <% if("Y".equals( member.getString("ISMAILING") ) )out.println(" checked ");%>> 동의함
			<input type="radio" name="p_ismailing" value="N" style="border:none;" <% if("N".equals( member.getString("ISMAILING") ) || member.getString("ISMAILING").equals(""))out.println(" checked ");%> > 동의안함
            <th>SMS수신설정</th>
			<td>
			<input type="radio" name="p_issms" value="Y" style="border:none;" <% if("Y".equals( member.getString("ISSMS") ) )out.println(" checked ");%>> 동의함
			<input type="radio" name="p_issms" value="N" style="border:none;" <% if("N".equals( member.getString("ISSMS") ) || member.getString("ISMAILING").equals("") )out.println(" checked ");%> > 동의안함			
			</td>
        </tr>      
		</table>
	</div>
	</form>
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