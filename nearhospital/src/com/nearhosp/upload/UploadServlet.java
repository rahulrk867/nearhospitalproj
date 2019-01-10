package com.nearhosp.upload;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class UploadServlet
 */
@WebServlet("/UploadServlet")
@MultipartConfig(maxFileSize = 11901334)    // upload file's size up to 16MB
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	    private static final String DATA_DIRECTORY = "/WebContent/uploadedImages";
	    private static final int MAX_MEMORY_SIZE = 1024 * 1024 * 2;
	    private static final int MAX_REQUEST_SIZE = 1024 * 1024;   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		InputStream inputStream = null;
		Part filePart = request.getPart("Image");
        if (filePart != null) {
            // prints out some information for debugging
            
             
            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
            byte b[]=null;
            inputStream.read(b);
            FileOutputStream fileOutputStream=new FileOutputStream("c:\\i.jpg");
            fileOutputStream.write(b);
            fileOutputStream.close();
            
        }
         
	}

}
