<%@page import="com.sinc.lms.contents.OpenSubjAttBaction"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file = "/jsp/front/common/commonBasicInc.jsp"	%>
		<%
		     String[] V_MENUTITLE = G_MENUORDER.split(",");
		     String V_MENUTITLEORDER = "";
		     for(int i =0; i < V_MENUTITLE.length;i++){
		    	  if(i > 0) V_MENUTITLEORDER += "_";
		    	  V_MENUTITLEORDER += V_MENUTITLE[i];
		     }
		%>
		<!-- sub_contents -->
		<table width="896" cellpadding="0" cellspacing="0" border="0">
		<colgroup>
			<col width="186" />
			<col width="38" />
			<col width="672" />
		</colgroup>
		<tr valign="top">
			<td align="left">
				<!-- leftmenu -->
				<table width="186" cellpadding="0" cellspacing="0" border="0" style="margin-bottom:20px;">
				<% if ("2_4".equals(G_SYSTEM + "_" + G_MAINMENUORDER)) {  %>
					<tr>
						<td>
							<a href="javascript:goMenu('464');"><img src="/images/home0/title/lefttitle_<%=G_SYSTEM %>_<%=G_MAINMENUORDER %>.gif"></a>
						</td>
					</tr>
				<% } else {%>
					<tr><td><img src="/images/home0/title/lefttitle_<%=G_SYSTEM %>_<%=G_MAINMENUORDER %>.gif"></td></tr>
				<% } %>
<%

DataSet partSubjMenu = null ;
String gMain = G_SYSTEM+"_"+G_MAINMENUORDER  ;
if ( gMain.equals("3_2") ) {
	OpenSubjAttBaction openSubjAttBaction = new OpenSubjAttBaction();
	HashMap hashMap = new HashMap();
	hashMap.put("p_comp", session.getAttribute("s_comp"));
	hashMap.put("p_classkind","P");
	partSubjMenu = openSubjAttBaction.openSubjAttList(hashMap); 			
}

