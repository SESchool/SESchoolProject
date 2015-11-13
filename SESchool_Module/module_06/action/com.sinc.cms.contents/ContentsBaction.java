/**
 * @(#)MemberBaction
 *
 * Copyright 2010 fmwave. All Rights Reserved.
 *
 * T_LMS_Member 테이블 Action 클래스.
 * 관리자단 메뉴를 관리하는 클래스
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2010. 10. 28.  fmwave       Initial Release
 ************************************************
 *
 * @author      bluedove
 * @version     1.0
 * @since       2010. 10. 28.
 */

package com.sinc.cms.contents;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.sinc.cms.master.MasterMgr;
import com.sinc.cms.product.ProductMgr;
import com.sinc.common.CommonUtil;
import com.sinc.framework.data.Box;
import com.sinc.framework.data.DataSet;
import com.sinc.framework.persist.ListDTO;
import com.sinc.framework.persist.PagingDTO;
import com.sinc.framework.struts.StrutsDispatchAction;


/** 
 * XDoclet definition:
 * @struts:action path="/back/cms/Contents" validate="false" parameter="cmd" scope="request"
 * @struts:action-forward name="MyContentsPageList" path="/jsp/back/cms/contents/myContentsPageList.jsp"
 * @struts:action-forward name="MyContentsWrite" path="/jsp/back/cms/contents/myContentsWrite.jsp"
 * @struts:action-forward name="ContentsSearchPageList" path="/jsp/back/cms/contents/contentsSearchPageList.jsp"
 * @struts:action-forward name="BookmarkPageList" path="/jsp/back/cms/contents/bookmarkPageList.jsp"
 * @struts:action-forward name="ContentsRecPageList" path="/jsp/back/cms/contents/contentsRecPageList.jsp"
 * @struts:action-forward name="ContentsRepPageList" path="/jsp/back/cms/contents/contentsRepPageList.jsp"
 * @struts:action-forward name="MyReqContentsPageList" path="/jsp/back/cms/contents/myReqContentsPageList.jsp"
 * @struts:action-forward name="MetadataShow" path="/jsp/back/cms/contents/metadataShow.jsp"
 * @struts:action-forward name="ProjectContentsWrite" path="/jsp/back/cms/contents/projectContentsWrite.jsp"
 */
public class ContentsBaction extends StrutsDispatchAction {

