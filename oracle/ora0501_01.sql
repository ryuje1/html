select * from employees;

select * from employees where emp_name like '%n%' order by emp_name desc;

select count(*) from employees where emp_name like '%n%';

select * from stuscore order by rank desc;

select * from stuscore order by kor desc;

-- 입사일 가장 일찍인 사원 순으로 정렬하시오.
select * from employees order by hire_date;




-- 숫자 함수
-- abs() : 절대값 / round() : 반올림 / ceil() : 올림 / floor() : 버림 / trunc() : 특정자리 수 잘라내기
-- mod() : 입력받은 수를 나눈 나머지 값 반환 / power(m,n) m의 n승을 반환
select -10 from dual;
select -10, abs(-10) from dual;

select kor, eng, kor-eng, abs(kor-eng) from stuscore order by abs(kor-eng) desc;

-- rownum : 조회된 순서대로 순번을 다시 매김
select rownum, sno, name from stuscore;
select rownum, sno, name, total from stuscore where total>=250 and rownum<=10;

-- stuscore 테이블에서 1-10등까지의 학생을 출력하시오.
select rownum, a.* from stuscore a where rank<=10 order by rank;
select rownum, a.* from (select * from stuscore where rank<=10 order by rank) a;

-- 국어점수가 80점 이상인 학생 3명을 출력하시오.
select rownum, a.* from (select * from stuscore where kor>=80 order by kor desc) a where rownum<=5;
select sno, a.* from stuscore a where sno<=5;   -- 같은 모양

-- 국어점수와 영어점수 차이가 가장 큰 10명의 학생을 출력하시오.
select rownum, a.* from (select name, kor, eng, abs(kor-eng) ke from stuscore order by ke desc) a where rownum<=10; -- rownum 출력, 별칭사용
select * from (select name, kor, eng, abs(kor-eng) ke from stuscore order by ke desc) where rownum<=10;     -- rownum 출력X, 별칭사용X


-- floor() : 버림
select 12.5, floor(12.5) from dual;

-- ceil() : 올림 -> 자리수 선택 불가
select 12.1, ceil(12.1) from dual;

-- round() : 반올림 -> 자리수 선택 가능. round(m,3) : 소수점 셋째자리까지 표시
select 12.1257, round(12.1257, 3) from dual;
select 34.5678, round(35.5678, -1) from dual;

-- trunc() : 지정한 자리수 버림 / floor()는 소수점 제거
select 34.5678, trunc(34.5678, 2), trunc(34.5678, -1) from dual;

-- mod() : 나눈 나머지. mod(5,2) 1 -> 5%2 와 같음
select mod(27, 2), mod(27, 5), mod(27, 7) from dual;

-- stuscore sno에서 짝수만 출력하시오.
select * from stuscore where mod(sno, 2)=0;
select * from stuscore where mod(sno, 10)=0;    -- 10의 배수

-- 시퀀스 : 자동 번호 생성기
select stu_seq.nextval from dual;   -- 번호 증가
select stu_seq.currval from dual;   -- 현재 번호 확인

-- 왼쪽 메뉴 시퀀스 - 마우스 오른쪽 - 새 시퀀스로 생성 또는 쿼리문으로 생성 가능
create sequence s_seq start with 1 increment by 1 minvalue 1 maxvalue 9999 nocache nocycle; -- 시작값, 증분, 최소값, 최대값, 캐시, 주기
select s_seq.nextval from dual;
select s_seq.currval from dual;

create table board (
bno number(4) primary key,  -- 게시글 번호. primary key : 중복X
btitle varchar2(1000),      -- 제목. varchar2 : 4000byte
bcontent clob,              -- clob : 대용량 문자 (varchar2 무한대)
id varchar2(100),           -- 회원가입 id 연결
bgroup number(4),           -- 답변달기 부모그룹
bstep number(4),            -- 답변달기 순서
bindent number(4),          -- 답변달기 들여쓰기
bhit number(4),             -- 조회수
bfile varchar2(100),        -- 파일첨부
bdate date                  -- 입력날짜
);

insert into board values(
board_seq.nextval, '게시글을 등록합니다.', '홈페이지를 오픈합니다. 많은 이용 바랍니다.',    -- 게시글 번호, 제목, 내용
'aaa', board_seq.currval, 0, 0, 0, '', sysdate
);

insert into board values(
board_seq.nextval, '이벤트 등록', '이벤트를 등록합니다. 꼭 당첨 기대!!',
'bbb', board_seq.currval, 0, 0, 0, '', sysdate
);

