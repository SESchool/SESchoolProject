<%--
 * @(#)ClassifyCommon Template
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * T_LMS_SUBJATT 테이블 Write Template.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2010. 11. 04.  bluedove       Initial Release
 ************************************************
--%>
<%@page import="com.sinc.common.FileDTO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file = "../../common/commonInc.jsp"%>

<%
	Box view = (Box)box.getObject("view");
	if(view == null){
		view = new Box(new HashMap());
	}

	String V_JOBSTARTDATE = StringUtil.nvl(view.getString("JOBSTARTDATE"));
	String V_JOBENDDATE = StringUtil.nvl(view.getString("JOBENDDATE"));
	String V_JOBDUEDATE = StringUtil.nvl(view.getString("JOBDUEDATE"));

	DataSet duty = (DataSet)box.getObject("duty");

	//첨부파일을 가져온다.
	ArrayList fileList = new ArrayList();
	FileDTO file = null;
	if(!view.getString("RFILE_NAME").equals("")){
		file = new FileDTO();
		file.setNo(Integer.parseInt(view.getString("EMPLOYNO")));
		file.setSaveFilename(view.getString("RFILE_NAME"));
		fileList.add(file);
	}
%>
<html>
<TITLE>::: 한국무역협회 무역아카데미 ::: 관리자페이지</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<fmtag:csscommon point="back" />
<fmtag:jscommon />
<fmtag:dwrcommon interfaceName="CommonUtilWork"/>
<fmtag:dwrcommon interfaceName="EmployWork"/>
<script language="Javascript" src="/js/common/calendar.js"></script>
<script language="Javascript" src="/js/common/fileupload.js"></script>
<script language="Javascript" src="/js/common/util.js"></script>
<script language="javascript">

	function goSave(){
		var f = document.form1;

		if(!compCheck()) return;
		if(!conditionCheck()) return;
		if(!employCheck()) return;
		if(!infoCheck()) return;
		if(!anyCheck()) return

		if(uploadClass1.get_old_file_cnt() == 0){
			f.p_rfile_name.value = "";
			f.p_sfile_name.value = "";
		}
		
		if( f.p_zip2.value == null || f.p_zip2.value == ""){
			f.p_zip.value = f.p_zip1.value;
		} else {
			f.p_zip.value = f.p_zip1.value+""+f.p_zip2.value;
		}
		f.submit();
		displayWorkProgress();
		alert("등록되었습니다.");
		window.opener.jsMainList();
		closeWorkProgress();
		window.close();
	}

	function goDelete(){
		var f = document.form1;
		if(confirm("정말 삭제하시겠습니까?")){
			f.action = "/back/Employ.do?cmd=deleteEmploy&p_employno="+f.p_employno.value;
			f.cmd.value = "deleteEmploy";
			f.submit();
			displayWorkProgress();
			alert("삭제되었습니다.");
			window.opener.jsMainList();
			closeWorkProgress();
			window.close();
		}
	}

	function goAlert(){
		alert("매핑된 지원자가 존재합니다.");
	}

	function pausecomp(millis) {
		var date = new Date();
		var curDate = null;
		do { curDate = new Date(); }
		while(curDate-date < millis);
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
				form.p_zip1.value = zipcode.substr(0, 3) ;
				form.p_zip2.value = zipcode.substr(4, 7) ;	
			} else {
				form.p_zip1.value = zipcode;		// 새로운 우편주소, 하나의 텍스트란에 넣음
				form.p_zip2.value = "";
				form.p_zip2.style.display="none";
			}
	    }
	}

	function compCheck(){
		var f = document.form1;

		//회사명
		if(ncCom_Empty(f.p_compnm.value)) return ncCom_ErrField(f.p_compnm,"회사명을 입력하세요");
		//대표자명
		if(ncCom_Empty(f.p_coname.value)) return ncCom_ErrField(f.p_coname,"대표자명을 입력하세요");
		//무역업신고번호
		if(ncCom_Empty(f.p_compresno.value)) return ncCom_ErrField(f.p_compresno,"무역업신고번호를 입력하세요");
		//홈페이지
		if(ncCom_Empty(f.p_homepage.value)) return ncCom_ErrField(f.p_homepage,"홈페이지를 입력하세요");
		//소재지
		if(ncCom_Empty(f.p_zip1.value)) return ncCom_ErrField(f.p_zip1,"소재지를 입력하세요");
		if(ncCom_Empty(f.p_addr.value)) return ncCom_ErrField(f.p_addr,"소재지를 입력하세요");
		//담당자명
		if(ncCom_Empty(f.p_manager.value)) return ncCom_ErrField(f.p_manager,"담당자명을 입력하세요");
		//담당부서
		if(ncCom_Empty(f.p_deptnm.value)) return ncCom_ErrField(f.p_deptnm,"담당부서를 입력하세요");
		//전화번호
		if(ncCom_Empty(f.p_telno.value)) return ncCom_ErrField(f.p_telno,"전화번호를 입력하세요");
		//팩스번호
		if(ncCom_Empty(f.p_faxno.value)) return ncCom_ErrField(f.p_faxno,"팩스번호를 입력하세요");
		//이메일
		if(!isEmail(f.p_email.value)) return ncCom_ErrField(f.p_email,"이메일을 입력하세요");
		return true;
	}

	function conditionCheck(){
		var f = document.form1;
		//자본금 / 총매출액
		if(ncCom_Empty(f.p_capital.value)) return ncCom_ErrField(f.p_capital,"자본금을 입력하세요");
		if(ncCom_Empty(f.p_sales.value)) return ncCom_ErrField(f.p_sales,"총매출액을 입력하세요");
		//수출액 / 수입액
		if(ncCom_Empty(f.p_export.value)) return ncCom_ErrField(f.p_export,"수출액을 입력하세요");
		if(ncCom_Empty(f.p_imports.value)) return ncCom_ErrField(f.p_imports,"수입액을 입력하세요");
		//업종
		if(ncCom_Empty(f.p_business.value)) return ncCom_ErrField(f.p_business,"업종을 입력하세요");
		//취급품목
		if(ncCom_Empty(f.p_article.value)) return ncCom_ErrField(f.p_article,"취급품목을 입력하세요");
		//생산시설
		if(ncCom_Empty(f.p_producenum.value)) return ncCom_ErrField(f.p_producenum,"생산시설을 입력하세요");
		if(!isNumber(f.p_producenum.value)) return ncCom_ErrField(f.p_producenum,"생산시설은 숫자만 입력가능합니다");
		if(ncCom_Empty(f.p_forignnum.value)) return ncCom_ErrField(f.p_forignnum,"생산시설을 입력하세요");
		if(!isNumber(f.p_forignnum.value))	return ncCom_ErrField(f.p_forignnum,"생산시설은 숫자만 입력가능합니다");
		//지사사무소
		if(ncCom_Empty(f.p_innerbranch.value)) return ncCom_ErrField(f.p_innerbranch,"지사사무소를 입력하세요");
		if(!isNumber(f.p_innerbranch.value)) return ncCom_ErrField(f.p_innerbranch,"지사사무소는 숫자만 입력가능합니다");
		if(ncCom_Empty(f.p_outerbranch.value)) return ncCom_ErrField(f.p_outerbranch,"지사사무소를 입력하세요");
		if(!isNumber(f.p_outerbranch.value)) return ncCom_ErrField(f.p_outerbranch,"지사사무소는 숫자만 입력가능합니다");
		//거래국가
		if(ncCom_Empty(f.p_dealnational.value)) return ncCom_ErrField(f.p_dealnational,"거래국가를 입력하세요");
		//설립년도
		if(f.p_establishyear.value.length < 4){
			return ncCom_ErrField(f.p_establishyear,"설립년도를 입력하세요(4자리)");
		} else if(!isNumber(f.p_establishyear.value)){
			return ncCom_ErrField(f.p_establishyear,"설립년도는 숫자입니다");
		}
		//종업원수
		if(ncCom_Empty(f.p_workerall.value)) return ncCom_ErrField(f.p_workerall,"종업원수를 입력하세요");
		if(!isNumber(f.p_workerall.value)) return ncCom_ErrField(f.p_workerall,"종업원수는 모두 숫자만 입력 가능합니다");
		if(ncCom_Empty(f.p_workerwhite.value)) return ncCom_ErrField(f.p_workerwhite,"종업원수를 입력하세요");
		if(!isNumber(f.p_workerwhite.value)) return ncCom_ErrField(f.p_workerwhite,"종업원수는 모두 숫자만 입력 가능합니다");
		if(ncCom_Empty(f.p_workerproduce.value)) return ncCom_ErrField(f.p_workerproduce,"종업원수를 입력하세요");
		if(!isNumber(f.p_workerproduce.value)) return ncCom_ErrField(f.p_workerproduce,"종업원수는 모두 숫자만 입력 가능합니다");

		return true;
	}

	function employCheck(){
		var f = document.form1;
		//채용제목체크
		if(ncCom_Empty(f.p_jobtitle.value)) return ncCom_ErrField(f.p_jobtitle,"채용제목을 입력하세요");
		//채용마감일 / 예정일
		if(ncCom_Empty(f.p_jobstartdate.value)) return ncCom_ErrField(f.date1,"채용기간일을 입력하세요");
		if(ncCom_Empty(f.p_jobenddate.value)) return ncCom_ErrField(f.date2,"채용기간일을 입력하세요");
		if(ncCom_Empty(f.p_jobduedate.value)) return ncCom_ErrField(f.date3,"채용예정일을 입력하세요");
		//근무국가
		if(ncCom_Empty(f.p_nation.value)) return ncCom_ErrField(f.p_nation,"근무국가를 선택하세요");
		//채용선발방법
		if(ncCom_Empty(f.p_selectmethod.value)) return ncCom_ErrField(f.p_selectmethod,"선발방법을 입력하세요");
		//채용준비물
		if(ncCom_Empty(f.p_prepare.value)) return ncCom_ErrField(f.p_prepare,"준비물 입력하세요");
		//선발장소
		if(ncCom_Empty(f.p_selectplace.value)) return ncCom_ErrField(f.p_selectplace,"선발장소를 입력하세요");
		//업무내용 1체크
		for(var i = 0; i < f.p_dutycontent.length; i++){
			var cnt = 0;
			if(f.p_dutycontent[i].value.length > 0)
				cnt++;
			if(f.p_sex[i].value.length > 0)
				cnt++;
			if(f.p_peoplenum[i].value.length > 0)
				cnt++;
			if(f.p_age[i].value.length > 0)
				cnt++;
			if(f.p_academic[i].value.length > 0)
				cnt++;
			if(f.p_major[i].value.length > 0)
				cnt++;
			if(f.p_foreign[i].value.length > 0)
				cnt++;
			if(f.p_workplace[i].value.length > 0)
				cnt++;
			if(cnt > 0 && cnt < 8){
				return ncCom_ErrField(f.p_dutycontent[i],"업무내용을 전부 입력해 주세요");
			}
		}
		return true;
	}

	function infoCheck(){
		var f = document.form1;
		//지원자격
		if(ncCom_Empty(f.p_qualification.value)) return ncCom_ErrField(f.p_qualification,"지원자격을 입력하세요");
		//학력사항
		if(ncCom_Empty(f.p_needmajor.value)) return ncCom_ErrField(f.p_needmajor,"학력사항을 입력하세요");
		//경력
		if(ncCom_Empty(f.p_needcareer.value)) return ncCom_ErrField(f.p_needcareer,"경력을 입력하세요");
		//컴퓨터활용능력
		if(ncCom_Empty(f.p_computer.value)) return ncCom_ErrField(f.p_computer,"컴퓨터활용능력을 입력하세요");
		//우대사항
		if(ncCom_Empty(f.p_complimentary.value)) return ncCom_ErrField(f.p_complimentary,"우대사항을 입력하세요");
		//어학능력
		if(ncCom_Empty(f.p_abilitylang.value)) return ncCom_ErrField(f.p_abilitylang,"어학능력을 입력하세요");
		return true;
	}

	function anyCheck(){
		var f = document.form1;

		//연봉 / 월급여 / 상여금
		if(ncCom_Empty(f.p_annualincome.value)) return ncCom_ErrField(f.p_annualincome,"연봉을 입력하세요");
		if(!isNumber(f.p_annualincome.value)) return ncCom_ErrField(f.p_annualincome,"연봉을은 숫자로 입력하세요");
		if(ncCom_Empty(f.p_pay.value)) return ncCom_ErrField(f.p_pay,"월급여을 입력하세요");
		if(!isNumber(f.p_pay.value)) return ncCom_ErrField(f.p_pay,"월급여은 숫자로 입력하세요");
		if(ncCom_Empty(f.p_bonus.value)) return ncCom_ErrField(f.p_bonus,"상여금을 입력하세요");
		if(!isNumber(f.p_bonus.value)) return ncCom_ErrField(f.p_bonus,"상여금은 숫자로 입력하세요");
		//근무시간
		if(f.p_workstarttime.value.length < 4) return ncCom_ErrField(f.p_workstarttime,"근무시간을 입력하세요 4자리 입니다(0900)");
		if(!isNumber(f.p_workstarttime.value)) return ncCom_ErrField(f.p_workstarttime,"근무시간은 숫자로 입력하세요");
		if(f.p_workendtime.value.length < 4) return ncCom_ErrField(f.p_workendtime,"근무시간을 입력하세요 4자리 입니다(0900)");
		if(!isNumber(f.p_workendtime.value)) return ncCom_ErrField(f.p_workendtime,"근무시간은 숫자로 입력하세요");
		//휴무 / 휴가
		if(ncCom_Empty(f.p_closedday.value)) return ncCom_ErrField(f.p_closedday,"휴무 / 휴가를 입력하세요");
		//복리후생
		if(ncCom_Empty(f.p_welfare.value)) return ncCom_ErrField(f.p_welfare,"복리후생을 입력하세요");

		var idx = -1;
		for(var i = 0; i < f.p_route.length; i++){

			if(f.p_route[i].checked){
				idx = i;
			}
		}
		if(idx == -1){
			return ncCom_ErrField(f.p_route[0],"인지정보를 선택하세요");
		}

		if(idx == 4){
			if(ncCom_Empty(f.p_routeetc.value)) return ncCom_ErrField(f.p_routeetc,"인지정보 기타 내용을 입력하세요");
		}
		return true;
	}

	function jsInitPage(){
		var f = document.form1;
	}

	function employFileDown() {
		var f = document.form1;
		var f2 = document.downForm;
		f2.action		  = "/fileDownServlet";
		f2.method		  = "get";
		f2.filePath.value  = "/employ";
		f2.rFileName.value = f.p_rfile_name.value;
		f2.sFileName.value = f.p_sfile_name.value;
		f2.submit();
	}

	function fnPrintView(){
		var f	=	document.form1;
		var temp_action = f.action;
		var temp_cmd = f.cmd.value;
	    var pop = Center_Fixed_Popup2("about:blank", "EmployPrintPop", 540, 768, "yes");
	   	f.action = "/back/Employ.do?cmd=employPrintPop";
	    f.target = "EmployPrintPop";
    	f.cmd.value = "employPrintPop";
	    f.submit();
	    f.target = "";
	    f.action = temp_action;
	    f.cmd.value = temp_cmd;
	}
