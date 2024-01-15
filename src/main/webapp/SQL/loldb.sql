--삭제명령어
DROP TABLE lol_member;              --멤버 테이블
DROP TABLE lol_member_role;        --권한 목록 테이블
DROP TABLE lol_member_authorities;      --권한 관리 테이블
DROP TABLE lol_board;                   --게시판 테이블
DROP TABLE lol_board_reply;             --게시판 댓글 테이블
DROP TABLE lol_board_likes;          --게시판 추천 추적 테이블


DROP SEQUENCE lol_member_seq;       --멤버 시퀀스
DROP SEQUENCE lol_member_role_seq;      --멤버 권한 시퀀스
DROP SEQUENCE lol_member_authorities;   --멤버 권한 관리 시퀀스
DROP SEQUENCE lol_board_seq;            --게시판 시퀀스
DROP SEQUENCE lol_board_reply_seq;      --게시판 댓글 시퀀스
DROP SEQUENCE lol_board_likes_seq;      --게시판 추천 추적 시퀀스

-- 시퀀스 생성
CREATE SEQUENCE lol_member_seq START WITH 1 INCREMENT BY 1 NOCACHE;                --멤버 테이블 시퀀스
CREATE SEQUENCE lol_member_role_seq START WITH 1 INCREMENT BY 1 NOCACHE;            --멤버 권한목록 시퀀스
CREATE SEQUENCE lol_member_authorities_seq START WITH 1 INCREMENT BY 1 NOCACHE;     --멤버 권한관리 시퀀스
CREATE SEQUENCE lol_board_seq START WITH 1 INCREMENT BY 1 NOCACHE;                   --게시판 테이블 시퀀스
CREATE SEQUENCE lol_board_reply_seq START WITH 1 INCREMENT BY 1 NOCACHE;                --게시판 댓글 시퀀스
CREATE SEQUENCE lol_board_likes_seq START WITH 1 INCREMENT BY 1 NOCACHE;                --게시판 추천 추적 시퀀스

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

SELECT * FROM lol_member;

-- 권한 테이블
CREATE TABLE lol_member_role (
  role_id NUMBER PRIMARY KEY,
  role_name VARCHAR2(50) UNIQUE
);
--권한 테이블에 미리 적용시켜놓음
INSERT INTO lol_member_role (role_id, role_name) VALUES (lol_member_role_seq.nextval, 'USER');
INSERT INTO lol_member_role (role_id, role_name) VALUES (lol_member_role_seq.nextval, 'MANAGER');
INSERT INTO lol_member_role (role_id, role_name) VALUES (lol_member_role_seq.nextval, 'ADMIN');

SELECT * FROM lol_member_role;
drop table lol_member_role;

-- 권한 관리 테이블
CREATE TABLE lol_member_authorities (
  authority_id NUMBER PRIMARY KEY,
  m_num NUMBER,
  authority VARCHAR2(50),
  FOREIGN KEY (m_num) REFERENCES lol_member (m_num)
);

SELECT * FROM lol_member_authorities;

-- 게시판 테이블
CREATE TABLE lol_board (        --게시글 수정날짜 추가할것
  b_num NUMBER NOT NULL PRIMARY KEY,
  b_id VARCHAR2(30) NOT NULL,
  b_title VARCHAR2(255) NOT NULL,
  b_cont CLOB NOT NULL,
  b_date TIMESTAMP NOT NULL,
  b_category VARCHAR2(50) NOT NULL,
  b_hits NUMBER DEFAULT 0 NOT NULL,
  b_likes NUMBER DEFAULT 0 NOT NULL,
  FOREIGN KEY (b_id) REFERENCES lol_member(m_id) ON DELETE SET NULL -- 아이디 삭제 시 게시글이 남아있고 아이디는 NULL로 설정
);
select * from lol_board;
--게시판 댓글 테이블       --댓글 수정날짜 추가할것
CREATE TABLE lol_board_reply (
    r_num NUMBER NOT NULL PRIMARY KEY,  --댓글 번호
    r_id VARCHAR2(30) NOT NULL,
    r_cont VARCHAR2(300) NOT NULL,
    r_date TIMESTAMP NOT NULL,
    r_board_num NUMBER NOT NULL,              --게시글 번호
    FOREIGN KEY (r_board_num) REFERENCES lol_board(b_num) ON DELETE CASCADE
); --사용자 탈퇴 시에도 댓글을 보존하기 위해 별도의 외래 키 제약 조건은 추가하지 않음


--이미 게시글에 추천을했는지 추적할수 있도록 liks테이블생성
--사용자가 몇번 게시글에 추천을 했는지 추적가능
CREATE TABLE lol_board_likes (
    like_id NUMBER PRIMARY KEY,
    b_num NUMBER NOT NULL,
    m_id VARCHAR2(30) NOT NULL,
    liked CHAR(1) CHECK (liked IN ('Y', 'N')),
    FOREIGN KEY (b_num) REFERENCES lol_board(b_num) ON DELETE CASCADE,
    FOREIGN KEY (m_id) REFERENCES lol_member(m_id) ON DELETE CASCADE
);
select * from lol_board_likes;
--게시글 추천 테스트 쿼리문
SELECT * FROM lol_board_likes;

