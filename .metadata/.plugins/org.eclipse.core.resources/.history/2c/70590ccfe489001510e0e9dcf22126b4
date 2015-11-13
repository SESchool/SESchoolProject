/**
 * @(#)TbCateAction
 *
 * Copyright 2006 mediopia. All Rights Reserved.
 *
 * T_LMS_CODEGUBUN, T_LMS_CODE 테이블 Action 클래스.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2010. 11. 06.  leehj       Initial Release
 ************************************************
 *
 * @author      leehj
 * @version     1.0
 * @since       2010. 11. 06.
 */

package com.sinc.lms.comp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.sinc.framework.data.Box;
import com.sinc.framework.data.DataSet;
import com.sinc.framework.data.RequestManager;
import com.sinc.framework.persist.ListDTO;
import com.sinc.framework.persist.PagingDTO;
import com.sinc.framework.struts.StrutsDispatchAction;
import com.sinc.framework.util.DateTimeUtil;
import com.sinc.framework.util.FileUtil;
import com.sinc.framework.util.StringUtil;
import com.sinc.framework.util.UploadFile;
import com.sinc.framework.util.UploadFiles;
import com.sinc.lms.course.SubjectMgr;
import com.sinc.lms.member.MemberMgr;
import com.sinc.lms.propose.PaymentMgr;
import com.sinc.lms.propose.ProposeMgr;

/**
 * 고객사를 관리하는 클래스
 */
/** 
 * XDoclet definition:
 * @struts:action path="/back/Comp" validate="false" parameter="cmd" scope="request"
 * @struts:action-forward name="CompPageList" path="/jsp/back/lms/comp/compPageList.jsp"
 * @struts:action-forward name="CompWriteForm" path="/jsp/back/lms/comp/compWrite.jsp"
 * @struts:action-forward name="GroupList" path="/jsp/back/lms/comp/groupList.jsp"
 * @struts:action-forward name="GroupWriteForm" path="/jsp/back/lms/comp/groupWrite.jsp"
 * @struts:action-forward name="BusinessPlcList" path="/jsp/back/lms/comp/businessPlcList.jsp"
 * @struts:action-forward name="BusinessPlcWriteForm" path="/jsp/back/lms/comp/businessPlcWrite.jsp"
 * @struts:action-forward name="CompSubjMapping" path="/jsp/back/lms/comp/compSubjMapping.jsp" 
 * @struts:action-forward name="CompSubjMappedSettingList" path="/jsp/back/lms/comp/compSubjMappedSettingList.jsp"
 * @struts:action-forward name="CompSubjMappedSettingWritePopup" path="/jsp/back/lms/comp/compSubjMappedSettingWritePopup.jsp"
 * @struts:action-forward name="CompSubjMappingExcelPopup" path="/jsp/back/lms/comp/compSubjMappingExcelPopup.jsp"
 * @struts:action-forward name="fosterTraining" path="/jsp/back/lms/comp/listFosterTraining.jsp" 
 * @struts:action-forward name="innerListFosterTraining" path="/jsp/back/lms/comp/innerListFosterTraining.jsp" 
 * @struts:action-forward name="fosterWriteForm" path="/jsp/back/lms/comp/frmWriteFosterTraining.jsp"
 * @struts:action-forward name="fosterTrainingEditForm" path="/jsp/back/lms/comp/frmEditFosterTraining.jsp"
 * @struts:action-forward name="fosterMemo" path="/jsp/back/lms/comp/popFrmEditMemo.jsp"
 * @struts:action-forward name="fosterExcelPageList" path="/jsp/back/lms/comp/listExcelFosterTraining.jsp"
 * @struts:action-forward name="externalSalesCompList" path="/jsp/back/lms/comp/externalSalesCompList.jsp"
 * @struts:action-forward name="externalSalesCompInfo" path="/jsp/back/lms/comp/externalSalesCompInfo.jsp"
 * @struts:action-forward name="externalSalesCompSearchContents" path="/jsp/back/lms/comp/externalSalesCompSearchContents.jsp"
 * @struts:action-forward name="externalSalesCompInfoWrite" path="/jsp/back/lms/comp/externalSalesCompList.jsp"
 * @struts:action-forward name="externalSalesCompInfoUpdate" path="/jsp/back/lms/comp/externalSalesCompList.jsp"
 * @struts:action-forward name="externalSalesCompInfoDelete" path="/jsp/back/lms/comp/externalSalesCompList.jsp"
 * @struts:action-forward name="externalCompMemoForm" path="/jsp/back/lms/comp/externalCompMemoPop.jsp"
 */
