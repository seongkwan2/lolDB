--사이트 사용자 테이블
create table lol_member(
m_num number primary key,
m_id varchar2(30) UNIQUE,
m_pwd varchar2(200),
m_email varchar2(200)
);

SELECT * FROM lol_member;

-- 게시판 테이블
CREATE TABLE lol_board (
  b_num number primary key,
  b_id varchar2(30) REFERENCES lol_member(m_id), --작성자
  b_title VARCHAR2(255),
  b_cont CLOB,
  b_date TIMESTAMP,
  b_category VARCHAR2(50),
  b_hits NUMBER DEFAULT 0, --조회수
  b_likes NUMBER DEFAULT 0 -- 추천 수 필드 (기본값은 0)
);

SELECT * FROM lol_board where b_num = 39;

--ㅡㅡㅡㅡㅡㅡㅡㅡㅡ게시판 데이터 추가 (테스트)ㅡㅡㅡ
INSERT INTO lol_board values(lol_board_seq.nextval,'zz3195','테스트 제목 입니다','테스트 내용 입니다','2023-12-11','자유게시판',1,0);
INSERT INTO lol_board values(lol_board_seq.nextval,'zz3195','두번째 테스트 제목 입니다',' 두번째 테스트 내용 입니다','2023-12-11','자유게시판',1,0);

SELECT * FROM lol_board;


UPDATE lol_board where b_num = 1

UPDATE lol_board SET b_title = '안녕하십니까', b_cont='테스트 내용작성', b_date = sysdate WHERE b_num = 7;

DELETE lol_board where b_num = 40;

drop table lol_board;
drop sequence lol_board_seq;
commit;
delete lol_board;
-- 시퀀스
CREATE SEQUENCE lol_member_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE lol_board_seq START WITH 1 INCREMENT BY 1 NOCACHE;


--예제 쿼리문 
--조회수 쿼리문
UPDATE lol_board SET board_views = board_views + 1 WHERE board_id = :게시물_ID;

-- 추천 추가
UPDATE lol_board SET board_likes = board_likes + 1 WHERE board_id = :게시물_ID;

-- 비추천 추가
UPDATE lol_board SET board_dislikes = board_dislikes + 1 WHERE board_id = :게시물_ID;



--
create table bs_member(
    m_id VARCHAR2(30) PRIMARY KEY, 
    m_pwd VARCHAR2(300),        
    m_name VARCHAR2(30),
    m_birth VARCHAR2(100),                        --20020201 형식으로 받음
    m_email VARCHAR2(300),                       --이메일 앞 부분
    m_phone VARCHAR2(30),                        --폰 번호
    m_tel VARCHAR2(10),
    m_state NUMBER default 1,                     --회원 상태여부(ex: 1은 평범한 상태 0은 탈퇴회원 9는 관리자)
    m_regdate DATE DEFAULT sysdate          --가입일자
);

--회원 테이블 전용 시퀀스
CREATE SEQUENCE bs_member_seq
START WITH 1 INCREMENT BY 1 NOCACHE;  --시퀀스1부터시작, 1씩증가, 캐시사용안함


ALTER SEQUENCE bs_member_seq RESTART START WITH 1; --시퀀스 다시 1부터 시작


--
CREATE TABLE lol_member(
    m_num number NOT NULL PRIMARY KEY,
    m_id VARCHAR(15) UNIQUE NOT NULL,
    m_pwd VARCHAR(30)
);

CREATE SEQUENCE lol_member_seq
START WITH 1 --1부터 시작
INCREMENT BY 1 --1씩 증가
NOCACHE; --캐시 사용안함

COMMIT;

SELECT * FROM lol_member;

INSERT INTO lol_member VALUES(lol_member_seq.next.val, 'zz3195', '1');
INSERT INTO lol_member VALUES(lol_member_seq.next.val, '1234', '1');