insert into board values(
board_seq.nextval, '이벤트 등록2', '이벤트를 등록합니다. 꼭 당첨 기대!!2',
'ccc', board_seq.currval, 0, 0, 0, '', sysdate
);

insert into board values(
board_seq.nextval, '이벤트 등록3', '이벤트를 등록합니다. 꼭 당첨 기대!!3',
'ddd', board_seq.currval, 0, 0, 0, '', sysdate
);

insert into board values(
board_seq.nextval, '이벤트 등록4', '이벤트를 등록합니다. 꼭 당첨 기대!!4',
'eee', board_seq.currval, 0, 0, 0, '', sysdate
);

select * from board;
commit;

insert into stuscore values(
stuscore_seq.nextval, '정진아', 100, 100, 99, 100+100+99, (100+100+99)/3, 0
);
select * from stuscore;
commit;

--delete stuscore where sno in(101, 102, 103);
--drop table stuscore4;

select * from stuscore;
update stuscore set kor=100, total=100+eng+math, avg=(100+eng+math)/3 where sno=105;
rollback;

-- 이름에 김이 들어간 학생을 검색하시오.
select * from stuscore where name like '%김%';



-- 형변환
-- to_char : 날짜형 또는 숫자형을 문자형으로 변환
-- to_date : 문자형을 날짜형으로 변환
-- to_number : 문자형을 숫자형으로 변환
-- number, varchar2, char, date
select 1+2 from dual;   -- 숫자 : 사칙연산 +, -, *, / 가능
select 1+'2' from dual; -- 문자열 숫자는 자동으로 숫자로 변경하여 연산
-- select 1+'a' from dual; -- 다른 타입 연산불가
-- select 'a'+'b' from dual; -- 문자열 연산 불가, || 또는 concat()을 통해 문자열 더하기 가능
select sysdate-1, sysdate, sysdate+1 from dual; -- 날짜는 +, - 가능

select hire_date from employees;
select sysdate from dual;
-- 근무일
select sysdate - hire_date from employees;
select hire_date, round(hire_date), to_char(hire_date, 'yyyy-mm-dd hh:mi:ss') from employees;
select bdate, to_char(bdate, 'yyyy-mm-dd hh24:mi:ss') from board;

insert into board values(
board_seq.nextval, '추가 게시글 등록', '추가로 게시글을 등록합니다. 당첨부탁드려요.',
'aaa', board_seq.currval, 0, 0, 0, '', sysdate
);

select * from board;
desc board;

-- 'day' : 1주가 시작되는 날짜 기준으로 반올림
select bdate, to_char(bdate, 'yyyy-mm-dd hh:mi:ss'), round(bdate, 'day') from board;
-- 'mi' : 30초 이상 +1분
select bdate, to_char(bdate, 'yyyy-mm-dd hh:mi:ss'), to_char(round(bdate, 'mi'), 'yyyy-mm-dd hh24:mi:ss') from board;
-- 'month' : 16일 기준으로 이전은 이번달 1일, 이후는 다음달 1일
select mdate, to_char(mdate, 'yyyy-mm-dd hh:mi:ss'), round(mdate, 'month') from member;


-- trunc 절사 : 해당 달 1일로 변경
select mdate, to_char(mdate, 'yyyy-mm-dd hh:mi:ss'), trunc(mdate, 'month') from member;
select mdate, trunc(mdate, 'month');

-- 현재 일과 입사일의 개월 수 계산
select emp_name, hire_date, sysdate, months_between(sysdate, hire_date) from employees;
select mdate, sysdate, round(months_between(sysdate, mdate))||'개월' from member;

-- 학생 성적이 현재일부터 등록된 달이 4개월 된 학생들을 출력하시오.
select * from member;
select name, mdate, sysdate, round(months_between(sysdate, mdate)) from member where round(months_between(sysdate, mdate)) = '4';

-- substr() : 파이썬 substring() 슬라이싱과 같음 a[3:7]  abcdefghijklmn  defg 출력 (3번째-7이전까지 출력)
select mdate, substr(to_char(mdate), 4, 2) from member;    -- 1부터 시작

select name from stuscore;
select emp_name from employees;
-- emp_name 3번째부터 4개의 글자를 가지고 와 출력하시오.
select emp_name, substr(emp_name, 3, 4) from employees;

-- round (달을 기준) : 16일 이상이면 다음달 1일 / 16일 미만 이번달 1일
select mdate from member;
select mdate, round(mdate, 'month') from member;
select 1.5, round(1.5) from dual;

-- trunc(달을 기준) : 일을 절사 해당월 1일
select mdate, trunc(mdate, 'month') from member;
select 1.5, trunc(1.5) from dual;

