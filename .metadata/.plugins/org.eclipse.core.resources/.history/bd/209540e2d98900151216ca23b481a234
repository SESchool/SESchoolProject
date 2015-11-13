<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/front/common/commonBasicInc.jsp"%>
<%
	Box boxVolunteer = (Box)box.getObject("boxVolunteer");
	DataSet dsVolunteerAcademic = (DataSet)box.getObject("dsVolunteerAcademic");
	DataSet dsVolunteerCareer = (DataSet)box.getObject("dsVolunteerCareer");
	DataSet dsVolunteerEduHistory = (DataSet)box.getObject("dsVolunteerEduHistory");
	DataSet dsVolunteerFamily = (DataSet)box.getObject("dsVolunteerFamily");
	DataSet dsVolunteerLang = (DataSet)box.getObject("dsVolunteerLang");
	DataSet dsVolunteerLicense = (DataSet)box.getObject("dsVolunteerLicense");
	DataSet dsCodeList = (DataSet)box.getObject("dsCodeList");
	
	String v_mode = boxVolunteer.getString("USERID").equals("") ? "W" : "E";
	
	if ( boxVolunteer == null ) {
		boxVolunteer = new Box("data");
	}
	if ( dsCodeList == null ) {
		//dsVolunteerAcademic = new DataSet();
	}
	if ( dsVolunteerCareer == null ) {
		boxVolunteer = new Box("data");
	}
	if ( dsVolunteerEduHistory == null ) {
		boxVolunteer = new Box("data");
	}
	if ( dsVolunteerFamily == null ) {
		boxVolunteer = new Box("data");
	}
	if ( dsVolunteerLang == null ) {
		boxVolunteer = new Box("data");
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=PAGETITLE%></title>
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
<script language="Javascript" src="/js/home/template<%=G_TMPL%>.js"></script>
<fmtag:jscommon point="front" />
<script type="text/javascript">
	function writeVolunteer() {
		var f = document.form1;

		if(!validate(f)) return;
		
		f.action = "/front/Volunteer.do?cmd=volunteerWrite&p_subj="+f.p_subj.value+"&p_year="+f.p_year.value+"&p_subjseq="+f.p_subjseq.value;
		f.cmd.value = "volunteerWrite";
		f.method = "post";
		f.target = "";

		f.submit();
		
	}

	function setBirthday() {
		var f = document.form1;
		var v_jumin1 = f.p_jumin1.value;
		var v_jumin2 = f.p_jumin2.value;
		var sex = "";
		
		if ( v_jumin1.length == 6 && v_jumin2.length == 7 ) {
			var sex = v_jumin2.substr(6,1);
			if ( sex == "1" || sex == "2" ) {
				f.p_byear.value = "19"+v_jumin1.substr(0,2);
			} else if ( sex == "3" || sex == "4" ) {
				f.p_byear.value = "20"+v_jumin1.substr(0,2);
			}
			f.p_bmonth.value = v_jumin1.substr(2,2);
			f.p_bday.value = v_jumin1.substr(4,6);
		}
	}
	
	function checkIsDigit(obj) {
		var str = obj.value;
		for ( var i=0; i < str.length; i++ ) {
			if ( str.substr(i,1) == " " || isNaN(str.charAt(i)) ) {
				alert ("숫자만 입력할수 있습니다.");
				obj.value = str.substr(0,i);
				obj.focus();
				break;
			}
		}
	}
	
	function searchZipCode() {
		var url = "/front/Common.do?cmd=selectZipCode";
		Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
	}
	
	function setZipCodeInfo(addr, zipcode) {
		var form = document.form1;
		
		form.p_address.value = addr;
		if(zipcode.search('-') > -1){	
			form.p_zipcode1.value = zipcode.substr(0, 3) ;
			form.p_zipcode2.value = zipcode.substr(4, 7) ;	
		} else {
			form.p_zipcode1.value = zipcode;		// 새로운 우편주소, 하나의 텍스트란에 넣음
			form.p_zipcode2.value = "";
			form.p_zipcode2.style.display="none";
		}
	}
	
	function addFile() {
		var f = document.form1;
		
		f.p_picturefile.click();
	}
	function setPicture() {
		var f = document.form1;
		var imgMyPicture = document.getElementById("imgMyPicture");
		var tdPicture = document.getElementById("tdPicture");
		//alert ( imgMyPicture.src+"   |    "+f.p_picturefile.value );
		imgMyPicture.src = "file:///"+f.p_picturefile.value;
		imgMyPicture.width = "106";
		imgMyPicture.height = "116";
		//alert ( imgMyPicture.height+"  "+imgMyPicture.width+"   "+imgMyPicture.src );
	}
	
	function addTableRow( v_type ) {
		
		var tbObj = "";
		var newRow = "";
		var rowIdx = "";
		
		if ( v_type == "academic" ) {
			tbObj = document.getElementById("tblAcademic");

			var newRow = tbObj.insertRow(-1);
			newRow.height = "26";
			newRow.style.valign = "top";
			rowIdx = tbObj.rows.length - 1;
			
			var newCell1 = newRow.insertCell(0);
			var newCell2 = newRow.insertCell(1);
			var newCell3 = newRow.insertCell(2);
			var newCell4 = newRow.insertCell(3);

			//newCell1.innerHTML = "<input name=\"p_gradeyear\" id=\"p_gradeyear"+rowIdx+"\" type=\"text\" dispName=\"졸업년도\" isNull=\"N\" lenCheck=\"8\" maxLength=\"8\" value=\"\" style=\"width:145px;\"/>";
			newCell1.innerHTML = "<input name=\"p_gradeyear\" id=\"p_gradeyear"+rowIdx+"\" type=\"text\" dataType=\"integer\" dispName=\"졸업년도\" isNull=\"N\" lenCheck=\"8\" maxLength=\"8\" value=\"\" style=\"width:145px;\" onkeyup=\"checkIsDigit(this);\"/>";
			newCell2.innerHTML = "<input name=\"p_schoolnm\" id=\"p_schoolnm+"+rowIdx+"\" type=\"text\" dispName=\"학교명\" isNull=\"N\" lenCheck=\"50\" maxLength=\"50\" value=\"\" style=\"width:145px;\"/>";
			newCell2.align = "center";
			newCell3.innerHTML = "<input name=\"p_major\" id=\"p_major"+rowIdx+"\" type=\"text\" dispName=\"전공\" isNull=\"N\" lenCheck=\"20\" maxLength=\"20\" value=\"\" style=\"width:145px;\"/>";
			newCell3.align = "center";
			newCell4.innerHTML = "<input name=\"p_locate\" id=\"p_locate"+rowIdx+"\" type=\"text\" dispName=\"소재지\" isNull=\"N\" lenCheck=\"50\" maxLength=\"50\" value=\"\" style=\"width:145px;\"/>";
			newCell4.align = "right";
			
		} else if ( v_type == "career" ) {
			tbObj = document.getElementById("tblCareer");

			var newRow = tbObj.insertRow(-1);
			newRow.height = "26";
			newRow.style.valign = "top";
			rowIdx = tbObj.rows.length - 1;
			
			var newCell1 = newRow.insertCell(0);
			var newCell2 = newRow.insertCell(1);
			var newCell3 = newRow.insertCell(2);
			var newCell4 = newRow.insertCell(3);
			var newCell5 = newRow.insertCell(4);

			newCell1.innerHTML = "<input name=\"p_compnm\" id=\"p_compnm"+rowIdx+"\" type=\"text\" dispName=\"근무처\" isNull=\"N\" lenCheck=\"50\" maxLength=\"50\" value=\"\" style=\"width:120px;\"/>";
			newCell2.innerHTML = "<input name=\"p_position2\" id=\"p_position2"+rowIdx+"\" type=\"text\" dispName=\"직위\" isNull=\"Y\" lenCheck=\"20\" maxLength=\"20\" value=\"\" style=\"width:80px;\"/>";
			newCell3.innerHTML = "<input name=\"p_workstartdt\" id=\"p_workstartdt"+rowIdx+"\" type=\"text\" dataType=\"integer\" dispName=\"근무기간 시작일\" isNull=\"N\" lenCheck=\"8\" maxLength=\"8\" value=\"\" style=\"width:80px;\" onkeyup=\"checkIsDigit(this);\"/> - ";
			newCell3.innerHTML += "<input name=\"p_workenddt\" id=\"p_workenddt"+rowIdx+"\" type=\"text\" dataType=\"integer\" dispName=\"근무기간 종료일\" isNull=\"N\" lenCheck=\"8\" maxLength=\"8\" value=\"\" style=\"width:80px;\" onkeyup=\"checkIsDigit(this);\"/>";
			newCell4.innerHTML = "<input name=\"p_dept\" id=\"p_dept"+rowIdx+"\" type=\"text\" dispName=\"근무부서\" isNull=\"Y\" lenCheck=\"30\" maxLength=\"30\" value=\"\" style=\"width:80px;\"/>";
			newCell5.innerHTML = "<input name=\"p_comptel\" id=\"p_comptel"+rowIdx+"\" type=\"text\" dispName=\"근무부서\" isNull=\"Y\" lenCheck=\"20\" maxLength=\"20\" value=\"\" style=\"width:100px;\"/>";
			
		} else if ( v_type == "eduhistory" ) {
			tbObj = document.getElementById("tblEduHistory");

			var newRow = tbObj.insertRow(-1);
			newRow.height = "26";
			newRow.style.valign = "top";
			rowIdx = tbObj.rows.length - 1;
			
			var newCell1 = newRow.insertCell(0);
			var newCell2 = newRow.insertCell(1);
			var newCell3 = newRow.insertCell(2);
			var newCell4 = newRow.insertCell(3);

			newCell1.innerHTML = "<input name=\"p_eduname\" id=\"p_eduname"+rowIdx+"\" type=\"text\" dispName=\"교육과정명\" isNull=\"N\" lenCheck=\"100\" maxLength=\"100\" value=\"\" style=\"width:130px;\"/>";
			newCell2.innerHTML = "<input name=\"p_edustartdt\" id=\"p_edustartdt"+rowIdx+"\" type=\"text\" dataType=\"integer\" dispName=\"교육기간 시작일\" isNull=\"N\" lenCheck=\"8\" maxLength=\"8\" value=\"\" style=\"width:80px;\"/> - ";
			newCell2.innerHTML += "<input name=\"p_eduenddt\" id=\"p_eduenddt"+rowIdx+"\" type=\"text\" dataType=\"integer\" dispName=\"교육기간 종료일\" isNull=\"N\" lenCheck=\"8\" maxLength=\"8\" value=\"\" style=\"width:80px;\"/>";
			newCell3.innerHTML = "<input name=\"p_academyname\" id=\"p_academyname"+rowIdx+"\" type=\"text\" dispName=\"기관명\" isNull=\"N\" lenCheck=\"30\" maxLength=\"30\" value=\"\" style=\"width:80px;\"/>";
			newCell4.innerHTML = "<input name=\"p_edudetail\" id=\"p_edudetail"+rowIdx+"\" type=\"text\" dispName=\"교육내용\" isNull=\"N\" lenCheck=\"300\" maxLength=\"300\" value=\"\" style=\"width:180px;\"/>";
			
		} else if ( v_type == "language" ) {
			tbObj = document.getElementById("tblLanguage");

			var newRow = tbObj.insertRow(-1);
			newRow.height = "26";
			newRow.style.valign = "top";
			rowIdx = tbObj.rows.length - 1;
			
			var newCell1 = newRow.insertCell(0);
			var newCell2 = newRow.insertCell(1);
			var newCell3 = newRow.insertCell(2);
			var newCell4 = newRow.insertCell(3);
			var newCell5 = newRow.insertCell(4);

			newCell1.innerHTML = "<input name=\"p_language\" id=\"p_language"+rowIdx+"\" type=\"text\" dispName=\"언어\" isNull=\"N\" lenCheck=\"100\" maxLength=\"100\" value=\"\" style=\"width:100px;\"/>";
			newCell2.innerHTML = "<input name=\"p_testnm\" id=\"p_testnm"+rowIdx+"\" type=\"text\" dispName=\"시험명\" isNull=\"N\" lenCheck=\"100\" maxLength=\"100\" value=\"\" style=\"width:173px;\"/>";
			newCell3.innerHTML = "<input name=\"p_score\" id=\"p_score"+rowIdx+"\" type=\"text\" dispName=\"점수/등급\" isNull=\"N\" lenCheck=\"30\" maxLength=\"30\" value=\"\" style=\"width:80px;\"/>";
			newCell4.innerHTML = "<input name=\"p_issueorgan\" id=\"p_issueorgan"+rowIdx+"\" type=\"text\" dispName=\"발급기관\" isNull=\"Y\" lenCheck=\"30\" maxLength=\"30\" value=\"\" style=\"width:100px;\"/>";
			newCell5.innerHTML = "<input name=\"p_getdate\" type=\"text\" dataType=\"integer\" dispName=\"취득일자\" isNull=\"N\" lenCheck=\"8\" maxLength=\"8\" value=\"\" style=\"width:100px;\" onkeyup=\"checkIsDigit(this);\"/>";
			
		} else if ( v_type == "family" ) {
			tbObj = document.getElementById("tblFamily");

			var newRow = tbObj.insertRow(-1);
			newRow.height = "26";
			newRow.style.valign = "top";
			rowIdx = tbObj.rows.length - 1;
			
			var newCell1 = newRow.insertCell(0);
			var newCell2 = newRow.insertCell(1);
			var newCell3 = newRow.insertCell(2);
			var newCell4 = newRow.insertCell(3);
			var newCell5 = newRow.insertCell(4);
			var newCell6 = newRow.insertCell(5);
			var newCell7 = newRow.insertCell(6);

			newCell1.innerHTML = "<input name=\"p_relationship\" id=\"p_relationship"+rowIdx+"\" type=\"text\" dispName=\"관계\" isNull=\"N\" lenCheck=\"100\" maxLength=\"100\" value=\"\" style=\"width:70px;\"/>";
			newCell2.innerHTML = "<input name=\"p_name\" id=\"p_name"+rowIdx+"\" type=\"text\" dispName=\"성명\" isNull=\"N\" lenCheck=\"100\" maxLength=\"100\" value=\"\" style=\"width:82px;\"/>";
			newCell3.innerHTML = "<input name=\"p_age\" id=\"p_age"+rowIdx+"\" type=\"text\" dispName=\"연령\" isNull=\"N\" lenCheck=\"3\" maxLength=\"3\" value=\"\" style=\"width:70px;\"/>";
			newCell4.innerHTML = "<input name=\"p_academic\" id=\"p_academic"+rowIdx+"\" type=\"text\" dispName=\"학력\" isNull=\"Y\" lenCheck=\"30\" maxLength=\"30\" value=\"\" style=\"width:70px;\"/>";
			newCell5.innerHTML = "<input name=\"p_job\" id=\"p_job"+rowIdx+"\" type=\"text\" dispName=\"직업\" isNull=\"Y\" lenCheck=\"300\" maxLength=\"300\" value=\"\" style=\"width:70px;\"/>";
			newCell6.innerHTML = "<input name=\"p_position3\" id=\"p_position3"+rowIdx+"\" type=\"text\" dispName=\"직위\" isNull=\"Y\" lenCheck=\"30\" maxLength=\"30\" value=\"\" style=\"width:70px;\"/>";
			newCell7.innerHTML = "<input type=\"radio\" name=\"p_istogether"+(rowIdx-2)+"\" value=\"Y\" style=\"border:none;\" checked>예&nbsp;";
			newCell7.innerHTML += "<input type=\"radio\" name=\"p_istogether"+(rowIdx-2)+"\" value=\"N\" style=\"border:none;\">아니오";
			
		} else if ( v_type == "license" ) {
			tbObj = document.getElementById("tblLicense");

			var newRow = tbObj.insertRow(-1);
			newRow.height = "26";
			newRow.style.valign = "top";
			rowIdx = tbObj.rows.length - 1;
			
			var newCell1 = newRow.insertCell(0);
			var newCell2 = newRow.insertCell(1);
			var newCell3 = newRow.insertCell(2);
			var newCell4 = newRow.insertCell(3);

			newCell1.innerHTML = "<input name=\"p_licensenm\" id=\"p_licensenm"+rowIdx+"\" type=\"text\" dispName=\"자격증명\" isNull=\"N\" lenCheck=\"50\" maxLength=\"50\" value=\"\" style=\"width:282px;\"/>";
			newCell2.innerHTML = "<input name=\"p_grade\" id=\"p_grade"+rowIdx+"\" type=\"text\" dispName=\"등급\" isNull=\"Y\" lenCheck=\"10\" maxLength=\"10\" value=\"\" style=\"width:80px;\"/>";
			newCell2.align = "center";
			newCell3.innerHTML = "<input name=\"p_getdate2\" id=\"p_getdate"+rowIdx+"\" type=\"text\" dataType=\"integer\" dispName=\"취득일자\" isNull=\"N\" lenCheck=\"8\" maxLength=\"8\" value=\"\" style=\"width:100px;\" onkeyup=\"checkIsDigit(this);\"/>";
			newCell3.align = "center";
			newCell4.innerHTML = "<input name=\"p_org\" id=\"p_org"+rowIdx+"\" type=\"text\" dispName=\"발급기관\" isNull=\"Y\" lenCheck=\"30\" maxLength=\"30\" value=\"\" style=\"width:100px;\"/>";
			
		}
		
	}
	function delTableRow( v_type ) {
		
		var tbObj = "";
		var rowIdx = "";
		
		if ( v_type == "academic" ) {
			tbObj = document.getElementById("tblAcademic");
			rowIdx = tbObj.rows.length - 1;
			
		} else if ( v_type == "career" ) {
			tbObj = document.getElementById("tblCareer");
			rowIdx = tbObj.rows.length - 1;
			
		} else if ( v_type == "eduhistory" ) {
			tbObj = document.getElementById("tblEduHistory");
			rowIdx = tbObj.rows.length - 1;
			
		} else if ( v_type == "language" ) {
			tbObj = document.getElementById("tblLanguage");
			rowIdx = tbObj.rows.length - 1;
			
		} else if ( v_type == "family" ) {
			tbObj = document.getElementById("tblFamily");
			rowIdx = tbObj.rows.length - 1;
			
		} else if ( v_type == "license" ) {
			tbObj = document.getElementById("tblLicense");
			rowIdx = tbObj.rows.length - 1;
			
		}

		if ( rowIdx > 2 ) {
			tbObj.deleteRow(rowIdx);
		}
	}
</script>
</head>
 
<a name="Top"></a>
<body style="margin:0px;">
 
<!--//-->
 
<table width="100%" height="100%" cellpadding="0" cellspacing="0">
<tr>
	<td align="center" height="100%" valign="top">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="42" background="/images/common/popup_header_bg.gif">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/template0/common/popup_account_title.gif" alt="결재현황" /></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="100%" valign="top" align="center" style="padding:20px;">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/template0/common/popup_account_label01.gif" alt="무통장입금정보" /></td>
				</tr>
				<tr><td height="5"></td></tr>
				</table>
 
				<div class="board-list-popup">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<caption>수강신청 - 개인정보확인</caption>
					<colgroup>
						<col width="100" />
						<col width="" />
					</colgroup>
					<tr>
						<th>입금은행</th>
						<td class="td_lefttext2">우리은행</td>
					</tr>
					<tr>
						<th>계좌번호</th>
						<td class="td_lefttext2">111-1111-1111111-111-11</td>
					</tr>
					<tr>
						<th>예금주</th>
						<td class="td_lefttext2">(주)한국무역협회</td>
					</tr>
					<tr>
						<th>수강료</th>
						<td class="td_lefttext2">60,000원</td>
					</tr>
					<tr>
						<th>입금일</th>
						<td class="td_lefttext2">2010.11.20</td>
					</tr>
					</table>
				</div>
 
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:5px;">
				<tr>
					<td>* 일부 은행의 경우 예금주가 (주)이니시스로 표시될 수 있습니다.</td>
					<td align="right">
						<a href="#"><img src="/images/template0/common/btn_popup_confirm_2.gif"></a></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="25" background="/images/common/popup_footer_bg.gif" style="padding-left:20px; padding-right:20px;">
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
</body>
</html>
