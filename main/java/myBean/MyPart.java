 package myBean;

import jakarta.servlet.http.Part;

public class MyPart { //파일 관리를 위한 클래스
	private Part part;
	private String savedFileName;
	
	public MyPart(Part part, String savedFileName) {
		this.part = part;
		this.savedFileName = savedFileName; 
	}

	public Part getPart() {
		return part;
	}
	public String getSavedFileName() {
		return savedFileName;
	}
}