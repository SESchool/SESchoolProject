<%@ page contentType="text/html;charset=UTF-8" 	%>
<%@ include file = "/jsp/front/common/commonBasicInc.jsp"	%>
<head>

<link rel="stylesheet" href="/css/style_v3.css" />
<script type="text/JavaScript" src="/js/home/jcarousellite_1.0.1c5.js"></script>
<script type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>

<script language="javascript" src="/flash/home0/elearning/js/flashObj.js">
</script>

</head>
<%
	String command = null;
	command = request.getParameter("command");
	if (StringUtil.isNotNull(command) && command.equals("export")) {%>
	<script>
		location.href = 'http://tradecampus.kita.net/front/ContentPage.do?cmd=contentPage&p_contentid=68&p_outmenuid=354&p_elearning=Y';
	</script>
<%} else if (StringUtil.isNotNull(command) && command.equals("gjcci")) {%>
	<script>
		location.href = 'http://tradecampus.kita.net/front/SubjectF.do?cmd=compSubjectMain&p_trainingclass=09&p_upperclass=2000&p_middleclass=2011&p_lowerclass=2111&p_contentid=74&p_elearnig=Y&p_outmenuid=176';
	</script>
<%} else if (StringUtil.isNotNull(command) && command.equals("chungbuk")) {%>
	<script>
		location.href = '/front/SubjectF.do?cmd=compSubjectMain&p_trainingclass=09&p_upperclass=2000&p_middleclass=2010&p_lowerclass=2105&p_contentid=78&p_outmenuid=395';
	</script>
<%} else if (StringUtil.isNotNull(command) && command.equals("jbba")) {%>
	<script>
		location.href = 'http://tradecampus.kita.net/front/ContentPage.do?cmd=contentPage&p_contentid=76&p_outmenuid=410&p_elearning=Y';
	</script>
<%} else if (StringUtil.isNotNull(command) && command.equals("sbc")) {%>
	<script>
		location.href = 'http://tradecampus.kita.net/front/ContentPage.do?cmd=contentPage&p_contentid=81&p_outmenuid=419&p_elearning=Y';
	</script>
<%} else if (StringUtil.isNotNull(command) && command.equals("gwd")) {%>
	<script>
		goMenu('608', '608');
/* 		location.href = 'http://tradecampus.kita.net/front/SubjectF.do?cmd=compSubjectMain&p_trainingclass=09&p_upperclass=2000&p_middleclass=2011&p_lowerclass=2114&p_contentid=83&p_outmenuid=421'; */
	</script>
<%} else if (StringUtil.isNotNull(command) && command.equals("dg")) {%>
	<script>
		goMenuOff('524', '524');	//지부연수 대구경북 페이지로 이동
		//location.href = '/front/SubjectF.do?cmd=compSubjectMain&p_trainingclass=09&p_upperclass=2000&p_middleclass=2010&p_lowerclass=2107&p_contentid=86&p_outmenuid=391';
	</script>
<%} else if (StringUtil.isNotNull(command) && command.equals("dc")) {%>
	<script>
		location.href = '/front/SubjectF.do?cmd=compSubjectMain&p_trainingclass=09&p_upperclass=2000&p_middleclass=2010&p_lowerclass=2104&p_contentid=73&p_outmenuid=392';
	</script>
<%} else if (StringUtil.isNotNull(command) && command.equals("gn")) {%>
	<script>
		location.href = '/front/SubjectF.do?cmd=compSubjectMain&p_trainingclass=09&p_upperclass=2000&p_middleclass=2010&p_lowerclass=2106&p_contentid=80&p_outmenuid=414';
	</script>
<%} %>

<%
	//팝업 공지사항을 가져온다.
	DataSet dsPopNotiList = (DataSet)box.getObject("dsPopNotiList");

	//공지사항 리스트를 가져온다.
	DataSet noticeList = (DataSet)box.getObject("NoticeList");

	// 이러닝 과정을 가져온다.
	//DataSet subjTraining09VOs = (DataSet)box.getObject("SubjTraining09VOs");	
	
	//신규과정
	//DataSet newSubjVOs = (DataSet)box.getObject("newSubjVOs");
	//추천과정
	//DataSet recomSubjVOs = (DataSet)box.getObject("recomSubjVOs");
	//인기과정
	//DataSet favorSubjVOs = (DataSet)box.getObject("favorSubjVOs");	
