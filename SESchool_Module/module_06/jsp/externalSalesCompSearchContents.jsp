<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file = "/jsp/back/common/commonInc.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>::: 한국무역협회 무역아카데미 ::: 관리자페이지</TITLE>
<META http-equiv=Content-Type content="text/html; charset=UTF-8"> 
<%
	// 컨텐츠 검색
	String	lvOrder1[]			=	{"INDATE ASC",
	                                  "CONTSNM ASC"};
	String	lvOrder2[]			=	{"INDATE DESC",
	                                  "CONTSNM DESC"};

    String v_pageno   	= StringUtil.nvl(box.getString("l_pageno"),"1");
    String v_listscale	= StringUtil.nvl(box.getString("l_listscale"),"10");
    String v_sortorder	= StringUtil.nvl(box.getString("l_sortorder"),lvOrder2[0]);
    String v_contsgubun = box.getString("l_contsgubun");
    String v_search = box.getString("l_search");
    String v_searchtext = box.getString("l_searchtext");
    
    String v_comp_seq = box.getString("p_comp_seq");
%>    
<fmtag:csscommon point="back" />
<fmtag:jscommon />
<fmtag:dwrcommon system="cms" interfaceName="ContentsWork"/>
<script language="JavaScript" src="/js/common/selectbox.js"></script>
<script language="Javascript" src="/js/common/popupbox.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--	
	var tm;
	function tblInit(){
		headerInfos			=	new Array();

		tableInfo			=	new TableInfo({tableName:"", tableId:"ajaxTable", width:"985", headerClass:"colresize", tableAlign:"left", topColor:"02", topHeight:"28", colHeight:"25"});
		headerInfos[0]		=	new HeaderInfo(0, {colName:"선택", width:"30", colNo:0,colAlign:"center",colClass:"title"});
		headerInfos[1]		=	new HeaderInfo(1, {colName:"구분", width:"70", colNo:1,colAlign:"center",colClass:"title"});
		headerInfos[2]		=	new HeaderInfo(2, {colName:"카테고리", width:"120", colNo:2,colAlign:"center",colClass:"title"});
		headerInfos[3]		=	new HeaderInfo(3, {colName:"컨텐츠명", width:"210", colNo:3,colAlign:"left",  colClass:"title", sortAsc:"<%=lvOrder1[1]%>", sortDesc:"<%=lvOrder2[1]%>"});
		headerInfos[4]		=	new HeaderInfo(4, {colName:"등록일", width:"80", colNo:4,colAlign:"center",colClass:"title", sortAsc:"<%=lvOrder1[0]%>", sortDesc:"<%=lvOrder2[0]%>"});
		headerInfos[5]		=	new HeaderInfo(5, {colName:"등록자", width:"70", colNo:5,colAlign:"center",colClass:"title"});
		headerInfos[6]		=	new HeaderInfo(6, {colName:"미리보기", width:"70", colNo:6,colAlign:"center",colClass:"title"});
        
		datas				=	new Array();
		this.tm				=	new TableManager($("ListBox"),tableInfo, headerInfos, datas);
	}

	function jsInitPage(){
		tblInit(); 
		jsMainList();
	}

	function jsMainList(){
		var f				=	document.form1;
    
        var param = {l_pageno:f.l_pageno.value,
        		l_sortorder:f.l_sortorder.value,
        		l_listscale:f.l_listscale.value,
                l_contsgubun:f.l_contsgubun.value,
                l_search:f.l_search.value,
                l_searchtext:f.l_searchtext.value,
                p_userid:f.p_userid.value,
                p_comp_seq:f.p_comp_seq.value
                };
        ContentsWork.externalContentsPageListCallBack(param,jsMainListCall); 

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
        var v_contsgubun = null, v_contsgubunnm = null;
        var v_contsid = null;
        var v_contsid_own = "";
        
		if(ds != null && ds.length > 0){
			lstIndex		=	data.startNum;
			for(var i = 0; i < ds.length;i++){
			    info		=	ds[i];   
			    
			    v_contsid = info["CONTSID"];
			    v_contsid_own = info["CONTSID_OWN"];		// 이미 보유중인 컨텐츠
			    v_contsgubun = info["CONTSGUBUN"];
				if(v_contsgubun == "S"){
					v_contsgubunnm = "표준";
				} else {
					v_contsgubunnm = "비표준";
				}
				
				if(v_contsid_own == "Y"){
					row[0]		=	'<input type=\"checkbox\" name=\"checkContents\" id=\"'+v_contsid+'\" value=\"\''+v_contsid+'\'\" onclick=\"clickChecked(\''+v_contsid+'\',\''+info["CONTSNM"]+'\');\" checked>';
				} else {
					row[0]		=	'<input type=\"checkbox\" name=\"checkContents\" id=\"'+v_contsid+'\" value=\"\''+v_contsid+'\'\" onclick=\"clickChecked(\''+v_contsid+'\',\''+info["CONTSNM"]+'\');\">';
				}
								
				row[1]		=	v_contsgubunnm;
				row[2]		=	info["CATENM"];
				row[3]		=	info["CONTSNM"];
				row[4]		=	addDateFormatStr(info["INDATE"]);
				row[5]		=	jsNvl(info["INUSERNM"]);
				if(info["FIRSTITEM"] > 0) {
					row[6] =  "<fmtag:button type='5' value='미리보기' func='contentsPreview(\'" + v_contsid + "\')' icon='icon_ok.gif'  />";
				} else {
                	row[6] = "-";
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
    
	// 미리보기
    function contentsPreview(contsid){
	    var f = document.form1;

		var url = "/back/cms/Master.do?cmd=previewContentsFrame&p_contsid="+contsid;
		Contents_Popup2(url, "ContentsPreview");
	}
	
	// 초기화 버튼 클릭
    function searchClear(){
	    var f = document.form1;
	    
	    f.l_contsgubun.options[0].selected = true;
	    f.l_search.options[0].selected = true;
	    f.l_searchtext.value = "";
    }
	
	// 선택 체크시
	function clickChecked( contsid, contsnm ){
		var f = document.form1;
		var comp_seq = '';
		<% if( v_comp_seq != "" ){ %>
			comp_seq = <%= v_comp_seq %>;
		<% } %>
		
		var checkContents = null;
		checkContents = document.getElementById(contsid);
		 
		if(checkContents.checked == true){
			alert('[선택] '+contsnm);
			opener.setData("SET_CONTENTS", comp_seq, contsid, contsnm);
		} else {
			alert('[해제] '+contsnm);
			opener.setData("DEL_CONTENTS", comp_seq, contsid, contsnm);
		}
	}
	
    -->
</script>
</HEAD>
<BODY leftMargin=0 topMargin=0 marginheight="0" marginwidth="0" onLoad="jsInitPage()">
	<form name="form1" action="/back/cms/Contents.do" method="post" onSubmit="return false;">
	<input type="hidden" name="cmd" value="contentsRepPageList">
	<input type="hidden" name="l_pageno" value="1">
	<input type="hidden" name="l_sortorder" value="<%=v_sortorder%>">
	<input type="hidden" name="p_userid" value="<%=box.getString("s_userid") %>">
	<input type="hidden" name="p_contsid" value="">
	<input type="hidden" name="p_comp_seq" value="<%=v_comp_seq%>">
	<input type="hidden" name="p_contentsMode" value="">

<table width="100%" cellpadding="0" cellspacing="0">
<tr>
	<td class="pad_left_15">

    <!-- 메뉴명 -->
	<table width="100%" cellpadding="0" cellspacing="0" class="mar_top_10">
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
	<table width="100%" cellpadding="0" cellspacing="0" class="mar_top_5" style="display:"  id="MenuDescTb">
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
							<!-- 구분 -->
		                  	<img src="/images/back/common/txt_padding.gif">
		                  	구분
		                    <select name="l_contsgubun" style="width:100" onChange="jsMainList()">
		                      <option value="">- 전체 - </option>
		                      <option value="S" <%if(v_contsgubun.equals("S")){%>selected<%}%>>표준</option>
		                      <option value="N" <%if(v_contsgubun.equals("N")){%>selected<%}%>>비표준</option>
		                    </select>
		                    <!-- 검색유형 -->
		                    <img src="/images/back/common/txt_padding.gif">
		                    <select name="l_search" style="width:100">
	                          <option value="CONTSNM" <%if(v_search.equals("CONTSNM")){%>selected<%}%>>컨텐츠명</option>
	                          <option value="INUSERNM" <%if(v_search.equals("INUSERNM")){%>selected<%}%>>등록자</option>
	                        </select>&nbsp;
	                       <input type="text" name="l_searchtext" value="<%=v_searchtext %>" size="40">            
						</td>
					</tr>
					<tr><td height="1" background="/images/back/common/line_dot_garo.gif"></td></tr>
					</table>
					
					<table width="100%" cellpadding="0" cellspacing="0">
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
										<fmtag:button type="2" value="검색시작" func="jsMainList()" />&nbsp;
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
			<col width="200" />
		</colgroup>
		<tr>
		    <td>&nbsp;</td> 
			<td align="right">
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
		
		<!-- 닫기 버튼 -->
		<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:5px;">
		<tr>
			<td align="center"><br><br><fmtag:button type="1" value="닫기" func="javascript:self.close();" /></td>
		</tr>
		</table>
	  
	  <!--푸터부분 시작-->
	  <%@ include file = "/jsp/back/common/bottom.jsp"%>
	  <!--푸터부분 끝-->	