<%@ page language="java" pageEncoding="EUC-KR"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.io.*" %>
<%
	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }

	String type = request.getParameter("type");
	String fname = request.getParameter("nfile");
	if(type == null){ type = ""; }
	if(fname == null){ fname = ""; }
	
	fname = fname.replace("..", "");
	
	if(type.equals("img"))
	{
		response.addHeader("content-type", "image/jpeg");
	}else
	{
		//Download ��
		response.addHeader("content-type", "otect/unknown");
		response.setHeader("Content-Disposition","attachment;filename=\"" + fname + "\";");
	}

try
{
	File mFile = new File("D:\\kge\\SkyLibrary\\WebContent\\jsp\\Manager\\mnotice\\img\\upload", fname);
	
	InputStream in = null; 
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