public class CompBaction extends StrutsDispatchAction {
	/**
	 * 고객사 리스트를 가져온다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward compPageList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		return mapping.findForward("CompPageList");
	}
	
    /**
	 * 고객사리스트를 반환해 준다. 
     * @param map
     * @return
     * @throws Exception
     */	
	public PagingDTO compPageListCallBack(HashMap map) throws Exception{
		CompMgr compMgr = new CompMgr();
		Box box = new Box(map);
		ListDTO data = compMgr.selectCompPageList(box);
		
		return data.getPagingDTO();
	}

    /**
     * 고객사 등록폼 페이지를 띄워준다.
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @param box
     * @return
     * @throws Exception
     */
	public ActionForward compWriteForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{		
		String p_mode = box.getString("p_mode");
		DataSet data = null;

		// p_mode의 값이 'E' 수정작업 이므로 기존 데이터를 가져와서 뷰단에 보내준다.
		if(p_mode.equals("E")){
		   CompMgr compMgr = new CompMgr();
		   data = compMgr.selectComp(box.getString("p_comp"));
		   box.put("Comp", data.getFirstObject());
		}
		return mapping.findForward("CompWriteForm");
	} 

	/**
	 * 고객사를 등록, 수정 처리해준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward compWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{	
		String v_filePath = "/comp/";
		
		UploadFiles files = FileUtil.upload(request, v_filePath, 10, false, "A","comp");	
		RequestManager.getMultiBox(box,files.getMultipart());
		String v_mode = box.getString("p_mode");
	    String v_complogo = "", v_complogobottom = "";
	    
		ArrayList fileList = files.getFiles();
	    UploadFile file = null;
	   	if(files.getStatus().equals("S")){
	       	for(int i =0; i < files.getUploadFileSize();i++){
	       	     file = (UploadFile)fileList.get(i);
	       	     if(file.getObjName().equals("p_file")) v_complogo = file.getUploadName();
	       	     if(file.getObjName().equals("p_file1")) v_complogobottom = file.getUploadName();
	       	}
	    } 
	
	   	String v_oldfile = box.getString("p_oldfile");
	   	String v_oldfile1 = box.getString("p_oldfile1");
	   	if(!v_complogo.equals("")){
		   	box.put("p_complogo",v_complogo);
			if(!v_oldfile.equals("")) FileUtil.delFile(FileUtil.UPLOAD_PATH+v_filePath+v_oldfile.replaceAll("_D", ""));
	   	}else{
	   		if(v_oldfile.indexOf("_D") > -1) {
	   			FileUtil.delFile(FileUtil.UPLOAD_PATH+v_filePath+v_oldfile.replaceAll("_D", ""));
			   	box.put("p_complogo","");
	   		}else{
			   	box.put("p_complogo",v_oldfile);
	   		}
	   	}
	   	if(!v_complogobottom.equals("")){
		   	box.put("p_complogobottom",v_complogobottom);
			if(!v_oldfile1.equals("")) FileUtil.delFile(FileUtil.UPLOAD_PATH+v_filePath+v_oldfile1.replaceAll("_D", ""));
	   	}else{
	   		if(v_oldfile1.indexOf("_D") > -1) {
	   			FileUtil.delFile(FileUtil.UPLOAD_PATH+v_filePath+v_oldfile1.replaceAll("_D", ""));
			   	box.put("p_complogobottom","");
	   		}else{
			   	box.put("p_complogobottom",v_oldfile1);
	   		}
	   	}
	   	
		CompMgr compMgr = new CompMgr();
		String msg = null;
		int retVal = 0;
		
		if(v_mode.equals("W")){
		    retVal = compMgr.insertComp(box);
		    if(box.getString("p_uppercomp").equals("")) box.put("p_uppercomp", "000000");
		    if(retVal > 0) msg = "고객사 등록에 성공하였습니다.";
		    else msg = "고객사 등록에 실패하였습니다.";
		}else if (v_mode.equals("E")){ 
		    retVal = compMgr.updateComp(box);
		    if(retVal > 0) msg = "고객사 수정에 성공하였습니다.";
		    else msg = "고객사 수정에 실패하였습니다.";
		}
       
		String url = "/back/Comp.do?cmd=compPageList"+box.getSearchParam();
		return alertAndExit(request, msg,url,"");
	}
	
	/**
	 * 고객사를 삭제해준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward compDelete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{	

		CompMgr compMgr = new CompMgr();
		String msg = null;
		int retVal = 0;
		
	    retVal = compMgr.deleteComp(box);
	    if(retVal > 0) msg = "고객사 정보 수정에 성공하였습니다.";
	    else msg = "고객사 정보 수정에 실패하였습니다.";
       
		String url = "/back/Comp.do?cmd=compPageList"+box.getSearchParam();
		return alertAndExit(request, msg,url,"");
	}
	
	/**
	 * Prefix가 있는지를 체크한다.
	 * @param prefix
	 * @return
	 * @throws Exception
	 */
	public String prefixCheckCallBack(String prefix) throws Exception{
 	    CompMgr compMgr = new CompMgr();
 	    int data = compMgr.selectPrefixCheck(prefix);
	
		return ""+data;
	}	
	
