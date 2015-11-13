<%--
 * @(#)SystemCode Template
 *
 * Copyright 2010 한국무역협회 무역아카데미. All Rights Reserved.
 *
 * T_LMS_CBOARDCONTENTS 테이블 List Template.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2009. 12. 14.  bgcho
 ************************************************
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import ="com.sinc.framework.data.DataSet"%>
<%@ page import ="com.sinc.framework.data.Box"%>
<%@ page import ="com.sinc.framework.persist.ListDTO"%>
<%@ page import ="com.sinc.common.FormatDate"%>
<%@ page import ="org.apache.commons.configuration.Configuration"%>
<%@ page import ="com.sinc.framework.configuration.ConfigurationFactory"%>
<%@ include file = "/jsp/front/common/commonBasicInc.jsp"%>
<%
	//게시판 기본정보
	Box boxBoardProperty = (Box)box.getObject("boxBoardProperty");

	String s_userid = box.getString("s_userid");
	
	String v_type		= boxBoardProperty.getString("TYPE");
	String v_system		= boxBoardProperty.getString("SYSTEM");
	String v_fixedyn	= boxBoardProperty.getStringDefault("FIXEDYN", "N");
	String v_listcnt	= boxBoardProperty.getStringDefault("LISTCNT", "10");
	String v_masterid	= boxBoardProperty.getStringDefault("MASTERID", "");
	String v_auth		= boxBoardProperty.getStringDefault("AUTH", "");
	
	//상세화면에서 넘겨받을 인자값
	String v_boardid	= box.getString("p_boardid");
	String v_pageno   	= box.getStringDefault("p_pageno", "1");
	String v_listscale	= box.getStringDefault("p_listscale", v_listcnt);
	String v_searchtype	= box.getString("p_searchtype");
	String v_searchword	= box.getString("p_searchword");
	
	DataSet dsFixedList = (DataSet)box.getObject("FixedData");
	ListDTO listDto = (ListDTO)box.getObject("ListData");
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
<title><%=PAGETITLE%></title>
<script type="text/javascript">
	function goSearch() {
		var f = document.form1;

		f.submit();
	}
	function bbsBoardWrite() {
		var f = document.form1;
		
		f.action = "/front/BbsBoard.do?cmd=bbsBoardWriteForm";
		f.cmd.value = "bbsBoardWriteForm";
		f.p_process.value = "W";
		
	    f.submit();
	}
	function bbsBoardShow(boardid, seq) {
		var f = document.form1;
	if(boardid=='24'){
		f.p_boardid2.value = boardid;
		f.p_seq.value = seq;
		
		f.action = "/front/BbsBoard.do?cmd=bbsBoardShowForm3";
		f.cmd.value = "bbsBoardShowForm";
		f.p_process.value = "E";
		
	    f.submit();

	    f.action = "/front/BbsBoard.do?cmd=bbsBoardPageListeLeanrning";
	    f.cmd.value = "bbsBoardPageListeLeanrning";
	    f.p_process.value = "W";
	}else{
			f.p_boardid2.value = boardid;
			f.p_seq.value = seq;
			
			f.action = "/front/BbsBoard.do?cmd=bbsBoardShowForm";
			f.cmd.value = "bbsBoardShowForm";
			f.p_process.value = "E";
			
		    f.submit();
	
		    f.action = "/front/BbsBoard.do?cmd=bbsBoardPageList";
		    f.cmd.value = "bbsBoardPageList";
		    f.p_process.value = "W";
		}
	}
	
	function bbsFreeBoardList(){
		var f = document.form1;
		f.action = "/back/TotalBoard.do";
	    f.cmd.value = "totalBoardPageList";
		f.submit();
	}	
	/*
	function goBoardShow( v_boardid, v_seq ) {
		var f = document.form1;

		f.action = "/front/BbsBoard.do?cmd=bbsBoardShowForm";
		f.cmd.value = "bbsBoardShowForm";

		f.p_boardid.value = v_boardid;
		f.p_seq.value = v_seq;

		f.submit();
	}
	*/
	function goMyStudyFreeBoardShow( v_subj, v_year, v_subjseq, v_seq, v_isonoff ) {
		var f = document.form1;
		
		f.method = "post";
		f.action = "/front/MyStudyBoard.do?cmd=myStudyFreeBoardShow";
		f.cmd.value = "myStudyFreeBoardShow";

		f.p_subj.value = v_subj;
		f.p_year.value = v_year;
		f.p_subjseq.value = v_subjseq;
		f.p_seq.value = v_seq;
		f.p_isonoff.value = v_isonoff;
		
		f.submit();
	}
	function bbsBoardList() {
		var f = document.form1;
		f.action	= "/front/BbsBoard.do";
	    f.cmd.value = "bbsBoardPageList";
		f.submit();
	}
	<%String parentmenuid	= box.getString("s_menuid");%>
	var parentmenuid = '<%=parentmenuid%>';
	function goPage(page,type){
		var f = document.form1;
		if(f.p_boardid.value=='112'){	//무역아카데미 뉴스레터
			f.p_main.value="Y";
		}
	   	f.p_pageno.value = page;
		if(parentmenuid=='33'){	//이러닝 공지사항리스트
		    f.action	= "/front/BbsBoard.do";
		    f.cmd.value = "bbsBoardPageListeLeanrning";
		    f.target = '_self';
			f.submit();
			return;
		}		
	   	bbsBoardList();
	}
</script>
</head>
<body>

<form name="form1" action="/front/BbsBoard.do" method="post" onSubmit="return false;">
<input type="hidden" name="cmd" value="bbsBoardPageList"/>
<input type="hidden" name="p_pageno" value="<%=v_pageno%>" />
<input type="hidden" name="p_process" value=""/>
<input type="hidden" name="p_boardid" value="<%=v_boardid %>"/>
<input type="hidden" name="p_boardid2" value=""/>
<input type="hidden" name="p_seq" value=""/>
<input type="hidden" name="v_type" value="<%=v_type %>"/>
<input type="hidden" name="p_listscale" value="<%=v_listcnt%>"/>
<input type="hidden" name="p_system" value="<%=v_system %>"/>
<input type="hidden" name="p_main" value=""/>
<% if(G_TMPL.equals("0")){ %>
<%     if(!v_boardid.equals("44")){ %>
<table width="100%" cellpadding="0" cellspacing="0" >
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"  bgcolor="#f8f8f8">												
							<td align="center" style="border: solid 1px #e6e6e6; background-color:#f7f7f6; padding:15px;">
								<select name="p_searchtype">
								    <option value="ALL"<%=(v_searchtype.equals("ALL")?" selected":"") %>>전체</option>
									<option value="TITLE"<%=(v_searchtype.equals("TITLE")?" selected":"") %>>제목</option>
									<option value="CONTENTS"<%=(v_searchtype.equals("CONTENTS")?" selected":"") %>>내용</option>
									<option value="INUSERNM"<%=(v_searchtype.equals("INUSERNM")?" selected":"") %>>이름</option>
									<option value="INUSERID"<%=(v_searchtype.equals("INUSERID")?" selected":"") %>>사용자아이디</option>
								</select>						

								<input type="text" name="p_searchword" value="<%=v_searchword %>" style="width:300px; height:18px;"/>
								<a href="#" onclick="goSearch();"><img src="/images/template0/common/btn_search_common.gif" align="absmiddle" alt="검색" /></a>

							</td>
						</tr>					
						</table>					
					</td>
				</tr>
				<tr><td height="10"></td></tr>
				</table>
	<% } %>
	<% if(v_boardid.equals("44")){ %>
	<table width="100%" cellpadding="0" cellspacing="0" style="margin-bottom:20px;">
	<tr>
		<td><img src="/images/template0/common/menu3_3_2_img01.gif"></td>
	</tr>
	</table>
	<% } %>
<% } %>
<% if(G_TMPL.equals("1")){ %>
<table width="100%" cellpadding="0" cellspacing="0" style="margin-top:10px;">
				<tr>
					<td style="border:solid 5px #efefef; padding:12px;">
						<table width="100%" cellpadding="0" cellspacing="0">
						<tr>
							<td><img src="/images/template0/common/notice_img01.gif"></td>
							<td align="right">
								<select name="p_searchtype" style="background-color:#efefef; border:solid 1px #d7d7d7; width:100px; height:20px;">
									<option value="TITLE"<%=(v_searchtype.equals("TITLE")?" selected":"") %>>제목</option>
									<option value="NAME"<%=(v_searchtype.equals("NAME")?" selected":"") %>>이름</option>
									<option value="USERID"<%=(v_searchtype.equals("USERID")?" selected":"") %>>사용자아이디</option>
								</select>	
								<input type="text" name="p_searchword" value="<%=v_searchword %>" style="background-color:#efefef; border:solid 1px #d7d7d7; width:200px; height:18px;">
								<a href="#" onclick="goSearch();"><img src="/images/template1/common/btn_search_common.gif" align="absmiddle" alt="검색버튼" /></a>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
<% } %>
<% if(G_TMPL.equals("2")){ %>
<table width="715" cellpadding="0" cellspacing="0" class="mar_top_10">
				<tr>
					<td style="border: solid 1px #DDDDDD; padding:10px;" bgcolor="#F5F5F5" align="center">
						<table width="600" cellpadding="0" cellspacing="0">					
						<tr>
							<td>
								<select name="p_searchtype" style="width:120px;">
									<option value="TITLE"<%=(v_searchtype.equals("TITLE")?" selected":"") %>>제목</option>
									<option value="NAME"<%=(v_searchtype.equals("NAME")?" selected":"") %>>이름</option>
									<option value="USERID"<%=(v_searchtype.equals("USERID")?" selected":"") %>>사용자아이디</option>
								</select>&nbsp;
								<input type="text" name="p_searchword" style="background-color:#FFFFFF; border:solid 1px #FFFFFF; width:300px; height:18px;">
								<a href="#" onclick="goSearch();"><a href="#"><img src="/images/template2/common/btn_search_common.gif" align="absmiddle" alt="검색버튼" /></a>
							</td>
						</tr>						
						</table>
					</td>
				</tr>			
				</table>
<% } %>
	<div id="list" class="board-list<%=G_HGRCODE.equals("0")?"-"+G_IMGID:"" %>">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" >
	<caption></caption>
	<colgroup>
		<col width="50" />
		<col width="" />
		<col width="40" />
		<col width="100" />
		<col width="60" />
	</colgroup>
	<thead>
	<tr>
		<th>No</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th class="th_nosplit">조회</th>
	</tr>
	</thead>
	<tbody>
<%	StringBuilder sbTemp = new StringBuilder();
	if ( v_fixedyn.equals("Y") && v_searchword.equals("") ) {
		if ( dsFixedList != null ) {
			while ( dsFixedList.next() ) { %>
	<tr height="30">
		<td>*</td>
		<td style="text-align:left">
<%				if ( dsFixedList.getInt("UPFILECNT") > 0 ) {
					if ( dsFixedList.getInt("FILECNT") > 0 ) {
						sbTemp.append("<img src='/images/back/icon/but_icon_save.gif' alt='file 아이콘' align='absMiddle'>\n");
					}
				}
				if ( dsFixedList.getString("NEWTERMYN").equals("Y") ) {
					sbTemp.append("<img src='/images/back/icon/ico_list_new_red.gif' alt='new 아이콘' align='absMiddle'>\n");
				}
				if ( dsFixedList.getString("HOTYN").equals("Y") ) {
					sbTemp.append("<img src='/images/back/icon/ico_hot.gif' alt='hot 아이콘' align='absMiddle'>\n");
				}
				if ( dsFixedList.getString("COMMENTYN").equals("Y") ) {
					if ( dsFixedList.getInt("COMMENTCNT") > 0 ) {
						sbTemp.append("<span class='reply_id'>[").append(dsFixedList.getString("COMMENTCNT")).append("]</span>\n");
					}
				}
				sbTemp.insert(0,"&nbsp;");

				if ( v_auth.contains("R") || (!v_masterid.equals("") && v_masterid.equals(s_userid)) ) { %>
		<a href="#none" onclick="bbsBoardShow('<%=dsFixedList.getString("BOARDID")%>','<%=dsFixedList.getString("SEQ")%>')"><%=("<B>"+dsFixedList.getString("TITLE")+"</B>"+sbTemp.toString())%></a>
<%				} else { %>
		<%=("<B>"+dsFixedList.getString("TITLE")+"</B>"+sbTemp.toString())%>
<%				}
				sbTemp.delete(0,sbTemp.length()); %>
		</td>
		<td><%=dsFixedList.getString("INUSERNM") %></td>
		<td><%=DateTimeUtil.getDateType(1, dsFixedList.getString("INDATE"), "/") %></td>
		<td><%=dsFixedList.getString("READCNT") %></td>
	</tr>
<%			}
		}
	
	}

	DataSet ds1 = listDto.getItemList();
	int listNum = listDto.getStartPageNum();
	StringBuilder sbTemp2 = new StringBuilder();
	
	if ( ds1 != null && ds1.getRow() > 0 ) {
		while ( ds1.next() ) { %>
	<tr height="30">
		<td><%=listNum--%></td>
		<td style="text-align:left">
<%			if ( ds1.getString("REPLYYN").equals("Y") && v_searchword.equals("") ) {
				if ( ds1.getInt("DEPTH") > 1 ) {
					sbTemp2.append("<span style='padding-left:").append((ds1.getInt("DEPTH")-1)*10).append("px;'>\n");
					sbTemp2.append("<img src='/images/back/icon/reply.gif' align='absMiddle'></span>\n");
				}
			}
			if ( !(v_type.equals("02")||v_type.equals("04")) && ds1.getInt("UPFILECNT") > 0 ) {
				if ( ds1.getInt("FILECNT") > 0 ) {
					sbTemp.append("<img src='/images/back/icon/but_icon_save.gif' alt='file 아이콘' align='absMiddle'>\n");
				}
			}
			if ( ds1.getString("NEWTERMYN").equals("Y") ) {
				sbTemp.append("<img src='/images/back/icon/ico_list_new_red.gif' alt='new 아이콘' align='absMiddle'>\n");
			}
			if ( ds1.getString("HOTYN").equals("Y") ) {
				sbTemp.append("<img src='/images/back/icon/ico_hot.gif' alt='hot 아이콘' align='absMiddle'>\n");
			}
			if ( ds1.getString("COMMENTYN").equals("Y") ) {
				if ( ds1.getInt("COMMENTCNT") > 0 ) {
					sbTemp.append("<span class='reply_id'>[").append(ds1.getString("COMMENTCNT")).append("]</span>\n");
				}
			}
			sbTemp.insert(0,"&nbsp;");
			
		if(!(v_type.equals("02"))||v_type.equals("04")){	
			if ( v_auth.contains("R") || v_masterid.equals(s_userid) ) { %>
		<a href="#none" onclick="bbsBoardShow('<%=ds1.getString("BOARDID")%>','<%=ds1.getString("SEQ")%>')"><%=sbTemp2.toString()+ds1.getString("TITLE")+sbTemp.toString() %></a>
<%			} else { %>
		<%=sbTemp2.toString()+ds1.getString("TITLE")+sbTemp.toString() %>
<%			}
		}

		if(v_type.equals("02")){	
			if ( v_auth.contains("R") || v_masterid.equals(s_userid) ) { %>
			<table border=1 style="table-layout: fixed;"><tr><td style="padding-top:0px;padding-bottom:0px;" width="98" height="72" align="center" bgcolor="#000000" onclick="bbsBoardShow('<%=ds1.getString("BOARDID")%>','<%=ds1.getString("SEQ")%>')" style="cursor:hand"><img src="/upload/data/bbs/<%=v_boardid%>/<%=ds1.getString("THUMBNAIL")%>"  onerror=this.src="/images/common/noimage.gif"></td>
			<td class="td_noline"><a href="#none" onclick="bbsBoardShow('<%=ds1.getString("BOARDID")%>','<%=ds1.getString("SEQ")%>')"><%=sbTemp2.toString()+ds1.getString("TITLE")+sbTemp.toString() %></a></td></tr></table>
<%			} else { %>
			<table border=1 style="table-layout: fixed;"><tr><td style="padding-top:0px;padding-bottom:0px;" width="98" height="72" align="center" bgcolor="#000000"><img src="/upload/data/bbs/<%=v_boardid%>/<%=ds1.getString("THUMBNAIL")%>"  onerror=this.src="/images/common/noimage.gif"></td>
			<td class="td_noline"><%=sbTemp2.toString()+ds1.getString("TITLE")+sbTemp.toString() %></td></tr></table>
<%			}
		}
		
		if(v_type.equals("05")){	
			if ( v_auth.contains("R") || v_masterid.equals(s_userid) ) { %>
			<table border=1 style="table-layout: fixed;"><tr><td style="padding-top:0px;padding-bottom:0px;" width="98" height="72" align="center" bgcolor="#000000" onclick="bbsBoardShow('<%=ds1.getString("BOARDID")%>','<%=ds1.getString("SEQ")%>')" style="cursor:hand"><img src="/upload/data/bbs/<%=v_boardid%>/<%=ds1.getString("THUMBNAIL")%>"  onerror=this.src="/images/common/noimage.gif"></td>
			<td class="td_noline"><a href="#none" onclick="bbsBoardShow('<%=ds1.getString("BOARDID")%>','<%=ds1.getString("SEQ")%>')"><%=sbTemp2.toString()+ds1.getString("TITLE")+sbTemp.toString() %></a></td></tr></table>
<%			} else { %>
			<table border=1 style="table-layout: fixed;"><tr><td style="padding-top:0px;padding-bottom:0px;" width="98" height="72" align="center" bgcolor="#000000"><img src="/upload/data/bbs/<%=v_boardid%>/<%=ds1.getString("THUMBNAIL")%>"  onerror=this.src="/images/common/noimage.gif"></td>
			<td class="td_noline"><%=sbTemp2.toString()+ds1.getString("TITLE")+sbTemp.toString() %></td></tr></table>
<%			}
		}
			sbTemp2.delete(0,sbTemp2.length());
			sbTemp.delete(0,sbTemp.length()); %>
		</td>
		<td><%=ds1.getString("INUSERNM") %></td>
		<td><%=DateTimeUtil.getDateType(1, ds1.getString("INDATE"), "/")%></td>
		<td><%=ds1.getString("READCNT") %></td>
	</tr>
<%		}
	} else { %>
	<tr align="center" height="30px">
		<td colspan="5">등록된 자료가 없습니다.</td>
	</tr>
<%	} %>
	</tbody>
	</table>
	</div>

<!-- 테이블_번호 시작 -->
<table width="100%" cellpadding="0" cellspacing="0" class="mar_top_10">
<% if ((!s_userid.equals("") && v_auth.indexOf("W") > -1) || (!v_masterid.equals("") && v_masterid.equals(box.getString("s_userid"))) ) { %>
<tr align="right">
	<td><a href="#none" onclick="javascript:bbsBoardWrite();"><img src="/images/template<%=G_TMPL %>/common/btn_board_insert.gif" alt="등록" /></a></td>
</tr>
<% } %>
<tr align="center">
	<td><%=listDto.getPagging("goPage") %></td>
</tr>
</table>
<!-- 테이블_번호 끝 -->

<!-- // -->
<!-- //Page Contents -->

</form>
<br/><br/>
</body>
</html>