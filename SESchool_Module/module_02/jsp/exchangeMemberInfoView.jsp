<%@ page contentType="text/html;charset=UTF-8" 	%>
<%@ include file = "/jsp/back/common/commonInc.jsp"	%>
<%
	Box memberInfo = (Box)box.getObject("exchangeMemberInfo");   // 사용자 기본정보
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>::: 한국무역협회 무역아카데미 ::: 관리자페이지</TITLE>
<META http-equiv=Content-Type content="text/html; charset=UTF-8"> 
<fmtag:csscommon point="back" />
<fmtag:jscommon />
<script type="text/JavaScript" language="JavaScript" src="/js/common/util.js"></script>
<script type="text/JavaScript" language="JavaScript" src="/js/common/main.js"></script>
<script language="Javascript" src="/js/common/popupbox.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
/*
 */
function setPopupSize() {
	window.resizeTo(1050,1000);
	popupAutoResize();
}
Event.observe(window,"load", setPopupSize);
*/

function searchZipCode(objname) {
	var url = "/front/Common.do?cmd=selectZipCode&p_objname="+objname; 
	Center_Fixed_Popup2(url, "_zipcode", 500, 500, "no");
}
function setZipCodeInfo(objname, addr, zipcode) {
	var form = document.form1;

    if ( objname == "home" ) {
		form.p_addr1.value = addr;
		if(zipcode.search('-') > -1){	
			form.p_post1.value = zipcode.substr(0, 3) ;
			form.p_post2.value = zipcode.substr(4, 7) ;	
		} else {
			form.p_post1.value = zipcode;		// 새로운 우편주소, 하나의 텍스트란에 넣음
			form.p_post2.value = "";
			form.p_post2.style.display="none";
		}
    }else  if ( objname == "member" ) {
		form.p_memberaddr1.value = addr;		
		if(zipcode.search('-') > -1){	
			form.p_memberpost1.value = zipcode.substr(0, 3) ;
			form.p_memberpost2.value = zipcode.substr(4, 7) ;	
		} else {
			form.p_memberpost1.value = zipcode;		// 새로운 우편주소, 하나의 텍스트란에 넣음
			form.p_memberpost2.value = "";
			form.p_memberpost2.style.display="none";
		}
    }
}

//첨부 파일 다운로드
function fileDownload(filePath, sFile){
	if( sFile == "" || sFile==null || sFile=='null') {
		alert("첨부된 파일이 없습니다");
		return;
	}
	var f = document.form2;
	f.action = "/fileDownServlet";
	f.method = "get";
	f.sFileName.value = sFile;
	f.rFileName.value = sFile;
	f.filePath.value = filePath;
	f.submit();
	return;		
}

