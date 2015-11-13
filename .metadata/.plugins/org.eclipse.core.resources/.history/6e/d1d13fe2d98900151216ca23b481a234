<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="com.sinc.framework.data.DataSet"%>
<%@ page import ="com.sinc.framework.data.Box"%>
<%@ page import ="com.sinc.framework.persist.ListDTO"%>
<%@ page import ="com.sinc.common.FormatDate"%>
<%@ page import ="org.apache.commons.configuration.Configuration"%>
<%@ page import ="com.sinc.framework.configuration.ConfigurationFactory"%>
<%@ include file = "/jsp/front/common/commonInc.jsp"%>
<%
	Box applyQuestionList = (Box)box.getObject("applyQuestionList");
	if(applyQuestionList == null){
		applyQuestionList = new Box(new HashMap());
	}
%>
<!-- 헤더 -->
<!-- !DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
<html xmlns="http://www.w3.org/1999/xhtml" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>::: 무역아카데미 트레이드캠퍼스 :::</title>
<style type="text/css">
        .preView { width: 106px; height: 116px; text-align: center; border:1px solid silver; background: url('/images/common/popup_teacher_noimg.gif') repeat-x;}
</style>
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
<script language="Javascript" src="/js/home/template<%=G_TMPL %>.js"></script>
<script language="Javascript" src="/js/common.js"></script>
<script type="text/JavaScript" language="JavaScript" src="/js/common/common.js"></script>
<script type="text/JavaScript" language="JavaScript" src="/js/common/common_util.js"></script>
<script type="text/JavaScript">
function searchZipCode() {
	var url = "/front/Common.do?cmd=selectZipCode";
	Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
}

