
package com.sinc.lms.comp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.sinc.common.FormChecker;
import com.sinc.framework.Constants;
import com.sinc.framework.data.Box;
import com.sinc.framework.data.DataSet;
import com.sinc.framework.persist.AbstractMgr;
import com.sinc.framework.persist.DAOException;
import com.sinc.framework.persist.ListDTO;
import com.sinc.framework.util.StringUtil;
import com.sinc.lms.cp.CPSubjectMgr;
import com.sinc.lms.propose.ProposeMgr;
import com.sinc.lms.support.MileageMgr;

public class CompMgr extends AbstractMgr { 

   /**
   * 고객사 리스트를 반환한다. 
   *
   * @return  List
   */
	public ListDTO selectCompPageList(Box box) throws Exception{
		ListDTO data = null;
		int pageNo = box.getInt("l_pageno");
		int listScale = box.getInt("l_listscale");
        try{
        	data = sqlWrap.queryForPageList("selectTzCompPageList", box.getMap(), pageNo, listScale);
        }catch(Exception e){
        	throw e;
        }finally{
        }
	 
		return data;
	}

   /**
   * 고객사 객체를 반환한다. 
   *
   * @return  TbCateDTO
   */
	public DataSet  selectComp(String gubun) throws Exception{
		DataSet data = null;
	    try{ 
        	data = sqlWrap.queryForDataSet("selectTzComp", gubun);
	    }catch(Exception e){
	        throw e;
	    }finally{ 
	    }

		return data;
	}
	
	/**
   * 고객사 객체를 반환한다.
   *
   * @return  TbCateDTO
   */
	public Box  selectCompOne(String gubun) throws Exception{
		Box data = null;
	    try{ 
        	data = sqlWrap.queryForBox("selectTzComp", gubun);
	    }catch(Exception e){
	        throw e;
	    }finally{ 
	    }

		return data;
	}

   /**
   * 고객사를 등록해 준다. 
   *
   * @return  int
   */
	public int insertComp(Box box) throws Exception{
		int retVal = 0;
	    try{
		    sqlWrap.startTransaction();
		    sqlWrap.insert("insertTzComp", box.getMap());
            sqlWrap.commitTransaction();
            retVal = 1;
	    }catch(Exception e){
	        retVal = 0;
	    }finally{
	        sqlWrap.endTransaction();
	    }
 
		return retVal;
	}

   /**
   * 고객사를 수정해 준다. 
   *
   * @return  int
   */
	public int updateComp(Box box) throws Exception{
		int retVal = 0;
	    try{
		    sqlWrap.startTransaction();
		    sqlWrap.update("updateTzComp", box.getMap());
            sqlWrap.commitTransaction();
            retVal = 1;
            HashMap dataMap = new HashMap();
            dataMap.put("p_comp", box.getString("p_comp"));
            String v_cdpidp = ""; 
            if(box.getString("").equals("I")) v_cdpidp = "idp";
            else if(box.getString("").equals("C")) v_cdpidp = "cdp";
            dataMap.put("p_comp", box.getString("p_comp"));
            dataMap.put("p_meta", v_cdpidp);
            try{
			    sqlWrap.queryForObject("metaModiParam",dataMap);
			    log.debug("SCAP P_META_MODI Result : "+(String)dataMap.get("result")+", Result Message : "+(String)dataMap.get("resultMsg"));
            }catch(Exception e1){}   
	    }catch(Exception e){
	        throw e;
	    }finally{
	        sqlWrap.endTransaction();
	    }

		return retVal;
	}

   /**
   * 고객사를 삭제해 준다. 
   *
   * @return  int
   */
	public int deleteComp(Box box) throws Exception{
		int retVal = 0;

	    try{
		    sqlWrap.startTransaction();
		    //sqlWrap.delete("deleteBusinessPlcComp",comp);
		    //sqlWrap.delete("deleteCompSubjCategoryAll",comp);
		    sqlWrap.delete("deleteTzComp", box.getMap());
            sqlWrap.commitTransaction();
            retVal = 1;
	    }catch(Exception e){
	        throw e;
	    }finally{
	        sqlWrap.endTransaction();
	    }

		return retVal;
	}
	
	/**
	 * Prefix가 있는지를 체크한다.
	 * @param prefix
	 * @return
	 * @throws Exception
	 */
	public int selectPrefixCheck(String prefix) throws Exception {
		Box data = null;
	    try{ 
        	data = sqlWrap.queryForBox("selectPrefixCheck", prefix);
		} catch (Exception e) {
			throw e;
		} finally {
		}

		return data.getInt("COMPCNT");
	}

   /**
   * 그룹 리스트를 반환한다. 
   *
   * @return  List
   */
	public List selectGroupList() throws Exception{
		List data = null;
        try{
        	data = sqlWrap.queryForList("selectGroupList");
        }catch(Exception e){
        	throw e;
        }finally{
        }
	 
		return data;
	}

