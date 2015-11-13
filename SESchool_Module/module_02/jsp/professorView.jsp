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

	String	lvOrder1[]			=	{"GUBUN ASC, GUBUNNM ASC", "GUBUNNM ASC, GUBUN ASC"};
	String	lvOrder2[]			=	{"GUBUN DESC, GUBUNNM ASC","GUBUNNM DESC, GUBUN ASC"};

	String v_pageno   	= StringUtil.nvl(box.getString("p_pageno"),"1");
	String v_listscale	= StringUtil.nvl(box.getString("p_listscale"),"1000");
	String v_sortorder	= StringUtil.nvl(box.getString("p_topsortorder"),lvOrder1[0]);


	String v_gadmin = box.getStringDefault("s_gadmin","00"); //권한코드
	String v0_gadmin = v_gadmin.substring(0,1); //권한코드앞자리

	String v_tabnum = box.getStringDefault("p_tabnum", "1");	
	
	Box boxTutorInfo 	= (Box)box.getObject("boxTutorInfo");
	
	String v_tutorgubun = StringUtil.nvl(boxTutorInfo.getString("TUTORGUBUN"),"1");	
	String v_tutortype 	= StringUtil.nvl(box.getString("p_tutortype"),"P");
	String v_trainingclass 	= box.getString("p_trainingclass");
	
	
	String v_name = boxTutorInfo.getString("NAME");
	String v_resno = boxTutorInfo.getString("RESNO");
	String v_compnm = boxTutorInfo.getString("COMPNM");
	String v_comp = boxTutorInfo.getString("COMP");
	String v_jikcheknm = boxTutorInfo.getString("JIKCHEKNM");
	String v_post1 = boxTutorInfo.getString("POST1");
	String v_post2 = boxTutorInfo.getString("POST2");
	String v_addr = boxTutorInfo.getString("ADDR");
	String v_phone = boxTutorInfo.getString("PHONE");
	String v_handphone = boxTutorInfo.getString("HANDPHONE");
	String v_email = boxTutorInfo.getString("EMAIL");
	String v_userid = boxTutorInfo.getString("USERID");
	String v_pwd = boxTutorInfo.getString("PWD");
	String v_photo = boxTutorInfo.getString("PHOTO");

	String v_istutor = boxTutorInfo.getString("ISTUTOR");
	String v_fmon = StringUtil.nvl(boxTutorInfo.getString("FMON"));
	String v_tmon = StringUtil.nvl(boxTutorInfo.getString("TMON"));		
	String v_realresume = boxTutorInfo.getString("REALRESUME");
	String v_realcertificate = boxTutorInfo.getString("REALCERTIFICATE");
	String v_fielddegree = boxTutorInfo.getString("FIELDDEGREE");
	String v_fieldcareer = boxTutorInfo.getString("FIELDCAREER");
	String v_fieldcerti = boxTutorInfo.getString("FIELDCERTI");
	String v_tutorscore = boxTutorInfo.getString("TUTURSCORE");
	String v_banknm = boxTutorInfo.getString("BANKNM");
	String v_bankaccount = boxTutorInfo.getString("BANKACCOUNT");
	
	String v_teachField = boxTutorInfo.getString("TEACHFIELD");
	String v_teachYN = boxTutorInfo.getString("TEACHYN");
	
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
	
	String v_searchgubun = box.getStringDefault("p_searchgubun","USERID"); //검색구분
	String v_searchtxt = box.getString("p_searchtxt");	
	if(v_searchtxt.equals("")) v_searchtxt = v_userid;	
	
	String currentDate = DateTimeUtil.getDate();	
	String preDate = DateTimeUtil.getAddDate(-365);
	
