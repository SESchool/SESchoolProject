<%@page import="Kisinfo.Check.IPINClient"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import ="com.sinc.framework.util.Base64" %>
<%@ include file = "/jsp/front/common/commonBasicInc.jsp" %>
<!-- i-pin 모듈 시작 -->
<%
	/********************************************************************************************************************************************
		NICE신용평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
		
		서비스명 : 가상주민번호서비스 (IPIN) 서비스
		페이지명 : 가상주민번호서비스 (IPIN) 호출 페이지
	*********************************************************************************************************************************************/
	
	String sSiteCode_ipin2				= "D002";			// IPIN 서비스 사이트 코드		(NICE신용평가정보에서 발급한 사이트코드)
	String sSitePw_ipin2					= "Kita5114";			// IPIN 서비스 사이트 패스워드	(NICE신용평가정보에서 발급한 사이트패스워드)
	
	
	/*
	┌ sReturnURL 변수에 대한 설명  ─────────────────────────────────────────────────────
		NICE신용평가정보 팝업에서 인증받은 사용자 정보를 암호화하여 귀사로 리턴합니다.
		따라서 암호화된 결과 데이타를 리턴받으실 URL 정의해 주세요.
		
		* URL 은 http 부터 입력해 주셔야하며, 외부에서도 접속이 유효한 정보여야 합니다.
		* 당사에서 배포해드린 샘플페이지 중, ipin_process.jsp 페이지가 사용자 정보를 리턴받는 예제 페이지입니다.
		
		아래는 URL 예제이며, 귀사의 서비스 도메인과 서버에 업로드 된 샘플페이지 위치에 따라 경로를 설정하시기 바랍니다.
		예 - http://www.test.co.kr/ipin_process.jsp, https://www.test.co.kr/ipin_process.jsp, https://test.co.kr/ipin_process.jsp
	└────────────────────────────────────────────────────────────────────
	*/
	String sReturnURL_ipin2				= "http://tradecampus.kita.net/jsp/front/common/member/ipin_mprocess.jsp";
	
	
	/*
	┌ sCPRequest 변수에 대한 설명  ─────────────────────────────────────────────────────
		[CP 요청번호]로 귀사에서 데이타를 임의로 정의하거나, 당사에서 배포된 모듈로 데이타를 생성할 수 있습니다.
		
		CP 요청번호는 인증 완료 후, 암호화된 결과 데이타에 함께 제공되며
		데이타 위변조 방지 및 특정 사용자가 요청한 것임을 확인하기 위한 목적으로 이용하실 수 있습니다.
		
		따라서 귀사의 프로세스에 응용하여 이용할 수 있는 데이타이기에, 필수값은 아닙니다.
	└────────────────────────────────────────────────────────────────────
	*/
	String sCPRequest2				= "";
	
	
	
	// 객체 생성
	IPINClient pClient2 = new IPINClient();
	
	
	// 앞서 설명드린 바와같이, CP 요청번호는 배포된 모듈을 통해 아래와 같이 생성할 수 있습니다.
	sCPRequest2 = pClient2.getRequestNO(sSiteCode_ipin2);
	
	// CP 요청번호를 세션에 저장합니다.
	// 현재 예제로 저장한 세션은 ipin_result.jsp 페이지에서 데이타 위변조 방지를 위해 확인하기 위함입니다.
	// 필수사항은 아니며, 보안을 위한 권고사항입니다.
	session.setAttribute("CPREQUEST" , sCPRequest2);
	
	
	// Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
	int iRtn2 = pClient2.fnRequest(sSiteCode_ipin2, sSitePw_ipin2, sCPRequest2, sReturnURL_ipin2);
	
	String sRtnMsg2					= "";			// 처리결과 메세지
	String sEncData_ipin2					= "";			// 암호화 된 데이타
	
	// Method 결과값에 따른 처리사항
	if (iRtn2 == 0)
	{
	
		// fnRequest 함수 처리시 업체정보를 암호화한 데이터를 추출합니다.
		// 추출된 암호화된 데이타는 당사 팝업 요청시, 함께 보내주셔야 합니다.
		sEncData_ipin2 = pClient2.getCipherData();		//암호화 된 데이타
		
		sRtnMsg2 = "정상 처리되었습니다.";
	
	}
	else if (iRtn2 == -1 || iRtn2 == -2)
	{
		sRtnMsg2 =	"배포해 드린 서비스 모듈 중, 귀사 서버환경에 맞는 모듈을 이용해 주시기 바랍니다.<BR>" +
					"귀사 서버환경에 맞는 모듈이 없다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
	}
	else if (iRtn2 == -9)
	{
		sRtnMsg2 = "입력값 오류 : fnRequest 함수 처리시, 필요한 4개의 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
	}
	else
	{
		sRtnMsg2 = "iRtn 값 확인 후, NICE신용평가정보 개발 담당자에게 문의해 주세요.";
	}
%>
<!-- i-pin 모듈 끝 -->
<!-- !DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
<html xmlns="http://www.w3.org/1999/xhtml" -->

<!DOCTYPE HTML>
<html lang="ko">

<head>
<meta charset="UTF-8"> 
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><%=PAGETITLE%></title>

<fmtag:csscommon point="front" hgrcode="<%=G_TMPL %>" />
<fmtag:dwrcommon interfaceName="CommonUtilWork"/>
<fmtag:dwrcommon interfaceName="MyClassWork"/>

<script language="Javascript" src="/js/home/template<%=G_TMPL %>.js"></script>
<script type="text/JavaScript" language="JavaScript" src="/js/common/common.js"></script>
<script type="text/JavaScript" language="JavaScript" src="/js/common/common_util.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script>

<link rel="stylesheet" href="/css/front/template_new/style.css" type="text/css"/>
<link rel="stylesheet" href="/css/front/template_new/navi2.css" type="text/css"/>

<script language="javascript">
<!--
//온로드 함수
/*
* Onload함수가 필요할경우, window.onload를 사용하지 않고,
* addLoadEvent(함수명);으로  해당함수를 호출해준다
*/
//window.onload=function(){		//	사용하지 않음!
	<% if(!G_USERID.equals("")){ %>
		addLoadEvent(selectMemoCnt);	// 새쪽지 카운트
	<% } %>
//}
//새쪽지 카운트
function selectMemoCnt(){
	CommonUtilWork.selectMemoCntCallBack(setMemoCnt);
}
//새쪽지 콜백
function setMemoCnt(v_cnt){

var memoCntSpan = document.getElementById("memoCntSpan");
//	memoCntSpan.innerHTML = v_cnt;
}
//쪽지팝업
function memoPoupUp(){
var url = "/front/Memo.do?cmd=memoListPopup";
wd_pop = Center_Fixed_Popup2(url, "memoPopup", 780, 597, "no");
}

