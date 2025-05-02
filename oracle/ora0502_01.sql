--- < 복습 >

-- Q1. 현재일에서 이달의 최초일, 이달의 마지막일을 출력하시오.
select sysdate from dual;
select trunc(sysdate,'month'),sysdate,last_day(sysdate) from dual;

select * from stuscore;
select * from stuscore where avg>=80 and rownum<=5 order by avg desc;
-- rownum: 검색된 것에 일련번호를 (새롭게)다시 붙이는 것을 말함.
select rownum,stuscore.* from stuscore where kor>=80;
select rownum,stuscore.* from stuscore where name like '%s%';

-- Q2. 국어점수와 영어점수 차이가 가장 큰 10명의 학생을 rownum을 붙여서 출력하시오.
select rownum,a.* from (
select kor,eng,kor-eng,abs(kor-eng) ke from stuscore order by ke desc) a 
where rownum<=10
;

--- 숫자함수 복습
-- min 급여 가장 낮은 사원 검색
select min(salary), max(salary), avg(salary),count(salary), sum(salary) from employees;


-------------------------
--- 날짜함수 복습

-- Q1. 년,월,일,시,분,초 요일  to_char
select sysdate,to_char(sysdate,'yyyy-mm-dd am hh:mi:ss day') from dual;
select next_day(sysdate,'금요일') from dual;

-- Q2. 현재 날짜에서 3일 전의 날짜, 3달 전의 날짜를 출력하시오.
select sysdate-3, sysdate, add_months(sysdate,-3) from dual;

-- Q3. 좋은나라만 substr 사용해서 출력하시오. - ABC좋은나라DEF
select 'ABC좋은나라DEF',substr('ABC좋은나라DEF',4,4) from dual;

-- Q4. 월만 분리해서 출력하고, 05,06,07인 회원만 출력하시오.
select mdate from member;
select mdate,substr(mdate,4,2) from member
 where substr(mdate,4,2) in (05,06,07) order by substr(mdate,4,2);


-----------------------------
--- DDL, DML 테이블 생성, 수정 관련
desc stuscore;
create table stuscore3(
sno number(4),
name varchar2(100),
KOR NUMBER(3),
ENG NUMBER(3),
MATH NUMBER(3),
TOTAL NUMBER(3),
AVG NUMBER(3),
RANK NUMBER(3)
);

-- 1. 기존테이블이 존재시 데이터 모두 복사
select * from stuscore3;
insert into stuscore3 select * from stuscore;

-- 2. 테이블과 함께 데이터를 모두 복사
create table stuscore4 as select * from stuscore;
select * from stuscore4;

-- 3. 컬럼이 다른 경우, 컬럼을 부여한 후 데이터 모두 복사
insert into stuscore5(sno,name,kor,eng,math) select sno,name,kor,eng,math from stuscore;
desc stuscore5;
select * from stuscore5;

create table stuscore5(
sno number(4),
name varchar2(100),
KOR NUMBER(3),
ENG NUMBER(3),
MATH NUMBER(3)
);

-- 컬럼 추가  add
alter table stuscore5 add total number(3);
-- 컬럼 삭제  drop
--alter table stuscore5 drop column total;
-- 기존에 들어가 있는 데이터 3자리가 있는데, 2자리 변경을 하려고 하면 변경되지 않음.

-- 컬럼 변경 -타입변경  modify
alter table stuscore5 modify total number(3);
-- 컬럼 변경 -이름변경  rename
alter table stuscore5 rename column total to tot;

-- 테이블명 변경
alter table stuscore2 rename to stu2;
alter table stu2 rename to stuscore2;

desc stuscore5;

-- 컬럼 순서 변경  invisible / visible
alter table stuscore5 modify name invisible;
alter table stuscore5 modify kor invisible;
alter table stuscore5 modify eng invisible;
alter table stuscore5 modify math invisible;

alter table stuscore5 modify name visible;
alter table stuscore5 modify kor visible;
alter table stuscore5 modify eng visible;
alter table stuscore5 modify math visible;

select * from stuscore5;

commit;

--drop table stuscore3;
--drop table stuscore4;
--drop table stuscore5;


--------------------------------------------
--- 무결성 제약 조건

-- 풀이
create table mem(
    id varchar2(30) primary key, -- null X / 중복 X
    name varchar2(100) not null, -- null X / 중복 O
    phone varchar2(20) unique,   -- null O / 중복 X
    gender nchar(2) check(gender in ('남성','여성')),
    kor number(3) check(kor between 0 and 100)
);

insert into mem values(
'aaa','홍길동','010-1111','남성',100
);
insert into mem values(
'bbb','유관순',null,'여성',99
);
insert into mem values(
'ccc','유관순',null,'여성',99
);
insert into mem values(
'ddd','이순신',null,'남성',100
);
insert into mem values(
'eee','이순신',010-2222,'남성',100
);
commit;
select * from mem;