   /**
   * 그룹객체를 반환한다. 
   *
   * @return  TbCateDTO
   */
	public DataSet  selectGroup(String comp) throws Exception{
		DataSet data = null;
	    try{ 
        	data = sqlWrap.queryForDataSet("selectGroup", comp);
	    }catch(Exception e){
	        throw e;
	    }finally{ 
	    }

		return data;
	}

   /**
   * 그룹을 등록해 준다. 
   *
   * @return  int
   */
	public int insertGroup(Box box) throws Exception{
		int retVal = 0;
	    try{
		    sqlWrap.startTransaction();
		    sqlWrap.insert("insertGroup", box.getMap());
            sqlWrap.commitTransaction();
            retVal = 1;
	    }catch(Exception e){
	        retVal = 0;
	    }finally{
	        sqlWrap.endTransaction();
	    }
 
		return retVal;
	}

   /**
   * 그룹을 수정해 준다. 
   *
   * @return  int
   */
	public int updateGroup(Box box) throws Exception{
		int retVal = 0;
	    try{
		    sqlWrap.startTransaction();
		    sqlWrap.update("updateGroup", box.getMap());
            sqlWrap.commitTransaction();
            retVal = 1;
	    }catch(Exception e){
	        throw e;
	    }finally{
	        sqlWrap.endTransaction();
	    }

		return retVal;
	}

   /**
   * 그룹을 삭제해 준다. 
   *
   * @return  int
   */
	public int deleteGroup(Box box) throws Exception{
		int retVal = 0;

	    try{
		    sqlWrap.startTransaction();
		    sqlWrap.delete("deleteGroupComp", box.getMap());
		    sqlWrap.delete("deleteGroup", box.getMap());
            sqlWrap.commitTransaction();
            retVal = 1;
	    }catch(Exception e){
	        throw e;
	    }finally{
	        sqlWrap.endTransaction();
	    }

		return retVal;
	}
	
   /**
   * 사업장 리스트를 반환한다. 
   *
   * @return  List
   */
	public List selectBusinessPlcList(String p_comp) throws Exception{
		List data = null;
        try{
        	data = sqlWrap.queryForList("selectBusinessPlcList",p_comp);
        }catch(Exception e){
        	throw e;
        }finally{
        }
	 
		return data;
	}

   /**
   * 사업장객체를 반환한다. 
   *
   * @return  TbCateDTO
   */
	public DataSet  selectBusinessPlc(Box box) throws Exception{
		DataSet data = null;
	    try{ 
        	data = sqlWrap.queryForDataSet("selectBusinessPlc", box.getMap());
	    }catch(Exception e){
	        throw e;
	    }finally{ 
	    }

		return data;
	}
	
	public ListDTO selectBusinessPlcPageList(Box box) throws Exception{
		ListDTO data = null;
		int pageNo = box.getInt("p_pageno");
		
        try{
        	data = sqlWrap.queryForPageList("selectBusinessPlcPageList", box.getMap(), pageNo);
        }catch(Exception e){
        	throw e;
        }finally{
        }
	 
		return data;
	}

   /**
   * 사업장을 등록해 준다. 
   *
   * @return  int
   */
	public int insertBusinessPlc(Box box) throws Exception{
		int retVal = 0;
	    try{
		    sqlWrap.startTransaction();
		    sqlWrap.insert("insertBusinessPlc", box.getMap());
            sqlWrap.commitTransaction();
            retVal = 1;
	    }catch(Exception e){
	        throw e;
	    }finally{
	        sqlWrap.endTransaction();
	    }
 
		return retVal;
	}

   /**
   * 사업장을 수정해 준다. 
   *
   * @return  int
   */
	public int updateBusinessPlc(Box box) throws Exception{
		int retVal = 0;
	    try{
		    sqlWrap.startTransaction();
		    sqlWrap.update("updateBusinessPlc", box.getMap());
            sqlWrap.commitTransaction();
            retVal = 1;
	    }catch(Exception e){
	        throw e;
	    }finally{
	        sqlWrap.endTransaction();
	    }

		return retVal;
	}

   /**
   * 사업장을 삭제해 준다. 
   *
   * @return  int
   */
	public int deleteBusinessPlc(Box box) throws Exception{
		int retVal = 0;

	    try{
		    sqlWrap.startTransaction();
		    sqlWrap.delete("deleteBusinessPlc", box.getMap());
            sqlWrap.commitTransaction();
            retVal = 1;
	    }catch(Exception e){
	        throw e;
	    }finally{
	        sqlWrap.endTransaction();
	    }

		return retVal;
	}		
	