//메인메뉴 롤오버
function imgExchange(obj){
	imgName = obj.src.slice(obj.src.lastIndexOf('/') + 1, obj.src.length);
	imgPath = '/images/home<%=G_HGRCODE%>/common/';

	if(imgName.indexOf('_on') > 0){
		imgName = imgName.replace('_on', '_off');
	}else{
		imgName = imgName.replace('_off.', '_on.');
	}

	obj.src = imgPath + imgName;
}

//좌측메뉴 롤오버
function imgExchange_menu(obj){

	imgName = obj.src.slice(obj.src.lastIndexOf('/') + 1, obj.src.length);
	imgPath = '/images/home<%=G_HGRCODE%>/menu/';

	if(imgName.indexOf('_on') > 0){
		imgName = imgName.replace('_on', '_off');
	}else{
		imgName = imgName.replace('_off.', '_on.');
	}

	obj.src = imgPath + imgName;
}

function menuMouseOver(onobj,idx){
	try{
		var menu_num = 10;
   var bodystartpos = getPosition(document.getElementById("BodyStaPos"));
   var menuendpos = 0, leftmargin = 0, menusize = 0;
   var objLayer, subMenu;
		for(i=1 ; i<=menu_num ; i++){
			objLayer = document.getElementById("tab_0"+i);
			subMenu = document.getElementById("SubMenu_0"+i);
			if(objLayer == null) continue;
			if(i == idx){
				objLayer.style.display = "block";
				var pos = getPosition(onobj);
				leftmargin = pos.x - bodystartpos.x;
				menusize = leftmargin + subMenu.clientWidth;
				if(896 < menusize) leftmargin = leftmargin - (menusize - 896);
				subMenu.style.marginLeft = leftmargin-20;

				objLayer.style.display = "block";
			}else{
				objLayer.style.display = "none";
			}
		}
	}catch(err){

	}
}
function menuMouseOut(idx){
	var objLayer = document.getElementById("tab_0"+idx);
	//objLayer.style.display = "none";
$(objLayer).fadeOut(1000);
}

//quick사용
function getQuickPosition(){
	var start, end, scale, term;
	start = parseInt (document.getElementById('quickmenu').style.top, 0);
	if(document.documentElement.scrollTop>80)
		end = document.documentElement.scrollTop-100 + 0;
	else
		end = document.documentElement.scrollTop + 0;
	term = 5;
	if ( start != end ) {
	scale = Math.ceil( Math.abs( end - start ) / 20 );
		if ( end < start )	scale = - scale;
		document.getElementById('quickmenu').style.top = parseInt (document.getElementById('quickmenu').style.top, 0)+ scale + "px";
		term = 1;
	}
	setTimeout ("getQuickPosition()", term);
}
function moveBanner() {
	document.getElementById('quickmenu').style.top = document.documentElement.scrollTop + 0 + "px";
	getQuickPosition();
	return true;
}

function goSystem(v_system){
	dwr.engine.setAsync(false);
CommonUtilWork.setSessionValue("s_system", v_system);
document.location.href="/front/Main.do?cmd=btocMain&s_system="+v_system;
}

//메뉴에 해당하는 URL로 이동을 한다.
function goMenu(v_menuid){
CommonUtilWork.setSessionBtocMenuCallBack(v_menuid, "", goMenuCallBack);
}
function goMenuOff(v_menuid, e_menuid){	//단기연수메뉴에 해당하는 URL로 이동시 사용
	CommonUtilWork.setSessionBtocMenuCallBack2(v_menuid, e_menuid, "", goMenuCallBack);
}

//위치는 주어진 menuid로 이동을 하며 주어진 url을 호출한다. -- 상세 내용으로 이동 시 사용
function goMenuUrl(v_menuid, url){
CommonUtilWork.setSessionBtocMenuCallBack(v_menuid, url, goMenuCallBack);
}

//페이지로 이동을 해준다.
function goMenuCallBack(v_url){
	if(v_url == "-1"){
   alert("준비중입니다.");
   return;
	}else if(v_url.indexOf("SYSTEM") > -1){
		goSystem(v_url.split("/")[1]);
	}else
	document.location.href=v_url;
}

//팝업을 띄워준다.
function goPopup(v_url){
window.open(v_url);
}

//로그아웃을 해준다.
function logout(v_hgrcode){
document.location = "/front/Member.do?cmd=logout&p_hgrcode="+v_hgrcode;
}

//홈으로
function fncGoHome()
{
	location.href="/front/Member.do?cmd=goIntro";
}

function iecompattest(){
	return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body
}

function showDayScheduleShow( v_key ) {

	var target = document.getElementById("tdDaySchedule");
	var source = $('#iframeCal').contents().find('#'+v_key);
	var divObj = document.getElementById("divDaySchedule");

	$('#divDaySchedule').css({
		top : $('#tableCalendar').offset().top + source.offset().top - 20,
		left : $('#tableCalendar').offset().left,
		display : ""
	});

	target.innerHTML = source.html();
}
function showDayScheduleHide() {
	$('#divDaySchedule').css({
		display : "none"
	});
}
function goCalendar() {
	var f = document.form1;
	var v_year = $('#p_scheduledt_year').val();
	var v_month = $('#p_scheduledt_mon').val();
//	var v_year = f.p_scheduledt_year[f.p_scheduledt_year.selectedIndex].value;
//	var v_month = f.p_scheduledt_mon[f.p_scheduledt_mon.selectedIndex].value;
	var v_yearmonth = v_year + v_month
	var iframe = document.getElementById("iframeCal");
	iframe.contentWindow.location.href = "/front/Main.do?cmd=mainCalendar&p_year="+v_year+"&p_mon="+v_month+"&p_yearmonth="+v_yearmonth+"&p_comp=<%=session.getAttribute("s_comp")%>";
}

function sulmunShow(sulpapernum){
var f = document.form1;

	var param = "&p_hgrcode=<%=G_HGRCODE%>";
	param += "&p_sulpapernum="+sulpapernum;
	param += "&p_userid=<%=box.getString("s_userid")%>";

	url = "/front/Sulmun.do?cmd=sulmunShow"+param

	Center_Fixed_Popup2(url, "SulPaperAttend", 880, 700, "yes");
}

