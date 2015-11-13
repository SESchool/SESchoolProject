<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sinc.common.FileDTO" %>
<%@ page import="com.sinc.common.CodeParamDTO" %>
<%@ include file = "/jsp/back/common/commonInc.jsp" %>
<%@ page import="org.apache.commons.configuration.Configuration" %>
<%@ page import="com.sinc.framework.configuration.ConfigurationFactory" %>
<%@ page import ="java.io.File"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<%
String	lvOrder1[]			=	{"GUBUN ASC, GUBUNNM ASC",
								"GUBUNNM ASC, GUBUN ASC"};

// 리스트 화면에서 넘겨받을 인자값
String v_pageno   	= StringUtil.nvl(box.getString("l_pageno"),"1");
String v_listscale	= StringUtil.nvl(box.getString("l_listscale"),"1000");
String v_sortorder	= StringUtil.nvl(box.getString("l_sortorder"),lvOrder1[0]);

String l_lecturefield   = StringUtil.nvl(box.getString("l_lecturefield"),"");
String l_infieldtxt   	= StringUtil.nvl(box.getString("l_infieldtxt"),"");
String l_name   		= StringUtil.nvl(box.getString("l_name"),"");
String l_inuserid   	= StringUtil.nvl(box.getString("l_inuserid"),"");

%>
<%
	// 리스트 화면에서 넘겨받을 인자값
    String v_process = box.getString("p_process");	// 등록,수정 구분자

    // 상세정보 가져온다.
	Box offlinetutorInfo = (Box)box.getObject("offlinetutorInfo");
    if(offlinetutorInfo == null) offlinetutorInfo = new Box("offlinetutorInfo");

	// 이미지 경로
    String v_photo			= offlinetutorInfo.getString("PHOTO");
  	File file = null;
  	String photoPath = null;
	file = new File(FileUtil.UPLOAD_PATH+"/lms/offlinetutor/"+v_photo);
	if(file.isFile()){
		photoPath = "/lms/offlinetutor/".concat(v_photo);
	}
	else{
		photoPath = "/images/back/common/sample_photo.gif";
	}


    String v_gadmin = box.getString("s_gadmin");
    String v_fgadmin = "";
    if(!v_gadmin.equals("H1") && v_gadmin.substring(0,1).equals("H")) v_fgadmin = v_gadmin.substring(0,3);

	Configuration configuration = ConfigurationFactory.getInstance().getConfiguration();
	int MAX_POST_SIZE 		= configuration.getInt("framework.subjseq.fileupload.max_post_size");
%>

