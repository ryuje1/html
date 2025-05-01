-- drop table stuscore3;

select * from member;

desc member;

insert into member values(
'ggg', '1111', '홍길자', '010-6666-6666'
);

commit;

update member set pw='2222' where id='ggg';

commit;

select * from member;

-- 테이블 생성 create
-- 검색 : select
-- 수정 : update
-- 추가 : insert
-- 삭제 : delete

select * from stuscore;

select kor+1 from stuscore;

update stuscore set kor=kor+1;
update stuscore set total = kor+eng+math;
update stuscore set avg = total/3;

rollback;

-- update stuscore set kor=kor+10;
-- update stuscore set total = kor+eng+math, avg=total/3;
select * from stuscore;
select count(*) from stuscore;

-- delete stuscore where sno=1;

-- 컬럼 8개 - sno, name, kor, eng, math, total, avg, rank
select * from stuscore;
select * from stuscore where avg>=80;

-- 평균이 80점 이상이면서 국어점수가 90점 이상을 검색하시오
select sno, kor, avg from stuscore where avg>=80 and kor>=90;

-- 평균 80점 이상
select sno, kor, avg from stuscore where avg>=80;
select sno, kor, avg from (select sno, kor, avg from stuscore where avg>=80) where kor>=90; -- 이중쿼리

select sno, total, rank() over(order by total desc) from stuscore;

-- 테이블 복사 --
-- 테이블 전체 복사
create table stuscore2 as select * from stuscore;
select * from stuscore2;
-- 테이블 원하는 컬럼만 복사
-- sno, name, kor, eng, math
create table stuscore3 as select sno, name, kor, eng, math from stuscore;
select * from stuscore;
-- 테이블 구조만 복사 (데이터 복사X)
create table stuscore4 as select * from stuscore where 1=2;
select * from stuscore4;

desc stuscore;
-- 컬럼 추가
alter table stuscore3 add total number(3);
alter table stuscore3 add avg number(5,2);
alter table stuscore3 add rank number(3);

select * from stuscore3;

select sno, name, total, kor, eng, math, avg, rank from stuscore3;

desc stuscore3;

-- 컬럼 순서 변경
-- 안보이게 설정
alter table stuscore3 modify kor invisible;
alter table stuscore3 modify eng invisible;
alter table stuscore3 modify math invisible;
alter table stuscore3 modify avg invisible;
alter table stuscore3 modify rank invisible;
-- 뒤쪽부터 보여짐
alter table stuscore3 modify kor visible;
alter table stuscore3 modify eng visible;
alter table stuscore3 modify math visible;
alter table stuscore3 modify avg visible;
alter table stuscore3 modify rank visible;

select * from stuscore3;
desc stuscore3;


update stuscore3 set total=kor+eng+math, avg=(kor+eng+math)/3;
commit;
select * from stuscore3;

-- 테이블 별칭은 as X
select kor+eng as ke from stuscore3 s;
select * from stuscore3;

select total from stuscore3 order by total desc;

-- 2개 합치기
select sno, rank from stuscore3;
select sno, rank() over(order by total desc) ranks from stuscore3;

-- update stuscore3 set rank = 1 where sno=1;
-- select ranks from (select sno, rank() over(order by total desc) ranks from stuscore3) b
-- where a.sno = b.sno;
-- select * from stuscore3;

update stuscore3 a 
set rank = (
select ranks from (select sno, rank() over(order by total desc) ranks from stuscore3) b
where a.sno = b.sno);
select * from stuscore3;


select max(total) from stuscore3;   -- 최대값
select min(total) from stuscore3;   -- 최소값
select count(total) from stuscore3; -- 개수
select avg(total) from stuscore3;   -- 평균 224,4
select avg(avg) from stuscore3;     -- 평균 74,7999
select sum(total) from stuscore3;   -- 전체합계

-- 전체평균보다 이하인 학생들에게만 전체평균 값을 입력하시오.
update stuscore3 set avg = (select avg(avg) from stuscore3)
where total<=(select avg(total) from stuscore3);
select * from stuscore3;
rollback;


-- date는 +,- 가능
-- hire_date : 입사일
select * from employees;
-- 근무일수
select hire_date from employees;
select sysdate from dual;
select round(sysdate - hire_date, 2) sh from employees order by sh desc;    -- 소수점 2자리
-- 근무일수에서 +100일 후 보너스 지급할 예정
select hire_date, hire_date+360 h3 from employees order by h3 asc;
-- 매일 00시마다 sysdate 비교해서 쿠폰 전달하는 형식으로 구현 가능

