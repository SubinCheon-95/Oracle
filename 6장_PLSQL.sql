-- 실습하기 1-1. Hello, Oracle 출력
SET SERVEROUTPUT ON; -- 실행 결과를 콘솔에 출력

BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello Oracle!');
END;
/

-- 실습하기 1-2. 주석 처리하기
DECLARE
    NO   NUMBER(4)     := 1001;
    NAME VARCHAR2(10)  := '홍길동';
    HP   CHAR(13)      := '010-1000-1001';
    ADDR VARCHAR2(100) := '부산광역시';
BEGIN
    DBMS_OUTPUT.PUT_LINE('번호 : ' || NO);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('전화 : ' || HP);
    DBMS_OUTPUT.PUT_LINE('주소 : ' || ADDR);
END;
/

-- 실습하기 2-1. 변수 선언 및 변수값 출력
SET SERVEROUTPUT ON;

DECLARE
    NO   CONSTANT NUMBER(4):= 1001;
    NAME VARCHAR2(10);
    HP   CHAR(13)          := '000-0000-0000';
    AGE  NUMBER(2) DEFAULT 1;
    ADDR VARCHAR2(100)     := '부산';
BEGIN
    NAME := '김유신';
    HP   := '010-1000-1001';
    DBMS_OUTPUT.PUT_LINE('번호 : ' || NO);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('전화 : ' || HP);
    DBMS_OUTPUT.PUT_LINE('나이 : ' || AGE);
    DBMS_OUTPUT.PUT_LINE('주소 : ' || ADDR);
END;
/

-- 실습하기 2-2. 열 참조형 변수 실습
DECLARE
    NO   DEPT.DEPTNO%TYPE;
    NAME DEPT.DNAME%TYPE;
    DTEL DEPT.DTEL%TYPE;
BEGIN
    SELECT * INTO NO, NAME, DTEL
    FROM  DEPT
    WHERE DEPTNO = 30;
    
    DBMS_OUTPUT.PUT_LINE('부서번호 : ' || NO);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('전화번호 : ' || DTEL);
END;
/

-- 실습하기 2-3. 행 참조형 변수 실습
DECLARE
    -- 선언
    ROW_DEPT DEPT%ROWTYPE;
BEGIN
    -- 처리
    SELECT *
    INTO  ROW_DEPT
    FROM  DEPT
    WHERE DEPTNO = 40;
    
    -- 출력
    DBMS_OUTPUT.PUT_LINE('부서번호 : ' || ROW_DEPT.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || ROW_DEPT.DNAME);
    DBMS_OUTPUT.PUT_LINE('전화번호 : ' || ROW_DEPT.DTEL);
END;
/

-- 실습하기 2-4. 레코드 자료형 기본 실습
DECLARE

    TYPE   REC_DEPT IS RECORD (
    DEPTNO NUMBER(2),
    DNAME  DEPT.DNAME%TYPE,
    DTEL   DEPT.DTEL%TYPE
    );
    
    DEPT_REC REC_DEPT;
BEGIN
    DEPT_REC.DEPTNO := 10;
    DEPT_REC.DNAME  := '개발부';
    DEPT_REC.DTEL   := '051-512-1010';
    
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || DEPT_REC.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || DEPT_REC.DNAME);
    DBMS_OUTPUT.PUT_LINE('DTEL : ' || DEPT_REC.DTEL);
    
END;
/

-- 실습하기 2-5. 레코드 사용한 INSERT 실습
CREATE TABLE DEPT_RECORD AS SELECT * FROM DEPT WHERE 1 = 0;

DECLARE
    TYPE REC_DEPT IS RECORD (
         DEPTNO NUMBER(2),
         DNAME  DEPT.DNAME%TYPE,
         DTEL   DEPT.DTEL%TYPE
    );
    dept_rec REC_DEPT;
BEGIN
    dept_rec.DEPTNO := 10;
    dept_rec.DNAME := '개발부';
    dept_rec.DTEL := '051-512-1010';
    
    INSERT INTO DEPT_RECORD VALUES dept_rec;
    
    DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;
/

---------------- 정리 중 ----------------
-- 실습하기 2-6. 레코드를 포함하는 레코드 실습
DECLARE
    TYPE REC_DEPT IS RECORD (
        DEPTNO DEPT.DEPTNO%TYPE,
        DNAME  DEPT.DNAME%TYPE,
        DTEL   DEPT.DTEL%TYPE
    );
    TYPE REC_EMP IS RECORD (
        EMPNO   EMP.EMPNO%TYPE,
        NAME    EMP.NAME%TYPE,
        REGDATE EMP.REGDATE%TYPE
    );
    emp_rec REC_EMP;