	/**
	 * 맵핑될 과정리스트를 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public List selectSubjMappingList(Box box) throws Exception{
		List data = null;
	    try{ 
        	data = sqlWrap.queryForList("selectSubjMappingList", box.getMap());
	    }catch(Exception e){
	        throw e;
	    }finally{ 
	    }

		return data;
	}

	/**
	 *  맵핑된 과정리스트를 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public List selectSubjMappedList(Box box) throws Exception{
		List data = null;
	    try{ 
        	data = sqlWrap.queryForList("selectSubjMappedList", box.getMap());
	    }catch(Exception e){
	        throw e;
	    }finally{ 
	    }

		return data;
	}
			
	/**
	 * 업체별 과정을 등록해준다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int insertCompSubj(Box box) throws Exception{
		int retVal = 0;
	    try{
		    sqlWrap.startTransaction();
		    HashMap map = new HashMap();
		    HashMap map2 = new HashMap();
		    ArrayList subjList = box.getList("checkVal");
		    map.put("comp",box.getString("p_comp"));
		    map.put("p_inuserid", box.getString("s_userid"));
		    String retStr = "";
		    for(int i =0; i < subjList.size();i++){
		    	map2.put("p_comp", box.getString("p_comp"));
		    	map2.put("p_subj", subjList.get(i));
		    	retStr = (String)sqlWrap.queryForObject("selectCompMappedCheck", map2);
		    	if(retStr.equals("0")){
			    	map.put("p_subj",subjList.get(i));
			    	sqlWrap.insert("insertCompCategory", map);
		    	}	
		    }
            sqlWrap.commitTransaction();
            retVal = 1;
	    }catch(Exception e){
	        throw e;
	    }finally{
	        sqlWrap.endTransaction();
	    }
 
		return retVal;
	}
	
	/**
	 * 고객사별로 매핑된 과정을 삭제해준다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int deleteCompCategory(Box box) throws Exception{
		int retVal = 0;
	    try{
		    sqlWrap.startTransaction();
		    HashMap map = new HashMap();
		    ArrayList subjList = box.getList("checkVal");
		    map.put("comp",box.getString("p_comp"));
		    String retStr = "";
		    for(int i =0; i < subjList.size();i++){
		    	map.put("p_subj",subjList.get(i));
		    	sqlWrap.delete("deleteCompCategory", map);
		    }
            sqlWrap.commitTransaction();
            retVal = 1;
	    }catch(Exception e){
	        throw e;
	    }finally{
	        sqlWrap.endTransaction();
	    }
 
		return retVal;
	}

	/**
	 * 고객사별 매핑된 과정 사용여부를 바꿔준다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int updateCompCategoryUseyn(Box box) throws Exception{
		int retVal = 0;
	    try{
		    sqlWrap.startTransaction();
		    sqlWrap.startBatch();
		    HashMap map = new HashMap();
		    ArrayList subjList = box.getList("checkVal");
		    map.put("p_comp",box.getString("p_comp"));
		    map.put("p_useyn",box.getString("p_useyn"));
		    String retStr = "";
		    for(int i =0; i < subjList.size();i++){
		    	map.put("p_subj",subjList.get(i));
		    	sqlWrap.delete("updateCompCategoryUseyn", map);
		    }
		    sqlWrap.executeBatch();
            sqlWrap.commitTransaction();
            retVal = 1;
	    }catch(Exception e){
	        throw e;
	    }finally{
	        sqlWrap.endTransaction();
	    }
 
		return retVal;
	}
	
	/**
	 * 고객사별 과정 설정정보를 저장해준다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int updateCompCategory(Box box) throws Exception{
		int retVal = 0;
		String biyong = "" ;
		String cppay = "" ;
	    try{
		    sqlWrap.startTransaction();
		    HashMap map = new HashMap();
		    map.put("p_comp",box.getString("p_comp"));
		    map.put("p_edutype",box.getString("p_edutype"));
		    map.put("p_basetime",box.getString("p_basetime"));
		    map.put("p_edulimit",box.getString("p_edulimit"));
		    map.put("p_chasilimit", box.getString("p_chasilimit"));
		    map.put("p_captcha", box.getString("p_captcha"));
		    map.put("p_autoapproval",box.getString("p_autoapproval"));
		    biyong = box.getString("p_biyong");
		    cppay = box.getString("p_cppay");
		    
		    if(StringUtil.isNotNull(biyong)) {
		    	biyong = biyong.replaceAll(",", "");
		    }
		    if(StringUtil.isNotNull(cppay)) {
		    	cppay = cppay.replaceAll(",", "");
		    }
		    map.put("p_biyong",biyong);
		    map.put("p_cppay",cppay);
		    
		    HashMap jikchek = new HashMap();
		    jikchek.put("p_comp",box.getString("p_comp"));
		    jikchek.put("s_userid",box.getString("s_userid"));
		    ArrayList v_jikuplist = box.getList("p_jikup");
		    String v_subjlist = box.getString("p_subjlist");
		    String[] subjList = v_subjlist.split("/");
		    String retStr = "";
		    for(int i =0; i < subjList.length;i++){
		    	map.put("p_subj",subjList[i]);
		    	jikchek.put("p_subj",subjList[i]);
		    	sqlWrap.update("updateCompSubjCategory", map);
		    	sqlWrap.delete("deleteSubjJikup", jikchek);
		    	for(int j = 0; j < v_jikuplist.size();j++){
                    jikchek.put("p_jikup",v_jikuplist.get(j)); 		    		
		    		sqlWrap.update("insertSubjJikup", jikchek);
		    	}
		    }
            sqlWrap.commitTransaction();
            retVal = 1;
	    }catch(Exception e){
	        throw e;
	    }finally{
	        sqlWrap.endTransaction();
	    }
 
		return retVal;
	}

	
	 /**
	   * 고객사별 과정 일괄등록   
	   *
	   * @return  int
	   */
		public int insertSubjMappingExcel(Box box, List list) throws Exception{
			int retVal = 0;
			boolean checkVal = true;
			String allCheck = "I";
		    try{
			    sqlWrap.startTransaction();
			    ArrayList data = null;
			    Box subjBox = null;
			    HashMap param = new HashMap();
			    param.put("comp", box.getString("p_comp"));
		        for (int i=0; i < list.size(); i++ ) {
		        	data = (ArrayList)list.get(i);
		        	allCheck = "I";
		        	param.put("p_subj", (String)data.get(0));
		             // 과정 존재여부 및 등록여부 
		        	subjBox = (Box)sqlWrap.queryForBox("selectIsCompSubjCheck", param);
		            data.add(subjBox.getString("SUBJNM"));    	
		        	if(subjBox.getString("SUBJNM").equals("")){
		        	   data.add("과정이 존재하지 않습니다.");
		        	   allCheck = "E";		        		
		        	}
		        	if(subjBox.getInt("SUBJCNT") > 0){
		        	   data.add("이미 맵핑된 과정입니다.");
		        	   allCheck = "E";		        				        		
		        	}
		            // 과정 체크
		        	String checkStr = FormChecker.Validate((String)data.get(0), "과정코드", "Y", 6, "N"); 	 
		        	if(!checkStr.equals("")){
		        	   data.add(checkStr);
		        	   allCheck = "E";
		        	}
		        	if(allCheck.equals("E"))checkVal = false;
		        	else data.add("성공!");
		        	data.add(allCheck);
		        }
		        //모든 데이터의 유효성 체크에 이상이 없을 경우 데이터를 등록해준다.
		        if(checkVal){
		        	HashMap dataBox = new HashMap();
		        	dataBox.put("comp",box.getString("p_comp"));
		        	dataBox.put("p_inuserid", box.getString("s_userid"));
		        	for(int i =0; i < list.size();i++){
		        		    data = (ArrayList)list.get(i);
		        		    dataBox.put("p_subj",(String)data.get(0));
			    			
			    			sqlWrap.insert("insertCompCategory",dataBox);
		        	}
		        	retVal = 1;
		        }
		        else retVal=0;
	           sqlWrap.commitTransaction();
		    }catch(Exception e){
	           
		        throw e;
		    }finally{
		        sqlWrap.endTransaction();
		    }
			return retVal;
		}
		
