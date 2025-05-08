select * from employees;

select rownum, emp_name, manager_id from employees;

-- select rownum, * from employees;      -- error
select rownum, a.* from employees a order by emp_name;      -- rownum 순차X
-- select문 전체를 테이블로 사용 가능 (select * from employees order by emp_name)
select rownum, a.* from (select * from employees order by emp_name) a;

-- emp_name에 a가 포함 + salary 4800 이상이면서 manager_id가 103
select * from employees where emp_name like '%a%';
select * from employees where salary >= 4800 and manager_id = 103;
select * from (select * from employees where emp_name like '%a%') where salary >= 4800 and manager_id = 103;

-- rownum : 순차적인 번호를 매기는 함수
select rownum, a.* from member a order by id;

-- 순차적인 번호를 다시 매겨서 출력하시오.
select rownum, a.* from (select * from member order by id) a where rownum between 1 and 10;     -- 데이터 정상출력
select rownum, a.* from (select * from member order by id) a where rownum between 2 and 20;     -- 데이터 출력 X
select * from (select rownum rnum, a.* from (select * from member order by id) a) b where rnum between 2 and 20;    -- 데이터 정상출력

select * from (select rownum rnum, a.* from member a) where rnum between 11 and 20;     -- 많이 쓰이는 형태.   **중요

-- rank() : 등수 매기는 함수
select row_number() over(order by id asc) rnum, a.* from member a;
select rownum, a.* from (select * from member order by id asc) a;

select * from stuscore;
-- rank(), dense_rank() : 공동등수 처리방식 다름
select rank() over(order by total desc), total from stuscore;           -- 공동등수 갯수만큼 건너뛰고 다음등수 반환 ex) 1,2,3,4,4,6,7
select dense_rank() over(order by total desc), total from stuscore;     -- 공동등수 갯수와 상관없이 순차적으로 다음등수 반환 ex) 1,2,3,4,4,5,6,7

----

select * from stuscore;
update stuscore set rank=0, sgrade='F';
commit;

-- rank, sgrade 값에 맞게 입력하시오.
-- rank() over()
-- sgrade non-equi join을 해서 해당되는 값을 입력하시오.  - scoregrade 테이블 사용

select sno, rank() over(order by total desc) ranks from stuscore;
update stuscore a 
set rank = (
select ranks from (select sno, rank() over(order by total desc) ranks from stuscore) b 
where a.sno = b.sno );

select * from scoregrade;
select sno, grade, avg from stuscore, scoregrade where avg between minscore and maxscore;
update stuscore a 
set sgrade = (
select grade from (select sno, grade from stuscore, scoregrade where avg between minscore and maxscore) b 
where a.sno = b.sno );

select * from stuscore;


-- substr(데이터, 시작위치, 추출길이) : 문자열 일부 추출 (추출길이 생략 가능)
select mdate, substr(mdate, 4, 2) from member;     -- 월만 출력
select mdate, to_number(substr(mdate, 4, 2)) from member;   -- 숫자타입으로 변경 (0 사라짐)

-- 03-08월까지 출력하시오
select mdate, substr(mdate, 4, 2) from member where substr(mdate, 4, 2) between '03' and '08';
select mdate, to_number(substr(mdate, 4, 2)) from member where to_number(substr(mdate, 4, 2)) between 3 and 8;
select mdate, to_number(substr(mdate, 4, 2)) from member where to_number(substr(mdate, 4, 2)) in (3,4,5,6,7,8);
select mdate, to_number(substr(mdate, 4, 2)) from member where to_number(substr(mdate, 4, 2)) not in (3,4,5,6,7,8);

-- 뒤에 있는 3글자를 출력하시오
select emp_name from employees;
select substr(emp_name, 1, 3) from employees;   -- 앞 3글자
select substr(emp_name, -3) from employees;     -- 뒤 3글자
select emp_name, substr(emp_name, 1, 3) "앞 3글자", substr(emp_name, -3) "뒤 3글자" from employees;


-- 공백제거
select '   aaa bbb ccc    ' from dual;
-- trim() : 앞뒤 공백 제거
select trim('   aaa bbb ccc    ') from dual;
-- replace() : 특정 문자 변경
select replace('   aaa bbb ccc   ', ' ', '') from dual;
-- 이름 공백 제거해서 출력하시오.
select emp_name, replace(emp_name, ' ', '') from employees;

-- lpad(), rpad() : 빈자리수를 특정문자로 채우는 함수
select * from member;
select rpad(phone, 17, '*') from member;
-- 전화번호 뒤 4자리를 ****로 출력하시오.
select rpad(substr(phone, 1, 8), 12, '*') from member;

-- 뒤 2글자를 *로 표시해서 출력하시오.
select name from member;
select name, length(name), rpad(substr(name, 1, length(name)-2), length(name), '*') from member;

-- 뒤 2글자를 *로 표시해서 출력하시오.
select emp_name, rpad(substr(emp_name, 1, length(emp_name)-2), length(emp_name), '*') from employees;
select id, rpad(substr(id,1,length(id)-2), length(id), '*') from member;

-- id 모두 *표시, 비밀번호 뒤 2자리 * 표시
select id, rpad('*', length(id), '*'), pw, rpad(substr(pw,1,length(pw)-2), length(pw), '*') from member;

-- 010-****-5678 phone 컬럼 출력하시오.
select phone, substr(phone, 1, 4)||'***'||substr(phone, 8, 5) as phone2 from member;

-- 그 달의 첫번째 일, 마지막일 출력하시오.
select mdate from member;
select mdate, trunc(mdate, 'month') "1일", last_day(mdate) "마지막일" from member;

-- 날짜 형태 yyyy-mm-dd hh:mi:ss 형태로 변경하시오. 24시간으로 표시
select to_char(mdate, 'yyyy-mm-dd hh24:mi:ss') from member;

