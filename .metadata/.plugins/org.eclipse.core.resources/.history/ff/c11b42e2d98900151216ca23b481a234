<%--
 * @(#)SystemCode Template
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * T_LMS_TUTOR 테이블 List Template.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2009. 11. 12.  bgcho       Initial Release
 ************************************************
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sinc.common.FileDTO" %>
<%@ page import="com.sinc.common.CodeParamDTO" %>
<%@ include file = "/jsp/back/common/commonInc.jsp" %>
<%@ page import ="org.apache.commons.configuration.Configuration"%>
<%@ page import ="com.sinc.framework.configuration.ConfigurationFactory"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>::: 한국무역협회 무역아카데미 ::: 관리자페이지</TITLE>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<%
	Box boxTutorInfo 	= (Box)box.getObject("boxTutorInfo");
    
    
	String v_tutorgubun = StringUtil.nvl(boxTutorInfo.getString("TUTORGUBUN"),"1");
	String v_process 	= StringUtil.nvl(box.getString("p_process"),"W");
	String v_tutortype 	= StringUtil.nvl(box.getString("p_tutortype"),"W");

	String v_resno = boxTutorInfo.getString("RESNO");
	String v_fmon = StringUtil.nvl(boxTutorInfo.getString("FMON"));
	String v_tmon = StringUtil.nvl(boxTutorInfo.getString("TMON"));		
	
	//첨부파일을 가져온다.
	DataSet dsTutorContractFile = (DataSet)box.getObject("dsTutorContractFile");
	ArrayList fileList = new ArrayList();    
	FileDTO file = null;
	if ( dsTutorContractFile != null ) {
		while ( dsTutorContractFile.next() ) {
			file = new FileDTO();			
			file.setNo(dsTutorContractFile.getInt("SEQ"));
			file.setSaveFilename(dsTutorContractFile.getString("REALFILE"));			
			fileList.add(file);
		}
		dsTutorContractFile.setPos();
	}
	
%>
<fmtag:csscommon point="back" />
<fmtag:jscommon />
<fmtag:dwrcommon interfaceName="TutorWork"/>
<script type="text/javascript" src="/js/common/calendar.js"></script>
<script language="Javascript" src="/js/common/fileupload.js"></script>
<script type="text/javascript">
	var v_tutorobj = "";

	function jsInitPage() {
		var f = document.form1;
		var v_gubun = "<%=v_tutorgubun %>";
		var v_process = f.p_process.value;
		var v_namesearchimg = document.getElementById("name_search_img");
		var v_idsearchimg = document.getElementById("id_search_img");	
		var v_compsearchimg = document.getElementById("comp_search_img");		
		var v_idresno  = document.getElementById("id_resno");  
			
		f.p_newmember.value = "Y";

		if ( v_process == "W" ) {
			v_tutorobj = {
					"p_name"		: f.p_name.value,		// 성명
					"p_resno1"		: f.p_resno1.value,		// 주민번호1
					"p_resno2"		: f.p_resno2.value,		// 주민번호2
					"p_jikcheknm"	: f.p_jikcheknm.value,	// 직책
					"p_post1"		: f.p_post1.value,		// 우편번호1
					"p_post2"		: f.p_post2.value,		// 우편번호2
					"p_addr"		: f.p_addr.value,		// 주소
					"p_email"		: f.p_email.value,		// 이메일
					"p_phone1"		: f.p_phone1.value,		// 연락처1
					"p_phone2"		: f.p_phone2.value,		// 연락처2
					"p_phone3"		: f.p_phone3.value,		// 연락처3
					"p_handphone1"	: f.p_handphone1.value,	// 핸드폰1
					"p_handphone2"	: f.p_handphone2.value,	// 핸드폰2
					"p_handphone3"	: f.p_handphone3.value,	// 핸드폰3
					"p_userid"		: f.p_userid.value,		// 아이디
					"p_pwd"			: f.p_pwd.value,			// 비밀번호
					"p_compnm"		: f.p_compnm.value			// 회사
			};			

			if ( v_gubun == "1" ) {			// 사내튜터
				for ( var key in v_tutorobj ) {
					f[key].onclick = searchMember;
					f[key].readOnly = false;
				}
				v_namesearchimg.style.display = "";
				v_idsearchimg.style.display = "none";
				v_compsearchimg.style.display = "none";
				v_idresno.style.display = "";
				
				f.writeNameType[0].checked = false;
				f.writeNameType[1].checked = true;
				
			} else if ( v_gubun == "2" ) {	// 사외튜터
				v_namesearchimg.style.display = "";
				v_idsearchimg.style.display = "";
				v_compsearchimg.style.display = "";
				v_idresno.style.display = "none";
				
				f.writeNameType[0].checked = true;
				f.writeNameType[1].checked = flase;
			}			
		} else if ( v_process == "E" ) {
			v_tutorobj = {
					"p_name"		: f.p_name.value,		// 성명
					"p_resno1"		: f.p_resno1.value,		// 주민번호1
					"p_resno2"		: f.p_resno2.value,		// 주민번호2
					"p_userid"		: f.p_userid.value,		// 아이디
					"p_pwd"			: f.p_pwd.value			// 비밀번호
			};
		
			if ( v_gubun == "1" ) {
				f.p_tutorgubun[1].disabled = true;
				v_idresno.style.display = "";
			} else if ( v_gubun == "2" ) {
				f.p_tutorgubun[0].disabled = true;
				v_idresno.style.display = "none";
			}
			for ( var key in v_tutorobj ) {
				f[key].onkeydown = alertInfo
				f[key].readOnly = true;
				//f[key].disabled = true;
			}
			v_namesearchimg.style.display = "none";
			v_idsearchimg.style.display = "none";
			v_compsearchimg.style.display = "none";
		}
	}
	function alertInfo() {
		alert ( '해당 페이지에서는 변경할수 없습니다.' );
	}
	// 튜터 구분
	function selectTutorGubun( v_gubun ) {	

		var f = document.form1;
		var v_process = f.p_process.value;
		var v_newmember = f.p_newmember.value;

		if ( v_gubun == undefined ) {
			v_gubun = (f.p_tutorgubun[0].checked) ? f.p_tutorgubun[0].value : f.p_tutorgubun[1].value;
		}
		
		if ( v_process == "W" ) {

			var v_namesearchimg = document.getElementById("name_search_img");
			var v_idsearchimg = document.getElementById("id_search_img");
			var v_compsearchimg = document.getElementById("comp_search_img");
			var v_idresno  = document.getElementById("id_resno");  
			
			if ( v_gubun == "1" ) {			// 사내강사

				for ( var key in v_tutorobj ) {
					//f[key].readOnly = true;
					if ( f[key].value != "" ) {
						f[key].readOnly = true;
					} else {
						f[key].readOnly = false;
					}
				}

				f.p_pwd.value = "";
				f.p_pwd.isNull = "Y";
				f.p_pwd.disabled = true;
				f.p_newmember.value = "N";

				v_namesearchimg.style.display = "";
				v_idsearchimg.style.display = "none";
				v_compsearchimg.style.display = "none";
				v_idresno.style.display = "";
				
				f.writeNameType[0].checked = false;
				f.writeNameType[1].checked = true;
				
			} else if ( v_gubun == "2" ) {	// 	사외강사

				if ( v_newmember == "Y" ) {	// 직접등록
					for ( var key in v_tutorobj ) {
						f[key].readOnly = false;
						f[key].onclick = "";
					}
					f.p_comp.value = "000001";
					f.p_idcheck.value = "N";
					f.p_pwd.value = "";
					f.p_pwd.isNull = "N";
					f.p_pwd.disabled = false;
					f.p_newmember.value = "Y";

					v_namesearchimg.style.display = "none";
					v_idsearchimg.style.display = "";
					v_compsearchimg.style.display = "";
					v_idresno.style.display = "none";
					
					f.writeNameType[0].checked = true;
					f.writeNameType[1].checked = false;
					
				} else if ( v_newmember == "N" ) {
					for ( var key in v_tutorobj ) {
						if ( f[key].value != "" ) {
							f[key].readOnly = true;
						} else {
							f[key].readOnly = false;
						}
					}
					f.p_pwd.value = "";
					f.p_pwd.isNull = "Y";
					f.p_pwd.disabled = true;
					f.p_newmember.value = "N";

					v_namesearchimg.style.display = "";
					v_idsearchimg.style.display = "none";
					v_compsearchimg.style.display = "none";
					v_idresno.style.display = "none";
					
					f.writeNameType[0].checked = true;
					f.writeNameType[1].checked = false;
				}
			}

			if(f.p_tutorgubun[0].checked) v_idresno.style.display = "";
			else v_idresno.style.display = "none";
		}
	}

	function setNewMember( v_newmember ) {
		var f = document.form1;
		f.p_newmember.value = v_newmember;
		if(v_newmember == "Y") 
			selectTutorGubun('2');
		else 
			selectTutorGubun('1');
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
				form.p_post1.value = zipcode.substr(0, 3) ;
				form.p_post2.value = zipcode.substr(4, 7) ;	
			} else {
				form.p_post1.value = zipcode;		// 새로운 우편주소, 하나의 텍스트란에 넣음
				form.p_post2.value = "";
				form.p_post2.style.display="none";
			}
	    }
	}
	
	// 강사를 등록한다.
	function tutorWrite( v_process ) {

		var f = document.form1;

		if(!validateEtc(f)) return;
		if(!validate(f)) return;

		var v_istutor = (f.p_istutor[0].checked) ? f.p_istutor[0].value : f.p_istutor[1].value;
		if ( v_istutor == "Y" ) {
			if( f.p_tmon.value <= f.p_fmon.value) {
				alert("마감일은 시작일보다 뒷 날짜여야 합니다.");
				return; 
			}
		}
		
		if ( f.p_filecnt.value > 0 ) {
		   	// submit 호출되기전에 한번 호출해주어야 함 - 파일업로드 아이디 정렬
	       	uploadClass1.change_id();
		}
	
		f.method = "post";
		f.target = "";
		f.enctype = "multipart/form-data";
		f.action = "/back/Tutor.do?cmd=tutorWrite";
		f.cmd.value = "tutorWrite";
		f.p_process.value = v_process;

		f.submit();
	}
	
	function searchMember() {
		var f = document.form1;
		f.p_newmember.value = "N";
		f.p_idcheck.value = "N";
		var url = "/Common.do?cmd=memberSearchPageList&p_gubun=T&p_searchgubun=NAME&p_searchtext="+f.p_name.value;
		Center_Fixed_Popup2(url, "SearchMember", 610, 550, "no");
	}
	
	var blFirstSearchMember = true;
	// param = COMP||COMPNM||USERID||CONO||NAME||COMPTEL||EMAIL||HANDPHONE||JIKCHEK||JIKCHEKNM||DEPTNAM||POST1||POST2||ADDR||RESNO
	function setMemberInfo( param ) {
		
		var arrParam = param.split("||");

		var f = document.form1;
		
		var arrTel = arrParam[5].split("-");
		var arrHp = arrParam[7].split("-");

		f.p_comp.value = arrParam[0];		// 회사코드
		f.p_compnm.value = arrParam[1];		// 회사명
	    f.p_userid.value = arrParam[2];		// 아이디
	    f.p_name.value = arrParam[4];		// 이름

	    f.p_phone1.value = jsNvl(arrTel[0]);	// 전화
	    f.p_phone2.value = jsNvl(arrTel[1]);	// 전화
	    f.p_phone3.value = jsNvl(arrTel[2]);	// 전화

	    f.p_handphone1.value = jsNvl(arrHp[0]);	// 핸드폰
	    f.p_handphone2.value = jsNvl(arrHp[1]);	// 핸드폰
	    f.p_handphone3.value = jsNvl(arrHp[2]);	// 핸드폰

	    f.p_email.value = arrParam[6];		// 이메일

	    f.p_jikcheknm.value = arrParam[9];	// 직책
	  //  f.p_deptnam.value = arrParam[10];	// 부서

	    f.p_post1.value = arrParam[11];		// 우편번호1
	    f.p_post2.value = arrParam[12];		// 우편번호2
	    f.p_addr.value = arrParam[13];		// 주소

	    f.p_resno1.value = arrParam[14].substring(0,6);
	    f.p_resno2.value = arrParam[14].substring(6,13);

	    selectTutorGubun();

	    if ( blFirstSearchMember && param != "" ) {
			for ( var key in v_tutorobj ) {
				f[key].onclick = "";
			}
			blFirstSearchMember = false;
		}
	}
	function setOldFileFlag( target ) {

		var f = document.form1;

		var v_spanobj = "";
		var v_delfile_flag = f.p_delfile_flag.value;
		if ( v_delfile_flag == "" ) {
			v_delfile_flag = "N,N,N,N";
		}
		var arrFlag = v_delfile_flag.split(",");
		if ( target == "0" ) {
			arrFlag[0] = "Y";
			v_spanobj = document.getElementById("OldFileResume");
			v_spanobj.style.display = "none";
		} else if ( target == "1" ) {
			arrFlag[1] = "Y";
			v_spanobj = document.getElementById("OldFileCertificate");
			v_spanobj.style.display = "none";
		} else if ( target == "2" ) {
			arrFlag[2] = "Y";
			v_spanobj = document.getElementById("OldFileContractfile");
			v_spanobj.style.display = "none";
		}
		f.p_delfile_flag.value = arrFlag.toString();
	}

	//ID중복확인체크
	function userIdCheck() {
		var f = document.form1;
		if ( f.p_compnm.value == "" ) {
			alert ( "회사를  선택해 주세요." );
			return;
		}
	
		if ( f.p_userid.value == "" ) {
			alert('ID를 입력하세요');
			return;
		}
		document.hiddenFrame.location.href="/back/Tutor.do?cmd=userIdCheck&p_userid="+f.p_userid.value+"&p_comp="+f.p_comp.value;		
	}
	function setCheckUserId(val) {
		document.form1.p_idcheck.value = val;
	}
	
	//회사 조회
	function searchCompList() {
		var f = document.form1;
		var url = "/Common.do?cmd=compPageList&p_remoyn=N";
		Center_Fixed_Popup2(url, "SearchComp", 510, 550, "no");
	}
	function setCompInfo(v_comp, v_compnm) {
		var f = document.form1;
        f.p_comp.value = v_comp;
        f.p_compnm.value = v_compnm;
	}
	
	function tutorDelete() {

		var f = document.form1;

		if(confirm("정말 삭제하시겠습니까?")){
					
			f.method = "post";
			f.target = "";
			f.enctype = "multipart/form-data";
			f.action = "/back/Tutor.do?cmd=tutorWrite";
			f.cmd.value = "tutorWrite";
			f.p_process.value = "D";
			f.submit();
		}	
	}

	function validateEtc(f) {

		if ( f.p_process.value == "E" ) {

			var v_spanresume = document.getElementById("OldFileResume");
			var v_spancert = document.getElementById("OldFileCertificate");
			var v_spancont = document.getElementById("OldFileContractfile");

			// 변경된 파일이 있을 경우 플래그 처리
			if ( v_spanresume != null ) {
				if ( f.p_resume.value != "" && v_spanresume.style.display == "" ) {
					setOldFileFlag("0");
				}
			}
			if ( v_spancert != null ) {
				if ( f.p_certificate.value != "" && v_spancert.style.display == "" ) {
					setOldFileFlag("1");
				}
			}
			if ( v_spancont != null ) {
				if ( f.p_contractfile.value != "" && v_spancont.style.display == "" ) {
					setOldFileFlag("2");
				}
			}
		}

		// 튜터 권한이 있으면 반드시 사용기간을 명시해야 된다.
		var v_istutor = (f.p_istutor[0].checked) ? f.p_istutor[0].value : f.p_istutor[1].value;
		if ( v_istutor == "Y" ) {
			f.p_fmon.isNull = "N";
			f.p_tmon.isNull = "N";
		} else {
			f.p_istutor[1].checked = true;
			f.p_fmon.isNull = "Y";
			f.p_tmon.isNull = "Y";
		}
		
		// 사외튜터일 경우 아이디 중복체크를 했는지 체크
		if ( f.p_process.value == "W" && f.p_tutorgubun[1].checked == true && f.p_newmember.value =="Y" ) {
			if ( f.p_idcheck.value == "N" ) {
				alert ( "아이디 중복체크를 해 주십시요" );
				return;
			}
		}
		if ( f.p_comp.value == "" ) {
			alert ( "회사등록은 회사조회후 선택해 주세요." );
			return;
		}

		// 사내튜터 직접입력은 주민번호 유효성 체크 
		if ( f.p_process.value == "W" && f.p_tutorgubun[0].checked == true && f.p_newmember.value =="Y" ) {
			f.p_resno.value=f.p_resno1.value+f.p_resno2.value;
			if(!jsCheckJumin1(f.p_resno)) return;
		}		

		
	   	return true;
	}

	function tutorList() {
		document.location.href="/back/Tutor.do?cmd=tutorList";
	}

	function fileDown(rFile, sFile) {
		var f = document.form1;
		f.action		  = "/fileDownServlet";
		f.method		  = "get";
		f.rFileName.value = rFile;
		f.sFileName.value = sFile;
		f.filePath.value  = "/tutor";
		f.submit();
	}
	
