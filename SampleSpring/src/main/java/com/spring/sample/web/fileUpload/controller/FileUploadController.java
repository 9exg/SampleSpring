package com.spring.sample.web.fileUpload.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.sample.common.CommonProperties;
import com.spring.sample.util.Utils;

@Controller
public class FileUploadController {
	private static final Logger logger = LoggerFactory.getLogger(FileUploadController.class);

	@RequestMapping(value = "/fileUpload", method = RequestMethod.GET)
	public ModelAndView fileUpload(HttpServletRequest request, HttpSession session, ModelAndView modelAndView) {

		modelAndView.setViewName("fileUpload/fileUpload");

		return modelAndView;
	}

	@RequestMapping(value = "/fileUploadAjax", method = RequestMethod.POST, 
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String fileUploadAjax(HttpServletRequest request, 
								 ModelAndView modelAndView) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		HashMap<String, Object> modelMap = new HashMap<String, Object>();
		
		/* File Upload Logic */
		MultipartHttpServletRequest multipartRequest 
					= (MultipartHttpServletRequest) request;

		String uploadExts = CommonProperties.FILE_EXT;	// 허용 확장자(확장자 제한)
		String uploadPath = CommonProperties.FILE_UPLOAD_PATH;	//파일을 업로드 경로 (어디에 올릴 것인지)
		String fileFullName = "";
		
		File folder = new File(uploadPath);

		if (!folder.exists()) { // 폴더 존재여부
			folder.mkdir(); // 폴더 생성
		}

		List<String> fileNames = new ArrayList<String>();	//저장될 파일명을 보관
		try {
			@SuppressWarnings("rawtypes")
			// MultipartHttpServletRequest 안에 있는 MultipartFile을 map으로 추출
			final Map files = multipartRequest.getFileMap(); 
			
			// map에 있는 form-data의 name 값을 뽑는다 
			Iterator<String> iterator = multipartRequest.getFileNames();

			// iterator.hasNext() -> iterator 를 순차적으로 실행 (for문같은) 
			while (iterator.hasNext()) {
				
				String key = iterator.next(); // 현재 인덱스의 데이터 (form-data의 name) 을 저장
				MultipartFile file = (MultipartFile) files.get(key);
				
				if (file.getSize() > 0) {								//파일의 내용이 존재하는지 확인
					String fileRealName = file.getOriginalFilename(); // 실제파일명
					String fileTmpName = Utils.getPrimaryKey(); // 고유 날짜키 받기
					String fileExt = FilenameUtils.getExtension(
										file.getOriginalFilename()).toLowerCase(); // 파일
																				   // 확장자추출

					if (uploadExts.toLowerCase().indexOf(fileExt) < 0) {	//허용 가능 확장자 확인
						throw new Exception("Not allowded file extension : " 
												+ fileExt.toLowerCase());
					} else {
						// 물리적으로 저장되는 파일명(실제파일명을 그대로 저장할지 rename해서 저장할지는 협의 필요)
						fileFullName = fileTmpName + fileRealName;
						//File(경로) - 폴더
						//File(경로, 파일명) - 파일
						// new File(new File(uploadPath), fileFullName)
						// uploadPath경로의 폴더에 fileFullName 이름의 파일
						// 파일.transferTo(새파일) - 새파일에 파일의 내용을 전송
						
						
						
						file.transferTo(new File(new File(uploadPath), fileFullName));		// file.transferTo(new File(uploadPath + "/" + fileFullName));
						fileNames.add(fileFullName);
					}
				}
			}
			
			modelMap.put("result", CommonProperties.RESULT_SUCCESS);
		} catch (Exception e) {
			// 공통 Exception 처리
			e.printStackTrace();
			modelMap.put("result", CommonProperties.RESULT_ERROR);
		}

		modelMap.put("fileName", fileNames);

		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value = "/imageUpload", method = RequestMethod.POST)
	public void editorImageUpload(HttpServletRequest request, HttpServletResponse response,
			@RequestParam MultipartFile upload, ModelAndView modelAndView) throws Throwable {
		PrintWriter printWriter = null;
		try {
			String uploadExts = CommonProperties.IMG_EXT; // 확장자
			String uploadPath = CommonProperties.FILE_UPLOAD_PATH; // 업로드경로
			String fileFullName = "";

			File fileDir = new File(uploadPath);

			if (!fileDir.exists()) {
				fileDir.mkdirs(); // 디렉토리가 존재하지 않는다면 생성
			}

			if (upload.getSize() > 0) {
				String fileRealName = upload.getOriginalFilename().replace(" ", "_").toLowerCase(); // 실제파일명
				String fileTmpName = Utils.getPrimaryKey(); // 고유 날짜키 받기
				String fileExt = FilenameUtils.getExtension(upload.getOriginalFilename()).toLowerCase(); // 파일

				if (uploadExts.toLowerCase().indexOf(fileExt) >= 0) {
					fileFullName = fileTmpName + fileRealName;
					upload.transferTo(new File(fileDir, fileFullName));

				} else {
					// 파일 확장자가 틀릴 경우
					printWriter = response.getWriter();

					printWriter.println("<script type='text/javascript'>alert('파일 확장자가 지원을 하지 않습니다.');</script>");
					printWriter.flush();
					printWriter.close();
				}

				// 성공 시
				String callback = request.getParameter("CKEditorFuncNum");

				printWriter = response.getWriter();

				printWriter.println("<script type='text/javascript'>" + "window.parent.CKEDITOR.tools.callFunction("
						+ callback + ",'" + "resources/upload/" + fileFullName + "','이미지를 업로드 하였습니다.'" + ")</script>");
				printWriter.flush();
				printWriter.close();

			} else {
				// 파일 크기가 0이거나 없는 경우
				printWriter = response.getWriter();

				printWriter.println("<script type='text/javascript'>alert('파일 업로드에 실패하였습니다.');</script>");
				printWriter.flush();
				printWriter.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (printWriter != null) {
				printWriter.close();
			}
		}
	}
}
