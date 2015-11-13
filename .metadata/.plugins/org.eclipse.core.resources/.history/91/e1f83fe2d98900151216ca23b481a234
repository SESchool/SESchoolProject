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
<%-- <%@page import="Kisinfo.Check.IPINClient"%> --%>
<%@ page contentType="text/html;charset=UTF-8" 		%>
<%@ include file = "/jsp/front/common/commonInc.jsp"	%>
<%
	Box userVO = (Box)box.getObject("userVO");
	Box userInterestVO = (Box)box.getObject("userInterestVO");
	Box userFieldVO = (Box)box.getObject("userFieldVO");
	Box userJoinVO = (Box)box.getObject("userJoinVO");
	
	String tel1 = "" ;
	String tel2 = "" ;
	String tel3 = "" ;
	String fax1 = "" ;
	String fax2 = "" ;
	String fax3 = "" ;
	String selPost1 = "" ;
	String selPost2 = "" ;
	String selAddr1 = "" ;
	String selAddr2 = "" ;
	String corpPost = "";
	String corpPost1 = "" ;
	String corpPost2 = "" ;
	String corpAddr1 = "" ;
	String corpAddr2 = "" ;
	String addr = "";
	String addr2 = "" ;
    String post1 = "" ;
    String post2 = "" ;
    String comptel = "" ;
    String compfax = "" ;
    String emailID = "" ;
    String emailAddr =  "" ;
    String jobGB = "" ;
    String localGB = "" ;
    String tradeGB = "" ;
	String email = "" ;
	String handphone = "" ;
	 
	int point = 0 ;
	String jobApply= "N";
	email = userVO.getString("EMAIL") ;
	if(StringUtil.isNotNull(email)) {
		point = email.indexOf("@");
		
		emailID = email.substring(0, point); 
		emailAddr = email.substring( point+1, email.length() );	
	}

    jobGB = userInterestVO.getString("JOBGB");
    localGB = userInterestVO.getString("LOCALGB");
    tradeGB = userInterestVO.getString("TRADEGB");
    if( StringUtil.isNull(jobGB)) {
    	jobGB = "NNNNNNNNNNNN";
    }
    if( StringUtil.isNull(localGB)) {
    	localGB = "NNNNNNNN";
    }

    if( StringUtil.isNull(tradeGB)) {
    	tradeGB = "NNNNNNNN";
    }
    
    String[] arrComptel = {"", "" , "" };
    
    String[] arrCompfax = {"", "" , "" };
    
    String[] arrHandphone = {"010", "" , "" };
    
    String hometel = "" ;
    String homefax = "" ;

	String[] arrHometel = {"", "" , "" };
    
    String[] arrHomefax = {"", "" , "" };
    
	String saupjaNO = "" ;
	String[] arrSaupjaNO   = {"", "" , "" };
	
	saupjaNO = userVO.getString("SAUPJANO");
	
	if(  !StringUtil.isNull(saupjaNO) && !"--".equals(saupjaNO)) {
		arrSaupjaNO = saupjaNO.split("-");
		jobApply = "Y";
	   
	}
	
	corpPost = userVO.getString("CORPZIP");
	
	/* if( !StringUtil.isNull(corpPost1) &&  !corpPost1.equals("-")) {
		corpPost1 = corpPost1.replaceAll("-", "");
		corpPost2 = corpPost1.substring(3,6) ;
		corpPost1 = corpPost1.substring(0,3) ;
	}else {
		corpPost1 = "" ;
	} */	
	
	if( !StringUtil.isNull(corpPost) && !corpPost.equals("-") ){
		if( corpPost.contains("-") ){
			corpPost1 = corpPost.substring(0, corpPost.indexOf("-"));
			corpPost2 = corpPost.substring(corpPost.indexOf("-")+1, corpPost.length());
		} else if( corpPost.length() > 5 ){
			corpPost1 = corpPost.substring(0, 3);
			corpPost2 = corpPost.substring(3, corpPost.length());
		} else {
			corpPost1 = corpPost;
			corpPost2 = "";
		}
	} else {
		corpPost1 = "";
		corpPost2 = "";
	}
	
	corpAddr1 = userVO.getString("CORPADDR1");
	corpAddr2 = userVO.getString("CORPADDR2");
	handphone =  userVO.getString("HANDPHONE") ;
	if(  !StringUtil.isNull(comptel) && !"--".equals(comptel)) {
		arrComptel = comptel.split("-");
	   
	}
	
	if(  !StringUtil.isNull(compfax) && !"--".equals(compfax)) {
		arrCompfax = compfax.split("-");
	   
	}
	
	if(  !StringUtil.isNull(handphone) && !"--".equals(handphone)) {
		arrHandphone = handphone.split("-");
	   
	}
	post1 = userVO.getString("POST1");
	post2 = userVO.getString("POST2");
	
	addr = userVO.getString("ADDR");
	addr2 = userVO.getString("ADDR2");
	
	// 회사 주소컬럼은 사용하지 않기로 함.
	if( userVO.getString("POSTGB").equals("1") && false) { // 우편물 수령지 회사 	
		selPost1 = corpPost1 ;
		selPost2 = corpPost2 ;
		selAddr1 = corpAddr1 ;
		selAddr2 = corpAddr2 ;		
	}else {// 우편물 수령지 집
		selPost1 = post1 ;
		selPost2 = post2 ;
		selAddr1 = addr ;
		selAddr2 = addr2 ;	
	}
