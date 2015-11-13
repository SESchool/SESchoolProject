<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="/tags/fm_taglib" prefix="fmtag" %>
<%@ page import ="java.util.ArrayList"%>
<%@ page import ="java.util.LinkedList"%>
<%@ page import ="java.util.HashMap"%>
<%@ page import ="com.sinc.framework.Constants"%>
<%@ page import ="com.sinc.framework.util.StringUtil"%>
<%@ page import ="com.sinc.framework.util.FileUtil"%>
<%@ page import ="com.sinc.framework.util.DateTimeUtil"%>
<%@ page import ="com.sinc.common.CommonUtil"%>
<%@ page import ="com.sinc.framework.data.Box"%>
<%@ taglib uri="/tags/fm_taglib" prefix="fmtag" %>
<%@ page import ="com.sinc.framework.data.DataSet"%>
<% 
	String CONTEXTPATH = request.getContextPath();
	Box box = (Box)request.getAttribute("BOX");
	String G_HGRCODE = box.getStringDefault("s_hgrcode","0");
	String G_TMPL = box.getString("s_tmpl");
	String G_USERID = box.getString("s_userid");
	String G_NAME = box.getString("s_name"); 
	String G_GADMIN = box.getString("s_gadmin");
    String G_MAINMENUID = box.getStringDefault("s_mainmenuid","1");
    String G_MENUID = box.getStringDefault("s_menuid","1");   
    String G_MAINMENUNAVI = box.getString("s_mainmenunavi");    
    String G_MENUNAVI = box.getString("s_menunavi");  
    String G_MENUORDER = box.getString("s_menuorder");
    String G_IMGPATH = G_MAINMENUID;
    String PROTECTSTR = "";
    String PAGETITLE = "";   