		/**
		 * 고객사별 해당과정 유무 체크
		 *
		 * @return  int
		 */
		public int selectCompSubjCheck(Box box) throws Exception{
			int retVal = 0;
			Box subjBox = null;
			// 과정 존재여부 및 등록여부 
			subjBox = (Box)sqlWrap.queryForBox("selectIsCompSubjCheck", box.getMap());
			if(  subjBox.getInt("SUBJCNT") > 0 ){
				retVal=1;
			}			
			return retVal;
		}
		
		/**
		 * 위탁연수고객 리스트를 반환한다.
		 * @param box
		 * @return
		 * @throws Exception
		 */
		public ListDTO selectFosterList(Box box) throws Exception {
			ListDTO listDto = null;
			
			int pageNo = box.getInt("p_pageno");
			String counselYear = box.getString("p_counselyear");
			String counselStartDate = "" ;
			String counselEndDate = "" ;
			if( StringUtil.isNotNull(counselYear)) {
				counselStartDate = counselYear+"01010000" ;
				counselEndDate = counselYear+"12312400" ;
				box.put("p_counselstartdate", counselStartDate)  ;
				box.put("p_counselenddate", counselEndDate)  ;
			}
			
			listDto =  sqlWrap.queryForPageList("selectFostertrainingPageList", box.getMap(), pageNo, box.getInt("listScale"));
			
			return listDto;
		}		
		
