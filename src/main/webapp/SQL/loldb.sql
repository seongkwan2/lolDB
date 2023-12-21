--삭제명령어
DROP TABLE lol_member;              --멤버 테이블
DROP TABLE lol_member_role;        --권한 목록 테이블
DROP TABLE lol_member_authorities;      --권한 관리 테이블
DROP TABLE lol_board;                   --게시판 테이블


DROP SEQUENCE lol_member_seq;       --멤버 시퀀스
DROP SEQUENCE lol_member_role_seq;      --멤버 권한 시퀀스
DROP SEQUENCE lol_member_authorities;   --멤버 권한 관리 시퀀스
DROP SEQUENCE lol_board_seq;            --게시판 시퀀스

-- 시퀀스
CREATE SEQUENCE lol_member_seq START WITH 1 INCREMENT BY 1 NOCACHE;                --멤버 테이블 시퀀스
CREATE SEQUENCE lol_board_seq START WITH 1 INCREMENT BY 1 NOCACHE;                   --게시판 테이블 시퀀스
CREATE SEQUENCE lol_member_role_seq START WITH 1 INCREMENT BY 1 NOCACHE;            --멤버 권한목록 시퀀스
CREATE SEQUENCE lol_member_authorities_seq START WITH 1 INCREMENT BY 1 NOCACHE;     --멤버 권한관리 시퀀스


--사이트 사용자 테이블
create table lol_member(
m_num number primary key,
m_id varchar2(30) UNIQUE,
m_pwd varchar2(200),
m_name varchar2(10),
m_birth varchar2(10),
m_email varchar2(200),
m_phone varchar2(20),
m_state number default 1,  --회원 상태여부(ex: 1은 평범한 상태 0은 탈퇴회원 9는 관리자)
m_regdate timestamp
);
SELECT sequence_name, last_number FROM user_sequences WHERE sequence_name = 'LOL_MEMBER_SEQ';

SELECT * FROM lol_member;

--테스트용 아이디
INSERT INTO lol_member VALUES(lol_member_seq.nextval,'z', 'z' , '조성관', '19960307', 'zaq3195@naver.com', '01038882488', '1', '2023-12-21');

-- 권한 테이블
CREATE TABLE lol_member_role (
  role_id NUMBER PRIMARY KEY,
  role_name VARCHAR2(50) UNIQUE
);
--권한 테이블에 미리 적용시켜놓음
INSERT INTO lol_member_role (role_id, role_name) VALUES (lol_member_role_seq.nextval, 'USER');
INSERT INTO lol_member_role (role_id, role_name) VALUES (lol_member_role_seq.nextval, 'MANAGER');
INSERT INTO lol_member_role (role_id, role_name) VALUES (lol_member_role_seq.nextval, 'ADMIN');

SELECT * FROM member_role;
drop table member_role;

-- 권한 관리 테이블
CREATE TABLE lol_member_authorities (
  authority_id NUMBER PRIMARY KEY,
  m_num NUMBER,
  authority VARCHAR2(50),
  FOREIGN KEY (m_num) REFERENCES lol_member (m_num)
);

commit;


SELECT * FROM lol_member_authorities;

commit;

-- 게시판 테이블
CREATE TABLE lol_board (
  b_num NUMBER PRIMARY KEY,
  b_id VARCHAR2(30),
  b_title VARCHAR2(255),
  b_cont CLOB,
  b_date TIMESTAMP,
  b_category VARCHAR2(50),
  b_hits NUMBER DEFAULT 0,
  b_likes NUMBER DEFAULT 0,
  FOREIGN KEY (b_id) REFERENCES lol_member(m_id) ON DELETE SET NULL -- 아이디 삭제 시 게시글이 남아있고 아이디는 NULL로 설정
);


SELECT * FROM lol_board where b_num = 39;

--ㅡㅡㅡㅡㅡㅡㅡㅡㅡ게시판 데이터 추가 (테스트)ㅡㅡㅡ
INSERT INTO lol_board values(lol_board_seq.nextval,'zaq3195','테스트 제목 입니다','테스트 내용 입니다','2023-12-11','자유게시판',1,0);
INSERT INTO lol_board values(lol_board_seq.nextval,'zaq3195','두번째 테스트 제목 입니다',' 두번째 테스트 내용 입니다','2023-12-11','자유게시판',1,0);

SELECT * FROM lol_board;
commit;

--조회수 쿼리문
UPDATE lol_board SET board_views = board_views + 1 WHERE board_id = :게시물_ID;

-- 추천 추가
UPDATE lol_board SET board_likes = board_likes + 1 WHERE board_id = :게시물_ID;

-- 비추천 추가
UPDATE lol_board SET board_dislikes = board_dislikes + 1 WHERE board_id = :게시물_ID;















