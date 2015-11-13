/**
 * @(#)TbCateAction
 *
 * Copyright 2006 mediopia. All Rights Reserved.
 *
 * T_LMS_DIC, T_LMS_DICGROUP 테이블 Action 클래스.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2010. 12. 16.  leehj       Initial Release
 ************************************************
 *
 * @author      leehj
 * @version     1.0
 * @since       2010. 12. 16.
 */

package com.sinc.lms.propose;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.sinc.common.FormatDate;
import com.sinc.common.OzReport;
import com.sinc.framework.data.Box;
import com.sinc.framework.data.DataSet;
import com.sinc.framework.data.RequestManager;
import com.sinc.framework.struts.StrutsDispatchAction;
import com.sinc.framework.util.DateTimeUtil;
import com.sinc.framework.util.FileUtil;
import com.sinc.framework.util.StringUtil;
import com.sinc.framework.util.UploadFile;
import com.sinc.framework.util.UploadFiles;
import com.sinc.lms.comp.CompMgr;
import com.sinc.lms.complete.FinishMgr;
import com.sinc.lms.course.SubjSeqMgr;
import com.sinc.lms.course.SubjectMgr;
import com.sinc.lms.cp.CPSubjectMgr;
import com.sinc.lms.delivery.DeliveryMgr;
import com.sinc.lms.member.MemberMgr;
import com.sinc.lms.message.MessageMgr;
import com.sinc.lms.study.MyClassMgr;
import com.sinc.lms.studybook.StudyBookMgr;
import com.sinc.lms.sulmun.SulmunMgr;
import com.sinc.lms.support.MileageMgr;

/**
 * 모든 클래스에서 사용할 공통 코드를 관리하는 클래스
 */
/**
 * XDoclet definition:
 * @struts:action path="/front/Propose" validate="false" parameter="cmd" scope="request"
 * @struts:action-forward name="CourseApprovalList" path="/jsp/front/templateMaster.jsp?body=/jsp/front/home02/propose/approvalList.jsp"
 * @struts:action-forward name="ProposeList" path="/jsp/front/new_templateMaster.jsp?body=/jsp/front/common/propose/proposeList.jsp"
 * @struts:action-forward name="ProposeListPre" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/proposeListPre.jsp"
 * @struts:action-forward name="ProposeListPreB2C" path="/jsp/front/new_templateMaster.jsp?body=/jsp/front/common/propose/proposeListPreB2C.jsp"
 * @struts:action-forward name="ProposeListIng" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/proposeListIng.jsp"
 * @struts:action-forward name="ProposeListIngB2C" path="/jsp/front/new_templateMaster.jsp?body=/jsp/front/common/propose/proposeListIng.jsp"
 * @struts:action-forward name="ProposeListDone" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/proposeListDone.jsp"
 * @struts:action-forward name="ProposeListDoneB2C" path="/jsp/front/new_templateMaster.jsp?body=/jsp/front/common/propose/proposeListDone.jsp"
 * @struts:action-forward name="ProposeListGold" path="/jsp/front/new_templateMaster.jsp?body=/jsp/front/common/propose/proposeListGold.jsp"
 * @struts:action-forward name="ProposeListSel" path="/jsp/front/new_templateMaster.jsp?body=/jsp/front/common/propose/proposeListSel.jsp"
 * @struts:action-forward name="ProposePayStateList" path="/jsp/front/new_templateMaster.jsp?body=/jsp/front/common/propose/proposePayStateList.jsp"
 * @struts:action-forward name="ProposePayInfoPopup" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/proposePayInfoPopup.jsp"
 * @struts:action-forward name="cpSubjectLink" path="/jsp/front/common/propose/popCpSubjStudy.jsp"
 * @struts:action-forward name="DelayList" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/delayList.jsp"
 * @struts:action-forward name="ProposeTotalResult" path="/jsp/front/common/propose/proposeTotalResultPopup.jsp"
 * @struts:action-forward name="ProposeCancelWriteForm" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/proposeCancelWritePopup.jsp"
 * @struts:action-forward name="ProposeCancelList" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/approvalCancelList.jsp"
 * @struts:action-forward name="ProposeCancelListB2C" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/approvalCancelListB2C.jsp"
 * @struts:action-forward name="RefundAccountWrite" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/refundAccountWritePopup.jsp"
 * @struts:action-forward name="CourseApprovalCancelWrite" path="/jsp/front/common/propose/approvalCancelWritePopup.jsp"
 * @struts:action-forward name="ProposeWriteForm" path="/jsp/front/common/propose/proposeWritePopup.jsp"
 * @struts:action-forward name="ProposeWriteForm2" path="/jsp/front/common/propose/proposeWritePopup2.jsp"
 * @struts:action-forward name="ProposeWriteForm3" path="/jsp/front/common/propose/proposeWritePopup3.jsp"
 * @struts:action-forward name="ProposeWriteForm4" path="/jsp/front/common/propose/proposeWritePopup4.jsp"
 * @struts:action-forward name="ProposeWriteForm5" path="/jsp/front/common/propose/proposeWritePopup5.jsp"
 * @struts:action-forward name="ProposeWriteForm6" path="/jsp/front/common/propose/proposeWritePopup6.jsp"
 * @struts:action-forward name="ProposeWriteForm7" path="/jsp/front/common/propose/proposeWritePopup7.jsp"
 * @struts:action-forward name="ProposeWriteForm8" path="/jsp/front/common/propose/proposeWritePopup8.jsp"
 * @struts:action-forward name="ProposeWriteForm9" path="/jsp/front/common/propose/proposeWritePopupToeic.jsp"
 * @struts:action-forward name="ProposeWriteForm10" path="/jsp/front/common/propose/proposeWritePopup10.jsp"
 * @struts:action-forward name="subjseqMadeCheck" path="/jsp/front/common/propose/subjseqMadeCheck.jsp"
 * @struts:action-forward name="ProposeWritePayForm" path="/jsp/front/common/propose/proposeWritePayForm.jsp"
 * @struts:action-forward name="RefundRequestWriteForm" path="/jsp/front/common/propose/refundRequestWriteForm.jsp"
 * @struts:action-forward name="ShowAccountPopup" path="/jsp/front/common/propose/showAccountPopup.jsp"
 * @struts:action-forward name="showStudentPopup" path="/jsp/front/common/propose/showStudentPopup.jsp"
 * @struts:action-forward name="ProposeWritePay" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/proposeWritePopupPay.jsp"
 * @struts:action-forward name="ProposeWriteResult" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/proposeWritePopupResult.jsp"
 * @struts:action-forward name="ChangeDeliveryWriteForm" path="/jsp/front/common/propose/deliveryModifyPopup.jsp"
 * @struts:action-forward name="ChangeBookWriteForm" path="/jsp/front/common/propose/bookModifyPopup.jsp"
 * @struts:action-forward name="CourseApprovalMemberList" path="/jsp/front/templateMaster.jsp?body=/jsp/front/home02/propose/approvalMemberList.jsp"
 * @struts:action-forward name="CourseApprovalSystemList" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/approvalList.jsp"
 * @struts:action-forward name="CourseApprovalSystemShow" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/approvalShow.jsp"
 * @struts:action-forward name="CourseApprovalSystemMemberList" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/approvalMemberList.jsp"
 * @struts:action-forward name="CourseApprovalSubjSeqShow" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/approvalSubjSeqShow.jsp"
 * @struts:action-forward name="CourseApprovalCancelList" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/approvalCancelList.jsp"
 * @struts:action-forward name="CourseEduTargetList" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/eduTargetList.jsp"
 * @struts:action-forward name="CourseProposeMemberList" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/proposeMemberList.jsp"
 * @struts:action-forward name="CourseApprovalCheifList" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/approvalCheifList.jsp"
 * @struts:action-forward name="CourseApprovalCheifRejectWriteForm" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/approvalCheifRejectWrite.jsp"
 * @struts:action-forward name="SubjSearchList" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/subjSearchList.jsp"
 * @struts:action-forward name="SubjSearchShow" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/subjSearchShow.jsp"
 * @struts:action-forward name="SubjSearchMemberList" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/subjSearchMemberList.jsp"
 * @struts:action-forward name="TeamStoldMemberList" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/teamStoldMemberList.jsp"
 * @struts:action-forward name="CertificateReportFPopup" path="/jsp/front/templateMaster.jsp?body=/jsp/front/common/propose/certificateReportFPopup.jsp"
 * @struts:action-forward name="MobileProposeList" path="/jsp/mobile/propose/proposeList.jsp"
 * @struts:action-forward name="MobileContentsList" path="/jsp/mobile/propose/mobileContentsList.jsp"
 * @struts:action-forward name="MobileProposeListPreB2C" path="/jsp/mobile/propose/proposeListPreB2C.jsp"
 * @struts:action-forward name="MobileProposeListIng" path="/jsp/mobile/propose/proposeListIng.jsp"
 * @struts:action-forward name="MobileProposeListDone" path="/jsp/mobile/propose/proposeListDone.jsp"
 */

public class ProposeFaction extends StrutsDispatchAction {

	/**
	 * 수강 목록을 표시한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward proposeList (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {

		String isonoff = "";
		String isb2b = "";
		int retVal = 0;
		String v_comp = box.getString("s_comp");
		box.getMap().put("p_comp", box.getString("s_comp"));
		box.getMap().put("p_userid", box.getString("s_userid"));

		String msg = null;
		CompMgr compMgr = new CompMgr();
		Box compInfo = compMgr.selectCompOne(v_comp);
		isonoff = box.getString("ISONOFF");
		isb2b = compInfo.getString("BTOBYN");
		box.put("p_btobyn", isb2b);

		//학습제한 체크
 		MyClassMgr myClassMgr = new MyClassMgr();
		String studyChk = myClassMgr.selectStudyControl(box);
		box.put("StudyControl",studyChk);

		ProposeMgr proposeMgr = new ProposeMgr();

		String type= box.getString("type");
		if(type.equals("pre")) {
			box.put("proposeList",proposeMgr.getProposeListAllInfo(box));
			if ( isb2b.equals("Y") ) {
				return mapping.findForward("ProposeListPre");
			} else {
				return mapping.findForward("ProposeListPreB2C");
			}
		} else if(type.equals("ing")) {
			box.put("_where", "F");
			FinishMgr finishMgr = new FinishMgr();
			finishMgr.completeFinishSubjectMultiCalc(box);
			ApprovalMgr approvalMgr = new ApprovalMgr();
			box.put("proposeList",proposeMgr.getProposeListIng(box));
			DataSet a = (DataSet)box.getObject("proposeList");
			if ( isb2b.equals("Y") ) {
				return mapping.findForward("ProposeListIng");
			} else {
				return mapping.findForward("ProposeListIngB2C");
			}
		} else if(type.equals("done")) {
			box.put("proposeList",proposeMgr.getProposeListDone(box));
			if ( isb2b.equals("Y") ) {
				box.put("p_certificates", compInfo.getStringDefault("CERTIFICATES", "N"));
				return mapping.findForward("ProposeListDone");
			} else {
				return mapping.findForward("ProposeListDoneB2C");
			}
		} else if(type.equals("gold")) {
			box.put("goldpathYN", "Y");
			box.put("proposeList",proposeMgr.getProposeListIng(box));
			return mapping.findForward("ProposeListGold");
		} else if(type.equals("sel")) {
			box.put("proposeList",proposeMgr.getProposeListSel(box));
			return mapping.findForward("ProposeListSel");
		}
		else {
			return mapping.findForward("ProposeList");
		}

	}

	/**
	 * 결제현황 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward proposePayStateList (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {

		ProposeMgr proposeMgr = new ProposeMgr();

		DataSet dsProposePayState = proposeMgr.getProposePayState(box);
		box.put("dsProposePayState", dsProposePayState);

		return mapping.findForward("ProposePayStateList");

	}

	/**
	 * 결제환황에서 무통장입금 정보를 보여준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward proposePayInfoPopup (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {

		ProposeMgr proposeMgr = new ProposeMgr();

		return mapping.findForward("ProposePayInfoPopup");

	}


	 /**
     * 외부과정 학습페이지를 띄운다. - 온라인
     * @param mapping
     * @param form
     * @param request
     * @param response
     * @param box
     * @return
     * @throws Exception
     */
	public ActionForward cpSubjectLink(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
		DataSet data = null ;
		Box subjectContentsVO = null;
		String next = "";
		String subj = box.getString("p_subj") ;
		next = box.getString("next");
		if(StringUtil.isNull(next)) {
			next = box.getString("cmd");
		}
		SubjectMgr subjectMgr = new SubjectMgr();
		CPSubjectMgr cpSubjectMgr = new CPSubjectMgr();

		subjectContentsVO = subjectMgr.getSubjectContents(subj);
		box.put("subjectContentsVO", subjectContentsVO);


		data = cpSubjectMgr.getCpSubjParam(subj);
		box.put("cpSubjParamVOs", data);
		box.put("p_resno", cpSubjectMgr.getResNO(box.getString("s_userid")));

		return mapping.findForward(next);
	}