		/**
		 * 위탁연수고객 리스트를 반환한다.
		 * @param box
		 * @return
		 * @throws Exception
		 */
		public DataSet selectExcelFosterList(Box box) throws Exception {
			DataSet dataSet = null;
			
			int pageNo = box.getInt("p_pageno");
			String counselYear = box.getString("p_counselyear");
			String counselStartDate = "" ;
			String counselEndDate = "" ;
			if( StringUtil.isNotNull(counselYear)) {
				counselStartDate = counselYear+"01010000" ;
				counselEndDate = counselYear+"12312400" ;
				box.put("p_counselstartdate", counselStartDate)  ;
				box.put("p_counselenddate", counselEndDate)  ;
			}
			
			dataSet =  sqlWrap.queryForDataSet("selectExcelFostertrainingPageList", box.getMap());
			
			return dataSet;
		}	
		/**
		 * 과정기본정보를 등록해 준다. - 온라인
		 * 
		 * @return int
		 */
		public int insertFosterTraining(Box box) throws Exception {
			int retVal = 0;
			String maxFosterSeq = "";
			String v_gadmin = box.getString("s_gadmin"); //권한
			String userID = box.getString("s_userid"); //로그인 아이디
			
			HashMap hashMap = null ;
			try {
				sqlWrap.startTransaction();
				
				//maxSubj값을 가져온다.
				maxFosterSeq =  (String)sqlWrap.queryForObject("getMaxFoster");
				box.put("p_fosterseq", maxFosterSeq);
				box.put("p_inuserid", userID);
				box.put("p_luserid", userID);
				String counselDate = box.get("p_counseldate");
				String counselHM = box.get("p_counselhm");
				String periods = box.get("p_periods");
				String periode = box.get("p_periode");
				
				String unitPrice = box.get("p_unitprice");
				String charge = box.get("p_charge");
				String eduPrice = box.get("p_eduprice");
				String classPrice = box.get("p_classprice");
				String bookPrice = box.get("p_bookprice");
				
				if ( !StringUtil.isNull(counselDate) ) {
					box.put("p_counseldate", counselDate.replaceAll("/", ""));
				}
				
				if ( !StringUtil.isNull(counselHM) ) {
					box.put("p_counselhm", counselHM.replaceAll(":", ""));
				}else {
					counselHM = "0000";
					box.put("p_counselhm", "0000");
				}
				
				if ( !StringUtil.isNull(counselDate) &&  !StringUtil.isNull(counselHM) ) {
					box.put("p_counseldate", box.get("p_counseldate")+ box.get("p_counselhm") );
					
				}else {
					box.put("p_counseldate", "" ) ;
				}
				if ( !StringUtil.isNull(periods) ) {
					box.put("p_periods", periods.replaceAll("/", ""));
				}
				if ( !StringUtil.isNull(periode) ) {
					box.put("p_periode", periode.replaceAll("/", ""));
				}				
				if ( !StringUtil.isNull(unitPrice) ) {
					box.put("p_unitprice", unitPrice.replaceAll(",", ""));
				}			
				if ( !StringUtil.isNull(charge) ) {
					box.put("p_charge", charge.replaceAll(",", ""));
				}			
				if ( !StringUtil.isNull(eduPrice) ) {
					box.put("p_eduprice", eduPrice.replaceAll(",", ""));
				}	
				if ( !StringUtil.isNull(classPrice) ) {
					box.put("p_classprice", classPrice.replaceAll(",", ""));
				}				
	
				if ( !StringUtil.isNull(bookPrice) ) {
					box.put("p_bookprice", bookPrice.replaceAll(",", ""));
				}
				
				sqlWrap.insert("insertFostertraining", box.getMap());
				
				//진행상황
				int rowNum = 0 ;
				String progCD = "" ;
				ArrayList arrProgCD = box.getList("arrProgCD");
				
				if(arrProgCD != null) {
					rowNum = arrProgCD.size() ;
				}
				for(int inx=0 ; inx < rowNum; inx++ ) {
					progCD = (String)arrProgCD.get(inx);
					
					box.put("p_progcd", progCD);
					box.put("p_progseq", (inx+1)+"");
					sqlWrap.insert("insertFosterprog", box.getMap());
				}			
				retVal = 1 ;
				sqlWrap.commitTransaction();
			} catch (Exception e) {
				throw e;
			} finally {
				sqlWrap.endTransaction();
			}

			return retVal;
		}	
		
