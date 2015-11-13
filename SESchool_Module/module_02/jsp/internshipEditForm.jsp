<%@page import="java.util.Calendar"%>
<%@page import="com._4csoft.aof.util.DateUtil"%>
<%@page import="com.sinc.common.FileDTO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file = "../../common/commonInc.jsp"%>

<%
	Box view = (Box)box.getObject("view");
	if(view == null){
		view = new Box(new HashMap());
	}

	String V_APPLYSTARTDATE = StringUtil.nvl(view.getString("APPLYSTARTDATE"));
	String V_APPLYENDDATE = StringUtil.nvl(view.getString("APPLYENDDATE"));
	/*
	List duty = (List)request.getAttribute("duty");

	//첨부파일을 가져온다.
	ArrayList fileList = new ArrayList();
	FileDTO file = null;
	if(!view.getString("RFILE_NAME").equals("")){
		file = new FileDTO();
		file.setNo(Integer.parseInt(view.getString("EMPLOYNO")));
		file.setSaveFilename(view.getString("RFILE_NAME"));
		fileList.add(file);
	}
	*/
	
	String v_spotzip = StringUtil.nvl(view.getString("SPOTZIP"));		// 우편번호 
   	String v_spotzip1;
   	String v_spotzip2;
   	if( !StringUtil.isNull(v_spotzip) && !v_spotzip.equals("-")){
   		if(v_spotzip.contains("-")){
   			v_spotzip1 = v_spotzip.substring(0, v_spotzip.indexOf("-"));
   			v_spotzip2 = v_spotzip.substring(v_spotzip.indexOf("-")+1, v_spotzip.length());
   		} else if (v_spotzip.length() > 5){
   			v_spotzip1 = v_spotzip.substring(0, 3);
   			v_spotzip2 = v_spotzip.substring(3, v_spotzip.length());
   		} else {
   			v_spotzip1 = v_spotzip;
   			v_spotzip2 = "";
   		}
   	} else {
   		v_spotzip1 = "";
   		v_spotzip2 = "";
   	}
   	
   	String v_headzip = StringUtil.nvl(view.getString("HEADZIP"));		// 본사 우편번호 
   	String v_headzip1;
   	String v_headzip2;
   	if( !StringUtil.isNull(v_headzip) && !v_headzip.equals("-")){
   		if(v_zipcode.contains("-")){
   			v_headzip1 = v_headzip.substring(0, v_headzip.indexOf("-"));
   			v_headzip2 = v_headzip.substring(v_headzip.indexOf("-")+1, v_headzip.length());
   		} else if (v_zipcode.length() > 5){
   			v_headzip1 = v_headzip.substring(0, 3);
   			v_headzip2 = v_headzip.substring(3, v_headzip.length());
   		} else {
   			v_headzip1 = v_headzip;
   			v_headzip2 = "";
   		}
   	} else {
   		v_headzip1 = "";
   		v_headzip2 = "";
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

	var stay=0, etc=0;
	function stayCheck(){
		var f = document.form1;
		if(stay == 0){
			f.p_stayamt.value = "";
			stay++;
		}
	}

	function etcCheck(){
		var f = document.form1;
		if(etc == 0){
			f.p_etc.value = "";
			etc++;
		}
	}

	function goSave(){
		var f = document.form1;

		if(!infoCheck()) return;
		if(!internshipCheck()) return;
		if(!anyCheck()) return;
		
		if( f.p_spotzip2.value == null || f.p_spotzip2.value == "" ){
			f.p_spotzip.value = f.p_spotzip1.value;
		} else {
			f.p_spotzip.value = f.p_spotzip1.value + "" +  f.p_spotzip2.value;
		}
		
		if( f.p_headzip2.value == null || f.p_headzip2.value == "" ){
			f.p_headzip.value = f.p_headzip1.value;
		} else {
			f.p_headzip.value = f.p_headzip1.value + "" +  f.p_headzip2.value;
		}

		f.submit();
	}

	function goDelete(){
		var f = document.form1;
		if(confirm("정말 삭제하시겠습니까?")){
			f.cmd.value = "deleteInternship";
			f.submit();
		}
	}

	function goAlert(){
		alert("매핑된 지원자가 존재합니다.");
	}

	function goInternshipApplyUserList(){
		var f = document.form1;
		var url = "/back/Internship.do?cmd=internshipApplyUserList&p_internno="+f.p_internno.value;
        Center_Fixed_Popup2(url, "internshipApplyUserList", 1024, 700, "yes");
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
			form.p_spotaddr.value = addr;			
			if(zipcode.search('-') > -1){	
				form.p_spotzip1.value = zipcode.substr(0, 3) ;
				form.p_spotzip2.value = zipcode.substr(4, 7) ;	
				form.p_spotzip.value = zipcode.substr(0, 3) + "" + zipcode.substr(4, 7);
			} else {
				form.p_spotzip1.value = zipcode;		// 새로운 우편주소, 하나의 텍스트란에 넣음
				form.p_spotzip2.value = "";
				form.p_spotzip2.style.display="none";
				form.p_spotzip.value = zipcode;
			}
	    } else {
	    	form.p_headaddr.value = addr;			
			if(zipcode.search('-') > -1){	
				form.p_headzip1.value = zipcode.substr(0, 3) ;
				form.p_headzip2.value = zipcode.substr(4, 7) ;	
				form.p_headzip.value = zipcode.substr(0, 3) + "" + zipcode.substr(4, 7);
			} else {
				form.p_headzip1.value = zipcode;		// 새로운 우편주소, 하나의 텍스트란에 넣음
				form.p_headzip2.value = "";
				form.p_headzip2.style.display="none";
				form.p_headzip.value = zipcode;
			}
	    }
	}

	function infoCheck(){
		var f = document.form1;

		//회사명
		if(ncCom_Empty(f.p_compnm.value)) return ncCom_ErrField(f.p_compnm,"회사명을 입력하세요");
		if(ncCom_Empty(f.p_compengnm.value)) return ncCom_ErrField(f.p_compengnm,"회사명을 입력하세요");
		//한국본사
		if(ncCom_Empty(f.p_headcompnm.value)) return ncCom_ErrField(f.p_headcompnm,"한국본사를 입력하세요");
		//현지업무 개요
		if(ncCom_Empty(f.p_spotbusiness.value)) return ncCom_ErrField(f.p_spotbusiness,"현지업무 개요를 입력하세요");
		//종업원수
		if(ncCom_Empty(f.p_workercnt.value)) return ncCom_ErrField(f.p_workercnt,"종업원수를 입력하세요");
		if(!isNumber(f.p_workercnt.value)) return ncCom_ErrField(f.p_workercnt,"종업원수는 숫자로 입력하세요");
		if(ncCom_Empty(f.p_headworkercnt.value)) return ncCom_ErrField(f.p_headworkercnt,"종업원수를 입력하세요");
		if(!isNumber(f.p_headworkercnt.value)) return ncCom_ErrField(f.p_headworkercnt,"종업원수는 숫자로 입력하세요");
		if(ncCom_Empty(f.p_spotworkercnt.value)) return ncCom_ErrField(f.p_spotworkercnt,"종업원수를 입력하세요");
		if(!isNumber(f.p_spotworkercnt.value)) return ncCom_ErrField(f.p_spotworkercnt,"종업원수는 숫자로 입력하세요");
		return true;
	}

	function internshipCheck(){
		var f = document.form1;
		//채용제목체크
		if(ncCom_Empty(f.p_interntitle.value)) return ncCom_ErrField(f.p_interntitle,"인턴쉽공고제목을 입력하세요");
		//파견지역
		if(ncCom_Empty(f.p_sendnation.value)) return ncCom_ErrField(f.p_sendnation,"파견국가를 입력하세요");
		if(ncCom_Empty(f.p_sendcity.value)) return ncCom_ErrField(f.p_sendcity,"파견국가를 입력하세요");
		//필요인원
		if(ncCom_Empty(f.p_needlang.value)) return ncCom_ErrField(f.p_needlang,"필요인원을 입력하세요");
		if(ncCom_Empty(f.p_needworker.value)) return ncCom_ErrField(f.p_needworker,"필요인원을 입력하세요");
		if(!isNumber(f.p_needworker.value)) return ncCom_ErrField(f.p_needworker,"인원은 숫자로 입력하세요");
		if(ncCom_Empty(f.p_needlang2.value)) return ncCom_ErrField(f.p_needlang2,"필요인원을 입력하세요");
		if(ncCom_Empty(f.p_needworker2.value)) return ncCom_ErrField(f.p_needworker2,"필요인원을 입력하세요");
		if(!isNumber(f.p_needworker2.value)) return ncCom_ErrField(f.p_needworker2,"인원은 숫자로 입력하세요");
		// 성별
		var sex = 0;
		for(var i = 0; i < f.p_sex.length; i++){
			if(f.p_sex[i].checked){
				sex++;
			}
		}
		if(sex == 0) return ncCom_ErrField(f.p_sex[0],"성별을 체크하세요");
		//지원기간
		if(ncCom_Empty(f.p_applystartdate.value)) return ncCom_ErrField(f.date1,"지원기간을 입력하세요");
		if(ncCom_Empty(f.p_applyenddate.value)) return ncCom_ErrField(f.date2,"지원기간을 입력하세요");
		//배치부서 / 배정업무
		if(ncCom_Empty(f.p_placedepart.value)) return ncCom_ErrField(f.p_placedepart,"배치부서 / 배정업무를 입력하세요");
		//연수생 체재비 지원금액
		if(ncCom_Empty(f.p_stayamt.value)) return ncCom_ErrField(f.p_stayamt,"연수생 체재비 지원금액을 입력하세요");
		//요망사항
		if(ncCom_Empty(f.p_etc.value)) return ncCom_ErrField(f.p_etc,"요망사항을 입력하세요");
		return true;
	}

	function anyCheck(){
		var f = document.form1;
		//해외현지 담당자 성명 / 직위
		if(ncCom_Empty(f.p_spotchargnm.value)) return ncCom_ErrField(f.p_spotchargnm,"해외 담당자를 입력하세요");
		//해외현지 전화
		if(ncCom_Empty(f.p_spottel.value)) return ncCom_ErrField(f.p_spottel,"해외 전화번호를 입력하세요");
		//해외현지 팩스
		if(ncCom_Empty(f.p_spotfax.value)) return ncCom_ErrField(f.p_spotfax,"해외 팩스번호를 입력하세요");
		//해외현지 EMAIL
		if(!isEmail(f.p_spotemail.value)) return ncCom_ErrField(f.p_spotemail,"해외 담당 이메일을 입력하세요");
		//해외현지 주소
		if(ncCom_Empty(f.p_spotzip1.value)) return ncCom_ErrField(f.p_spotzip1,"해외현지 주소를 입력하세요");
		if(ncCom_Empty(f.p_spotaddr.value)) return ncCom_ErrField(f.p_spotaddr,"해외현지 주소를 입력하세요");
		//본사 담당자 성명 / 직위
		if(ncCom_Empty(f.p_headchargnm.value)) return ncCom_ErrField(f.p_headchargnm,"본사 담당자를 입력하세요");
		//본사 전화
		if(ncCom_Empty(f.p_headtel.value)) return ncCom_ErrField(f.p_headtel,"본사 전화번호를 입력하세요");
		//본사 팩스
		if(ncCom_Empty(f.p_headfax.value)) return ncCom_ErrField(f.p_headfax,"본사 팩스번호를 입력하세요");
		//본사 EMAIL
		if(!isEmail(f.p_heademail.value)) return ncCom_ErrField(f.p_heademail,"본사 이메일을 입력하세요");
		//본사 주소
		if(ncCom_Empty(f.p_headzip1.value)) return ncCom_ErrField(f.p_headzip1,"본사 주소를 입력하세요");
		if(ncCom_Empty(f.p_headaddr.value)) return ncCom_ErrField(f.p_headaddr,"본사 주소를 입력하세요");
		return true;
	}
	
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" topmargin="0" leftmargin="0">

