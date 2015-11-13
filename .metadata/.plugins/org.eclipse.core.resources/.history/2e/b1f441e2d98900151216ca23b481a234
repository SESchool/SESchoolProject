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

	String v_subj = box.getString("p_subj");
	String v_year = box.getString("p_year");
	String v_subjseq = box.getString("p_subjseq");
	String v_userid = box.getString("p_userid");
	
	String v_volunteerYN = box.getString("volunteerYN");
	String UPLOAD_CONTEXT = box.getString("UPLOAD_CONTEXT");
	String v_serverurl = request.getServerName();
	
	String v_mode = v_volunteerYN.equals("Y") ? "E" : "W";

	if ( boxVolunteer == null ) {
		boxVolunteer = new Box("data");
	}
	/*
	if ( dsVolunteerAcademic == null ) {
		dsVolunteerAcademic = new DataSet();
	}
	if ( dsVolunteerCareer == null ) {
		dsVolunteerCareer = new DataSet();
	}
	if ( dsVolunteerEduHistory == null ) {
		dsVolunteerEduHistory = new DataSet();
	}
	if ( dsVolunteerFamily == null ) {
		dsVolunteerFamily = new DataSet();
	}
	if ( dsVolunteerLang == null ) {
		dsVolunteerLang = new DataSet();
	}
	*/
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=PAGETITLE%></title>
<style type="text/css">
        .preView { width: 106px; height: 116px; text-align: center; border:1px solid silver; background: url('/images/common/popup_teacher_noimg.gif') repeat-x;}
</style>
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
<script language="Javascript" src="/js/home/template<%=G_TMPL%>.js"></script>
<fmtag:jscommon point="front" />
<script type="text/javascript">
	function writeVolunteer(v_mode) {
		var f = document.form1;
		if(!validate(f)) return;
		if(!validateEtc(f)) return;
		
		f.action = "/front/Volunteer.do?cmd=volunteerWrite&p_mode="+v_mode+"&p_ispicturedelete="+f.p_ispicturedelete.value+"&p_subj="+f.p_subj.value+"&p_year="+f.p_year.value+"&p_subjseq="+f.p_subjseq.value;
		f.cmd.value = "volunteerWrite";
		f.method = "post";
		f.target = "";

		f.submit();
	}
	function validateEtc(f) {

		if ( f.p_oldpicturefile.value == "" && f.p_picturefile.value == "" ) {
			alert("사진을 선택해 주십시요");
	        return false;
		}
		if(f.p_picturefile.value != "" && !/(\.gif|\.jpg|\.jpeg|\.png)$/i.test(f.p_picturefile.value)) {
	        alert("이미지 형식의 파일을 선택하십시오");
	        return false;
	    }

	    return true;
	}

	function setBirthday() {
		var f = document.form1;
		var v_jumin1 = f.p_jumin1.value;
		var v_jumin2 = f.p_jumin2.value;
		var sex = "";

		if ( v_jumin1.length == 6 && v_jumin2.length == 7 ) {
			var sex = v_jumin2.substr(0,1);
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
		document.domain = "tradecampus.kita.net";
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
			newCell2.innerHTML = "<input name=\"p_edustartdt\" id=\"p_edustartdt"+rowIdx+"\" type=\"text\" dataType=\"integer\" dispName=\"교육기간 시작일\" isNull=\"N\" lenCheck=\"8\" maxLength=\"8\" value=\"\" style=\"width:80px;\" onkeyup=\"checkIsDigit(this);\"/> - ";
			newCell2.innerHTML += "<input name=\"p_eduenddt\" id=\"p_eduenddt"+rowIdx+"\" type=\"text\" dataType=\"integer\" dispName=\"교육기간 종료일\" isNull=\"N\" lenCheck=\"8\" maxLength=\"8\" value=\"\" style=\"width:80px;\" onkeyup=\"checkIsDigit(this);\"/>";
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
			newCell3.innerHTML = "<input name=\"p_age\" dataType=\"integer\" id=\"p_age"+rowIdx+"\" type=\"text\" dispName=\"연령\" isNull=\"N\" lenCheck=\"3\" maxLength=\"3\" value=\"\" style=\"width:70px;\" onkeyup=\"checkIsDigit(this);\"/>";
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

	function fileUploadPreview(thisObj, preViewer) {

		var f = document.form1;
		
		f.p_ispicturedelete.value = "Y";
		
	    if(!/(\.gif|\.jpg|\.jpeg|\.png)$/i.test(thisObj.value)) {
	        alert("이미지 형식의 파일을 선택하십시오");
	        return;
	    }

	    preViewer = (typeof(preViewer) == "object") ? preViewer : document.getElementById(preViewer);
	    preViewer.innerHTML = "";
	    var ua = window.navigator.userAgent;

	    if (ua.indexOf("MSIE 8") > -1) {
	        thisObj.select();

	        var selectionRange = document.selection.createRange();
	        var selectionText = selectionRange.text.toString();

	        preViewer.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='file://" + selectionText +"', sizingMethod='scale')";
	        thisObj.blur();
	    } else if (ua.indexOf("MSIE 7") > -1) {
	        preViewer.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='file://" + thisObj.value +"', sizingMethod='scale')";
	    } else {
	        preViewer.innerHTML = "";
	        var W = preViewer.offsetWidth;
	        var H = preViewer.offsetHeight;
	        var tmpImage = document.createElement("img");
	        preViewer.appendChild(tmpImage);

	        tmpImage.onerror = function () {
	            return preViewer.innerHTML = "";
	        }

	        tmpImage.onload = function () {
	            if (this.width > W) {
	                this.height = this.height / (this.width / W);
	                this.width = W;
	            }
	            if (this.height > H) {
	                this.width = this.width / (this.height / H);
	                this.height = H;
	            }
	        }
	        if (ua.indexOf("Firefox/3") > -1) {
	            var picData = thisObj.files.item(0).getAsDataURL();
	            tmpImage.src = picData;
	        } else {
	            tmpImage.src = "file://" + thisObj.value;
	        }
	    }
	}
</script>

</head>

<a name="Top"></a>
<body style="margin:0px;">

