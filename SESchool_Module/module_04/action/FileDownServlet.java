
package com.sinc.framework.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 파일 다운로드
 * 
 */
public class FileDownServlet  extends HttpServlet {
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		doGet(request,response);
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {

			String rFileName	= StringUtil.nvl(request.getParameter("rFileName"));
			String sFileName	= StringUtil.nvl(request.getParameter("sFileName"));
			String filePath		= StringUtil.nvl(request.getParameter("filePath"));
			String fileGubun	= StringUtil.nvl(request.getParameter("FILEGU"));
			String lmsdataPath	= FileUtil.UPLOAD_PATH;
			
			if(rFileName.indexOf("../") > -1 || sFileName.indexOf("../") > -1 || filePath.indexOf("../") > -1){
				response.setContentType("text/html;charset=utf-8");
				PrintWriter out = response.getWriter();
				
				out.println("<html><body>");
				out.println("<script language='javascript'>");
				out.println("alert('보안에 위반되는 경로를 포함하고 있어 다운로드 진행을 중지하였습니다.');");
				out.println("</script>");
				out.println("</body></html>");
				out.close();
				
			}else{
	 		  try {
			
	            if(fileGubun.equals("MAIL")){
	            	rFileName = new String(rFileName.getBytes("EUC-KR"), "ISO-8859-1");
			    }
				
				File file = new File(lmsdataPath+filePath+"/"+sFileName);
				FileInputStream in = null;
			
				try {
					in = new FileInputStream(file);
				} catch ( Exception e ) {
					e.printStackTrace();
				}
	
				response.setContentType( "application/x-msdownload" );
				response.setHeader( "Content-Disposition", "attachment; filename=\""+ new String(rFileName.getBytes("euc-kr"),"iso-8859-1") + "\"" );
				response.setHeader( "Content-Transfer-Coding", "binary" );
	
				ServletOutputStream binaryOut = response.getOutputStream();
				byte b[] = new byte[1024];
	
				try {
					int nRead;
					do {
						nRead = in.read( b );
						binaryOut.write( b, 0, nRead );
					} while ( nRead == 1024 );
	
				} catch ( Exception e ) {
					e.printStackTrace();
				} finally {
					if (in != null) {
						in.close();
					}
					if (binaryOut != null) {
						binaryOut.close();
					}
				}
	
			}catch(Exception e) {
				e.printStackTrace();
			}
		}	
	}
}