	/**
	 * MyContents 리스트 페이지로 이동을 해준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward myContentsPageList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{

		return mapping.findForward("MyContentsPageList");
	}

	/**
	 * MyContents 리스트를 가져온다.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public PagingDTO myContentsPageListCallBack(HashMap map, HttpServletRequest request) throws Exception{
 	    ContentsMgr mycontentsMgr = new ContentsMgr();
 	    Box box = new Box(map);
        HttpSession session = request.getSession();
        String v_gadmin = (String)session.getAttribute("s_gadmin");
        box.put("p_gadmin", v_gadmin.substring(0,1));
		ListDTO data = mycontentsMgr.selectContentsPageList(box);
		
		return data.getPagingDTO();		
	}

	/**
	 * MyContents를 등록할 수 있는 등록 페이지를 띄워준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward myContentsWriteForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		String v_mode = box.getString("p_mode");
		ContentsMgr mycontentsMgr = new ContentsMgr();
		if(v_mode.equals("E")){
			HashMap map = mycontentsMgr.selectContents(box);

			box.put("MyConts", map.get("MyConts"));
			box.put("Metadata", map.get("Metadata"));
	    }
             
		return mapping.findForward("MyContentsWrite");
	}
	
	/**
	 * MyContents를 등록,수정해준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward myContentsWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		String v_mode = box.getString("p_mode");
		int retVal = 0; 
	    String msg = "";
		ContentsMgr mycontentsMgr = new ContentsMgr();
		if(v_mode.equals("W")){
			MasterMgr masterMgr = new MasterMgr();
			retVal = mycontentsMgr.insertContents(box);
			if(retVal > 0) msg = "내컨텐츠를 등록하는데 성공하였습니다.";
			else  msg = "내컨텐츠를 등록하는데 실패하였습니다.";
	    }else{
	    	retVal = mycontentsMgr.updateContents(box);
			if(retVal > 0) msg = "내컨텐츠를 수정하는데 성공하였습니다.";
			else  msg = "내컨텐츠를 수정하는데 실패하였습니다.";
	    }
	    String url = "/back/cms/Contents.do?cmd=myContentsPageList&p_projyn="+box.getString("p_projyn")+"&p_contsgubun="+box.getString("p_contsgubun");
		url += box.getSearchParam();
		
		return alertAndExit(request, msg, url, "");
	}  
	
	/**
	 * 컨텐츠를 삭제해준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward myContentsDelete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		int retVal = 0; 
	    String msg = "";
		ContentsMgr mycontentsMgr = new ContentsMgr();
		MasterMgr masterMgr = new MasterMgr();
    	retVal = mycontentsMgr.deleteContents(box);
    	masterMgr.deleteMaster(box);
		if(retVal > 0) msg = "내컨텐츠를 삭제하는데 성공하였습니다.";
		else  msg = "내컨텐츠를 삭제하는데 실패하였습니다.";

	    String url = "/back/cms/Contents.do?cmd=myContentsPageList&p_contsgubun="+box.getString("p_contsgubun");
		url += box.getSearchParam();
		
		return alertAndExit(request, msg, url, "");
	} 	

	/**
	 * 컨텐츠 저장소에서 컨텐츠를 삭제했을 경우 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward recContentsDelete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		int retVal = 0; 
	    String msg = "";
		ContentsMgr mycontentsMgr = new ContentsMgr();
    	retVal = mycontentsMgr.deleteContents(box);
		if(retVal > 0) msg = "컨텐츠 저장소에서 컨텐츠를 삭제하는데 성공하였습니다.";
		else  msg = "컨텐츠 저장소에서 컨텐츠를 삭제하는데 실패하였습니다.";

	    String url = "/back/cms/Contents.do?cmd=contentsRepPageList";
		url += box.getSearchParam();
		
		return alertAndExit(request, msg, url, "");
	} 	
	
	/**
	 * Contents 검색 팝업 페이지로 이동을 해준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward contentsSearchPageList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{

		return mapping.findForward("ContentsSearchPageList");
	}
	
	/**
	 * Contents 검색 팝업 페이지 리스트를 가져온다.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public PagingDTO contentsSearchPageListCallBack(HashMap map) throws Exception{
 	    ContentsMgr mycontentsMgr = new ContentsMgr();
 	    Box box = new Box(map);
		ListDTO data = mycontentsMgr.selectContentsSearchPageList(box);
		
		return data.getPagingDTO();		
	}
	
	/**
	 * 컨텐츠를 저장소에 등록 요청을 해준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward contentsRepWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		int retVal = 0; 
	    String msg = "";
		String v_contsgubun = box.getString("p_contsgubun");
	    ContentsMgr mycontentsMgr = new ContentsMgr();
		retVal = mycontentsMgr.updateContentsRep(box);
		if(retVal > 0) msg = "컨텐츠를 저장소에 등록하는데 성공하였습니다.";
		else  msg = "컨텐츠를 저장소에 등록하는데 실패하였습니다.";
		
		String url = "/back/cms/Item.do?cmd=itemList";
		
		url += box.getSearchParam()+"&p_contsgubun="+v_contsgubun+"&p_contsid="+box.getString("p_contsid");
		
		return alertAndExit(request, msg, url, "");
	} 
	
	/**
	 * 저장소 등록 요청 컨텐츠 리스트 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward myReqContentsPageList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{

		return mapping.findForward("MyReqContentsPageList");
	}	

	/**
	 * 저장소 등록 요청 컨텐츠 리스트 
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public PagingDTO myReqContentsPageListCallBack(HashMap map) throws Exception{
 	    ContentsMgr mycontentsMgr = new ContentsMgr();
 	    Box box = new Box(map);
		ListDTO data = mycontentsMgr.selectReqContentsPageList(box);
		
		return data.getPagingDTO();		
	}
	
	/**
	 * 북마크 페이지 리스트 페이지로 이동한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward bookmarkPageList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{

		return mapping.findForward("BookmarkPageList");
	}	

	/**
	 * 북마크 페이지 리스트를 가져온다.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public PagingDTO bookmarkPageListCallBack(HashMap map) throws Exception{
 	    ContentsMgr mycontentsMgr = new ContentsMgr();
 	    Box box = new Box(map);
		ListDTO data = mycontentsMgr.selectBookmarkPageList(box);
		
		return data.getPagingDTO();		
	}

	/**
	 * 북마크를 삭제해준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward bookmarkDelete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		int retVal = 0; 
	    String msg = "";
		ContentsMgr mycontentsMgr = new ContentsMgr();
    	retVal = mycontentsMgr.deleteBookmark(box);
		if(retVal > 0) msg = "북마크를 삭제하는데 성공하였습니다.";
		else  msg = "북마크를 삭제하는데 실패하였습니다.";

	    String url = "/back/cms/Contents.do?cmd=bookmarkPageList";
		url += box.getSearchParam();
		
		return alertAndExit(request, msg, url, "");
	} 	

	/**
	 * 컨텐층 승인 페이지로 이동을 한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward contentsRecPageList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{

		return mapping.findForward("ContentsRecPageList");
	}	

	/**
	 * 컨텐츠 승인 리스트를 가져온다.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public PagingDTO contentsRecPageListCallBack(HashMap map) throws Exception{
 	    ContentsMgr contentsMgr = new ContentsMgr();
 	    Box box = new Box(map);
		ListDTO data = contentsMgr.selectContentsRecPageList(box);
		
		return data.getPagingDTO();		
	}
	
	public ActionForward contentsRecWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		int retVal = 0; 
	    String msg = "";
		ContentsMgr contentsMgr = new ContentsMgr();
    	String v_state = box.getString("p_state");
    	if(v_state.equals("C")) v_state = "컨텐츠 승인 작업을";
    	else v_state = "컨텐츠 반려 작업을";

    	retVal = contentsMgr.updateContentsRec(box);
		if(retVal > 0) msg = " 성공하였습니다.";
		else  msg = " 실패하였습니다.";

	    String url = "/back/cms/Contents.do?cmd=contentsRecPageList";
		url += box.getSearchParam();
		
		return alertAndExit(request, msg, url, "");
	} 
	
	/**
	 * 저장소의 컨텐츠 리스트 페이지로 이동을 한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward contentsRepPageList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{

		return mapping.findForward("ContentsRepPageList");
	}	

	/**
	 * 저장소의 컨텐츠 페이지 리스트를 가져온다.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public PagingDTO contentsRepPageListCallBack(HashMap map) throws Exception{
 	    ContentsMgr contentsMgr = new ContentsMgr();
 	    Box box = new Box(map);
		ListDTO data = contentsMgr.selectContentsRepPageList(box);
		
		return data.getPagingDTO();		
	}
	
	/**
	 * 유통사 컨텐츠 검색
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public PagingDTO externalContentsPageListCallBack(HashMap map) throws Exception{
 	    ContentsMgr contentsMgr = new ContentsMgr();
 	    Box box = new Box(map);
		ListDTO data = contentsMgr.selectExternalContentsList(box);
		
		return data.getPagingDTO();		
	}
	
	
    /**
     * 북마크를 등록해 준다.
     * @param map
     * @return
     * @throws Exception
     */
	public int contentsBookmarkCallBack(HashMap map) throws Exception{
 	    ContentsMgr contentsMgr = new ContentsMgr();
 	    Box box = new Box(map);
		int v_retval = contentsMgr.insertContentsBookmark(box);
		
		return v_retval;		
	}

