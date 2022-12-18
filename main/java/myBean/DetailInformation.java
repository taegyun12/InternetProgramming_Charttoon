package myBean;

import java.sql.Date;

public class DetailInformation { //웹툰 회차 데이터를 처리하기 위한 클래스
	public DetailInformation() {};
	private String webtoonTitle;
	private String detailTitle;
	private String releaseDay;
	private int count;
	private String detailOriginalFileName; //동일한 이름의 파일 처리를 위한 파일 이름 변수들
	private String detailSavedFileName;
	private String toonOriginalFileName;
	private String toonSavedFileName;
	
	//각 변수들의 getter와 setter 함수
	public String getDetailOriginalFileName() {
		return detailOriginalFileName;
	}
	public void setDetailOriginalFileName(String detailOriginalFileName) {
		this.detailOriginalFileName = detailOriginalFileName;
	}
	public String getDetailSavedFileName() {
		return detailSavedFileName;
	}
	public void setDetailSavedFileName(String detailSavedFileName) {
		this.detailSavedFileName = detailSavedFileName;
	}
	public String getToonOriginalFileName() {
		return toonOriginalFileName;
	}
	public void setToonOriginalFileName(String toonOriginalFileName) {
		this.toonOriginalFileName = toonOriginalFileName;
	}
	public String getToonSavedFileName() {
		return toonSavedFileName;
	}
	public void setToonSavedFileName(String toonSavedFileName) {
		this.toonSavedFileName = toonSavedFileName;
	}
	public String getReleaseDay() {
		return releaseDay;
	}
	public void setReleaseDay(String releaseDay) {
		this.releaseDay = releaseDay;
	}
	
	
	public String getWebtoonTitle() {
		return webtoonTitle;
	}
	public void setWebtoonTitle(String webtoonTitle) {
		this.webtoonTitle = webtoonTitle;
	}
	public String getDetailTitle() {
		return detailTitle;
	}
	public void setDetailTitle(String detailTitle) {
		this.detailTitle = detailTitle;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
}
