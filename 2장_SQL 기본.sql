/*
    날짜 : 2025/07/14
    이름 : 천수빈
    내용 : 2장 SQL 기본
*/

// 실습하기 1-2. NUMBER 자료형 이해
CREATE TABLE TYPE_TEST_NUMBER (
    num1 NUMBER,
    num2 NUMBER(2),
    num3 NUMBER(3,1),
    num4 NUMBER(4,2),
    num5 NUMBER(5,6),
    num6 NUMBER(6,-1)
);

// num1 NUMBER
INSERT INTO TYPE_TEST_NUMBER (num1) VALUES (1);
INSERT INTO TYPE_TEST_NUMBER (num1) VALUES (123);
INSERT INTO TYPE_TEST_NUMBER (num1) VALUES (123.74);
INSERT INTO TYPE_TEST_NUMBER (num1) VALUES (123.12345);

// num2 NUMBER(2)
INSERT INTO TYPE_TEST_NUMBER (num2) VALUES (12);
INSERT INTO TYPE_TEST_NUMBER (num2) VALUES (123);
INSERT INTO TYPE_TEST_NUMBER (num2) VALUES (1.2);
INSERT INTO TYPE_TEST_NUMBER (num2) VALUES (1.23);
INSERT INTO TYPE_TEST_NUMBER (num2) VALUES (12.34567);
INSERT INTO TYPE_TEST_NUMBER (num2) VALUES (12.56789);
INSERT INTO TYPE_TEST_NUMBER (num2) VALUES (123.56789);

// num3 NUMBER(3,1)
INSERT INTO TYPE_TEST_NUMBER (num3) VALUES (12);
INSERT INTO TYPE_TEST_NUMBER (num3) VALUES (123);
INSERT INTO TYPE_TEST_NUMBER (num3) VALUES (12.1);
INSERT INTO TYPE_TEST_NUMBER (num3) VALUES (12.1234);
INSERT INTO TYPE_TEST_NUMBER (num3) VALUES (12.56789);
INSERT INTO TYPE_TEST_NUMBER (num3) VALUES (123.56789);

----------------------------------------------------------------

// 실습하기 1-3. 문자형 자료형 이해

CREATE TABLE TYPE_TEST_CHAR (
    char1   CHAR(1), // char 은 1byte
    char2   CHAR(2),
    char3   CHAR(3),
    vchar1  VARCHAR2(1),
    vchar2  VARCHAR2(2),
    vchar3  VARCHAR2(3),
    nvchar1 NVARCHAR2(1),
    nvchar2 NVARCHAR2(2),
    nvchar3 NVARCHAR2(3)
);

// CHAR
INSERT INTO TYPE_TEST_CHAR (char1) VALUES ('A'); // 영문/숫자는 1Byte
INSERT INTO TYPE_TEST_CHAR (char3) VALUES ('가'); // 한글은 3Byte

// VARCHAR2
INSERT INTO TYPE_TEST_CHAR (vchar1) VALUES ('A');
INSERT INTO TYPE_TEST_CHAR (vchar2) VALUES ('AB');
INSERT INTO TYPE_TEST_CHAR (vchar3) VALUES ('가');

// NVARCHAR2
INSERT INTO TYPE_TEST_CHAR (nvchar1) VALUES ('A');
INSERT INTO TYPE_TEST_CHAR (nvchar2) VALUES ('AB');
INSERT INTO TYPE_TEST_CHAR (nvchar3) VALUES ('가나다');
// NVARCHAR2 에서만 한글(UTF-8) 1Byte

----------------------------------------------------------------

// 실습하기 1-4. 테이블 생성 및 삭제

// 테이블 생성
CREATE TABLE USER1 (
    USER_ID VARCHAR2(20),
    NAME    VARCHAR2(20),
    HP      CHAR(13),
    AGE     number
);

// 테이블 제거
DROP TABLE USER1;

----------------------------------------------------------------

// 실습하기 1-5. 데이터 추가(INSERT)

INSERT INTO USER1 VALUES ('A101', '김유신', '010-1234-1111', 25);
INSERT INTO USER1 VALUES ('A102', '김춘추', '010-1234-2222', 23);
INSERT INTO USER1 VALUES ('A103', '장보고', '010-1234-3333', 32);
INSERT INTO USER1 (user_id, name, age) VALUES ('A104', '강감찬', 45);
INSERT INTO USER1 (user_id, name, hp) VALUES ('A105', '이순신', '010-1234-5555');

----------------------------------------------------------------

// 실습하기 1-6. 데이터 조회(SELECT)

SELECT * FROM USER1;
SELECT * FROM USER1 WHERE USER_ID = 'A101';
SELECT * FROM USER1 WHERE NAME = '김춘추';
SELECT * FROM USER1 WHERE AGE > 30;

SELECT USER_ID, NAME, AGE FROM USER1;

----------------------------------------------------------------

// 실습하기 1-7. 데이터 수정(UPDATE)

UPDATE USER1 SET 
                HP='010-1234-4444' WHERE USER_ID = 'A104';
UPDATE USER1 SET
                AGE = 51 WHERE USER_ID = 'A105';
UPDATE USER1 SET
                HP = '010-1234-1001',
                AGE = 27 WHERE USER_ID = 'A101';

----------------------------------------------------------------

// 실습하기 1-8. 데이터 삭제(DELETE)

DELETE FROM USER1 WHERE USER_ID = 'A101';
DELETE FROM USER1 WHERE USER_ID = 'A102' AND AGE = 25;
DELETE FROM USER1 WHERE AGE >= 30;

----------------------------------------------------------------

// 2. 제약 조건

// 실습하기 2-1. 기본키(PRIMARY KEY)

CREATE TABLE USER2 (
    USER_ID VARCHAR2(20) PRIMARY KEY,
    NAME    VARCHAR2(20),
    HP      CHAR(13),
    AGE     NUMBER(2)
);

-- PRIMARY KEY(기본키) 컬럼은 중복 안됨
INSERT INTO USER2 VALUES ('A101', '김유신', '010-1234-1111', 23);
INSERT INTO USER2 VALUES ('A102', '김춘추', '010-1234-2222', 21);

----------------------------------------------------------------

// 실습하기 2-2. 고유키(UNUQUE)

CREATE TABLE USER3 (
    USER_ID VARCHAR(20) PRIMARY KEY,
    NAME    VARCHAR(20),
    HP      CHAR(13) UNIQUE,
    AGE     NUMBER(3)
);

INSERT INTO USER3 VALUES ('A101', '김유신', '010-1234-1111', 23);
INSERT INTO USER3 VALUES ('A102', '김춘추', '010-1234-2222', 21);