function sulmunResult(sulpapernum){
var f = document.form1;

	var param = "&p_hgrcode=<%=G_HGRCODE%>";
	param += "&p_sulpapernum="+sulpapernum;
	param += "&p_userid=<%=box.getString("s_userid")%>";

	url = "/front/Sulmun.do?cmd=sulmunResult"+param

	Center_Fixed_Popup2(url, "SulPaperResult", 880, 700, "yes");
}

function userSubjProgress(){
var userSubjObj = document.getElementById("UserSubj");

var userSubj = userSubjObj.value.split("/");
var param = {p_subj:userSubj[0],p_year:userSubj[1],p_subjseq:userSubj[2],p_userid:'<%=box.getString("s_userid")%>'};
MyClassWork.userSubjListCallBack(param,userSubjProgressCallBack);
}

function userSubjProgressCallBack(data){
var subjTerm = document.getElementById("SubjTerm");
var subjCurProgress = document.getElementById("SubjCurProgress");
var subjCurProgAvg = document.getElementById("CurProgAvg");
var subjRecommProgress = document.getElementById("SubjRecommProgress");
var subjRecommProgAvg = document.getElementById("RecommProgAvg");

var subjProj = document.getElementById("SubjProj");
var subjMtest = document.getElementById("SubjMtest");
var subjFtest = document.getElementById("SubjFtest");

var v_itemcnt =  data["ITEMCNT"];
var v_completeitemcnt = data["COMPLETEITEMCNT"];
var v_totedudt = data["TOTEDUDT"];
var v_studydt =  data["STUDYDT"];
var v_curavg = v_completeitemcnt==0||v_itemcnt==0?0:(v_completeitemcnt/(v_itemcnt*1.0))*100;
if(data["OUTSOURCINGTYPE"] == "02") v_curavg = data["TSTEP"];
var v_studyavg = v_studydt==0||v_totedudt==0?0:v_studydt/(v_totedudt*1.0)*100;

subjTerm.innerText = addDateFormatStr(data["EDUSTART"])+" ~ "+addDateFormatStr(data["EDUEND"]);
subjCurProgress.style.width = v_curavg.toFixed(1) +"%";
subjCurProgAvg.innerText = v_curavg.toFixed(1)+"%";
subjRecommProgress.style.width = v_studyavg.toFixed(1)+"%";
subjRecommProgAvg.innerText = v_studyavg.toFixed(1)+"%";
subjProj.innerText =  data["PROJTOTCNT"]+"개중 "+data["PROJORDCNT"]+"개 제출";
subjMtest.innerText =  data["MTESTCNT"]+"개중 "+data["SMTESTCNT"]+"개 응시";
subjFtest.innerText =  data["FTESTCNT"]+"개중 "+data["SFTESTCNT"]+"개 응시";
}

function changeNewRecomm(idx){
var newRecomm1 = document.getElementById("NewRecomm1");
var newRecomm2 = document.getElementById("NewRecomm2");
var newRecommSubj1 = document.getElementById("NewRecommSubj1");
var newRecommSubj2 = document.getElementById("NewRecommSubj2");

if(idx == 1){
  newRecomm1.src = "/images/template1/main/main_lecture_tab01_ov.gif";
  newRecomm2.src = "/images/template1/main/main_lecture_tab02.gif";
  newRecommSubj1.style.display = "";
  newRecommSubj2.style.display = "none";
}else{
  newRecomm1.src = "/images/template1/main/main_lecture_tab01.gif";
  newRecomm2.src = "/images/template1/main/main_lecture_tab02_ov.gif";
  newRecommSubj1.style.display = "none";
  newRecommSubj2.style.display = "";
}
}

function goLecture(arg){
	var subjinfo = "" ;
	if(arg == undefined) subjinfo =  document.getElementById("UserSubj");
	else subjinfo =  document.getElementById("UserSubj2");

	if(subjinfo.value == ""){
   alert("강의실 선택 후에 나의 강의실을 클릭해 주세요.");
   return;
}

subj = subjinfo.value.split("/");

if(subj[7] == "02") { //외부 링크 과정
	 	var url = "/front/Propose.do?cmd=cpSubjectLink" + "&p_subj=" + subj[0] + "&p_year=" + subj[1]  + "&p_subjseq=" + subj[2] + "&p_cpsubj=" + subj[3] + "&p_cpsubjseq="+ subj[4] + "&p_edustart=" + subj[5] + "&p_eduend=" + subj[6];
		Center_Fixed_Popup2(url, "_blank", 900, 720, "yes");
} else {
 	var url = "/front/MyClass.do?cmd=classroomMain&p_subj="+subj[0]+"&p_year="+subj[1]+"&p_subjseq="+subj[2];
	    Center_Fixed_Popup2(url, "GoLecture", 790, 730, "no");
	}
}
function goPopCurriculumE(isOnOff, subj, subjseq, year) {	//이러닝 모집과정 팝업
	var subElements = document.forms["popCurriculumForm"].elements;
	subElements["p_subj"].value  = subj ;
	subElements["cmd"].value  = "getViewCompSubject" ;
	subElements["p_isonoff"].value  = isOnOff ;

	subElements["next"].value = "popViewCompSubject";

	Center_Fixed_Popup2("", "popMainCurriculum", 820, 700, "yes");
	document.forms["popCurriculumForm"].target = "popMainCurriculum";
	document.forms["popCurriculumForm"].action = "/front/SubjectF.do";
	document.forms["popCurriculumForm"].method = "post";
	document.forms["popCurriculumForm"].submit();
	document.forms["popCurriculumForm"].target = "_self";

}


function goCurriculum() {
<% if (G_HGRCODE.equals("6")) { %>
		goDirectMenu2("경영교육",'경영일반', '/front/SubjectF.do?cmd=compSubjectMain&p_isonoff=ON&p_upperclass=1000&p_middleclass=1100');
<% }else {%>

		goDirectMenu("전체보기1",'/front/SubjectF.do?cmd=compSubjectMain&p_isonoff=ON&p_upperclass=1000');
<%}%>
}
function goPreview(arg1, arg2) {
	var url = "" ;
	if(arg1 == "Y") {
		url = "/front/Contents.do?cmd=sampleContentsFrame&p_contsid="+arg2;
		Contents_Popup2(url, "CourseContents", '1024','700','yes');
	}else {
		url = arg2 ;
		Contents_Popup4(url, "CourseContents", '1024','700', 'yes');
	}
}
function goIdPwd(arg) {
	var url = "" ;
	if(arg == "1") {
		url = "http://login.kita.net/hintsearch/popup_id_search.jsp";
	}else if ( arg == "2") {
		url = "http://login.kita.net/hintsearch/popup_pass_search.jsp";
		
	}
	Center_Fixed_Popup4(url, "popIdPwd", '445','520','yes');
	//var url = "http://login.kita.net/hintsearch/popup_pass_search.jsp";
	
}
function bestTop(pst){
var inx = pst + 1 ;
	subElements = document.forms["popCurriculumForm"].elements;

	if(pst == 0)
	{
			tab5_01.style.display = '';
			tab5_02.style.display = 'none';

			subElements["p_upperclass"].value = "";
			subElements["p_middleclass"].value = "";
			subElements["p_lowerclass"].value = "";
	}
	else if(pst == 1)
	{
			tab5_02.style.display = '';
			tab5_01.style.display = 'none';

			subElements["p_upperclass"].value = "2000";
			subElements["p_middleclass"].value = "";
			subElements["p_lowerclass"].value = "";

	}
}