%>
<!-- i-pin 모듈 시작 -->
<%-- <%
	/********************************************************************************************************************************************
		NICE신용평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
		
		서비스명 : 가상주민번호서비스 (IPIN) 서비스
		페이지명 : 가상주민번호서비스 (IPIN) 호출 페이지
	*********************************************************************************************************************************************/
	
	String sSiteCode_ipin				= "D002";			// IPIN 서비스 사이트 코드		(NICE신용평가정보에서 발급한 사이트코드)
	String sSitePw_ipin					= "Kita5114";			// IPIN 서비스 사이트 패스워드	(NICE신용평가정보에서 발급한 사이트패스워드)
	
	
	/*
	┌ sReturnURL 변수에 대한 설명  ─────────────────────────────────────────────────────
		NICE신용평가정보 팝업에서 인증받은 사용자 정보를 암호화하여 귀사로 리턴합니다.
		따라서 암호화된 결과 데이타를 리턴받으실 URL 정의해 주세요.
		
		* URL 은 http 부터 입력해 주셔야하며, 외부에서도 접속이 유효한 정보여야 합니다.
		* 당사에서 배포해드린 샘플페이지 중, ipin_process.jsp 페이지가 사용자 정보를 리턴받는 예제 페이지입니다.
		
		아래는 URL 예제이며, 귀사의 서비스 도메인과 서버에 업로드 된 샘플페이지 위치에 따라 경로를 설정하시기 바랍니다.
		예 - http://www.test.co.kr/ipin_process.jsp, https://www.test.co.kr/ipin_process.jsp, https://test.co.kr/ipin_process.jsp
	└────────────────────────────────────────────────────────────────────
	*/
	String sReturnURL_ipin				= "http://tradecampus.kita.net/jsp/front/common/member/ipin_process.jsp";
	
	
	/*
	┌ sCPRequest 변수에 대한 설명  ─────────────────────────────────────────────────────
		[CP 요청번호]로 귀사에서 데이타를 임의로 정의하거나, 당사에서 배포된 모듈로 데이타를 생성할 수 있습니다.
		
		CP 요청번호는 인증 완료 후, 암호화된 결과 데이타에 함께 제공되며
		데이타 위변조 방지 및 특정 사용자가 요청한 것임을 확인하기 위한 목적으로 이용하실 수 있습니다.
		
		따라서 귀사의 프로세스에 응용하여 이용할 수 있는 데이타이기에, 필수값은 아닙니다.
	└────────────────────────────────────────────────────────────────────
	*/
	String sCPRequest				= "";
	
	
	
	// 객체 생성
	IPINClient pClient = new IPINClient();
	
	
	// 앞서 설명드린 바와같이, CP 요청번호는 배포된 모듈을 통해 아래와 같이 생성할 수 있습니다.
	sCPRequest = pClient.getRequestNO(sSiteCode_ipin);
	
	// CP 요청번호를 세션에 저장합니다.
	// 현재 예제로 저장한 세션은 ipin_result.jsp 페이지에서 데이타 위변조 방지를 위해 확인하기 위함입니다.
	// 필수사항은 아니며, 보안을 위한 권고사항입니다.
	session.setAttribute("CPREQUEST" , sCPRequest);
	
	
	// Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
	int iRtn = pClient.fnRequest(sSiteCode_ipin, sSitePw_ipin, sCPRequest, sReturnURL_ipin);
	
	String sRtnMsg					= "";			// 처리결과 메세지
	String sEncData_ipin					= "";			// 암호화 된 데이타
	
	// Method 결과값에 따른 처리사항
	if (iRtn == 0)
	{
	
		// fnRequest 함수 처리시 업체정보를 암호화한 데이터를 추출합니다.
		// 추출된 암호화된 데이타는 당사 팝업 요청시, 함께 보내주셔야 합니다.
		sEncData_ipin = pClient.getCipherData();		//암호화 된 데이타
		
		sRtnMsg = "정상 처리되었습니다.";
	
	}
	else if (iRtn == -1 || iRtn == -2)
	{
		sRtnMsg =	"배포해 드린 서비스 모듈 중, 귀사 서버환경에 맞는 모듈을 이용해 주시기 바랍니다.<BR>" +
					"귀사 서버환경에 맞는 모듈이 없다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
	}
	else if (iRtn == -9)
	{
		sRtnMsg = "입력값 오류 : fnRequest 함수 처리시, 필요한 4개의 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
	}
	else
	{
		sRtnMsg = "iRtn 값 확인 후, NICE신용평가정보 개발 담당자에게 문의해 주세요.";
	}
