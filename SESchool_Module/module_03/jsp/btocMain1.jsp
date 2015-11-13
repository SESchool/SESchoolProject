<%@page import="jxl.write.DateTime"%>
<%@page import="java.util.Iterator"%>
<%@ page contentType="text/html;charset=UTF-8" 	%>
<%@ include file = "/jsp/front/common/commonBasicInc.jsp"	%>

<script language="Javascript" src="/js/common/banner.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script>

<link rel="stylesheet" href="/css/front/template_new/banner.css" type="text/css"/>
<link rel="stylesheet" href="/css/front/template_new/style.css" type="text/css"/>

<%
	String command = request.getParameter("command");
	if (command != null && command.equals("href")) {
		String url = request.getParameter("url");
		//out.print("<script>alert('링크된 페이지로 이동합니다.');</script>");
		out.print("<script>location.href=\"" + url + "\";</script>");
	} else if (StringUtil.isNotNull(command) && command.equals("logimaster")) {
		System.out.println("command2 : " + command);
	%>
		<script>
		location.href = '/front/SubjSeqF.do?cmd=compSubjSeqMain&p_upperclass=G000&p_middleclass=G001&p_lowerclass=G101&next=compSubjSeqMainLogiMaster&p_isapply=Y&p_contentid=143&p_outmenuid=628';
		</script>
	<%
	} else if (command != null && command.length() != 0) {
		out.print("<script>" + command + ";</script>");
		//out.print("<script>alert('링크된 페이지로 이동합니다.');</script>");
	}
%>
<%
	//팝업 공지사항을 가져온다.
	DataSet dsPopNotiList = (DataSet)box.getObject("dsPopNotiList");

	//공지사항 리스트를 가져온다.
	DataSet noticeList = (DataSet)box.getObject("NoticeList");
	
	String V_MAINFLASH = box.getStringDefault("s_mainrandomflash","0");
	String v_comp = box.getString("p_comp");
%>
<!-- 팝업 공지사항 -->
<script type="text/javascript">
addLoadEvent(doPopNotice); //onload함수에 추가

