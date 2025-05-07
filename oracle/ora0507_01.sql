select * from employees;

-- employees 테이블에 department_name 컬럼을 생성
select department_id from employees;

select department_id, department_name from departments;

desc employees;
DEPARTMENT_ID NUMBER(6)  

desc departments;
DEPARTMENT_ID   NOT NULL NUMBER(6)    
DEPARTMENT_NAME NOT NULL VARCHAR2(80) 

-- equi join
select emp_name, a.department_id, department_name from employees a, departments b
where a.department_id = b.department_id;


-- 각각 테이블 생성 시, emp1에서 업데이트된 항목을 depart1도 업데이트해줘야 한다는 단점이 있음
create table emp1(
EMP_NAME VARCHAR2(80),
DEPARTMENT_ID NUMBER(6),
DEPARTMENT_NAME VARCHAR2(80),
SALARY NUMBER(8,2)
);

insert into emp1 values ('홍길동', 10, '총무기획부', '100');
insert into emp1 values ('유관순', 20, '마케팅', '200');
insert into emp1 values ('이순신', 30, '구매/생산부', '200');

commit;
select * from emp1;

update emp1 set department_name = '전략기획부' where department_id = 10;
commit;

create table depart1(
DEPARTMENT_ID NUMBER(6),
DEPARTMENT_NAME VARCHAR2(80)
);

insert into depart1 values (10, '총무기획부');
insert into depart1 values (20, '마케팅');
insert into depart1 values (30, '구매/생산부');

commit;
select * from depart1;

select count(*) from board;
select * from board;

select * from member;

update member set id='aaa' where id='Vito';
update member set id='bbb' where id='Alvis';
update member set id='ccc' where id='Sonnie';
update member set id='eee' where id='Lorin';
update member set id='fff' where id='Flori';

commit;

select bno, btitle, name from member a, board b where a.id = b.id;

select * from scoregrade;
select * from stuscore;

alter table stuscore add grade char(1) default 'C' not null;
alter table stuscore rename column grade to sgrade;

-- scoregrade, stuscore 테이블 non-equi join
-- 구매리스트 정보 한달별로 총 구매금액 출력 > 회원 등급 기준으로 등급 입력시킬때 non-equi join 주로 사용
select avg, grade from scoregrade a, stuscore b
where avg between minscore and maxscore;

-- 그룹함수 sum()
select sum(salary) from employees;

-- 부서별로 합계
select a.department_id, department_name, count(salary), round(avg(salary),2), sum(salary) from employees a, departments b
where a.department_id = b.department_id 
group by a.department_id, department_name 
order by sum(salary) desc;


select * from stuscore;
select * from stuscore2;

update stuscore2 set rank=0;

commit;

-- stuscore2 테이블 > rank() 함수를 사용해서 등수를 입력하시오.       ** 중요
select * from stuscore2 order by total desc;
select sno, name, total, rank() over(order by total desc) ranks from stuscore2;
select ranks from (select sno, rank() over(order by total desc) ranks from stuscore2);

update stuscore2 a
set rank = ( select ranks from (select sno, rank() over(order by total desc) ranks from stuscore2) b
where a.sno = b.sno );
select * from stuscore2 order by rank;

-- stuscore 테이블 > grade 입력하시오. scoregrade 테이블과 join
select sno, name, total, avg, grade from stuscore, scoregrade
where avg between minscore and maxscore;

update stuscore a 
set sgrade = (
select grade from 
(select sno, avg, grade from stuscore, scoregrade where avg between minscore and maxscore) b 
where a.sno = b.sno );

select * from stuscore2 order by avg;
select count(*) from stuscore2;

select sno, avg, grade from stuscore2, scoregrade where avg between minscore and maxscore;

select * from scoregrade;

desc scoregrade;

alter table scoregrade modify (maxscore number(6, 3));