	/**
	 * 수강 연기 내역을  표시한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward delayList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{

		String isonoff = "";
		String isb2b = "";
		int retVal = 0;
		String v_comp = box.getString("s_comp");
		box.getMap().put("p_comp", box.getString("s_comp"));
		box.getMap().put("p_userid", box.getString("s_userid"));

		String msg = null;
		CompMgr compMgr = new CompMgr();
		Box compInfo = compMgr.selectCompOne(v_comp);
		isonoff = box.getString("ISONOFF");
		isb2b = compInfo.getString("BTOBYN");

		ProposeMgr proposeMgr = new ProposeMgr();
		MemberMgr memberMgr = new MemberMgr();
		box.put("userInfo", memberMgr.selectMemberDetail(box).getFirstObject());
		box.put("delayList",proposeMgr.getProposeDelayList(box));
		return mapping.findForward("DelayList");

	}

	/**
	 * 수강 목록을 표시한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward proposeTotalResult (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {

		String isonoff = "";
		String isb2b = "";
		int retVal = 0;
		String v_comp = box.getString("s_comp");
		box.getMap().put("p_comp", box.getString("s_comp"));
		box.getMap().put("p_userid", box.getString("s_userid"));

		String msg = null;
		CompMgr compMgr = new CompMgr();
		Box compInfo = compMgr.selectCompOne(v_comp);
		isonoff = box.getString("ISONOFF");
		isb2b = compInfo.getString("BTOBYN");

		ProposeMgr proposeMgr = new ProposeMgr();
		MemberMgr memberMgr = new MemberMgr();
		box.put("userInfo", memberMgr.selectMemberDetailOne(box.getString("s_userid")));
		box.put("resultList",proposeMgr.getTotalResultList(box));
//		box.put("externalList",proposeMgr.getExternalResultList(box));

		return mapping.findForward("ProposeTotalResult");
	}

	/**
	 * 결제방식의 가상계좌 정보 팝업
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward showAccountPopup (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {

		// 수강신청 정보를 가져온다.
		ProposeMgr proposeMgr = new ProposeMgr();
		Box boxVBankInfo = proposeMgr.selectVBankInfo(box);
		box.put("boxVBankInfo", boxVBankInfo);

		return mapping.findForward("ShowAccountPopup");
	}
	
	/**
	 * 수강생 정보 팝업
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward showStudentPopup (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {
		
		System.out.println("p_userid : "+box.getString("p_represent"));
		System.out.println("p_subj : "+box.getString("p_represent_subj"));
		System.out.println("p_subjseq : "+box.getString("p_represent_subjseq"));
		System.out.println("p_recogstate : "+box.getString("p_represent_recogstate"));
		
		box.put("p_userid", box.getString("p_represent"));
		box.put("p_subj", box.getString("p_represent_subj"));
		box.put("p_subjseq", box.getString("p_represent_subjseq"));
		box.put("p_recogstate", box.getString("p_represent_recogstate"));
		
		// 수강생 정보를 가져온다.
		ProposeMgr proposeMgr = new ProposeMgr();
		DataSet selectProposeStudent = proposeMgr.selectProposeStudent(box.getMap());
		box.put("selectProposeStudent", selectProposeStudent);

		return mapping.findForward("showStudentPopup");
	}

	/**
	 * 수강신청폼을 표시한다..
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward proposeWriteForm (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {

		if ( box.getString("s_userid").equals("") ) {
			return alertPopupClose(request, "로그인을 먼저 해 주십시요", "");
		}


		// opener 가 팝업이면 opener 를 reload 하지 않기 위해 opener 가 팝업인지 확인한다.
		String v_ppopup = box.getString("p_ppopup");
		box.put("p_ppopup",  v_ppopup  );

		String _where = box.getString("_where");
		if ( _where.equals("B") ) {	// 관리자에서 수강신청 할 때에는 아이디와 회사정보가 넘어온다.
//			box.put("p_gyear", box.getString("p_year"));
		} else {
			box.put("p_comp", box.getString("s_comp"));
			box.put("p_gyear", box.getString("p_year"));
			box.put("p_userid", box.getString("s_userid"));
		}

		// 수강신청 정보를 가져온다.
		ProposeMgr proposeMgr = new ProposeMgr();
		Box boxProposeApplyInfo = proposeMgr.selectProposeApplyInfo(box.getMap());

		String v_trainingclass = boxProposeApplyInfo.getString("TRAININGCLASS");
		String v_btobyn = boxProposeApplyInfo.getString("BTOBYN");
		String v_proposeyn = boxProposeApplyInfo.getString("PROPOSEYN");
		String v_isoptsubjectselect = box.getStringDefault("p_isoptsubjectselect", boxProposeApplyInfo.getString("ISOPTSUBJECTSELECT"));
		String v_isinstallment = boxProposeApplyInfo.getString("ISINSTALLMENT");
		String v_paystate = boxProposeApplyInfo.getString("PAYSTATE");
		String v_paydayyn = boxProposeApplyInfo.getString("PAYDAYYN");
		String v_payable = boxProposeApplyInfo.getString("PAYABLE");
		String v_refundagreeyn = boxProposeApplyInfo.getString("REFUNDAGREEYN");
		String v_paystart = boxProposeApplyInfo.getString("PAYSTART");
		String v_payend = boxProposeApplyInfo.getString("PAYEND");
		String v_price = boxProposeApplyInfo.getString("PRICE");
		String v_moid = boxProposeApplyInfo.getString("MOID");
		String v_trainingarea = boxProposeApplyInfo.getString("TRAININGAREA");   // 추가_2013.12.02
		String v_isonoff = boxProposeApplyInfo.getString("ISONOFF");
		String v_deptnam = boxProposeApplyInfo.getString("DEPTNAM");
		String v_jikcheknm = boxProposeApplyInfo.getString("JIKCHEKNM");
		int v_paystateycnt = boxProposeApplyInfo.getInt("PAYSTATEYCNT");
		
		String v_installment_seq = box.getString("p_installment_seq");
		

		// 적립된 마일리지 가져오기
		if (v_btobyn.equals("Y")) {
			box.put("p_mileage", 10);
		} else {
			MileageMgr mileageMgr = new MileageMgr();
			int v_mileage = mileageMgr.selectUserRestantPoint(box);
			box.put("p_mileage", v_mileage);
		}
		
		//MileageMgr mileageMgr = new MileageMgr();
		//int v_mileage = mileageMgr.selectUserRestantPoint(box);

		box.put("boxProposeApplyInfo", boxProposeApplyInfo);
		box.put("p_trainingclass", v_trainingclass);
		box.put("p_btobyn", v_btobyn);
		box.put("p_proposeyn", v_proposeyn);
		box.put("p_isoptsubjectselect", v_isoptsubjectselect);
		box.put("p_isinstallment", v_isinstallment);
		box.put("p_paystate", v_paystate);
		box.put("p_paydayyn", v_paydayyn);
		box.put("p_payable", v_payable);
		box.put("p_paystart", v_paystart);
		box.put("p_payend", v_payend);
		box.put("p_price", v_price);
		box.put("p_moid", v_moid);
		box.put("p_trainingarea", v_trainingarea);   // 추가_2013.12.02
		box.put("p_deptnam", v_deptnam);
		box.put("p_jikcheknm", v_jikcheknm);

		//box.put("p_mileage", v_mileage);

		// 할인내용리스트
		SubjectMgr subjectMgr = new SubjectMgr();
		DataSet dsDiscountSubj = subjectMgr.getDiscountSubj(box.getString("p_subj"));
		box.put("dsDiscountSubj", dsDiscountSubj);

		/**
		 * ProposeWriteForm  - B2B 수강신청 폼
		 * ProposeWriteForm2 - B2C 수강신청 폼
		 * ProposeWriteForm3 - 무역마스터 수강신청폼
		 * ProposeWriteForm4 - 선택과목 결정 팝업
		 * ProposeWriteForm5 - GLMP 수강신청폼
		 * ProposeWriteForm6 - 골드패스 수강신청폼
		 * ProposeWriteForm7 - 부분수강 수강신청폼
		 * ProposeWriteForm8 - 수강취소,환불규정 동의서폼
		 * ProposeWriteForm9 - 토익특별시험??
		 * ProposeWriteForm10 - 자격시험 수강신청 폼
		 */

