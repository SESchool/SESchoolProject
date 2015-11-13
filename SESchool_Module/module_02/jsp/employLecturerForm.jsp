<%@ page contentType="text/html;charset=UTF-8" 		%>
<%@ include file = "/jsp/front/common/commonBasicInc.jsp"%>
<%
	Box info = null;
	DataSet academic = null;
	DataSet license = null;
	DataSet book = null;
	DataSet career = null;
	DataSet lCareer = null;
	String s_userid = box.getString("s_userid");
	String s_menucontrol = box.getString("s_menucontrol");
	if(!s_userid.equals("") && !s_menucontrol.equals("")){
		info = (Box)box.getObject("lectureInfo");
		academic = (DataSet)box.getObject("lectureAcademic");
		license = (DataSet)box.getObject("lectureLicense");
		book = (DataSet)box.getObject("lectureBook");
		career = (DataSet)box.getObject("lectureCareer");
		lCareer = (DataSet)box.getObject("lectureLecturecareer");
	}
	if(info == null){
		info = new Box("temp");
	}
	String v_korname = info.getString("KORNAME");
	String v_chaname = info.getString("CHANAME");
	String v_engname = info.getString("ENGNAME");
	
	String v_photo = info.getString("PHOTO");
	
	String v_birthday = info.getString("BIRTHDAY");
	String v_year = "";
	String v_month = "";
	String v_date = "";
	if(v_birthday != null && v_birthday.length() == 8){
		v_year = v_birthday.substring(0,4);
		v_month = v_birthday.substring(4,6);
		v_date = v_birthday.substring(6,8);
	}
	String v_sex = info.getString("SEX");
	String v_post1 = info.getString("POST1");
	String v_post2 = info.getString("POST2");
	String v_addr = info.getString("ADDR");
	String v_hometel = info.getString("HOMETEL");
	String[] hometel = {"","",""};
	if(v_hometel != null && !"".equals(v_hometel)){
		 hometel = v_hometel.split("-");
	}
	String v_handphone = info.getString("HANDPHONE");
	String[] handphone = {"","",""};
	if(v_handphone != null && !"".equals(v_handphone)){
		handphone = v_handphone.split("-");
	}
	String v_email = info.getString("EMAIL");
	String v_part = info.getString("PART");
	String[] part = {"","","",""};
	if(v_part != null && !"".equals(v_part)){
		part[0] = v_part.substring(0,1);
		part[1] = v_part.substring(1,2);
		part[2] = v_part.substring(2,3);
		part[3] = v_part.substring(3,4);
	}
	String v_detailpart1 = info.getString("DETAILPART1");
	String v_detailpart2 = info.getString("DETAILPART2");
	String v_detailpart3 = info.getString("DETAILPART3");
	if(v_photo != null && !"".equals(v_photo)) {
		v_photo = "/upload/employCompOrLecturer/"+v_photo;
	}
%>
<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
		<style type="text/css">
        .preView { width: 106px; height: 116px; text-align: center; border:1px solid silver; background: url('/images/common/popup_teacher_noimg.gif') repeat-x;}
        </style>