	/**
	 * 컨텐츠를 추천해준다.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public int contentsRecommCallBack(HashMap map) throws Exception{
 	    ContentsMgr contentsMgr = new ContentsMgr();
 	    Box box = new Box(map);
		int v_retval = contentsMgr.insertContentsRecomm(box);
		
		return v_retval;		
	}

	/**
	 * 메타정보를 가져온다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward metadataShow(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
 	    ContentsMgr contentsMgr = new ContentsMgr();
 		DataSet ds = contentsMgr.selectMetadata(box);
 
 		box.put("Metadata", ds.getFirstObject());
 		 
		return mapping.findForward("MetadataShow");
	}

	/**
	 * 프로젝트 컨텐츠를 등록하는 페이지로 이동한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward projContentsWriteForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		ContentsMgr mycontentsMgr = new ContentsMgr();
		String v_contsid = box.getString("s_projcontsid");
		box.put("p_projid", box.getString("s_projid"));

		if(!v_contsid.equals("")){
			box.put("p_contsid", v_contsid); 
			HashMap map = mycontentsMgr.selectContents(box);

			box.put("ProjConts", map.get("MyConts"));
			box.put("Metadata", map.get("Metadata"));
	    }
             
		return mapping.findForward("ProjectContentsWrite");
	}
	
	/**
	 * 프로젝트 컨텐츠를 등록,수정해준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward projContentsWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		String v_mode = box.getString("p_mode");
		int retVal = 0; 
	    String msg = "";
		ContentsMgr mycontentsMgr = new ContentsMgr();
		if(v_mode.equals("W")){
			retVal = mycontentsMgr.insertContents(box);
			if(retVal > 0) {
			    ProductMgr productMgr = new ProductMgr();
			    retVal = productMgr.insertProductBasic(box);
				msg = "프로젝트 컨텐츠를 등록하는데 성공하였습니다.";
			}else  msg = "프로젝트 컨텐츠를 등록하는데 실패하였습니다.";
	    }else{
	    	retVal = mycontentsMgr.updateContents(box);
			if(retVal > 0) msg = "프로젝트 컨텐츠를 수정하는데 성공하였습니다.";
			else  msg = "프로젝트 컨텐츠를 수정하는데 실패하였습니다.";
	    }
		CommonUtil.setSessionValue("s_projcontsid", box.getString("p_contsid"), request);
	    String url = "/back/cms/Contents.do?cmd=projContentsWriteForm&p_mode=E";
		url += "&p_projid="+box.getString("p_projid")+"&p_contsid="+box.getString("p_contsid");
		
		return alertAndExit(request, msg, url, "");
	} 

}