function setZipCodeInfo(addr, zipcode) {
	var form = document.form1;
	
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

function setBirthday() {
	var f = document.form1;
	var v_jumin1 = f.p_resno1.value;
	var v_jumin2 = f.p_resno2.value;
	var sex = "";
	
	if ( v_jumin1.length == 6 && v_jumin2.length == 7 ) {
		var sex = v_jumin2.substr(0,1);
		if ( sex == "1" || sex == "2" ) {
			f.p_birthyear.value = "19"+v_jumin1.substr(0,2);
		} else if ( sex == "3" || sex == "4" ) {
			f.p_birthyear.value = "20"+v_jumin1.substr(0,2);
		}
		f.p_birthmonth.value = v_jumin1.substr(2,2);
		f.p_birthday.value = v_jumin1.substr(4,6);
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

function goSave(){
	var f = document.form1;

	if(!validate(f)){
		return;
	}

	if(!/(\.gif|\.jpg|\.jpeg|\.png)$/i.test(f.p_picturefile.value)) { 
        alert("이미지 형식의 파일을 선택하십시오"); 
        return; 
    }

	f.action = "/front/Internship.do?cmd=internshipApply&p_noticeno="+f.p_noticeno.value;
	f.cmd.value = "internshipApply";
	f.method = "post";
	f.submit();
}

function addFile() {
	var f = document.form1;
	
	f.p_picturefile.click();
}
function setPicture() {
/*	var f = document.form1;
	var imgMyPicture = document.getElementById("imgMyPicture");
	var tdPicture = document.getElementById("tdPicture");
	//alert ( imgMyPicture.src+"   |    "+f.p_picturefile.value );
	imgMyPicture.src = "file:///"+f.p_picturefile.value;
	imgMyPicture.width = "106";
	imgMyPicture.height = "116";*/
	//alert ( imgMyPicture.height+"  "+imgMyPicture.width+"   "+imgMyPicture.src );
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
</head>

<a name="Top"></a>
<body style="margin:0px;">

<!--//-->
<form name="form1" action="/front/Internship.do" method="post" onSubmit="return false;" enctype="multipart/form-data">
<input type="hidden" name="cmd" value="internshipApplyForm"/>
<input type="hidden" name="p_noticeno" value="<%=box.getString("p_noticeno") %>" />
<input type="hidden" name="p_subj" value="<%=box.getString("p_subj") %>" />
<input type="hidden" name="p_year" value="<%=box.getString("p_year") %>" />
<input type="hidden" name="p_subjseq" value="<%=box.getString("p_subjseq") %>" />
<input type="hidden" name="p_mode" value="W">
<input type="hidden" name="p_question1" value="<%=applyQuestionList.getString("QUESTION1") %>">
<input type="hidden" name="p_question2" value="<%=applyQuestionList.getString("QUESTION2") %>">
<input type="hidden" name="p_question3" value="<%=applyQuestionList.getString("QUESTION3") %>">

<table width="100%" height="100%" cellpadding="0" cellspacing="0">
<tr>
	<td align="center" height="100%" valign="top">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="42" background="/images/common/popup_header_bg.gif">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/common/popup_internship_support_title.gif"></td>
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
									<td>
										<input type="text" name="p_kornm" value="한글" style="width:230px;" dispName="한글이름" isNull="N" lenCheck="20" maxLength="20" onclick="if(this.value=='한글')this.value='';this.onclick=''">
									</td>
								</tr>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:6px;"></td>
									<td style="padding-top:3px;"></td>
									<td>
										<input type="text" name="p_engnm" value="영문" style="width:230px;" dispName="영문이름" isNull="N" lenCheck="20" maxLength="20" onclick="if(this.value=='영문')this.value='';this.onclick=''">
									</td>
								</tr>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
									<td style="padding-top:4px;"><img src="/images/common/txt_passport.gif"></td>
									<td>
										<input type="text" name="p_passportnum" value="" style="width:230px;" dispName="여권번호" isNull="N" lenCheck="15" maxLength="15">
									</td>
								</tr>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
									<td style="padding-top:4px;"><img src="/images/common/txt_passport_date.gif"></td>
									<td>
										<input type="text" name="p_passportexpireyear" value="" style="width:70px;" dispName="여권만료일" isNull="N" datatype="number" lenCheck="4" maxLength="4"> 년&nbsp;
										<input type="text" name="p_passportexpiremonth" value="" style="width:50px;" dispName="여권만료일" isNull="N" datatype="number" lenCheck="2" maxLength="2"> 월&nbsp;
										<input type="text" name="p_passportexpireday" value="" style="width:50px;" dispName="여권만료일" isNull="N" datatype="number" lenCheck="2" maxLength="2"> 일&nbsp;
									</td>
								</tr>								<tr valign="top" height="26">
									<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
									<td style="padding-top:4px;"><img src="/images/common/txt_resno.gif"></td>
									<td>
										<input type="text" name="p_resno1" value="" style="width:105px;" dispName="주민등록번호" isNull="N" datatype="number" lenCheck="6" maxLength="6" onkeyup="checkIsDigit(this);if(this.value.length==6)document.form1.p_resno2.focus();" onblur="setBirthday(this);">
										-
										<input type="text" name="p_resno2" value="" style="width:110px;" dispName="주민등록번호" isNull="N" datatype="number" lenCheck="7" maxLength="7" onkeyup="checkIsDigit(this);" onblur="setBirthday(this);">
									</td>
								</tr>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
									<td style="padding-top:4px;"><img src="/images/common/txt_birthday.gif"></td>
									<td>
										<input type="text" name="p_birthyear" value="" style="width:70px;" dispName="생년월일" isNull="N" datatype="number" lenCheck="4" maxLength="4"> 년&nbsp;
										<input type="text" name="p_birthmonth" value="" style="width:50px;" dispName="생년월일" isNull="N" datatype="number" lenCheck="2" maxLength="2"> 월&nbsp;
										<input type="text" name="p_birthday" value="" style="width:50px;" dispName="생년월일" isNull="N" datatype="number" lenCheck="2" maxLength="2"> 일&nbsp;
									</td>
								</tr>
								</table>
							</td>
							<td></td>
							<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<colgroup>
									<!--  col width="118" />
									<col width="14" / -->
									<col width="118" />
								</colgroup>
								<tr valign="top">
									<!-- td>
										<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td id="tdPicture" bgcolor="#ebebeb" style="padding:6px;">
												<img id="imgMyPicture" src="/images/common/popup_teacher_noimg.gif">
											</td>
										</tr>
										</table>
									</td>
									<td></td -->
									<td>
										<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<table width="115" border="0" cellpadding="0" cellspacing="0" class="noline">
												<tr>
													<td class="td_noline" style="padding:6px; background-color:#ebebeb;">
														<div id="preView" class="preView" title="이미지미리보기">
														</div>
														</td>
												</tr>
												</table>	
											</td>
										</tr>
										<tr><td height="20"></td></tr>
										<tr>
											<td><!-- a href="#none" onclick="javascript:addFile()"><img src="/images/common/btn_file_find.gif" -->
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
							<col width="" />
						</colgroup>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_military.gif"></td>
							<td>
								<input type="radio" name="p_military" value="Y" style="border:none;" dispName="군병력" isNull="N" checked> 군필&nbsp;&nbsp;
								<input type="radio" name="p_military" value="N" style="border:none;" dispName="군병력" isNull="N"> 미필&nbsp;&nbsp;
								<input type="radio" name="p_military" value="E" style="border:none;" dispName="군병력" isNull="N"> 면제
								<input type="text" name="p_incomplet" value="면제사유"  lenCheck="50" maxLength="50" style="width:330px;" onclick="if(this.value=='면제사유')this.value='';this.onclick=''">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_now_address.gif"></td>
							<td>
								<input type="text" name="p_zip1" value="" style="width:100px;" dispName="우편번호" isNull="N" datatype="number" readOnly>
								<input type="hidden" name="p_zip2" value="" dispName="우편번호">
								<a href="#none" onclick="javascript:searchZipCode()"><img src="/images/common/btn_popup_search_2.gif"></a>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"></td>
							<td style="padding-top:4px;"></td>
							<td>
								<input type="text" name="p_addr" value="" style="width:497px;" dispName="주소" isNull="N" lenCheck="100" maxLength="100">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_phone.gif"></td>
							<td>
								<input type="text" name="p_telno1" value="" style="width:80px;" dispName="전화번호" lenCheck="3" maxLength="3" isNull="N" datatype="number"> -
								<input type="text" name="p_telno2" value="" style="width:100px;" dispName="전화번호" lenCheck="4" maxLength="4" isNull="N" datatype="number"> -
								<input type="text" name="p_telno3" value="" style="width:100px;" dispName="전화번호" lenCheck="4" maxLength="4" isNull="N" datatype="number">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_mobile.gif"></td>
							<td>
								<input type="text" name="p_handtel1" value="" style="width:80px;" dispName="휴대전화" lenCheck="3" maxLength="3" isNull="N" datatype="number"> -
								<input type="text" name="p_handtel2" value="" style="width:100px;" dispName="휴대전화" lenCheck="4" maxLength="4" isNull="N" datatype="number"> -
								<input type="text" name="p_handtel3" value="" style="width:100px;" dispName="휴대전화" lenCheck="4" maxLength="4" isNull="N" datatype="number">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_email.gif"></td>
							<td>
								<input type="text" name="p_email1" value="" style="width:100px;" dispName="이메일" isNull="N" lenCheck="40" maxLength="50">
								@
								<input type="text" name="p_email2" value="" style="width:150px;" dispName="이메일" isNull="N" lenCheck="40" maxLength="50">
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 추가입력정보 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_internship_support_label01.gif"></td>
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
							<td style="padding-top:4px;"><img src="/images/common/txt_overseas_experience.gif"></td>
							<td>
								국가명
								<input type="text" name="p_foreignstay" value="" style="width:200px;" dispName="해외체류경험국가" isNull="N" lenCheck="20" maxLength="20">
								&nbsp;&nbsp;&nbsp;&nbsp;
								개월수
								<input type="text" name="p_foreignstaymonth" value="" style="width:150px;" dispName="해외체류개월수" isNull="N" datatype="number" lenCheck="3" maxLength="3">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_hope_country.gif"></td>
							<td>
								1순위
								<input type="text" name="p_wishnation1" value="" style="width:100px;" dispName="1순위희망국가" isNull="N" lenCheck="20" maxLength="20">
								&nbsp;&nbsp;&nbsp;&nbsp
								2순위
								<input type="text" name="p_wishnation2" value="" style="width:100px;" dispName="2순위희망국가" isNull="N" lenCheck="20" maxLength="20">
								&nbsp;&nbsp;&nbsp;&nbsp
								3순위
								<input type="text" name="p_wishnation3" value="" style="width:100px;" dispName="3순위희망국가" isNull="N" lenCheck="20" maxLength="20">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_target.gif"></td>
							<td>
								<input type="text" name="p_protecobj" value="" style="width:200px;" dispName="보훈대상" isNull="Y" lenCheck="20" maxLength="20">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_disabled_person.gif"></td>
							<td>
								장애 <input type="radio" name="p_handicapyn" value="Y" style="border:none;" dispName="장애인여부" isNull="N"> 
								비장애 <input type="radio" name="p_handicapyn" value="N" style="border:none;" dispName="장애인여부" isNull="N" checked>
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
							<td><img src="/images/common/popup_internship_support_label02.gif"></td>
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
							<col width="75" />
							<col width="75" />
							<col width="140" />
							<col width="55" />
							<col width="" />
							<col width="65" />
							<col width="50" />
						</colgroup>
						<tr height="30">
							<td align="center"><img src="/images/common/txt_entrance_date.gif"></td>
							<td align="center"><img src="/images/common/txt_graduate_date.gif"></td>
							<td align="center"><img src="/images/common/txt_school_name.gif"></td>
							<td align="center"><img src="/images/common/txt_school_status.gif"></td>
							<td align="center"><img src="/images/common/txt_double_major.gif"></td>
							<td align="center"><img src="/images/common/txt_school_grade.gif"></td>
							<td align="center"><img src="/images/common/txt_location.gif"></td>
						</tr>
						<tr><td height="1" colspan="7" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
						<tr valign="top" height="26">
							<td>
								<input type="text" id="p_enteryear1" name="p_enteryear" value="" style="width:70px;" dispName="입학년도" isNull="N" datatype="number" lenCheck="6" maxLength="6">
							</td>
							<td>
								<input type="text" id="p_gradeyear1" name="p_gradeyear" value="" style="width:70px;" dispName="졸업년도" isNull="N" datatype="number" lenCheck="6" maxLength="6">
							</td>
							<td>
								<input type="text" id="p_schoolnm1" name="p_schoolnm" value="" style="width:70px;" dispName="학교명" isNull="N" lenCheck="20" maxLength="20">
								대학교
							</td>
							<td align="center">
								<select id="p_status1" name="p_status" style="width:70px;" dispName="상태" isNull="N">
									<option value="">-선택-</option>
									<option value="재학중">재학중</option>
									<option value="휴학중">휴학중</option>
									<option value="졸업예정">졸업예정</option>
									<option value="졸업">졸업</option>
								</select>
							</td>
							<td align="center">
								<input type="text" id="p_major1" name="p_major" value="" style="width:150px;" dispName="전공" isNull="N" lenCheck="20" maxLength="20">
							</td>
							<td align="center">
								<input type="text" id="p_score1" name="p_score" value="" style="width:30px;" dispName="학점" isNull="N" datatype="float" lenCheck="3" maxLength="3">/4.5
							</td>
							<td align="right">
								<input type="text" id="p_locate1" name="p_locate" value="" style="width:50px;" dispName="소재지" isNull="N" lenCheck="20" maxLength="20">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td>
								<input type="text" id="p_enteryear2" name="p_enteryear" value="" style="width:70px;" dispName="입학년도" isNull="Y" datatype="number" lenCheck="6" maxLength="6">
							</td>
							<td>
								<input type="text" id="p_gradeyear2" name="p_gradeyear" value="" style="width:70px;" dispName="졸업년도" isNull="Y" datatype="number" lenCheck="6" maxLength="6">
							</td>
							<td>
								<input type="text" id="p_schoolnm2" name="p_schoolnm" value="" style="width:70px;" dispName="학교명" isNull="Y" datatype="number" lenCheck="20" maxLength="20">
								대학교(편입)
							</td>
							<td align="center">
								<select id="p_status2" name="p_status" style="width:70px;" dispName="상태" isNull="Y">
									<option value="">-선택-</option>
									<option value="재학중">재학중</option>
									<option value="휴학중">휴학중</option>
									<option value="졸업예정">졸업예정</option>
									<option value="졸업">졸업</option>
								</select>
							</td>
							<td align="center">
								<input type="text" id="p_major2" name="p_major" value="" style="width:150px;" dispName="전공" isNull="Y" lenCheck="20" maxLength="20">
							</td>
							<td align="center">
								<input type="text" id="p_score2" name="p_score" value="" style="width:30px;" dispName="학점" isNull="Y" datatype="float" lenCheck="3" maxLength="3">/4.5
							</td>
							<td align="right">
								<input type="text" id="p_locate2" name="p_locate" value="" style="width:50px;" dispName="소재지" isNull="Y" lenCheck="20" maxLength="20">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td>
								<input type="text" id="p_enteryear3" name="p_enteryear" value="" style="width:70px;" dispName="입학년도" isNull="Y" datatype="number" lenCheck="6" maxLength="6">
							</td>
							<td>
								<input type="text" id="p_gradeyear3" name="p_gradeyear" value="" style="width:70px;" dispName="졸업년도" isNull="Y" datatype="number" lenCheck="6" maxLength="6">
							</td>
							<td>
								<input type="text" id="p_schoolnm3" name="p_schoolnm" value="" style="width:70px;" dispName="학교명" isNull="Y" lenCheck="20" maxLength="20">
								대학원
							</td>
							<td align="center">
								<select id="p_status3" name="p_status" style="width:70px;" dispName="상태" isNull="Y">
									<option value="">-선택-</option>
									<option value="재학중">재학중</option>
									<option value="휴학중">휴학중</option>
									<option value="졸업예정">졸업예정</option>
									<option value="졸업">졸업</option>
								</select>
							</td>
							<td align="center">
								<input type="text" id="p_major3" name="p_major" value="" style="width:150px;" dispName="전공" isNull="Y" lenCheck="20" maxLength="20">
							</td>
							<td align="center">
								<input type="text" id="p_score3" name="p_score" value="" style="width:30px;" dispName="학점" isNull="Y" datatype="float" lenCheck="3" maxLength="3">/4.5
							</td>
							<td align="right">
								<input type="text" id="p_locate3" name="p_locate" value="" style="width:50px;" dispName="소재지" isNull="Y" lenCheck="20" maxLength="20">
							</td>
						</tr>
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
							<td><img src="/images/common/popup_internship_support_label03.gif"></td>
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
							<col width="100" />
							<col width="" />
							<col width="80" />
							<col width="105" />
							<col width="100" />
						</colgroup>
						<tr height="30">
							<td align="center"><img src="/images/common/txt_language_name.gif"></td>
							<td align="center"><img src="/images/common/txt_language_test.gif"></td>
							<td align="center"><img src="/images/common/txt_language_score.gif"></td>
							<td align="center"><img src="/images/common/txt_get_gigwan.gif"></td>
							<td align="center"><img src="/images/common/txt_get_date.gif"></td>
						</tr>
						<tr><td height="1" colspan="5" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
						<tr valign="top" height="26">
							<td>
								영어<input type="hidden" id="p_language1" name="p_language" value="영어" style="width:95px;">
							</td>
							<td>
								<input type="text" id="p_testnm1" name="p_testnm" value="" style="width:200px;" dispName="시험명" isNull="Y" lenCheck="30" maxLength="30">
							</td>
							<td>
								<input type="text" id="p_langscore1" name="p_langscore" value="" style="width:75px;" dispName="점수/등급" isNull="Y" dataType="number" lenCheck="4" maxLength="4">
							</td>
							<td>
								<input type="text" id="p_issueorgan1" name="p_issueorgan" value="" style="width:100px;" dispName="발급기관" isNull="Y" lenCheck="20" maxLength="20">
							</td>
							<td>
								<input type="text" id="p_getdate1" name="p_getdate" value="" style="width:100px;" dispName="취득일자" isNull="Y" dataType="number" lenCheck="8" maxLength="8">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td>
								일어<input type="hidden" id="p_language2" name="p_language" value="일어" style="width:95px;">
							</td>
							<td>
								<input type="text" id="p_testnm2" name="p_testnm" value="" style="width:200px;" dispName="시험명" isNull="Y" lenCheck="30" maxLength="30">
							</td>
							<td>
								<input type="text" id="p_langscore2" name="p_langscore" value="" style="width:75px;" dispName="점수/등급" isNull="Y" dataType="number" lenCheck="4" maxLength="4">
							</td>
							<td>
								<input type="text" id="p_issueorgan2" name="p_issueorgan" value="" style="width:100px;" dispName="발급기관" isNull="Y" lenCheck="20" maxLength="20">
							</td>
							<td>
								<input type="text" id="p_getdate2" name="p_getdate" value="" style="width:100px;" dispName="취득일자" isNull="Y" dataType="number" lenCheck="8" maxLength="8">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td>
								중국어<input type="hidden" id="p_language3" name="p_language" value="중국어" style="width:95px;">
							</td>
							<td>
								<input type="text" id="p_testnm3" name="p_testnm" value="" style="width:200px;" dispName="시험명" isNull="Y" lenCheck="30" maxLength="30">
							</td>
							<td>
								<input type="text" id="p_langscore3" name="p_langscore" value="" style="width:75px;" dispName="점수/등급" isNull="Y" dataType="number" lenCheck="4" maxLength="4">
							</td>
							<td>
								<input type="text" id="p_issueorgan3" name="p_issueorgan" value="" style="width:100px;" dispName="발급기관" isNull="Y" lenCheck="20" maxLength="20">
							</td>
							<td>
								<input type="text" id="p_getdate3" name="p_getdate" value="" style="width:100px;" dispName="취득일자" isNull="Y" dataType="number" lenCheck="8" maxLength="8">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td>
								<input type="text" id="p_language4" name="p_language" value="" style="width:95px;" dispName="언어" isNull="Y" lenCheck="20" maxLength="20">
							</td>
							<td>
								<input type="text" id="p_testnm4" name="p_testnm" value="" style="width:200px;" dispName="시험명" isNull="Y" lenCheck="30" maxLength="30">
							</td>
							<td>
								<input type="text" id="p_langscore4" name="p_langscore" value="" style="width:75px;" dispName="점수/등급" isNull="Y" dataType="number" lenCheck="4" maxLength="4">
							</td>
							<td>
								<input type="text" id="p_issueorgan4" name="p_issueorgan" value="" style="width:100px;" dispName="발급기관" isNull="Y" lenCheck="20" maxLength="20">
							</td>
							<td>
								<input type="text" id="p_getdate4" name="p_getdate" value="" style="width:100px;" dispName="취득일자" isNull="Y" dataType="number" lenCheck="8" maxLength="8">
							</td>
						</tr>
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
							<td><img src="/images/common/popup_internship_support_label04.gif"></td>
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
							<td style="padding-top:4px;"><img src="/images/common/txt_license_name.gif"></td>
							<td style="padding-top:4px;">
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<colgroup>
									<col width="33%" />
									<col width="33%" />
									<col width="34%" />
								</colgroup>
								<tr>
									<td height="20">
										<input type="checkbox" id="p_licensenm1" name="p_licensenm" value="무역영어1급" style="border:none;">무역영어1급
										<input type="checkbox" id="p_licensenm2" name="p_licensenm" value="국제무역사" style="border:none;">국제무역사
										<input type="checkbox" id="p_licensenm3" name="p_licensenm" value="외환관리사" style="border:none;">외환관리사
									</td>
								</tr>
								<tr>
									<td height="20">
										<input type="checkbox" id="p_licensenm4" name="p_licensenm" value="물류관리사" style="border:none;">물류관리사
										<input type="checkbox" id="p_licensenm5" name="p_licensenm" value="유통관리사" style="border:none;">유통관리사
										<input type="checkbox" id="p_licensenm6" name="p_licensenm" value="관세사" style="border:none;">관세사
									</td>
								</tr>
								<tr>
									<td height="20">
										<input type="text" id="p_licensenm7" name="p_licensenm" value="" style="width:350px;" lenCheck="150" maxLength="150">
									</td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 자기소개서 작성 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_internship_support_label05.gif"></td>
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
						<tr>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_self_introduce.gif"></td>
							<td style="padding-top:5px;">
								<textarea name="p_introself" style="width:490px; height:100px;" dispName="자기소개서" isNull="N" lenCheck="500" maxLength="500"></textarea>
							</td>
						</tr>
						<tr>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_activities.gif"></td>
							<td style="padding-top:5px;">
								<textarea name="p_specialaction" style="width:490px; height:100px;" dispName="특이사항" isNull="N" lenCheck="500" maxLength="20"></textarea>
							</td>
						</tr>
						<tr>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_interest.gif"></td>
							<td style="padding-top:5px;">
								<textarea name="p_interestpart" style="width:490px; height:100px;" dispName="관심분야" isNull="N" lenCheck="500" maxLength="500"></textarea>
							</td>
						</tr>
						<tr>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_etc.gif"></td>
							<td style="padding-top:5px;">
								<textarea name="p_etc" style="width:490px; height:100px;" lenCheck="500" maxLength="500"></textarea>
							</td>
						</tr>
						</table>

					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 단답형 질문 작성 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_internship_support_label06.gif"></td>
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
						<tr>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><%=applyQuestionList.getString("QUESTION1") %></td>
							<td style="padding-top:5px;">
								<textarea name="p_answer1" style="width:490px; height:100px;" dispName="질문에 대한 답변" isNull="N" lenCheck="500" maxLength="500"></textarea>
							</td>
						</tr>
						<tr>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><%=applyQuestionList.getString("QUESTION2") %></td>
							<td style="padding-top:5px;">
								<textarea name="p_answer2" style="width:490px; height:100px;" dispName="질문에 대한 답변" isNull="N" lenCheck="500" maxLength="500"></textarea>
							</td>
						</tr>
						<tr>
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><%=applyQuestionList.getString("QUESTION3") %></td>
							<td style="padding-top:5px;">
								<textarea name="p_answer3" style="width:490px; height:100px;" dispName="질문에 대한 답변" isNull="N" lenCheck="500" maxLength="500"></textarea>
							</td>
						</tr>
						</table>

					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:10px;">
				<tr>
					<td align="right">
						<a href="javascript:goSave();"><img src="/images/common/btn_popup_insert01.gif"></a>
						<a href="javascript:self.close();"><img src="/images/common/btn_popup_cancel.gif"></a></td>
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
