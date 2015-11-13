<%--
 * @(#)Sample Template
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * Template.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2009. 12. 09.  jangcw       Initial Release
 ************************************************
--%>
<%@page import="com.sinc.common.FileDTO"%>
<%@ page contentType="text/html;charset=UTF-8" 		%>
<%@ include file = "/jsp/front/common/commonBasicInc.jsp"%>
<%
	Box view = (Box)box.getObject("view");
	String editType = "E";
	if(view == null){
		editType = "W";
		view = new Box(new HashMap());
	}
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
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
<script language="Javascript" src="/js/home/template<%=G_TMPL%>.js"></script>
<fmtag:jscommon point="front" />
<script language="Javascript" src="/js/common.js"></script>
<script language="Javascript" src="/js/common/util.js"></script>
<script language="Javascript" src="/js/common/calendar.js"></script>
<script language="Javascript" src="/js/common/fileupload.js"></script>
<script language="javascript">


	function goSave(){
		var f = document.form1;

		if(!compCheck()) return;
		if(!conditionCheck()) return;
		if(!employCheck()) return;
		if(!infoCheck()) return;
		if(!anyCheck()) return
		//수정을 위한 이메일 / 비밀번호
		if(!isEmail(f.p_inemail.value)) return ncCom_ErrField(f.p_inemail,"수정을 위한 이메일을 입력하세요");
		if(ncCom_Empty(f.p_inpassword.value)) return ncCom_ErrField(f.p_inpassword,"수정을 위한 비밀번호를 입력하세요");

		if(uploadClass1.get_old_file_cnt() == 0){
			f.p_rfile_name.value = "";
			f.p_sfile_name.value = "";
		}
		if(f.p_zip2.value == null || f.p_zip2.value == ""){
			f.p_zip.value = f.p_zip1.value;
		} else {
			f.p_zip.value = f.p_zip1.value+""+f.p_zip2.value;
		}
		f.submit();
	}

	function searchZipCode(objname) {
		var check = 'trade';
		var url = "/front/Common.do?cmd=selectZipCode&p_objname="+objname+"&check="+check;
		Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
		/* document.domain = "tradecampus.kita.net"; */
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
		if(is_tel_char(f.p_telno.value)) return ncCom_ErrField(f.p_telno,"잘못된 전화번호입니다");
		//팩스번호
		if(ncCom_Empty(f.p_faxno.value)) return ncCom_ErrField(f.p_faxno,"팩스번호를 입력하세요");
		if(is_tel_char(f.p_faxno.value)) return ncCom_ErrField(f.p_faxno,"잘못된 팩스번호 입니다");
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
		if(f.p_establishyear.value.length != 4){
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
		if(f.p_selectmethod.value.length>500) return ncCom_ErrField(f.p_selectmethod,"선발방법 500자 이내로 입력하세요");
		//채용준비물
		if(ncCom_Empty(f.p_prepare.value)) return ncCom_ErrField(f.p_prepare,"준비물 입력하세요");
		if(f.p_prepare.value.length>500) return ncCom_ErrField(f.p_prepare,"준비물을 500자 이내로 입력하세요");
	
		//선발장소
		if(ncCom_Empty(f.p_selectplace.value)) return ncCom_ErrField(f.p_selectplace,"선발장소를 입력하세요");
		//업무내용 1체크
		if (f.p_dutycontent == '[object]') {
			for(var i = 0; i < f.p_dutycontent.length; i++){
				var cnt = 0;
				
				if(!isNumber(f.p_peoplenum[i].value)) return ncCom_ErrField(f.p_peoplenum[i],"인원은 숫자만 입력 가능합니다");

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
		if(f.p_computer.value.length>500) return ncCom_ErrField(f.p_computer,"컴퓨터활용능력을 500자 이내로 입력하세요");
		//우대사항
		if(ncCom_Empty(f.p_complimentary.value)) return ncCom_ErrField(f.p_complimentary,"우대사항을 입력하세요");
		if(f.p_complimentary.value.length>500) return ncCom_ErrField(f.p_complimentary,"우대사항을 500자 이내로 입력하세요");
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
		if(f.p_welfare.value.length>500) return ncCom_ErrField(f.p_welfare,"복리후생을 500자 이내로 입력하세요");

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
	
</script>
<a name="Top"></a>
<body style="margin:0px;">

<!--//-->
<form name="form1" method="post" action="/front/Employ.do?cmd=insertEmployRecommend" onSubmit="return false;" enctype="multipart/form-data">
<input type="hidden" name="p_notigubun" value="C">
<input type="hidden" name="p_gubun" value="<%=box.getString("p_gubun") %>">
<input type="hidden" name="p_edittype" value="<%=editType %>">
<input type="hidden" name="p_employno" value="<%=box.getString("p_employno")%>">
<table width="100%" height="100%" cellpadding="0" cellspacing="0">
<tr>
	<td align="center" height="100%" valign="top">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="42" background="/images/common/popup_header_bg.gif">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/common/popup_recommend_title.gif"></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="100%" valign="top" align="left" style="padding:20px;">
				<form name="fm" method="post" action="">
				<!-- 회사정보 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_recommend_label01.gif"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-top:10px; padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-bottom:15px;">
						<tr>
							<td><img src="/images/common/popup_recommend_label0101.gif"></td>
						</tr>
						</table>

						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="15" />
							<col width="80" />
							<col width="" />
							<col width="15" />
							<col width="70" />
							<col width="200" />
						</colgroup>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_company_popup.gif"></td>
							<td>
								<input type="text" name="p_compnm" value="<%= view.getString("COMPNM") %>" maxlength="50" style="width:200px;">
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_ceoname.gif"></td>
							<td>
								<input type="text" name="p_coname" value="<%= view.getString("CONAME") %>" maxlength="10" style="width:180px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_trade_no.gif"></td>
							<td>
								<input type="text" name="p_compresno" value="<%= view.getString("COMPRESNO") %>" maxlength="10" style="width:200px;">
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_homepage_popup.gif"></td>
							<td>
								http://<input type="text" name="p_homepage" value="<%= view.getString("HOMEPAGE") %>" maxlength="100" style="width:155px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_sojaeji.gif"></td>
							<td colspan="4">
								<%
									String zip = view.getString("ZIP");
									String zip1;
									String zip2;
									if(zip.contains("-")){
										zip1 = zip.substring(0, zip.indexOf("-"));
										zip2 = zip.substring(zip.indexOf("-")+1, zip.length());
									} else {
										zip1 = zip;
										zip2 = "";
									}
								%>
								<input type="hidden" name="p_zip" value="<%=zip%>"/>
								
								<% if( zip2 == null || zip2.equals("")){ %>
									<input type="text" name="p_zip1" value="<%= zip1 %>" maxlength="5" style="width:70px;" readonly="readonly">
									<input type="hidden" name="p_zip2" value="<%= zip2 %>" >
								<% } else { %>
									<input type="text" name="p_zip1" value="<%= zip1 %>" style="width:70px;" readonly="readonly"> -
									<input type="text" name="p_zip2" value="<%= zip2 %>" style="width:70px;" readonly="readonly">
								<% } %>
								<a href="#none" onclick="searchZipCode('home')"><img src="/images/common/btn_popup_search_2.gif"></a>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"></td>
							<td style="padding-top:4px;"></td>
							<td colspan="4">
								<input type="text" name="p_addr" value="<%= view.getString("ADDR") %>" maxlength="75" style="width:480px;">
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-top:15px; padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-bottom:15px;">
						<tr>
							<td><img src="/images/common/popup_recommend_label0102.gif"></td>
						</tr>
						</table>

						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="15" />
							<col width="80" />
							<col width="" />
							<col width="15" />
							<col width="70" />
							<col width="200" />
						</colgroup>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_damdang_popup.gif"></td>
							<td>
								<input type="text" name="p_manager" value="<%= view.getString("MANAGER") %>" maxlength="10" style="width:180px;">
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_damdang_office.gif"></td>
							<td>
								<input type="text" name="p_deptnm" value="<%= view.getString("DEPTNM") %>" maxlength="25" style="width:180px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_phone.gif"></td>
							<td>
								<input type="text" name="p_telno" value="<%= view.getString("TELNO") %>" maxlength="20" style="width:180px;">
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_fax.gif"></td>
							<td>
								<input type="text" name="p_faxno" value="<%= view.getString("FAXNO") %>" maxlength="20" style="width:180px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_email.gif"></td>
							<td colspan="4">
								<input type="text" name="p_email" value="<%= view.getString("EMAIL") %>" maxlength="25" style="width:180px;">
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 회사현황 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_recommend_label02.gif"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-top:10px; padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="15" />
							<col width="80" />
							<col width="" />
							<col width="15" />
							<col width="70" />
							<col width="200" />
						</colgroup>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_company_state01.gif"></td>
							<td>
								<input type="text" name="p_capital" value="<%= view.getString("CAPITAL") %>" maxlength="25" style="width:60px;">
								/
								<input type="text" name="p_sales" value="<%= view.getString("SALES") %>" maxlength="25" style="width:60px;">
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_company_state02.gif"></td>
							<td>
								<input type="text" name="p_export" value="<%= view.getString("EXPORT") %>" maxlength="25" style="width:60px;">
								<input type="text" name="p_imports" value="<%= view.getString("IMPORTS") %>" maxlength="25" style="width:60px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_company_state03.gif"></td>
							<td>
								<input type="text" name="p_business" value="<%= view.getString("BUSINESS") %>" maxlength="25" style="width:100px;">
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_company_state04.gif"></td>
							<td>
								<input type="text" name="p_article" value="<%= view.getString("ARTICLE") %>" maxlength="25" style="width:100px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_company_state05.gif"></td>
							<td>
								국내 <input type="text" name="p_producenum" value="<%= view.getString("PRODUCENUM") %>" maxlength="4" style="width:50px;"> 개,
								해외 <input type="text" name="p_forignnum" value="<%= view.getString("FORIGNNUM") %>" maxlength="4" style="width:50px;"> 개
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_company_state06.gif"></td>
							<td>
								국내 <input type="text" name="p_innerbranch" value="<%= view.getString("INNERBRANCH") %>" maxlength="4" style="width:50px;"> 개,
								해외 <input type="text" name="p_outerbranch" value="<%= view.getString("OUTERBRANCH") %>" maxlength="4" style="width:50px;"> 개
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_company_state07.gif"></td>
							<td>
								<input type="text" name="p_dealnational" value="<%= view.getString("DEALNATIONAL") %>" maxlength="50" style="width:180px;">
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_company_state08.gif"></td>
							<td>
								<input type="text" name="p_establishyear" value="<%= view.getString("ESTABLISHYEAR") %>" maxlength="4" style="width:180px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_company_state09.gif"></td>
							<td colspan="4">
								전체 <input type="text" name="p_workerall" value="<%= view.getString("WORKERALL") %>" maxlength="5" style="width:50px;"> 명,
								사무직 <input type="text" name="p_workerwhite" value="<%= view.getString("WORKERWHITE") %>" maxlength="5" style="width:50px;"> 명,
								생산직 <input type="text" name="p_workerproduce" value="<%= view.getString("WORKERPRODUCE") %>" maxlength="5" style="width:50px;"> 명
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 채용정보 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_recommend_label03.gif"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-top:10px; padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="15" />
							<col width="80" />
							<col width="" />
							<col width="15" />
							<col width="70" />
							<col width="200" />
						</colgroup>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_recruit_info01.gif"></td>
							<td colspan="4">
								<input type="text" name="p_jobtitle" value="<%= view.getString("JOBTITLE") %>" maxlength="150" style="width:480px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_recruit_info02.gif"></td>
							<td>
								<%
									String jobstart = view.getString("JOBSTARTDATE");
									String jobend = view.getString("JOBENDDATE");
								%>
								<fmtag:calendar seq="1" name="form1" property="p_jobstartdate" date="<%=jobstart%>" dispName="시작일" defaultYn="N" position="right"/>
								~
								<fmtag:calendar seq="2" name="form1" property="p_jobenddate" date="<%=jobend%>" dispName="종료일" defaultYn="N" position="right"/>
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_recruit_info03.gif"></td>
							<td>
								<%
									String jobdue = view.getString("JOBDUEDATE");
								%>
								<fmtag:calendar seq="3" name="form1" property="p_jobduedate" date="<%=jobdue%>" dispName="예정일" defaultYn="N" position="right"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_recruit_info04.gif"></td>
							<td colspan="4"><%=CommonUtil.getCodeListBox("select","0096","p_nation",view.getString("NATION"),"","- 선택 -")%>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_recruit_info05.gif"></td>
							<td style="padding-bottom:6px;" colspan="4">
								<textarea name="p_selectmethod" maxlength="500" style="border: solid 1px #d6d6d6; width:480px; height:50px;"><%= view.getString("SELECTMETHOD") %></textarea>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_recruit_info06.gif"></td>
							<td style="padding-bottom:6px;" colspan="4">
								<textarea name="p_prepare" maxlength="500" style="border: solid 1px #d6d6d6; width:480px; height:50px;"><%= view.getString("PREPARE") %></textarea>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_recruit_info07.gif"></td>
							<td colspan="4">
								<input type="text" name="p_selectplace" maxlength="100" value="<%= view.getString("SELECTPLACE") %>" style="width:480px;">
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="" />
							<col width="72" />
							<col width="72" />
							<col width="72" />
							<col width="72" />
							<col width="72" />
							<col width="72" />
							<col width="72" />
						</colgroup>
						<tr height="30">
							<td align="center"><img src="/images/common/txt_recruit_info08.gif"></td>
							<td align="center"><img src="/images/common/txt_recruit_info09.gif"></td>
							<td align="center"><img src="/images/common/txt_recruit_info10.gif"></td>
							<td align="center"><img src="/images/common/txt_recruit_info11.gif"></td>
							<td align="center"><img src="/images/common/txt_recruit_info12.gif"></td>
							<td align="center"><img src="/images/common/txt_recruit_info13.gif"></td>
							<td align="center"><img src="/images/common/txt_recruit_info14.gif"></td>
							<td align="center"><img src="/images/common/txt_recruit_info15.gif"></td>
						</tr>
						<tr><td colspan="8" height="1" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="4"></td></tr>
						<%
							if(duty != null){
								int cnt = duty.getRow();
								while(duty.next()){
						%>
						<tr height="26">
							<td align="center"><input type="text" name="p_dutycontent" maxlength="100" value="<%=duty.getString("DUTYCONTENT") %>" style="width:86px;"></td>
							<td align="center"><input type="text" name="p_sex" maxlength="2" value="<%=duty.getString("SEX") %>" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_peoplenum" maxlength="4" value="<%=duty.getString("PEOPLENUM") %>" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_age" value="<%=duty.getString("AGE") %>" maxlength="20" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_academic" value="<%=duty.getString("ACADEMIC") %>" maxlength="100" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_major" value="<%=duty.getString("MAJOR") %>" maxlength="100" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_foreign" value="<%=duty.getString("FOREIGN") %>" maxlength="100" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_workplace" value="<%=duty.getString("WORKPLACE") %>" maxlength="100" style="width:70px;"></td>
						</tr>
						<%
								}
								if(cnt == 1){
						%>
						<tr height="26">
							<td align="center"><input type="text" name="p_dutycontent" maxlength="100" value="" style="width:86px;"></td>
							<td align="center"><input type="text" name="p_sex" maxlength="2" value="" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_peoplenum" maxlength="4" value="" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_age" value="" maxlength="20" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_academic" value="" maxlength="100" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_major" value="" maxlength="100" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_foreign" value="" maxlength="100" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_workplace" value="" maxlength="100" style="width:70px;"></td>
						</tr>
						<%
								}
							} else {
						%>
						<tr height="26">
							<td align="center"><input type="text" name="p_dutycontent" maxlength="100" value="" style="width:86px;"></td>
							<td align="center"><input type="text" name="p_sex" maxlength="2" value="" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_peoplenum" maxlength="4" value="" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_age" value="" maxlength="20" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_academic" value="" maxlength="100" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_major" value="" maxlength="100" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_foreign" value="" maxlength="100" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_workplace" value="" maxlength="100" style="width:70px;"></td>
						</tr>
						<tr height="26">
							<td align="center"><input type="text" name="p_dutycontent" value="" maxlength="100" style="width:86px;"></td>
							<td align="center"><input type="text" name="p_sex" maxlength="2" value="" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_peoplenum" maxlength="4" value="" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_age" value="" maxlength="20" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_academic" value="" maxlength="100" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_major" value="" maxlength="100" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_foreign" value="" maxlength="100" style="width:70px;"></td>
							<td align="center"><input type="text" name="p_workplace" value="" maxlength="100" style="width:70px;"></td>
						</tr>
						<%
							}
						%>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 근로조건 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_recommend_label04.gif"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-top:10px; padding-bottom:5px;">
						<!-- 지원정보 -->
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="15" />
							<col width="80" />
							<col width="" />
							<col width="15" />
							<col width="50" />
							<col width="120" />
							<col width="15" />
							<col width="50" />
							<col width="120" />
						</colgroup>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_job_condition01.gif"></td>
							<td>
								<input type="text" name="p_annualincome" value="<%= view.getString("ANNUALINCOME") %>" maxlength="9" style="width:120px;">
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_job_condition02.gif"></td>
							<td>
								<input type="text" name="p_pay" value="<%= view.getString("PAY") %>" maxlength="9" style="width:100px;">
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_job_condition03.gif"></td>
							<td>
								<input type="text" name="p_bonus" value="<%= view.getString("BONUS") %>" maxlength="9" style="width:100px;">
							</td>
						</tr>
						</table>

						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="15" />
							<col width="80" />
							<col width="" />
							<col width="15" />
							<col width="70" />
							<col width="180" />
						</colgroup>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_job_condition04.gif"></td>
							<td>
								<%
									String starttime = view.getString("WORKSTARTTIME");
									if(!"".equals(starttime) && starttime.length() == 3){
										starttime = "0" + starttime;
									}
									String endtime = view.getString("WORKENDTIME");
									if(!"".equals(endtime) && endtime.length() == 3){
										endtime = "0" + endtime;
									}
								%>
								<input type="text" name="p_workstarttime" maxlength="4" value="<%= starttime %>" style="width:60px;"> 부터
								<input type="text" name="p_workendtime" value="<%=endtime %>" maxlength="4" style="width:60px;"> 까지
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_job_condition05.gif"></td>
							<td>
								<input type="text" name="p_closedday" value="<%= view.getString("CLOSEDDAY") %>" maxlength="50" style="width:150px;">
							</td>
						</tr>
						</table>

						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="15" />
							<col width="80" />
							<col width="" />
						</colgroup>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_job_condition06.gif"></td>
							<td style="padding-bottom:6px;">
								<textarea name="p_welfare" maxlength="500" style="border: solid 1px #d6d6d6; width:480px; height:50px;"><%= view.getString("WELFARE") %></textarea>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_recommend_label05.gif"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-top:10px; padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="15" />
							<col width="80" />
							<col width="" />
						</colgroup>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_support.gif"></td>
							<td>
								<input type="text" name="p_qualification" value="<%= view.getString("QUALIFICATION") %>" maxlength="50" style="width:480px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_school.gif"></td>
							<td>
								<input type="text" name="p_needmajor" value="<%= view.getString("NEEDMAJOR") %>" maxlength="50" style="width:480px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_career.gif"></td>
							<td>
								<select name="p_needcareer">
									<%
										String needcarre = view.getString("NEEDCAREER");
									%>
									<option value="무관" <% if("무관".equals(needcarre)) { %> selected="selected" <% } %>>무관</option>
									<option value="신입" <% if("신입".equals(needcarre)) { %> selected="selected" <% } %>>신입</option>
									<option value="1년" <% if("1년".equals(needcarre)) { %> selected="selected" <% } %>>1년</option>
									<option value="2년" <% if("2년".equals(needcarre)) { %> selected="selected" <% } %>>2년</option>
									<option value="3년" <% if("3년".equals(needcarre)) { %> selected="selected" <% } %>>3년</option>
									<option value="4년" <% if("4년".equals(needcarre)) { %> selected="selected" <% } %>>4년</option>
									<option value="5년이상" <% if("5년이상".equals(needcarre)) { %> selected="selected" <% } %>>5년이상</option>
								</select>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_computer.gif"></td>
							<td style="padding-bottom:6px;">
								<textarea name="p_computer" maxlength="500" style="border: solid 1px #d6d6d6; width:480px; height:50px;"><%= view.getString("COMPUTER") %></textarea>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_special.gif"></td>
							<td style="padding-bottom:6px;">
								<textarea name="p_complimentary" maxlength="500" style="border: solid 1px #d6d6d6; width:480px; height:50px;"><%= view.getString("COMPLIMENTARY") %></textarea>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_language.gif"></td>
							<td>
								<input type="text" name="p_abilitylang" maxlength="50" value="<%= view.getString("ABILITYLANG") %>" style="width:480px;">
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 첨부파일 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_recommend_label06.gif"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-top:10px; padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="15" />
							<col width="80" />
							<col width="" />
						</colgroup>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_attach_file2.gif"></td>
							<td>
								<%=CommonUtil.getMultiFileupload("uploadClass1","p_contractfile", 1, fileList, null, "470") %>
								<input type="hidden" name="p_sfile_name" value="<%= view.getString("SFILE_NAME") %>">
								<input type="hidden" name="p_rfile_name" value="<%= view.getString("RFILE_NAME") %>">
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 인지정보 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_recommend_label07.gif"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-top:10px; padding-bottom:5px; padding-left:5px;">

						<table width="350" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td height="20">본 인력추천을 알게된 경위는?</td>
						</tr>
						<tr valign="top">
							<td style="border-style:solid none solid none; border-width:1px; border-color:#dedede; background-color:#f9f9f9; padding:10px;">
								<%
									String route = view.getString("ROUTE");
								%>
								<input type="radio" name="p_route" value="1" style="border:none;" <% if("".equals(route) || "1".equals(route)) { %> checked="checked" <% } %>> 신문광고<br>
								<input type="radio" name="p_route" value="2" style="border:none;" <% if("2".equals(route)) { %> checked="checked" <% } %>> 온라인 잡 사이트 광고<br>
								<input type="radio" name="p_route" value="3" style="border:none;" <% if("3".equals(route)) { %> checked="checked" <% } %>> 주변 무역업체<br>
								<input type="radio" name="p_route" value="4" style="border:none;" <% if("4".equals(route)) { %> checked="checked" <% } %>> 홍보 메일 또는 DM을 통해<br>
								<input type="radio" name="p_route" value="5" style="border:none;" <% if("5".equals(route)) { %> checked="checked" <% } %>> 기타
								<input type="text" name="p_routeetc" value="<%=view.getString("ROUTEETC") %>" maxlength="150" style="width:250px;">
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td>
						이메일 : <input type="text" maxlength="25" name="p_inemail" value="<%=view.getString("INEMAIL")%>">&nbsp;&nbsp;비밀번호 : <input type="password" maxlength="30" name="p_inpassword" value="<%=view.getString("INPASSWORD")%>"><br> 
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td>* 인재추천의뢰 내용 수정 시 사용됩니다.</td></tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:15px;">
				<tr>
					<td align="right">
						<a href="#none" onclick="goSave();"><img src="/images/common/btn_popup_save.gif"></a>
						<a href="#none" onclick="self.close();"><img src="/images/common/btn_popup_cancel.gif"></a></td>
				</tr>
				</table>
				</form>
			</td>
		</tr>
		<tr>
			<td height="26" background="/images/common/popup_footer_bg.gif" style="padding-left:20px; padding-right:20px;">
				<table width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/common/popup_footer_copyright.gif"></td>
					<td align="right">
						<a href="javascript:self.close();"><img src="/images/common/btn_popup_close.gif"></a></td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
</form>
</body>