<%
	if(view.getString("INTERNNO") == null || view.getString("INTERNNO").equals("")){
%>
<form name="form1" method="post" action="/back/Internship.do" onSubmit="return false;">
<input type="hidden" name="cmd"     value="insertInternship">
<%
	} else {
%>
<form name="form1" method="post" action="/back/Internship.do" onSubmit="return false;">
<input type="hidden" name="cmd"     value="updateInternship">
<%
	}
%>
<input type="hidden" name="p_internno" value="<%=view.getString("INTERNNO") %>">
<input type="hidden" name="p_notigubun" value="M">
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
	<td class="pad_left_15">

		<!-- 라벨 -->
		<table width="950" cellpadding="0" cellspacing="0" class="mar_top_15">
		<tr>
			<td width="15"><img src="/images/back/common/bullet_title.gif"></td>
			<td class="txt_black_b">글로벌무역전문가 양성사업 해외인턴쉽 장기과정 의뢰신청서</td>
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
				<th>법인(회사, 지사)명<br/>(한글)</th>
				<td><input type="text" size="40" name="p_compnm" value="<%=view.getString("COMPNM")%>"></td>
				<th rowspan="3">종업원수</th>
				<td>총&nbsp;<input type="text" maxlength="6" size="20" name="p_workercnt" value="<%=view.getString("WORKERCNT")%>">&nbsp;명</td>
			</tr>
			<tr>
				<th>법인(회사, 지사)명<br/>(영문)<br/>*현지 국가에 공식등록된<br/>명칭을 적어주세요.</th>
				<td><input type="text" size="40" name="p_compengnm" value="<%=view.getString("COMPENGNM")%>"></td>
				<td>본사주재원&nbsp;<input type="text" maxlength="6" size="20" name="p_headworkercnt" value="<%=view.getString("HEADWORKERCNT")%>">&nbsp;명</td>
			</tr>
			<tr>
				<th>한국본사</th>
				<td><input type="text" size="40" name="p_headcompnm" value="<%=view.getString("HEADCOMPNM")%>"></td>
				<td>현지직원&nbsp;<input type="text" maxlength="6" size="20" name="p_spotworkercnt" value="<%=view.getString("SPOTWORKERCNT")%>">&nbsp;명</td>
			</tr>
			<tr>
				<th>법인(지사, 회사)<br/>현지업무 개요</th>
				<td colspan="3"><textarea cols="120" rows="6" name="p_spotbusiness"><%=view.getString("SPOTBUSINESS") %></textarea></td>
			</tr>
			</table>
		</div>
		<!-- // -->

		<!-- 라벨 -->
		<table width="950" cellpadding="0" cellspacing="0" class="mar_top_15">
		<tr>
			<td width="15"><img src="/images/back/common/bullet_title.gif"></td>
			<td class="txt_black_b">연수생운영</td>
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
				<th>인턴쉽의뢰제목</th>
				<td colspan="3"><input type="text" size="20" name="p_interntitle" value="<%=view.getString("INTERNTITLE")%>"></td>
			</tr>
			<tr>
				<th rowspan="2">파견지역</th>
				<td>국가 : <%=CommonUtil.getCodeListBox("select","0096","p_sendnation",view.getString("SENDNATION"),"","- 선택 -")%></td>
				<th rowspan="2">필요인원<br/>(언어별/인원)</th>
				<td rowspan="2">
					<input type="text" size="10" name="p_needlang" value="<%=view.getString("NEEDLANG")%>">어&nbsp;<input type="text" size="10" maxlength="6" name="p_needworker" value="<%=view.getString("NEEDWORKER")%>">명<br/>
					<input type="text" size="10" name="p_needlang2" value="<%=view.getString("NEEDLANG2")%>">어&nbsp;<input type="text" size="10" maxlength="6" name="p_needworker2" value="<%=view.getString("NEEDWORKER2")%>">명
				</td>
			</tr>
			<tr>
				<td>도시 : <input type="text" size="30" name="p_sendcity" value="<%=view.getString("SENDCITY")%>"></td>
			</tr>
			<tr>
				<th>성별</th>
				<td colspan="3">
					남<input type="radio" name="p_sex" value="M" <% if("M".equals(view.getString("SEX"))){ %> checked="checked" <% } %>>&nbsp;
					여<input type="radio" name="p_sex" value="F" <% if("F".equals(view.getString("SEX"))){ %> checked="checked" <% } %>>
				</td>
			</tr>
			<tr>
				<th>지원기간</th>
				<td colspan="3">
					<fmtag:calendar seq="1" name="form1" property="p_applystartdate" date="<%=V_APPLYSTARTDATE%>" dispName="지원시작일" defaultYn="N" position="right"/>
					~
					<fmtag:calendar seq="2" name="form1" property="p_applyenddate" date="<%=V_APPLYENDDATE%>" dispName="지원마감일" defaultYn="N" position="right"/>
				</td>
			</tr>
			<tr>
				<th>연수생<br/>배치부서 및<br/>배정업부</th>
				<td colspan="3"><textarea cols="120" rows="6" name="p_placedepart"><%=view.getString("PLACEDEPART")%></textarea></td>
			</tr>
			<%
				if(view.getString("STAYAMT") != null && !view.getString("STAYAMT").equals("")){
			%>
			<tr>
				<th>연수생<br/>체재비<br/>지원금액</th>
				<td colspan="3"><textarea cols="120" rows="6" name="p_stayamt"><%=view.getString("STAYAMT") %></textarea></td>
			</tr>
			<%
				} else {
			%>
			<tr>
				<th>연수생<br/>체재비<br/>지원금액</th>
				<td colspan="3"><textarea cols="120" rows="6" name="p_stayamt" onClick="stayCheck()">업체에서 연수생에게 직접 지급할 수 있는 체재비 지원금을 적어주세요.
(단, 월 지원금액이 미국 400불, 유럽 300유로, 일본 35,000엔, 중국 2,500위안 이상이어야 함.)
 - 지원가능 금액 :
 - 기타 의견 </textarea></td>
			</tr>
			<%
				}
				if(view.getString("ETC") != null && !view.getString("ETC").equals("")){
			%>
			<tr>
				<th>요망사항</th>
				<td colspan="3"><textarea cols="120" rows="6" name="p_etc"><%=view.getString("ETC") %></textarea></td>
			</tr>
			<%
				} else {
			%>
			<tr>
				<th>요망사항</th>
				<td colspan="3"><textarea cols="120" rows="6" name="p_etc" onclick="etcCheck()">(예: 성별, 전공분야, 성격, OA능력 등)
				</textarea></td>
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
			<td class="txt_black_b">연수생담당</td>
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
				<td colspan="4">해외현지 담당자</td>
			</tr>
			<tr>
				<th>성명/직위</th>
				<td colspan="3"><input type="text" size="40" name="p_spotchargnm" value="<%=view.getString("SPOTCHARGNM")%>"></td>
			</tr>
			<tr>
				<th>TEL</th>
				<td><input type="text" size="40" name="p_spottel" value="<%=view.getString("SPOTTEL")%>"></td>
				<th>FAX</th>
				<td><input type="text" size="40" name="p_spotfax" value="<%=view.getString("SPOTFAX")%>"></td>
			</tr>
			<tr>
				<th>E-MAIL</th>
				<td colspan="3"><input type="text" size="40" name="p_spotemail" value="<%=view.getString("SPOTEMAIL")%>"></td>
			</tr>
			<tr>
				<th>주소</th>
				<td colspan="3" height="50">
					<input type="hidden" name="p_spotzip" value="<%=v_spotzip %>"/>
	                <% if( v_spotzip2 == null || v_spotzip2.equals("")){ %>
						<input type="text" name="p_spotzip1" dispName="우편번호" isNull="Y"  size="5" dataType="number" value="<%=v_spotzip1 %>" maxlength="5" readonly="readonly">
	                	<input type="hidden" name="p_spotzip2" dispName="우편번호" size="5" value="<%=v_spotzip2 %>">
					<% } else { %>
						<input type="text" name="p_spotzip1" dispName="우편번호" isNull="Y"  size="5" dataType="number" value="<%=v_spotzip1 %>" maxlength="5" readonly="readonly">&nbsp;-&nbsp;
	                	<input type="text" name="p_spotzip2" dispName="우편번호" size="5" value="<%=v_spotzip2 %>" readonly="readonly">
					<% } %>
					<a href="#none" onclick="searchZipCode('home')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a>
					<br/>
					<input type="text" name="p_spotaddr" dispName="사업장주소" isNull="Y" size="80" lenCheck="100" value="<%=view.getString("SPOTADDR")%>">
				</td>
			</tr>
			<tr>
				<td colspan="4">본사 담당자</td>
			</tr>
			<tr>
				<th>성명/직위</th>
				<td colspan="3"><input type="text" size="40" name="p_headchargnm" value="<%=view.getString("HEADCHARGNM")%>"></td>
			</tr>
			<tr>
				<th>TEL</th>
				<td><input type="text" size="40" name="p_headtel" value="<%=view.getString("HEADTEL")%>"></td>
				<th>FAX</th>
				<td><input type="text" size="40" name="p_headfax" value="<%=view.getString("HEADFAX")%>"></td>
			</tr>
			<tr>
				<th>E-MAIL</th>
				<td colspan="3"><input type="text" size="40" name="p_heademail" value="<%=view.getString("HEADEMAIL")%>"></td>
			</tr>
			<tr>
				<th>주소</th>
				<td colspan="3" height="50">
					<input type="hidden" name="p_headzip" value="<%=v_headzip %>"/>
	               	<% if( v_headzip2 == null || v_headzip2.equals("")){ %>
						<input type="text" name="p_headzip1" dispName="우편번호" isNull="Y"  size="5" dataType="number" value="<%=v_headzip1 %>" maxlength="5">
	               		<input type="hidden" name="p_headzip2" dispName="우편번호" size="5" value="<%=v_headzip2 %>" >
					<% } else { %>
						<input type="text" name="p_headzip1" dispName="우편번호" isNull="Y"  size="5" dataType="number" value="<%=v_headzip1 %>" maxlength="5">&nbsp;-&nbsp;
	               		<input type="text" name="p_headzip2" dispName="우편번호" size="5" value="<%=v_headzip2 %>" >
					<% } %>
					<a href="#none" onclick="searchZipCode('head')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a>
					<br/>
					<input type="text" name="p_headaddr" dispName="사업장주소" isNull="Y" size="80" lenCheck="100" value="<%=view.getString("HEADADDR")%>">
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
						<option value="Y" <% if("Y".equals(view.getString("HANDLEYN"))){ %> selected="selected" <% } %>>처리완료</option>
					</select>
				</td>
			</tr>
		</table>

		<%
	 		if(view.getString("INTERNNO") != null && !view.getString("INTERNNO").equals("")){
	     %>
		<table width="950" border="0" cellpadding="0" cellspacing="0" class="mar_top_5">
			<tr>
				<td align="right">
					<fmtag:button value="인턴십지원자 등록" func="goInternshipApplyUserList()" />
				</td>
			</tr>
		</table>
		<%
	 		}
		%>
		<!-- 버튼 -->
		<table width="950" cellpadding="0" cellspacing="0" class="mar_top_10">
		<tr>
			<td align="center">
				<table cellpadding="0" cellspacing="0">
				<tr>
				  <td>
			 <%
		 		if(view.getString("INTERNNO") != null && !view.getString("INTERNNO").equals("")){
		     %>
		     <fmtag:button value="인 쇄" func="window.print()" />
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
		 		if(view.getString("INTERNNO") != null && !view.getString("INTERNNO").equals("") && cnt == 0){
		     %>
		     <fmtag:button value="삭제" func="goDelete()" />
		     <%
		 		} else if(cnt > 0){
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
</body>
</html>