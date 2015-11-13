/**
 * @(#)TbCateMgr
 *
 * Copyright 2006 mediopia. All Rights Reserved.
 *
 * T_LMS_DIC, T_LMS_DICGROUP 테이블 Mgr 클래스.
 *
 ************************************************
 * DATE         AUTHOR      DESCRIPTION
 * ----------------------------------------------
 * 2010. 12. 18.  leehj       Initial Release
 ************************************************
 *
 * @author      leehj
 * @version     1.0
 * @since       2010. 12. 18.
 */

package com.sinc.lms.propose;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.inicis.inipay.INIpay50;
import com.sinc.cms.item.ItemMgr;
import com.sinc.framework.data.Box;
import com.sinc.framework.data.DataSet;
import com.sinc.framework.persist.AbstractMgr;
import com.sinc.framework.util.DateTimeUtil;
import com.sinc.framework.util.StringUtil;
import com.sinc.lms.exam.ExamMgr;
import com.sinc.lms.member.MemberMgr;
import com.sinc.lms.report.ReportMakeMgr;
import com.sinc.lms.study.StudyBoardMgr;
import com.sinc.lms.sulmun.SulmunMgr;
import com.sinc.lms.support.MileageMgr;

public class ProposeMgr extends AbstractMgr {

	Logger log = Logger.getLogger(ProposeMgr.class);

	/**
	 * 부분수강 수강신청할 정보를 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public Box selectProposeSelApplyInfo(Box box) throws Exception {
		Box data = null;
        try {
 		    data = sqlWrap.queryForBox("selectProposeSelApplyInfo", box.getMap());
 		    if(data == null) data = new Box("");
        } catch ( Exception e ) {
        	throw e;
        } finally {

        }
		return data;
	}

	/**
	 * GLMP 수강신청 폼 정보를 가져온다
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public Box selectProposeFormGLMP(Box box) throws Exception{
		Box data = null;
        try {
 		    data = sqlWrap.queryForBox("selectProposeFormGLMP", box.getMap());
 		    if(data == null) data = new Box("");
        } catch ( Exception e ) {
        	throw e;
        } finally {

        }
		return data;
	}

	/**
	 * 수강 및 결제 상태 정보를 가져온다
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public Box selectPropPayState(Box box) throws Exception{
		Box data = null;
        try {
 		    data = sqlWrap.queryForBox("selectPropPayState", box.getMap());
 		    if(data == null) data = new Box("");
        } catch ( Exception e ) {
        	throw e;
        } finally {

        }
		return data;
	}

	/**
	 * 분납과정의에서 현재 날짜에 결제 가능한 seq 를 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public Box selectPayInstallmentSeqMin(Box box) throws Exception {
		Box data = null;
        try {
 		    data = sqlWrap.queryForBox("selectPayInstallmentSeqMin", box.getMap());
 		    if(data == null) data = new Box("");
        } catch ( Exception e ) {
        	throw e;
        } finally {

        }
		return data;
	}

	/**
	 * 무역협회 회원사인지 확인한다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public Box getKitaMemberAuthCheck(Box box) throws Exception{
		Box data = null;
        try {
 		    data = sqlWrap.queryForBox("selectKitaMemberAuthCheck", box.getMap());
 		    if(data == null) data = new Box("");
        } catch ( Exception e ) {
        	throw e;
        } finally {

        }
		return data;
	}
	/**
	 * 무역마스터 학생인지 확인한다
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public Box getTradeGraduCheck(Box box) throws Exception{
		Box data = null;
		try {
			data = sqlWrap.queryForBox("checkMasterStudentResult", box.getMap());
			if(data == null) data = new Box("");
		} catch ( Exception e ) {
			throw e;
		} finally {
			
		}
		return data;
	}

	/**
	 * 결제모듈(이니페이) 설정 정보를 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public Box getInipayInfo(Box box) throws Exception{
		Box data = null;
		try {
        	if(box.getString("p_trainingclass").equals("15")){
        		data = sqlWrap.queryForBox("getInipayInfoJiboo",box.getMap());
        	}else{
        		data = sqlWrap.queryForBox("getInipayInfo",box.getMap());
        	}
 		    
 		    if(data == null) data = new Box("");
        } catch ( Exception e ) {
        	throw e;
        } finally {

        }
		return data;
	}
	
	/**
	 * IC.N 결제 대상 과정 정보를 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public boolean getIcnPayInfo(String subj) throws Exception{
		boolean result = false;
		String payResult = null;
        try {
 		    payResult = (String)sqlWrap.queryForObject("getIcnPayInfo", subj);
 		    if ("Y".equals(payResult)) {
 		    	result = true;
 		    } 
 		 
        } catch ( Exception e ) {
        	throw e;
        } finally {

        }
		return result;
	}

	/**
	 * 가상계좌 정보를 가져온다
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public Box selectVBankInfo(Box box) throws Exception{
		Box data = null;
        try {
 		    data = sqlWrap.queryForBox("selectVBankInfo",box.getMap());
 		    if(data == null) data = new Box("");
        } catch ( Exception e ) {
        	throw e;
        } finally {

        }
		return data;
	}

	/**
	 * 결제시작
	 * @param request
	 * @param box
	 * @throws Exception
	 */
	public void doINISecureStart( HttpServletRequest request, Box box ) throws Exception {
		/**
		 * 1. INIpay 설정정보 가져오기
		 */
		Box boxProposeApplyInfo = (Box)box.getObject("boxProposeApplyInfo");
		Box boxInipayInfo = this.getInipayInfo(box);
		boolean boxIcnpayInfo = this.getIcnPayInfo(box.getString("p_subj"));
		box.put("boxInipayInfo", boxInipayInfo);
		
		String v_date = boxProposeApplyInfo.getString("PAYLIMIT");
		String vbank_date = "";
		
		if("".equals(v_date)){
			Box vBank = (Box)box.getObject("data_vBank");
			if(vBank != null){
				v_date = vBank.getString("PAYLIMIT");
				/*
				if(!"".equals(v_date)){
					v_date = v_date.substring(0, 4) + v_date.substring(5, 7) + v_date.substring(8, 10);
				}
				*/
			}
		}
		
		if(!"".equals(v_date) && v_date.length() > 7){
			Calendar today = Calendar.getInstance();
			
			today.add(Calendar.DATE, 30);
			
			Calendar c = Calendar.getInstance();
			c.set(Integer.parseInt(v_date.substring(0,4)), Integer.parseInt(v_date.substring(4,6))-1, Integer.parseInt(v_date.substring(6,8)));
			
			if(today.getTimeInMillis() < c.getTimeInMillis()){
				// 수업시작일이 한달 넘게 남았을 경우 오늘부터 30일 후까지  
				c = today;
			} else {
				// 수업시작일이 한달 이내일 경우 수업시작 하루 전까지
				// 가상계좌 납입기한 까지
				c.add(Calendar.DATE, 0);
			}
			
			String year = c.get(Calendar.YEAR)+"";
			String month = (c.get(Calendar.MONTH)+1)+"";
			if(month.length() == 1){
				month = "0"+month;
			}
			String date = c.get(Calendar.DATE) + "";
			if(date.length() == 1){
				date = "0"+date;
			}
			vbank_date= "vbank("+year+month+date+")";
		}
		
		if("Y".equals(boxProposeApplyInfo.getString("ISINSTALLMENT"))){
			v_date = boxProposeApplyInfo.getString("PAYEND");
			Calendar today = Calendar.getInstance();
			
			today.add(Calendar.DATE, 30);
			
			Calendar c = Calendar.getInstance();
			c.set(Integer.parseInt(v_date.substring(0,4)), Integer.parseInt(v_date.substring(4,6))-1, Integer.parseInt(v_date.substring(6,8)));
			
			if(today.getTimeInMillis() < c.getTimeInMillis()){
				// 수업시작일이 한달 넘게 남았을 경우 오늘부터 30일 후까지  
				c = today;
			} else {
				// 수업시작일이 한달 이내일 경우 수업시작 하루 전까지
				// 가상계좌 납입기한 까지
				c.add(Calendar.DATE, 0);
			}
			
			String year = c.get(Calendar.YEAR)+"";
			String month = (c.get(Calendar.MONTH)+1)+"";
			if(month.length() == 1){
				month = "0"+month;
			}
			String date = c.get(Calendar.DATE) + "";
			if(date.length() == 1){
				date = "0"+date;
			}
			vbank_date= "vbank("+year+month+date+")";
		}

		/**
		 * 2. INIpay 인스턴스 생성
		 */
		INIpay50 inipay = new INIpay50();

	    /**
	     * 3. 암호화 대상/값 설정   테스트 수정
	     */
//		inipay.SetField("inipayhome", boxInipayInfo.getString("INIPAYHOME"));	// 이니페이 홈디렉터리(상점수정 필요)
		inipay.SetField("inipayhome", "C:/INIpay50");	// 이니페이 홈디렉터리(상점수정 필요)	//로컬실행용
		//***********************************************************************************************************
		//* admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다.      *
		//* 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해 주시기 바랍니다.*
		//* 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다.                               *
		//* 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오.             *
		//***********************************************************************************************************
		if (boxIcnpayInfo) {			// 토익 특별시험, 비즈니스 외국어
			inipay.SetField("admin", "1111");
		} else if (box.getString("p_subj").equals("3044")
				|| box.getString("p_subj").equals("3284")
				|| box.getString("p_subj").equals("3285")
				|| box.getString("p_subj").equals("3286")
				|| box.getString("p_subj").equals("3287")
				|| box.getString("p_subj").equals("3283")
				|| box.getString("p_subj").equals("3295")) { // 대학생 무역캠프
			inipay.SetField("admin", "1111");
		} else {
			inipay.SetField("admin", boxInipayInfo.getString("ADMIN")); 		// 키패스워드(상점아이디에 따라 변경)
		}
		
		inipay.SetField("type", boxInipayInfo.getString("TYPE")); 				// 고정 (절대 수정 불가)
		inipay.SetField("type", "chkfake"); 									// 고정 (절대 수정 불가)
		inipay.SetField("enctype", boxInipayInfo.getString("ENCTYPE")); 		// 고정 (절대 수정 불가) asym:비대칭, symm:대칭
		inipay.SetField("checkopt", boxInipayInfo.getString("CHECKOPT")); 		// 고정 (절대 수정 불가) base64함:false, base64안함:true
		inipay.SetField("debug", boxInipayInfo.getString("DEBUG")); 			// 로그모드("true"로 설정하면 상세로그가 생성됨.)
//		inipay.SetField("debug", "true");

		//필수항목 : mid, price, nointerest, quotabase
		//추가가능 : INIregno, oid
		//*주의* : 	추가가능한 항목중 암호화 대상항목에 추가한 필드는 반드시 hidden 필드에선 제거하고
		//          SESSION이나 DB를 이용해 다음페이지(INIsecureresult.jsp)로 전달/셋팅되어야 합니다.
		if (boxIcnpayInfo) {
		//	inipay.SetField("mid", "iseenorg01"); 				//토익 상점아이디
		} else if (box.getString("p_subj").equals("3044")
				|| box.getString("p_subj").equals("3284")
				|| box.getString("p_subj").equals("3285")
				|| box.getString("p_subj").equals("3286")
				|| box.getString("p_subj").equals("3287")
				|| box.getString("p_subj").equals("3283")
				|| box.getString("p_subj").equals("3295")) {
		//	inipay.SetField("mid", "kitanet011"); // 대학생 무역캠프(자격시험 상점 아이디)
		} else {
		//	inipay.SetField("mid", boxInipayInfo.getString("MID")); 				//상점아이디
		}
		inipay.SetField("mid", "INIpayTest"); 				//상점아이디
		inipay.SetField("price", boxProposeApplyInfo.getString("PRICE")); 		// 가격
		inipay.SetField("nointerest", boxInipayInfo.getString("NOINTEREST")); 	//무이자여부
		inipay.SetField("quotabase", boxInipayInfo.getString("QUOTABASE")); 	//할부기간
		String[] parameters = {"price","nointerest", "quotabase"};
		inipay.SetField("parameters",parameters);

		/**
		 * 4. 암호화 대상/값을 암호화함
		 */
		inipay.startAction();

		/**
		 * 5. 암호화 결과
		 */
		String rn_resultMsg = "";
		box.put("ResultCode", inipay.GetResult("ResultCode"));
		if ( inipay.GetResult("ResultCode") != "00" ) {
			rn_resultMsg = inipay.GetResult("ResultMsg");
			box.put("rn_resultMsg", rn_resultMsg);
		}

		/**
		 * 6. 세션정보 저장
		 */
		HttpSession session = request.getSession();
		session.setAttribute("INI_MID"    , inipay.GetResult("mid"));
		session.setAttribute("INI_RN"     , inipay.GetResult("rn"));
		session.setAttribute("INI_ENCTYPE", inipay.GetResult("enctype"));
		session.setAttribute("INI_PRICE"  , inipay.GetResult("price") );
		session.setAttribute("admin"      , inipay.GetResult("admin"));

		/**
		 * 7. 플러그인 전달 정보, hidden field 설정
		 */
		String ini_encfield = inipay.GetResult("encfield");
		String ini_certid   = inipay.GetResult("certid");
		box.put("ini_encfield", ini_encfield);
		box.put("ini_certid", ini_certid);

		/**
		 * 8. 인스턴스 해제
		 */
		inipay = null;

		/**
		 * 9. hidden 폼태그 생성
		 */
		StringBuilder sbHtml = new StringBuilder();
		sbHtml.append("<input type=\"hidden\" name=\"ini_encfield\" value=\"").append(ini_encfield).append("\">\n");
		sbHtml.append("<input type=\"hidden\" name=\"ini_certid\" value=\"").append(ini_certid).append("\">\n");
		sbHtml.append("<input type=\"hidden\" name=\"quotainterest\" value=\"\">\n");
		sbHtml.append("<input type=\"hidden\" name=\"paymethod\" value=\"\">\n");
		sbHtml.append("<input type=\"hidden\" name=\"cardcode\" value=\"\">\n");
		sbHtml.append("<input type=\"hidden\" name=\"cardquota\" value=\"\">\n");
		sbHtml.append("<input type=\"hidden\" name=\"rbankcode\" value=\"\">\n");
		sbHtml.append("<input type=\"hidden\" name=\"reqsign\" value=\"\">\n");
		sbHtml.append("<input type=\"hidden\" name=\"encrypted\" value=\"\">\n");
		sbHtml.append("<input type=\"hidden\" name=\"sessionkey\" value=\"\">\n");
		sbHtml.append("<input type=\"hidden\" name=\"uid\" value=\"\">\n");
		sbHtml.append("<input type=\"hidden\" name=\"sid\" value=\"\">\n");
		sbHtml.append("<input type=\"hidden\" name=\"version\" value=\"5000\">\n");
		sbHtml.append("<input type=\"hidden\" name=\"clickcontrol\" value=\"\">\n");
		sbHtml.append("<input type=\"hidden\" name=\"currency\" value=\"").append(boxInipayInfo.getString("CURRENCY")).append("\">\n");
		if(!"".equals(vbank_date)){
			if(boxInipayInfo.getString("ACCEPTMETHOD").equals("")){
				boxInipayInfo.put("ACCEPTMETHOD", vbank_date);
			} else {
				boxInipayInfo.put("ACCEPTMETHOD", vbank_date+":"+boxInipayInfo.getString("ACCEPTMETHOD"));
			}
		}
		if ( !boxInipayInfo.getString("ACCEPTMETHOD").equals("") ) {
			sbHtml.append("<input type=\"hidden\" name=\"acceptmethod\" value=\"").append(boxInipayInfo.getString("ACCEPTMETHOD")).append("\">\n");
		}

		box.put("sbHtml", sbHtml);
	}

	/**
	 * 결제정보 재 세팅   ( 마일리지를 제외한 최종 결제금액 재설정 )
	 * @param request
	 * @param box
	 * @throws Exception
	 */
	public void doINISecureReStart( HttpServletRequest request, Box box ) throws Exception {
		/**
		 * 1. INIpay 설정정보 가져오기
		 */
		Box boxInipayInfo = this.getInipayInfo(box);
		box.put("boxInipayInfo", boxInipayInfo);
		/**
		 * 2. INIpay 인스턴스 생성
		 */
		INIpay50 inipay = new INIpay50();

	    /**
	     * 3. 암호화 대상/값 설정   테스트 수정
	     */
//		inipay.SetField("inipayhome", boxInipayInfo.getString("INIPAYHOME"));	// 이니페이 홈디렉터리(상점수정 필요)
		inipay.SetField("inipayhome", "C:/INIpay50");	// 이니페이 홈디렉터리(상점수정 필요)
		//***********************************************************************************************************
		//* admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다.      *
		//* 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해 주시기 바랍니다.*
		//* 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다.                               *
		//* 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오.             *
		//***********************************************************************************************************
		inipay.SetField("admin", boxInipayInfo.getString("ADMIN")); 		// 키패스워드(상점아이디에 따라 변경)

		inipay.SetField("type", boxInipayInfo.getString("TYPE")); 				// 고정 (절대 수정 불가)
		inipay.SetField("type", "chkfake"); 									// 고정 (절대 수정 불가)
		inipay.SetField("enctype", boxInipayInfo.getString("ENCTYPE")); 		// 고정 (절대 수정 불가) asym:비대칭, symm:대칭
		inipay.SetField("checkopt", boxInipayInfo.getString("CHECKOPT")); 		// 고정 (절대 수정 불가) base64함:false, base64안함:true
		inipay.SetField("debug", boxInipayInfo.getString("DEBUG")); 			// 로그모드("true"로 설정하면 상세로그가 생성됨.)
//		inipay.SetField("debug", "true");

		//필수항목 : mid, price, nointerest, quotabase
		//추가가능 : INIregno, oid
		//*주의* : 	추가가능한 항목중 암호화 대상항목에 추가한 필드는 반드시 hidden 필드에선 제거하고
		//          SESSION이나 DB를 이용해 다음페이지(INIsecureresult.jsp)로 전달/셋팅되어야 합니다.
//		inipay.SetField("mid", boxInipayInfo.getString("MID")); 				//상점아이디
		inipay.SetField("mid", "INIpayTest"); 				//상점아이디
		inipay.SetField("price", box.getString("p_price")); 		// 가격
		inipay.SetField("nointerest", boxInipayInfo.getString("NOINTEREST")); 	//무이자여부
		inipay.SetField("quotabase", boxInipayInfo.getString("QUOTABASE")); 	//할부기간
		String[] parameters = {"price","nointerest", "quotabase"};
		inipay.SetField("parameters",parameters);

		/**
		 * 4. 암호화 대상/값을 암호화함
		 */
		inipay.startAction();

		/**
		 * 5. 암호화 결과
		 */
		String rn_resultMsg = "";
		box.put("ResultCode", inipay.GetResult("ResultCode"));
		if ( inipay.GetResult("ResultCode") != "00" ) {
			rn_resultMsg = inipay.GetResult("ResultMsg");
			box.put("rn_resultMsg", rn_resultMsg);
		}

		/**
		 * 6. 세션정보 저장
		 */
		HttpSession session = request.getSession();
		session.setAttribute("INI_MID"    , inipay.GetResult("mid"));
		session.setAttribute("INI_RN"     , inipay.GetResult("rn"));
		session.setAttribute("INI_ENCTYPE", inipay.GetResult("enctype"));
		session.setAttribute("INI_PRICE"  , inipay.GetResult("price") );
		session.setAttribute("admin"      , inipay.GetResult("admin"));

		/**
		 * 7. 플러그인 전달 정보, hidden field 설정
		 */
		String ini_encfield = inipay.GetResult("encfield");
		String ini_certid   = inipay.GetResult("certid");

		box.put("ini_encfield", ini_encfield);
		box.put("ini_certid", ini_certid);

		/**
		 * 8. 인스턴스 해제
		 */
		inipay = null;

	}