%>
<fmtag:csscommon point="back" />
<fmtag:jscommon />
<fmtag:dwrcommon interfaceName="CommonUtilWork"/>
<fmtag:dwrcommon interfaceName="TutorWork"/>
<script language="Javascript" src="/js/common/util.js"></script>
<script type="text/javascript" src="/js/common/calendar.js"></script>
<script language="Javascript" src="/js/common/fileupload.js"></script>
<script type="text/javascript">
	var v_tutorobj = ""; 
	
	function goTabMenu( v_tabnum ) {
		var f = document.form1;
		f.target = "";
		if(f.p_userid.value=='') {
			alert('이름 , 아이디 혹은 주민번호를  넣고 검색하세요.');
			f.p_searchtxt.focus();
			return;
		}
		f.p_tabnum.value = v_tabnum;
		$("tblButton1").hide();
		$("tblButton2").hide();
		$("tblButton3").hide();
		$("tblButton4").hide();
		$("infoDiv").hide();
		$("sulDiv").hide();
		
		for ( var i=1; i <= 5; i++ ) {
			if(v_tabnum == i) {
				$("tabmenu" + i).removeClassName("tabmenu");
				$("tabmenu" + i).addClassName("tabmenu_over");
			} else {
				$("tabmenu" + i).removeClassName("tabmenu_over");
				$("tabmenu" + i).addClassName("tabmenu");
			}
		}

		$("ListBox").update("");
	
		var param = {p_userid:f.p_userid.value
					,p_searchtxt:f.p_searchtxt.value
					,p_listscale:1000
					,p_pageno:1
					};
		switch ( v_tabnum ) {
		case "1": //강의경력
			tblInit();						
			TutorWork.tutorCareerListCallBack(param,jsMainListCall);
			displayWorkProgress();
			$("tblButton1").show();
			break;
		case "2": //강의이력
			tblInit2();	
			TutorWork.tutorLectureHistoryListCallBack(param,jsMainListCall2);		
			//CompleteStatusWork.personalStudentListCallBack(param,jsMainListCall2);
			displayWorkProgress();
			$("tblButton2").show();
			break;
		case "3": //평가,강의료
			$("sulDiv").show();	
			tblInit3();
			$("tblButton3").show();
			selectedGYear();
			jsMainList3();
			break;
		case "4": //메모
			tblInit4();			
			TutorWork.tutorMemoListCallBack(param,jsMainListCall4);
			displayWorkProgress();
			$("tblButton4").show();
			break;
		
		case "5": //기타정보
			$("infoDiv").show();			
			break;
			
		case "6": //월간일정 _ 추가_2013.11.13
			tblInit5();
			TutorWork.tutorMonthScheduleListCallBack(param,jsMainListCall5);
			break;
			
		default:
			break;
		
		
			
		}
	}

	//검색
	function fncSearch()
	{
		var f = document.searchForm;
		
		if(f.p_searchtxt.value=='')
		{
			alert('이름  혹은 아이디를  넣고 검색하세요.');
			f.p_searchtxt.focus();
			return;
		}
		f.target = "";
		f.enctype = "";		
		f.action = "/back/Tutor.do";
		f.method = "POST";
		f.cmd.value = "tutorView";
		f.submit();
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

	function jsInitPage() {
		var f = document.form1;
		var v_gubun = "<%=v_tutorgubun %>";
		var v_idresno  = document.getElementById("id_resno");  
		var v_process = f.p_process.value;
		var v_compsearchimg = document.getElementById("comp_search_img");
		
		v_tutorobj = {
				"p_name"		: f.p_name.value,		// 성명
				"p_resno1"		: f.p_resno1.value,		// 주민번호1
			//	"p_resno2"		: f.p_resno2.value,		// 주민번호2   //수정 2013.10.17
				"p_userid"		: f.p_userid.value,		// 아이디
				"p_pwd"			: f.p_pwd.value			// 비밀번호
		};
		
		if ( v_gubun == "1" ) {			
			v_idresno.style.display = "";
		} else if ( v_gubun == "2" ) {
			v_idresno.style.display = "none";
		}
		for ( var key in v_tutorobj ) {
			f[key].onkeydown = alertInfo
			f[key].readOnly = true;
		}
		v_compsearchimg.style.display = "none";

		if(f.p_userid.value != "") {
			goTabMenu("<%=v_tabnum%>");
		}
	} 
	
	function alertInfo() {
		alert ( '해당 페이지에서는 변경할수 없습니다.' );
	}

	// 교수자내용을 수정한다.
	function tutorWrite( v_process ) {
	
		var f = document.form1;
		f.p_process.value = v_process;
		if(!validateEtc(f)) return;
		if(!validate(f)) return;
	 
		f.p_comp.value = f.p_compnm.value; /* 추가 _2013.11.13회사 코드가 아닌 회사명을 받아옴*/
		
		f.method = "post";
		f.target = "";
		f.enctype = "multipart/form-data";
		f.action = "/back/Tutor.do?cmd=tutorWrite";
		f.cmd.value = "tutorWrite";
		f.p_process.value = v_process;

		f.submit();
	}

	function validateEtc(f) {
		if ( f.p_process.value == "PE2" ) {

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

			// 튜터 권한이 있으면 반드시 사용기간을 명시해야 된다.
			var v_istutor = (f.p_istutor[0].checked) ? f.p_istutor[0].value : f.p_istutor[1].value;
			if ( v_istutor == "Y" ) {
				f.p_fmon.isNull = "N";
				f.p_tmon.isNull = "N";

				if( (f.p_fmon.value != "" && f.p_tmon.value != "") &&  f.p_tmon.value <= f.p_fmon.value) {
						alert("마감일은 시작일보다 뒷 날짜여야 합니다.");
						return false; 
				}
				
			} else {
				f.p_istutor[1].checked = true;
				f.p_fmon.isNull = "Y";
				f.p_tmon.isNull = "Y";
			}

			if ( f.p_filecnt.value > 0 ) {
			   	// submit 호출되기전에 한번 호출해주어야 함 - 파일업로드 아이디 정렬
		       	uploadClass1.change_id();
			}
		}else {
			f.p_fmon.isNull = "Y";
			f.p_tmon.isNull = "Y";
		}		
	   	return true;
	}
	function setOldFileFlag( target ) {

		var f = document.form1;

		var v_spanobj = "";
		var v_delfile_flag = f.p_delfile_flag.value;
		if ( v_delfile_flag == "" ) {
			// 이력서, 증명서, 사진 
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

	// 교수자점수 계산
	function setTutorScore() {
		var f = document.form1;

		var v_fielddegree = f.p_fielddegree;
		var v_fieldcareer = f.p_fieldcareer;
		var v_fieldcerti = f.p_fieldcerti;
		var v_tutorscore = f.p_tutorscore;

		var v_score = 0;

		// 관련분야 학위는
		// 학사 1점
		// 석사 2점
		// 박사 3점
		if ( v_fielddegree.value == "1" ) {
			v_score += 1;
		} else if ( v_fielddegree.value == "2" ) {
			v_score += 2;
		} else if ( v_fielddegree.value == "3" ) {
			v_score += 3;
		}

		// 경력은
		// 3년   1점
		// 5년   2점
		// 10년 3점
		if ( v_fieldcareer.value == "3" ) {
			v_score += 1;
		} else if ( v_fieldcareer.value == "5" ) {
			v_score += 2;
		} else if ( v_fieldcareer.value == "10" ) {
			v_score += 3;
		}

		// 자격증은 한개당 0.5점
		v_score += (v_fieldcerti.value * 0.5 );

		v_tutorscore.value = v_score;
	}		
	function careerWritePopup(v_proc, v_seq){
		var f = document.form1;
		var url = "/back/Tutor.do?cmd=tutorCareerWriteForm&p_proc="+v_proc+"&p_userid=<%=v_userid %>&p_seq="+v_seq;
		Center_Fixed_Popup2(url, "tutorCareer", 510, 430, "no");	
	}
	function careerDelete(v_seq){
		var f = document.form2;
		
		f.action = "/back/Tutor.do?cmd=tutorCareerWrite";
		f.cmd.value = "tutorCareerWrite";
		f.p_proc.value = "D";
		f.p_seq.value = v_seq;
		f.p_userid.value = "<%=v_userid %>";		
		f.submit();
		
	    
	}
		
	function careerExcelDown(){
		var f = document.form2;
		
		f.action = "/back/Tutor.do";
	    f.cmd.value="tutorCareerExcelDown";
	    f.target = "hiddenFrame";
	    f.submit();
	    f.cmd.value="tutorView";
	    f.target = "";		
	    
	}
	// 강의이력 엑셀 다운 
	function lectureHistoryExcelDown(){
		var f = document.form2;
		
		f.action = "/back/Tutor.do";
	    f.cmd.value="lectureHistoryExcelDown";
	    f.target = "hiddenFrame";
	    f.submit();
	    f.cmd.value="tutorView";
	    f.target = "";		
	    
	}
	
	function memoWritePopup(v_proc, v_seq){
		var f = document.form1;
		var url = "/back/Tutor.do?cmd=tutorMemoWriteForm&p_proc="+v_proc+"&p_userid=<%=v_userid %>&p_seq="+v_seq;
		Center_Fixed_Popup2(url, "tutorMemo", 510, 380, "no");	
	}
	
	function tutorDelete() {

		var f = document.form1;

		f.method = "post";
		f.target = "";
		f.enctype = "multipart/form-data";
		f.action = "/back/Tutor.do?cmd=tutorWrite";
		f.cmd.value = "tutorWrite";
		f.p_process.value = "D";

		f.submit();
	}
	
	function tutorList() {
		document.location.href="/back/Tutor.do?cmd=tutorList";
	}
	
</script>
<script language='javascript'>
	var tm;

	function tblInit(){
		headerInfos			=	new Array();

		tableInfo			=	new TableInfo({tableName:"", tableId:"ajaxTable", width:"985", headerClass:"colresize", tableAlign:"left", topColor:"02", topHeight:"45",rowYn:"Y"});
		idx = 0;
		headerInfos[idx]		=	new HeaderInfo(idx, {colName:"No", 		width:"40",  colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"강의명", 		width:"200", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"강의내용",	width:"400", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"교육기관",	width:"120", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"강의기간",	width:"150", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"삭제",	width:"70", colNo:idx,colAlign:"center",colClass:"ellipsis"});

		datas				=	new Array();
		this.tm				=	new TableManager($("ListBox"),tableInfo, headerInfos, datas);
	}

	function tblInit2(){
		headerInfos			=	new Array();

		tableInfo			=	new TableInfo({tableName:"", tableId:"ajaxTable", width:"985", headerClass:"colresize", tableAlign:"left", topColor:"02", topHeight:"45",rowYn:"Y"});
		idx = 0;
		headerInfos[idx]		=	new HeaderInfo(idx, {colName:"No", 		width:"40",  colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"연수과정", 		width:"100", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"과정명",	width:"150", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"과정코드",	width:"80", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"과정기수",	width:"80", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"과정기수<br/>코드",	width:"80", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"과목명",	width:"150", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"과목기수",	width:"80", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"교육날짜",	width:"100", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"강의시간",	width:"80", colNo:idx,colAlign:"center",colClass:"ellipsis"});

		datas				=	new Array();
		this.tm				=	new TableManager($("ListBox"),tableInfo, headerInfos, datas);
	}

	function tblInit3(){
		headerInfos			=	new Array();

		tableInfo			=	new TableInfo({tableName:"", tableId:"ajaxTable", width:"1200", headerClass:"colresize", tableAlign:"left", topColor:"02", topHeight:"35",rowYn:"Y"});
		idx = 0;
		headerInfos[idx]		=	new HeaderInfo(idx, {colName:"No", 		width:"40",  colNo:idx,colAlign:"center",colClass:"ellipsis",rowSpan:2});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"연수과정", 	width:"70", colNo:idx,colAlign:"center",colClass:"ellipsis",rowSpan:2});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"과정명",	width:"150", colNo:idx,colAlign:"center",colClass:"ellipsis",rowSpan:2});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"과정<br/>코드",	width:"40", colNo:idx,colAlign:"center",colClass:"ellipsis",rowSpan:2});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"과정<br/>기수",	width:"40", colNo:idx,colAlign:"center",colClass:"ellipsis",rowSpan:2});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"과정<br/>기수코드",	width:"60", colNo:idx,colAlign:"center",colClass:"ellipsis",rowSpan:2});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"과목명",	width:"150", colNo:idx,colAlign:"center",colClass:"ellipsis",rowSpan:2});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"과목<br/>코드",	width:"40", colNo:idx,colAlign:"center",colClass:"ellipsis",rowSpan:2});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"과목<br/>기수",	width:"40", colNo:idx,colAlign:"center",colClass:"ellipsis",rowSpan:2});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"교육기간",	width:"150", colNo:idx,colAlign:"center",colClass:"ellipsis",rowSpan:2});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"강의<br/>시간",	width:"40", colNo:idx,colAlign:"center",colClass:"ellipsis",rowSpan:2});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"전문<br/>지식",	width:"40", colNo:idx,colAlign:"center",colClass:"ellipsis",colSpan:5,colSpanName:"교육생평가"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"강의<br/>기법",	width:"40", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"준비성/태도",	width:"50", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"총평과 결과",	width:"40", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		//headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"교수자<br/>평가",	width:"50", colNo:idx,colAlign:"center",colClass:"ellipsis"});