-- round(년을 기준) : 7월 1일 이상 년+1 / 미만 해당년도 1월 1일
select mdate, round(mdate, 'year') from member;

-- months_between : 두 날짜 사이의 달수를 계산
select sysdate, mdate, sysdate-mdate from member;
select sysdate, mdate, months_between(sysdate, mdate) from member;
select sysdate, mdate, round(months_between(sysdate, mdate)) from member;
select sysdate, mdate, trunc(months_between(sysdate, mdate)) from member;
select sysdate, mdate, trunc(months_between(sysdate, mdate), 1) from member;
select sysdate, mdate, floor(months_between(sysdate, mdate)) from member;

-- add_months : 날짜에 달을 더해줌
-- 1년 청약 만기일
select sysdate, mdate, add_months(mdate, 12)-1 from member;

-- 다음번 요일 검색
select sysdate, next_day(sysdate, '수요일') from dual;
select sysdate, next_day(sysdate, '금요일') from dual;

-- 마지막 날 검색
select sysdate, last_day(sysdate) from dual;
select mdate, last_day(mdate) from member;
select hire_date, last_day(hire_date) from employees;

-- 날짜를 문자타입으로 변경
select sysdate, to_char(sysdate, 'yyyy') from dual;
select sysdate, to_number(to_char(sysdate, 'mm')) from dual;

-- member 테이블에서 5, 6, 7월 회원가입한 회원을 출력하시오.
select mdate from member where to_char(mdate, 'mm') in ('05', '06', '07') order by mdate asc;

-- employees 테이블 hire_date 5, 6, 7월 입사한 사원을 출력하시오.
select hire_date, to_char(hire_date, 'mm') mm from employees where to_char(hire_date, 'mm') in ('05', '06', '07') order by mm asc;

-- mm : 숫자월 (05, 06 ...) / mon : 영문 또는 한글월 (5월, 6월 ...)
select sysdate, to_char(sysdate, 'mon') from dual;
select mdate, to_char(mdate, 'mon') from member;

-- day : 요일 (월요일, 화요일...) / dy : 일 (월, 화...)
select mdate, to_char(mdate, 'day') from member;
select mdate, to_char(mdate, 'dy') from member;

-- 일요일에 가입한 사람을 출력하시오.
select mdate, to_char(mdate, 'day') from member where to_char(mdate, 'day') = '일요일';

select bdate, to_char(bdate, 'yyyy-mm-dd am hh:mi:ss') from board;  -- 오전/오후
select bdate, to_char(bdate, 'yyyy-mm-dd hh24:mi:ss') from board;   -- 24시간제


-- 숫자형을 문자형으로 변경
-- L : 각 국가통화표시 / $ : 달러표시 / . : 소수점 표시 / , : 천단위 표시 / 0 : 빈자리 0 표시 / 9 : 빈자리 공백 표시
select 1230000000, to_char(1230000000, 'L999,999,999,999.9') from dual;
select 1230000000, to_char(1230000000, '$000,000,000,000.0') from dual;

-- salary 달러 표시, 1438원 곱해서 원화표시와 천단위 표시 소수점 2자리를 넣어 출력하시오.
select salary, to_char(salary, '$999,999'), to_char(salary*1438, 'L999,999,999,999.99')||'원' from employees;



-- 날짜형 타입 변환
select 20221231, to_date(20221231, 'yyyy-mm-dd') from dual;
select '20221231'-1, to_date('20221231', 'yyyy-mm-dd') from dual;
select '20221231'-1, add_months(to_date('20221231', 'yyyy-mm-dd'),3) from dual;

-- '09/01/01' 날짜타입으로 변경해서 현재날짜 기준으로 몇개월이 지났는지 출력하시오.
select sysdate, 09/01/01, months_between(sysdate, '09/01/01')||'개월' from dual;

-- 숫자형 변환 to_number()
select to_number('20,000', '999,999')-1 from dual;

-- replace() : 특정문자를 대체
select '***,111', replace('***,111', '*', '0') from dual;
select '20,000', replace('20,000', ',', '') from dual;
select '20,000', replace('20,000', ',', '')-1 from dual;

-- trim(), replace() : 공백제거
select '       123111 111 111     ' from dual;
select trim('     123111 111 111    ') from dual;   -- 중간 공백은 제외
select trim('     123111 111 111    ')-1 from dual; -- 에러
select replace('    123111 111 111    ', ' ', '')-1 from dual; -- 중간 공백까지 제거 -> replace() 사용 (공백을 ''로 대체)