-- decode() : switch문과 동일. 같은지 비교
select emp_name, department_id from employees;
select emp_name, department_id,
decode(department_id, 
10, '총무기획부',
20, '마케팅',
30, '구매/생산부',
40, '인사부',
50, '배송부') as depart_name from employees;

--  12-2 겨울  3-5 봄 / 6-8 여름 / 9-11 가을
select * from member;

-- decode
select name, mdate, substr(mdate,4,2) month,
decode(substr(mdate,4,2),
'12', '겨울',
'01', '겨울',
'02', '겨울',
'03', '봄',
'04', '봄',
'05', '봄',
'06', '여름',
'07', '여름',
'08', '여름',
'09', '가을',
'10', '가을',
'11', '가을') season from member;

-- case문
select mdate, substr(mdate,4,2),
case 
when substr(mdate,4,2) in ('12', '01', '02') then '겨울'
when substr(mdate,4,2) in ('03', '04', '05') then '봄'
when substr(mdate,4,2) in ('06', '07', '08') then '여름'
when substr(mdate,4,2) in ('09', '10', '11') then '가을'
end season from member;


-- 90점 이상이면 VVIP / 80점 이상 VIP / 70점 이상 GOLD / 60점 이상 SILVER / 그외 BRONE
select avg,
case
when avg>=90 then 'VVIP'
when avg>=80 then 'VIP'
when avg>=70 then 'GOLD'
when avg>=60 then 'SILVER'
when avg<60 then 'BRONE'
end rank
from stuscore;

-- group by절에서는 where절로 조건문 불가. 일반함수는 where절 사용 가능
-- select department_id, avg(salary) from employees group by department_id where department_id<50;  -- error
-- having : 그룹함수의 조건문을 입력
select department_id, avg(salary) from employees where department_id<50 group by department_id having avg(salary)>5000;

select max(salary) from employees group by department_id;       -- 부서별 최고 급여
select emp_name, salary from employees where salary in (select max(salary) from employees group by department_id);      -- 부서별 최고 급여, 받는 사원
-- 부서별 최고급여, 받는 사원, 부서이름
select employee_id, emp_name, a.department_id, department_name, salary from employees a, departments c 
where salary in (select max(salary) from employees b where a.department_id = b.department_id group by department_id)
and a.department_id = c.department_id;      -- in 대신 = some 써도 동일한 결과 출력


select * from stuscore;
alter table stuscore add sclass number(2) default 0;

-- 1-10번까지 1반 / 11-20번까지 2반 / 21-30번까지 3반 / .... / 11
update stuscore set sclass=1;
select * from stuscore;

select sno, name,
case
when sno<=10 then 1          -- when sno between 1 and 10 then 1 도 가능
when sno<=20 then 2
when sno<=30 then 3
when sno<=40 then 4
when sno<=50 then 5
when sno<=60 then 6
when sno<=70 then 7
when sno<=80 then 8
when sno<=90 then 9
when sno<=100 then 10
when sno<=110 then 11
end ssclass from stuscore;

-- sclass 칼럼에 case문
update stuscore set sclass=
case
when sno<=10 then 1
when sno<=20 then 2
when sno<=30 then 3
when sno<=40 then 4
when sno<=50 then 5
when sno<=60 then 6
when sno<=70 then 7
when sno<=80 then 8
when sno<=90 then 9
when sno<=100 then 10
when sno<=110 then 11
end

alter table stuscore modify sclass number(3);

update stuscore a set sclass = (select rnum from (select rownum rnum, sno from stuscore) b where a.sno = b.sno);

select rownum from stuscore;


-- sclass 반 별로 가장 성적이 높은 학생들을 출력하시오.
select * from stuscore;
select max(total), sclass from stuscore group by sclass;
select * from stuscore where total in (select max(total) from stuscore group by sclass);    -- 결과 15개
select sno, total, sclass from stuscore a where total in (select max(total) maxtotal from stuscore b where a.sclass = b.sclass group by sclass);     -- 결과 11개

-- 부서별 가장 월급이 높은 사원 출력
select emp_name, salary, c.department_id, c.department_name from employees a, departments c
where salary in (
select max(salary) from employees b where a.department_id = b.department_id group by department_id)
and a.department_id = c.department_id;

-- sclass 반 별로 가장 성적이 낮은 학생들을 출력하시오.

-- 부서 12개
select distinct department_id from employees order by department_id;
-- 부서 27개
select department_id from departments;
-- employees 없는 부서를 출력하시오.
select department_id, department_name from departments a
where not exists
(select * from employees b where a.department_id = b.department_id)
;

-- member 테이블에 이름이 존재하는 stuscore 학생 성적을 출력하시오.
select * from stuscore a
where exists
(select * from member b where a.name = b.name);

-- 부서별 가장 월급이 높은 사원 출력 (다중열 서브쿼리)
select * from employees
where (department_id, salary) in (select department_id, max(salary) from employees group by department_id);


create table stuscore3 as select * from stuscore;               -- 테이블 생성 및 데이터 복사
create table stuscore3 as select * from stuscore where 1=2;     -- 테이블만 생성

insert into stuscore3(sno, kor) select sno, kor from stuscore3;
select * from stuscore3;

create table stuscore2 as select * from stuscore;


select * from stuscore2;
update stuscore2 set sclass = 0;
commit;

select max(rank), sclass from stuscore2 group by sclass;
select * from stuscore2 a where rank in (select max(rank) from stuscore2 b where a.sclass = b.sclass group by sclass);

select min(rank), sclass from stuscore2 group by sclass;
select * from stuscore2 a where rank in (select min(rank) from stuscore2 b where a.sclass = b.sclass group by sclass);