	/**
	 * 그룹 리스트를 가져온다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward groupList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		return mapping.findForward("GroupList");
	}
	
    /**
	 * 그룹리스트를 반환해 준다. 
     * @param map
     * @return
     * @throws Exception
     */	
	public List groupListCallBack() throws Exception{
		CompMgr compMgr = new CompMgr();
		List data = compMgr.selectGroupList();
		
		return data;
	}

    /**
     * 그룹 등록폼 페이지를 띄워준다.
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @param box
     * @return
     * @throws Exception
     */
	public ActionForward groupWriteForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{		
		String p_mode = box.getString("p_mode");
		DataSet data = null;

		// p_mode의 값이 'E' 수정작업 이므로 기존 데이터를 가져와서 뷰단에 보내준다.
		if(p_mode.equals("E")){
		   CompMgr compMgr = new CompMgr();
		   data = compMgr.selectGroup(box.getString("p_comp"));
		   box.put("Group", data.getFirstObject());
		}
		return mapping.findForward("GroupWriteForm");
	}
	
	/**
	 * 사업장을 등록, 수정 처리해준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward groupWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{	
		String v_mode = box.getString("p_mode");

		CompMgr compMgr = new CompMgr();
		String msg = null;
		int retVal = 0;
		
		if(v_mode.equals("W")){
		    retVal = compMgr.insertGroup(box);
		    if(box.getString("p_uppercomp").equals("")) box.put("p_uppercomp", "000000");
		    if(retVal > 0) msg = "그룹 등록에 성공하였습니다.";
		    else msg = "그룹 등록에 실패하였습니다.그룹코드가 중복이 되었는지 확인 바랍니다.";
		}else if (v_mode.equals("E")){ 
		    retVal = compMgr.updateGroup(box);
		    if(retVal > 0) msg = "그룹 수정에 성공하였습니다.";
		    else msg = "그룹 수정에 실패하였습니다.";
		}
       
		String url = "/back/Comp.do?cmd=groupList";
		return alertAndExit(request, msg,url,"");
	}
	
	/**
	 * 그룹을 삭제해준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward groupDelete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{	

		CompMgr compMgr = new CompMgr();
		String msg = null;
		int retVal = 0;
		
	    retVal = compMgr.deleteGroup(box);
	    if(retVal > 0) msg = "그룹 수정에 성공하였습니다.";
	    else msg = "그룹 수정에 실패하였습니다.";
       
		String url = "/back/Comp.do?cmd=groupList"+box.getSearchParam();
		return alertAndExit(request, msg,url,"");
	}
	
	/**
	 * 그룹 리스트를 가져온다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward businessPlcList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		return mapping.findForward("BusinessPlcList");
	}
	
    /**
	 * 사업장리스트를 반환해 준다. 
     * @param map
     * @return
     * @throws Exception
     */	
	public List businessPlcListCallBack(String comp) throws Exception{
		CompMgr compMgr = new CompMgr();
		List data = compMgr.selectBusinessPlcList(comp);
		
		return data;
	}

    /**
     * 사업장 등록폼 페이지를 띄워준다.
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @param box
     * @return
     * @throws Exception
     */
	public ActionForward businessPlcWriteForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{		
		String p_mode = box.getString("p_mode");
		DataSet data = null;

		// p_mode의 값이 'E' 수정작업 이므로 기존 데이터를 가져와서 뷰단에 보내준다.
		if(p_mode.equals("E")){
		   CompMgr compMgr = new CompMgr();
		   data = compMgr.selectBusinessPlc(box);
		   box.put("BusinessPlc", data.getFirstObject());
		}
		return mapping.findForward("BusinessPlcWriteForm");
	}
	
	/**
	 * 사업장을 등록, 수정 처리해준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward businessPlcWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{	
		String v_mode = box.getString("p_mode");

		CompMgr compMgr = new CompMgr();
		String msg = null;
		int retVal = 0;
		
		if(v_mode.equals("W")){
			DataSet ds = compMgr.selectBusinessPlc(box);
            if(ds != null && ds.getRow() > 0) msg = "사업장 코드가 이미 존재하여 등록에 실패하였습니다.";
            else{	
 			    retVal = compMgr.insertBusinessPlc(box);
			    if(box.getString("p_uppercomp").equals("")) box.put("p_uppercomp", "000000");
			    if(retVal > 0) msg = "사업장 등록에 성공하였습니다.";
			    else msg = "사업장 등록에 실패하였습니다.";
            }    
		}else if (v_mode.equals("E")){ 
		    retVal = compMgr.updateBusinessPlc(box);
		    if(retVal > 0) msg = "사업장 수정에 성공하였습니다.";
		    else msg = "사업장 수정에 실패하였습니다.";
		}
       
		String url = "/back/Comp.do?cmd=businessPlcList&p_comp="+box.getString("p_comp")+"&p_compnm="+box.getString("p_compnm");
		return alertAndExit(request, msg,url,"");
	}
	
	/**
	 * 사업장을 삭제해준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward businessPlcDelete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{	

		CompMgr compMgr = new CompMgr();
		String msg = null;
		int retVal = 0;
		
	    retVal = compMgr.deleteBusinessPlc(box);
	    if(retVal > 0) msg = "사업장 삭제에 성공하였습니다.";
	    else msg = "사업장 삭제에 실패하였습니다.";
       
		String url = "/back/Comp.do?cmd=businessPlcList&p_comp="+box.getString("p_comp")+"&p_compnm="+box.getString("p_compnm");
		return alertAndExit(request, msg,url,"");
	}	
	
	/**
	 * 고객사별 과정 매핑 페이지로 이동을 한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward compSubjMapping(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		return mapping.findForward("CompSubjMapping");
	}
	
    /**
	 * 고객사별 맵핑할 과정을 반환해 준다. 
     * @param map
     * @return
     * @throws Exception
     */	
	public List compSubjMappingListCallBack(HashMap map) throws Exception{
		CompMgr compMgr = new CompMgr();
		Box box = new Box(map);
		List data = compMgr.selectSubjMappingList(box);
		
		return data;
	}