function goSearchSubj( arg ) {
	var searchWord ;
	if(arg == undefined ) searchWord = document.getElementById("p_recommsubj").value;
	else searchWord = arg ;
	if(searchWord.trim() == "") {
		alert("검색어를 입력하세요");
		document.getElementById("p_recommsubj").focus();
		return ;
	}

	searchWord = toUTF8(searchWord);
	goMenuUrl('255', '/front/SubjectF.do?cmd=courseSearchMain&p_favoryn=Y&p_subjnm='+searchWord );
}
function goScap(){
<% if(G_HGRCODE.equals("1")){ %>
	    window.open("/front/MyClass.do?cmd=goScapSso");
	 <% }else{%>
	 	alert('아직 기간이 아닙니다.');
	 <% } %>
}

function popupWin(url, winname, prot) {
	  window.open(url, winname, prot);
}

function pageGo(){
	document.forms["form3"].action = "http://edu1.kkpc.com/cyber/kkpc/connect.asp";
	document.forms["form3"].method = "post";
	document.forms["form3"].target = "_blank";
	document.forms["form3"].submit();
}

//컨텐츠스크랩 목차명 클릭
function goContents(contsid, contsurl, itemid){
	var url = "/front/Contents.do?cmd=previewContentsFrame&p_contsid="+contsid+"&p_contsurl="+contsurl;
Contents_Popup2(url, "OpenContents");
}

<%	if ( !box.getString("s_userid").equals("") ) { %>
function moveLinkPage(){
var v_gadmin = document.getElementById("multiAuthor");
if ( !v_gadmin.value == "" ) {
	//IENewOpenCtrl.URLOpen("http://www.tradecampus.com/back/Member.do?cmd=directLogin&p_comp=&p_userid=<%=Base64.encode(box.getStringDefault("s_userid","test"))%>&p_gadmin="+v_gadmin.value);
	window.open("http://tradecampus.kita.net/back/Member.do?cmd=directLogin&p_comp=&p_userid=<%=Base64.encode(box.getStringDefault("s_userid","test"))%>&p_gadmin="+v_gadmin.value);	
}
}
<%	} %>
function login() {
	var f = document.loingform;
	if(!validate(f)) return;
	f.target = "hiddenFrame";
f.submit();
}

function EnterCheck(){
if (event.keyCode == 13) login();
}

var subElements = "" ;

//역량진단 메인 팝업
function ehrdMainForm(){
var url = "/front/ehrd/Ehrd.do?cmd=ehrdMainPopup";
wd_pop = Center_Fixed_Popup2(url, "ehrdMainFrom", 760, 678, "no");
}

function goPopCurriculum(isOnOff, subj, subjseq, year) {
	subElements["p_subj"].value  = subj ;
	subElements["p_subjseq"].value  = subjseq ;
	subElements["p_year"].value  = year ;
	subElements["cmd"].value  = "getViewCompSubjSeq" ;
	subElements["p_isonoff"].value  = isOnOff ;
	subElements["next"].value = "popViewCompSubjSeq";

	Center_Fixed_Popup2("", "popMainCurriculum", 820, 700, "yes");
	document.forms["popCurriculumForm"].target = "popMainCurriculum";
	document.forms["popCurriculumForm"].action = "/front/SubjSeqF.do";
	document.forms["popCurriculumForm"].method = "post";
	document.forms["popCurriculumForm"].submit();
	document.forms["popCurriculumForm"].target = "_self";
}



function goPopProposeForm(isOnOff, subj, subjseq, year) {
	goPopPropse(subElements, document.forms["popCurriculumForm"], subj, subjseq, year, "");
}

function goTraining() {
	if (document.getElementById("tab3_01").style.display == "" ) { //단기과정
		goMenu('146');
	}else if (document.getElementById("tab3_02").style.display == "" ) {//eLearning
		goMenu('167');
	}else { //위탁연수

	}
}
function courseQuickSearch() {
	subElements["cmd"].value  = "courseQuickSearch" ;
	subElements["next"].value  = "" ;
	Center_Fixed_Popup2("", "popCourseQuickSearch", 1131, 503, "yes");
	document.forms["popCurriculumForm"].target = "popCourseQuickSearch";
	document.forms["popCurriculumForm"].action = "/front/SubjSeqF.do";
	document.forms["popCurriculumForm"].method = "post";
	document.forms["popCurriculumForm"].submit();
	document.forms["popCurriculumForm"].target = "_self";
}
function DOC_LOAD() {
	subElements = document.forms["popCurriculumForm"].elements;
}
addLoadEvent(DOC_LOAD);
function findIdNPw(){
	if (confirm("아이디/패스워드 찾기는 KITA.NET를 이용해 주세요\n KITA.NET로 이동합니다")) {
		window.open('http://www.kita.net');
	} else return;
}

function closeMenu(){	
	$('.TopSubMenu').hide();
}

//-->
</script>
<script type="text/javascript">
function gogoCampus(){
	document.getElementById("gogocampus").focus();
}
</script>


<!-- header 내용 시작 -->
<body>
<div class="header_top">
<div class="header_top_contents">

<!-- 서비스 바로가기 -->
<script type="text/javascript">
	function goSubMainPage(obj){
		if(obj.selectedIndex > 0){
			if(obj.options[obj.selectedIndex].value=='jiboo'){
				goMenuOff('523', '523');
			} else if (obj.options[obj.selectedIndex].value=='628') {
				goMenu('628');
			} else if (obj.options[obj.selectedIndex].value=='630') {
				goMenu('630');
			} else{
				goSystem(obj.options[obj.selectedIndex].value);
			}
		}
	}
