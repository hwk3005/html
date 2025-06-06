--------------------------------------------------------
--  파일이 생성됨 - 목요일-5월-08-2025   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table SCOREGRADE
--------------------------------------------------------

  CREATE TABLE "ORA_USER"."SCOREGRADE" 
   (	"GRADE" CHAR(1 BYTE), 
	"MINSCORE" NUMBER(3,0), 
	"MAXSCORE" NUMBER(6,3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into ORA_USER.SCOREGRADE
SET DEFINE OFF;
Insert into ORA_USER.SCOREGRADE (GRADE,MINSCORE,MAXSCORE) values ('F',0,59.999);
Insert into ORA_USER.SCOREGRADE (GRADE,MINSCORE,MAXSCORE) values ('D',60,69.999);
Insert into ORA_USER.SCOREGRADE (GRADE,MINSCORE,MAXSCORE) values ('C',70,79.999);
Insert into ORA_USER.SCOREGRADE (GRADE,MINSCORE,MAXSCORE) values ('B',80,89.999);
Insert into ORA_USER.SCOREGRADE (GRADE,MINSCORE,MAXSCORE) values ('A',90,100);