</script>
</head>
<form name="downForm">
	<input type="hidden" name="filePath">
	<input type="hidden" name="rFileName">
	<input type="hidden" name="sFileName">
</form>
<body bgcolor="#FFFFFF" text="#000000" topmargin="0" leftmargin="0" onload="jsInitPage()">

<%
	if(view.getString("EMPLOYNO") == null || view.getString("EMPLOYNO").equals("")){
%>
<form name="form1" method="post" action="/back/Employ.do?cmd=insertEmploy" onSubmit="return false;" enctype="multipart/form-data">
<input type="hidden" name="cmd"     value="insertEmploy">
<%
	} else {
%>
<form name="form1" method="post" action="/back/Employ.do?cmd=updateEmploy" onSubmit="return false;" enctype="multipart/form-data">
<input type="hidden" name="cmd"     value="updateEmploy">
<%
	}
%>
<input type="hidden" name="p_employno" value="<%=view.getString("EMPLOYNO") %>">
<input type="hidden" name="p_notigubun" value="M">
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
	<td class="pad_left_15">

		<!-- 라벨 -->
		<table width="950" cellpadding="0" cellspacing="0" class="mar_top_15">
		<tr>
			<td width="15"><img src="/images/back/common/bullet_title.gif"></td>
			<td class="txt_black_b">인재추천의뢰 작성</td>
		</tr>
		</table>

		<!-- 입력폼 -->
		<div class="board-view">
			<table width="950" border="1" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="200" />
				<col width="" />
				<col width="200" />
				<col width="" />
			</colgroup>
			<tr>
				<td colspan="4">1. 회사정보</td>
			</tr>
			<tr>
				<th>회사명</th>
				<td><%=view.getString("COMPNM")%></td>
				<th>대표자명</th>
				<td><%=view.getString("CONAME")%></td>
			</tr>
			<tr>
				<th>무역업신고번호</th>
				<td><%=view.getString("COMPRESNO")%></td>
				<th>홈페이지</th>
				<td><%=view.getString("HOMEPAGE")%></td>
			</tr>
			<tr>
				<th>소재지</th>
				<td colspan="3">
					<%=view.getString("ADDR")%>
				</td>
			</tr>
			<tr>
				<td colspan="4">2. 채용담당자</td>
			</tr>
			<tr>
				<th>담당자명</th>
				<td><%=view.getString("MANAGER")%></td>
				<th>담당부서</th>
				<td><%=view.getString("DEPTNM")%></td>
			</tr>
			<tr>
				<th>전호번호</th>
				<td><%=view.getString("TELNO")%></td>
				<th>팩스번호</th>
				<td><%=view.getString("FAXNO")%></td>
			</tr>
			<tr>
				<th>이메일주소</th>
				<td colspan="3"><%=view.getString("EMAIL")%></td>
			</tr>
			</table>
		</div>
		<!-- // -->

		<!-- 라벨 -->
		<table width="950" cellpadding="0" cellspacing="0" class="mar_top_15">
		<tr>
			<td width="15"><img src="/images/back/common/bullet_title.gif"></td>
			<td class="txt_black_b">회사현황</td>
		</tr>
		</table>

		<!-- 입력폼 -->
		<div class="board-view">
			<table width="950" border="1" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="200" />
				<col width="" />
				<col width="200" />
				<col width="" />
			</colgroup>
			<tr>
				<th>자본금 / 총매출액</th>
				<td><%=view.getString("CAPITAL")%> / <%=view.getString("SALES")%></td>
				<th>수출액 / 수입액</th>
				<td><%=view.getString("EXPORT")%> / <%=view.getString("IMPORTS")%></td>
			</tr>
			<tr>
				<th>업종</th>
				<td>
					<%=view.getString("BUSINESS") %>
				</td>
				<th>취급품목</th>
				<td><%=view.getString("ARTICLE")%></td>
			</tr>
			<tr>
				<th>생산시설</th>
				<td>
					국내 <%=view.getString("PRODUCENUM")%> 개,
					<img src="/images/back/common/txt_padding.gif">해외 <%=view.getString("FORIGNNUM")%> 개
				</td>
				<th>지사사무소</th>
				<td>
					국내 <%=view.getString("INNERBRANCH")%> 개,
					<img src="/images/back/common/txt_padding.gif">해외 <%=view.getString("OUTERBRANCH")%> 개
				</td>
			</tr>
			<tr>
				<th>거래국가</th>
				<td><%=view.getString("DEALNATIONAL")%></td>
				<th>설립년도</th>
				<td><%=view.getString("ESTABLISHYEAR")%></td>
			</tr>
			<tr>
				<th>종업원수</th>
				<td colspan="3">
					전체 <%=view.getString("WORKERALL")%> 명,
					<img src="/images/back/common/txt_padding.gif">사무직 <%=view.getString("WORKERWHITE")%> 명,
					<img src="/images/back/common/txt_padding.gif">생산직 <%=view.getString("WORKERPRODUCE")%> 명
				</td>
			</tr>
			</table>
		</div>
		<!-- // -->

		<!-- 라벨 -->
		<table width="950" cellpadding="0" cellspacing="0" class="mar_top_15">
		<tr>
			<td width="15"><img src="/images/back/common/bullet_title.gif"></td>
			<td class="txt_black_b">채용정보</td>
		</tr>
		</table>

		<!-- 입력폼 -->
		<div class="board-view">
			<table width="950" border="1" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="200" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
			</colgroup>
			<tr>
				<th>채용제목</th>
				<td colspan="7"><%=view.getString("JOBTITLE")%></td>
			</tr>
			<tr>
				<th>채용기간</th>
				<td colspan="3">
					<%=DateTimeUtil.getDateType(1, V_JOBSTARTDATE)%>
					~
					<%=DateTimeUtil.getDateType(1, V_JOBENDDATE)%>
				</td>
				<th>채용예정일</th>
				<td colspan="3"><%=DateTimeUtil.getDateType(1, V_JOBDUEDATE)%></td>
			</tr>
			<tr>
				<th>근무국가</th>
				<td colspan="7"><%=view.getString("NATION")%></td>
			</tr>
			<tr>
				<th>선발방법<br/>(500자 내외)</th>
				<td colspan="7"><%=view.getString("SELECTMETHOD") %></td>
			</tr>
			<tr>
				<th>준비물<br/>(500자 내외)</th>
				<td colspan="7"><%=view.getString("PREPARE") %></td>
			</tr>
			<tr>
				<th>선발장소</th>
				<td colspan="7"><%=view.getString("SELECTPLACE")%></td>
			</tr>
			<tr>
				<th>업무내용</th>
				<th>성별</th>
				<th>인원</th>
				<th>연령</th>
				<th>학력</th>
				<th>전공</th>
				<th>외국어</th>
				<th>근무지</th>
			</tr>
			<%
				while(duty != null && duty.next()){
			%>
			<tr>
				<td><%=duty.getString("DUTYCONTENT")%></td>
				<td><%=duty.getString("SEX")%></td>
				<td><%=duty.getString("PEOPLENUM")%></td>
				<td><%=duty.getString("AGE")%></td>
				<td><%=duty.getString("ACADEMIC")%></td>
				<td><%=duty.getString("MAJOR")%></td>
				<td><%=duty.getString("FOREIGN")%></td>
				<td><%=duty.getString("WORKPLACE")%></td>
			</tr>
			<%
				}
			%>
			</table>
		</div>
		<!-- // -->

		<!-- 라벨 -->
		<table width="950" cellpadding="0" cellspacing="0" class="mar_top_15">
		<tr>
			<td width="15"><img src="/images/back/common/bullet_title.gif"></td>
			<td class="txt_black_b">근로조건</td>
		</tr>
		</table>

		<!-- 입력폼 -->
		<div class="board-view">
			<table width="950" border="1" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="150" />
				<col width="" />
				<col width="150" />
				<col width="" />
				<col width="150" />
				<col width="" />
			</colgroup>
			<tr>
				<th>연봉(A+B)</th>
				<td><%=view.getString("ANNUALINCOME")%></td>
				<th>월급여(A)</th>
				<td><%=view.getString("PAY")%></td>
				<th>상여금(B)</th>
				<td><%=view.getString("BONUS")%></td>
			</tr>
			<tr>
				<th>근무시간</th>
				<td colspan="2">
					<%
						String start = StringUtil.nvl(view.getString("WORKSTARTTIME"),"0000");
						String end = StringUtil.nvl(view.getString("WORKENDTIME"),"0000");
						if(start.length() == 3) {
							start = "0"+start;
						}
						if(end.length() == 3) {
							end = "0"+end;
						}
					%>
					<%=start.substring(0,2) + " : " + start.substring(2,4) %> 부터 <%=end.substring(0,2) + " : " + end.substring(2,4) %>  까지
				</td>
				<th>휴무/휴가</th>
				<td colspan="2"><%=view.getString("CLOSEDDAY")%></td>
			</tr>
			<tr>
				<th>복리후생</th>
				<td colspan="5"><%=view.getString("WELFARE")%></td>
			</tr>
			</table>
		</div>
		<!-- // -->

		<!-- 라벨 -->
		<table width="950" cellpadding="0" cellspacing="0" class="mar_top_15">
		<tr>
			<td width="15"><img src="/images/back/common/bullet_title.gif"></td>
			<td class="txt_black_b">지원정보</td>
		</tr>
		</table>

		<!-- 입력폼 -->
		<div class="board-view">
			<table width="950" border="1" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="200" />
				<col width="" />
				<col width="200" />
				<col width="" />
			</colgroup>
			<tr>
				<th>지원자격</th>
				<td colspan="4"><%=view.getString("QUALIFICATION")%></td>
			</tr>
			<tr>
				<th>학력사항</th>
				<td><%=view.getString("NEEDMAJOR")%></td>
				<th>경력</th>
				<td>
					<%= StringUtil.nvl(view.getString("NEEDCAREER"))	%>
				</td>
			</tr>
			<tr>
				<th>컴퓨터<br/>활용능력</th>
				<td colspan="4"><%=view.getString("COMPUTER") %></td>
			</tr>
			<tr>
				<th>우대사항<br/>(자격증/기타)</th>
				<td colspan="4"><%=view.getString("COMPLIMENTARY") %></td>
			</tr>
			<tr>
				<th>어학능력</th>
				<td colspan="4"><%=view.getString("ABILITYLANG")%></td>
			</tr>
			</table>
		</div>
		<!-- // -->

		<!-- 버튼 -->
		<table width="950" cellpadding="0" cellspacing="0" class="mar_top_10">
		<tr>
			<td align="center">
				<table cellpadding="0" cellspacing="0">
				<tr>
					<td>
				    	<fmtag:button value="인 쇄" func="window.print()" />&nbsp;
				    	<fmtag:button value="닫 기" func="self.close()" />
		     		</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
		<!-- // -->
	</td>
</tr>
</table>
</form>
</body>
</html>