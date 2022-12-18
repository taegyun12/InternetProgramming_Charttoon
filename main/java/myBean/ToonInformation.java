package myBean;

public class ToonInformation { //웹툰 데이터를 처리하기 위한 클래스
	public ToonInformation() {}
	private int idx;
	
	private String title;
	private String author;
	private String shorts;
	private String introduce;
	private String genre;
	private String originalFileName;
	private String savedFileName;
	
	//각 변수들의 getter, setter 클래스
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public String getSavedFileName() {
		return savedFileName;
	}
	public void setSavedFileName(String savedFileName) {
		this.savedFileName = savedFileName;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getShorts() {
		return shorts;
	}
	public void setShorts(String shorts) {
		this.shorts = shorts;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	
}