-- to_date() : 날짜 변환 - 문자, 숫자를 날짜로 변경해서 날짜형태를 +,- 날짜함수를 사용해서 계산
-- to_char() : 문자 변환 - 숫자를 문자로 변경해서 천단위, 0표시, 통화표시
-- to_number() : 숫자 변환 : 천단위 표시된 문자를 숫자로 변환해서 사칙연산을 할 수 있다는 장점

-- NVL() : null을 0 또는 다른 값으로 변환하기 위해 사용
-- commission_pct 커미션 - 월급 * 커미션을 더해서 계산
select salary, commission_pct, salary+(salary*nvl(commission_pct, 0)) 실제월급 from employees;
select manager_id, nvl(manager_id, 0) from employees;   -- null을 0으로 변경
select manager_id, nvl(to_char(manager_id), 'CEO') from employees;  -- null을 CEO로 변경


-------------------------------------------------------------------------------
--그룹함수
-- max(), min(), sum(), avg(), count(), median()
select max(salary) from employees;      -- max() : 최대값
select min(salary) from employees;      -- min() : 최소값
select sum(salary) from employees;      -- sum() : 합계
select avg(salary) from employees;      -- avg() : 평균
select count(salary) from employees;    -- count() : 갯수
select median(salary) from employees;   -- median() : 중간 값

select count(*) from employees where salary>=(select avg(salary) from employees);
select emp_name, avg(salary) from employees;    -- 그룹함수는 단일함수와 같이 사용 불가
select emp_name, min(salary) from employees;    -- 에러
select * from employees where salary=(select min(salary) from employees);   -- select * from employees where salary=2100; 와 동일

-- 그룹함수끼리는 같이 사용 가능
select max(salary), min(salary), avg(salary), count(salary), sum(salary) from employees;

select * from employees;
-- 부서번호가 50번인 사원들의 합계를 출력하시오.
select sum(salary), count(salary), avg(salary) from employees where department_id=50;

-- 그룹함수의 경우 null 제외
select count(*) from employees;             -- 107명
select count(manager_id) from employees;    -- 106명

select manager_id from employees where manager_id is null;
select count(*) from employees where manager_id is null;


-- 문자열 함수
-- initcap() : 첫글자만 대문자로 변환 / lower() : 전부 소문자로 변환 / upper() : 전부 대문자로 변환
select emp_name from employees;
select emp_name, lower(emp_name), upper(emp_name), initcap(emp_name) from employees;
select name from member;

-- lpad(컬럼명,자리수,'특정문자') : 남은 자리수를 특정문자로 대체
select kor, lpad(kor, 10, '@') from stuscore;

-- trim(), ltrim(), rtrim() : 좌우공백 / 왼쪽공백 / 오른쪽공백 제거
select '    aaaa   aaa   ' 문자열, trim('    aaa    aaaaa    ') trim, ltrim('    aaa    aaaaa    ') ltrim, rtrim('    aaa    aaaaa    ') rtrim from dual;

-- substr() : 해당하는만큼 문자열을 분리해서 가져옴
select name from stuscore;
select name, substr(name, 2, 2) from stuscore;  -- 두번째부터 두자리
select substr(name, 0, 2) from stuscore;        -- 처음부터 두자리
select substr(name, 0, 1) from stuscore;        -- 처음부터 한자리

-- replace() : 문자열 대체
select '1111222223333aaa', replace('1111222223333aaa', 'a', '0') from dual;     -- a를 0으로 대체

-- length() : 문자열 길이
select kor from stuscore;
select length(kor) from stuscore;
select length(name) from stuscore;
select max(length(name)) from stuscore;

-- 이름 가져오는데 마지막 글자만 제외 후 출력하시오.
select name, substr(name, 0, length(name)-1) from stuscore;


create table test(
ch1 char(30),
ch2 varchar2(10)
);

insert into test values(
'12345', '12345'
);

commit;
select * from test;

select length(ch1), length(ch2) from test;  -- char : 고정형 (30 고정) / varchar2 : 가변형 (데이터에 맞게 1, 2, 3, 4, 5)

-- 날짜함수
-- 달의 1일, mdate, 마지막일 출력
select trunc(mdate, 'month') "1일", mdate, last_day(mdate) "마지막일" from member;
-- 월만 출력
select mdate, to_char(mdate, 'mon') from member;
select mdate, to_char(mdate, 'mm') from member where to_char(mdate, 'mm')='07';

select * from member;
-- name, mdate 홍길동 가입일:2024년 07월 14일 화요일 형태로 출력하시오
select name, to_char(mdate, '"가입일 :" yyyy"년" mm"월" dd"일" day') from member;