<!--//-->
<form name="form1" action="/front/Volunteer.do?cmd=volunteerWriteForm" method="post" onSubmit="return false;" enctype="multipart/form-data">
<input type="hidden" name="cmd" value="volunteerWriteForm">
<input type="hidden" name="p_mode" value="<%=v_mode%>">
<input type="hidden" name="p_subj" value="<%=box.getString("p_subj")%>">
<input type="hidden" name="p_year" value="<%=v_year%>">
<input type="hidden" name="p_subjseq" value="<%=box.getString("p_subjseq")%>">
<input type="hidden" name="p_userid" value="<%=box.getString("p_userid")%>">
<input type="hidden" name="p_ispicturedelete" value="N">
<input type="hidden" name="p_oldpicturefile" value="<%=boxVolunteer.getString("PICTURE")%>">
<table width="100%" height="100%" cellpadding="0" cellspacing="0">
<tr>
	<td align="center" height="100%" valign="top">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="42" background="/images/common/popup_header_bg.gif">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/common/popup_support_request_title.gif"></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="100%" valign="top" align="left" style="padding:20px;">
				<!-- 기본정보 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-top:10px; padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="" />
							<col width="12" />
							<col width="250" />
						</colgroup>
						<tr valign="top">
							<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<colgroup>
									<col width="15" />
									<col width="80" />
									<col width="" />
								</colgroup>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
									<td style="padding-top:4px;"><img src="/images/common/txt_name.gif"></td>
									<td>
										<input name="p_korname" type="text" dispName="성명(한글)" isNull="N" lenCheck="20" maxLength="20" value="<%=boxVolunteer.getStringDefault("KOR_NAME", "한글") %>" style="width:230px;" onclick="if(this.value=='한글')this.value='';this.onclick=''"/>
									</td>
								</tr>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:6px;"></td>
									<td style="padding-top:3px;"></td>
									<td>
										<input name="p_hansaname" type="text" dispName="성명(漢字)" isNull="N" lenCheck="20" maxLength="20" value="<%=boxVolunteer.getStringDefault("HANSA_NAME", "(漢字)") %>" style="width:230px;" onclick="if(this.value=='(漢字)')this.value='';this.onclick=''"/>
									</td>
								</tr>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:6px;"></td>
									<td style="padding-top:3px;"></td>
									<td>
										<input name="p_engname" type="text" dispName="성명(영문)" isNull="N" lenCheck="20" maxLength="20" value="<%=boxVolunteer.getStringDefault("ENG_NAME", "영문") %>" style="width:230px;" onclick="if(this.value=='영문')this.value='';this.onclick=''"/>
									</td>
								</tr>								
							<%
								String v_jumin1 = (boxVolunteer.getString("JUMIN").length()>=6) ? boxVolunteer.getString("JUMIN").substring(0,6) : "";
								String v_jumin2 = (boxVolunteer.getString("JUMIN").length()>=13) ? boxVolunteer.getString("JUMIN").substring(6,13) : "";
								box.put("p_jumin1", v_jumin1);
								box.put("p_jumin2", v_jumin2);								
							%>
							<!-- 주민등록번호탭 노출 지정안함 / 20130528-->
								<%-- <tr valign="top" height="26" style="display: none;" >	
									<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
									<td style="padding-top:4px;"><img src="/images/common/txt_resno.gif"></td>
									<td>
										<input name="p_jumin1" type="hidden" size="6" maxLength="6" value="<%=v_jumin1%>" style="width:105px;" onblur="setBirthday(this);"/>
										-
										<input name="p_jumin2" type="hidden" size="7" maxLength="7" value="<%=v_jumin2%>" style="width:110px;" onblur="setBirthday(this);" readonly="readonly"/>
									</td>
								</tr>  --%>
							<%
								/*
								String v_sex = (boxVolunteer.getString("JUMIN").length()>=7) ? boxVolunteer.getString("JUMIN").substring(6,7) : "";
								String v_byear = (boxVolunteer.getString("JUMIN").length()>=2) ? boxVolunteer.getString("JUMIN").substring(0,2) : "";
								String v_bmonth = (boxVolunteer.getString("JUMIN").length()>=4) ? boxVolunteer.getString("JUMIN").substring(2,4) : "";
								String v_bday = (boxVolunteer.getString("JUMIN").length()>=6) ? boxVolunteer.getString("JUMIN").substring(4,6) : "";

								if ( !v_byear.equals("") && (v_sex.equals("1") || v_sex.equals("2")) ) {
									v_byear += "19";
								} else if ( !v_byear.equals("") && (v_sex.equals("3") || v_sex.equals("4")) ) {
									v_byear += "20";
								}
								*/

								String v_byear = (boxVolunteer.getString("BIRTHDAY").length()>=4) ? boxVolunteer.getString("BIRTHDAY").substring(0,4) : "";
								String v_bmonth = (boxVolunteer.getString("BIRTHDAY").length()>=6) ? boxVolunteer.getString("BIRTHDAY").substring(4,6) : "";
								String v_bday = (boxVolunteer.getString("BIRTHDAY").length()>=8) ? boxVolunteer.getString("BIRTHDAY").substring(6,8) : "";
								
								//생년,월,일 공백일경우 주민번호 이용하여 입력 - 20130528
								if(v_byear.equals("")&&v_bmonth.equals("")&&v_bday.equals("")){ 
									if ( v_jumin1.length() == 6 && v_jumin2.length() == 7 ) {
										String sex = v_jumin2.substring(0,1);
										try{
											if(Integer.parseInt(v_jumin1.substring(0, 2)) >30 ){
												v_byear = "19"+v_jumin1.substring(0,2);	
											}else if(Integer.parseInt(v_jumin1.substring(0, 2)) <= 30){
												v_byear = "20"+v_jumin1.substring(0,2);	
											}
										}catch(NumberFormatException e){
											System.out.println(e);											
										}										
/* 									바뀐 주민등록번호로는 년도를 구할수 없음
										if ( sex.equals("1") || sex.equals("2")) {
											v_byear = "19"+v_jumin1.substring(0,2);
										} else if ( sex.equals("3") || sex.equals("4") ) {
											v_byear = "20"+v_jumin1.substring(0,2);
										} */
										v_bmonth = v_jumin1.substring(2,4);
										v_bday = v_jumin1.substring(4,6);
									}								
								}
																	
							%>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
									<td style="padding-top:4px;"><img src="/images/common/txt_birthday.gif"></td>
									<td>
										<input name="p_byear" type="text" dataType="integer" dispName="생년" isNull="N" lenCheck="4" maxLength="4" value="<%=v_byear%>" style="width:60px; text-align: right;"  /> 년&nbsp;
										<input name="p_bmonth" type="text" dataType="integer" dispName="생월" isNull="Y" lenCheck="2" maxLength="2" value="<%=v_bmonth%>" style="width:50px; text-align: right;"/> 월&nbsp;
										<input name="p_bday" type="text" dataType="integer" dispName="생일" isNull="Y" lenCheck="2" maxLength="2" value="<%=v_bday%>" style="width:50px; text-align: right;"/> 일&nbsp;
									</td>
								</tr>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
									<td style="padding-top:4px;"><img src="/images/common/txt_military.gif"></td>
									<td>
										<input type="radio" name="p_military" value="Y" style="border:none;"<%=(boxVolunteer.getString("MILITARY").equals("Y"))?" checked":"" %> onclick="document.form1.p_nomilitaryreason.disabled=true"> 군필&nbsp;&nbsp;
										<input type="radio" name="p_military" value="N" style="border:none;"<%=(boxVolunteer.getString("MILITARY").equals("N"))?" checked":"" %> onclick="document.form1.p_nomilitaryreason.disabled=false"> 미필&nbsp;&nbsp;
										<input type="radio" name="p_military" value="E" style="border:none;"<%=(boxVolunteer.getStringDefault("MILITARY","E").equals("E"))?" checked":"" %> onclick="document.form1.p_nomilitaryreason.disabled=false"> 면제
										<input name="p_nomilitaryreason" type="text" dispName="면제사유" isNull="Y" lenCheck="50" maxLength="50" value="<%=boxVolunteer.getStringDefault("NOMILITARYREASON","면제사유") %>" style="width:200px;" onclick="if(this.value=='면제사유')this.value='';this.onclick=''"<%=(boxVolunteer.getStringDefault("MILITARY","E").equals("Y"))?" disabled":"" %>/>
									</td>
								</tr>
								</table>
							</td>
							<td></td>
							<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<colgroup>
									<col width="118" />
									<col width="14" />
									<col width="118" />
								</colgroup>
								<tr valign="top">
									<td>
										<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<table width="115" border="0" cellpadding="0" cellspacing="0" class="noline">
												<tr>
													<td class="td_noline" style="padding:6px; background-color:#ebebeb;">
														<div id="preView" class="preView" title="이미지미리보기">
													<%	if ( !boxVolunteer.getString("PICTURE").equals("") ) {
															String v_imgpath = null;
															if ( !boxVolunteer.getString("OLD_SID").equals("") ) {
																if ( boxVolunteer.getString("TRAININGCLASS").equals("03") ) {
																	v_imgpath = "http://"+v_serverurl+UPLOAD_CONTEXT+"/volunteer/old_trademaster/"+boxVolunteer.getString("PICTURE");
																} else if ( boxVolunteer.getString("TRAININGCLASS").equals("04") ) {
																	v_imgpath = "http://"+v_serverurl+UPLOAD_CONTEXT+"/volunteer/old_itmaster/"+boxVolunteer.getString("PICTURE");
																}
															} else {
																v_imgpath = "http://"+v_serverurl+UPLOAD_CONTEXT+"/volunteer/"+v_subj+"/"+v_year+"/"+v_subjseq+"/"+boxVolunteer.getString("PICTURE");
															}
													%>
															<img width="105px" height="115px" src="<%=v_imgpath %>"></img>
													<%	} %>
														</div>
														</td>
												</tr>
												</table>
											</td>
										</tr>
										<tr><td height="20"></td></tr>
										<tr>
											<td><!-- a href="#none" onclick="javascript:addFile()"><img src="/images/common/btn_file_find.gif" -->
											<input type="file" name="p_picturefile" value="" onchange="fileUploadPreview(this, 'preView')" style="display:; width:200px; height:18px; background-color:#FFFFFF;" dispName="사진" isNull="Y">
											</td>
										</tr>
										</table>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						</table>

						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:5px;">
						<colgroup>
							<col width="15" />
							<col width="80" />
							<col width="" />
						</colgroup>
						<%-- <tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_military.gif"></td>
							<td>
								<input type="radio" name="p_military" value="Y" style="border:none;"<%=(boxVolunteer.getString("MILITARY").equals("Y"))?" checked":"" %> onclick="document.form1.p_nomilitaryreason.disabled=true"> 군필&nbsp;&nbsp;
								<input type="radio" name="p_military" value="N" style="border:none;"<%=(boxVolunteer.getString("MILITARY").equals("N"))?" checked":"" %> onclick="document.form1.p_nomilitaryreason.disabled=false"> 미필&nbsp;&nbsp;
								<input type="radio" name="p_military" value="E" style="border:none;"<%=(boxVolunteer.getStringDefault("MILITARY","E").equals("E"))?" checked":"" %> onclick="document.form1.p_nomilitaryreason.disabled=false"> 면제
								<input name="p_nomilitaryreason" type="text" dispName="면제사유" isNull="Y" lenCheck="50" maxLength="50" value="<%=boxVolunteer.getStringDefault("NOMILITARYREASON","면제사유") %>" style="width:330px;" onclick="if(this.value=='면제사유')this.value='';this.onclick=''"<%=(boxVolunteer.getStringDefault("MILITARY","E").equals("Y"))?" disabled":"" %>/>
							</td>
						</tr> --%>
					<%
						String zipcode = boxVolunteer.getString("ZIPCODE");
						String zipcode1;
						String zipcode2; 
						if( zipcode.contains("-")){
							zipcode1 = zipcode.substring(0, zipcode.indexOf("-"));
							zipcode2 = zipcode.substring(zipcode.indexOf("-")+1, zipcode.length());
						} else {
							zipcode1 = zipcode;
							zipcode2 = "";
						}
					%>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_now_address.gif"></td>
							<td>
								<% if( zipcode2 == null || zipcode2.equals("")){ %>
									<input name="p_zipcode1" type="text" dataType="integer" dispName="우편번호" isNull="Y" lenCheck="5" maxLength="5" value="<%= zipcode1 %>" style="width:100px;" readOnly/>
									<input name="p_zipcode2" type="hidden" dispName="우편번호" value="<%= zipcode2 %>" >
								<% } else { %>
									<input name="p_zipcode1" type="text" dataType="integer" dispName="우편번호" isNull="Y" value="<%= zipcode1 %>" style="width:100px;" readOnly/> -
									<input name="p_zipcode2" type="text" dataType="integer" dispName="우편번호" value="<%= zipcode2 %>" style="width:100px;" readOnly/>
								<% } %>
								<a href="#none" onclick="javascript:searchZipCode()"><img src="/images/common/btn_popup_search_2.gif" alt="우편번호찾기"></a>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"></td>
							<td style="padding-top:4px;"></td>
							<td>
								<input name="p_address" type="text" dispName="주소" isNull="Y" lenCheck="100" maxLength="100" value="<%=boxVolunteer.getString("ADDRESS") %>" style="width:497px;" />
							</td>
						</tr>
					<%
						String[] arrPhone = boxVolunteer.getString("TEL").split("-");
						String[] arrHandPhone = boxVolunteer.getString("HANDPHONE").split("-");
					%>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_phone.gif"></td>
							<td>
								<input name="p_tel1" type="text" size="4" dataType="integer" dispName="연락처" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>=2)?arrPhone[0]:"" %>" style="width:80px;" onkeyup="checkIsDigit(this);"> -
								<input name="p_tel2" type="text" size="4" dataType="integer" dispName="연락처" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>=2)?arrPhone[1]:"" %>" style="width:100px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_tel3" type="text" size="4" dataType="integer" dispName="연락처" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>=3)?arrPhone[2]:"" %>" style="width:100px;" onkeyup="checkIsDigit(this);"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_mobile.gif"></td>
							<td>
								<input name="p_handphone1" type="text" size="4" dataType="integer" dispName="핸드폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=2)?arrHandPhone[0]:"" %>" style="width:80px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_handphone2" type="text" size="4" dataType="integer" dispName="핸드폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=2)?arrHandPhone[1]:"" %>" style="width:100px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_handphone3" type="text" size="4" dataType="integer" dispName="핸드폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=3)?arrHandPhone[2]:"" %>" style="width:100px;" onkeyup="checkIsDigit(this);"/>

							</td>
						</tr>
						<%
							String[] arrEmail = boxVolunteer.getString("EMAIL").split("@");
						%>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_email.gif"></td>
							<td>
								<input name="p_email1" type="text" dispName="이메일" isNull="Y" lenCheck="50" maxLength="50" value="<%=(arrEmail.length>=1)?arrEmail[0]:"" %>" style="width:100px;"/>
								@
								<input name="p_email2" type="text" dispName="이메일" isNull="Y" lenCheck="50" maxLength="50" value="<%=(arrEmail.length>=2)?arrEmail[1]:"" %>" style="width:140px;" onblur="if(this.value.toLowerCase()=='kita.net'){alert('kita.NET 외의 다른 메일을 입력해주세요.');this.value='';document.form1.p_email2.focus();}"/>
								<img src="/images/common/icon_exclamation.gif"> <span style="color:#f26522;">kita.NET 외의 다른 메일을 입력해주세요.</span>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_company_sosok.gif"></td>
							<td>
								<input name="p_company" type="text" dispName="회사명(소속)" isNull="Y" lenCheck="50" maxLength="50" value="<%=boxVolunteer.getString("COMPANY") %>" style="width:230px;"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_jikwi.gif"></td>
							<td>
								<input name="p_position" type="text" dispName="직위" isNull="Y" lenCheck="30" maxLength="30" value="<%=boxVolunteer.getString("POSITION") %>" style="width:230px;"/>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 학력사항 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_support_request_label01.gif"></td>
							<td align="right" valign="bottom">
								<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<a href="#none" onclick="javascript:addTableRow('academic')"><img src="/images/common/btn_popup_icon_insert.gif"></a></td>
									<td style="padding-left:1px;">
										<a href="#none" onclick="javascript:delTableRow('academic')"><img src="/images/common/btn_popup_icon_delete.gif"></a></td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-bottom:5px;">
						<table id="tblAcademic" width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="145" />
							<col width="" />
							<col width="150" />
							<col width="145" />
						</colgroup>
						<tr>
							<td align="center"><img src="/images/common/txt_graduate_date.gif"></td>
							<td align="center"><img src="/images/common/txt_school_name.gif"></td>
							<td align="center"><img src="/images/common/txt_major.gif"></td>
							<td align="center"><img src="/images/common/txt_location.gif"></td>
						</tr>
						<tr><td height="1" colspan="4" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
			<%	if ( dsVolunteerAcademic != null && dsVolunteerAcademic.getRow() > 0 ) {
					while ( dsVolunteerAcademic.next() ) { %>
						<tr valign="top" height="26">
							<td>
								<input name="p_gradeyear" type="text" dataType="integer" dispName="졸업년도" isNull="N" lenCheck="8" maxLength="8" value="<%=dsVolunteerAcademic.getString("GRADEYEAR")%>" style="width:145px;" onkeyup="checkIsDigit(this);"/>
							</td>
							<td align="center">
								<input name="p_schoolnm" type="text" dispName="학교명" isNull="N" lenCheck="50" maxLength="50" value="<%=dsVolunteerAcademic.getString("SCHOOLNM")%>" style="width:145px;"/>
							</td>
							<td align="center">
								<input name="p_major" type="text" dispName="전공" isNull="N" lenCheck="20" maxLength="20" value="<%=dsVolunteerAcademic.getString("MAJOR")%>" style="width:145px;"/>
							</td>
							<td align="right">
								<input name="p_locate" type="text" dispName="소재지" isNull="N" lenCheck="50" maxLength="50" value="<%=dsVolunteerAcademic.getString("LOCATE")%>" style="width:145px;"/>
							</td>
						</tr>
			<%		}
				} else { %>
						<tr valign="top" height="26">
							<td>
								<input name="p_gradeyear" type="text" dataType="integer" dispName="졸업년도" isNull="N" lenCheck="8" maxLength="8" value="" style="width:145px;" onkeyup="checkIsDigit(this);"/>
							</td>
							<td align="center">
								<input name="p_schoolnm" type="text" dispName="학교명" isNull="N" lenCheck="50" maxLength="50" value="" style="width:145px;"/>
							</td>
							<td align="center">
								<input name="p_major" type="text" dispName="전공" isNull="N" lenCheck="20" maxLength="20" value="" style="width:145px;"/>
							</td>
							<td align="right">
								<input name="p_locate" type="text" dispName="소재지" isNull="N" lenCheck="50" maxLength="50" value="" style="width:145px;"/>
							</td>
						</tr>
			<%	}  %>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 경력사항 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_support_request_label02.gif"></td>
							<td align="right" valign="bottom">
								<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<a href="#none" onclick="javascript:addTableRow('career')"><img src="/images/common/btn_popup_icon_insert.gif"></a></td>
									<td style="padding-left:1px;">
										<a href="#none" onclick="javascript:delTableRow('career')"><img src="/images/common/btn_popup_icon_delete.gif"></a></td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-bottom:5px;">
						<table id="tblCareer" width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="" />
							<col width="90" />
							<col width="180" />
							<col width="90" />
							<col width="100" />
						</colgroup>
						<tr>
							<td align="center"><img src="/images/common/txt_work_part.gif"></td>
							<td align="center"><img src="/images/common/txt_jikwi.gif"></td>
							<td align="center"><img src="/images/common/txt_work_date.gif"></td>
							<td align="center"><img src="/images/common/txt_work_office.gif"></td>
							<td align="center"><img src="/images/common/txt_company_phone.gif"></td>
						</tr>
						<tr><td height="1" colspan="5" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
				<%	if ( dsVolunteerCareer != null && dsVolunteerCareer.getRow() > 0 ) {
					while ( dsVolunteerCareer.next() ) { %>
						<tr valign="top" height="26">
							<td>
								<input name="p_compnm" type="text" dispName="근무처" isNull="N" lenCheck="50" maxLength="50" value="<%=dsVolunteerCareer.getString("COMPNM")%>" style="width:120px;"/>
							</td>
							<td>
								<input name="p_position2" type="text" dispName="직위" isNull="Y" lenCheck="20" maxLength="20" value="<%=dsVolunteerCareer.getString("POSITION")%>" style="width:80px;"/>
							</td>
							<td>
								<input name="p_workstartdt" type="text" dataType="integer" dispName="근무기간 시작일" isNull="N" lenCheck="8" maxLength="8" value="<%=dsVolunteerCareer.getString("WORKSTARTDT")%>" style="width:80px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_workenddt" type="text" dataType="integer" dispName="근무기간 종료일" isNull="N" lenCheck="8" maxLength="8" value="<%=dsVolunteerCareer.getString("WORKENDDT")%>" style="width:80px;" onkeyup="checkIsDigit(this);"/>
							</td>
							<td>
								<input name="p_dept" type="text" dispName="근무부서" isNull="Y" lenCheck="30" maxLength="30" value="<%=dsVolunteerCareer.getString("DEPT")%>" style="width:80px;"/>
							</td>
							<td>
								<input name="p_comptel" type="text" dispName="근무부서" isNull="Y" lenCheck="20" maxLength="20" value="<%=dsVolunteerCareer.getString("COMPTEL")%>" style="width:100px;"/>
							</td>
						</tr>
			<%		}
				} else { %>
						<tr valign="top" height="26">
							<td>
								<input name="p_compnm" type="text" dispName="근무처" isNull="N" lenCheck="50" maxLength="50" value="" style="width:120px;"/>
							</td>
							<td>
								<input name="p_position2" type="text" dispName="직위" isNull="Y" lenCheck="20" maxLength="20" value="" style="width:80px;"/>
							</td>
							<td>
								<input name="p_workstartdt" type="text" dataType="integer" dispName="근무기간 시작일" isNull="N" lenCheck="8" maxLength="8" value="" style="width:80px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_workenddt" type="text" dataType="integer" dispName="근무기간 종료일" isNull="N" lenCheck="8" maxLength="8" value="" style="width:80px;" onkeyup="checkIsDigit(this);"/>
							</td>
							<td>
								<input name="p_dept" type="text" dispName="근무부서" isNull="Y" lenCheck="30" maxLength="30" value="" style="width:80px;"/>
							</td>
							<td>
								<input name="p_comptel" type="text" dispName="근무부서" isNull="Y" lenCheck="20" maxLength="20" value="" style="width:100px;"/>
							</td>
						</tr>
			<%	}  %>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 교수이수경력 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_support_request_label03.gif"></td>
							<td align="right" valign="bottom">
								<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<a href="#none" onclick="javascript:addTableRow('eduhistory')"><img src="/images/common/btn_popup_icon_insert.gif"></a></td>
									<td style="padding-left:1px;">
										<a href="#none" onclick="javascript:delTableRow('eduhistory')"><img src="/images/common/btn_popup_icon_delete.gif"></a></td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-bottom:5px;">
						<table id="tblEduHistory" width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="" />
							<col width="180" />
							<col width="90" />
							<col width="180" />
						</colgroup>
						<tr>
							<td align="center"><img src="/images/common/txt_lecture_name.gif"></td>
							<td align="center"><img src="/images/common/txt_education_date.gif"></td>
							<td align="center"><img src="/images/common/txt_gigwan_name.gif"></td>
							<td align="center"><img src="/images/common/txt_education_cont.gif"></td>
						</tr>
						<tr><td height="1" colspan="4" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
				<%	if ( dsVolunteerEduHistory != null && dsVolunteerEduHistory.getRow() > 0 ) {
					while ( dsVolunteerEduHistory.next() ) { %>
						<tr valign="top" height="26">
							<td>
								<input name="p_eduname" type="text" dispName="교육과정명" isNull="N" lenCheck="100" maxLength="100" value="<%=dsVolunteerEduHistory.getString("EDUNAME")%>" style="width:130px;"/>
							</td>
							<td>
								<input name="p_edustartdt" type="text" dataType="integer" dispName="교육기간 시작일" isNull="N" lenCheck="8" maxLength="8" value="<%=dsVolunteerEduHistory.getString("EDUSTARTDT")%>" style="width:80px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_eduenddt" type="text" dataType="integer" dispName="교육기간 종료일" isNull="N" lenCheck="8" maxLength="8" value="<%=dsVolunteerEduHistory.getString("EDUENDDT")%>" style="width:80px;" onkeyup="checkIsDigit(this);"/>
							</td>
							<td>
								<input name="p_academyname" type="text" dispName="기관명" isNull="N" lenCheck="30" maxLength="30" value="<%=dsVolunteerEduHistory.getString("ACADEMYNAME")%>" style="width:80px;"/>
							</td>
							<td>
								<input name="p_edudetail" type="text" dispName="교육내용" isNull="N" lenCheck="300" maxLength="300" value="<%=dsVolunteerEduHistory.getString("EDUDETAIL")%>" style="width:180px;"/>
							</td>
						</tr>
			<%		}
				} else { %>
						<tr valign="top" height="26">
							<td>
								<input name="p_eduname" type="text" dispName="교육과정명" isNull="N" lenCheck="100" maxLength="100" value="" style="width:130px;"/>
							</td>
							<td>
								<input name="p_edustartdt" type="text" dataType="integer" dispName="교육기간 시작일" isNull="N" lenCheck="8" maxLength="8" value="" style="width:80px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_eduenddt" type="text" dataType="integer" dispName="교육기간 종료일" isNull="N" lenCheck="8" maxLength="8" value="" style="width:80px;" onkeyup="checkIsDigit(this);"/>
							</td>
							<td>
								<input name="p_academyname" type="text" dispName="기관명" isNull="N" lenCheck="30" maxLength="30" value="" style="width:80px;"/>
							</td>
							<td>
								<input name="p_edudetail" type="text" dispName="교육내용" isNull="N" lenCheck="300" maxLength="300" value="" style="width:180px;"/>
							</td>
						</tr>
			<%	}  %>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 언어능력 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_support_request_label04.gif"></td>
							<td align="right" valign="bottom">
								<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<a href="#none" onclick="javascript:addTableRow('language')"><img src="/images/common/btn_popup_icon_insert.gif"></a></td>
									<td style="padding-left:1px;">
										<a href="#none" onclick="javascript:delTableRow('language')"><img src="/images/common/btn_popup_icon_delete.gif"></a></td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-bottom:5px;">
						<table id="tblLanguage" width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="110" />
							<col width="" />
							<col width="90" />
							<col width="110" />
							<col width="100" />
						</colgroup>
						<tr>
							<td align="center"><img src="/images/common/txt_language_name.gif"></td>
							<td align="center"><img src="/images/common/txt_language_test.gif"></td>
							<td align="center"><img src="/images/common/txt_language_score.gif"></td>
							<td align="center"><img src="/images/common/txt_get_gigwan.gif"></td>
							<td align="center"><img src="/images/common/txt_get_date.gif"></td>
						</tr>
						<tr><td height="1" colspan="5" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
				<%	if ( dsVolunteerLang != null && dsVolunteerLang.getRow() > 0 ) {
					while ( dsVolunteerLang.next() ) { %>
						<tr valign="top" height="26">
							<td>
								<input name="p_language" type="text" dispName="언어" isNull="N" lenCheck="100" maxLength="100" value="<%=dsVolunteerLang.getString("LANGUAGE")%>" style="width:100px;"/>
							</td>
							<td>
								<input name="p_testnm" type="text" dispName="시험명" isNull="N" lenCheck="100" maxLength="100" value="<%=dsVolunteerLang.getString("TESTNM")%>" style="width:173px;"/>
							</td>
							<td>
								<input name="p_score" type="text" dispName="점수/등급" isNull="N" lenCheck="30" maxLength="30" value="<%=dsVolunteerLang.getString("SCORE")%>" style="width:80px;"/>
							</td>
							<td>
								<input name="p_issueorgan" type="text" dispName="발급기관" isNull="Y" lenCheck="30" maxLength="30" value="<%=dsVolunteerLang.getString("ISSUEORGAN")%>" style="width:100px;"/>
							</td>
							<td>
								<input name="p_getdate" type="text" dataType="integer" dispName="취득일자" isNull="N" lenCheck="8" maxLength="8" value="<%=dsVolunteerLang.getString("GETDATE")%>" style="width:100px;" onkeyup="checkIsDigit(this);"/>
							</td>
						</tr>
			<%		}
				} else { %>
						<tr valign="top" height="26">
							<td>
								<input name="p_language" type="text" dispName="언어" isNull="N" lenCheck="100" maxLength="100" value="" style="width:100px;"/>
							</td>
							<td>
								<input name="p_testnm" type="text" dispName="시험명" isNull="N" lenCheck="100" maxLength="100" value="" style="width:173px;"/>
							</td>
							<td>
								<input name="p_score" type="text" dispName="점수/등급" isNull="N" lenCheck="30" maxLength="30" value="" style="width:80px;"/>
							</td>
							<td>
								<input name="p_issueorgan" type="text" dispName="발급기관" isNull="Y" lenCheck="30" maxLength="30" value="" style="width:100px;"/>
							</td>
							<td>
								<input name="p_getdate" type="text" dataType="integer" dispName="취득일자" isNull="N" lenCheck="8" maxLength="8" value="" style="width:100px;" onkeyup="checkIsDigit(this);"/>
							</td>
						</tr>
			<%	}  %>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 자격증 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_support_request_label05.gif"></td>
							<td align="right" valign="bottom">
								<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<a href="#none" onclick="javascript:addTableRow('license')"><img src="/images/common/btn_popup_icon_insert.gif"></a></td>
									<td style="padding-left:1px;">
										<a href="#none" onclick="javascript:delTableRow('license')"><img src="/images/common/btn_popup_icon_delete.gif"></a></td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-bottom:5px;">
						<table id="tblLicense" width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="" />
							<col width="80" />
							<col width="120" />
							<col width="100" />
						</colgroup>
						<tr>
							<td align="center"><img src="/images/common/txt_license.gif"></td>
							<td align="center"><img src="/images/common/txt_grade.gif"></td>
							<td align="center"><img src="/images/common/txt_get_date.gif"></td>
							<td align="center"><img src="/images/common/txt_get_gigwan.gif"></td>
						</tr>
						<tr><td height="1" colspan="4" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
			<%	if ( dsVolunteerLicense != null && dsVolunteerLicense.getRow() > 0 ) {
					while ( dsVolunteerLicense.next() ) { %>
						<tr valign="top" height="26">
							<td>
								<input name="p_licensenm" type="text" dispName="자격증명" isNull="N" lenCheck="50" maxLength="50" value="<%=dsVolunteerLicense.getString("LICENSENM")%>" style="width:282px;"/>
							</td>
							<td align="center">
								<input name="p_grade" type="text" dispName="등급" isNull="Y" lenCheck="10" maxLength="10" value="<%=dsVolunteerLicense.getString("GRADE")%>" style="width:80px;"/>
							</td>
							<td align="center">
								<input name="p_getdate2" type="text" dataType="integer" dispName="취득일자" isNull="N" lenCheck="8" maxLength="8" value="<%=dsVolunteerLicense.getString("GETDATE")%>" style="width:100px;" onkeyup="checkIsDigit(this);"/>
							</td>
							<td align="right">
								<input name="p_org" type="text" dispName="발급기관" isNull="Y" lenCheck="30" maxLength="30" value="<%=dsVolunteerLicense.getString("ORG")%>" style="width:100px;"/>
							</td>
						</tr>
			<%		}
				} else { %>
						<tr valign="top" height="26">
							<td>
								<input name="p_licensenm" type="text" dispName="자격증명" isNull="N" lenCheck="50" maxLength="50" value="" style="width:282px;"/>
							</td>
							<td align="center">
								<input name="p_grade" type="text" dispName="등급" isNull="Y" lenCheck="10" maxLength="10" value="" style="width:80px;"/>
							</td>
							<td align="center">
								<input name="p_getdate2" type="text" dataType="integer" dispName="취득일자" isNull="N" lenCheck="8" maxLength="8" value="" style="width:100px;" onkeyup="checkIsDigit(this);"/>
							</td>
							<td align="right">
								<input name="p_org" type="text" dispName="발급기관" isNull="Y" lenCheck="30" maxLength="30" value="" style="width:100px;"/>
							</td>
						</tr>
			<%	}  %>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 가족사항 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_support_request_label06.gif"></td>
							<td align="right" valign="bottom">
								<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<a href="#none" onclick="javascript:addTableRow('family')"><img src="/images/common/btn_popup_icon_insert.gif"></a></td>
									<td style="padding-left:1px;">
										<a href="#none" onclick="javascript:delTableRow('family')"><img src="/images/common/btn_popup_icon_delete.gif"></a></td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-bottom:5px;">
						<table id="tblFamily" width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="80" />
							<col width="" />
							<col width="80" />
							<col width="80" />
							<col width="80" />
							<col width="80" />
							<col width="100" />
						</colgroup>
						<tr>
							<td align="center"><img src="/images/common/txt_relation.gif"></td>
							<td align="center"><img src="/images/common/txt_family_name.gif"></td>
							<td align="center"><img src="/images/common/txt_age.gif"></td>
							<td align="center"><img src="/images/common/txt_family_school.gif"></td>
							<td align="center"><img src="/images/common/txt_job.gif"></td>
							<td align="center"><img src="/images/common/txt_jikwi.gif"></td>
							<td align="center"><img src="/images/common/txt_live_together.gif"></td>
						</tr>
						<tr><td height="1" colspan="7" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
				<%	if ( dsVolunteerFamily != null && dsVolunteerFamily.getRow() > 0 ) {
					int i = 1;
					while ( dsVolunteerFamily.next() ) { %>
						<tr valign="top" height="26">
							<td>
								<input name="p_relationship" type="text" dispName="관계" isNull="N" lenCheck="100" maxLength="100" value="<%=dsVolunteerFamily.getString("RELATIONSHIP")%>" style="width:70px;"/>
							</td>
							<td>
								<input name="p_name" type="text" dispName="성명" isNull="N" lenCheck="100" maxLength="100" value="<%=dsVolunteerFamily.getString("NAME")%>" style="width:82px;"/>
							</td>
							<td>
								<input name="p_age" type="text" dataType="integer" dispName="연령" isNull="N" lenCheck="3" maxLength="3" value="<%=dsVolunteerFamily.getString("AGE")%>" style="width:70px;" onkeyup="checkIsDigit(this);"/>
							</td>
							<td>
								<input name="p_academic" type="text" dispName="학력" isNull="Y" lenCheck="30" maxLength="30" value="<%=dsVolunteerFamily.getString("ACADEMIC")%>" style="width:70px;"/>
							</td>
							<td>
								<input name="p_job" type="text" dispName="직업" isNull="Y" lenCheck="300" maxLength="300" value="<%=dsVolunteerFamily.getString("JOB")%>" style="width:70px;"/>
							</td>
							<td>
								<input name="p_position3" type="text" dispName="직위" isNull="Y" lenCheck="30" maxLength="30" value="<%=dsVolunteerFamily.getString("POSITION")%>" style="width:70px;"/>
							</td>
							<td>
								<input type="radio" name="p_istogether<%=i%>" value="Y" style="border:none;"<%=(dsVolunteerFamily.getString("ISTOGETHER").equals("Y"))?" checked":"" %>>예&nbsp;
								<input type="radio" name="p_istogether<%=i++%>" value="N" style="border:none;"<%=(dsVolunteerFamily.getString("ISTOGETHER").equals("N"))?" checked":"" %>>아니오
							</td>
						</tr>
			<%		}
				} else { %>
						<tr valign="top" height="26">
							<td>
								<input name="p_relationship" type="text" dispName="관계" isNull="N" lenCheck="100" maxLength="100" value="" style="width:70px;"/>
							</td>
							<td>
								<input name="p_name" type="text" dispName="성명" isNull="N" lenCheck="100" maxLength="100" value="" style="width:82px;"/>
							</td>
							<td>
								<input name="p_age" type="text" dataType="integer" dispName="연령" isNull="N" lenCheck="30" maxLength="30" value="" style="width:70px;" onkeyup="checkIsDigit(this);"/>
							</td>
							<td>
								<input name="p_academic" type="text" dispName="학력" isNull="Y" lenCheck="30" maxLength="30" value="" style="width:70px;"/>
							</td>
							<td>
								<input name="p_job" type="text" dispName="직업" isNull="Y" lenCheck="300" maxLength="300" value="" style="width:70px;"/>
							</td>
							<td>
								<input name="p_position3" type="text" dispName="직위" isNull="Y" lenCheck="30" maxLength="30" value="" style="width:70px;"/>
							</td>
							<td>
								<input type="radio" name="p_istogether1" value="Y" style="border:none;" checked>예&nbsp;
								<input type="radio" name="p_istogether1" value="N" style="border:none;">아니오
							</td>
						</tr>
			<%	}  %>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>
				
				<%-- 
				<!-- 저소득층 여부 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_support_request_label12.gif"></td>
							<td align="right" valign="bottom">
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="300" />
							<col width="" />
						</colgroup>
						
						<tr><td height="1" colspan="2" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
						<tr valign="top" height="26">
							<td align="center">
								<input type="radio" name="p_islowincome" value="기초" style="border:none;"<%=(boxVolunteer.getString("ISLOWINCOME").equals("기초"))?" checked":"" %>>기초생활 수급자&nbsp;&nbsp;
								<input type="radio" name="p_islowincome" value="차상위" style="border:none;"<%=(boxVolunteer.getString("ISLOWINCOME").equals("차상위"))?" checked":"" %>>차상위계층
								<input type="radio" name="p_islowincome" value="해당없음" style="border:none;"<%=(boxVolunteer.getStringDefault("ISLOWINCOME", "해당없음").equals("해당없음"))?" checked":"" %>>해당없음
							</td>
							<td></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>
 --%>
				<!-- 거주사항 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_support_request_label07.gif"></td>
							<td align="right" valign="bottom">
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="200" />
							<col width="" />
						</colgroup>
						<tr>
							<td align="center"><img src="/images/common/txt_live_now.gif"></td>
							<td align="center"><img src="/images/common/txt_live_will.gif"></td>
						</tr>
						<tr><td height="1" colspan="2" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
						<tr valign="top" height="26">
							<td align="center">
								<input type="radio" name="p_isliveincapital" value="Y" style="border:none;"<%=(boxVolunteer.getStringDefault("ISLIVEINCAPITAL","Y").equals("Y"))?" checked":"" %>>수도권&nbsp;&nbsp;
								<input type="radio" name="p_isliveincapital" value="N" style="border:none;"<%=(boxVolunteer.getString("ISLIVEINCAPITAL").equals("N"))?" checked":"" %>>지방
							</td>
							<td align="center">
								<input type="radio" name="p_housetype" value="자가" style="border:none;"<%=(boxVolunteer.getStringDefault("HOUSETYPE","자가").equals("자가"))?" checked":"" %>>자가&nbsp;&nbsp;
								<input type="radio" name="p_housetype" value="하숙" style="border:none;"<%=(boxVolunteer.getString("HOUSETYPE").equals("하숙"))?" checked":"" %>>하숙&nbsp;&nbsp;
								<input type="radio" name="p_housetype" value="자취" style="border:none;"<%=(boxVolunteer.getString("HOUSETYPE").equals("자취"))?" checked":"" %>>자취&nbsp;&nbsp;
								<input type="radio" name="p_housetype" value="친척집" style="border:none;"<%=(boxVolunteer.getString("HOUSETYPE").equals("친척집"))?" checked":"" %>>친척집&nbsp;&nbsp;
								<input type="radio" name="p_housetype" value="기타" style="border:none;"<%=(boxVolunteer.getString("HOUSETYPE").equals("기타"))?" checked":"" %>>기타
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 본과정 응시여부 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_support_request_label08.gif"></td>
							<td align="right" valign="bottom">
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="200" />
							<col width="" />
						</colgroup>
						<tr>
							<td align="center"><img src="/images/common/txt_lecture_ok.gif"></td>
							<td align="center"><img src="/images/common/txt_lecture_no.gif"></td>
						</tr>
						<tr><td height="1" colspan="2" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
						<tr valign="top" height="26">
							<td align="center">
								<input type="radio" name="p_ispastapply" value="Y" style="border:none;"<%=(boxVolunteer.getStringDefault("ISPASTAPPLY","Y").equals("Y"))?" checked":"" %> onclick="document.form1.p_pastapplydetail.disabled=false">있다&nbsp;&nbsp;
								<input type="radio" name="p_ispastapply" value="N" style="border:none;"<%=(boxVolunteer.getString("ISPASTAPPLY").equals("N"))?" checked":"" %> onclick="document.form1.p_pastapplydetail.disabled=true">없다
							</td>
							<td align="center">
								<input name="p_pastapplydetail" type="text" dispName="응시상세정보" isNull="Y" lenCheck="30" maxLength="50" value="<%=boxVolunteer.getString("PASTAPPLYDETAIL") %>" style="width:300px;"<%=(boxVolunteer.getStringDefault("ISPASTAPPLY","Y").equals("Y"))?"":" disabled" %>/>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 해외연수경험 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_support_request_label09.gif"></td>
							<td align="right" valign="bottom">
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="200" />
							<col width="" />
						</colgroup>
						<tr>
							<td align="center"><img src="/images/common/txt_overseas_ok.gif"></td>
							<td align="center"><img src="/images/common/txt_overseas_no.gif"></td>
						</tr>
						<tr><td height="1" colspan="2" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
						<tr valign="top" height="26">
							<td align="center">
								<input type="radio" name="p_isabroadstudy" value="Y" style="border:none;"<%=(boxVolunteer.getStringDefault("ISABROADSTUDY","Y").equals("Y"))?" checked":"" %> onclick="document.form1.p_abroadstudydetail.disabled=false">있다&nbsp;&nbsp;
								<input type="radio" name="p_isabroadstudy" value="N" style="border:none;"<%=(boxVolunteer.getString("ISABROADSTUDY").equals("N"))?" checked":"" %> onclick="document.form1.p_abroadstudydetail.disabled=true">없다
							</td>
							<td align="center">
								<input name="p_abroadstudydetail" type="text" dispName="해외연수경험상세" isNull="Y" lenCheck="30" maxLength="50" value="<%=boxVolunteer.getString("ABROADSTUDYDETAIL") %>" style="width:350px;"<%=(boxVolunteer.getStringDefault("ISABROADSTUDY","Y").equals("Y"))?"":" disabled" %>/>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 자기소개 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_support_request_label10.gif"></td>
							<td align="right" valign="bottom">
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="200" />
							<col width="" />
						</colgroup>
						<tr>
							<td align="center"><img src="/images/common/txt_self_introduction.gif"></td>
						</tr>
						<tr><td height="1" colspan="2" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
						<tr valign="top" height="26">
							<td style="padding-bottom:6px;">
