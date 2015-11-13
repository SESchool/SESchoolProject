
package com.sinc.lms.propose;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.sinc.framework.data.Box;
import com.sinc.framework.data.DataSet;
import com.sinc.framework.persist.AbstractMgr;
import com.sinc.framework.persist.ListDTO;
import com.sinc.framework.util.StringUtil;
import com.sinc.lms.member.MemberMgr;
import com.sinc.lms.support.MileageMgr;


public class PaymentMgr extends AbstractMgr {

	/**
	* 결제 리스트를 반환한다.
	*
	* @return  DataSet
	*/
	public ListDTO selectPaymentList(Box box) throws Exception{

		ListDTO data = null;
		int pageNo = box.getInt("p_pageno");
		int listScale = box.getInt("p_listscale");
	    try{
	      	data = sqlWrap.queryForPageList("selectPaymentPageList", box.getMap(), pageNo, listScale);
	    }catch(Exception e){
	       	throw e;
	    }finally{
	    }
		return data;
	}

	 /**
	   * 결제  리스트를 반환한다.(엑셀)
	   *
	   * @return  DataSet
	   */
	public DataSet selectPaymentExcel(Box box) throws Exception{

		DataSet data = null;

		ListDTO listDto = null;
      try{
      	listDto = sqlWrap.queryForPageList("selectPaymentPageList", box.getMap(), 1, 65000);
      	data = listDto.getItemList();
      }catch(Exception e){
      	throw e;
      }finally{
      }
      return data;
	}


	/**
	* 과정기수 결제  리스트를 반환한다.
	*
	* @return  DataSet
	*/
	public ListDTO selectPaymentCourseList(Box box) throws Exception{

		ListDTO data = null;
		int pageNo = box.getInt("p_pageno");
		int listScale = box.getInt("p_listscale");
	    try{
	      	data = sqlWrap.queryForPageList("selectPaymentCoursePageList", box.getMap(), pageNo, listScale);
	    }catch(Exception e){
	       	throw e;
	    }finally{
	    }
		return data;
	}



   /**
   * 환불처리 리스트를 반환한다.
   *
   * @return  DataSet
   */

	public ListDTO selectRefundList(Box box) throws Exception{

		ListDTO data = null;
		int pageNo = box.getInt("p_pageno");
		int listScale = box.getInt("p_listscale");
        try{
        	data = sqlWrap.queryForPageList("selectRefundPageList", box.getMap(), pageNo, listScale);
        }catch(Exception e){
        	throw e;
        }finally{
        }

		return data;


	}

	 /**
	   * 환불처리 리스트를 반환한다.
	   *
	   * @return  DataSet
	   */
	public DataSet selectRefundExcel(Box box) throws Exception{

		DataSet data = null;

		ListDTO listDto = null;
        try{
        	listDto = sqlWrap.queryForPageList("selectRefundPageList", box.getMap(), 1, 65000);
        	data = listDto.getItemList();
        }catch(Exception e){
        	throw e;
        }finally{
        }

		return data;


	}


	public DataSet selectPaymentListUser(Box box) throws Exception{

		DataSet data = null;

        try{
        	data = sqlWrap.queryForDataSet("selectPaymentListUser", box.getMap());
        }catch(Exception e){
        	throw e;
        }finally{
        }

		return data;
	}


	 /**
     * 결제 상세정보를 리턴해준다.
     * @param box
     * @return
     * @throws Exception
     */
    public Box selectPaymentDetail(Box box) throws Exception {
    	Box data = null;
		try {
			data = sqlWrap.queryForBox("selectPaymentDetail", box.getMap());
		} catch (Exception e) {
			throw e;
		} finally {
		}

	    return data;
   }
    /**
	 * 결제 메모리스트 가져온다.
	 * @param box
     * @return
     * @throws Exception
     */
	public DataSet selectPaymentMemo(Box box) throws Exception{

		DataSet data = null;

        try{
        	data = sqlWrap.queryForDataSet("selectPaymentMemo", box.getMap());
        }catch(Exception e){
        	throw e;
        }finally{
        }

		return data;
	}


    /**
     * 결제 환불관리 메모 update
     * @param box
     * @return int
     * @throws Exception
     */