%> --%>
<!-- i-pin 모듈 끝 -->

<%@page import="com.sinc.common.FormatDate"%>
<script language="Javascript" src="/js/common/util.js"></script>
<script language="Javascript" src="/js/common/calendar.js"></script>
<script type="text/javascript">
document.domain = "tradecampus.kita.net";
	var mainElements ;
	var subElements ;
	function isValid (arg) {
		var regExp ; 
		switch (arg) {
			case 'U' :
				// 2. 연속된 숫자 또는 알파벳 3자 이상 사용 불가합니다.
				var ch1, ch2, ch3;
				var v_pwd = mainElements["p_pwd"].value;
				var userID = mainElements["p_userid"].value;
				if( !ncCom_Empty( mainElements["p_pwd"].value) ||  !ncCom_Empty( mainElements["p_pwdconfirm"].value)  ) {
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
					// 3. 비밀번호내에 아이디가 포함되어 있으면 안됩니다.
					var arrTmp = v_pwd.split(userID);
					if ( arrTmp.length > 1 ) {
						return ncCom_ErrField( mainElements["p_pwd"], "비밀번호내에 아이디가 포함되어 있으면 안됩니다.");
					}
					
					// 비밀번호 확인 검사
					if (mainElements["p_pwdconfirm"].value  != mainElements["p_pwd"].value ) {
						return ncCom_ErrField( mainElements["p_pwdconfirm"], "비밀번호와 비밀번호 확인 값이 서로 다릅니다.");
					}
				}	

				if ( ncCom_Empty( mainElements["p_postgb"].value) ) return ncCom_ErrField( mainElements["p_postgb"], "우편물접수처를 선택하세요") ;

				//전화번호
				regExp = /0[0-9]{1,2}-[0-9]{3,4}-[0-9]{4}/;
				if ( !regExp.test(mainElements["p_handphone1"].value+"-"+mainElements["p_handphone2"].value+"-"+mainElements["p_handphone3"].value) ) {
					return ncCom_ErrField( mainElements["p_handphone1"], "핸드폰번호 형식이 잘못되었습니다.") ; 
				}				
								 
				if ( ncCom_Empty( mainElements["emailID"].value) ) return ncCom_ErrField( mainElements["emailID"], "이메일 을 입력하세요") ; 
				if ( ncCom_Empty( mainElements["emailTail"].value) ) return ncCom_ErrField( mainElements["emailTail"], "이메일 을 입력하세요") ;
				if ( !chkEmail(mainElements["emailID"].value +"@"+ mainElements["emailTail"].value) ) {
					return ncCom_ErrField( mainElements["emailID"], "메일주소가 정확하지 않습니다.") ;
				}
				
				if ( ncCom_Empty( mainElements["p_selpost1"].value) ) return ncCom_ErrField( mainElements["p_selpost1"], "주소를 입력하세요") ;
				if ( ncCom_Empty( mainElements["p_seladdr2"].value) ) return ncCom_ErrField( mainElements["p_seladdr2"], "상세 주소를 입력하세요") ;		
				
				break; 
				
		}
		return true ;
				
	}
	function main(arg1) {
		switch (arg1) {
			case 'U' :
				if( !isValid(arg1) ) return ;
				if(!confirm("수정하시겠습니까?")) return ;
				var temp = "" ;
				mainElements["p_handphone"].value = mainElements["p_handphone1"].value +"-"+ mainElements["p_handphone2"].value +"-"+ mainElements["p_handphone3"].value ;
				// 직장부분은 사용하지 않도록 변경.
				if( mainElements["p_postgb"].value == "1" && false) { //직장
					if(mainElements["p_selpost2"].value == null || mainElements["p_selpost2"].value == ""){
						mainElements["p_corpzip"].value = mainElements["p_selpost1"].value
					} else {
						mainElements["p_corpzip"].value = mainElements["p_selpost1"].value + "-"+ mainElements["p_selpost2"].value;
					}
					mainElements["p_corpaddr1"].value = mainElements["p_seladdr1"].value ;
					mainElements["p_corpaddr2"].value = mainElements["p_seladdr2"].value
				}else {//자택
					mainElements["p_post1"].value = mainElements["p_selpost1"].value ;
					mainElements["p_post2"].value =  mainElements["p_selpost2"].value;
					mainElements["p_addr"].value = mainElements["p_seladdr1"].value ;
					mainElements["p_addr2"].value = mainElements["p_seladdr2"].value;					
				}
				mainElements["p_email"].value = mainElements["emailID"].value +"@"+ mainElements["emailTail"].value ;
				mainElements["p_jobc_name"].value = mainElements["p_jobc_csenr"].options[ mainElements["p_jobc_csenr"].selectedIndex].text ;
				mainElements["cmd"].value = "btocMemberEdit";
				mainElements["next"].value = "joinMemberResult";
				document.forms["form1"].target = "hiddenFrame";
				document.forms["form1"].action = "https://tradecampus.kita.net/front/Member.do?cmd=btocMemberEdit";
				document.forms["form1"].submit();
				location.replace('/front/Main.do?cmd=btocMain&s_system=1');	//메인페이지로 이동
//				location.replace('http://tradecampus.kita.net');
				document.forms["form1"].target = "_self";	//이건 적용안되고 있음
				
				break;
			case 'B' :
				document.forms["form2"].action = "https://tradecampus.kita.net/front/Member.do";
				document.forms["form2"].method = "post";
				subElements["cmd"].value = "joinMember";
				subElements["next"].value = "joinMemberPerson";
				document.forms["form2"].submit();
				break;
		}			
	}
	function pop(arg1, arg2) {
		switch (arg1) {
			case 'POP_ZIP' :
				Center_Fixed_Popup_zip("", "popZip", 470, 550, "yes"); 
				document.forms["form2"].action = "/front/Common.do";	
				document.forms["form2"].method = "post";
				subElements["cmd"].value = "selectZipCode";
				document.forms["form2"].target = "popZip";
				document.forms["form2"].submit();
				document.forms["form2"].target = "_self";
				break;					
		}
	}

	function setZipCodeInfo(addr, zipcode) {
		mainElements["p_seladdr1"].value = addr ;
		if(zipcode.search('-') > -1){	
			mainElements["p_selpost1"].value = zipcode.substr(0, 3) ;
			mainElements["p_selpost2"].value = zipcode.substr(4, 7) ;	
		} else {
			mainElements["p_selpost1"].value = zipcode;		// 새로운 우편주소, 하나의 텍스트란에 넣음
			mainElements["p_selpost2"].value = "";
			
			form1.p_selpost2.style.display="none";
			form1.p_seladdr2.value = "";
			form1.p_seladdr2.focus();
		}
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

	function chngJobApply() {
		if(mainElements["p_jobapply"].value == "Y" ) {
			mainElements["p_saupjano1"].value  = "" ;
			mainElements["p_saupjano1"].readOnly =  false ;
		}else {
			
		}
	}
    function oldImgDel(arg){
    	var f = document.form1;
    	var oldImg = document.getElementById("oldImg"+arg);
    	var oldFile = "" ;
    	var oldRealFile = "" ;

    	oldFile = mainElements["p_oldfile"+arg];
    	oldRealFile =  mainElements["p_oldrealfile"+arg]; 
    	        
		oldImg.style.display = "none";
        oldFile.value = "";    
        oldRealFile.value = "" ;  	
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
		mainElements["p_handphone1"].value = "<%=arrHandphone[0]%>";
		mainElements["p_prevnomailing"].value  =  mainElements["p_ismailing"][1].checked+"";
		mainElements["p_prevnosms"].value  =  mainElements["p_issms"][1].checked+"" ;		
		
	}	
	addLoadEvent(DOC_LOAD);
	function Center_Fixed_Popup_zip(s_url, s_name, s_width, s_height, s_scroll) {
		ls_pri = "toolbar=no, location=no, directories=no, menubar=no, resizable=yes, scrollbars="+s_scroll+", status=yes, width="+s_width+", height="+s_height;
		wd_pop = window.open(s_url, s_name,ls_pri);
		if(wd_pop == null) {
		   alert("현재 사이트의 팝업이 차단되어 있습니다. 차단을 해제해 주십시요.");
		   return;
		}

        /* var version = navigator.appVersion;
        var addHeight = 0;
        if(version.indexOf("MSIE 7.0") > -1) addHeight=50;
		wd_pop.blur();
		wd_pop.resizeTo(s_width, s_height+addHeight);
        var aw = window.screen.availWidth;
        var ah = window.screen.availHeight;
		wd_pop.moveTo(((aw - eval(s_width))/2),((ah - eval(s_height))/2));
		wd_pop.focus(); */
		return wd_pop;
	}
</script>

		<!--헤더부분 시작-->
				<form name = "form1" method="post" enctype="multipart/form-data">	
					<input type="hidden" name="cmd"  value = "" />
					<input type="hidden" name="next"  value = "" />				
					<input type="hidden" name="p_post1" value = "<%=post1%>" />
					<input type="hidden" name="p_post2" value = "<%=post2%>" />
					<input type="hidden" name="p_addr" value = "<%=addr %>" /> 
					<input type="hidden" name="p_addr2" value = "<%=addr2 %>" />
					<input type="hidden" name="p_corpzip" value = "<%=corpPost1 %><%=corpPost2%>" />
					<input type="hidden" name="p_corpaddr1" value = "<%=corpAddr1%>" />
					<input type="hidden" name="p_corpaddr2" value = "<%=corpAddr2%>" />
					<input type="hidden" name="p_email" value = "" />
					<input type="hidden" name="idDuplicateCheck" value = "Y" />
					<input type="hidden" name="p_jobc_name" value = "" />
					<input type="hidden" name="p_jobgb" value = "" />
					<input type="hidden" name="p_resno" value = "" />
					<input type="hidden" name="p_usergubun" value = "<%=userVO.getString("USERGUBUN") %>" />
					<input type="hidden" name="p_userid" value = "<%=box.getString("s_userid") %>" />
					<input type="hidden" name="p_handphone" value = "" />	
					<input type="hidden" name="p_prevnomailing" value = "" />
					<input type="hidden" name="p_prevnosms" value = "" />									
					<input type="hidden" name="p_name" value = "<%=userVO.getString("NAME")%>" />									
				
				<!-- 기본정보 -->
				<table width="700" cellpadding="0" cellspacing="0" style="margin-top:30px;">
				<!-- <tr>
					<td height="60"></td>
				</tr> -->
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
						<!-- 아이디 -->
						<tr height="35">
							<td><img src="/images/template0/common/txt_join_id.gif" /> <img src="/images/template0/common/icon_pilsu.gif" hspace="5" /></td>
							<td><%=userVO.getString("USERID") %>
						</tr>
						<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						<!-- 비밀번호 -->
						<tr height="35">
        					<td><img src="/images/template0/common/txt_join_pw.gif" /> <img src="/images/template0/common/icon_pilsu.gif" hspace="5" /></td>
        					<td><input type="password" name="p_pwd" value="" class="form2" style="width:200px;" maxlength = "14"  title = "비밀번호를 입력하세요" />        </td>
      					</tr>
      					<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
      					<tr height="35">
        					<td><img src="/images/template0/common/txt_join_pwchk.gif" />
        						<img src="/images/template0/common/icon_pilsu.gif" hspace="5" /></td>
        					<td><input type="password" name="p_pwdconfirm" value="" class="form2" style="width:200px;" maxlength = "14" title = "비밀번호 확인을 입력하세요" />        </td>
      					</tr>
      					<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						<!-- 이름 -->
						<tr height="35">
							<td width="100"><img src="/images/template0/common/txt_join_name.gif" /></td>
							<td><%=userVO.getString("NAME") %>
						</tr>
						<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						<!-- 주민등록번호 IPin 전환 기능-->
						<%-- <% 
						String certis = "";
						if(userVO.getString("CERT_GB")!=null){certis = userVO.getString("CERT_GB");}
						if(!certis.equals("0")){	// 아이핀인증이 아닐경우 아이핀인증 가능하게 추가
							%>
						<tr height="150">
							<td><img src="/images/template0/common/txt_mypage_resno.gif" /></td>
							<td valign="top">
								&nbsp;&nbsp;<br><a onclick="fnPopup_ipin()" href="#"><img src="/images/template0/common/btn_change_ipin.gif" /></a><br>
								<b>*  아이핀(I-PIN)이란 인터넷상에서 주민번호를 대신하여 본임임을 확인할 수 있는 <br>&nbsp;&nbsp;개인식별 수단입니다.</b><br>&nbsp;&nbsp;
								회원님은 회원가입시 주민등록번호(외국인등록번호)또는 핸드폰 인증을 이용한 실명확인으로<br>&nbsp;&nbsp; 가입하셨습니다.
								해킹, 관리자, 부주의로 인한 개인정보 유출사고를 방지하고, 주민번호의 불법적 <br>&nbsp;&nbsp;이용을 원천적으로
								차단하기 위해, 인터넷상 주민번호 수집 / 이용이 2012년 8월부터 제한되므로, <br>&nbsp;&nbsp;주민번호를 대신한
								아이핀(I-PIN)으로 전환하여 주시기 바랍니다.<br>
								* 근거법률 : [정보통신망 이용촉진 및 정보보호 등에 관한 법률] 제 23조의(주민등록번호의 사용 제한)<br>&nbsp;&nbsp;			
							</td>
						</tr>
						<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						<%}%> --%>
						<!-- 휴대폰 -->			
						<tr height="35">
        					<td><img src="/images/template0/common/txt_join_mobile.gif" /> <img src="/images/template0/common/icon_pilsu.gif" hspace="5" /></td>
        					<td><select name="p_handphone1" class="form3"  style="width: auto;" >
          						<option value="010" selected="selected">010</option> 
          						<option value="011" >011</option>
          						<option value="016" >016</option>
          						<option value="017" >017</option>
          						<option value="018" >018</option>
          						<option value="019" >019</option>
        						</select>
          						-
          						<input type="text" name="p_handphone2" value="<%=arrHandphone[1] %>" class="form2" style="width:60px;" maxlength = "4" title = "핸드폰번호를 입력하세요" />
          						-
          						<input type="text" name="p_handphone3" value="<%=arrHandphone[2] %>" class="form2" style="width:60px;" maxlength = "4" title = "핸드폰번호를 입력하세요" />        </td>
      					</tr>
      					<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						<!-- 이메일 -->
						<tr height="35">
       						<td><img src="/images/template0/common/txt_join_email.gif" /> <img src="/images/template0/common/icon_pilsu.gif" hspace="5" /></td>
        					<td><input type="text" name="emailID" value="<%=emailID %>" class="form2" style="width:100px;"  maxlength = "50"/>
          					@
          					<input type="text" name="emailTail" value="<%=emailAddr %>" class="form2" style="width:150px;"  maxlength = "50" readonly="readOnly" />
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
						<!-- 직업 -->
						<tr height="35">
        					<td><img src="/images/template0/common/txt_join_job.gif" /></td>
							<td>
								<%=CommonUtil.getCodeListBox("select","0093","p_jobc_csenr",userVO.getString("JOBC_CSENR"),"","- 선택 -")%>
							</td>
						</tr>
						<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						<!-- 직장/학교 -->
						<tr height="35">
        					<td><img src="/images/template0/common/txt_join_school.gif" /></td>
        					<td><input type="text" name="p_corpnm" value="<%=userVO.getString("COMPNM") %>" class="form2" style="width:210px;" maxlength = "50"  title = "직장/회사 를 입력하세요" />        </td>
      					</tr>
						<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						<!-- 우편물 접수처 -->
						<tr height="35">
							<td><img src="/images/template0/common/txt_join_maildesk.gif" /> <img src="/images/template0/common/icon_pilsu.gif" hspace="5" /></td>
							<td>
							<%=CommonUtil.getCodeListBox("select","0092","p_postgb",userVO.getString("POSTGB"),"","- 선택 -")%>
								
							</td>
						</tr>
						<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						<!-- 우편번호 -->
						<tr height="35">
							<td><img src="/images/template0/common/txt_join_number.gif" />
							<img src="/images/template0/common/icon_pilsu.gif" hspace="5" /></td>
							<td>
								<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="140">
									<% if(selPost2 == null || selPost2.equals("")){ %>
										<input type="text" name="p_selpost1" value="<%=selPost1%>" class="form2" style="width:60px;" readOnly />
										<input type="hidden" name="p_selpost2" value = "<%=selPost2%>" />	
									<% } else { %>
										<input type="text" name="p_selpost1" value="<%=selPost1%>" class="form2" style="width:60px;" readOnly />
										-
										<input type="text" name="p_selpost2" value="<%=selPost2%>" class="form2" style="width:60px;" readOnly />
									<% } %>
									</td>
									<td>
										<a href="#none" onClick="pop('POP_ZIP');"><img src="/images/template0/common/btn_numbercheck.gif" width="88" height="27" border="0" /></a>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td height="1" bgcolor="#ebebeb" colspan="2"></td></tr>
						<!-- 주소1 -->
						<tr height="35">
        					<td><img src="/images/template0/common/txt_join_address.gif" /></td>
        					<td>
        						<table border="0" cellspacing="0" cellpadding="0">
          							<tr>
            							<td><input type="text" name="p_seladdr1" value="<%=selAddr1%>" class="form2" style="width:300px;" title = "주소를 입력하세요" readonly="readonly"/></td>
            							<td><img src="/images/template0/common/msg4.gif" width="135" height="13" hspace="5" /></td>
          							</tr>
        						</table>
        					</td>
      					</tr>
      					
      					<tr>
							<td height="1" bgcolor="#FFFFFF"></td>
							<td height="1" bgcolor="#ebebeb"></td>
						</tr>
						
						<!-- 주소2 -->
						<tr height="35">
        					<td><img src="/images/template0/common/txt_join_address2.gif" /></td>
        					<td><input type="text" name="p_seladdr2" value="<%=selAddr2%>" class="form2" style="width:300px;" title = "주소를 입력하세요" /></td>
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
                  									<td colspan="2">
                  										<input type="radio" name="p_ismailing" value="Y" style="border:none;" onClick= "chngReceive('M');" <% if("Y".equals( userVO.getString("ISMAILING") ) )out.println(" checked ");%>>
														동의함
  														<input type="radio" name="p_ismailing" value="N" style="border:none;" onClick= "chngReceive('M');" <% if("N".equals( userVO.getString("ISMAILING") ) )out.println(" checked ");%>>
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
                  									<td colspan="2"><input type="radio" name="p_issms" value="Y" style="border:none;" onClick= "chngReceive('H');"  <% if("Y".equals( userVO.getString("ISSMS") ) )out.println(" checked ");%>>
                    								동의함
                    								<input type="radio" name="p_issms" value="N" style="border:none;" onClick= "chngReceive('H');" <% if("N".equals( userVO.getString("ISSMS") ) )out.println(" checked ");%>>
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
					</table>
				</td>
			</tr>
			<tr><td height="2" bgcolor="#a7a7a7"></td></tr>
			</table>
			<table border="0" cellspacing="0" cellpadding="0">
  				<tr><td>&nbsp;</td></tr>
			</table>
			
			<table width="700" border="0" cellspacing="0" cellpadding="0">
  				<tr>
    				<td align="center">
    					<table border="0" cellspacing="2" cellpadding="0">
      						<tr>
        						<td><a href="#none" onClick = "main('U');"><img src="/images/template0/common/btn_insert.gif" width="66" height="24"></a></td>
      						</tr>
    					</table>
    				</td>
  				</tr>
			</table>
			<table border="0" cellspacing="0" cellpadding="0">
  			<tr><td height="100">&nbsp;</td></tr>
			</table>
			</form>
			<form name = "form2">
				<input type = "hidden" name = "cmd" value = "" />
				<input type = "hidden" name = "next" value = "" />
				<input type = "hidden" name = "p_userid" value = "" />
			</form>
			


<!-- ipin인증 팝업 -->
<!-- <script language='javascript'>
	window.name ="Parent_window";	

	function fnPopup_ipin(){
		window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		document.form_ipin.target = "popupIPIN2";
		document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
		document.form_ipin.submit();
	}
</script> -->
<!-- IPIN인증용 폼 -->			
<!-- <form name="vnoform" method="post">
	<input type="hidden" name="enc_data"> -->								<!-- 인증받은 사용자 정보 암호화 데이타입니다. -->
	
	<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
    	 해당 파라미터는 추가하실 수 없습니다. -->
    <%-- <input type="hidden" name="param_r1" value="EMODE">
    <input type="hidden" name="param_r2" value="">
    <input type="hidden" name="param_r3" value="<%=box.getString("s_userid") %>">
    <input type="hidden" name="cmd" >
</form> --%>

<!-- ipin인증 폼 -->
<!-- <form name="form_ipin" method="post"> -->
	<!-- <input type="hidden" name="m" value="pubmain"> -->						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
    <%-- <input type="hidden" name="enc_data" value="<%= sEncData_ipin %>"> --%>		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
    
    <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
    	 해당 파라미터는 추가하실 수 없습니다. -->
    <%-- <input type="hidden" name="param_r1" value="EMODE">
    <input type="hidden" name="param_r2" value="">
    <input type="hidden" name="param_r3" value="<%=box.getString("s_userid") %>">
</form> --%>