/* 		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"강사<br/>평가",	width:"50", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"코멘트",	width:"40", colNo:idx,colAlign:"center",colClass:"ellipsis"}); */
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"등급",	width:"60", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"강의료",	width:"60", colNo:idx,colAlign:"center",colClass:"ellipsis",rowSpan:2});

		datas				=	new Array();
		this.tm				=	new TableManager($("ListBox2"),tableInfo, headerInfos, datas);
	}
	
	function tblInit4(){
		headerInfos			=	new Array();

		tableInfo			=	new TableInfo({tableName:"", tableId:"ajaxTable", width:"985", headerClass:"colresize", tableAlign:"left", topColor:"02", topHeight:"45",rowYn:"Y"});
		idx = 0;
		headerInfos[idx]		=	new HeaderInfo(idx, {colName:"No", 		width:"40",  colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"제목", 		width:"200", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"내용",	width:"470", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"첨부파일",	width:"70", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"작성자",	width:"100", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"작성일자",	width:"100", colNo:idx,colAlign:"center",colClass:"ellipsis"});

		datas				=	new Array();
		this.tm				=	new TableManager($("ListBox"),tableInfo, headerInfos, datas);
	}
	
	function tblInit5(){				//추가_2013.11.13 _  월간일정
		headerInfos = new Array();
		
		tableInfo = new TableInfo({tableName:"", tableId:"ajaxTable", width:"985", headerClass:"colresize", tableAlign:"left", topColor:"02", topHeight:"45",rowYn:"Y"});
		idx = 0;
		headerInfos[idx]		=	new HeaderInfo(idx, {colName:"No", 		width:"40",  colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"일자",	width:"100", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"시간",	width:"100", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"제목", 		width:"200", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		//headerInfos[++idx]		=	new HeaderInfo(idx, {colName:"내용",	width:"470", colNo:idx,colAlign:"center",colClass:"ellipsis"});
		
		datas				=	new Array();
		this.tm				=	new TableManager($("ListBox"),tableInfo, headerInfos, datas);
		
		
	}

	function jsMainListCall(ds){ // 강의경력
		var f				=	document.form1;
		tm.deleteAllRow();

		var lstIndex		=	0;
        var info;
        var row				=	new Array();
		var idx = 0;     	
			    
		if(ds != null && ds.length > 0){			
			for(var i = 0; i < ds.length;i++){
				idx = 0; 
			    info		=	ds[i];

				row[idx]		=	i+1;
				row[++idx]		=	"<a href='#' onClick=\"careerWritePopup(\'E\',\'" + info["SEQ"] + "\')\">"+info["LETURENM"]+"</a>";
				row[++idx]		=	info["LECTUREDESC"];
				row[++idx]		=	info["EDUORG"];				
				row[++idx]		=	addDateFormatStr(info["STARTDT"])+"~"+addDateFormatStr(info["ENDDT"]);
				row[++idx]		=	"<fmtag:button type='5' value='경력삭제' func='careerDelete(\'" + info["SEQ"] + "\')'/>";

				tm.addRow(row);
			}
		}else{
			tm.addRow(row);
		}
		tm.resizeTable();
		//- 작업중 표시 닫기
		closeWorkProgress();
	}

	function jsMainListCall2(ds){ // 강의이력
		var f				=	document.form1;
		tm.deleteAllRow();

		var lstIndex		=	0;
        var info;
        var row				=	new Array();
		var idx = 0;     	
			    
		if(ds != null && ds.length > 0){			
			for(var i = 0; i < ds.length;i++){
				idx = 0; 
			    info		=	ds[i];
			    
				row[idx]		=	i+1;
				row[++idx]		=	info["TRAININGCLASSNM"];
				row[++idx]		=	info["COURSENM"];
				row[++idx]		=	info["COURSE"];				
				row[++idx]		=	info["COURSESEQNM"];
				row[++idx]		=	info["COURSESEQ"];
				row[++idx]		=	info["SUBJNM"];
				row[++idx]		=	info["SUBJSEQNM"];				
				row[++idx]		=	addDateFormatStr(info["EDUDATE"]);
				row[++idx]		=	info["LECTURETIME"];
				
				tm.addRow(row);
			}
		}else{
			tm.addRow(row);
		}

        //tm.setSortMark(f.p_sortorder.value);
		tm.resizeTable();

		//- 작업중 표시 닫기
		closeWorkProgress();
	}
	
	function jsMainListCall4(ds){ // 메모
		var f				=	document.form1;
		tm.deleteAllRow();
		var lstIndex		=	0;
        var info;
        var row				=	new Array();
		var idx = 0;     	
		var filedown = "";	    
		if(ds != null && ds.length > 0){			
			for(var i = 0; i < ds.length;i++){
				idx = 0; 
			    info		=	ds[i];	
			    
			    filedown    = 	jsNvl(info["REALFILE"])!="" ? "<a href='#' onclick=\"fileDownMemo('"+info["REALFILE"]+"', '"+info["SAVEFILE"]+"')\"><img src='/images/back/icon/icon_file.gif' border='0'></a>":""    
				row[idx]		=	i+1;
				row[++idx]		=	"<a href='#' onClick=\"memoWritePopup(\'E\',\'" + info["SEQ"] + "\')\">"+info["TITLE"]+"</a>";				
				row[++idx]		=	info["CONTENTS"];
				row[++idx]		=	filedown;				
				row[++idx]		=	info["NAME"];
				row[++idx]		=	addDateFormatStr(info["INDATE"]);
				tm.addRow(row);
			}
		}else{
			tm.addRow(row);
		}
		tm.resizeTable();
		closeWorkProgress();
	}
	
	//월간일정 콜백 메서드
	function jsMainListCall5(ds){
		var f = document.form1;
		tm.deleteAllRow();
		var lstIndex		=	0;
        var info;
        var row				=	new Array();
		var idx = 0;     	
		var filedown = "";	    
		if(ds != null && ds.length > 0){			
			for(var i = 0; i < ds.length;i++){
				idx = 0; 
			    info		=	ds[i];	
			    
			  /*   filedown    = 	jsNvl(info["REALFILE"])!="" ? "<a href='#' onclick=\"fileDownMemo('"+info["REALFILE"]+"', '"+info["SAVEFILE"]+"')\"><img src='/images/back/icon/icon_file.gif' border='0'></a>":""    */
				row[idx]		=	i+1;
				row[++idx]		=	"<a href='#' onClick=\"memoWritePopup(\'E\',\'" + info["SEQ"] + "\')\">"+info["TITLE"]+"</a>";				
				row[++idx]		=	info["CONTENTS"];
				row[++idx]		=	filedown;				
				row[++idx]		=	info["NAME"];
				row[++idx]		=	addDateFormatStr(info["INDATE"]); 
				
				
				tm.addRow(row);
			}
		}else{
			tm.addRow(row);
		}
		tm.resizeTable();
		closeWorkProgress();
		
		
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
	function fileDownMemo(rFile, sFile) {
		var f = document.form1;
		f.action		  = "/fileDownServlet";
		f.method		  = "get";
		f.rFileName.value = rFile;
		f.sFileName.value = sFile;
		f.filePath.value  = "/tutorMemo";
		f.submit();
	}
	
	
	// 교육 분야 추가
	function addTeachFieldCode() {
		var url = "/back/Code.do?cmd=codeList&p_gubun=0122";
		
		if( confirm('교육분야 코드를 추가하시겠습니까? 추가 후, 새로고침(F5) 를 해 주셔야 반영됩니다.')) {
			Center_Fixed_Popup2(url, "addTeachFieldCode", 1030, 550, "no");
		}
	}
</script>	
<style>
/* 탭메뉴 링크 */
.tabmenu			{float:left; width:130px; background:url('/images/back/common/tabmenu_out.gif') no-repeat; cursor:pointer;}

.tabmenu_over		{float:left; width:130px; background:url('/images/back/common/tabmenu_over.gif') no-repeat; cursor:pointer;}
</style>
</HEAD>
<BODY leftMargin="0" topMargin="0" marginheight="0" marginwidth="0" onload="jsInitPage();">


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
		
		<form name="searchForm" action="/back/Tutor.do?cmd=tutorWrite" method="post" onSubmit="return false;">
		<input type="hidden" name="cmd" value="tutorWrite">
		<input type="hidden" name="p_tutortype" value="<%=v_tutortype %>">
		<input type="hidden" name="p_process" value="PE1">
		<input type="hidden" name="p_comp" value="<%=v_comp%>">
		<input type="hidden" name="p_delfile_flag" value="N,N,N,N" />
		<input type="hidden" name="p_filecnt" value="5" />
		<input type="hidden" name="p_tabnum" value="" />
		<input type="hidden" name="p_tutorgubun" value="<%=v_tutorgubun %>" />

		<input type="hidden" name="p_pageno" 	value="<%=v_pageno%>">
		<input type="hidden" name="p_sortorder" value="<%=v_sortorder%>">
			
		<input type="hidden" name="rFileName" value="">
		<input type="hidden" name="sFileName" value="">
		<input type="hidden" name="filePath" value="">
		
		
		<!-- 메뉴명 -->
		<table width="985" cellpadding="0" cellspacing="0" class="mar_top_10">
		<colgroup>
			<col width="10" />
			<col width="" />
			<col width="15" />
		</colgroup>
		<tr>
			<td><img src="/images/back/common/bullet_title.gif"></td>
			<td class="t_title">강사관리</td>
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
						◈성명, ID, 주민번호를 입력하세요
						 
						<select name="v_searchgubun">
							<option value ="" <%=(v_searchgubun.equals(""))?"selected":"" %>>--All--</option>
							<option value ="NAME" <%=(v_searchgubun.equals("NAME"))?"selected":"" %>>성명</option>
							<option value ="USERID" <%=(v_searchgubun.equals("USERID"))?"selected":"" %>>ID</option>
							<option value ="RESNO" <%=(v_searchgubun.equals("RESNO"))?"selected":"" %>>주민번호</option>
						</select>  
						<input name="p_searchtxt" type="text" size="15" dispName="검색어" isNull="Y" lenCheck="100" maxLength="100" value="<%=v_searchtxt%>"/>
						<fmtag:button type="2" value="검색" func="fncSearch()"/>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
		<!-- // -->		
		</form>
		<form name="form1" action="/back/Tutor.do?cmd=tutorWrite" method="post" onSubmit="return false;" enctype="multipart/form-data">
		<input type="hidden" name="cmd" value="tutorWrite">
		<input type="hidden" name="p_tutortype" value="<%=v_tutortype %>">
		<input type="hidden" name="p_process" value="PE1">
		<input type="hidden" name="p_comp" value="<%=v_comp%>">
		<input type="hidden" name="p_delfile_flag" value="N,N,N,N" />
		<input type="hidden" name="p_filecnt" value="5" />
		<input type="hidden" name="p_tabnum" value="" />
		<input type="hidden" name="p_tutorgubun" value="<%=v_tutorgubun %>" />

		<input type="hidden" name="p_pageno" 	value="<%=v_pageno%>">
		<input type="hidden" name="p_sortorder" value="<%=v_sortorder%>">
			
		<input type="hidden" name="rFileName" value="">
		<input type="hidden" name="sFileName" value="">
		<input type="hidden" name="filePath" value="">
		<input type="hidden" name="p_searchtxt" value="<%=v_userid%>"/>
		
		


		<!-- 저장버튼 -->
		<table width="985" cellpadding="0" cellspacing="0" class="mar_top_10">		
		<tr>
			<td align="right">
			<%	if ( s_menucontrol.equals("RW") ) { %>
				<fmtag:button type="1" value="저장" func="tutorWrite('PE1')" />
				<fmtag:button type="1" value="삭제" func="tutorDelete()" />
			<%		
				}
			%>
			</td>
			
		</tr>
		</table>
		<!-- // -->
		
		<!-- 입력폼 -->
		<div class="board-view">
			<table width="985" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="170" />
				<col width="100" />
				<col width="300" />
				<col width="100" />
				<col width="200" />
			</colgroup>
			<tr>
				<td class="td_top_bd01" rowspan="5">
				<%	if ( !v_photo.equals("") ) { %>
					<img src="/upload/tutor/<%=v_photo%>"  width="100" height="100" ></img><br>
				<% 	} else {out.println("<br/><br/>");}%>
					사진 <input type="file" name="p_photo" value="" style="width:150px; height:18px; background-color:#FFFFFF;">
				</td>
				<th class="th_top_bd01">성명</th>
				<td class="td_top_bd">					
					<input name="p_name" type="text" size="20" dispName="성명" isNull="N" lenCheck="20" maxLength="20" value="<%=v_name%>"/>
				</td>
				<th class="th_top_bd">생년월일</th><%-- 수정 주민번호 생략, 생년월일 입력2013.10.17 --%>
				<td class="td_top_bd">
					<div id="id_resno">
									<input name="p_resno1" type="text" size="6" lenCheck="6" maxLength="6" value="<%=boxTutorInfo.getString("RESNO") %>" /><%-- 수정 2013.10.17 --%>
<%-- 					<input name="p_resno1" type="text" size="6" lenCheck="6" maxLength="6" value="<%=(v_resno.length()>=6)?v_resno.substring(0,6):"" %>" />
					-
					<input name="p_resno2" type="text" size="7" lenCheck="7" maxLength="7" value="<%=(v_resno.length()>=13)?v_resno.substring(6,13):"" %>"/> --%>
					</div>
				</td>
			</tr>
			<tr>
				<th class="th_left_bd"><!-- 회사 -->소속</th>
				<td>
				<input name="p_compnm" type="text" size="20" dispName="회사명" isNull="Y" lenCheck="60" maxLength="60" value="<%=boxTutorInfo.getString("COMP") %>"  />
					<%-- <input name="p_compnm" type="text" size="20" dispName="회사명" isNull="Y" lenCheck="60" maxLength="60" value="<%=v_compnm %>"  /> --%>
					
					<%-- <fmtag:button type="4" name="comp_search_img" value="회사조회" func="searchCompList()" /> --%>
					<input type="hidden" name="comp_search_img" value=""/>
					
				</td>
				<!-- 
				<th>직책</th>
				<td>
					<input name="p_jikcheknm" type="text" size="20" dispName="직책" isNull="Y" lenCheck="20" maxLength="20" value="<%=v_jikcheknm %>"/>
				</td>
				 -->
				<th>교육분야</th>
				<td>
					<%=CommonUtil.getCodeListBox(box, "select", "0122", "p_teachField", boxTutorInfo.getString("TEACHFIELD"),"", "-전체-")%>
					<!-- 
					<a href="javascript:addTeachFieldCode();">
						<img id="name_search_img" src="/images/common/btn_popup_icon_insert.gif" align="absmiddle">
					</a>
					 -->
				</td>
			</tr>
			<tr>
				<th class="th_left_bd">주소</th>
				<td colspan="3">
					<% if( v_post2 == null || v_post2.equals("")){ %>
						<input name="p_post1" type="text" size="5" dataType="integer" dispName="우편번호" isNull="Y" maxLength="5" value="<%=v_post1 %>" readonly="readonly"/>
						<input name="p_post2" type="hidden" dispName="우편번호" value="<%=v_post2 %>"/>
					<% } else { %>
						<input name="p_post1" type="text" size="5" dataType="integer" dispName="우편번호" isNull="Y" maxLength="5" value="<%=v_post1 %>" readonly="readonly"/>
						-
						<input name="p_post2" type="text" size="5" dispName="우편번호" value="<%=v_post2 %>" readonly="readonly"/>
					<% } %>
					<a href="#none" onclick="searchZipCode('home')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a><br/>
					<input name="p_addr" type="text" size="100" dispName="주소" isNull="Y" lenCheck="100" maxLength="100" value="<%=v_addr %>" />
				</td>
			</tr>
			<tr>
				<th class="th_left_bd">이메일</th>
				<td>
					<input name="p_email" type="text" size="30" dispName="이메일" isNull="Y" lenCheck="50" maxLength="20" value="<%=v_email %>"/>
				</td>
				<th>출강여부</th>
				<td>
					<input type="radio" name="p_teachYN" value="Y" style="border:none;"<%=(boxTutorInfo.getStringDefault("TEACHYN", "Y").equals("Y"))?" checked":"" %>> YES
					<input type="radio" name="p_teachYN" value="N" style="border:none;"<%=(boxTutorInfo.getString("TEACHYN").equals("N"))?" checked":"" %>> NO
				</td>
			</tr>
			<tr>
<%
	String[] arrAreaCode = new String[] {"02","031","032","033","041","042","043","051","052","053","054","055","061","063","064"};
	String[] arrCellAreaCode = new String[] {"010","011","016","017","018","019"};
	String[] arrPhone = v_phone.split("-");
	String[] arrHandPhone = v_handphone.split("-");
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
				<td colspan="1">
					<input name="p_userid" type="text" size="20" dispName="아이디" isNull="N" lenCheck="20" maxLength="20" value="<%=v_userid %>" readonly/>
					<input type="hidden" name="p_pwd" value="dummy_value0" readonly="readonly"/>					
				</td>
				<%-- <th>비밀번호</th>
				<td>
					<input name="p_pwd" type="password" size="20" dispName="비밀번호" isNull="N" lenCheck="20" maxLength="20" value="<%=v_pwd %>" readonly/>
				</td> --%>
			</tr>


			<tr>
				<th colspan="2">전문분야</th>
				<td colspan="3">
				<%
					//과목 분류체계 소분류 목록 가져오기
					List lowerclassList = (List) box.getObject("lowerclassList");
					//해당 강사의 전문분야 목록 가져오기
					List tutorLowerclassList = (List) box.getObject("tutorLowerclassList");
					
					HashMap map1 = null, map2 = null;
					boolean checked = false;
					
					for (int i = 0; i < lowerclassList.size(); i++) {
						map1 = (HashMap) lowerclassList.get(i);
						checked = false;
						for (int j = 0; j < tutorLowerclassList.size(); j++) {
							map2 = (HashMap) tutorLowerclassList.get(j);
							if (map1.get("LOWERCLASS").equals(map2.get("SUBJ"))) {
								checked = true;
								break;
							}
						}
				%>
				<input type="checkbox" name="p_tutor_subj" value="<%= map1.get("LOWERCLASS") %>" <% if (checked) { %>checked<% } %>><%= map1.get("CLASSNAME") %>
				<%					
					}
				%>
										
				</td>
			</tr>

			</table>
			</div>
			
			<table width="985" border="0" cellpadding="0" cellspacing="0" background="/images/back/common/tabmenu_bg.gif" class="mar_top_15" >
			<colgroup>
				<col width="130" />
				<col width="130" />
				<col width="130" />
				<col width="130" />
				<col width="130" />
				<col width="335" />
			</colgroup>
			<tr height="32" >
				<td class="tabmenu" id="tabmenu1" align="center" style="cursor:hand; background-repeat:no-repeat;">
					<a href="#none" onClick="goTabMenu('1');">강의경력</a>
				</td>
				<td class="tabmenu" id="tabmenu2"  align="center" style="cursor:hand; background-repeat:no-repeat;" >
					<a href="#none" onClick="goTabMenu('2');">강의이력</a>
				</td>
				<td class="tabmenu" id="tabmenu3"  align="center" style="cursor:hand; background-repeat:no-repeat;" >
					<a href="#none" onClick="goTabMenu('3');">강사평가/강의료</a>
				</td>
				<td class="tabmenu" id="tabmenu4"  align="center" style="cursor:hand; background-repeat:no-repeat;">
					<a href="#none" onClick="goTabMenu('4');">메모</a>
				</td>
				<td class="tabmenu" id="tabmenu5" align="center" style="cursor:hand; background-repeat:no-repeat;">
					<a href="#none" onClick="goTabMenu('5');"><span style=''>기타정보</span></a>
				</td>
				<%-- <td class="tabmenu" id="tabmenu6" align="center" style="cursor:hand; background-repeat:no-repeat;">
					<a href="#none" onClick="goTabMenu('6');"><span style=''>월간일정</span></a>
				</td> --%>
				<td>&nbsp;</td>
			</tr>
			</table>
			
			<!-- 버튼 -->
			<table id="tblButton1" width="985" border="0" cellpadding="0" cellspacing="0" class="mar_top_5" style="display:none">
			<tr>
				<td align="right">
					<table border="0" cellspacing="0" cellpadding="0" >
		            <tr>
						<td>
							<fmtag:button type="1" value="엑셀출력" func="careerExcelDown()" />
						<% if ( s_menucontrol.equals("RW") ) { %>
							<fmtag:button type="1" value="경력등록" func="careerWritePopup('W','')" />
						<% } %>
						</td>
		              </tr>
		            </table>
				</td>
			</tr>
			</table>
			<!--  강의이력 //-->
			<table id="tblButton2" width="985" border="0" cellpadding="0" cellspacing="0" class="mar_top_5" style="display:none">
			<tr>
				<td align="right">
					<table border="0" cellspacing="0" cellpadding="0" >
		            <tr>
						<td>
							<fmtag:button type="1" value="엑셀" func="lectureHistoryExcelDown()" />
						
						</td>
		              </tr>
		            </table>
				</td>
			</tr>
			</table>
		
			<table id="tblButton4" width="985" border="0" cellpadding="0" cellspacing="0" class="mar_top_5" style="display:none">
			<tr>
				<td align="right">
					<table border="0" cellspacing="0" cellpadding="0" >
		            <tr>
						<td>
							<fmtag:button type="1" value="등록" func="memoWritePopup('W','')" />
						
						</td>
		              </tr>
		            </table>
				</td>
			</tr>
			</table>
			<!--  교수자평가/ 강의료 -->
			<div id="sulDiv" style="margin:0;width:100%;table-layout:fix;height:100%;" style="display:none">
			<%@ include file = "/jsp/back/lms/tutor/innerProfessorEstimation.jsp" %>
			</div>		
			<!--  기타정보 등록  FORM -->
			<div id="infoDiv" style="margin:0;width:100%;table-layout:fix;height:100%;" style="display:none">
			<%@ include file = "/jsp/back/lms/tutor/innerProfessorViewForm.jsp" %>
			</div>
		
		
		<!-- 리스트 -->
		    <div id="listDiv" style="margin:0;width:100%;table-layout:fix;height:100%;">
				<table width="100%" cellpadding="0" cellspacing="0" class="mar_top_5">
				<tr>
					<td id="ListBox"></td>
				</tr>
				</table>
		 	</div>
		 	<!-- // -->
		 	
		<!-- 공백 -->
		<table width="985" cellpadding="0" cellspacing="0" class="mar_top_20">
		<tr><td></td></tr>
		</table>

	<!-- // -->
	</form>
	<form name="form2" action="" method="POST" >
	<input type="hidden" name="cmd" value="">
	<input type="hidden" name="p_userid"   value="<%=v_userid %>">
	<input type="hidden" name="p_proc" value="" />
	<input type="hidden" name="p_seq" value="" />
	
	<input type="hidden" name="p_trainingclass" value="" />
	<input type="hidden" name="p_grcode" value="" />
	<input type="hidden" name="p_gyear" value="" />
	<input type="hidden" name="p_grseq" value="" />
	<input type="hidden" name="p_subj" value="" />
	<input type="hidden" name="p_subjseq" value="" />
	<input type="hidden" name="p_subject" value="" />
	<input type="hidden" name="p_eudstartdt" value="" />
	<input type="hidden" name="p_eudenddt" value="" />
	
	</form>
  <!--푸터부분 시작-->
  <%@ include file = "/jsp/back/common/bottom.jsp"%>
  <!--푸터부분 끝-->