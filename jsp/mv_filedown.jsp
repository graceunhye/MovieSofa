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
	File mFile = new File("D:\\������\\B��(������,������,�����,�ڼ���)\\07.�����ڷ�\\img\\upload", fname);
	
	InputStream  in = null;
	in = new FileInputStream(mFile); //�����͸� �о���̰ڴ�
	OutputStream os = null;
	
	os = response.getOutputStream(); //in���� ������ �޾Ƽ� out�� �����ڴ�
	
	byte b[] = new byte[(int)mFile.length()]; 
	int leng = 0;
	while( (leng = in.read(b)) > 0) //�迭�� �������� ������ �о���δ�
	{
		os.write(b,0,leng);         //�����鼭 ������ŭ outputstream�� ���
	}
	
	os.close();
	in.close();
} catch (Exception e) 
{
	out.print("ERROR");
}
%>