	/**
	 * 결제
	 * @param request
	 * @param box
	 * @throws Exception
	 */
	public int doINISecureResult( HttpServletRequest request, Box box ) throws Exception {

		int retVal = 0;

		HttpSession session = request.getSession();

		try {
			/**
			 * 1. INIpay 설정정보 가져오기 및 수강신청 정보 가져오기
			 */
			Box boxProposeApplyInfo = (Box)box.getObject("boxProposeApplyInfo");
			Box boxInipayInfo = this.getInipayInfo(box);
			box.put("boxInipayInfo", boxInipayInfo);

			/**
			 * 2. INIpay 인스턴스 생성
			 */
			INIpay50 inipay = new INIpay50();


			/**
			 * 3. 지불 정보 설정  테스트 수정
			 */
			HashMap<String,String> hmParam = new HashMap<String,String>();

//			inipay.SetField("inipayhome", boxInipayInfo.getString("INIPAYHOME"));	// 이니페이 홈디렉터리(상점수정 필요)
			inipay.SetField("inipayhome", "C:/INIpay50");	// 이니페이 홈디렉터리(상점수정 필요)
			inipay.SetField("type", "securepay"); 									// 고정 (절대 수정 불가)
			inipay.SetField("admin", boxInipayInfo.getString("ADMIN"));				// 키패스워드(상점아이디에 따라 변경)
			inipay.SetField("admin", session.getAttribute("admin")); 				// 키패스워드(상점아이디에 따라 변경)

			//***********************************************************************************************************
			//* admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다.      *
			//* 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해 주시기 바랍니다.*
			//* 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다.                               *
			//* 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오.             *
			//***********************************************************************************************************
			inipay.SetField("debug", boxInipayInfo.getString("DEBUG")); 		// 로그모드("true"로 설정하면 상세로그가 생성됨.)

			inipay.SetField("uid", request.getParameter("uid") ); 				// INIpay User ID (절대 수정 불가)
			inipay.SetField("oid", request.getParameter("oid") ); 				// 상품명
			inipay.SetField("goodname", request.getParameter("goodname") ); 	// 상품명
			inipay.SetField("currency", request.getParameter("currency") ); 	// 화폐단위

//			inipay.SetField("mid", session.getAttribute("INI_MID") ); 			// 상점아이디
			inipay.SetField("mid", "INIpayTest"); 								// 상점아이디
			inipay.SetField("enctype", session.getAttribute("INI_ENCTYPE") ); 	// 웹페이지 위변조용 암호화 정보
			inipay.SetField("rn", session.getAttribute("INI_RN") ); 			// 웹페이지 위변조용 RN값
			inipay.SetField("price", session.getAttribute("INI_PRICE") ); 		// 가격

			// 마일리지 결제로 금액이 변경된 경우
			String v_trainingclass = box.getString("p_trainingclass");
			String v_proposetype = box.getString("p_proposetype");

			if(v_trainingclass.equals("11") || v_trainingclass.equals("03")||v_trainingclass.equals("04")||v_trainingclass.equals("08") || v_trainingclass.equals("12") || v_trainingclass.equals("16") || v_trainingclass.equals("13") || v_proposetype.equals("7")){
				// 골드패스 , 무역마스터, it 마스터, 글로벌인턴쉽 , 섬유수출전문가, 중국마케팅전문가, 선택적 부분수강
				if ( !box.getString("p_price").equals(session.getAttribute("INI_PRICE")) ) {
					return -1;
				}

			}else {

				if ( !boxProposeApplyInfo.getString("PRICE").equals(session.getAttribute("INI_PRICE")) ) {
					return -1;
				}
			}



			/**---------------------------------------------------------------------------------------
			* price 등의 중요데이터는
			* 브라우저상의 위변조여부를 반드시 확인하셔야 합니다.
			*
			* 결제 요청페이지에서 요청된 금액과
			* 실제 결제가 이루어질 금액을 반드시 비교하여 처리하십시오.
			*
			* 설치 메뉴얼 2장의 결제 처리페이지 작성부분의 보안경고 부분을 확인하시기 바랍니다.
			* 적용참조문서: 이니시스홈페이지->가맹점기술지원자료실->기타자료실 의
			*              '결제 처리 페이지 상에 결제 금액 변조 유무에 대한 체크' 문서를 참조하시기 바랍니다.
			* 예제)
			* 원 상품 가격 변수를 OriginalPrice 하고  원 가격 정보를 리턴하는 함수를 Return_OrgPrice()라 가정하면
			* 다음 같이 적용하여 원가격과 웹브라우저에서 Post되어 넘어온 가격을 비교 한다.
			*
				String originalPrice = merchant.getOriginalPrice();
				String postPrice = inipay.GetResult("price");
				if ( originalPrice != postPrice )
				{
					//결제 진행을 중단하고  금액 변경 가능성에 대한 메시지 출력 처리
					//처리 종료
				}
			---------------------------------------------------------------------------------------**/
			inipay.SetField("paymethod", request.getParameter("paymethod") ); 		// 지불방법 (절대 수정 불가)
			inipay.SetField("encrypted", request.getParameter("encrypted") ); 		// 암호문
			inipay.SetField("sessionkey",request.getParameter("sessionkey") ); 		// 암호문
			inipay.SetField("buyername", request.getParameter("buyername") ); 		// 구매자 명
			inipay.SetField("buyertel", request.getParameter("buyertel") ); 		// 구매자 연락처(휴대폰 번호 또는 유선전화번호)
			inipay.SetField("buyeremail",request.getParameter("buyeremail") ); 		// 구매자 이메일 주소
			inipay.SetField("url", "http://www.kitabtoc.com" ); 					// 실제 서비스되는 상점 SITE URL로 변경할것
			inipay.SetField("cardcode", request.getParameter("cardcode") ); 		// 카드코드 리턴
			inipay.SetField("parentemail", request.getParameter("parentemail") ); 	// 보호자 이메일 주소(핸드폰 , 전화결제시에 14세 미만의 고객이 결제하면  부모 이메일로 결제 내용통보 의무, 다른결제 수단 사용시에 삭제 가능)

			/*-----------------------------------------------------------------*
			* 수취인 정보 *                                                   *
			*-----------------------------------------------------------------*
			* 실물배송을 하는 상점의 경우에 사용되는 필드들이며               *
			* 아래의 값들은 INIsecurestart.jsp 페이지에서 포스트 되도록        *
			* 필드를 만들어 주도록 하십시요.                                  *
			* 컨텐츠 제공업체의 경우 삭제하셔도 무방합니다.                   *
			*-----------------------------------------------------------------*/
//			inipay.SetField("recvname",request.getParameter("recvname") );	// 수취인 명
//			inipay.SetField("recvtel",request.getParameter("recvtel") );		// 수취인 연락처
//			inipay.SetField("recvaddr",request.getParameter("recvaddr") );	// 수취인 주소
//			inipay.SetField("recvpostnum",request.getParameter("recvpostnum") );  // 수취인 우편번호
//			inipay.SetField("recvmsg",request.getParameter("recvmsg") );		// 전달 메세지
//
//			inipay.SetField("joincard",request.getParameter("joincard") );        // 제휴카드코드
//			inipay.SetField("joinexpire",request.getParameter("joinexpire") );    // 제휴카드유효기간
//			inipay.SetField("id_customer",request.getParameter("id_customer") );  // 일반적인 경우 사용하지 않음, user_id


			/****************
			* 4. 지불 요청 *
			****************/
			inipay.startAction();


			/*****************
			* 5. 결제  결과 *
			*****************/
			/*****************************************************************************************************************
			*  1 모든 결제 수단에 공통되는 결제 결과 데이터
			* 	거래번호 : inipay.GetResult("tid")
			* 	결과코드 : inipay.GetResult("ResultCode") ("00"이면 지불 성공)
			* 	결과내용 : inipay.GetResult("ResultMsg") (지불결과에 대한 설명)
			* 	지불방법 : inipay.GetResult("PayMethod") (매뉴얼 참조)
			* 	상점주문번호 : inipay.GetResult("MOID")
			*	결제완료금액 : inipay.GetResult("TotPrice")
			* 	이니시스 승인날짜 : inipay.GetResult("ApplDate") (YYYYMMDD)
			* 	이니시스 승인시각 : inipay.GetResult("ApplTime") (HHMMSS)
			*
			*
			* 결제 되는 금액 =>원상품가격과  결제결과금액과 비교하여 금액이 동일하지 않다면
			* 결제 금액의 위변조가 의심됨으로 정상적인 처리가 되지않도록 처리 바랍니다. (해당 거래 취소 처리)
			*
			*  2. 일부 결제 수단에만 존재하지 않은 정보,
			*     OCB Point/VBank 를 제외한 지불수단에 모두 존재.
			* 	승인번호 : inipay.GetResult("ApplNum")
			*
			*
			*  3. 신용카드 결제 결과 데이터 (Card, VCard 공통)
			* 	할부기간 : inipay.GetResult("CARD_Quota")
			* 	무이자할부 여부 : inipay.GetResult("CARD_Interest") ("1"이면 무이자할부),
			*                    또는 inipay.GetResult("EventCode") (무이자/할인 행사적용 여부, 값에 대한 설명은 메뉴얼 참조)
			* 	신용카드사 코드 : inipay.GetResult("CARD_Code") (매뉴얼 참조)
			* 	카드발급사 코드 : inipay.GetResult("CARD_BankCode") (매뉴얼 참조)
			* 	본인인증 수행여부 : inipay.GetResult("CARD_AuthType") ("00"이면 수행)
			*  각종 이벤트 적용 여부 : inipay.GetResult("EventCode")
			*
			*
			*      ** 달러결제 시 통화코드와  환률 정보 **
			*	해당 통화코드 : inipay.GetResult("OrgCurrency")
			*	환율 : inipay.GetResult("ExchangeRate")
			*
			*      아래는 "신용카드 및 OK CASH BAG 복합결제" 또는"신용카드 지불시에 OK CASH BAG적립"시에 추가되는 데이터
			* 	OK Cashbag 적립 승인번호 : inipay.GetResult("OCB_SaveApplNum")
			* 	OK Cashbag 사용 승인번호 : inipay.GetResult("OCB_PayApplNum")
			* 	OK Cashbag 승인일시 : inipay.GetResult("OCB_ApplDate") (YYYYMMDDHHMMSS)
			* 	OCB 카드번호 : inipay.GetResult("OCB_Num")
			* 	OK Cashbag 복합결재시 신용카드 지불금액 : inipay.GetResult("CARD_ApplPrice")
			* 	OK Cashbag 복합결재시 포인트 지불금액 : inipay.GetResult("OCB_PayPrice")
			*
			* 4. 실시간 계좌이체 결제 결과 데이터
			*
			* 	은행코드 : inipay.GetResult("ACCT_BankCode")
			*	현금영수증 발행결과코드 : inipay.GetResult("CSHR_ResultCode")
			*	현금영수증 발행구분코드 : inipay.GetResult("CSHR_Type")
			*
			* 5. OK CASH BAG 결제수단을 이용시에만  결제 결과 데이터
			* 	OK Cashbag 적립 승인번호 : inipay.GetResult("OCB_SaveApplNum")
			* 	OK Cashbag 사용 승인번호 : inipay.GetResult("OCB_PayApplNum")
			* 	OK Cashbag 승인일시 : inipay.GetResult("OCB_ApplDate") (YYYYMMDDHHMMSS)
			* 	OCB 카드번호 : inipay.GetResult("OCB_Num")
			*
			* 6. 무통장 입금 결제 결과 데이터
			* 	가상계좌 채번에 사용된 주민번호 : inipay.GetResult("VACT_RegNum")
			* 	가상계좌 번호 : inipay.GetResult("VACT_Num")
			* 	입금할 은행 코드 : inipay.GetResult("VACT_BankCode")
			* 	입금예정일 : inipay.GetResult("VACT_Date") (YYYYMMDD)
			* 	송금자 명 : inipay.GetResult("VACT_InputName")
			* 	예금주 명 : inipay.GetResult("VACT_Name")
			*
			* 7. 핸드폰, 전화 결제 결과 데이터( "실패 내역 자세히 보기"에서 필요 , 상점에서는 필요없는 정보임)
			* 	전화결제 사업자 코드 : inipay.GetResult("HPP_GWCode")
			*
			* 8. 핸드폰 결제 결과 데이터
			* 	휴대폰 번호 : inipay.GetResult("HPP_Num") (핸드폰 결제에 사용된 휴대폰번호)
			*
			* 9. 전화 결제 결과 데이터
			* 	전화번호 : inipay.GetResult("ARSB_Num") (전화결제에  사용된 전화번호)
			*
			* 10. 문화 상품권 결제 결과 데이터
			* 	컬쳐 랜드 ID : inipay.GetResult("CULT_UserID")
			*
			* 11. 현금영수증 발급 결과코드 (은행계좌이체시에만 리턴)
			*    inipay.GetResult("CSHR_ResultCode")
			*
			* 12.틴캐시 잔액 데이터
			*    inipay.GetResult("TEEN_Remains")
			*  틴캐시 ID : inipay.GetResult("TEEN_UserID")
			*
			* 13.게임문화 상품권
			*	사용 카드 갯수 : inipay.GetResult("GAMG_Cnt")
			*
			* 14.도서문화 상품권
			*	사용자 ID : inipay.GetResult("BCSH_UserID")
			*
			****************************************************************************************************************/

			//** 모든 결제 수단에 공통되는 결제 결과 데이터 **//
			hmParam.put("p_tid", inipay.GetResult("tid")); 				// 거래번호
			hmParam.put("p_resultcode", inipay.GetResult("ResultCode")); // 결과코드
			hmParam.put("p_resultmsg", inipay.GetResult("ResultMsg")); 	// 결과내용
			hmParam.put("p_paymethod", inipay.GetResult("PayMethod")); 	// 지불방법
			hmParam.put("p_moid", inipay.GetResult("MOID")); 			// 상점주문번호
			hmParam.put("p_totprice", inipay.GetResult("TotPrice")); 	// 결제완료금액
			hmParam.put("p_appldate", inipay.GetResult("ApplDate")+inipay.GetResult("ApplTime")); // 이니시스 승인날짜
			hmParam.put("p_applnum", inipay.GetResult("ApplNum")); 		// 승인번호 - OCB Point/VBank 를 제외한 지불수단에 모두 존재.

			if ( box.getString("p_paymethod").equals("010000000000") ) hmParam.put("p_appldate", ""); // 이니시스 승인날짜

			//** 신용카드 결제 결과 데이터 (Card, VCard 공통) **//
			hmParam.put("p_card_quota", inipay.GetResult("CARD_Quota")); 		// 할부기간
			hmParam.put("p_card_interest", inipay.GetResult("CARD_Interest")); 	// 무이자할부 여부, ("1"이면 무이자할부)
			hmParam.put("p_card_code", inipay.GetResult("CARD_Code")); 			// 신용카드사 코드
			hmParam.put("p_card_bankcode", inipay.GetResult("CARD_BankCode")); 	// 카드발급사 코드
			hmParam.put("p_card_authtype", inipay.GetResult("CARD_AuthType")); 	// 본인인증 수행여부, ("00"이면 수행)
			hmParam.put("p_eventcode", inipay.GetResult("EventCode")); 			// 각종 이벤트 적용 여부

			//** 달러결제 시 통화코드와  환률 정보 **//
			hmParam.put("p_orgcurrency", inipay.GetResult("OrgCurrency")); 		// 해당 통화코드
			hmParam.put("p_exchangerate", inipay.GetResult("ExchangeRate")); 	// 환율

			//**  "신용카드 및 OK CASH BAG 복합결제" 또는"신용카드 지불시에 OK CASH BAG적립"시에 추가되는 데이터 **//
			hmParam.put("p_ocb_saveapplnum", inipay.GetResult("OCB_SaveApplNum")); 	// OK Cashbag 적립 승인번호
			hmParam.put("p_ocb_payapplnum", inipay.GetResult("OCB_PayApplNum")); 	// OK Cashbag 사용 승인번호
			hmParam.put("p_ocb_appldate", inipay.GetResult("OCB_ApplDate")); 		// OK Cashbag 승인일시
			hmParam.put("p_ocb_num", inipay.GetResult("OCB_Num")); 					// OCB 카드번호
			hmParam.put("p_card_applprice", inipay.GetResult("CARD_ApplPrice")); 	// OK Cashbag 복합결재시 신용카드 지불금액
			hmParam.put("p_ocb_payprice", inipay.GetResult("OCB_PayPrice")); 		// OK Cashbag 복합결재시 포인트 지불금액

			//** 무통장 입금 결제 결과 데이터 **//
			hmParam.put("p_vact_regnum", inipay.GetResult("VACT_RegNum")); 			// 가상계좌 채번에 사용된 주민번호
			hmParam.put("p_vact_num", inipay.GetResult("VACT_Num")); 				// 가상계좌 번호
			hmParam.put("p_vact_bankcode", inipay.GetResult("VACT_BankCode")); 		// 입금할 은행 코드
			hmParam.put("p_vact_date", inipay.GetResult("VACT_Date")); 				// 입금예정일
			hmParam.put("p_vact_inputname", inipay.GetResult("VACT_InputName")); 	// 송금자 명
			hmParam.put("p_vact_name", inipay.GetResult("VACT_Name")); 				// 예금주 명

			box.put("hmInipayResult", hmParam);
			box.put("inipay", inipay);

			//Get PG Added Entity Sample
			if(inipay.GetResult("ResultCode").equals("00") ) {
				retVal = 1;
			}

		} catch ( Exception e ) {
			retVal = -2;
		} finally {
		}

		return retVal;
	}

	/**
	 * 결제취소
	 * @param request
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int doINICancel( Box box ) throws Exception {

		int retVal = 0;

		try {
			/**
			 * 1. INIpay 설정정보 가져오기 및 수강신청 정보 가져오기
			 */
			Box boxInipayInfo = this.getInipayInfo(box);
			boolean boxIcnpayInfo = this.getIcnPayInfo(box.getString("p_subj"));
			box.put("boxInipayInfo", boxInipayInfo);


			/**
			 * 2. INIpay 인스턴스 생성
			 */
			INIpay50 inipay = new INIpay50();


			/**
			 * 3. 취소 정보 설정
			 */
			HashMap<String,String> hmParam = new HashMap<String,String>();

//			inipay.SetField("inipayhome", boxInipayInfo.getString("INIPAYHOME"));	// 이니페이 홈디렉터리(상점수정 필요)
			inipay.SetField("inipayhome", "C:/INIpay50");	// 이니페이 홈디렉터리(상점수정 필요)
			inipay.SetField("type", "cancel"); 										// 고정 (절대 수정 불가)
			if (boxIcnpayInfo) {			// 토익 특별시험, 비즈니스 외국어
				inipay.SetField("admin", "1111");
				inipay.SetField("mid", "iseenorg01");
			} else if (box.getString("p_subj").equals("3044")
					|| box.getString("p_subj").equals("3284")
					|| box.getString("p_subj").equals("3285")
					|| box.getString("p_subj").equals("3286")
					|| box.getString("p_subj").equals("3287")
					|| box.getString("p_subj").equals("3283")
					|| box.getString("p_subj").equals("3295")) { // 대학생 무역캠프
				inipay.SetField("admin", "1111");
				inipay.SetField("mid", "kitanet011");
			} else {
				inipay.SetField("admin", boxInipayInfo.getString("ADMIN")); 		// 키패스워드(상점아이디에 따라 변경)
			//	inipay.SetField("mid", boxInipayInfo.getString("MID")); 				//상점아이디
				inipay.SetField("mid", "INIpayTest"); 	
			}

			//***********************************************************************************************************
			//* admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다.      *
			//* 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해 주시기 바랍니다.*
			//* 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다.                               *
			//* 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오.             *
			//***********************************************************************************************************
			inipay.SetField("debug", boxInipayInfo.getString("DEBUG")); 			// 로그모드("true"로 설정하면 상세로그가 생성됨.)
			inipay.SetField("tid", box.getString("TID") ); 			// 취소할 거래의 거래아이디
			inipay.SetField("cancelmsg", "사용자취소" ); 								// 취소사유


			/****************
			 * 4. 취소 요청 *
			 ****************/
			inipay.startAction();


			/****************************************************************
			 * 5. 취소 결과
			 *
			 * 결과코드 : inipay.GetResult("ResultCode") ("00"이면 취소 성공)
			 * 결과내용 : inipay.GetResult("ResultMsg") (취소결과에 대한 설명)
			 * 취소날짜 : inipay.GetResult("CancelDate") (YYYYMMDD)
			 * 취소시각 : inipay.GetResult("CancelTime") (HHMMSS)
			 * 현금영수증 취소 승인번호 : inipay.GetResult("CSHR_CancelNum")
			 * (현금영수증 발급 취소시에만 리턴됨)
			 ****************************************************************/
			hmParam.put("p_tid", inipay.GetResult("tid")); 				// 거래번호
			hmParam.put("p_cancelresultcode", inipay.GetResult("ResultCode")); // 결과코드
			hmParam.put("p_cancelresultmsg", inipay.GetResult("ResultMsg")); 	// 결과내용
			hmParam.put("p_canceldate", inipay.GetResult("CancelDate")+inipay.GetResult("CancelTime")); // 이니시스 승인날짜

			box.put("hmInipayResult", hmParam);
			box.put("inipay", inipay);

			//Get PG Added Entity Sample
			if(inipay.GetResult("ResultCode").equals("00") ) {
				retVal = 1;
			}

		} catch ( Exception e ) {
			retVal = -2;
		} finally {
		}

		return retVal;
	}

	/**
	 * 가상계좌입금시 수강승인해줌
	 *
	 * 가상계좌 입금통보 확인 프로세스
	 * 1. t_lms_propose 의 chkfinal 필드 Y 로 업데이트
	 * 2. t_lms_student 테이블 insert
	 * 3. t_lms_payment 의 recogstate 필드 Y 로 업데이트
	 * 4. t_pay_inipayvacct 테이블 insert
	 * @param request
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int doVacctProc( Box box ) throws Exception {
	
		int retVal = 0;

		try {

			sqlWrap.startTransaction();
			/**
			 * 가상계좌 입금통보 확인 프로세스
			 * 1. 일반과정일 경우
			 *   1-1. t_lms_propose 의 chkfinal 필드 Y 로 업데이트
			 *   1-2. t_lms_student 테이블 insert
			 *   1-3. t_lms_payment 의 recogstate 필드 Y 로 업데이트
			 *   1-4. t_pay_inipayvacct 테이블 insert
			 *
			 * 2. 분납과정일 경우
			 *   1-1. t_lms_payment 의 recogstate 필드 Y 로 업데이트
			 *   1-2. t_pay_inipayvacct 테이블 insert
			 */
			
			/**
			 * 대표 id 구분 (가상계좌 입금시)
			 */
			System.out.println("************** 가상계좌 입금 *********************");
			
			// 수강승인
			if ( box.getString("p_isinstallment").equals("Y") ) {
				System.out.println("가상계좌, box.getString(p_isinstallment).equals(Y)");
				if ( box.getString("p_installment_seq").equals("1") ) {
					retVal = sqlWrap.update("updateProposeConfirmWithSubBL",box.getMap());
					sqlWrap.insert("insertStudentBL", box.getMap());
					System.out.println("가상계좌, box.getString(p_isinstallment).equals(Y) : 1");
				}
				sqlWrap.update("updatePaymentRecogState", box.getMap());
				sqlWrap.insert("insertInipayVacct", box.getMap());
				retVal = 1;
				System.out.println("가상계좌, box.getString(p_isinstallment).equals(Y) : 2");
			} else {
				System.out.println("가상계좌, box.getString(p_isinstallment).equals(N)");
				retVal = sqlWrap.update("updateProposeConfirmWithSubBL",box.getMap());
				if ( retVal > 0 ) {
					sqlWrap.insert("insertStudentBL", box.getMap());
					System.out.println("가상계좌, box.getString(p_isinstallment).equals(N) : 1");
					sqlWrap.update("updatePaymentRecogState", box.getMap());
					sqlWrap.insert("insertInipayVacct", box.getMap());
					System.out.println("가상계좌, box.getString(p_isinstallment).equals(N) : 2");
					
					// 과목코드가 랭귀지큐브라면, 랭큐 회사에  입과를 위해 URL요청. 2015.06.03 by 안성현 
					if(box.getString("p_subj").equals("4230")){
						box.getMap().put("p_userid", box.get("p_userid")); //안되면 get으로해보자
						
						Box tempBox=sqlWrap.queryForBox("getUserInfoLangQ",box.getMap());
						
						box.put("p_handphone", tempBox.getString("HANDPHONE"));
						box.put("p_name", tempBox.getString("NAME"));
			
						String resultmsg= requestLangQ(box);
						
						((HashMap<String,String>)box.getMap()).put("p_memo", resultmsg);
						//resultmsg(결과메시지)는 메모에 insert해주기로.
						
						sqlWrap.update("updateLangQMemo",box.getMap());
					}
				}
			}
			
			// 대표 id 전용
			HashMap<String, String> hmParam = new HashMap<String, String>();
			ProposeMgr proposeMgr = new ProposeMgr();
			MemberMgr memberMgr = new MemberMgr();
			
			// 대표 id
			hmParam.put("p_userid", box.getString("p_userid"));
			hmParam.put("p_subj", box.getString("p_subj"));
			hmParam.put("p_subjseq", box.getString("p_subjseq"));
			hmParam.put("p_recogstate", "N");
			
			// 단체수강신청 여부 확인	
			DataSet selectProposeStudent = proposeMgr.selectProposeStudent(hmParam);
			
			// 대표 id	(대표 id & 단체신청)
			if ( selectProposeStudent.getRow() > 0  ){		
				System.out.println(" 대표 & 단체신청 가상계좌 입금!! ");
				box.put("p_joincd", 		"03");												// 가입동기
				box.put("p_price", 			0);													// 결제금액
				box.put("p_biyong", 		0);													// 교육비
				box.put("p_bookpricesum", 	0);													// 교재비
				box.put("p_usemileage", 	0);													// 사용 마일리지
				box.put("p_costsupport", 	"1004");
		        box.put("p_anniversary", 	"");
				box.put("p_income", 		"");
				box.put("p_issms", 			"N");
				box.put("p_ismailing", 		"N");
				box.put("p_children", 		"0");
				box.put("p_iskita", 		"Y");
				box.put("p_mempath", 		"10");
				box.put("p_chkfinal", 		"M");												
				box.put("p_isdinsert", 		"N");
				box.put("p_isb2c", 			"Y");
				box.put("p_tid", 			"");
				box.put("p_office_gbn", 	"Y");												// 로그인 시 필요
				box.put("p_isdinsert", "N");
										
				System.out.println("check !!");
				System.out.println("대표 p_userid : "+box.get("p_userid"));
				System.out.println("대표 s_userid : "+box.getString("s_userid"));
				System.out.println("대표 p_subj : "+box.getString("p_subj"));
				System.out.println("대표 p_subjseq : "+box.getString("p_subjseq"));
				System.out.println("대표 p_year : "+box.getString("p_year"));		
				
				// 대표 id 정보 가져오기
				DataSet representInfo = null;
				representInfo = memberMgr.selectMemberDetail(box);
				for(int i = 0; i< representInfo.getRow(); i++){
					representInfo.next();
					box.put("p_postgb", 	representInfo.getString("POSTGB"));													// 우편물 접수처
					box.put("p_jobc_csenr", representInfo.getString("JOBC_CSENR"));												// 직업
				}
				System.out.println("대표 id 정보 가져오기 완료");
				
				// 수강생 리스트 불러오기
				for( int i = 0 ; i < selectProposeStudent.getRow(); i++ ){
					selectProposeStudent.next();							
					box.put("p_userid", 		selectProposeStudent.getString("USERID"));											// 수강생 아이디
					box.put("p_name", 			selectProposeStudent.getString("NAME"));											// 수강생 이름
					box.put("p_email", 			selectProposeStudent.getString("EMAIL"));											// 수강생 이메일
					box.put("p_birthday", 		selectProposeStudent.getString("BIRTHDAY"));										// 수강생 생일
					box.put("p_handphone", 		selectProposeStudent.getString("HANDPHONE"));										// 수강생 휴대폰
					box.put("p_usergubun", 		"KC");																				// 유저구분 (일반)
					box.put("p_resno", 			box.getString("p_birthday")+"0000000");												// 주민등록번호
					box.put("p_resno1", 		box.getString("p_birthday"));														// 주민등록번호 앞자리
					box.put("p_resno2", 		"0000000");																			// 주민등록번호 뒷자리
					box.put("p_pwd", 			box.getString("p_userid"));							
					box.put("p_pwdconfirm", 	box.getString("p_userid"));
					box.put("p_pwd", 			(String) sqlWrap.queryForObject("selectNewPwd", box.getString("p_pwd")));
					box.put("emailID", 			box.getString("p_email").substring(0, box.getString("p_email").indexOf("@")));		// 이메일 앞자리
					box.put("emailTail", 		box.getString("p_email").substring(box.getString("p_email").indexOf("@")+1));		// 이메일 뒷자리
					box.put("p_emailid", 		box.getString("emailID"));
					box.put("p_emailaddr", 		box.getString("emailTail"));
					box.put("p_comp", 			"10000");
					box.put("p_tel1", 			box.getString("p_handphone").substring(0, 3));										// 전화번호
					box.put("p_tel2", 			box.getString("p_handphone").substring(4, 8));		
					box.put("p_tel3", 			box.getString("p_handphone").substring(9));
					box.put("p_rcvrtel", 		box.getString("p_tel1") +"-"+box.getString("p_tel2")+"-"+box.getString("p_tel3")) ;
					box.put("p_rcvrmobile", 	box.getString("p_handphone") ) ;
					
					System.out.println("--- 수강생 정보 ---");
					System.out.println("p_userid : "+box.getString("p_userid"));
					System.out.println("p_name : "+box.getString("p_name"));
					System.out.println("p_email : "+box.getString("p_email"));
					System.out.println("p_birthday : "+box.getString("p_birthday"));
					
					// 수강생 회원가입 시키기
					sqlWrap.insert("insertBtoCMember", box.getMap());
					System.out.println("수강생 회원가입 완료");
					
					//비밀번호 암호화 방식이 2014년 적용된 새로운 암호화 방식임을 알아보는  new_pwd_yn 컬럼 업데이트(t_lms_member) 및 merge(MEMBER_SUB_INFO@TRADE)
					String userID = box.getString("p_userid");
					sqlWrap.update("updateMemberNewPwdYnIsY", userID);//t_lms_member 의 NEW_PWD_YN 컬럼 업데이트
					
					// 수강생 수강신청
					sqlWrap.insert("insertProposeBL", box.getMap());	
					System.out.println("수강생 수강신청 완료");
										
					// 수강생 수강승인  처리한다
					retVal = sqlWrap.update("updateProposeConfirmWithSubBL",box.getMap());		
					if ( retVal > 0 ) {
						System.out.println("수강생 수강승인 완료");
						
						// 대표&수강생 관계테이블 승인상태 업데이트
						sqlWrap.update("updateProposeStudent", box.getMap());
						System.out.println("// 대표&수강생 관계테이블 승인상태 업데이트");
						
						// 수강생 학생정보 업데이트
						retVal = sqlWrap.update("insertStudentBL", box.getMap());
						if ( retVal == 0 ) {
							System.out.println("수강생 학생정보 업데이트 실패");
							retVal = -1;
							return retVal ;
						}
					} else {
						System.out.println("수강생 수강승인 실패");
						retVal = -1;					// 수강테이블 업데이트에 실패하였습니다.
						return retVal;
					}
					System.out.println("수강생 학생정보 업데이트 완료");
					
				}// for
				
			}

			sqlWrap.commitTransaction();
		} catch ( Exception e ) {
			retVal = -1;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}

	/**
	 * 가상계좌입금시 수강승인해줌 - 선택적 부분수강
	 *
	 * 가상계좌 입금통보 확인 프로세스
	 * 1. t_lms_propose 의 chkfinal 필드 Y 로 업데이트
	 * 2. t_lms_student 테이블 insert
	 * 3. t_lms_payment 의 recogstate 필드 Y 로 업데이트
	 * 4. t_pay_inipayvacct 테이블 insert
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int doVacctProcSel( Box box ) throws Exception {

		int retVal = 0;

		try {

			sqlWrap.startTransaction();
			/**
			 * 가상계좌 입금통보 확인 프로세스
			 * 1. t_lms_propose 의 chkfinal 필드 Y 로 업데이트
			 * 2. t_lms_student 테이블 insert
			 * 3. t_lms_payment 의 recogstate 필드 Y 로 업데이트
			 * 4. t_pay_inipayvacct 테이블 insert
			 *
			 */
			retVal = sqlWrap.update("updateProposeConfirmWithSel",box.getMap());
			if ( retVal > 0 ) {
				sqlWrap.insert("insertStudentSel", box.getMap());
				sqlWrap.update("updatePaymentRecogState", box.getMap());
				sqlWrap.insert("insertInipayVacct", box.getMap());
			}

			sqlWrap.commitTransaction();
		} catch ( Exception e ) {
			retVal = -1;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}

	/**
	 * 가상계좌입금시 RIGHTAPPLY[원서접수]테이블에 APPLYSTATE 컬럼 상태값을 TF[완료]로 변경 해줌.
	 *
	 * 가상계좌 입금통보 확인 프로세스
	 * 1. t_lms_rightapply 의 applystate 필드 PF 로 업데이트
	 * 2. t_lms_payment 의 recogstate 필드 Y 로 업데이트
	 * 3. t_pay_inipayvacct 테이블 insert
	 * @param request
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int doVacctTestRightProc( Box box ) throws Exception {

		int retVal = 0;

		try {

			sqlWrap.startTransaction();
			/**
			 * 가상계좌 입금통보 확인 프로세스
			 * 1. t_lms_rightapply 의 applystate 필드PF 로 업데이트
			 * 2. t_lms_payment 의 recogstate 필드 Y 로 업데이트
			 * 3. t_pay_inipayvacct 테이블 insert
			 */
			retVal = sqlWrap.update("updateTestRightApplystateChange",box.getMap());
			if ( retVal > 0 ) {
				sqlWrap.update("updateRightTestPaymentRecogState", box.getMap());
				sqlWrap.insert("insertInipayVacct", box.getMap());
			}
			sqlWrap.commitTransaction();
		} catch ( Exception e ) {
			retVal = -1;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}

	/**
	 * 결재현황 리스트를 가져온다.
	 * 지원신청서 리스트 + 수강신청 리스트 + 결재리스트
	 * 분납결제일 경우는 따로 셀렉트를 해 와서 리스트에 추가한다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public DataSet getProposePayState(Box box) throws Exception {

		DataSet data = null;

        try {
        	String v_isinstallment = null;
//        	String v_paperpassyn = null;
//        	String v_interviewpassyn = null;
			//교재와 배송정보를 정보를 가져온다.
			HashMap<String,String> hmParam = new HashMap<String,String>();
			hmParam.put("p_userid", box.getString("s_userid"));

			data = sqlWrap.queryForDataSet("selectProposePayStateList", hmParam);
						
			for ( int i=0; data != null && data.next(); i++ ) {
				v_isinstallment = data.getString("ISINSTALLMENT");
//				v_paperpassyn = data.getString("PAPERPASSYN");
//	        	v_interviewpassyn = data.getString("INTERVIEWPASSYN");
				if ( v_isinstallment.equals("Y") ) {
					String v_subj = data.getString("SUBJ");
					String v_year = data.getString("YEAR");
					String v_subjseq = data.getString("SUBJSEQ");

					hmParam.put("p_subj", v_subj);
					hmParam.put("p_year", v_year);
					hmParam.put("p_subjseq", v_subjseq);

					DataSet payInstalList = sqlWrap.queryForDataSet("selectProposePayInstallList", hmParam);
					data.getCurBox().put("payInstalList", payInstalList);
				}
			}

			data.setPos();

        } catch ( Exception e ) {
        	throw e;
        } finally {

        }
		return data;
	}

	/**
	 * 학습자 수강신청 폼
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Box selectProposeApplyInfo(HashMap param) throws Exception{
		Box data = null;
        try {
 		    data = sqlWrap.queryForBox("selectProposeApplyInfo",param);
 		    if(data == null) data = new Box("");
        } catch ( Exception e ) {
        	throw e;
        } finally {

        }
		return data;
	}

	/**
	 * 과정에 속한 과목 리스트(교재정보포함)를 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public DataSet getSubjSeqBook(Box box) throws Exception {
		DataSet data = null;
        try {
 		    data = sqlWrap.queryForDataSet("selectProposeSubjectList",box.getMap());
        } catch ( Exception e ) {
        	throw e;
        } finally {

        }
		return data;
	}

	/**
	 * 교재신청한 리스트
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public DataSet getApplyBookList(Box box) throws Exception {
		DataSet data = null;
		DataSet data2 = null;
		HashMap<String,String> hmParam = new HashMap<String,String>();
        try {
        	data = sqlWrap.queryForDataSet("selectProposeSubjectList", box.getMap());
 		    while ( data != null && data.getRow() > 0 && data.next() ) {
 		    	if ( data.getString("ISONOFF").equals("READ") ) {
 		    		hmParam.put("p_subj", data.getString("SUBJ"));
 		    		hmParam.put("p_year", data.getString("YEAR"));
 		    		hmParam.put("p_subjseq", data.getString("SUBJSEQ"));
 		    		hmParam.put("p_userid", data.getString("USERID"));
 		    		data2 = sqlWrap.queryForDataSet("selectSelSubjBook", hmParam);
 		    		data.getCurBox().put("dsSelSubjBook", data2);
 		    	}
 		    }

 		    data.setPos();

        } catch ( Exception e ) {
        	throw e;
        } finally {

        }
		return data;
	}
	
	/**
	 * 단체신청 시 학생정보 반환 및 추가&삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Box checkProposeStudent(HashMap param) throws Exception{
		Box data = null;
		try{
			data = sqlWrap.queryForBox("checkProposeStudent",param);
		}catch(Exception e){
			throw e;
		}finally{
			
		}
		return data;
	}	
	
	public Box readProposeStudentSEQ(HashMap param) throws Exception{
		Box data = null;
		try{
			data = sqlWrap.queryForBox("readProposeStudentSEQ",param);
		}catch(Exception e){
			throw e;
		}finally{
			
		}
		return data;
	}
	
	public DataSet selectProposeStudent(HashMap param) throws Exception{
		DataSet data = null;
		try{
			data = sqlWrap.queryForDataSet("selectProposeStudent",param);
		}catch(Exception e){
			throw e;
		}finally{
			
		}
		return data;
	}		

	/**
	 * 마이페이지 수강리스트를  반환한다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public DataSet getProposeList(Box box) throws Exception{
		DataSet data = null;
        try{
        	HashMap param = box.getMap();
 		    data = sqlWrap.queryForDataSet("selectProposeUser",param);
        }catch(Exception e){
        	throw e;
        }finally{

        }
		return data;
	}

	public Box getStudentDetail(HashMap param) throws Exception{
		Box data = null;
        try{
 		    data = sqlWrap.queryForBox("selectStudentDetail",param);
 		    if(data == null) data = new Box("");
        }catch(Exception e){
        	throw e;
        }finally{

        }
		return data;
	}
	public Box checkStudentDetail(HashMap param) throws Exception{
		Box data = null;
		try{
			data = sqlWrap.queryForBox("checkStudentDetail",param);
			if(data == null) data = new Box("");
		}catch(Exception e){
			throw e;
		}finally{
			
		}
		return data;
	}
	public Box getProposeDetail(HashMap param) throws Exception{
		Box data = null;
        try{
 		    data = sqlWrap.queryForBox("selectProposeDetail",param);
 		    if(data == null) data = new Box("");
        }catch(Exception e){
        	throw e;
        }finally{

        }
		return data;
	}

	/**
	 * 수강중인 과정 정보를 반환한다.
	 *
	 * @return  DataSet
	 */
	public DataSet getProposeListIng(Box box) throws Exception{
		DataSet data = null;
        try {
        	HashMap param = box.getMap();
        	HashMap<String, String> hmParam = new HashMap<String, String>();
        	hmParam.put("p_userid", box.getString("s_userid"));
 		    data = sqlWrap.queryForDataSet("selectProposeUserIng",param);
 		    
 		    for ( int i=0; data != null && data.next(); i++ ) {
 		       	String v_subj = data.getString("SUBJ");
				String v_year = data.getString("YEAR");
				String v_subjseq = data.getString("SUBJSEQ");
				
				hmParam.put("p_subj", v_subj);
				hmParam.put("p_year", v_year);
				hmParam.put("p_subjseq", v_subjseq);
				DataSet recogstate = sqlWrap.queryForDataSet("selectRefundSubjIng", hmParam);
				if(recogstate.next()) {
					data.getCurBox().put("RECOGSTATE", recogstate.getString("recogstate"));
				} else {
					data.getCurBox().put("RECOGSTATE", "N");
				}
			}
 		    data.setPos(); 		    
        } catch(Exception e) {
        	throw e;
        } finally{

        }
		return data;
	}

	/**
	 * 선택적 부분수강 리스트
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public DataSet getProposeListSel(Box box) throws Exception{
		DataSet data = null;
        try {
        	HashMap param = box.getMap();
 		    data = sqlWrap.queryForDataSet("selectProposeUserSel",param);
        } catch(Exception e) {
        	throw e;
        } finally{

        }
		return data;
	}

	/**
	 * 수강 완료한 과정을 반환한다.
	 *
	 * @return  DataSet
	 */
	public DataSet getProposeListDone(Box box) throws Exception{
		DataSet data = null;
		String p_year = box.getString("p_gyear");

        try{
        	if(StringUtil.isNull(p_year)) {
        		p_year = DateTimeUtil.getYear();
        	}
        	box.put("p_year", p_year);
        	HashMap param = box.getMap();
//        	data = sqlWrap.queryForDataSet("selectProposeUserALLDone",param);
        	data = sqlWrap.queryForDataSet("selectProposeUserDone",param);
        	if( box.getString("p_gyear").compareTo("2009") <= 0 )  {
//        		data = sqlWrap.queryForDataSet("selectProposeUserDone",param);
        		//data = sqlWrap.queryForDataSet("selectProposeUser2009Done",param);
        	}else {
        		//data = sqlWrap.queryForDataSet("selectProposeUserDone",param);
        	}

        }catch(Exception e){
        	throw e;
        }finally{

        }
		return data;
	}

	/**
	 * 수강 연기한 정보를 반환한다.
	 *
	 * @return  DataSet
	 */
	public DataSet getProposeDelayList(Box box) throws Exception{
		DataSet data = null;
        try{
        	HashMap param = box.getMap();
 		    data = sqlWrap.queryForDataSet("selectDelayListUser",param);
        }catch(Exception e){
        	throw e;
        }finally{

        }
		return data;
	}

	/**
	 * 마이페이지 수강리스트를  반환한다.
	 * 배송정보와  교재정보를 같이 반환한다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public DataSet getProposeListAllInfo(Box box) throws Exception {
		DataSet data = null;
        try {
        	String isb2b = box.getString("p_btobyn");
        	if ( isb2b.equals("Y") ) {
        		data = sqlWrap.queryForDataSet("selectProposeUserPre", box.getMap());
        	} else {
        		data = sqlWrap.queryForDataSet("selectProposeUserPreB2C", box.getMap());
        	}
 		    //교재와 배송정보를 정보를 가져온다.
			HashMap<String,String> hmParam = new HashMap<String,String>();
			hmParam.put("p_userid", box.getString("s_userid"));

			for ( int i=0; data != null && data.next(); i++ ) {
				if ( data.getString("SUBJTYPE").equals("S") ) {
					String v_subj = data.getString("SUBJ");
					String v_year = data.getString("YEAR");
					String v_subjseq = data.getString("SUBJSEQ");
					String v_isonoff = data.getString("ISONOFF");
					String v_usebook = data.getString("USEBOOK");
					String v_appbookyn = data.getString("APPBOOKYN");

					hmParam.put("p_subj", v_subj);
					hmParam.put("p_year", v_year);
					hmParam.put("p_subjseq", v_subjseq);

					if ( v_isonoff.equals("READ") ) {
						DataSet bookList = sqlWrap.queryForDataSet("selectStudyBookUser", hmParam);
						data.getCurBox().put("BookList", bookList);
						DataSet deliveryList = sqlWrap.queryForDataSet("selectStudyDeliveryUser", hmParam);
						data.getCurBox().put("DeliveryList", deliveryList);

					} else if ( v_usebook.equals("Y") && v_appbookyn.equals("Y") ) {
						DataSet deliveryList = sqlWrap.queryForDataSet("selectStudyDeliveryUser", hmParam);
						data.getCurBox().put("DeliveryList", deliveryList);
					}
				}
			}

			data.setPos();

        } catch ( Exception e ) {
        	throw e;
        } finally {

        }
		return data;
	}

	/**
	 * 종합실적정보를 반환한다.
	 *
	 * @return  DataSet
	 */
	public DataSet getTotalResultList(Box box) throws Exception{
		DataSet data = null;
        try{
        	HashMap param = box.getMap();
 		    data = sqlWrap.queryForDataSet("selectStoldListUser",param);
        }catch(Exception e){
        	throw e;
        }finally{

        }
		return data;
	}

	/**
	 * 사용자 외부과정 수료정보를 반환한다.
	 * 사용안함
	 * @return  DataSet
	 */
	public DataSet getExternalResultList(Box box) throws Exception{
		DataSet data = null;
        try {
 		    data = sqlWrap.queryForDataSet("selectExternalStoldListUser", box.getMap());
        } catch ( Exception e ) {
        	throw e;
        } finally {

        }
		return data;
	}

	/**
	 *
	 * 이 메소드는(proposeWrite)
	 * 	- B2B 수강신청인 경우
	 *  - B2C 에서 결제가 성공 했을 경우에 호출 된다.
	 *
	 *
	 * 아래는 수강신청의 몇가지 경우이다.
	 * 1. 결제를 하지 않고 수강신청만 하는 경우
	 * 2. 결제와 수강신청을 같이 하는 경우
	 * 3. 결제만 하는 경우
	 *
	 * 1. 결제를 하지 않고 수강신청만 하는 경우
	 *  - B2B : 결제를 하지 않기 때문
	 *  - B2C : 수강신청만 하고 결제를 나중에 할 경우 혹은 결제를 실패 할 경우
	 *
	 * 2. 결제와 수강신청을 같이 하는 경우
	 *  - 무역마스터의 경우로 결제와 수강신청을 동시에 진행한다.
	 *  - 또한 선택과목을 결정하게 되는데 폼 이름은 p_bookappyn 이다 ( 값예시:17_2010_0017_Y)
	 *
	 * 3. 결제만 하는 경우
	 *  - B2C 일반 : 수강신청 과정에서 결제를 안한(혹은 못한) 경우
	 *  - 무역마스터과정 : 분납 결제
	 *
	 * @param box
	 * @return
	 * @throws Exception
	 */
