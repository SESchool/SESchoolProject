<%--
 * @(#)educationSubjectList.jsp
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * 나의정보수정 폼
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2009. 01. 20.  bluedove       Initial Release
 ************************************************
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.sinc.framework.data.DataSet"%>
<%@ page import="com.sinc.common.FormatDate"%>
<%@ include file="/jsp/front/common/commonInc.jsp"%>

<%
	String v_onoff = box.getStringDefault("p_onoff","ALL");
	String v_hgrcode = box.getString("s_hgrcode");
	String v_userid = box.getString("s_userid");
	
	Box ds2 = (Box)box.getObject("MemberInfo"); //학습자개인정보
    String v_usergubun = ds2.getString("USERGUBUN"); 
	boolean isRND = (box.getString("s_usergubun").equals("RK") || box.getString("s_usergubun").equals("RH")) ? true : false;

	String[] v_handphone_temp = ds2.getString("HANDPHONE").split("-");
	String[] v_handphone = {"","",""};
	if(v_handphone_temp.length==3) v_handphone = v_handphone_temp;	
	
	String[] v_hometel_temp = ds2.getString("HOMETEL").split("-");
	String[] v_hometel = {"","",""};
	if(v_hometel_temp.length==3) v_hometel = v_hometel_temp;
	
	String[] v_homefax_temp = ds2.getString("HOMEFAX").split("-");
	String[] v_homefax = {"","",""};
	if(v_homefax_temp.length==3) v_homefax = v_homefax_temp;
	
	String[] v_comptel_temp = ds2.getString("COMPTEL").split("-");
	String[] v_comptel = {"","",""};
	if(v_comptel_temp.length==3) v_comptel = v_comptel_temp;
	
	String[] v_corpfax_temp = ds2.getString("CORPFAX").split("-");
	String[] v_corpfax = {"","",""};
	if(v_corpfax_temp.length==3) v_corpfax = v_corpfax_temp;
		
	String v_corpzip = ds2.getString("CORPZIP");
	String v_corpzip1;
	String v_corpzip2;			
	if( !StringUtil.isNull(v_corpzip) && !v_corpzip.equals("-") ){
		if( v_corpzip.contains("-") ){
			v_corpzip1 = v_corpzip.substring(0, v_corpzip.indexOf("-"));
			v_corpzip2 = v_corpzip.substring(v_corpzip.indexOf("-")+1, v_corpzip.length())
		} else if( v_corpzip.length() > 5 ){
			v_corpzip1 = v_corpzip.substring(0, 3);
			v_corpzip2 = v_corpzip.substring(3, v_corpzip.length());
		} else {
			v_corpzip1 = v_corpzip;
			v_corpzip2 = "";
		}
	} else {
		v_corpzip1 = "";
		v_corpzip2 = "";
	}

	String[] v_email_temp = ds2.getString("EMAIL").split("@");
	String[] v_emailstr = {"",""};
	if(v_email_temp.length==2) v_emailstr = v_email_temp;
	
	String v_prefix = ds2.getString("PREFIX");
	
	v_userid = ds2.getString("USERID");
	if(v_prefix.length()>0) v_userid = v_userid.replaceFirst(v_prefix,""); //id에서 prefix를 뗀다.

	String v_postgb = ds2.getString("POSTGB");
	if(v_postgb.equals("")) v_postgb = "2";
	
	String v_nemail = "N"; // 등록된 이메일인지를 체크해준다.
	if(v_emailstr[1].equals("hanmail.net") || v_emailstr[1].equals("naver.com") || v_emailstr[1].equals("empal.com")
	 || v_emailstr[1].equals("paran.com") || v_emailstr[1].equals("hotmail.com") || v_emailstr[1].equals("lycos.co.kr")
	 || v_emailstr[1].equals("msn.com") || v_emailstr[1].equals("yahoo.com") || v_emailstr[1].equals("korea.com")
	 || v_emailstr[1].equals("kornet.net") || v_emailstr[1].equals("yahoo.co.kr")) v_nemail = "Y"; 
 %>
 <script type="text/JavaScript" language="JavaScript" src="/js/common/prototype.js"></script>
<script language="javascript">
	
	function fncConfirm()
	{
		var f = document.form1;
		if(!validate(f)) return;
		
		if(f.p_pwd.value!=f.p_pwdconfirm.value)
		{
			alert('비밀번호와 비밀번호확인이 틀립니다.');
			return;
		}

		f.p_hometel.value = f.p_hometel1.value+"-"+f.p_hometel2.value+"-"+f.p_hometel3.value;		
		f.p_homefax.value = f.p_homefax1.value+"-"+f.p_homefax2.value+"-"+f.p_homefax3.value;
		f.p_handphone.value = f.p_handphone1.value+"-"+f.p_handphone2.value+"-"+f.p_handphone3.value;
		if( f.p_corpzip2.value == null || f.p_corpzip2.value == "" ){
			f.p_corpzip.value = f.p_corpzip1.value;
		} else {
			f.p_corpzip.value = f.p_corpzip1.value+"-"+f.p_corpzip2.value;
		}
		f.p_comptel.value = f.p_comptel1.value+"-"+f.p_comptel2.value+"-"+f.p_comptel3.value;		
		f.p_corpfax.value = f.p_corpfax1.value+"-"+f.p_corpfax2.value+"-"+f.p_corpfax3.value;

   		f.p_rcvrmobile.value = f.p_handphone.value            
        if(f.p_postgb.value == "2"){
    		f.p_rcvrzipcode.value = f.p_post1.value+f.p_post2.value;
    		f.p_rcvrtel.value = f.p_hometel.value;	
    		f.p_rcvraddr.value = f.p_addr.value + " " + f.p_addr2.value 
        } else{
    		f.p_rcvrzipcode.value = f.p_corpzip1.value+f.p_corpzip2.value;
    		f.p_rcvrtel.value = f.p_comptel.value;	            
    		f.p_rcvraddr.value = f.p_corpaddr1.value + " " + f.p_corpaddr2.value
        } 
		
	    f.action = "/front/MyClass.do?cmd=myInfoEdit";	     
		f.submit();
	}	
 
	function searchZipCode(objname) {
		var url = "/front/Common.do?cmd=selectZipCode&p_objname="+objname; 
		Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
	}
	function setZipCodeInfo(objname, addr, zipcode) {
		var form = document.form1;
        alert(objname);
	    if(objname == "home"){ 				
			$("p_addr").setValue(addr);			
			if(zipcode.search('-') > -1){	// 기존의 지번주소
				$("p_post1").setValue(zipcode.substr(0, 3));
				$("p_post2").setValue(zipcode.substr(4, 7));
			} else {						// 새로운 우편주소
				$("p_post1").setValue(zipcode);
				$("p_post2").setValue("");
				form.p_post2.style.display="none";
			}
	    }else{
			$("p_corpaddr1").setValue(addr);
			if(zipcode.search('-') > -1){	// 기존의 지번주소
				$("p_corpzip1").setValue(zipcode.substr(0, 3));
				$("p_corpzip2").setValue(zipcode.substr(4, 7));
			} else {						// 새로운 우편주소
				$("p_corpzip1").setValue(zipcode);
				$("p_corpzip2").setValue("");
				form.p_corpzip2.style.display="none";
			}
	    }	
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

	function fileDownload(rfileName, sfileName, filePath) {
		  var loc = "/fileDownServlet?rFileName="+rfileName+"&sFileName="+sfileName+"&filePath="+filePath;
		  location.href = loc;
		  hiddenFrame.location.href = loc;
	}

	function selectPostGb(){
		var f = document.form1;
		var postgb = f.p_postgb.value;
		var homeTr = null, compTr = null;
	
		for(var i = 1; i <= 3; i++){ 
			if(postgb == "2"){
				document.getElementById("nameTh").innerHTML = "학교명"; 
				homeTr = document.getElementById("homeTr"+i);
				compTr = document.getElementById("compTr"+i);
				homeTr.style.display = "";
				compTr.style.display = "none";
			}else{
				document.getElementById("nameTh").innerHTML = "직장명";
				homeTr = document.getElementById("homeTr"+i);
				compTr = document.getElementById("compTr"+i);
				homeTr.style.display = "none";
				compTr.style.display = "";				
			}
		}	 
	}

	function setEmailTail(arg) {
		var f = document.form1;
		
		if(arg == "") {
			f["p_email2"].value  = "" ;
			f["p_email2"].readOnly =  false ;
			f["p_email2"].focus();
		}else {
			f["p_email2"].readOnly =  true ;
			f["p_email2"].value  = arg ;
		}
	}

</script>

<form name="form1" method="post" action="/front/MyClass.do" onSubmit="return false;" enctype="multipart/form-data">
<input type="hidden" name="cmd" value="myInfoEditForm">
<input type="hidden" name="p_userid" value="<%=box.getString("p_userid") %>">
<input type="hidden" name="p_oldfile1" value="<%=ds2.getString("FILE1") %>">
<input type="hidden" name="p_oldrealfile1" value="<%=ds2.getString("REALFILE1") %>">
<input type="hidden" name="p_oldfile2" value="<%=ds2.getString("FILE2") %>">
<input type="hidden" name="p_oldrealfile2" value="<%=ds2.getString("REALFILE2") %>">
<input type="hidden" name="p_rcvrzipcode" value="<%=ds2.getString("RCVRZIPCODE") %>">
<input type="hidden" name="p_rcvrtel" value="<%=ds2.getString("RCVRTEL") %>">
<input type="hidden" name="p_rcvrmobile" value="<%=ds2.getString("RCVRMOBILE") %>">
<input type="hidden" name="p_rcvraddr" value="<%=ds2.getString("RCVRADDR") %>">

<!-- Body -->
<div class="board-write">
<table width="690" border="0" cellpadding="0" cellspacing="0">
	<caption></caption>
	<colgroup>
		<col width="130" />
		<col width="" />
		<col width="130" />
		<col width="" />		
	</colgroup>
	<tr>
		<th>아이디</th>
		<td colspan="3"><%=v_userid%></td>
	</tr>
	<tr>
		<th><span style="color: #a0410d; padding-right: 5px;">*</span>비밀번호</th>
		<td><input name="p_pwd" type="password" isNull="N"
			dispName="비밀번호" lenCheck="20" value=""
			style="border: solid 1px #cccccc; width: 134px; height: 18px;"></td>
		<th><span style="color: #a0410d; padding-right: 5px;">*</span>비밀번호확인</th>
		<td><input name="p_pwdconfirm" type="password" isNull="N"
			dispName="비밀번호 확인" lenCheck="20" value=""
			style="border: solid 1px #cccccc; width: 134px; height: 18px;" /></td>
	</tr>
	<tr>
		<th>이름</th>
		<td colspan="3"><%=ds2.getString("NAME") %></td>
	</tr>
	<tr>
		<th>주민등록번호</th>
		<td><%=ds2.getString("RESNO").substring(0,6) %>-******<%--=ds2.getString("RESNO") --%></td>
		<th>우편물접수처</th>
		<td><%=CommonUtil.getCodeListBox("select","0092","p_postgb",v_postgb,"selectPostGb()","")%></td>
	</tr>
	<tr>
		<th>직업</th>
		<td colspan="3"><%=CommonUtil.getCodeListBox("select","0093","p_jobccsenr",ds2.getString("JOBC_CSENR"),"","")%></td>
	</tr>		
	<tr>
		<th id="nameTh"><%=v_postgb.equals("2")?"학교명":"직장명"%></th>
		<td colspan="3">
		<input name="p_compnm" type="text" isNull="Y"
			dispName="<%=v_postgb.equals("2")?"학교명":"직장명"%>" lenCheck="50" value="<%=ds2.getString("COMPNM") %>"
			style="border: solid 1px #cccccc; width: 154px; height: 18px;" />
		</td>
	</tr>	
	<tr>
		<th>핸드폰번호</th>
		<td colspan="3">
		<input type="hidden" name="p_handphone" value="<%=ds2.getString("HANDPHONE") %>">
		<select name="p_handphone1">
			<option value="010" <%=v_handphone[0].equals("010")?"selected":"" %>>010</option>
			<option value="011" <%=v_handphone[0].equals("011")?"selected":"" %>>011</option>
			<option value="016" <%=v_handphone[0].equals("016")?"selected":"" %>>016</option>
			<option value="017" <%=v_handphone[0].equals("017")?"selected":"" %>>017</option>
			<option value="018" <%=v_handphone[0].equals("018")?"selected":"" %>>018</option>
			<option value="019" <%=v_handphone[0].equals("019")?"selected":"" %>>019</option>
		</select> - <input name="p_handphone2" type="text" size="4" isNull="N"
			dispName="핸드폰번호" dataType="number" value="<%=v_handphone[1]%>" maxLength="4" /> - <input
			name="p_handphone3" type="text" size="4" isNull="N" dispName="핸드폰번호"
			dataType="number" value="<%=v_handphone[2]%>" maxLength="4" />
		</td>
	</tr>
	<tr>
		<th>이메일</th>
		<td colspan="3">
		    <input type="hidden" name="p_email" value="<%=ds2.getString("EMAIL") %>">
			<input name="p_email1" type="text" isNull="N" dispName="이메일" lenCheck="50" value="<%=v_emailstr[0] %>" />
			<input name="p_email2" type="text" value="<%=v_emailstr[1] %>" style="display:<%=v_nemail.equals("Y")?"none":"" %>"/>
	        <select name="emailCheck" onchange="setEmailTail(emailCheck.options[this.selectedIndex].value)" class="form" >
				<option value="">직접입력</option>
				<option value="hanmail.net" <%=v_emailstr[1].equals("hanmail.net")?"selected":"" %>>hanmail.net</option>
				<option value="naver.com" <%=v_emailstr[1].equals("naver.com")?"selected":"" %>>naver.com</option>
				<option value="empal.com" <%=v_emailstr[1].equals("empal.com")?"selected":"" %>>empal.com</option>
				<option value="paran.com" <%=v_emailstr[1].equals("paran.com")?"selected":"" %>>paran.com</option>
				<option value="hotmail.com" <%=v_emailstr[1].equals("hotmail.com")?"selected":"" %>>hotmail.com</option>
				<option value="lycos.co.kr" <%=v_emailstr[1].equals("lycos.co.kr")?"selected":"" %>>lycos.co.kr</option>
				<option value="msn.com" <%=v_emailstr[1].equals("msn.com")?"selected":"" %>>msn.com</option>
				<option value="yahoo.com" <%=v_emailstr[1].equals("yahoo.com")?"selected":"" %>>yahoo.com</option>
				<option value="korea.com" <%=v_emailstr[1].equals("korea.com")?"selected":"" %>>korea.com</option>
	            <option value="kornet.net" <%=v_emailstr[1].equals("kornet.net")?"selected":"" %>>kornet.net</option>
				<option value="yahoo.co.kr" <%=v_emailstr[1].equals("yahoo.co.kr")?"selected":"" %>>yahoo.co.kr</option>
            </select>
		</td>
	</tr>
	<tr id="homeTr1" style="display:<%=v_postgb.equals("2")?"":"none"%>">
		<th>전화번호</th>
		<td colspan="3">
		<input type="hidden" name="p_hometel" value="<%=ds2.getString("HOMETEL") %>">
		<input name="p_hometel1" type="text" size="3" isNull="Y"
			dispName="자택전화번호" dataType="number" value="<%=v_hometel[0] %>"  maxLength="3" /> - <input
			name="p_hometel2" type="text" size="4" isNull="Y" dispName="자택전화번호"
			dataType="number" value="<%=v_hometel[1]%>"  maxLength="4" /> - <input
			name="p_hometel3" type="text" size="4" isNull="Y" dispName="자택전화번호"
			dataType="number" value="<%=v_hometel[2]%>"  maxLength="4" />
		</td>
	</tr>
	<tr id="homeTr2" style="display:<%=v_postgb.equals("2")?"":"none"%>">
		<th>팩스번호</th>
		<td colspan="3">
		<input type="hidden" name="p_homefax" value="<%=ds2.getString("HOMEFAX") %>">
		<input name="p_homefax1" type="text" size="3" isNull="Y"
			dispName="팩스번호" dataType="number" value="<%=v_homefax[0] %>" maxLength="3" /> - <input
			name="p_homefax2" type="text" size="4" isNull="Y" dispName="팩스번호"
			dataType="number" value="<%=v_homefax[1]%>" maxLength="4" /> - <input
			name="p_homefax3" type="text" size="4" isNull="Y" dispName="팩스번호"
			dataType="number" value="<%=v_homefax[2]%>" maxLength="4" />
		</td>
	</tr>
	<tr  id="homeTr3" style="display:<%=v_postgb.equals("2")?"":"none"%>">
		<th>주소</th>
		<td colspan="3">
		<% if( ds2.getString("POST2") == null || ds2.getString("POST2").equals("")){ %>
			<input type="text" name="p_post1" size="3" isNull="Y" dispName="우편번호" dataType="number" value="<%=ds2.getString("POST1") %>" style="border: solid 1px #cccccc; width: 50px; height: 18px;">
			<input type="hidden" name="p_post2" dispName="우편번호" value="<%=ds2.getString("POST2") %>">
		<% } else { %>
		  <input type="text" name="p_post1" size="3" isNull="Y"	dispName="우편번호" dataType="number" value="<%=ds2.getString("POST1") %>" style="border: solid 1px #cccccc; width: 50px; height: 18px;">
		- <input type="text" name="p_post2" size="3" isNull="Y" dispName="우편번호"	dataType="number" value="<%=ds2.getString("POST2") %>" style="border: solid 1px #cccccc; width: 50px; height: 18px;">
		<% } %>
		&nbsp;<a href="javascript:searchZipCode('home')"><img src="/images/common/btn_zipcode.gif" alt="우편번호찾기" /></a><br>
		<input type="text" name="p_addr" isNull="Y" dispName="주소"	lenCheck="200" value="<%=ds2.getString("ADDR") %>" style="border: solid 1px #cccccc; width: 550px; height: 18px; margin-top: 3px;">
		<input type="text" name="p_addr2" isNull="Y" dispName="상세주소" lenCheck="200" value="<%=ds2.getString("ADDR2") %>" style="border: solid 1px #cccccc; width: 550px; height: 18px; margin-top: 3px;"></td>
	</tr>
	<tr id="compTr1" style="display:<%=v_postgb.equals("2")?"none":""%>">
		<th>직장전화번호</th>
		<td colspan="3">
		<input type="hidden" name="p_comptel" value="<%=ds2.getString("COMPTEL") %>">
		<input name="p_comptel1" type="text" size="3" isNull="Y"
			dispName="직장전화번호" dataType="number" value="<%=v_comptel[0] %>" /> - <input
			name="p_comptel2" type="text" size="4" isNull="Y" dispName="직장전화번호"
			dataType="number" value="<%=v_comptel[1]%>" /> - <input
			name="p_comptel3" type="text" size="4" isNull="Y" dispName="직장전화번호"
			dataType="number" value="<%=v_comptel[2]%>" />
		</td>
	</tr>
	<tr id="compTr2" style="display:<%=v_postgb.equals("2")?"none":""%>">
		<th>직장팩스번호</th>
		<td colspan="3">
		<input type="hidden" name="p_corpfax" value="<%=ds2.getString("CORPFAX") %>">
		<input name="p_corpfax1" type="text" size="3" isNull="Y"
			dispName="직장팩스번호" dataType="number" value="<%=v_corpfax[0] %>" /> - <input
			name="p_corpfax2" type="text" size="4" isNull="Y" dispName="직장팩스번호"
			dataType="number" value="<%=v_corpfax[1]%>" /> - <input
			name="p_corpfax3" type="text" size="4" isNull="Y" dispName="직장팩스번호"
			dataType="number" value="<%=v_corpfax[2]%>" />
		</td>
	</tr>
	<tr  id="compTr3" style="display:<%=v_postgb.equals("2")?"none":""%>">
		<th>직장주소</th>
		<td colspan="3">
		    <input type="hidden" name="p_corpzip" value="<%=ds2.getString("CORPZIP") %>">
		<% if( v_corpzip2 == null || v_corpzip2.equals("")){ %>
			<input type="text" name="p_corpzip1" size="3" isNull="Y" dispName="우편번호" dataType="number" value="<%=v_corpzip1 %>" style="border: solid 1px #cccccc; width: 50px; height: 18px;">
			<input type="hidden" name="p_corpzip2" dispName="우편번호" value="<%=v_corpzip2 %>">
		<% } else { %>
			<input type="text" name="p_corpzip1" size="3" isNull="Y" dispName="우편번호" dataType="number" value="<%=v_corpzip1 %>" style="border: solid 1px #cccccc; width: 50px; height: 18px;"> -
			<input type="text" name="p_corpzip2" size="3" dispName="우편번호" dataType="number" value="<%=v_corpzip2 %>" style="border: solid 1px #cccccc; width: 50px; height: 18px;">
		<% } %>
		&nbsp;<a href="javascript:searchZipCode('comp')");"><img src="/images/common/btn_zipcode.gif" alt="우편번호찾기" /></a><br>
		<input type="text" name="p_corpaddr1" isNull="Y" dispName="주소" lenCheck="200" value="<%=ds2.getString("CORPADDR1") %>" style="border: solid 1px #cccccc; width: 550px; height: 18px; margin-top: 3px;">
		<input type="text" name="p_corpaddr2" isNull="Y" dispName="상세주소" lenCheck="200" value="<%=ds2.getString("CORPADDR2") %>" style="border: solid 1px #cccccc; width: 550px; height: 18px; margin-top: 3px;"></td>
	</tr>	
    <tr>
		<th>배송시메시지</th>
		<td colspan="3"><input type="text" name="p_rcvrmsg"
			value="<%=ds2.getString("RCVRMSG") %>" dispName="배송시메시지" isNull="Y"
			lenCheck="1000"
			style="border: solid 1px #cccccc; width: 550px; height: 18px;"></td>
	</tr>
	<tr>
		<th>첨부파일1</th>
		<td colspan="3">
		<%
			if (!ds2.getString("FILE1").equals("")) {
		%><span id="OldFile1">
		<a href="javascript:fileDownload('<%=ds2.getString("REALFILE1")%>', '<%=ds2.getString("FILE1")%>', '/member');"><%=ds2.getString("FILE1")%></a>&nbsp;
		<img src="/images/back/icon/ico_del.gif" onClick="oldFileDel(1)" align="absmiddle">
		</span><br>
		<%
			}
		%> <input name="p_file1" type="file" size="50"></td>
		</td>
	</tr>
	<tr>
		<th>첨부파일2</th>
		<td colspan="3">
		<%
			if (!ds2.getString("FILE2").equals("")) {
		%><span id="OldFile2">
		<a href="javascript:fileDownload('<%=ds2.getString("REALFILE2")%>', '<%=ds2.getString("FILE2")%>', '/member');"><%=ds2.getString("FILE2")%></a>&nbsp;
		<img src="/images/back/icon/ico_del.gif" onClick="oldFileDel(2)" align="absmiddle">
		</span><br>
		<%
			}
		%> <input name="p_file2" type="file" size="50"></td>
		</td>
	</tr>
</table>
</div>

<table width="690" border="0" cellpadding="0" cellspacing="0"
	style="margin-top: 10px;">
	<tr>
		<td align="right">
		<a href="javascript:fncConfirm()"><img
			src="/images/common/btn_save.gif" alt="저장" /></a>
		</td>
	</tr>
</table>
</form>
<!-- //Body -->