</script>
</HEAD>
<BODY leftMargin="0" topMargin="0" marginheight="0" marginwidth="0" onload="jsInitPage();">
<form name="form1" action="/back/Tutor.do?cmd=tutorWrite" method="post" onSubmit="return false;" enctype="multipart/form-data">
<input type="hidden" name="cmd" value="tutorWrite">
<input type="hidden" name="p_tutortype" value="<%=v_tutortype %>">
<input type="hidden" name="p_process" value="<%=v_process %>">
<input type="hidden" name="p_museremail" value="">
<input type="hidden" name="p_comp" value="<%=boxTutorInfo.getString("COMP") %>">
<input type="hidden" name="p_delfile_flag" value="N,N,N,N" />
<input type="hidden" name="p_idcheck" value="" />
<input type="hidden" name="p_newmember" value="" />
<input type="hidden" name="p_filecnt" value="5" />

<input type="hidden" name="rFileName" value="">
<input type="hidden" name="sFileName" value="">
<input type="hidden" name="filePath" value="">

  <table width="100%" cellpadding="0" cellspacing="0">
  <tr>
	<td class="pad_left_15">
		<!-- 현재위치 -->
		<table width="985" cellpadding="0" cellspacing="0" class="mar_top_10">
		<tr>
			<td><%=s_menunavi %></td>
		</tr>
		</table>
		<!-- // -->

		<!-- 메뉴명 -->
		<table width="985" cellpadding="0" cellspacing="0" class="mar_top_10">
		<colgroup>
			<col width="10" />
			<col width="" />
			<col width="15" />
		</colgroup>
		<tr>
			<td><img src="/images/back/common/bullet_title.gif"></td>
			<td class="t_title">저자등록</td>
		</tr>
		</table>
		<!-- // -->

		<!-- 검색 조건 -->
		<table width="985" cellpadding="0" cellspacing="0" class="mar_top_5">
		<tr>
			<td class="border_gray02" align="center">
				<table width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td class="txt_b">
						<img src="/images/back/common/txt_padding.gif">
						저자구분 
						<input type="radio" name="p_tutorgubun" value="1" style="border:none;" onclick="selectTutorGubun('1');" <%=(v_tutorgubun.equals("1"))?" checked":"" %>> 사내저자
						<input type="radio" name="p_tutorgubun" value="2" style="border:none;" onclick="selectTutorGubun('2');" <%=(v_tutorgubun.equals("2"))?" checked":"" %>> 사외저자
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
		<!-- // -->

		<!-- 라벨 -->
		<table width="985" cellpadding="0" cellspacing="0" class="mar_top_15">
		<tr>
			<td width="15"><img src="/images/back/common/bullet_label.gif"></td>
			<td class="txt_black_b">기본정보</td>
		</tr>
		</table>

		<!-- 입력폼 -->
		<div class="board-view">
			<table width="985" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="100" />
				<col width="100" />
				<col width="350" />
				<col width="100" />
				<col width="300" />
			</colgroup>
			<tr>
				<th class="th_top_bd" rowspan="4">개인정보</th>
				<th class="th_top_bd01">성명</th>
				<td class="td_top_bd">
					<input type="radio" name="writeNameType" style="border:none;" onClick="setNewMember('Y')"> 직접입력
					<input type="radio" name="writeNameType" style="border:none;" onClick="setNewMember('N')"> 검색
					<input name="p_name" type="text" size="20" dispName="성명" isNull="N" lenCheck="20" maxLength="20" value="<%=boxTutorInfo.getString("NAME") %>"/>
					<a href="javascript:searchMember();"><img id="name_search_img" src="/images/back/common/icon_search.gif" align="absmiddle"></a>
					
				</td>
				<th class="th_top_bd">주민번호</th>
				<td class="td_top_bd">
					<div id="id_resno">
					<input name ="p_resno" type="Hidden" />
					<input name="p_resno1" type="text" size="6" dataType="integer" dispName="주민번호" isNull="Y" lenCheck="6" maxLength="6" value="<%=(v_resno.length()>=6)?v_resno.substring(0,6):"" %>"/>
					-
					<input name="p_resno2" type="text" size="7" dataType="integer" dispName="주민번호" isNull="Y" lenCheck="7" maxLength="7" value="<%=(v_resno.length()>=13)?v_resno.substring(6,13):"" %>"/>
					</div>
				</td>
			</tr>
			<tr>
				<th class="th_left_bd">회사</th>
				<td>
					<input name="p_compnm" type="text" size="20" dispName="회사명" isNull="Y" lenCheck="60" maxLength="60" value="<%=boxTutorInfo.getString("COMPNM") %>" readonly/>
					<fmtag:button type="4" name="comp_search_img" value="회사조회" func="searchCompList()" />
				</td>
				<th>직책</th>
				<td>
					<input name="p_jikcheknm" type="text" size="20" dispName="직책" isNull="Y" lenCheck="20" maxLength="20" value="<%=boxTutorInfo.getString("JIKCHEKNM") %>"/>
				</td>
			</tr>
			<tr>
				<th class="th_left_bd">주소</th>
				<td>
					<% if( boxTutorInfo.getString("POST2")  == null || boxTutorInfo.getString("POST2").equals("")){ %>
						<input name="p_post1" type="text" size="3" dataType="integer" dispName="우편번호" isNull="Y" maxLength="5" value="<%=boxTutorInfo.getString("POST1") %>" readonly="readonly"/>
						<input name="p_post2" type="hidden" size="3" dispName="우편번호" value="<%=boxTutorInfo.getString("POST2") %>"/>
					<% } else { %>
						<input name="p_post1" type="text" size="3" dataType="integer" dispName="우편번호" isNull="Y" maxLength="5" value="<%=boxTutorInfo.getString("POST1") %>" readonly="readonly"/>
						-
						<input name="p_post2" type="text" size="3" dispName="우편번호" value="<%=boxTutorInfo.getString("POST2") %>" readonly="readonly"/>
					<% } %>
					<a href="#none" onclick="searchZipCode('home')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a>
					<input name="p_addr" type="text" size="50" dispName="주소" isNull="Y" lenCheck="100" maxLength="100" value="<%=boxTutorInfo.getString("ADDR") %>"/>
				</td>
				<th>이메일</th>
				<td>
					<input name="p_email" type="text" size="30" dispName="이메일" isNull="Y" lenCheck="50" maxLength="50" value="<%=boxTutorInfo.getString("EMAIL") %>"/>
				</td>
			</tr>
			<tr>