		/**
		 * 과정기본정보를 등록해 준다. - 온라인
		 * 
		 * @return int
		 */
		public int updateFosterTraining(Box box) throws Exception {
			int retVal = 0;
			String userID = box.getString("s_userid"); //로그인 아이디
			
			try {
				sqlWrap.startTransaction();
				
				box.put("p_inuserid", userID);
				box.put("p_luserid", userID);
				String counselDate = box.get("p_counseldate");
				String counselHM = box.get("p_counselhm");
				String periods = box.get("p_periods");
				String periode = box.get("p_periode");
				
				String unitPrice = box.get("p_unitprice");
				String charge = box.get("p_charge");
				String eduPrice = box.get("p_eduprice");
				String classPrice = box.get("p_classprice");
				String bookPrice = box.get("p_bookprice");
				
				
				if ( !StringUtil.isNull(counselDate) ) {
					box.put("p_counseldate", counselDate.replaceAll("/", ""));
				}
				if ( !StringUtil.isNull(counselHM) ) {
					box.put("p_counselhm", counselHM.replaceAll(":", ""));
				}else {
					counselHM = "0000";
					box.put("p_counselhm", "0000");
				}
				if ( !StringUtil.isNull(counselDate) &&  !StringUtil.isNull(counselHM) ) {
					box.put("p_counseldate", box.get("p_counseldate")+ box.get("p_counselhm") );
					
				}else {
					box.put("p_counseldate", "" ) ;
				}
				if ( !StringUtil.isNull(periods) ) {
					box.put("p_periods", periods.replaceAll("/", ""));
				}
				if ( !StringUtil.isNull(periode) ) {
					box.put("p_periode", periode.replaceAll("/", ""));
				}				
				if ( !StringUtil.isNull(unitPrice) ) {
					box.put("p_unitprice", unitPrice.replaceAll(",", ""));
				}			
				if ( !StringUtil.isNull(charge) ) {
					box.put("p_charge", charge.replaceAll(",", ""));
				}			
				if ( !StringUtil.isNull(eduPrice) ) {
					box.put("p_eduprice", eduPrice.replaceAll(",", ""));
				}	
				if ( !StringUtil.isNull(classPrice) ) {
					box.put("p_classprice", classPrice.replaceAll(",", ""));
				}				
	
				if ( !StringUtil.isNull(bookPrice) ) {
					box.put("p_bookprice", bookPrice.replaceAll(",", ""));
				}
				
				sqlWrap.insert("updateFostertraining", box.getMap());
				
				//진행상황 삭제
				sqlWrap.delete("deleteFosterprog", box.get("p_fosterseq"));
				
				int rowNum = 0 ;
				String progCD = "" ;
				
				ArrayList arrProgCD = box.getList("arrProgCD");
				
				if(arrProgCD != null) {
					rowNum = arrProgCD.size() ;
				}
				for(int inx=0 ; inx < rowNum; inx++ ) {
					progCD = (String)arrProgCD.get(inx);
					
					box.put("p_progcd", progCD);
					box.put("p_progseq", (inx+1)+"");
					sqlWrap.insert("insertFosterprog", box.getMap());
				}			
				retVal = 1 ;
				sqlWrap.commitTransaction();
			} catch (Exception e) {
				throw e;
			} finally {
				sqlWrap.endTransaction();
			}

			return retVal;
		}	
		
		/**
		 * 과정기본정보를 등록해 준다. - 온라인
		 * 
		 * @return int
		 */
		public int deleteFosterTraining(Box box) throws Exception {
			int retVal = 0;
			
			
			try {
				sqlWrap.startTransaction();
				//진행상황 삭제
				sqlWrap.delete("deleteFosterprog", box.get("p_fosterseq"));
				//위탁고객연수 삭제
				sqlWrap.delete("deleteFostertraining", box.get("p_fosterseq"));
				retVal = 1 ;
				sqlWrap.commitTransaction();
			} catch (Exception e) {
				throw e;
			} finally {
				sqlWrap.endTransaction();
			}

			return retVal;
		}	
		
		public Box getFosterTraining(String fosterSeq) throws Exception {
			return sqlWrap.queryForBox("getFosterTraining", fosterSeq );
		}
		
		public Box getFosterprog(String fosterSeq) throws Exception {
			return sqlWrap.queryForBox("getFosterprog", fosterSeq );
		}	
		
		public String getFosterMemo(String fosterSeq) throws Exception {
			return (String)sqlWrap.queryForObject("selectMemoFostertraining", fosterSeq );
		}
		
		public int updateFosterMemo(Box box) throws Exception {
			int retVal = 0;
			String userID = box.getString("s_userid"); //로그인 아이디
			box.put("p_luserid", userID);
			sqlWrap.insert("updateMemoFostertraining", box.getMap());
			retVal = 1 ;
			return retVal;
		}			
	