	/**
	 * 맵핑된 과정리스트를 반환해 준다.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List compSubjMappedListCallBack(HashMap map) throws Exception{
		CompMgr compMgr = new CompMgr();
		Box box = new Box(map);
		List data = compMgr.selectSubjMappedList(box);
		
		return data;
	}
	
	/**
	 * 고객사별 과정을 맵핑처리해준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward compSubjMappingWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{	

		CompMgr compMgr = new CompMgr();
		String msg = null;
		int retVal = 0;
		
	    retVal = compMgr.insertCompSubj(box);
	    if(retVal > 0) msg = "고객사별과정을  등록하는데 성공하였습니다.";
	    else msg = "고객사별과정을  등록하는데 실패하였습니다.";
	    
	    if(retVal > 0) return commonProcForward(request, msg, "P", "jsMainList2();", "Y");
	    else return alertAndExit(request, msg, "");
	}

	/**
	 * 고객사별 과정 맵핑 정보를 삭제해준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward compSubjMappedDelete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{	

		CompMgr compMgr = new CompMgr();
		String msg = null;
		int retVal = 0;
		
	    retVal = compMgr.deleteCompCategory(box);
	    if(retVal > 0) msg = "고객사별과정을  삭제하는데 성공하였습니다.";
	    else msg = "고객사별과정을 삭제하는데 실패하였습니다.";
	    
	    if(retVal > 0) return commonProcForward(request, msg, "P", "jsMainList2();", "Y");
	    else return alertAndExit(request, msg, "");
	}

	/**
	 * 고객사별 과정에 대한 환경설정을 할 수 있는 페이지를 띄워준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward compSubjMappedSettingList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		return mapping.findForward("CompSubjMappedSettingList");
	}

	/**
	 * 고객사별 과정의 설정 정보를 등록해주는 등록 페이지로 이동한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward compSubjMappedSettingWritePopup(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		return mapping.findForward("CompSubjMappedSettingWritePopup");
	}

	/**
	 * 고객사별 과정 설정 정보를 등록해 준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward compSubjMappedSettingWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{	

		CompMgr compMgr = new CompMgr();
		String msg = null;
		int retVal = 0;
		
	    retVal = compMgr.updateCompCategory(box);
	    if(retVal > 0) msg = "고객사별과정 설정을  저장하는데 성공하였습니다.";
	    else msg = "고객사별과정 설정을 저장하는데 실패하였습니다.";
	    
	    if(retVal > 0) return commonProcForward(request, msg, "O", "jsMainList();", "Y");
	    else return alertPopupClose(request, msg, "");
	}
	
	// 고객사별과정 매핑 일괄 등록  폼 리턴
	public ActionForward compSubjMappingExcelPopup(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		return mapping.findForward("CompSubjMappingExcelPopup");
	}		

	/**
	 * 고객사별 과정 엑셀 등록 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */               
	public ActionForward SubjMappingExcelWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
		CompMgr compMgr = new CompMgr();
		String v_comp 		= StringUtil.nvl(box.getString("p_comp"));
		String msg 			= null;
		int[] nullChkCell	= null;
		int retVal 			= 0;
		
		UploadFiles files = FileUtil.upload(request, "/comp", 1, false, "M", DateTimeUtil.getDateTime());
		List subjList 	  = FileUtil.getExcelList(request, files, "/comp", nullChkCell);
		RequestManager.getMultiBox(box, files.getMultipart());
		box.put("p_comp", v_comp);
		if(subjList != null) { 
		    retVal = compMgr.insertSubjMappingExcel(box, subjList);
		    box.put("SubjMappingExcel", subjList);
		    box.put("SubjMappingExcelResult", ""+retVal);
		} 
		