</script>
<select class="selector" valign="middle" onChange="goSubMainPage(this)" name="">
	<option value="#" style="background:white;">서비스바로가기</option>
	<option value="1" style="background:white;">HOME</option>
	<option value="2" style="background:white;">단기연수</option>
	<option value="3" style="background:white;">e러닝</option>
	<option value="4" style="background:white;">무역마스터</option>
	<option value="632" style="background:white;">전자무역물류마스터</option>
	<option value="5" style="background:white;">SMART Cloud 마스터</option>
	<option value="6" style="background:white;">GLMP</option>
	<option value="8" style="background:white;">글로벌무역인턴쉽</option>
	<option value="10" style="background:white;">자격시험</option>
</select>

<!-- 관리자 계정의 서비스 바로가기 -->
<%
	if(!G_USERID.equals("")) {
		String _multiauthor = box.getString("s_multiauthor");
		String _multiauthornm = box.getString("s_multiauthornm");
		String[] _multiauthorArr = StringUtil.split(_multiauthor,",");
		if ( !_multiauthor.equals("") && _multiauthorArr != null && _multiauthorArr.length > 0 ) {
			String[] _multiauthornmArr = StringUtil.split(_multiauthornm,",");
%>
	<select id="multiAuthor" name="multiAuthor" style="width:100px;" onchange="moveLinkPage()">
		<option value="">선택</option>
<%			for ( int i=0; i < _multiauthorArr.length; i++ ) { %>
				<option value="<%=_multiauthorArr[i]%>"><%=_multiauthornmArr[i]%></option>
<%			} %>
	</select>
	<%	} %>
<%  } %>

<a href="#none" onClick="goMenu('98');"><img src="/images/common/new_main/sitemap.png" align="right"></a>
<a href="https://www.youtube.com/user/kita1946" target="_blank"><img src="/images/common/new_main/youtube.png" align="right"></a>
<a href="http://twitter.com/kita_net" target="_blank"><img src="/images/common/new_main/twitter.png" align="right"></a>
<a href="http://www.facebook.com/tradecampus" target="_blank"><img src="/images/common/new_main/facebook.png" align="right"></a>
</div>
</div>


<div class="header_middle">
<div class="header_middle_contents">

<!-- 검색 -->
<a href="http://www.tradecampus.com/"><img src="/images/common/new_main/logo.png" align="left"></a>
<div class="search_bar">
	<br>
	<div class="search_bar_input"><input type="text" size="50" id="p_recommsubj" name="p_recommsubj" class="input_text_for_search" align="absmiddle"></div>
	<div class="search_bar_btn"><a href="#none" onClick="goSearchSubj();"><img src="/images/common/new_main/search_btn.png" alt="검색"></a></div>
</div>
<div class="line"></div>

<!-- HOT 키워드 -->
<div class="search_words">
<div class="search_words_left"><img src="/images/common/new_main/left_btn.png"></div>
	<a id="link" href="http://award.kita.net/main3.screen " target="_blank" style="font-size: 14px">무역의 날 포상신청</a> | 
	<a id="link" href="http://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&ie=utf8&query=%EC%97%94%ED%99%94" target="_blank" style="font-size: 14px">엔화</a> | 
	<a id="link" href="http://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&ie=utf8&query=%EC%A4%91%EA%B5%AD%EC%A0%84%EC%9E%90%EC%83%81%EA%B1%B0%EB%9E%98 " target="_blank" style="font-size: 14px">중국전자상거래</a> | 
	<a id="link" href="http://terms.naver.com/entry.nhn?docId=74758&cid=43667&categoryId=43667 " target="_blank" style="font-size: 14px">PPL 마케팅</a>
<div class="search_words_right"><img src="/images/common/new_main/right_btn.png"></div>
</div>

<!-- 로그인 모듈 -->
<% if(G_USERID.equals("")) { %>
<!-- 로그인 -->
<form name="loingform" action="https://tradecampus.kita.net/front/Member.do" method="post" onSubmit="return false">
	<input type="hidden" name="cmd" value="btocLogin">
	<div class="login">
	<br>
		<div class="id_input">
			<input type="text" name="p_userid" dispName="아이디" isNull="N" lenCheck="20" onKeyDown="EnterCheck()" maxlength="20" size="7" class="input_text_for_idpw" >
		</div> 
		<div class="login_btn">
			<a href="#" onclick="javascript:login();"><img src="/images/common/new_main/login_btn.png" alt="로그인"></a>
		</div>
		<div class="pw_input">
			<input type="password" name="p_pwd" dispName="패스워드" isNull="N" lenCheck="20" onKeyDown="EnterCheck()" maxlength="20" size="7" class="input_text_for_idpw">
		</div>
		<div class="login_txt"><a id="link" href="#none" onClick="goMenu('253');">회원가입</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a id="link" href="#" onclick="findIdNPw()" target="_self">아이디 / 비밀번호찾기</a>  </div>
	</div>
</form>
<% } else { %>
<!-- 로그아웃 -->
<div class="login">
<br>
	<div class="login_id">
		<b style="color: blue; font-size: 14px;"><%=G_NAME %></b>&nbsp;님
	</div> 
	<div class="login_btn">
		<%
		String s_ck_cert_gb = "";
		String s_sex = "";
		String s_usergubun = "";
		if(session.getAttribute("s_ck_cert_gb")!=null){s_ck_cert_gb=(String)session.getAttribute("s_ck_cert_gb");}
		if(session.getAttribute("s_sex")!=null){s_sex=(String)session.getAttribute("s_sex");}
		if(session.getAttribute("s_usergubun")!=null){s_usergubun=(String)session.getAttribute("s_usergubun");}
		if( (!s_ck_cert_gb.equals("0") && !s_usergubun.equals("FC")) || (s_sex.equals("") && !s_usergubun.equals("FC")) ){%>
	      	<a onclick="fnPopup_ipin2()" href="#"><img src="/images/template0/common/btn_change_ipin.gif" border="0" /></a>
	      	<!-- ipin인증 팝업 -->
			<script language='javascript'>
				window.name ="Parent_window2";	
			
				function fnPopup_ipin2(){
					window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
					document.form_ipin2.target = "popupIPIN2";
					document.form_ipin2.action = "https://cert.vno.co.kr/ipin.cb";
					document.form_ipin2.submit();
					document.domain = "tradecampus.kita.net";
				}
			</script>
	<%	} %>
	</div>
	<div class="login_message">
		반갑습니다.
	</div>
	<div class="login_txt"><a id="link" href="javascript:logout(<%=G_HGRCODE%>)">로그아웃</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a id="link" href="javascript:goMenu('73');">정보수정</a></div>
	<!--쪽지기능 사용안하므로  숨김 -->
	<!-- <img alt="쪽지" src="/images/common/icon_paper.gif" align="absmiddle">
	<a href="#none" onclick="memoPoupUp()"><span id="memoCntSpan" style="color:#FFFFFF"></span></a> -->
</div>
<% } %>