//	public int proposeWrite(Box box, boolean blTran) throws Exception {
//		int retVal = 0;
//
//		box.put("p_comp", box.getString("s_comp"));
//		box.put("p_userid", box.getString("s_userid"));
//		box.put("p_gyear", box.getString("p_year"));
//
//		// 수강신청 정보를 가져온다.
//		ProposeMgr proposeMgr = new ProposeMgr();
//		Box boxProposeApplyInfo = proposeMgr.selectProposeApplyInfo(box.getMap());
//
//		String v_trainingclass = boxProposeApplyInfo.getString("TRAININGCLASS");
//		String v_btobyn = boxProposeApplyInfo.getString("BTOBYN");
//		String v_proposeyn = boxProposeApplyInfo.getString("PROPOSEYN");
//		String v_isoptsubjectselect = box.getStringDefault("p_isoptsubjectselect", boxProposeApplyInfo.getString("ISOPTSUBJECTSELECT"));
//		String v_isinstallment = boxProposeApplyInfo.getString("ISINSTALLMENT");
//		String v_paystate = boxProposeApplyInfo.getString("PAYSTATE");
//
//		box.put("boxProposeApplyInfo", boxProposeApplyInfo);
//		box.put("p_trainingclass", v_trainingclass);
//		box.put("p_btobyn", v_btobyn);
//		box.put("p_proposeyn", v_proposeyn);
//		box.put("p_isoptsubjectselect", v_isoptsubjectselect);
//		box.put("p_isinstallment", v_isinstallment);
//		box.put("p_paystate", v_paystate);
//
//		HashMap<String,String> hmParam = new HashMap<String,String>();
//		hmParam.put("p_subj", box.getString("p_subj"));
//		hmParam.put("p_year", box.getString("p_year"));
//		hmParam.put("p_subjseq", box.getString("p_subjseq"));
//		hmParam.put("p_userid", box.getString("s_userid"));
//		hmParam.put("s_userid", box.getString("s_userid"));
//		hmParam.put("p_chkfinal", "Y");	// 결제가 완료 되었으면 Y 아니면 M
//		hmParam.put("p_essenyn", "Y");
//		hmParam.put("p_isdinsert", "N");
//
//		String[] arrTmp = null;
//
//		try {
//
//			if(blTran)	sqlWrap.startTransaction();
//
//			// B2B 수강신청
//			if ( v_btobyn.equals("Y") ) {
//				// 수강신청 insert
//				sqlWrap.insert("insertProposeBL", hmParam);
//
//				// 수강생 insert
//				sqlWrap.insert("insertStudentBL", hmParam);
//
//				// 배송정보 insert
//				hmParam.put("p_name", box.getString("p_name"));
//				hmParam.put("p_rcvrtel", box.getString("p_rcvrtel"));
//				hmParam.put("p_rcvrmobile", box.getString("p_rcvrmobile"));
//				hmParam.put("p_rcvrzipcode", box.getString("p_rcvrzipcode"));
//				hmParam.put("p_rcvraddr", box.getString("p_rcvraddr"));
//				hmParam.put("p_rcvrmsg", box.getString("p_rcvrmsg"));
//				hmParam.put("p_rcvemail", box.getString("p_rcvemail"));
//				sqlWrap.insert("insertSend", hmParam);
//				// 교재신청 insert
//				List bookappyn = (List)box.getList("p_bookappyn");	// 32_2010_0023_Y
//				List bookmonth = (List)box.getList("p_bookmonth");	// 32_2010_0023_1_3
//
//				HashMap<String,String> hmParam2 = new HashMap<String,String>();
//				// 우편과목이 아닐경우
//				if ( bookappyn != null && bookappyn.size() > 0 ) {
//					for ( int i=0; i < bookappyn.size(); i++ ) {
//						arrTmp = ((String)bookappyn.get(i)).split("_");
//						hmParam2.put("p_subj", arrTmp[0]);
//						hmParam2.put("p_year", arrTmp[1]);
//						hmParam2.put("p_subjseq", arrTmp[2]);
//						hmParam2.put("p_bookid", "0");
//						sqlWrap.insert("insertSelSubjBook", hmParam);
//					}
//				}
//				// 우편과목일 경우
//				if ( bookmonth != null && bookmonth.size() > 0 ) {
//					for ( int i=0; i < bookmonth.size(); i++ ) {
//						arrTmp = ((String)bookmonth.get(i)).split("_");
//						hmParam2.put("p_subj", arrTmp[0]);
//						hmParam2.put("p_year", arrTmp[1]);
//						hmParam2.put("p_subjseq", arrTmp[2]);
//						hmParam2.put("p_bookid", arrTmp[4]);
//						sqlWrap.insert("insertSelSubjBook", hmParam);
//					}
//				}
//			}
//			// B2C 수강신청
//			else {
//
//				// 수강신청 insert
//				sqlWrap.insert("insertProposeBL", hmParam);
//
//				// 수강생 insert
//				sqlWrap.insert("insertStudentBL", hmParam);
//
//				// 선택과목이 있다면
//				String v_osubjectid = box.getString("p_osubjectid");
//				if ( !v_osubjectid.equals("") ) {
//					String v_appbookyn = box.getString("p_appbookyn");
//					box.put("p_appbookyn", "N");
//					arrTmp = v_appbookyn.split("_");
//					hmParam.put("p_subj", arrTmp[0]);
//					hmParam.put("p_year", arrTmp[1]);
//					hmParam.put("p_subjseq", arrTmp[2]);
//					hmParam.put("p_appbookyn", "N");
//					hmParam.put("p_essenyn", "N");
//					sqlWrap.insert("insertProposeBL", hmParam);
//					sqlWrap.insert("insertStudentBL", hmParam);
//				}
//
//				// 배송정보 insert
//				hmParam.put("p_subj", box.getString("p_subj"));
//				hmParam.put("p_year", box.getString("p_year"));
//				hmParam.put("p_subjseq", box.getString("p_subjseq"));
//				hmParam.put("p_name", box.getString("p_name"));
//				hmParam.put("p_rcvrtel", box.getString("p_rcvrtel"));
//				hmParam.put("p_rcvrmobile", box.getString("p_rcvrmobile"));
//				hmParam.put("p_rcvrzipcode", box.getString("p_rcvrzipcode"));
//				hmParam.put("p_rcvraddr", box.getString("p_rcvraddr"));
//				hmParam.put("p_rcvrmsg", box.getString("p_rcvrmsg"));
//				hmParam.put("p_rcvemail", box.getString("p_rcvemail"));
//				sqlWrap.insert("insertSend", hmParam);
//			}
//
//			if(blTran) sqlWrap.commitTransaction();
//
//			retVal = 1;
//
//		} catch (Exception e) {
//			throw e;
//		} finally {
//			if(blTran) sqlWrap.endTransaction();
//		}
//		return retVal;
//	}



	public int proposePay(Box box) throws Exception {
		int retVal = 0;

		box.put("p_comp", box.getString("s_comp"));
		box.put("p_userid", box.getString("s_userid"));
		box.put("p_gyear", box.getString("p_year"));

		// 수강신청 정보를 가져온다.
		ProposeMgr proposeMgr = new ProposeMgr();
		Box boxProposeApplyInfo = proposeMgr.selectProposeApplyInfo(box.getMap());

		String v_trainingclass = boxProposeApplyInfo.getString("TRAININGCLASS");
		String v_btobyn = boxProposeApplyInfo.getString("BTOBYN");
		String v_proposeyn = boxProposeApplyInfo.getString("PROPOSEYN");
		String v_isoptsubjectselect = box.getStringDefault("p_isoptsubjectselect", boxProposeApplyInfo.getString("ISOPTSUBJECTSELECT"));
		String v_isinstallment = boxProposeApplyInfo.getString("ISINSTALLMENT");
		String v_paystate = boxProposeApplyInfo.getString("PAYSTATE");

		box.put("boxProposeApplyInfo", boxProposeApplyInfo);
		box.put("p_trainingclass", v_trainingclass);
		box.put("p_btobyn", v_btobyn);
		box.put("p_proposeyn", v_proposeyn);
		box.put("p_isoptsubjectselect", v_isoptsubjectselect);
		box.put("p_isinstallment", v_isinstallment);
		box.put("p_paystate", v_paystate);

		List bookappyn = (List)box.getList("p_bookappyn");

		try {
			HashMap param  = box.getMap();
			String isonoff = (String)param.get("p_isonoff");
			String usebook = (String)param.get("p_usebook");
			String usedelivery = (String)param.get("p_usedelivery");
			String v_comp		= box.getString("s_comp");
			String v_year	 	= box.getString("p_year");
			String v_subj	 	= box.getString("p_subj");
			String v_subjseq	= box.getString("p_subjseq");
			String v_userid		= box.getString("s_userid");

			param.put("p_userid", v_userid);
			param.put("p_applygubun", "B2B");
			param.put("p_isb2c", "N");
			param.put("p_chkfinal", "B");

			sqlWrap.startTransaction();

			//우편과정인 경우 교재정보를 입력한다.
			if(isonoff.equals("READ") || isonoff.equals("BL")) {
				retVal = insertBook(param);
			}

			//배송정보를 입력한다.
			if(isonoff.equals("READ") || usedelivery.equals("Y")) {
				retVal = insertDelivery(param);
			}
			retVal = insertPropose(param);

			//idp 업체인 경우에 역량쪽 API를 호출한다.
			//IDP/CDP 업체인 경우 역량쪽 프로시져를 호출하여,수강정보를 등록해준다.
			Object idpcdpResult = "";
			String idpcdpyn 	= (String)sqlWrap.queryForObject("getCompIdpcdpyn", v_comp );

			if("I".equals(idpcdpyn)) {
				param.put("p_coursenum", v_subj + "_" + v_year + "_" + v_subjseq);
				param.put("p_plancode", "i");
				sqlWrap.queryForObject("callPlanModify",param);
				String result = StringUtil.nvl(param.get("result"));
				String resultMsg = StringUtil.nvl(param.get("resultMsg"));
				if(!result.equals("S")) {
					throw new SQLException("수강생 등록에 실패했습니다.  call U_SCAP.P_PLAN_MODI [" + resultMsg + "]");

				}
			}

			sqlWrap.commitTransaction();
		} catch (Exception e) {
			throw e;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}

	public int proposeWriteB2B(Box box) throws Exception {

		int retVal = 0;

		// 수강신청 정보를 가져온다.
		Box boxProposeApplyInfo = sqlWrap.queryForBox("selectProposeApplyInfo", box.getMap());

		String v_trainingclass = boxProposeApplyInfo.getString("TRAININGCLASS");
		String v_btobyn = boxProposeApplyInfo.getString("BTOBYN");
		String v_proposeyn = boxProposeApplyInfo.getString("PROPOSEYN");
		String v_isoptsubjectselect = box.getStringDefault("p_isoptsubjectselect", boxProposeApplyInfo.getString("ISOPTSUBJECTSELECT"));
		String v_isinstallment = boxProposeApplyInfo.getString("ISINSTALLMENT");
		String v_paystate = boxProposeApplyInfo.getString("PAYSTATE");

		String v_isdelivery = boxProposeApplyInfo.getString("ISDELIVERY");

		box.put("boxProposeApplyInfo", boxProposeApplyInfo);
		box.put("p_trainingclass", v_trainingclass);
		box.put("p_btobyn", v_btobyn);
		box.put("p_proposeyn", v_proposeyn);
		box.put("p_isoptsubjectselect", v_isoptsubjectselect);
		box.put("p_isinstallment", v_isinstallment);
		box.put("p_paystate", v_paystate);

		HashMap<String,String> hmParam = new HashMap<String,String>();
		hmParam.put("p_subj", box.getString("p_subj"));
		hmParam.put("p_year", box.getString("p_year"));
		hmParam.put("p_subjseq", box.getString("p_subjseq"));
		hmParam.put("p_userid", box.getString("p_userid"));
		hmParam.put("s_userid", box.getString("s_userid"));
		hmParam.put("p_chkfinal", "M");
//		hmParam.put("p_essenyn", "Y");
		hmParam.put("p_isdinsert", "N");

		hmParam.put("p_costsupport", "");
		hmParam.put("p_isoptsubjectselect", "");
		hmParam.put("p_pricetype", "");
		hmParam.put("p_price", "0");
		hmParam.put("p_authtype", "");
		hmParam.put("p_authnum", "");

		String[] arrTmp = null;

		try {

			sqlWrap.startTransaction();

			// B2B 수강신청
			if ( v_btobyn.equals("Y") ) {
				// 수강신청 insert
				sqlWrap.insert("insertProposeBL", hmParam);

//				// 수강생 insert
//				sqlWrap.insert("insertStudentBL", hmParam);

				// 배송정보 insert
//				if ( v_isdelivery.equals("Y") ) {
//					hmParam.put("p_name", box.getString("p_name"));
					hmParam.put("p_rcvrtel", box.getString("p_rcvrtel"));
					hmParam.put("p_rcvrmobile", box.getString("p_rcvrmobile"));
					hmParam.put("p_rcvrzipcode", box.getString("p_rcvrzipcode"));
					hmParam.put("p_rcvraddr", box.getString("p_rcvraddr"));
					hmParam.put("p_rcvrmsg", box.getString("p_rcvrmsg"));
					hmParam.put("p_rcvemail", box.getString("p_rcvemail"));
					sqlWrap.insert("insertSend", hmParam);
//				}
				// 교재신청 insert
				List bookappyn = (List)box.getList("p_bookappyn");	// 32_2010_0023_Y_10000
				List bookmonth = (List)box.getList("p_bookmonth");	// 32_2010_0023_1_3

				HashMap<String,String> hmParam2 = new HashMap<String,String>();
				hmParam2.put("p_userid", box.getString("p_userid"));
				// 우편과목이 아닐경우
				if ( bookappyn != null && bookappyn.size() > 0 ) {
					for ( int i=0; i < bookappyn.size(); i++ ) {
						arrTmp = ((String)bookappyn.get(i)).split("_");
						hmParam2.put("p_subj", arrTmp[0]);
						hmParam2.put("p_year", arrTmp[1]);
						hmParam2.put("p_subjseq", arrTmp[2]);
						hmParam2.put("p_bookid", "0");
						sqlWrap.insert("insertSelSubjBook", hmParam2);
					}
				}
				// 우편과목일 경우
				if ( bookmonth != null && bookmonth.size() > 0 ) {
					for ( int i=0; i < bookmonth.size(); i++ ) {
						arrTmp = ((String)bookmonth.get(i)).split("_");
						hmParam2.put("p_subj", arrTmp[0]);
						hmParam2.put("p_year", arrTmp[1]);
						hmParam2.put("p_subjseq", arrTmp[2]);
						hmParam2.put("p_bookid", arrTmp[4]);
						sqlWrap.insert("insertSelSubjBook", hmParam2);
					}
				}
			}
			sqlWrap.commitTransaction();

			retVal = 1;

		} catch (Exception e) {
			throw e;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}


	/**
	 * 무역마스터 수강신청 및 결제
	 * @param request
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int proposeWriteTraid( HttpServletRequest request, Box box ) throws Exception {

		int retVal = 0;

		// 수강신청 정보를 가져온다.
		Box boxProposeApplyInfo = sqlWrap.queryForBox("selectProposeApplyInfo", box.getMap());

		String v_trainingclass = boxProposeApplyInfo.getString("TRAININGCLASS");
		String v_btobyn = boxProposeApplyInfo.getString("BTOBYN");
		String v_chkfinal = boxProposeApplyInfo.getString("CHKFINAL");
		String v_proposeyn = boxProposeApplyInfo.getString("PROPOSEYN");
		String v_isoptsubjectselect = box.getStringDefault("p_isoptsubjectselect", boxProposeApplyInfo.getString("ISOPTSUBJECTSELECT"));
		String v_isinstallment = boxProposeApplyInfo.getString("ISINSTALLMENT");

		// v_isinstallment 가  Y 일때..  p_installment_seq 의 값이 없을때는 1   (확인 요함 )
		//String  v_installment_seq = box.getString("p_installment_seq");

		String v_installment_seq = null;
		if( v_isinstallment.equals("Y") ) {
			v_installment_seq = box.getStringDefault("p_installment_seq","1");
		}else {
			v_installment_seq = box.getString("p_installment_seq");
		}

		String v_paystate = boxProposeApplyInfo.getString("PAYSTATE");
		//String v_price = boxProposeApplyInfo.getString("PRICE");
		String v_price = box.getString("p_price");
		String v_usemileage = box.getString("p_usemileage");
		String v_biyong	= boxProposeApplyInfo.getString("PRICE");   // 마일리지 차감전 금액

		String v_paymethod = box.getString("p_paymethod");
		String v_paymethod2 = null;

		// 결제 금액이 0 이고  마일리지 결제금액이 0 보다 크면 전액 마일리지 결제임.
		if( Integer.parseInt(v_price) == 0  && Integer.parseInt(v_usemileage) > 0 ){
			v_paymethod = "9998";
		}

		String v_isdelivery = boxProposeApplyInfo.getString("ISDELIVERY");

		box.put("boxProposeApplyInfo", boxProposeApplyInfo);
		box.put("p_trainingclass", v_trainingclass);
//		box.put("p_chkfinal", v_chkfinal);
		box.put("p_btobyn", v_btobyn);
		box.put("p_proposeyn", v_proposeyn);
		box.put("p_isoptsubjectselect", v_isoptsubjectselect);
		box.put("p_isinstallment", v_isinstallment);
		box.put("p_paystate", v_paystate);
		box.put("p_price", v_price);

		HashMap<String,String> hmParam = new HashMap<String,String>();
		hmParam = box.getMap();
		hmParam.put("p_price", v_price);
		hmParam.put("p_userid", box.getString("p_userid"));
		hmParam.put("p_essenyn", "Y");
		hmParam.put("p_isdinsert", "N");
		if ( v_btobyn.equals("Y") ) {
			return -4;	// B2C 과정이 아님
		}
		
		if ( !(v_trainingclass.equals("03")||v_trainingclass.equals("04")||v_trainingclass.equals("08")||v_trainingclass.equals("12")||v_trainingclass.equals("16")||v_trainingclass.equals("13")||v_trainingclass.equals("15")) ) {
			return -5;	// 무역마스터, IT마스터, 글로벌인턴쉽, 지부 장기 과정이 아님
		}
		if ( v_isinstallment.equals("N") && v_proposeyn.equals("Y") ) {
			return -6;	// 수강신청 되어 있으면 에러. 이과정은 수강신청과 결제가 동시에 이루어짐
		}
		if ( box.getString("_where").equals("B") ) {
			if ( v_isinstallment.equals("Y") && v_installment_seq.equals("") ) {
				Box boxPayInsSeq = sqlWrap.queryForBox("selectPayInstallmentSeqMin", box.getMap());
				if ( boxPayInsSeq.getString("SEQ").equals("") ) {
					return -7;
				}
				box.put("p_installment_seq", boxPayInsSeq.getString("SEQ"));
			}
		} else {
			if ( v_isinstallment.equals("Y") && v_installment_seq.equals("") ) {
				return -7;
			}
		}

		try {

			sqlWrap.startTransaction();

			INIpay50 inipay = null;

			/**
			 * 1.결제 진행
			 */
			// 001000000000 - 무통장
			// 9999 - 개인수강금(임시)
			// 9998 - 전액 마일리지 결제
			if ( v_paymethod.equals("001000000000") || v_paymethod.equals("9999") ||  v_paymethod.equals("9998") ) {

				Box boxInipayInfo = this.getInipayInfo(box);
				box.put("boxInipayInfo", boxInipayInfo);

				inipay = new INIpay50();

//				inipay.SetField("inipayhome", boxInipayInfo.getString("INIPAYHOME"));	// 이니페이 홈디렉터리(상점수정 필요)
				inipay.SetField("inipayhome", "C:/INIpay50");	// 이니페이 홈디렉터리(상점수정 필요)
				inipay.SetField("mid", boxInipayInfo.getString("MID") ); 				// 상점아이디
				inipay.SetField("admin", boxInipayInfo.getString("ADMIN"));				// 키패스워드(상점아이디에 따라 변경)
				inipay.SetField("debug", boxInipayInfo.getString("DEBUG")); 			// 로그모드("true"로 설정하면 상세로그가 생성됨.)

				HashMap<String,String> hmInipayResult = new HashMap<String,String>();

				hmInipayResult.put("buyername", request.getParameter("buyername") ); 	// 구매자 명
				hmInipayResult.put("buyertel", request.getParameter("buyertel") ); 		// 구매자 연락처(휴대폰 번호 또는 유선전화번호)
				hmInipayResult.put("buyeremail",request.getParameter("buyeremail") ); 	// 구매자 이메일 주소
				hmInipayResult.put("url", "http://www.kitabtoc.com" ); 					// 실제 서비스되는 상점 SITE URL로 변경할것

				hmInipayResult.put("p_tid", boxProposeApplyInfo.getString("MOID")); 	// 거래번호
				hmInipayResult.put("p_resultcode", "00"); 								// 결과코드
				hmInipayResult.put("p_resultmsg", "이니시스결제 프로세스를 타지 않았음"); 		// 결과내용
				hmInipayResult.put("p_paymethod", v_paymethod); 							// 지불방법
				hmInipayResult.put("p_moid", boxProposeApplyInfo.getString("MOID")); 	// 상점주문번호
				//hmInipayResult.put("p_totprice", boxProposeApplyInfo.getString("PRICE")); 	// 결제완료금액
				hmInipayResult.put("p_totprice", v_price ); 	// 결제완료금액
				hmInipayResult.put("p_appldate", ""); 									// 이니시스 승인날짜
				hmInipayResult.put("p_applnum", ""); 		// 승인번호 - OCB Point/VBank 를 제외한 지불수단에 모두 존재.

				box.put("hmInipayResult", hmInipayResult);

				v_paymethod2 = "VBank";

				retVal = 1;

			} else {
				retVal = this.doINISecureResult(request, box);
				inipay = (INIpay50)box.getObject("inipay");
				v_paymethod2 = inipay.GetResult("PayMethod");
			}

//			retVal = this.doINISecureResult(request, box);
			inipay = (INIpay50)box.getObject("inipay");
			HashMap<String,String> hmParam2 = null;
			hmParam2 = (HashMap)box.getObject("hmInipayResult");
			hmParam2.putAll(hmParam);
//			hmParam2.put("p_paymethod", inipay.GetResult("PayMethod"));
			hmParam2.put("p_subj", box.getString("p_subj"));
			hmParam2.put("p_year", box.getString("p_year"));
			hmParam2.put("p_subjseq", box.getString("p_subjseq"));
			hmParam2.put("p_userid", box.getString("p_userid"));
			hmParam2.put("s_userid", box.getString("s_userid"));

			hmParam2.put("p_usemileage", box.getString("p_usemileage"));
			hmParam2.put("p_biyong", v_biyong );

			if ( retVal <= 0 ) {
				return retVal;
			}

			/**
			 * 2-1. 수강 신청이 안되어 있을 경우 수강신청
			 * 처음 수강신청 할때
			 */
			if ( v_proposeyn.equals("N") ) {

				// 수강신청서에서 사용자의 핸드폰 번호, 이메일이 없을 경우 입력 받아서 업데이트 한다.
				if ( hmParam2.get("p_email") != null || hmParam2.get("p_handphone") != null ) {
					sqlWrap.update("updateMemberInfo2", hmParam2);
					sqlWrap.update("updateKobzMemberInfo2", hmParam2);
				}

				// 카드 결제, 전액 마일리지 결제 의 경우 student 테이블에도 insert 해준다.
				if ( v_paymethod.equals("100000000000")  ||  v_paymethod.equals("9998") ) {

					hmParam2.put("p_chkfinal", "Y");	// 카드결제면 Y, 아니면 M ( 전액 마일리지 결제시 Y )

					// 수강신청 insert
					sqlWrap.insert("insertProposeBL", hmParam2);

					// 수강생 insert
					sqlWrap.insert("insertStudentBL", hmParam2);

				} else {

					hmParam2.put("p_chkfinal", "M");
					// 수강신청 insert
					sqlWrap.insert("insertProposeBL", hmParam2);
				}

				// 분납결제하는 과정일 경우 t_lms_proposepayinstall 에 insert
				if ( v_isinstallment.equals("Y") ) {
					//hmParam2.put("p_installment_seq", box.getString("p_installment_seq"));
					hmParam2.put("p_installment_seq", v_installment_seq );
					sqlWrap.insert("insertProposePayInstall", hmParam2);
				} else {
					hmParam2.put("p_installment_seq", "999");
				}

				// 선택과목이 있다면
				String v_osubjectid = box.getString("p_osubjectid");
				String[] arrTmp = null;
				if ( !v_osubjectid.equals("") ) {
					HashMap<String,String> hmParam3 = new HashMap<String,String>();
					String v_appbookyn = box.getString("p_appbookyn");
//					box.put("p_appbookyn", "N");
					arrTmp = v_appbookyn.split("_");
					hmParam3.put("p_subj", arrTmp[0]);
					hmParam3.put("p_year", arrTmp[1]);
					hmParam3.put("p_subjseq", arrTmp[2]);
//					hmParam3.put("p_appbookyn", "N");
					hmParam3.put("p_essenyn", "N");
					sqlWrap.insert("insertProposeBL", hmParam3);
					sqlWrap.insert("insertStudentBL", hmParam3);
					sqlWrap.insert("insertSelSubjBook", hmParam3);
				}


//				 배송정보 insert
//				hmParam.put("p_name", box.getString("p_name"));
//				hmParam.put("p_rcvrtel", box.getString("p_rcvrtel"));
//				hmParam.put("p_rcvrmobile", box.getString("p_rcvrmobile"));
//				hmParam.put("p_rcvrzipcode", box.getString("p_rcvrzipcode"));
//				hmParam.put("p_rcvraddr", box.getString("p_rcvraddr"));
//				hmParam.put("p_rcvrmsg", box.getString("p_rcvrmsg"));
//				hmParam.put("p_rcvemail", box.getString("p_rcvemail"));

				sqlWrap.insert("insertSend", hmParam2);


				// 책정보 입력
				// 책은 사용하지 않지만 나중을 위해 넣는걸로..
				sqlWrap.insert("insertSelSubjBookByAdmin", hmParam2);

				// insert t_pay_inipay
				hmParam2.put("p_paymethod", v_paymethod2);
				sqlWrap.insert("insertInipay", hmParam2);
				HashMap<String,String> hmParam4 = new HashMap<String,String>();
				hmParam4.putAll(hmParam2);
				hmParam4.put("p_paymethod", v_paymethod);
				hmParam4.put("p_amount", hmParam2.get("p_totprice"));
				//hmParam4.put("p_recogstate", (v_paymethod.equals("100000000000"))?"Y":"N");
				hmParam4.put("p_recogstate", (v_paymethod.equals("100000000000"))?"Y":(v_paymethod.equals("9998"))?"Y":"N" );
				hmParam4.put("p_islicense", "N");
				hmParam4.put("p_isopensubj", "N");
//				hmParam4.put("p_installment_seq", box.getString("p_installment_seq"));
				hmParam4.put("p_rightno", "");
				hmParam4.put("p_inningseq", "");

				// insert t_lms_payment
				if( v_paymethod.equals("9998")) hmParam2.put("p_appldate", DateTimeUtil.getDate()) ;
				hmParam4.put("p_paydate", hmParam2.get("p_appldate"));
				sqlWrap.insert("insertPayment", hmParam4);

			}
			// 2-2. 수강 신청이 되어 있을 경우 업데이트
			// 분납결제일 경우 두번째 부터
			else {

//				if ( v_paymethod.equals("100000000000") ) {
//					hmParam2.put("p_chkfinal", "Y");	// 카드결제면 Y, 아니면 M
//
//					// 신청정보 업데이트
//					sqlWrap.update("updateProposePay", hmParam2);
//
//					// 수강생 insert
//					if ( !v_chkfinal.equals("Y") ) {
//						sqlWrap.insert("insertStudentBL", hmParam2);
//					}
//
//				} else {
//					hmParam2.put("p_chkfinal", "M");
//					sqlWrap.update("updateProposePay", hmParam2);
//				}

				// 분납결제하는 과정일 경우 t_lms_proposepayinstall 에 insert
				if ( v_isinstallment.equals("Y") ) {
					hmParam2.put("p_installment_seq", box.getString("p_installment_seq"));
					sqlWrap.insert("insertProposePayInstall", hmParam2);
				} else {
					hmParam2.put("p_installment_seq", "999");
				}

				// 선택과목이 있다면
				String v_osubjectid = box.getString("p_osubjectid");
				String[] arrTmp = null;
				if ( !v_osubjectid.equals("") ) {
					HashMap<String,String> hmParam3 = new HashMap<String,String>();
					String v_appbookyn = box.getString("p_appbookyn");
					box.put("p_appbookyn", "N");
					arrTmp = v_appbookyn.split("_");
					hmParam3.put("p_subj", arrTmp[0]);
					hmParam3.put("p_year", arrTmp[1]);
					hmParam3.put("p_subjseq", arrTmp[2]);
//					hmParam3.put("p_appbookyn", "N");
//					hmParam.put("p_essenyn", "N");
					sqlWrap.insert("insertProposeBL", hmParam3);
					sqlWrap.insert("insertStudentBL", hmParam3);
					sqlWrap.insert("insertSelSubjBook", hmParam3);
				}

				// 배송정보 update
//				hmParam2.put("p_name", box.getString("p_name"));
//				hmParam2.put("p_rcvrtel", box.getString("p_rcvrtel"));
//				hmParam2.put("p_rcvrmobile", box.getString("p_rcvrmobile"));
//				hmParam2.put("p_rcvrzipcode", box.getString("p_rcvrzipcode"));
//				hmParam2.put("p_rcvraddr", box.getString("p_rcvraddr"));
//				hmParam2.put("p_rcvrmsg", box.getString("p_rcvrmsg"));
//				hmParam2.put("p_rcvemail", box.getString("p_rcvemail"));

				sqlWrap.update("updateSend", hmParam2);

				// insert t_pay_inipay
				hmParam2.put("p_paymethod", v_paymethod2);
				sqlWrap.insert("insertInipay", hmParam2);

				// insert t_lms_payment
				HashMap<String,String> hmParam4 = new HashMap<String,String>();
				hmParam4.putAll(hmParam2);
				hmParam4.put("p_paymethod", v_paymethod);
				hmParam4.put("p_amount", hmParam2.get("p_totprice"));
				//hmParam4.put("p_recogstate", (v_paymethod.equals("100000000000"))?"Y":"N");
				hmParam4.put("p_recogstate", (v_paymethod.equals("100000000000"))?"Y":(v_paymethod.equals("9998"))?"Y":"N" );
				hmParam4.put("p_islicense", "N");
				hmParam4.put("p_rightno", "");
				hmParam4.put("p_inningseq", "");
				if( v_paymethod.equals("9998")) hmParam2.put("p_appldate", DateTimeUtil.getDate()) ;
				hmParam4.put("p_paydate", hmParam2.get("p_appldate"));
				sqlWrap.insert("insertPayment", hmParam4);

			}

			// 마일리지 차감
			if(Integer.parseInt(v_usemileage) > 0 ){
				box.put("SUBJNM" , boxProposeApplyInfo.getString("SUBJNM"));
				this.doSaveUseMileage(box);
			}

			sqlWrap.commitTransaction();

//			if ( !(v_paymethod.equals("001000000000") || v_paymethod.equals("9999")) ) {
//				String tmp_TID = inipay.GetResult("tid");
//				inipay.SetField("type", "cancel"); 			// 고정
//				inipay.SetField("tid", tmp_TID); 			// 고정
//				inipay.SetField("cancelmsg", "Test"); 	// 취소사유
//				inipay.startAction();
//			}

		} catch ( Exception e ) {
			/*******************************************************************
			* 7. DB연동 실패 시 강제취소                                      *
			*                                                                 *
			* 지불 결과를 DB 등에 저장하거나 기타 작업을 수행하다가 실패하는  *
			* 경우, 아래의 코드를 참조하여 이미 지불된 거래를 취소하는 코드를 *
			* 작성합니다.                                                     *
			*******************************************************************/

			INIpay50 inipay = (INIpay50)box.getObject("inipay");

			String tmp_TID = inipay.GetResult("tid");
			inipay.SetField("type", "cancel"); 			// 고정
			inipay.SetField("tid", tmp_TID); 			// 고정
			inipay.SetField("cancelmsg", "DB FAIL"); 	// 취소사유
			inipay.startAction();

//			e.printStackTrace();

			retVal = -3;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}

	/**
	 * GLMP 수강신청
	 * @param request
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int proposeWriteGLMP( HttpServletRequest request, Box box ) throws Exception {

		int retVal = 0;

		// 수강신청 정보를 가져온다.
		Box boxProposeApplyInfo = sqlWrap.queryForBox("selectProposeApplyInfo", box.getMap());

		String v_trainingclass = boxProposeApplyInfo.getString("TRAININGCLASS");
		String v_btobyn = boxProposeApplyInfo.getString("BTOBYN");
		String v_chkfinal = boxProposeApplyInfo.getString("CHKFINAL");
		String v_proposeyn = boxProposeApplyInfo.getString("PROPOSEYN");
		String v_isoptsubjectselect = box.getStringDefault("p_isoptsubjectselect", boxProposeApplyInfo.getString("ISOPTSUBJECTSELECT"));
		String v_isinstallment = boxProposeApplyInfo.getString("ISINSTALLMENT");
		String v_installment_seq = box.getString("p_installment_seq");
		String v_paystate = boxProposeApplyInfo.getString("PAYSTATE");
		String v_price = boxProposeApplyInfo.getString("PRICE");
		String v_paymethod = box.getString("p_paymethod");
		String v_paymethod2 = null;

		box.put("boxProposeApplyInfo", boxProposeApplyInfo);
		box.put("p_trainingclass", v_trainingclass);
//		box.put("p_chkfinal", v_chkfinal);
		box.put("p_btobyn", v_btobyn);
		box.put("p_proposeyn", v_proposeyn);
		box.put("p_isoptsubjectselect", v_isoptsubjectselect);
		box.put("p_isinstallment", v_isinstallment);
		box.put("p_paystate", v_paystate);
		box.put("p_price", v_price);

		HashMap<String,String> hmParam = new HashMap<String,String>();
		hmParam = box.getMap();
		hmParam.put("p_price", v_price);
		hmParam.put("p_userid", box.getString("p_userid"));
		hmParam.put("p_essenyn", "Y");
		hmParam.put("p_isdinsert", "N");
		if ( v_btobyn.equals("Y") ) {
			return -4;	// B2C 과정이 아님
		}
		if ( !v_trainingclass.equals("06") ) {
			return -13;	// GLMP 과정이 아님
		}
		if ( v_isinstallment.equals("N") && v_proposeyn.equals("Y") ) {
			return -6;	// 수강신청 되어 있으면 에러. 이과정은 수강신청과 결제가 동시에 이루어짐
		}
		if ( v_isinstallment.equals("Y") && v_installment_seq.equals("") ) {
			return -7;	// 분납결제가 설정되어 있는데 분납 정보가 업을 경우
		}

		try {

			sqlWrap.startTransaction();

			INIpay50 inipay = null;

			/**
			 * 1.결제 진행
			 */
			// 001000000000 - 무통장
			if ( v_paymethod.equals("001000000000") ) {

				Box boxInipayInfo = this.getInipayInfo(box);
				box.put("boxInipayInfo", boxInipayInfo);

				inipay = new INIpay50();

//				inipay.SetField("inipayhome", boxInipayInfo.getString("INIPAYHOME"));	// 이니페이 홈디렉터리(상점수정 필요)
				inipay.SetField("inipayhome", "C:/INIpay50");	// 이니페이 홈디렉터리(상점수정 필요)
				inipay.SetField("mid", boxInipayInfo.getString("MID") ); 				// 상점아이디
				inipay.SetField("admin", boxInipayInfo.getString("ADMIN"));				// 키패스워드(상점아이디에 따라 변경)
				inipay.SetField("debug", boxInipayInfo.getString("DEBUG")); 			// 로그모드("true"로 설정하면 상세로그가 생성됨.)

				HashMap<String,String> hmInipayResult = new HashMap<String,String>();

				hmInipayResult.put("buyername", request.getParameter("buyername") ); 	// 구매자 명
				hmInipayResult.put("buyertel", request.getParameter("buyertel") ); 		// 구매자 연락처(휴대폰 번호 또는 유선전화번호)
				hmInipayResult.put("buyeremail",request.getParameter("buyeremail") ); 	// 구매자 이메일 주소
				hmInipayResult.put("url", "http://www.kitabtoc.com" ); 					// 실제 서비스되는 상점 SITE URL로 변경할것

				hmInipayResult.put("p_tid", boxProposeApplyInfo.getString("MOID")); 	// 거래번호
				hmInipayResult.put("p_resultcode", "00"); 								// 결과코드
				hmInipayResult.put("p_resultmsg", "이니시스결제 프로세스를 타지 않았음"); 		// 결과내용
				hmInipayResult.put("p_paymethod", v_paymethod); 							// 지불방법
				hmInipayResult.put("p_moid", boxProposeApplyInfo.getString("MOID")); 	// 상점주문번호
				hmInipayResult.put("p_totprice", boxProposeApplyInfo.getString("PRICE")); 	// 결제완료금액
				hmInipayResult.put("p_appldate", ""); 									// 이니시스 승인날짜
				hmInipayResult.put("p_applnum", ""); 		// 승인번호 - OCB Point/VBank 를 제외한 지불수단에 모두 존재.

				box.put("hmInipayResult", hmInipayResult);

				v_paymethod2 = "VBank";

				retVal = 1;

			} else {
				retVal = this.doINISecureResult(request, box);
				inipay = (INIpay50)box.getObject("inipay");
				v_paymethod2 = inipay.GetResult("PayMethod");
			}

//			retVal = this.doINISecureResult(request, box);
			inipay = (INIpay50)box.getObject("inipay");
			HashMap<String,String> hmParam2 = null;
			hmParam2 = (HashMap)box.getObject("hmInipayResult");
			hmParam2.putAll(hmParam);
//			hmParam2.put("p_paymethod", inipay.GetResult("PayMethod"));
			hmParam2.put("p_subj", box.getString("p_subj"));
			hmParam2.put("p_year", box.getString("p_year"));
			hmParam2.put("p_subjseq", box.getString("p_subjseq"));
			hmParam2.put("p_userid", box.getString("p_userid"));
			hmParam2.put("s_userid", box.getString("s_userid"));
			hmParam2.put("p_installment_seq", "999");	// GLMP는 분납결제 를 하지 않는다.

			if ( retVal <= 0 ) {
				return retVal;
			}
			//hmParam2.put("p_jumin", hmParam2.get("p_jumin1")+hmParam2.get("p_jumin2"));	//주민등록번호 제거
			//hmParam2.put("p_wjumin", hmParam2.get("p_wjumin1")+hmParam2.get("p_wjumin2"));	//배우자 주민번호 제거

			hmParam2.put("p_tel", StringUtil.ReplaceAll(hmParam2.get("p_tel1")+"-"+hmParam2.get("p_tel2")+"-"+hmParam2.get("p_tel3"),"--",""));
			hmParam2.put("p_handphone", StringUtil.ReplaceAll(hmParam2.get("p_handphone1")+"-"+hmParam2.get("p_handphone2")+"-"+hmParam2.get("p_handphone3"),"--",""));

			hmParam2.put("p_otel", StringUtil.ReplaceAll(hmParam2.get("p_otel1")+"-"+hmParam2.get("p_otel2")+"-"+hmParam2.get("p_otel3"),"--",""));
			hmParam2.put("p_ofax", StringUtil.ReplaceAll(hmParam2.get("p_ofax1")+"-"+hmParam2.get("p_ofax2")+"-"+hmParam2.get("p_ofax3"),"--",""));

			hmParam2.put("p_ctel", StringUtil.ReplaceAll(hmParam2.get("p_ctel1")+"-"+hmParam2.get("p_ctel2")+"-"+hmParam2.get("p_ctel3"),"--",""));
			hmParam2.put("p_chandphone", StringUtil.ReplaceAll(hmParam2.get("p_chandphone1")+"-"+hmParam2.get("p_chandphone2")+"-"+hmParam2.get("p_chandphone3"),"--",""));
			hmParam2.put("p_cfax", StringUtil.ReplaceAll(hmParam2.get("p_cfax1")+"-"+hmParam2.get("p_cfax2")+"-"+hmParam2.get("p_cfax3"),"--",""));

			hmParam2.put("p_rtel", StringUtil.ReplaceAll(hmParam2.get("p_rtel1")+"-"+hmParam2.get("p_rtel2")+"-"+hmParam2.get("p_rtel3"),"--",""));


			// 카드 결제의 경우 student 테이블에도 insert 해준다.
			if ( v_paymethod.equals("100000000000") ) {

				hmParam2.put("p_chkfinal", "Y");	// 카드결제면 Y, 아니면 M

				// 수강신청 insert
				sqlWrap.insert("insertProposeBL", hmParam2);
				sqlWrap.insert("insertProposeForm", hmParam2);

				// 수강생 insert
				sqlWrap.insert("insertStudentBL", hmParam2);
//
//				// 책정보 입력
//				sqlWrap.insert("insertSelSubjBookByAdmin", hmParam2);

			} else {

				hmParam2.put("p_chkfinal", "M");
				// 수강신청 insert
				sqlWrap.insert("insertProposeBL", hmParam2);
				sqlWrap.insert("insertProposeForm", hmParam2);
			}

			// 책정보 입력
			// 책은 사용하지 않지만 나중을 위해 넣는걸로..
			sqlWrap.insert("insertSelSubjBookByAdmin", hmParam2);

			// insert t_pay_inipay
			hmParam2.put("p_paymethod", v_paymethod2);
			sqlWrap.insert("insertInipay", hmParam2);
			HashMap<String,String> hmParam4 = new HashMap<String,String>();
			hmParam4.putAll(hmParam2);
			hmParam4.put("p_paymethod", v_paymethod);
			hmParam4.put("p_amount", hmParam2.get("p_totprice"));
			hmParam4.put("p_recogstate", (v_paymethod.equals("100000000000"))?"Y":"N");
			hmParam4.put("p_islicense", "N");
//				hmParam4.put("p_installment_seq", box.getString("p_installment_seq"));
			hmParam4.put("p_rightno", "");
			hmParam4.put("p_inningseq", "");

			// insert t_lms_payment
			hmParam4.put("p_paydate", hmParam2.get("p_appldate"));
			sqlWrap.insert("insertPayment", hmParam4);

			sqlWrap.commitTransaction();

		} catch ( Exception e ) {
			/*******************************************************************
			* 7. DB연동 실패 시 강제취소                                      *
			*                                                                 *
			* 지불 결과를 DB 등에 저장하거나 기타 작업을 수행하다가 실패하는  *
			* 경우, 아래의 코드를 참조하여 이미 지불된 거래를 취소하는 코드를 *
			* 작성합니다.                                                     *
			*******************************************************************/

			INIpay50 inipay = (INIpay50)box.getObject("inipay");

			String tmp_TID = inipay.GetResult("tid");
			inipay.SetField("type", "cancel"); 			// 고정
			inipay.SetField("tid", tmp_TID); 			// 고정
			inipay.SetField("cancelmsg", "DB FAIL"); 	// 취소사유
			inipay.startAction();

//			e.printStackTrace();

			retVal = -3;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}
	/**
	 * GLMP 신청정보 수정
	 * @param request
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int proposeUpdateGLMP( HttpServletRequest request, Box box ) throws Exception {
		int retVal = 0;
		
		// 수강신청 정보를 가져온다.
		Box boxProposeApplyInfo = sqlWrap.queryForBox("selectProposeApplyInfo", box.getMap());
		
		String v_trainingclass = boxProposeApplyInfo.getString("TRAININGCLASS");
		String v_btobyn = boxProposeApplyInfo.getString("BTOBYN");
		String v_chkfinal = boxProposeApplyInfo.getString("CHKFINAL");
		String v_proposeyn = boxProposeApplyInfo.getString("PROPOSEYN");
		String v_isoptsubjectselect = box.getStringDefault("p_isoptsubjectselect", boxProposeApplyInfo.getString("ISOPTSUBJECTSELECT"));
		String v_isinstallment = boxProposeApplyInfo.getString("ISINSTALLMENT");
		String v_installment_seq = box.getString("p_installment_seq");
		String v_paystate = boxProposeApplyInfo.getString("PAYSTATE");
		String v_price = boxProposeApplyInfo.getString("PRICE");
		String v_paymethod = box.getString("p_paymethod");
		String v_paymethod2 = null;
		
		box.put("boxProposeApplyInfo", boxProposeApplyInfo);
		box.put("p_trainingclass", v_trainingclass);
//		box.put("p_chkfinal", v_chkfinal);
		box.put("p_btobyn", v_btobyn);
		box.put("p_proposeyn", v_proposeyn);
		box.put("p_isoptsubjectselect", v_isoptsubjectselect);
		box.put("p_isinstallment", v_isinstallment);
		box.put("p_paystate", v_paystate);
		box.put("p_price", v_price);
		
		HashMap<String,String> hmParam = new HashMap<String,String>();
		hmParam = box.getMap();
		hmParam.put("p_price", v_price);
		hmParam.put("p_userid", box.getString("p_userid"));
		hmParam.put("p_essenyn", "Y");
		hmParam.put("p_isdinsert", "N");
		if ( v_btobyn.equals("Y") ) {
			return -4;	// B2C 과정이 아님
		}
		if ( !v_trainingclass.equals("06") ) {
			return -13;	// GLMP 과정이 아님
		}
		/* 폼만 수정하므로 
		 if ( v_isinstallment.equals("N") && v_proposeyn.equals("Y") ) {
			return -6;	// 수강신청 되어 있으면 에러. 이과정은 수강신청과 결제가 동시에 이루어짐
		}*/
		if ( v_isinstallment.equals("Y") && v_installment_seq.equals("") ) {
			return -7;	// 분납결제가 설정되어 있는데 분납 정보가 업을 경우
		}
		try {
			
			sqlWrap.startTransaction();
			
			
			
//			retVal = this.doINISecureResult(request, box);
			HashMap<String,String> hmParam2 = new HashMap<String,String>();
			hmParam2.putAll(hmParam);
			//주민등록번호 제거
			//hmParam2.put("p_jumin", hmParam2.get("p_jumin1")+hmParam2.get("p_jumin2"));			
			//hmParam2.put("p_wjumin", hmParam2.get("p_wjumin1")+hmParam2.get("p_wjumin2"));
			
			hmParam2.put("p_tel", StringUtil.ReplaceAll(hmParam2.get("p_tel1")+"-"+hmParam2.get("p_tel2")+"-"+hmParam2.get("p_tel3"),"--",""));
			hmParam2.put("p_handphone", StringUtil.ReplaceAll(hmParam2.get("p_handphone1")+"-"+hmParam2.get("p_handphone2")+"-"+hmParam2.get("p_handphone3"),"--",""));
			
			hmParam2.put("p_otel", StringUtil.ReplaceAll(hmParam2.get("p_otel1")+"-"+hmParam2.get("p_otel2")+"-"+hmParam2.get("p_otel3"),"--",""));
			hmParam2.put("p_ofax", StringUtil.ReplaceAll(hmParam2.get("p_ofax1")+"-"+hmParam2.get("p_ofax2")+"-"+hmParam2.get("p_ofax3"),"--",""));
			
			hmParam2.put("p_ctel", StringUtil.ReplaceAll(hmParam2.get("p_ctel1")+"-"+hmParam2.get("p_ctel2")+"-"+hmParam2.get("p_ctel3"),"--",""));
			hmParam2.put("p_chandphone", StringUtil.ReplaceAll(hmParam2.get("p_chandphone1")+"-"+hmParam2.get("p_chandphone2")+"-"+hmParam2.get("p_chandphone3"),"--",""));
			hmParam2.put("p_cfax", StringUtil.ReplaceAll(hmParam2.get("p_cfax1")+"-"+hmParam2.get("p_cfax2")+"-"+hmParam2.get("p_cfax3"),"--",""));
			
			hmParam2.put("p_rtel", StringUtil.ReplaceAll(hmParam2.get("p_rtel1")+"-"+hmParam2.get("p_rtel2")+"-"+hmParam2.get("p_rtel3"),"--",""));
			
			
			sqlWrap.delete("deleteProposeFormGLMP", hmParam2);
			sqlWrap.insert("insertProposeForm", hmParam2);			
			
			// 책정보 입력
			// 책은 사용하지 않지만 나중을 위해 넣는걸로..
			//sqlWrap.insert("updateSelSubjBookByAdmin", hmParam2);
			
			
			sqlWrap.commitTransaction();
			retVal=1;
			
		} catch ( Exception e ) {
			
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}
		
	/**
	 * B2C 수강신청 ( 결제X )
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int proposeWriteB2C(Box box) throws Exception {
		int retVal = 0;
		
		// 수강신청 정보를 가져온다.
		Box boxProposeApplyInfo = sqlWrap.queryForBox("selectProposeApplyInfo", box.getMap());

		String v_trainingclass = boxProposeApplyInfo.getString("TRAININGCLASS");
		String v_btobyn = boxProposeApplyInfo.getString("BTOBYN");
		String v_proposeyn = boxProposeApplyInfo.getString("PROPOSEYN");
		String v_isoptsubjectselect = box.getStringDefault("p_isoptsubjectselect", boxProposeApplyInfo.getString("ISOPTSUBJECTSELECT"));
		String v_isinstallment = boxProposeApplyInfo.getString("ISINSTALLMENT");
		String v_installment_seq = box.getString("p_installment_seq");
		String v_paystate = boxProposeApplyInfo.getString("PAYSTATE");

		String v_isdelivery = boxProposeApplyInfo.getString("ISDELIVERY");
		
		// 단체신청
		String v_changePropose = box.getString("changePropose");
		int v_student = box.getInt("p_student");

		box.put("p_subj", box.getString("subj"));
		box.put("p_subjseq", box.getString("subjseq"));
		box.put("p_year", box.getString("year"));
		box.put("boxProposeApplyInfo", boxProposeApplyInfo);
		box.put("p_trainingclass", v_trainingclass);
		box.put("p_btobyn", v_btobyn);
		box.put("p_proposeyn", v_proposeyn);
		box.put("p_isoptsubjectselect", v_isoptsubjectselect);
		box.put("p_isinstallment", v_isinstallment);
		box.put("p_paystate", v_paystate);

		if ( v_btobyn.equals("Y") ) {
			return -4;	// B2C 과정이 아님
		}
		if ( v_proposeyn.equals("Y") ) {
			return -6;	// 이미 수강신청 되어 있음
		}
		if ( box.getString("_where").equals("B") ) {
			if ( v_isinstallment.equals("Y") && v_installment_seq.equals("") ) {
				Box boxPayInsSeq = sqlWrap.queryForBox("selectPayInstallmentSeqMin", box.getMap());
				if ( boxPayInsSeq.getString("SEQ").equals("") ) {
					return -7;
				}
				box.put("p_installment_seq", boxPayInsSeq.getString("SEQ"));
			}
		}

		HashMap<String,String> hmParam = new HashMap<String,String>();
		hmParam = box.getMap();

		hmParam.put("p_chkfinal", "M");	// 결제가 완료 되었으면 Y 아니면 M
		hmParam.put("p_essenyn", "Y");
		hmParam.put("p_isdinsert", "N");
		hmParam.put("p_isoptsubjectselect", "");
		hmParam.put("p_isb2c", "Y");
		hmParam.put("p_sulmun1", box.getString("p_sulmun1"));
		hmParam.put("p_sulmun2", box.getString("p_sulmun2"));
		hmParam.put("p_sulmun3", box.getString("p_sulmun3"));
		hmParam.put("p_sulmun4_1", box.getString("p_sulmun4_1"));
		hmParam.put("p_sulmun4_2", box.getString("p_sulmun4_2"));
		hmParam.put("p_sulmun5", box.getString("p_sulmun5"));
		hmParam.put("p_sulmun6", box.getString("p_sulmun6"));
		hmParam.put("p_sulmun1besides", box.getString("p_sulmun1besides"));
		hmParam.put("p_sulmun2besides", box.getString("p_sulmun2besides"));
		hmParam.put("p_sulmun3besides", box.getString("p_sulmun3besides"));
		hmParam.put("p_sulmun4_1besides", box.getString("p_sulmun4_1besides"));
		hmParam.put("p_sulmun4_2besides", box.getString("p_sulmun4_2besides"));
		hmParam.put("p_sulmun5besides", box.getString("p_sulmun5besides"));
		hmParam.put("p_sulmun6besides", box.getString("p_sulmun6besides"));
//		if ( box.getString("p_authnum").equals("") ) {
//			hmParam.put("p_authtype", "");
//		}
		
		/**
		 * 수강금액체크
		 */
		// 기본 교재비
		DataSet dsSubjectListBook = this.getSubjSeqBook(box);
		HashMap<String,String> hmBookPrice = new HashMap<String,String>();
		StringBuilder sbTmp = new StringBuilder();
		while ( dsSubjectListBook != null && dsSubjectListBook.getRow() > 0 && dsSubjectListBook.next() ) {
			sbTmp.append(dsSubjectListBook.getString("SUBJ")).append("_");
			sbTmp.append(dsSubjectListBook.getString("YEAR")).append("_");
			sbTmp.append(dsSubjectListBook.getString("SUBJSEQ")).append("_Y_");
			sbTmp.append(dsSubjectListBook.getString("BOOKPRICE"));
			hmBookPrice.put(sbTmp.toString(), dsSubjectListBook.getString("BOOKPRICE"));
			sbTmp.delete(0, sbTmp.length());
		}
		
		// 교제비 계산
		String[] arrTmp = null;
		List bookappyn = (List)box.getList("p_bookappyn");	// 32_2010_0023_Y_10000
		int v_bookpricesum = 0;
		String tmpBookPrice = null;
		for ( int i=0; i < bookappyn.size(); i++ ) {
			tmpBookPrice = (String)bookappyn.get(i);
			tmpBookPrice = tmpBookPrice.substring(tmpBookPrice.lastIndexOf("_")+1, tmpBookPrice.length());
			if ( !tmpBookPrice.equals(hmBookPrice.get((String)bookappyn.get(i))) ) {
				return -11; // 교재비 정보가 다름
			}
			v_bookpricesum += Integer.parseInt(tmpBookPrice);
		}
		if( v_changePropose.equals("1") && v_student > 0 ){		// 단체신청 시 
			v_bookpricesum = v_bookpricesum * v_student;
		}
		hmParam.put("p_bookpricesum", Integer.toString(v_bookpricesum));
		System.out.println("p_bookpricesum : "+hmParam.get("p_bookpricesum"));
		
		// 기본 교육비
		DataSet dsDiscountSubj = sqlWrap.queryForDataSet("getDiscountSubj", box.getString("p_subj"));
		HashMap<String,String> hmDiscountPrice = new HashMap<String,String>();
		while ( dsDiscountSubj != null && dsDiscountSubj.getRow() > 0 && dsDiscountSubj.next() ) {
			hmDiscountPrice.put(dsDiscountSubj.getString("TARGETCD"), dsDiscountSubj.getString("DCAMT"));
		}

		int v_biyong = 0;
		int v_biyong2 = 0;
		String v_pricetype = box.getString("p_pricetype");
		
		if( v_changePropose.equals("1") && v_student > 0 ){		// 단체신청 시 
			if ( v_pricetype.equals("98") ) {
				v_biyong = box.getInt("p_memberbiyong");
				v_biyong2 = boxProposeApplyInfo.getInt("MEMBERBIYONG") * v_student;
			} else if ( v_pricetype.equals("99") ) {
				v_biyong = box.getInt("p_biyong");
				v_biyong2 = boxProposeApplyInfo.getInt("BIYONG") * v_student;
			} else {
				v_biyong = box.getInt("p_special_"+v_pricetype);
				v_biyong2 = Integer.parseInt(hmDiscountPrice.get(v_pricetype)) * v_student;
			}
		} else {
			if ( v_pricetype.equals("98") ) {
				v_biyong = box.getInt("p_memberbiyong");
				v_biyong2 = boxProposeApplyInfo.getInt("MEMBERBIYONG");
			} else if ( v_pricetype.equals("99") ) {
				v_biyong = box.getInt("p_biyong");
				v_biyong2 = boxProposeApplyInfo.getInt("BIYONG");
			} else {
				v_biyong = box.getInt("p_special_"+v_pricetype);
				v_biyong2 = Integer.parseInt(hmDiscountPrice.get(v_pricetype));
			}
		}
		
		if ( v_biyong != v_biyong2 ) {
			return -10;	// 교육비 정보가 다름
		}
		hmParam.put("p_biyong", Integer.toString(v_biyong));
		System.out.println("p_biyong : "+hmParam.get("p_biyong"));

		// 사용한 마일리지
		int v_usemileage = 0;
		v_usemileage = box.getInt("p_usemileage");

		hmParam.put("p_usemileage", Integer.toString(v_usemileage));
		System.out.println("p_usemileage : "+hmParam.get("p_usemileage"));

		// 전체 교육비 계산
		int v_totprice = box.getInt("p_totprice");
		int v_totprice2 = v_biyong + v_bookpricesum - v_usemileage;
		System.out.println("v_totprice : "+v_totprice);
		System.out.println("v_totprice2 : "+v_totprice2);
		if ( v_totprice != v_totprice2 ) {
			return -12; // 전체 교육비 정보가 다름
		}
		hmParam.put("p_price", Integer.toString(v_totprice));
		System.out.println("p_price : "+hmParam.get("p_price"));

		try {

			sqlWrap.startTransaction();

			// B2C 수강신청
			if ( v_btobyn.equals("N") ) {

				// 수강신청서에서 사용자의 핸드폰 번호, 이메일이 없을 경우 입력 받아서 업데이트 한다.
				if ( hmParam.get("p_email") != null || hmParam.get("p_handphone") != null ) {
					sqlWrap.update("updateMemberInfo2", hmParam);
//					sqlWrap.update("updateKobzMemberInfo2", hmParam);
				}

				// 수강신청 insert
				sqlWrap.insert("insertProposeBL", hmParam);
				// 단기연수일경우에만 수강신청시 설문조사 insert
				if(v_trainingclass.equals("01")){
					sqlWrap.insert("insertSulmunResult", hmParam);
				}
				
				//자격시험연수과정일경우(외환관리사 실무과정) 설문내역 insert
				if(v_trainingclass.equals("05")){
					HashMap<String,String> rightPropSulmunParam = new HashMap<String,String>();
					rightPropSulmunParam.put("v_subj", boxProposeApplyInfo.getString("SUBJ"));
					rightPropSulmunParam.put("v_subjseq", boxProposeApplyInfo.getString("SUBJSEQ"));
					rightPropSulmunParam.put("v_userid", box.getString("s_userid"));
					rightPropSulmunParam.put("v_jikgun", box.getString("p_jikgun"));
					rightPropSulmunParam.put("v_jikguntext", box.getString("p_jikgunValue"));
					rightPropSulmunParam.put("v_trademasterseq", box.getString("p_trademasterseq"));
					rightPropSulmunParam.put("v_sulmun1", box.getString("sulmun1"));
					rightPropSulmunParam.put("v_sulmun1text", box.getString("sulmun1Value"));
					rightPropSulmunParam.put("v_sulmun2", box.getString("sulmun2"));
					rightPropSulmunParam.put("v_sulmun2text", box.getString("sulmun2Value"));
					rightPropSulmunParam.put("v_sulmun3", box.getString("sulmun3"));
					rightPropSulmunParam.put("v_sulmun3text", box.getString("sulmun3Value"));
					rightPropSulmunParam.put("v_sulmun4", box.getString("sulmun4"));
					rightPropSulmunParam.put("v_sulmun4text", box.getString("sulmun4Value"));
					rightPropSulmunParam.put("v_sulmun5", box.getString("sulmun5"));
					rightPropSulmunParam.put("v_sulmun5text", box.getString("sulmun5Value"));
					rightPropSulmunParam.put("v_sulmun6", box.getString("sulmun6"));
					rightPropSulmunParam.put("v_sulmun6text", box.getString("sulmun6Value"));
					rightPropSulmunParam.put("v_sulmun7text", box.getString("sulmun7Value"));
					rightPropSulmunParam.put("v_engname", box.getString("p_engname"));
					rightPropSulmunParam.put("v_proofempsavename", box.getString("p_proofempsavename"));
					rightPropSulmunParam.put("v_bizlicensesavename", box.getString("p_bizlicensesavename"));					
					rightPropSulmunParam.put("v_fxmlicensesavename", box.getString("p_fxmlicensesavename"));					
					rightPropSulmunParam.put("v_collegiansavename", box.getString("p_collegiansavename"));					
					rightPropSulmunParam.put("v_bankersavename", box.getString("p_bankersavename"));					
					rightPropSulmunParam.put("v_year", boxProposeApplyInfo.getString("YEAR"));
					
					sqlWrap.insert("insertRightPropSulmun", rightPropSulmunParam);
				}
				
				
				// 토익 특별시험 과정 부가정보 insert
				if ("Y".equals(box.getStringDefault("p_istoeic", "N"))) {
					HashMap<String,String> toeicParam = new HashMap<String,String>();
					toeicParam.put("v_userid", box.getString("s_userid"));
					toeicParam.put("v_subj", box.getString("p_subj"));
					toeicParam.put("v_subjseq", box.getString("p_subjseq"));
					toeicParam.put("v_isstudent", box.getString("p_isstudent"));
					toeicParam.put("v_recive", box.getString("p_recive"));
					
					sqlWrap.insert("insertToeic", toeicParam);
				}

				// 분납결제하는 과정일 경우 t_lms_proposepayinstall 에 insert
				if ( v_isinstallment.equals("Y") ) {
					if ( v_proposeyn.equals("N") && v_isinstallment.equals("Y") && v_installment_seq.equals("") ) {
						hmParam.put("p_installment_seq", "1");
					}
					sqlWrap.insert("insertProposePayInstall", hmParam);
				}

				// 배송정보 insert
//				if ( v_isdelivery.equals("Y") ) {
//					hmParam.put("p_name", box.getString("p_name"));
					hmParam.put("p_rcvrtel", box.getString("p_rcvrtel"));
					hmParam.put("p_rcvrmobile", box.getString("p_rcvrmobile"));
					hmParam.put("p_rcvrzipcode", box.getString("p_rcvrzipcode"));
					hmParam.put("p_rcvraddr", box.getString("p_rcvraddr"));
					hmParam.put("p_rcvrmsg", box.getString("p_rcvrmsg"));
					hmParam.put("p_rcvemail", box.getString("p_rcvemail"));
					sqlWrap.insert("insertSend", hmParam);
//				}

				// 교재신청 insert
//				List bookappyn = (List)box.getList("p_bookappyn");	// 32_2010_0023_Y_10000
				List bookmonth = (List)box.getList("p_bookmonth");	// 32_2010_0023_1_3

				HashMap<String,String> hmParam2 = new HashMap<String,String>();
				hmParam2.put("p_userid", box.getString("p_userid"));
				// 우편과목이 아닐경우
				if ( bookappyn != null && bookappyn.size() > 0 ) {
					for ( int i=0; i < bookappyn.size(); i++ ) {
						arrTmp = ((String)bookappyn.get(i)).split("_");
						hmParam2.put("p_subj", arrTmp[0]);
						hmParam2.put("p_year", arrTmp[1]);
						hmParam2.put("p_subjseq", arrTmp[2]);
						hmParam2.put("p_bookid", "0");
						hmParam2.put("p_bookprice", arrTmp[4]);
						sqlWrap.insert("insertSelSubjBook", hmParam2);
					}
				}
				// 우편과목일 경우
				if ( bookmonth != null && bookmonth.size() > 0 ) {
					for ( int i=0; i < bookmonth.size(); i++ ) {
						arrTmp = ((String)bookmonth.get(i)).split("_");
						hmParam2.put("p_subj", arrTmp[0]);
						hmParam2.put("p_year", arrTmp[1]);
						hmParam2.put("p_subjseq", arrTmp[2]);
						hmParam2.put("p_bookid", arrTmp[4]);
						sqlWrap.insert("insertSelSubjBook", hmParam2);
					}
				}

				// 마일리지 차감
				if(v_usemileage > 0 ){
					MileageMgr mileageMgr = new MileageMgr();
					box.put("p_point", box.getString("p_usemileage"));
					box.put("p_gubun","5555");
					box.put("p_content", boxProposeApplyInfo.getString("SUBJNM")+"과정  마일리지 차감.");
					box.put("p_useyn", "Y");
					mileageMgr.insertSaveMileage(box);
				}
				
				/**
				 * 단체 수강신청 시, 수강생 정보 추가
				 * changePropose = 1 : 단체신청
				 * 
				 */
				HashMap<String,String> hmParam3 = new HashMap<String,String>();
				ProposeMgr proposeMgr = new ProposeMgr();
				int student = 0;
//				int seq = 0;
				
				// 대표 id
				hmParam3.put("p_represent", box.getString("p_userid"));														// 테이블 관계설정을 위한 대표 아이디
				hmParam3.put("p_subj", box.getString("subj"));																// 수강과목
				hmParam3.put("p_subjseq", box.getString("subjseq"));														// 수강코드
				hmParam3.put("p_recogstate", "N");																			// 승인상태 (대기)
				
				// 대표아이디&수강생이 관계테이블 안에 있는지 확인, (* p_student_id는 조건에 포함시키지 않음)
				Box studentInfo = proposeMgr.checkProposeStudent(hmParam3);
				Box studentInfo_seq = proposeMgr.readProposeStudentSEQ(hmParam3);
				student = studentInfo.getInt("STUDENT");
//				seq = studentInfo_seq.getInt("SEQ");
				
				if( v_changePropose.equals("1") ){
					ArrayList<String> alStudentName = (ArrayList<String>)box.getList("p_studentName");
					if ( alStudentName != null && alStudentName.size() > 0 ) {
						ArrayList<String> alStudentBirthDay = (ArrayList<String>)box.getList("p_studentBirthDay");
						ArrayList<String> alStudentEmail = (ArrayList<String>)box.getList("p_studentEmail");
						ArrayList<String> alStudentPhone1 = (ArrayList<String>)box.getList("p_studentPhone1");
						ArrayList<String> alStudentPhone2 = (ArrayList<String>)box.getList("p_studentPhone2");
						ArrayList<String> alStudentPhone3 = (ArrayList<String>)box.getList("p_studentPhone3");
						
						for ( int i=0; i < alStudentName.size(); i++ ) {
							// 수강생 정보 가져오기
							hmParam3.put("p_name", alStudentName.get(i));																// 이름
							hmParam3.put("p_birthDay", alStudentBirthDay.get(i));														// 생년월일 (ex : 881004)
							hmParam3.put("p_email", alStudentEmail.get(i));																// e-mail
							hmParam3.put("p_handphone", alStudentPhone1.get(i)+"-"+alStudentPhone2.get(i)+"-"+alStudentPhone3.get(i));		// 휴대폰 번호 (ex : 010-0000-0000)
							
							// 확인
							System.out.println("p_name : "+hmParam3.get("p_name"));
							System.out.println("p_birthDay : "+hmParam3.get("p_birthDay"));
							System.out.println("p_email : "+hmParam3.get("p_email"));
							System.out.println("p_handphone : "+hmParam3.get("p_handphone"));
							System.out.println("p_represent : "+hmParam3.get("p_represent"));
							System.out.println("p_subj : "+hmParam3.get("p_subj"));
							System.out.println("p_subjseq : "+hmParam3.get("p_subjseq"));
							
							// 선증가
							++student;
//							++seq;
							
							// 대표&수강생 관계테이블에 수강생정보 넣기
							hmParam3.put("p_userid", box.getString("p_userid")+"_"+student);
//							hmParam3.put("p_student_seq", seq+"");
							sqlWrap.insert("insertProposeStudent", hmParam3);	
						}					
					} 
				}
			}
			sqlWrap.commitTransaction();

			retVal = 1;

		} catch (Exception e) {
			throw e;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}

	/**
	 * B2C 결제
	 * propose 테이블에 결제 정보를 업데이트 하고 결제를 진행한다.
	 * 업데이트 해야 될 필드
	 * TID				: 결제아이디
	 * AGREEYN			: 동의서 동의 여부
	 * ABNORMALTYPE		: 비정규구분 코드
	 * TRAINEETYPE 		: 훈련생구분 코드
	 * REFUNDBANKCD 	: 환급은행 코드
	 * REFUNDACCOUNT 	: 환급계좌번호
	 * EMP_COMPNM 		: 고용보험과정 - 회사명
	 * EMP_BUSINESSNUM 	: 고용보험과정 - 사업자번호
	 * PER_CARDNUM 		: 근로자능력개발카드환급과정 - 카드번호
	 * @param request
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int proposeWriteB2CPay( HttpServletRequest request, Box box ) throws Exception {

		int retVal = 0;

		try {
			Box boxProposeApplyInfo = sqlWrap.queryForBox("selectProposeApplyInfo", box.getMap());
			box.put("boxProposeApplyInfo", boxProposeApplyInfo);
			box.put("p_trainingarea", boxProposeApplyInfo.getString("TRAININGAREA"));  //추가_2013.12.03

			String v_trainingclass = boxProposeApplyInfo.getString("TRAININGCLASS");
			String v_btobyn = boxProposeApplyInfo.getString("BTOBYN");
			String v_proposeyn = boxProposeApplyInfo.getString("PROPOSEYN");
			String v_isoptsubjectselect = box.getStringDefault("p_isoptsubjectselect", boxProposeApplyInfo.getString("ISOPTSUBJECTSELECT"));
			String v_isinstallment = boxProposeApplyInfo.getString("ISINSTALLMENT");
			String v_paymethod = box.getString("p_paymethod");
			String v_paymethod2 = null;
			String v_price  = boxProposeApplyInfo.getString("PRICE");
			String v_usemileage = boxProposeApplyInfo.getString("USEMILEAGE");

			String _where = box.getString("_where");
			String v_paystate = boxProposeApplyInfo.getString("PAYSTATE");
			String v_payable = boxProposeApplyInfo.getString("PAYABLE");
			int v_paystateycnt = boxProposeApplyInfo.getInt("PAYSTATEYCNT");
			if ( v_payable.equals("N") ) {
				retVal = -15;
				return retVal;
			}
			// 결제내역이 없거나, 결제상태가 취소(C), 환불완료(E), 결제실패(F) 일 때만 결제를 할수 있다.
			// paystateycnt 는 취소, 환불, 결제 실패 이외의 상태값의 갯수이다. 이 갯수가 0보다 크면 결제나환불이 진행중이거나 완료된 상태가 있다는 의미이다(강제입과때문에 추가했음)
			if ( v_paystateycnt > 0 && !_where.equals("B") ) {
				retVal = -16;
				return retVal;
			}
			
			INIpay50 inipay = null;

			// 001000000000 - 무통장
			// 9999 - 개인수강금(임시)
			// 9998 - 전액 마일리지 결제
			if ( v_paymethod.equals("001000000000") || v_paymethod.equals("9999") || v_paymethod.equals("9998") ) {

				Box boxInipayInfo = this.getInipayInfo(box);
				box.put("boxInipayInfo", boxInipayInfo);

//				inipay = new INIpay50();
//
//				inipay.SetField("inipayhome", boxInipayInfo.getString("INIPAYHOME"));	// 이니페이 홈디렉터리(상점수정 필요)
//				inipay.SetField("mid", boxInipayInfo.getString("MID") ); 				// 상점아이디
//				inipay.SetField("admin", boxInipayInfo.getString("ADMIN"));				// 이니페이 홈디렉터리(상점수정 필요)
//				inipay.SetField("debug", boxInipayInfo.getString("DEBUG")); 			// 로그모드("true"로 설정하면 상세로그가 생성됨.)

				HashMap<String,String> hmInipayResult = new HashMap<String,String>();

				hmInipayResult.put("buyername", request.getParameter("buyername") ); 	// 구매자 명
				hmInipayResult.put("buyertel", request.getParameter("buyertel") ); 		// 구매자 연락처(휴대폰 번호 또는 유선전화번호)
				hmInipayResult.put("buyeremail",request.getParameter("buyeremail") ); 	// 구매자 이메일 주소
				hmInipayResult.put("url", "http://www.kitabtoc.com" ); 					// 실제 서비스되는 상점 SITE URL로 변경할것

				hmInipayResult.put("p_tid", boxProposeApplyInfo.getString("MOID")); 	// 거래번호
				hmInipayResult.put("p_resultcode", "00"); 								// 결과코드
				hmInipayResult.put("p_resultmsg", "이니시스결제 프로세스를 타지 않았음"); 		// 결과내용
				hmInipayResult.put("p_paymethod", v_paymethod); 							// 지불방법
				hmInipayResult.put("p_moid", boxProposeApplyInfo.getString("MOID")); 	// 상점주문번호
				hmInipayResult.put("p_totprice", boxProposeApplyInfo.getString("PRICE")); 	// 결제완료금액
				hmInipayResult.put("p_appldate", ""); 									// 이니시스 승인날짜
				hmInipayResult.put("p_applnum", ""); 		// 승인번호 - OCB Point/VBank 를 제외한 지불수단에 모두 존재.

				v_paymethod2 = "VBank";

				box.put("hmInipayResult", hmInipayResult);

				retVal = 1;

			} else {
				retVal = this.doINISecureResult(request, box);
				inipay = (INIpay50)box.getObject("inipay");
				v_paymethod2 = inipay.GetResult("PayMethod");
			}

			sqlWrap.startTransaction();
			HashMap<String,String> hmParam = null;
			HashMap<String,String> hmParam2 = new HashMap<String,String>();
			
			/**
			 * 대표 id 구분 (B2C 결제 입금시)
			 */
			
			// 대표 id인 경우에 저장
			HashMap<String,String> hmParam3 = new HashMap<String,String>();	
			Box box2 = null;
			ProposeMgr proposeMgr = new ProposeMgr();
			MemberMgr memberMgr = new MemberMgr();

			hmParam = (HashMap)box.getObject("hmInipayResult");