-- 입사일이 04-01-01 이후인 사원 출력
select hire_date from employees where hire_date>='04-01-01';

-- 문자열은 +,-,*,/ 불가능


select * from employees;
-- 월급 4000이상 이면서 부서번호가 50 이상인 사원을 검색하시오.
select * from employees where salary>=4000 and department_id>=50 order by employee_id;
-- 사원번호 150번 이상이거나 입사일이 2007/01/01 이전인 사원을 검색하시오.
select count(*) from employees;
select * from employees where employee_id>=150 or hire_date<'07/01/01';
-- 월급 4000, 6000, 7000인 사원을 검색하시오.
select * from employees where salary in(4000, 6000, 7000);
select * from employees where salary not in(4000, 6000, 7000);
select manager_id from employees where manager_id is null;
select manager_id from employees where manager_id is not null;
-- 부서번호가 50번인 사원을 검색하시오.
select * from employees where department_id=50;
-- 부서번호가 20, 30번이 아닌 사원을 검색하시오.
select * from employees where department_id not in(20,30) order by department_id;
select * from employees where department_id!=20 and department_id!=30;
-- 월급이 4000 이상 6000 이하인 사원 검색하시오.
select * from employees where salary>=4000 and salary<=6000;
select * from employees where salary between 4000 and 6000;     -- >=, <=
select * from employees where salary not between 4000 and 6000;
-- 입사일이 00/01/01부터 07/12/31
select * from employees where hire_date>='00/01/01' and hire_date<='07/12/31';
select * from employees where hire_date between '00/01/01' and '07/12/31';


select * from employees;
-- 월급이 3800 이상이면서 sh_clerk인 사원 검색하시오.
select * from employees where salary>=3800 and job_id='SH_CLERK';   -- 데이터는 대소문자 구분! 명령어는 구분X
-- CLERK 포함되어 있는 사원을 모두 검색하시오.
select job_id from employees where job_id = 'SH_CLERK' or job_id = 'PU_CLERK' or job_id = 'ST_CLERK';
select job_id from employees where job_id like '%CLERK%';
-- 이름 중에 n이 들어가있는 사원을 출력하시오.
select * from employees where emp_name like '%n%';
-- 이름 중에 2번째에 o가 들어가있는 사원을 검색하시오.
select emp_name from employees where emp_name like '_o%';
-- 이름 중에 3번째에 u가 들어가있는 사원을 검색하시오.
select emp_name from employees where emp_name like '__u%';
-- '_' 들어간 항목 검색 -> escape 사용
select job_id from employees where job_id like '%#_%' escape '#';


select * from stuscore;
-- 이름 중에 순 학생을 검색하시오.
select * from stuscore where name like '%순%';
-- 2번째 a가 들어가 있는 학생 검색
select * from stuscore where name like '_a%';


select * from member;
-- member 테이블에서 날짜 25년 1월~3월까지 가입한 회원을 출력하시오.
select * from member where mdate between '25/01/01' and '25/03/31' order by mdate;
select * from member where mdate>='25/01/01' and mdate<='25/03/31' order by mdate;


select * from stuscore;
-- 이름 중에 3번째에 g가 들어간 사람을 검색하시오. (대소문자 포함 검색)
select * from stuscore where lower(name) like '__g%';
select * from stuscore where upper(name) like '__G%';


-- salary, 연봉 계산, 원화 (*1438), 천단위 표시 -> 대소문자 구분없이 이름 3번째에 g 들어가있는 사원만 출력하시오.
select emp_name, salary from employees;
select emp_name, salary, salary*12 연봉, salary+salary*nvl(commission_pct, 0) "커미션 포함", 
salary*12*1438 원화, to_char(salary*12*1438, '999,999,999') 천단위 from employees where lower(emp_name) like '__g%';


-- 이름 순으로 정렬하시오.
-- emp_name 순차정렬 asc (생략가능)
select * from employees order by emp_name asc;
-- emp_name 역순정렬 desc
select * from employees order by emp_name desc;


select * from employees;
-- email E 또는 S 포함되어 있는 사원을 출력하시오.
select * from employees where email like '%E%' or email like '%S%' order by email;
select * from employees where email like '%E%' and email like '%S%' order by email desc;

select * from stuscore;
-- 2개 이상 order by 정렬 : kor 1차 정렬 후 같은 값일 경우 eng 2차 정렬. 1,2차 값이 같으면 3차 정렬
select * from stuscore order by kor asc, eng desc, math desc;


-- delete member;
commit;