update scoregrade set maxscore = 59.999 where grade = 'F';
update scoregrade set maxscore = 69.999 where grade = 'D';
update scoregrade set maxscore = 79.999 where grade = 'C';
update scoregrade set maxscore = 89.999 where grade = 'B';

commit;

select * from stuscore2;

alter table stuscore2 add sgrade char(1) default 'F';

select sno, avg, grade 
from stuscore2, scoregrade
where avg between minscore and maxscore;

select grade from (select sno, avg, grade 
from stuscore2, scoregrade
where avg between minscore and maxscore);

update stuscore2 set sgrade = 'B';

update stuscore2 a 
set sgrade = (
select grade from (select sno, avg, grade from stuscore2, scoregrade
where avg between minscore and maxscore) b
where a.sno = b.sno );


-- stuscore2 테이블 rank 입력
update stuscore2 set rank = 1;

select sno, rank() over(order by total desc) from stuscore2;

update stuscore2 a
set rank = (
select ranks from (select sno, rank() over(order by total desc) ranks from stuscore2) b
where a.sno = b.sno);

select * from stuscore2;
select * from stuscore;

--drop table stuscore;

create table stuscore as select * from stuscore2;

create table stuscore3 as select * from stuscore where 1=2;     -- 테이블 구조만 복사

select * from stuscore;
select * from stuscore2;
select * from stuscore3;

--drop table stuscore3;

alter table stuscore2 drop column sgrade;
alter table stuscore2 drop column rank;

select * from (select a.*, rank() over(order by total desc) ranks from stuscore2 a) order by sno;

select * from member;

alter table member add total number(3) default 0;

--update member a set a.total = (
--select b.total from stuscore2 b
--);

select * from stuscore;

--insert into member(total) select total from stuscore;

alter table member add no number(4);

select * from member;

--insert into member(no, total) select sno, total from stuscore;
--update member set no=(select sno from stuscore), total=(select total from stuscore) select sno, total from stuscore;

--delete from member where id is null;
commit;

select rownum, no from member;

--update member set no=(select rownum from member)

select * from stuscore;
update stuscore set sgrade = 'F';
commit;

-- 등급 출력
update stuscore a set sgrade=(
select grade from(
select sno, avg, grade from stuscore, scoregrade where avg between minscore and maxscore) b 
where a.sno = b.sno);

update stuscore set rank = 0;
commit;

-- non-equi join (등급 검색)        ** 중요
select grade from stuscore, scoregrade where avg between minscore and maxscore;
-- avg, grade 중 grade만 출력 + grade 'A', 'B', 'C' 출력 (조건추가)
select grade from (select avg, grade from stuscore, scoregrade where avg between minscore and maxscore) where grade in ('A', 'B', 'C');
select * from scoregrade;       -- grade, minscore, maxscore
select * from stuscore;         -- avg
update stuscore a set sgrade=(
select grade from(
select sno, avg, grade from stuscore, scoregrade where avg between minscore and maxscore) b 
where a.sno = b.sno);


-- equi join : 서로 다른 2개의 테이블에서 같은 컬럼을 가지고 검색
-- non-equi join : 서로 다른 2개의 테이블에서 같은 컬럼이 없는 경우 검색
-- self join : 같은 2개의 테이블에서 검색
-- outer join : null 값이 있을 때 null 값도 포함해서 검색


-- self join
select * from employees;
select employee_id, emp_name, manager_id, job_id from employees;
select a.employee_id, a.emp_name, a.manager_id, b.emp_name from employees a, employees b where a.manager_id = b.employee_id and b.emp_name like '%Steven%';


-- outer join
select a.employee_id, a.emp_name, a.manager_id, b.emp_name from employees a, employees b where a.manager_id = b.employee_id;      -- 106개
select count(*) from employees;     -- 107개

-- manager_id null (null값은 검색X)
select * from employees where manager_id is null;

