/**
 * @(#)MainFaction
 *
 * Copyright 2009 신세계아이엔씨. All Rights Reserved.
 *
 * 메인페이지 Action 클래스.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2009. 02. 09.  bluedove       Initial Release
 ************************************************
 *
 * @author      bluedove
 * @version     1.0
 * @since       2009. 02. 09.
 */

package com.sinc.lms.main;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.sinc.common.CommonUtil;
import com.sinc.common.FormatDate;
import com.sinc.framework.data.Box;
import com.sinc.framework.data.DataSet;
import com.sinc.framework.struts.StrutsDispatchAction;
import com.sinc.framework.util.DateTimeUtil;
import com.sinc.framework.util.StringUtil;
import com.sinc.lms.bbs.BbsBoardMgr;
import com.sinc.lms.edumanagement.ManageScheduleMgr;
import com.sinc.lms.study.MyClassMgr;

/**
 * 모든 클래스에서 사용할 공통 코드를 관리하는 클래스
 */
/**
 * XDoclet definition:
 *
 * @struts:action path="/front/Main" validate="false" parameter="cmd" scope="request"
 * @struts:action-forward name="BtocMain1" path="/jsp/front/new_templateMainMaster.jsp?body=/jsp/front/common/btocmain/btocMain1.jsp"
 * @struts:action-forward name="BtocMain2" path="/jsp/front/offlineTemplateMaster.jsp?body=/jsp/front/common/btocmain/btocMain2.jsp"
 * @struts:action-forward name="BtocMain3" path="/jsp/front/eLearningMainTemplateMaster.jsp?body=/jsp/front/common/btocmain/btocMain3.jsp"
 * @struts:action-forward name="BtocMain4" path="/jsp/front/templateMainMaster.jsp?body=/jsp/front/common/btocmain/btocMain4.jsp"
 * @struts:action-forward name="BtocMain5" path="/jsp/front/templateMainMaster.jsp?body=/jsp/front/common/btocmain/btocMain5.jsp"
 * @struts:action-forward name="BtocMain6" path="/jsp/front/templateMainMaster.jsp?body=/jsp/front/common/btocmain/btocMain6.jsp"
 * @struts:action-forward name="BtocMain7" path="/jsp/front/templateMainMaster.jsp?body=/jsp/front/common/btocmain/btocMain7.jsp"
 * @struts:action-forward name="BtocMain8" path="/jsp/front/templateMainMaster.jsp?body=/jsp/front/common/btocmain/btocMain8.jsp"
 * @struts:action-forward name="BtocMain9" path="/jsp/front/templateMainMaster.jsp?body=/jsp/front/common/btocmain/btocMain9.jsp"
 * @struts:action-forward name="BtocMain10" path="/jsp/front/templateMainMaster.jsp?body=/jsp/front/common/btocmain/btocMain10.jsp"
 * @struts:action-forward name="BtocMain11" path="/jsp/front/templateMainMaster.jsp?body=/jsp/front/common/btocmain/btocMain11.jsp"
 * @struts:action-forward name="BtocMain632" path="/jsp/front/templateMainMaster.jsp?body=/jsp/front/common/btocmain/btocMain632.jsp"
 * @struts:action-forward name="BtocMain646" path="/jsp/front/templateMainMaster.jsp?body=/jsp/front/common/btocmain/btocMain646.jsp"
 * @struts:action-forward name="BtocMain477" path="/jsp/front/templateMainMaster.jsp?body=/jsp/front/common/btocmain/btocMain477.jsp"
 * @struts:action-forward name="BtocMain554" path="/jsp/front/templateMainMaster.jsp?body=/jsp/front/common/btocmain/btocMain554.jsp"
 * @struts:action-forward name="BtocMain521" path="/jsp/front/offlineTemplateMaster.jsp?body=/jsp/front/common/btocmain/btocMain521.jsp"
 * @struts:action-forward name="BtocMain504" path="/jsp/front/templateMainMaster.jsp?body=/jsp/front/common/btocmain/btocMain504.jsp"
 * @struts:action-forward name="BtobMain1" path="/jsp/front/common/btobMain1.jsp"
 * @struts:action-forward name="BtobMain2" path="/jsp/front/common/btobMain2.jsp"
 * @struts:action-forward name="BtobMain3" path="/jsp/front/common/btobMain3.jsp"
 * @struts:action-forward name="BtobMain8" path="/jsp/front/common/btobMain8.jsp"
 * @struts:action-forward name="BtobMain9" path="/jsp/front/common/btobMain9.jsp"
 * @struts:action-forward name="eduIntro" path="/jsp/front/common/eduintro/eduIntro.jsp"
 * @struts:action-forward name="eduIntro1" path="/jsp/front/common/eduintro/eduIntro1.jsp"
 * @struts:action-forward name="eduIntro2" path="/jsp/front/common/eduintro/eduIntro2.jsp"
 * @struts:action-forward name="eduIntro3" path="/jsp/front/common/eduintro/eduIntro3.jsp"
 * @struts:action-forward name="eduIntro4" path="/jsp/front/common/eduintro/eduIntro4.jsp"
 * @struts:action-forward name="eduIntro5"path="/jsp/front/common/eduintro/eduIntro5.jsp"
 * @struts:action-forward name="MainCalendar" path="/jsp/front/common/mainCalendar.jsp"
 * @struts:action-forward name="MainCalendar1" path="/jsp/front/common/mainCalendar1.jsp"
 * @struts:action-forward name="PopReturnInfo1" path="/jsp/front/common/homepage/popReturnInfo1.jsp"
 * @struts:action-forward name="PopReturnInfo2" path="/jsp/front/common/homepage/popReturnInfo2.jsp"
 * @struts:action-forward name="PopReturnInfo3" path="/jsp/front/common/homepage/popReturnInfo3.jsp"
 * @struts:action-forward name="MobileMain" path="/jsp/mobile/main.jsp"
 * @struts:action-forward name="PopOffCourseList" path="/jsp/front/common/propose/popOffCourseList.jsp"
 */
public class MainFaction extends StrutsDispatchAction {