%> 
<%
	//String v_hgrcode = box.getString("s_hgrcode");
	//ArrayList compList = (ArrayList)box.getObject("CompList");
	
	String v_onoff = box.getStringDefault("p_onoff","ALL");
	String v_hgrcode = box.getString("s_hgrcode");
	String v_userid = box.getString("s_userid");
	
	Box ds2 = (Box)box.getObject("MemberInfo"); //학습자개인정보
    String v_usergubun = ds2.getString("USERGUBUN"); 
	boolean isRND = (box.getString("s_usergubun").equals("RK") || box.getString("s_usergubun").equals("RH")) ? true : false;

	String[] v_hometel_temp = ds2.getString("HOMETEL").split("-");
	String[] v_hometel = {"","",""};
	if(v_hometel_temp.length==3) v_hometel = v_hometel_temp;
	
	String[] v_comptel_temp = ds2.getString("COMPTEL").split("-");
	String[] v_comptel = {"","",""};
	if(v_comptel_temp.length==3) v_comptel = v_comptel_temp;
	
	String[] v_handphone_temp = ds2.getString("HANDPHONE").split("-");
	String[] v_handphone = {"","",""};
	if(v_handphone_temp.length==3) v_handphone = v_handphone_temp;
	
	String[] v_email_temp = ds2.getString("EMAIL").split("@");
	String[] v_email = {"",""};
	if(v_email_temp.length==2) v_email = v_email_temp;	
	
	
	String v_prefix = ds2.getString("PREFIX");
	
	v_userid = ds2.getString("USERID");
	if(v_prefix.length()>0) v_userid = v_userid.replaceFirst(v_prefix,""); //id에서 prefix를 뗀다.	
	
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
<title>::: 무역아카데미 트레이드캠퍼스 :::</title>
<link type="text/css" rel="stylesheet" href="/css/front/template1/import.css" />
<fmtag:jscommon />
<script type="text/javascript">
<%	if ( !box.getString("MSG").equals("") ) { %>
	alert ( "box : <%=box.getString("MSG")%>" );
<%	} %>
/*
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
*/
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
		
		//if ( !validate(f) ) return;
		if ( !validateEtc(f) ) return;
		
		f.action = "/front/Member.do?cmd=selfConfirmMemberUpdatePopup";
		f.cmd.value = "selfConfirmMemberUpdatePopup";
		f.method = "post";

		f.submit();
		f.target = "";
	}
	
	function validateEtc(f) {
		
		var regExp = "";

		// 아이디 중복체크
		if ( f.idDuplicateCheck.value == "N" ) {
			alert ( "아이디 중복체크를 해주십시요." );
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

	function checkNumber(obj){
		if(isNaN(obj.value)){
			alert("숫자를 입력해주세요.");
			obj.value = "";
		}
	}	

	function initWin(){		 
	//	 window.moveTo(500,0);
		 window.resizeTo(760,980);
		 document.form1.p_userid.focus();
	}	

	function setHomeAddr(){
		
		$("p_rcvraddr").setValue($("p_addr").getValue());
		$("p_rcvrzipcode1").setValue($("p_post1").getValue());
		$("p_rcvrzipcode2").setValue($("p_post2").getValue());		    
		$("p_rcvrtel1").setValue($("p_hometel1").getValue());
		$("p_rcvrtel2").setValue($("p_hometel2").getValue());
		$("p_rcvrtel3").setValue($("p_hometel3").getValue());           
		$("p_rcvrmobile1").setValue($("p_handphone1").getValue());
		$("p_rcvrmobile2").setValue($("p_handphone2").getValue());
		$("p_rcvrmobile3").setValue($("p_handphone3").getValue());

	}

    function resetAddr(){
        
		$("p_rcvraddr").setValue("");
		$("p_rcvrzipcode1").setValue("");
		$("p_rcvrzipcode2").setValue("");
		$("p_rcvrtel1").setValue("");
		$("p_rcvrtel2").setValue("");
		$("p_rcvrtel3").setValue("");           
		$("p_rcvrmobile1").setValue("");
		$("p_rcvrmobile2").setValue("");
		$("p_rcvrmobile3").setValue("");
		
    }
    	
</script>
</head>
<body style="margin:5px 0px 0px 21px" onload="initWin()">
<form name="form1" action="/front/Member.do?cmd=writeMember" method="post" onSubmit="return false;">
<input type="hidden" name="cmd" value="writeMember" />
<input type="hidden" name="p_hgrcode" value="<%=v_hgrcode %>">
<input type="hidden" name="p_resno" value="<%=ds2.getString("RESNO") %>"/>
<input type="hidden" name="idDuplicateCheck" value="N"/>
<input type="hidden" name="p_comp" value="<%=ds2.getString("COMP") %>">
	<div class="contents">
<table width="690" cellpadding="0" cellspacing="0" style="margin-top:17px;">
			<tr>
				<td width="15"><img src="/images/template1/common/bullet_title.gif" alt="타이틀불릿" /></td>
				<td>
					<img src="/images/template1/title/pagetitle10.gif" alt="사이트맵 타이틀" /></td>
			</tr>
			<tr><td height="15"></td></tr>
			</table>
			<!-- Page Contents -->
			<table width="690" border="0" cellpadding="0" cellspacing="0">
			<tr><td style="padding:0 0 5px 0;"><img src="/images/common/04_mypage_label13.gif" alt="필수정보" /></td></tr>			
			<tr><td>1. 회원아이디는 공백을 허용하지 않습니다.</br>
2. 회원 아이디는 영문과 숫자로만 가능 합니다.<font color=blue>(4자리 이상)</font></br>
3. 비밀번호는 영문 또는 영문/숫자 조합으로 8자 이상 등록이 가능합니다</br>
4. 비밀번호는 연속된 숫자 또는 알파벳 3자 이상 사용 불가합니다.</br>
5. 비밀번호내에 아이디가 포함되어 있으면 안됩니다.</br></td></tr>		
			</table>
 
			<div><!-- 회원인증폼 -->
				<table width="680" summary="회원인증폼" border="0" class="" cellspacing="0">
				<colgroup>
					<col width="140" />
					<col width="540" />
				</colgroup>
				<tr><td style="padding:10px 0 10px 0;"><img src="/images/common/04_mypage_label10.gif" alt="기본정보" /></td></tr>
				<tr><td height="2" bgcolor="#252525"></td><td bgcolor="#b7b7b7"></td></tr>				
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">아이디<span style="color:#a0410d; padding-right:5px;">*</span></th>
					<td style="padding-left:5px;">
						<input name="p_userid" type="text" size="20" dispName="아이디" isNull="N" lenCheck="13" maxLength="13" value="<%//=v_userid%>" style="height:20px"/>
						<a href="#" onClick="userIdCheck()"><img src="/images/common/btn_double_check01.gif" align="absmiddle" alt="중복확인" /></a>
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">비밀번호<span style="color:#a0410d; padding-right:5px;">*</span></th>
					<td style="padding-left:5px;">
						<input name="p_pwd" type="password" size="20" dispName="비밀번호" isNull="N" lenCheck="20" maxLength="20" value="<%//=ds2.getString("PWD") %>" style="height:20px"/>
						(8자 이상의 영문, 숫자 조합)
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">비밀번호 확인<span style="color:#a0410d; padding-right:5px;">*</span></th>
					<td style="padding-left:5px;">
						<input name="p_pwdconfirm" type="password" size="20" dispName="비밀번호확인" isNull="N" lenCheck="12" maxLength="12" value="<%//=ds2.getString("PWD") %>" style="height:20px"/>
						(비밀번호를 한번 더 입력해 주세요)
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">이름<span style="color:#a0410d; padding-right:5px;">*</span></th>
					<td style="padding-left:5px;">
						<input name="p_name" type="text" size="20" dispName="이름" isNull="N" lenCheck="30" maxLength="30" value="<%=ds2.getString("NAME") %>"  style="height:20px" readonly />
					</td>
				</tr>				
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">회사</th>
					<td style="padding-left:5px;">
						<%=ds2.getString("COMPNM") %>
					</td>
				</tr>
 
 
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">부서</th>
					<td style="padding-left:5px;">
						<!-- <input name="p_deptnam" type="text" size="20" dispName="부서" isNull="Y" lenCheck="60" maxLength="60" value="" style="height:20px" />-->
						<%=ds2.getString("DEPTNAM") %>
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">직급</th>
					<td style="padding-left:5px;" >
						<!-- <input name="p_jikupnm" type="text" size="20" dispName="직급" isNull="Y" lenCheck="50" maxLength="50" value="" style="height:20px" /> -->
						<%=ds2.getString("JIKUPNM") %>
					</td>
				</tr>
			
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">자택 전화번호</th>
					<td style="padding-left:5px;">
						<input name="p_hometel1" type="text" size="7" dataType="integer" dispName="자택 전화번호" isNull="Y" lenCheck="3" maxLength="3" value="<%=v_hometel[0] %>" onkeyup="checkNumber(this);" style="height:20px"/> -
						<input name="p_hometel2" type="text" size="7" dataType="integer" dispName="자택 전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=v_hometel[1] %>" onkeyup="checkNumber(this);" style="height:20px"/> - 
						<input name="p_hometel3" type="text" size="7" dataType="integer" dispName="자택 전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=v_hometel[2] %>" onkeyup="checkNumber(this);" style="height:20px"/>
					</td>
				</tr>
 
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">핸드폰번호<span style="color:#a0410d; padding-right:5px;">*</span></th>
					<td style="padding-left:5px;">
						<input name="p_handphone1" type="text" size="7" dataType="integer" dispName="핸드폰번호" isNull="N" lenCheck="3" maxLength="3" value="<%=v_handphone[0]%>" onkeyup="checkNumber(this);" style="height:20px"/> -
						<input name="p_handphone2" type="text" size="7" dataType="integer" dispName="핸드폰번호" isNull="N" lenCheck="4" maxLength="4" value="<%=v_handphone[1]%>" onkeyup="checkNumber(this);" style="height:20px"/> - 
						<input name="p_handphone3" type="text" size="7" dataType="integer" dispName="핸드폰번호" isNull="N" lenCheck="4" maxLength="4" value="<%=v_handphone[2]%>" onkeyup="checkNumber(this);" style="height:20px"/>
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">회사 전화번호<span style="color:#a0410d; padding-right:5px;">*</span></th>
					<td style="padding-left:5px;">
						<input name="p_comptel1" type="text" size="7" dataType="integer" dispName="회사 전화번호" isNull="N" lenCheck="3" maxLength="3" value="<%=v_comptel[0] %>" onkeyup="checkNumber(this);" style="height:20px"/> -
						<input name="p_comptel2" type="text" size="7" dataType="integer" dispName="회사 전화번호" isNull="N" lenCheck="4" maxLength="4" value="<%=v_comptel[1] %>" onkeyup="checkNumber(this);" style="height:20px"/> - 
						<input name="p_comptel3" type="text" size="7" dataType="integer" dispName="회사 전화번호" isNull="N" lenCheck="4" maxLength="4" value="<%=v_comptel[2] %>" onkeyup="checkNumber(this);" style="height:20px"/>
					</td>
				</tr>
<!-- 				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">내선 전화번호</th>
					<td style="padding-left:5px;" >
						<input name="p_tel_line" type="text" size="20" dataType="integer" dispName="회사 전화번호" isNull="Y" lenCheck="4" maxLength="4" value="" style="height:20px"/>					
					</td>
				</tr>-->
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">이메일<span style="color:#a0410d; padding-right:5px;">*</span></th>
					<td style="padding-left:5px;">
						<input name="p_email1" type="text" size="20" dispName="이메일" isNull="Y" lenCheck="25" maxLength="25" value="<%=v_email[0] %>" style="height:20px" /> @
						<input name="p_email2" type="text" size="20" dispName="이메일" isNull="Y" lenCheck="24" maxLength="24" value="<%=v_email[1] %>" style="height:20px" />
					</td>
				</tr>
				
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="50" bgcolor="#f4f4f4">집주소</th>
					<td style="padding-left:5px;">
						<% if( ds2.getString("POST2") == null || ds2.getString("POST2").equals("")){ %>
							<input name="p_post1" type="text" size="7" dataType="integer" dispName="우편번호" isNull="Y" lenCheck="5" maxLength="5" value="<%=ds2.getString("POST1") %>" onkeyup="checkNumber(this);" style="height:20px" readonly="readonly"/>
							<input name="p_post2" type="hidden" dispName="우편번호" value="<%=ds2.getString("POST2") %>" />
						<% } else { %>
							<input name="p_post1" type="text" size="7" dataType="integer" dispName="우편번호" isNull="Y" value="<%=ds2.getString("POST1") %>" onkeyup="checkNumber(this);" style="height:20px" readonly="readonly"/> -
							<input name="p_post2" type="text" size="7" dataType="integer" dispName="우편번호" value="<%=ds2.getString("POST2") %>" onkeyup="checkNumber(this);" style="height:20px" readonly="readonly"/>
						<% } %>
						<a href="#none" onclick="searchZipCode('home')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a><br/>
						<input name="p_addr" type="text" size="80" dispName="집주소" isNull="Y" lenCheck="1000" maxLength="1000" value="<%=ds2.getString("ADDR") %>" style="height:20px" />
					</td>
				</tr>
				
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				</table>
			</div>
 
 
			<div><!-- 배송상품 및 배송지 정보확인 -->
				<table width="680" summary="회원인증폼" border="0" class="" cellspacing="0">
				<colgroup>
					<col width="140" />
					<col width="540" />
				</colgroup>
				<tr>
				   <td style="padding:20px 0 10px 0;"><img src="/images/common/04_mypage_label11.gif" alt="배송상품 및 배송지 정보확인" /></td>
				   <td style="padding:20px 0 10px 0;" align="right"><input type="radio" name="checkAddr"  style="border: none;" onClick="setHomeAddr()">집주소 
				   <input type="radio" name="checkAddr" style="border: none;" onClick="resetAddr()">새로입력</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="50" bgcolor="#f4f4f4">배송주소</th>
					<td style="padding-left:5px;">
		<%
							String v_rcvzipcode = ds2.getString("RCVRZIPCODE");
							String v_rcvzipcode1 = "", v_rcvzipcode2 = "";
							if(v_rcvzipcode.length() > 5){
								if( v_rcvzipcode.contains("-")){
									v_rcvzipcode1 = v_rcvzipcode.substring(0, v_rcvzipcode.indexOf("-"));  
									v_rcvzipcode2 = v_rcvzipcode.substring(v_rcvzipcode.indexOf("-")+1, v_rcvzipcode.length());
								} else {
									v_rcvzipcode1 = v_rcvzipcode.substring(0,3);  
									v_rcvzipcode2 = v_rcvzipcode.substring(3,v_rcvzipcode.length());
								}
							}else v_rcvzipcode1 = v_rcvzipcode;
		%>					
						<% if( v_rcvzipcode2 == null || v_rcvzipcode2.equals("")){ %>
							<input name="p_rcvrzipcode1" type="text" size="7" dataType="integer" dispName="우편번호" isNull="Y" lenCheck="5" maxLength="5" value="<%=v_rcvzipcode1 %>" onkeyup="checkNumber(this);" style="height:20px" readonly="readonly"/>
							<input name="p_rcvrzipcode2" type="hidden" dispName="우편번호" value="<%=v_rcvzipcode2 %>" />
						<% } else { %>
							<input name="p_rcvrzipcode1" type="text" size="7" dataType="integer" dispName="우편번호" isNull="Y" value="<%=v_rcvzipcode1 %>" onkeyup="checkNumber(this);" style="height:20px" readonly="readonly"/> -
							<input name="p_rcvrzipcode2" type="text" size="7" dataType="integer" dispName="우편번호" isNull="Y" value="<%=v_rcvzipcode2 %>" onkeyup="checkNumber(this);" style="height:20px" readonly="readonly"/>
						<% } %>
						
						<a href="#none" onclick="searchZipCode('recv')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a><br/>
						<input name="p_rcvraddr" type="text" size="80" dispName="배송주소" isNull="Y" lenCheck="1000" maxLength="1000" value="<%=ds2.getString("RCVRADDR") %>" style="height:20px" />							
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">전화번호</th>
					<td style="padding-left:5px;">
		<%
					String[] v_rcvrtel_temp = ds2.getString("RCVRTEL").split("-");
					String[] v_rcvrtel = {"","",""};
					if(v_rcvrtel_temp.length==3) v_rcvrtel = v_rcvrtel_temp;
		%>					
						<input name="p_rcvrtel1" type="text" size="7" dataType="integer" dispName="전화번호" isNull="Y" lenCheck="3" maxLength="3" value="<%=v_rcvrtel[0] %>" onkeyup="checkNumber(this);" style="height:20px"/> -
						<input name="p_rcvrtel2" type="text" size="7" dataType="integer" dispName="전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=v_rcvrtel[1] %>" onkeyup="checkNumber(this);" style="height:20px"/> - 
						<input name="p_rcvrtel3" type="text" size="7" dataType="integer" dispName="전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=v_rcvrtel[2] %>" onkeyup="checkNumber(this);" style="height:20px"/>
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">핸드폰번호</th>
					<td style="padding-left:5px;">
		<%
					String[] v_rcvrmobile_temp = ds2.getString("RCVRMOBILE").split("-");
					String[] v_rcvrmobile = {"","",""};
					if(v_rcvrmobile_temp.length==3) v_rcvrmobile = v_rcvrmobile_temp;
		%>					
						<input name="p_rcvrmobile1" type="text" size="7" dataType="integer" dispName="핸드폰번호" isNull="Y" lenCheck="3" maxLength="3" value="<%=v_rcvrmobile[0] %>" onkeyup="checkNumber(this);" style="height:20px"/> -
						<input name="p_rcvrmobile2" type="text" size="7" dataType="integer" dispName="핸드폰번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=v_rcvrmobile[1] %>" onkeyup="checkNumber(this);" style="height:20px"/> - 
						<input name="p_rcvrmobile3" type="text" size="7" dataType="integer" dispName="핸드폰번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=v_rcvrmobile[2] %>" onkeyup="checkNumber(this);" style="height:20px"/>
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				<tr>
					<th align="left" style="padding-left:20px;" height="33" bgcolor="#f4f4f4">배송메시지</th>
					<td style="padding-left:5px;">
						<input name="p_recvmsg" type="text" size="80" dispName="배송메시지" isNull="Y" lenCheck="2000" maxLength="2000" value="<%=ds2.getString("RCVRMSG") %>" style="height:20px" />
					</td>
				</tr>
				<tr><td height="1" colspan="2" bgcolor="#b7b7b7"></td></tr>
				</table>
			</div>
 
			<!-- 버튼 -->
			<table width="690" cellpadding="0" cellspacing="0" style="margin-top:10px;">
			<tr>
				<td align="right">
				<a href="#none" onclick="writeMember()"><img src="/images/common/btn_member_join.gif" alt="회원인증" /></a>&nbsp;&nbsp;
				<a href="#none" onclick="window.location.reload();"><img src="/images/common/btn_member_join_cancel.gif" alt="회원인증취소" /></a>&nbsp;&nbsp;
				<a href="#none" onclick="self.close();"><img src="/images/common/btn_close.gif" alt="닫기" /></a></td>
			</tr>
			<tr><td height="20px"></td></tr>
			</table>
			
		<!-- //Page Contents -->
 
		
<!-- 푸터 -->
		<!-- 공백 -->
		<table width="660" cellpadding="0" cellspacing="0" class="mar_top_20">
		<tr><td></td></tr>
		</table>
	</td>
</tr>
</table>
</body>
</html>
<!-- // -->