// FTA FAQ 동영상 자료실일때(트리메뉴)
if ( gMain.equals("11_2")  ) {
%>

<script type="text/JavaScript" language="JavaScript" src="/js/common/dtree_menu.js"></script>
<script type="text/javascript">




var idx = 1;
var seq = 100;
var dTree = new dTree('dTree');
// 트리메뉴의 root
dTree.add(idx, '-1', 'N','','','');
</script>
<%
}else if (gMain.equals("3_2")  ) {
	
	out.println("<script type=\"text/JavaScript\" language=\"JavaScript\" src=\"/js/common/dtree_menu.js\"></script>");
}
%>
<% ArrayList<String> menuList = new ArrayList<String>(); %>
<%
	int V_IDX = 0, V_MENUID = 0, V_PARENTMENUID = 0, V_DEPTH =0;
	String V_SUBMENUID = "", V_MENUNM = "",V_MENUORDER = "",V_SUBMENUORDER = "",V_MENUORDER2 = "",V_URL= "",V_POPYN = "",V_CONTROL="",V_CURMENU = "";
	String V_PMENUID = "" ;
	
	String V_NAVINM1 = "",V_NAVINM2 = "",V_NAVIMENUORDER = "";
	String V_SUBMENUURL = "", V_SUBMENUNM = "";
	int v_menucnt = 0;
	DataSet V_MENUDS = CommonUtil.getSubMenuList(G_HGRCODE,G_MAINMENUID);

	String V_PARENTMENUORDER1 = "",V_PARENTMENUORDER2 = "",V_NAVIMENUORDERTMP = "";
	int idx = 0;
	int lastDepth = 0, depth4Cnt = 0;
	if ( V_MENUDS != null && V_MENUDS.getRow() > 0 ) {
		while ( V_MENUDS.next() ) {
			idx++;
			V_MENUID = V_MENUDS.getInt("MENUID");
			V_DEPTH = V_MENUDS.getInt("DEPTH");
			V_MENUORDER = V_MENUDS.getString("MENUORDER");
			V_MENUNM = V_MENUDS.getString("MENUNM");
			V_URL = V_MENUDS.getString("URL");
			V_POPYN = V_MENUDS.getString("POPUPYN");
			V_SUBMENUURL = V_MENUDS.getString("SUBMENUURL");
			V_PMENUID = V_MENUDS.getString("PARENTMENUID");
			V_CURMENU = V_MENUNM;
			

			// 3depth중에 FTA FAQ 동영상 자료실은 메뉴에서 제외(대신 트리메뉴를 사용하고 있다.)
			if ( V_DEPTH == 3 && !gMain.equals("11_2") ) {
				V_MENUORDER2 = V_MENUORDER;
				if(lastDepth > V_DEPTH && depth4Cnt > 0){ // 4뎁스의 열린거를 닫아준다.
%>
                      	</table>
					</td>
				</tr>           
<%              } %>
                <tr><td>
<%					if ( !V_URL.equals("") ) {
						if ( V_POPYN.equals("N") ) { %>
							<% if (gMain.equals("3_1")) { %>
							<a href="#none" class="leftmenu" onclick="goMenu('<%=V_MENUID%>','<%=V_MENUID%>');"><img src="/images/home0/menu/leftmidmenu_<%=G_SYSTEM %>_<%=G_MAINMENUORDER %>_<%=V_MENUORDER %>_off.gif" onMouseOut="imgExchange_menu(this)" onMouseOver="imgExchange_menu(this)"></a>
							<%} else { %>
							<a href="#none" class="leftmenu" onclick="goMenu('<%=V_MENUID%>');"><img src="/images/home0/menu/leftmidmenu_<%=G_SYSTEM %>_<%=G_MAINMENUORDER %>_<%=V_MENUORDER %>_off.gif" onMouseOut="imgExchange_menu(this)" onMouseOver="imgExchange_menu(this)"></a>
							<%} %>
<%						} else { %>
						<a href="#none" class="leftmenu" onclick="goPopup('<%=V_URL%>');"><img src="/images/home0/menu/leftmidmenu_<%=G_SYSTEM %>_<%=G_MAINMENUORDER %>_<%=V_MENUORDER %>_off.gif" onMouseOut="imgExchange_menu(this)" onMouseOver="imgExchange_menu(this)"></a>
<%						}
					} else { %>
						<a href="#none" class="leftmenu"><img src="/images/home0/menu/leftmidmenu_<%=G_SYSTEM %>_<%=G_MAINMENUORDER %>_<%=V_MENUORDER %>_off.gif" onMouseOut="imgExchange_menu(this)" onMouseOver="imgExchange_menu(this)"></a>
<%					} 

                if ( !V_SUBMENUURL.equals("") ) { %>
					<iframe id="subMenu<%=V_MENUID %>" name="subMenu<%=V_MENUID %>" src="<%=V_SUBMENUURL %>" scrolling="NO"  marginwidth="0" marginheight="0" frameborder="0" vspace="0" hspace="0" style="overflow:visible; width:150px; height:400px; display:block; margin-left:5px" allowTransparency="true"></iframe>
<%				} %>
			    </td></tr>
<%
				depth4Cnt = 0;
				lastDepth = V_DEPTH; 
			}
			// 3depth중에 FTA FAQ 동영상 자료실( 트리메뉴를 사용하고 있다.)
			if ( V_DEPTH == 3 && gMain.equals("11_2") ) {
				%>
				  
				  <script type="text/javascript">
				  dTree.add(++idx, '1', 'N','<%=V_MENUNM%>','<%=V_URL%>',"_self",'<%=V_MENUID%>');
				  </script>
      
				<%
			}
			// 4depth중에 FTA FAQ 동영상 자료실은 메뉴에서 제외(대신 트리메뉴를 사용하고 있다.)
			if ( V_DEPTH == 4 && !gMain.equals("11_2") ) {
				if(depth4Cnt == 0 ) {
					if ( V_MENUID != 302){ // 처음 들어왔을 경우 헤더를 만들어준다.
						out.println("<tr>" ) ;
						out.println("<td style=\" padding-left:13px; padding-bottom:7px;\">" );
						if (gMain.equals("3_1")) {
							out.println("<table id=\"" + V_PMENUID + "\" style=\"display:none\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">" );
							menuList.add(V_PMENUID);
						} else {
							out.println("<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">" );
						}
              		} else {
						out.println("<tr>" ) ;
						out.println("<td style=\"padding-bottom:7px;\">" );
						out.println("<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">" );	
	
					} 
				}
	
				
%>						
						<tr>
							<td>
<% 
								if (V_MENUID == 302) { 
								String upperClass = "" ;
								String middleClass = "" ;
								String lowerClass = "" ;
								String subjClass = "" ;
	
								String fnc = "" ;
%>
								 <script type="text/javascript">
								 
<%
							     int rowNum  = 0 ;
								 if( partSubjMenu != null ) {
									 rowNum = partSubjMenu.getRow() ;
								 }
								 if( rowNum > 0 ) {
									
									out.println(" var dTree = new dTree('dTree');" ) ;
										 // 트리메뉴의 root
								 	if (G_MENUID.equals("294") ) {
										fnc = "main(\"Q\", \"1\",\"\", \"\", \"\"   );" ;									 
									 }else {
										 fnc = "goMenuUrl(\"294\", \"/front/OpenCourse.do?cmd=partSubjMain&p_contentid=51\"  );" ;
									 }										 
								 	out.println("dTree.add(0, '-1', 'N','','','');" ) ;									 

								 }
								 for( int inx = 0 ; inx < rowNum; inx++ ) {
									 partSubjMenu.next() ;
									 upperClass = partSubjMenu.getString("upperclass");
									 middleClass = partSubjMenu.getString("middleclass");
									 lowerClass = partSubjMenu.getString("lowerclass");
									 subjClass =  partSubjMenu.getString("subjClass"); 
									 if ("0000".equals( upperClass ) ) {
										 upperClass= "";
									 }
									 if ("0000".equals( middleClass ) ) {
										 middleClass= "";
									 }		
									 if ("0000".equals( lowerClass ) ) {
										 lowerClass= "";
									 }										 
									 if (G_MENUID.equals("294") ) {
										fnc = "main(\"Q\", \"1\",\""+upperClass+"\", \""+middleClass+"\", \""+lowerClass+"\"   );" ;									 
									 }else {
										 fnc = "goMenuUrl(\"294\", \"/front/OpenCourse.do?cmd=partSubjMain&p_contentid=51&p_upperclass="+upperClass+"&p_middleclass="+middleClass+"&p_lowerclass="+lowerClass+"\"  );" ;
									 }
									 if( lowerClass.equals("") &&  middleClass.equals("")  ) { //대분류
										 out.println(" dTree.add('"+subjClass+"', '0', 'Y','"+partSubjMenu.getString("classname")+"','','_self','', '', '','','', '', '"+fnc+"'); " );
									 }else if ( lowerClass.equals("") &&  !middleClass.equals("") ) { // 중분류
										 out.println( "dTree.add('"+subjClass+"', '"+upperClass+"00000000', 'Y', '"+partSubjMenu.getString("CLASSNAME")+"','"+V_URL+"','_self','"+V_MENUID+"', '', '','','', '', '"+fnc+"');") ;
									 }else { //소분류
										 out.println( "dTree.add('"+subjClass+"', '"+upperClass+middleClass+"0000"+"', 'Y', '"+partSubjMenu.getString("CLASSNAME")+"','"+V_URL+"','_self','"+V_MENUID+"', '', '','','', '', '"+fnc+"');") ;										 
									 }
								 }
								 if( rowNum > 0 ) {
%>

document.write("<tr><td height='5' background='/images/template0/menu/leftmidmenu_top.gif'></td></tr><tr><td background='/images/template0/menu/leftmidmenu_bg.gif' style='padding:0px 0px 0px 7px;'>"+dTree+"</td></tr><tr><td height='15' background='/images/template0/menu/leftmidmenu_bottom.gif'></td></tr>");
dTree.openAll();


<%
									 
								 }
%>
				  					
				  				</script>
								<% } else { %>
								<% if(!V_URL.equals("")){%><a class="leftmenu_1" href="#none" onClick="<%if(V_POPYN.equals("N")){%>goMenu<%}else{%>goPopup<%}%>('<%=V_MENUID%>', '<%=V_PMENUID%>');"><%=V_CURMENU%></a><%}else{%><a class="leftmenu" href="#none"><%=V_CURMENU%></a><%}%>
								<% } %>
						</tr>
						
						
<%			   depth4Cnt++;
               lastDepth = V_DEPTH;
           }
			// 4depth중에 FTA FAQ 동영상 자료실( 트리메뉴를 사용하고 있다.)
		   if ( V_DEPTH == 4 && gMain.equals("11_2") ) {
		       %>
		        <script type="text/javascript">
  				dTree.add(seq++, idx, 'Y', '<%=V_MENUNM%>','<%=V_URL%>',"_self",'<%=V_MENUID%>');
  				</script>
		       <%
		   }
		}
		// 4depth중에 FTA FAQ 동영상 자료실은 메뉴에서 제외(대신 트리메뉴를 사용하고 있다.)
		if(depth4Cnt > 0 && !(G_SYSTEM+"_"+G_MAINMENUORDER).equals("11_2")){ // 4뎁스의 열린거를 닫아준다.
%>
                    	</table>
					</td>
				</tr>           
<%      } 
	}
%>
<%
// FTA FAQ 동영상 자료실일때(트리메뉴)
if ( (G_SYSTEM+"_"+G_MAINMENUORDER).equals("11_2") ) {
%>
<script type="text/javascript">
document.write("<tr><td height='5' background='/images/template0/menu/leftmidmenu_top.gif'></td></tr><tr><td background='/images/template0/menu/leftmidmenu_bg.gif' style='padding:0px 0px 0px 15px;'>"+dTree+"</td></tr><tr><td height='15' background='/images/template0/menu/leftmidmenu_bottom.gif'></td></tr>");
dTree.openAll();
</script>
<%
}
%>
				</table>
				<!-- leftmenu //-->


				<!-- banner -->
<%

if( G_SYSTEM.equals("1") || G_SYSTEM.equals("2")|| G_SYSTEM.equals("9") || G_SYSTEM.equals("3") || G_SYSTEM.equals("10") || G_SYSTEM.equals("8") ) { %>				
				<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<% if((G_SYSTEM+"_"+G_MAINMENUORDER).equals("9_4")) { %>
						<td><img src="/images/home0/common/sub_helpdesk_img_<%=G_SYSTEM%>_1.gif"></td>
					<%}else if((G_SYSTEM+"_"+G_MAINMENUORDER).equals("2_11")) { %>
						<td><img src="/images/home0/common/sub_helpdesk_img_<%=G_SYSTEM%>_11.gif"></td>
					<% } else if ((G_SYSTEM+"_"+G_MAINMENUORDER+"_"+G_MENUID).equals("2_4_464") || (G_SYSTEM+"_"+G_MAINMENUORDER+"_"+G_MENUID).equals("2_4_384") || (G_SYSTEM+"_"+G_MAINMENUORDER+"_"+G_MENUID).equals("2_4_448") || (G_SYSTEM+"_"+G_MAINMENUORDER+"_"+G_MENUID).equals("2_4_450")) { %>
						<td>
							<img usemap="#itab" src="/images/home0/common/sub_helpdesk_img_2.gif">
							<!-- <img usemap="#itab" src="/images/home0/common/itab_helpdesk.gif"> --> <!-- 20141020 이미지 변경-->
							<map name="itab">
								<area shape="rect" target="_self" onfocus="this.blur();" coords="12, 127, 156, 148" href="mailto:askitab@kita.net" />
								<area shape="rect" target="_self" onfocus="this.blur();" coords="14, 153, 168, 185" href="javascript:goMenu('215')" />
							</map>
						</td>
						
					<% } else { %>						
						<td><img src="/images/home0/common/sub_helpdesk_img_<%=G_SYSTEM%>.gif"></td></tr>
					<%if(G_SYSTEM.equals("8")){ %>						
						<tr><td height=5></td></tr>
						<tr><td>
						
						<img src="/images/home0/common/sub_helpdesk_img_<%=G_SYSTEM%>_1.jpg" usemap="#itab2"/></td></tr>
						<%} %>
				

						
					
										<% } %>
				</tr>
				</table>
							<map name="itab2">
								<area shape="rect" target="_blank" coords="15, 211, 172, 226" href="http://www.tradecampus.com/UserFiles/ebook/DC_ebook/DC-ebook.html" />
								<area shape="rect" target="_blank" coords="15, 230, 172, 246" href="http://www.tradecampus.com/UserFiles/ebook/dojeong-ebook/dojeong-ebook.html"  />
							</map>
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td height="50"></td>						
					</tr>
				</table>
<% } %>				
				<div id="leftbanner"></div>
				<!-- banner //-->
			</td>
			<td></td>
			<td align="left">
				<table width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td><img src="/images/home0/title/pagetitle_<%=V_MENUTITLEORDER %>.gif"></td>
					<td align="right" valign="bottom">
						<table cellpadding="0" cellspacing="0">
						<tr>
							<td class="locate01">
								<img src="/images/common/icon_home.gif">&nbsp;<%=G_MENUNAVI%></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="30"></td></tr>
				</table>
<% if (gMain.equals("3_1") && StringUtil.isNotNull((String)session.getAttribute("e_menuid"))) {%>
<script type="text/javascript">
	var menuid = 0;
	var p_menuid=<%=(String)session.getAttribute("e_menuid")%>
	ctl = document.getElementById(p_menuid);
	if (ctl != null) {
		ctl.style.display = "block";	
	}
</script>
<%} %>

<!---  quick_mu  ---->
<style>
#content {}
#floater {position: absolute; left:expression((document.body.clientWidth/2)+470); top:0px; visibility:visible;}

</style>

<span ID="floater">
	<div class="quick" id="quickmenu"></div>
</span>

<!-- 기존 코드(크롬에서 작동 안 하여 주석처리함)
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

//	if(NS || IE) action = window.setInterval("heartBeat()",1);

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
			var menu = 896;
			var empty = 0;
			var x = 0;
			var y = 120;
			
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
// 창크기 변화가 발생할 때마다 퀵메뉴바 재정렬
$(window).resize(function(){
	jsSiteLinkList();
});

</script>
<!-- //SiteLink menu -->
