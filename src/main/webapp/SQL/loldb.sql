12345678
테스트
테스트테스트DQWDQW
6787867876868678678678677876867
1234sdfdsafaASDAd
sadfassffaf
sdafsdfawe
sdfffsdwfwa
SDZFSZFSDFFFDZ
--사이트 사용자 테이블
create table lol_member(
m_num number primary key,
m_id varchar2(30) UNIQUE,
m_pwd varchar2(200),
m_email varchar2(200)
);

--lol 플레이어 테이블
create table lol_player(
p_num number primary key,
p_id varchar2(30) UNIQUE,
p_level varchar2(5),
p_rank varchar2(20),
p_rank_point number,
p_WinRate number
);

--챔피언 테이블
create table lol_cmp(
cmp_num number primary key,
cmp_name varchar2(20)
);

--아이템 테이블
create table lol_item(
item_num number primary key,
item_name varchar2(30),
item_price number
);

-- 게임 테이블(전적)
CREATE TABLE lol_game (
  game_num number PRIMARY KEY,
  game_id varchar2(30) REFERENCES lol_player(p_id) ON DELETE CASCADE,
  game_mode varchar2(30),
  game_out_time TIMESTAMP, -- 게임 일시 (시간 및 날짜 정보를 포함하는 타임스탬프)
  game_in_time INTERVAL DAY TO SECOND, -- 게임 지속 시간 (예: 30분)
  game_result varchar2(10), -- 게임 결과 (승, 패, 무승부 등)
  game_cmp varchar2(20) REFERENCES lol_cmp(cmp_name), -- 플레이한 챔피언
  game_kills number, -- 킬 수
  game_deaths number, -- 데스 수
  game_assists number, -- 어시스트 수
  game_cs number, -- 미니언 처치 수
  game_gold number, -- 획득한 골드
  game_items varchar2(1000) -- 획득한 아이템 목록 (콤마로 구분하여 저장)
);



-- 게시판 테이블
CREATE TABLE lol_board (
  board_num number primary key,
  board_id varchar2(30) REFERENCES lol_member(m_id), --작성자
  board_title VARCHAR2(255),
  board_content CLOB,
  board_created TIMESTAMP,
  board_category VARCHAR2(50),
  board_views NUMBER DEFAULT 0, --조회수
  board_likes NUMBER DEFAULT 0, -- 추천 수 필드 (기본값은 0)
  board_dislikes NUMBER DEFAULT 0 -- 비추천 수 필드 (기본값은 0)
);




-- 시퀀스
CREATE SEQUENCE lol_member_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE lol_player_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE lol_cmp_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE lol_item_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE lol_gamegame_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE lol_board_seq START WITH 1 INCREMENT BY 1 NOCACHE;






-- 예제 데이터 삽입
INSERT INTO lol_game 
(game_num, game_id, game_mode, game_out_time, game_in_time, game_result, 
game_cmp, game_kills, game_deaths, game_assists, game_cs, game_gold, game_items)
VALUES
(game_seq.nextval, '유저1', '소환사의 협곡', TIMESTAMP '2023-11-13 14:30:00', INTERVAL '30' MINUTE, '승', '이렐리아', 10, 2, 5, 200, 15000, '아이템1,아이템2,아이템3');


--예제 쿼리문 
--조회수 쿼리문
UPDATE lol_board SET board_views = board_views + 1 WHERE board_id = :게시물_ID;

-- 추천 추가
UPDATE lol_board SET board_likes = board_likes + 1 WHERE board_id = :게시물_ID;

-- 비추천 추가
UPDATE lol_board SET board_dislikes = board_dislikes + 1 WHERE board_id = :게시물_ID;













