
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


		String v_ppopup = box.getString("p_ppopup");
		box.put("p_ppopup",  v_ppopup  );

		String _where = box.getString("_where");
		if ( _where.equals("B") ) {	
		} else {
			box.put("p_comp", box.getString("s_comp"));
			box.put("p_gyear", box.getString("p_year"));
			box.put("p_userid", box.getString("s_userid"));
		}

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
		

		if (v_btobyn.equals("Y")) {
			box.put("p_mileage", 10);
		} else {
			MileageMgr mileageMgr = new MileageMgr();
			int v_mileage = mileageMgr.selectUserRestantPoint(box);
			box.put("p_mileage", v_mileage);
		}
		

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

		SubjectMgr subjectMgr = new SubjectMgr();
		DataSet dsDiscountSubj = subjectMgr.getDiscountSubj(box.getString("p_subj"));
		box.put("dsDiscountSubj", dsDiscountSubj);

		if ( v_trainingclass.equals("03") || v_trainingclass.equals("04") || v_trainingclass.equals("08") || v_trainingclass.equals("12") || v_trainingclass.equals("16") || v_trainingclass.equals("13") || (v_trainingclass.equals("15")&&v_isonoff.equals("LONG")) ) {
			if ( v_trainingclass.equals("03") ) {
				if ( v_isoptsubjectselect.equals("N") ) {
					box.put("p_essenyn", "N");
					DataSet dsOptionSubject = proposeMgr.getSubjSeqBook(box);
					box.put("dsOptionSubject", dsOptionSubject);
					return mapping.findForward("ProposeWriteForm4");
				}
			}
			if ( v_proposeyn.equals("Y") ) {
				if ( v_payable.equals("N") ) {
					return alertPopupClose(request, "결제기간이 아닙니다..", "");
				}
				if ( v_paystate.equals("")||v_paystate.equals("C")||v_paystate.equals("E")||v_paystate.equals("F")||(_where.equals("B")&&v_paystateycnt>0) ) {
					proposeMgr.doINISecureStart(request, box);
					return mapping.findForward("ProposeWriteForm3");
				}
				else {
					return alertPopupClose(request, "결제를 할수 없는 상태 입니다.", "");
				}
			} else {
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
		else if ( v_trainingclass.equals("06")) {
			if ( v_proposeyn.equals("Y") ) {
				box.put("glmpEditMode", "Y");				
				
				Box boxProposeFormGLMP = proposeMgr.selectProposeFormGLMP(box);
				box.put("boxProposeFormGLMP", boxProposeFormGLMP);
				return mapping.findForward("ProposeWriteForm5");			
			}
			
		}
		else if ( v_btobyn.equals("N") ) {
			if ( v_proposeyn.equals("Y") ) {
				if ( (v_trainingclass.equals("01") || v_trainingclass.equals("05") || v_trainingclass.equals("14") ||v_trainingclass.equals("10"))&& (v_refundagreeyn.equals("")||v_refundagreeyn.equals("N")) ) {
					return mapping.findForward("ProposeWriteForm8");
				}
				if ( v_payable.equals("N") ) {
					return alertPopupClose(request, "결제기간이 아닙니다..", "");
				}
				if ( v_paystate.equals("")||v_paystate.equals("C")||v_paystate.equals("E")||v_paystate.equals("F")||(_where.equals("B")&&v_paystateycnt>0) ) {

					proposeMgr.doINISecureStart(request, box);

					return mapping.findForward("ProposeWritePayForm");
				}
				else {
					return alertPopupClose(request, "결제를 할수 없는 상태 입니다.", "");
				}
			}
		}
		else {
			if ( v_paystate.equals("I") ) {
				if ( v_btobyn.equals("Y") ) {
					return mapping.findForward("ProposeWriteForm");
				}
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

		DataSet dsSubjectListBook = proposeMgr.getSubjSeqBook(box);
		box.put("dsSubjectListBook", dsSubjectListBook);

		if ( v_trainingclass.equals("03") || v_trainingclass.equals("04") || v_trainingclass.equals("08") || v_trainingclass.equals("12") || v_trainingclass.equals("16") || v_trainingclass.equals("13")  || (v_trainingclass.equals("15")&&v_isonoff.equals("LONG"))  ) {
			proposeMgr.doINISecureStart(request, box);
			return mapping.findForward("ProposeWriteForm3");

		} else if ( v_trainingclass.equals("06") ) {	//GLMP
			Box boxProposeFormGLMP = proposeMgr.selectProposeFormGLMP(box);
			box.put("boxProposeFormGLMP", boxProposeFormGLMP);
			return mapping.findForward("ProposeWriteForm5");
		}
		else if ( v_trainingclass.equals("11") ) {
			proposeMgr.doINISecureStart(request, box);
			return mapping.findForward("ProposeWriteForm6");
		}
		else if ( v_trainingclass.equals("05") ) {
			return mapping.findForward("ProposeWriteForm10");
		}
		else if ( v_btobyn.equals("Y") ) {
			return mapping.findForward("ProposeWriteForm");

		} else {
			if (box.getString("p_subj").equals("2324")) {
				return mapping.findForward("ProposeWriteForm9");
			}
			return mapping.findForward("ProposeWriteForm2");

		}
	}
	
	public ActionForward paymentChange(
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box ) 
	throws Exception {
		int retVal = 0;		
		int retVal1 = 0;	
		
		box.getMap().put("p_userid", box.getString("s_userid"));
		
		ProposeMgr proposeMgr = new ProposeMgr();

		String v_installment_seq = box.getString("p_installment_seq");
		
		box.put("p_installment_seq", v_installment_seq);
		box.put("v_subj", box.getString("p_subj"));			
		box.put("v_year", box.getString("p_year"));			
		box.put("v_subjseq", box.getString("p_subjseq"));	
		box.put("p_userid", box.getString("s_userid"));		
		box.put("v_tid", box.getString("p_tid"));
			
		retVal = proposeMgr.deleteNupdatePaymentData(box);
		if(retVal == 1){
			System.out.println("DB가 정상적으로 삭제 되었습니다.");
		} else {
			System.out.println("DB삭제가 정상적으로 작동되지 않았습니다.");
		}
			
		if(Integer.parseInt(v_installment_seq) < 2){	// 분납과정이 한번이면
			retVal1 = proposeMgr.deleteLmsSend(box);
		}
		
		return proposeWriteForm(mapping, form, request, response, box);
	}

	public String inipaySetPriceCallBack(HashMap map, HttpServletRequest request) throws Exception{
		ProposeMgr proposeMgr = new ProposeMgr();
		Box box = new Box(map);
		if(box.getString("p_proposetype").equals("7")){
			box.put("p_trainingclass", "09");	
		}
		proposeMgr.doINISecureReStart(request, box);
		String data = box.getString("ini_encfield")+"|:"+ box.getString("ini_certid");

		return data ;
	}


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
		
		String v_ppopup = box.getString("p_ppopup");
		box.put("p_ppopup",  v_ppopup  );

		String _where = box.getString("_where");
		if ( _where.equals("B") ) {	
		} else {
			box.put("p_comp", box.getString("s_comp"));
			box.put("p_gyear", box.getString("p_year"));
			box.put("p_userid", box.getString("s_userid"));
		}

		String v_proposetype = box.getStringDefault("p_proposetype", "1");
		String v_installment_seq = box.getString("p_installment_seq");

		if ( v_proposetype.equals("2") || v_proposetype.equals("5") ) {
			String uploadPath	= "/propose/"+box.getString("subj")+"/"+box.getString("year")+"/"+box.getString("subjseq");
			int v_maxfilesize	= 10;

			UploadFiles files 	= FileUtil.upload(request, uploadPath, v_maxfilesize, false, "A", DateTimeUtil.getDateTime());
			RequestManager.getMultiBox(box, files.getMultipart());
			box.put("p_proposetype", v_proposetype);
			_where = box.getString("_where");
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
					
					else if ( file.getObjName().equals("p_collegianrealname") ) {
						box.put("p_collegiansavename", file.getUploadName());	
					}					
					else if ( file.getObjName().equals("p_fxmlicenserealname") ) {
						box.put("p_fxmlicensesavename", file.getUploadName()); 	
					}
					else if ( file.getObjName().equals("p_bankerrealname") ) {
						box.put("p_bankersavename", file.getUploadName()); 	
					}
					
				}
			}
			else if ( files.getStatus().equals("V") ) {
				return alertPopupClose(request, FileUtil.UPLOAD_VALIDATE_MSG, "");
			}
		}

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
		

		int retVal = 0;
		String v_subj = box.getString("p_subj");
		String v_year = box.getString("p_year");
		String v_subjseq = box.getString("p_subjseq");
		String msg = null;

		ProposeMgr proposeMgr = new ProposeMgr();
		MemberMgr memberMgr = new MemberMgr();

		if ( v_proposetype.equals("1") ) {
			retVal = proposeMgr.proposeWriteB2B(box);
		}
		else if ( v_proposetype.equals("2") ) {
			memberMgr.updateProposeMember(box);
			retVal = proposeMgr.proposeWriteB2C(box);
			if(retVal > 0 ) {
				if ( _where.equals("B") ) {
					return forward("/front/Propose.do?cmd=proposeWriteForm&p_subj="+v_subj+"&p_year="+v_year+"&p_subjseq="+v_subjseq+"&p_userid="+box.getString("p_userid")+"&_where=B");
				} else {
					return forward("/front/Propose.do?cmd=proposeWriteForm&p_subj="+v_subj+"&p_year="+v_year+"&p_subjseq="+v_subjseq+"&p_ppopup="+v_ppopup);
				}
			} else {
				return alertPopupClose(request, "수강신청 오류입니다.", "");
			}
		}
		else if ( v_proposetype.equals("3") ) {
			retVal = proposeMgr.proposeWriteTraid(request, box);
		}
		else if ( v_proposetype.equals("4") ) {
			retVal = proposeMgr.proposeWriteB2CPay(request, box);
		}
		else if ( v_proposetype.equals("5") ) {
			retVal = proposeMgr.proposeWriteGLMP(request, box);
		}
		else if ( v_proposetype.equals("6") ) {
			retVal = proposeMgr.proposeWriteGOLD(request, box);
		}
		else if ( v_proposetype.equals("8") ) {
			retVal = proposeMgr.proposeWriteRefundAgreeUpdate(box);
			if ( _where.equals("B") ) {
				return forward("/front/Propose.do?cmd=proposeWriteForm");
			} else {
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
			Box boxSmsNotiInfo = proposeMgr.selectProposeSmsNotiInfo(box);
			String v_smsnotiyn = boxSmsNotiInfo.getString("SMSNOTIYN");
			String v_smsnotinumber = boxSmsNotiInfo.getString("SMSNOTINUMBER");
			v_smsnotinumber = v_smsnotinumber.replace(" ", "");
			String v_chkfinal = boxSmsNotiInfo.getString("CHKFINAL");
			if ( !v_chkfinal.equals("Y") && v_smsnotiyn.equals("Y") && !v_smsnotinumber.equals("") ) {
				if(!v_proposetype.equals("3")){		
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

	}
	
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
		
		String v_ppopup = box.getString("p_ppopup");
		box.put("p_ppopup",  v_ppopup  );
		
		String _where = box.getString("_where");
		if ( _where.equals("B") ) {	
		} else {
			box.put("p_comp", box.getString("s_comp"));
			box.put("p_gyear", box.getString("p_year"));
			box.put("p_userid", box.getString("s_userid"));
		}
		
		String v_proposetype = box.getStringDefault("p_proposetype", "1");
		String v_installment_seq = box.getString("p_installment_seq");
		
		
		String uploadPath	= "/propose/"+box.getString("subj")+"/"+box.getString("year")+"/"+box.getString("subjseq");
		int v_maxfilesize	= 10;
		
		UploadFiles files 	= FileUtil.upload(request, uploadPath, v_maxfilesize, false, "A", DateTimeUtil.getDateTime());
		RequestManager.getMultiBox(box, files.getMultipart());
		box.put("p_proposetype", v_proposetype);
		_where = box.getString("_where");
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
		
		retVal = proposeMgr.proposeUpdateGLMP(request, box);

	
		return alertPopupClose(request, "수정되었습니다", "");
	}

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
		if ( _where.equals("B") ) {
		} else {
			box.put("p_comp", box.getString("s_comp"));
			box.put("p_gyear", box.getString("p_year"));
			box.put("p_userid", box.getString("s_userid"));
		}
		box.put("p_trainingclass", "09");	
		box.put("p_proposetype", "7");

		MileageMgr mileageMgr = new MileageMgr();
		int v_mileage = mileageMgr.selectUserRestantPoint(box);
		box.put("p_mileage", v_mileage);

		ArrayList v_grouplist = (ArrayList)box.getList("p_grouplist");

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
		String v_iscart = box.getString("p_iscart");
		if(v_iscart.equals("Y")){
			CartMgr cartMgr = new CartMgr();
			int cartrst = cartMgr.checkPartSubjCartItem( request, box);
			if(cartrst == 0 ){
				String msg = "장바구니에 존재하지 않습니다.";

				return closePopupReload(request, msg, "","O");
			}
		}

		ProposeMgr proposeMgr = new ProposeMgr();
		Box boxProposeApplyInfo = proposeMgr.selectProposeSelApplyInfo(box);
		box.put("boxProposeApplyInfo", boxProposeApplyInfo);
		proposeMgr.doINISecureStart(request, box);

		return mapping.findForward("ProposeWriteForm7");
	}

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
		if ( _where.equals("B") ) {	
		} else {
			box.put("p_comp", box.getString("s_comp"));
			box.put("p_gyear", box.getString("p_year"));
			box.put("p_userid", box.getString("s_userid"));
		}
		box.put("p_trainingclass", "09");	

		ArrayList v_grouplist = (ArrayList)box.getList("p_grouplist");

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
			return alertAndAction(request, "", "/front/Propose.do?cmd=proposeWriteForm");
		} else {
			return alertPopupClose(request, "취소에 실패 하였습니다", "") ;
		}
	}

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
			return closePopupReload(request, "환불요청 되었습니다.", "", "", "");
		} else {
			return alertPopupClose(request, "환불요청을 실패하였습니다..", "");
		}
	}

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

	public ActionForward proposeCancelList (
			ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response,
			Box box )
	throws Exception {

		box.put("p_comp", box.getString("s_comp"));
		box.put("p_userid", box.getString("s_userid"));
		box.put("p_subjtype", "C");

		ApprovalMgr approvalMgr = new ApprovalMgr();
		DataSet data  = approvalMgr.selectCourseApprovalCancelList(box);
		box.put("proposeCancelList", data);
		return mapping.findForward("ProposeCancelList");
	}


	public ActionForward refundAccountWriteForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{

		String v_comp = box.getString("s_comp");
		String v_userid = box.getString("s_userid");
		box.put("p_comp", box.getString("s_comp"));
		box.put("p_userid", box.getString("s_userid"));

		MemberMgr memberMgr = new MemberMgr();
		box.put("userInfo", memberMgr.selectMemberDetailOne(v_userid));
		return mapping.findForward("RefundAccountWrite");

	}

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

	public ActionForward courseApprovalCancelList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{
		ApprovalMgr approvalMgr = new ApprovalMgr();
		DataSet data  = approvalMgr.selectCourseApprovalCancelList(box);
		box.put("CourseApprovalCancelList", data);

		return mapping.findForward("CourseApprovalCancelList");
	}

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
		Box proposeInfo = proposeMgr.getProposeDetail(param);
		if ( proposeInfo == null || proposeInfo.getMap() == null ) {
			return closePopupReload(request, "수강취소할 내역이 없습니다.", "", "");
		}
		if(proposeInfo.getString("ISONOFF").equals("OFF") && proposeInfo.getString("APPLYGUBUN").equals("IDP")) {
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

			String msg = "";
			if(cancelGubun.equals("D")) {
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

	public ActionForward courseApprovalCheifRejectWriteForm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception{

		return mapping.findForward("CourseApprovalCheifRejectWriteForm");
	}

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
		Box data = proposeMgr.getTradeGraduCheck(box);	
		
		if(data.getString("TRADESUBJSEQ").equals("")){
			retMsg = "N";
		}else{
			retMsg = "Y"+data.getString("TRADESUBJSEQ");
		}
		
		PrintWriter pw = null;
		pw = response.getWriter();
		pw.append(retMsg);
	}
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
		
		box.put("p_subj", "");  
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
	
	
	public ActionForward subjseqMadeCheck(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception {
		
		if ( box.getString("s_userid").equals("") ) {
			return alertPopupClose(request, "로그인을 먼저 해 주십시요", "");
		}
		
		String next = request.getParameter("next");
		if(StringUtil.isNull(next)) {
			next = request.getParameter("cmd");
		}
		
		SubjSeqMgr subjSeqMgr = new SubjSeqMgr();
		
		if( subjSeqMgr.checkSubjSeqAutoList(box)<1){
			return forward("/front/Propose.do?cmd=proposeWriteForm");
		}
			
			
		DataSet ck = null;
		ck = subjSeqMgr.subjseqMadeCheck(box);
		
		if (ck.next()==true) {
			System.out.println("기수있음");
			box.put("p_subj", ck.getString("SUBJ"));
			box.put("p_subjseq", ck.getString("SUBJSEQ"));
			box.put("p_year", ck.getString("YEAR"));
			box.put("p_gyear", ck.getString("YEAR"));
			box.put("p_grseq", ck.getString("GRSEQ"));
			box.put("p_grcode", ck.getString("GRCODE"));
			
			return proposeWriteForm(mapping, form, request, response, box);
		} else {			
			System.out.println("기수없음");
			return subjseqAutoMake(mapping, form, request, response, box);
		}
		
	}
	
	
	public ActionForward subjseqAutoMake(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response, Box box) throws Exception {
		
		SubjSeqMgr subjSeqMgr = new SubjSeqMgr();
		SubjectMgr subjectMgr = new SubjectMgr(); 
				
		String p_grcode="N000002";
		box.put("p_grcode", p_grcode);
		


		FormatDate date = new FormatDate();
		String todateis =  date.getDate("yyyyMMdd");		
		
		Calendar cal = Calendar.getInstance();
		
				
		String aaaa[] = {"일", "월", "화", "수", "목", "금", "토", "일"};
		
		int todayNumber = date.getDayOfWeekforNumber(todateis);
		if(todayNumber==0){todayNumber=7;}	
		int mon_today = 1-todayNumber;	
		String mon_date = date.getRelativeDate(todateis, mon_today);			
		String sun_date = date.getRelativeDate(mon_date, 6);	

		String p_subj = "";
		p_subj = box.getString("p_subj");
		DataSet ds =  subjectMgr.getSubject(p_subj);	
		
		
		String edudays = "";
		edudays = ds.getFirstObject().getString("EDUDAYS");
		
		String p_props="";	
		p_props = mon_date;
		box.put("p_props", p_props+"00");
		
		String p_prope="";	
		p_prope = sun_date;
		box.put("p_prope", p_prope+"23");
		
		String standard = subjSeqMgr.selectSubjseqAutoStandard(box);	
		int edu_startDate = 0;	
		if(standard.equals("0")){
			edu_startDate = -6;
		}else if(standard.equals("1")){			
			edu_startDate = 1;
		}
		
		String p_edustart="";
		p_edustart = date.getRelativeDate(sun_date, edu_startDate);
		box.put("p_edustart", p_edustart);
		
		String p_eduend="";
		p_eduend = date.getRelativeDate(sun_date, Integer.parseInt(edudays));
		box.put("p_eduend", p_eduend);
		
		
		String p_gyear=p_edustart.substring(0, 4);	
		box.put("p_gyear", p_gyear);
		
		String p_paylimit=p_prope;		
		box.put("p_paylimit", p_paylimit);
		
		String p_luserid=box.getString("s_userid");	
		box.put("p_luserid", p_luserid);
		box.put("p_userid", p_luserid);
		String p_grseq="";	
		p_grseq = subjSeqMgr.getGrSeqCode(box);
		box.put("p_grseq", p_grseq);
		
		
		
		String arrSulPaperNum[] = null;
		String arrSulPaperStart[] = null;
		String arrSulPaperEnd[] = null;
		SulmunMgr suMgr = new SulmunMgr();
		DataSet suldata = suMgr.selectSulmunSubj(box);
		if(suldata!=null){
			arrSulPaperNum = new String[suldata.getRow()];
			arrSulPaperStart = new String[suldata.getRow()];
			arrSulPaperEnd = new String[suldata.getRow()];
			for(int x=0; x < suldata.getRow(); x++){
				suldata.next();
				arrSulPaperNum[x] = suldata.getString("SULPAPERNUM");
				
				String sulpaperstartdate = suldata.getString("SULSTARTDATE");
				sulpaperstartdate = date.getRelativeDate(p_edustart, Integer.parseInt(sulpaperstartdate));
				String sulpaperenddate = suldata.getString("SULENDDATE");
				sulpaperenddate = date.getRelativeDate(p_eduend, Integer.parseInt(sulpaperenddate)*-1);
				arrSulPaperStart[x] =  sulpaperstartdate;
				arrSulPaperEnd[x] =  sulpaperenddate;
			}
			box.put("p_arrSulPaperNum", arrSulPaperNum);
			box.put("p_arrSulPaperStart", arrSulPaperStart);
			box.put("p_arrSulPaperEnd", arrSulPaperEnd);
		}
		
		
		
		
		String subj_num = box.get("p_subj");	
		
		int retVal = 0;
		retVal = subjSeqMgr.insertGrSeq2(box);
		
		box.put("p_subj", subj_num);		
		
		String p_subjseq = "";
		p_subjseq = subjSeqMgr.selectAutoSubjSeq(box);
		box.put("p_subjseq", p_subjseq);
		System.out.println("aaaaaa==>  "+ p_subjseq);

	    if(retVal > 0){
	    	box.put("p_year", box.getString("p_gyear"));
	    	return proposeWriteForm(mapping, form, request, response, box);
	    }
		else return alertPopupClose(request, "시스템 오류 입니다 기수 개설에 실패하였습니다", "");
		
	}
	
	
	
	
	
	
}
