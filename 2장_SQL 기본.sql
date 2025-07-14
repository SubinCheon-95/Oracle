/*
    날짜 : 2025/07/14
    이름 : 천수빈
    내용 : 2장 SQL 기본
*/

-- 실습 1-2. NUMBER 자료형 이해
CREATE TABLE TYPE_TEST_NUMBER (
    num1 NUMBER,
    num2 NUMBER(2),
    num3 NUMBER(3, 1),
    num4 NUMBER(4, 2),
    num5 NUMBER(5, 6),
    num6 NUMBER(6, -1)
);

//num1 NUMBER
INSERT INTO TYPE_TEST_NUMBER (num1) VALUES (1);