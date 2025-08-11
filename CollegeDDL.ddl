-- 생성자 Oracle SQL Developer Data Modeler 24.3.1.347.1153
--   위치:        2025-08-11 12:25:09 KST
--   사이트:      Oracle Database 21c
--   유형:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE lecture (
    lecno     INTEGER NOT NULL,
    lecname   VARCHAR2(20 BYTE) NOT NULL,
    leccredit INTEGER NOT NULL,
    lectime   INTEGER NOT NULL,
    lecclass  VARCHAR2(10 BYTE)
);

ALTER TABLE lecture ADD CONSTRAINT lecture_pk PRIMARY KEY ( lecno );

CREATE TABLE register (
    regstdno      CHAR(8 BYTE) NOT NULL,
    reglecno      INTEGER NOT NULL,
    regmidscore   INTEGER,
    regfinalscore INTEGER,
    regtotalscore INTEGER,
    reggrade      CHAR(1 BYTE)
);

CREATE TABLE student (
    stdno      CHAR(8 BYTE) NOT NULL,
    stdname    VARCHAR2(20) NOT NULL,
    stdhp      CHAR(13 BYTE) NOT NULL,
    stdyear    INTEGER NOT NULL,
    stdaddress VARCHAR2(100 BYTE)
);

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( stdno );

ALTER TABLE student ADD CONSTRAINT student__un UNIQUE ( stdhp );

ALTER TABLE register
    ADD CONSTRAINT register_lecture_fk FOREIGN KEY ( reglecno )
        REFERENCES lecture ( lecno );

ALTER TABLE register
    ADD CONSTRAINT register_student_fk FOREIGN KEY ( regstdno )
        REFERENCES student ( stdno );

INSERT INTO student VALUES ('20201011', '김유신', '010-1234-1001', 3, '경남 김해시');
INSERT INTO student VALUES ('20201122', '김춘추', '010-1234-1002', 3, '경남 경주시');
INSERT INTO student VALUES ('20210213', '장보고', '010-1234-1003', 2, '전남 완도군');
INSERT INTO student VALUES ('20210324', '강감찬', '010-1234-1004', 2, '서울 관악구');
INSERT INTO student VALUES ('20220415', '이순신', '010-1234-1005', 1, '서울 종로구');

INSERT INTO lecture VALUES (101, '컴퓨터과학 개론', 2, 40, '본301');
INSERT INTO lecture VALUES (102, '프로그래밍 언어', 3, 52, '본302');
INSERT INTO lecture VALUES (103, '데이터베이스', 3, 56, '본303');
INSERT INTO lecture VALUES (104, '자료구조', 3, 60, '본304');
INSERT INTO lecture VALUES (105, '운영체제', 3, 52, '본305');

INSERT INTO register VALUES ('20220415', 101, 60, 30, NULL, NULL);
INSERT INTO register VALUES ('20210324', 103, 54, 36, NULL, NULL);
INSERT INTO register VALUES ('20201011', 105, 52, 28, NULL, NULL);
INSERT INTO register VALUES ('20220415', 102, 38, 40, NULL, NULL);
INSERT INTO register VALUES ('20210324', 104, 56, 32, NULL, NULL);
INSERT INTO register VALUES ('20210213', 103, 48, 40, NULL, NULL);

-- 실습 6-9. 다음 데이터를 조회하시오.

-- 이번 학기에 수강신청 하지 않은 학생의 학번, 이름, 연락처, 학년을 조회하시오.
select
    stdNo, stdName, stdHp, stdYear
from student a
left join register b on a.stdNo = b.regstdno
where regStdNo is null;

-- 중간고사 점수와 기말고사 점수의 총합을 구하고 등급을 구하시오.
UPDATE register SET
    regtotalscore = regmidscore + regfinalscore,
    reggrade = CASE
        WHEN (regmidscore + regfinalscore) >= 90 then 'A'
        WHEN (regmidscore + regfinalscore) >= 80 then 'B'
        WHEN (regmidscore + regfinalscore) >= 70 then 'C'
        WHEN (regmidscore + regfinalscore) >= 60 then 'D'
        ELSE 'F'
    END;

select * from register;

-- 2학년 학생의 학번, 이름, 학년, 수강 강좌명, 중간점수, 기말점수, 총합, 등급을 조회하시오.
select
    s.stdNo, s.stdName, s.stdYear, l.lecName, 
    r.regMidScore, r.regFinalScore, r.regTotalscore, r. regGrade
from register r join student s on r.regStdNo = s.stdNo
                join lecture l on r.regLecNo = l.lecNo
where s.stdYear = 2;