SELECT COUNT(*) AS like_count
FROM lol_board_likes
WHERE b_num = [대상 게시글 번호] AND liked = 'Y';



SELECT COUNT(*) FROM lol_board_likes WHERE b_num = :b_num AND m_id = :m_id AND liked = 'Y';

commit;
--ㅡㅡㅡㅡㅡㅡㅡㅡㅡ게시판 데이터 추가 (테스트)ㅡㅡㅡ
--테스트용 댓글 작성
INSERT INTO lol_board_reply values(lol_board_reply_seq.nextval,'zaq3195','안녕하세요 댓글입니다', sysdate, 3);
INSERT INTO lol_board_reply values(lol_board_reply_seq.nextval,'zzz3195','반갑습니다', sysdate, 3);
INSERT INTO lol_board_reply values(lol_board_reply_seq.nextval,'z','하이', sysdate, 3);


--테스트용 아이디
INSERT INTO lol_member VALUES(lol_member_seq.nextval,'z', 'z' , '조성관', '19960307', 'zaq3195@naver.com', '01038882488', '1', '2023-12-21');

--테스트용 게시글작성
INSERT INTO lol_board values(lol_board_seq.nextval,'zaq3195','추천글 테스트입니다!!','테스트 내용 입니다','2024-01-15','자유게시판',1,50);
INSERT INTO lol_board values(lol_board_seq.nextval,'zaq3195','자유게시판 테스트 제목 입니다',' 두번째 테스트 내용 입니다','2024-01-15','자유게시판',1,0);
INSERT INTO lol_board values(lol_board_seq.nextval,'zaq3195','자유게시판 테스트 제목2 입니다',' 두번째 테스트 내용 입니다','2024-01-15','자유게시판',1,0);
INSERT INTO lol_board values(lol_board_seq.nextval,'zaq3195','자유게시판 테스트 제목3 입니다',' 두번째 테스트 내용 입니다','2024-01-15','자유게시판',1,0);

INSERT INTO lol_board values(lol_board_seq.nextval,'zaq3195','팁게시판 테스트 제목 입니다',' 두번째 테스트 내용 입니다','2024-01-15','팁게시판',1,0);
INSERT INTO lol_board values(lol_board_seq.nextval,'zaq3195','팁게시판 테스트 제목2 입니다',' 두번째 테스트 내용 입니다','2024-01-15','팁게시판',1,0);
INSERT INTO lol_board values(lol_board_seq.nextval,'zaq3195','팁게시판 테스트 제목3 입니다',' 두번째 테스트 내용 입니다','2024-01-15','팁게시판',1,0);

--조회수 쿼리문
UPDATE lol_board SET board_views = board_views + 1 WHERE board_id = :게시물_ID;

-- 추천 추가
UPDATE lol_board SET board_likes = board_likes + 1 WHERE board_id = :게시물_ID;

--JOIN을 이용하여 게시판과 댓글 테이블을 합쳐서 해당 게시글의 댓글의 갯수 파악
SELECT b.b_num, b.b_title, b.b_id, b.b_date, b.b_hits, b.b_likes, COUNT(r.r_num) AS reply_count
FROM lol_board b
LEFT JOIN lol_board_reply r ON b.b_num = r.r_board_num
GROUP BY b.b_num, b.b_title, b.b_id, b.b_date, b.b_hits, b.b_likes;
--JOIN앞에 LEFT를 입력해야 0이 표시됨 LEFT를 빼면 NULL로 표기됨

commit;

 SELECT b.b_num, b.b_title, b.b_id, b.b_date, b.b_hits, b.b_likes,
    COUNT(r.r_num) AS reply_count
    FROM lol_board b
    LEFT JOIN lol_board_reply r ON b.b_num = r.r_board_num
    GROUP BY b.b_num, b.b_title, b.b_id, b.b_date, b.b_hits, b.b_likes
    ORDER BY b.b_num desc
    OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
    
    SELECT * FROM lol_board;


SELECT * FROM lol_board WHERE b_num = 56;
SELECT COUNT(*) FROM lol_board WHERE b_likes >= 30;

	    SELECT b.b_num, b.b_title, b.b_id, b.b_date, b.b_hits, b.b_likes, COUNT(r.r_num) AS reply_count
        FROM lol_board b
        LEFT JOIN lol_board_reply r ON b.b_num = r.r_board_num
        WHERE b.b_title LIKE '%' || '안녕' || '%' AND b.b_category = '자유게시판'
        GROUP BY b.b_num, b.b_title, b.b_id, b.b_date, b.b_hits, b.b_likes
        ORDER BY b.b_num DESC
        OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
        
        SELECT b.b_num, b.b_title, b.b_id, b.b_date, b.b_hits, b.b_likes, COUNT(r.r_num) AS reply_count
        FROM lol_board b
        LEFT JOIN lol_board_reply r ON b.b_num = r.r_board_num
        WHERE b.b_title LIKE '%' || '안녕' || '%' AND b.b_category = '자유게시판'
        GROUP BY b.b_num, b.b_title, b.b_id, b.b_date, b.b_hits, b.b_likes
        ORDER BY b.b_num asc
        OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY













