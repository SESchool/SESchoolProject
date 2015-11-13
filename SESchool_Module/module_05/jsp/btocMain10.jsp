<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/front/common/commonBasicInc.jsp"%>
<%@ page import="java.util.Calendar"%>

<%
	//팝업 공지사항을 가져온다.
	DataSet dsPopNotiList = (DataSet) box.getObject("dsPopNotiList");

	// 공지사항 리스트를 가져온다.
	DataSet noticeList = (DataSet) box.getObject("NoticeList");

	// IT교육센터  과정을 가져온다.
	DataSet RecruitTraining04VOs = (DataSet) box.getObject("RecruitTraining04VOs");
	
	//연간일정
	DataSet ictYearScDs = (DataSet)box.getObject("ictYearScDs");	
%>
<script language="javascript">
<!--
addLoadEvent(doPopNotice); //onload함수에 추가

function doPopNotice() {
<%
	if (dsPopNotiList != null) {
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
		while (dsPopNotiList.next()) {
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
			if (v_popuptype.equals("A")) {%>
				if ( getCookie("popnotice_<%=v_hgrcode%>_<%=v_seq%>") == null ) {
					Center_Fixed_Popup2("/front/PopNotice.do?cmd=popNoticePopup&p_hgrcode=<%=v_hgrcode%>&p_seq=<%=v_seq%>", "PopNotice<%=v_hgrcode%><%=v_seq%>", parseInt(<%=v_width%>), parseInt(<%=v_height%>), "yes");
				}
<%
			// 레이어공지사항
			} else if (v_popuptype.equals("B")) {%>
				if ( getCookie("popnotice_<%=v_hgrcode%>_<%=v_seq%>") == null ) {
					document.getElementById("layerPopupBox").innerHTML +=
					'<Div id="popnotice_<%=v_hgrcode%>_<%=v_seq%>" style="border:1px solid #cccccc;position:absolute; left:<%=v_left%>px; top:<%=v_top%>px; z-index:3;display:;">'+
					'<table width="<%=v_width%>" height="100%" cellpadding="0" cellspacing="0">'+
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
					'					<td align="right" style="color: #ffffff; font-size: 11px;">'+
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
					'								<%=StringUtil.ReplaceAll(v_content, "\r\n", "")%>'+
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
//-->
</script>
<script type="text/javascript" language="JavaScript"  src="/js/home/jcarousellite_1.0.1c5.js"></script>
<script>
		$(function(){
				$("#slidebox").jCarouselLite({
					btnPrev: ".previous"
					,btnNext: ".next"
					,hoverPause:true
					,scroll: 1
					,start : 0
					/* 배너 개수만큰 아래 btnGo 추가 */
				  	,btnGo : [
				  	          slide_1,
				  	          slide_2/*,
				  	          slide_3 ,
				  	          slide_4,
				  	          slide_5		 */		  	          
				  	          ]
					,mouseWheel : true
					,circular : true
					,speed : 700
					/* ,easing :  "bounceout" */
					,visible : 1
					,vertical : false
					,auto : 3000 
					 ,afterEnd: function(a, to, btnGo) {
						if(btnGo.length <= to){
							to = 0;
						}
						$("[id^='slide_']").removeClass("thumbActive");
						$(btnGo[to]).addClass("thumbActive");

						$("[id^='slide_img_']").attr("src","/images/home0/main/slide_bottom_off.png");
						$("#slide_img_"+(to+1)).attr("src","/images/home0/main/slide_bottom_on.png");
						
				    } 
				});	
		}); 



		function slideStatusChange(){			
			var statusVal = $('#slide_status_hidden_id').val();
			if(statusVal ==1){
				$('#slide_status_id').attr('src','/images/home0/main/slide_bottom_play.jpg');
			}
			if(statusVal ==-1){
				$('#slide_status_id').attr('src','/images/home0/main/slide_bottom_pause.jpg');
			}
			
			$('#slide_status_hidden_id').val(statusVal*=-1);
			alert();
		}
		
		//연간일정 탭메뉴
		function change_scTab(tabNum){
			if(tabNum=='1'){
				document.getElementById("sc_first").style.display = 'block';
				document.getElementById("sc_second").style.display = 'none';				
			}else{
				document.getElementById("sc_first").style.display = 'none';
				document.getElementById("sc_second").style.display = 'block';
			}
		}
</script>

<!--  레이어 팝업 div-->
<div id="layerPopupBox" style="position: absolute;"></div>
<!-- //레이어 팝업 div 끝-->


<!-- 배너 및 일정 -->
<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td height="75"><!-- 배너위 여백 --></td>
	</tr>
	<tr>
		<td align="center"  style="background-repeat: no-repeat; background-position: top center;">
			<table width="896" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<!-- 슬라이드배너 -->
					<td width="540" height="300">
						<!-- 슬라이드배너 -->
						<div id="slidebox" style="width: 100%;">
								<div class="thumbs">
										<ul>
											<!-- 배너 갯수만큰 아래 li추가 -->
											<!-- <li><a href="http://tradecampus.kita.net/front/SubjSeqF.do?cmd=compSubjSeqMain&p_trainingclass=04&next=compSubjSeqApplyMain&p_isapply=Y&p_contentid=06&p_outmenuid=47"><img src="/swf/img/btoc10_banner4.jpg" width="540"  height="300" alt="SC마스터 29기 모집" /></a></li> -->
											<!-- <li><a href="#"><img src="/swf/img/btoc10_banner2.jpg" width="540"  height="300" alt="공인시험센터 운영" /></a></li> -->
											<li><a href="http://tradecampus.kita.net/front/BbsBoard.do?cmd=bbsBoardShowForm2&p_boardid2=13&p_seq=76&p_boardid=2&p_outmenuid=91"><img src="/swf/img/btoc10_banner5.jpg" width="540"  height="300" alt="SC마스터 30기" /></a></li>										
											<!-- <li><a href="javascript:goMenu('213');"><img src="/swf/img/btoc10_banner1.jpg" width="540"  height="300" alt="사전학습반모집" /></a></li> -->
											<!-- <li><a href="http://tradecampus.kita.net/front/BbsBoard.do?cmd=bbsBoardShowForm&p_boardid=13&p_seq=59&p_outmenuid=312"><img src="/swf/img/btoc10_banner3.jpg" width="540"  height="300" alt="28기 모집" /></li> -->										
											<!-- <li><a href="#"><img src="" width="540"  height="300" /></a></li>										
											<li><a href="#"><img src="" width="540"  height="300" /></a></li> -->										
										</ul>
								</div>
								<!-- 이미지배너아래  위치표시 동그라미 -->
								<div align="center" style="position:absolute; z-index:2; right:10px; top: 275px;">
									<!-- 배너 갯수만큰 아래 div추가(id, class명 잘맞출것) -->									
										<div style="border-width: 0px; float: left; cursor: pointer; " class="1" id="slide_1">
											<img alt=""  src="/images/home0/main/slide_bottom_on.png"  id="slide_img_1">
										</div>									
										<div style="border-width: 0px; float: left; cursor: pointer; " class="2" id="slide_2">
											<img alt=""  src="/images/home0/main/slide_bottom_off.png"  id="slide_img_2">
										</div>
										<!-- <div style="border-width: 0px; float: left; cursor: pointer; " class="3" id="slide_3">
											<img alt=""  src="/images/home0/main/slide_bottom_off.png"  id="slide_img_3">
										</div> -->
									<!--	<div style="border-width: 0px; float: left; cursor: pointer; " class="4" id="slide_4">
											<img alt=""  src="/images/home0/main/slide_bottom_off.png"  id="slide_img_4">
										</div>
									<div style="border-width: 0px; float: left; cursor: pointer; " class="5" id="slide_5">
											<img alt=""  src="/images/home0/main/slide_bottom_off.png"  id="slide_img_5">
										</div>
									-->						
								</div>
								<!--// 이미지배너아래  위치표시 동그라미 -->
								
								<!-- 좌로이동버튼 div -->
								<div align="center" style="position:absolute; z-index:2; left:0px; top: 125px;" class="previous" ><img src="/images/home0/main/slide_arrow_L.png" /></div>
								<!-- 우로이동버튼 div -->
								<div align="center" style="position:absolute; z-index:2; right:0px; top: 125px;" class="next" ><img src="/images/home0/main/slide_arrow_R.png" /></div>
						</div>
						<!--// 슬라이드배너 -->
					
					</td>
					<!--// 슬라이드배너 -->
					
					<td width="15"></td>
					
					<!-- 퀵메뉴 및 시험일정 --> 
					<td width="340" height="300">
						<!-- 퀵메뉴 -->
						<table  width="341" height="300">
							<tr  width="341" height="115" style="background: url('/images/home0/main/submain10_quick_bg.jpg'); " >
								<td  style=" cursor: pointer; "><img onclick="goMenu('213')" src="/images/home0/main/submain10_bt_propose_off.jpg" alet="사전학습반신청 바로가기" onmouseout="imgExchange_main(this)" onmouseover="imgExchange_main(this)" /></td>
								<td width="2"><img src="/images/home0/main/submain10_gubun_line.jpg" /></td>
								<td  style=" cursor: pointer; "><img  onclick="goMenu('210')" src="/images/home0/main/submain10_bt_centerinfo_off.jpg" alet="시험센터 안내"   onmouseout="imgExchange_main(this)" onmouseover="imgExchange_main(this)"  /></td>
								<td  width="2"><img src="/images/home0/main/submain10_gubun_line.jpg" /></td>
								<td  style=" cursor: pointer; "><img  onclick="goMenu('458')" src="/images/home0/main/submain10_bt_location_off.jpg" alet="오시는길"   onmouseout="imgExchange_main(this)" onmouseover="imgExchange_main(this)" /></td>
							</tr>
						<!-- //퀵메뉴 -->
						
							<tr width="" height="15"><td colspan="5"></td></tr>
							
						<!-- 시험일정 -->
							<tr>
								<td colspan="5">
								<!-- 상반기일정 -->
									<table style="display: block;"  id="sc_first" >
										<tr height="45"  style=" cursor: pointer; ">
											<td><img src="/images/home0/main/submain10_bt_first_on.jpg" alet="상반기일정"  onclick="change_scTab('1')" /> </td>
											<td><img src="/images/home0/main/submain10_bt_second_off.jpg" alet="하반기일정"  onclick="change_scTab('2')"  /></td>
										</tr>
										<tr height="125">
											<td colspan="2" style=" border-bottom: 1px solid #9D9D9D;">
												<div style="overflow-x:hidden; overflow-y:auto; width: 340px; height: 125px; ">
												<table width="340" border="0"  >
													<colgroup>
														<col width="170" />
														<col width="170" />
													</colgroup>
													<tr style="background-color: #E8E8E8; height: 25px; border-top:1px solid #9D9D9D; border-bottom: 1.5px solid #9D9D9D;" >
														<td>일 시</td><td style="border-left: 1px solid #9D9D9D;">내 용</td>
													</tr>										
													<!-- 일정반복 -->
													<%if(ictYearScDs.getRow()>0){ 
															while(ictYearScDs.next()){
																if(ictYearScDs.getInt("MON")>6) continue;	// 전체 리스트중 6월까지만 출력
														%>
															<tr style="height: 25px; border-bottom: 1px solid #9D9D9D;" >
																<td><%=ictYearScDs.getString("YEAR")%>. <%=ictYearScDs.getString("MON")%>. <%=ictYearScDs.getString("DAY")%></td>
																<td style="border-left: 1px solid #9D9D9D;"><%= ictYearScDs.getString("TESTNM")%></td>
															</tr>										
														<%
															}
														}else{ %>
														<tr style=" height: 99px; border-bottom: 1px solid #9D9D9D;" >
															<td colspan="2" >등록된 일정이 없습니다</td>
														</tr>
													<%} %>
													<!-- //일정반복 -->
												</table>
												</div>
											</td>
										</tr>
									</table>
								<!--// 상반기일정 -->
								<!-- 하반기일정 -->
									<table style="display: none;" id="sc_second" >
										<tr height="45" style=" cursor: pointer; ">
											<td><img src="/images/home0/main/submain10_bt_first_off.jpg" alet="상반기일정" onclick="change_scTab('1')" /> </td>
											<td><img src="/images/home0/main/submain10_bt_second_on.jpg" alet="하반기일정"  onclick="change_scTab('2')"  /></td>
										</tr>
										<tr height="125">
											<td colspan="2" style=" border-bottom: 1px solid #9D9D9D;">
												<div style="overflow-x:hidden; overflow-y:auto; width: 340px; height: 125px; ">
												<table width="340" border="0" >
													<colgroup>
														<col width="170" />
														<col width="170" />
													</colgroup>
													<tr style="background-color: #E8E8E8; height: 25px; border-top:1px solid #9D9D9D; border-bottom: 1.5px solid #9D9D9D;" >
														<td>일 시</td><td style="border-left: 1px solid #9D9D9D;">내 용</td>
													</tr>										
													<!-- 일정반복 -->
													<%if(ictYearScDs.getRow()>0){
															ictYearScDs.first();
															while(ictYearScDs.next()){
																if(ictYearScDs.getInt("MON")<7) continue;	//전체리스트중 6월 이후것만 출력
														%>
															<tr style="height: 25px; border-bottom: 1px solid #9D9D9D;" >
																<td><%=ictYearScDs.getString("YEAR")%>. <%=ictYearScDs.getString("MON")%>. <%=ictYearScDs.getString("DAY")%></td>
																<td style="border-left: 1px solid #9D9D9D;"><%= ictYearScDs.getString("TESTNM")%></td>
															</tr>										
														<%
															}
														}else{ %>
														<tr style=" height: 99px; border-bottom: 1px solid #9D9D9D;" >
															<td colspan="2">등록된 일정이 없습니다</td>
														</tr>
													<%} %>
													<!-- //일정반복 -->
												</table>
												</div>
											</td>
										</tr>
									</table>
								<!--// 상반기일정 -->
								</td>
							</tr>
						<!-- //시험일정 -->
						</table>
						
					
					</td>				
					<!-- //퀵메뉴 및 시험일정 --> 
				</tr>
			</table> 
		</td>
	</tr>
</table>
<!-- //배너 및 일정 -->



<table width="895" cellpadding="0" cellspacing="0" border="0">
<!-- 구분선 -->
<tr>
	<td colspan="3" height="25"></td>
</tr>
<tr>
	<td colspan="3" height="15"><img src="/images/home<%=G_HGRCODE%>/main/submain10_gubun_line_2.jpg" /> </td>
</tr>
<!-- //구분선 -->
</table>


<!-- 공지사항 / 모집중인과정 리스트 -->
<table width="895" cellpadding="0" cellspacing="0" border="0">
<!-- 구분선 -->
<tr>
	<td colspan="3" height="15"></td>
</tr>
<!-- //구분선 -->


<tr>
	<!-- 공지사항 -->
	<td width="440" height="160">
		<table width="430">
			<tr  height="20">
				<td valign="top" align="left"><img src="/images/home<%=G_HGRCODE%>/main/submain10_notice_title.gif" alt="공지사항"></td>
				<td align="right" valign="middle"><a href="#none" onClick="goMenu('474')"><img src="/images/home<%=G_HGRCODE%>/main/btn_submain10_more.gif" alt="MORE"></a></td>
			</tr>	
			<tr>
				<td height="140">
					<table width="100%" cellpadding="1" cellspacing="1" border="0">
							<colgroup>
								<col width="7" />
								<col width="" />
								<col width="70" />
							</colgroup>
							<%
								if (noticeList != null && noticeList.getRow() > 0) {
									while (noticeList.next()) {
							%>
							<tr height="25">
								<td><img src="/images/home<%=G_HGRCODE%>/main/bullet_dot_notice_submain12.gif" alt=""></td>
								<td align="left"><a href="#none" onClick="goMenuUrl('474','/front/BbsBoard.do?cmd=bbsBoardShowForm&p_boardid=<%=noticeList.getString("BOARDID")%>&p_seq=<%=noticeList.getString("SEQ")%>')"><%=StringUtil.cropByte(noticeList.getString("TITLE"), 34)%></a>
									<%
										if (noticeList.getString("NEWTERMYN").equals("Y")) {
									%>		&nbsp;<img src="/images/home<%=G_HGRCODE%>/common/icon_new.gif" alt=""> <%
 										}
 									%>
 								</td>
								<td align="right"><%=DateTimeUtil.getDateType(1,noticeList.getString("INDATE"), ".")%></td>
							</tr>
							<%
									}//while
								} else {
							%>
							<tr height="18">
								<td colspan="3" valign="top">등록된 공지사항이 없습니다.</td>
							</tr>
							<%
								}
							%>
						</table>
				</td>
			</tr>	
		</table>
	</td>
	<!--// 공지사항 -->
	
	<!-- 구분선 -->
	<td  width="50" height="160">
		<img src="/images/home<%=G_HGRCODE%>/main/submain10_gubun_line.jpg" height="100%" width="2" />
	</td>
	<!--// 구분선 -->
	
	<!-- 모집중인과정 -->
	<td  width="440" height="160">
		<table width="430">
			<tr   height="20">
				<td align="left"><img src="/images/home<%=G_HGRCODE%>/main/submain10_lecture_title.gif" alt="모집중인 과정"></td>
			</tr>
			<tr>
				<td height="140" valign="top" style=" padding-top: 15px; ">
					<table>
						<colgroup>
							<col width="40" />
							<col width="340" />
							<col width="50" />
						</colgroup>
						<%
							if (RecruitTraining04VOs != null && RecruitTraining04VOs.getRow() > 0) {								
						%>
							<%while(RecruitTraining04VOs.next()){ %>
							<tr>
								<td>
									<table width="100%" cellpadding="0" cellspacing="0" border="0">
										<tr>
											<td style="border: solid 1px #dadada;"><img
												src="/jsp/common/viewImg.jsp?fileGubun=subj&sFileName=<%=RecruitTraining04VOs.getString("SUBJIMG")%>"
												width='40' height='40' /> <!-- <img src="/images/home<%=G_HGRCODE%>/main/submain10_lecture_sample.gif">  -->
											</td>
										</tr>
									</table>
								</td>
								
								<td style="padding-left: 7px;" align="left">
								<%
									if ("2324".equals(RecruitTraining04VOs.getString("SUBJ"))) {
								%>
									<p style="font-weight: bold; padding-bottom: 6px;">
										<a href="http://tradecampus.kita.net/front/SubjectF.do?next=getViewCompSubject2&cmd=getViewCompSubject&body=http://tradecampus.kita.net/jsp/front/common/propose/subjSeqProposeViewMain.jsp&p_subj=2324&p_subjseq=0002&p_year=2012&p_isonoff=isOnOff&p_outmenuid=431"><%=StringUtil.cropByte(RecruitTraining04VOs.getString("SUBJNM"), 20)%></a>
									</p>
									<p>
										<a href="http://tradecampus.kita.net/front/SubjectF.do?next=getViewCompSubject2&cmd=getViewCompSubject&body=http://tradecampus.kita.net/jsp/front/common/propose/subjSeqProposeViewMain.jsp&p_subj=2324&p_subjseq=0002&p_year=2012&p_isonoff=isOnOff&p_outmenuid=431"><%=DateTimeUtil.getDateType(1,RecruitTraining04VOs.getString("EDUSTART"),".")%>~<%=DateTimeUtil.getDateType(1,RecruitTraining04VOs.getString("EDUEND"),".")%></a>
									</p> 
								<%
										} else {
									%>
									<p style="font-weight: bold; padding-bottom: 6px;">
										<a href="#" onClick="goPopCurriculum('<%=RecruitTraining04VOs.getString("ISONOFF")%>','<%=RecruitTraining04VOs.getString("SUBJ")%>','<%=RecruitTraining04VOs.getString("SUBJSEQ")%>','<%=RecruitTraining04VOs.getString("YEAR")%>')"><%=StringUtil.cropByte(RecruitTraining04VOs.getString("SUBJNM"), 30)%></a>
									</p>
									<p>
										<a href="#" onClick="goPopCurriculum('<%=RecruitTraining04VOs.getString("ISONOFF")%>','<%=RecruitTraining04VOs.getString("SUBJ")%>','<%=RecruitTraining04VOs.getString("SUBJSEQ")%>','<%=RecruitTraining04VOs.getString("YEAR")%>')"><%=DateTimeUtil.getDateType(1,RecruitTraining04VOs.getString("EDUSTART"),".")%>~<%=DateTimeUtil.getDateType(1,RecruitTraining04VOs.getString("EDUEND"),".")%></a>
									</p> 
								<%
										}
									%>
								</td>
								
								
								<td style="padding-right: 5px">
									<%
										if ("2324".equals(RecruitTraining04VOs.getString("SUBJ"))) {
									%> <a href="http://tradecampus.kita.net/front/SubjectF.do?next=getViewCompSubject2&cmd=getViewCompSubject&body=http://tradecampus.kita.net/jsp/front/common/propose/subjSeqProposeViewMain.jsp&p_subj=2324&p_subjseq=0002&p_year=2012&p_isonoff=isOnOff&p_outmenuid=431"><img src="/images/home0/common/btn_register01.gif" alt="수강신청"/></a> <%
											} else {
										%> <a href="#"
									onClick="goPopProposeForm('<%=RecruitTraining04VOs.getString("isonoff")%>','<%=RecruitTraining04VOs.getString("SUBJ")%>','<%=RecruitTraining04VOs.getString("SUBJSEQ")%>','<%=RecruitTraining04VOs.getString("YEAR")%>')"><img src="/images/home0/common/btn_register01.gif" alt=""/></a> <%
											}
										%>
								</td>					
							</tr>
							<%} %>
						<%} else{ %>
						<tr><td colspan="3" width="450" height="100" >현재 모집중인 과정이 없습니다</td></tr>
						<%} %>
					</table>
				</td>
			</tr>
		</table>
	</td>
	<!--// 모집중인과정 -->
</tr>



<tr>
	<td colspan="3" height="15"></td>
</tr>
</table>

 <!-- //공지사항 / 모집중인과정 리스트 -->


<table width="895" cellpadding="0" cellspacing="0" border="0">
<!-- 구분선 -->
<tr>
	<td colspan="3" height="15"><img src="/images/home<%=G_HGRCODE%>/main/submain10_gubun_line_3.jpg" /> </td>
</tr>
<tr>
	<td colspan="3" height="30"></td>
</tr>
<!-- //구분선 -->
</table>



<fmtag:dwrcommon interfaceName="ContactReqFaction" />
<script type="text/javascript">
		function onEnter() {
			if(event.keyCode == 13) {
				jsContactReq();
			}		
		}				
/*		function SetNull(key){ 
			key.style.background = '#101010'; 
		}
		function SetDefaultName(key){
			if (key.value == '') {
				key.style.background = '#101010 url(/images/home<%=G_HGRCODE%>/main/submain5_input_name_bg.gif) no-repeat';
			}
		}

		function SetDefaultMobile(key){
			if (key.value == '') {
				key.style.background = '#101010 url(/images/home<%=G_HGRCODE%>/main/submain5_input_mobile_bg.gif) no-repeat';
			}
		}		
*/		
		function jsContactReq() {			
			var f = document.formContactReq;
			var v_userid = "<%=box.getString("s_userid")%>";

		if (v_userid == "") {
			alert("로그인 후 이용해주시기 바랍니다.");
			return false;
		}
		if (f.getName.value == "") {
			alert("이름을 입력해주세요.");
			f.getName.focus();
			return false;
		}
		if (f.getMobile.value == "") {
			alert("핸드폰번호를 입력해주세요.");
			f.getMobile.focus();
			return false;
		}

		var linkParam = {
			p_name : f.getName.value,
			p_telno : f.getMobile.value,
			p_userid : v_userid
		};
		ContactReqFaction.insertContactReqDataCallBack(linkParam,
				jsContactReqDataCall);
	}
	function jsContactReqDataCall(resultInt) {
		var f = document.formContactReq;
		SetDefaultName(document.getElementById('getName'));
		SetDefaultMobile(document.getElementById('getMobile'));

		if (resultInt > 0) {
			msg = "감사합니다. 상담이 성공적으로 접수되었습니다!";
		} else {
			msg = "상담을 접수하는데 실패하였습니다.";
		}
		alert(msg);
	}
</script>


<%
String V_MAINFLASH = box.getStringDefault("s_mainrandomflash","0");
if (V_MAINFLASH.equals("1") && G_SYSTEM.equals("1")) { 
%>
<!--  main 2 quick banner -->
<!---  quick_mu  ---->
		<style>
		#content {}
		#floater {position: absolute; left:expression((document.body.clientWidth/2)+430); top:0px; visibility:visible;}
		</style>
 
		<span ID="floater">
		<div ID="content" >
			<script language="javascript">
			function rQuickLink(n){
				var url = "";
				if(n==0){
					url = "javascript:courseQuickSearch()";
				}else if(n==1){
					url = "javascript:goMenu('68')";
				}else if(n==2){
					url = "javascript:goMenu('73')";
				}else if(n==3){
					url = "javascript:goMenu('90')";
				}else if(n==4){
					url = "javascript:goMenu('300')";
					//url = Center_Fixed_Popup2('/jsp/front/home0/home/popup_edu_schedule.jsp', 'popup_edu_schedule',1000,730, 'no'); return;
				}else if(n==5){
					url = window.open('http://webdocu.kita.net/','');return;
				}else if(n==6){
					url = "javascript:goMenu('300')";
					//url = window.open('/jsp/front/home0/home/popup_edu_schedule.jsp','popup_edu_schedule','scrollbars=no,width=1000,height=730,left=0,top=0');return;
				}else if(n==7){
					<% if(G_USERID.equals("")){ %>
							url = "javascript:alert('로그인후 이용해 주세요')"; 
					<% }else { %>
							url = "javascript:ehrdMainForm()"; 
					<% } %>
				}else if(n==8){
					url = "javascript:goMenu('89')";				
				}else if(n==9){
					url = Center_Fixed_Popup2('/upload/eBrochure/WTAeBrochure.pdf', 'WTAeBrochure',800,565, 'yes');return;
				}				
				location.href=url;
			}
			</script>
 
			<table cellpadding="0" cellspacing="0" border="0" style="margin-top:21px; margin-left:22px;">
			<tr>
				<td>
					<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="88" height="372" id="rBanner" align="middle">
					<param name="allowScriptAccess" value="sameDomain" />
					<param name="allowFullScreen" value="false" />
					<param name="movie" value="/flash/home0/rquicklink.swf" />
					<param name="quality" value="high" />
					<PARAM name="wmode" VALUE="transparent">
					<embed src="/flash/home0/rquicklink.swf" quality="high" bgcolor="#ffffff" width="88" height="372" name="rQuickLink" align="middle" allowScriptAccess="sameDomain" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
					</object>
				</td>
			</tr>
			</table>
		</div>
		</span>
 
		<SCRIPT LANGUAGE="JavaScript">
			self.onError=null;
 
			currentX = currentY = 0;
			whichIt = null;
			lastScrollX = 0; lastScrollY = -130;
 
			NS = (document.layers) ? 1 : 0;
			IE = (document.all) ? 1: 0;
 
			function heartBeat() {
 
				if(IE) { diffY = document.body.scrollTop; }				
				if(NS) { diffY = self.pageYOffset; }
				
				if(diffY > 50 ) diffy = 50; 
				if(diffY != lastScrollY && ( diffY < 50 ||   lastScrollY < 50 )  ) {
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
		<!---  quick_mu end  ---->

<%
}
else { 
%>
<!---  quick_mu  ---->
		<style>
		#content {}
		#floater {position: absolute; left:expression((document.body.clientWidth/2)+<%=G_SYSTEM.equals("1")?"467":"450"%>); top:0px; visibility:visible;}
		</style>

		<span ID="floater">
			<div class="quick" id="quickmenu"></div>
		</span>

		<%-- 
		<SCRIPT LANGUAGE="JavaScript">
			var G_SYSTEM = <%=G_SYSTEM%>;
			self.onError=null;

			currentX = currentY = 0;
			whichIt = null;
			if(G_SYSTEM == 1){
				lastScrollX = 0; lastScrollY = -140;	//190
			}else{
				lastScrollX = 0; lastScrollY = -115;	//355
			}

			NS = (document.layers) ? 1 : 0;
			IE = (document.all) ? 1: 0;

			function heartBeat() {

				if(IE) { diffY = document.body.scrollTop + 50; }
				if(NS) { diffY = self.pageYOffset; }
				
				if(diffY > 130 ) diffy = 130; 
				if(diffY != lastScrollY && ( diffY < 130 ||   lastScrollY < 130 ) ) {
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
		--%>

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
					var menu = 896;
					var empty = 0;
					var x = 0;
					var y = 135;
					
					clientwidth = document.body.clientWidth;
					empty = (clientwidth - menu)/2;
					x = menu + empty + 50;
					
					document.getElementById("floater").style.position = 'fixed';
					document.getElementById("floater").style.left = x + 'px';
					document.getElementById("floater").style.top = y + 'px';
					document.getElementById("quickmenu").innerHTML = "<ul>"+bannerQuick+"</ul>";
				}
				if(bannerLeft != "") {
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
		// 창크기 변화가 발생할 때마다 퀵메뉴바 재정렬
		$(window).resize(function(){
			jsSiteLinkList();
		});
		
		</script>
		<!-- //SiteLink menu -->
<% } 
%>	