<fmtag:csscommon point="back" />
<fmtag:jscommon />
<fmtag:dwrcommon interfaceName="CommonUtilWork"/>
<script type="text/javascript" src="/js/common/fileupload.js"></script>
<script language="javascript">
	//파일다운로드
	function fileDownload(rfileName, sfileName, filePath) {
	  var loc = "/fileDownServlet?rFileName="+toUTF8(rfileName)+"&sFileName="+sfileName+"&filePath="+filePath;
	  location.href = loc;
	  hiddenFrame.location.href = loc;
	}

	function viewPicture(){
	    var f = document.form1;
		if(f.f_photo.value == "") return;

		var picObj = document.getElementById("picture");
		picObj.src = f.f_photo.value;
	}

	// 저장버튼
    function offlinetutorWrite(pProcess){
    	var f = document.form1;
        if(!validate(f)) return;

    	// 강의분야 널 체크
    	var isTrue = false;
		for(i=0; i<f.p_lecturefield.length;i++){
			// 체크
			if(f.p_lecturefield[i].checked==true){
		    	//alert(f.p_lecturefield[i].value);
		    	isTrue = true;
			}
		}
		if(!isTrue){
			alert("강의분야를 선택하세요.");
			return false;
		}


		f.action 			= "/back/Offlinetutor.do?cmd=offlinetutorWrite&p_maxfilesize=" + f.p_maxfilesize.value;
	    f.p_process.value	= pProcess;
	   	f.submit();
    }

	// 취소버튼
	function offlinetutorList(){
	    var f = document.form1;

	    f.method = "get";
	    f.encoding	= "application/x-www-form-urlencoded";
	    f.cmd.value="offlinetutorList";
	    f.submit();
	}

	// 삭제버튼
	function offlinetutorDelete(){
   	    var f = document.form1;

	    if(!confirm("현재 튜터를 삭제하시겠습니까?")) return;
	    f.encoding	= "application/x-www-form-urlencoded";	// 폼 기본형태로 변경
	    f.cmd.value="offlinetutorDelete";
	    f.submit();
	}

	// 첨부파일 삭제
	function oldFileDel(delseq){
    	var oldFile = document.getElementById("OldFile");
    	var f = document.form1;
    	oldFile.style.display = "none";
    	oldFile.value = "";
    	f.p_datafiledel.value = delseq;

    }

	// 이미지파일 삭제
	function oldFileImgDel(delseq){
    	var oldFileImg = document.getElementById("OldFile2");
    	var f = document.form1;
    	oldFileImg.style.display = "none";
    	oldFileImg.value = "";
    	f.p_photodel.value = delseq;

    }

	function useridCheck(){
	    var f = document.form1;

	    var userid = f.p_userid.value;
	     if(userid.length < 1){
	        alert("아이디를 입력해 주십시요");
	        return;
	     }

	     if(f.p_comp.value == ""){
	           alert("회사를 선택해 주십시요");
	           return;
	     }

	     var param = {p_userid:f.p_userid.value,p_comp:f.p_comp.value};
	     MemberWork.useridCheckCallBack(param, useridCheckCallBack);
	}

	function useridCheckCallBack(check){
	   var f = document.form1;
	   if(parseInt(check) < 1){
	       alert("사용가능한 아이디입니다.");
	       f.checkUserid.value = "Y";
	   }else{
	       alert("이미 사용중인 아이디입니다.");
	       f.checkUserid.value = "N";
	       f.p_userid.value = "";
	       f.p_userid.focus();
	   }
	}

	function selectComp(){
  	    var f = document.form1;
        var v_comp = f.p_comp.value;

        var param = {p_comp:v_comp,dwrYn:"Y"};
        CommonUtilWork.getBusinessPlc(param,getBusinessPlcCallBack);
        CommonUtilWork.getJikmu(param,getJikmuCallBack);
        CommonUtilWork.getJikchek(param,getJikchekCallBack);
        CommonUtilWork.getJikup(param,getJikupCallBack);
	}

	function getBusinessPlcCallBack(list){
		selectbox_insertlist("p_businessplc", list);
	}

	function getJikmuCallBack(list){
		selectbox_insertlist("p_jikmu", list);
	}

	function getJikchekCallBack(list){
		selectbox_insertlist("p_jikchek", list);
	}

	function getJikupCallBack(list){
		selectbox_insertlist("p_jikup", list);
	}

	function searchOrgan(){
        var f = document.form1;
        var url = "/back/Organ.do?cmd=organSearch&p_parentorgcode=000000&comp_code="+f.p_comp.value;
	    Center_Fixed_Popup2(url, "SearchOrgan", 640, 520, "no");
	}

	function setOrgInfo(orgcd, orgnm){
        var f = document.form1;
        f.p_deptcod.value = orgcd;
        f.p_deptnam.value = orgnm;
	}

	//시스템체크박스 액션
	function setGlobalObj(val)
	{
		/*
		var f = document.form1;
		if(val=='04') //글로벌이라면
		{
			for(i=0; i<f.p_lecturefield.length;i++)
			{
				if(f.p_lecturefield[i].checked==true && f.p_lecturefield[i].value=='04')
				{
					f.p_globalobj[0].disabled = false;
					f.p_globalobj[1].disabled = false;
				}
				else if (f.p_lecturefield[i].checked==false && f.p_lecturefield[i].value=='04')
				{
					f.p_globalobj[0].checked=false;
					f.p_globalobj[1].checked=false;
					f.p_globalobj[0].disabled = true;
					f.p_globalobj[1].disabled = true;
				}
			}
		}
		*/
	}

	function searchZipCode(objname) {
		var url = "/front/Common.do?cmd=selectZipCode&p_objname="+objname; 
		Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
	}
	function setZipCodeInfo(objname, addr, zipcode) {
		var form = document.form1;

	    if ( objname == "home" ) {
			form.p_address.value = addr;			
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


</script>
</head>

<body>
<form name="form1" action="/back/Offlinetutor.do" method="post" onSubmit="return false;" enctype="multipart/form-data">
<input type="hidden" name="cmd"				value="offlinetutorWrite">
<input type="hidden" name="l_pageno" 		value="<%=v_pageno%>">
<input type="hidden" name="l_sortorder"		value="<%=v_sortorder%>">

<input type="hidden" name="l_lecturefield"	value="<%=l_lecturefield%>">
<input type="hidden" name="l_infieldtxt"	value="<%=l_infieldtxt%>">
<input type="hidden" name="l_name"			value="<%=l_name%>">
<input type="hidden" name="l_inuserid"		value="<%=l_inuserid%>">


<input type="hidden" name="p_process" 		value="<%=v_process %>">
<input type="hidden" name="p_inuserid"		value="<%=box.getString("s_userid") %>">
<input type="hidden" name="p_tutorno"		value="<%=box.getString("p_tutorno") %>">
<input type="hidden" name="p_maxfilesize"	value="<%=MAX_POST_SIZE%>">
<input type="hidden" name="p_datafile"		value="<%=offlinetutorInfo.getString("DATAFILE")%>">
<input type="hidden" name="p_photo"			value="<%=offlinetutorInfo.getString("PHOTO")%>">
<input type="hidden" name="p_datafiledel"	value="">
<input type="hidden" name="p_photodel"		value="">
<input type="hidden" name="p_datafileOld"	value="<%=offlinetutorInfo.getString("REALDATAFILE")%>">
<input type="hidden" name="p_photoOld"		value="<%=offlinetutorInfo.getString("PHOTO")%>">
<input type="hidden" name="p_realdatafile"	value="<%=offlinetutorInfo.getString("REALDATAFILE")%>">


<table width="100%" cellpadding="0" cellspacing="0">
<tr>
	<td class="pad_left_15">

     <!-- 메뉴명 -->
	<table width="985" cellpadding="0" cellspacing="0" class="mar_top_20">
	<colgroup>
		<col width="10" />
		<col width="" />
		<col width="15" />
	</colgroup>
	<tr>
		<td><img src="/images/back/common/bullet_title.gif"></td>
		<td class="t_title"><%=s_menunavi %></td>
		<td align="right" valign="bottom"></td>
	</tr>
	</table>
	<!-- // -->

       <!-- 입력폼 -->
		<div class="board-view">
			<table width="985" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="205" />
				<col width="50" />
				<col width="150" />
				<col width="215" />
				<col width="150" />
				<col width="215" />
			</colgroup>
			<tr>
				<th class="th_top_bd01" style="background-color: white;" rowspan="5">
				<img id="picture" src="<%=photoPath %>" width="120" height="150">
				</th>
				<th class="th_top_bd01" rowspan="5">개인<br>정보</th>
				<th class="th_top_bd01">튜터명</th>
				<td class="td_top_bd">
					<input type="text" name="p_name" dispName="튜터명" isNull="N" lenCheck="20" value="<%=offlinetutorInfo.getString("NAME")%>" style="width:80px; height:18px;">
				</td>
				<th class="th_top_bd01">출생년도</th>
				<td class="td_top_bd">
					<input type="text" name="p_birthyear" dispName="출생년도" dataType="number" lenCheck="4" isNull="Y" maxlength="4" value="<%=offlinetutorInfo.getString("BIRTHYEAR")%>" style="width:80px; height:18px;">년
				</td>
			</tr>
			<tr>
				<th class="th_left_bd">직업/소속</th>
				<td colspan="3">
					<textarea name="p_jobplace" dispName="직업/소속" lenCheck="1000" style="border:solid 1px #DDDDDD; width:500px; height:60px;"><%=offlinetutorInfo.getString("JOBPLACE")%></textarea>
				</td>
			</tr>
			<tr>
				<th class="th_left_bd">사무실전화</th>
				<td>
	                <%
	                  String v_comtel = offlinetutorInfo.getString("COMTEL");
	                  String[] v_comtelInfo = new String[]{"","",""};
	                  if(!v_comtel.equals("")){
	                      String[] v_comtelInfo2 = StringUtil.split(v_comtel,"-");
	                      System.arraycopy(v_comtelInfo2, 0, v_comtelInfo, 0, v_comtelInfo2.length);
	                  }
	                %>
					<input type="text" name="p_comtel1" dispName="사무실전화번호" isNull="Y"  dataType="number" lenCheck="4" maxlength="4" value="<%=v_comtelInfo[0] %>" maxlength="4" style="width:50px; height:18px;">-
					<input type="text" name="p_comtel2" dispName="사무실전화번호" isNull="Y"  dataType="number" lenCheck="4" maxlength="4" value="<%=v_comtelInfo[1] %>" maxlength="4" style="width:50px; height:18px;">-
					<input type="text" name="p_comtel3" dispName="사무실전화번호" isNull="Y"  dataType="number" lenCheck="4" maxlength="4" value="<%=v_comtelInfo[2] %>" maxlength="4" style="width:50px; height:18px;">
				</td>
				<th class="th_left_bd">휴대폰</th>
				<td>
	                <%
	                  String v_handphone = offlinetutorInfo.getString("HANDPHONE");
	                  String[] v_handphoneInfo = new String[]{"","",""};
	                  if(!v_handphone.equals("")){
	                      String[] v_handphoneInfo2 = StringUtil.split(v_handphone,"-");
	                      System.arraycopy(v_handphoneInfo2, 0, v_handphoneInfo, 0, v_handphoneInfo2.length);
	                  }
	                %>
					<input type="text" name="p_handphone1" dispName="휴대폰" isNull="Y"  dataType="number" value="<%=v_handphoneInfo[0] %>" maxlength="4" style="width:50px; height:18px;">-
					<input type="text" name="p_handphone2" dispName="휴대폰" isNull="Y"  dataType="number" value="<%=v_handphoneInfo[1] %>" maxlength="4" style="width:50px; height:18px;">-
					<input type="text" name="p_handphone3" dispName="휴대폰" isNull="Y"  dataType="number" value="<%=v_handphoneInfo[2] %>" maxlength="4" style="width:50px; height:18px;">
				</td>
			</tr>
			<tr>
				<th class="th_left_bd">E-Mail</th>
				<td colspan="3">
					<input type="text" name="p_email" dispName="E-Mail" dataType="email" value="<%=offlinetutorInfo.getString("EMAIL")%>" style="width:500px; height:18px;">
				</td>
			</tr>
			<tr>
				<th class="th_left_bd">주소</th>
				<td colspan="3">
					<% if( offlinetutorInfo.getString("POST2") == null || offlinetutorInfo.getString("POST2").equals("") ){ %>
						<input type="text" name="p_post1" dispName="우편번호" dataType="integer" lenCheck="5" maxlength="5" isNull="Y" value="<%=offlinetutorInfo.getString("POST1")%>" style="width:50px; height:18px;" readonly="readonly">
						<input type="hidden" name="p_post2" dispName="우편번호" value="<%=offlinetutorInfo.getString("POST2")%>" >
					<% } else { %>
						<input type="text" name="p_post1" dispName="우편번호" dataType="integer" maxlength="5" isNull="Y"  value="<%=offlinetutorInfo.getString("POST1")%>" style="width:50px; height:18px;" readonly="readonly"> -
						<input type="text" name="p_post2" dispName="우편번호" value="<%=offlinetutorInfo.getString("POST2")%>" style="width:50px; height:18px;" readonly="readonly">
					<% } %>
					<a href="#none" onclick="searchZipCode('home')"><img src="/images/common/btn_zipcode.gif" align="absmiddle" alt="우편번호찾기"/></a>
					<br/>
					<input type="text" name="p_address" dispName="주소" lenCheck="100" maxlength="100" isNull="Y"   value="<%=offlinetutorInfo.getString("ADDRESS")%>" style="width:500px; height:18px;">
				</td>
			</tr>
			<tr>
				<th>강의분야</th>
				<td colspan="5">
      	        <%
       			   CodeParamDTO param = new CodeParamDTO();
       			   param.setCodeCol(" UPPERCLASS AS CODE");
       			   param.setNameCol(" CLASSNAME AS CODENM");
				   param.setTableName(" T_LMS_COMATT ");
				   param.setCondStmt(" MIDDLECLASS = '0000' ");
				   param.setType("checkbox");
				   param.setName("p_lecturefield");
				   param.setEvent("setGlobalObj(this.value);");
				   param.setSelected(box.getString("p_lecturefield"));
				   param.setSelected(offlinetutorInfo.getString("LECTUREFIELD"));
	            %>
				<%=CommonUtil.getCodeListBox(param)%>
				</td>
			</tr>
			<tr>
				<th>세부강좌명</th>
				<td colspan="5">
					<input type="text" name="p_infieldtxt" dispName="세부강좌명" lenCheck="1000" maxlength="1000" isNull="Y" value="<%=offlinetutorInfo.getString("INFIELDTXT")%>" style="width:700px; height:18px;">
				</td>
			</tr>
			<tr>
				<th>특징/학력사항</th>
				<td colspan="5">
					<textarea name="p_career" dispName="특징/학력사항" lenCheck="1000" maxlength="1000" isNull="Y" style="border:solid 1px #DDDDDD; width:700px; height:50px;"><%=offlinetutorInfo.getString("CAREER")%></textarea>
				</td>
			</tr>
			<tr>
				<th>강의경력/저서</th>
				<td colspan="5">
					<textarea name="p_publish" dispName="강의경력/저서" lenCheck="1000" maxlength="1000"  style="border:solid 1px #DDDDDD; width:700px; height:50px;"><%=offlinetutorInfo.getString("PUBLISH")%></textarea>
				</td>
			</tr>
			<tr>
				<th>강의가능과목</th>
				<td colspan="5">
					<textarea name="p_lecture" dispName="강의가능과목" lenCheck="1000" maxlength="1000" style="border:solid 1px #DDDDDD; width:700px; height:50px;"><%=offlinetutorInfo.getString("LECTURE")%></textarea>
				</td>
			</tr>
			<tr>
				<th>강의평</th>
				<td colspan="5">
					<textarea name="p_review" dispName="강의평" lenCheck="1000" maxlength="1000" style="border:solid 1px #DDDDDD; width:700px; height:50px;"><%=offlinetutorInfo.getString("REVIEW")%></textarea>
				</td>
			</tr>
			<tr>
				<th>섭외방법</th>
				<td colspan="5">
					<textarea name="p_contact" dispName="섭외방법" lenCheck="1000" maxlength="1000" style="border:solid 1px #DDDDDD; width:700px; height:50px;"><%=offlinetutorInfo.getString("CONTACT")%></textarea>
				</td>
			</tr>
			<tr>
				<th>비고</th>
				<td colspan="5">
					<textarea name="p_etc" dispName="비고" lenCheck="1000" maxlength="1000" style="border:solid 1px #DDDDDD; width:700px; height:50px;"><%=offlinetutorInfo.getString("ETC")%></textarea>
				</td>
			</tr>
			<tr>
				<th>강사료</th>
				<td colspan="3">
					<input type="text" name="p_pay" dispName="강사료" dataType=""  lenCheck="20" maxlength="20" value="<%=offlinetutorInfo.getString("PAY")%>" style="width:300px; height:18px;">
				</td>
				<th>강사료기준시점</th>
				<td>
					<input type="text" name="p_basis" dispName="강사료기준시점" dataType=""  lenCheck="20" maxlength="20" value="<%=offlinetutorInfo.getString("BASIS")%>" style="width:100px; height:18px;">
				</td>
			</tr>
			<tr>
				<th>자료첨부</th>
				<td colspan="5">
					<%if(!offlinetutorInfo.getString("REALDATAFILE").equals("")){%><span id="OldFile">
					<% out.println("<a href=javascript:fileDownload('"+offlinetutorInfo.getString("REALDATAFILE")+"','"+offlinetutorInfo.getString("DATAFILE")+"','/lms/offlinetutor')>"+offlinetutorInfo.getString("REALDATAFILE")+"</a>"); %>
					&nbsp;<img src="/images/common/ico_del.gif" onClick="oldFileDel('<%=offlinetutorInfo.getString("DATAFILE") %>')" align="absmiddle"></img></span><br><% } %>
					<input type="file" name="f_datafile" value="" onChange="" style="width:700px; height:18px; background-color:#FFFFFF;">
				</td>
			</tr>
			<tr>
				<th>사진첨부</th>
				<td colspan="5">
					<%if(!offlinetutorInfo.getString("PHOTO").equals("")){%><span id="OldFile2">
					<% out.println("<a href=javascript:fileDownload('"+offlinetutorInfo.getString("PHOTO")+"','"+offlinetutorInfo.getString("PHOTO")+"','/lms/offlinetutor')>"+offlinetutorInfo.getString("PHOTO")+"</a>"); %>
					&nbsp;<img src="/images/common/ico_del.gif" onClick="oldFileImgDel('<%=offlinetutorInfo.getString("PHOTO") %>')" align="absmiddle"></img></span><br><% } %>
					<input type="file" name="f_photo" value="" onChange="" style="width:700px; height:18px; background-color:#FFFFFF;">
				</td>
			</tr>
			</table>
		</div>
	<!-- // -->

    <!-- 버튼 -->
	<table width="985" cellpadding="0" cellspacing="0" class="mar_top_10">
	<tr>
		<td align="center">
			<table cellpadding="0" cellspacing="0">
			<tr>
			  <td>
		<%
      if(s_menucontrol.equals("RW")) {
	    if(v_process.equals("E")) {
           %>
				<fmtag:button type="1" value="수 정" func="offlinetutorWrite('E')" />&nbsp;
				<fmtag:button type="1" value="삭 제" func="offlinetutorDelete()" />&nbsp;
		<%
	    } else {
           %>
				<fmtag:button type="1" value="저 장" func="offlinetutorWrite('W')" />&nbsp;
      <% }
	   } %>
				<fmtag:button type="1" value="취 소" func="offlinetutorList()" />
			  </td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
	<!-- // -->

	  <!--푸터부분 시작-->
	  <%@ include file = "/jsp/back/common/bottom.jsp"%>
	  <!--푸터부분 끝-->