
package com.sinc.lms.billpublish;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.sinc.framework.data.Box;
import com.sinc.framework.data.DataSet;
import com.sinc.framework.data.RequestManager;
import com.sinc.framework.struts.StrutsDispatchAction;
import com.sinc.framework.util.DateTimeUtil;
import com.sinc.framework.util.FileUtil;
import com.sinc.framework.util.UploadFile;
import com.sinc.framework.util.UploadFiles;
import com.sinc.lms.unempinsurance.StudyStudentMgr;

/**
 * 모든 클래스에서 사용할 공통 코드를 관리하는 클래스
 */
/**
 * XDoclet definition:
 * @struts:action path="/front/FileBox" validate="false" parameter="cmd" scope="request"
 * @struts:action-forward name="FillBoxList" path="/jsp/front/new_templateMaster.jsp?body=/jsp/front/common/propose/fileboxList.jsp"
 * @struts:action-forward name="RequestForm" path="/jsp/front/common/propose/billrequestPop.jsp"
 * @struts:action-forward name="RequestReceiptForm" path="/jsp/front/common/propose/receiptRequestPop.jsp"
 * @struts:action-forward name="RefundDocuments" path="/jsp/front/common/propose/refundDocumentsPop.jsp"
 * @struts:action-forward name="RequestTrainingForm" path="/jsp/front/common/propose/requestTrainingFormPop.jsp"
 */

public class FileBoxFaction extends StrutsDispatchAction {

	/**
	 * 서류함  리스트를 가져온다.
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward fileBoxList (
			ActionMapping mapping, 
			ActionForm form,
			HttpServletRequest request, 
			HttpServletResponse response, 
			Box box )
	throws Exception {
		
		BillPublishMgr billPubMgr = new BillPublishMgr();
		DataSet dsfileBoxList = billPubMgr.selectFileBoxList(box);
		box.put("dsfileBoxList", dsfileBoxList);
		
		return mapping.findForward("FillBoxList");
	}
	
	/**
	 * 계산서 신청 Form 
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward requestForm (
			ActionMapping mapping, 
			ActionForm form,
			HttpServletRequest request, 
			HttpServletResponse response, 
			Box box )
	throws Exception {
		
		BillPublishMgr billPubMgr = new BillPublishMgr();
		Box billReqInfo =  billPubMgr.selectBillPubRequestInfo(box);
		box.put("billReqInfo", billReqInfo);   
		
		return mapping.findForward("RequestForm");
	}
	
	/**
	 * 영수증  신청 Form 
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward requestReceiptForm (
			ActionMapping mapping, 
			ActionForm form,
			HttpServletRequest request, 
			HttpServletResponse response, 
			Box box )
	throws Exception {
		
		return mapping.findForward("RequestReceiptForm");
	}
	
	
	/**
	 * 계산서 신청 정보를 입력/수정한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 * 
	 * @ 신청 입력하기 전 출력이 되었었는지 확인하고 되었으면 삭제 후 입력 or 아니면 그냥 입력 (2012.07.31 수정)
	*/
	public ActionForward billRequestWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
	   String msg = "";
		
		//파일업로드
		String uploadPath	= "/billpubreq/"+box.getString("subj")+"/"+box.getString("year")+"/"+box.getString("subjseq");
//			int v_maxfilesize	= box.getInt("p_maxfilesize");
		int v_maxfilesize	= 10;
		
		UploadFiles files 	= FileUtil.upload(request, uploadPath, v_maxfilesize, false, "A", DateTimeUtil.getDateTime());
		RequestManager.getMultiBox(box, files.getMultipart());

		//파일 업로드 상태를 체크한다.(파일을 등록하지 않을경우도 "S")
		if ( files.getStatus().equals("S") && files.getFiles().size() > 0 ) {
			UploadFile file = null;
			for ( int i=0; i < files.getFiles().size(); i++ ) {
				file = (UploadFile)files.getFiles().get(i);
				
				if ( file.getObjName().equals("p_bizlicenserealname") ) {
					box.put("p_bizlicensesavename", file.getUploadName());
					box.put("p_bizlicenserealname", file.getRootName());
				} else if ( file.getObjName().equals("p_proofemprealname") ) {
					box.put("p_proofempsavename", file.getUploadName());
					box.put("p_proofemprealname", file.getRootName());
				} else if ( file.getObjName().equals("p_picturefile") ) {
					box.put("p_picturefile", file.getUploadName());
				}
			}
		}
		// "파일 확장자가 JSP,ASP,PHP,HTM,HTML인 파일은 업로드 할 수 없습니다"
		else if ( files.getStatus().equals("V") ) {
			return alertPopupClose(request, FileUtil.UPLOAD_VALIDATE_MSG, "");
		}else if(files.getFiles().size()<1){
			box.put("p_picturefile", box.getString("imgsrc"));
		}
	   	   	   
		try {
				BillPublishMgr billPubMgr = new BillPublishMgr();
				/*System.out.println("#####################################################");
				System.out.println(" box.getString(p_seq) : " +  box.getString("p_seq"));
				System.out.println("#####################################################");*/
				
				int retVal = billPubMgr.insertBillReq(box);		
				
				if(retVal > 0) {
					msg = "저장에 성공하였습니다.";
				} else {
					msg = "저장에실패하였습니다.";
				}
				
				
		} catch(Exception e) {
			if(e.getMessage() != null) {
					msg = e.getMessage();
			}
		}		
		return closePopupReload(request, msg, "", "");
	}
	
	/**
	 * 영수증 신청.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	*/
	public ActionForward requestReceipt(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
	   String msg = "";
		try {
				BillPublishMgr billPubMgr = new BillPublishMgr();
				int retVal = billPubMgr.updateRequestReceipt(box);		
			
				if(retVal > 0) {
					msg = "신청에  성공하였습니다.";
				} else {
					msg = "신청에  실패하였습니다.";
				}
		} catch(Exception e) {
			if(e.getMessage() != null) {
				msg = e.getMessage();
			}
		}		
		
		return closePopupReload(request, msg, "", "");
	}
	
	/**
	 * 환불서류 팝업 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	*/
	public ActionForward refundDocuments(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
		
		return mapping.findForward("RefundDocuments");
	}
	
	/**
	 * 위수탁 훈련계약서 Form  
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	*/
	public ActionForward requestTrainingForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
		
		Box databox = null; 
		StudyStudentMgr studyStudent = new StudyStudentMgr();
		databox = studyStudent.selectTrainingContract(box);
		
		if(databox == null){
			databox = new Box("data");
		}
		box.put("data", databox);
		return mapping.findForward("RequestTrainingForm");
	}
	
	/**
	 * 위수탁계약서 발행을 위한 정보 저장 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	*/
	public ActionForward requestTrainingWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
	   String msg = "";
	   int retVal = 0; 
	   
		try {
				
				StudyStudentMgr studyStudent = new StudyStudentMgr();
				retVal = studyStudent.doSaveTrainingEtcInfo(box);				
				
		} catch(Exception e) {
			if(e.getMessage() != null) {
				msg = e.getMessage();
			}
		}		
		if(retVal > 0) {
			
			box.put("p_isSave" , "Y" );	
			Box databox = null; 
			StudyStudentMgr studyStudent = new StudyStudentMgr();
			databox = studyStudent.selectTrainingContract(box);
			box.put("data", databox);			
			return mapping.findForward("RequestTrainingForm");
		} else {
			return alertPopupClose(request, "정보 저장에  실패하였습니다.", "");
		}		
	}
}
