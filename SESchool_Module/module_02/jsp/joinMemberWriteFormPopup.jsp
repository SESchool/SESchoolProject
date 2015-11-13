<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="/tags/fm_taglib" prefix="fmtag" %>
<%@ include file = "../commonBasicInc.jsp"%>
<%
	String v_hgrcode = box.getString("s_hgrcode");
	ArrayList compList = (ArrayList)box.getObject("CompList");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
<title>무역아카데미</title>
<link type="text/css" rel="stylesheet" href="/css/front/template1/import.css" />
<fmtag:jscommon />
<script type="text/javascript">
<%	if ( !box.getString("MSG").equals("") ) { %>
	alert ( "<%=box.getString("MSG")%>" );
<%	} %>
	function goNextPage() {
		var f = document.form1;
		
		if ( !validate(f) ) return;
		
		if ( !f.p_agree1.checked ) {
			alert ( "서비스 이용약관에 동의 하셔야 가입이 됩니다." );
			f.p_agree1.focus();
			return;
		}if ( !f.p_agree2.checked ) {
			alert ( "개인정보보호정책 이용약관에 동의 하셔야 가입이 됩니다." );
			f.p_agree1.focus();
			return;
		}
		if ( !jsCheckJumin(f.p_resno1.value+f.p_resno2.value) ) {
			alert ( "주민등록 번호 형식이 잘못 되었습니다." );
			return;
		}
		f.action = "/front/Member.do";
		f.cmd.value = "joinMemberWriteFormPopup";
		f.submit();
	}
	//ID중복확인체크
	function userIdCheck() {
		var f = document.form1;
		
		if ( f.p_userid.value == "" ) {
			alert('아이디를 입력하세요');
			f.p_userid.focus();			
			return;
		}
		if ( !idValidate(f.p_userid.value ) ) {
			f.p_userid.focus();
			return;
		}
		Center_Fixed_Popup2("", "IdInputPop", 420, 300, "no");
		f.target = "IdInputPop";
		f.action = "/front/Member.do?cmd=idDuplicateCheckPopup";
		f.cmd.value = "idDuplicateCheckPopup";
		f.method = "post";

		f.submit();
		f.target = "";
		//document.hiddenFrame.location.href="/back/Tutor.do?cmd=userIdCheck&p_userid="+f.p_userid.value;
	}
	function setUserId(v_userid) {
		var f = document.form1;
		f.p_userid.value = v_userid;
		f.p_userid.readOnly = true;
		f.idDuplicateCheck.value = "Y";
	}
	function searchZipCode(objname) {
		var url = "/front/Common.do?cmd=selectZipCode&p_objname="+objname; 
		Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
	}
	function setZipCodeInfo(objname, addr, zipcode) {
		var form = document.form1;

	    if ( objname == "home" ) {
			$("p_addr").setValue(addr);			
			if(zipcode.search('-') > -1){	// 기존의 지번주소
				$("p_post1").setValue(zipcode.substr(0, 3));
				$("p_post2").setValue(zipcode.substr(4, 7));
			} else {						// 새로운 우편주소
				$("p_post1").setValue(zipcode);
				$("p_post2").setValue("");
				form.p_post2.style.display="none";
			}	
	    } else if ( objname == "recv" ) {
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
	}
	function writeMember() {
		var f = document.form1;
		
		if ( !validate(f) ) return;
		if ( !validateEtc(f) ) return;
		
		f.action = "/front/Member.do?cmd=writeMember";
		f.cmd.value = "writeMember";
		f.method = "post";

		f.submit();
		f.target = "";
	}
	
	function validateEtc(f) {
		
		var regExp = "";

		// 아이디 중복체크
		if ( f.idDuplicateCheck.value == "N" ) {
			alert ( "아이디 중복체크를 해 주십시요" );
			return;
		}

		// 아이디 검사
		if ( !idValidate(f.p_userid.value) ) {
			f.p_userid.focus();
			return;
		}
		
		// 비밀번호 검사
		// 1. 비밀번호는 영문 또는 영문/숫자 조합으로만 등록이 가능합니다.
		regExp = /[a-zA-Z0-9]{7,20}/;
		if ( !regExp.test(f.p_pwd.value) ) {
			alert ( "비밀번호는 영문 또는 영문/숫자 조합으로  8자리 이상  등록이 가능합니다." );
			f.p_pwd.focus();
			return false;
		} else {
			// 2. 연속된 숫자 또는 알파벳 3자 이상 사용 불가합니다.
			var ch1, ch2, ch3;
			var v_pwd = f.p_pwd.value;
			for ( var i=2; i < v_pwd.length; i++ ) {
				ch1 = v_pwd.charCodeAt(i-2);
				ch2 = v_pwd.charCodeAt(i-1);
				ch3 = v_pwd.charCodeAt(i-0);
				if ( ch1 == ch2 && ch1 == ch3 ) {
					alert ( "비밀번호는 연속된 3개의 문자를 사용할수 없습니다." );
					f.p_pwd.focus();
					return false;
				}
			}
			// 3. 비밀번호내에 아이디가 포함되어 있으면 안됩니다.
			var arrTmp = v_pwd.split(f.p_userid.value);
			if ( arrTmp.length > 1 ) {
				alert ( "비밀번호내에 아이디가 포함되어 있으면 안됩니다." );
				f.p_pwd.focus();
				return false;
			}
		}

		// 비밀번호 확인 검사
		if ( f.p_pwdconfirm.value != f.p_pwd.value ) {
			alert ( "비밀번호와 비밀번호 확인 값이 서로 다릅니다." );
			f.p_pwdconfirm.focus();
			return;
		}

		// 핸드폰 번호
		regExp = /01[016789]{1}-[0-9]{3,4}-[0-9]{4}/;
		if ( !regExp.test(f.p_handphone1.value+"-"+f.p_handphone2.value+"-"+f.p_handphone3.value) ) {
			alert ( "핸드폰 번호 형식이 잘못되었습니다." );
			f.p_handphone1.focus();
			return;
		}

		// 회사 전화번호
		regExp = /0[0-9]{1,2}-[0-9]{3,4}-[0-9]{4}/;
		if ( !regExp.test(f.p_comptel1.value+"-"+f.p_comptel2.value+"-"+f.p_comptel3.value) ) {
			alert ( "전화번호 형식이 잘못되었습니다." );
			f.p_comptel1.focus();
			return;
		}

		//메일 확인
		if (f.p_email1.value.charAt(0) == " " || f.p_email2.value == ""){
			alert("메일주소가 공백이거나 첫문자가 공란입니다.");
			f.p_email1.focus();
			return false;
		}

		var val = f.p_email1.value+'@'+f.p_email2.value;
		if (!ise_mail(val)) 
		{
		  alert("메일주소가 정확하지 않습니다.");
		  	f.p_email1.value="";
		  	f.p_email2.value='';
		  	f.p_email1.focus();
		  return false;
		}
		
		return true;
	}
	function idValidate(v_userid) {
		// 1. 회원 ID는 공백을 허용하지 않습니다.
		// 2. 회원ID는 4자 이상 12자 이하입니다.
		// 3. 아이디는 숫자와 영문이외의 숫자를 사용 못함
		regExp = /^[A-Za-z0-9]{4,12}$/;
		if ( !regExp.test(v_userid) ) {
			alert ( "아이디는 숫자와 영문 이외의 문자를 사용할 수 없으며 4자 이상 입니다." );
			return false;
		}
		return true;
	}

	function ise_mail(s)
	{
	  return s.search(/^\s*[\w\~\-\.]+\@[\w\~\-]+(\.[\w\~\-]+)+\s*$/g)>=0;
	}	
</script>
</head>
<body style="margin:5px 0px 0px 21px">
<form name="form1" action="/front/Member.do?cmd=writeMember" method="post" onSubmit="return false;">
<input type="hidden" name="cmd" value="writeMember" />
<input type="hidden" name="p_hgrcode" value="<%=v_hgrcode %>">
<input type="hidden" name="p_resno" value="<%=box.getString("p_resno1")+box.getString("p_resno2") %>"/>
<input type="hidden" name="idDuplicateCheck" value="N"/>
	<div class="contents">
			<table width="690" cellpadding="0" cellspacing="0" style="margin-top:17px;">
			<tr>
				<td width="15"><img src="/images/template1/common/bullet_title.gif" alt="타이틀불릿" /></td>
				<td>
					<img src="/images/template1/title/pagetitle8.gif" alt="사이트맵 타이틀" /></td>
			</tr>
			<tr><td height="15"></td></tr>
			</table>
			<!-- Page Contents -->
			<table width="690" border="0" cellpadding="0" cellspacing="0">
			<tr><td style="padding:0 0 5px 0;"><img src="/images/common/join_title02.gif" alt="필수정보" /></td></tr>			
			<tr><td>1. 회원아이디는 공백을 허용하지 않습니다.</br>
2. 회원 아이디는 영문과 숫자로만 가능 합니다.<font color=blue>(4자리 이상)</font></br>
3. 비밀번호는 영문 또는 영문/숫자 조합으로 8자 이상 등록이 가능합니다</br>
4. 비밀번호는 연속된 숫자 또는 알파벳 3자 이상 사용 불가합니다.</br>
5. 비밀번호내에 아이디가 포함되어 있으면 안됩니다.</br><!--img src="/images/common/join_img.gif" alt="필수정보내용" /--></td></tr>		
			</table>
 
			<div><!-- 회원가입폼 -->
				<table width="680" summary="회원가입폼" border="0" class="" cellspacing="0">
				<colgroup>
					<col width="140" />
					<col width="540" />
				</colgroup>
				<tr><td style="padding:10px 0 10px 0;"><img src="/images/common/join_label01.gif" alt="기본정보" /></td></tr>
				<tr><td height="2" bgcolor="#252525"></td><td bgcolor="#b7b7b7"></td></tr>				
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">아이디<img src="/images/common/icon_point.gif" alt="중요" /></th>
					<td style="padding-left:5px;">
						<input name="p_userid" type="text" size="20" dispName="아이디" isNull="N" lenCheck="13" maxLength="13" value="<%=box.getString("p_userid") %>" style="height:20px"/>
						<a href="#" onClick="userIdCheck()"><img src="/images/common/btn_double_check.gif" align="absmiddle" alt="중복확인" /></a>
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">비밀번호<img src="/images/common/icon_point.gif" alt="중요" /></th>
					<td style="padding-left:5px;">
						<input name="p_pwd" type="password" size="20" dispName="비밀번호" isNull="N" lenCheck="20" maxLength="20" value="<%=box.getString("p_pwd") %>" style="height:20px"/>
						(8자 이상의 영문, 숫자 조합)
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">비밀번호 확인<img src="/images/common/icon_point.gif" alt="중요" /></th>
					<td style="padding-left:5px;">
						<input name="p_pwdconfirm" type="password" size="20" dispName="비밀번호확인" isNull="N" lenCheck="12" maxLength="12" value="" style="height:20px"/>
						(비밀번호를 한번 더 입력해 주세요)
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">이름<img src="/images/common/icon_point.gif" alt="중요" /></th>
					<td style="padding-left:5px;">
						<input name="p_name" type="text" size="20" dispName="이름" isNull="N" lenCheck="30" maxLength="30" value="<%=box.getString("p_name") %>" style="height:20px" readonly />
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
<%	if ( !v_hgrcode.equals("0") ) { %>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">회사</th>
					<td style="padding-left:5px;">
<%		HashMap hmData = null;
		if ( compList != null && compList.size() > 0 ) {
			if ( compList.size() > 1 ) { %>
						<select name="p_comp">
<%				for ( int i=0; i < compList.size(); i++ ) {
					hmData = (HashMap)compList.get(i); %>
						<option value="<%=hmData.get("CODE") %>"><%=hmData.get("CODENM") %></option>                                          
<% 				} %>
						</select>
<% 			} else {
				hmData = (HashMap)compList.get(0); %>
					<input type="hidden" name="p_comp" value="<%=hmData.get("CODE") %>" />
<%			}
		} %>
					</td>
				</tr>
<%	} %>

<%	if ( v_hgrcode.equals("0") ) { %>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">부서</th>
					<td style="padding-left:5px;">
						<input name="p_deptnam" type="text" size="20" dispName="부서" isNull="Y" lenCheck="60" maxLength="60" value="<%=box.getString("p_deptnam") %>" style="height:20px" />
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">직급</th>
					<td style="padding-left:5px;" >
						<input name="p_jikupnm" type="text" size="20" dispName="직급" isNull="Y" lenCheck="50" maxLength="50" value="<%=box.getString("p_deptnam") %>" style="height:20px" />
					</td>
				</tr>
			
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">자택 전화번호</th>
					<td style="padding-left:5px;">
						<input name="p_hometel1" type="text" size="7" dataType="integer" dispName="자택 전화번호" isNull="Y" lenCheck="3" maxLength="3" value="<%=box.getString("p_hometel1")%>" style="height:20px"/> -
						<input name="p_hometel2" type="text" size="7" dataType="integer" dispName="자택 전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=box.getString("p_hometel2")%>" style="height:20px"/> - 
						<input name="p_hometel3" type="text" size="7" dataType="integer" dispName="자택 전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=box.getString("p_hometel3")%>" style="height:20px"/>
					</td>
				</tr>
<%	} %>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">핸드폰번호<img src="/images/common/icon_point.gif" alt="중요" /></th>
					<td style="padding-left:5px;">
						<input name="p_handphone1" type="text" size="7" dataType="integer" dispName="핸드폰번호" isNull="N" lenCheck="3" maxLength="3" value="<%=box.getString("p_handphone1")%>" style="height:20px"/> -
						<input name="p_handphone2" type="text" size="7" dataType="integer" dispName="핸드폰번호" isNull="N" lenCheck="4" maxLength="4" value="<%=box.getString("p_handphone2")%>" style="height:20px"/> - 
						<input name="p_handphone3" type="text" size="7" dataType="integer" dispName="핸드폰번호" isNull="N" lenCheck="4" maxLength="4" value="<%=box.getString("p_handphone3")%>" style="height:20px"/>
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">회사 전화번호<img src="/images/common/icon_point.gif" alt="중요" /></th>
					<td style="padding-left:5px;">
						<input name="p_comptel1" type="text" size="7" dataType="integer" dispName="회사 전화번호" isNull="N" lenCheck="3" maxLength="3" value="<%=box.getString("p_comptel1")%>" style="height:20px"/> -
						<input name="p_comptel2" type="text" size="7" dataType="integer" dispName="회사 전화번호" isNull="N" lenCheck="4" maxLength="4" value="<%=box.getString("p_comptel2")%>" style="height:20px"/> - 
						<input name="p_comptel3" type="text" size="7" dataType="integer" dispName="회사 전화번호" isNull="N" lenCheck="4" maxLength="4" value="<%=box.getString("p_comptel3")%>" style="height:20px"/>
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">내선 전화번호</th>
					<td style="padding-left:5px;" >
						<input name="p_tel_line" type="text" size="20" dataType="integer" dispName="회사 전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=box.getString("p_tel_line")%>" style="height:20px"/>					
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">이메일<img src="/images/common/icon_point.gif" alt="중요" /></th>
					<td style="padding-left:5px;">
						<input name="p_email1" type="text" size="20" dispName="이메일" isNull="Y" lenCheck="25" maxLength="25" value="<%=box.getString("p_email1") %>" style="height:20px" /> @
						<input name="p_email2" type="text" size="20" dispName="이메일" isNull="Y" lenCheck="24" maxLength="24" value="<%=box.getString("p_email2") %>" style="height:20px" />
					</td>
				</tr>
<%	if ( v_hgrcode.equals("0") ) { %>				
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="50" bgcolor="#f4f4f4">집주소</th>
					<td style="padding-left:5px;">
						<% if( box.getString("p_post2") == null || box.getString("p_post2").equals("") ){ %>
							<input name="p_post1" type="text" size="7" dataType="integer" dispName="우편번호" isNull="Y" lenCheck="5" maxLength="5" value="<%=box.getString("p_post1")%>" style="height:20px" readonly="readonly"/>
							<input name="p_post2" type="hidden" dispName="우편번호" value="<%=box.getString("p_post2")%>" />
						<% } else { %>
							<input name="p_post1" type="text" size="7" dataType="integer" dispName="우편번호" isNull="Y" value="<%=box.getString("p_post1")%>" style="height:20px" readonly="readonly"/> -
							<input name="p_post2" type="text" size="7" dataType="integer" dispName="우편번호" value="<%=box.getString("p_post2")%>" style="height:20px" readonly="readonly"/>
						<% } %>
						<a href="#none" onclick="searchZipCode('home')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a><br/>
						<input name="p_addr" type="text" size="80" dispName="집주소" isNull="Y" lenCheck="1000" maxLength="1000" value="<%=box.getString("p_addr") %>" style="height:20px" />
					</td>
				</tr>
<%	} %>				
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				</table>
			</div>
 
			<div><!-- 배송상품 및 배송지 정보확인 -->
				<table width="680" summary="회원가입폼" border="0" class="" cellspacing="0">
				<colgroup>
					<col width="140" />
					<col width="540" />
				</colgroup>
				<tr><td style="padding:20px 0 10px 0;"><img src="/images/common/join_label02.gif" alt="기본정보" /></td></tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="50" bgcolor="#f4f4f4">배송주소</th>
					<td style="padding-left:5px;">
						<% if( box.getString("p_rcvrzipcode2") == null || box.getString("p_rcvrzipcode2").equals("") ){ %>
							<input name="p_rcvrzipcode1" type="text" size="7" dataType="integer" dispName="우편번호" isNull="Y" lenCheck="5" maxLength="5" value="<%=box.getString("p_rcvrzipcode1")%>" style="height:20px" readonly="readonly"/>
							<input name="p_rcvrzipcode2" type="hidden" dispName="우편번호" value="<%=box.getString("p_rcvrzipcode2")%>" />
						<% } else { %>
							<input name="p_rcvrzipcode1" type="text" size="7" dataType="integer" dispName="우편번호" isNull="Y" maxLength="5" value="<%=box.getString("p_rcvrzipcode1")%>" style="height:20px" readonly="readonly"/> -
							<input name="p_rcvrzipcode2" type="text" size="7" dataType="integer" dispName="우편번호" value="<%=box.getString("p_rcvrzipcode2")%>" style="height:20px" readonly="readonly"/>
						<% } %>
						<a href="#none" onclick="searchZipCode('recv')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a><br/>
						<input name="p_rcvraddr" type="text" size="80" dispName="배송주소" isNull="Y" lenCheck="1000" maxLength="1000" value="<%=box.getString("p_rcvraddr") %>" style="height:20px" />							
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">전화번호</th>
					<td style="padding-left:5px;">
						<input name="p_rcvrtel1" type="text" size="7" dataType="integer" dispName="전화번호" isNull="Y" lenCheck="3" maxLength="3" value="<%=box.getString("p_rcvrtel1")%>" style="height:20px"/> -
						<input name="p_rcvrtel2" type="text" size="7" dataType="integer" dispName="전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=box.getString("p_rcvrtel2")%>" style="height:20px"/> - 
						<input name="p_rcvrtel3" type="text" size="7" dataType="integer" dispName="전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=box.getString("p_rcvrtel3")%>" style="height:20px"/>
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">핸드폰번호</th>
					<td style="padding-left:5px;">
						<input name="p_rcvrmobile1" type="text" size="7" dataType="integer" dispName="핸드폰번호" isNull="Y" lenCheck="3" maxLength="3" value="<%=box.getString("p_rcvrmobile1")%>" style="height:20px"/> -
						<input name="p_rcvrmobile2" type="text" size="7" dataType="integer" dispName="핸드폰번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=box.getString("p_rcvrmobile2")%>" style="height:20px"/> - 
						<input name="p_rcvrmobile3" type="text" size="7" dataType="integer" dispName="핸드폰번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=box.getString("p_rcvrmobile3")%>" style="height:20px"/>
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">배송메시지</th>
					<td style="padding-left:5px;">
						<input name="p_recvmsg" type="text" size="80" dispName="배송메시지" isNull="Y" lenCheck="2000" maxLength="2000" value="<%=box.getString("p_recvmsg") %>" style="height:20px" />
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				</table>
			</div>

			<!-- 버튼 -->
			<table width="690" cellpadding="0" cellspacing="0" style="margin-top:10px;">
			<tr>
				<td align="right">
				<a href="#none" onclick="writeMember()"><img src="/images/common/btn_member_join.gif" alt="회원가입" /></a> <a href="#none"><img src="/images/common/btn_member_join_cancel.gif" alt="회원가입취소" onclick="window.close();"/></a></td>
			</tr>
			<tr><td height="20px"></td></tr>
			</table>
			
		<!-- //Page Contents -->
	</div>
</form>
</body>
</html>