%>
<script language="javascript">
<!--
addLoadEvent(doPopNotice); //onload함수에 추가

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
'<div id="popnotice_<%=v_hgrcode%>_<%=v_seq%>" style="border:1px solid #cccccc;position:absolute; left:<%=v_left%>px; top:<%=v_top%>px; z-index:100;display:;">'+
'<table width="<%=v_width %>" height="100%" cellpadding="0" cellspacing="0">'+
'<tr>'+
'	<td align="center" height="100%" valign="top">'+
'		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="FFFFFF">'+
'		<tr>'+
'			<td height="42" background="/images/common/popup_header_bg.gif">'+
'				<table width="100%" border="0" cellpadding="0" cellspacing="0" ondrag="layer_move(\'popnotice_<%=v_hgrcode%>_<%=v_seq%>\', event);">'+
'				<colgroup>'+
'					<col width="69" />'+
'					<col width="" />'+
'					<col width="10" />'+
'				</colgroup>'+
'				<tr>'+
'					<td><img src="/images/common/popup_notice_title.gif"></td>'+
'					<td align="right" style="color: #ffffff; font-size: 11px;"></td>'+
'					<td></td>'+
'				</tr>'+
'				</table>'+
'			</td>'+
'		</tr>'+
'		<tr>'+
'			<td height="100%" valign="top" align="center" style="padding:20px;">'+
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
'				<tr><td height="5"></td></tr>'+
'				<tr><td height="2" bgcolor="#c7c7c7"></td></tr>'+
'				<tr>'+
'					<td bgcolor="#f4f4f4" style="padding:15px 10px 10px 10px;">'+
'						<table width="100%" cellpadding="0" cellspacing="0">'+
'						<tr>'+
'							<td style="border: solid 1px #ececec; padding:10px; line-height:20px; font-size:11px; background-color:#FFFFFF;" height="100%" valign="top">'+
'								<%=StringUtil.ReplaceAll(v_content,"\r\n","")%>'+
'							</td>'+
'						</tr>'+
'						<tr><td height="7"></td></tr>'+
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

function menuClick_tab_3(idx){
	try{
		for(var i=1 ; i<=3 ; i++){

			objLayer = document.getElementById("tab_3_0"+i);
			if(i == idx){
				objLayer.style.display = "block";
			}else{
				objLayer.style.display = "none";
			}
		}
	}catch(err){

	}
}




//샘플동영상 미리보기 배너 마우스 오버 / 마우스 아웃 스크립트
function showSampleCon(num){
	
		jQuery("#sample0"+num+"_0").stop().animate({
			opacity:'0.4'
		}, 400, function(){});
		jQuery("#sample0"+num+"_1").stop().animate({
			opacity:'0.8'
		}, 400, function(){});
		jQuery("#sample0"+num+"_2").stop().animate({
			opacity:'0.8'
		}, 400, function(){});
}
function noshowSampleCon(num){
	
		jQuery("#sample0"+num+"_0").stop().animate({
			opacity:'1.0'
		}, 400, function(){});
		jQuery("#sample0"+num+"_1").stop().animate({
			opacity:'0.0'
		}, 400, function(){});
		jQuery("#sample0"+num+"_2").stop().animate({
			opacity:'0.0'
		}, 400, function(){});
	
}

//샘플강의팝업
function showPreview(arg1, arg2){
	var url = "" ;
	if(arg1 == "Y") {
		url = "/front/Contents.do?cmd=sampleContentsFrame&p_contsid="+arg2;
		Contents_Popup2(url, "CourseContents", '1024','700','yes');
	}else {
		url = arg2 ;
		Contents_Popup4(url, "CourseContents", '1024','700', 'yes');
	}

}
function showPreview2(arg1){	//링크과정 샘플강의	
	var url = arg1;
		Contents_Popup2(url, "CourseContents", '1024','700','yes');
		
}
function showPreview3(arg1){	//인도과정 플래시 안내 이미지	
	var url = arg1;
	window.open(url, "CourseContents", 'width=620,height=500');
		
}

//-->
</script>
<script type="text/javascript">
<!--

    function fncShow(sel) {
        for (var i = 1; i <= 2; i++) {
            var div = document.getElementById('dv' + i);
            if (i == sel) div.style.display = 'none';
            else div.style.display = 'block';
        }
    }
    //-->