//			box.put("p_comp", box.getString("s_comp"));
//			box.put("p_userid", box.getString("s_userid"));
//			box.put("p_gyear", box.getString("p_year"));
			hmParam.put("p_subj", box.getString("p_subj"));
			hmParam.put("p_year", box.getString("p_year"));
			hmParam.put("p_subjseq", box.getString("p_subjseq"));
			hmParam.put("p_userid", box.getString("p_userid"));
			hmParam.put("s_userid", box.getString("s_userid"));

			if ( retVal > 0 ) {

				hmParam.put("p_agreeyn", box.getString("p_agreeyn"));
				hmParam.put("p_abnormaltype", box.getString("p_abnormaltype"));
				hmParam.put("p_traineetype", box.getString("p_traineetype"));
				hmParam.put("p_refundbankcd", box.getString("p_refundbankcd"));
				hmParam.put("p_refundaccount", box.getString("p_refundaccount"));
				hmParam.put("p_empcompnm", box.getString("p_empcompnm"));
				hmParam.put("p_empbusinessnum", box.getString("p_empbusinessnum"));
				hmParam.put("p_percardnum", box.getString("p_percardnum"));

				if ( v_paymethod.equals("100000000000") ||  v_paymethod.equals("9998") ) {
					hmParam.put("p_chkfinal", "Y");	// 카드결제면 Y, 아니면 M , 마일리지 입금완료: Y
					
					//** 결제 정보 입력 **/
					// 신청정보 업데이트
					sqlWrap.update("updateProposePay", hmParam);
					sqlWrap.insert("insertStudentBL", hmParam);
					 
					// 과목코드가 랭귀지큐브라면, 랭큐 회사에  입과를 위해 URL요청. 2015.06.03 by 안성현 
					if(box.getString("p_subj").equals("4230")){
						Box tempBox=sqlWrap.queryForBox("getUserInfoLangQ",box.getMap());
						
						box.put("p_handphone", tempBox.getString("HANDPHONE"));
						box.put("p_name", tempBox.getString("NAME"));
					}
					
					// 대표 id
					hmParam3.put("p_userid", hmParam.get("p_userid"));
					hmParam3.put("p_subj", hmParam.get("p_subj"));
					hmParam3.put("p_subjseq", hmParam.get("p_subjseq"));
					hmParam3.put("p_recogstate", "N");
					
					// 단체수강신청 여부 확인	
					DataSet selectProposeStudent = proposeMgr.selectProposeStudent(hmParam3);
					
					// 대표 id	(대표 id & 단체신청)
					if ( selectProposeStudent.getRow() > 0 ){
						System.out.println("대표 id & 단체신청 결제");
						hmParam3 = box.getMap();
						box2 = new Box(hmParam3);
						hmParam3.clear();
						
						box2.put("p_represent", 	hmParam.get("p_userid"));
						box2.put("p_userid", 		hmParam.get("p_userid"));
						box2.put("s_userid", 		hmParam.get("s_userid"));
						box2.put("p_subj", 			hmParam.get("p_subj"));
						box2.put("p_subjseq", 		hmParam.get("p_subjseq"));
						box2.put("p_year", 			hmParam.get("p_year"));
						box2.put("p_joincd", 		"03");												// 가입동기
						box2.put("p_price", 		0);													// 결제금액
						box2.put("p_biyong", 		0);													// 교육비
						box2.put("p_bookpricesum", 	0);													// 교재비
						box2.put("p_usemileage", 	0);													// 사용 마일리지
						box2.put("p_costsupport", 	"1004");
				        box2.put("p_anniversary", 	"");
						box2.put("p_income", 		"");
						box2.put("p_issms", 		"N");
						box2.put("p_ismailing", 	"N");
						box2.put("p_children", 		"0");
						box2.put("p_iskita", 		"Y");
						box2.put("p_mempath", 		"10");
						box2.put("p_isdinsert", 	"N");
						box2.put("p_isb2c", 		"Y");
				        box2.put("p_office_gbn", 	"Y");												// 로그인 시 필요
				        box2.put("p_recogstate", 	"Y");												// 승인상태 (완료)
												
						System.out.println("check !!");
						System.out.println("대표 p_userid : "+box2.get("p_userid"));
						System.out.println("대표 s_userid : "+box2.getString("s_userid"));
						System.out.println("대표 p_subj : "+box2.getString("p_subj"));
						System.out.println("대표 p_subjseq : "+box2.getString("p_subjseq"));
						System.out.println("대표 p_year : "+box2.getString("p_year"));					
						
						// 대표 id 정보 가져오기
						DataSet representInfo = null;
						representInfo = memberMgr.selectMemberDetail(box2);
						for(int i = 0; i< representInfo.getRow(); i++){
							representInfo.next();
							box2.put("p_postgb", 	representInfo.getString("POSTGB"));													// 우편물 접수처
							box2.put("p_jobc_csenr", representInfo.getString("JOBC_CSENR"));												// 직업
						}
						
						// 수강생 리스트 불러오기
						for( int i = 0 ; i < selectProposeStudent.getRow(); i++ ){
							selectProposeStudent.next();							
							box2.put("p_userid", 		selectProposeStudent.getString("USERID"));											// 수강생 아이디
							box2.put("p_name", 			selectProposeStudent.getString("NAME"));											// 수강생 이름
							box2.put("p_email", 		selectProposeStudent.getString("EMAIL"));											// 수강생 이메일
							box2.put("p_birthday", 		selectProposeStudent.getString("BIRTHDAY"));										// 수강생 생일
							box2.put("p_handphone", 	selectProposeStudent.getString("HANDPHONE"));										// 수강생 휴대폰
							box2.put("p_usergubun", 	"KC");																				// 유저구분 (일반)
							box2.put("p_resno", 		box2.getString("p_birthday")+"0000000");												// 주민등록번호
							box2.put("p_resno1", 		box2.getString("p_birthday"));														// 주민등록번호 앞자리
							box2.put("p_resno2", 		"0000000");																			// 주민등록번호 뒷자리
							box2.put("p_pwd", 			box2.getString("p_userid"));							
							box2.put("p_pwdconfirm", 	box2.getString("p_userid"));
							box2.put("p_pwd", 			(String) sqlWrap.queryForObject("selectNewPwd", box2.getString("p_pwd")));
							box2.put("emailID", 		box2.getString("p_email").substring(0, box2.getString("p_email").indexOf("@")));		// 이메일 앞자리
							box2.put("emailTail", 		box2.getString("p_email").substring(box2.getString("p_email").indexOf("@")+1));		// 이메일 뒷자리
							box2.put("p_emailid", 		box2.getString("emailID"));
							box2.put("p_emailaddr", 	box2.getString("emailTail"));
							box2.put("p_comp", 			"10000");
							box2.put("p_tel1", 			box2.getString("p_handphone").substring(0, 3));										// 전화번호
							box2.put("p_tel2", 			box2.getString("p_handphone").substring(4, 8));		
							box2.put("p_tel3", 			box2.getString("p_handphone").substring(9));
							box2.put("p_rcvrtel", 		box2.getString("p_tel1") +"-"+box2.getString("p_tel2")+"-"+box2.getString("p_tel3")) ;
							box2.put("p_rcvrmobile", 	box2.getString("p_handphone") ) ;
							
							System.out.println("--- 수강생 정보 ---");
							System.out.println("p_userid : "+box2.getString("p_userid"));
							System.out.println("p_name : "+box2.getString("p_name"));
							System.out.println("p_email : "+box2.getString("p_email"));
							System.out.println("p_birthday : "+box2.getString("p_birthday"));
							
							hmParam3 = box2.getMap();
							hmParam3.put("p_chkfinal", 		"M");	// 카드결제면 Y, 아니면 M , 마일리지 입금완료: Y
							hmParam3.put("p_tid", 			"");
							
							// 수강생 회원가입 시키기
							sqlWrap.insert("insertBtoCMember", hmParam3);
							
							//비밀번호 암호화 방식이 2014년 적용된 새로운 암호화 방식임을 알아보는  new_pwd_yn 컬럼 업데이트(t_lms_member) 및 merge(MEMBER_SUB_INFO@TRADE)
							String userID = box2.getString("p_userid");
							sqlWrap.update("updateMemberNewPwdYnIsY", userID);//t_lms_member 의 NEW_PWD_YN 컬럼 업데이트							
							
							// 수강생 수강신청
							hmParam3.put("p_isdinsert", "N");
							sqlWrap.insert("insertProposeBL", hmParam3);	
							System.out.println("수강생 수강신청 완료");
												
							// 수강생 수강승인  처리한다
							retVal = sqlWrap.update("updateProposeConfirmWithSubBL",hmParam3);		
							if ( retVal > 0 ) {
								System.out.println("수강생 수강승인 완료");
								
								// 대표&수강생 관계테이블 승인상태 업데이트
								sqlWrap.update("updateProposeStudent", hmParam3);
								System.out.println("대표&수강생 관계테이블 승인상태 업데이트");
								
								// 수강생 학생정보 업데이트
								retVal = sqlWrap.update("insertStudentBL", hmParam3);
								if ( retVal == 0 ) {
									System.out.println("수강생 학생정보 업데이트 실패");
									retVal = -1;
									return retVal ;
								}
							} else {
								System.out.println("수강생 수강승인 실패");
								retVal = -1;					// 수강테이블 업데이트에 실패하였습니다.
								return retVal;
							}
							System.out.println("수강생 학생정보 업데이트 완료");
						}
					}
					
				} else {
					hmParam.put("p_chkfinal", "M");
					sqlWrap.update("updateProposePay", hmParam);
				}


				//** 분납 결제 정보가 있다면 t_lms_proposepayinstall 테이블 update **//
				if ( v_isinstallment.equals("Y") ) {
					hmParam.put("p_installment_seq", box.getString("p_installment_seq"));
					// 결제후 분납결제 과정의 수강신청 정보 업데이트
					sqlWrap.update("updateProposePayInstall", hmParam);
				} else {
					hmParam.put("p_installment_seq", "999");
				}

				// insert t_pay_inipay
				hmParam.put("p_paymethod", v_paymethod2);
				sqlWrap.insert("insertInipay", hmParam);
//				hmParam2 = (HashMap<String, String>)hmParam.clone();
				hmParam2.putAll(hmParam);
				hmParam2.put("p_paymethod", v_paymethod);
				hmParam2.put("p_amount", hmParam.get("p_totprice"));
				hmParam2.put("p_usemileage", v_usemileage);
				hmParam2.put("p_recogstate", (v_paymethod.equals("100000000000"))?"Y":(v_paymethod.equals("9998"))?"Y":"N" );
				hmParam2.put("p_islicense", "N");
//				hmParam2.put("p_installment_seq", "");
				hmParam2.put("p_rightno", "");
				hmParam2.put("p_inningseq", "");

				// insert t_lms_payment
				if( v_paymethod.equals("9998")) hmParam.put("p_appldate", DateTimeUtil.getDate()) ;
				hmParam2.put("p_paydate", hmParam.get("p_appldate"));
				
				// 결제정보 입력
				sqlWrap.insert("insertPayment", hmParam2);
				
				// 과목코드가 랭귀지큐브라면, 랭큐 회사에  입과를 위해 URL요청2. 2015.06.11 by 안성현 
				if(( v_paymethod.equals("100000000000") ||  v_paymethod.equals("9998") ) && box.getString("p_subj").equals("4230")){
					
					String resultmsg= requestLangQ(box);
					
					((HashMap<String,String>)box.getMap()).put("p_memo", resultmsg);
					//카드결제이고, 과정코드가 랭큐라면 -> resultmsg(결과메시지)를 메모에 insert.
					
					int testVAl = sqlWrap.update("updateLangQMemo",box.getMap());
					
				}
				
				sqlWrap.commitTransaction();
			}

		} catch ( Exception e ) {
			/*******************************************************************
			* 7. DB연동 실패 시 강제취소                                      *
			*                                                                 *
			* 지불 결과를 DB 등에 저장하거나 기타 작업을 수행하다가 실패하는  *
			* 경우, 아래의 코드를 참조하여 이미 지불된 거래를 취소하는 코드를 *
			* 작성합니다.                                                     *
			*******************************************************************/

			INIpay50 inipay = (INIpay50)box.getObject("inipay");

			String tmp_TID = inipay.GetResult("tid");
			inipay.SetField("type", "cancel"); 			// 고정
			inipay.SetField("tid", tmp_TID); 			// 고정
			inipay.SetField("cancelmsg", "DB FAIL"); 	// 취소사유
			inipay.startAction();

			e.printStackTrace();

			retVal = -2;

		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}

	/**
	 * 골드패스 수강신청
	 * @param request
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int proposeWriteGOLD( HttpServletRequest request, Box box ) throws Exception {

		int retVal = 0;

		// 수강신청 정보를 가져온다.
		Box boxProposeApplyInfo = sqlWrap.queryForBox("selectProposeApplyInfo", box.getMap());

		String v_trainingclass = boxProposeApplyInfo.getString("TRAININGCLASS");
		String v_btobyn = boxProposeApplyInfo.getString("BTOBYN");
		String v_chkfinal = boxProposeApplyInfo.getString("CHKFINAL");
		String v_proposeyn = boxProposeApplyInfo.getString("PROPOSEYN");
		String v_isoptsubjectselect = box.getStringDefault("p_isoptsubjectselect", boxProposeApplyInfo.getString("ISOPTSUBJECTSELECT"));
		String v_isinstallment = boxProposeApplyInfo.getString("ISINSTALLMENT");
		String v_installment_seq = box.getString("p_installment_seq");
		String v_paystate = boxProposeApplyInfo.getString("PAYSTATE");
		String v_price = box.getString("p_price");
		String v_usemileage = box.getString("p_usemileage");
		String v_biyong	= boxProposeApplyInfo.getString("BIYONG");

		String v_paymethod = box.getString("p_paymethod");
		String v_paymethod2 = null;

		// 결제 금액이 0 이고  마일리지 결제금액이 0 보다 크면 전액 마일리지 결제임.
		if( Integer.parseInt(v_price) == 0  && Integer.parseInt(v_usemileage) > 0 ){
			v_paymethod = "9998";
		}

		String v_isdelivery = boxProposeApplyInfo.getString("ISDELIVERY");

		box.put("boxProposeApplyInfo", boxProposeApplyInfo);
		box.put("p_trainingclass", v_trainingclass);
//		box.put("p_chkfinal", v_chkfinal);
		box.put("p_btobyn", v_btobyn);
		box.put("p_proposeyn", v_proposeyn);
		box.put("p_isoptsubjectselect", v_isoptsubjectselect);
		box.put("p_isinstallment", v_isinstallment);
		box.put("p_paystate", v_paystate);
		box.put("p_price", v_price);

		HashMap<String,String> hmParam = new HashMap<String,String>();
		hmParam = box.getMap();
		hmParam.put("p_price", v_price);
		hmParam.put("p_userid", box.getString("p_userid"));
		hmParam.put("p_essenyn", "Y");
		hmParam.put("p_isdinsert", "N");


		if ( v_btobyn.equals("Y") ) {
			return -4;	// B2C 과정이 아님
		}
		if ( !v_trainingclass.equals("11") ) {
			return -14;	// 골드패스 과정이 아님
		}
		if ( v_isinstallment.equals("N") && v_proposeyn.equals("Y") ) {
			return -6;	// 수강신청 되어 있으면 에러. 이과정은 수강신청과 결제가 동시에 이루어짐
		}
		if ( box.getString("_where").equals("B") ) {
			if ( v_isinstallment.equals("Y") && v_installment_seq.equals("") ) {
				Box boxPayInsSeq = sqlWrap.queryForBox("selectPayInstallmentSeqMin", box.getMap());
				if ( boxPayInsSeq.getString("SEQ").equals("") ) {
					return -7;
				}
				box.put("p_installment_seq", boxPayInsSeq.getString("SEQ"));
			}
		} else {
			if ( v_isinstallment.equals("Y") && v_installment_seq.equals("") ) {
				return -7;
			}
		}
		HttpSession session = request.getSession();
		session.setAttribute("INI_PRICE"  ,  v_price );

		try {

			sqlWrap.startTransaction();

			INIpay50 inipay = null;

			/**
			 * 1.결제 진행
			 */
			// 001000000000 - 무통장
			// 9999 - 개인수강금(임시)
			// 9998 - 전액 마일리지 결제
			if ( v_paymethod.equals("001000000000") || v_paymethod.equals("9999") ||  v_paymethod.equals("9998") ) {

				Box boxInipayInfo = this.getInipayInfo(box);
				box.put("boxInipayInfo", boxInipayInfo);

				inipay = new INIpay50();

//				inipay.SetField("inipayhome", boxInipayInfo.getString("INIPAYHOME"));	// 이니페이 홈디렉터리(상점수정 필요)
				inipay.SetField("inipayhome", "C:/INIpay50");	// 이니페이 홈디렉터리(상점수정 필요)
				inipay.SetField("mid", boxInipayInfo.getString("MID") ); 				// 상점아이디
				inipay.SetField("admin", boxInipayInfo.getString("ADMIN"));				// 키패스워드(상점아이디에 따라 변경)
				inipay.SetField("debug", boxInipayInfo.getString("DEBUG")); 			// 로그모드("true"로 설정하면 상세로그가 생성됨.)

				HashMap<String,String> hmInipayResult = new HashMap<String,String>();

				hmInipayResult.put("buyername", request.getParameter("buyername") ); 	// 구매자 명
				hmInipayResult.put("buyertel", request.getParameter("buyertel") ); 		// 구매자 연락처(휴대폰 번호 또는 유선전화번호)
				hmInipayResult.put("buyeremail",request.getParameter("buyeremail") ); 	// 구매자 이메일 주소
				hmInipayResult.put("url", "http://www.kitabtoc.com" ); 					// 실제 서비스되는 상점 SITE URL로 변경할것

				hmInipayResult.put("p_tid", boxProposeApplyInfo.getString("MOID")); 	// 거래번호
				hmInipayResult.put("p_resultcode", "00"); 								// 결과코드
				hmInipayResult.put("p_resultmsg", "이니시스결제 프로세스를 타지 않았음"); 		// 결과내용
				hmInipayResult.put("p_paymethod", v_paymethod); 							// 지불방법
				hmInipayResult.put("p_moid", boxProposeApplyInfo.getString("MOID")); 	// 상점주문번호
				//hmInipayResult.put("p_totprice", boxProposeApplyInfo.getString("PRICE")); 	// 결제완료금액
				hmInipayResult.put("p_totprice", v_price ); 	// 결제완료금액
				hmInipayResult.put("p_appldate", ""); 									// 이니시스 승인날짜
				hmInipayResult.put("p_applnum", ""); 		// 승인번호 - OCB Point/VBank 를 제외한 지불수단에 모두 존재.

				box.put("hmInipayResult", hmInipayResult);

				v_paymethod2 = "VBank";

				retVal = 1;

			} else {
				retVal = this.doINISecureResult(request, box);
				inipay = (INIpay50)box.getObject("inipay");
				v_paymethod2 = inipay.GetResult("PayMethod");
			}

