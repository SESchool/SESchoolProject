<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/front/common/commonBasicInc.jsp"%>
<%
	Box boxProposeApplyInfo = (Box)box.getObject("boxProposeApplyInfo");
	Box boxProposeFormGLMP = (Box)box.getObject("boxProposeFormGLMP");
	
	String glmpEditMode = box.getString("glmpEditMode");	//GLMP개인정보 확인 수정일경우 'Y'
	
	String v_mode = boxProposeFormGLMP.getString("USERID").equals("") ? "W" : "E";	
	
	
	String p_serverurl = request.getServerName();
	
	String imgsrc = boxProposeFormGLMP.getString("PICTURE");
	
	
	v_mode = "W";

	if ( boxProposeFormGLMP == null ) {
		boxProposeFormGLMP = new Box("data");
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=PAGETITLE%></title>
<style type="text/css">
        .preView { width: 106px; height: 116px; text-align: center; border:1px solid silver; background: url('/images/common/popup_teacher_noimg.gif') repeat-x;}
        table tr td{
        text-align: left;
        }
</style>
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
<script language="Javascript" src="/js/home/template<%=G_TMPL%>.js"></script>
<fmtag:jscommon point="front" />
<script type="text/javascript">
	function proposeWriteGLMP() {
		var f = document.form1;

		if(!validate(f)) return;

		if(!/(\.gif|\.jpg|\.jpeg|\.png)$/i.test(f.p_picturefile.value)) {
	        alert("이미지 형식의 파일을 선택하십시오");
	        return;
	    }
		f.action = "/front/Propose.do?cmd=proposeWrite&p_proposetype=5&subj="+f.p_subj.value+"&year="+f.p_year.value+"&subjseq="+f.p_subjseq.value;
		f.cmd.value = "proposeWrite";
		f.method = "post";
		f.target = "";

		f.submit();
	}
	//신청정보 수정
	function proposeUpdateGLMP(){
		var f = document.form1;		
		if(!/(\.gif|\.jpg|\.jpeg|\.png)$/i.test(f.p_picturefile.value) && f.p_picturefile.value!="") {
	        alert("이미지 형식의 파일을 선택하십시오");
	        return;
	    }
		if(f.p_picturefile.value==""){
			f.imgsrc.value='<%=imgsrc%>';
		}
		f.action = "/front/Propose.do?cmd=proposeUpdateGLMP&p_proposetype=5&subj="+f.p_subj.value+"&year="+f.p_year.value+"&subjseq="+f.p_subjseq.value;
		f.cmd.value = "proposeUpdateGLMP";
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

	//자택 우편번호
	function searchZipCode() {
		var url = "/front/Common.do?cmd=selectZipCode&p_objname=glmphome";
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
	
	//근무처 우편번호
	function searchOZipCode() {
		var url = "/front/Common.do?cmd=selectZipCode&ozipcode=Y&p_objname=home";
		Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
	}
	function setOZipCodeInfo(addr, zipcode) {
		var form = document.form1;
		
		form.p_address.value = addr;
		if(zipcode.search('-') > -1){	
			form.p_ozipcode1.value = zipcode.substr(0, 3) ;
			form.p_ozipcode2.value = zipcode.substr(4, 7) ;	
		} else {
			form.p_ozipcode1.value = zipcode;		// 새로운 우편주소, 하나의 텍스트란에 넣음
			form.p_ozipcode2.value = "";
			form.p_ozipcode2.style.display="none";
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
		window.resizeTo(680,700);
		popupAutoResize();
	}
	Event.observe(window,"load", setPopupSize);
</script>
</head>

<a name="Top"></a>
<body style="margin:0px;">

<!--//-->
<form name="form1" action="/front/Propose.do?cmd=proposeWriteForm5" method="post" onSubmit="return false;" enctype="multipart/form-data">
<input type="hidden" name="cmd" value="proposeWriteForm5">
<input type="hidden" name="p_mode" value="<%=v_mode%>">
<input type="hidden" name="p_proposetype" value="5">
<input type="hidden" name="p_subj" value="<%=box.getString("p_subj")%>">
<input type="hidden" name="p_year" value="<%=box.getString("p_year")%>">
<input type="hidden" name="p_gyear" value="<%=box.getString("p_year")%>">
<input type="hidden" name="p_subjseq" value="<%=box.getString("p_subjseq")%>">
<input type="hidden" name="p_moid" value="<%=boxProposeApplyInfo.getString("MOID")%>">
<input type="hidden" name="p_paymethod" value="001000000000">
<%	if ( box.getString("_where").equals("B") ) { %>
<input type="hidden" name="_where" value="<%=box.getString("_where")%>" />
<input type="hidden" name="p_userid" value="<%=box.getString("p_userid")%>" />
<input type="hidden" name="p_comp" value="<%=box.getString("p_comp")%>" />
<%	} %>
<input type="hidden" name="imgsrc" value="">
<table width="100%" height="100%" cellpadding="0" cellspacing="0">
<tr>
	<td align="center" height="100%" valign="top">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="42" background="/images/common/popup_header_bg.gif">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/common/popup_glmp_application_title.gif"></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="100%" valign="top" align="center" style="padding:20px;">
				<!-- 지원자 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_glmp_application_label01.gif"></td>
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
							<col width="336" />
							<col width="10" />
							<col width="244" />
						</colgroup>
						<tr valign="top">
							<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<colgroup>
									<col width="15" />
									<col width="80" />
									<col width="241" />
								</colgroup>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
									<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt01.gif"></td>
									<td><input name="p_korname" type="text" dispName="성명(한글)" isNull="N" lenCheck="10" maxLength="10" value="<%=boxProposeFormGLMP.getStringDefault("KOR_NAME", "한글") %>" style="width:100px;" onclick="if(this.value=='한글')this.value='';this.onclick=''"/>
									</td>
								</tr>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
									<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt02.gif"></td>
									<td><input name="p_hansaname" type="text" dispName="성명(漢字)" isNull="N" lenCheck="10" maxLength="10" value="<%=boxProposeFormGLMP.getStringDefault("HANSA_NAME", "(漢字)") %>" style="width:100px;" onclick="if(this.value=='(漢字)')this.value='';this.onclick=''"/>
									</td>
								</tr>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
									<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt03.gif"></td>
									<td><input name="p_engname" type="text" dispName="성명(영문)" isNull="N" lenCheck="50" maxLength="50" value="<%=boxProposeFormGLMP.getStringDefault("ENG_NAME", "영문") %>" style="width:100px;" onclick="if(this.value=='영문')this.value='';this.onclick=''"/>
										* 여권과 일치
									</td>
								</tr>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
									<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt04.gif"></td>
									<td><input name="p_hobby" type="text" dispName="취미" isNull="Y" lenCheck="100" maxLength="100" value="<%=boxProposeFormGLMP.getString("HOBBY") %>" style="width:100px;" onclick="if(this.value=='영문')this.value='';this.onclick=''"/>
										* 골프 핸디(<input name="p_golfhandi" type="text" dispName="골프핸디" isNull="Y" lenCheck="10" maxLength="10" value="<%=boxProposeFormGLMP.getString("GOLF_HANDI") %>" style="width:50px;">)
									</td>
								</tr>
								<%--	주민등록번호 제거
								<tr valign="top" height="26">
									<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
									<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt05.gif"></td>
									<td>
									<%
										String v_jumin1 = (boxProposeFormGLMP.getString("JUMIN").length()>=6) ? boxProposeFormGLMP.getString("JUMIN").substring(0,6) : "";
										String v_jumin2 = (boxProposeFormGLMP.getString("JUMIN").length()>=13) ? boxProposeFormGLMP.getString("JUMIN").substring(6,13) : "";
									%>
										<input name="p_jumin1" type="text" size="6" dataType="integer" dispName="주민번호" isNull="N" lenCheck="6" maxLength="6" value="<%=v_jumin1%>" style="width:100px;" onkeyup="checkIsDigit(this);if(this.value.length==6)document.form1.p_jumin2.focus();" onblur="setBirthday(this);"/>
										-
										<input name="p_jumin2" type="text" size="7" dataType="integer" dispName="주민번호" isNull="N" lenCheck="7" maxLength="7" value="<%=v_jumin2%>" style="width:100px;" onkeyup="checkIsDigit(this);" onblur="setBirthday(this);"/>
									</td>
								</tr> --%>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
									<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt06.gif"></td>
									<td>
										<input name="p_birth_year" type="text" dataType="integer" dispName="생년" isNull="Y" lenCheck="4" maxLength="4" value="<%=boxProposeFormGLMP.getString("BIRTH_YEAR")%>" style="width:50px;"> 년&nbsp;
										<input name="p_birth_month" type="text" dataType="integer" dispName="생월" isNull="Y" lenCheck="2" maxLength="2" value="<%=boxProposeFormGLMP.getString("BIRTH_MONTH")%>" style="width:50px;"> 월&nbsp;
										<input name="p_birth_day" type="text" dataType="integer" dispName="생일" isNull="Y" lenCheck="2" maxLength="2" value="<%=boxProposeFormGLMP.getString("BIRTH_DAY")%>" style="width:50px;"> 일&nbsp;
									</td>
								</tr>
								</table>
							</td>
							<td></td>
							<td>
								
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<colgroup>
									<col width="118" />
									<col width="10" />
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
														<%	if ( !boxProposeFormGLMP.getString("PICTURE").equals("") ) {
															String v_imgpath = null;
															//String uploadPath	= "/propose/"+box.getString("subj")+"/"+box.getString("year")+"/"+box.getString("subjseq");
															v_imgpath = "http://edu.tradecampus.net/propose/"+boxProposeFormGLMP.getString("SUBJ")+"/"+boxProposeFormGLMP.getString("YEAR")+"/"+boxProposeFormGLMP.getString("SUBJSEQ")+"/"+boxProposeFormGLMP.getString("PICTURE");
															
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
											<td>
											<input type="file" name="p_picturefile" value="" onchange="fileUploadPreview(this, 'preView')" style="display:; width:200px; height:18px; background-color:#FFFFFF;" dispName="사진" isNull="N"></a>
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
							<col width="241" />
							<col width="15" />
							<col width="50" />
							<col width="189" />
						</colgroup>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt44.gif"></td>
							<td colspan="4">
							<% 
								String zipcode = boxProposeFormGLMP.getString("ZIPCODE"); 
								String zipcode1;
								String zipcode2;
								if( zipcode.contains("-") ){
									zipcode1 = zipcode.substring(0, zipcode.indexOf("-"));
									zipcode2 = zipcode.substring(zipcode.indexOf("-")+1, zipcode.length());
								} else {
									zipcode1 = zipcode;
									zipcode2 = "";
								}
							%>
							<% if( zipcode2 == null || zipcode2.equals("") ){ %>
								<input name="p_zipcode1" type="text" dataType="integer" dispName="우편번호" isNull="Y" lenCheck="5" maxLength="5" value="<%= zipcode1 %>" style="width:50px;" readOnly/>
								<input name="p_zipcode2" type="hidden" dispName="우편번호" value="<%= zipcode2 %>" />
							<% } else { %>
								<input name="p_zipcode1" type="text" dataType="integer" dispName="우편번호" isNull="Y" value="<%= zipcode1 %>" style="width:50px;" readOnly/> -
								<input name="p_zipcode2" type="text" dataType="integer" dispName="우편번호" value="<%= zipcode2 %>" style="width:50px;" readOnly/>
							<% } %>						
								<a href="#none" onclick="javascript:searchZipCode()"><img src="/images/common/btn_popup_search_2.gif" alt="우편번호찾기"></a>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"></td>
							<td style="padding-top:4px;"></td>
							<td colspan="4">
								<input name="p_address" type="text" dispName="주소" isNull="Y" lenCheck="200" maxLength="200" value="<%=boxProposeFormGLMP.getString("ADDRESS") %>" style="width:495px;"/>
							</td>
						</tr>
						<%
							String[] arrPhone = boxProposeFormGLMP.getString("TEL").split("-");
							String[] arrHandPhone = boxProposeFormGLMP.getString("HANDPHONE").split("-");
						%>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt07.gif"></td>
							<td>
								<input name="p_tel1" type="text" size="4" dataType="integer" dispName="연락처" isNull="N" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>=2)?arrPhone[0]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"> -
								<input name="p_tel2" type="text" size="4" dataType="integer" dispName="연락처" isNull="N" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>=2)?arrPhone[1]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_tel3" type="text" size="4" dataType="integer" dispName="연락처" isNull="N" lenCheck="4" maxLength="4" value="<%=(arrPhone.length>=3)?arrPhone[2]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"/>
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt08.gif"></td>
							<td>
								<input name="p_handphone1" type="text" size="4" dataType="integer" dispName="핸드폰" isNull="N" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=2)?arrHandPhone[0]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_handphone2" type="text" size="4" dataType="integer" dispName="핸드폰" isNull="N" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=2)?arrHandPhone[1]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_handphone3" type="text" size="4" dataType="integer" dispName="핸드폰" isNull="N" lenCheck="4" maxLength="4" value="<%=(arrHandPhone.length>=3)?arrHandPhone[2]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt09.gif"></td>
							<td>
								<input name="p_car" type="text" dispName="차종" isNull="Y" lenCheck="30" maxLength="30" value="<%=boxProposeFormGLMP.getString("CAR") %>" style="width:200px;"/>
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt10.gif"></td>
							<td>
								<input name="p_relision" type="text" dispName="종교" isNull="Y" lenCheck="20" maxLength="20" value="<%=boxProposeFormGLMP.getString("RELISION") %>" style="width:180px;"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt11.gif"></td>
							<td>
								<input name="p_carnum" type="text" dispName="차량번호" isNull="Y" lenCheck="20" maxLength="20" value="<%=boxProposeFormGLMP.getString("CARNUM") %>" style="width:200px;"/>
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt12.gif"></td>
							<td>
								<input name="p_email" type="text" dispName="이메일" isNull="Y" lenCheck="50" maxLength="50" value="<%=boxProposeFormGLMP.getString("EMAIL") %>" style="width:180px;"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_passport.gif"></td>
							<td>
								<input name="p_passport" type="text" dispName="여권번호" isNull="Y" lenCheck="20" maxLength="20" value="<%=boxProposeFormGLMP.getString("PASSPORT") %>" style="width:200px;"/>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 근무처 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_glmp_application_label02.gif"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-top:10px; padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:5px;">
						<colgroup>
							<col width="15" />
							<col width="80" />
							<col width="241" />
							<col width="15" />
							<col width="50" />
							<col width="189" />
						</colgroup>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt13.gif"></td>
							<td>
								<input name="p_oname" type="text" dispName="근무처" isNull="Y" lenCheck="30" maxLength="30" value="<%=boxProposeFormGLMP.getString("O_NAME") %>" style="width:200px;"/>
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt14.gif"></td>
							<td>
								<input name="p_oposition" type="text" dispName="직위" isNull="Y" lenCheck="30" maxLength="30" value="<%=boxProposeFormGLMP.getString("O_POSITION") %>" style="width:180px;"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt15.gif"></td>
							<td colspan="4">
							<% 
								String ozipcode = boxProposeFormGLMP.getString("O_ZIPCODE"); 
								String ozipcode1;
								String ozipcode2;
								if( ozipcode.contains("-")){
									ozipcode1 = ozipcode.substring(0, ozipcode.indexOf("-"));
									ozipcode2 = ozipcode.substring(ozipcode.indexOf("-")+1, ozipcode.length());
								} else {
									ozipcode1 = ozipcode;
									ozipcode2 = "";
								}
							%>
							<% if( ozipcode2 == null || ozipcode2.equals("") ){ %>
								<input name="p_ozipcode1" type="text" dataType="integer" dispName="근무처 우편번호" isNull="Y" lenCheck="5" maxLength="5" value="<%= ozipcode1 %>" style="width:50px;" readOnly/>
								<input name="p_ozipcode2" type="hidden" dispName="근무처 우편번호" value="<%= ozipcode2 %>" />
							<% } else { %>
								<input name="p_ozipcode1" type="text" dataType="integer" dispName="근무처 우편번호" isNull="Y" value="<%= ozipcode1 %>" style="width:50px;" readOnly/> -
								<input name="p_ozipcode2" type="text" dataType="integer" dispName="근무처 우편번호" isNull="Y" value="<%= ozipcode2 %>" style="width:50px;" readOnly/>
							<% } %>	
								<a href="#none" onclick="javascript:searchOZipCode()"><img src="/images/common/btn_popup_search_2.gif" alt="우편번호찾기"></a>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"></td>
							<td style="padding-top:4px;"></td>
							<td colspan="4">
								<input name="p_oaddress" type="text" dispName="주소" isNull="Y" lenCheck="200" maxLength="200" value="<%=boxProposeFormGLMP.getString("O_ADDRESS") %>" style="width:495px;"/>
							</td>
						</tr>
						<%
							String[] arrOPhone = boxProposeFormGLMP.getString("O_TEL").split("-");
							String[] arrOFax = boxProposeFormGLMP.getString("O_FAX").split("-");
						%>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt16.gif"></td>
							<td>
								<input name="p_otel1" type="text" size="4" dataType="integer" dispName="근무지 전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrOPhone.length>=2)?arrOPhone[0]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"> -
								<input name="p_otel2" type="text" size="4" dataType="integer" dispName="근무지 전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrOPhone.length>=2)?arrOPhone[1]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_otel3" type="text" size="4" dataType="integer" dispName="근무지 전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrOPhone.length>=3)?arrOPhone[2]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"/>
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt17.gif"></td>
							<td>
								<input name="p_ofax1" type="text" size="4" dataType="integer" dispName="근무지 팩스" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrOFax.length>=2)?arrOFax[0]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"> -
								<input name="p_ofax2" type="text" size="4" dataType="integer" dispName="근무지 팩스" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrOFax.length>=2)?arrOFax[1]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_ofax3" type="text" size="4" dataType="integer" dispName="근무지 팩스" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrOFax.length>=3)?arrOFax[2]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt19.gif"></td>
							<td>
								<input name="p_oturnover" type="text" size="6" dataType="integer" dispName="매출액" isNull="Y" lenCheck="12" maxLength="12" value="<%=boxProposeFormGLMP.getString("O_TURNOVER")%>" style="width:200px;"/>
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt21.gif"></td>
							<td>
								<input name="p_ohomepage" type="text" dispName="근무지 홈페이지" isNull="Y" lenCheck="200" maxLength="200" value="<%=boxProposeFormGLMP.getString("O_HOMEPAGE") %>" style="width:180px;"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt22.gif"></td>
							<td>
								<input type="radio" name="p_omanagetype" value="1" style="border:none;"<%=(boxProposeFormGLMP.getStringDefault("O_MANAGETYPE","1").equals("1"))?" checked":"" %>>소유경영인&nbsp;
								<input type="radio" name="p_omanagetype" value="2" style="border:none;"<%=(boxProposeFormGLMP.getString("O_MANAGETYPE").equals("2"))?" checked":"" %>>전문경영인
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt23.gif"></td>
							<td>
								<input name="p_obizfield" type="text" dispName="업태/종목" isNull="Y" lenCheck="50" maxLength="50" value="<%=boxProposeFormGLMP.getString("O_BIZFIELD") %>" style="width:180px;"/>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 업무역량담당자 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_glmp_application_label03.gif"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-top:10px; padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:5px;">
						<colgroup>
							<col width="15" />
							<col width="80" />
							<col width="241" />
							<col width="15" />
							<col width="50" />
							<col width="189" />
						</colgroup>
						<%
							String[] arrCPhone = boxProposeFormGLMP.getString("C_TEL").split("-");
							String[] arrCHandphone = boxProposeFormGLMP.getString("C_HANDPHONE").split("-");	
							String[] arrCFax = boxProposeFormGLMP.getString("C_FAX").split("-");
						%>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt24.gif"></td>
							<td>
								<input name="p_cname" type="text" dispName="업무역량 담당자 이름" isNull="Y" lenCheck="10" maxLength="10" value="<%=boxProposeFormGLMP.getString("C_NAME") %>" style="width:200px;"/>
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt25.gif"></td>
							<td>
								<input name="p_ctel1" type="text" size="4" dataType="integer" dispName="업무역량 담당자 전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrCPhone.length>=2)?arrCPhone[0]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"> -
								<input name="p_ctel2" type="text" size="4" dataType="integer" dispName="업무역량 담당자 전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrCPhone.length>=2)?arrCPhone[1]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_ctel3" type="text" size="4" dataType="integer" dispName="업무역량 담당자 전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrCPhone.length>=3)?arrCPhone[2]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt26.gif"></td>
							<td>
								<input name="p_cdeptposnm" type="text" dispName="업무역량 담당자 부서/직위" isNull="Y" lenCheck="50" maxLength="50" value="<%=boxProposeFormGLMP.getString("C_DEPTPOSNM") %>" style="width:200px;"/>
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt28.gif"></td>
							<td>
								<input name="p_chandphone1" type="text" size="4" dataType="integer" dispName="업무역량 담당자 휴대폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrCHandphone.length>=2)?arrCHandphone[0]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"> -
								<input name="p_chandphone2" type="text" size="4" dataType="integer" dispName="업무역량 담당자 휴대폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrCHandphone.length>=2)?arrCHandphone[1]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_chandphone3" type="text" size="4" dataType="integer" dispName="업무역량 담당자 휴대폰" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrCHandphone.length>=3)?arrCHandphone[2]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt29.gif"></td>
							<td>
								<input name="p_cemail" type="text" dispName="업무역량 담당자 이메일" isNull="Y" lenCheck="50" maxLength="50" value="<%=boxProposeFormGLMP.getString("C_EMAIL") %>" style="width:200px;"/>
							</td>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt27.gif"></td>
							<td>
								<input name="p_cfax1" type="text" size="4" dataType="integer" dispName="업무역량 담당자 팩스" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrCFax.length>=2)?arrCFax[0]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"> -
								<input name="p_cfax2" type="text" size="4" dataType="integer" dispName="업무역량 담당자 팩스" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrCFax.length>=2)?arrCFax[1]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_cfax3" type="text" size="4" dataType="integer" dispName="업무역량 담당자 팩스" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrCFax.length>=3)?arrCFax[2]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"/>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 학력 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_glmp_application_label04.gif"></td>
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
							<col width="150" />
							<col width="140" />
							<col width="100" />
							<col width="50" />
						</colgroup>
						<tr height="30">
							<td align="center"><img src="/images/common/txt_glmp_txt30.gif"></td>
							<td align="center"><img src="/images/common/txt_glmp_txt31.gif"></td>
							<td align="center"><img src="/images/common/txt_glmp_txt32.gif"></td>
							<td align="center"><img src="/images/common/txt_condition.gif"></td>
						</tr>
						<tr><td height="1" colspan="5" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
						<%
							String v_hgyear = (boxProposeFormGLMP.getString("H_GRADYEARMON").length()>=4) ? boxProposeFormGLMP.getString("H_GRADYEARMON").substring(0,4) : "";
							String v_hgmonth = (boxProposeFormGLMP.getString("H_GRADYEARMON").length()>=6) ? boxProposeFormGLMP.getString("H_GRADYEARMON").substring(4,6) : "";
							String v_ugyear = (boxProposeFormGLMP.getString("U_GRADYEARMON").length()>=4) ? boxProposeFormGLMP.getString("U_GRADYEARMON").substring(0,4) : "";
							String v_ugmonth = (boxProposeFormGLMP.getString("U_GRADYEARMON").length()>=6) ? boxProposeFormGLMP.getString("U_GRADYEARMON").substring(4,6) : "";
							String v_ggyear = (boxProposeFormGLMP.getString("G_GRADYEARMON").length()>=4) ? boxProposeFormGLMP.getString("G_GRADYEARMON").substring(0,4) : "";
							String v_ggmonth = (boxProposeFormGLMP.getString("G_GRADYEARMON").length()>=6) ? boxProposeFormGLMP.getString("G_GRADYEARMON").substring(4,6) : "";
							String v_egyear = (boxProposeFormGLMP.getString("E_GRADYEARMON").length()>=4) ? boxProposeFormGLMP.getString("E_GRADYEARMON").substring(0,4) : "";
							String v_egmonth = (boxProposeFormGLMP.getString("E_GRADYEARMON").length()>=6) ? boxProposeFormGLMP.getString("E_GRADYEARMON").substring(4,6) : "";
						%>
						<tr valign="top" height="26">
							<td>
								<input name="p_hgyear" type="text" size="4" dataType="integer" dispName="고등학교 졸업년도" isNull="N" lenCheck="4" maxLength="4" value="<%=v_hgyear%>" style="width:60px;" onkeyup="checkIsDigit(this);"> 년
								<input name="p_hgmonth" type="text" size="2" dataType="integer" dispName="고등학교 졸업월" isNull="N" lenCheck="2" maxLength="2" value="<%=v_hgmonth%>" style="width:40px;" onkeyup="checkIsDigit(this);"> 월
							</td>
							<td>
								<input name="p_hname" type="text" dispName="고등학교명" isNull="N" lenCheck="10" maxLength="10" value="<%=boxProposeFormGLMP.getString("H_NAME") %>" style="width:100px;"/> 고등학교
							</td>
							<td align="center">
								<input name="p_hmajor" type="text" dispName="고등학교 전공" isNull="Y" lenCheck="10" maxLength="10" value="<%=boxProposeFormGLMP.getString("H_MAJOR") %>" style="width:175px;"/>
							</td>
							<td align="center"><%=CommonUtil.getCodeListBox("select","0110","p_hstate",boxProposeFormGLMP.getStringDefault("H_STATE","01"),"","선택")%></td>
						</tr>
						<tr valign="top" height="26">
							<td>
								<input name="p_ugyear" type="text" size="4" dataType="integer" dispName="대학교 졸업년도" isNull="N" lenCheck="4" maxLength="4" value="<%=v_ugyear%>" style="width:60px;" onkeyup="checkIsDigit(this);"> 년
								<input name="p_ugmonth" type="text" size="4" dataType="integer" dispName="대학교 졸업월" isNull="N" lenCheck="2" maxLength="2" value="<%=v_ugmonth%>" style="width:40px;" onkeyup="checkIsDigit(this);"> 월
							</td>
							<td>
								<input name="p_uname" type="text" dispName="대학교명" isNull="N" lenCheck="10" maxLength="10" value="<%=boxProposeFormGLMP.getString("U_NAME") %>" style="width:100px;"/> 대학교
							</td>
							<td align="center">
								<input name="p_umajor" type="text" dispName="대학교 전공" isNull="Y" lenCheck="20" maxLength="20" value="<%=boxProposeFormGLMP.getString("U_MAJOR") %>" style="width:175px;"/>
							</td>
							<td align="center"><%=CommonUtil.getCodeListBox("select","0110","p_ustate",boxProposeFormGLMP.getStringDefault("U_STATE","01"),"","선택")%></td>
						</tr>
						<tr valign="top" height="26">
							<td>
								<input name="p_ggyear" type="text" size="4" dataType="integer" dispName="대학원 졸업년도" isNull="Y" lenCheck="4" maxLength="4" value="<%=v_ggyear%>" style="width:60px;" onkeyup="checkIsDigit(this);"> 년
								<input name="p_ggmonth" type="text" size="4" dataType="integer" dispName="대학원 졸업월" isNull="Y" lenCheck="2" maxLength="2" value="<%=v_ggmonth%>" style="width:40px;" onkeyup="checkIsDigit(this);"> 월
							</td>
							<td>
								<input name="p_gname" type="text" dispName="대학원명" isNull="Y" lenCheck="10" maxLength="10" value="<%=boxProposeFormGLMP.getString("G_NAME") %>" style="width:100px;"/> 대학원
							</td>
							<td align="center">
								<input name="p_gmajor" type="text" dispName="대학원 전공" isNull="Y" lenCheck="10" maxLength="10" value="<%=boxProposeFormGLMP.getString("G_MAJOR") %>" style="width:175px;"/>
							</td>
							<td align="center"><%=CommonUtil.getCodeListBox("select","0110","p_gstate",boxProposeFormGLMP.getStringDefault("G_STATE","01"),"","선택")%></td>
						</tr>
						<tr valign="top" height="26">
							<td>
								<input name="p_egyear" type="text" size="4" dataType="integer" dispName="기타학력 졸업년도" isNull="Y" lenCheck="4" maxLength="4" value="<%=v_egyear%>" style="width:60px;" onkeyup="checkIsDigit(this);"> 년
								<input name="p_egmonth" type="text" size="4" dataType="integer" dispName="기타학력 졸업월" isNull="Y" lenCheck="2" maxLength="2" value="<%=v_egmonth%>" style="width:40px;" onkeyup="checkIsDigit(this);"> 월
							</td>
							<td colspan="2">
								<input name="p_ename" type="text" dispName="기타학력 학교명" isNull="Y" lenCheck="10" maxLength="10" value="<%=boxProposeFormGLMP.getString("E_NAME") %>" style="width:100px;"/> (최고경영자 과정 등)
							</td>
							<!-- td align="center">

							</td-->
							<td align="center"><%=CommonUtil.getCodeListBox("select","0110","p_estate",boxProposeFormGLMP.getString("E_STATE"),"","선택")%></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 주요경력 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_glmp_application_label05.gif"></td>
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
							<col width="180" />
							<col width="" />
							<col width="50" />
						</colgroup>
						<tr><td height="10"></td></tr>
						<%
							String v_cyear1 = (boxProposeFormGLMP.getString("C_YEARMON1").length()>=4) ? boxProposeFormGLMP.getString("C_YEARMON1").substring(0,4) : "";
							String v_cmonth1 = (boxProposeFormGLMP.getString("C_YEARMON1").length()>=6) ? boxProposeFormGLMP.getString("C_YEARMON1").substring(4,6) : "";
							String v_cyear2 = (boxProposeFormGLMP.getString("C_YEARMON2").length()>=4) ? boxProposeFormGLMP.getString("C_YEARMON2").substring(0,4) : "";
							String v_cmonth2 = (boxProposeFormGLMP.getString("C_YEARMON2").length()>=6) ? boxProposeFormGLMP.getString("C_YEARMON2").substring(4,6) : "";
							String v_cyear3 = (boxProposeFormGLMP.getString("C_YEARMON3").length()>=4) ? boxProposeFormGLMP.getString("C_YEARMON3").substring(0,4) : "";
							String v_cmonth3 = (boxProposeFormGLMP.getString("C_YEARMON3").length()>=6) ? boxProposeFormGLMP.getString("C_YEARMON3").substring(4,6) : "";
						%>
						<tr valign="top" height="26">
							<td>
								<input name="p_cyear1" type="text" size="4" dataType="integer" dispName="경력 년도" isNull="Y" lenCheck="4" maxLength="4" value="<%=v_cyear1%>" style="width:60px;" onkeyup="checkIsDigit(this);"> 년
								<input name="p_cmonth1" type="text" size="4" dataType="integer" dispName="경력 월" isNull="Y" lenCheck="2" maxLength="2" value="<%=v_cmonth1%>" style="width:40px;" onkeyup="checkIsDigit(this);"> 월
							</td>
							<td align="center">
								<input name="p_cdetail1" type="text" dispName="경력내용" isNull="Y" lenCheck="100" maxLength="100" value="<%=boxProposeFormGLMP.getString("C_DETAIL1") %>" style="width:335px;"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td>
								<input name="p_cyear2" type="text" size="4" dataType="integer" dispName="경력 년도" isNull="Y" lenCheck="4" maxLength="4" value="<%=v_cyear2%>" style="width:60px;" onkeyup="checkIsDigit(this);"> 년
								<input name="p_cmonth2" type="text" size="4" dataType="integer" dispName="경력 월" isNull="Y" lenCheck="2" maxLength="2" value="<%=v_cmonth2%>" style="width:40px;" onkeyup="checkIsDigit(this);"> 월
							</td>
							<td align="center">
								<input name="p_cdetail2" type="text" dispName="경력내용" isNull="Y" lenCheck="100" maxLength="100" value="<%=boxProposeFormGLMP.getString("C_DETAIL2") %>" style="width:335px;"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td>
								<input name="p_cyear3" type="text" size="4" dataType="integer" dispName="경력 년도" isNull="Y" lenCheck="4" maxLength="4" value="<%=v_cyear3%>" style="width:60px;" onkeyup="checkIsDigit(this);"> 년
								<input name="p_cmonth3" type="text" size="4" dataType="integer" dispName="경력 월" isNull="Y" lenCheck="2" maxLength="2" value="<%=v_cmonth3%>" style="width:40px;" onkeyup="checkIsDigit(this);"> 월
							</td>
							<td align="center">
								<input name="p_cdetail3" type="text" dispName="경력내용" isNull="Y" lenCheck="100" maxLength="100" value="<%=boxProposeFormGLMP.getString("C_DETAIL3") %>" style="width:335px;"/>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 배우자 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_glmp_application_label06.gif"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-top:10px; padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:5px;">
						<colgroup>
							<col width="15" />
							<col width="80" />
							<col width="" />
						</colgroup>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt35.gif"></td>
							<td>
								<input name="p_wkorname" type="text" dispName="배우자 성명(한글)" isNull="Y" lenCheck="10" maxLength="10" value="<%=boxProposeFormGLMP.getString("W_KORNAME") %>" style="width:200px;"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt37.gif"></td>
							<td>
								<input name="p_wengname" type="text" dispName="배우자 성명(영문)" isNull="Y" lenCheck="30" maxLength="30" value="<%=boxProposeFormGLMP.getString("W_ENGNAME") %>" style="width:200px;"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_passport.gif"></td>
							<td>
								<input name="p_wpassport" type="text" dispName="배우자 여권번호" isNull="Y" lenCheck="30" maxLength="30" value="<%=boxProposeFormGLMP.getString("W_PASSPORT") %>" style="width:200px;"/>
							</td>
						</tr>
						<%--	주민등록번호 제거
						 <tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt38.gif"></td>
							<%
								String v_wjumin1 = (boxProposeFormGLMP.getString("W_JUMIN").length()>=6) ? boxProposeFormGLMP.getString("W_JUMIN").substring(0,6) : "";
								String v_wjumin2 = (boxProposeFormGLMP.getString("W_JUMIN").length()>=13) ? boxProposeFormGLMP.getString("W_JUMIN").substring(6,13) : "";
							%>
							<td>
								<input name="p_wjumin1" type="text" size="6" dataType="integer" dispName="배우자 주민번호" isNull="Y" lenCheck="6" maxLength="6" value="<%=v_wjumin1%>" style="width:90px;"/>
								-
								<input name="p_wjumin2" type="text" size="7" dataType="integer" dispName="배우자 주민번호" isNull="Y" lenCheck="7" maxLength="7" value="<%=v_wjumin2%>" style="width:90px;"/>
							</td>
						</tr> --%>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 추천인 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_glmp_application_label07.gif"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="3"></td></tr>
				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>
				<tr>
					<td style="padding-top:10px; padding-bottom:5px;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:5px;">
						<colgroup>
							<col width="15" />
							<col width="80" />
							<col width="" />
						</colgroup>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt39.gif"></td>
							<td>
								<input name="p_rname" type="text" dispName="추천인 성명(한글)" isNull="Y" lenCheck="10" maxLength="10" value="<%=boxProposeFormGLMP.getString("R_NAME") %>" style="width:200px;"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt40.gif"></td>
							<td>
								<input name="p_rrelation" type="text" dispName="추천인과의 관계" isNull="Y" lenCheck="20" maxLength="20" value="<%=boxProposeFormGLMP.getString("R_RELATION") %>" style="width:200px;"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt41.gif"></td>
							<td>
								<input name="p_rcompnm" type="text" dispName="추천인 회사" isNull="Y" lenCheck="20" maxLength="20" value="<%=boxProposeFormGLMP.getString("R_COMPNM") %>" style="width:200px;"/>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt42.gif"></td>
							<td>
								<input name="p_rposition" type="text" dispName="추천인 직위" isNull="Y" lenCheck="20" maxLength="20" value="<%=boxProposeFormGLMP.getString("R_POSITION") %>" style="width:200px;"/>
							</td>
						</tr>
						<%
							String[] arrRPhone = boxProposeFormGLMP.getString("R_TEL").split("-");
						%>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_glmp_txt43.gif"></td>
							<td>
								<input name="p_rtel1" type="text" size="4" dataType="integer" dispName="추천인 전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrRPhone.length>=2)?arrRPhone[0]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"> -
								<input name="p_rtel2" type="text" size="4" dataType="integer" dispName="추천인 전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrRPhone.length>=2)?arrRPhone[1]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"/> -
								<input name="p_rtel3" type="text" size="4" dataType="integer" dispName="추천인 전화번호" isNull="Y" lenCheck="4" maxLength="4" value="<%=(arrRPhone.length>=3)?arrRPhone[2]:"" %>" style="width:50px;" onkeyup="checkIsDigit(this);"/>
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
					<%if(glmpEditMode.equals("Y")){ %>
						<a href="#" onclick="proposeUpdateGLMP();"><img src="/images/common/btn_popup_save.gif"></a>
					<%}else{ %>
						<a href="#" onclick="proposeWriteGLMP();"><img src="/images/common/btn_popup_insert.gif"></a>
					<%} %>
						<a href="#" onclick="self.close();"><img src="/images/common/btn_popup_cancel.gif"></a></td>
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