	public ActionForward btocMain(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Box box)
			throws Exception {
		int v_system = box.getInt("p_system");
		if (v_system == 0)
			v_system = box.getInt("s_system");
		if (v_system == 0)
			v_system = 1;
		CommonUtil.setSessionValue("s_system", "" + v_system, request);
		// BtoC 서브 메인별 보여줄 데이터를 가져온다.
		box.put("s_system", v_system);
		MainMgr mainMgr = new MainMgr();

		// 세션에 회사정보(s_comp)가 없을 경우 10000으로 셋팅
		if ( box.getString("s_comp").equals("") ) {
			box.put("s_comp", "10000");
			CommonUtil.setSessionValue("s_comp", box.getString("s_comp"), request);
			box.put("p_comp", box.getString("s_comp"));
		}
		// request 파라미터 p_comp 가 없을 경우 s_comp 값 셋팅
		if ( box.getString("p_comp").equals("") ) {
			box.put("p_comp", box.getString("s_comp"));
		}

		switch (v_system) {
		case 1: {
			// 공지사항 리스트를 가져온다.
			box.put("toGetRowNum", "4"); //읽어 올 공지사항 개수
			box.put("p_boardid", "2"); // 전체공지사항
			box.put("p_boardnm", "전체공지사항");
			DataSet noticeList = mainMgr.selectMainNoticeList(box);
			box.put("NoticeList", noticeList);

			// 모집중인 과정 리스트를 가져온다.
			//DataSet subjTrainingVOs = mainMgr.selectSubjPropseMain2(box);
			//box.put("subjTrainingVOs", subjTrainingVOs);
			
			//자동개설을 사용하는 이러닝 과정 리스트를 가져온다
			DataSet subjSeqAutoVOs = mainMgr.selectSubjPropseMainAutoList(box);
			
			//ArrayList subjTraining01VOs = new ArrayList(); //집합과정 모집과정
			//ArrayList subjTraining02VOs = new ArrayList(); 
			//ArrayList subjTraining09VOs = new ArrayList(); //이러닝 모집과정
						
			//사용안하는것 같아서 주석
			//ArrayList subjTraining10VOs = new ArrayList(); //IT교육센터 모집과정
			
			//if ( subjTrainingVOs != null && subjTrainingVOs.getRow() > 0 ) {
			//	while ( subjTrainingVOs.next() ) {
					/*
					if ( subjTrainingVOs.getString("TRAININGCLASS").equals("01") ) {
						subjTraining01VOs.add(subjTrainingVOs.getCurMap());
					} else if ( subjTrainingVOs.getString("TRAININGCLASS").equals("02") ) {
						subjTraining02VOs.add(subjTrainingVOs.getCurMap());
					} else if ( subjTrainingVOs.getString("TRAININGCLASS").equals("09") ) {
						subjTraining09VOs.add(subjTrainingVOs.getCurMap());
					}
					*/

					// 집합과정
					/*if ( subjTrainingVOs.getString("TRAININGCLASS").equals("01") ) {	// 집합과정
						subjTraining01VOs.add(subjTrainingVOs.getCurMap());
					} 
					if ( subjTrainingVOs.getString("TRAININGCLASS").equals("09") ) {	// e러닝
						subjTraining09VOs.add(subjTrainingVOs.getCurMap());
					} */
					////사용안하는것 같아서 주석
					/*if ( subjTrainingVOs.getString("TRAININGCLASS").equals("10") ) {	// IT 교육과정
						subjTraining10VOs.add(subjTrainingVOs.getCurMap());
					}*/
			//	}
			//}
			
			//메인페이지에 보여줄 모집과정에  이러닝과정 자동개설되는 리스트를 추가한다
			/*if ( subjSeqAutoVOs != null && subjSeqAutoVOs.getRow() > 0 ) {
				while(subjSeqAutoVOs.next()){
					if ( subjSeqAutoVOs.getString("TRAININGCLASS").equals("09") ) {	// e러닝
						subjTraining09VOs.add(subjSeqAutoVOs.getCurMap());
					}
				}
			}*/
			
//			// 단기연수 과정 가져온다.
//			box.put("p_trainingclass", "01");
//			box.put("p_viewcnt", "4");
//			DataSet subjTraining01VOs = mainMgr.selectSubjPropseMain(box);
			//box.put("SubjTraining01VOs", subjTraining01VOs);
//
//			// 이러닝 과정 가져온다.
//			box.put("p_trainingclass", "09");
//			box.put("p_viewcnt", "4");
//			DataSet subjTraining09VOs = mainMgr.selectSubjPropseMain(box);
			//box.put("SubjTraining09VOs", subjTraining09VOs);
			
//			// 위탁연수
//			box.put("p_trainingclass", "02");
//			box.put("p_viewcnt", "4");
//			DataSet subjTraining02VOs = mainMgr.selectSubjPropseMain(box);
//			box.put("SubjTraining02VOs", subjTraining02VOs);
			
			//사용안하는것 같아서 주석
			// IT 교육 과정
			//box.put("SubjTraining10VOs", subjTraining10VOs);
			
			
			// 단기연수 신규 모집과정 리스트 16개를 가져온다.(메인페이지 모집과정(단기모집)의 Thumbnail 이미지와 함께 보여지는 과정 리스트)
			box.put("p_trainingclass", "01");
			box.put("p_viewcnt", "16");
			DataSet offLineSubjectNewList = mainMgr.selectSubjPropseMain(box);
			box.put("offLineSubjectNewList", offLineSubjectNewList);
			
			// 이러닝 신규 모집과정 리스트 16개를 가져온다.(메인페이지 모집과정(E-Learning)의 Thumbnail 이미지와 함께 보여지는 과정 리스트)
			box.put("p_trainingclass", "09");
			box.put("p_viewcnt", "16");
			DataSet eLearningSubjectNewList = mainMgr.selectSubjPropseMain(box);
			//System.out.println(eLearningSubjectNewList.getRow()+">>>>>>>>>>>");
			
			ArrayList AutoVOs = new ArrayList();
			//모집과정이 16개보다 작다면 자동개설리스트에 있는 과정을 넣어준다
			if(eLearningSubjectNewList.getRow()<16){
				while(eLearningSubjectNewList.next()){					
						AutoVOs.add(eLearningSubjectNewList.getCurMap());						
				}
				
				
				//자동개설과정 날짜계산
				FormatDate date = new FormatDate();
				String standard = "";
				String edudays = "";
				int edu_startDate = 0; //수강신청일 종료일기준 언제 교육시작인지(일수)
				String todateis =  date.getDate("yyyyMMdd");
				int todayNumber = date.getDayOfWeekforNumber(todateis);
				if(todayNumber==0){todayNumber=7;}	//0:일요일 => 일요일일경우 7로 변경
				int mon_today = 1-todayNumber;	//오늘과 월요일의 간격
				String mon_date = date.getRelativeDate(todateis, mon_today);	//월요일의 날짜 YYYYMMDD		
				String sun_date = date.getRelativeDate(mon_date, 6);
				
				boolean check = false;
				while(subjSeqAutoVOs.next()){
					check=false;
					eLearningSubjectNewList.first();
					while(eLearningSubjectNewList.next()){	//이미 모집과정에 추가되어있는 항목인지 체크
						if(subjSeqAutoVOs.getString("SUBJ").equals(eLearningSubjectNewList.getString("SUBJ"))){
							check=true;
						}
					}					
					if ( subjSeqAutoVOs.getString("TRAININGCLASS").equals("09") && check==false ) {
						standard = (String) subjSeqAutoVOs.getString("STANDARD");
						edudays = (String) subjSeqAutoVOs.getString("EDUDAYS");
						
						if(standard.equals("0")){
							edu_startDate = -6;
						}else if(standard.equals("1")){			
							edu_startDate = 1;
						}
						
						subjSeqAutoVOs.getCurMap().put("EDUSTART", date.getRelativeDate(sun_date, edu_startDate));
						subjSeqAutoVOs.getCurMap().put("EDUEND", date.getRelativeDate(sun_date, Integer.parseInt(edudays)));
						
						//System.out.println(standard+"/"+edudays);
						AutoVOs.add(subjSeqAutoVOs.getCurMap());
					}
				}
				eLearningSubjectNewList.setDataSet(AutoVOs);
			}
			box.put("eLearningSubjectNewList", eLearningSubjectNewList);

			// 팝업 공지사항 리스트를 가져온다.
			if (box.getString("s_userid").equals("")) {
				box.put("p_islogin", "N");
			} else {
				box.put("p_islogin", "Y");
			}
			box.put("p_isfirst", "Y");
			box.put("p_subexposeposition", "1");
			box.put("p_hgrcode", box.getString("s_hgrcode"));
//			box.put("p_comp", box.getString("s_comp"));
			DataSet dsPopNotiList = mainMgr.selectB2bMainPopNoticeList(box);
			box.put("dsPopNotiList", dsPopNotiList);

			// main flash
			HttpSession session = request.getSession();
			String v_mainflash = box.getStringDefault("s_mainrandomflash", "1");
			v_mainflash = v_mainflash.equals("1") ? "0" : "1";
			session.setAttribute("s_mainrandomflash", v_mainflash);
			box.put("s_mainrandomflash", session
					.getAttribute("s_mainrandomflash"));
		}
			break;
		case 2: {
			// 공지사항 리스트를 가져온다.
			box.put("toGetRowNum", "5");
			box.put("p_boardid", "35"); // 집체교육 공지사항
			DataSet noticeList = mainMgr.selectMainNoticeList(box);
			box.put("NoticeList", noticeList);

			// 단기연수 모집중인 과정을 가져온다.
			box.put("p_trainingclass", "01");
			// box.put("p_viewcnt", "2");
			DataSet subjTraining01VOs = mainMgr.selectSubjPropseMain(box);
			box.put("SubjTraining01VOs", subjTraining01VOs);

			// 팝업 공지사항 리스트를 가져온다.
			if (box.getString("s_userid").equals("")) {
				box.put("p_islogin", "N");
			} else {
				box.put("p_islogin", "Y");
			}
			box.put("p_subexposeposition", "2");
			box.put("p_hgrcode", box.getString("s_hgrcode"));
//			box.put("p_comp", box.getString("s_comp"));
			DataSet dsPopNotiList = mainMgr.selectB2bMainPopNoticeList(box);
			box.put("dsPopNotiList", dsPopNotiList);
			
			//메뉴에 사용되는  e_menuid 세션값 삭제
			HttpSession session = request.getSession();
			session.setAttribute("e_menuid", "");

		}
			break;
		case 3: {
			// 공지사항 리스트를 가져온다.
			box.put("toGetRowNum", "5");/**수정_2013.12.09_공지사항 5행*/
			box.put("p_boardid", "24"); // e러닝 공지사항
			DataSet noticeList = mainMgr.selectMainNoticeList(box);
			box.put("NoticeList", noticeList);

			// 팝업 공지사항 리스트를 가져온다.
			if (box.getString("s_userid").equals("")) {
				box.put("p_islogin", "N");
			} else {
				box.put("p_islogin", "Y");
			}
			box.put("p_subexposeposition", "3");
			box.put("p_hgrcode", box.getString("s_hgrcode"));
//			box.put("p_comp", box.getString("s_comp"));
			DataSet dsPopNotiList = mainMgr.selectB2bMainPopNoticeList(box);
			box.put("dsPopNotiList", dsPopNotiList);

			// 이러닝 과정 가져온다.
			box.put("p_trainingclass", "09");
			//box.put("p_viewcnt", "6");
			// DataSet subjTraining09VOs = mainMgr.selectSubjPropseMain(box);
			// box.put("SubjTraining09VOs", subjTraining09VOs);

			// 신규과정을 가져온다.
			/*box.put("p_issubjnew", "Y");
			box.put("p_issubjfavor", "");
			box.put("p_issubjrecom", "");*/
			//DataSet newDs = mainMgr.selectSubjMain_new(box);
			//box.put("newSubjVOs", newDs);

			// 추천과정을 가져온다.
			/*box.put("p_issubjnew", "");
			box.put("p_issubjfavor", "");
			box.put("p_issubjrecom", "Y");//
*/			//DataSet recomDs = mainMgr.selectSubjMain_recom(box);
			//box.put("recomSubjVOs", recomDs);

			// 인기과정을 가져온다
			/*box.put("p_issubjnew", "");
			box.put("p_issubjfavor", "Y");
			box.put("p_issubjrecom", "");//
*/			//DataSet favorDs = mainMgr.selectSubjMain_favor(box);
			//box.put("favorSubjVOs", favorDs);

		}
			break;
		case 4: {
			// 공지사항 리스트를 가져온다.
			box.put("toGetRowNum", "5");
			box.put("p_boardid", "12"); // 무역마스터 공지사항
			DataSet noticeList = mainMgr.selectMainNoticeList(box);
			box.put("NoticeList", noticeList);

			// 기수별 커뮤니티 리스트를 가져온다.
			box.put("toGetRowNum", "3");
			box.put("p_boardid", "81"); // 무역마스터 기수별 커뮤니티
			DataSet galleryList = mainMgr.selectMainGalleryList(box);
			box.put("GalleryList", galleryList);

			// 팝업 공지사항 리스트를 가져온다.
			if (box.getString("s_userid").equals("")) {
				box.put("p_islogin", "N");
			} else {
				box.put("p_islogin", "Y");
			}
			box.put("p_subexposeposition", "4");
			box.put("p_hgrcode", box.getString("s_hgrcode"));
//			box.put("p_comp", box.getString("s_comp"));
			DataSet dsPopNotiList = mainMgr.selectB2bMainPopNoticeList(box);
			box.put("dsPopNotiList", dsPopNotiList);
		}
			break;
		case 5: {
			// 공지사항 리스트를 가져온다.
			box.put("toGetRowNum", "5");
			box.put("p_boardid", "13"); // IT마스터 공지사항
			DataSet noticeList = mainMgr.selectMainNoticeList(box);
			box.put("NoticeList", noticeList);

			// IT마스터 모집중인 과정을 가져온다.
			box.put("p_trainingclass", "04");
			// box.put("p_viewcnt", "2");
			DataSet subjTraining04VOs = mainMgr.selectSubjPropseMain(box);
			int subjTraining04VOsCnt = subjTraining04VOs.getRow();
			box.put("subjTraining04VOsCnt", subjTraining04VOsCnt);

			// 팝업 공지사항 리스트를 가져온다.
			if (box.getString("s_userid").equals("")) {
				box.put("p_islogin", "N");
			} else {
				box.put("p_islogin", "Y");
			}
			box.put("p_subexposeposition", "5");
			box.put("p_hgrcode", box.getString("s_hgrcode"));
//			box.put("p_comp", box.getString("s_comp"));
			DataSet dsPopNotiList = mainMgr.selectB2bMainPopNoticeList(box);
			box.put("dsPopNotiList", dsPopNotiList);
		}
			break;
		case 6: {
			// 공지사항 리스트를 가져온다.
			box.put("toGetRowNum", "5");
			box.put("p_boardid", "14"); // GTEP 공지사항
			DataSet noticeList = mainMgr.selectMainNoticeList(box);
			box.put("NoticeList", noticeList);

			// 과정사진 리스트를 가져온다.
			box.put("toGetRowNum", "2");
			box.put("p_boardid", "29"); // GTEP 과정사진
			DataSet galleryList = mainMgr.selectMainGalleryList(box);
			box.put("GalleryList", galleryList);

			// 팝업 공지사항 리스트를 가져온다.
			if (box.getString("s_userid").equals("")) {
				box.put("p_islogin", "N");
			} else {
				box.put("p_islogin", "Y");
			}
			box.put("p_subexposeposition", "6");
			box.put("p_hgrcode", box.getString("s_hgrcode"));
//			box.put("p_comp", box.getString("s_comp"));
			DataSet dsPopNotiList = mainMgr.selectB2bMainPopNoticeList(box);
			box.put("dsPopNotiList", dsPopNotiList);
		}
			break;
		case 7: {
			// 공지사항 리스트를 가져온다.
			box.put("toGetRowNum", "5");
			box.put("p_boardid", "15"); // GTEP 공지사항
			DataSet noticeList = mainMgr.selectMainNoticeList(box);
			box.put("NoticeList", noticeList);

		}
			break;
		case 8: {
			// 공지사항 리스트를 가져온다.
			box.put("toGetRowNum", "5");
			box.put("p_boardid", "16"); // 글로벌인턴쉽 공지사항
			DataSet noticeList = mainMgr.selectMainNoticeList(box);
			box.put("NoticeList", noticeList);

			// 글로벌인턴해외통신원 Top1 가져온다.
			box.put("toGetRowNum", "1");
			box.put("p_boardid", "30"); // 글로벌인턴해외통신원 Top1
			DataSet globalStringerTop1 = mainMgr.selectMainGalleryList(box);
			box.put("GlobalStringerTop1", globalStringerTop1);

			// 인턴십 체험기를 가져온다.
			box.put("toGetRowNum", "2");
			box.put("p_boardid", "31"); // 글로벌인턴해외통신원 Top1
			DataSet globalInternship = mainMgr.selectMainBoardList(box);
			box.put("GlobalInternship", globalInternship);

			// 팝업 공지사항 리스트를 가져온다.
			if (box.getString("s_userid").equals("")) {
				box.put("p_islogin", "N");
			} else {
				box.put("p_islogin", "Y");
			}
			box.put("p_subexposeposition", "8");
			box.put("p_hgrcode", box.getString("s_hgrcode"));
//			box.put("p_comp", box.getString("s_comp"));
			DataSet dsPopNotiList = mainMgr.selectB2bMainPopNoticeList(box);
			box.put("dsPopNotiList", dsPopNotiList);

		}
			break;
		case 9: {
			// 공지사항 리스트를 가져온다.
			box.put("toGetRowNum", "5");
			box.put("p_boardid", "7"); // 자격시험 공지사항
			DataSet noticeList = mainMgr.selectMainNoticeList(box);
			box.put("NoticeList", noticeList);

			// 팝업 공지사항 리스트를 가져온다.
			if (box.getString("s_userid").equals("")) {
				box.put("p_islogin", "N");
			} else {
				box.put("p_islogin", "Y");
			}
			box.put("p_subexposeposition", "9");
			box.put("p_hgrcode", box.getString("s_hgrcode"));
//			box.put("p_comp", box.getString("s_comp"));
			DataSet dsPopNotiList = mainMgr.selectB2bMainPopNoticeList(box);
			box.put("dsPopNotiList", dsPopNotiList);
			
			// 국제무역사 대비 모집중인 과정을 가져온다
			box.put("p_trainingclass", "01");
			box.put("p_upperclass", "1000");
			box.put("p_middleclass", "1001");
			box.put("p_lowerclass", "1107");
			box.put("information", mainMgr.selectSubjPropseMain(box));
			
			// 외환관리사 대비 모집중인 과정을 가져온다
			box.put("p_trainingclass", "05");
			box.put("p_upperclass", "1000");
			box.put("p_middleclass", "1002");
			box.put("p_lowerclass", "1203");
			box.put("foreignexchange", mainMgr.selectSubjPropseMain(box));
		}
			break;
		case 10: {
			// 공지사항 리스트를 가져온다.
			box.put("toGetRowNum", "5");
			box.put("p_boardid", "40"); // IT교육센터 공지사항
			DataSet noticeList = mainMgr.selectMainNoticeList(box);
			box.put("NoticeList", noticeList);

			// IT교육센터 모집중인 과정 가져온다.
			box.put("p_trainingclass", "10");
			box.put("p_viewcnt", "");
			DataSet recruitTraining04VOs = mainMgr.selectSubjPropseMain(box);
			box.put("RecruitTraining04VOs", recruitTraining04VOs);

			// 팝업 공지사항 리스트를 가져온다.
			if (box.getString("s_userid").equals("")) {
				box.put("p_islogin", "N");
			} else {
				box.put("p_islogin", "Y");
			}
			box.put("p_subexposeposition", "10");
			box.put("p_hgrcode", box.getString("s_hgrcode"));
//			box.put("p_comp", box.getString("s_comp"));
			DataSet dsPopNotiList = mainMgr.selectB2bMainPopNoticeList(box);
			box.put("dsPopNotiList", dsPopNotiList);
			
			/*1년간 시험일정 가져오기*/
			ManageScheduleMgr msmgr = new ManageScheduleMgr();
			// 시험코드, 시험명을 가져온다.
			DataSet ictYearScDs = msmgr.selectIctYearSchedule2(box);
			box.put("ictYearScDs", ictYearScDs);
			/*/1년간 시험일정 가져오기*/
			
			String next = "";
			next = box.getString("next");
			if(StringUtil.isNull(next)) {
				next = box.getString("cmd");
			}
			
		}
			break;
		case 11: {
			if (box.getString("s_userid").equals("")) {
				box.put("p_islogin", "N");
			} else {
				box.put("p_islogin", "Y");
			}
			box.put("p_subexposeposition", "11");
			box.put("p_hgrcode", box.getString("s_hgrcode"));
//			box.put("p_comp", box.getString("s_comp"));
			DataSet dsPopNotiList = mainMgr.selectB2bMainPopNoticeList(box);
			box.put("dsPopNotiList", dsPopNotiList);
		}
			break;
		case 632: {
			// 공지사항 리스트를 가져온다.
			box.put("toGetRowNum", "5");
			box.put("p_boardid", "140"); // 잔자무역물류 마스터 공지사항
			DataSet noticeList = mainMgr.selectMainNoticeList(box);
			box.put("NoticeList", noticeList);

			// 기수별 커뮤니티 리스트를 가져온다.
			box.put("toGetRowNum", "3");
			box.put("p_boardid", "142"); // 전자무역물류마스터 기수별 커뮤니티
			DataSet galleryList = mainMgr.selectMainGalleryList(box);
			box.put("GalleryList", galleryList);

			// 팝업 공지사항 리스트를 가져온다.
			if (box.getString("s_userid").equals("")) {
				box.put("p_islogin", "N");
			} else {
				box.put("p_islogin", "Y");
			}
			box.put("p_subexposeposition", "632");
			box.put("p_hgrcode", box.getString("s_hgrcode"));
//			box.put("p_comp", box.getString("s_comp"));
			DataSet dsPopNotiList = mainMgr.selectB2bMainPopNoticeList(box);
			box.put("dsPopNotiList", dsPopNotiList);
		}
			break;
		case 646: {
			// 공지사항 리스트를 가져온다.
			box.put("toGetRowNum", "5");
			box.put("p_boardid", "144"); // 자동차부품수출전문가  공지사항
			DataSet noticeList = mainMgr.selectMainNoticeList(box);
			box.put("NoticeList", noticeList);

			// 기수별 커뮤니티 리스트를 가져온다.
			box.put("toGetRowNum", "3");
			box.put("p_boardid", "146"); // 자동차부품수출전문가 기수별 커뮤니티
			DataSet galleryList = mainMgr.selectMainGalleryList(box);
			box.put("GalleryList", galleryList);

			// 팝업 공지사항 리스트를 가져온다.
			if (box.getString("s_userid").equals("")) {
				box.put("p_islogin", "N");
			} else {
				box.put("p_islogin", "Y");
			}
			box.put("p_subexposeposition", "646");
			box.put("p_hgrcode", box.getString("s_hgrcode"));
//			box.put("p_comp", box.getString("s_comp"));
			DataSet dsPopNotiList = mainMgr.selectB2bMainPopNoticeList(box);
			box.put("dsPopNotiList", dsPopNotiList);
		}
			break;
		case 477: {
			// 공지사항 리스트를 가져온다.
			box.put("toGetRowNum", "5");
			box.put("p_boardid", "120"); // 섬유수출전문가과정 공지사항
			DataSet noticeList = mainMgr.selectMainNoticeList(box);
			box.put("NoticeList", noticeList);

			// 기수별 커뮤니티 리스트를 가져온다.
			box.put("toGetRowNum", "3");
			box.put("p_boardid", "121"); // 무역마스터 기수별 커뮤니티
			DataSet galleryList = mainMgr.selectMainBoardList(box);
			box.put("GalleryList", galleryList);

			// 팝업 공지사항 리스트를 가져온다.
			if (box.getString("s_userid").equals("")) {
				box.put("p_islogin", "N");
			} else {
				box.put("p_islogin", "Y");
			}
			box.put("p_subexposeposition", "477");
			box.put("p_hgrcode", box.getString("s_hgrcode"));
//			box.put("p_comp", box.getString("s_comp"));
			DataSet dsPopNotiList = mainMgr.selectB2bMainPopNoticeList(box);
			box.put("dsPopNotiList", dsPopNotiList);
		}
			break;
		case 554: {	//섬유수출전문가 소재과정
			// 공지사항 리스트를 가져온다.
			box.put("toGetRowNum", "5");
			box.put("p_boardid", "132"); // 섬유수출전문가과정 공지사항
			DataSet noticeList = mainMgr.selectMainNoticeList(box);
			box.put("NoticeList", noticeList);
			
			// 기수별 커뮤니티 리스트를 가져온다.
			box.put("toGetRowNum", "3");
			box.put("p_boardid", "137"); // 무역마스터 기수별 커뮤니티
			DataSet galleryList = mainMgr.selectMainBoardList(box);
			box.put("GalleryList", galleryList);
			
			// 팝업 공지사항 리스트를 가져온다.
			if (box.getString("s_userid").equals("")) {
				box.put("p_islogin", "N");
			} else {
				box.put("p_islogin", "Y");
			}
			box.put("p_subexposeposition", "554");
			box.put("p_hgrcode", box.getString("s_hgrcode"));
//			box.put("p_comp", box.getString("s_comp"));
			DataSet dsPopNotiList = mainMgr.selectB2bMainPopNoticeList(box);
			box.put("dsPopNotiList", dsPopNotiList);
		}
		break;
		case 504: {
			// 공지사항 리스트를 가져온다.
			box.put("toGetRowNum", "5");
			box.put("p_boardid", "126"); // 중국마케팅전문가 공지사항
			DataSet noticeList = mainMgr.selectMainNoticeList(box);
			box.put("NoticeList", noticeList);

			// 기수별 커뮤니티 리스트를 가져온다.
			box.put("toGetRowNum", "3");
			box.put("p_boardid", "127"); // 기수별 커뮤니티
			DataSet galleryList = mainMgr.selectMainBoardList(box);
			box.put("GalleryList", galleryList);

			// 팝업 공지사항 리스트를 가져온다.
			if (box.getString("s_userid").equals("")) {
				box.put("p_islogin", "N");
			} else {
				box.put("p_islogin", "Y");
			}
			box.put("p_subexposeposition", "504");
			box.put("p_hgrcode", box.getString("s_hgrcode"));
//			box.put("p_comp", box.getString("s_comp"));
			DataSet dsPopNotiList = mainMgr.selectB2bMainPopNoticeList(box);
			box.put("dsPopNotiList", dsPopNotiList);
		}
		case 521: { //지부연수
			//메인페이지 없기때문에 세션값지정(대구경북 오프라인과정것으로 지정)
			HttpSession session = request.getSession();
			session.setAttribute("e_menuid", "523");		
			
		}
			break;
		default:
			break;
		}

		return mapping.findForward("BtocMain" + v_system);
	}

