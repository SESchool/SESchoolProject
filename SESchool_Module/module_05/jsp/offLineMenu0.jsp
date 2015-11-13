<%@page import="com.sinc.lms.contents.OpenSubjAttBaction"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/jsp/front/common/commonBasicInc.jsp"%>
<link rel="stylesheet" href="/css/style_v3.css" />
<%
	 
	 String[] V_MENUTITLE = G_MENUORDER.split(",");
	 String V_MENUTITLEORDER = "";
	 for (int i = 0; i < V_MENUTITLE.length; i++) {
	 if (i > 0)
	 V_MENUTITLEORDER += "_";
	 V_MENUTITLEORDER += V_MENUTITLE[i];
	 }
	 String checkmenuid="";
	 if(session.getAttribute("e_menuid")!=null){
	 checkmenuid=(String)session.getAttribute("e_menuid");
	 }
%>

<center>

	<table width="100%" border="0" cellpadding="0" cellspacing="0"
		bgcolor="#5b9ecf">
		<tr>
			<td height="4"></td>
		</tr>
	</table>

	<table border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="15">
				<%-- <%=session.getAttribute("e_menuid") %> --%>
			</td>
		</tr>
	</table>
	
	<!-- sub_contents -->

	<table cellpadding="0" cellspacing="0" width="1024">
		<colgroup>
			<col width="200" />
			<col width="24" />
			<col width="800" />
		</colgroup>
		<tr>
			<td valign="top">
				<%
					DataSet V_MAINMENUDS = CommonUtil.getBtocMainMenuList(G_HGRCODE,
							G_SYSTEM);
					int size = 0;
					if (V_MAINMENUDS != null && V_MAINMENUDS.getRow() > 0) {
						V_MAINMENUDS.next();
						size = V_MAINMENUDS.getInt("MAINCNT");
						V_MAINMENUDS.setPos();
					}
					int V_MAINWIDTH = 100 / size;
				%>
				<table  cellpadding="0" cellspacing="0" border="0"  >
					<tr><td height="15"></td></tr>
					<%
					if (session.getAttribute("e_menuid") != null && !checkmenuid.equals("") ) {
							//간단설명 타이틀 배너 
							if ("2_4".equals(G_SYSTEM + "_" + G_MAINMENUORDER)) {
					%>
					<tr>
						<td><a href="javascript:goMenu('464');"><img
								src="/images/home0/title/lefttitle_<%=G_SYSTEM%>_<%=G_MAINMENUORDER%>.gif"></a>
						</td>
					</tr>
					<tr height="10"><td></td></tr>
					<%
						} else {
					%>
					<tr>
						<td><img
							src="/images/home0/title/lefttitle_<%=G_SYSTEM%>_<%=G_MAINMENUORDER%>.gif"></td>
					</tr>
					<tr height="10"><td></td></tr>
					<%
						}
						}
					%>
					<%
						int V_IDX = 0, V_MENUID = 0, V_PARENTMENUID = 0, V_DEPTH = 0, V_SUBMENUCNT = 0;
						String V_SUBMENUID = "", V_REALMENUID = "", V_MENUNM = "", V_MENUORDER = "", V_PREMENUORDER = "", V_SUBMENUORDER = "", V_MENUORDER2 = "", V_CURMENU = "", V_URL = "", V_POPYN = "", V_CONTROL = "";
						String V_NAVINM = "", V_NAVINM1 = "", V_NAVIMENUORDER = "";
						String V_SUBMENUURL = "", V_SUBMENUNM = "", V_GROUPSIGN = "N";
						String V_SUBMENUGBIMG = "";
						String V_MENUDIV2 = "";
						String V_PMENUID = "";
						int v_menucnt = 0;
						int cnt = 0;
						if (size > 0) {
							while (V_MAINMENUDS.next()) {
								cnt++;
								V_MENUID = V_MAINMENUDS.getInt("MENUID");
								V_PARENTMENUID = V_MAINMENUDS.getInt("PARENTMENUID");
								V_DEPTH = V_MAINMENUDS.getInt("DEPTH");
								V_MENUORDER = V_MAINMENUDS.getString("MENUORDER");
								V_MENUNM = V_MAINMENUDS.getString("MENUNM");
								V_URL = V_MAINMENUDS.getString("URL");
								V_POPYN = V_MAINMENUDS.getString("POPUPYN");
								V_SUBMENUID = V_MAINMENUDS.getString("SUBMENUID");
								V_SUBMENUURL = V_MAINMENUDS.getString("SUBURL");
								V_SUBMENUNM = V_MAINMENUDS.getString("SUBMENUNM");
								V_SUBMENUORDER = V_MAINMENUDS.getString("SUBMENUORDER");
								V_SUBMENUCNT = V_MAINMENUDS.getInt("SUBMENUCNT");
								V_REALMENUID = V_MAINMENUDS.getString("REALMENUID");
								V_GROUPSIGN = V_MAINMENUDS.getString("GROUPSIGN");
								if (V_DEPTH == 2) {
									V_MENUDIV2 = V_MENUORDER; //V_MENUDIV2 = 상위메뉴 번호
					%>
					<tr height="1" class="menu_all" >
						<td valign="top" >
							<table cellpadding="0" cellspacing="0" border="0" >
								<tr>
									<td>
										<%
											if (V_REALMENUID.equals("") && V_URL.equals("")) {//실이동id가 없고 url값도 없으면 a태그에 링크를 달지 않음
										%> 
										<a onclick="opensubClick('<%=V_MENUID%>');"  href="#"><img style="cursor:pointer;"  src="/images/home<%=G_HGRCODE%>/menu/offlineleftmenu_<%=G_SYSTEM%>_<%=V_MENUORDER%>_off.jpg" onMouseOut="imgExchange_menu(this)" onMouseOver="imgExchange_menu(this)" id="menu<%=V_MENUORDER%>" alt="<%=V_MENUNM%>" /></a>
										 <%}else if(!V_REALMENUID.equals("") || !V_URL.equals("")){%> 
											<a id="<%=V_MENUID%>" class="<%=V_MENUID%>" onmouseover="menuMouseOver(this,'<%=V_MENUORDER%>');" href="javascript:<%if (V_POPYN.equals("N")) {%>goMenuOff('<%=V_REALMENUID.equals("")? V_MENUID: V_REALMENUID%>','<%=V_MENUID%>')<%} else {%>goPopup('<%=V_URL%>')<%}%>;">
											<img src="/images/home<%=G_HGRCODE%>/menu/offlineleftmenu_<%=G_SYSTEM%>_<%=V_MENUORDER%>_off.jpg" onMouseOut="imgExchange_menu(this)" onMouseOver="imgExchange_menu(this)" id="menu<%=V_MENUORDER%>" alt="<%=V_MENUNM%>" /></a>
										 <%}else {%> 
										 <a onmouseover="menuMouseOver(this,'<%=V_MENUORDER%>');" href="javascript:<%if (V_POPYN.equals("N")) {%>goMenuOff('<%=V_REALMENUID.equals("")? V_MENUID: V_REALMENUID%>','<%=V_MENUID%>')<%} else {%>goPopup('<%=V_URL%>')<%}%>;">
											<img src="/images/home<%=G_HGRCODE%>/menu/offlineleftmenu_<%=G_SYSTEM%>_<%=V_MENUORDER%>_off.jpg" onMouseOut="imgExchange_menu(this)" onMouseOver="imgExchange_menu(this)" id="menu<%=V_MENUORDER%>" alt="<%=V_MENUNM%>" /></a>
										 <%
										 	}
										 %></td>
								</tr>
								<tr id="menu_bottom<%=V_MENUID%>">
									<td><img
										src="/images/home<%=G_HGRCODE%>/menu/offlineleftmenu_bottom.jpg" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<%
						} else if (V_DEPTH < 4) {
									
					%>
					<tr>
						<td style="background: url('/images/home0/menu/offlineleftmenu_bg.jpg'); width: 186px; background-repeat: no-repeat;">
							<table id="<%=V_MENUID%>" class="<%=V_PARENTMENUID%>" style="display: none;"  cellpadding="0" cellspacing="0" border="0" >
								<tr>
									<td style="padding-left: 25px; height: 25px;">
										<a href="javascript:<%if (V_POPYN.equals("N")) {%>goMenuOff('<%=V_REALMENUID.equals("") ? V_MENUID : V_REALMENUID%>','<%=V_MENUID%>')<%} else {%>goPopup('<%=V_URL%>')<%}%>;">
											<img src="/images/home<%=G_HGRCODE%>/menu/offlineleftmenu_<%=G_SYSTEM%>_<%=V_MENUDIV2%>_<%=V_MENUORDER%>_off.jpg" onMouseOut="imgExchange_menu(this)" onMouseOver="imgExchange_menu(this)" alt="<%=V_MENUNM%>">
										</a>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<%
						
						}
					%>

					<%
					}
				}
					%>
				</table>
				
				
				 <!-- banner --> <%
			
 	if (G_SYSTEM.equals("1") || G_SYSTEM.equals("2")
 			|| G_SYSTEM.equals("9") || G_SYSTEM.equals("3")
 			|| G_SYSTEM.equals("10") || G_SYSTEM.equals("8")) {
 %>
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
						<%if(checkmenuid.equals("")){ %>
							<td><img
							src="/images/home0/common/sub_helpdesk_img_<%=G_SYSTEM%>.gif"></td>					
						<%
 							}else if ((G_SYSTEM + "_" + G_MAINMENUORDER).equals("9_4")) {
						%>
						<td><img
							src="/images/home0/common/sub_helpdesk_img_<%=G_SYSTEM%>_1.gif"></td>
						<%
							} else if ((G_SYSTEM + "_" + G_MAINMENUORDER).equals("2_11")) {
						%>
						<td><img
							src="/images/home0/common/sub_helpdesk_img_<%=G_SYSTEM%>_11.gif"></td>
						<%
							
/* 							} else if ((G_SYSTEM + "_" + G_MAINMENUORDER + "_" + G_MENUID)
										.equals("2_5_464")
										|| (G_SYSTEM + "_" + G_MAINMENUORDER + "_" + G_MENUID)
												.equals("2_5_384")
										|| (G_SYSTEM + "_" + G_MAINMENUORDER + "_" + G_MENUID)
												.equals("2_5_448")
										|| (G_SYSTEM + "_" + G_MAINMENUORDER + "_" + G_MENUID)
												.equals("2_5_450")) { */
							} else {
						%>
						<td><img
							src="/images/home0/common/sub_helpdesk_img_<%=G_SYSTEM%>.gif"></td>
						<%
							}
						%>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td height="50"></td>
					</tr>
				</table> <%
 	}
 %>
				<div id="leftbanner"></div> <!-- banner //-->

