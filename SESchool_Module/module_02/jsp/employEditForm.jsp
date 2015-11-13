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
	
	String v_zip = StringUtil.nvl(view.getString("ZIP"));		// 우편번호 
   	String v_zip1;
   	String v_zip2;
   	if( !StringUtil.isNull(v_zip) && !v_zip.equals("-")){
   		if(v_zip.contains("-")){
   			v_zip1 = v_zip.substring(0, v_zip.indexOf("-"));
   			v_zip2 = v_zip.substring(v_zip.indexOf("-")+1, v_zip.length());
   		} else if (v_zip.length() > 5){
   			v_zip1 = v_zip.substring(0, 3);
   			v_zip2 = v_zip.substring(3, v_zip.length());
   		} else {
   			v_zip1 = v_zip;
   			v_zip2 = "";
   		}
   	} else {
   		v_zip1 = "";
   		v_zip2 = "";
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
			var gubun= f.p_gubun.value;
			f.action = "/back/Employ.do?cmd=deleteEmploy&p_employno="+f.p_employno.value+"&p_gubun="+gubun;
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
		var starttime = <%=view.getString("WORKSTARTTIME")%>+"";
		var endtime = <%=view.getString("WORKENDTIME")%>+"";
		if(starttime.length == 2 || starttime.length == 3){
			if(starttime.length == 2){
				f.p_workstarttime.value = "00"+starttime;
			} else {
				f.p_workstarttime.value = "0"+starttime;
			}
		} else {
			f.p_workstarttime.value = starttime;
		}

		if(endtime.length == 2 || endtime.length == 3){
			if(starttime.length == 2){
				f.p_workendtime.value = "00"+endtime;
			} else {
				f.p_workendtime.value = "0"+endtime;
			}
		} else {
			f.p_workendtime.value = endtime;
		}
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
	    var pop = Center_Fixed_Popup2("about:blank", "EmployPrintPop", 1024, 700, "yes");
	   	f.action = "/back/Employ.do?cmd=employPrintPop&p_employno="+f.p_employno.value;
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
				<td><input type="text" size="40" name="p_compnm" value="<%=view.getString("COMPNM")%>"></td>
				<th>대표자명</th>
				<td><input type="text" size="40" name="p_coname" value="<%=view.getString("CONAME")%>"></td>
			</tr>
			<tr>
				<th>무역업신고번호</th>
				<td><input type="text" size="40" name="p_compresno" value="<%=view.getString("COMPRESNO")%>"></td>
				<th>홈페이지</th>
				<td><input type="text" size="40" name="p_homepage" value="<%=view.getString("HOMEPAGE")%>"></td>
			</tr>
			<tr>
				<th>소재지</th>
				<td colspan="3">
					<input type="hidden" name="p_zip" value="<%=v_zip %>"/>
	                <% if( v_zip2 == null || v_zip2.equals("")){ %>
						<input type="text" name="p_zip1" dispName="우편번호" isNull="Y"  size="5" dataType="number" value="<%=v_zip1 %>" maxlength="5" readonly="readonly">
						<input type="hidden" name="p_zip2" dispName="우편번호" value="<%=v_zip2 %>">
					<% } else { %>
						<input type="text" name="p_zip1" dispName="우편번호" isNull="Y"  size="5" dataType="number" value="<%=v_zip1 %>" maxlength="5" readonly="readonly">&nbsp;-&nbsp;
						<input type="text" name="p_zip2" dispName="우편번호" value="<%=v_zip2 %>" readonly="readonly">
					<% } %>
					<a href="#none" onclick="searchZipCode('home')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a>
					<br/>
					<input type="text" name="p_addr" dispName="사업장주소" isNull="Y" size="80" lenCheck="100" value="<%=view.getString("ADDR")%>">
				</td>
			</tr>
			<tr>
				<td colspan="4">2. 채용담당자</td>
			</tr>
			<tr>
				<th>담당자명</th>
				<td><input type="text" size="40" name="p_manager" value="<%=view.getString("MANAGER")%>"></td>
				<th>담당부서</th>
				<td><input type="text" size="40" name="p_deptnm" value="<%=view.getString("DEPTNM")%>"></td>
			</tr>
			<tr>
				<th>전호번호</th>
				<td><input type="text" size="40" name="p_telno" value="<%=view.getString("TELNO")%>"></td>
				<th>팩스번호</th>
				<td><input type="text" size="40" name="p_faxno" value="<%=view.getString("FAXNO")%>"></td>
			</tr>
			<tr>
				<th>이메일주소</th>
				<td colspan="3"><input type="text" size="40" name="p_email" value="<%=view.getString("EMAIL")%>"></td>
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
				<td><input type="text" size="10" name="p_capital" value="<%=view.getString("CAPITAL")%>"> / <input type="text" size="10" name="p_sales" value="<%=view.getString("SALES")%>"> </td>
				<th>수출액 / 수입액</th>
				<td><input type="text" size="10" name="p_export" value="<%=view.getString("EXPORT")%>"> / <input type="text" size="10" name="p_imports" value="<%=view.getString("IMPORTS")%>"> </td>
			</tr>
			<tr>
				<th>업종</th>
				<td>
					<input type="text" size="40" name="p_business" value="<%=view.getString("BUSINESS") %>">
				</td>
				<th>취급품목</th>
				<td><input type="text" size="40" name="p_article" value="<%=view.getString("ARTICLE")%>"></td>
			</tr>
			<tr>
				<th>생산시설</th>
				<td>
					국내 <input type="text" size="10" maxlength="4" name="p_producenum" value="<%=view.getString("PRODUCENUM")%>"> 개,
					<img src="/images/back/common/txt_padding.gif">해외 <input type="text" maxlength="4" size="10" name="p_forignnum" value="<%=view.getString("FORIGNNUM")%>"> 개
				</td>
				<th>지사사무소</th>
				<td>
					국내 <input type="text" size="10" maxlength="4" name="p_innerbranch" value="<%=view.getString("INNERBRANCH")%>"> 개,
					<img src="/images/back/common/txt_padding.gif">해외 <input type="text" maxlength="4" size="10" name="p_outerbranch" value="<%=view.getString("OUTERBRANCH")%>"> 개
				</td>
			</tr>
			<tr>
				<th>거래국가</th>
				<td><input type="text" size="40" name="p_dealnational" value="<%=view.getString("DEALNATIONAL")%>"></td>
				<th>설립년도</th>
				<td><input type="text" size="40" name="p_establishyear" maxlength="4" value="<%=view.getString("ESTABLISHYEAR")%>"></td>
			</tr>
			<tr>
				<th>종업원수</th>
				<td colspan="3">
					전체 <input type="text" maxlength="5" size="15" name="p_workerall" value="<%=view.getString("WORKERALL")%>"> 명,
					<img src="/images/back/common/txt_padding.gif">사무직 <input type="text" maxlength="5" size="15" name="p_workerwhite" value="<%=view.getString("WORKERWHITE")%>"> 명,
					<img src="/images/back/common/txt_padding.gif">생산직 <input type="text" maxlength="5" size="15" name="p_workerproduce" value="<%=view.getString("WORKERPRODUCE")%>"> 명
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
				<td colspan="7"><input type="text" size="80" name="p_jobtitle" value="<%=view.getString("JOBTITLE")%>"></td>
			</tr>
			<tr>
				<th>채용기간</th>
				<td colspan="3">
					<fmtag:calendar seq="1" name="form1" property="p_jobstartdate" date="<%=V_JOBSTARTDATE%>" dispName="시작일" defaultYn="N" position="right"/>
					~
					<fmtag:calendar seq="2" name="form1" property="p_jobenddate" date="<%=V_JOBENDDATE%>" dispName="종료일" defaultYn="N" position="right"/>
				</td>
				<th>채용예정일</th>
				<td colspan="3"><fmtag:calendar seq="3" name="form1" property="p_jobduedate" date="<%=V_JOBDUEDATE%>" dispName="예정일" defaultYn="N" position="right"/></td>
			</tr>
			<tr>
				<th>근무국가</th>
				<td colspan="7"><%=CommonUtil.getCodeListBox("select","0096","p_nation",view.getString("NATION"),"","- 선택 -")%></td>
			</tr>
			<tr>
				<th>선발방법<br/>(500자 내외)</th>
				<td colspan="7"><textarea cols="120" rows="5" name="p_selectmethod"><%=view.getString("SELECTMETHOD") %></textarea></td>
			</tr>
			<tr>
				<th>준비물<br/>(500자 내외)</th>
				<td colspan="7"><textarea cols="120" rows="5" name="p_prepare"><%=view.getString("PREPARE") %></textarea></td>
			</tr>
			<tr>
				<th>선발장소</th>
				<td colspan="7"><input type="text" size="80" name="p_selectplace" value="<%=view.getString("SELECTPLACE")%>"></td>
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
				if(duty == null || duty.getRow() == 0) {
			%>
			<tr>
				<td><input type="text" size="30" name="p_dutycontent"></td>
				<td><input type="text" size="10" name="p_sex" maxlength="2"></td>
				<td><input type="text" size="10" name="p_peoplenum" maxlength="4"></td>
				<td><input type="text" size="10" name="p_age"></td>
				<td><input type="text" size="10" name="p_academic"></td>
				<td><input type="text" size="10" name="p_major"></td>
				<td><input type="text" size="10" name="p_foreign"></td>
				<td><input type="text" size="10" name="p_workplace"></td>
			</tr>
			<tr>
				<td><input type="text" size="30" name="p_dutycontent"></td>
				<td><input type="text" size="10" name="p_sex" maxlength="2"></td>
				<td><input type="text" size="10" name="p_peoplenum" maxlength="4"></td>
				<td><input type="text" size="10" name="p_age"></td>
				<td><input type="text" size="10" name="p_academic"></td>
				<td><input type="text" size="10" name="p_major"></td>
				<td><input type="text" size="10" name="p_foreign"></td>
				<td><input type="text" size="10" name="p_workplace"></td>
			</tr>
			<%
				} else {
					while(duty.next()){
			%>
			<tr>
				<td><input type="text" size="30" name="p_dutycontent" value="<%=duty.getString("DUTYCONTENT")%>"></td>
				<td><input type="text" size="10" name="p_sex" maxlength="1" value="<%=duty.getString("SEX")%>"></td>
				<td><input type="text" size="10" name="p_peoplenum" maxlength="4" value="<%=duty.getString("PEOPLENUM")%>"></td>
				<td><input type="text" size="10" name="p_age" value="<%=duty.getString("AGE")%>"></td>
				<td><input type="text" size="10" name="p_academic" value="<%=duty.getString("ACADEMIC")%>"></td>
				<td><input type="text" size="10" name="p_major" value="<%=duty.getString("MAJOR")%>"></td>
				<td><input type="text" size="10" name="p_foreign" value="<%=duty.getString("FOREIGN")%>"></td>
				<td><input type="text" size="10" name="p_workplace" value="<%=duty.getString("WORKPLACE")%>"></td>
			</tr>
			<%
					}
					if(duty.getRow() == 1){
			%>
			<tr>
				<td><input type="text" size="30" name="p_dutycontent"></td>
				<td><input type="text" size="10" name="p_sex" maxlength="1"></td>
				<td><input type="text" size="10" name="p_peoplenum" maxlength="4"></td>
				<td><input type="text" size="10" name="p_age"></td>
				<td><input type="text" size="10" name="p_academic"></td>
				<td><input type="text" size="10" name="p_major"></td>
				<td><input type="text" size="10" name="p_foreign"></td>
				<td><input type="text" size="10" name="p_workplace"></td>
			</tr>
			<%
					}
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
				<td><input type="text" maxlength="9" size="10" name="p_annualincome" value="<%=view.getString("ANNUALINCOME")%>"> </td>
				<th>월급여(A)</th>
				<td><input type="text" maxlength="9" size="10" name="p_pay" value="<%=view.getString("PAY")%>"> </td>
				<th>상여금(B)</th>
				<td><input type="text" maxlength="9" size="10" name="p_bonus" value="<%=view.getString("BONUS")%>"> </td>
			</tr>
			<tr>
				<th>근무시간</th>
				<td colspan="2"><input type="text" size="20" name="p_workstarttime" maxlength="4" value=""> 부터 <input type="text" size="20" name="p_workendtime" maxlength="4" value=""> 까지</td>
				<th>휴무/휴가</th>
				<td colspan="2"><input type="text" size="40" name="p_closedday" value="<%=view.getString("CLOSEDDAY")%>"></td>
			</tr>
			<tr>
				<th>복리후생</th>
				<td colspan="5"><input type="text" size="80" name="p_welfare" value="<%=view.getString("WELFARE")%>"></td>
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
				<td colspan="4"><input type="text" size="80" name="p_qualification" value="<%=view.getString("QUALIFICATION")%>"></td>
			</tr>
			<tr>
				<th>학력사항</th>
				<td><input type="text" size="20" name="p_needmajor" maxlength="4" value="<%=view.getString("NEEDMAJOR")%>"></td>
				<th>경력</th>
				<td>
					<%
						String career = StringUtil.nvl(view.getString("NEEDCAREER"));
					%>
					<select name="p_needcareer">
						<option value="무관" <% if(career.equals("무관")) { %> selected="selected" <% } %>>무관</option>
						<option value="신입" <% if(career.equals("신입")) { %> selected="selected" <% } %>>신입</option>
						<option value="1년" <% if(career.equals("1년")) { %> selected="selected" <% } %>>1년</option>
						<option value="2년" <% if(career.equals("2년")) { %> selected="selected" <% } %>>2년</option>
						<option value="3년" <% if(career.equals("3년")) { %> selected="selected" <% } %>>3년</option>
						<option value="4년" <% if(career.equals("4년")) { %> selected="selected" <% } %>>4년</option>
						<option value="5년이상" <% if(career.equals("5년이상")) { %> selected="selected" <% } %>>5년이상</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>컴퓨터<br/>활용능력</th>
				<td colspan="4"><textarea cols="120" rows="5" name="p_computer"><%=view.getString("COMPUTER") %></textarea></td>
			</tr>
			<tr>
				<th>우대사항<br/>(자격증/기타)</th>
				<td colspan="4"><textarea cols="120" rows="5" name="p_complimentary"><%=view.getString("COMPLIMENTARY") %></textarea></td>
			</tr>
			<tr>
				<th>어학능력</th>
				<td colspan="4"><input type="text" size="80" name="p_abilitylang" value="<%=view.getString("ABILITYLANG")%>"></td>
			</tr>
			</table>
		</div>
		<!-- // -->

		<!-- 라벨 -->
		<table width="950" cellpadding="0" cellspacing="0" class="mar_top_15">
		<tr>
			<td width="15"><img src="/images/back/common/bullet_title.gif"></td>
			<td class="txt_black_b">첨부파일</td>
		</tr>
		</table>

		<!-- 입력폼 -->
		<div class="board-view">
			<%
				String down = "";
				if(view.getString("RFILE_NAME") != null && !"".equals(view.getString("RFILE_NAME"))){
					down = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"#none\" onclick=\"employFileDown();\">[다운로드]</a>";
				}
			%>
			<table width="950" border="1" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="200" />
				<col width="" />
			</colgroup>
			<tr>
				<th height="180">첨부파일</th>
				<td><%=down %>
					<%=CommonUtil.getMultiFileupload("uploadClass1","p_contractfile", 1, fileList, null, "570") %>
					<input type="hidden" name="p_sfile_name" value="<%=view.getString("SFILE_NAME") %>">
					<input type="hidden" name="p_rfile_name" value="<%=view.getString("RFILE_NAME") %>">
				</td>
			</tr>
			</table>
		</div>
		<!-- // -->

		<!-- 라벨 -->
		<table width="950" cellpadding="0" cellspacing="0" class="mar_top_15">
		<tr>
			<td width="15"><img src="/images/back/common/bullet_title.gif"></td>
			<td class="txt_black_b">인지정보</td>
		</tr>
		</table>

		<!-- 입력폼 -->
		<div class="board-view">
			<table width="950" border="1" cellpadding="0" cellspacing="0" class="mar_top_5">
			<tr>
				<td>본 인력추천을 알게된 경위는?</td>
			</tr>
			<tr>
				<td>
					<table width="950" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><input type="radio" name="p_route" value="1" <% if("1".equals(view.getString("ROUTE"))){ %> checked="checked" <% } %>>1. 신문광고</td>
						</tr>
						<tr>
							<td><input type="radio" name="p_route" value="2" <% if("2".equals(view.getString("ROUTE"))){ %> checked="checked" <% } %>>2. 온라인 잡 사이트 광고</td>
						</tr>
						<tr>
							<td><input type="radio" name="p_route" value="3" <% if("3".equals(view.getString("ROUTE"))){ %> checked="checked" <% } %>>3. 주변 무역업체</td>
						</tr>
						<tr>
							<td><input type="radio" name="p_route" value="4" <% if("4".equals(view.getString("ROUTE"))){ %> checked="checked" <% } %>>4. 홍보 메일 또는 DM을 통해</td>
						</tr>
						<tr>
							<td><input type="radio" name="p_route" value="5" <% if("5".equals(view.getString("ROUTE"))){ %> checked="checked" <% } %>>5. 기타
								<img src="/images/back/common/txt_padding.gif">
								<input type="text" size="30" name="p_routeetc" value="<%=view.getString("ROUTEETC") %>">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			</table>
		</div>
		
		<!-- 입력폼 -->
		<div class="board-view">
			<table width="950" border="1" cellpadding="0" cellspacing="0" class="mar_top_5">
			<tr>
				<td>
					이메일 : <input type="text" maxlength="25" name="p_inemail" value="<%=view.getString("INEMAIL")%>">&nbsp;&nbsp;비밀번호 : <input type="password" maxlength="30" name="p_inpassword" value="<%=view.getString("INPASSWORD")%>">
				</td>
			</tr>
			</table>
		</div>
		
		<!-- // -->
		<table width="950" border="0" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="50" />
				<col width="" />
			</colgroup>
			<tr>
				<td>처리여부</td>
				<td>
					<select name="p_handleyn">
						<option value="N" <% if("N".equals(view.getString("HANDLEYN"))){ %> selected="selected" <% } %>>처리중</option>
						<option value="Y" <% if("Y".equals(view.getString("HANDLEYN"))){ %> selected="selected" <% } %>>게시</option>
						<option value="E" <% if("E".equals(view.getString("HANDLEYN"))){ %> selected="selected" <% } %>>마감</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>구분</td>
				<td>
					<select name="p_gubun">
						<option value="T" <% if("T".equals(view.getString("GUBUN"))){ %> selected="selected" <% } %>>무역마스터</option>
						<option value="S" <% if("S".equals(view.getString("GUBUN"))){ %> selected="selected" <% } %>>섬유수출전문가</option>
						<option value="C" <% if("C".equals(view.getString("GUBUN"))){ %> selected="selected" <% } %>>중국마케팅전문가</option>
						<option value="I" <% if("I".equals(view.getString("GUBUN"))){ %> selected="selected" <% } %>>SMART IT마스터</option>
					</select>
				</td>
			</tr>
		</table>

		<!-- 버튼 -->
		<table width="950" cellpadding="0" cellspacing="0" class="mar_top_10">
		<tr>
			<td align="center">
				<table cellpadding="0" cellspacing="0">
				<tr>
				  <td>
			 <%
		 		if(view.getString("EMPLOYNO") != null && !view.getString("EMPLOYNO").equals("")){
		     %>
		     <fmtag:button value="인 쇄" func="fnPrintView()" />
		     <%
		 		}
		     %>
		     <fmtag:button value="저 장" func="goSave()" />&nbsp;
		     <fmtag:button value="닫 기" func="window.close()" />
		     <%
		     	int cnt = 0;
			    if(box.getString("applyCount") != null && !box.getString("applyCount").equals("")){
			    	 cnt = Integer.parseInt(box.getString("applyCount"));
			    }
		 		if(view.getString("EMPLOYNO") != null && !view.getString("EMPLOYNO").equals("") && cnt == 0){
		     %>
		     <fmtag:button value="삭제" func="goDelete()" />
		     <%
		 		} else if (cnt > 0){
		     %>
		     <fmtag:button value="삭제" func="goAlert()" />
		     <% } %>
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