		// 무역마스터, IT마스터, 글로벌 인턴쉽 / 지부장기과정 인 경우
		if ( v_trainingclass.equals("03") || v_trainingclass.equals("04") || v_trainingclass.equals("08") || v_trainingclass.equals("12") || v_trainingclass.equals("16") || v_trainingclass.equals("13") || (v_trainingclass.equals("15")&&v_isonoff.equals("LONG")) ) {
			if ( v_trainingclass.equals("03") ) {
				// 선택과목을 선택하지 않았다면 선택과목 결정 팝업을 띄운다.
				if ( v_isoptsubjectselect.equals("N") ) {
					box.put("p_essenyn", "N");
//					box.put("p_essenyn", "Y");
					DataSet dsOptionSubject = proposeMgr.getSubjSeqBook(box);
					box.put("dsOptionSubject", dsOptionSubject);
					return mapping.findForward("ProposeWriteForm4");
				}
			}
			// 수강신청을 했으면
			if ( v_proposeyn.equals("Y") ) {
				if ( v_payable.equals("N") ) {	// 결제가능 하지 않다면
					return alertPopupClose(request, "결제기간이 아닙니다..", "");
				}
				// 결제내역이 없거나, 결제상태가 취소(C), 환불완료(E), 결제실패(F) 이면 수강신청 팝업을 띄운다.
				// paystateycnt 는 취소, 환불, 결제 실패 이외의 상태값의 갯수이다. 이 갯수가 0보다 크면 결제나환불이 진행중이거나 완료된 상태가 있다는 의미이다(강제입과때문에 추가했음)
				if ( v_paystate.equals("")||v_paystate.equals("C")||v_paystate.equals("E")||v_paystate.equals("F")||(_where.equals("B")&&v_paystateycnt>0) ) {
					proposeMgr.doINISecureStart(request, box);
					return mapping.findForward("ProposeWriteForm3");
				}
				// 결제내역이 있는데 결제 상태가 결제 진행중, 입금대기, 환불처리중, 환불요청 일 경우는 종료한다.
				else {
					return alertPopupClose(request, "결제를 할수 없는 상태 입니다.", "");
				}
			} else {
				//무역마스터, IT마스터, 글로벌 인턴쉽 / 지부 장기과정 인 경우
				if ( v_trainingclass.equals("03") || v_trainingclass.equals("04") || v_trainingclass.equals("12") ||  v_trainingclass.equals("16") || v_trainingclass.equals("13") || (v_trainingclass.equals("15")&&v_isonoff.equals("LONG"))  ) {
					if ( v_isinstallment.equals("Y") && v_installment_seq.equals("") ) {
						Box boxPayInsSeq = proposeMgr.selectPayInstallmentSeqMin(box);
						if ( boxPayInsSeq.getString("SEQ").equals("") ) {
							return alertPopupClose(request, "결제기간이 아닙니다.", "");
						} else {
							box.put("p_installment_seq", boxPayInsSeq.getString("SEQ"));
						}
					}
				}
			}
		}
		/*else if ( v_trainingclass.equals("06") || v_trainingclass.equals("11") ) {
		  }
		  */
		// GLMP 인 경우 - 수강신청 되면 무통장으로 결제(수강신청과 결제가 동시에 이루어진다)
		else if ( v_trainingclass.equals("06")) {
			//수강신청이 되어있으면 신청정보 수정가능하도록
			if ( v_proposeyn.equals("Y") ) {
				box.put("glmpEditMode", "Y");				
				
				Box boxProposeFormGLMP = proposeMgr.selectProposeFormGLMP(box);
				box.put("boxProposeFormGLMP", boxProposeFormGLMP);
				return mapping.findForward("ProposeWriteForm5");			
			}
			
//			// 수강신청을 했으면
//			if ( v_proposeyn.equals("Y") ) {
//				if ( v_paydayyn.equals("N") ) {
//					return alertPopupClose(request, "결제기간이 아닙니다..", "");
//				}
//				// 결제내역이 없거나, 결제상태가 취소(C), 환불완료(E), 결제실패(F) 이면 수강신청 팝업을 띄운다.
//				if ( v_paystate.equals("")||v_paystate.equals("C")||v_paystate.equals("E")||v_paystate.equals("F") ) {
//					proposeMgr.doINISecureStart(request, box);
//					return mapping.findForward("ProposeWriteForm5");
//				}
//				// 결제내역이 있는데 결제 상태가 결제 진행중, 입금대기, 환불처리중, 환불요청 일 경우는 종료한다.
//				else {
//					return alertPopupClose(request, "결제를 할수 없는 상태 입니다.", "");
//				}
//			}
		}
		// B2C 인 경우
		else if ( v_btobyn.equals("N") ) {
			// 수강신청을 했으면
			if ( v_proposeyn.equals("Y") ) {
				// 단기연수 / ICT / iTab 과정 중 하나 이고 수강신청을 했고 환불 규정에 동의를 하지 않았을 경우 수강취소 및 환불관련 규정 팝업을 띄운다. - 자격시험(05)과정추가(20140403)
				if ( (v_trainingclass.equals("01") || v_trainingclass.equals("05") || v_trainingclass.equals("14") ||v_trainingclass.equals("10"))&& (v_refundagreeyn.equals("")||v_refundagreeyn.equals("N")) ) {
					return mapping.findForward("ProposeWriteForm8");
				}
				if ( v_payable.equals("N") ) {
					return alertPopupClose(request, "결제기간이 아닙니다..", "");
				}
				// 결제내역이 없거나, 결제상태가 취소(C), 환불완료(E), 결제실패(F) 이면 결제 가능
				// paystateycnt 는 취소, 환불, 결제 실패 이외의 상태값의 갯수이다. 이 갯수가 0보다 크면 결제나환불이 진행중이거나 완료된 상태가 있다는 의미이다(강제입과때문에 추가했음)
				if ( v_paystate.equals("")||v_paystate.equals("C")||v_paystate.equals("E")||v_paystate.equals("F")||(_where.equals("B")&&v_paystateycnt>0) ) {

					proposeMgr.doINISecureStart(request, box);

					return mapping.findForward("ProposeWritePayForm");
				}
				// 결제내역이 있는데 결제 상태가 결제 진행중, 입금대기, 환불처리중, 환불요청 일 경우는 종료한다.
				else {
					return alertPopupClose(request, "결제를 할수 없는 상태 입니다.", "");
				}
			}
		}
		// 그외 과정은 결제 진행중인 경우만 체크해서 상태체크를 하지 않고 수강신청 팝업을 띄운다.
		else {
			if ( v_paystate.equals("I") ) {
				// B2B 수강신청 팝업을 띄운다.
				if ( v_btobyn.equals("Y") ) {
					return mapping.findForward("ProposeWriteForm");
				}
				// B2C 수강신청 팝업을 띄운다.
				else {
					return mapping.findForward("ProposeWriteForm2");
				}
			}
		}

		String status = "";
		String isonoff = "";

		StudentManagerMgr studentMgr = new StudentManagerMgr();

		Map checkInfo = studentMgr.getStudentBeforeCheckOne(box.getMap());

		if ( checkInfo != null ) {
			status = StringUtil.nvl(checkInfo.get("STATUS"));
			isonoff = StringUtil.nvl(checkInfo.get("ISONOFF"));
		}

		/**
		 * A : 이수과정
		 * B : 수강신청한 과정
		 * C : 차수 정원초과
		 * D : 해당아이디없음
		 * E : 블랙리스트
		 * F : 신청제한개수 초과 (월별)
		 * G : 집합과정 기간중복
		 * H : 퇴사
		 * I : 해당과정 없음
		 * L : 필기시험 이력이 없음
		 */
		if(status.indexOf("L") >=0) {
			return alertPopupClose(request, "필기시험 이력이 없습니다.", "");
		} else if(status.indexOf("I") >=0) {
			return alertPopupClose(request, "해당과정이 없습니다.", "");
		} else if(status.indexOf("H") >=0) {
			return alertPopupClose(request, "퇴사하였습니다.", "");
		} else if(status.indexOf("E") >=0) {
		 	return alertPopupClose(request, "수강제한 대상자입니다.", "");
		} else if(status.indexOf("G") >=0) {
			return alertPopupClose(request, "집합과정 기간이 중복되었습니다.", "");
		} else if(status.indexOf("D") >=0) {
			return alertPopupClose(request, "해당아이디가 없습니다.", "");
		} else if(status.indexOf("F") >=0) {
			return alertPopupClose(request, "신청제한개수를 초과하였습니다.", "");
		} else if(status.indexOf("C") >=0) {
			return alertPopupClose(request, "차수 정원이 초과되었습니다.", "");
		} else if(status.indexOf("B") >=0) {
			return alertPopupClose(request, "수강신청한 과정입니다.", "");
		} else if(status.indexOf("A") >=0) {
			return alertPopupClose(request, "이수한 과정입니다.", "");
		}

		box.put("STATUS", status);
		box.put("ISONOFF", isonoff);

		// 과정에 속한 과목 리스트(교재정보포함)를 가져온다.
		DataSet dsSubjectListBook = proposeMgr.getSubjSeqBook(box);
		box.put("dsSubjectListBook", dsSubjectListBook);