</script>
<style type="text/css">
<!--
body {margin:0; padding:0; background:#fff;}
#slidebox{position:relative; border:1px solid #ccc; margin:0px auto;overflow:hidden;}
#slidebox, #slidebox ul {width:814px;height:300px;}
#slidebox, #slidebox ul li{width:814px;height:300px;}
#slidebox ul li{position:relative; left:0; background:#eee; float:left;list-style: none; padding:0px 0px;  font-family:Verdana, Geneva, sans-serif; font-size:13px;}
#slidebox .next, #slidebox .previous{position:absolute; z-index:2; display:block; width:38px; height:51px;top:125px;}
#slidebox .next{right:0; margin-right:10px; background:url(/images/common/slidebox_next.gif) no-repeat left top;}
#slidebox .next:hover{background:url(/images/common/slidebox_next_hover.gif) no-repeat left top;}
#slidebox .previous{margin-left:10px; background:url(/images/common/slidebox_previous.gif) no-repeat left top;}
#slidebox .previous:hover{background:url(/images/common/slidebox_previous_hover.gif) no-repeat left top;}
#slidebox .thumbs{position:absolute; z-index:2; top:280px; right:10px;}
#slidebox .thumbs a{display:block; margin-left:5px; float:left; font-family:Verdana, Geneva, sans-serif; font-size:9px; text-decoration:none; padding:2px 4px; background:url(/images/common/slidebox_thumb.png); color:#fff;}
#slidebox .thumbs a:hover{background:#fff; color:#000;}
#slidebox .thumbs .thumbActive{background:#fff; color:#000; display:block; margin-left:5px; float:left; font-family:Verdana, Geneva, sans-serif; font-size:9px; text-decoration:none; padding:2px 4px;}
.elearning_main_td_class{line-height: 0px; font-size: 0px;}
-->
</style>

<!--  레이어 팝업 div-->
<div id="layerPopupBox" style="position:absolute;z-index:4">
</div>
<!-- //레이어 팝업 div 끝-->
<center>
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="10" height="34">&nbsp;</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" bgcolor="#315D8C"><table width="1024" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="814" height="300" valign="top" bgcolor="#FFFFFF">
	        <div id="slidebox">
				<div class="next"></div>
				<div class="previous"></div>
				<div class="thumbs">
					<a href="#" onClick="" class="1 thumbActive">1</a> 
					<a href="#" onClick="" class="2">2</a> 
					<a href="#" onClick="" class="3">3</a> 						
					<a href="#" onClick="" class="4">4</a>
					<a href="#" onClick="" class="5">5</a>
					<!-- <a href="#" onClick="" class="5">5</a> -->
					<!-- <a href="#" onClick="" class="6">6</a>
					<a href="#" onClick="" class="7">7</a> -->
				</div>
				<ul>
				   	<!-- <li><a href="http://tradecampus.kita.net/front/BbsBoard.do?cmd=bbsBoardShowForm3&p_boardid=24&p_seq=52&p_outmenuid=33"><img border="0" alt='' src='/flash/home0/elearning/img/img5.jpg' alt="수강료할인이벤트"></a></li> -->
				   	<li><a href="javascript:goMenu('616');"><img border="0" alt='' src='/flash/home0/elearning/img/img7.jpg' alt="인도네시아지역전문가과정"></a></li>
				   	<li><a href="javascript:goMenu('582');"><img border="0" alt='' src='/flash/home0/elearning/img/img4.jpg' alt="인도지역전문가과정"></a></li>
				   	<li><a href="#"><img border="0" alt='' src='/flash/home0/elearning/img/img0.jpg' alt="무역실무 기초와 실전을 한꺼번에! Let's learn together 사례로 배우는 실전무역실무"></a></li>
					<li><a href="#"><img border="0" alt='' src='/flash/home0/elearning/img/img1.jpg' alt="우리회사 수출경쟁력을 올려보자! FTA활용의 바이블 아는만큼 앞서가는 FTA활용 전략과정 원산지관리전담자교육 점수 10점 인정"></a></li>
					<li><a href="javascript:goMenu('364', '168')"><img border="0" alt='' src='/flash/home0/elearning/img/img3.jpg' alt="비즈니스 영어에 대한 답은 Biz-Master시리즈로!!"></a></li>
<!-- 				   	<li><a href="javascript:goMenu('368');"><img border="0" alt='' src='/flash/home0/elearning/img/img6.jpg' alt="지역전문가과정"></a></li> -->
<!-- 					<li><a href="javascript:goMenu('4')"><img border="0" alt='' src='/flash/home0/elearning/img/img2.jpg' alt="무역전시회 120%활용의 비법 바이어를 사로잡는 전시마케팅 과정"></a></li> -->
				</ul>
			</div>
        </td>
        <td width="200" valign="top" bgcolor="#FFFFFF">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><img src="/images/home0/main/main_customer_top.gif" alt="E러닝 고객센터"></td>
				</tr>
				<tr>
					<td><a href="#" onClick="goMenuUrl('90','/front/Faq.do?cmd=faqList&p_faqcategory=0005');" ><img src="/images/home0/main/main_customer1.gif" alt="FAQ"></a></td>
				</tr>
				<tr>
					<td><a href="mailto:smartkita@kita.net"><img src="/images/home0/main/main_customer2.gif" alt="시스템 장애문의"></a></td>
				</tr>
				<tr>
					<td><a href="http://939.co.kr/kitahelp" target="_blank"><img src="/images/home0/main/main_customer3.gif"  alt="원격 서비스"></a></td>
				</tr>
				<tr>
					<td><a href="#" onClick="Center_Fixed_Popup2('/jsp/front/common/homepage/popInformation.html', '동영상시청안내',740,700, 'yes');"><img src="/images/home0/main/main_customer4.gif" alt="동영상 시청안내"></a></td>
				</tr>
				<tr>
					<td><a href="#" onClick="goMenu('162');"><img src="/images/home0/main/main_customer5.gif" alt="환급제도 안내"></a></td>
				</tr>
				<tr>
					<td><img src="/images/home0/main/main_customer_bottom.gif" alt=""></td>
				</tr>
			</table>
		</td>
      </tr>
    </table></td>
  </tr>
</table>
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30"></td>
  </tr>
</table>

<!-- 수정_2013.12.09 -->
<table width="1024" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
	<td width="100%"><!-- big td1 //-->
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
		  <tr><!--  tr1//-->
		    <td width="10" align="left" valign="top" rowspan="5" class="elearning_main_td_class">&nbsp;</td><!--//blank1  -->
		    
		    
			<td width="392" align="left" valign="top"  rowspan="3" height="400" style="line-height: 0px; font-size: 0px;" class="elearning_main_td_class">
			<img usemap="#experts" src="/images/home0/elearning/main/banner/banner_01.jpg"/>
			<map name="experts">
				<area alt="인도전문가 샘플강의보기" shap="rect" onfocus="this.blur();" coords="47, 66, 140, 90"	href="javascript:showPreview3('/jsp/front/common/opencourse/regional_experts.jsp');">
				<area alt="베트남전문가 샘플강의보기"  shap="rect" onfocus="this.blur();" coords="255, 66, 347, 88"	href="javascript:showPreview('Y' , '0000270');">
				<area alt="인도전문가 과정리스트" shap="rect" onfocus="this.blur();" coords="1, 109, 196, 398"	href="javascript:goMenu('582');">
				<area alt="베트남전문가 과정리스트"  shap="rect" onfocus="this.blur();" coords="198, 109, 390, 398"	href="javascript:goMenu('583');">
			</map>
						
				<a href="javascript:showPreview3('/jsp/front/common/opencourse/regional_experts.jsp');" onfocus="showSampleCon('1')" ></a>
			</td>
			<!--// 샘플배너1 -->
		    
		    <td width="16" align="left" valign="top" rowspan="3" class="elearning_main_td_class">&nbsp;</td><!--//blank2  -->
		    <!-- Banner2 -->
		    <td width="402" height="188" align="center" valign="top" colspan="3" class="elearning_main_td_class">
		    	<a href="javascript:showPreview2('http://www.ddnet.co.kr/cylang/class/preview/E47A/intro/intro_b2b.htm');">
		    		<img src="/images/home0/elearning/main/banner/banner_02.jpg" width="402" height="188" alt="신 일본어 능력시험 한권으로 끝내기 샘플 강의 GO">
		    	</a>
		    </td>
		    <!--// Banner2  -->
		    <td width="16" align="left" valign="top" rowspan="5" class="elearning_main_td_class">&nbsp;</td><!--//blank3  -->
		 </tr><!--//tr1  -->
		    
		  <tr  height="5"><!-- tr2 //-->
		  	<td height="5" colspan="3" class="elearning_main_td_class">&nbsp;</td>
		  </tr><!--//tr2  -->
		    
		  <tr><!-- tr3 //-->
		  <!-- 샘플배너3 
		    자바스크립트 showSampleCon(num) 사용할것
		    이미지 파일명[2개] = banner_0[배너번호]_on1.jpg / banner_0[배너번호]
		    id명[4개] = sample0[배너번호], sample0[배너번호]_0, sample0[배너번호]_1, sample0[배너번호]_2 
		    아래폼 그대로 이용 사이즈 및 아이디명만 변경
		    -->
		  <!-- 3번배너 -->
			  	<td height="207"  style="line-height: 0px; font-size: 0px;" align="left">
			  		<div  id='sample03' onmouseover="showSampleCon('3')" onmouseout="noshowSampleCon('3')" style="margin-top:-100px;" >
						<!-- 마우스오버되면 사라질 이미지 -->
						<div style="width:193px; height:0px; position:relative;  background-color:#000000; "> 
							<img src="/images/home0/elearning/main/banner/banner_03_on.jpg"/>
						</div>
						<div  id="sample03_0"   style="width:193px; height:0px; position:relative;  background-color:#000000;  z-index:5000;">
						<!-- 링크 거는 위치 --> 
						<a href="javascript:showPreview('Y', '0000238');"  onfocus="showSampleCon('4')" ><img src="/images/home0/elearning/main/banner/banner_03.jpg"   /></a>
						</div>				
						<div id='sample03_1' style=" width:200px; height:30px; display:inline; z-index:5100; position:relative; opacity:0.0; float:left; left:0; top:0; background-color:#000; color:#fff; font-size:12px;"> 
							<!-- 샘플강의 상단타이틀 --> 
							<table style="width:392px; height:30px; padding: 20px;  padding: 10px;">
								<tr><td style="color: white;">
								<b>무역관리사 대비(종합)</b>
								</td></tr></table>
						</div>
						<div id='sample03_2' style=" width:200px; height:50px;   display:inline; z-index:5100; position:relative; opacity:0.0; float:left; left:0; top:124px;  background-color: #000;  color:#fff; font-size:12px;"> 
							<table  style="width:180px; height:30px; padding: 10px; margin: 10px;"><tr><td>
							무역의 기초적인 이론과 무역 비즈니스 영어를 학습하여 실질적...
							</td></tr></table>
						</div>
						<!-- 마우스오버되면 나타날 텍스트들 -->							
					</div>	
					
			  		<!-- <a href="#">
			  			<img alt="신흥시장 무역 증진을 위한 온라인 강좌" src="/images/home0/elearning/main/banner/banner_04.jpg" height="207">
			  		</a> -->
		  		</td><!-- td4 -->
			  	
			  	<td width="6" align="left" valign="top">&nbsp;</td><!-- td5 -->
			  	<!-- 샘플배너4 -->
			  	<td height="207" width="193" style="line-height: 0px; font-size: 0px;" align="left">
			  		<div  id='sample04' onmouseover="showSampleCon('4')" onmouseout="noshowSampleCon('4')" style="margin-top:-100px;" >
						<!-- 마우스오버되면 사라질 이미지 -->
						<div style="width:193px; height:0px; position:relative;  background-color:#000000; "> 
							<img src="/images/home0/elearning/main/banner/banner_04_on.jpg"/>
						</div>
						<div  id="sample04_0"   style="width:193px; height:0px; position:relative;  background-color:#000000;  z-index:5000;">
						<!-- 링크 거는 위치 --> 
						<a href="javascript:showPreview('Y', '0000239');"  onfocus="showSampleCon('4')" ><img src="/images/home0/elearning/main/banner/banner_04.jpg"   /></a>
						</div>				
						<div id='sample04_1' style=" width:190px; height:30px; display:inline; z-index:5100; position:relative; opacity:0.0; float:left; left:0; top:0; background-color:#000; color:#fff; font-size:12px;"> 
							<!-- 샘플강의 상단타이틀 --> 
							<table style="width:392px; height:30px; padding: 20px;  padding: 10px;">
								<tr><td style="color: white;">
								<b>20일 초단기완성 국제무역사</b>
								</td></tr></table>
						</div>
						<div id='sample04_2' style=" width:190px; height:50px;   display:inline; z-index:5100; position:relative; opacity:0.0; float:left; left:0; top:124px;  background-color: #000;  color:#fff; font-size:12px;"> 
							<table  style="width:180px; height:30px; padding: 10px; margin: 10px;"><tr><td>
							국제 무역사 핵심정리를 통한<br> 자격증 취득!!
							</td></tr></table>
						</div>
						<!-- 마우스오버되면 나타날 텍스트들 -->							
					</div>	
					
			  		<!-- <a href="#">
			  			<img alt="신흥시장 무역 증진을 위한 온라인 강좌" src="/images/home0/elearning/main/banner/banner_04.jpg" height="207">
			  		</a> -->
		  		</td><!-- td6 -->
		  		<!--// 샘플배너4 -->
		  		
		  </tr><!--//tr3  -->
		   
		  <tr><!--  tr4//-->  
			  <td height="17" colspan="5"></td><!--//td4  -->
		  </tr><!--// tr4  -->

		  <tr><!-- tr5 -->
		  	<td>
		  		<a href="http://tradecampus.kita.net/front/Common.do?cmd=goHtmlPage&p_path=elearning&p_page=course_page_05&p_outmenuid=354">
		  			<img alt="고객맞춤형 패키지 강좌 신입사원 무역 실무 과정 바로가기" src="/images/home0/elearning/main/banner/banner_05.jpg" height="189" width="392">
		  		</a>
		  	</td><!--//td2  -->
		  	<td width="15"></td> <!--//td3 --> 
		  	<td colspan="3">
		  			<img alt="온라인 교육 시행 주요 고객사" src="/images/home0/elearning/main/banner/banner_06.jpg" height="189" width="402">
		  	</td><!--//td4  -->
		  </tr><!--// tr5 -->
		    
		   
		</table>
		    
	</td><!--// big td1  -->
	
	
	<td width="16"  align="center" valign="top" class="elearning_main_td_class"></td> <!--// big td2 -->

		
    <td width="196"  height="188" align="center" valign="top" class="elearning_main_td_class"><!--  big td3//-->
    
    	<table cellpadding ="0" cellspacing ="0" style="vertical-align: top; width:100%;">
		    <tr>
		    <td>
			    <!-- Notice -->
			    	<table cellpadding="0" cellspacing="0" style="vertical-align: top; width: 100%;">
			    	<% 
			    	int notice_bg_row_cnt = 0;
			    		if(noticeList!=null||noticeList.getRow()>0){
			    			notice_bg_row_cnt = noticeList.getRow();
			    		}
			    		notice_bg_row_cnt +=4;
			    	%> <%-- 수정_2013.12.09_공지사항의 갯수 --%>
			      		<tr>
			      			<td rowspan="<%=notice_bg_row_cnt %>" width="3" class="elearning_main_td_class"><img alt="" width="3" src="/images/home0/elearning/main/notice/bg_01.jpg"></td>
			        		<td width="190"  valign="middle" style="height: 46px;" class="elearning_main_td_class"  background="/images/home0/elearning/main/notice/bg_02.jpg">
									<!-- <a href="#"> -->
										<img src="/images/home0/elearning/main/notice/news.jpg" alt="뉴스/공지사항" border="0" >
									<!-- </a>  -->
			          		</td>
			        		<td rowspan="<%=notice_bg_row_cnt %>" width="3" class="elearning_main_td_class"><img alt="" width="3" src="/images/home0/elearning/main/notice/bg_03.jpg"></td>
			      		</tr>
			      		<!-- 공지사항 -->
			      		<%
			      			if (noticeList != null && noticeList.getRow() > 0) {
			      				while (noticeList.next()) {
			      		%>
			      		<tr>
			        		<td height="24" style="color:#5f5f5f">
			        			<!-- <img src="/images/home0/main/point.gif" border="0" alt="">&nbsp; -->
			        			<a href="#none" style="text-align: left; float: left;" onClick="goMenuUrl('33', '/front/BbsBoard.do?cmd=bbsBoardShowForm3&p_boardid=<%=noticeList.getString("BOARDID") %>&p_seq=<%=noticeList.getString("SEQ") %>')"><%=StringUtil.cropByte(noticeList.getString("TITLE"), 16) %></a>
			        			<% if ("Y".equals(noticeList.getString("NEWTERMYN"))) { %>
			        				<img src="/images/home0/main/new_bt.gif" border="0" align="absmiddle" alt="">
			        			<% } %>
			        		</td>
			        		<%-- <td style="color:#5f5f5f"><%=DateTimeUtil.getDateType(1, noticeList.getString("INDATE")) %></td> --%>
			      		</tr>
			      		
			      		<%
			      				}
			      		 	} 
			      		 %>
			      		 <tr>
			      		 	<td width="70" height="20" align="right">
			      		 		<a href="#" onclick="goMenuUrl('33','/front/BbsBoard.do?cmd=bbsBoardPageListeLeanrning&p_boardid=24&p_hgrcode=3')">
			      		 			<img src="/images/home0/elearning/main/notice/more.jpg" border="0" alt="MORE">
			      		 		</a>
			      		 	</td>
			      		 </tr>
			      		<tr>
			      			<td width="196" height="0" class="elearning_main_td_class" valign="top">
				  				<img alt="" src="/images/home0/elearning/main/notice/bg_bottom.jpg" height="1"  width="190">
			  				</td>
			      		</tr>
			    	</table><!--// Notice-->
		    	</td>
		    	</tr>
		    	
		    	<tr>	<!--blank /-->
		    		<td class="elearning_main_td_class" height="7"></td>
		    	</tr>
		    	
		    	<tr><!--  quick//-->
		    		<td rowspan="3"  width="196"  style="vertical-align: top; width: 196">
				  		<table  style="vertical-align: top; width: 100%; table-layout: fixed;" >
				  			<tr  style="width: 100%;">
				  				<td rowspan="4" width="3" class="elearning_main_td_class"><img alt="" width="3" src="/images/home0/elearning/main/quick/bg_01.jpg"></td>
				  				<td colspan="2" style="width: 190px; vertical-align: bottom; height: 44px;" class="elearning_main_td_class" background="/images/home0/elearning/main/quick/bg_02.jpg">
				  				<img alt="스마트러닝 서비스 안내" src="/images/home0/elearning/main/quick/menu.jpg"/>
				  				</td>
				  				<td rowspan="4" width="3" class="elearning_main_td_class"><img alt="" width="3" src="/images/home0/elearning/main/quick/bg_03.jpg"></td>
				  			</tr>
				  			<tr>
				  				<td class="elearning_main_td_class" >
				  					<a href="javascript:goMenu('93')">
				  						<img alt="마일리지 적립" onmouseover="this.src='/images/home0/elearning/main/quick/icon_01_on.jpg';" src="/images/home0/elearning/main/quick/icon_01_off.jpg"  onmouseout="this.src='/images/home0/elearning/main/quick/icon_01_off.jpg'" >
				  					</a>
			  					</td>
				  				<td class="elearning_main_td_class">
				  					<a href="javascript:goMenu('94')">
				  						<img alt="모바일 수강지원" onmouseover="this.src='/images/home0/elearning/main/quick/icon_02_on.jpg';" src="/images/home0/elearning/main/quick/icon_02_off.jpg"  onmouseout="this.src='/images/home0/elearning/main/quick/icon_02_off.jpg'">
				  					</a>
				  				</td>
				  			</tr>
				  			<tr>
				  				<td class="elearning_main_td_class">
				  					<a href="#" onclick="window.open('http://tradecampus.kita.net/jsp/front/common/homepage/popDontCopy.html','', 'width=750,height=600,scrollbars=yes');">
				  						<img alt="모사답안방지대책" onmouseover="this.src='/images/home0/elearning/main/quick/icon_03_on.jpg';" src="/images/home0/elearning/main/quick/icon_03_off.jpg"  onmouseout="this.src='/images/home0/elearning/main/quick/icon_03_off.jpg'">
				  					</a>
				  				</td>
				  				<td class="elearning_main_td_class">
				  					<a href="http://webdocu.kita.net" target="_blank">
				  						<img alt="증명서 발급" onmouseover="this.src='/images/home0/elearning/main/quick/icon_04_on.jpg';" src="/images/home0/elearning/main/quick/icon_04_off.jpg"  onmouseout="this.src='/images/home0/elearning/main/quick/icon_04_off.jpg'">
				  					</a>
				  				</td>
				  			</tr>
				  			<tr>
				  				<td colspan="2" width="196" height="0" class="elearning_main_td_class" valign="top">
				  					<img alt="" src="/images/home0/elearning/main/quick/bg_bottom.jpg" height="1"  width="190">
				  				</td>
			  				</tr>
				  			<tr>
				  				<td height="8px;" colspan="2" class="elearning_main_td_class"></td>
				  			</tr>
				  			<tr><td colspan="2" class="elearning_main_td_class"><img alt="학습상담 : 02)6000-5595 02)6000-5224 시스템오류장애 : 02)6000-7139 상담가능시간 평일 : 09:00~18:00 토/일/공휴일 휴무" src="/images/home0/elearning/main/cs/img.jpg"></td></tr>
				  		</table>
				  		
				  	</td>
		    	</tr><!--//quick  -->
    	</table>
    </td><!--// big td3  -->

</tr>
</table>
    




<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="50">&nbsp;</td>
  </tr>
</table>
</center>
<script type="text/javascript">
jQuery(function bottom_banner () {
	jQuery(".bottom_banner").jCarouselLite({
        btnNext: ".bottom_next",
        btnPrev: ".bottom_prev",
        visible: 6
    });
});
jQuery(function() {
	jQuery("#slidebox").jCarouselLite({
		vertical: false,
		hoverPause:true,
		btnPrev: ".previous",
		btnNext: ".next",
		visible: 1,
		start: 0,
		scroll: 1,
		circular: true,
		auto:3000,
		speed:700,				
		btnGo:
		    [".1", ".2", ".3", ".4", ".5"],
		
		afterEnd: function(a, to, btnGo) {
				if(btnGo.length <= to){
					to = 0;
				}
				$(".thumbActive").removeClass("thumbActive");
				$(btnGo[to]).addClass("thumbActive");
		    }
	});
});
</script>

<!---  quick_mu  ---->
<style>
#content {}
#floater {position: absolute; left:expression((document.body.clientWidth/2)+470); top:0px; visibility:visible;}

</style>

<span ID="floater">
	<div class="quick" id="quickmenu"></div>
</span>

<!-- 
<SCRIPT LANGUAGE="JavaScript">
	self.onError=null;

	currentX = currentY = 0;
	whichIt = null;
	lastScrollX = 0; lastScrollY = -155;

	NS = (document.layers) ? 1 : 0;
	IE = (document.all) ? 1: 0;

	function heartBeat() {

		if(IE) { diffY = document.body.scrollTop; }
		if(NS) { diffY = self.pageYOffset; }

		if(diffY != lastScrollY) {
					percent = .1 * (diffY - lastScrollY);
					if(percent > 0) percent = Math.ceil(percent);
					else percent = Math.floor(percent);
					if(IE) document.all.floater.style.pixelTop += percent;
					if(NS) document.floater.top += percent;
					lastScrollY = lastScrollY + percent;
		}
	}

	if(NS || IE) action = window.setInterval("heartBeat()",1);

</SCRIPT> 
-->
<!---  quick_mu end  ---->

<!-- SiteLink menu -->
<fmtag:dwrcommon interfaceName="SiteLinkFWork"/>
<script type="text/javascript">

function jsSiteLinkList() {
	clearInterval(intervalid);
	var f = document.formSiteLink;
	var v_hgrcode = "<%=G_HGRCODE%>";
	var v_comp    = "<%=box.getString("s_comp") %>";
	var v_category    = "<%=G_SYSTEM%>";
	var linkParam = { p_hgrcode:v_hgrcode, p_comp:v_comp, p_category:v_category };
	var topImg = "<li class='li_title'><img src='/images/home<%=G_HGRCODE %>/common/quickmenu_top.gif' border='0'></li>";
	var bottomImg = "<li class='li_title'><img src='/images/home<%=G_HGRCODE %>/common/quickmenu_bottom.gif' border='0'></li>";

	callCnt = 0;
	SiteLinkFWork.siteLinkDataCallBack(linkParam,jsSiteLinkListCall);
}
function jsSiteLinkListCall(ds){

	try {
	    var info;
	    var bannerRight = "";
	    var bannerLeft = "";
	    var bannerQuick = "";
	    var checkScript = "";
	    var checkUrl = "";

		if(ds != null && ds.length > 0){
			for(var i = 0; i < ds.length;i++){
				info		=	ds[i];
				//alert(info[0]);
				if(info[0] == "L"){			// 좌측배너
					checkScript = info[1].indexOf("javascript:");
					checkUrl = info[1].substring(0,1);
					if(checkScript >= 0 || checkUrl == "#"){	// href위치에서 함수호출시
						bannerLeft   +=	"<li style='padding:0px 0 0px 0;'><A HREF=\""+info[1]+"\"><img src='"+info[2]+"' border='0'></A></li>";
					}else{
						if(checkUrl == "@"){	// onlick위치에서 함수호출시
							bannerLeft   +=	"<li style='padding:0px 0 0px 0;'><A HREF='#' onClick=\""+info[1].substring(1,info[1].length)+"\"><img src='"+info[2]+"' border='0'></A></li>";
						}else{					// 기타선언 없을경우 새창띄우기
							bannerLeft   +=	"<li style='padding:0px 0 0px 0;'><A HREF='#' onClick=\"window.open('"+info[1]+"','KITA','width=1000,height=700,left=0,top=0,scrollbars=yes,resizable=yes,menubar=yes,toolbar=yes,location=yes,status=yes');\"><img src='"+info[2]+"' border='0'></A></li>";
						}
					}// if checkScript

				}else if(info[0] == "R"){	// 우측배너
					checkScript = info[1].indexOf("javascript:");
					checkUrl = info[1].substring(0,1);
					if(checkScript >= 0 || checkUrl == "#"){    // href위치에서 함수호출시
						bannerRight  +=	"<li class='li_title'><A HREF=\""+info[1]+"\"><img src='"+info[2]+"' border='0'></A></li>";
					}else{
						if(checkUrl == "@"){    // onlick위치에서 함수호출시
							bannerRight  +=	"<li class='li_title'><A HREF='#' onClick=\""+info[1].substring(1,info[1].length)+"\"><img src='"+info[2]+"' border='0'></A></li>";
						}else{                  // 기타선언 없을경우 새창띄우기
							bannerRight  +=	"<li class='li_title'><A HREF='#' onClick=\"window.open('"+info[1]+"','KITA','width=1000,height=700,left=0,top=0,scrollbars=yes,resizable=yes,menubar=yes,toolbar=yes,location=yes,status=yes');\"><img src='"+info[2]+"' border='0'></A></li>";
						}

					}// if checkScript

				}else if(info[0] == "Q"){	// 퀵메뉴
					//alert(info[1]);
					checkScript = info[1].indexOf("javascript:");
					checkUrl = info[1].substring(0,1);
					if(checkScript >= 0 || checkUrl == "#"){    // href위치에서 함수호출시
						bannerQuick  +=	"<li class='li_title'><A HREF=\""+info[1]+"\"><img src='"+info[2]+"' border='0'></A></li>";
					}else{
						if(checkUrl == "@"){    // onlick위치에서 함수호출시
							bannerQuick  +=	"<li class='li_title'><A HREF='#' onClick=\""+info[1].substring(1,info[1].length)+"\"><img src='"+info[2]+"' border='0'></A></li>";
						}else{                  // 기타선언 없을경우 새창띄우기
							bannerQuick  +=	"<li class='li_title'><A HREF='#' onClick=\"window.open('"+info[1]+"','KITA','width=1000,height=700,left=0,top=0,scrollbars=yes,resizable=yes,menubar=yes,toolbar=yes,location=yes,status=yes');\"><img src='"+info[2]+"' border='0'></A></li>";
						}

					}// if checkScript
				}
			}
		}
		 
		//alert(bannerRight);
		//if(bannerRight != null)	document.getElementById("quickmenu").innerHTML = "<ul>"+topImg+bannerRight+bottomImg+"</ul>";

		if(bannerQuick != "")	{
			var temp = '<img src="/images/template0/common/btn_popup_confirm_2.gif">';
			bannerQuick = temp + bannerQuick;
			
			var clientwidth = 0;
			var menu = 1024;
			var empty = 0;
			var x = 0;
			var y = 140;
			
			clientwidth = document.body.clientWidth;
			empty = (clientwidth - menu)/2;
			x = menu + empty + 50;
			
			document.getElementById("floater").style.position = 'fixed';
			document.getElementById("floater").style.left = x + 'px';
			document.getElementById("floater").style.top = y + 'px';
			document.getElementById("quickmenu").innerHTML = "<ul>"+bannerQuick+"</ul>";
		}
		if(bannerLeft != "")	{
			document.getElementById("leftbanner").innerHTML = "<ul>"+bannerLeft+"</ul>";
		}
		if(bannerRight != "")	{
			document.getElementById("rightbanner").innerHTML = "<ul>"+bannerRight+"</ul>";
		}

	} catch (e) {
		//callCnt++;
		//if ( callCnt < 10 ) {
			//SiteLinkFWork.siteLinkDataCallBack(linkParam,jsSiteLinkListCall);
		//}
	}
}
var intervalid = setInterval(jsSiteLinkList);

</script>

<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript">
//창크기 변화가 발생할 때마다 퀵메뉴바 재정렬
$(window).resize(function(){
	jsSiteLinkList();
});

</script>
<!-- //SiteLink menu -->