function pupupKitaCourse(){
	var url = "http://www.kita.net/tams/sub01/list.jsp?course_type=CO1";
	window.open(url); 
}
function doPopNotice() {
<%
if ( dsPopNotiList != null ) {
	String v_hgrcode = null;
	String v_seq = null;
	String v_width = null;
	String v_height = null;
	String v_popuptype = null;
	String v_title = null;
	String v_content = null;
	String v_inusernm = null;
	String v_indate = null;
	String v_left = null;
	String v_top = null;
	while ( dsPopNotiList.next() ) {
		v_hgrcode = dsPopNotiList.getString("HGRCODE");
		v_seq = dsPopNotiList.getString("SEQ");
		v_width = dsPopNotiList.getString("WIDTH");
		v_height = dsPopNotiList.getString("HEIGHT");
		v_popuptype = dsPopNotiList.getString("POPUPTYPE");
		v_title = dsPopNotiList.getString("TITLE");
		v_content = dsPopNotiList.getString("CONTENT");
		v_inusernm = dsPopNotiList.getString("INUSERNM");
		v_indate = dsPopNotiList.getString("INDATE");
		v_left = dsPopNotiList.getString("LEFT");
		v_top = dsPopNotiList.getString("TOP");
		
		// 팝업창공지사항
		if(v_popuptype.equals("A")){
%>
if ( getCookie("popnotice_<%=v_hgrcode%>_<%=v_seq%>") == null ) {
	
	Center_Fixed_Popup2("/front/PopNotice.do?cmd=popNoticePopup&p_hgrcode=<%=v_hgrcode%>&p_seq=<%=v_seq%>", "PopNotice<%=v_hgrcode%><%=v_seq%>", parseInt(<%=v_width%>), parseInt(<%=v_height%>), "yes");
}
<%
		// 레이어공지사항
		}else if(v_popuptype.equals("B")){
%>
if ( getCookie("popnotice_<%=v_hgrcode%>_<%=v_seq%>") == null ) {
document.getElementById("layerPopupBox").innerHTML +=
	'<Div id="popnotice_<%=v_hgrcode%>_<%=v_seq%>" style="border:1px solid #cccccc;position:absolute; left:<%=v_left%>px; top:<%=v_top%>px; z-index:0;display:;">'+
	'<table width="<%=v_width %>" height="100%" cellpadding="0" cellspacing="0">'+
	'<tr>'+
	'	<td align="center" height="100%" valign="top">'+
	'		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="FFFFFF">'+
	'		<tr>'+
	'			<td height="42" background="/images/common/popup_header_bg.gif">'+
	'				<table width="100%" border="0" cellpadding="0" cellspacing="0" ondrag="layer_move(\'popnotice_<%=v_hgrcode%>_<%=v_seq%>\', event);">'+
	'				<colgroup>'+
	'					<col width="69" />'+
	//'					<col width="" />'+
	'					<col width="10" />'+
	'				</colgroup>'+
	'				<tr>'+
	'					<td><img src="/images/common/popup_notice_title.gif"></td>'+
	//'					<td align="right" style="color: #ffffff; font-size: 11px;">작성자 : <%=v_inusernm %>   작성일 : <%=v_indate %></td>'+
	'					<td></td>'+
	'				</tr>'+
	'				</table>'+
	'			</td>'+
	'		</tr>'+
	'		<tr>'+
	'			<td height="100%" valign="top" align="center" style="padding:15px;">'+
	
	'				<table width="100%" border="0" cellpadding="0" cellspacing="0">'+
	'				<colgroup>'+
	'					<col width="15" />'+
	'					<col width="" />'+
	'				</colgroup>'+
	'				<tr>'+
	'					<td align="left"><img src="/images/common/bullet_label_green.gif"></td>'+
	'					<td align="left"><%=v_title%></td>'+
	'				</tr>'+
	'				</table>'+
	
	'				<table width="100%" cellpadding="0" cellspacing="0">'+
	'				<tr><td height="0"></td></tr>'+
	'				<tr><td height="0" bgcolor="#c7c7c7"></td></tr>'+
	'				<tr>'+
	'					<td bgcolor="#f4f4f4" style="padding:0px 0px 0px 0px;">'+
	'						<table width="100%" cellpadding="0" cellspacing="0">'+
	'						<tr>'+
	'							<td style="border: solid 1px #ececec; padding:0px; line-height:0px; font-size:11px; background-color:#FFFFFF;" height="100%" valign="top">'+
	'								<%=StringUtil.ReplaceAll(v_content,"\r\n","")%>'+
	'							</td>'+
	'						</tr>'+
	'						<tr><td height="0"></td></tr>'+
	'						'+
	'						</table>'+
	'					</td>'+
	'				</tr>'+
	'				<tr><td height="1" bgcolor="#c7c7c7"></td></tr>'+
	'				</table>'+
	'			</td>'+
	'		</tr>'+
	'		<tr>'+
	'			<td height="25" background="/images/common/popup_footer_bg.gif" style="padding-left:20px; padding-right:20px;">'+
	'				<table width="100%" cellpadding="0" cellspacing="0">'+
	'				<tr>'+
	'					<td align="left"><a href="#none" onclick="javascript:setPopNoticeCookie(\'popnotice_<%=v_hgrcode%>_<%=v_seq%>\');"><input type="checkbox" name="" value="" style="border:none;"><img src="/images/common/popup_footer_today.gif"></a></td>'+
	'					<td align="right">'+
	'						<a href="#none" onclick="document.getElementById(\'popnotice_<%=v_hgrcode%>_<%=v_seq%>\').style.display=\'none\'"><img src="/images/common/btn_popup_close.gif"></a></td>'+
	'				</tr>'+
	'				</table>'+
	'			</td>'+
	'		</tr>'+
	'		</table>'+
	'	</td>'+
	'</tr>'+
	'</table>'+
	'</div>';
}
<%
		}
	}
}
%>
}

function setPopNoticeCookie(name) {
	setCookie( name, "done" , 1);
	document.getElementById(name).style.display="none";
}

function publicityRoom(){
	Center_Fixed_Popup2("/front/RightTestMenagement.do?cmd=publicityRoom", "publicityRoomPopup", 1040, 837, "yes");
}

// 모집과정 (집합) 팝업
function popoffCourse(comp){
	Center_Fixed_Popup2("/front/Main.do?cmd=popOffCourse&p_comp=" + comp, "popOffCourse", 780, 837, "yes");
}

//news의 이미지 목록을 저장하는 배열
//var newsImageArray = ["/images/home0/main/example-slide-1.jpg", "/images/home0/main/example-slide-2.jpg", "/images/home0/main/example-slide-3.jpg","/images/home0/main/example-slide-4.jpg"];

//news의 이미지에 커서가 올라갔을 때의 목록을 저장하는 배열
//var newsOnTheCursurImageArray = ["/images/home0/main/example-slide-1_black.jpg", "/images/home0/main/example-slide-2_black.jpg", "/images/home0/main/example-slide-3_black.jpg","/images/home0/main/example-slide-4_black.jpg"];


// NEWS의 이미지 클릭시 이미지를 메인 이미지 변경
function changeNewsMainImage(index){
	//var picArray = document.getElementsByName("pic_name");
	
	// 메인 이미지를 변경
	document.newsMainImage.src = newsImageArray[index];
	
	var element = document.getElementById("selectedbox");
	//element.style.borderTop = "8px solid #0000ff";
	//element.style.top = 
	
	//var element2 = document.getElementById("newsbox.nextnews");
	//element2.
}
</script>