		if ( v_trainingclass.equals("03") || v_trainingclass.equals("04") || v_trainingclass.equals("08") || v_trainingclass.equals("12") || v_trainingclass.equals("16") || v_trainingclass.equals("13")  || (v_trainingclass.equals("15")&&v_isonoff.equals("LONG"))  ) {
			proposeMgr.doINISecureStart(request, box);
			return mapping.findForward("ProposeWriteForm3");

		} else if ( v_trainingclass.equals("06") ) {	//GLMP
			Box boxProposeFormGLMP = proposeMgr.selectProposeFormGLMP(box);
			box.put("boxProposeFormGLMP", boxProposeFormGLMP);
//			proposeMgr.doINISecureStart(request, box);
			return mapping.findForward("ProposeWriteForm5");
		}
		// 골드패스일 경우
		else if ( v_trainingclass.equals("11") ) {
			proposeMgr.doINISecureStart(request, box);
			return mapping.findForward("ProposeWriteForm6");
		}
		//자격시험일경우
		else if ( v_trainingclass.equals("05") ) {
			return mapping.findForward("ProposeWriteForm10");
		}
		// B2B 인경우
		else if ( v_btobyn.equals("Y") ) {
			return mapping.findForward("ProposeWriteForm");

		} else {
			if (box.getString("p_subj").equals("2324")) {
				return mapping.findForward("ProposeWriteForm9");
			}
			return mapping.findForward("ProposeWriteForm2");

		}
		/*
		if ( v_btobyn.equals("Y") ) {
			return mapping.findForward("ProposeWriteForm");
		} else {
			if ( v_trainingclass.equals("03") || v_trainingclass.equals("04") || v_trainingclass.equals("08") ) {
				proposeMgr.doINISecureStart(request, box);
				return mapping.findForward("ProposeWriteForm3");
			} else {
				return mapping.findForward("ProposeWriteForm2");
			}
		}
		*/
	}
	
	/**
	 * 결제현황에서 결제방법 변경시 처리
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward paymentChange(
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box ) 
	throws Exception {
		int retVal = 0;		// T_LMS_PROPOSEPAYINSTALL, T_PAY_INIPAY, T_LMS_PAYMENT를 지웠는지 확인
		int retVal1 = 0;	// T_LMS_SEND를 지웠는지 확인
		
		box.getMap().put("p_userid", box.getString("s_userid"));
		
		// 수강신청 정보를 가져온다.
		ProposeMgr proposeMgr = new ProposeMgr();

		//String v_payable = boxProposeApplyInfo.getString("PAYABLE");
		String v_installment_seq = box.getString("p_installment_seq");
		
		/**
		 * 수강신청폼을 표시하는데 결제 내용 수정시 창을 띄울때의 처리를 해준다 (2013.9.25 정수영)
		 */
		box.put("p_installment_seq", v_installment_seq);
		box.put("v_subj", box.getString("p_subj"));			// box에 proposePayStateList로 부터 넘겨받은 p_subj의 값을 v_subj에 저장
		box.put("v_year", box.getString("p_year"));			// box에 proposePayStateList로 부터 넘겨받은 p_year의 값을 v_year에 저장
		box.put("v_subjseq", box.getString("p_subjseq"));	// box에 proposePayStateList로 부터 넘겨받은 p_subjseq의 값을 v_subjseq에 저장
		box.put("p_userid", box.getString("s_userid"));		// box에 사용자의 id 값을 저장 한다
		box.put("v_tid", box.getString("p_tid"));
			
		// 가상계좌 받은 후 결제수단변경 -> 변경없이 이전에 가상계좌로 입금시 확인 불가한 오류때문에 삭제에서 수정으로 변경(취소 이력 남기기용)
		// DB내용들을 삭제한다 (T_LMS_PROPOSEPAYINSTALL, T_PAY_INIPAY, T_LMS_PAYMENT)
		//retVal = proposeMgr.deletePaymentData(box);
		//DB내용 을 수정 및 삭제(T_LMS_PROPOSEPAYINSTALL= 삭제, T_LMS_PAYMENT = RECOGSTATE컬럼 C로 수정)
		retVal = proposeMgr.deleteNupdatePaymentData(box);
		if(retVal == 1){
			System.out.println("DB가 정상적으로 삭제 되었습니다.");
		} else {
			System.out.println("DB삭제가 정상적으로 작동되지 않았습니다.");
		}
			
		// 최초결제일 경우 T_LMS_SEND를 삭제한다
		if(Integer.parseInt(v_installment_seq) < 2){	// 분납과정이 한번이면
			retVal1 = proposeMgr.deleteLmsSend(box);
		}
		
		// 창을 닫고 부모창을 새로고침 한뒤 새로운 팝업창을 띄워준다.
		return proposeWriteForm(mapping, form, request, response, box);
	}

	/**
	 * 이니시스 결제 금액  재 설정 및 New 인스턴스 만들기
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public String inipaySetPriceCallBack(HashMap map, HttpServletRequest request) throws Exception{
		ProposeMgr proposeMgr = new ProposeMgr();
		Box box = new Box(map);
		// 선택적 부분수강의 trainingclass 는 이러닝과 같다.
		if(box.getString("p_proposetype").equals("7")){
			box.put("p_trainingclass", "09");	// 이러닝과 같은 상점아이디 사용
		}
		proposeMgr.doINISecureReStart(request, box);
		String data = box.getString("ini_encfield")+"|:"+ box.getString("ini_certid");

		return data ;
	}


	/**
	 * 수강신청 처리한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward proposeWrite (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {
		if ( box.getString("s_userid").equals("") ) {
			return alertPopupClose(request, "권한이 없습니다.", "");
		}
		
		// opener 가 팝업이면 opener 를 reload 하지 않기 위해 opener 가 팝업인지 확인한다.
		String v_ppopup = box.getString("p_ppopup");
		box.put("p_ppopup",  v_ppopup  );

		String _where = box.getString("_where");
		if ( _where.equals("B") ) {	// 관리자에서 수강신청 할 때에는 아이디와 회사정보가 넘어온다.
//			box.put("p_gyear", box.getString("p_year"));
		} else {
			box.put("p_comp", box.getString("s_comp"));
			box.put("p_gyear", box.getString("p_year"));
			box.put("p_userid", box.getString("s_userid"));
		}

		String v_proposetype = box.getStringDefault("p_proposetype", "1");
		String v_installment_seq = box.getString("p_installment_seq");

		if ( v_proposetype.equals("2") || v_proposetype.equals("5") ) {
			String uploadPath	= "/propose/"+box.getString("subj")+"/"+box.getString("year")+"/"+box.getString("subjseq");
//			int v_maxfilesize	= box.getInt("p_maxfilesize");
			int v_maxfilesize	= 10;

			UploadFiles files 	= FileUtil.upload(request, uploadPath, v_maxfilesize, false, "A", DateTimeUtil.getDateTime());
			RequestManager.getMultiBox(box, files.getMultipart());
			box.put("p_proposetype", v_proposetype);
			_where = box.getString("_where");
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
//						box.put("p_picturefile", file.getRootName());
					}
					
					//외환관리사실무과정의 경우 아래 첨부파일이 첨부될수 있음
					else if ( file.getObjName().equals("p_collegianrealname") ) {
						box.put("p_collegiansavename", file.getUploadName());	//실제 저장된 파일명만 저장
					}					
					else if ( file.getObjName().equals("p_fxmlicenserealname") ) {
						box.put("p_fxmlicensesavename", file.getUploadName()); 	//실제 저장된 파일명만 저장
					}
					else if ( file.getObjName().equals("p_bankerrealname") ) {
						box.put("p_bankersavename", file.getUploadName()); 	//실제 저장된 파일명만 저장
					}
					
				}
			}
			// "파일 확장자가 JSP,ASP,PHP,HTM,HTML인 파일은 업로드 할 수 없습니다"
			else if ( files.getStatus().equals("V") ) {
				return alertPopupClose(request, FileUtil.UPLOAD_VALIDATE_MSG, "");
			}
		}

		/**
		 * A : 이수과정
		 * B : 수강신청한 과정
		 * C : 차수 정원초과
		 * D : 해당아이디없음
		 * E : 블랙리스트
		 * F : 신청제한개수 초과 (월별)
		 * G : 집합과정 기간중복
		 * H : 퇴사
		 * I : 해당과정 없음
		 */
		// 결제, 환불동의서 폼이 아니거나 1회차 이상의 분납과정 결제일 경우에는 체크하지 않는다.
		if ( v_installment_seq.equals("") && !(v_proposetype.equals("4") || v_proposetype.equals("8")) ) {
			
			StudentManagerMgr studentMgr = new StudentManagerMgr();

			Map checkInfo = studentMgr.getStudentBeforeCheckOne(box.getMap());
			String status = "";
			if ( checkInfo != null ) {
				status = StringUtil.nvl(checkInfo.get("STATUS"));
			}
			if(status.indexOf("I") >=0) {
				return alertPopupClose(request, "해당과정이 없습니다.", "");
			} else if(status.indexOf("H") >=0) {
				return alertPopupClose(request, "퇴사하였습니다.", "");
			} else if(status.indexOf("E") >=0) {
			 	return alertPopupClose(request, "수강제한 대상자입니다.", "");
			} else if(status.indexOf("G") >=0) {
				return alertPopupClose(request, "집합과정 기간이 중복되었습니다.", "");
			} else if(status.indexOf("D") >=0) {
				return alertPopupClose(request, "해당아이디가 없습니다.", "");
			} else if(status.indexOf("F") >=0) {
				return alertPopupClose(request, "신청제한개수를 초과하였습니다.", "");
			} else if(status.indexOf("C") >=0) {
				return alertPopupClose(request, "차수 정원이 초과되었습니다.", "");
			} else if(status.indexOf("B") >=0) {
				return alertPopupClose(request, "수강신청한 과정입니다.", "");
			} else if(status.indexOf("A") >=0) {
				return alertPopupClose(request, "이수한 과정입니다.", "");
			}
		}
		
//		box.put("p_comp", box.getString("s_comp"));
//		box.put("p_userid", box.getString("s_userid"));
//		box.put("p_gyear", box.getString("p_year"));

		int retVal = 0;
		String v_subj = box.getString("p_subj");
		String v_year = box.getString("p_year");
		String v_subjseq = box.getString("p_subjseq");
		String msg = null;

		ProposeMgr proposeMgr = new ProposeMgr();
		MemberMgr memberMgr = new MemberMgr();

		// B2B 수강신청
		if ( v_proposetype.equals("1") ) {
			retVal = proposeMgr.proposeWriteB2B(box);
		}
		// B2C 수강신청
		else if ( v_proposetype.equals("2") ) {
			// 수강신청 시 전화번호, 휴대폰번호, 주소 정보를 업데이트 한다.
			memberMgr.updateProposeMember(box);
			retVal = proposeMgr.proposeWriteB2C(box);
			if(retVal > 0 ) {
				if ( _where.equals("B") ) {
					return forward("/front/Propose.do?cmd=proposeWriteForm&p_subj="+v_subj+"&p_year="+v_year+"&p_subjseq="+v_subjseq+"&p_userid="+box.getString("p_userid")+"&_where=B");
				} else {
					return forward("/front/Propose.do?cmd=proposeWriteForm&p_subj="+v_subj+"&p_year="+v_year+"&p_subjseq="+v_subjseq+"&p_ppopup="+v_ppopup);
				}
			} else {
//				return closePopupReload(request, "수강신청 오류입니다.", "", "", "/front/SubjSeqF.do?cmd=compSubjSeqMain");
				return alertPopupClose(request, "수강신청 오류입니다.", "");
			}
		}
		// 무역마스터 수강신청 및 결제(장기과정)
		else if ( v_proposetype.equals("3") ) {
			retVal = proposeMgr.proposeWriteTraid(request, box);
		}
		// B2C 결제
		else if ( v_proposetype.equals("4") ) {
			retVal = proposeMgr.proposeWriteB2CPay(request, box);
		}
		// GLMP 수강신청 및 결제
		else if ( v_proposetype.equals("5") ) {
			retVal = proposeMgr.proposeWriteGLMP(request, box);
		}
		// 골드패스 수강신청 및 결제
		else if ( v_proposetype.equals("6") ) {
			retVal = proposeMgr.proposeWriteGOLD(request, box);
		}
		// 단기연수 수강취소 및 환불관련 규정 동의 업데이트
		else if ( v_proposetype.equals("8") ) {
			retVal = proposeMgr.proposeWriteRefundAgreeUpdate(box);
//			return mapping.findForward("ProposeWriteForm");
			if ( _where.equals("B") ) {
//				return forward("/front/Propose.do?cmd=proposeWriteForm&p_subj="+v_subj+"&p_year="+v_year+"&p_subjseq="+v_subjseq+"&p_userid="+box.getString("p_userid")+"&_where=B");
				return forward("/front/Propose.do?cmd=proposeWriteForm");
			} else {
//				return forward("/front/Propose.do?cmd=proposeWriteForm&p_subj="+v_subj+"&p_year="+v_year+"&p_subjseq="+v_subjseq+"&p_ppopup="+v_ppopup);
				return forward("/front/Propose.do?cmd=proposeWriteForm");
			}
		} 

		if ( retVal > 0 ) {
			Box boxProposeApplyInfo = (Box)box.getObject("boxProposeApplyInfo");
			String v_trainingclass = boxProposeApplyInfo.getString("TRAININGCLASS");

			if ("100000000000".equals(box.getString("p_paymethod"))) {

				MileageMgr mileageMgr = new MileageMgr();
				HashMap hmParam = new HashMap();
				hmParam.put("p_subj", v_subj);
				hmParam.put("p_year", v_year);
				hmParam.put("p_subjseq", v_subjseq);
				int temp = mileageMgr.selectSubjSeqPoint(hmParam);
	    		if(temp  > 0){
	    			hmParam.put("p_userid", box.getString("p_userid"));
	    			hmParam.put("p_content","수강신청을 하는 경우");
	    			hmParam.put("p_useyn", "N");
	    			hmParam.put("p_point", temp);
	    			hmParam.put("p_gubun","0004");
	    			Box tempBox = new Box(hmParam);
					mileageMgr.insertSaveMileage(tempBox);
	    		}
			}
			// 수강신청 SMS 알림
			Box boxSmsNotiInfo = proposeMgr.selectProposeSmsNotiInfo(box);
			String v_smsnotiyn = boxSmsNotiInfo.getString("SMSNOTIYN");
			String v_smsnotinumber = boxSmsNotiInfo.getString("SMSNOTINUMBER");
			v_smsnotinumber = v_smsnotinumber.replace(" ", "");
			String v_chkfinal = boxSmsNotiInfo.getString("CHKFINAL");
			if ( !v_chkfinal.equals("Y") && v_smsnotiyn.equals("Y") && !v_smsnotinumber.equals("") ) {
				//subj문자열이 짧을경우 StringUtil.cutStringByBytes 에서 오류 발생해서 수정
				if(!v_proposetype.equals("3")){	//장기과정이 아닐경우에만 카드결제,  가상계좌선택 후 문자 발송	
					String v_message ="";
					if(StringUtil.realLength(boxProposeApplyInfo.getString("SUBJNM"))>30){
						v_message = box.getString("s_name")+"님이 "+StringUtil.cutStringByBytes(boxProposeApplyInfo.getString("SUBJNM"),30)+" 과정을 수강신청 하였습니다.";
					}else{
						v_message = box.getString("s_name")+"님이 "+boxProposeApplyInfo.getString("SUBJNM")+" 과정을 수강신청 하였습니다.";
					}
					String v_sender = "";
					MessageMgr messageMgr = new MessageMgr();
					messageMgr.doSendSms(v_message, "1566-5114", v_smsnotinumber);
				}
			}

			if ( _where.equals("B") ) {
				return alertPopupClose(request, "수강신청 되었습니다.", "");
			} else {
				if ( v_trainingclass.equals("01") ) {
					return closePopupReload(request, "수강신청되었습니다. 결제관련 정보는 MY CAMPUS에서 확인하실 수 있습니다", "", "", "/front/Propose.do?cmd=proposePayStateList");//"/front/Common.do?cmd=goHtmlPage&p_path=home&p_page=page_229"
					//return alertAndAction(request, "수강신청되었습니다. 결제관련 정보는 MY CAMPUS에서 확인하실 수 있습니다", "/front/Propose.do?cmd=proposePayStateList");
					// return alertAndReload(request, "수강신청되었습니다. 결제관련 정보는 MY CAMPUS에서 확인하실 수 있습니다", "/front/Propose.do?cmd=proposePayStateList");
					
				} else {
					if ( v_proposetype.equals("1") ) {
						return closePopupReload(request, "수강신청되었습니다.", "", "", "/front/Propose.do?cmd=proposeCancelList&p_outmenuid=66");
					}
					if(v_ppopup.equals("Y")){
						return alertPopupClose(request, "수강신청되었습니다. 결제관련 정보는 MY CAMPUS에서 확인하실 수 있습니다", "");
					}else {
						return closePopupReload(request, "수강신청되었습니다. 결제관련 정보는 MY CAMPUS에서 확인하실 수 있습니다", "", "", "/front/Propose.do?cmd=proposePayStateList&p_subj="+v_subj+"&p_year="+v_year+"&p_subjseq="+v_subjseq+"&p_outmenuid=66");
					}
				}
			}
		} else {
			/**
			 * 에러 종류
			 * -1 : 결제할 금액과 실제 결재금액이 다름
			 * -2 : 결재처리중 에러발생
			 * -3 : DB연동 실패로 결재 강제취소
			 * -4 : B2C 과정이 아님
			 * -5 : 무역마스터, IT마스터, 글로벌인턴쉽 과정이 아님
			 * -6 : 이미 수강신청 되어 있음
			 * -7 : 분납결재 과정인데 분납결제 내용이 없음
			 * -8 : 일반 B2C 과정이 아님
			 * -10 : 교육비 정보가 다름
			 * -11 : 교재비 정보가 다름
			 * -12 : 전체 교육비 정보가 다름
			 * -13 : GLMP 과정이 아님
			 * -14 : 골드패스 과정이 아님
			 * -15 : 결제기간이 아님
			 * -16 : 결제를 할수 없는 상태임(이미 결제가 되어있거나 환불진행중)
			 */
			msg = "수강신청 오류입니다. 관리자에게 연락해 주십시요";

			if ( _where.equals("B") ) {
				if ( retVal == -1 ) {
					msg = "결제할 금액과 실제 결재금액이 다름";
				} else if ( retVal == -2 ) {
					msg = "결재처리중 에러발생";
				} else if ( retVal == -3 ) {
					msg = "DB연동 실패로 결재 강제취소";
				} else if ( retVal == -4 ) {
					msg = "B2C 회사사람들만 수강신청 가능함";
				} else if ( retVal == -5 ) {
					msg = "무역마스터, IT마스터, 글로벌인턴쉽 과정이 아님";
				} else if ( retVal == -6 ) {
					msg = "이미 수강신청 되어 있음";
				} else if ( retVal == -7 ) {
					msg = "결제기간이 아니거나 분납결재 과정인데 분납결제 내용이 없음";
				} else if ( retVal == -8 ) {
					msg = "일반 B2C 과정이 아님";
				} else if ( retVal == -10 ) {
					msg = "교육비 정보가 다름";
				} else if ( retVal == -11 ) {
					msg = "교재비 정보가 다름";
				} else if ( retVal == -12 ) {
					msg = "전체 교육비 정보가 다름";
				} else if ( retVal == -13 ) {
					msg = "GLMP 과정이 아님";
				} else if ( retVal == -14 ) {
					msg = "골드패스 과정이 아님";
				} else if ( retVal == -15 ) {
					msg = "결제기간이 아님";
				} else if ( retVal == -16 ) {
					msg = "결제를 할수 없는 상태임(이미 결제가 되어있거나 환불진행중)";
				}
			}
			return alertPopupClose(request, msg+"("+retVal+")", "");
		}