	public ActionForward btobMain(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Box box)
			throws Exception {
		String v_hgrcode = box.getString("s_hgrcode");
		String s_userid = box.getString("s_userid");
		box.put("s_hgrcode", box.getStringDefault("s_hgrcode", "1"));
		String v_tmpl = box.getStringDefault("s_tmpl", "1");
		String v_hometype = box.getStringDefault("p_hometype", "on");
		MainMgr mainMgr = new MainMgr();
		box.put("p_comp", box.getString("s_comp"));

		// 팝업 공지사항 리스트를 가져온다.
		box.put("p_isfirst", "Y");
		box.put("p_islogin", "Y");
		box.put("p_hgrcode", box.getString("s_hgrcode"));
		box.put("p_comp", box.getString("s_comp"));
		DataSet dsPopNotiList = mainMgr.selectB2bMainPopNoticeList(box);
		box.put("dsPopNotiList", dsPopNotiList);

		// 수강 기간
		Box proposeTerm = mainMgr
				.selectCompProposeTerm(box.getString("s_comp"));
		box.put("ProposeTerm", proposeTerm);

		// // 개인 수강정보를 가져온다.
		DataSet userSubjCount = mainMgr.selectUserSubjCount(box
				.getString("s_userid"));
		box.put("UserSubjCount", userSubjCount);
		//
		// // 공지사항 리스트를 가져온다.
		box.put("toGetRowNum", "5");
		DataSet noticeList = mainMgr.selectMainNoticeList(box);
		box.put("NoticeList", noticeList);
		// // FAQ 리스트를 가져온다.
		DataSet faqList = mainMgr.selectMainFaqList(box);
		box.put("FaqList", faqList);

		// // 과정 Q&A 리스트를 가져온다.
		if (box.getString("s_hgrcode").equals("1")) {
			box.put("toGetRowNum", "4");
		} else if (box.getString("s_hgrcode").equals("2")) {
			box.put("toGetRowNum", "3");
		} else if (box.getString("s_hgrcode").equals("4")) {
			box.put("toGetRowNum", "3");
		}
		DataSet myStudyQnaList = mainMgr.selectMainMyStudyQnaList(box);
		box.put("MyStudyQnaList", myStudyQnaList);

		// // 과정게시판 리스트를 가져온다.
		DataSet myStudyFreeBoardList = mainMgr
				.selectMainMyStudyFreeBoardList(box);
		box.put("MyStudyFreeBoardList", myStudyFreeBoardList);
		//
		// //컨텐츠 스크랩 리스트를 가져온다.
		box.put("p_sortorder", box.getStringDefault("p_sortorder",
				"INDATE DESC"));
		box.put("toGetRowNum", "5");
		DataSet myScrapList = mainMgr.selectMyScrapList(box);
		box.put("MyScrapList", myScrapList);
		//
		// // 사용자 학습중인 과정 리스트를 가져온다.
		DataSet userSubjList = mainMgr.selectUserSubjList(box);
		if (userSubjList != null && userSubjList.getRow() > 0) {
			userSubjList.next();
			HashMap userMap = new HashMap();
			userMap.put("p_subj", userSubjList.getString("SUBJ"));
			userMap.put("p_year", userSubjList.getString("YEAR"));
			userMap.put("p_subjseq", userSubjList.getString("SUBJSEQ"));
			userMap.put("p_userid", box.getString("s_userid"));
			Box userSubj = mainMgr.selectUserSubjProgress(userMap);
			box.put("UserSubjProgress", userSubj);
			userSubjList.setPos();

			//과정 진도율 표시를 위한 데이터
			userMap.put("p_course", userMap.get("p_subj"));
			userMap.put("p_courseyear", userMap.get("p_year"));
			userMap.put("p_coursesubjseq", userMap.get("p_subjseq"));
			userMap.put("s_userid", userMap.get("p_userid"));
			MyClassMgr myClassMgr = new MyClassMgr();
			Box temp = new Box(userMap);
			box.put("totalItem", myClassMgr.selectTotalItem(temp));

		} else
			box.put("UserSubjProgress", new Box("UserSubj"));
		box.put("UserSubjList", userSubjList);

		box.put("p_comp", box.getString("s_comp"));
		
		if ("1".equals(v_tmpl)) {
			box.put("p_issubjnew", "Y");
			box.put("p_issubjfavor", "");
			box.put("p_issubjrecom", "");
			box.put("p_viewcnt", "1");
			// // 신규과정을 가져온다.
			DataSet newDs = mainMgr.selectSubjMain(box);

			box.put("p_issubjnew", "");
			box.put("p_issubjfavor", "");
			box.put("p_issubjrecom", "Y");
			// // 추천 가져온다.
			DataSet recomDs = mainMgr.selectSubjMain(box);
			//
			//
			box.put("p_issubjnew", "");
			box.put("p_issubjfavor", "Y");
			box.put("p_issubjrecom", "");
			// // 히트과정
			DataSet favorDs = mainMgr.selectSubjMain(box);
			//
			box.put("newSubjVOs", newDs);
			box.put("recomSubjVOs", recomDs);
			box.put("favorSubjVOs", favorDs);

			box.put("p_isonoff", "ON");
			box.put("p_upperclass", "1000");
			box.put("p_issubjfavor", "Y");
			box.put("p_viewcnt", "5");
			// 경영일반가져온다.
			DataSet bestSubjVOs = mainMgr.selectSubjMain(box);

			// 직무
			box.put("p_upperclass", "2000");
			DataSet bestBusVOs = mainMgr.selectSubjMain(box);

			// 금융
			box.put("p_upperclass", "3000");
			DataSet bestLeaderSubjVOs = mainMgr.selectSubjMain(box);

			// 자격증
			box.put("p_upperclass", "4000");
			DataSet bestLicenseSubjVOs = mainMgr.selectSubjMain(box);

			// 정보기술
			box.put("p_upperclass", "5000");
			DataSet bestInfoSubjVOs = mainMgr.selectSubjMain(box);

			// 외국어
			box.put("p_upperclass", "6000");
			DataSet bestLangSubjVOs = mainMgr.selectSubjMain(box);

			box.put("p_viewcnt", "5");
			DataSet recomSubjWord = mainMgr.selectRecomSubjSrch(box);
			box.put("recomSubjWord", recomSubjWord);

			box.put("bestSubjVOs", bestSubjVOs);
			box.put("bestBusVOs", bestBusVOs);
			box.put("bestLeaderSubjVOs", bestLeaderSubjVOs);
			box.put("bestLicenseSubjVOs", bestLicenseSubjVOs);
			box.put("bestInfoSubjVOs", bestInfoSubjVOs);
			box.put("bestLangSubjVOs", bestLangSubjVOs);
			//
			// DataSet mainMenuList = null;
			// if(!box.getString("s_userid").equals("")){
			// MyClassMgr myclassMgr = new MyClassMgr();
			// mainMenuList = myclassMgr.selectMainMenuUserList(box);
			// }
			// box.put("MainMenu", mainMenuList);
			//
			// Box sulmunPopup = mainMgr.selectMainSulmunPopup(box);
			// box.put("SulmunPopup", sulmunPopup);
		} else if ("2".equals(v_tmpl)) {
			// box.put("p_issubjnew", "Y");
			box.put("p_issubjfavor", "");
			box.put("p_issubjrecom", "");
			box.put("p_viewcnt", "1");
			// 신규과정을 가져온다.
			DataSet newDs = mainMgr.selectSubjMain(box);

			box.put("p_issubjnew", "");
			box.put("p_issubjfavor", "");
			box.put("p_issubjrecom", "Y");
			// 추천 가져온다.
			DataSet recomDs = mainMgr.selectSubjMain(box);

			box.put("p_issubjnew", "");
			box.put("p_issubjfavor", "Y");
			box.put("p_issubjrecom", "");
			// 히트과정
			DataSet favorDs = mainMgr.selectSubjMain(box);

			box.put("p_isonoff", "ON");
			box.put("p_upperclass", "1000");
			box.put("p_issubjfavor", "Y");
			box.put("p_viewcnt", "5");

			// 경영일반가져온다.
			DataSet bestSubjVOs = mainMgr.selectSubjMain(box);

			box.put("p_isonoff", "ON");
			box.put("p_upperclass", "2000");
			box.put("p_issubjfavor", "Y");
			box.put("p_viewcnt", "5");

			// 외국어를 가져온다.
			DataSet bestLangSubjVOs = mainMgr.selectSubjMain(box);

			box.put("newSubjVOs", newDs);
			box.put("recomSubjVOs", recomDs);
			box.put("favorSubjVOs", favorDs);
			box.put("bestSubjVOs", bestSubjVOs);
			box.put("bestLangSubjVOs", bestLangSubjVOs);
			//
			// // 개인 메인 메뉴항목을 가져온다.
			// DataSet mainMenuList = null;
			// if(!box.getString("s_userid").equals("")){
			// MyClassMgr myclassMgr = new MyClassMgr();
			// mainMenuList = myclassMgr.selectMainMenuUserList(box);
			// }
			// box.put("MainMenu", mainMenuList);
			//
			// Box sulmunPopup = mainMgr.selectMainSulmunPopup(box);
			// box.put("SulmunPopup", sulmunPopup);
		}
		return mapping.findForward("BtobMain" + v_tmpl);
	}