</div>
</div>
<div class="divider_line"></div>


<div class="header_bottom">
<div class="header_bottom_contents">

<ul id="oe_menu"  class="oe_menu">
<br>
<li class="menu1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;교육 / 연수
<div style="margin-left: 12px; display:none; z-index: 999999;">
							<ul style="margin-left: 20px;">
								<li class="oe_heading"><a id="link2" href="javascript:goMenuOff('299', '299')">단기모집과정</a></li>
								<li><a id="link2" href="javascript:goMenuOff('146', '146')">무역실무</a></li>
								<li><a id="link2" href="javascript:goMenuOff('153','153')">마케팅/외환금융</a></li>
								<li><a id="link2" href="javascript:goMenuOff('499','499')">FTA실무</a></li>
								<li><a id="link2" href="javascript:goMenuOff('613', '613')">해외시장진출</a></li>
								<!-- <li><a id="link2" href="javascript:goMenuOff('24', '24')">비즈니스외국어</a></li> --><!-- 추가_2013.12.13 -->
							</ul>
							<ul>
								<li class="oe_heading" style="width: 170px;"><a id="link2" href="javascript:goMenu('89')">기업단체연수</a></li>
								<li style="width: 170px;"><a id="link2" href="javascript:goMenu('89')">연수프로그램</a></li>
								<li style="width: 170px;"><a id="link2" href="javascript:goMenu('89')">신청/문의</a></li>
								<li>&nbsp;</li>
								<li class="oe_heading" style="width: 170px;"><a id="link2" href="javascript:goMenu('673')">미래무역포럼(CEO과정)</a></li>
								<li style="width: 170px;"><a id="link2" href="javascript:goMenu('673')">미래무역포럼 소개</a></li>
								<li style="width: 170px;"><a id="link2" href="javascript:goMenu('671')">과정안내/커리큘럼</a></li>
								<li style="width: 170px;"><a id="link2" href="javascript:goMenu('672')">지원신청</a></li>
							</ul>
							<ul>
								<li class="oe_heading"><a id="link2" href="javascript:goMenu('158')">연수안내/지원</a></li>
								<li><a id="link2" href="javascript:goMenu('158')">연수신청방법</a></li>
								<li><a id="link2" href="javascript:goMenu('159')">고용보험환급</a></li>
								<li><a id="link2" href="javascript:goMenu('160')">연수행정지원</a></li>
								<li><a id="link2" href="javascript:goMenu('157')">운영자에게(QnA)</a></li>
								<li><a id="link2" href="javascript:goMenu('27')">자료실</a></li>
								<li><a id="link2" href="javascript:goMenu('161')">연수시설/찾아오는길</a></li>
							</ul>
							<ul>
								<li class="oe_heading" style="width: 190px;"><a id="link2" href="javascript:goMenu('6')">물류최고경영자과정(GLMP)</a></li>
								<li style="width: 190px;"><a id="link2" href="javascript:goMenu('201')">GLMP 소개</a></li>
								<li style="width: 190px;"><a id="link2" href="javascript:goMenu('276')">학사안내</a></li>
								<li style="width: 190px;"><a id="link2" href="javascript:goMenu('277')">모집/신청</a></li>
								<li style="width: 190px;"><a id="link2" href="javascript:goMenu('349')">자료실</a></li>
								<li style="width: 190px;"><a id="link2" href="javascript:goMenu('205')">알림마당</a></li>
							</ul>
							<ul>
								<li class="oe_heading" style="margin-left: 50px; width: 150px;"><a id="link2" href="javascript:goMenu('466')">대학생무역캠프</a></li>
								<li style="margin-left: 50px; width: 150px;"><a id="link2" href="javascript:goMenu('466')">무역캠프 소개</a></li>
								<li style="margin-left: 50px; width: 150px; "><a id="link2" href="javascript:goMenu('466')">모집/신청</a></li>
								<li style="margin-left: 50px; width: 150px; ">&nbsp;</li>
								<li class="oe_heading" style="margin-left: 50px; width: 150px; "><a id="link2" href="javascript:goMenu('627')">무역아카데미 체험학습</a></li>
							</ul>
						</div>
</li>

<li class="menu2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E-러닝
<div style="left: -112px; z-index: 999999; display: none;">
							<ul style="margin-left: 80px;" class="elearning">
								<li class="oe_heading"><a id="link2" href="javascript:goMenu('167')">분야별과정</a></li>
								<li><a id="link2" href="javascript:goMenu('167')">무역실무</a></li>
								<li><a id="link2" href="javascript:goMenu('168')">비즈니스 외국어</a></li>
								<li><a id="link2" href="javascript:goMenu('169')">직무계발</a></li>
								<li><a id="link2" href="javascript:goMenu('170')">자격시험대비</a></li>
								<li><a id="link2" href="javascript:goMenu('171')">FTA Q&amp;A</a></li>
								<li><a id="link2" href="javascript:goMenu('172')">무역특강</a></li>
							</ul>
							<ul class="elearning">
								<li class="oe_heading"><a id="link2" href="javascript:goMenu('582')">지역전문가</a></li>
								<li><a id="link2" href="javascript:goMenu('582')">인도 무역투자</a></li>
								<li><a id="link2" href="javascript:goMenu('583')">베트남 무역투자</a></li>
								<li><a id="link2" href="javascript:goMenu('616')">인도네시아 무역투자</a></li>	
								<li><a id="link2" href="javascript:goMenu('584')">중국 무역투자</a></li>								
								<li><a id="link2" href="javascript:goMenu('589')">기&nbsp;&nbsp;타</a></li>								
							</ul>
							<ul class="elearning">
								<li class="oe_heading"><a id="link2" href="javascript:goMenu('354')">패키지강좌</a></li>
								<li><a id="link2" href="javascript:goMenu('354')">실무자 핵심역량강화</a></li>
								<li><a id="link2" href="javascript:goMenu('358')">중견직원 역량강화</a></li>
								<li><a id="link2" href="javascript:goMenu('410')">직급별 승진자 역량강화</a></li>
								<li><a id="link2" href="javascript:goMenu('428')">리더 역량강화</a></li>								
								<!-- <li><a id="link2" href="javascript:var return_value = Center_Fixed_Popup2('/jsp/front/common/opencourse/tradeSecrets.jsp','trade_serects','800','820','Y')">영업비밀 보호방법</a></li> -->
							</ul>
							<ul class="elearning" style="width:210px;">
								<li class="oe_heading"><a id="link2" href="#">정부/지자체 지원 특별과정</a></li>
								<li><a id="link2" href="javascript:goMenu('391')">중소기업 수출역량 강화사업</a></li>
								<li><a id="link2" href="javascript:goMenu('623')">고성장 중소기업 수출역량 강화사업</a></li>
								<li><a id="link2" href="javascript:goMenuOff('607', '607')">지방자치단체 협력사업</a></li>
								<!-- <li><a id="link2" href="javascript:goMenu('393')">GTEP 특별과정</a></li> -->
							</ul>
						</div>