  	public int insertPaymentMemo(Box box) throws Exception{
  		int retVal = 0;
  		String v_mamomode = box.getString("p_mamomode");
		try{
  	    	sqlWrap.startTransaction();

  	    	if(v_mamomode.equals("ADD")){

  	    		 retVal = sqlWrap.update("addPaymentMemo",box.getMap());

  	    	}else {
  	    		 retVal = sqlWrap.update("updatePaymentMemo",box.getMap());
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
     * 결제 환불 정보를 수정한다.
     * @param box
     * @return int
     * @throws Exception
     */
  	public int refundInfoUpdate(HttpServletRequest request,Box box) throws Exception{
  		int retVal = 0;
		try{
  	    	sqlWrap.startTransaction();
  	    	Box paymentInfo = selectPaymentDetail(box);
  	    	String v_refundcomplete = "";

  	    	if(paymentInfo == null) {
  	    		box.getMap().put("resultMsg", "해당되는 결제정보가 없습니다.");
  	    		return 0;
  	    	}

  	    	String paymethod = paymentInfo.getString("PAYMETHOD");
  	    	if(!paymethod.equals(box.getString("p_paymethod"))){
  	    		paymethod = box.getString("p_paymethod");
  	    	}

  	    	String cust_ip        = StringUtil.nvl(request.getHeader("Proxy-Client-IP")); // 요청 IP
  	    	String v_refundstate = box.getString("p_refundstate");

			String v_recogstate = paymentInfo.getString("RECOGSTATE") ;
			String v_repay_paper_state = paymentInfo.getString("REPAY_PAPER_STATE") ;

			String v_isrefund = "N";
			box.put("p_refundreqdt", box.getString("p_refundreqdt").trim());

			if( !v_recogstate.equals(v_refundstate)){
				if(v_refundstate.equals("") ){   // 미요청
					v_recogstate = v_recogstate ;
				}else if (!v_refundstate.equals("") ){
					v_recogstate = v_refundstate ;
				}

				// 상태값이 요청이고, 결제방법이  마일리지 일 경우
				if( ( v_refundstate.equals("R")|| v_refundstate.equals("P")  || v_refundstate.equals("D")  ) && paymethod.equals("9998") ) {
					v_recogstate ="D";
					box.put("p_allmileage" , "Y");
				}

				if( v_refundstate.equals("D") ) v_isrefund = "Y";
			}
  	    	box.put("p_recogstate", v_recogstate);
  	    	if(v_recogstate.equals("")) return 0;

  			// 결제 금액 수정
			String v_orgamount 		= box.getString("p_orgamount");
			String v_amount			= box.getString("p_amount");

			if(!v_amount.equals("0") && box.getString("p_paymentComplete").equals("Y")){
				v_recogstate = "Y";
				box.put("p_recogstate", v_recogstate);
				box.put("p_isComplet", "Y"); 			// 결제일 업데이트

				if(!paymentInfo.getString("RECOGSTATE").equals("Y")){

					box.put("p_isdinsert", "N");
					retVal = sqlWrap.update("updateProposeConfirmWithSubBL",box.getMap());
					if ( retVal > 0 ) {
						retVal = sqlWrap.update("insertStudentBL", box.getMap() );
						if ( retVal == 0 ) {
							retVal = 0;
							return retVal ;
						}
					}
					MileageMgr mileageMgr = new MileageMgr();
					int temp = mileageMgr.selectSubjSeqPoint(box.getMap());
		    		if(temp  > 0){
	    				box.put("p_content","수강신청을 하는 경우");
	    				box.put("p_useyn", "N");
	    				box.put("p_point", temp);
	    				box.put("p_gubun","0004");
	    				mileageMgr.insertSaveMileage(box);
		    		}
				}
			}
			if(v_amount.equals("0")) v_amount = v_orgamount;

			box.put("p_amount", v_amount);
			// 수정정보 history
			this.insertPaymentChangeHistory(box);
		    retVal = sqlWrap.update("updatePaymentRefund",box.getMap());

  		    sqlWrap.commitTransaction();
  	    }catch(Exception e){
  	        throw e;
  	    }finally{
  	    	sqlWrap.endTransaction();
  	    }

  		return retVal;
  	}

   /**
   * 수강신청을 승인해 준다.
   *
   * @return  int
   */

	public int updateRefund(Box box) throws Exception{
		int retVal = 0;
		String v_grcode	 	= "";
		String v_gyear	 	= "";
		String v_subj	 	= "";
		String v_subjseq	= "";
		String v_userid		= "";
		String v_arrdata[]	= null;
		List dataList    	= (List)box.getList("p_userlist");
		String s_userid 	= box.getString("s_userid");
	    try{
	    	sqlWrap.startTransaction();

	    	for(int i=0 ; i<dataList.size() ; i++) {

	    		HashMap param = new HashMap();

	    		v_arrdata	= dataList.get(i).toString().split("/");
				v_grcode	= v_arrdata[0];
				v_gyear	 	= v_arrdata[1];
				v_subj	 	= v_arrdata[2];
				v_subjseq	= v_arrdata[3];
				v_userid	= v_arrdata[4];

				param.put("p_grcode", v_grcode);
				param.put("p_subj", v_subj);
				param.put("p_year", v_gyear);
				param.put("p_subjseq", v_subjseq);
				param.put("p_userid", v_userid);
				param.put("s_userid", s_userid);

			    retVal += sqlWrap.update("updateProposeApproval",param);
			    sqlWrap.update("insertStudentApproval",param);
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
	   * 결제를 처리한다.
	   *
	   * @return  DataSet
	   */
	public int processPayment(HashMap param) {
		int retVal = -1;

		return retVal;


		/* ============================================================================== */
	}

	  /**
	   * KCP 가상계좌 입금통보를 처리한다.
	   * 주의 : 입금통보가 여러번 올수 있기 때문에, 처리된 건은 무시한다.
	   * @return  int
	   */
	public int kcpCommonReturn(Box box) throws Exception{
		int retVal = -1;
		/* ============================================================================== */
	    /* =   01. 공통 통보 페이지 설명(필독!!)                                        = */
	    /* = -------------------------------------------------------------------------- = */
	    /* =   공통 통보 페이지에서는,                                                  = */
	    /* =   가상계좌 입금 통보 데이터와 모바일안심결제 통보 데이터 등을 KCP를 통해   = */
	    /* =   실시간으로 통보 받을 수 있습니다.                                        = */
	    /* =                                                                            = */
	    /* =   common_return 페이지는 이러한 통보 데이터를 받기 위한 샘플 페이지        = */
	    /* =   입니다. 현재의 페이지를 업체에 맞게 수정하신 후, 아래 사항을 참고하셔서  = */
	    /* =   KCP 관리자 페이지에 등록해 주시기 바랍니다.                              = */
	    /* =                                                                            = */
	    /* =   등록 방법은 다음과 같습니다.                                             = */
	    /* =  - KCP 관리자페이지(admin.kcp.co.kr)에 로그인 합니다.                      = */
	    /* =  - [쇼핑몰 관리] -> [정보변경] -> [공통 URL 정보] -> 공통 URL 변경 후에    = */
	    /* =    가맹점 URL을 입력합니다.                                                = */
	    /* ============================================================================== */

	    //02. 공통 통보 데이터 받기
	    String site_cd      = box.getString("site_cd");  // 사이트 코드
	    String tno          = box.getString("tno");  // KCP 거래번호
	    String order_no     = box.getString("order_no");  // 주문번호
	    String tx_cd        = box.getString("tx_cd");  // 업무처리 구분 코드
	    String tx_tm        = box.getString("tx_tm");  // 업무처리 완료 시간

	    String ipgm_name    = ""; // 주문자명
	    String remitter     = ""; // 입금자명
	    String ipgm_mnyx    = ""; // 입금 금액
	    String ipgm_time	= ""; // 입금 시간
	    String bank_code    = ""; // 은행코드
	    String account      = ""; // 가상계좌 입금계좌번호
	    String op_cd        = ""; // 처리구분 코드
	    String noti_id      = ""; // 통보 아이디
	    String cash_a_no	= ""; // 현금영수증 발급코드

	    //   02-1. 가상계좌 입금 통보 데이터 받기
	    if ( tx_cd.equals("TX00") ) {
	        ipgm_name =  box.getString("ipgm_name");          // 주문자명
	        ipgm_time =  box.getString("ipgm_time");          // 주문자명
	        remitter  = box.getString("remitter");            // 입금자명
	        ipgm_mnyx =  box.getString("ipgm_mnyx");          // 입금 금액
	        bank_code =  box.getString("bank_code");          // 은행코드
	        account   =  box.getString("account");            // 가상계좌 입금계좌번호
	        op_cd     =  box.getString("op_cd");              // 처리구분 코드
	        noti_id   =  box.getString("noti_id");            // 통보 아이디
	        cash_a_no = box.getString("cash_a_no");
	        try {
	        	sqlWrap.startTransaction();
	        	HashMap param = box.getMap();
	        	if(!cash_a_no.equals("")) { //현금영수증 발급이 되었다면
	        		param.put("cash_yn", "Y");
	        		param.put("cash_authno", cash_a_no);
	        	} else {
	        		param.put("cash_yn", "N");
	        		param.put("cash_authno", "");
	        	}

	        	Box historyInfo = sqlWrap.queryForBox("selectPaymentHistoryDetail", box.getMap());
	        	if(noti_id.equals(historyInfo.getString("noti_id"))) { //이미 입금 처리된건
	        		return 1;
	        	}

	        	retVal = sqlWrap.update("updatePaymentHistoryIpgm",param);
	        	if(retVal > 0) {
	        		retVal = sqlWrap.update("updatePaymentIpgm",param);
	        	}
	        	sqlWrap.commitTransaction();
	        	return retVal;
	        } catch(SQLException e) {
	        	return  -1;
	        } finally {
	        	sqlWrap.endTransaction();
	        }
	    } else {
	    	return 0;
	    }

	}

  /**
   * 사용자 환불계좌정보를 업데이트 한다.
   *
   * @return  int
   */
	public int updateUserRefundAccount(Box box) throws Exception{
		int retVal = 0;
	    try{
	    	sqlWrap.startTransaction();
	    	box.put("p_userid", box.getString("s_userid"));
	    	retVal = sqlWrap.update("updateMemberRefundAccount",box.getMap());

	    }catch(Exception e){
	        throw e;
	    }finally{
	    	sqlWrap.endTransaction();
	    }

		return retVal;
	}

	/**
	* 과정명, 과정기수 가져오기
	*
	* @return  DataSet
	*/
	public DataSet getPaymentSubjNmSubjSeq(Box box) throws Exception{

		DataSet data = null;
	    try{
	      	data = sqlWrap.queryForDataSet("getPaymentSubjNmSubjSeq", box.getMap());
	    }catch(Exception e){
	       	throw e;
	    }finally{
	    }
		return data;
	}

	 /**
     * 환불 처리중으로 수정하기
     * @param box
     * @return
     * @throws Exception
     */
	public int updateRePayRecogstate(Box box) throws Exception{
		int retVal = 0;
	    try{
	    	sqlWrap.startTransaction();
	    	// 수정정보 history
			this.insertPaymentChangeHistory(box);
	    	retVal = sqlWrap.update("updateRePayRecogstate",box.getMap());
	    	sqlWrap.commitTransaction();
	    }catch(Exception e){
	        throw e;
	    }finally{
	    	sqlWrap.endTransaction();
	    }

		return retVal;
	}


	 /**
	   * 회/ 비 / 특별할인 리스트 가져온다.
	   *
	   * @return  DataSet
	   */
	public DataSet getSubjDiscountAll() throws Exception{
		DataSet data = null;
    try{
    	data = sqlWrap.queryForDataSet("getSubjDiscountAll");
    }catch(Exception e){
    	throw e;
    }finally{
    }
    return data;
	}

	 /**
     * 수강신청 영문이름 수정
     * @param box
     * @return
     * @throws Exception
     */
	public int updateProposeEngName(Box box) throws Exception{
		int retVal = 0;
	    try{
	    	sqlWrap.startTransaction();
	    	retVal = sqlWrap.update("updateProposeEngName",box.getMap());
	    	sqlWrap.commitTransaction();
	    }catch(Exception e){
	        throw e;
	    }finally{
	    	sqlWrap.endTransaction();
	    }

		return retVal;
	}

	/**
	 * 회/비/특별할인 리스트 가져오기
	 * @param box
     * @return
     * @throws Exception
     */
	public DataSet selectPriceTypeItem(Box box) throws Exception{

		DataSet data = null;

        try{
        	data = sqlWrap.queryForDataSet("selectPriceTypeItem", box.getMap());
        }catch(Exception e){
        	throw e;
        }finally{
        }

		return data;
	}

	/**
	 * 결재 정보 개별 항목 업데이트
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int changePaymentItem(Box box) throws Exception {

		int retVal = 0;

		HashMap<String,String> hmParam = new HashMap<String,String>();
		String v_seq 		=	 box.getString("p_seq");
		String v_subj 		=	 box.getString("p_subj");
		String v_subjseq	=	 box.getString("p_subjseq");
		String v_year		=	 box.getString("p_year");
		String v_userid		=	 box.getString("p_userid");
		String v_codegubun	=	 box.getString("p_codegubun");
		String s_userid		=	 box.getString("s_userid");

		if(v_subj == null || v_subj.equals("")){
			Box paymentInfo = sqlWrap.queryForBox( "selectPaymentCouseRightInfo", box.getMap() );

			v_subj 		=	 paymentInfo.getString("SUBJ");
			v_subjseq	=	 paymentInfo.getString("SUBJSEQ");
			v_year		=	 paymentInfo.getString("YEAR");
			v_userid	=	 paymentInfo.getString("USERID");
		}

		hmParam.put("p_seq"	 		, v_seq);
		hmParam.put("p_subj"	 	, v_subj);
		hmParam.put("p_subjseq"	 	, v_subjseq);
		hmParam.put("p_year"	 	, v_year);
		hmParam.put("p_userid"	 	, v_userid);
		hmParam.put("s_userid"	 	, s_userid);

		try {
			sqlWrap.startTransaction();
			if(v_codegubun.equals("PRICETYPE")){

				hmParam.put("p_pricetype"	, box.getString("p_pricetype"));
				String v_biyong = (String)sqlWrap.queryForObject( "getSubjBiyong", hmParam );
				hmParam.put("p_biyong", v_biyong);
				sqlWrap.update( "updateProposeBiyongPrice", hmParam );

			}else if(v_codegubun.equals("IMPLNOTIYN")){

				hmParam.put("p_implnotiyn"	, box.getString("p_implnotiyn"));

				if( hmParam.get("p_implnotiyn").equals("Y")) {
					// N --> Y 로 수정  Y: 1003 ( 고용보험 )
					hmParam.put("p_costsupport", "1003");
				}else {
					// Y --> N 로 수정  N: 1004 ( 일반 )
					hmParam.put("p_costsupport", "1004");
				}
				sqlWrap.update( "updateCostSupport", hmParam );

			}else if(v_codegubun.equals("DOCUMENTSYN")){
				// 문서발급

				hmParam.put("p_documentsyn"	, box.getString("p_documentsyn"));
				// 수정정보 history
				this.insertPaymentChangeHistory(box);
				sqlWrap.update( "updatePaymentMethodDocuments", hmParam );

			}else if(v_codegubun.equals("PAYMETHOD")){
				// 결제 방법 변경
				hmParam.put("p_paymethod"	, box.getString("p_paymethod"));
				// 수정정보 history
				this.insertPaymentChangeHistory(box);
				sqlWrap.update( "updatePaymentMethodDocuments", hmParam );

			}else if(v_codegubun.equals("RECOGSTATE")){
				// 결제 상태 변경
				hmParam.put("p_recogstate"	, box.getString("p_recogstate"));
				// 수정정보 history
				this.insertPaymentChangeHistory(box);
				
				// 결완료시  t_lms_propose 업데이트,  t_lms_student 인서트 한다.

				// 마일리지 부여 / 취소
				MileageMgr mileageMgr = new MileageMgr();
				
				// 
				if(hmParam.get("p_recogstate").equals("Y")){			// 입금완료
					ProposeMgr proposeMgr = new ProposeMgr();
					MemberMgr memberMgr = new MemberMgr();
					sqlWrap.update( "updatePaymentRecogState", hmParam );
					
					int temp = mileageMgr.selectSubjSeqPoint(hmParam);
		    		if(temp  > 0){
		    			box.put("p_userid", v_userid);
	    				box.put("p_content", "수강신청을 하는 경우");
	    				box.put("p_useyn", "N");
	    				box.put("p_point", temp);
	    				box.put("p_gubun", "0004");
	    				mileageMgr.insertSaveMileage(box);
		    		}
					
					// 수강정보 업데이트
					hmParam.put("p_isdinsert", "N");
					retVal = sqlWrap.update("updateProposeConfirmWithSubBL",hmParam);
					if ( retVal > 0 ) {
						retVal = sqlWrap.update("insertStudentBL", hmParam);
						if ( retVal == 0 ) {
							retVal = 100;
							return retVal ;
						}
					}
					
					// 대표 id 전용
					HashMap<String, String> hmParam2 = new HashMap<String, String>();
					
					// 대표 id
					hmParam2.put("p_userid", hmParam.get("p_userid"));
					hmParam2.put("p_subj", hmParam.get("p_subj"));
					hmParam2.put("p_subjseq", hmParam.get("p_subjseq"));
					hmParam2.put("p_recogstate", "N");						// 승인상태(대기를 완료로)
					
					System.out.println("대표 p_represent : "+hmParam2.get("p_represent"));
					System.out.println("대표 p_subj : "+hmParam2.get("p_subj"));
					System.out.println("대표 p_subjseq : "+hmParam2.get("p_subjseq"));
					System.out.println("대표 p_recogstate : "+hmParam2.get("p_recogstate"));
					
					// 단체수강신청 여부 확인	
					DataSet selectProposeStudent = proposeMgr.selectProposeStudent(hmParam2);
					
					// 대표 id	(대표 id & 단체신청)
					if ( selectProposeStudent.getRow() > 0 ){
						System.out.println("--- 대표 id & 단체신청 (입금완료) ---");
						box.put("p_userid", 		hmParam.get("p_userid"));
						box.put("s_userid", 		hmParam.get("s_userid"));
						box.put("p_subj", 			hmParam.get("p_subj"));
						box.put("p_subjseq", 		hmParam.get("p_subjseq"));
						box.put("p_year", 			hmParam.get("p_year"));
						box.put("p_recogstate", 	hmParam.get("p_recogstate"));						// 승인상태
						box.put("p_joincd", 		"03");												// 가입동기
						box.put("p_price", 			0);													// 결제금액
						box.put("p_biyong", 		0);													// 교육비
						box.put("p_bookpricesum", 	0);													// 교재비
						box.put("p_usemileage", 	0);													// 사용 마일리지
						box.put("p_costsupport", 	"1004");
						box.put("p_reggb", 			"nofee");
				        box.put("p_feegb", 			"NN");
				        box.put("p_anniversary", 	"");
						box.put("p_income", 		"");
						box.put("p_issms", 			"N");
						box.put("p_ismailing", 		"N");
						box.put("p_children", 		"0");
						box.put("p_iskita", 		"Y");
						box.put("p_mempath", 		"10");
						box.put("p_chkfinal", 		"M");												// 결제가 완료 되었으면 Y 아니면 M
						box.put("p_essenyn", 		"Y");
						box.put("p_isdinsert", 		"N");
						box.put("p_isoptsubjectselect", "");
						box.put("p_isb2c", 			"Y");
						box.put("p_office_gbn", 	"Y");												// 로그인 시 필요
						box.put("p_recogstate", "Y");													// 승인상태(완료)
												
						System.out.println("check !!");
						System.out.println("대표 p_userid : "+box.get("p_userid"));
						System.out.println("대표 s_userid : "+box.getString("s_userid"));
						System.out.println("대표 p_subj : "+box.getString("p_subj"));
						System.out.println("대표 p_subjseq : "+box.getString("p_subjseq"));
						System.out.println("대표 p_year : "+box.getString("p_year"));					
						
						DataSet representInfo = null;
						representInfo = memberMgr.selectMemberDetail(box);
						for(int i = 0; i< representInfo.getRow(); i++){
							representInfo.next();
							box.put("p_postgb", 	representInfo.getString("POSTGB"));													// 우편물 접수처
							box.put("p_jobc_csenr", representInfo.getString("JOBC_CSENR"));												// 직업
						}
						
						// 수강생 리스트 불러오기
						for( int i = 0 ; i < selectProposeStudent.getRow(); i++ ){
							selectProposeStudent.next();							
							box.put("p_userid", 	selectProposeStudent.getString("USERID"));											// 수강생 아이디
							box.put("p_name", 		selectProposeStudent.getString("NAME"));											// 수강생 이름
							box.put("p_email", 		selectProposeStudent.getString("EMAIL"));											// 수강생 이메일
							box.put("p_birthday", 	selectProposeStudent.getString("BIRTHDAY"));										// 수강생 생일
							box.put("p_handphone", 	selectProposeStudent.getString("HANDPHONE"));										// 수강생 휴대폰
							box.put("p_usergubun", "KC");																				// 유저구분 (일반)
							box.put("p_resno", 		box.getString("p_birthday")+"0000000");												// 주민등록번호
							box.put("p_resno1", 	box.getString("p_birthday"));														// 주민등록번호 앞자리
							box.put("p_resno2", 	"0000000");																			// 주민등록번호 뒷자리
							box.put("p_pwd", 		box.getString("p_userid"));							
							box.put("p_pwdconfirm", box.getString("p_userid"));
							box.put("p_pwd", (String) sqlWrap.queryForObject("selectNewPwd", box.getString("p_pwd")));
							box.put("emailID", 		box.getString("p_email").substring(0, box.getString("p_email").indexOf("@")));		// 이메일 앞자리
							box.put("emailTail", 	box.getString("p_email").substring(box.getString("p_email").indexOf("@")+1));		// 이메일 뒷자리
							box.put("p_emailid", 	box.getString("emailID"));
							box.put("p_emailaddr", 	box.getString("emailTail"));
							box.put("p_comp", 		"10000");
							box.put("p_tel1", 		box.getString("p_handphone").substring(0, 3));										// 전화번호
							box.put("p_tel2", 		box.getString("p_handphone").substring(4, 8));		
							box.put("p_tel3", 		box.getString("p_handphone").substring(9));
							box.put("p_rcvrtel", 	box.getString("p_tel1") +"-"+box.getString("p_tel2")+"-"+box.getString("p_tel3")) ;
							box.put("p_rcvrmobile", box.getString("p_handphone") ) ;
							
							System.out.println("p_userid : "+box.getString("p_userid"));
							System.out.println("p_name : "+box.getString("p_name"));
							System.out.println("p_email : "+box.getString("p_email"));
							System.out.println("p_birthday : "+box.getString("p_birthday"));
							
							hmParam = box.getMap();
							
							// 수강생 회원가입 시키기
							sqlWrap.insert("insertBtoCMember", hmParam);
							System.out.println("수강생 회원가입 완료");
							
							//비밀번호 암호화 방식이 2014년 적용된 새로운 암호화 방식임을 알아보는  new_pwd_yn 컬럼 업데이트(t_lms_member) 및 merge(MEMBER_SUB_INFO@TRADE)
							String userID = box.getString("p_userid");
							sqlWrap.update("updateMemberNewPwdYnIsY", userID);//t_lms_member 의 NEW_PWD_YN 컬럼 업데이트
							
							// 수강생 수강신청
							hmParam.put("p_isdinsert", "N");
							sqlWrap.insert("insertProposeBL", hmParam);	
							System.out.println("수강생 수강신청 완료");
												
							// 수강생 수강승인  처리한다
							retVal = sqlWrap.update("updateProposeConfirmWithSubBL",hmParam);		
							if ( retVal > 0 ) {
								System.out.println("수강생 수강승인 완료");
								
								// 대표&수강생 관계테이블 승인상태 업데이트
								sqlWrap.update("updateProposeStudent", hmParam);
								System.out.println("대표&수강생 관계테이블 승인상태 업데이트");
								
								// 수강생 학생정보 업데이트
								retVal = sqlWrap.update("insertStudentBL", hmParam);
								if ( retVal == 0 ) {
									System.out.println("수강생 학생정보 업데이트 실패");
									retVal = 100;
									return retVal ;
								}
							} else {
								System.out.println("수강생 수강승인 실패");
								retVal = 100;					// 수강테이블 업데이트에 실패하였습니다.
								return retVal;
							}
							System.out.println("수강생 학생정보 업데이트 완료");
						}
					}// 대표 id
					
				}else {		// 입금대기
					ProposeMgr proposeMgr = new ProposeMgr();
		    		MemberMgr memberMgr = new MemberMgr();
					
		    		sqlWrap.update( "updatePaymentRecogState", hmParam );
		    		
		    		int temp = mileageMgr.selectSubjSeqPoint(hmParam);
		    		if(temp  > 0){
		    			box.put("p_userid", v_userid);
	    				box.put("p_content","수강신청을 하는 경우(취소)");
	    				box.put("p_useyn", "Y");
	    				box.put("p_point", temp);
	    				box.put("p_gubun","9999");
	    				mileageMgr.insertSaveMileage(box);
		    		}
		    		
					// 입금대기시  t_lms_propose 업데이트,  t_lms_student delete 한다.
					retVal = sqlWrap.update("updateProposeWaitWithSubBL",hmParam);
					if ( retVal > 0 ) {
						retVal = sqlWrap.update("deleteStudentWait", hmParam);
					}
					
					// 대표 id 전용
					HashMap<String, String> hmParam2 = new HashMap<String, String>();
					
					// 대표 id
					hmParam2.put("p_userid", hmParam.get("p_userid"));
					hmParam2.put("p_subj", hmParam.get("p_subj"));
					hmParam2.put("p_subjseq", hmParam.get("p_subjseq"));
					hmParam2.put("p_recogstate", "Y");						// 승인상태(완료를 대기로)
					
					// 단체수강신청 여부 확인	
					DataSet selectProposeStudent = proposeMgr.selectProposeStudent(hmParam2);
					
					// 대표 id	(대표 id & 단체신청)
					if ( selectProposeStudent.getRow() > 0  ){
						System.out.println("--- 대표 id & 단체신청 (입금대기) ---");
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
									System.out.println("대표&수강생 관계테이블 승인상태 업데이트");
								}
							}
						}
					} 
					
				}
			}else if(v_codegubun.equals("OPENRECOGSTATE")){
				// 결제 상태 변경
				hmParam.put("p_recogstate"	, box.getString("p_recogstate"));
				// 수정정보 history
				this.insertPaymentChangeHistory(box);
				sqlWrap.update( "updatePaymentRecogState", hmParam );
				// 결제완료시  t_lms_propose 업데이트,  t_lms_student 인서트 한다.
				if(hmParam.get("p_recogstate").equals("Y")){
					hmParam.put("p_isdinsert", "N");
					retVal = sqlWrap.update("updateProposeConfirmWithSel",hmParam);
					if ( retVal > 0 ) {
						retVal = sqlWrap.update("insertStudentSel", hmParam);
						if ( retVal == 0 ) {
							retVal = 100;
							return retVal ;
						}
					}
				}else {
					// 완료 -> 대기   t_lms_propose 업데이트,  t_lms_student delete 한다.
					retVal = sqlWrap.update("updateProposeWaitWithSel",hmParam);
					if ( retVal > 0 ) {
						retVal = sqlWrap.update("deleteStudentSel", hmParam);

					}
				}
			}
			
			sqlWrap.commitTransaction();
			
			retVal = 1;

		} catch ( Exception e ) {
			e.printStackTrace();
			throw e;
		} finally {
			sqlWrap.endTransaction();
		}
		
		return retVal;
	}

	/**
	 * 결재 정보 - 선택한   항목 전체  업데이트
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int changePaymentItemAll(Box box) throws Exception {

		int retVal = 0;
		int notupdatecnt = 0 ;

		HashMap<String,String> hmParam = new HashMap<String,String>();
		String v_seqs 		=	 box.getString("p_seqs");
		String v_mode 		=	 box.getString("p_mode");
		String v_selectitem	=	 box.getString("p_selectitem");
		String v_recogstate = "";
		try {

			sqlWrap.startTransaction();

			DataSet paymentInfo = sqlWrap.queryForDataSet( "selectPaymentCouseRightInfo", box.getMap() );

			if( v_mode.equals("PRICETYPE")){

				for( int i = 0 ; i < paymentInfo.getRow(); i++ ){
					hmParam = new HashMap<String,String>();
					paymentInfo.next();
					hmParam.put("p_pricetype"	, v_selectitem );
					hmParam.put("p_seq"	 		, paymentInfo.getString("SEQ"));
					hmParam.put("p_subj"	 	, paymentInfo.getString("SUBJ"));
					hmParam.put("p_subjseq"	 	, paymentInfo.getString("SUBJSEQ"));
					hmParam.put("p_year"	 	, paymentInfo.getString("YEAR"));
					hmParam.put("p_userid"	 	, paymentInfo.getString("USERID"));
					hmParam.put("s_userid"	 	, box.getString("s_userid"));
					v_recogstate = paymentInfo.getString("RECOGSTATE");

					String v_biyong = (String)sqlWrap.queryForObject( "getSubjBiyong", hmParam );
					if( v_biyong == null || v_biyong.equals("") || !paymentInfo.getString("INSTALLMENT_SEQ").equals("999")
							|| v_recogstate.equals("D")|| v_recogstate.equals("E")|| v_recogstate.equals("C") ){
						notupdatecnt++;
					}else {
						hmParam.put("p_biyong", v_biyong);
						sqlWrap.update( "updateProposeBiyongPrice", hmParam );
					}
				}
			}else if( v_mode.equals("IMPLNOTIYN")){

				for( int i = 0 ; i < paymentInfo.getRow(); i++ ){
					hmParam = new HashMap<String,String>();
					paymentInfo.next();
					hmParam.put("p_implnotiyn"	, v_selectitem );
					hmParam.put("p_seq"	 		, paymentInfo.getString("SEQ"));
					hmParam.put("p_subj"	 	, paymentInfo.getString("SUBJ"));
					hmParam.put("p_subjseq"	 	, paymentInfo.getString("SUBJSEQ"));
					hmParam.put("p_year"	 	, paymentInfo.getString("YEAR"));
					hmParam.put("p_userid"	 	, paymentInfo.getString("USERID"));
					hmParam.put("s_userid"	 	, box.getString("s_userid"));

					if( hmParam.get("p_implnotiyn").equals("Y")) {
						// N --> Y 로 수정  Y: 1003 ( 고용보험 )
						hmParam.put("p_costsupport", "1003");
					}else {
						// Y --> N 로 수정  N: 1004 ( 일반 )
						hmParam.put("p_costsupport", "1004");
					}
					sqlWrap.update( "updateCostSupport", hmParam );
				}
			}else if( v_mode.equals("DOCUMENTSYN")){

				for( int i = 0 ; i < paymentInfo.getRow(); i++ ){
					hmParam = new HashMap<String,String>();
					paymentInfo.next();
					hmParam.put("p_documentsyn"	, v_selectitem );
					hmParam.put("p_seq"	 		, paymentInfo.getString("SEQ"));
					hmParam.put("p_subj"	 	, paymentInfo.getString("SUBJ"));
					hmParam.put("p_subjseq"	 	, paymentInfo.getString("SUBJSEQ"));
					hmParam.put("p_year"	 	, paymentInfo.getString("YEAR"));
					hmParam.put("p_userid"	 	, paymentInfo.getString("USERID"));
					hmParam.put("s_userid"	 	, box.getString("s_userid"));

					// 수정정보 history
					this.insertPaymentChangeHistory(new Box(hmParam));

					sqlWrap.update( "updatePaymentMethodDocuments", hmParam );
				}
			}else if( v_mode.equals("AMOUNT")){
				String v_amount = box.getString("p_amount");
				String v_paymentComplete = box.getString("p_paymentComplete");

				for( int i = 0 ; i < paymentInfo.getRow(); i++ ){
					hmParam = new HashMap<String,String>();
					paymentInfo.next();
					hmParam.put("p_amount"		, v_amount );

					hmParam.put("p_seq"	 		, paymentInfo.getString("SEQ"));
					hmParam.put("p_subj"	 	, paymentInfo.getString("SUBJ"));
					hmParam.put("p_subjseq"	 	, paymentInfo.getString("SUBJSEQ"));
					hmParam.put("p_year"	 	, paymentInfo.getString("YEAR"));
					hmParam.put("p_userid"	 	, paymentInfo.getString("USERID"));
					hmParam.put("s_userid"	 	, box.getString("s_userid"));

					hmParam.put("p_refundreqdt"	 	, paymentInfo.getString("REFUNDREQDT"));
					hmParam.put("p_refundamount"	, paymentInfo.getString("REFUNDAMOUNT"));
					hmParam.put("p_refundaccount"	, paymentInfo.getString("REFUNDACCOUNT"));
					hmParam.put("p_refunddepositor"	, paymentInfo.getString("REFUNDDEPOSITOR"));

					if(v_paymentComplete.equals("Y") && (paymentInfo.getString("PAYDATE") == null || paymentInfo.getString("PAYDATE").equals("")) ){
						hmParam.put("p_isComplet"	, v_paymentComplete );

						hmParam.put("p_isdinsert", "N");
						retVal = sqlWrap.update("updateProposeConfirmWithSubBL",hmParam);
						if ( retVal > 0 ) {
							retVal = sqlWrap.update("insertStudentBL", hmParam);
							if ( retVal == 0 ) {
								retVal = 100;
								return retVal ;
							}
						}

					}
					if(v_paymentComplete.equals("Y") && (paymentInfo.getString("RECOGSTATE").equals("N")) ){   //입금대기 상태일 경우  -> 입금 완료로 수정
						hmParam.put("p_recogstate"	 	, "Y");

						MileageMgr mileageMgr = new MileageMgr();
						int temp = mileageMgr.selectSubjSeqPoint(hmParam);
			    		if(temp  > 0){
			    			hmParam.put("p_content","수강신청을 하는 경우");
			    			hmParam.put("p_useyn", "N");
			    			hmParam.put("p_point", temp+"");
			    			hmParam.put("p_gubun","0004");
			    			Box mile = new Box(hmParam);
		    				mileageMgr.insertSaveMileage(mile);
			    		}

					}else {
						hmParam.put("p_recogstate"	 	, paymentInfo.getString("RECOGSTATE") );
					}

					// 수정정보 history
					this.insertPaymentChangeHistory(new Box(hmParam));
					sqlWrap.update( "updatePaymentRefund", hmParam );

				}
			}else if( v_mode.equals("OPENAMOUNT")){
				String v_amount = box.getString("p_amount");
				String v_paymentComplete = box.getString("p_paymentComplete");

				for( int i = 0 ; i < paymentInfo.getRow(); i++ ){
					hmParam = new HashMap<String,String>();
					paymentInfo.next();
					hmParam.put("p_amount"		, v_amount );

					hmParam.put("p_seq"	 		, paymentInfo.getString("SEQ"));
					hmParam.put("p_subj"	 	, paymentInfo.getString("SUBJ"));
					hmParam.put("p_subjseq"	 	, paymentInfo.getString("SUBJSEQ"));
					hmParam.put("p_year"	 	, paymentInfo.getString("YEAR"));
					hmParam.put("p_userid"	 	, paymentInfo.getString("USERID"));
					hmParam.put("s_userid"	 	, box.getString("s_userid"));

					hmParam.put("p_refundreqdt"	 	, paymentInfo.getString("REFUNDREQDT"));
					hmParam.put("p_refundamount"	, paymentInfo.getString("REFUNDAMOUNT"));
					hmParam.put("p_refundaccount"	, paymentInfo.getString("REFUNDACCOUNT"));
					hmParam.put("p_refunddepositor"	, paymentInfo.getString("REFUNDDEPOSITOR"));

					if(v_paymentComplete.equals("Y") && (paymentInfo.getString("PAYDATE") == null || paymentInfo.getString("PAYDATE").equals("")) ){
						hmParam.put("p_isComplet"	, v_paymentComplete );

						retVal = sqlWrap.update("updateProposeConfirmWithSel",hmParam);
						if ( retVal > 0 ) {
							retVal = sqlWrap.update("insertStudentSel", hmParam);
							if ( retVal == 0 ) {
								retVal = 100;
								return retVal ;
							}
						}

					}
					if(v_paymentComplete.equals("Y") && (paymentInfo.getString("RECOGSTATE").equals("N")) ){   //입금대기 상태일 경우  -> 입금 완료로 수정
						hmParam.put("p_recogstate"	 	, "Y");
					}else {
						hmParam.put("p_recogstate"	 	, paymentInfo.getString("RECOGSTATE") );
					}

					// 수정정보 history
					this.insertPaymentChangeHistory(new Box(hmParam));
					sqlWrap.update( "updatePaymentRefund", hmParam );
				}
			}

			sqlWrap.commitTransaction();
			box.put("notupdatecnt", notupdatecnt) ;
			retVal = 1;

		} catch ( Exception e ) {
			throw e;
		} finally {
			sqlWrap.endTransaction();
		}

		return retVal;
	}

	/**
	* 단위 수강 결제 리스트를 반환한다.
	*
	* @return  DataSet
	*/
	public ListDTO selectPaymentSectionList(Box box) throws Exception{

		ListDTO data = null;
		int pageNo = box.getInt("p_pageno");
		int listScale = box.getInt("p_listscale");
	    try{
	      	data = sqlWrap.queryForPageList("selectPaymentSectionPageList", box.getMap(), pageNo, listScale);
	    }catch(Exception e){
	       	throw e;
	    }finally{
	    }
		return data;
	}

	 /**
	 * 환불처리 리스트를 반환한다.
	 *
	 * @return  DataSet
	 */

	public ListDTO selectRefundSectionList(Box box) throws Exception{

		ListDTO data = null;
		int pageNo = box.getInt("p_pageno");
		int listScale = box.getInt("p_listscale");
	    try{
	       	data = sqlWrap.queryForPageList("selectRefundSectionPageList", box.getMap(), pageNo, listScale);
	    }catch(Exception e){
	      	throw e;
	    }finally{
	    }

		return data;
	}

	 /**
     * 부분수강 결제 상세정보를 리턴해준다.
     * @param box
     * @return
     * @throws Exception
     */
    public Box selectPaymentSectionDetail(Box box) throws Exception {
    	Box data = null;
		try {
			data = sqlWrap.queryForBox("selectPaymentSectionDetail", box.getMap());
		} catch (Exception e) {
			throw e;
		} finally {
		}

	    return data;
   }

    /**
     * 부분수강 결제 정보를 수정한다.
     * @param box
     * @return int
     * @throws Exception
     */
  	public int refundSectionInfoUpdate(HttpServletRequest request,Box box) throws Exception{
  		int retVal = 0;

  		Box paymentInfo = selectPaymentSectionDetail(box);
	   	String v_refundcomplete = "";
	   	if(paymentInfo == null) {
	   		box.getMap().put("resultMsg", "해당되는 결제정보가 없습니다.");
	   		return 0;
	   	}

		try{
  	    	sqlWrap.startTransaction();

  	    	String paymethod = paymentInfo.getString("PAYMETHOD");
  	    	if(!paymethod.equals(box.getString("p_paymethod"))){
  	    		paymethod = box.getString("p_paymethod");
  	    	}

  	    	String cust_ip        = StringUtil.nvl(request.getHeader("Proxy-Client-IP")); // 요청 IP
  	    	String v_refundstate = box.getString("p_refundstate");

			String v_recogstate = paymentInfo.getString("RECOGSTATE") ;
			String v_repay_paper_state = paymentInfo.getString("REPAY_PAPER_STATE") ;

			String v_isrefund = "N";
			box.put("p_refundreqdt", box.getString("p_refundreqdt").trim());

			if( !v_recogstate.equals(v_refundstate)){
				//if(v_refundstate.equals("") && ( v_recogstate.equals("D") || v_recogstate.equals("R")  || v_recogstate.equals("P")) ){   // 미요청
				if(v_refundstate.equals("") ){   // 미요청
					v_recogstate = v_recogstate ;
				}else if (!v_refundstate.equals("") ){
					v_recogstate = v_refundstate ;
				}
				// 상태값이 환불처리중이고, repay_paper_state 가 9 이면 환불처리완료 (D) 로 수정하기
				if( v_refundstate.equals("P") && v_repay_paper_state.equals("9") ) {
					v_recogstate ="D";
				}

				if( v_refundstate.equals("D") ) v_isrefund = "Y";
			}
  	    	box.put("p_recogstate", v_recogstate);
  	    	if(v_recogstate.equals("")) return 0;

  			// 결제 금액 수정
			String v_orgamount 		= box.getString("p_orgamount");
			String v_amount			= box.getString("p_amount");

			if(!v_amount.equals("0") && box.getString("p_paymentComplete").equals("Y")){
				v_recogstate = "Y";
				box.put("p_recogstate", v_recogstate);
				box.put("p_isComplet", "Y"); 			// 결제일 업데이트

				if(!paymentInfo.getString("RECOGSTATE").equals("Y")){

					box.put("p_isdinsert", "N");
					retVal = sqlWrap.update("updateProposeConfirmWithSel",box.getMap());
					if ( retVal > 0 ) {
						retVal = sqlWrap.update("insertStudentSel", box.getMap() );
						if ( retVal == 0 ) {
							retVal = 0;
							return retVal ;
						}
					}

				}
			}
			if(v_amount.equals("0")) v_amount = v_orgamount;

			box.put("p_amount", v_amount);

			// 수정정보 history
			this.insertPaymentChangeHistory(box);
		    retVal = sqlWrap.update("updatePaymentRefund",box.getMap());

  		    sqlWrap.commitTransaction();
  	    }catch(Exception e){
  	        throw e;
  	    }finally{
  	    	sqlWrap.endTransaction();
  	    }

  		return retVal;
  	}

  	/**
	 * 부분 수강 결제  리스트를 반환한다.(엑셀)
	 *
	 * @return  DataSet
	*/
	public DataSet selectPaymentSectionExcel(Box box) throws Exception{

		DataSet data = null;
		ListDTO listDto = null;
    try{
    	listDto = sqlWrap.queryForPageList("selectPaymentSectionPageList", box.getMap(), 1, 65000);
    	data = listDto.getItemList();
    }catch(Exception e){
    	throw e;
    }finally{
    }
    return data;
	}

	/**
	   * 부분수강 환불처리 리스트를 반환한다.
	   *
	   * @return  DataSet
	   */
	public DataSet selectRefundSectionExcel(Box box) throws Exception{

	  DataSet data = null;
	  ListDTO listDto = null;
      try{
      	listDto = sqlWrap.queryForPageList("selectRefundSectionPageList", box.getMap(), 1, 65000);
      	data = listDto.getItemList();
      }catch(Exception e){
      	throw e;
      }finally{
      }
	  return data;
	}

	/**
	   * 결제정보 수정 history
	   *
	   * @return  DataSet
	   */
	public int insertPaymentChangeHistory(Box box) throws Exception{
		int retVal = 0;
	    try{
	    	sqlWrap.insert("insertPaymentChangeHistory", box.getMap());
	    }catch(Exception e){
	    	throw e;
	    }finally{
	    }
	   	return retVal;
	}
}