-- drop table member;

create table member (
id varchar2(30),
pw varchar2(30),
name varchar2(100),
phone char(13),
email varchar2(100),
gender nchar(2),
mdate date
);


insert into member (id, pw, name, phone, email, gender, mdate) values ('Flori', 9733, '홍길동', '952-160-6953', 'ffebry0@statcounter.com', '여성', '2024-07-14');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Holt', 2138, '유관순', '718-189-1853', 'hchristensen1@msu.edu', '여성', '2025-03-15');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Byrom', 3730, '이순신', '223-452-6929', 'blambirth2@howstuffworks.com', '남성', '2025-04-06');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Austin', 5850, '강감찬', '721-858-1554', 'awheldon3@usgs.gov', '남성', '2025-01-28');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Allard', 5244, '김구', '526-945-2485', 'atarply4@trellian.com', '여성', '2025-03-07');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Dolores', 7064, '김유신', '453-868-9149', 'ddunge5@soundcloud.com', '여성', '2024-12-22');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Asher', 6589, '홍길자', '614-424-8034', 'abedingfield6@bloglovin.com', '여성', '2024-06-06');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Dalt', 2519, '홍길순', '811-206-7944', 'dmacvey7@google.com', '여성', '2024-07-18');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Lexy', 9465, '길동스', '160-102-3854', 'ldavison8@businessweek.com', '여성', '2024-06-22');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Gualterio', 1809, '관순스', '698-982-5647', 'gnoirel9@4shared.com', '여성', '2024-08-14');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Keslie', 4280, '순신스', '637-621-8583', 'kyerralla@miitbeian.gov.cn', '여성', '2024-11-20');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Wolfy', 2170, '감찬스', '554-810-1509', 'woverstallb@howstuffworks.com', '여성', '2024-07-12');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Dagmar', 2970, '구스', '947-984-5033', 'dhendrixc@google.com', '남성', '2024-09-29');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Sybille', 4744, '유신스', '832-420-7001', 'sshenfishd@google.nl', '여성', '2024-05-11');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Andres', 5244, '길자스', '951-938-1802', 'alingee@tamu.edu', '여성', '2025-03-02');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Travis', 4099, '길순스', '903-445-0327', 'twaddinghamf@stumbleupon.com', '여성', '2024-05-25');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Tilda', 3136, 'Duddridge', '196-530-6277', 'tduddridgeg@apache.org', '여성', '2024-08-19');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Tabina', 9870, 'Lohmeyer', '309-495-5142', 'tlohmeyerh@slashdot.org', '여성', '2024-10-14');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Fonzie', 5415, 'Hayford', '665-131-6314', 'fhayfordi@nymag.com', '남성', '2024-08-22');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Carmina', 6472, 'Gilpin', '742-804-3880', 'cgilpinj@state.gov', '여성', '2024-11-05');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Elias', 5737, 'Gilleson', '306-249-4478', 'egillesonk@clickbank.net', '여성', '2024-08-07');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Dotti', 2154, 'Lill', '303-631-0586', 'dlilll@forbes.com', '여성', '2024-06-16');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Wilfrid', 5834, 'Paladino', '158-235-0716', 'wpaladinom@kickstarter.com', '여성', '2025-04-01');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Delly', 4562, 'Theodore', '732-786-9240', 'dtheodoren@geocities.jp', '여성', '2024-12-01');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Issiah', 4863, 'Wehnerr', '603-752-8317', 'iwehnerro@ow.ly', '여성', '2024-12-02');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Caril', 6627, 'Domoni', '857-683-9217', 'cdomonip@trellian.com', '여성', '2024-06-17');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Martynne', 8848, 'Staner', '235-900-0077', 'mstanerq@soundcloud.com', '여성', '2024-07-14');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Nettle', 4173, 'Winslet', '728-350-3609', 'nwinsletr@microsoft.com', '남성', '2025-02-06');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Vivien', 8149, 'Curman', '327-964-9491', 'vcurmans@yahoo.co.jp', '남성', '2025-02-25');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Arliene', 3016, 'Downing', '181-939-7389', 'adowningt@state.gov', '여성', '2025-04-26');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Selestina', 8482, 'Bartoshevich', '444-716-8756', 'sbartoshevichu@slashdot.org', '여성', '2024-07-25');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Andre', 5670, 'Sevin', '142-187-7961', 'asevinv@homestead.com', '여성', '2024-08-17');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Zachariah', 7759, 'Varty', '916-167-3292', 'zvartyw@cmu.edu', '남성', '2024-09-05');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Sloan', 9239, 'Slimming', '824-633-6651', 'sslimmingx@yale.edu', '남성', '2024-07-23');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Dell', 7041, 'Volks', '514-827-8034', 'dvolksy@webmd.com', '여성', '2024-06-24');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Beryle', 5552, 'Wiffield', '461-542-7215', 'bwiffieldz@goo.ne.jp', '여성', '2024-05-02');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Rikki', 1153, 'MacQueen', '467-667-4369', 'rmacqueen10@tmall.com', '여성', '2024-05-09');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Halli', 7992, 'Lainge', '182-953-4251', 'hlainge11@smh.com.au', '여성', '2025-01-30');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Agnella', 5504, 'Bilston', '229-678-8906', 'abilston12@theglobeandmail.com', '남성', '2024-09-23');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Hyman', 3954, 'Kirdsch', '178-922-5747', 'hkirdsch13@wikimedia.org', '여성', '2024-05-09');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Rodrique', 1880, 'De''Ath', '489-447-7343', 'rdeath14@creativecommons.org', '남성', '2025-04-22');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Sue', 6888, 'Hartridge', '824-257-3099', 'shartridge15@ameblo.jp', '여성', '2025-04-01');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Felicia', 3180, 'Di Domenico', '255-740-1393', 'fdidomenico16@washingtonpost.com', '남성', '2024-07-20');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Dionysus', 9811, 'Bassilashvili', '666-659-2717', 'dbassilashvili17@gov.uk', '남성', '2025-02-01');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Mandy', 1986, 'Krysztofowicz', '184-431-3674', 'mkrysztofowicz18@arstechnica.com', '여성', '2025-02-25');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Urbain', 9959, 'Bittleson', '255-656-5127', 'ubittleson19@creativecommons.org', '남성', '2025-02-13');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Ricard', 1062, 'Erley', '140-213-4084', 'rerley1a@geocities.com', '여성', '2024-12-29');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Vail', 4424, 'Houndsom', '793-206-2761', 'vhoundsom1b@google.com.au', '남성', '2024-12-29');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Antonino', 9306, 'Lounds', '809-147-5576', 'alounds1c@delicious.com', '남성', '2024-10-29');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Hobart', 9400, 'McKillop', '820-235-9481', 'hmckillop1d@hexun.com', '남성', '2024-05-13');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Hana', 1104, 'Ebbs', '878-518-2547', 'hebbs1e@ox.ac.uk', '여성', '2024-11-02');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Aimee', 4536, 'Pascho', '195-224-6175', 'apascho1f@oaic.gov.au', '남성', '2025-02-16');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Janaye', 7728, 'Hawthorne', '635-776-4202', 'jhawthorne1g@whitehouse.gov', '여성', '2025-02-11');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Marijn', 8664, 'Liveley', '144-331-5514', 'mliveley1h@chicagotribune.com', '남성', '2024-06-08');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Oona', 6472, 'Cunniam', '207-704-9936', 'ocunniam1i@wisc.edu', '남성', '2025-03-14');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Bernetta', 8593, 'McCoid', '627-101-4270', 'bmccoid1j@washington.edu', '남성', '2024-12-16');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Patin', 8380, 'Carleton', '246-663-1138', 'pcarleton1k@furl.net', '여성', '2024-06-16');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Danice', 7185, 'Borsnall', '666-556-5138', 'dborsnall1l@amazon.de', '남성', '2025-02-28');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Grissel', 4064, 'Assel', '985-316-6925', 'gassel1m@nbcnews.com', '남성', '2025-01-14');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Rod', 8820, 'Maginot', '793-879-3761', 'rmaginot1n@techcrunch.com', '남성', '2025-04-05');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Saunderson', 2766, 'Leadbitter', '486-279-9616', 'sleadbitter1o@ucoz.com', '남성', '2024-10-22');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Sinclare', 5375, 'Marlen', '674-147-1967', 'smarlen1p@xing.com', '남성', '2024-09-06');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Caritta', 8891, 'Sheerman', '751-253-0186', 'csheerman1q@yahoo.co.jp', '남성', '2024-10-07');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Claus', 4968, 'Boggis', '492-196-2711', 'cboggis1r@hostgator.com', '여성', '2025-01-20');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Allie', 7857, 'Skahill', '784-721-1572', 'askahill1s@canalblog.com', '여성', '2024-09-22');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Darice', 2169, 'Niese', '910-826-9163', 'dniese1t@51.la', '여성', '2024-05-25');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Tabbie', 5107, 'Culham', '926-593-5605', 'tculham1u@multiply.com', '여성', '2024-06-16');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Madelena', 3065, 'Espinha', '911-371-4167', 'mespinha1v@chron.com', '여성', '2024-08-09');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Una', 3757, 'Price', '718-547-9106', 'uprice1w@tinypic.com', '여성', '2025-02-15');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Drusy', 2132, 'Grigaut', '869-525-0323', 'dgrigaut1x@quantcast.com', '남성', '2024-10-11');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Arnuad', 5112, 'Bignell', '586-561-3237', 'abignell1y@comsenz.com', '남성', '2024-11-09');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Tybie', 8185, 'Nanninini', '234-550-4441', 'tnanninini1z@ovh.net', '남성', '2025-01-12');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Nat', 2298, 'Geater', '389-424-7300', 'ngeater20@nytimes.com', '남성', '2024-09-10');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Lynnea', 3278, 'Feaviour', '349-174-6394', 'lfeaviour21@sohu.com', '남성', '2024-07-26');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Samantha', 5647, 'Ewens', '594-537-1852', 'sewens22@forbes.com', '여성', '2025-02-15');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Helaina', 4334, 'Greenshields', '730-975-2789', 'hgreenshields23@theglobeandmail.com', '여성', '2024-11-25');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Delphine', 6130, 'Sivil', '810-866-4468', 'dsivil24@ucla.edu', '남성', '2024-05-18');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Heidie', 2365, 'Ivancevic', '345-145-7485', 'hivancevic25@wikia.com', '남성', '2024-07-13');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Lani', 5788, 'Fawdrie', '826-842-8694', 'lfawdrie26@who.int', '여성', '2024-11-07');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Standford', 3920, 'Hastie', '470-908-7827', 'shastie27@w3.org', '남성', '2024-09-13');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Giorgio', 5541, 'Staten', '408-460-5971', 'gstaten28@guardian.co.uk', '여성', '2024-11-18');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Dorey', 1296, 'Poat', '843-535-5467', 'dpoat29@uiuc.edu', '여성', '2025-02-14');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Trudy', 4600, 'Gallaway', '963-219-8514', 'tgallaway2a@mediafire.com', '여성', '2024-08-03');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Sarah', 9249, 'Wroe', '502-181-3567', 'swroe2b@vinaora.com', '남성', '2025-02-10');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Hillel', 8375, 'Marushak', '715-752-3859', 'hmarushak2c@census.gov', '여성', '2025-04-10');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Noell', 2106, 'Foskett', '371-452-2805', 'nfoskett2d@printfriendly.com', '남성', '2024-09-10');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Franzen', 2516, 'Skewes', '765-567-5679', 'fskewes2e@bbc.co.uk', '여성', '2024-07-26');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Kathleen', 8929, 'Yare', '180-959-5536', 'kyare2f@theatlantic.com', '여성', '2024-05-13');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Felisha', 1823, 'Edser', '461-214-2952', 'fedser2g@cbsnews.com', '여성', '2024-07-15');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Meggy', 5588, 'Claire', '437-295-1019', 'mclaire2h@de.vu', '남성', '2024-06-23');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Bobbi', 4257, 'Dignan', '832-264-2136', 'bdignan2i@guardian.co.uk', '여성', '2024-05-31');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Charleen', 5060, 'Vasenkov', '454-345-4318', 'cvasenkov2j@skyrock.com', '남성', '2025-02-14');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Benjamin', 9998, 'Upshall', '420-804-5860', 'bupshall2k@example.com', '여성', '2024-12-29');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Alysa', 1766, 'Livings', '320-866-7456', 'alivings2l@netscape.com', '여성', '2024-11-24');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Elset', 6818, 'Millions', '135-250-8140', 'emillions2m@godaddy.com', '남성', '2024-07-20');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Hiram', 5760, 'Ralls', '772-179-9383', 'hralls2n@slate.com', '여성', '2025-04-29');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Vito', 5256, 'Witty', '134-557-9742', 'vwitty2o@vinaora.com', '남성', '2025-03-13');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Alvis', 8134, 'Hairs', '260-404-7512', 'ahairs2p@meetup.com', '여성', '2025-03-16');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Sonnie', 6947, 'Semens', '356-507-0249', 'ssemens2q@wix.com', '남성', '2024-11-24');
insert into member (id, pw, name, phone, email, gender, mdate) values ('Lorin', 3024, 'Shires', '696-349-5730', 'lshires2r@salon.com', '남성', '2024-05-04');

select * from member;