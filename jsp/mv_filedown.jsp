<%@ page language="java" pageEncoding="EUC-KR"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.io.*" %>
<%

	response.addHeader("content-type", "image/jpeg");
	String fname = request.getParameter("rv_file");
	if(fname == null){ fname = ""; }
	
	fname = fname.replace("..", "");

try
{
	File mFile = new File("D:\\팀폴더\\B팀(송은혜,강고은,배민주,박수진)\\07.참고자료\\img\\upload", fname);
	
	InputStream  in = null;
	in = new FileInputStream(mFile); //데이터를 읽어들이겠다
	OutputStream os = null;
	
	os = response.getOutputStream(); //in에서 데이터 받아서 out에 보내겠다
	
	byte b[] = new byte[(int)mFile.length()]; 
	int leng = 0;
	while( (leng = in.read(b)) > 0) //배열을 만들어놓고 파일을 읽어들인다
	{
		os.write(b,0,leng);         //읽으면서 읽은만큼 outputstream에 쏜다
	}
	
	os.close();
	in.close();
} catch (Exception e) 
{
	out.print("ERROR");
}
%>