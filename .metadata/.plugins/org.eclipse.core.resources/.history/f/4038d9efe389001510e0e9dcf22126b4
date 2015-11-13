<%--
 * @(#)login Template
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * T_LMS_MEMBER 테이블 List Template.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2010. 01. 30.  bgcho       Initial Release
 ************************************************
--%>
<%@ page contentType="text/html;charset=UTF-8" 		%>
<%@ include file = "/jsp/front/common/commonBasicInc.jsp"	%>
<jsp:include page="/jsp/front/common/commonLoginCheck.jsp" flush="true"/>
<script language="Javascript" src="/js/common/util.js"></script>
<script language="Javascript" src="/js/common/calendar.js"></script>
<!-- 안심체크 결과 시작 -->

<%
//	String usergubun = request.getParameter("p_usergubun");
System.out.println("NATIONALINFO");
System.out.println(session.getAttribute("NATIONALINFO"));
	String usergubun =(String)session.getAttribute("NATIONALINFO"); 
	
	String cert_gb = null;
	String nc_name = null;
	String vnumber = null;
	String dupinfo = null;
	String s_ipin_ci = null;
	String resno = null;
	String kita_resno = null;
	String sex = null;
	String year = null;
	String month = null;
	String day = null;
	
		String session_sRequestResult = (String)session.getAttribute("RETURN_RESULT");
		if(!"TRUE".equals(session_sRequestResult)) {
			out.println("<script>alert(\'실명인증이 필요합니다.\');</script>");
			out.println("<script>history.go(-1);</script>");
		}
		nc_name = (String)session.getAttribute("NC_NAME");
		vnumber = (String)session.getAttribute("VNUMBER");
		cert_gb = (String)session.getAttribute("CERT_GB");
		year = ((String)session.getAttribute("BIRTHDATE")).substring(0, 4);
		month = ((String)session.getAttribute("BIRTHDATE")).substring(4, 6);
		day = ((String)session.getAttribute("BIRTHDATE")).substring(6, 8);
		dupinfo = (String)session.getAttribute("DUPINFO");
		s_ipin_ci = (String)session.getAttribute("NC_IPIN_CI");		
		
			sex = (String)session.getAttribute("GENDERCODE");		//넘어온 session에 있는 값 남자:1, 여자:0
			/* 
				sex
					1 : 국내 2000년 이전 남자
					2 : 국내 2000년 이전 여자
					3 : 국내 2000년 이후 남자
					4 : 국내 2000년 이후 여자
					
					5 : 외국 2000년 이전 남자
					6 : 외국 2000년 이전 여자
					7 : 외국 2000년 이후 남자
					8 : 외국 2000년 이후 여자					
			 */
			 // session.getAttribute("NATIONALINFO") : 0=내국인, 1=외국인
			 if(usergubun.equals("0")){	//내국인
					usergubun="KC";	//일반
					if(Integer.parseInt(year)<2000){
						if(sex.equals("1")) sex="1";
						else sex="2"; 
					}else{
						if(sex.equals("1")) sex="3";
						else sex="4";
					}
				}else{	//외국인
					usergubun="KF";//국내거주외국인
					if(Integer.parseInt(year)<2000){
						if(sex.equals("1")) sex="5";
						else sex="6"; 
					}else{
						if(sex.equals("1")) sex="7";
						else sex="8";
					}
				}
			 
			// 무역아카데미에 insert될 주민번호 형식
			resno = ((String)session.getAttribute("BIRTHDATE")).substring(2, 8) + sex + "000000";
			// kita.net에 insert될 주민번호 형식
			kita_resno = ((String)session.getAttribute("BIRTHDATE")).substring(2, 8) + "-" + sex + "000000";
			
		
			if (sex.equals("0")) {
				sex = "F";	//여자
			}else{
				sex = "M";	//남자
			}
		
		/* System.out.println("성별코드 : " + sex);
		System.out.println("생일 : " + (String)session.getAttribute("BIRTHDATE"));
		System.out.println("생일 : " + ((String)session.getAttribute("BIRTHDATE")).substring(2, 8) );
		System.out.println("생일 : " + ((String)session.getAttribute("BIRTHDATE")).substring(0, 4) );
		System.out.println("생일 : " + ((String)session.getAttribute("BIRTHDATE")).substring(4, 6) );
		System.out.println("생일 : " + ((String)session.getAttribute("BIRTHDATE")).substring(6, 8) ); */
		
		
%>
<!-- 안심체크 결과 끝 -->
<script type="text/javascript">
	var mainElements ;
	var subElements ;
	function isValid (arg) {
		var regExp ; 
		switch (arg) {
			case 'POP_IDCHECK' :
				if ( ncCom_Empty( mainElements["p_userid"].value) ) return ncCom_ErrField( mainElements["p_userid"]) ; 
				var  userID =  mainElements["p_userid"].value ;
				if (userID.substring(0, 1) >= 'A' && userID.substring(0, 1) <= 'Z') {
					return ncCom_ErrField( mainElements["p_userid"], "아이디는 대문자로 시작할 수 없습니다..");
				}
				regExp = /^[A-Za-z0-9]{6,10}$/;
				if ( !regExp.test(userID) ) {
					return ncCom_ErrField( mainElements["p_userid"], "아이디는 숫자와 영문 이외의 문자를 사용할 수 없으며 6자 이상 입니다.");
				}
				
				break;
			case 'C' :
				if (  mainElements["idDuplicateCheck"].value  == "N" ) {
					alert ( "아이디 중복체크를 해 주십시요" );
					return false ;
				}
				var  userID =  mainElements["p_userid"].value ;
				if (userID.substring(0, 1) >= 'A' && userID.substring(0, 1) <= 'Z') {
					return ncCom_ErrField( mainElements["p_userid"], "아이디는 대문자로 시작할 수 없습니다..");
				}
				regExp = /^[A-Za-z0-9]{6,10}$/;
				if ( !regExp.test(userID) ) {
					return ncCom_ErrField( mainElements["p_userid"], "아이디는 숫자와 영문 이외의 문자를 사용할 수 없으며 6자 이상 입니다.");
				}
				
				// 2. 연속된 숫자 또는 알파벳 3자 이상 사용 불가합니다.
				var ch1, ch2, ch3;
				var v_pwd = mainElements["p_pwd"].value;
				if ( ncCom_Empty( mainElements["p_pwd"].value) ) return ncCom_ErrField( mainElements["p_pwd"], "비밀번호를 입력하세요") ; 
				if ( ncCom_Empty( mainElements["p_pwdconfirm"].value) ) return ncCom_ErrField( mainElements["p_pwdconfirm"], "비밀번호확인을 입력하세요") ;
				for ( var i=2; i < v_pwd.length; i++ ) {
					ch1 = v_pwd.charCodeAt(i-2);
					ch2 = v_pwd.charCodeAt(i-1);
					ch3 = v_pwd.charCodeAt(i-0);
					if ( ch1 == ch2 && ch1 == ch3 ) {
						return ncCom_ErrField( mainElements["p_pwd"], "비밀번호는 연속된 3개의 문자를 사용할수 없습니다.");
					}
				}
				
				if (v_pwd.length < 8) {
					return ncCom_ErrField( mainElements["p_pwd"], "비밀번호는 8자리 이상 입니다.");
				}
				
				if (!v_pwd.match(/([a-zA-Z].*[0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([0-9].*[a-zA-Z].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[0-9].*[a-zA-Z])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z].*[0-9])|([a-zA-Z].*[!,@,#,$,%,^,&,*,?,_,~].*[0-9])|([0-9].*[!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z])/)) {
					return ncCom_ErrField( mainElements["p_pwd"], "비밀번호는 영문자, 숫자, 특수문자를 포함해야 합니다.");	
				}
				
				// 3. 비밀번호내에 아이디가 포함되어 있으면 안됩니다.
				var arrTmp = v_pwd.split(userID);
				if ( arrTmp.length > 1 ) {
					return ncCom_ErrField( mainElements["p_pwd"], "비밀번호내에 아이디가 포함되어 있으면 안됩니다.");
				}
				
				// 비밀번호 확인 검사
				if (mainElements["p_pwdconfirm"].value  != mainElements["p_pwd"].value ) {
					return ncCom_ErrField( mainElements["p_pwdconfirm"], "비밀번호와 비밀번호 확인 값이 서로 다릅니다.");
				}	
				if ( ncCom_Empty( mainElements["p_name"].value) ) return ncCom_ErrField( mainElements["p_name"]) ; 		
				
				regExp = /0[0-9]{1,2}-[0-9]{3,4}-[0-9]{4}/;
			
				if ( !regExp.test(mainElements["p_handphone1"].value+"-"+mainElements["p_handphone2"].value+"-"+mainElements["p_handphone3"].value) ) {
					return ncCom_ErrField( mainElements["p_handphone1"], "핸드폰번호 형식이 잘못되었습니다.") ; 
				}
				
				if ( !chkEmail(mainElements["emailID"].value +"@"+ mainElements["emailTail"].value) ) {
					return ncCom_ErrField( mainElements["emailID"], "메일주소가 정확하지 않습니다.") ;
				}
				if ( ncCom_Empty( mainElements["emailID"].value) ) return ncCom_ErrField( mainElements["emailID"], "이메일 을 입력하세요") ; 
				if ( ncCom_Empty( mainElements["emailTail"].value) ) return ncCom_ErrField( mainElements["emailTail"], "이메일 을 입력하세요") ;
				if ( ncCom_Empty( mainElements["p_selpost1"].value) ) return ncCom_ErrField( mainElements["p_selpost1"], "주소를 입력하세요") ;
				if ( ncCom_Empty( mainElements["p_seladdr2"].value) ) return ncCom_ErrField( mainElements["p_seladdr2"], "상세 주소를 입력하세요") ;
								
				break; 
				
		}
		return true ;
				
	}
	function main(arg1) {
		switch (arg1) {
			case 'C' :
				if( !isValid(arg1) ) return ;
				if(!confirm("저장하시겠습니까?")) return ;
				
				mainElements["p_handphone"].value = mainElements["p_handphone1"].value +"-"+ mainElements["p_handphone2"].value +"-"+ mainElements["p_handphone3"].value ;
				if( mainElements["p_postgb"].value == "1" ) { //직장
					if( mainElements["p_seladdr2"].value == null || mainElements["p_seladdr2"].value == ""){	// 새로운 우편번호 형식
						mainElements["p_corpzip"].value = mainElements["p_selpost1"].value;
					} else {
						mainElements["p_corpzip"].value = mainElements["p_selpost1"].value + "-"+ mainElements["p_selpost2"].value;		// 기존의 우편번호 형식
					}
					mainElements["p_corpaddr1"].value = mainElements["p_seladdr1"].value ;
					mainElements["p_corpaddr2"].value = mainElements["p_seladdr2"].value;
					mainElements["p_post1"].value =  "" ;
					mainElements["p_post2"].value =  "";
					mainElements["p_addr"].value = "" ;
					mainElements["p_addr2"].value = "";
				}else {//자택
					mainElements["p_corpzip"].value = "";
					mainElements["p_corpaddr1"].value = "";
					mainElements["p_corpaddr2"].value = "";
					mainElements["p_post1"].value = mainElements["p_selpost1"].value ;
					mainElements["p_post2"].value =  mainElements["p_selpost2"].value;
					mainElements["p_addr"].value = mainElements["p_seladdr1"].value ;
					mainElements["p_addr2"].value = mainElements["p_seladdr2"].value;					
				}
				
				mainElements["p_email"].value = mainElements["emailID"].value +"@"+ mainElements["emailTail"].value ;
				mainElements["p_jobc_name"].value = mainElements["p_jobc_csenr"].options[ mainElements["p_jobc_csenr"].selectedIndex].text ;
				mainElements["cmd"].value = "btocJoinMemberWrite";
				mainElements["next"].value = "joinMemberResult";
				document.forms["form1"].target = "hiddenFrame";
				document.forms["form1"].action = "https://tradecampus.kita.net/front/Member.do?cmd=btocJoinMemberWrite";
				document.forms["form1"].submit();
				document.forms["form1"].target = "_self";
				
				break;
			case 'B' :
				document.forms["form2"].action = "/front/Member.do";
				document.forms["form2"].method = "post";
				subElements["cmd"].value = "joinMember";
				subElements["next"].value = "joinMemberPerson";
				document.forms["form2"].submit();
				break;
		}			
	}
	function pop(arg1, arg2) {
		switch (arg1) {
			case 'POP_IDCHECK' :
				if( !isValid(arg1) ) return ;
				//Center_Fixed_Popup2("", "popIdCheck", 420, 330, "no");
				
				var userid = mainElements["p_userid"].value
				Center_Fixed_Popup2("/jsp/front/common/member/id_check.jsp?userid="+userid, "popIdCheck", 420, 400, "no");
				//document.forms["form2"].action = "/jsp/front/common/member/idDuplicateCheckPopup.jsp";
				/*
				document.forms["form2"].action = "/front/Member.do";
				document.forms["form2"].method = "post";
				subElements["cmd"].value = "idDuplicateCheckPopup";
				subElements["p_userid"].value = mainElements["p_userid"].value;
				document.forms["form2"].target = "popIdCheck";
				document.forms["form2"].submit();
				document.forms["form2"].target = "_self";
				*/
				break;
			case 'POP_ZIP' :
				if (  mainElements["idDuplicateCheck"].value  == "N" ) {
					alert ( "아이디 중복체크를 먼저 해 주십시요" );
					return false ;
				}
				Center_Fixed_Popup2("", "popZip", 500, 500, "no"); 
				document.forms["form2"].action = "/front/Common.do";	
				document.forms["form2"].method = "post";
				subElements["cmd"].value = "selectZipCode";
				document.forms["form2"].target = "popZip";
				document.forms["form2"].submit();
				document.forms["form2"].target = "_self";
				document.domain = "tradecampus.kita.net";
				break;					
		}
	}

	function setZipCodeInfo(addr, zipcode) {
		mainElements["p_seladdr1"].value = addr ;
		/* if(zipcode.search('-') > -1){						// 기존의 우편주소, 두개의 텍스트란에 넣음
			mainElements["p_selpost1"].value = zipcode.substr(0, 3) ;
			mainElements["p_selpost2"].value = zipcode.substr(4, 7) ;	
		} else {
			mainElements["p_selpost1"].value = zipcode;		// 새로운 우편주소, 하나의 텍스트란에 넣음
			mainElements["p_selpost2"].value = "";
		} */
		mainElements["p_selpost1"].value = zipcode;		// 새로운 우편주소, 하나의 텍스트란에 넣음
		mainElements["p_selpost2"].value = "";
	}
	
	function setUserId(v_userid) {
		mainElements["p_userid"].value = v_userid ;
		mainElements["p_userid"].readOnly = true ;
		mainElements["idDuplicateCheck"].value = "Y" ;
	}
	
	// 재외국인 번호 체크
	function checkForeignerNo(juminNo1, juminNo2) {
		var sum = 0;
		var odd = 0;

		buf = new Array(13);
		var juminno = juminNo1 + juminNo2;

		for ( i = 0; i < 13; i++) {
			buf[i] = parseInt(juminno.charAt(i));
		}

		odd = buf[7]*10 + buf[8];

		if ( odd % 2 != 0 ) {
			return false;
		}

		if ( ( buf[11] != 6 ) && ( buf[11] != 7 ) && ( buf[11] != 8 ) && ( buf[11] != 9 ) ) {
			return false;
		}

		multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];

		for ( i = 0, sum = 0; i < 12; i++) {
			sum += ( buf[i] *= multipliers[i]);
		}

		sum = 11 - (sum%11);

		if ( sum >= 10 ) {
			sum -= 10;
		}

		sum += 2;

		if ( sum >= 10 ) {
			sum -= 10;
		}

		if ( sum != buf[12] ) {
			return false;
		}

		return true;
	}

	function setEmailTail(arg) {
		if(arg == "etc") {
			mainElements["emailTail"].value  = "" ;
			mainElements["emailTail"].readOnly =  false ;
			mainElements["emailTail"].focus();
		}else {
			mainElements["emailTail"].readOnly =  true ;
			mainElements["emailTail"].value  = arg ;
		}
	}	

	function chngReceive(arg) {
		if( arg == "M") {
			if ( mainElements["p_ismailing"][1].checked+""  == mainElements["p_prevnomailing"].value ) {
				return ;
			}else {
				 mainElements["p_prevnomailing"].value  =  mainElements["p_ismailing"][1].checked ;
			}
			
			if ( mainElements["p_ismailing"][1].checked == true) {
				alert("메일을 수신 거부하시면 학습진행시 독려등의 정보를 받지 못하여 불이익을 당하실 수 있습니다");
			}  
		}else {
			if ( mainElements["p_issms"][1].checked+""  == mainElements["p_prevnosms"].value ) {
				return ;
			}else {
				 mainElements["p_prevnosms"].value  =  mainElements["p_issms"][1].checked ;
			}			
			
			if ( mainElements["p_issms"][1].checked == true) {
				alert("SMS 수신을 거부하시면 학습진행시 독려등의 정보를 받지 못하여 불이익을 당하실 수 있습니다");
			}  			
		}
	}
	function DOC_LOAD() {
		mainElements = document.forms["form1"].elements;
		subElements = document.forms["form2"].elements;
		mainElements["p_userid"].focus();
	}	
	addLoadEvent(DOC_LOAD);
</script>
		<!--헤더부분 시작-->
				<form name = "form1" method="post" enctype="multipart/form-data">	
					<input type="hidden" name="cmd"  value = "" />
					<input type="hidden" name="next"  value = "" />				
					<input type="hidden" name="p_post1" value = "" />
					<input type="hidden" name="p_post2" value = "" />
					<input type="hidden" name="p_addr" value = "" /> 
					<input type="hidden" name="p_addr2" value = "" />
					<input type="hidden" name="p_corpzip" value = "" />
					<input type="hidden" name="p_corpaddr1" value = "" />
					<input type="hidden" name="p_corpaddr2" value = "" />
					<input type="hidden" name="p_email" value = "" />
					<input type="hidden" name="idDuplicateCheck" value = "N" />
					<input type="hidden" name="p_jobc_name" value = "" />
					<input type="hidden" name="p_resno" value = <%=resno %> />
					<input type="hidden" name="p_kita_resno" value = <%=kita_resno %> />
					<input type="hidden" name="p_usergubun" value = "<%=usergubun %>" />
					<input type="hidden" name="p_handphone" value = "" />
					<input type="hidden" name="p_prevnomailing" value = "false" />
					<input type="hidden" name="p_prevnosms" value = "false" />
					<input type="hidden" name="p_sex" value = "<%=sex%>" />

				<!-- 기본정보 -->
				<table width="700" cellpadding="0" cellspacing="0" style="margin-top:30px;">
				<tr>
					<td height="10"></td>
				</tr>
				<tr>
				    <td><img src="/images/template0/common/personal1_step2_label01.gif" width="335" height="16" /></td>
				</tr>
				<tr>
					<td height="10"></td>
				</tr>
				<tr><td height="2" bgcolor="#a7a7a7"></td></tr>
				<tr>
					<td>
						<table width="100%" cellpadding="0" cellspacing="0">
						<tr height="35">
							<td width="100"><img src="/images/template0/common/txt_join_name.gif" /></td>
							<td>
								<input type="text" readonly="readonly" name="p_name" value="<%=nc_name %>" style="width:200px;" class="form1" maxlength = "50" title = "이름을 입력하세요" />
							</td>
						</tr>
						<tr>
        					<td height="1" bgcolor="#ebebeb" colspan="2"></td>
      					</tr>
						<tr height="35">
							<td><img src="/images/template0/common/txt_join_id.gif" /> <img src="/images/template0/common/icon_pilsu.gif" hspace="5" /></td>
							<td>
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
            							<td width="205"><input type="text" name="p_userid" value=""  class="form2" style="width:200px;" maxlength = '10' title = "아이디를 입력하세요" /></td>
            							<td> <a href="#none" onClick="pop('POP_IDCHECK');"><img src="/images/template0/common/btn_idcheck1.gif" border="0" /></a></td>
          							</tr>
          						</table>
          					</td>
						</tr>
						<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						<tr height="35">
        					<td><img src="/images/template0/common/txt_join_pw.gif" /> <img src="/images/template0/common/icon_pilsu.gif" hspace="5" /></td>
        					<td><input type="password" name="p_pwd" value="" class="form2" style="width:200px;" maxlength = "8"  title = "비밀번호를 입력하세요" />        </td>
      					</tr>
      					<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
      					<tr height="35">
        					<td><img src="/images/template0/common/txt_join_pwchk.gif" /> <img src="/images/template0/common/icon_pilsu.gif" hspace="5" /></td>
        					<td><input type="password" name="p_pwdconfirm" value="" class="form2" style="width:200px;" maxlength = "8" title = "비밀번호 확인을 입력하세요" />        </td>
      					</tr>
      					<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
      					<tr height="35">
        					<td><img src="/images/template0/common/txt_join_birth.gif" /></td>
        					<td>
        						<table border="0" cellspacing="0" cellpadding="0">
          			  			<tr>
              						<td><input type="text" readonly="readonly" name="p_handphone22" value="<%=year %>" class="form1" style="width:60px;" maxlength = "4" title = "생년월일을 입력하세요" />
년
  										<input type="text" readonly="readonly" name="p_handphone23" value="<%=month %>" class="form1" style="width:60px;" maxlength = "4" title = "생년월일을 입력하세요" />
월
										<input type="text" readonly="readonly" name="p_handphone24" value="<%=day %>" class="form1" style="width:60px;" maxlength = "4" title = "생년월일을 입력하세요" />
일 
									</td>
									<td><img src="/images/template0/common/msg3.gif" width="146" height="13" hspace="5" /></td>
            					</tr>
          						</table>
          					</td>
      					</tr>
						<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						<tr height="35">
        					<td><img src="/images/template0/common/txt_join_mobile.gif" /> <img src="/images/template0/common/icon_pilsu.gif" hspace="5" /></td>
        					<td><select name="p_handphone1" class="form3" style="width:60px;">
          						<option value="010" selected="selected">010</option>
          						<option value="011" >011</option>
          						<option value="016" >016</option>
          						<option value="017" >017</option>
          						<option value="018" >018</option>
          						<option value="019" >019</option>
        						</select>
          						-
          						<input type="text" name="p_handphone2" value="" class="form2" style="width:60px;" maxlength = "4" title = "핸드폰번호를 입력하세요" />
          						-
          						<input type="text" name="p_handphone3" value="" class="form2" style="width:60px;" maxlength = "4" title = "핸드폰번호를 입력하세요" />        </td>
      					</tr>
						<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						
						<tr height="35">
       						<td><img src="/images/template0/common/txt_join_email.gif" /> <img src="/images/template0/common/icon_pilsu.gif" hspace="5" /></td>
        					<td><input type="text" name="emailID" value="" class="form2" style="width:100px;"  maxlength = "50"/>
          					@
          					<input type="text" name="emailTail" value="" class="form2" style="width:150px;"  maxlength = "50" readonly="readOnly" />
              					<select name="emailCheck" onChange="setEmailTail(emailCheck.options[this.selectedIndex].value)" class="form3" >
                					<option value="" selected="selected">선택하세요</option>
                					<option value="etc">직접입력</option>
                					<option value="hanmail.net">hanmail.net</option>
                					<option value="naver.com">naver.com</option>
                					<option value="empal.com">empal.com</option>
                					<option value="paran.com">paran.com</option>
                					<option value="hotmail.com">hotmail.com</option>
                					<option value="lycos.co.kr">lycos.co.kr</option>
                					<option value="msn.com">msn.com</option>
                					<option value="yahoo.com">yahoo.com</option>
                					<option value="korea.com">korea.com</option>
                					<option value="kornet.net">kornet.net</option>
                					<option value="yahoo.co.kr">yahoo.co.kr</option>
              					</select>        
              				</td>
      					</tr>
						<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						
						<tr height="35">
        					<td><img src="/images/template0/common/txt_join_job.gif" /></td>
							<td>
								<%=CommonUtil.getCodeListBox("select","0093","p_jobc_csenr","","","- 선택 -")%>
							</td>
						</tr>
						<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						
						<tr height="35">
        					<td><img src="/images/template0/common/txt_join_school.gif" /></td>
        					<td><input type="text" name="p_corpnm" value="" class="form2" style="width:210px;" maxlength = "50"  title = "직장/회사 를 입력하세요" />        </td>
      					</tr>
						<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						
						<tr height="35">
							<td><img src="/images/template0/common/txt_join_maildesk.gif" /> <img src="/images/template0/common/icon_pilsu.gif" hspace="5" /></td>
							<td>
							<%=CommonUtil.getCodeListBox("select","0092","p_postgb","","","- 선택 -")%>
								
							</td>
						</tr>
						<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						
						<tr height="35">
							<td><img src="/images/template0/common/txt_join_number.gif" /> <img src="/images/template0/common/icon_pilsu.gif" hspace="5" /></td>
							<td>
								<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="140">
										<input type="text" name="p_selpost1" value="" class="form2" style="width:60px;" readOnly />
										<input type="hidden" name="p_selpost2" value="" class="form2" />
									</td>
									<td>
										<a href="#none" onClick="pop('POP_ZIP');"><img src="/images/template0/common/btn_numbercheck.gif" width="88" height="27" border="0" /></a>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						
						<tr height="35">
        					<td><img src="/images/template0/common/txt_join_address.gif" /></td>
        					<td>
        						<table border="0" cellspacing="0" cellpadding="0">
          							<tr>
            							<td><input type="text" name="p_seladdr1" value="" class="form2" style="width:300px;" title = "주소를 입력하세요" /></td>
            							<td><img src="/images/template0/common/msg4.gif" width="135" height="13" hspace="5" /></td>
          							</tr>
        						</table>
        					</td>
      					</tr>
						
						<tr>
							<td height="1" bgcolor="#FFFFFF"></td>
							<td height="1" bgcolor="#ebebeb"></td>
						</tr>
						
						<tr height="35">
        					<td><img src="/images/template0/common/txt_join_address2.gif" /></td>
        					<td><input type="text" name="p_seladdr2" value="" class="form2" style="width:300px;" title = "주소를 입력하세요" /></td>
      					</tr>
						<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						
						<tr height="35">
        					<td colspan="2">
        						<table width="100%" cellpadding="0" cellspacing="0">
									<tr>
            							<td width="100"><img src="/images/template0/common/txt_join_mailok.gif" /></td>
            							<td colspan="3" style="padding-top:5; padding-bottom:5;">
              								<table border="0" cellspacing="0" cellpadding="0">
			    								<tr>
                  									<td colspan="2"><input type="radio" name="p_ismailing" value="Y" style="border:none;" onclick= "chngReceive('M');" checked="checked" />
														동의함
  														<input type="radio" name="p_ismailing" value="N" style="border:none;" onclick= "chngReceive('M');">
														동의안함
													</td>
                  								</tr>
                								<tr>
                  									<td><img src="/images/template0/common/icon_info.gif"/></td>
                  									<td><img src="/images/template0/common/msg.gif" width="475" height="13" hspace="5" /></td>
                								</tr>
              								</table>
              							</td>
          							</tr>
          							<tr><td colspan="4" height="1" bgcolor="#ebebeb"></td></tr>
          							<tr>
            							<td><img src="/images/template0/common/txt_join_smsok.gif" /></td>
            							<td colspan="3" style="padding-top:5; padding-bottom:5;">
              								<table border="0" cellspacing="0" cellpadding="0">
                								<tr>
                  									<td colspan="2"><input type="radio" name="p_issms" value="Y" style="border:none;" onclick= "chngReceive('H');" checked="checked" />
                    								동의함
                    								<input type="radio" name="p_issms" value="N" style="border:none;" onclick= "chngReceive('H');">
                    								동의안함
                    								</td>
                								</tr>
                								<tr>
                  									<td><img src="/images/template0/common/icon_info.gif"/></td>
                  									<td><img src="/images/template0/common/msg.gif" width="475" height="13" hspace="5" /></td>
                								</tr>
              								</table>
              							</td>
          							</tr>
          						</table>
          					</td>
        				</tr>
          				<tr><td colspan="2" height="2" bgcolor="#a7a7a7"></td></tr>	
						</table>
						<table border="0" cellspacing="0" cellpadding="0">
  							<tr><td>&nbsp;</td></tr>
						</table>
						
						<table width="700" border="0" cellspacing="0" cellpadding="0">
  							<tr>
    							<td align="center">
    								<table border="0" cellspacing="2" cellpadding="0">
      									<tr>
        									<td><a href="#none" onClick = "main('C');"><img src="/images/template0/common/btn_insert.gif" width="66" height="24"></a></td>
        									<td><a href="#none" onClick = "main('B');"><img src="/images/template0/common/btn_cancel.gif" width="66" height="24"></a></td>
      									</tr>
    								</table>
    							</td>
  							</tr>
						</table>
						<table border="0" cellspacing="0" cellpadding="0">
  							<tr><td height="100">&nbsp;</td></tr>
						</table>
					</td>
				</tr>
			</table>
 
			</form>
			<form name = "form2">
				<input type = "hidden" name = "cmd" value = "" />
				<input type = "hidden" name = "next" value = "" />
				<input type = "hidden" name = "p_userid" value = "" />
			</form>