<div class="middle_top">
<div class="middle_top_contents">

<div class="one"><a href="javascript:goMenuOff('299', '299')"><img src="/images/common/new_main/1.png"></a><br><br>단기모집과정</div>
<div class="two"><a href="javascript:goMenu('3')"><img src="/images/common/new_main/2.png"></a><br><br>E-러닝</div>
<div class="three"><a href="javascript:goMenu('170')"><img src="/images/common/new_main/3.png"></a><br><br>자격시험</div>
<div class="four"><a href="javascript:goMenu('90')"><img src="/images/common/new_main/4.png"></a><br><br>FAQ</div>
<div class="five"><a href="javascript:goMenu('6')"><img src="/images/common/new_main/5.png"></a><br><br>물류최고경영자과정</div>
<div class="six"><a href="javascript:goMenu('523', '523')"><img src="/images/common/new_main/6.png"></a><br><br>지부연수</div>
<div class="seven"><a href="javascript:goMenu('627')"><img src="/images/common/new_main/7.png"></a><br><br>체험학습</div>
<div class="eight" style="letter-spacing:-1px;"><a href="javascript:goMenu('477')"><img src="/images/common/new_main/8.png"></a><br><br>섬유수출전문가소재과정</div>

<!-- <div class="mask"><img src="/images/common/new_main/banner_mask.png" alt="" /></div> -->

<div id="banner"></div>
  
</div>
</div>


<div class="middle_middle">

<div class="middle_middle_contents">
<div class="middle_middle_contents_left">
<div class="left_title"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;공지사항</div>
<div class="left_tablee">

<table cellspacing=0 cellpadding=0 border=0 width="335" height="97">
<%
	if(noticeList != null && noticeList.getRow() > 0){
		while(noticeList.next()){
%>
<tr>
	<td height="26" align="left" width="257" >
		<a class="notice" id="link" href="#" onClick="goMenuUrl('91','/front/BbsBoard.do?cmd=bbsBoardShowForm2&p_boardid2=<%=noticeList.getString("BOARDID") %>&p_seq=<%=noticeList.getString("SEQ") %>&p_boardid=2')"><%=StringUtil.cropByte(noticeList.getString("TITLE"), 25) %></a>
		<%if(noticeList.getString("NEWTERMYN").equals("Y")){ %>
			&nbsp;<img src="/images/home0/main/main_box_brown_new.gif"
			alt="NEW"> 
		<%}%>
	</td>
	<td class="bbstitle_day3">
		<%=DateTimeUtil.getDateType(1, noticeList.getString("INDATE")) %>
	</td>
</tr>
<% 		}//while 
	} else {  %>
<tr>
	<td class="notice" height="24">등록된 내용이 없습니다.</td>
</tr>
<%	}//else %>
</table>

</div>
</div>

<div class="line_3"></div>

<div class="middle_middle_contents_right">
<div class="right_title"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;빠른서비스</div>
<div class="right_tablee">

<div class="service1"><a href="http://webdocu.kita.net" target="_blank"><img src="/images/common/new_main/s1.png" align="center"></a><br><br>증명서 발급</div>

<div class="service2"><a href="javascript:goMenu('36')"><img src="/images/common/new_main/s2.png" align="center"></a><br><br>M-러닝</div>

<div class="service3"><a href="javascript:goMenu('223')"><img src="/images/common/new_main/s3.png" align="center"></a><br><br>인재추천</div>

<div class="service4"><a href="javascript:goMenu('87')"><img src="/images/common/new_main/s4.png" align="center"></a><br><br>교수초빙</div>

<div class="service5"><a href="http://edu.tradecampus.com/upload/eBrochure/WTAeBrochure.pdf" target="_blank"><img src="/images/common/new_main/s5.png" align="center"></a><br><br>브로셔</div>

<div class="service6"><a href="javascript:goMenu('300')"><img src="/images/common/new_main/s6.png" align="center"></a><br><br>교육일정</div>
</div>

</div>

</div>

</div>

<div class="middle_bottom">

<div class="middle_bottom_contents">
<div class="middle_bottom_contents1"><a href="javascript:goMenu('6')"><img src="/images/common/new_main/1glmp.png"></a></div>
<div class="middle_bottom_contents2"><a href="javascript:goMenu('5')"><img src="/images/common/new_main/2smartcloud.png"></a></div>
<div class="middle_bottom_contents3"><a href="javascript:goMenu('4')"><img src="/images/common/new_main/3trade.png"></a></div>
<div class="middle_bottom_contents4"><a href="javascript:goMenu('646')"><img src="/images/common/new_main/4car.png"></a></div>
</div>

</div>