--테이블 mem 테이블 primary key id
--constraint 별칭(fk_score_id) foreign key(현재테이블의 컬럼) references pk테이블(컬럼)
constraint fk_score_id foreign key(id) references mem(id)

-- ### 기본키 설정
sno number(4) primary key

--기본키 삭제
alter table score drop constraint SYS_C008355;

--기본키 설정
alter table score add constraint pk_score_sno primary key(sno);


-- ### 외래키 설정
create table score (
 sno number(4) primary key,
 id varchar2(30),
 kor number(3),
 constraint fk_score_id foreign key(id) references mem(id) -- 외래키 등록
);




--기본키 : 중복 X, null X
--외래키 : 기본키없는 데이터를 입력하면 입력이 되지 않게 함.

-- 외래키 조건 등록
alter table score add constraint fk_score_id foreign key(id) references mem(id);

-- 외래키 조건 삭제
alter table score drop constraint fk_score_id;

select * from mem;
 
insert into score values (1,'aaa',100 ); 
insert into score values (2,'bbb',90 );
insert into score values (3,'bb2',90 );

select * from score;

--delete score where sno=2;
commit;

select * from mem;

--delete mem where id='bbb';


------------------------------------------------
-- 조인 join

select * from employees;
select department_id from employees;
cross join -- 테이블 2개 선택해서 출력 
--컬럼수 (13 + 6) = 19개 
--데이터 개수 107 * 27 = 2889개
select * from employees,departments;
select * from departments;

desc employees; -- 13
desc departments; -- 6

------------------
-- equi join: 같은 컬럼을 가지고 조인
-- 풀이1.
select emp_name,a.department_id,department_name,salary 
from employees a,departments b
where a.department_id = b.department_id
;

------------
-- 풀이2.
select * from member;
select * from stuscore;

select id,gender,phone,a.name,sno,total,avg,rank
from member a,stuscore b
where  a.name = b.name
;

------------
-- 풀이3.
select emp_name, a.department_id,department_name,salary, a.job_id,min_salary,max_salary
from employees a,jobs b,departments c
where a.job_id = b.job_id and a.department_id = c.department_id
;

select min_salary,max_salary from jobs;

------------
-- 풀이4.
desc board;
select * from board;

alter table board add bfile3 varchar2(100);

alter table board modify bdate invisible;
alter table board modify bdate visible;
desc board;
select * from board;
create table bfile(
bno number(4),
bfile varchar2(100)
);

insert into bfile values(
1,'1.jpg'
);
insert into bfile values(
4,'d1.jpg'
);
commit;

select * from bfile;

----
select * from board a, bfile b
where a.bno = b.bno
;

alter table board drop column bfile;
alter table board drop column bfile2;
alter table board drop column bfile3;

desc board;


select * from board a,bfile b where a.bno=b.bno and a.bno=1;

select * from board where bno=1;
select * from bfile where bno=1;

select department_id,department_name from departments;


---------
select * from board;
-- bno,btitle,bcontent,id,bgroup,bstep,bindent,bhit bdate
bno: board_seq.nextval
bgroup : board_seq.currval
bdate : sysdate

insert into board values ( 
board_seq.nextval,'2번째 게시글','파이썬에서 글쓰기 테스트','aaa',board_seq.currval,
0,0,0,sysdate
)
;

commit;

select * from bfile;
select * from board;
desc board;


--------------------------------------
---- cross join -> equi join, non-equi join, inner join, outer join

-- non-equi join
create table scoreGrade(
grade char(1),
minscore number(3),
maxscore number(3)
);

insert into scoregrade values ('F',0,59);
insert into scoregrade values ('D',60,69);
insert into scoregrade values ('C',70,79);
insert into scoregrade values ('B',80,89);
insert into scoregrade values ('A',90,100);

select * from scoregrade;
commit;


select * from scoregrade;
select * from stuscore;
--stuscore 테이블 avg가지고 scoregrade 테이블의 grade를 출력할 수 있게 구성
select sno,name,avg,grade
from stuscore,scoregrade
where avg between minscore and maxscore
;

select department_id,sum(salary) from employees;
group by department_id;

--28,17,15,30,45,49,37,35,32,12,19,27
-- Q1. 생일 나이로 환산해서 출력하시오.
select hire_date from employees;

select trunc(to_char(sysdate,'yyyy') - to_char(hire_date,'yyyy'),-1) tyear, count(*)
from employees
group by trunc(to_char(sysdate,'yyyy') - to_char(hire_date,'yyyy'),-1);

-- Q2. 부서별 평균 월급을 출력하시오.
select a.department_id, department_name,round(avg(salary),2)
from employees a,departments b
where a.department_id = b.department_id
group by a.department_id, department_name
;