	/**
	 * 유통사현황 리스트를 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ListDTO externalSalesCompListCallBack(Box box) throws Exception {
		ListDTO data = null;
		int pageNo = box.getInt("l_pageno");
		int listScale = box.getInt("l_listscale");
		try {
	   		data = sqlWrap.queryForPageList("externalSalesCompListCallBack", box.getMap(), pageNo, listScale); 
		} catch (Exception e) {
			throw e;
		} finally {
		}

		return data;
	}
	
	/**
	 * 유통사 정보를 가져온다.
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Box externalSalesCompInfo(HashMap param) throws Exception{
		Box data = null;
		try{
			data = sqlWrap.queryForBox("externalSalesCompInfo", param);
		}catch(Exception e){
			throw e;
		}finally{
			
		}
		return data;
	}	
	
	/**
	 * 유통사 컨텐츠 리스트를 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public DataSet externalSalesContentsList(Box box) throws Exception {
		DataSet data = null;
		try {
	   		data = sqlWrap.queryForDataSet("externalSalesContentsList", box.getMap()); 
		} catch (Exception e) {
			throw e;
		} finally {
		}

		return data;
	}
	
	/**
	 * 유통사 업체명이 이미 존재하는지 확인
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Box checkExternalCompInfo(HashMap param) throws Exception{
		Box data = null;
		try{
			data = sqlWrap.queryForBox("checkExternalCompInfo",param);
		}catch(Exception e){
			throw e;
		}finally{
			
		}
		return data;
	}
	
	/** 
	 * 등록한 유통사의 COMP_SEQ 가져오기
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Box checkExternalCompSeq(HashMap param) throws Exception{
		Box data = null;
		try{
			data = sqlWrap.queryForBox("checkExternalCompSeq",param);
		}catch(Exception e){
			throw e;
		}finally{
			
		}
		return data;
	}
	
	/**
	 * 유통사가 해당 컨텐츠 보유중인지 확인
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Box checkExternalContentsInfo(HashMap param) throws Exception{
		Box data = null;
		try{
			data = sqlWrap.queryForBox("checkExternalContentsInfo",param);
		}catch(Exception e){
			throw e;
		}finally{
			
		}
		return data;
	}
	
	/**
	 * 유통사 정보를 등록
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int externalSalesCompInfoWrite(Box box) throws Exception {
		int retVal = 0;
		String comp_seq = "";
		
		try {
			sqlWrap.startTransaction();
			
			/**
			 * 등록 처리
			 */
			String v_comp_seq = box.getString("p_comp_seq");					// 유통사명
			String v_compnm = box.getString("p_compnm");						// 유통사명
			String v_startyear = box.getString("p_startyear");					// 계약기간(시작)
			String v_endyear = box.getString("p_endyear");						// 계약기간(끝)
			String v_manager = box.getString("p_manager");						// 담당자명
			String v_monitoringid = box.getString("p_monitoringid");			// 모니터링 계정
			String v_responsibilities = box.getString("p_responsibilities");	// 담당업무
			String v_telephone = box.getString("p_telephone");					// 전화번호 합치기
			String v_handphone = box.getString("p_handphone");					// 휴대폰 합치기
			String v_email = box.getString("p_email");							// 이메일
			String v_inuserid = box.getString("p_inuserid");	
			String v_luserid = box.getString("p_luserid");	
			String s_userid = box.getString("s_userid");
			
			HashMap<String,String> hmParam = new HashMap<String,String>();
			CompMgr compMgr = new CompMgr();
			ProposeMgr proposeMgr = new ProposeMgr();
			int count_compInfo = 0;
			int count_contentsInfo = 0;
			hmParam = box.getMap();
			
			// 유통사 업체명이 이미 존재하는지 확인
			Box compInfo = compMgr.checkExternalCompInfo(hmParam);
			count_compInfo = compInfo.getInt("COUNT_COMPINFO");

