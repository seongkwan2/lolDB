package com.lol.Service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.lol.DAO.BoardDAO;
import com.lol.vo.BoardDetailsVO;
import com.lol.vo.BoardVO;
import com.lol.vo.FileUploadVO;
import com.lol.vo.PageVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardServiceImpl.class);

	@Autowired
	private BoardDAO boardDao;
	
	@Override
	public List<BoardVO> getBoardList() {
		return this.boardDao.getBoardList();
	}

	@Override
	public int getListCount() {
		return this.boardDao.getListCount();
	}

	@Transactional
	@Override
	public void writeBoard(BoardVO boardInfo, MultipartFile file) throws Exception {
		
	    //시퀀스 값을 불러옴 (이 값을 사용하려면 xml에서 시퀀스.nextval 코드를 제거)
	    long nextSeqVal = boardDao.getNextSeqVal();
	    boardInfo.setB_num(nextSeqVal);
	    
	    //게시글 정보를 먼저 저장
	    boardDao.writeBoard(boardInfo);
	    System.out.println("boardInfo의 정보"+boardInfo);
	    // 파일 처리
	    if (file != null && !file.isEmpty()) {
	        // 파일 저장 로직
	        String fileName = file.getOriginalFilename();
	        String uploadPath = "D:\\KGITBANK\\teamproject\\Work_space\\lolDB\\src\\main\\webapp\\upload\\image"; // 서버의 실제 경로
	        String uploadName = UUID.randomUUID().toString() + "_" + fileName;
	        File saveFile = new File(uploadPath, uploadName);
	        file.transferTo(saveFile);

	        // 파일 확장자 추출
	        String f_ext = FilenameUtils.getExtension(fileName);

	        // 파일 크기 설정
	        long f_size = file.getSize();

	        // 파일 정보를 FileUploadVO에 설정
	        FileUploadVO fileUpload = new FileUploadVO();
	        System.out.println("fileUpload에 셋하기전 boardInfo의 b_num : "+boardInfo.getB_num());
	        fileUpload.setB_num(boardInfo.getB_num()); // 방금 저장한 게시글 번호 설정
	        System.out.println("fileUpload에 셋후 boardInfo의 b_num : "+boardInfo.getB_num());
	        System.out.println("fileUpload에 셋후 fileUpload의 b_num : "+fileUpload.getB_num());
	        fileUpload.setF_original_name(fileName);
	        fileUpload.setF_upload_name(uploadName);
	        fileUpload.setF_upload_path(uploadPath);
	        fileUpload.setF_ext(f_ext); // 파일 확장자 설정
	        fileUpload.setF_size((int)f_size); // 파일 크기 설정 (단위: 바이트)

	        // 파일 정보 저장
	        boardDao.uploadFile(fileUpload);
	    }
	}
	
	@Transactional
	@Override
	public BoardDetailsVO getCont(long b_num) {
		BoardVO boardInfo = boardDao.getBoardByNum(b_num); // 게시글 정보 가져오기
	    FileUploadVO fileInfo = boardDao.getFileByBoardNum(b_num); // 해당 게시글의 이미지 파일 정보 가져오기

	    BoardDetailsVO details = new BoardDetailsVO();
	    details.setBoardInfo(boardInfo);
	    details.setFileInfo(fileInfo); // fileInfo가 null일 수 있음

	    return details;
	}

	@Override
	public int boardDel(long b_num) {
		return this.boardDao.boardDel(b_num);
	}

	@Override
    public boolean boardUpdate(BoardVO boardInfo, MultipartFile file) throws Exception {
        // 파일 처리
        if (file != null && !file.isEmpty()) {
            // 파일 저장 로직
            String fileName = file.getOriginalFilename();
            String uploadPath = "D:\\KGITBANK\\teamproject\\Work_space\\lolDB\\src\\main\\webapp\\upload\\image";
            String uploadName = UUID.randomUUID().toString() + "_" + fileName;
            File saveFile = new File(uploadPath, uploadName);
            file.transferTo(saveFile);

            // 파일 확장자 추출
            String f_ext = FilenameUtils.getExtension(fileName);

            // 파일 크기 설정
            long f_size = file.getSize();

            // 파일 정보를 FileUploadVO에 설정
            FileUploadVO fileUpload = new FileUploadVO();
            fileUpload.setB_num(boardInfo.getB_num()); // 게시글 번호 설정
            fileUpload.setF_original_name(fileName);
            fileUpload.setF_upload_name(uploadName);
            fileUpload.setF_upload_path(uploadPath);
            fileUpload.setF_ext(f_ext); // 파일 확장자 설정
            fileUpload.setF_size((int)f_size); // 파일 크기 설정

            // 파일 정보 저장
            boardDao.uploadFile(fileUpload);
        }

        // 게시글 업데이트
        int updateCount = boardDao.boardUpdate(boardInfo);
        return updateCount > 0;
}

	@Override
	public void plusHits(long b_num) {
		this.boardDao.plusHits(b_num);
	}

	@Override
	public List<BoardVO> getBoardListWithReplyCount(PageVO pageInfo) {
		return this.boardDao.getBoardListWithReplyCount(pageInfo);
	}

	@Transactional
	@Override
	public String toggleLike(long b_num, String m_id) {
		int likeStatus = this.boardDao.checkLikeStatus(b_num, m_id);
		if (likeStatus > 0) {
			this.boardDao.removeLike(b_num, m_id);
			this. boardDao.downLike(b_num);
			return "추천을 취소했습니다.";
		} else {
			this.boardDao.addLike(b_num, m_id);
			this.boardDao.upLike(b_num);
			return "해당 게시글을 추천합니다.";
		}
	}

	@Override
	public int getLikesCount(long b_num) {
		return this.boardDao.getLikesCount(b_num);
	}

	@Override
	public int getCountByCategory(String bCategory) {
		return this.boardDao.getCountByCategory(bCategory);
	}

	@Override
	public BoardVO getBoardByNum(long b_num) {
		return this.boardDao.getBoardByNum(b_num);
	}

	@Override
	public List<BoardVO> getPopularByCategory(PageVO pageVO) {
		return this.boardDao.getPopularByCategory(pageVO);
	}

	@Override
	public int getPopularCount(String selectedCategory) {
		return this.boardDao.getPopularCount(selectedCategory);
	}

	@Override
	public List<BoardVO> searchByTitle(String b_title, String b_category, int offset, int limit) {
		return this.boardDao.searchByTitle(b_title, b_category, offset, limit);
	}

	@Override
	public int countSearchResults(String b_title, String b_category) {
		return this.boardDao.countSearchResults(b_title, b_category);
	}

	@Override
	public List<BoardVO> getPopularByCategory(String b_title, String b_category, int offset, int limit) {
		return this.boardDao.getPopularByCategory(b_title,b_category, offset, limit);
	}


}
