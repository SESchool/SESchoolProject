
package com.sinc.cms.contents;

import java.util.ArrayList;
import java.util.HashMap;

import com.sinc.framework.data.Box;
import com.sinc.framework.data.DataSet;
import com.sinc.framework.persist.AbstractMgr;
import com.sinc.framework.persist.ListDTO;

public class ContentsMgr extends AbstractMgr {

	/**
	 * 컨텐츠 페이지 리스트를 불러온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ListDTO selectContentsPageList(Box box) throws Exception{
		ListDTO data = null;
		int pageNo = box.getInt("l_pageno");
		int listScale = box.getInt("l_listscale");
        try{
        	data = sqlWrap.queryForPageList("selectCmsContentsPageList", box.getMap(), pageNo, listScale);
        }catch(Exception e){
        	throw e;
        }finally{
        }
	 
		return data;
	}

	/**
	 * 승인요청 결과 리스트를 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ListDTO selectReqContentsPageList(Box box) throws Exception{
		ListDTO data = null;
		int pageNo = box.getInt("l_pageno");
		int listScale = box.getInt("l_listscale");
        try{
        	data = sqlWrap.queryForPageList("selectCmsReqContentsPageList", box.getMap(), pageNo, listScale);
        }catch(Exception e){
        	throw e;
        }finally{
        }
	 
		return data;
	}
	
	/**
	 * 컨텐츠 기본정보를 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public DataSet selectContentsInfo(Box box) throws Exception {
		DataSet data = null;
	    try{ 
        	data = sqlWrap.queryForDataSet("selectCmsContents", box.getString("p_contsid"));
	    }catch(Exception e){
	        throw e;
	    }finally{ 
	    }

		return data;
	}
	
	/**
	 * 컨텐츠 기본 정보를 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public HashMap selectContents(Box box) throws Exception {
		DataSet data = null;
		HashMap map = null;
		Box metaBox = null;
		try {
			map = new HashMap();
		    box.put("p_itemid", "0");
			data = sqlWrap.queryForDataSet("selectCmsContents", box.getString("p_contsid"));
			map.put("MyConts",data.getFirstObject());
			data = sqlWrap.queryForDataSet("selectCmsMetadata", box.getMap());
			if(data != null && data.getRow() > 0) metaBox = data.getFirstObject(); 
			else metaBox = new Box("Metadata");
			map.put("Metadata", metaBox);
		} catch (Exception e) {
			throw e;
		} finally {
		}

		return map;
	}
	
	/**
	 * 컨텐츠 정보를 등록해 준다.
	 * @param box
	 * @return 
	 */
	public int insertContents(Box box) throws Exception {
		int retVal = 0;
	    try{
		    sqlWrap.startTransaction();
		    String v_contsid =  (String)sqlWrap.insert("insertCmsContents", box.getMap());
		    box.put("p_contsid",v_contsid);
		    sqlWrap.update("insertCmsMetadata", box.getMap());
		    sqlWrap.update("insertCmsMasterBasic", box.getMap());
		    StringBuffer sb = new StringBuffer();
		    sb.append("사용자 ").append(box.getString("s_name")).append("(").append(box.getString("s_userid")).append(")가 ");
		    sb.append("컨텐츠를 등록하였습니다.");
		    box.put("p_content", sb.toString());
		    sqlWrap.insert("insertCmsHistory", box.getMap());
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
	 * 컨텐츠 정보를 수정해준다.
	 * @param box
	 * @return
	 */
	public int updateContents(Box box) throws Exception {
		int retVal = 0;
	    try{
		    sqlWrap.startTransaction();
		    sqlWrap.update("updateCmsMetadata", box.getMap());
		    sqlWrap.update("updateCmsContents", box.getMap());
		    StringBuffer sb = new StringBuffer();
		    sb.append("사용자 ").append(box.getString("s_name")).append("(").append(box.getString("s_userid")).append(")가 ");
		    sb.append("컨텐츠를 수정하였습니다.");
		    box.put("p_content", sb.toString());
		    sqlWrap.insert("insertCmsHistory", box.getMap());
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
	 * 컨텐츠를 삭제해 줍니다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int deleteContents(Box box) throws Exception {
		int retVal = 0;
	    try{
		    sqlWrap.startTransaction();
		    retVal = sqlWrap.delete("deleteCmsContents", box.getMap());
            sqlWrap.commitTransaction();
	    }catch(Exception e){
	        throw e;
	    }finally{
	        sqlWrap.endTransaction();
	    }

		return retVal;
	}
	
	/**
	 * 컨텐츠 검색 페이지 리스트를 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ListDTO selectContentsSearchPageList(Box box) throws Exception{
		ListDTO data = null;
		int pageNo = box.getInt("l_pageno");
        try{
        	data = sqlWrap.queryForPageList("selectCmsContentsSearchPageList", box.getMap(), pageNo);
        }catch(Exception e){
        	throw e;
        }finally{
        }
	 
		return data;
	}
	
	/**
	 * 컨텐츠를 저장소에 등록 요청해준다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int updateContentsRep(Box box) throws Exception {
		int retVal = 0;
	    try{
		    sqlWrap.startTransaction();
		    retVal = sqlWrap.update("updateCmsContentsRep", box.getMap());
		    StringBuffer sb = new StringBuffer();
		    sb.append("사용자 ").append(box.getString("s_name")).append("(").append(box.getString("s_userid")).append(")가 ");
		    sb.append("컨텐츠를 저장소에 등록요청 하였습니다.");
		    box.put("p_content", sb.toString());
		    sqlWrap.insert("insertCmsHistory", box.getMap());
            sqlWrap.commitTransaction();
	    }catch(Exception e){
	        throw e;
	    }finally{
	        sqlWrap.endTransaction();
	    }

		return retVal;
	}
	
	/**
	 * 메타데이타 정보를 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public DataSet selectMetadata(Box box) throws Exception {
		DataSet data = null;
		try {
			box.put("itemid","0");
			data = sqlWrap.queryForDataSet("selectCmsMetadata", box.getMap());
		} catch (Exception e) {
			throw e;
		} finally {
		}

		return data;
	}
	
	/**
	 * 북마크 페이지 리스트를 돌려준다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ListDTO selectBookmarkPageList(Box box) throws Exception{
		ListDTO data = null;
		int pageNo = box.getInt("l_page");
		int listScale = box.getInt("l_listscale");
        try{
        	data = sqlWrap.queryForPageList("selectCmsBookmarkPageList", box.getMap(), pageNo, listScale);
        }catch(Exception e){
        	throw e;
        }finally{
        }
	 
		return data;
	}
	
	/**
	 * 북마크를 삭제해 줍니다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int deleteBookmark(Box box) throws Exception {
		int retVal = 0;
	    try{
		    sqlWrap.startTransaction();
		    sqlWrap.startBatch();
		    ArrayList list = box.getList("p_contssel");
		    HashMap map = new HashMap();
		    for(int i=0; i < list.size();i++){
		    	map.put("p_contsid", (String)list.get(i));
		    	map.put("p_userid", box.getString("s_userid"));
		    	sqlWrap.delete("deleteCmsBookmark", map);
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
	 * 컨텐츠 승인 리스트를 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ListDTO selectContentsRecPageList(Box box) throws Exception{
		ListDTO data = null;
		int pageNo = box.getInt("l_page");
		int listScale = box.getInt("l_listscale");
        try{
        	data = sqlWrap.queryForPageList("selectCmsContentsRecPageList", box.getMap(), pageNo, listScale);
        }catch(Exception e){
        	throw e;
        }finally{
        }
	 
		return data;
	}
	
	/**
	 * 컨텐츠 승인정보를 등록해준다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int updateContentsRec(Box box) throws Exception {
		int retVal = 0;
	    try{
		    sqlWrap.startTransaction();
		    String v_state = box.getString("p_state");
		    StringBuffer sb = new StringBuffer();
			ArrayList recogList = box.getList("p_contssel");
			String v_contsid = null;
			HashMap map = new HashMap();
			map.put("p_userid", box.getString("s_userid"));
			map.put("p_state", v_state);
			if(v_state.equals("C")) v_state = "컨텐츠에 대해서 승인을 하였습니다.";
			else v_state = "컨텐츠에 대해서 반려를 하였습니다.";
			map.put("p_recogreason", v_state);
			for(int i =0; i < recogList.size();i++){
		    	v_contsid = (String)recogList.get(i);
		    	map.put("p_contsid", v_contsid);
		    	retVal = sqlWrap.update("updateCmsContentsRec", map);
			    sb.append("사용자 ").append(box.getString("s_name")).append("(").append(box.getString("s_userid")).append(")가 ");
			    sb.append(v_state);
			    box.put("p_content", sb.toString());
			   
			    sqlWrap.insert("insertCmsHistory", map);
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
	 * 컨텐츠 저장소 페이지 리스트를 가져온다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ListDTO selectContentsRepPageList(Box box) throws Exception{
		ListDTO data = null;
		int pageNo = box.getInt("l_pageno");
		int listScale = box.getInt("l_listscale");
        try{
        	data = sqlWrap.queryForPageList("selectCmsContentsRepPageList", box.getMap(), pageNo, listScale);
        }catch(Exception e){
        	throw e;
        }finally{
        }
	 
		return data;
	}
	
	/**
	 * 유통사 컨텐츠 검색
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public ListDTO selectExternalContentsList(Box box) throws Exception{
		ListDTO data = null;
		int pageNo = box.getInt("l_pageno");
		int listScale = box.getInt("l_listscale");
        try{
        	data = sqlWrap.queryForPageList("selectExternalContentsList", box.getMap(), pageNo, listScale);
        }catch(Exception e){
        	throw e;
        }finally{
        }
	 
		return data;
	}
	
	/**
	 * 북마크를 등록해준다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int insertContentsBookmark(Box box) throws Exception {
		int retVal = 0;
	    try{
		    sqlWrap.startTransaction();
	        // 기존에 북마크가 등록되었는지를 확인한다.
		    retVal = Integer.parseInt((String)sqlWrap.queryForObject("selectCmsBookmarkCnt", box.getMap()));
		    
		    if(retVal < 1) {
		    	retVal = sqlWrap.update("insertCmsContentsBookmark", box.getMap());
		    	retVal = 1;
		    }else{
		    	retVal = 2;
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
	 * 컨텐츠 추천수를 올려준다.
	 * @param box
	 * @return
	 * @throws Exception
	 */
	public int insertContentsRecomm(Box box) throws Exception {
		int retVal = 0;
	    try{
		    sqlWrap.startTransaction();
		    // 이전에 추천을 했는지를 판단한다.
		    retVal = Integer.parseInt((String)sqlWrap.queryForObject("selectCmsRecommCnt", box.getMap()));
		    if(retVal < 1) {
		    	sqlWrap.update("insertCmsContentsRecomm", box.getMap());
		    	retVal = 1;
		    }else{
		    	sqlWrap.update("updateCmsContentsRecomm", box.getMap());
		    	retVal = 2;
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