<%-- 								<textarea name="p_selfintroduce" value="" style="width:100%; height:150px; padding:10px;">
								<%	if ( boxVolunteer.getString("SELFINTRODUCE").equals("") ) { %>
1. 지원동기 및 수료후 목표는?


2. 본인의 적성은? ( )분야에 관심이 있다. 예) Database, System Engineer, 개발자, 시스템 설계 및 분석,무역, 마케팅/영업, 행정관리, 재무, 기획, 연구조사, 홍보, 대외관계/협상, 어학 등


3. 주요경력은? 직장근무경험이 있다( ) 없다( ) 있다면 ( 직장명, 근무기간, 담당업무를 구체적으로 서술) :


4. 기타 특별활동 또는 특기사항이 있으면 기재바랍니다.
								<%	} else { %>
									<%=boxVolunteer.getString("SELFINTRODUCE") %>
								<%	} %>
								</textarea> --%>
								<textarea name="p_selfintroduce" value="" style="width:100%; height:150px; padding:10px;">
								<%	if ( boxVolunteer.getString("SELFINTRODUCE").equals("") ) { 
										if (v_subj.equals("3354")) {
								%>
1. 제3기 청년무역사관학교 입교지원 동기와 본인이 10년 이내 이루고 싶은 꿈을 설명하시오. 


2. 다음 중 하나를 선택하고 그 이유를 간단히 기술하시오.

 ① 연봉 4,000만원을 지급하는 대기업에서 본인의 적성과는 상관없는 업무를 진행 

 ② 연봉 2,500만원을 지급하는 중소기업에서 본인의 적성과 부합하는 업무를 진행


3. 본인의 인생에서 가장 성취감을 느꼈던 경험과 가장 후회스러웠던 경험에 대해 간단히 기술하시오 


4. 본인을 표현할 수 있는 키워드 3개를 우선순위를 정하여 나열하시오.
   (10자 이내) 
 
 ①
 ②
 ③
 										<% } else if (v_subj.equals("3420")) {%>
1. 지원동기 및 수료후 목표는?


2. 강점


3. 가치관


4. 기타 특별활동 또는 특기사항이 있으면 기재바랍니다.	

								
 										<% } else {%>
1. 지원동기 및 수료후 목표는? (200자 이상)


2. 본인의 적성은? ( )분야에 관심이 있다. 예) Database, System Engineer, 개발자, 시스템 설계 및 분석,무역, 마케팅/영업, 행정관리, 재무, 기획, 연구조사, 홍보, 대외관계/협상, 어학 등 (200자 이상)


3. 주요경력은?(200자 이상) 직장근무경험이 있다( ) 없다( ) 있다면 ( 직장명, 근무기간, 담당업무를 구체적으로 서술) :


4. 기타 특별활동 또는 특기사항이 있으면 기재바랍니다. (200자 이상) 										
 									<%	} %>
								<%	} else { %>
									<%=boxVolunteer.getString("SELFINTRODUCE") %>
								<%	} %>
								</textarea>
								
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 과정모집 정보를 접한 매체 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_support_request_label11.gif"></td>
							<td align="right" valign="bottom">
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="" />
						</colgroup>
						<tr>
							<td align="center"><img src="/images/common/txt_information.gif"></td>
						</tr>
						<tr><td height="1" colspan="2" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
						<tr valign="top" height="26">
							<td style="padding-left:10px;">
					<%	while ( dsCodeList != null && dsCodeList.next() ) {
							/* TV, 라디오, 잡지 항목 삭제 (2015-08-04) => 민지윤대리 요청 */
							if ( !dsCodeList.getString("CODE").equals("008") && !dsCodeList.getString("CODE").equals("002") && !dsCodeList.getString("CODE").equals("003") && !dsCodeList.getString("CODE").equals("004") && !dsCodeList.getString("CODE").equals("007")) { %>
								<input type="checkbox" name="p_advmedia" value="<%=dsCodeList.getString("CODE") %>" style="border:none;"<%=(boxVolunteer.getString("ADVMEDIA").contains(dsCodeList.getString("CODE")))?" checked":"" %>>&nbsp;<%=dsCodeList.getString("CODENM") %><br>
					<%		}
						} %>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td style="padding-left:10px;">
								<input type="checkbox" name="p_advmedia" value="007" style="border:none;"<%=(boxVolunteer.getString("ADVMEDIA").contains("007"))?" checked":"" %> onclick="document.form1.p_advmediajiin.disabled=false">&nbsp;지인추천(지인과의 관계)&nbsp;&nbsp;
								<input name="p_advmediajiin" type="text" dispName="매체정보" isNull="Y" lenCheck="100" maxLength="100" value="<%=boxVolunteer.getString("ADVMEDIAJIIN") %>" style="width:240px;"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td style="padding-left:10px;">
								<input type="checkbox" name="p_advmedia" value="008" style="border:none;"<%=(boxVolunteer.getString("ADVMEDIA").contains("008"))?" checked":"" %> onclick="document.form1.p_advmediaetc.disabled=false">&nbsp;기타&nbsp;&nbsp;
								<input name="p_advmediaetc" type="text" dispName="매체정보" isNull="Y" lenCheck="100" maxLength="100" value="<%=boxVolunteer.getString("ADVMEDIAETC") %>" style="width:350px;"/>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:15px;">
				<tr>
					<td align="right">
					<%	if ( v_mode.equals("E") ) { %>
						<a href="#none" onclick="writeVolunteer('E');"><img src="/images/common/btn_modify.gif"></a>
					<%	} else { %>
						<a href="#none" onclick="writeVolunteer('W');"><img src="/images/common/btn_popup_take.gif"></a>
					<%	} %>
						<a href="#none" onclick="window.close();"><img src="/images/common/btn_popup_cancel.gif"></a></td>
				</tr>
				</table>
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
</html>