//			retVal = this.doINISecureResult(request, box);
			inipay = (INIpay50)box.getObject("inipay");
			HashMap<String,String> hmParam2 = null;
			hmParam2 = (HashMap)box.getObject("hmInipayResult");
			hmParam2.putAll(hmParam);
//			hmParam2.put("p_paymethod", inipay.GetResult("PayMethod"));
			hmParam2.put("p_subj", box.getString("p_subj"));
			hmParam2.put("p_year", box.getString("p_year"));
			hmParam2.put("p_subjseq", box.getString("p_subjseq"));
			hmParam2.put("p_userid", box.getString("p_userid"));
			hmParam2.put("s_userid", box.getString("s_userid"));
			hmParam2.put("p_usemileage", box.getString("p_usemileage"));
			hmParam2.put("p_biyong", v_biyong );

			if ( retVal <= 0 ) {
				return retVal;
			}

			// 수강신청서에서 사용자의 핸드폰 번호, 이메일이 없을 경우 입력 받아서 업데이트 한다.
			if ( hmParam2.get("p_email") != null || hmParam2.get("p_handphone") != null ) {
				sqlWrap.update("updateMemberInfo2", hmParam2);
				sqlWrap.update("updateKobzMemberInfo2", hmParam2);
			}

			// 카드 결제의 경우 student 테이블에도 insert 해준다.
			if ( v_paymethod.equals("100000000000") ||  v_paymethod.equals("9998") ) {

				hmParam2.put("p_chkfinal", "Y");	// 카드결제면 Y, 아니면 M  ( 전액 마일리지 결제시 Y )

				// 수강신청 insert
				sqlWrap.insert("insertProposeBL", hmParam2);

				// 수강생 insert
				sqlWrap.insert("insertStudentBL", hmParam2);

			} else {

				hmParam2.put("p_chkfinal", "M");
				// 수강신청 insert
				sqlWrap.insert("insertProposeBL", hmParam2);
			}

			// 책정보 입력
			sqlWrap.insert("insertSelSubjBookByAdmin", hmParam2);

			// insert t_pay_inipay
			hmParam2.put("p_paymethod", v_paymethod2);
			sqlWrap.insert("insertInipay", hmParam2);
			HashMap<String,String> hmParam4 = new HashMap<String,String>();
			hmParam4.putAll(hmParam2);
			hmParam4.put("p_paymethod", v_paymethod);
			hmParam4.put("p_amount", hmParam2.get("p_totprice"));
			hmParam4.put("p_recogstate", (v_paymethod.equals("100000000000"))?"Y":(v_paymethod.equals("9998"))?"Y":"N" );
			hmParam4.put("p_islicense", "N");
			hmParam4.put("p_isopensubj", "N");