</li>
<li class="menu3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  인력양성 / 취업
<div style="left: -229px; display: none; z-index: 999999;">
							<ul style="margin-left: 20px;" class="training">
								<li class="oe_heading"><a id="link2" href="javascript:goMenu('4')">무역마스터</a></li>
								<li><a id="link2" href="javascript:goMenu('178')">과정안내/커리큘럼</a></li>
								<li><a id="link2" href="javascript:goMenu('42')">지원신청</a></li>
								<li><a id="link2" href="javascript:goMenu('187')">인재추천</a></li>
								<li>&nbsp;</li>
								<li class="oe_heading" style="width: 130px;"><a id="link2" href="javascript:goMenu('632')">전자무역물류마스터</a></li>
								<li><a id="link2" href="javascript:goMenu('635')">과정안내/커리큘럼</a></li>
								<li><a id="link2" href="javascript:goMenu('641')">지원신청</a></li>
								<li><a id="link2" href="javascript:goMenu('642')">인재추천</a></li>
							</ul>
							<ul class="training" style="margin-right: 55px;">
								<li class="oe_heading" style="width: 165px;  "><a id="link2" href="javascript:goMenu('477')">패션·의류·섬유수출과정</a></li>
								<li><a id="link2" href="javascript:goMenu('483')">과정안내/커리큘럼</a></li>
								<li><a id="link2" href="javascript:goMenu('480')">지원신청</a></li>
								<li><a id="link2" href="javascript:goMenu('486')">인재추천</a></li>
								<li>&nbsp;</li>
								<li class="oe_heading" style="width: 165px;"><a id="link2" href="javascript:goMenu('560')">섬유수출전문가:소재과정</a></li>
								<li><a id="link2" href="javascript:goMenu('560')">과정안내/커리큘럼</a></li>
								<li><a id="link2" href="javascript:goMenu('557')">지원신청</a></li>
								<li><a id="link2" href="javascript:goMenu('568')">인재추천</a></li>
							</ul>
							<ul class="training" style="width:165px;">
								<li class="oe_heading"><a id="link2" href="javascript:goMenu('5')">SMART Cloud 마스터</a></li>
								<li><a id="link2" href="javascript:goMenu('192')">과정안내/커리큘럼</a></li>
								<li><a id="link2" href="javascript:goMenu('47')">지원신청</a></li>
								<li><a id="link2" href="javascript:goMenu('314')">채용정보</a></li>
								<li>&nbsp;</li>
								<li class="oe_heading" style="width: 170px;"><a id="link2" href="javascript:goMenu('646')">자동차부품수출전문가과정</a></li>
								<li><a id="link2" href="javascript:goMenu('657')">과정안내/커리큘럼</a></li>
								<li><a id="link2" href="javascript:goMenu('649')">지원신청</a></li>
								<li><a id="link2" href="javascript:goMenu('650')">채용정보</a></li>
							</ul>
							<ul class="training">
								<li class="oe_heading"><a id="link2" href="javascript:goMenu('52')">GTEP</a></li>
								<li><a id="link2" href="javascript:goMenu('52')">프로그램 안내</a></li>
								<li><a id="link2" href="javascript:goMenu('465')">우수사례</a></li>
								<li><a id="link2" href="http://www.gtep.or.kr/" target="_blank">GTEP 사이트</a></li>
							</ul>
							<ul class="training">
								<li class="oe_heading"><a id="link2" href="javascript:goMenu('8')">글로벌 무역인턴십</a></li>
								<li><a id="link2" href="javascript:goMenu('54')">프로그램 안내</a></li>
								<li><a id="link2" href="javascript:goMenu('196')">지원신청</a></li>
							</ul>
							<!-- <ul  class="training">
								<li class="oe_heading"><a id="link2" href="javascript:goMenu('502')">특성화고 무역교육</a></li>
								<li><a id="link2" href="javascript:goMenu('502')">프로그램 안내</a></li>
								<li><a id="link2" href="javascript:goMenu('503')">신청방법</a></li>
							</ul> -->
						</div>

</li>
<li class="menu4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  지부연수
<div style="left: -406px; z-index: 999999; display: none;">
							<ul style="margin-left: 20px;" class="jiboo">
								<li class="oe_heading"><a id="link2" href="javascript:goMenu('523', '523')">대구/경북</a></li>
								<li><a id="link2" href="javascript:goMenuOff('523', '523')">오프라인</a></li>
								<li><a id="link2" href="javascript:goMenuOff('524', '524')">온라인</a></li>
								<li><a id="link2" href="javascript:goMenuOff('525', '525')">장기과정</a></li>
							</ul>
							<ul style="margin-left: 20px;" class="jiboo">
								<li class="oe_heading"><a id="link2" href="javascript:goMenuOff('527', '527')">대전</a></li>
								<li><a id="link2" href="javascript:goMenuOff('527', '527')">오프라인</a></li>
								<li><a id="link2" href="javascript:goMenuOff('528', '528')">온라인</a></li>
								<li><a id="link2" href="javascript:goMenuOff('529', '529')">장기과정</a></li>
							</ul>
							<ul style="margin-left: 20px;" class="jiboo">
								<li class="oe_heading"><a id="link2" href="javascript:goMenuOff('531', '531')">울산</a></li>
								<li><a id="link2" href="javascript:goMenuOff('531', '531')">오프라인</a></li>
								<li><a id="link2" href="javascript:goMenuOff('532', '532')">온라인</a></li>
								<li><a id="link2" href="javascript:goMenuOff('533', '533')">장기과정</a></li>
							</ul>
							<ul style="margin-left: 20px;" class="jiboo">
								<li class="oe_heading"><a id="link2" href="javascript:goMenuOff('535', '535')">광주</a></li>
								<li><a id="link2" href="javascript:goMenuOff('535', '535')">오프라인</a></li>
								<li><a id="link2" href="javascript:goMenuOff('536', '536')">온라인</a></li>
								<li><a id="link2" href="javascript:goMenuOff('537', '537')">장기과정</a></li>
							</ul>
							<ul style="margin-left: 20px;" class="jiboo">
								<li class="oe_heading"><a id="link2" href="javascript:goMenuOff('539', '539')">충북</a></li>
								<li><a id="link2" href="javascript:goMenuOff('539', '539')">오프라인</a></li>
								<li><a id="link2" href="javascript:goMenuOff('540', '540')">온라인</a></li>
								<li><a id="link2" href="javascript:goMenuOff('540', '540')">장기과정</a></li>
							</ul>
							<ul style="margin-left: 20px;" class="jiboo">
								<li class="oe_heading"><a id="link2" href="javascript:goMenuOff('543', '543')">전북</a></li>
								<li><a id="link2" href="javascript:goMenuOff('543', '543')">오프라인</a></li>
								<li><a id="link2" href="javascript:goMenuOff('544', '544')">온라인</a></li>
								<li><a id="link2" href="javascript:goMenuOff('545', '545')">장기과정</a></li>
							</ul>
							<ul style="margin-left: 20px;" class="jiboo">
								<li class="oe_heading"><a id="link2" href="javascript:goMenuOff('547', '547')">경남</a></li>
								<li><a id="link2" href="javascript:goMenuOff('547', '547')">오프라인</a></li>
								<li><a id="link2" href="javascript:goMenuOff('548', '548')">온라인</a></li>
								<li><a id="link2" href="javascript:goMenuOff('549', '549')">장기과정</a></li>
							</ul>
							<ul style="margin-left: 20px;" class="jiboo">
								<li class="oe_heading"><a id="link2" href="#">인천</a></li>
								<li><a id="link2" href="#">오프라인</a></li>
								<li><a id="link2" href="#">온라인</a></li>
								<li><a id="link2" href="#">장기과정</a></li>