<script language="Javascript" src="/js/home/template<%=G_TMPL %>.js"></script>
<script language="Javascript" src="/js/common/common.js"></script>
<script language="Javascript" src="/js/common/util.js"></script>
<script type="text/javascript">
<!--
	function fnRegist(){
		var f = document.form1;
		if(!validate(f)){
			return;
		}
		f.submit();
	}

	function validate(f){
		if(ncCom_Empty(f.p_korname.value)) return ncCom_ErrField(f.p_korname,"성명(한글)을 입력하세요");
		if(ncCom_Empty(f.p_chaname.value)) return ncCom_ErrField(f.p_chaname,"성명(한자)을 입력하세요");
		if(ncCom_Empty(f.p_engname.value)) return ncCom_ErrField(f.p_engname,"성명(영문)을 입력하세요");
		if(ncCom_Empty(f.p_picturefile.value)) return ncCom_ErrField(f.p_picturefile,"사진이 없습니다.");
		if(!checkYMD(true, f.p_year, f.p_month, f.p_date)) return false;
		var birthday = f.p_year.value;
		if(f.p_month.value.length == 1){
			f.p_month.value = "0"+f.p_month.value;
		}
		birthday += ""+f.p_month.value;
		if(f.p_date.value.length == 1){
			f.p_date.value = "0"+f.p_date.value;
		}
		birthday += ""+f.p_date.value;
		f.p_birthday.value = birthday;

		if(ncCom_Empty(f.p_post1.value)){
			alert("현 주소를 입력해주세요");
			return false;
		}

		if(f.p_hometel1.value.length < 2 || f.p_hometel2.value.length < 3 || f.p_hometel3.value.length < 4) {
			alert("전화번호를 입력해주세요");
			return false;
		}
		if(!isNumber(f.p_hometel1.value) || !isNumber(f.p_hometel2.value) || !isNumber(f.p_hometel3.value)){
			alert("전화번호는 숫자 입니다.");
			return false;
		}
		f.p_hometel.value = f.p_hometel1.value + "-" + f.p_hometel2.value + "-" + f.p_hometel3.value;

		if(f.p_handphone1.value.length < 3 || f.p_handphone2.value.length < 3 || f.p_handphone3.value.length < 4) {
			alert("휴대전화를 입력해주세요");
			return false;
		}
		if(!isNumber(f.p_handphone1.value) || !isNumber(f.p_handphone2.value) || !isNumber(f.p_handphone3.value)){
			alert("휴대전화는 숫자 입니다.");
			return false;
		}
		f.p_handphone.value = f.p_handphone1.value + "-" + f.p_handphone2.value + "-" + f.p_handphone3.value;

		if(!chkEmail(f.p_email.value)) return ncCom_ErrField(f.p_email,"이메일 형식에 맞춰주세요.");
		var checkCnt = 0;
		var parts = "";
		for(var i = 0; i < f.p_part.length; i++){
			if(f.p_part[i].checked){
				checkCnt++;
				parts += "Y";
			} else {
				parts += "N";
			}
		}

		f.p_parts.value = parts;
		if(checkCnt == 0) {
			alert("지원분야(대분야)를 선택해 주세요");
			return false;
		}
		if(f.p_detailpart1.value == "" && f.p_detailpart2.value == "" && f.p_detailpart1.value == ""){
			alert("지원분야(상세과목)을 하나 이상 입력해 주세요");
			return false;
		}
		return true;
	}

	function validateEtc(f){
		// 학력사항
		var sc = f.p_gradeyear.length;
		if(sc == undefined){

		} else {

		}

		// 경력사항
		var comp = f.p_compnm.length;
		if(comp == undefined){

		} else {

		}

		// 강의경력
		var lecture = f.p_lecturepart.length;
		if(lecture == undefined){

		} else {

		}

		// 저서
		var book = f.p_booknm.length;
		if(book == undefined){

		} else {

		}

		// 자격증
		var license = f.p_licensenm.length;
		if(license == undefined){

		} else {

		}
	}

	function fnModifyForm(id, type){
		if(type == "add"){
			var str = document.getElementById(id+"form").innerHTML;
			document.getElementById(id).innerHTML += str;
		}
		if(type == "del") {
			var temp = document.getElementById(id).innerHTML;
			var lastIdx = temp.lastIndexOf("<TABLE id="+id+"table");
			document.getElementById(id).innerHTML = temp.substring(0, lastIdx);
		}
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
	/*
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
	*/

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
//-->
</script>
<body style="margin:0px;">
<form name="form1" action="/front/Employ.do?cmd=insertEmployLecturer" method="post" onSubmit="return false;" enctype="multipart/form-data">
<input type="hidden" name="p_resno" value=""/>
<input type="hidden" name="p_birthday" value=""/>
<input type="hidden" name="p_hometel" value=""/>
<input type="hidden" name="p_handphone" value=""/>
<input type="hidden" name="p_parts" value=""/>
<table width="100%" height="100%" cellpadding="0" cellspacing="0">
<tr>
	<td align="center" height="100%" valign="top">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="42" background="/images/common/popup_header_bg.gif">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/common/popup_gyosu_support_title.gif"></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="100%" valign="top" align="center" style="padding:20px;">
				<!-- 개인정보 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_teacher_label01.gif"></td>
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
										한글&nbsp;<input type="text" name="p_korname" value="<%=v_korname %>" style="width:200px;">
									</td>
								</tr>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:6px;"></td>
									<td style="padding-top:3px;"></td>
									<td>
										漢字&nbsp;<input type="text" name="p_chaname" value="<%=v_chaname %>" style="width:200px;">
									</td>
								</tr>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:6px;"></td>
									<td style="padding-top:3px;"></td>
									<td>
										영문&nbsp;<input type="text" name="p_engname" value="<%=v_engname %>" style="width:200px;">
									</td>
								</tr>
								<tr valign="top" height="26">
									<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
									<td style="padding-top:4px;"><img src="/images/common/txt_birthday.gif"></td>
									<td>
										<input type="text" name="p_year" maxlength="4" value="<%=v_year %>" style="width:50px;"> 년&nbsp;
										<input type="text" name="p_month" maxlength="2" value="<%=v_month %>" style="width:50px;"> 월&nbsp;
										<input type="text" name="p_date" maxlength="2" value="<%=v_date %>" style="width:50px;"> 일&nbsp;
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
											<td bgcolor="#ebebeb" style="padding:6px;">
												<div id="preView" class="preView" title="이미지미리보기">
												<% if(v_photo != null && !"".equals(v_photo)) {%>
												<img width="100" height="110" src="<%=v_photo %>">
												<% } %>
												</div>
												<!--  <img src="/images/common/popup_teacher_noimg.gif"> -->
												</td>

										</tr>
										</table>
									</td>
									<td></td>
									<td>
										<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<!-- <img src="/images/common/popup_photo_explain.gif"> --></td>
										</tr>
										<tr><td height="3"></td></tr>
										<tr>
											<td>
											</td>
										</tr>
										<tr><td height="3"></td></tr>
										<tr>
											<td><!-- <a href="#"><img src="/images/common/btn_file_find.gif"></a> --></td>
										</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td colspan="3">
									<% if("".equals(v_korname)) { %>
									<input type="file" name="p_picturefile" value="" onchange="fileUploadPreview(this, 'preView')" style="display:; width:210px; height:18px; background-color:#FFFFFF;" dispName="사진" isNull="N"></a>
									<% } %>
									</td>
								</tr>
								</table>
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
							<td style="padding-top:4px;"><img src="/images/common/txt_sex.gif"></td>
							<td>
								<input type="radio" name="p_sex" value="M" style="border:none;" <% if("M".equals(v_sex) || "".equals(v_sex)) { %> checked="checked" <% } %>> 남자&nbsp;&nbsp;
								<input type="radio" name="p_sex" value="F" style="border:none;" <% if("F".equals(v_sex)) { %> checked="checked" <% } %>> 여자
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_now_address.gif"></td>
							<td>
								
								<% if( v_post2 == null || v_post2.equals("")){ %>
									<input type="text" name="p_post1" maxlength="5" value="<%=v_post1 %>" style="width:80px;" readonly="readonly">
									<input type="hidden" name="p_post2" value="<%=v_post2 %>" >
								<% } else { %>
									<input type="text" name="p_post1" value="<%=v_post1 %>" style="width:80px;" readonly="readonly"> -
									<input type="text" name="p_post2" value="<%=v_post2 %>" style="width:80px;" readonly="readonly">
								<% } %>
								<% if("".equals(v_korname)) { %>
									<a href="#none" onclick="searchZipCode('home')"><img src="/images/common/btn_popup_search_2.gif"></a>
								<%} %>
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"></td>
							<td style="padding-top:4px;"></td>
							<td>
								<input type="text" name="p_addr" value="<%=v_addr %>" style="width:497px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_phone.gif"></td>
							<td>
								<input type="text" name="p_hometel1" maxlength="3" value="<%=hometel[0]%>" style="width:60px;"> -
								<input type="text" name="p_hometel2" maxlength="4" value="<%=hometel[1] %>" style="width:80px;"> -
								<input type="text" name="p_hometel3" maxlength="4" value="<%=hometel[2] %>" style="width:80px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_mobile.gif"></td>
							<td>
								<input type="text" name="p_handphone1" maxlength="3" value="<%=handphone[0] %>" style="width:60px;"> -
								<input type="text" name="p_handphone2" maxlength="4" value="<%=handphone[1] %>" style="width:80px;"> -
								<input type="text" name="p_handphone3" maxlength="4" value="<%=handphone[2] %>" style="width:80px;">
							</td>
						</tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_email.gif"></td>
							<td>
								<input type="text" name="p_email" value="<%=v_email %>" style="width:250px;">
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
							<td><img src="/images/common/popup_teacher_label02.gif">&nbsp;&nbsp;<span style="color: red;font-size: 12px">※모든항목을 입력하지 않으면 해당 라인은 저장되지 않습니다</span></td>
							<td align="right" valign="bottom">
								<% if("".equals(v_korname)) { %>
								<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<a href="#none" onclick="fnModifyForm('academic','add');"><img src="/images/common/btn_popup_icon_insert.gif"></a></td>
									<td style="padding-left:1px;">
										<a href="#none" onclick="fnModifyForm('academic','del');"><img src="/images/common/btn_popup_icon_delete.gif"></a></td>
								</tr>
								</table>
								<% } %>
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
							<col width="145" />
							<col width="145" />
							<col width="145" />
							<col width="145" />
						</colgroup>
						<tr height="30">
							<td align="center"><img src="/images/common/txt_graduate_date.gif"></td>
							<td align="center"><img src="/images/common/txt_school_name.gif"></td>
							<td align="center"><img src="/images/common/txt_major.gif"></td>
							<td align="center"><img src="/images/common/txt_location.gif"></td>
						</tr>
						<tr><td height="1" colspan="4" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
						<tr valign="top" height="26">
							<td colspan="4">
								<div id="academicform">
									<table id="academictable" width="100%" border="0" cellpadding="0" cellspacing="0">
									<colgroup>
										<col width="145" />
										<col width="145" />
										<col width="145" />
										<col width="145" />
									</colgroup>
									<%
										if(academic != null && academic.getRow() > 0) {
											while(academic.next()){
									%>
									<tr valign="top" height="26">
										<td>
											<input type="text" name="p_gradeyear" maxlength="4" value="<%=academic.getString("GRADEYEAR") %>" style="width:145px;">
										</td>
										<td align="center">
											<input type="text" name="p_schoolnm" value="<%=academic.getString("SCHOOLNM") %>" style="width:145px;">
										</td>
										<td align="center">
											<input type="text" name="p_major" value="<%=academic.getString("MAJOR") %>" style="width:145px;">
										</td>
										<td align="right">
											<input type="text" name="p_locate" value="<%=academic.getString("LOCATE") %>" style="width:145px;">
										</td>
									</tr>
									<%
											}

										} else {
									%>
									<tr valign="top" height="26">
										<td>
											<input type="text" name="p_gradeyear" maxlength="4" value="" style="width:145px;">
										</td>
										<td align="center">
											<input type="text" name="p_schoolnm" value="" style="width:145px;">
										</td>
										<td align="center">
											<input type="text" name="p_major" value="" style="width:145px;">
										</td>
										<td align="right">
											<input type="text" name="p_locate" value="" style="width:145px;">
										</td>
									</tr>
									<% } %>
									</table>
								</div>
								<div id="academic"></div>
							</td>
						</tr>
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
							<td><img src="/images/common/popup_teacher_label03.gif">&nbsp;&nbsp;<span style="color: red;font-size: 12px">※모든항목을 입력하지 않으면 해당 라인은 저장되지 않습니다</span></td>
							<td align="right" valign="bottom">
								<% if("".equals(v_korname)) { %>
								<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<a href="#none" onclick="fnModifyForm('career','add');"><img src="/images/common/btn_popup_icon_insert.gif"></a></td>
									<td style="padding-left:1px;">
										<a href="#none" onclick="fnModifyForm('career','del');"><img src="/images/common/btn_popup_icon_delete.gif"></a></td>
								</tr>
								</table>
								<% } %>
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
							<col width="120" />
							<col width="100" />
							<col width="200" />
							<col width="180" />
						</colgroup>
						<tr height="30">
							<td align="center"><img src="/images/common/txt_company_name.gif"></td>
							<td align="center"><img src="/images/common/txt_jikwi.gif"></td>
							<td align="center"><img src="/images/common/txt_work_date.gif"></td>
							<td align="center"><img src="/images/common/txt_upmoo.gif"></td>
						</tr>
						<tr><td height="1" colspan="4" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
						<tr valign="top" height="26">
							<td colspan="4">
								<div id="careerform">
									<table id="careertable" width="100%" border="0" cellpadding="0" cellspacing="0">
									<colgroup>
										<col width="" />
										<col width="100" />
										<col width="200" />
										<col width="180" />
									</colgroup>
									<%
										if(career != null && career.getRow() > 0) {
											while(career.next()){
									%>
									<tr valign="top" height="26">
										<td align="center">
											<input type="text" name="p_compnm" value="<%=career.getString("COMPNM") %>" style="width:120px;">
										</td>
										<td align="center">
											<input type="text" name="p_jikwi" value="<%=career.getString("JIKWI") %>" style="width:80px;">
										</td>
										<td>
											<input type="text" name="p_compstartdt" maxlength="8" value="<%=career.getString("COMPSTARTDT") %>" style="width:85px;"> -
											<input type="text" name="p_compenddt" maxlength="8" value="<%=career.getString("COMPENDDT") %>" style="width:85px;">
										</td>
										<td>
											<input type="text" name="p_work" value="<%=career.getString("WORK") %>" style="width:180px;">
										</td>
									</tr>
									<%		}
										} else {
									%>
									<tr valign="top" height="26">
										<td align="center">
											<input type="text" name="p_compnm" value="" style="width:120px;">
										</td>
										<td align="center">
											<input type="text" name="p_jikwi" value="" style="width:80px;">
										</td>
										<td>
											<input type="text" name="p_compstartdt" maxlength="8" value="" style="width:85px;"> -
											<input type="text" name="p_compenddt" maxlength="8" value="" style="width:85px;">
										</td>
										<td>
											<input type="text" name="p_work" value="" style="width:180px;">
										</td>
									</tr>
									<% } %>
									</table>
								</div>
								<div id="career">
								</div>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 지원분야 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_teacher_label04.gif"></td>
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
							<col width="15" />
							<col width="80" />
							<col width="" />
						</colgroup>
						<tr valign="top" height="30">
							<td align="center" style="padding-top:10px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:9px;"><img src="/images/common/txt_first_field.gif"></td>
							<td style="padding-top:5px;">
								<input type="checkbox" name="p_part" value="Y" style="border:none;" <% if("Y".equals(part[0])) {%> checked="checked" <% } %>> 무역실무&nbsp;&nbsp;
								<input type="checkbox" name="p_part" value="Y" style="border:none;" <% if("Y".equals(part[1])) {%> checked="checked" <% } %>> 국제마케팅&nbsp;&nbsp;
								<input type="checkbox" name="p_part" value="Y" style="border:none;" <% if("Y".equals(part[2])) {%> checked="checked" <% } %>> 외환금융&nbsp;&nbsp;
								<input type="checkbox" name="p_part" value="Y" style="border:none;" <% if("Y".equals(part[3])) {%> checked="checked" <% } %>> 외국어
							</td>
						</tr>
						<tr><td height="5"></td></tr>
						<tr valign="top" height="26">
							<td align="center" style="padding-top:5px;"><img src="/images/common/bullet_dot_cyan.gif"></td>
							<td style="padding-top:4px;"><img src="/images/common/txt_subject_name.gif"></td>
							<td>
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<colgroup>
									<col width="40" />
									<col width="" />
								</colgroup>
								<tr height="26">
									<td style="font-weight:bold;">1순위</td>
									<td>
										<input type="text" name="p_detailpart1" value="<%=v_detailpart1 %>" style="width:457px;">
									</td>
								</tr>
								<tr height="26">
									<td style="font-weight:bold;">2순위</td>
									<td>
										<input type="text" name="p_detailpart2" value="<%=v_detailpart2 %>" style="width:457px;">
									</td>
								</tr>
								<tr height="26">
									<td style="font-weight:bold;">3순위</td>
									<td>
										<input type="text" name="p_detailpart3" value="<%=v_detailpart3 %>" style="width:457px;">
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

				<!-- 강의경력 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_teacher_label05.gif">&nbsp;&nbsp;<span style="color: red;font-size: 12px">※모든항목을 입력하지 않으면 해당 라인은 저장되지 않습니다</span></td>
							<td align="right" valign="bottom">
								<% if("".equals(v_korname)) { %>
								<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<a href="#none" onclick="fnModifyForm('lecture','add');"><img src="/images/common/btn_popup_icon_insert.gif"></a></td>
									<td style="padding-left:1px;">
										<a href="#none" onclick="fnModifyForm('lecture','del');"><img src="/images/common/btn_popup_icon_delete.gif"></a></td>
								</tr>
								</table>
								<% } %>
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
							<col width="195" />
							<col width="" />
							<col width="200" />
						</colgroup>
						<tr height="30">
							<td align="center"><img src="/images/common/txt_lecture_work_date.gif"></td>
							<td align="center"><img src="/images/common/txt_lecture_subject.gif"></td>
							<td align="center"><img src="/images/common/txt_sosok.gif"></td>
						</tr>
						<tr><td height="1" colspan="3" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
						<tr valign="top" height="26">
							<td colspan="3">
								<div id="lectureform">
									<table id="lecturetable" width="100%" border="0" cellpadding="0" cellspacing="0">
									<colgroup>
										<col width="195" />
										<col width="" />
										<col width="200" />
									</colgroup>
									<%
										if(lCareer != null && lCareer.getRow() > 0) {
											while(lCareer.next()){
									%>
									<tr valign="top" height="26">
										<td>
											<input type="text" name="p_lecturestartdt" maxlength="8" value="<%=lCareer.getString("LECTURESTARTDT") %>" style="width:90px;"> -
											<input type="text" name="p_lectureenddt" maxlength="8" value="<%=lCareer.getString("LECTUREENDDT") %>" style="width:90px;">
										</td>
										<td align="center">
											<input type="text" name="p_lecturepart" value="<%=lCareer.getString("LECTUREPART") %>" style="width:180px;">
										</td>
										<td>
											<input type="text" name="p_agency" value="<%=lCareer.getString("AGENCY") %>" style="width:200px;">
										</td>
									</tr>
									<%
											}
										} else {
									%>
									<tr valign="top" height="26">
										<td>
											<input type="text" name="p_lecturestartdt" maxlength="8" value="" style="width:90px;"> -
											<input type="text" name="p_lectureenddt" maxlength="8" value="" style="width:90px;">
										</td>
										<td align="center">
											<input type="text" name="p_lecturepart" value="" style="width:180px;">
										</td>
										<td>
											<input type="text" name="p_agency" value="" style="width:200px;">
										</td>
									</tr>
									<% } %>
									</table>
								</div>
								<div id="lecture">
								</div>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>

				<!-- 저서 -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:20px;">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/common/popup_teacher_label06.gif">&nbsp;&nbsp;<span style="color: red;font-size: 12px">※모든항목을 입력하지 않으면 해당 라인은 저장되지 않습니다</span></td>
							<td align="right" valign="bottom">
								<% if("".equals(v_korname)) { %>
								<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<a href="#none" onclick="fnModifyForm('book','add');"><img src="/images/common/btn_popup_icon_insert.gif"></a></td>
									<td style="padding-left:1px;">
										<a href="#none" onclick="fnModifyForm('book','del');"><img src="/images/common/btn_popup_icon_delete.gif"></a></td>
								</tr>
								</table>
								<% } %>
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
							<col width="180" />
							<col width="90" />
							<col width="200" />
						</colgroup>
						<tr height="30">
							<td align="center"><img src="/images/common/txt_bookname.gif"></td>
							<td align="center"><img src="/images/common/txt_balhaeng_date.gif"></td>
							<td align="center"><img src="/images/common/txt_balhaeng.gif"></td>
						</tr>
						<tr><td height="1" colspan="3" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
						<tr valign="top" height="26">
							<td colspan="3">
							<div id="bookform">
								<table id="booktable" width="100%" border="0" cellpadding="0" cellspacing="0">
								<colgroup>
									<col width="" />
									<col width="210" />
									<col width="200" />
								</colgroup>
								<%
									if(book != null && book.getRow() > 0) {
										while(book.next()){
								%>
								<tr valign="top" height="26">
									<td>
										<input type="text" name="p_booknm" value="<%=book.getString("BOOKNM") %>" style="width:180px;">
									</td>
									<td align="center">
										<input type="text" name="p_publishdt" maxlength="8" value="<%=book.getString("PUBLISHDT") %>" style="width:90px;">
									</td>
									<td>
										<input type="text" name="p_publishcompnm" value="<%=book.getString("PUBLISHCOMPNM") %>" style="width:200px;">
									</td>
								</tr>
								<%
										}
									} else {
								%>
								<tr valign="top" height="26">
									<td>
										<input type="text" name="p_booknm" value="" style="width:180px;">
									</td>
									<td align="center">
										<input type="text" name="p_publishdt" maxlength="8" value="" style="width:90px;">
									</td>
									<td>
										<input type="text" name="p_publishcompnm" value="" style="width:200px;">
									</td>
								</tr>
								<% } %>
								</table>
							</div>
							<div id="book">
							</div>
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
							<td><img src="/images/common/popup_teacher_label07.gif">&nbsp;&nbsp;<span style="color: red;font-size: 12px">※모든항목을 입력하지 않으면 해당 라인은 저장되지 않습니다</span></td>
							<td align="right" valign="bottom">
								<% if("".equals(v_korname)) { %>
								<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<a href="#none" onclick="fnModifyForm('license','add');"><img src="/images/common/btn_popup_icon_insert.gif"></a></td>
									<td style="padding-left:1px;">
										<a href="#none" onclick="fnModifyForm('license','del');"><img src="/images/common/btn_popup_icon_delete.gif"></a></td>
								</tr>
								</table>
								<% } %>
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
							<col width="180" />
							<col width="90" />
							<col width="200" />
						</colgroup>
						<tr height="30">
							<td align="center"><img src="/images/common/txt_license.gif"></td>
							<td align="center"><img src="/images/common/txt_get_date.gif"></td>
							<td align="center"><img src="/images/common/txt_jukwan_gikwan.gif"></td>
						</tr>
						<tr><td height="1" colspan="3" bgcolor="#c7c7c7"></td></tr>
						<tr><td height="10"></td></tr>
						<tr valign="top" height="26">
							<td colspan="3">
								<div id="licenseform">
									<table id="licensetable" width="100%" border="0" cellpadding="0" cellspacing="0">
										<colgroup>
											<col width="" />
											<col width="210" />
											<col width="200" />
										</colgroup>
										<%
											if(license != null && license.getRow() > 0) {
												while(license.next()){
										%>
										<tr valign="top" height="26">
											<td>
												<input type="text" name="p_licensenm" value="<%=license.getString("LICENSENM") %>" style="width:180px;">
											</td>
											<td align="center">
												<input type="text" name="p_getdate" maxlength="8" value="<%=license.getString("GETDATE") %>" style="width:90px;">
											</td>
											<td>
												<input type="text" name="p_issueorgan" value="<%=license.getString("ISSUEORGAN")%>" style="width:200px;">
											</td>
										</tr>
										<%
												}
											} else {
										%>
										<tr valign="top" height="26">
											<td>
												<input type="text" name="p_licensenm" value="" style="width:180px;">
											</td>
											<td align="center">
												<input type="text" name="p_getdate" maxlength="8" value="" style="width:90px;">
											</td>
											<td>
												<input type="text" name="p_issueorgan" value="" style="width:200px;">
											</td>
										</tr>
										<% } %>
									</table>
								</div>
								<div id="license">
								</div>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>
				</table>
				<% if("".equals(v_korname)) { %>
				<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:10px;">
				<tr>
					<td align="right">
						<a href="#none" onclick="fnRegist();"><img src="/images/common/btn_popup_saving.gif"></a>
						<a href="#none" onclick="self.close();"><img src="/images/common/btn_popup_cancel.gif"></a></td>
				</tr>
				</table>
				<% } %>
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