		return mapping.findForward("CompSubjMappingExcelPopup"); 
	}	
	
	/**
	 * 고객사별 과정 맵핑 정보를 사용여부를 변경해준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward compSubjMappedUseyn(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{	

		CompMgr compMgr = new CompMgr();
		String msg = null;
		int retVal = 0;
		String usegubun = "사용";
		if(box.getString("p_useyn").equals("Y")){
			usegubun += "안";
			box.put("p_useyn","N");
		}else box.put("p_useyn","Y");
	    retVal = compMgr.updateCompCategoryUseyn(box);
	    if(retVal > 0) msg = "고객사별과정을 "+usegubun+"함으로 처리하는데 성공하였습니다.";
	    else msg = "고객사별과정을  "+usegubun+"함으로 처리하는데 실패하였습니다.";
	    
	    if(retVal > 0) return commonProcForward(request, msg, "P", "jsMainList2();", "Y");
	    else return alertAndExit(request, msg, "");
	}
	
	/**
	 * 고객사 리스트를 가져온다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward fosterTraining(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		String next =box.get("next");
		if( StringUtil.isNull(next)) {
			next = box.get("cmd");
		}
		return mapping.findForward(next);
	}	
	
	/**
	 * 연수고객 리스트를 조회 한다.
	 * @param mapping
	 * @param form
	 * @param request 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward fosterPageList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
		CompMgr compMgr = new CompMgr();
		String next = "" ;
		next = box.getString("next");
		if(StringUtil.isNull(next)) {
			next = box.getString("cmd");
		}
		
		ListDTO fosterVOs = compMgr.selectFosterList(box);
		box.put("fosterVOs", fosterVOs);
		return mapping.findForward(next);

	}	
	/**
	 * 연수고객 리스트를 조회 한다.
	 * @param mapping
	 * @param form
	 * @param request 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward fosterExcelPageList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
		CompMgr compMgr = new CompMgr();
		String next = "" ;
		next = box.getString("next");
		if(StringUtil.isNull(next)) {
			next = box.getString("cmd");
		}
		
		DataSet fosterVOs = compMgr.selectExcelFosterList(box);
		box.put("fosterVOs", fosterVOs);
		return mapping.findForward(next);

	}	
	/**
	 * 위탁연수고객을 저장한다.
	 * @param mapping
	 * @param form
	 * @param request 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward fosterTrainingWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{

		CompMgr compMgr = new CompMgr();
		String msg = null;
		int retVal = 0;
		
	    retVal = compMgr.insertFosterTraining(box);

	    if(retVal > 0) msg = "등록 하였습니다.";
	    else msg = "등록에 실패하였습니다.";
		
		StringBuilder searchParam = new StringBuilder();
		searchParam.append("&ps_counselyear="+box.getString("ps_counselyear")+"&ps_fieldcd="+box.getString("ps_fieldcd")+"&ps_pageno="+box.getString("ps_pageno")+"&ps_listScale="+box.getString("ps_listScale")+"&ps_isconfirm="+box.getString("ps_isconfirm") );
		searchParam.append("&ps_businesscd="+box.getString("ps_businesscd")+"&ps_search="+box.getString("ps_search")+"&ps_searchtext="+box.getString("ps_searchtext") );
		
		return alertAndExit(request, msg,"/back/Comp.do?cmd=fosterTraining&"+searchParam.toString(),"");
		

	}	
	
	/**
	 * 위탁연수고객을 수정한다.
	 * @param mapping
	 * @param form
	 * @param request 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward fosterTrainingEdit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{


		String cmd = "" ;
		CompMgr compMgr = new CompMgr();
		String msg = null;
		int retVal = 0;
		
		
	    retVal = compMgr.updateFosterTraining(box);

	    if(retVal > 0) msg = "수정 하였습니다.";
	    else msg = "수정에 실패하였습니다.";
		
		StringBuilder searchParam = new StringBuilder();
		searchParam.append("&ps_counselyear="+box.getString("ps_counselyear")+"&ps_fieldcd="+box.getString("ps_fieldcd")+"&ps_pageno="+box.getString("ps_pageno")+"&ps_listScale="+box.getString("ps_listScale")+"&ps_isconfirm="+box.getString("ps_isconfirm") );
		searchParam.append("&ps_businesscd="+box.getString("ps_businesscd")+"&ps_search="+box.getString("ps_search")+"&ps_searchtext="+box.getString("ps_searchtext") );
		
		return alertAndExit(request, msg,"/back/Comp.do?cmd=fosterTraining&"+searchParam.toString(),"");
		

	}	
	
	/**
	 * 위탁연수고객을 저장한다.
	 * @param mapping
	 * @param form
	 * @param request 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward fosterTrainingDelete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{

		CompMgr compMgr = new CompMgr();
		String msg = null;
		int retVal = 0;
		
	    retVal = compMgr.deleteFosterTraining(box);

	    if(retVal > 0) msg = "삭제 하였습니다.";
	    else msg = "삭제에 실패하였습니다.";
		
		return alertAndExit(request, msg,"/back/Comp.do?cmd=fosterTraining","");
	}	
	
	/**
	 * 위탁연수고객을 조회 한다.
	 * @param mapping
	 * @param form
	 * @param request 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward fosterTrainingEditForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
		CompMgr compMgr = new CompMgr();
		String next = "" ;
		next = box.getString("next");
		if(StringUtil.isNull(next)) {
			next = box.getString("cmd");
		}
		Box fosterVO = compMgr.getFosterTraining(box.getString("p_fosterseq"));
		box.put("fosterVO", fosterVO);
		Box fosterProgVO = compMgr.getFosterprog(box.getString("p_fosterseq"));
		box.put("fosterProgVO", fosterProgVO);		
		return mapping.findForward(next);
	}	
	
	/**
	 * 메모를 조회  한다.
	 * @param mapping
	 * @param form
	 * @param request 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward fosterMemo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
		CompMgr compMgr = new CompMgr();
		String next = "" ;
		next = box.getString("next");
		if(StringUtil.isNull(next)) {
			next = box.getString("cmd");
		}
		
		String memo = compMgr.getFosterMemo(box.getString("p_fosterseq"));
		box.put("MEMO", memo);
		return mapping.findForward(next);

	}	
	
	/**
	 * 메모를 조회  한다.
	 * @param mapping
	 * @param form
	 * @param request 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward updateFosterMemo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
		String cmd = "" ;
		CompMgr compMgr = new CompMgr();
		String msg = null;
		int retVal = 0;
		
		
	    retVal = compMgr.updateFosterMemo(box);

	    if(retVal > 0) msg = "수정 하였습니다.";
	    else msg = "수정에 실패하였습니다.";
		
		
		
		return alertAndExit(request, msg,"/back/Comp.do?cmd=fosterMemo&p_fosterseq="+box.getString("p_fosterseq"),"");

	}	
	
	/**
	 * 유통사 현황 page로 이동
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward externalSalesCompList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		return mapping.findForward("externalSalesCompList");
	}
	
	/**
	 * 유통사 정보를 등록 후, 페이지 이동
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward externalSalesCompInfoWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		// 등록
		int retVal = 0;
		CompMgr compMgr = new CompMgr();
		retVal = compMgr.externalSalesCompInfoWrite(box);
		if(retVal > 0 ) {
			return mapping.findForward("externalSalesCompInfoWrite");
		} else {
			return alertPopupClose(request, "등록 오류입니다.", "");
		}
	}
	
	/**
	 * 유통사 정보를 수정 후, 페이지 이동
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward externalSalesCompInfoUpdate(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		// 수정
		int retVal = 0;
		CompMgr compMgr = new CompMgr();
		retVal = compMgr.externalSalesCompInfoUpdate(box);
		if(retVal > 0 ) {
			return mapping.findForward("externalSalesCompInfoUpdate");
		} else {
			return alertPopupClose(request, "수정 오류입니다.", "");
		}
	}
	
	/**
	 * 유통사 정보를 삭제 후, 페이지 이동
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward externalSalesCompInfoDelete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		// 삭제
		int retVal = 0;
		CompMgr compMgr = new CompMgr();
		retVal = compMgr.externalSalesCompInfoDelete(box);
		if(retVal > 0 ) {
			return mapping.findForward("externalSalesCompInfoDelete");
		} else {
			return alertPopupClose(request, "삭제 오류입니다.", "");
		}
	}
	
	/**
	 * 유통사 정보를 가져온다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward externalSalesCompInfo (ActionMapping mapping, ActionForm form,	HttpServletRequest request,	HttpServletResponse response, Box box ) throws Exception {
		String v_comp_seq = "";
		v_comp_seq = box.getString("p_comp_seq");
		box.put("p_comp_seq", (String)v_comp_seq);
		
		// 유통사 정보를 가져온다.
		CompMgr compMgr = new CompMgr();
		Box externalSalesCompInfo = compMgr.externalSalesCompInfo(box.getMap());
		box.put("externalSalesCompInfo", externalSalesCompInfo);
		
		return mapping.findForward("externalSalesCompInfo");
	}
	
	/**
	 * 유통사 컨텐츠 리스트를 가져온다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward externalSalesCompSearchContents(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		String v_comp_seq = "";
		v_comp_seq = box.getString("p_comp_seq");
		box.put("p_comp_seq", (String)v_comp_seq);
		
		return mapping.findForward("externalSalesCompSearchContents");
	}
	
	/**
	 * 유통사 리스트를 가져온다.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public PagingDTO externalSalesCompListCallBack(HashMap map) throws Exception{
		CompMgr compMgr = new CompMgr();
		Box box = new Box(map);
		String v_search = box.getString("l_search");
		String v_searchtext = box.getString("l_searchtext");
		String v_sortorder = box.getString("l_sortorder");
		
		box.put("p_search", v_search);
		box.put("p_searchtext", v_searchtext);
		box.put("p_sortorder", v_sortorder);
		
		ListDTO data = compMgr.externalSalesCompListCallBack(box);
		
		return data.getPagingDTO();
	}
	
	/**
	 * 유통사 컨텐츠 리스트를 가져온다.
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List externalSalesContentsListCallBack(HashMap map) throws Exception{
		CompMgr compMgr = new CompMgr();
		Box box = new Box(map);
		DataSet data = null;
		
		data = compMgr.externalSalesContentsList(box);
		return data.getDataSet();
	}	
	
	/**
	 * 유통사 메모 팝업
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward externalCompMemoForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
	   CompMgr compMgr = new CompMgr();
	   DataSet datads = compMgr.selectexternalCompMemo(box);
	   box.put("MemoInfo","");
	   String v_compnm = "";
	   for(int i = 0 ; i < datads.getRow(); i++){
		   datads.next();		   
		   if(i == 0){	
			   box.put("MemoInfo",  (datads.getRow() == 1)? datads.getString("MEMO"):"" );
			   v_compnm += datads.getString("COMPNM");
		   }else {
			   v_compnm += ","+datads.getString("COMPNM");
		   }   
	   }
	   	box.put("p_compnm", v_compnm);	
		return mapping.findForward("externalCompMemoForm");
	}
	
	/**
	 * 유통사 메모 등록
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward externalCompMemo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{	
		String msg = "";
		try {
			CompMgr compMgr = new CompMgr();
			int retVal = compMgr.insertExternalCompMemo(box);	
			if(retVal > 0) {
				msg = "메모 등록을 성공 하였습니다.";
			} else {
				msg = "메모 등록을 실패 하였습니다.";
			}
		} catch(Exception e) {
			if(e.getMessage() != null) {
				msg = e.getMessage();
			}
		}		
		return closePopupReload(request, msg, "", "");
	}
 }