<!-- 								<li class="oe_heading"><a id="link2" href="javascript:goMenuOff('551', '551')">인천</a></li>
								<li><a id="link2" href="javascript:goMenuOff('551', '551')">오프라인</a></li>
								<li><a id="link2" href="javascript:goMenuOff('552', '552')">온라인</a></li>
								<li><a id="link2" href="javascript:goMenuOff('553', '553')">장기과정</a></li> -->
							</ul>
						</div>

</li>  
<li class="menu5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  자격시험

<div style="left: -537px; z-index: 1; display: none;">
							<ul style="margin-left: 120px;" class="main_head5">
								<li class="oe_heading"><a id="link2" href="javascript:goMenu('78')">국제무역사</a></li>
								<li><a id="link2" href="javascript:goMenu('78')">안내</a></li>
								<li><a id="link2" href="javascript:goMenu('75')">시험일정/신청</a></li>
							</ul>
							<ul style="margin-left: 80px;" class="main_head5">
								<li class="oe_heading"><a id="link2" href="javascript:goMenu('350')">무역관리사</a></li>
								<li><a id="link2" href="javascript:goMenu('350')">안내</a></li>
								<li><a id="link2" href="javascript:goMenu('75')">시험일정/신청</a></li>
							</ul>
							<ul style="margin-left: 80px;" class="main_head5">
								<li class="oe_heading"><a id="link2" href="javascript:goMenu('77')">외환관리사 자격취득과정</a></li>
								<li><a id="link2" href="javascript:goMenu('77')">안내</a></li>
							</ul>
							<!-- <ul>
								<li class="oe_heading"><a id="link2" href="javascript:goMenu('77')">외환관리사</a></li>
								<li><a id="link2" href="javascript:goMenu('77')">안내</a></li>
								<li><a id="link2" href="javascript:goMenu('75')">시험일정/신청</a></li>
							</ul>
							<ul>
								<li class="oe_heading"><a id="link2" href="javascript:goMenu('281')">외환관리사 실무과정</a></li>
								<li><a id="link2" href="javascript:goMenu('281')">안내</a></li>
								<li><a id="link2" href="javascript:goMenu('154')">시험일정/신청</a></li>
							</ul> -->
						</div>

</li>
</ul>
<div class="line_2"></div>
<div class="mycampus"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id="link" href="javascript:goMenu('230');" style="font-size: 16px; font-weight : bold; color : blue;" >마이 캠퍼스 >></a></div>

</div>
</div>
<div class="divider_line"></div>
<!-- Header 내용 끝 -->


<!-- IPIN인증용 폼 -->			
<form name="vnoform2" method="post">
	<input type="hidden" name="enc_data">								<!-- 인증받은 사용자 정보 암호화 데이타입니다. -->
	
	<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
    	 해당 파라미터는 추가하실 수 없습니다. -->
    <input type="hidden" name="param_r1" value="M_EMODE">
    <input type="hidden" name="param_r2" value="">
    <input type="hidden" name="param_r3" value="<%=box.getString("s_userid") %>">
    <input type="hidden" name="cmd" >
</form>

<!-- ipin인증 폼 -->
<form name="form_ipin2" method="post">
	<input type="hidden" name="m" value="pubmain">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
    <input type="hidden" name="enc_data" value="<%= sEncData_ipin2 %>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
    
    <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
    	 해당 파라미터는 추가하실 수 없습니다. -->
    <input type="hidden" name="param_r1" value="M_EMODE">
    <input type="hidden" name="param_r2" value="">
    <input type="hidden" name="param_r3" value="<%=box.getString("s_userid") %>">
</form>

<!-- 메뉴 -->
<script type="text/javascript">
	$(function() {
		var $oe_menu		= $('#oe_menu');
		var $oe_menu_items	= $oe_menu.children('li');
		var $oe_overlay		= $('#oe_overlay');
		
		$oe_menu.bind('mouseenter',function(){
			var $this = $(this);
			$oe_overlay.stop(true,true).fadeTo(200, 0.6);
			$this.addClass('hovered');
		}).bind('mouseleave',function(){
			var $this = $(this);
			$this.removeClass('hovered');
			$oe_overlay.stop(true,true).fadeTo(200, 0);
			$oe_menu_items.children('div').hide();
		});

		$oe_menu_items.bind('mouseenter',function(){
			var $this = $(this);
			$this.addClass('slided selected');
			$this.children('div').css('z-index','9999').stop(true,true).slideDown(200,function(){
				$oe_menu_items.not('.slided').children('div').hide();
				$this.removeClass('slided');
			});
		}).bind('mouseleave',function(){
			var $this = $(this);
			$this.removeClass('selected').children('div').css('z-index','1');
		});
		
	});
</script>
