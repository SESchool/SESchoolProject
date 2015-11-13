<%--
 * @(#)SystemCode Template
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * T_LMS_CODEGUBUN 테이블 List Template.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2009. 10. 23.  JANGCW       Initial Release
 ************************************************
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file = "/jsp/back/common/commonInc.jsp"%>
<%@ page import ="com.sinc.common.CodeParamDTO"%>
<HTML>
<HEAD>
<TITLE>::: 한국무역협회 무역아카데미 ::: 관리자페이지</TITLE>
<META http-equiv=Content-Type content="text/html; charset=UTF-8"> 
<%
String	lvOrder1[]			=	{"LDATE DESC, COMPNM ASC"};
%>
<%
	//유통사 리스트
	
	//소분류에서 넘겨받을 인자값
    String v_pageno   	= StringUtil.nvl(box.getString("l_pageno"),"1");
    String v_listscale	= StringUtil.nvl(box.getString("l_listscale"),"10");
    String v_sortorder	= StringUtil.nvl(box.getString("l_sortorder"),lvOrder1[0]);
    String v_gubun = box.getString("l_gubun");
    String v_uppercomp = box.getString("l_uppercomp");
    String v_search = box.getString("l_search");
    String v_searchtext = box.getString("l_searchtext");
%>    
<fmtag:csscommon point="back" />
<fmtag:jscommon />
<fmtag:dwrcommon interfaceName="CompWork"/>
<script language="JavaScript" src="/js/common/selectbox.js"></script>
<SCRIPT LANGUAGE="JavaScript">

	var tm;
	function tblInit(){
		headerInfos			=	new Array();

		tableInfo			=	new TableInfo({tableName:"", tableId:"ajaxTable", width:"1200", headerClass:"colresize", tableAlign:"left", topColor:"02", topHeight:"35"});
		headerInfos[0]		=	new HeaderInfo(0, {colName:"No", height:"35",width:"30", colNo:0,colAlign:"center",colClass:"title"});
		headerInfos[1]		=	new HeaderInfo(1, {colName:"업체명", height:"35",width:"80", colNo:1,colAlign:"center",colClass:"title"});
		headerInfos[2]		=	new HeaderInfo(2, {colName:"계약기간", height:"35",width:"110", colNo:2,colAlign:"center",  colClass:"title"});
		headerInfos[3]		=	new HeaderInfo(3, {colName:"담당자", height:"35",width:"50", colNo:3,colAlign:"center",colClass:"title"});
		headerInfos[4]		=	new HeaderInfo(4, {colName:"모니터링 계정", height:"35",width:"80", colNo:4,colAlign:"center",  colClass:"title"});
		headerInfos[5]		=	new HeaderInfo(5, {colName:"담당업무", height:"35",width:"50", colNo:5,colAlign:"center",colClass:"title"});
		headerInfos[6]		=	new HeaderInfo(6, {colName:"전화번호", height:"35",width:"100", colNo:6,colAlign:"center",colClass:"title"});
		headerInfos[7]		=	new HeaderInfo(7, {colName:"휴대폰", height:"35",width:"100", colNo:7,colAlign:"center",colClass:"title"});
        headerInfos[8]		=	new HeaderInfo(8, {colName:"이메일", height:"35",width:"100", colNo:8,colAlign:"center",colClass:"title"});
        headerInfos[9]		=	new HeaderInfo(9, {colName:"메모", height:"35",width:"25", colNo:9,colAlign:"center",colClass:"title"});
        
		datas				=	new Array();
		this.tm				=	new TableManager($("ListBox"),tableInfo, headerInfos, datas);
	}

	function jsInitPage(){
		tblInit(); 
		jsMainList();
	}

	function jsMainList(){
		
		var f = document.form1;
        var param = {
        		l_pageno:f.l_pageno.value
        		, l_listscale:f.l_listscale.value
        		, l_sortorder:f.l_sortorder.value
        		, l_search:f.l_search.value
        		, l_searchtext:f.l_searchtext.value
        		}

        CompWork.externalSalesCompListCallBack(param,jsMainListCall); 

		//- 작업중 표시
		displayWorkProgress();
	}

	function jsMainListCall(data){

		var f				=	document.form1;
		ds = data.list;
		
		//- 테이블 내용 모두 지우기
		tm.deleteAllRow();

		var lstIndex		=	0;
        var  v_issystem_view = "";
        var info;
        var row				=	new Array();
        var gubunnm = "";
        var comp_seq = "";
		if(ds != null && ds.length > 0){
			lstIndex		=	data.startNum;
			for(var i = 0; i < ds.length;i++){
			    info		=	ds[i];  
			    comp_seq = info["COMP_SEQ"];

			    row[0]		=	lstIndex--;
				row[1]		=	"<A HREF='#' onClick=externalSalesCompInfo('" + comp_seq + "')>" + info["COMPNM"] + "</A>";
				row[2]		=	info["STARTYEAR"]+" ~ "+info["ENDYEAR"];
				row[3]		=	info["MANAGER"];
				row[4]		=	info["MONITORINGID"];
				row[5]		=	info["RESPONSIBILITIES"];
				row[6]		=	info["TELEPHONE"];
				row[7]		=	info["HANDPHONE"];
				row[8]		=	info["EMAIL"];
				if(info["ISMEMO"] =="Y")  {
					row[9]		=	"<fmtag:button type='6' value='메모' func='externalMemoPop(\'" + comp_seq + "\')' />";
				}
				else{
					row[9]		=	"<fmtag:button type='5' value='메모' func='externalMemoPop(\'" + comp_seq + "\')' />";
				}

				tm.addRow(row);
			}
		}else{
			tm.addRow(row);
		}
		
        tm.setSortMark(f.l_sortorder.value);
		tm.resizeTable();
         
        var pageNavi = document.getElementById("PageNavi");
        pageNavi.innerHTML = data.pageNavi;
		//- 작업중 표시 닫기
		closeWorkProgress();		
	}
	
	//- 테이블 소팅을 클릭 했을 경우 실행된다.  
	function jsTableSort(sortOrder){
		var f				=	document.form1;
		f.l_pageno.value		=	1;
		f.l_sortorder.value	=	sortOrder;
		jsMainList();
	}
	
	function goPage(page,type){
		var f = document.form1;
	   	f.l_pageno.value  = page;
	   	jsMainList();
	}
	
	// 유통사 등록 or 유통사명 클릭
	function externalSalesCompInfo( comp_seq ){
		var f = document.form1;
		 
	    f.p_comp_seq.value = comp_seq;
		f.action = "/back/Comp.do?cmd=externalSalesCompInfo";
		f.cmd.value="externalSalesCompInfo";
		f.method = "post";
        f.submit();
	}
	
	function search(){
	    var f = document.form1;
	    f.l_pageno.value = '1';
	    jsMainList();
	}
	
	function onEnter(event) {
		if(event.keyCode == 13) {
			search();
		}		
	}
	
	function searchClear(){
		var f = document.form1;
		
		f.l_searchtext.value = "";
		f.l_gubun.options[0].selected = true;
		f.l_uppercomp.options[0].selected = true;
	}
	
	// 메모 쓰기
	function externalMemoPop(comp_seq) {
		var f = document.form1;

		var url =  "/back/Comp.do?cmd=externalCompMemoForm&p_comp_seq=" + comp_seq;
		popWin = Center_Fixed_Popup2(url, "Memo", 790,570, "no");
	}

</script>
</HEAD>
<BODY leftMargin=0 topMargin=0 marginheight="0" marginwidth="0" onLoad="jsInitPage()">
	<form name="form1" action="/back/Comp.do" method="post" onSubmit="return false;">
	<input type="hidden" name="cmd" value="">
	<input type="hidden" name="p_comp" value="">
	<input type="hidden" name="l_pageno" value="1">
	<input type="hidden" name="l_sortorder" value="<%=v_sortorder%>">
	<input type="hidden" name="p_comp_seq" value="">
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
	<td class="pad_left_15">
     <!-- 메뉴명 -->
	<table width="985" cellpadding="0" cellspacing="0" class="mar_top_10">
	<colgroup>
		<col width="10" />
		<col width="" />
		<col width="15" />
	</colgroup>
	<tr>
		<td><img src="/images/back/common/bullet_title.gif"></td>
		<td class="t_title"><%=s_menunavi %></td>
		<td align="right" valign="bottom"><a href="javascript:showMenuDesc();"><img id="MenuDescBtn" src="/images/back/button/btn_tbl_close.gif" alt="메뉴설명 닫기"></a></td>
	</tr>
	</table>
	<!-- // -->	
	
	<!-- 해당메뉴 설명 -->
	<table width="985" cellpadding="0" cellspacing="0" class="mar_top_5" style="display:"  id="MenuDescTb">
	<tr>
		<td class="border_gray" align="center">				
			<table width="100%" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<!-- CP/유통사 현황과 실적 등을 관리할 수 있는 모듈 -->
				<td id="menuDesc"></td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
	<!-- // -->

		<!-- 검색 조건 -->
		<table width="985" cellpadding="0" cellspacing="0" class="mar_top_5">
		<tr>
			<td class="border_gray02" align="center">
					<table width="100%" cellpadding="0" cellspacing="0">
					<tr>
						<td class="txt_b">
							검색
							<select name="l_search">
							   <option value="COMPNM">유통사명</option>
							   <option value="MANAGER">담당자명</option>
							</select>
							<input name="l_searchtext" value="<%=v_searchtext%>" type="text" size="65" />
						</td>
					</tr>
					<tr><td height="1" background="/images/back/common/line_dot_garo.gif"></td></tr>
					</table>
				
					<table width="100%" cellpadding="0" cellspacing="0" class="color_blue">
					<tr><td height="1" bgcolor="#cccccc"></td></tr>
					<tr><td height="1" bgcolor="#FFFFFF"></td></tr>
					<tr><td class="hei_5"></td></tr>
					<tr>
						<td align="center">
							<table width="" cellpadding="0" cellspacing="0">
							<tr>
								<td>
										<fmtag:button type="2" value="검색시작" func="search()" />&nbsp;						
										<fmtag:button type="2" value="초기화" func="searchClear()" />
								</td>
							</tr>
							</table>
						</td>
					</tr>
					<tr><td class="hei_5"></td></tr>
					</table>
				<div>
			</td>
		</tr>
		</table>
		<!-- // -->

	    <!-- 버튼 -->
		<table width="985" border="0" cellpadding="0" cellspacing="0" class="mar_top_5">
		<colgroup>
			<col width="" />
			<col width="70" />
			<col width="60" />
		</colgroup>
		<tr>
		    <td>&nbsp;</td> 
			<td align="right">
<%      if(s_menucontrol.equals("RW")) { %>		
				<fmtag:button type="1" value="등록" func="externalSalesCompInfo('')" />&nbsp;
<%      }  %>
			</td>
			<td>
                <%=CommonUtil.getListCountBox("l_listscale","jsMainList()",v_listscale,true)%>
			</td>
		</tr>
		</table>
		<!-- // -->	      
	      
		<!-- 리스트 -->
         <div id="listDiv" style="margin:0;width:100%;table-layout:fix;height:100%;">
			<table width="100%" cellpadding="0" cellspacing="0" class="mar_top_5">
			<tr>
				<td id="ListBox"></td>
			</tr>
			</table>
		  </div>	
		<!-- // -->	 
		     
		<!-- 페이지 -->
		<table width="985" cellpadding="0" cellspacing="0" class="mar_top_10">
		<tr>
			<td align="center" id="PageNavi">
			</td>
		</tr>
		</table>
		<!-- // -->
	  
	  <!--푸터부분 시작-->
	  <%@ include file = "/jsp/back/common/bottom.jsp"%>
	  <!--푸터부분 끝-->