//				hmParam4.put("p_installment_seq", box.getString("p_installment_seq"));
			hmParam4.put("p_rightno", "");
			hmParam4.put("p_inningseq", "");

			// insert t_lms_payment
			if( v_paymethod.equals("9998")) hmParam2.put("p_appldate", DateTimeUtil.getDate()) ;
			hmParam4.put("p_paydate", hmParam2.get("p_appldate"));
			hmParam4.put("p_installment_seq", "999");       //  분납이 아니므로 999
			sqlWrap.insert("insertPayment", hmParam4);

			// 마일리지 차감
			if(Integer.parseInt(v_usemileage) > 0 ){
				box.put("SUBJNM" , boxProposeApplyInfo.getString("SUBJNM"));
				this.doSaveUseMileage(box);
			}
			sqlWrap.commitTransaction();

		} catch ( Exception e ) {
			/*******************************************************************
			* 7. DB연동 실패 시 강제취소                                      *
			*                                                                 *
			* 지불 결과를 DB 등에 저장하거나 기타 작업을 수행하다가 실패하는  *
			* 경우, 아래의 코드를 참조하여 이미 지불된 거래를 취소하는 코드를 *
			* 작성합니다.                                                     *
			*******************************************************************/

			INIpay50 inipay = (INIpay50)box.getObject("inipay");

			String tmp_TID = inipay.GetResult("tid");
			inipay.SetField("type", "cancel"); 			// 고정
			inipay.SetField("tid", tmp_TID); 			// 고정
			inipay.SetField("cancelmsg", "DB FAIL"); 	// 취소사유
			inipay.startAction();

//			e.printStackTrace();

			retVal = -3;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}

	/**
	 * 수강취소 및 환불관련 규정 업데이트
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int proposeWriteRefundAgreeUpdate( Box box ) throws Exception {

		int retVal = 0;

		try {

			sqlWrap.startTransaction();
			retVal = sqlWrap.update("proposeWriteRefundAgreeUpdate", box.getMap());
			sqlWrap.commitTransaction();

			retVal = 1;

		} catch (Exception e) {
			throw e;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}

	/**
	 * 선택적 부분수강 수강신청
	 * @param request
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int proposeWriteSel( HttpServletRequest request, Box box ) throws Exception {

		int retVal = 0;

		// biyong 원금, price 최종 결제금액
		// 수강신청 정보를 가져온다.
		Box boxProposeApplyInfo = sqlWrap.queryForBox("selectProposeSelApplyInfo", box.getMap());

		String v_trainingclass = box.getString("p_trainingclass");
		//String v_price = boxProposeApplyInfo.getString("PRICE");
		String v_price = box.getString("p_price");
		String v_usemileage = box.getString("p_usemileage");
		String v_biyong	= boxProposeApplyInfo.getString("PRICE");

		String v_paymethod = box.getString("p_paymethod");
		String v_paymethod2 = null;

		// 결제 금액이 0 이고  마일리지 결제금액이 0 보다 크면 전액 마일리지 결제임.
		if( Integer.parseInt(v_price) == 0  && Integer.parseInt(v_usemileage) > 0 ){
			v_paymethod = "9998";
		}

		// 마일리지 적용때 나머지 적용
		box.put("boxProposeApplyInfo", boxProposeApplyInfo);
		box.put("p_price", v_price);
		box.put("p_biyong", v_biyong);

		HashMap<String,String> hmParam = new HashMap<String,String>();
		hmParam = box.getMap();
		hmParam.put("p_price", v_price);
		hmParam.put("p_biyong", v_biyong);
		hmParam.put("p_userid", box.getString("p_userid"));
		hmParam.put("p_isdinsert", "N");
		hmParam.put("p_isb2c", "Y");
		hmParam.put("p_usemileage",  box.getString("p_usemileage"));
		try {

			sqlWrap.startTransaction();

			INIpay50 inipay = null;

			/**
			 * 1.결제 진행
			 */
			// 03 - 무통장
			// 9999 - 개인수강금(임시)
			// 9998 - 전액 마일리지 결제
			if ( v_paymethod.equals("03") ||  v_paymethod.equals("9998") ) {

				Box boxInipayInfo = this.getInipayInfo(box);
				box.put("boxInipayInfo", boxInipayInfo);

				inipay = new INIpay50();

//				inipay.SetField("inipayhome", boxInipayInfo.getString("INIPAYHOME"));	// 이니페이 홈디렉터리(상점수정 필요)
				inipay.SetField("inipayhome", "C:/INIpay50");	// 이니페이 홈디렉터리(상점수정 필요)
				inipay.SetField("mid", boxInipayInfo.getString("MID") ); 				// 상점아이디
				inipay.SetField("admin", boxInipayInfo.getString("ADMIN"));				// 키패스워드(상점아이디에 따라 변경)
				inipay.SetField("debug", boxInipayInfo.getString("DEBUG")); 			// 로그모드("true"로 설정하면 상세로그가 생성됨.)

				HashMap<String,String> hmInipayResult = new HashMap<String,String>();

				hmInipayResult.put("buyername", request.getParameter("buyername") ); 	// 구매자 명
				hmInipayResult.put("buyertel", request.getParameter("buyertel") ); 		// 구매자 연락처(휴대폰 번호 또는 유선전화번호)
				hmInipayResult.put("buyeremail",request.getParameter("buyeremail") ); 	// 구매자 이메일 주소
				hmInipayResult.put("url", "http://www.kitabtoc.com" ); 					// 실제 서비스되는 상점 SITE URL로 변경할것

				hmInipayResult.put("p_tid", boxProposeApplyInfo.getString("MOID")); 	// 거래번호
				hmInipayResult.put("p_resultcode", "00"); 								// 결과코드
				hmInipayResult.put("p_resultmsg", "이니시스결제 프로세스를 타지 않았음"); 		// 결과내용
				hmInipayResult.put("p_paymethod", v_paymethod); 							// 지불방법
				hmInipayResult.put("p_moid", boxProposeApplyInfo.getString("MOID")); 	// 상점주문번호
				//hmInipayResult.put("p_totprice", boxProposeApplyInfo.getString("PRICE")); 	// 결제완료금액
				hmInipayResult.put("p_totprice", v_price ); 	// 결제완료금액
				hmInipayResult.put("p_appldate", ""); 									// 이니시스 승인날짜
				hmInipayResult.put("p_applnum", ""); 		// 승인번호 - OCB Point/VBank 를 제외한 지불수단에 모두 존재.

				box.put("hmInipayResult", hmInipayResult);

				v_paymethod2 = "VBank";

				retVal = 1;

			} else {
				retVal = this.doINISecureResult(request, box);
				inipay = (INIpay50)box.getObject("inipay");
				v_paymethod2 = inipay.GetResult("PayMethod");
			}