<%-- 현재 위치 
<%out.print(G_SYSTEM + "_" + G_MAINMENUORDER + "_" + G_MENUID); %> --%>



			</td>
			<td width="20"></td>
			<td valign="top" align="left">
			
			<!-- 세부페이지 상단 타이틀 이미지 & 경로 안내 -->
			<table width="800" cellpadding="0" cellspacing="0">
			<tr><td height="15" colspan="3"></td></tr>
			<%
				if (!checkmenuid.equals("") ) {
			%>
				<tr>
					<td><img src="/images/home0/title/pagetitle_<%=V_MENUTITLEORDER %>.gif"></td>
					<td align="right" valign="top">
						<table cellpadding="0" cellspacing="0">
						<tr>
							<td class="locate01">
								<img src="/images/common/icon_home.gif" style="margin-bottom: 7px;">&nbsp;<%=G_MENUNAVI%></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="15" colspan="3"></td></tr>				
			<%
				}
			%>
			</table>
			<!--/ 세부페이지 상단 타이틀 이미지 & 경로 안내 -->
			
			<script type="text/javascript">
     	var openid='';
    	 if(document.getElementById('<%=checkmenuid%>') != undefined ){
    		var pid = jQuery("#<%=checkmenuid%>").attr('class');
    		jQuery("."+pid).show();
    		jQuery("#menu_bottom"+pid).hide();
    		openid=pid;
    	 }
    	 
    	 <%
    	 //지부연수일경우 해당 지역메뉴를 제외한 나머지 지부의 메뉴트리를 숨긴다
    	 if(G_SYSTEM.equals("521")){%>
    	 if(document.getElementById('<%=checkmenuid%>') != undefined ){
    		 var pid = jQuery("#<%=checkmenuid%>").attr('class');
     		jQuery(".menu_all").hide();
    		 jQuery("."+pid).show();
    		 /* alert(pid); */
    	 }
    	 <%}%>
    	 
    	 <%-- else if(jQuery(".<%=(String) session.getAttribute("e_menuid")%>").length>0){
    		 jQuery(".<%=(String) session.getAttribute("e_menuid")%>").show();
    		 jQuery("#menu_bottom<%=(String) session.getAttribute("e_menuid")%>").hide();
    		 openid='<%=(String) session.getAttribute("e_menuid")%>';
    	 } --%>
    	 
    	 function opensub(id){ 
    		 if(jQuery("."+id).length>0){
    			 	jQuery("."+id).show();
    			 	jQuery("#menu_bottom"+id).hide();
    		 }
    	 }
    	 function closesub(id){
    		 
    		 if(id != openid){
	    		 if(jQuery("."+id).length>0){
	    			 /* if(jQuery("."+id).css("display")=="none"){ */
	    			 	jQuery("."+id).hide();
	    			 	jQuery("#menu_bottom"+id).show();
	    			 /* }else{
	    				 jQuery("."+id).hide(); 
	    			 } */
	    		 }
    		 }
    	 }
    	 
    	 function opensubClick(idis){
    		 if(jQuery("."+idis).length>0){
    			 if(jQuery("."+idis).css("display")=="none"){
    			 	jQuery("."+idis).show();
    			 	jQuery("#menu_bottom"+idis).hide();
    			 }else{
    				 jQuery("."+idis).hide(); 
    			 	jQuery("#menu_bottom"+idis).show();
    			 }
    		 }    		 
    	 }
    	 
    	 <%-- alert('<%=(String)session.getAttribute("e_menuid")%>'); --%>
     </script> <!-- </td>
   	</tr>
</table>	 -->

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
	lastScrollX = 0; lastScrollY = -115;

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
			var y = 113;
			
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