-- manager_id 반대에 (+) -> null값까지 출력   ** (+)는 한쪽만 지정 가능
select a.employee_id, a.emp_name, a.manager_id, b.emp_name from employees a, employees b where a.manager_id = b.employee_id(+);   -- a.manager_id의 null값 검색

select sum(a.salary), a.manager_id, b.emp_name from employees a, employees b where a.manager_id = b.employee_id(+) group by a.manager_id, b.emp_name;


-- ansi cross join
select * from employees cross join departments;
-- 기본 sql 구문
select * from employees, departments;


-- 기본 sql 구문 - equi join
select emp_name, a.department_id, department_name from employees a, departments b
where a.department_id = b.department_id;

-- ansi join - equi join
--select * from employees a inner join departments b on a.department_id = b.department_id;
select department_id, department_name from employees join departments using(department_id);         -- where 조건 대신 using() 사용
select department_id, department_name from employees inner join departments using(department_id);


-- 기본 sql 구문 - outer join (+) -> 한쪽만 (+) 지정 가능 (full join 불가)
select a.manager_id, b.emp_name from employees a, employees b where a.manager_id = b.employee_id(+);

-- ansi join - outer join
select a.manager_id, b.emp_name from employees a left outer join employees b on a.manager_id = b.employee_id;       -- 왼쪽 a.manager_id 의 null값 검색
select a.manager_id, b.emp_name from employees a right outer join employees b on a.manager_id = b.employee_id;      -- 오른쪽 b.employee_id 의 null값 검색
select a.manager_id, b.emp_name from employees a full outer join employees b on a.manager_id = b.employee_id;       -- 양쪽 a.manager_id, b.employee_id 의 null값 검색



-- union : 2개의 검색된 결과에서 중복된 결과값은 제거 후 출력(중복제거) 2개의 테이블을 출력시킬 때 사용
select * from departments;
select department_id, manager_id from departments where manager_id is not null;
select department_id, manager_id from employees where department_id>80;

select department_id, manager_id from departments where manager_id is not null
union
select department_id, manager_id from employees where department_id>80;

-- employees 테이블에서 부서번호 50 검색, employees 테이블에서 없는 departments의 부서 검색 -> 2개를 union 하시오
select * from employees;
select * from departments;
-- distinct : 중복제거
select distinct a.department_id, b.department_name from employees a, departments b 
where a.department_id = b.department_id and a.department_id>50 order by a.department_id;    -- 부서번호 50 이상 검색 - 6개
select distinct department_id from employees order by department_id;                        -- employees 테이블에서 없는 departments 부서 검색 12개
select department_id, department_name from departments;                                     -- 27개
select department_id, department_name from departments a
where not exists    -- 존재하지않는 것 검색
(select * from employees b where a.department_id = b.department_id);

-- union : 중복제거 / union all : 중복포함
select distinct a.department_id, b.department_name from employees a, departments b 
where a.department_id = b.department_id and a.department_id>50
union
select department_id, department_name from departments a
where not exists    -- 존재하지않는 것 검색
(select * from employees b where a.department_id = b.department_id);

select * from member;
select * from employees;



-- view : 민감한 정보 제외한 가상의 테이블 생성 (실제 테이블 생성X)
create or replace view emp
as select employee_id, emp_name, email, phone_number from employees;    -- 보여줄 컬럼들
select * from emp;

select * from employees;

-- depart1, emp1 테이블의 department_name 중복 -> 수정 시 두 테이블 다 수정 필요
select * from depart1;
select * from emp1;

-- 가상의 테이블 view 사용 시 원래 테이블의 값이 변경되면 view의 값도 자동으로 변경됨
update employees set phone_number = '650.507.9834' where employee_id=198;   -- employees phone_number 변경 시 emp phone_number도 자동으로 변경됨

--drop view emp;

select * from member;
update member set no = rownum;
select rownum, id, phone from member;
select * from stuscore;
select id, phone, b.* from member a, stuscore b where a.no = b.sno;
commit;