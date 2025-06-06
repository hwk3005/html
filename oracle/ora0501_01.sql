-- 복습 (like, count, order by asc/desc
select * from employees;
select * from employees where emp_name like '%n%' order by emp_name desc;
select count(*) from employees where emp_name like '%n%';

select * from stuscore order by rank desc;
select * from stuscore order by kor desc;

-- Q1. 입사일 가장 일찍인 사원순으로 정렬하시오.
-- employees테이블 hire_date 입사일
select hire_date from employees order by hire_date;


---------------------------------------
-- 숫자 함수
-- abs(): 절대값, round(): 반올림, ceil(): 올림, floor():버림, trunc(): 특정자리수를 잘라내기
-- mod(): 입력받은수를 나눈 나머지값 반환, power(m,m): m의 n승을 반환

select -10 from dual;   -- dual 가상테이블
select -10,abs(-10) from dual;
select kor,eng,kor-eng,abs(kor-eng) from stuscore order by kor-eng desc;
-------------------
-- rownum: 조회된 순서대로 순번을 다시 매김
select rownum,name from stuscore;
select rownum,sno,name,total from stuscore where total >=250 and rownum<=10;

-- rownum,테이블명(/별칭).* : rownum 쓸때 테이블명(별칭).* 해야 전체 조회됨
-------------------
-- Q1. stuscore테이블 1~10등까지 학생을 출력하시오.
select rownum,a.* from stuscore a where rank<=10 order by rank;
select rownum,a.* from (select * from stuscore where rank<=10 order by rank) a;
-- Q2. 국어점수 80점 이상인 상위 학생 5명을 출력하시오.
select rownum,a.* from (
select * from stuscore where kor>=80 order by kor desc  -- 테이블
) a where rownum<=5;                                    -- 조건절
----
select sno,a.* from stuscore a where sno<=5;
-- Q3. 국어점수와 영어점수 차이가 가장 큰 10명의 학생을 출력하시오.
select rownum,kor,eng,abs(kor-eng) from (
select kor,eng,abs(kor-eng) ke from stuscore order by ke desc  -- 테이블
) where rownum<=10;


---------------------------------------
-- floor() 버림  - 자릿수 선택 불가, 소수점을 제거
select 12.5, floor(12.5) from dual;

-- ceil() 올림  - 자릿수 선택 불가
select 12.1, ceil(12.1) from dual;

-- round() 반올림  - (m,3): 소수점 3자리까지 표시
select 12.1257, round(12.1257,3) from dual;
select 34.5678, round(35.5678,-1) from dual;

-- trunc() 지정한 자리 버림, 자릿수선택 가능(소수점)
select 34.5678, trunc(34.5678,2), trunc(34.5678,-1) from dual;

-- mod() 나눈 나머지, mod(5.2) 1 -> 5%2
select mod(27,2), mod(27.5), mod(27.7) from dual;
-- Q1. stuscore sno에서 짝수만 출력하시오.
select * from stuscore where mod(sno,2)=0;


---------------------------------------
-- 시퀀스  / 뒤로 back안됨
select stu_seq.nextval from dual;  -- .nextval 번호 증가돼서 나타남
select stu_seq.currval from dual;  -- .currval 번호 확인 (증가x)

-------------------
-- s_seq  (create)
create sequence s_seq
start with 1
increment by 1
minvalue 1
maxvalue 9999
nocache
nocycle
;
select s_seq.nextval from dual;
select s_seq.currval from dual;

-- board_seq  (create)
create table board (
bno number(4) primary key,  -- primary key 기본키(빈공백,중복안된다는뜻)
btitle varchar2(1000),      -- 제목 (varchar2-4000byte)
bcontent clob,              -- clob 대용량 문자 (varchar2(무한대)
id varchar2(100),           -- 회원가입id 연결
bgroup number(4),           -- 답변달기 부모그룹
bstep number(4),            -- 답변달기 순서
bindent number(4),          -- 답변달기 들여쓰기
bhit number(4),             -- 조회수
bfile varchar2(100),        -- 파일첨부
bdate date                  -- 입력날짜
);
-- board_seq  (insert)
insert into board values(
 board_seq.nextval,'게시글을 등록합니다.','홈페이지를 오픈합니다. 많은 이용바랍니다.',
 'aaa',board_seq.currval,0,0,0,'',sysdate
);
insert into board values(
 board_seq.nextval,'이벤트 등록','이벤트를 등록합니다. 꼭 당첨 기대!!',
 'bbb',board_seq.currval,0,0,0,'',sysdate
);
insert into board values(
 board_seq.nextval,'이벤트 등록2','이벤트를 등록합니다. 꼭 당첨 기대!!',
 'ccc',board_seq.currval,0,0,0,'',sysdate
);
insert into board values(
 board_seq.nextval,'이벤트 등록3','이벤트를 등록합니다. 꼭 당첨 기대!!',
 'ddd',board_seq.currval,0,0,0,'',sysdate
);
insert into board values(
 board_seq.nextval,'이벤트 등록4','이벤트를 등록합니다. 꼭 당첨 기대!!',
 'eee',board_seq.currval,0,0,0,'',sysdate
);

select * from board;
commit;


-------------------------------------
select * from stuscore;

insert into stuscore values(
 stuscore_seq.nextval,'이찬영',100,100,99,100+100+99,(100+100+99)/3,0
);
select * from stuscore;
commit;

-------------------------------------
-- 오라클 DB연결 (python)
--delete stuscore where sno in (104,111,112);
--drop table stuscore3;
--drop table stuscore4;


select * from stuscore;

update stuscore set kor=100,total=100+eng+math,avg=(100+eng+math)/3 where sno=105;
rollback;

-- Q1. 이름 김 학생을 검색하시오.
select * from stuscore where name like '%김%';
-- Q2. 이름 순차정렬
select * from stuscore order by name;

-------------------------------------
-- 형변환
-- number, varchar2, char, date
select 1+2 from dual;       -- 숫자: 사칙연산 가능 (숫자+숫자)
select 1+'2' from dual;     -- 문자열 숫자는 자동으로 숫자로 변경됨.
select 1+'a' from dual;     -- 문자: 불가능 (숫자+문자)
select 'a'+'b' from dual;   -- 문자: 불가능 (문자+문자)

select sysdate-1,sysdate,sysdate+1 from dual; -- 날짜: 가능 + -

-------------------------------------
-- 날짜
select hire_date from employees;
select sysdate from dual;
-- 근무일을 알 수 있음 (현재날짜 - 입사일)
select sysdate-hire_date from employees;

select hire_date,round(hire_date),to_char(hire_date,'yyyy-mm-dd hh:mi:ss') from employees;
select bdate_to_char(bdate,'yyyy-mm-dd hh24:mi:ss') from board;

insert into board values (
 board_seq.nextval,'추가 게시글 등록','추가로 게시물을 등록합니다. 당첨부탁드려요.',
 'aaa',board_seq.currval,0,0,0,"",sysdate
);

select * from board;
desc board;
-- 한 주가 시작되는 날짜기준으로 반올림.
select bdate, to_char(bdate,"yyyy-mm-dd hh:mi:ss"),round(bdate,'day') from board;
-- 분을 반올림
select bdate, to_char(bdate,"yyyy-mm-dd hh:mi:ss"),to_char(round(bdate,'mi'),'yyyy-mm-dd hh24:mi:ss') from board;

-- 16일 기준으로 월을 반올림 month
select mdate,to_char,(mdate,'yyyy-mm-dd hh:mi:ss'),round(mdate,'month') from member; 

-- trunc 절사
select mdate,to_char,(mdate,'yyyy-mm-dd hh:mi:ss'),trunc(mdate,'month') from member; 
select mdate,trunc(mdate,'month');

-- 현재일 입사일의 개월수 계산
select emp_name,hire_date,sysdate,months_between(sysdate,hire_date) from employees;
select mdate,sysdate,round(months_between(sysdate,mdate))||'개월' from member;

-- Q. 학생성적이 현재일부터, 등록된 달이 4개월된 학생들을 출력하시오.
select name,mdate,sysdate,round(months_between(sysdate,mdate)) from member
where round(months_between(sysdate,mdate))=4;

substr()
24/07/14
select mdate,substr(to_char(mdate),4,2) from member;

-- 파이썬 substring() a[3:7]  
select name from stuscore;
select emp_name from employees;
-- Q1. emp_name 3,4  3번째부터 4개의 글자를 가지고 와 출력하시오.
select emp_name,substr(emp_name,3,4) from employees;


-----------------------------------------------
-- round 반올림 (달을 기준) - 16일 이상이면 월+1, 16일 미만이면 일을 절사
select mdate from member;
select mdate,round(mdate,'month') from member;
select 1.5,round(1.5),trunc(1.5) from dual;

-- trunc 버림 (달을 기준) 일을 절사
select mdate, trunc(mdate,'month') from member;

-- round 반올림 (년을 기준) round(mdate,'year')
select mdate,round(mdate,'year') from member;

-- months_between (두 날짜 사이의 달수를 계산)
select sysdate,mdate,sysdate-mdate from member;
select sysdate,mdate,trunc(months_between(sysdate,mdate),1) from member;

-- add_months (날짜에 달을 더해줌.)
select sysdate,mdate,add_months(mdate,12)-1 from member;  -- 1년

-- next_day (다음번 요일 찾기)
select sysdate,next_day(sysdate,'화요일') from dual;

-- last_day (마지막 날 찾기)
select sysdate,last_day(sysdate) from dual;
select mdate,last_day(mdate) from member;
-- Q1. employees hire_date 마지막 날 찾기
select hire_date,last_day(hire_date) from employees;

--------------------------------------------
-- 형변환 함수
--to_char   날짜형 or 숫자형을 문자형으로
--to_date   문자형을           날짜형으로
--to_number 문자형을           숫자형으로

---------------------------
-- To_char 날짜를 문자타입으로 변경
select sysdate, to_char(sysdate,'yyyy') from dual;
select sysdate, to_number(to_char(sysdate,'mm')) from dual;
-- Q1. member테이블에서 5,6,7월 회원가입한 회원을 출력하시오.
select mdate from member where to_char(mdate,'mm') in('05','06','07') order by mdate ;
-- Q2. employees테이블에서 hire_date 5,6,7월에 입사한 사원을 출력하시오.
select hire_date,to_char(hire_date,'mm') mm from employees
where to_char(hire_date,'mm') in('05','06','07') order by mm;

-- mm 숫자월 / mon 영문,한글월 / day 요일
select sysdate,to_char(sysdate,'mon') from dual;
select mdate,to_char(mdate,'mon') from member;
select mdate,to_char(mdate,'day') from member;
-- Q1. 일요일에 가입한 사람을 출력하시오.
select mdate,to_char(mdate,'day') from member where to_char(mdate,'day')='일요일';
-- hh: 02시 / hh24: 14시 / am/pm: 오전/오후 
select bdate,to_char(bdate,'yyyy-mm-dd pm:mi:ss') from board;

---------------------------
-- To_char 숫자를 문자타입으로 변경
-- L국가통화표시, $달러표시,  .천단위표시, 0 빈자리0표시, 9 빈자리공백표시
select 12300000, to_char(123000000,'$000,999,999,999.999') from dual;
-- Q1. salary 달러표시, 1438원 곱해서 원화표시와 천단위 표시, 소수점2자리 넣어 출력하시오.
select salary,to_char(salary,'$999,999,999'),to_char(salary*1438,'l999,999,999.99')||'원' from employees;

---------------------------
--To_date 날짜형 타입으로 변환
select 20221231,to_date(20221231,'yyyy-mm-dd') from dual;       -- 숫자형-> 날짜형 타입 변환
select '20221231',to_date('20221231','yyyy-mm-dd') from dual;   -- 문자형-> 날짜형 타입 변환
select '20221231'-1,add_months(to_date('20221231','yyyy-mm-dd'),3) from dual;
-- Q1. '09/01/01' 날짜타입으로 변경해서, 현재날짜기준으로 몇개월이 지났는지 출력하시오.
select sysdate,'09/01/01',months_between(sysdate,'09/01/01')||'개월' from dual;
-- ㄴ 'yy/mm/dd'/'yy-mm-dd'문자형이더라도 날짜타입으로 자동인식?함 (to_date 사용 안 해도 날짜타입 적용됨)

---------------------------
-- To_number 숫자형 타입으로 변환
select to_number('20,000','999,999')-1 from dual;  -- 문자형-> 숫자형 타입으로 변환

-- replace() 특정문자를 대체할 때 사용
select '***,111',replace('***,111','*','0') from dual;  -- *을 0으로 대체
select '20,000',replace('20,000',',','') from dual;     -- ,천단위표시를 없앰 (빈칸으로 둠)
select '20,000',replace('20,000',',','')-1 from dual;

-- trim() 바깥부분의 공백만 제거
select '   123111 111 111   ' from dual;
select trim('   123111 111 111   ')-1 from dual;
select replace('   123111 111 111   ',' ','')-1 from dual;

---------------------------
-- 형변환 함수
--to_char()   문자변환: 숫자를 문자로 변경해서 천단위, 0표시, 통화표시
--to_date()   날짜변환: 문자,숫자를 날짜로 변경, 날짜형태 +,- 날짜함수 사용해서 계산
--to_number() 숫자변환: 천단위 표시된 문자를 숫자변환해서 사칙연산 할 수 있는 장점

---------------------------
-- commission_pct 커미션 부분 월급 * 커미션을 더해서 계산
select salary, commission_pct, salary+salary*nvl(commission_pct,0) "실제월급" from employees;
---------------
select manager_id from employees;
-- 10 null
-- ceo null ceo
null 0
select manager_id,nvl(manager_id,0),nvl(to_char(manager_id,'ceo') from employees;
desc employees;


---------------------------
-- 그룹함수 max min median sum avg variance stddev count
select max(salary) from employees;
select min(salary) from employees;
select sum(salary) from employees;
select avg(salary) from employees;
select count(salary) from employees;
select median(salary) from employees;
select count(*) from employees where salary>=(select avg(salary) from employees);

-- 그룹함수는 단일컬럼과 함께 사용할 수 없음.
select emp_name,avg(salary) from employees;  -- 불가능

select min(salary) from employees;
select * from employees where salary=2100;
select * from employees where salary=(select min(salary) from employees);

select max(salary),min(salary),sum(salary),avg(salary),count(salary) from employees;  -- 가능
-- Q1. 부서번호가 50번인 사원들의 합계를 구하시오.
select sum(salary),count(salary),avg(salary) from employees where department_id=50;

-- 그룹함수 경우 - null 제외됨
select count(*) from employees;  -- 107명
select count(manager_id) from employees;  -- 106명 (그룹함수)

select manager_id from employees where manager_id is null;
select count(*) from employees where manager_id is null;


-----------------------------------------------
-- 문자열 함수
-- initcap, lower, upper
select emp_name from employees;
select emp_name,upper(emp_name),lower(emp_name),initcap(emp_name) from employees;
select name from member;

-- lpad, rpad 자리수만큼 특정문자로 대체
select kor, lpad(kor,10,'0') from stuscore;

-- trim, ltrim, rtrim 빈공백 제거
select '    aaa   aaa   ',
    ltrim('   aaa aaa   '),
    rtrim('   aaa   aaa   '),
    trim('   aaa aaa   ')
    from dual;

-- substr() 해당하는 만큼 문자열을 분리해서 가져옴.
select name from stuscore;
select substr(name,2,2) from stuscore;  -- 2번째 자리에서 2개 가져오기 (이름)
select substr(name,0,1) from stuscore;  -- 0번째 자리에서 1개 가져오기 (성)

-- replace 문자열 대체
select '111222333aaa', replace('111222333aaa','a','0') from dual;

-- length 문자열 길이
select kor from stuscore;
select length(kor) from stuscore;
select max(length(name)) from stuscore;
-- Q1. 이름 가져오는 마지막 글자만 제외 후 출력하시오.
select substr(name,0,length(name)-1) from stuscore;  -- substr, length 활용한 응용문제

-- Q풀이. length 응용
create table test (
  ch1 char(30),
  ch2 varchar(30)
);
insert into test values(
  '12345','12345'
);
commit;
select * from test;
select length(ch1),length(ch2) from test;

-------------------
-- 날짜함수
-- Q1. 달의 첫일, mdate, 마지막일을 출력하시오.
select mdate from member;
select trunc(mdate,'month'), mdate, last_day(mdate) from member;
-- 02. 월만 뽑아내기
select mdate, to_char(mdate,'mm') from member where to_char(mdate,'mm')='07';

-- Q3. 아래와 같이 출력하시오.
-- name   mdate
-- 홍길동 가입일: 2024년 07월 14일 화요일
select * from member;
select name,to_char(mdate,'"가입일: "yyyy"년" mm"월" dd"일" day') from member;



--- END ---