//		return alertAndExit(request, msg, "/front/Approval.do?cmd=subjSearchShow&p_gyear=" + box.getString("p_year") + "&p_subj=" + box.getString("p_subj"), "");
	}
	
	/**
	 * GLMP 신청정보 업데이트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward proposeUpdateGLMP (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
					throws Exception {
		if ( box.getString("s_userid").equals("") ) {
			return alertPopupClose(request, "권한이 없습니다.", "");
		}
		
		// opener 가 팝업이면 opener 를 reload 하지 않기 위해 opener 가 팝업인지 확인한다.
		String v_ppopup = box.getString("p_ppopup");
		box.put("p_ppopup",  v_ppopup  );
		
		String _where = box.getString("_where");
		if ( _where.equals("B") ) {	// 관리자에서 수강신청 할 때에는 아이디와 회사정보가 넘어온다.
//			box.put("p_gyear", box.getString("p_year"));
		} else {
			box.put("p_comp", box.getString("s_comp"));
			box.put("p_gyear", box.getString("p_year"));
			box.put("p_userid", box.getString("s_userid"));
		}
		
		String v_proposetype = box.getStringDefault("p_proposetype", "1");
		String v_installment_seq = box.getString("p_installment_seq");
		
		
		//파일업로드
		String uploadPath	= "/propose/"+box.getString("subj")+"/"+box.getString("year")+"/"+box.getString("subjseq");
//			int v_maxfilesize	= box.getInt("p_maxfilesize");
		int v_maxfilesize	= 10;
		
		UploadFiles files 	= FileUtil.upload(request, uploadPath, v_maxfilesize, false, "A", DateTimeUtil.getDateTime());
		RequestManager.getMultiBox(box, files.getMultipart());
		box.put("p_proposetype", v_proposetype);
		_where = box.getString("_where");
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
		
		int retVal = 0;
		String v_subj = box.getString("p_subj");
		String v_year = box.getString("p_year");
		String v_subjseq = box.getString("p_subjseq");
		String msg = null;
		
		ProposeMgr proposeMgr = new ProposeMgr();
		MemberMgr memberMgr = new MemberMgr();
		
		// GLMP 신청정보 업데이트
		retVal = proposeMgr.proposeUpdateGLMP(request, box);

	
		return alertPopupClose(request, "수정되었습니다", "");
	}

	/**
	 * 선택적 부분수강 수강신청 폼
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward proposeWriteFormSel (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {

		if ( box.getString("s_userid").equals("") ) {
			return alertPopupClose(request, "로그인을 먼저 해 주십시요", "");
		}

		String _where = box.getString("_where");
		if ( _where.equals("B") ) {	// 관리자에서 수강신청 할 때에는 아이디와 회사정보가 넘어온다.
//			box.put("p_gyear", box.getString("p_year"));
		} else {
			box.put("p_comp", box.getString("s_comp"));
			box.put("p_gyear", box.getString("p_year"));
			box.put("p_userid", box.getString("s_userid"));
		}
		box.put("p_trainingclass", "09");	// 이러닝과 같은 상점아이디 사용
		box.put("p_proposetype", "7");

		// 적립된 마일리지 가져오기
		MileageMgr mileageMgr = new MileageMgr();
		int v_mileage = mileageMgr.selectUserRestantPoint(box);
		box.put("p_mileage", v_mileage);

		/**
		 * 1. 사용자가 선택 한 그룹(차시)을 배열로 받는다. (GROUPID_OPENSUBJID_BIYONG)
		 *   1-1. 그룹아이디 추출한다.
		 * 2. 과정 정보 셀렉트 ( 과정명, 결제수단, 결제할금액, ... 등 )
		 */
		ArrayList v_grouplist = (ArrayList)box.getList("p_grouplist");