<%
	String[] arrAreaCode = new String[] {"02","031","032","033","041","042","043","051","052","053","054","055","061","063","064"};
	String[] arrCellAreaCode = new String[] {"010","011","016","017","018","019"};
	String[] arrPhone = boxTutorInfo.getString("PHONE").split("-");
	String[] arrHandPhone = boxTutorInfo.getString("HANDPHONE").split("-");
%>
				<th class="th_left_bd">연락처<br/>(사무실)</th>
				<td>
					<select name="p_phone1">
<%	for ( int i=0; i < arrAreaCode.length; i++ ) { %>
					<option value="<%=arrAreaCode[i] %>"<%=arrPhone.length!=0&&(arrPhone[0].equals(arrAreaCode[i]))?" selected":"" %>><%=arrAreaCode[i]%></option>
<%	}%>
					</select>
					-
					<input name="p_phone2" type="text" size="4" dataType="integer" dispName="연락처" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>=2)?arrPhone[1]:"" %>"/>
					-
					<input name="p_phone3" type="text" size="4" dataType="integer" dispName="연락처" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>=3)?arrPhone[2]:"" %>"/>
				</td>
				<th>HP</th>
				<td>
					<select name="p_handphone1">
<%	for ( int i=0; i < arrCellAreaCode.length; i++ ) { %>
					<option value="<%=arrCellAreaCode[i] %>"<%=arrHandPhone.length!=0&&(arrHandPhone[0].equals(arrCellAreaCode[i]))?" selected":"" %>><%=arrCellAreaCode[i]%></option>
<%	}%>
					</select>
					-
					<input name="p_handphone2" type="text" size="4" dataType="integer" dispName="핸드폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=2)?arrHandPhone[1]:"" %>"/>
					-
					<input name="p_handphone3" type="text" size="4" dataType="integer" dispName="핸드폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=3)?arrHandPhone[2]:"" %>"/>
				</td>
			</tr>
			<tr>
				<th colspan="2">아이디</th>
				<td>
					<input name="p_userid" type="text" size="20" dispName="아이디" isNull="N" lenCheck="20" maxLength="20" value="<%=boxTutorInfo.getString("USERID") %>" readonly/>
					<fmtag:button type="4" name="id_search_img" value="중복체크" func="userIdCheck()" />
				</td>
				<th>비밀번호</th>
				<td>
					<input name="p_pwd" type="password" size="20" dispName="비밀번호" isNull="N" lenCheck="20" maxLength="20" value="<%=boxTutorInfo.getString("PWD") %>" readonly/>
				</td>
			</tr>
			<tr>
				<th colspan="2">최종학력</th>
				<td>
					<%=CommonUtil.getCodeListBox("select","0079","p_academic",boxTutorInfo.getString("ACADEMIC"),"","-선택-")%>
				</td>
				<th>전공</th>
				<td>
					<input type="text" name="p_major"  size="20"  dispName="전공" isNull="N" lenCheck="200" maxLength="200" value="<%=boxTutorInfo.getString("MAJOR") %>"><br/>
				</td>
			</tr>
			<tr>
				<th colspan="2">경력사항</th>
				<td colspan="3">
					<textarea name="p_career" cols="130" rows="5" dispName="경력사항" isNull="Y" lenCheck="1000" maxLength="1000"><%=boxTutorInfo.getString("CARRER") %></textarea><br/>
					<input name="p_careeryear" type="text" size="10" dataType="integer" dispName="경력사항" isNull="Y" lenCheck="30" maxLength="30" value="<%=boxTutorInfo.getString("CAREERYEAR") %>"/> 년
					<input name="p_careermonth" type="text" size="10" dataType="integer" dispName="경력사항" isNull="Y" lenCheck="30" maxLength="30" value="<%=boxTutorInfo.getString("CAREERMONTH") %>"/> 개월
				</td>
			</tr>	
			<tr>
				<th colspan="2">저자권한</th>
				<td colspan="3">
					<input type="radio" name="p_istutor" value="Y" style="border:none;"<%=(boxTutorInfo.getStringDefault("ISTUTOR", "Y").equals("Y"))?" checked":"" %>> YES
					<input type="radio" name="p_istutor" value="N" style="border:none;"<%=(boxTutorInfo.getString("ISTUTOR").equals("N"))?" checked":"" %>> NO
				</td>
			</tr>
			<tr>
				<th colspan="2">권한사용기간</th>
				<td colspan="3">
					<fmtag:calendar seq="1" name="form1" property="p_fmon" date="<%=v_fmon %>" dispName="시작일" defaultYn="N" isNull="N" position="right"/> ~
					<fmtag:calendar seq="2" name="form1" property="p_tmon" date="<%=v_tmon %>" dispName="마감일" defaultYn="N" isNull="N" position="right"/>
				</td>
			</tr>
			<tr>
				<th colspan="2">저자계약서</th>	
				<td colspan="3">
				  <table border="0" cellspacing="0" cellpadding="0">
				  	<td>
						<% 
							if( dsTutorContractFile !=null )  {								
								while( dsTutorContractFile.next() ) {									
									out.println( "&nbsp; <a href='#' onClick=\"fileDown('"+ dsTutorContractFile.getString("REALFILE")+"','"+ dsTutorContractFile.getString("SAVEFILE")+"')\"><img src='/images/back/icon/icon_file.gif'>"+dsTutorContractFile.getString("REALFILE")+"</a>" );	
								}
							}
						%>
					</td>
				  </tr>
				  <tr>
					<td><%=CommonUtil.getMultiFileupload("uploadClass1","p_contractfile", 5, fileList, null, "570") %></td>
				  </tr>
				  </table>
				  <span class="pl5">※ 한 게시물당 최대  <B>100MB</B>까지 파일을 올리실 수 있습니다.</span>
			  </td>
			</tr>			
			<tr>
				<th colspan="2">은행명</th>
				<td>
					<input name="p_banknm" type="text" size="18" dispName="은행명" isNull="Y" lenCheck="30" maxLength="30" value="<%=boxTutorInfo.getString("BANKNM") %>"/>
				</td>				
				<th>계좌번호</th>
				<td>
					<input name="p_bankaccount" type="text" size="18" dispName="계좌번호" isNull="Y" lenCheck="20" maxLength="20" value="<%=boxTutorInfo.getString("BANKACCOUNT") %>"/>
				</td>
			</tr>
			</table>
		</div>
		<!-- // -->

		<!-- 버튼 -->
		<table width="985" border="0" cellpadding="0" cellspacing="0" class="mar_top_10">
		<colgroup>
			<col width="" />
		</colgroup>
		<tr>
			<td align="center">
<%	if ( s_menucontrol.equals("RW") ) {
		if ( v_process.equals("W") ) { %>
				<fmtag:button type="1" value="등록" func="tutorWrite('W')" />
<%		} else if ( v_process.equals("E") ) { %>
				<fmtag:button type="1" value="수정" func="tutorWrite('E')" />
				<fmtag:button type="1" value="삭제" func="tutorDelete()" />
<%		}
	}
%>
				<fmtag:button type="1" value="취소" func="tutorList()" />
			</td>
		</tr>
		</table>
		<!-- // -->

		<!-- 공백 -->
		<table width="985" cellpadding="0" cellspacing="0" class="mar_top_20">
		<tr><td></td></tr>
		</table>

	<!-- // -->
	</form>
  <!--푸터부분 시작-->
  <%@ include file = "/jsp/back/common/bottom.jsp"%>
  <!--푸터부분 끝-->