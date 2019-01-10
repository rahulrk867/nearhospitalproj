package com.nearhosp.upload;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.beans.hosp.Department;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class Upload
 */
@WebServlet("/Upload")
public class Upload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Upload() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Department department=new Department();
		String filename="",departmentName="",command="";
		int departmentId=0;
		String project=request.getContextPath();
        String uploadFolder = getServletContext().getRealPath(project);
        
        uploadFolder=uploadFolder.split("\\\\.meta")[0]+ project+"/WebContent/uploadedImages";
		MultipartRequest m = new MultipartRequest(request, uploadFolder);  
		Enumeration files=m.getFileNames();
		Enumeration data=m.getParameterNames();
		int i=0,j=0;
		if (files.hasMoreElements()) {
			Object object = (Object) files.nextElement();
			filename=m.getFilesystemName("Image");
			i++;
		}
		if (data.hasMoreElements()) {
			Object object = (Object) data.nextElement();
			departmentName=m.getParameter("Department Name");
			departmentId=Integer.parseInt(m.getParameter("Department Id"));
			command=m.getParameter("save");
			if(filename.equals(""))
			{
				filename=m.getParameter("FileName");
			}
			i++;
		}
		department.setDepartmentId(departmentId);
		department.setDepartmentName(departmentName);
		//department.setImage(filename);
		
		if(command.equals("Save"))
		{
			department.saveDept();
		}
		else
		{
			department.updateDept();
		}
		String target=project+"/jsp/department.jsp?save="+department.getMessage();
		response.sendRedirect(target);
		//getServletContext().getRequestDispatcher("/jsp/department.jsp").forward(
                //request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
