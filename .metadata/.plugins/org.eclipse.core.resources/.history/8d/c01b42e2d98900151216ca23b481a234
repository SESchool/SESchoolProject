<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import ="org.apache.commons.configuration.Configuration"%>
<%@ page import ="com.sinc.framework.configuration.ConfigurationFactory"%>
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
	
	String v_subj = box.getString("p_subj");
	String v_year = box.getString("p_year");
	String v_subjseq = box.getString("p_subjseq");
	String v_userid = box.getString("p_userid");
	
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
<style type="text/css">
        .preView { width: 106px; height: 116px; text-align: center; border:1px solid silver; background: url('/images/common/popup_teacher_noimg.gif') repeat-x;}
</style>
<fmtag:csscommon point="front" hgrcode="1" />
<script language="Javascript" src="/js/home/template1.js"></script>
<fmtag:jscommon point="front" />
<script type="text/javascript">
	function writeVolunteer() {
		var f = document.form1;
	    
		if(!validate(f)) return;

		if(!/(\.gif|\.jpg|\.jpeg|\.png)$/i.test(f.p_picturefile.value)) { 
	        alert("이미지 형식의 파일을 선택하십시오"); 
	        return; 
	    }
	    
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

	function fileUploadPreview(thisObj, preViewer) {
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
<script type="text/javascript">
	function setPopupSize() {
		window.resizeTo(700,500);
		popupAutoResize();
		alert ( window.resizable );
	}
//	Event.observe(window,"load", setPopupSize);
</script>
</head>
 
<a name="Top"></a>
<body style="margin:0px;">

<!--//-->
<form name="form1" action="/front/Volunteer.do?cmd=volunteerWriteForm" method="post" onSubmit="return false;" enctype="multipart/form-data">
<input type="hidden" name="cmd" value="volunteerWriteForm">
<input type="hidden" name="p_mode" value="<%=v_mode%>">
<input type="hidden" name="p_subj" value="<%=v_subj%>">
<input type="hidden" name="p_year" value="<%=v_year%>">
<input type="hidden" name="p_subjseq" value="<%=v_subjseq%>">
<input type="hidden" name="p_userid" value="<%=v_userid%>">
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
			<td height="100%" valign="top" align="center" style="padding:20px;">
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
									<td><%=boxVolunteer.getString("KOR_NAME") %></td>
								</tr>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:6px;"></td>
									<td style="padding-top:3px;"></td>
									<td><%=boxVolunteer.getString("HANSA_NAME") %></td>
								</tr>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:6px;"></td>
									<td style="padding-top:3px;"></td>
									<td><%=boxVolunteer.getString("ENG_NAME") %></td>
								</tr>
							<%
								String v_jumin1 = (boxVolunteer.getString("JUMIN").length()>=6) ? boxVolunteer.getString("JUMIN").substring(0,6) : "";
								String v_jumin2 = (boxVolunteer.getString("JUMIN").length()>=13) ? boxVolunteer.getString("JUMIN").substring(6,13) : "";
							%>
								<!-- tr valign="top" height="26">
									<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
									<td style="padding-top:4px;"><img src="/images/common/txt_resno.gif"></td>
									<td>
										<input name="p_jumin1" type="text" size="6" dataType="integer" dispName="주민번호" isNull="N" lenCheck="6" maxLength="6" value="" style="width:105px;" onkeyup="checkIsDigit(this);if(this.value.length==6)document.form1.p_jumin2.focus();" onblur="setBirthday(this);"/>
										-
										<input name="p_jumin2" type="text" size="7" dataType="integer" dispName="주민번호" isNull="N" lenCheck="7" maxLength="7" value="" style="width:110px;" onkeyup="checkIsDigit(this);" onblur="setBirthday(this);"/>
									</td>
								</tr-->
							<%
								String v_byear = (boxVolunteer.getString("BIRTHDAY").length()>=4) ? boxVolunteer.getString("BIRTHDAY").substring(0,4) : "";
								String v_bmonth = (boxVolunteer.getString("BIRTHDAY").length()>=6) ? boxVolunteer.getString("BIRTHDAY").substring(4,6) : "";
								String v_bday = (boxVolunteer.getString("BIRTHDAY").length()>=8) ? boxVolunteer.getString("BIRTHDAY").substring(6,8) : "";
							%>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
									<td style="padding-top:4px;"><img src="/images/common/txt_birthday.gif"></td>
									<td><%=v_byear%> 년&nbsp; <%=v_bday%> 월&nbsp; <%=v_bday%> 일&nbsp;</td>
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
																	v_imgpath = FileUtil.UPLOAD_CONTEXT+"/volunteer/old_trademaster/"+boxVolunteer.getString("PICTURE");
																} else if ( boxVolunteer.getString("TRAININGCLASS").equals("04") ) {
																	v_imgpath = FileUtil.UPLOAD_CONTEXT+"/volunteer/old_itmaster/"+boxVolunteer.getString("PICTURE");
																}
															} else {
																v_imgpath = FileUtil.UPLOAD_CONTEXT+"/volunteer/"+v_subj+"/"+v_year+"/"+v_subjseq+"/"+boxVolunteer.getString("PICTURE");
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
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_military.gif"></td>
							<% String v_military = (boxVolunteer.getString("MILITARY").equals("Y")) ? "군필" : ((boxVolunteer.getString("MILITARY").equals("N"))?"미필":"면제");%>
							<td><%=v_military%><%=!(boxVolunteer.getString("MILITARY").equals("Y"))? "&nbsp;&nbsp;-&nbsp;&nbsp;"+boxVolunteer.getString("NOMILITARYREASON") : "" %>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_now_address.gif"></td>
							<td>
							<% if( boxVolunteer.getString("ZIPCODE2") == null || boxVolunteer.getString("ZIPCODE2").equals("")){ %>
								<%=boxVolunteer.getString("ZIPCODE1") %>
							<% } else { %>
								<%=boxVolunteer.getString("ZIPCODE1") %> - <%=boxVolunteer.getString("ZIPCODE2") %>
							<% } %>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"></td>
							<td style="padding-top:4px;"></td>
							<td><%=boxVolunteer.getString("ADDRESS") %></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_phone.gif"></td>
							<td><%=boxVolunteer.getString("TEL") %></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_mobile.gif"></td>
							<td><%=boxVolunteer.getString("THANDPHONEEL") %></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_email.gif"></td>
							<td><%=boxVolunteer.getString("EMAIL") %></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_company_sosok.gif"></td>
							<td><%=boxVolunteer.getString("COMPANY") %></td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_jikwi.gif"></td>
							<td><%=boxVolunteer.getString("POSITION") %></td>
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
							<td align="center"><%=dsVolunteerAcademic.getString("GRADEYEAR")%></td>
							<td align="center"><%=dsVolunteerAcademic.getString("SCHOOLNM")%></td>
							<td align="center"><%=dsVolunteerAcademic.getString("MAJOR")%></td>
							<td align="center"><%=dsVolunteerAcademic.getString("LOCATE")%></td>
						</tr>
			<%		}
				} else { %>
						<tr align="center" height="26">
							<td colspan="4">등록정보가 없습니다.</td>
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
							<td align="center"><%=dsVolunteerCareer.getString("COMPANY")%></td>
							<td align="center"><%=dsVolunteerCareer.getString("POSITION")%></td>
							<td align="center"><%=dsVolunteerCareer.getString("WORKSTARTDT")%> - <%=dsVolunteerCareer.getString("WORKENDDT")%></td>
							<td align="center"><%=dsVolunteerCareer.getString("DEPT")%></td>
							<td align="center"><%=dsVolunteerCareer.getString("COMPTEL")%></td>
						</tr>
			<%		}
				} else { %>
						<tr align="center" height="26">
							<td colspan="5">등록정보가 없습니다.</td>
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
							<td align="right" valign="bottom"></td>
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
							<td align="center"><%=dsVolunteerEduHistory.getString("EDUNAME")%></td>
							<td align="center"><%=dsVolunteerEduHistory.getString("EDUSTARTDT")%> - <%=dsVolunteerEduHistory.getString("EDUENDDT")%></td>
							<td align="center"><%=dsVolunteerEduHistory.getString("ACADEMYNAME")%></td>
							<td align="center"><%=dsVolunteerEduHistory.getString("EDUDETAIL")%></td>
						</tr>
			<%		}
				} else { %>
						<tr align="center" height="26">
							<td colspan="4">등록정보가 없습니다.</td>
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
							<td align="right" valign="bottom"></td>
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
							<td align="center"><%=dsVolunteerLang.getString("LANGUAGE")%></td>
							<td align="center"><%=dsVolunteerLang.getString("TESTNM")%></td>
							<td align="center"><%=dsVolunteerLang.getString("SCORE")%></td>
							<td align="center"><%=dsVolunteerLang.getString("ISSUEORGAN")%></td>
							<td align="center"><%=dsVolunteerLang.getString("GETDATE")%></td>
						</tr>
			<%		}
				} else { %>
						<tr align="center" height="26">
							<td colspan="5">등록정보가 없습니다.</td>
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
							<td align="right" valign="bottom"></td>
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
							<td align="center"><%=dsVolunteerLicense.getString("LICENSENM")%></td>
							<td align="center"><%=dsVolunteerLicense.getString("GRADE")%></td>
							<td align="center"><%=dsVolunteerLicense.getString("GETDATE")%></td>
							<td align="center"><%=dsVolunteerLicense.getString("ORG")%></td>
						</tr>
			<%		}
				} else { %>
						<tr align="center" height="26">
							<td colspan="4">등록정보가 없습니다.</td>
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
							<td align="right" valign="bottom"></td>
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
					while ( dsVolunteerFamily.next() ) { %>
						<tr valign="top" height="26">
							<td align="center"><%=dsVolunteerFamily.getString("RELATIONSHIP")%></td>
							<td align="center"><%=dsVolunteerFamily.getString("NAME")%></td>
							<td align="center"><%=dsVolunteerFamily.getString("AGE")%></td>
							<td align="center"><%=dsVolunteerFamily.getString("ACADEMIC")%></td>
							<td align="center"><%=dsVolunteerFamily.getString("JOB")%></td>
							<td align="center"><%=dsVolunteerFamily.getString("POSITION")%></td>
							<td align="center"><%=(dsVolunteerFamily.getString("ISTOGETHER").equals("Y"))?"예":"아니요"%></td>
						</tr>
			<%		}
				} else { %>
						<tr align="center" height="26">
							<td colspan="7">등록정보가 없습니다.</td>
						</tr>
			<%	}  %>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>
 
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
							<td align="center"><%=(boxVolunteer.getString("ISLIVEINCAPITAL").equals("Y")?"수도권":"지방")%></td>
							<td align="center"><%=boxVolunteer.getString("HOUSETYPE")%></td>
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
							<td align="center"><%=(boxVolunteer.getString("ISPASTAPPLY")).equals("Y")?"있다":"없다"%></td>
							<td align="center"><%=boxVolunteer.getString("PASTAPPLYDETAIL") %></td>
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
							<td align="center"><%=(boxVolunteer.getString("ISABROADSTUDY")).equals("Y")?"있다":"없다"%></td>
							<td align="center"><%=boxVolunteer.getString("ABROADSTUDYDETAIL") %></td>
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
							<td style="padding-bottom:6px;"><%=boxVolunteer.getString("SELFINTRODUCE") %></td>
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
							<td style="padding-left:10px;"><%=boxVolunteer.getString("ADVMEDIA").equals("008") ? boxVolunteer.getString("ADVMEDIAETC") : boxVolunteer.getString("ADVMEDIANM") %></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
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