	public ActionForward mobileMain(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Box box)
			throws Exception {

		// 공지사항을 가지고 온다.(시작)
		BbsBoardMgr bbsBoardMgr = new BbsBoardMgr();
		box.put("p_gadmin", box.getStringDefault("s_gadmin", "G1"));
		box.put("p_cnt", "1");
		box.put("p_boardid", "2");
		box.put("p_boardnm", "전체공지사항");
		Box boxCBoardContents = bbsBoardMgr.selectMobileCboardContents(box);
		box.put("boxCBoardContents", boxCBoardContents);
		// 공지사항을 가지고 온다.(끝)

		return mapping.findForward("MobileMain");
	}

	public ActionForward subSample(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Box box)
			throws Exception {

		return mapping.findForward("SubSample");
	}

	public ActionForward eduIntro(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Box box)
			throws Exception {
		String next = "";
		next = box.getString("next");
		if (StringUtil.isNull(next)) {
			next = box.getString("cmd");
		}
		return mapping.findForward(next);
	}

	/**
	 * 메인 화면에서 달력을 가져온다.
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward mainCalendar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Box box)
			throws Exception {

		MainMgr mainMgr = new MainMgr();
		DataSet ds = mainMgr.selectMainCalendarSchedule(box);
		HashMap<String, Box> hmStudySchedule = new HashMap<String, Box>();
		if (ds != null) {
			while (ds.next()) {
				hmStudySchedule.put(ds.getString("DAY"), ds.getCurBox());
			}
		}
		box.put("hmSchedule", hmStudySchedule);

		String v_tmpl = box.getStringDefault("s_tmpl", "1");
		if (v_tmpl.equals("1")) {
			return mapping.findForward("MainCalendar1");
		} else {
			return mapping.findForward("MainCalendar");
		}

		// return mapping.findForward("MainCalendar");
	}

	/**
	 * 커리쿨럼의 과정을 검색해 준다.
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward searchSubj(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Box box)
			throws Exception {

		MainMgr mainMgr = new MainMgr();

		// 커리쿨럼에서 과정이 있는지를 검색한다.

		// 검색한 과정이 있을 시 과정검색 카운트를 올려준다
		mainMgr.insertSubjSrch(box.getString("p_subjsearchtxt"));
		// 검색 과정이 없다는 메시지를 띄워준다.

		return mapping.findForward("MainCalendar");
	}

	/**
	 * "기업 위탁교육" 안내 페이지로 이동한다.
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward popReturnInfo1(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Box box)
			throws Exception {

		return mapping.findForward("PopReturnInfo1");
	}

	/**
	 * "개인 수강지원" 안내 페이지로 이동한다.
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward popReturnInfo2(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Box box)
			throws Exception {

		return mapping.findForward("PopReturnInfo2");
	}

	/**
	 * "능력 개발 카드제" 안내 페이지로 이동한다.
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward popReturnInfo3(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Box box)
			throws Exception {

		return mapping.findForward("PopReturnInfo3");
	}

	/**
	 * 집합 모집과정으로 이동한다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ActionForward popOffCourse(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Box box)
			throws Exception {
		
		// 모집중인 집합과정 리스트를 가져온다.
		MainMgr mainMgr = new MainMgr();
		box.put("p_isOnOff", "OFF");
		//box.put("p_trainingclass", "01");
		box.put("ps_year", DateTimeUtil.getYear());
		
		// Sky
		DataSet subjTrainingList = mainMgr.selectOffCourseList(box);
		
					
		ArrayList subjTrainingVOs = new ArrayList();
		ArrayList subjTraining1VOs = new ArrayList();
		ArrayList subjTraining2VOs = new ArrayList();
		ArrayList subjTraining3VOs = new ArrayList();
					
		if ( subjTrainingList != null && subjTrainingList.getRow() > 0 ) {
			while ( subjTrainingList.next() ) {
				// 단기연수 과정
				if ( subjTrainingList.getString("TRAININGCLASS").equals("01") ) {
					subjTrainingVOs.add(subjTrainingList.getCurMap());
				}
					
				if ( subjTrainingList.getString("UPPERCLASS").equals("1000") ) {
					if ( subjTrainingList.getString("MIDDLECLASS").equals("1001") ) {			// 무역실무
						subjTraining1VOs.add(subjTrainingList.getCurMap());
					} else if ( subjTrainingList.getString("MIDDLECLASS").equals("1002") ) {		// 마케팅/외환금융
						subjTraining2VOs.add(subjTrainingList.getCurMap());
					} else if ( subjTrainingList.getString("MIDDLECLASS").equals("1003") ) {		// 비즈니스 외국어
						subjTraining3VOs.add(subjTrainingList.getCurMap());
					}
				}
			}
		}
					
		box.put("subjTrainingVOs", 	subjTrainingVOs);
		box.put("SubjTraining1VOs", subjTraining1VOs);
		box.put("SubjTraining2VOs", subjTraining2VOs);
		box.put("SubjTraining3VOs", subjTraining3VOs);			

		return mapping.findForward("PopOffCourseList");
	}
}