//-->
</SCRIPT>
</HEAD>
<BODY leftMargin=0 topMargin=0 marginheight="0" marginwidth="0" >
	<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td class="pad_left_15">
		     <!-- 메뉴명 -->
			<table width="560" cellpadding="0" cellspacing="0" class="mar_top_20">
			<colgroup>
				<col width="10" />
				<col width="" />
				<col width="15" />
			</colgroup>
			<tr>
				<td><img src="/images/back/common/bullet_label.gif"></td>
				<td class="t_title"> 사용자 정보</td>
				<td align="right" valign="bottom"></td>
			</tr>
			</table>
		</td>
	</tr>	
	<!-- 과정기수변경  -->
	<tr>
		<td class="pad_left_15">
			<div class="board-view">
			<table width="1000" cellpadding="0" cellspacing="0" class="mar_top_5">
			<colgroup>
				<col width="200" />
				<col width="300" />
				<col width="200" />
				<col width="300" />			
			</colgroup>
			<tr>
				<th class="th_top_bd">접수자명</th>
				<td class="td_top_bd">
					<%=memberInfo.getString("NAME") %>
				</td>
				<th class="th_top_bd">주민번호</th>
				<td class="td_top_bd"">
            	    <%=memberInfo.getString("RESNO") %>
				</td>
			</tr>
			<tr>
				<th>핸드폰</th>
				<td>
					<%=memberInfo.getString("HANDPHONE") %>
				</td>
				<th>전화번호</th>
				<td>
					<%=memberInfo.getString("HOMETEL") %>
				</td>
			</tr>
			<tr>
				<th>이메일주소</th>
				<td>
					<%=memberInfo.getString("EMAIL") %>
				</td>
				<th>회사명</th>
				<td>
            	    <%=memberInfo.getString("COMPNM") %>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td colspan="3">
					<% if( memberInfo.getString("POST2") == null || memberInfo.getString("POST2").equals("") ){ %>
						(<%=memberInfo.getString("POST1") %>) 
					<% } else { %>
						(<%=memberInfo.getString("POST1") %> - <%=memberInfo.getString("POST2") %>) 
					<% } %>
					<%=memberInfo.getString("ADDR") %> 
					<%=memberInfo.getString("ADDR2") %>
				</td>
			</tr>
			<tr>
			<%
			/* 1 = 일반
			2 = 회원사
			3= 대학생
			4=무역마스터 
			5 = 금융사
			*/
			String memberis = memberInfo.getString("SULMUN4");
			String filePath = "/propose/"+memberInfo.getString("SUBJ")+"/"+memberInfo.getString("YEAR")+"/"+memberInfo.getString("SUBJSEQ");
			if(memberis.equals("1")){
				memberis = "일반";
			}else if(memberis.equals("2")){
				memberis = "회원사"+"<input style='border:0px;' type='button' value='재직증명서' onClick=\"fileDownload('"+filePath+"', '"+memberInfo.getString("PROOFEMPSAVENAME")+"') \" />"
									+"<input style='border:0px;' type='button' value='사업자등록증' onClick=\"fileDownload('"+filePath+"', '"+memberInfo.getString("BIZLICENSESAVENAME")+"') \" />";
			}else if(memberis.equals("3")){
				memberis = "대학생"+"<input style='border:0px;' type='button' value='증명서' onClick=\"fileDownload('"+filePath+"', '"+memberInfo.getString("COLLEGIANSAVENAME")+"') \" />";
			}else if(memberis.equals("4")){
				memberis = "무역마스터 "+memberInfo.getString("TRADEMASTERSEQ")+"기";
			}else if(memberis.equals("5")){
				memberis = "금융사 "+"<input style='border:0px;' type='button' value='재직증명서' onClick=\"fileDownload('"+filePath+"', '"+memberInfo.getString("BANKERSAVENAME")+"') \" />";
			}
			/*테스트 else{
				memberis = "-"+"<input type='button' value='-' onClick=\"fileDownload('"+filePath+"', '"+memberInfo.getString("PROOFEMPSAVENAME")+"') \" />";
			} */
			
								 %>
				<th>회원구분</th>
				<td colspan="3">					 										
					<%=memberis %> 
					
				</td>
			</tr>
			</table>
		  </div>
	    </td>
      </tr>	
	</table>
	
	<table width="100%" cellpadding="0" cellspacing="0" class="mar_top_10">
	<tr>
		<td align="center">
			<table cellpadding="0" cellspacing="0">
			<tr>
			  <td>
	  			<fmtag:button type="1" value="닫기" func="window.close()" />
			  </td>
			</tr>
			</table>
		</td>
	</tr>
	</table>			
   
	<!-- // -->
	
	<form name="form2">
	<!-- 파일다운로드용 -->
		<input type="hidden" name="rFileName"		value="">
		<input type="hidden" name="sFileName"		value="">
		<input type="hidden" name="filePath"		value="">
	</form>
	
	
  <!--푸터부분 시작-->
  <%@ include file = "/jsp/back/common/popBottom.jsp"%>
  <!--푸터부분 끝-->	