//		if ( v_grouplist == null || v_grouplist.size() == 0 ) {
//			v_grouplist = new ArrayList();
//			v_grouplist.add("1_0000000043_500");
//			v_grouplist.add("2_0000000043_500");
//			v_grouplist.add("3_0000000043_100");
//			v_grouplist.add("4_0000000043_1000");
//			v_grouplist.add("5_0000000043_700");
//			box.put("p_grouplist", v_grouplist);
//		}

		StringBuilder sbGoupId = new StringBuilder();
		String[] arrTmp = null;

		if ( v_grouplist == null || v_grouplist.size() <= 0 ) {
			return alertPopupClose(request, "수강 할 항목을 선택해 주십시요", "");
		}

		String v_opensubjid = box.getString("p_opensubjid");

		for ( int i=0; i < v_grouplist.size(); i++ ) {
			arrTmp = v_grouplist.get(i).toString().split("_");
			sbGoupId.append("'").append(arrTmp[0]).append("',");
			if ( v_opensubjid.equals("") ) {
				v_opensubjid = arrTmp[1];
			}
		}
		sbGoupId.delete(sbGoupId.length()-1, sbGoupId.length());
		box.put("p_groupids", sbGoupId.toString());
		if ( box.getString("p_opensubjid").equals("") ) {
			box.put("p_opensubjid", v_opensubjid);
		}
		// 장바구니에 담긴 과정 결제시 장바구니 테이블에 존재하는지 여부를 확인한다.
		String v_iscart = box.getString("p_iscart");
		if(v_iscart.equals("Y")){
			CartMgr cartMgr = new CartMgr();
			int cartrst = cartMgr.checkPartSubjCartItem( request, box);
			if(cartrst == 0 ){
				String msg = "장바구니에 존재하지 않습니다.";

				return closePopupReload(request, msg, "","O");
			}
		}

		// 수강신청 정보를 가져온다.
		ProposeMgr proposeMgr = new ProposeMgr();
		Box boxProposeApplyInfo = proposeMgr.selectProposeSelApplyInfo(box);
		box.put("boxProposeApplyInfo", boxProposeApplyInfo);
		proposeMgr.doINISecureStart(request, box);

		return mapping.findForward("ProposeWriteForm7");
	}

	/**
	 * 부분수강 수강신청
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward proposeWriteSel (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {
		if ( box.getString("s_userid").equals("") ) {
			return alertPopupClose(request, "권한이 없습니다.", "");
		}

		StudentManagerMgr studentMgr = new StudentManagerMgr();

		String _where = box.getString("_where");
		if ( _where.equals("B") ) {	// 관리자에서 수강신청 할 때에는 아이디와 회사정보가 넘어온다.
//			box.put("p_gyear", box.getString("p_year"));
		} else {
			box.put("p_comp", box.getString("s_comp"));
			box.put("p_gyear", box.getString("p_year"));
			box.put("p_userid", box.getString("s_userid"));
		}
		box.put("p_trainingclass", "09");	// 이러닝과 같은 상점아이디 사용

		ArrayList v_grouplist = (ArrayList)box.getList("p_grouplist");
//		if ( v_grouplist == null || v_grouplist.size() == 0 ) {
//			v_grouplist = new ArrayList();
//			v_grouplist.add("1_0000000014_500");
//			v_grouplist.add("2_0000000014_500");
//			v_grouplist.add("3_0000000014_100");
//			v_grouplist.add("4_0000000014_1000");
//			v_grouplist.add("5_0000000014_700");
//			box.put("p_grouplist", v_grouplist);
//		}

		StringBuilder sbGoupId = new StringBuilder();
		String[] arrTmp = null;

		if ( v_grouplist == null && v_grouplist.size() <= 0 ) {
			return alertPopupClose(request, "수강 할 항목을 선택해 주십시요", "");
		}

		String v_opensubjid = box.getString("p_opensubjid");

		for ( int i=0; i < v_grouplist.size(); i++ ) {
			arrTmp = v_grouplist.get(i).toString().split("_");
			sbGoupId.append("'").append(arrTmp[0]).append("',");
			if ( v_opensubjid.equals("") ) {
				v_opensubjid = arrTmp[1];
			}
		}
		sbGoupId.delete(sbGoupId.length()-1, sbGoupId.length());
		box.put("p_groupids", sbGoupId.toString());
		if ( box.getString("p_opensubjid").equals("") ) {
			box.put("p_opensubjid", v_opensubjid);
		}

		int retVal = 0;
		String v_subj = box.getString("p_subj");
		String v_year = box.getString("p_year");
		String v_subjseq = box.getString("p_subjseq");
		String msg = null;

		ProposeMgr proposeMgr = new ProposeMgr();

		retVal = proposeMgr.proposeWriteSel(request, box);

		if ( retVal > 0 ) {

			if ( _where.equals("B") ) {
				return alertPopupClose(request, "수강신청 되었습니다.", "");
			}else if (box.getString("p_iscart").equals("Y") ) {
				return closePopupReload(request, "수강신청되었습니다.", "", "", "/front/Cart.do?cmd=viewPartSubjCart");
			}else {
				return closePopupReload(request, "수강신청되었습니다.", "", "", "/front/Propose.do?cmd=proposeList&type=sel");
			}

		} else {
			msg = "수강신청 오류입니다. 관리자에게 연락해 주십시요";

			return alertPopupClose(request, msg, "");
		}
	}

	/**
	 * 수강신청 취소
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward proposeWriteCancel (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {

		int retVal = 0;

		box.put("p_comp", box.getString("s_comp"));
		box.put("p_gyear", box.getString("p_year"));
		box.put("p_userid", box.getString("s_userid"));

		String v_subj = box.getString("p_subj");
		String v_year = box.getString("p_year");
		String v_subjseq = box.getString("p_subjseq");

		ProposeMgr proposeMgr = new ProposeMgr();
		retVal = proposeMgr.proposeWriteCancel(request,box);

		if ( retVal > 0 ) {
			return alertAndAction(request, "수강신청을 취소 하였습니다.", "/front/Propose.do?cmd=proposeList&type=pre&p_subj="+v_subj+"&p_year="+v_year+"&p_subjseq="+v_subjseq);
		} else {
			return alertAndAction(request, "수강신청 취소요청을 실패 하였습니다.", "/front/Propose.do?cmd=proposeList&type=pre&p_subj="+v_subj+"&p_year="+v_year+"&p_subjseq="+v_subjseq);
		}
	}
	/**
	 * 결제수단 선택화면에서 수강신청 취소
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward proposePayFormWriteCancel (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
					throws Exception {
		
		int retVal = 0;
		
		box.put("p_comp", box.getString("s_comp"));
		box.put("p_gyear", box.getString("p_year"));
		box.put("p_userid", box.getString("s_userid"));
		
		String v_subj = box.getString("p_subj");
		String v_year = box.getString("p_year");
		String v_subjseq = box.getString("p_subjseq");
		
		ProposeMgr proposeMgr = new ProposeMgr();
		retVal = proposeMgr.proposeWriteCancel(request,box);
		
		if ( retVal > 0 ) {
			//return alertPopupClose(request, "취소되었습니다", "") ;
			return alertAndAction(request, "", "/front/Propose.do?cmd=proposeWriteForm");
		} else {
			return alertPopupClose(request, "취소에 실패 하였습니다", "") ;
		}
	}

	/**
	 * 환불신청 폼
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward refundRequestWriteForm (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {

		if ( box.getString("s_userid").equals("") ) {
			return alertPopupClose(request, "로그인을 먼저 해 주십시요", "");
		}

		PaymentMgr paymentMgr = new PaymentMgr();
		Box boxPaymentInfo = paymentMgr.selectPaymentDetail(box);
		box.put("boxPaymentInfo", boxPaymentInfo);

		if ( boxPaymentInfo.getString("RECOGSTATE").equals("Y") ) {
			return mapping.findForward("RefundRequestWriteForm");
		} else {
			return alertPopupClose(request, "결제가 완료된 경우에만 환불신청을 할수 있습니다.", "");
		}

	}

	/**
	 * 환불요청한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward refundRequestWrite (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {
		if ( box.getString("s_userid").equals("") ) {
			return alertPopupClose(request, "권한이 없습니다.", "");
		}

		int retVal = 0;

		PaymentMgr paymentMgr = new PaymentMgr();
		Box boxPaymentInfo = paymentMgr.selectPaymentDetail(box);
		box.put("boxPaymentInfo", boxPaymentInfo);

		if ( !boxPaymentInfo.getString("RECOGSTATE").equals("Y") ) {
			return alertPopupClose(request, "결제가 완료된 경우에만 환불신청을 할수 있습니다.", "");
		}

		ProposeMgr proposeMgr = new ProposeMgr();
		retVal = proposeMgr.updatePaymentRefundRequest(box);

		if ( retVal > 0 ) {
			//return alertPopupClose(request, "환불요청 되었습니다.", "");
			return closePopupReload(request, "환불요청 되었습니다.", "", "", "");
		} else {
			return alertPopupClose(request, "환불요청을 실패하였습니다..", "");
		}
	}

//	/**
//	 * 수강신청시 결제를 처리한다.
//	 * @param mapping
//	 * @param form
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws Exception
//	*/
//	public ActionForward proposeWritePay(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
//
//		try {
//			ProposeMgr proposeMgr = new ProposeMgr();
//			//능력카드 결제인경우 payment를 호출한다.
////			int retVal = proposeMgr.proposeWriteB2C(request, box);
//			int retVal = proposeMgr.proposeWriteB2C(box);
//			String pay_type = box.getString("pay_type");
//			if(retVal > 0) {
//				if(pay_type.equals("100000000000") || pay_type.equals("010000000000") || pay_type.equals("001000000000")) {
//					//신용카드,계좌이체,가상계좌인경우 결과 페이지로 보낻다.
//					return mapping.findForward("ProposeWritePay");
//				} else {
//					return alertPopupClose(request, "결제가 완료되었습니다.", "");
//				}
//			} else {
//				return alertPopupClose(request, "결제시 오류가 발생했습니다.", "");
//			}
//		} catch (Exception e) {
//			return alertPopupClose(request, "결제시 오류가 발생했습니다.", "");
//		}
//	}
//
//	/**
//	 * 결제결과 페지이를 표시한다.
//	 * @param mapping
//	 * @param form
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws Exception
//	*/
//	public ActionForward proposeWriteResult(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
//		return mapping.findForward("ProposeWriteResult");
//
//	}
//
	/**
	 * 배송지 변경 팝업을  표시한다..
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward changeDeliveryWriteForm (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {
		String v_gyear	= box.getString("p_gyear");
		String v_subj	 = box.getString("p_subj");
		String status = "";
		String isonoff = "";
		String v_comp = box.getString("s_comp");
		box.getMap().put("p_comp", box.getString("s_comp"));
		box.getMap().put("p_userid", box.getString("s_userid"));

		String msg = null;
		MemberMgr memberMgr = new MemberMgr();
		StudentManagerMgr studentMgr = new StudentManagerMgr();
		CompMgr compMgr = new CompMgr();
		SubjSeqMgr subjSeqMgr = new SubjSeqMgr();
		DeliveryMgr deliveryMgr = new DeliveryMgr();

		box.put("subjSeqInfo", subjSeqMgr.getSubjSeq(box).getFirstObject());
		box.put("subjSeqSubBL", subjSeqMgr.getSubjSeq(box).getFirstObject()); //혼합과정인경우 포함과정
		box.put("deliveryInfo", deliveryMgr.getCourseDeleverUser(box));

		box.put("compInfo", compMgr.selectCompOne(v_comp));
		return mapping.findForward("ChangeDeliveryWriteForm");
	}

	/**
	 * 배송지를 변경한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward changeDeliveryWrite (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {
		int retVal = 0;
		String v_gyear	= box.getString("p_gyear");
		String v_subj	 	= box.getString("p_subj");
		String status = "";
		String isonoff = "";
		DeliveryMgr deliveryMgr = new DeliveryMgr();
		Box delivery = deliveryMgr.getCourseDeleverUser(box);
		if(delivery.getString("USERID").equals("")) {
			retVal = deliveryMgr.insertDeliveryUser(box);
		} else {
			retVal = deliveryMgr.updateDeliveryUser(box);
		}

		if(retVal > 0) {
			return closePopupReload(request, "변경되었습니다.", "", "");
		} else {
			return closePopupReload(request, "배송지 변경 오류 발생", "", "");
		}
	}

	/**
	 * 교재  변경 팝업을  표시한다..
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward changeBookWriteForm (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {
		String v_gyear	= box.getString("p_gyear");
		String v_subj	 = box.getString("p_subj");
		String status = "";
		String isonoff = "";
		String v_comp = box.getString("s_comp");
		box.getMap().put("p_comp", box.getString("s_comp"));
		box.getMap().put("p_userid", box.getString("s_userid"));

		String msg = null;
		MemberMgr memberMgr = new MemberMgr();
		StudentManagerMgr studentMgr = new StudentManagerMgr();
		CompMgr compMgr = new CompMgr();
		SubjSeqMgr subjSeqMgr = new SubjSeqMgr();
		StudyBookMgr studybookMgr = new StudyBookMgr();

		box.put("subjSeqInfo", subjSeqMgr.getSubjSeq(box).getFirstObject());
		box.put("subjSeqSubBL", subjSeqMgr.getSubjSeq(box).getFirstObject()); //혼합과정인경우 포함과정
		box.put("bookList", studybookMgr.selectStudyBookSubjseqWithAllBook(box));

		box.put("compInfo", compMgr.selectCompOne(v_comp));
		return mapping.findForward("ChangeBookWriteForm");
	}


	/**
	 * 교재를 변경한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward changeBookWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
		String v_gyear	= box.getString("p_year");
		String v_subj	 	= box.getString("p_subj");
		String status = "";
		String isonoff = "";
		StudyBookMgr studybookMgr = new StudyBookMgr();
		int retVal = studybookMgr.changeStudyBookUser(box);
		if(retVal > 0) {
			return closePopupReload(request, "변경되었습니다.", "", "");
		} else {
			return closePopupReload(request, "교재가 변경되지 않았습니다.", "", "");
		}
	}

	/**
	 * 수강신청 확인/취소 리스트를 가져온다.
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward proposeCancelList (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {

//		String v_comp = box.getString("s_comp");
//		String v_userid = box.getString("s_userid");
		box.put("p_comp", box.getString("s_comp"));
		box.put("p_userid", box.getString("s_userid"));
		box.put("p_subjtype", "C");
//		CompMgr compMgr = new CompMgr();
//		Box compInfo = compMgr.selectCompOne(v_comp);
//		box.put("compInfo", compInfo);
//		if(compInfo.getString("BTOBYN").equals("Y")) {
//			ApprovalMgr approvalMgr = new ApprovalMgr();
//			DataSet data  = approvalMgr.selectCourseApprovalCancelList(box);
//			box.put("proposeCancelList", data);
//			return mapping.findForward("ProposeCancelList");
//		} else {
//			PaymentMgr paymentMgr = new PaymentMgr();
//			//DataSet data  = approvalMgr.selectCourseApprovalCancelList(box);
//			DataSet data  = paymentMgr.selectPaymentListUser(box);
//			MemberMgr memberMgr = new MemberMgr();
//			box.put("userInfo", memberMgr.selectMemberDetailOne(v_userid));
//			box.put("proposeCancelList", data);
//			return mapping.findForward("ProposeCancelListB2C");
//		}

		ApprovalMgr approvalMgr = new ApprovalMgr();
		DataSet data  = approvalMgr.selectCourseApprovalCancelList(box);
		box.put("proposeCancelList", data);
		return mapping.findForward("ProposeCancelList");
	}


	/**
	 * 환불계좌를 등록/수정폼을 표시한다.
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward refundAccountWriteForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{

		String v_comp = box.getString("s_comp");
		String v_userid = box.getString("s_userid");
		box.put("p_comp", box.getString("s_comp"));
		box.put("p_userid", box.getString("s_userid"));

		MemberMgr memberMgr = new MemberMgr();
		box.put("userInfo", memberMgr.selectMemberDetailOne(v_userid));
		return mapping.findForward("RefundAccountWrite");

	}

	/**
	 * 환불계좌를 수정 한다.
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward refundAccountWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{

		String v_comp = box.getString("s_comp");
		String v_userid = box.getString("s_userid");
		box.put("p_comp", box.getString("s_comp"));
		box.put("p_userid", box.getString("s_userid"));

		MemberMgr memberMgr = new MemberMgr();
		box.put("userInfo", memberMgr.selectMemberDetailOne(v_userid));

		int retVal = memberMgr.updateMemberRefundAccount(box);
		if(retVal > 0) {
			return closePopupReload(request, "환불계좌정보가 등록되었습니다.", "", "");
		} else {
			return closePopupReload(request, "오류 발생", "", "");
		}

	}

	/**
	 * 수강신청 확인/취소 리스트를 가져온다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward courseApprovalCancelList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		ApprovalMgr approvalMgr = new ApprovalMgr();
		DataSet data  = approvalMgr.selectCourseApprovalCancelList(box);
		box.put("CourseApprovalCancelList", data);

		return mapping.findForward("CourseApprovalCancelList");
	}

	/**
	 * 수강신청을 취소창을 띄워준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward courseApprovalCancelWriteForm (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {
		SubjSeqMgr subjseqMgr = new SubjSeqMgr();
		ProposeMgr proposeMgr = new ProposeMgr();

		HashMap param = box.getMap();
		param.put("p_userid", box.getString("s_userid"));
//		param.put("p_userid", "200407031");
		Box proposeInfo = proposeMgr.getProposeDetail(param);
		if ( proposeInfo == null || proposeInfo.getMap() == null ) {
			return closePopupReload(request, "수강취소할 내역이 없습니다.", "", "");
		}
		if(proposeInfo.getString("ISONOFF").equals("OFF") && proposeInfo.getString("APPLYGUBUN").equals("IDP")) {
			//교육시작일 전이면, 변경요청 가능
			int remainDay = proposeInfo.getInt("REMAINDAY");
			if(remainDay < 1) {
				return closePopupReload(request, "교육시작일 이후에는 취소/변경이 불가능합니다.", "", "");
			}

		} else if(proposeInfo.getString("CHKFINAL").equals("Y") || proposeInfo.getString("CHKFINAL").equals("승인")) { //입과되었다면,
			return closePopupReload(request, "수강승인된 과정입니다.", "", "");
		}


		box.put("ProposeInfo", proposeInfo);
		box.put("SubjSeqList", subjseqMgr.selectSubjSeqList2(box));
		return mapping.findForward("CourseApprovalCancelWrite");
	}


	/**
	 * 수강신청을 취소창을 띄워준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward proposeCancelWriteForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
		SubjSeqMgr subjseqMgr = new SubjSeqMgr();
		PaymentMgr paymentMgr = new PaymentMgr();
		String v_userid = box.getString("s_userid");
		box.put("p_userid", v_userid);
		box.put("paymentInfo", paymentMgr.selectPaymentDetail(box));
		box.put("subjSeqInfo", subjseqMgr.getSubjSeq(box).getFirstObject());
		MemberMgr memberMgr = new MemberMgr();
		box.put("userInfo", memberMgr.selectMemberDetailOne(v_userid));
		return mapping.findForward("ProposeCancelWriteForm");

	}

	/**
	 * B2C 수강신청을 취소한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward proposeCancelWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
		try {
			ProposeMgr proposeMgr = new ProposeMgr();
			int retVal = proposeMgr.proposeCancelB2C(box);
			String msg = "";
		    if(retVal > 0) {
		    	return closePopupReload(request, "수강취소 되었습니다.", "", "");
		    } else {
		    	return closePopupReload(request, "수강취소 오류", "", "");
		    }
		} catch(Exception e) {
			return closePopupReload(request, "수강취소 오류", "", "");
		}

	}


	/**
	 * B2B 수강신청을 취소한다.(IDP 업체가 아닌경우)
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward proposeCancelWriteB2B (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {
		try {
			ProposeMgr proposeMgr = new ProposeMgr();

			String cancelGubun = box.getString("p_cancelgubun");
			cancelGubun = "";

			box.put("p_userid", box.getString("s_userid"));
//			box.put("p_userid", "200407031");

			String msg = "";
			if(cancelGubun.equals("D")) { //연기 차수인경우
				int retVal = proposeMgr.requestDelay(box);
				if(retVal > 0) {
			    	return closePopupReload(request, "수강연기신청  되었습니다.", "", "");
			    } else {
			    	return closePopupReload(request, "수강연기신청  오류", "", "");
			    }

			} else {
				int retVal = proposeMgr.proposeWriteCancel(request, box);
				if(retVal > 0) {
			    	return closePopupReload(request, "수강취소 되었습니다.", "", "");
			    } else {
			    	return closePopupReload(request, "수강취소 오류", "", "");
			    }
			}
		} catch(Exception e) {
			return closePopupReload(request, "수강취소 오류", "", "");
		}

	}



	/**
	 * 수강신청을 취소요청한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward courseApprovalCancelWrite(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,Box box) throws Exception{
		DelayApplyMgr delayApplyMgr = new DelayApplyMgr();
		String v_language = box.getString("p_language");
		String msg = null;
		try {
			int retVal = delayApplyMgr.requestDelay(box);

			msg = box.getString("msg");
		    if(retVal > 0) {
		    	return closePopupReload(request, msg, "", "");
		    } else {
		    	return closePopupReload(request, msg, "", "");
		    }
		} catch(Exception e) {
			msg = e.getMessage();
			if(msg == null) {
				msg = box.getString("msg").replaceAll("\n", "\\n");
			}
			return closePopupReload(request, msg, "", "");
		}
	}

	/**
	 * 수강신청 리스트를 가져온다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward courseApprovalCheifRejectWriteForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{

		return mapping.findForward("CourseApprovalCheifRejectWriteForm");
	}

	/**
	 * 수수료증 출력 팝업
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward certificateReportFPopup (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {

		String v_width = box.getStringDefault("p_width", "100%");
		String v_height = box.getStringDefault("p_height", "100%");

		String[] aConArgs = {
				"p_subjnm="+box.getString("p_subjnm"),
				"p_gyear="+box.getString("p_gyear"),
				"p_grseq="+box.getString("p_grseq"),
				"p_comp="+box.getString("s_comp"),
				"p_userid="+box.getString("s_userid"),
				"p_subjseq="+box.getString("p_subjseq"),
				"p_startmonth="+box.getString("p_startmonth"),
				"p_edustart_1="+box.getString("p_edustart_1"),
				"p_edustart_2="+box.getString("p_edustart_2"),
				"p_eduend_1="+box.getString("p_eduend_1"),
				"p_eduend_2="+box.getString("p_eduend_2"),
				"p_outsourcingtype="+box.getString("p_outsourcingtype"),
				"p_isgoyong="+box.getString("p_isgoyong"),
				"p_servicecomp="+box.getString("p_servicecomp"),
				"p_isgraduated="+box.getString("p_isgraduated")
		};

		String[] aOdiArgs = {
				"p_subjnm="+box.getString("p_subjnm"),
				"p_grcode="+box.getString("p_grcode"),
				"p_gyear="+box.getString("p_gyear"),
				"p_grseq="+box.getString("p_grseq"),
				"p_comp="+box.getString("s_comp"),
				"p_startmonth="+box.getString("p_startmonth"),
				"p_edustart_1="+box.getString("p_edustart_1"),
				"p_edustart_2="+box.getString("p_edustart_2"),
				"p_eduend_1="+box.getString("p_eduend_1"),
				"p_eduend_2="+box.getString("p_eduend_2")
				};

//		OzReport report = new OzReport("/unempInsurance/completeReport.ozr","completeReport","","",v_width,v_height);
		System.out.println(">>>>>>>>>p_subjnm : "+box.getString("p_subjnm")+", p_subjseq : "+box.getString("p_subjseq")+", p_comp : "+box.getString("s_comp")+", p_userid : "+box.getString("s_userid"));

		OzReport report = new OzReport();
		report.setReportName("/unempInsurance/completionCertificateLearner.ozr");
		report.setOdiName("completionCertificateLearner");
		report.setOidArgs(aOdiArgs);
		report.setConnectionArgs(aConArgs);
		report.setWidth(v_width);
		report.setHeight(v_height);

		box.put("report", report);

		return mapping.findForward("CertificateReportFPopup");
	}


	/**
	 * 모바일 수강 목록을 표시한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward mobileProposeList (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {

		String isonoff = "";
		String isb2b = "";
		int retVal = 0;
		String v_comp = box.getString("s_comp");
		box.getMap().put("p_comp", box.getString("s_comp"));
		box.getMap().put("p_userid", box.getString("s_userid"));

		String msg = null;
		CompMgr compMgr = new CompMgr();
		Box compInfo = compMgr.selectCompOne(v_comp);
		isonoff = box.getString("ISONOFF");
		isb2b = compInfo.getString("BTOBYN");
		box.put("p_btobyn", isb2b);

		//학습제한 체크
 		MyClassMgr myClassMgr = new MyClassMgr();
		String studyChk = myClassMgr.selectStudyControl(box);
		box.put("StudyControl",studyChk);

		ProposeMgr proposeMgr = new ProposeMgr();

		String type= box.getString("type");
		if(type.equals("pre")) {
			box.put("proposeList",proposeMgr.getMobileProposeListAllInfo(box));
			if ( isb2b.equals("Y") ) {
				return mapping.findForward("MobileProposeListPre");

			} else {
				return mapping.findForward("MobileProposeListPreB2C");
			}
		} else if(type.equals("ing")) {
			ApprovalMgr approvalMgr = new ApprovalMgr();
			box.put("p_idx", "0");
			box.put("proposeList",proposeMgr.getMobileProposeListIng(box));
			return mapping.findForward("MobileProposeListIng");
		} else if(type.equals("done")) {
			box.put("proposeList",proposeMgr.getMobileProposeListDone(box));
			return mapping.findForward("MobileProposeListDone");
		} else {
			return mapping.findForward("MobileProposeList");
		}

	}

	/**
	 * 모바일 컨텐츠
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward mobileContentsList (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {
		ProposeMgr proposeMgr = new ProposeMgr();
		box.put("mobileContentList", proposeMgr.selectMobileContents(box));
		return mapping.findForward("MobileContentsList");
	}

	/**
	 * 무역협회 회원사인지 확인한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public void doKitaAuthCheck (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {

		response.setCharacterEncoding("UTF-8");

		String retMsg = null;
		ProposeMgr proposeMgr = new ProposeMgr();
		box.put("p_authnum", box.getString("p_authnum").trim());
		Box data = proposeMgr.getKitaMemberAuthCheck(box);

		if ( data.getString("COMPANY_KOR").equals("") ) {
			retMsg = "N||||";
		} else {
			if ( data.getInt("CNT") > 0 ) {
				retMsg = "M||||";
			} else {
				retMsg = "Y||"+data.getString("COMPANY_KOR")+"||"+box.getString("COMPANY_KOR");
			}
		}

		PrintWriter pw = null;
		pw = response.getWriter();
		pw.append(retMsg);
	}
	/**
	 * 무역마스터 수료생 / 학생인지 확인한다
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public void doTradeGraduCheck (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
					throws Exception {
		
		response.setCharacterEncoding("UTF-8");
		
		String retMsg = null;
		ProposeMgr proposeMgr = new ProposeMgr();
		Box data = proposeMgr.getTradeGraduCheck(box);	//무역마스터 입과자인지 체크
		
		if(data.getString("TRADESUBJSEQ").equals("")){
			retMsg = "N";
		}else{
			retMsg = "Y"+data.getString("TRADESUBJSEQ");
		}
		
		PrintWriter pw = null;
		pw = response.getWriter();
		pw.append(retMsg);
	}
	/**
	 * 외환관리사 문자발송 - 약도
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public void sendLocationSMS (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
					throws Exception {
		
		response.setCharacterEncoding("UTF-8");
		
		String retMsg = null;
		
		MessageMgr messageMgr = new MessageMgr();
		
		box.put("p_subj", "");   //일반 SMS일 경우 subj,subjseq,gyer 초기화
		box.put("p_year", "");
		box.put("p_subjseq", "");
		box.put("p_subjnm","");

		ArrayList v_userlist = box.getList("p_userinfo");
		box.put("p_usernum", v_userlist.size());

		retMsg = messageMgr.doSendSms(box);		
		
		
		PrintWriter pw = null;
		pw = response.getWriter();
		pw.append(retMsg);
	}
	
	
	/**
	 * 수강신청시 해당 기수가 개설되어 있는지 체크한다(SMART-004-B)
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward subjseqMadeCheck(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception {
		
		if ( box.getString("s_userid").equals("") ) {
			return alertPopupClose(request, "로그인을 먼저 해 주십시요", "");
		}
		
		//if(!"09".equals(box.getString("p_trainingclass"))){	//이러닝이 아닐경우 기존 수강신청 폼으로 이동
		//	System.out.println("여기왓네요");
		//	return alertAndAction(request, "", "/front/Propose.do?cmd=proposeWriteForm");
		//}
		
		String next = request.getParameter("next");
		if(StringUtil.isNull(next)) {
			next = request.getParameter("cmd");
		}
		
		SubjSeqMgr subjSeqMgr = new SubjSeqMgr();
		
		//자동개설 리스트에 존재 하지 않을경우 기존수강신청 폼으로 이동
		if( subjSeqMgr.checkSubjSeqAutoList(box)<1){
			return forward("/front/Propose.do?cmd=proposeWriteForm");
		}
			
			
		//기수 존재 유무 체크
		DataSet ck = null;
		ck = subjSeqMgr.subjseqMadeCheck(box);
		
		//기수가 존재할경우 수강신청폼으로 이동
		if (ck.next()==true) {
			System.out.println("기수있음");
			box.put("p_subj", ck.getString("SUBJ"));
			box.put("p_subjseq", ck.getString("SUBJSEQ"));
			box.put("p_year", ck.getString("YEAR"));
			box.put("p_gyear", ck.getString("YEAR"));
			box.put("p_grseq", ck.getString("GRSEQ"));
			box.put("p_grcode", ck.getString("GRCODE"));
			
			return proposeWriteForm(mapping, form, request, response, box);
		//기수가 없을경우 기수 개설 액션으로 이동
		} else {			
			System.out.println("기수없음");
			return subjseqAutoMake(mapping, form, request, response, box);
		}
		
	}
	
	
	/**
	 * 자동 기수 개설(SMART-004-B)
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward subjseqAutoMake(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception {
		
		SubjSeqMgr subjSeqMgr = new SubjSeqMgr();
		SubjectMgr subjectMgr = new SubjectMgr(); 
				
		String p_grcode="N000002";	//N000002 (T_LMS_GRCODE) == 무역아카데미(B2C)
		box.put("p_grcode", p_grcode);
		


		FormatDate date = new FormatDate();
		//현재 년월일 가져오기
		String todateis =  date.getDate("yyyyMMdd");		
		
		Calendar cal = Calendar.getInstance();
		
				
		String aaaa[] = {"일", "월", "화", "수", "목", "금", "토", "일"};
		
		//현재 요일에 해당하는 숫자 구하기
		//현재 요일구하기(1:월요일/2:화요일/3:수요일/4:목요일/5:금요일/6:토요일/7:일요일)
		int todayNumber = date.getDayOfWeekforNumber(todateis);
		if(todayNumber==0){todayNumber=7;}	//0:일요일 => 일요일일경우 7로 변경
		int mon_today = 1-todayNumber;	//오늘과 월요일의 간격
		String mon_date = date.getRelativeDate(todateis, mon_today);	//월요일의 날짜 YYYYMMDD		
		String sun_date = date.getRelativeDate(mon_date, 6);	//일요일의 날짜 YYYYMMDD - 월요일+6일==일요일
		//System.out.println("월요일 : "+mon_date+", 오늘 : "+todateis+aaaa[todayNumber]+", 일요일 : "+sun_date);
		
		
		
		//과정코드
		String p_subj = "";
		p_subj = box.getString("p_subj");
		//해당과정의 정보 가져오기
		DataSet ds =  subjectMgr.getSubject(p_subj);	
		
		
		//교육일수
		String edudays = "";
		edudays = ds.getFirstObject().getString("EDUDAYS");
		
		//수강신청 시작일 : 해당 주의 월요일 00시
		String p_props="";	
		p_props = mon_date;
		box.put("p_props", p_props+"00");
		
		//수강신청 종료일 : 해당 주의 일요일 23시
		String p_prope="";	
		p_prope = sun_date;
		box.put("p_prope", p_prope+"23");
		
		//자동개설 리스트 중 해당 과정의 교육시작기준 가져오기 - 0:즉시(교육시작일 =이전월요일) / 1:다음주 월요일
		String standard = subjSeqMgr.selectSubjseqAutoStandard(box);	
		int edu_startDate = 0;	//수강신청일 종료일기준 언제 교육시작인지(일수)
		if(standard.equals("0")){
			edu_startDate = -6;
		}else if(standard.equals("1")){			
			edu_startDate = 1;
		}
		
		//교육시작일 : 자체, 포팅 과정의 경우 수강신청종료일 기준 이전 월요일 /  링크 과정의 경우 다음주 월요일(수강신청 종료일 다음날)
		String p_edustart="";
		p_edustart = date.getRelativeDate(sun_date, edu_startDate);
		box.put("p_edustart", p_edustart);
		
		//교육종료일 : 해당과정의 수강신청 종료일 다음날 부터 교육일수 만큼 더한 날짜
		String p_eduend="";
		p_eduend = date.getRelativeDate(sun_date, Integer.parseInt(edudays));//기준일부터 몇일뒤를 구하는 메소드여서 기준일을 제외시키기위해 +1 안함
		box.put("p_eduend", p_eduend);
		
		
		//년도(교육시작일의 년도)
		String p_gyear=p_edustart.substring(0, 4);	
		box.put("p_gyear", p_gyear);
		
		//결제기한(수강신청 종료일==그주 일요일)
		String p_paylimit=p_prope;		
		box.put("p_paylimit", p_paylimit);
		
		String p_luserid=box.getString("s_userid");		//로그인아이디
		box.put("p_luserid", p_luserid);
		box.put("p_userid", p_luserid);
		//GRSEQ가져오기
		String p_grseq="";	//T_LMS_GRSEQ
		p_grseq = subjSeqMgr.getGrSeqCode(box);
		box.put("p_grseq", p_grseq);
		
		
		
		//설문정보
		/*		MGR에서 배열로 받기때문에 배열로 넣을것  이름은 아래 이름
		ArrayList arrSulPaperNum = box.getList("p_arrSulPaperNum");
		ArrayList arrSulPaperStart = box.getList("p_arrSulPaperStart");
		ArrayList arrSulPaperEnd = box.getList("p_arrSulPaperEnd");		
		*/
		String arrSulPaperNum[] = null;
		String arrSulPaperStart[] = null;
		String arrSulPaperEnd[] = null;
		//과정에 해당하는 설문지 정보 가져와서 리스트에 담기
		SulmunMgr suMgr = new SulmunMgr();
		DataSet suldata = suMgr.selectSulmunSubj(box);
		if(suldata!=null){
			//배열 크기 선언
			arrSulPaperNum = new String[suldata.getRow()];
			arrSulPaperStart = new String[suldata.getRow()];
			arrSulPaperEnd = new String[suldata.getRow()];
			for(int x=0; x < suldata.getRow(); x++){
				suldata.next();
				arrSulPaperNum[x] = suldata.getString("SULPAPERNUM");
				
				String sulpaperstartdate = suldata.getString("SULSTARTDATE");//교육시작일 기준 몇일
				sulpaperstartdate = date.getRelativeDate(p_edustart, Integer.parseInt(sulpaperstartdate));		//교육시작일로부터 날짜 계산 후 date타입으로 리턴
				String sulpaperenddate = suldata.getString("SULENDDATE");	//교육종료일기준 몇일전
				sulpaperenddate = date.getRelativeDate(p_eduend, Integer.parseInt(sulpaperenddate)*-1); //교육종료일로부터 날짜 계산 후 date타입으로 리턴
				arrSulPaperStart[x] =  sulpaperstartdate;
				arrSulPaperEnd[x] =  sulpaperenddate;
			}
			box.put("p_arrSulPaperNum", arrSulPaperNum);
			box.put("p_arrSulPaperStart", arrSulPaperStart);
			box.put("p_arrSulPaperEnd", arrSulPaperEnd);
		}
		
		
		
		
		String subj_num = box.get("p_subj");		//기수 개설후 subj가 과목코드로 바뀌는데 다시 넣어줄 subj 값(과정코드)
		
		//기수 개설
		int retVal = 0;
		retVal = subjSeqMgr.insertGrSeq2(box);
		
		//subj값 재설정(과정코드로)
		box.put("p_subj", subj_num);		
		
		//개설된 기수번호(신청일, 신청종료일, 과정코드, 년도로 체크)
		String p_subjseq = "";
		p_subjseq = subjSeqMgr.selectAutoSubjSeq(box);
		box.put("p_subjseq", p_subjseq);
		System.out.println("aaaaaa==>  "+ p_subjseq);

		//과정정보를 가져온다
	    if(retVal > 0){
	    	box.put("p_year", box.getString("p_gyear"));
	    	//수강신청 페이지로 이동
	    	return proposeWriteForm(mapping, form, request, response, box);
	    }
		else return alertPopupClose(request, "시스템 오류 입니다 기수 개설에 실패하였습니다", "");
		
	}
	
	
	
	
	
	
}