			if(count_compInfo == 0){
				// 유통사 등록
				sqlWrap.insert("insertExternalCompInfo", hmParam);
				
				// 등록한 유통사의 COMP_SEQ 가져오기
				Box compSeq = compMgr.checkExternalCompSeq(hmParam);
				comp_seq = compSeq.getString("COMP_SEQ");
				hmParam.put("p_comp_seq", comp_seq);
				
				// 컨텐츠를 추가했는지 확인
				ArrayList<String> alContsid = (ArrayList<String>)box.getList("p_contsid");
				if ( alContsid != null && alContsid.size() > 0 ) {			
					for ( int i=0; i < alContsid.size(); i++ ) {
						hmParam.put("p_contsid", alContsid.get(i));							// 컨텐츠 id
						
						// 해당 컨텐츠를 이미 보유중인지 확인
						Box contentsInfo = compMgr.checkExternalContentsInfo(hmParam);
						count_contentsInfo = contentsInfo.getInt("COUNT_CONTENTSINFO");
						if(count_contentsInfo == 0){
							// 컨텐츠 등록
							sqlWrap.insert("insertExternalContentsInfo", hmParam);
						}
					}					
				} 
			} else {
				return retVal = 0;
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
	 * 유통사 정보를 수정
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int externalSalesCompInfoUpdate(Box box) throws Exception {
		int retVal = 0;
		String comp_seq = "";
		
		try {
			sqlWrap.startTransaction();
			
			/**
			 * 수정 처리
			 */
			String v_comp_seq = box.getString("p_comp_seq");					// 유통사명
			String v_compnm = box.getString("p_compnm");						// 유통사명
			String v_startyear = box.getString("p_startyear");					// 계약기간(시작)
			String v_endyear = box.getString("p_endyear");						// 계약기간(끝)
			String v_manager = box.getString("p_manager");						// 담당자명
			String v_monitoringid = box.getString("p_monitoringid");			// 모니터링 계정
			String v_responsibilities = box.getString("p_responsibilities");	// 담당업무
			String v_telephone = box.getString("p_telephone");					// 전화번호 합치기
			String v_handphone = box.getString("p_handphone");					// 휴대폰 합치기
			String v_email = box.getString("p_email");							// 이메일
			String v_inuserid = box.getString("p_inuserid");	
			String v_luserid = box.getString("p_luserid");	
			String s_userid = box.getString("s_userid");
			
			HashMap<String,String> hmParam = new HashMap<String,String>();
			CompMgr compMgr = new CompMgr();
			ProposeMgr proposeMgr = new ProposeMgr();
			int count_compInfo = 0;
			int count_contentsInfo = 0;
			hmParam = box.getMap();

			// 유통사 수정
			retVal = sqlWrap.update("updateExternalCompInfo", hmParam);
			if(retVal == 0){
				return retVal;
			}
			
			// 보유중이었던 유통사의 모든 컨텐츠 삭제
			sqlWrap.delete("deleteExternalContentsInfo", hmParam);
			
			// 컨텐츠를 추가했는지 확인
			ArrayList<String> alContsid = (ArrayList<String>)box.getList("p_contsid");
			if ( alContsid != null && alContsid.size() > 0 ) {
				for ( int i=0; i < alContsid.size(); i++ ) {
					hmParam.put("p_contsid", alContsid.get(i));							// 컨텐츠 id
					
					// 해당 컨텐츠를 이미 보유중인지 확인
					Box contentsInfo = compMgr.checkExternalContentsInfo(hmParam);
					count_contentsInfo = contentsInfo.getInt("COUNT_CONTENTSINFO");
					if(count_contentsInfo == 0){
						// 컨텐츠 등록
						sqlWrap.insert("insertExternalContentsInfo", hmParam);
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
	 * 유통사 정보를 삭제
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int externalSalesCompInfoDelete(Box box) throws Exception {
		int retVal = 0;
		String comp_seq = "";
		
		try {
			sqlWrap.startTransaction();
			
			/**
			 * 삭제 처리
			 */
			String v_comp_seq = box.getString("p_comp_seq");					// 유통사명
			String v_compnm = box.getString("p_compnm");						// 유통사명
			String v_startyear = box.getString("p_startyear");					// 계약기간(시작)
			String v_endyear = box.getString("p_endyear");						// 계약기간(끝)
			String v_manager = box.getString("p_manager");						// 담당자명
			String v_monitoringid = box.getString("p_monitoringid");			// 모니터링 계정
			String v_responsibilities = box.getString("p_responsibilities");	// 담당업무
			String v_telephone = box.getString("p_telephone");					// 전화번호 합치기
			String v_handphone = box.getString("p_handphone");					// 휴대폰 합치기
			String v_email = box.getString("p_email");							// 이메일
			String v_inuserid = box.getString("p_inuserid");	
			String v_luserid = box.getString("p_luserid");	
			String s_userid = box.getString("s_userid");
			
			HashMap<String,String> hmParam = new HashMap<String,String>();
			CompMgr compMgr = new CompMgr();
			ProposeMgr proposeMgr = new ProposeMgr();
			int count_compInfo = 0;
			int count_contentsInfo = 0;
			hmParam = box.getMap();
			
			// 보유중이었던 유통사의 모든 컨텐츠 삭제
			sqlWrap.delete("deleteExternalContentsInfo", hmParam);
			
			// 유통사 삭제
			retVal = sqlWrap.update("deleteExternalCompInfo", hmParam);
			if(retVal == 0){
				return retVal;
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
	 * 유통사 메모를 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public DataSet selectexternalCompMemo(Box box) throws Exception{
		DataSet data = null;
        try{
        	data = sqlWrap.queryForDataSet("selectexternalCompMemo", box.getMap());
        }catch(Exception e){
        	throw e;
        }finally{
        }

		return data;
	}
	
	/**
	 * 유통사 메모를 등록
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int insertExternalCompMemo(Box box) throws Exception{
  		int retVal = 0;
		try{
  	    	sqlWrap.startTransaction();

  	    	retVal = sqlWrap.update("updateExternalCompMemo",box.getMap());
  	    	if(retVal == 0){
  	    		return retVal;
  	    	}

  		    sqlWrap.commitTransaction();
  	    }catch(Exception e){
  	        throw e;
  	    }finally{
  	    	sqlWrap.endTransaction();
  	    }
  		return retVal;
  	}
}