BEGIN
    SELECT E.EMPNO, E.NAME, D.DEPTNO, D.DNAME, D.DTEL
    INTO
        EMP_REC.EMPNO,
        EMP_REC.NAME,
        EMP_REC.REGDATE.DEPTNO,
        EMP_REC.REGDATE.DNAME,
        EMP_REC.REGDATE.DTEL
    FROM EMP E, DEPT D
    WHERE E.EMPNO = D.DEPTNO AND E.EMPNO = 7788;
    
    DBMS_OUTPUT.PUT_LINE('EMPNO  : ' || EMP_REC.EMPNO);
    DBMS_OUTPUT.PUT_LINE('NAME   : ' || EMP_REC.NAME);
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || EMP_REC.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME  : ' || EMP_REC.DNAME);
    DBMS_OUTPUT.PUT_LINE('DTEL   : ' || EMP_REC.DTEL);
    
    DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;
/

---------------- 정리 중 ----------------
        
-- 실습하기 2-7. 테이블(연관배열) 기본 실습
DECLARE
    TYPE ARR_CITY IS TABLE OF VARCHAR2(20) INDEX BY PLS_INTEGER;
    arrCity ARR_CITY;
BEGIN
    arrCity(1) := '서울';
    arrCity(2) := '대전';
    arrCity(3) := '대구';
 
    DBMS_OUTPUT.PUT_LINE('arrCity(1) : ' || arrCity(1));
    DBMS_OUTPUT.PUT_LINE('arrCity(2) : ' || arrCity(2));
    DBMS_OUTPUT.PUT_LINE('arrCity(3) : ' || arrCity(3));
END;
/
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
-- 실습하기 4-1. 단일 행 결과를 처리하는 커서 사용
DECLARE
    -- 커서 데이터를 저장할 변수 선언
    V_DEPT_ROW DEPT%ROWTYPE;
    
    -- 커서 선언
    CURSOR c1 IS SELECT * FROM DEPT WHERE DEPTNO = 40;
BEGIN
    -- 커서 열기
    OPEN c1;
    
    -- 커서 데이터 입력
    FETCH c1 INTO V_DEPT_ROW;
    
    -- 커서 데이터 출력
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPTNO_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPTNO_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('DTEL : ' || V_DEPTNO_ROW.DTEL);
    
    CLOSE c1;
END;
/

-- 실습하기 4-2. 여러 행 결과를 처리하는 커서 사용(LOOP)
DECLARE
    V_EMP_ROW EMP%ROWTYPE;
    CURSOR emp_cursor IS SELECT * FROM EMP;
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO V_EMP_ROW;
        
        EXIT WHEN emp_cursor%NOTFOUND;

    DBMS_OUTPUT.PUT_LINE('------------------------------');
    DBMS_OUTPUT.PUT_LINE('EMPNO : ' || V_EMP_ROW.EMPNO);
    DBMS_OUTPUT.PUT_LINE('NAME : ' || V_EMP_ROW.NAME);
    DBMS_OUTPUT.PUT_LINE('REGDATE: ' || V_EMP_ROW.REGDATE);
    END LOOP;
END;
/

-- 실습하기 4-3. 여러 행 결과를 처리하는 커서 사용(FOR)
DECLARE
    CURSOR c1 IS SELECT * FROM DEPT;
BEGIN
    FOR c1_rec IN c1 LOOP
   
    DBMS_OUTPUT.PUT_LINE('------------------------------');
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || c1_rec.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || c1_rec.DNAME);
    DBMS_OUTPUT.PUT_LINE('DTEL : ' || c1_rec.DTEL);
    END LOOP;
END;
/

-- 실습하기 5-1. 이름으로 환영 메시지 출력하는 간단한 프로시저 실습
CREATE PROCEDURE hello_procedure (
p_name IN VARCHAR2
)
IS
BEGIN
DBMS_OUTPUT.PUT_LINE('안녕하세요, ' || p_name || '님!');
DBMS_OUTPUT.PUT_LINE('환영합니다.');
END;
/

-- 프로시저 실행1
EXECUTE hello_procedure('홍길동');
EXECUTE hello_procedure('김철수');

DROP PROCEDURE hello_procedure;

-- 실습하기 5-2. 사원 번호를 입력받아 사원 이름을 반환하는 함수 실습
CREATE FUNCTION get_emp_name (p_empno NUMBER) RETURN VARCHAR2
IS
    v_ename VARCHAR2(20);
BEGIN
    SELECT NAME INTO v_ename FROM EMP WHERE EMPNO = p_empno;
    RETURN v_ename;
END;
/

DROP FUNCTION GET_EMP_NAME;

-- 실습하기 5-3. 제목
-- 로그 테이블 생성
CREATE TABLE emp_log (
    log_date date,
    empno number,
    action varchar(10)
);

-- 트리거 생성
CREATE TRIGGER trgg_emp_insert
AFTER INSERT ON emp
FOR EACH ROW
BEGIN
    INSERT INTO emp_log (log_date, empno, action)
    VALUES (sysdate, :NEW.empno, 'INSERT');
END;
/

INSERT INTO emp
    VALUES (2002, '김춘추', 'M', '대리', 10, SYSDATE);