//			retVal = this.doINISecureResult(request, box);
			inipay = (INIpay50)box.getObject("inipay");
			HashMap<String,String> hmParam2 = null;
			hmParam2 = (HashMap)box.getObject("hmInipayResult");
			hmParam2.putAll(hmParam);
			hmParam2.put("p_userid", box.getString("p_userid"));
			hmParam2.put("s_userid", box.getString("s_userid"));

			if ( retVal <= 0 ) {
				return retVal;
			}

			// 수강신청서에서 사용자의 핸드폰 번호, 이메일이 없을 경우 입력 받아서 업데이트 한다.
			if ( hmParam2.get("p_email") != null || hmParam2.get("p_handphone") != null ) {
				sqlWrap.update("updateMemberInfo2", hmParam2);
				sqlWrap.update("updateKobzMemberInfo2", hmParam2);
			}

			// 카드 결제의 경우 student 테이블에도 insert 해준다., 전액 마일리지 수강시 student 테이블에도 insert 한다.
			if ( v_paymethod.equals("01") || v_paymethod.equals("04") ||  v_paymethod.equals("9998") ) {

				hmParam2.put("p_chkfinal", "Y");	// 카드결제면 Y, 아니면 M

				// 수강신청 insert
				sqlWrap.insert("insertProposeSel", hmParam2);

				Box boxTmp = sqlWrap.queryForBox("selectSubjSeqInfoFromTid", hmParam2);
				hmParam2.put("p_subj", boxTmp.getString("SUBJ"));
				hmParam2.put("p_year", boxTmp.getString("YEAR"));
				hmParam2.put("p_subjseq", boxTmp.getString("SUBJSEQ"));
				box.put("p_subj", boxTmp.getString("SUBJ"));
				box.put("p_yaer", boxTmp.getString("YEAR"));
				box.put("p_subjseq", boxTmp.getString("SUBJSEQ"));

				// 수강생 insert
				sqlWrap.insert("insertStudentSel", hmParam2);

			} else {

				hmParam2.put("p_chkfinal", "M");
				// 수강신청 insert
				sqlWrap.insert("insertProposeSel", hmParam2);

				Box boxTmp = sqlWrap.queryForBox("selectSubjSeqInfoFromTid", hmParam2);
				hmParam2.put("p_subj", boxTmp.getString("SUBJ"));
				hmParam2.put("p_year", boxTmp.getString("YEAR"));
				hmParam2.put("p_subjseq", boxTmp.getString("SUBJSEQ"));
				box.put("p_subj", boxTmp.getString("SUBJ"));
				box.put("p_year", boxTmp.getString("YEAR"));
				box.put("p_subjseq", boxTmp.getString("SUBJSEQ"));

//				// 수강생 insert
//				sqlWrap.insert("insertStudentSel", hmParam2);
			}

			HashMap<String,String> hmParam3 = new HashMap<String,String>();
			hmParam3.putAll(hmParam2);
			ArrayList v_grouplist = (ArrayList)box.getList("p_grouplist");
			String[] arrTmp = null;

			// 장바구니
			HttpSession session = request.getSession();
			String v_cartno 	=  (String)session.getAttribute("CART_NO");
			hmParam3.put("p_cartno", v_cartno);

			for ( int i=0; i < v_grouplist.size(); i++ ) {
				arrTmp = v_grouplist.get(i).toString().split("_");
				hmParam3.put("p_groupid", arrTmp[0]);
				hmParam3.put("p_biyong", arrTmp[2]);
				sqlWrap.insert("insertProposeOpenSubj", hmParam3);

				// 장바구니 삭제
				if(!StringUtil.isNull(v_cartno))
					sqlWrap.delete("deleteCartItem", hmParam3);

			}
			// 장바구니 존재 여부
			if (!StringUtil.isNull(v_cartno)){
				int cartcnt  = (Integer)sqlWrap.queryForObject("selectCartItemCnt", hmParam3);
				if(cartcnt <=0 )
					box.put("p_iscart", "N");
			}

			// insert t_pay_inipay
			hmParam2.put("p_paymethod", v_paymethod2);
			sqlWrap.insert("insertInipay", hmParam2);
			HashMap<String,String> hmParam4 = new HashMap<String,String>();
			hmParam4.putAll(hmParam2);
			hmParam4.put("p_isopensubj", "Y");
			hmParam4.put("p_paymethod", v_paymethod);
			hmParam4.put("p_amount", hmParam2.get("p_totprice"));
			//hmParam4.put("p_recogstate", (v_paymethod.equals("01")||v_paymethod.equals("04"))?"Y":"N");
			hmParam4.put("p_recogstate", (v_paymethod.equals("01")||v_paymethod.equals("04")||v_paymethod.equals("9998"))?"Y":"N");
			hmParam4.put("p_islicense", "N");
			hmParam4.put("p_rightno", "");
			hmParam4.put("p_inningseq", "");

			// insert t_lms_payment
			if( v_paymethod.equals("9998")) hmParam2.put("p_appldate", DateTimeUtil.getDate()) ;
			hmParam4.put("p_paydate", hmParam2.get("p_appldate"));
			hmParam4.put("p_installment_seq", "999");       //  분납이 아니므로 999
			sqlWrap.insert("insertPayment", hmParam4);

			// 마일리지 차감
			if(Integer.parseInt(v_usemileage) > 0 ){
				box.put("SUBJNM" , boxProposeApplyInfo.getString("OPENSUBJNM"));
				this.doSaveUseMileage(box);
			}

			sqlWrap.commitTransaction();

			retVal = 1;

		} catch ( Exception e ) {
			/*******************************************************************
			* 7. DB연동 실패 시 강제취소                                      *
			*                                                                 *
			* 지불 결과를 DB 등에 저장하거나 기타 작업을 수행하다가 실패하는  *
			* 경우, 아래의 코드를 참조하여 이미 지불된 거래를 취소하는 코드를 *
			* 작성합니다.                                                     *
			*******************************************************************/

			INIpay50 inipay = (INIpay50)box.getObject("inipay");

			String tmp_TID = inipay.GetResult("tid");
			inipay.SetField("type", "cancel"); 			// 고정
			inipay.SetField("tid", tmp_TID); 			// 고정
			inipay.SetField("cancelmsg", "DB FAIL"); 	// 취소사유
			inipay.startAction();

//			e.printStackTrace();

			retVal = -3;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}

	/**
	 * 수강신청 취소
	 * 결제취소는 이곳에서 이루어지지 않음
	 * 수강신청 취소 프로세스는 환불요청만 한다. 수강취소는 환불이 완료될때 이루어진다.
	 * @param request
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int proposeWriteCancel( HttpServletRequest request, Box box ) throws Exception {

		int retVal = 0;

		try {

//			// 카드결제 였다면 바로 취소
//			if ( v_paymethod.equals("100000000000") ) {
//				retVal = this.doINICancel(request, box);
//			} else {
//
//			}
//			INIpay50 inipay = (INIpay50)box.getObject("inipay");

			String v_isclosed = null;
			String v_isb2c = null;
			String v_trainingclass = null;
			String v_recogstate = null;
			String v_paymethod = null;
			String v_tid = null;
			String v_seq = null;
			String v_usemileage = null;

			HashMap<String,String> hmParam = new HashMap<String,String>();
			hmParam.put("p_subj", box.getString("p_subj"));
			hmParam.put("p_year", box.getString("p_year"));
			hmParam.put("p_subjseq", box.getString("p_subjseq"));
			hmParam.put("p_userid", box.getString("p_userid"));
			hmParam.put("s_userid", box.getString("s_userid"));

			hmParam.put("p_reasoncd", "1");
			hmParam.put("p_reason", box.getString("p_cancelreason"));

//			Box proposeInfo = sqlWrap.queryForBox("selectApprovalListB2C", hmParam);
			Box proposeInfo = sqlWrap.queryForBox("selectProposeDetail", hmParam);
			hmParam.put("p_seq", proposeInfo.getString("SEQ"));

			v_isclosed = proposeInfo.getString("ISCLOSED");
			v_isb2c = proposeInfo.getString("ISB2C");
			v_paymethod = proposeInfo.getString("PAYMETHOD");
			v_trainingclass = proposeInfo.getString("TRAININGCLASS");
			v_recogstate = proposeInfo.getString("RECOGSTATE");
			v_tid = proposeInfo.getString("TID");
			v_seq = proposeInfo.getString("SEQ");
			v_usemileage = proposeInfo.getString("USEMILEAGE");
			if (StringUtil.isNull(v_usemileage)) {
				v_usemileage = "0";
			}

			//if ( v_isclosed.equals("Y") ) {
			//	retVal = 0;
			//} else {
				sqlWrap.startTransaction();
				if ( v_recogstate.equals("Y") ) {	// 결제완료인 경우 - 환불요청만 함
					hmParam.put("p_recogstate", "R"); //환불요청상태
					sqlWrap.update("updatePaymentRefundRequest", hmParam);

				}
				// 입금 대기인 경우 - 바로 삭제
				else if ( v_recogstate.equals("N") || v_recogstate.equals("") ) {
	
					MileageMgr mileageMgr = new MileageMgr();
					int mileage = Integer.parseInt(v_usemileage); 
					if( mileage  > 0){
		    			hmParam.put("p_content","수강신청 취소");
		    			hmParam.put("p_useyn", "N");
		    			hmParam.put("p_point", mileage + "");
		    			hmParam.put("p_gubun","9999");
		    			Box mile = new Box(hmParam);
	    				mileageMgr.insertSaveMileage(mile);
					}
					
					ProposeMgr proposeMgr = new ProposeMgr();
					
					// 1. 교재,배송정보 삭제 ( t_lms_send, t_lms_selsubjbook )
	        		sqlWrap.update("deleteSend", hmParam);
	        		sqlWrap.update("deleteSelSubjBook", hmParam);

	        		// 2. T_LMS_PAYMENT 테이블에 RECOGSTATE 값을 C 로 업데이트
					hmParam.put("p_recogstate", "C");
					sqlWrap.update("updatePaymentRefundRequest", hmParam);
					if ( v_paymethod.equals("010000000000") && !v_tid.equals("") ) {
						box.put("TID", v_tid);
						box.put("p_trainingclass", v_trainingclass);
						int ret = proposeMgr.doINICancel(box);
						if ( ret != 1 ) {
							throw new Exception("이니시스 취소중 에러");
						}
					}

					// 3. t_lms_cancel insert
	        		sqlWrap.insert("insertCancelUser", hmParam); //취소 히스토리를 남긴다.

//	        		// 4. T_LMS_STOLD 삭제
//	        		sqlWrap.update("deleteStoldUser", hmParam);

	        		// 5. T_LMS_STUDENT 삭제
	        		sqlWrap.update("deleteStudentUser", hmParam);

	        		// 6. T_LMS_PROPOSE 삭제
	        		sqlWrap.delete("deleteProposeUser", hmParam);
	        		
	        		// 7. 설문조사 결과 삭제(수강신청 취소 버튼을 누를시에)
	        		sqlWrap.delete("deleteSulmunResult", hmParam);
	        		
	        		// 8. 외환관리사 실무과정 설문조사 결과 삭제
	        		sqlWrap.delete("deleteRightPropSulmun", hmParam);
	        		
					// 9. 단체수강신청 여부 확인
					DataSet selectProposeStudent = proposeMgr.selectProposeStudent(hmParam);
					
					// 10. 단체수강신청시 입력했던 수강생 정보 삭제		
					if( selectProposeStudent != null ){
						sqlWrap.update("deleteProposeStudent", hmParam);
					}
				}
				// 그외의 경우(취소(C), 환불처리완료(D), 환불완료(E), 결제실패(F), 결제진행중(I), 환불처리중(P), 환불요청(R)) 는 아무것도 안함
				else {

				}

				retVal = 1;
				sqlWrap.commitTransaction();
		//	}

		} catch ( Exception e ) {
			e.printStackTrace();
			retVal = 0;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}

	public int insertStudent(HashMap param) throws Exception {
		Integer retVal;
		int rcount = 0; // insert 처리된 건수
		try {
			sqlWrap.startTransaction();
			rcount = sqlWrap.update("insertStudentSubBL", param);
			sqlWrap.commitTransaction();
		} catch (Exception e) {
			throw e;
		} finally {
			sqlWrap.endTransaction();
		}
		return rcount;
	}

	public int insertPropose(HashMap param) throws Exception {
		Integer retVal;
		int rcount = 0; // insert 처리된 건수
		try {
			rcount = sqlWrap.update("insertProposeWithSubBL", param);
		} catch (Exception e) {
			throw e;
		} finally {

		}
		return rcount;
	}

	public int insertBook(HashMap param) throws Exception {
		Integer retVal;
		int rcount = 0; // insert 처리된 건수
		try {
			//BL 과정인 경우, BLSUB 과정들도 모두 가져와 독서통신인 경우 교재 데이타를 INSERT 해준다.
			String isonoff = (String)param.get("ISONOFF");
			//int bookcnt = Integer.parseInt((String)param.get("p_bookcnt"));

			HashMap param2 = new HashMap();
			param2.put("p_subj", param.get("p_subj"));
			param2.put("p_year", param.get("p_year"));
			param2.put("p_subjseq", param.get("p_subjseq"));
			param2.put("p_userid", param.get("p_userid"));

			for(int i =1; i <= 12; i++) {
				String subjmonth = StringUtil.nvl(param.get("subjmonth" + i));
				if(subjmonth.equals("")) continue;
				String temp[] = subjmonth.split("\\|");
				if(temp.length == 2) {
					param2.put("p_subjmonth", temp[0]);
					param2.put("p_bookid", temp[1]);
					sqlWrap.update("insertBookWithSubBL", param2);
				}
			}
		} catch (Exception e) {
			throw e;
		} finally {

		}
		return rcount;
	}

	public int insertDelivery(HashMap param) throws Exception {
		Integer retVal;
		int rcount = 0; // insert 처리된 건수
		try {

			rcount = sqlWrap.update("insertDeliveryWithSubBL", param);
		} catch (Exception e) {
			throw e;
		} finally {

		}
		return rcount;
	}

	public int proposeCancelB2C(Box box) throws Exception {
		int retVal=0;
		DataSet data = null;
 		ArrayList proposeList = null;

		try {
			sqlWrap.startTransaction();
			box.put("p_userid", box.getString("s_userid"));
			data = sqlWrap.queryForDataSet("selectProposeSubBL", box.getMap());

			PaymentMgr paymentMgr = new PaymentMgr();
			Box paymentInfo = paymentMgr.selectPaymentDetail(box);

			HashMap param = new HashMap();
			param.put("p_subj", box.getString("p_subj"));
			param.put("p_year", box.getString("p_year"));
			param.put("p_subjseq", box.getString("p_subjseq"));
			param.put("p_seq", box.getString("p_seq"));
			param.put("p_userid", box.getString("s_userid"));

			String recogstate = "C";
			if(paymentInfo.getString("COSTSUPPORT").equals("1003")) {
				recogstate = "C";

			} else if(paymentInfo.getString("RECOGSTATE").equals("Y")) {
				recogstate = "R";
				if(!paymentInfo.getString("PAYMETHOD").equals("100000000000")) { //계좌이체, 가상계좌인 경우는 환불계좌를 등록해준다.
					param.put("p_refundbankcd", box.getString("p_refundbankcd"));
					param.put("p_refundaccount", box.getString("p_refundaccount"));
				}
			} else if(paymentInfo.getString("RECOGSTATE").equals("N")) {
				recogstate = "C";
			}

			param.put("p_recogstate", recogstate);
			//결제정보를 환불신청으로 둔다.
			retVal = sqlWrap.update("updatePaymentRefundRequest",param);

			proposeList = (ArrayList)data.getDataSet();
			proposeList.add(box);


			for(int i=0;proposeList != null && i < proposeList.size(); i++) {
				param = ((Box)proposeList.get(i)).getMap();
				param.put("p_userid", box.getString("s_userid"));

				Box box2 = new Box(param); //호출시 필요한 유형으로 변환한다.
				// 과정별 사용자 평 가정보 삭제
				new ExamMgr().deleteExamSubjPaperUser(box2);

				// 과정별 사용자 설문 참여 정보 삭제
				new SulmunMgr().deleteSulSubjUserAll(box2);

				// 과정별 사용자 학습 정보 삭제
				new ItemMgr().deleteSubjseqCmiUserAll(box2);

				// 과정별 사용자 과제 정보 삭제
				new ReportMakeMgr().deleteTzProjRep(box2);

				//사용자별 과정 게시판 삭제
				new StudyBoardMgr().deleteUserBoard(box2);

				sqlWrap.delete("deleteBookWithSubBL", param);
        		sqlWrap.delete("deleteDeliveryWithSubBL", param);
				sqlWrap.delete("deleteStudentUser", param);
				sqlWrap.delete("deleteProposePayInstall", param);
				retVal += sqlWrap.update("deletePropose", param);

			}



			sqlWrap.commitTransaction();
		} catch (Exception e) {
			throw e;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}


	public int proposeCancelB2B(Box box) throws Exception {
		int retVal=0;
		DataSet data = null;
 		ArrayList proposeList = null;

		try {
			sqlWrap.startTransaction();
			box.put("p_userid", box.getString("s_userid"));
			data = sqlWrap.queryForDataSet("selectProposeSubBL", box.getMap());

			String v_comp 		= box.getString("s_comp");
			String v_year	 	= box.getString("p_year");
			String v_subj	 	= box.getString("p_subj");
			String v_subjseq	= box.getString("p_subjseq");
			String v_userid 	= box.getString("s_userid");

			HashMap param = new HashMap();
			param.put("p_comp", v_comp);
			param.put("p_subj", v_subj);
			param.put("p_year", v_year);
			param.put("p_subjseq", v_subjseq);
			param.put("p_userid", v_userid);

			param.put("p_reasoncd", "1");
			param.put("p_reason", box.getString("p_cancelreason"));

			sqlWrap.insert("insertCancelUser", param); //취소 히스토리를 남긴다.

			proposeList = (ArrayList)data.getDataSet();
			proposeList.add(box);
			HashMap param2 = null;
			for(int i=0;proposeList != null && i < proposeList.size(); i++) {
				param2 = ((Box)proposeList.get(i)).getMap();
				param2.put("p_userid", v_userid);
				Box box2 = new Box(param2); //호출시 필요한 유형으로 변환한다.
				// 과정별 사용자 평 가정보 삭제
				new ExamMgr().deleteExamSubjPaperUser(box2);

				// 과정별 사용자 설문 참여 정보 삭제
				new SulmunMgr().deleteSulSubjUserAll(box2);

				// 과정별 사용자 학습 정보 삭제
				new ItemMgr().deleteSubjseqCmiUserAll(box2);

				// 과정별 사용자 과제 정보 삭제
				new ReportMakeMgr().deleteTzProjRep(box2);

				//사용자별 과정 게시판 삭제
				new StudyBoardMgr().deleteUserBoard(box2);

				sqlWrap.update("deleteBookWithSubBL", param2);
        		sqlWrap.update("deleteDeliveryWithSubBL", param2);
				sqlWrap.update("deleteStudentUser",param2);
				retVal += sqlWrap.update("deletePropose",param2);

			}

			if(retVal == 0) {
				throw new SQLException("수강 취소에 실패했습니다.");
			}

			/*
        	String idpcdpyn 	= (String)sqlWrap.queryForObject("getCompIdpcdpyn", v_comp );

        	//IDP/CDP 업체인 경우 역량쪽 프로시져를 호출하여,수강정보를 삭제해준다.
			Object idpcdpResult = "";
			if("I".equals(idpcdpyn) || "C".equals(idpcdpyn)) {
				if("I".equals(idpcdpyn)) {
					param.put("p_coursenum", v_subj + "_" + v_year + "_" + v_subjseq);
					param.put("p_plancode", "c");
					sqlWrap.queryForObject("callPlanModify",param);
				} else if("C".equals(idpcdpyn)) {
					param.put("p_coursenum", v_subj + "_" + v_year + "_" + v_subjseq);
					param.put("p_plancode", "c");
					sqlWrap.queryForObject("callPlanModify",param);
				}

				String result = StringUtil.nvl(param.get("result"));
				String resultMsg = StringUtil.nvl(param.get("resultMsg"));

				System.out.println(result + " : " + resultMsg);

				if(result.equals("F")) {
					throw new SQLException("수강생 취소에 실패했습니다.  call U_SCAP.P_PLAN_MODI [" + resultMsg + "]");
				} else if(result.equals("S")) {

				} else {
					throw new SQLException("수강생 취소에 실패했습니다.  call U_SCAP.P_PLAN_MODI NO RESULT ");
				}
			}
			*/

			sqlWrap.commitTransaction();
		} catch (Exception e) {
			throw e;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}

	/**
   * 수강취소/차수연기 신청을 한다.
   *
   * @return  int
   */
	public int requestDelay(Box box) throws Exception{
		int retVal = 0;
		int chkVal = 0;
		try{
			sqlWrap.startTransaction();
			String type = "";

			HashMap param = box.getMap();
			//수강정보를 가져온다.
			//취소신청의 경우 수강 시작전만 가능하다.
			param.put("p_userid", box.getString("s_userid"));
			param.put("p_rejectgubun", box.getString("p_cancelgubun"));
			param.put("p_rejectreason", box.getString("p_cancelreason"));
			Box propose = sqlWrap.queryForBox("selectProposeDetail", param);
			String cancelGubun = box.getString("p_cancelgubun");

			//취소 신청정보를 가져온다.
			if(propose == null) {
				throw new SQLException("취소 대상 수강 정보가 없습니다.");
			}

			if("BL".equals(propose.getString("ISONOFF"))) {//BL 과정은 차수 변경 불가하다.
	    		throw new SQLException("BL과정은 차수변경할수 없습니다.");
	    	}

			String v_subj = (String)param.get("p_subj");
			String v_year = (String)param.get("p_year");
			String v_subjseq = (String)param.get("p_subjseq");
			String isonoff  = propose.getString("ISONOFF");
			String v_comp = propose.getString("COMP");

			String result = "";
			String resultMsg = "";

			param.put("p_comp",v_comp);

			//취소 신청 데이타를 insert 한다.
			if(cancelGubun.equals("D")) { //차수 연기인경우
				type = "차수변경";
				param.put("newseq", param.get("p_wantedseq"));
				retVal = sqlWrap.update("insertDelayApply", param);
				box.put("msg", type + " 신청되었습니다.");
			}

        	sqlWrap.commitTransaction();
        }catch(Exception e){
        	throw e;
        }finally{
        	sqlWrap.endTransaction();
        }
		return retVal;
	}

	/**
	 * 모바일 수강중인 과정 정보를 반환한다.
	 *
	 * @return  DataSet
	 */
	public DataSet getMobileProposeListIng(Box box) throws Exception{
		DataSet data = null;
        try{
        	HashMap param = box.getMap();
 		    data = sqlWrap.queryForDataSet("selectMobileProposeUserIng",param);
        }catch(Exception e){
        	throw e;
        }finally{

        }
		return data;
	}

	/**
	 * 모바일 학습예정인 과정
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public DataSet getMobileProposeListAllInfo(Box box) throws Exception {
		DataSet data = null;
        try {
        	String isb2b = box.getString("p_btobyn");
        	if ( isb2b.equals("Y") ) {
        		data = sqlWrap.queryForDataSet("selectProposeUserPre", box.getMap());
        	} else {
        		data = sqlWrap.queryForDataSet("selectMobileProposeUserPreB2C", box.getMap());
        	}

        } catch ( Exception e ) {
        	throw e;
        } finally {

        }
		return data;
	}

	/**
	 * 모바일 수강 완료한 과정을 반환한다.
	 *
	 * @return  DataSet
	 */
	public DataSet getMobileProposeListDone(Box box) throws Exception{
		DataSet data = null;
		String p_year = box.getString("p_gyear");

        try{
        	if(StringUtil.isNull(p_year)) {
        		p_year = DateTimeUtil.getYear();
        	}
        	box.put("p_year", p_year);
        	HashMap param = box.getMap();
        	data = sqlWrap.queryForDataSet("selectMobileProposeUserDone",param);

        }catch(Exception e){
        	throw e;
        }finally{

        }
		return data;
	}

	/**
	 * 모바일 컨텐츠 항목을 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public DataSet selectMobileContents(Box box) throws Exception {
		DataSet data = null;
		try {
			data = sqlWrap.queryForDataSet("getMobileStudy", box.getString("p_subj"));
		} catch (Exception e) {
			throw e;
		}
		return data;
	}

	/**
	 * 학습자 결제 및 원서접수 정보 수정
	 * @param request
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int paymentRun( HttpServletRequest request, Box box ) throws Exception {
		int retVal = 0;
		String v_paymethod = box.getString("p_paymethod");
		String v_paymethod2 = null;

		//PRICE 가져오기..
		Box boxProposeApplyInfo = sqlWrap.queryForBox("getRightTestApplyInfo", box.getMap());
		box.put("boxProposeApplyInfo", boxProposeApplyInfo);
		box.put("p_inningseq", box.getString("p_seq"));

		try{
			sqlWrap.startTransaction();

			INIpay50 inipay = null;

			retVal = this.doINISecureResult(request, box);
			inipay = (INIpay50)box.getObject("inipay");
			v_paymethod2 = inipay.GetResult("PayMethod");

//			retVal = 1;
			if ( retVal > 0 ) {
				HashMap<String,String> hmParam = null;
				hmParam = (HashMap)box.getObject("hmInipayResult");
				hmParam.putAll(box.getMap());
//				hmParam.put("p_userid", box.getString("p_userid"));
//				hmParam.put("s_userid", box.getString("s_userid"));

				// insert t_pay_inipay
				hmParam.put("p_paymethod", v_paymethod2);
				sqlWrap.insert("insertInipay", hmParam);
				HashMap<String,String> hmParam2 = new HashMap<String,String>();
				hmParam2.putAll(hmParam);
				hmParam2.put("p_paymethod", v_paymethod);
				hmParam2.put("p_amount", hmParam.get("p_totprice"));
				hmParam2.put("p_recogstate", (v_paymethod.equals("100000000000"))?"Y":"N");
				hmParam2.put("p_applystate", (v_paymethod.equals("100000000000"))?"PF":"PI");
				hmParam2.put("p_islicense", "Y");   //자격시험인 경우 : Y
//				hmParam4.put("p_installment_seq", box.getString("p_installment_seq"));
//				hmParam4.put("p_rightno", box.getString("p_rightno"));
//				hmParam4.put("p_inningseq", box.getString("p_seq"));

				// insert t_lms_payment
				hmParam2.put("p_paydate", hmParam.get("p_appldate"));
				sqlWrap.insert("insertPayment", hmParam2);
				// update t_lms_rightapply
				sqlWrap.update("updateRightApply", hmParam2);

				sqlWrap.commitTransaction();
			}

//			String tmp_TID = inipay.GetResult("tid");
//			inipay.SetField("type", "cancel"); 			// 고정
//			inipay.SetField("tid", tmp_TID); 			// 고정
//			inipay.SetField("cancelmsg", "Test"); 	// 취소사유
//			inipay.startAction();
		}catch(Exception e){
			/*******************************************************************
			* 7. DB연동 실패 시 강제취소                                      *
			*                                                                 *
			* 지불 결과를 DB 등에 저장하거나 기타 작업을 수행하다가 실패하는  *
			* 경우, 아래의 코드를 참조하여 이미 지불된 거래를 취소하는 코드를 *
			* 작성합니다.                                                     *
			*******************************************************************/

			INIpay50 inipay = (INIpay50)box.getObject("inipay");

			String tmp_TID = inipay.GetResult("tid");
			inipay.SetField("type", "cancel"); 			// 고정
			inipay.SetField("tid", tmp_TID); 			// 고정
			inipay.SetField("cancelmsg", "DB FAIL"); 	// 취소사유
			inipay.startAction();

			e.printStackTrace();

			retVal = -3;
		}finally{
			sqlWrap.endTransaction();
		}

		return retVal;
	}

	/**
	 * 수강취소 및 환불 완료
	 * 환불전표처리 완료후 수강취소, 및 환불 완료 처리
	 *
	 * @param request
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int proposeDrop( HttpServletRequest request, Box box ) throws Exception {

		int retVal = 0;

		try {
			String v_usemileage = null;
			HashMap<String,String> hmParam = new HashMap<String,String>();
			
			hmParam.put("p_subj", box.getString("p_subj"));
			hmParam.put("p_year", box.getString("p_year"));
			hmParam.put("p_subjseq", box.getString("p_subjseq"));
			hmParam.put("p_userid", box.getString("p_userid"));
			hmParam.put("s_userid", box.getString("s_userid"));

			hmParam.put("p_reasoncd", "1");
			hmParam.put("p_reason", box.getString("p_cancelreason"));

			Box proposeInfo = sqlWrap.queryForBox("selectProposeDetail", hmParam);
			hmParam.put("p_seq", proposeInfo.getString("SEQ"));
			v_usemileage = proposeInfo.getString("USEMILEAGE");
			if (StringUtil.isNull(v_usemileage)) {
				v_usemileage = "0";
			}

			sqlWrap.startTransaction();

			// 1. 교재,배송정보 삭제 ( t_lms_send, t_lms_selsubjbook )
    		sqlWrap.delete("deleteSend", hmParam);
    		sqlWrap.delete("deleteSelSubjBook", hmParam);

    		// 2. t_lms_cancel insert
    		sqlWrap.insert("insertCancelUser", hmParam); //취소 히스토리를 남긴다.
    		
    		MileageMgr mileageMgr = new MileageMgr();
    		// 3. 환불처리
			if ( proposeInfo.getString("RECOGSTATE").equals("D") ) {	//  환불 전표처리 완료 인 경우
				hmParam.put("p_recogstate", "E"); //환불완료
				
				// 과정 적립 마일리지 회수
				int temp = mileageMgr.selectSubjSeqPoint(hmParam);
	    		if(temp  > 0){
    				box.put("p_content","수강신청을 하는 경우(취소)");
    				box.put("p_useyn", "Y");
    				box.put("p_point", temp);
    				box.put("p_gubun","9999");
    				mileageMgr.insertSaveMileage(box);
	    		}
			} else {													// 결제대기인 경우 (결제되지 않은 경우 바로 취소로 표시)
				hmParam.put("p_recogstate", "C");
			}
			
			// 과정 적립 마일리지 재적립
    		int mileage = Integer.parseInt(v_usemileage); 
			if( mileage  > 0){
    			hmParam.put("p_content","수강신청 취소");
    			hmParam.put("p_useyn", "N");
    			hmParam.put("p_point", mileage + "");
    			hmParam.put("p_gubun","9999");
    			Box mile = new Box(hmParam);
				mileageMgr.insertSaveMileage(mile);
			}
			
			// 결제정보 히스토리
			sqlWrap.insert("insertPaymentChangeHistory", hmParam );
			
			sqlWrap.update("updatePaymentRefundFinish", hmParam);

			// 4. t_lms_student 삭제
    		retVal = sqlWrap.update("deleteStudentUser", hmParam);

    		// 5. t_lms_propose 삭제
    		sqlWrap.delete("deleteProposePayInstall", hmParam);
    		sqlWrap.delete("deleteProposeUser", hmParam);
    		
    		//외환관리사 자격취득과정 과정 설문조사 결과 삭제
    		sqlWrap.delete("deleteRightPropSulmun", hmParam);
    		
    		/**
    		 * 대표 id의 경우 환불처리
    		 *	
    		 */
    		HashMap<String,String> hmParam2 = new HashMap<String,String>();
			ProposeMgr proposeMgr = new ProposeMgr();
			
			// 대표 id
			hmParam2.put("p_userid", box.getString("p_userid"));
			hmParam2.put("p_subj", box.getString("p_subj"));
			hmParam2.put("p_subjseq", box.getString("p_subjseq"));
			hmParam2.put("p_recogstate", "Y");						// 승인상태(완료)
			
			// 단체수강신청 여부 확인	
			DataSet selectProposeStudent = proposeMgr.selectProposeStudent(hmParam2);
			
			// 대표 id	(대표 id & 단체신청)
			if ( selectProposeStudent.getRow() > 0 ){
				System.out.println("--- 대표 id & 단체신청 (환불처리) ---");
				// 수강생 리스트 불러오기
				for( int i = 0 ; i < selectProposeStudent.getRow(); i++ ){
					selectProposeStudent.next();							
					hmParam.put("p_userid", selectProposeStudent.getString("USERID"));		// 수강생 아이디
					
					retVal = sqlWrap.update("updateProposeWaitWithSubBL",hmParam);			// 입금대기시  t_lms_propose 업데이트,  t_lms_student delete 한다.	(수강생 id)
					if ( retVal > 0 ) {
						retVal = sqlWrap.update("deleteStudentWait", hmParam);	
						retVal = sqlWrap.delete("deleteProposeBL", hmParam);
						if( retVal > 0 ){
							// 수강생 회원탈퇴 처리
							String userID = hmParam.get("p_userid");
							sqlWrap.delete("deleteMemberField", userID);	
						    sqlWrap.delete("deleteMemberJoin", userID);	
						    sqlWrap.delete("deleteMemberInterest", userID);
						    sqlWrap.delete("deleteBtoCMemberMileage", userID);
						    sqlWrap.delete("deleteMember", userID);
						    System.out.println("수강생 회원탈퇴 처리 완료");
						    
						    // 대표&수강생 관계테이블 승인상태 업데이트
							sqlWrap.update("updateProposeStudent", hmParam);
							System.out.println("// 대표&수강생 관계테이블 승인상태 업데이트");
						}
					}
				}			    
			}

			sqlWrap.commitTransaction();
			retVal = 1;

			// 6. t_lms_stold 삭제
    		sqlWrap.update("deleteStoldUser", hmParam);

    		// 7. 과정별 사용자 평 가정보 삭제
			new ExamMgr().deleteExamSubjPaperUser(new Box(hmParam));

			// 8. 과정별 사용자 설문 참여 정보 삭제
			new SulmunMgr().deleteSulSubjUserAll(new Box(hmParam));

			// 9. 과정별 사용자 학습 정보 삭제
			new ItemMgr().deleteSubjseqCmiUserAll(new Box(hmParam));

			// 10. 과정별 사용자 과제 정보 삭제
			new ReportMakeMgr().deleteTzProjRep(new Box(hmParam));

			// 11. 사용자별 과정 게시판 삭제
			new StudyBoardMgr().deleteUserBoard(new Box(hmParam));

		} catch ( Exception e ) {
			retVal = 0;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}

	/**
	 * 선택적 부분수강   수강 취소 및 환불 완료
	 * 환불전표처리 완료후 수강취소, 및 환불 완료 처리
	 *
	 * @param request
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int proposeSelDrop( HttpServletRequest request, Box box ) throws Exception {

		int retVal = 0;

		try {

			HashMap<String,String> hmParam = new HashMap<String,String>();
			hmParam.put("p_subj", box.getString("p_subj"));
			hmParam.put("p_year", box.getString("p_year"));
			hmParam.put("p_subjseq", box.getString("p_subjseq"));
			hmParam.put("p_userid", box.getString("p_userid"));
			hmParam.put("s_userid", box.getString("s_userid"));

			hmParam.put("p_reasoncd", "1");
			hmParam.put("p_reason", box.getString("p_cancelreason"));

			Box proposeInfo = sqlWrap.queryForBox("getProposeSeqState", hmParam);
			hmParam.put("p_seq", proposeInfo.getString("SEQ"));

			sqlWrap.startTransaction();

    		// 1. t_lms_cancel insert
    		sqlWrap.insert("insertCancelUser", hmParam); //취소 히스토리를 남긴다.

    		// 2. 환불처리
			if ( proposeInfo.getString("RECOGSTATE").equals("D") ) {	//  환불 전표처리 완료 인 경우
				hmParam.put("p_recogstate", "E"); //환불완료
			} else {													// 결제대기인 경우 (결제되지 않은 경우 바로 취소로 표시)
				hmParam.put("p_recogstate", "C");
			}
			sqlWrap.update("updatePaymentRefundFinish", hmParam);

    		// 3. t_lms_student 삭제
    		retVal = sqlWrap.update("deleteStudentSel", hmParam);

    		// 4. t_lms_proposeopensubj 삭제
    		sqlWrap.delete("deleteProposeOpenSubjSel", hmParam);

    		// 5. t_lms_propose 삭제
    		sqlWrap.delete("deleteProposeSelUser", hmParam);
    		
			retVal = 1;

			sqlWrap.commitTransaction();

		} catch ( Exception e ) {
			retVal = 0;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}

	/**
	 * 학습자가 환불 요청한다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int updatePaymentRefundRequest(Box box) throws Exception {

		int retVal = 0;

		box.put("p_userid", box.getString("s_userid"));
		box.put("p_recogstate", "R");

		try {

			sqlWrap.startTransaction();
			retVal = sqlWrap.update("updatePaymentRefundRequest", box.getMap());
			sqlWrap.commitTransaction();

			//retVal = 1;

		} catch (Exception e) {
			throw e;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}

	/**
	 * 수강신청서에서 사용자의 핸드폰 번호, 이메일이 없을 경우 입력 받아서 업데이트 한다
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int updateMemberInfo2(Box box) throws Exception {

		int retVal = 0;

		try {

			sqlWrap.startTransaction();
			retVal = sqlWrap.update("updateMemberInfo2", box.getMap());
			sqlWrap.commitTransaction();

			//retVal = 1;

		} catch (Exception e) {
			throw e;
		} finally {
			sqlWrap.endTransaction();
		}
		return retVal;
	}

	/**
	 * 마일리지 차감
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public void doSaveUseMileage( Box box  ) throws Exception {

		MileageMgr mileageMgr = new MileageMgr();
		box.put("p_point", box.getString("p_usemileage"));
		box.put("p_gubun","5555");
		box.put("p_content", box.getString("SUBJNM")+"과정  마일리지 차감.");
		box.put("p_useyn", "Y");
		mileageMgr.insertSaveMileage(box);

	}

	/**
	 * 결제 정보 가져오기
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public DataSet selectPaymentCouseRightInfo(Box box) throws Exception {
		DataSet data = null;
		try {
			data = sqlWrap.queryForDataSet("selectPaymentCouseRightInfo", box.getMap() );
		} catch (Exception e) {
			throw e;
		}
		return data;
	}
	
	/**
	 * 수강신청 알림 설정을 가져온다
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public Box selectProposeSmsNotiInfo(Box box) throws Exception {
		Box data = null;
        try {
 		    data = sqlWrap.queryForBox("selectProposeSmsNotiInfo", box.getMap());
 		    if(data == null) data = new Box("");
        } catch ( Exception e ) {
        	throw e;
        } finally {

        }
		return data;
	}
	
	/**
	 * 결제 방식 변경시 기존의 insert문을 삭제한다(T_LMS_PAYMENT, T_PAY_INIPAY, T_LMS_PAYMENT)
	 * @param box
	 * @return int
	 * @throws Exception
	 */
	 public int deletePaymentData(Box box) throws Exception {
		 int retVal = 0;
		 
		 try{
			 sqlWrap.startTransaction();
			 sqlWrap.delete("deletePayment", box.getMap());
			 sqlWrap.delete("deleteInipay", box.getMap());
			 sqlWrap.delete("deleteProposePayInstallWhenEditPayment", box.getMap());
			 
			 sqlWrap.commitTransaction();
			 retVal = 1;
		 } catch(Exception e) {
			 throw e;
		 } finally {
			 sqlWrap.endTransaction();
		 }
		 
		 return retVal;
	 }
	 /**
	  * 결제 방식 변경시 기존의 insert문을 수정 및 삭제한다(T_LMS_PAYMENT, T_LMS_PAYMENT)
	  * @param box
	  * @return int
	  * @throws Exception
	  */
	 public int deleteNupdatePaymentData(Box box) throws Exception {
		 int retVal = 0;
		 
		 try{
			 sqlWrap.startTransaction();
			 //결제 정보 취소로 변경
			 sqlWrap.delete("updatePaymentRecogstateC", box.getMap());
			 //분납정보 삭제
			 sqlWrap.delete("deleteProposePayInstallWhenEditPayment", box.getMap());
			 
			 sqlWrap.commitTransaction();
			 retVal = 1;
		 } catch(Exception e) {
			 throw e;
		 } finally {
			 sqlWrap.endTransaction();
		 }
		 
		 return retVal;
	 }
	 
	 /**
	  * 최초 결제시 결제 방식 변경시 기존의 insert문을 삭제한다(T_LMS_SEND)
	  * @param box
	  * @return int
	  * @throws Exception
	  */
	 public int deleteLmsSend(Box box) throws Exception {
		 int retVal = 0;
		 
		 try{
			 sqlWrap.startTransaction();
			 sqlWrap.delete("deleteStudyDeliveryUser", box.getMap());
			 
			 sqlWrap.commitTransaction();
			 retVal = 1;
		 } catch(Exception e) {
			 throw e;
		 } finally {
			 sqlWrap.endTransaction();
		 }
		 
		 return retVal;
	 }
	 
	 /**
		 * 학습자 결제 및 원서접수 정보 수정
		 * @param request
		 * @param box
		 * @return
		 * @throws Exception
		 */
		public int toeflPaymentRun( HttpServletRequest request, Box box ) throws Exception {
			int retVal = 0;
			String v_paymethod = box.getString("p_paymethod");
			String v_paymethod2 = null;
			
			//PRICE 가져오기..
			Box boxProposeApplyInfo = sqlWrap.queryForBox("getToeflApplyInfo", box.getMap());
			box.put("boxProposeApplyInfo", boxProposeApplyInfo);

			try{
				sqlWrap.startTransaction();

				INIpay50 inipay = null;

				retVal = this.doINISecureResult(request, box);
				
				inipay = (INIpay50)box.getObject("inipay");
				v_paymethod2 = inipay.GetResult("PayMethod");

				if ( retVal > 0 ) {
					HashMap<String,String> hmParam = null;
					hmParam = (HashMap)box.getObject("hmInipayResult");
					hmParam.putAll(box.getMap());

					// insert t_pay_inipay
					hmParam.put("p_paymethod", v_paymethod2);
					sqlWrap.insert("insertInipay", hmParam);
					HashMap<String,String> hmParam2 = new HashMap<String,String>();
					hmParam2.putAll(hmParam);
					hmParam2.put("p_paymethod", v_paymethod);
					hmParam2.put("p_amount", hmParam.get("p_totprice"));
					hmParam2.put("p_recogstate", (v_paymethod.equals("100000000000"))?"Y":"N");
//					hmParam2.put("p_applystate", (v_paymethod.equals("100000000000"))?"PF":"PI");
					Box data = (Box)box.getObject("boxProposeApplyInfo"); 
					data.put("p_applystate", (v_paymethod.equals("100000000000"))?"PF":"PI");
					
					HashMap<String,String> hmParam3 = new HashMap<String,String>();
					hmParam3.put("p_testcode", box.getString("p_testcode"));
					hmParam3.put("p_userid", box.getString("s_userid"));
					hmParam3.put("p_gubun", box.getString("p_gubun"));
					hmParam3.put("p_testdate", box.getString("p_testdate"));
					hmParam3.put("p_userprn1", box.getString("p_userprn1"));
					hmParam3.put("p_userprn2", box.getString("p_userprn2"));
					hmParam3.put("p_applystate", (v_paymethod.equals("100000000000"))?"PF":"PI");
					hmParam3.put("p_applynum", hmParam2.get("p_moid"));
					
					// insert t_lms_payment
					hmParam2.put("p_paydate", hmParam.get("p_appldate"));
					sqlWrap.insert("insertPayment", hmParam2);
					// update t_lms_rightapply
					sqlWrap.insert("insertToeflTestApplyInfo", hmParam3);

					sqlWrap.commitTransaction();
				}

//				String tmp_TID = inipay.GetResult("tid");
//				inipay.SetField("type", "cancel"); 			// 고정
//				inipay.SetField("tid", tmp_TID); 			// 고정
//				inipay.SetField("cancelmsg", "Test"); 	// 취소사유
//				inipay.startAction();
			}catch(Exception e){
				/*******************************************************************
				* 7. DB연동 실패 시 강제취소                                      *
				*                                                                 *
				* 지불 결과를 DB 등에 저장하거나 기타 작업을 수행하다가 실패하는  *
				* 경우, 아래의 코드를 참조하여 이미 지불된 거래를 취소하는 코드를 *
				* 작성합니다.                                                     *
				*******************************************************************/
				e.printStackTrace();
				INIpay50 inipay = (INIpay50)box.getObject("inipay");

				String tmp_TID = inipay.GetResult("tid");
				inipay.SetField("type", "cancel"); 			// 고정
				inipay.SetField("tid", tmp_TID); 			// 고정
				inipay.SetField("cancelmsg", "DB FAIL"); 	// 취소사유
				inipay.startAction();

				e.printStackTrace();

				retVal = -3;
			}finally{
				sqlWrap.endTransaction();
			}

			return retVal;
		}
		
		/**
		 * 모의토플 가상계좌 입금통보 확인 프로세스
		 * 1. t_lms_toeflapply 의 applystate 필드 PF 로 업데이트
		 * 2. t_lms_payment 의 recogstate 필드 Y 로 업데이트
		 * 3. t_pay_inipayvacct 테이블 insert
		 * @param request
		 * @param box
		 * @return
		 * @throws Exception
		 */
		public int doVacctToeflProc( Box box ) throws Exception {

			int retVal = 0;

			try {

				sqlWrap.startTransaction();
				
				retVal = sqlWrap.update("updateToeflApplystateChange",box.getMap());
				if ( retVal > 0 ) {
					sqlWrap.update("updateToeflPaymentRecogState", box.getMap());
					sqlWrap.insert("insertInipayVacct", box.getMap());
				}
				sqlWrap.commitTransaction();
			} catch ( Exception e ) {
				retVal = -1;
			} finally {
				sqlWrap.endTransaction();
			}
			return retVal;
		}
		
		
		// 랭귀지큐브에 파라매터와 함께 입과요청을 한다. 2015.06.03 by 안성현 
		public String requestLangQ(Box box) throws Exception {
			String resultmsg="";
			
			HashMap<String, String> hmap = new HashMap<String,String>(); int resVal = 0; 
			// 랭귀지큐브 정보 전송 
			String sendData = ""; 
			/*****************고정값******************/
			String agent = "web_kita_1";
			String svcid = "kita"; 
			String pid = "P4100"; // 상품명: 랭큐 1개월 과정
			/***************************************/
			String userid = (String)box.getMap().get("p_userid");
			String name = (String)box.getString("p_name");
			String pwd = "kita_"+box.getString("p_userid");
			String phone = (String)box.getString("p_handphone").replace("-", "");
			
			if(phone==null || phone.equals("")){
				phone = "00000000000";
			}
			
			//Box boxPropose = (Box)box.getObject("boxProposeApplyInfo");
			String p_subjseq = box.get("p_subjseq");
			
			hmap.put("p_subjseq", p_subjseq);
			hmap.put("p_userid", userid);
			
			Box tempBox= sqlWrap.queryForBox("getUserInfoLangQ2", hmap);
			
			String ordno = tempBox.getString("moid");
			String sdate = tempBox.getString("edustart");
			
			box.getMap().put("p_moid", ordno); //resultMsg를 memo에 insert 할 때 key값으로 사용.
			
			/*System.out.println("--------------------------------Paramaters sending to The LanguageQube----------------------------------------");
			System.out.println("agent : "+agent+" svcid : "+svcid+" pid : "+pid+" // 여기까진 고정값");
			System.out.println("userid : "+userid+" name : "+name+" pwd : "+pwd+" phone :"+phone);
			System.out.println("ordno : "+ordno+" sdate : "+sdate);*/
			
			// sendData 에 파라미터 담기
			sendData = URLEncoder.encode("agent", "UTF-8")+"="+URLEncoder.encode(agent, "UTF-8"); 
			sendData += "&"+URLEncoder.encode("svcid", "UTF-8")+"="+URLEncoder.encode(svcid, "UTF-8"); 
			sendData += "&"+URLEncoder.encode("userid", "UTF-8")+"="+URLEncoder.encode(userid, "UTF-8"); 
			sendData += "&"+URLEncoder.encode("name", "UTF-8")+"="+URLEncoder.encode(name, "UTF-8"); 
			sendData += "&"+URLEncoder.encode("pwd", "UTF-8")+"="+URLEncoder.encode(pwd, "UTF-8"); 
			sendData += "&"+URLEncoder.encode("phone", "UTF-8")+"="+URLEncoder.encode(phone, "UTF-8"); 
			sendData += "&"+URLEncoder.encode("ordno", "UTF-8")+"="+URLEncoder.encode(ordno, "UTF-8"); 
			sendData += "&"+URLEncoder.encode("pid", "UTF-8")+"="+URLEncoder.encode(pid, "UTF-8"); 
			sendData += "&"+URLEncoder.encode("sdate", "UTF-8")+"="+URLEncoder.encode(sdate, "UTF-8"); 
		
			String uri = "http://api.langq.kr/api/kita/set_pay_result.aspx";
			URL url = new URL(uri); 
			URLConnection conn = url.openConnection(); 
			conn.setDoOutput(true); conn.setDoInput(true); 
			OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream()); 
			wr.write(sendData); wr.flush(); 
			/*결과 응답*/ BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8")); 
			String line = "";
			while((line = rd.readLine())!=null){ 
				//System.out.println(line);
				resultmsg += line;
				}//while
			if(wr!=null)wr.close(); 
			if(rd!=null)rd.close();
			return resultmsg;
		}
}