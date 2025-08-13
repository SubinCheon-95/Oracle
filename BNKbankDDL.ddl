/*
    날짜 : 2025/08/13
    이름 : 천수빈
    내용 : SQL(Oracle DBMS) 수행평가
*/

CREATE TABLE account (
    acc_id            CHAR(14 BYTE) NOT NULL,
    cust_jumin        CHAR(14 BYTE),
    acc_type          VARCHAR2(20 BYTE) NOT NULL,
    acc_balance       NUMBER NOT NULL,
    acc_card          CHAR(1 BYTE) NOT NULL,
    acc_register_date DATE
);

ALTER TABLE account ADD CONSTRAINT account_pk PRIMARY KEY ( acc_id );

CREATE TABLE card (
    card_no            CHAR(14 BYTE) NOT NULL,
    cust_jumin         CHAR(14 BYTE),
    acc_id             CHAR(14 BYTE),
    card_register_date DATE,
    card_limit         NUMBER,
    card_approve_date  DATE,
    card_type          VARCHAR2(10 BYTE) NOT NULL
);

ALTER TABLE card ADD CONSTRAINT card_pk PRIMARY KEY ( card_no );

CREATE TABLE customer (
    cust_jumin CHAR(14 BYTE) NOT NULL,
    name       VARCHAR2(20 BYTE) NOT NULL,
    address    VARCHAR2(100 BYTE) NOT NULL,
    birth      CHAR(10 BYTE) NOT NULL,
    email      VARCHAR2(100 BYTE),
    hp         VARCHAR2(20 BYTE) NOT NULL,
    job        VARCHAR2(20 BYTE)
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( cust_jumin );

ALTER TABLE customer ADD CONSTRAINT customer__un UNIQUE ( email,
                                                          hp );

CREATE TABLE transaction (
    trans_id      NUMBER NOT NULL,
    trans_acc_id  CHAR(14 BYTE) NOT NULL,
    trans_type    VARCHAR2(20 BYTE),
    trans_message VARCHAR2(20 BYTE),
    trans_money   NUMBER,
    trans_date    DATE NOT NULL
);

ALTER TABLE transaction ADD CONSTRAINT transaction_pk PRIMARY KEY ( trans_id );

ALTER TABLE account
    ADD CONSTRAINT account_customer_fk FOREIGN KEY ( cust_jumin )
        REFERENCES customer ( cust_jumin );

ALTER TABLE card
    ADD CONSTRAINT card_account_fk FOREIGN KEY ( acc_id )
        REFERENCES account ( acc_id );

ALTER TABLE card
    ADD CONSTRAINT card_customer_fk FOREIGN KEY ( cust_jumin )
        REFERENCES customer ( cust_jumin );

ALTER TABLE transaction
    ADD CONSTRAINT transaction_account_fk FOREIGN KEY ( trans_acc_id )
        REFERENCES account ( acc_id );

CREATE SEQUENCE transaction_trans_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER transaction_trans_id_trg BEFORE
    INSERT ON transaction
    FOR EACH ROW
    WHEN ( new.trans_id IS NULL )
BEGIN
    :new.trans_id := transaction_trans_id_seq.nextval;
END;
/

-- 작업2. 데이터 입력

-- Customer
INSERT INTO customer VALUES ('760121-1234567', '정우성', '서울', '1976-01-21', NULL, '010-1101-7601', '배우');
INSERT INTO customer VALUES ('750611-1234567', '이정재', '서울', '1975-06-11', NULL, '010-1102-7506', '배우');
INSERT INTO customer VALUES ('890530-1234567', '전지현', '대전', '1989-05-30', 'jjh@naver.com', '010-1103-8905', '자영업');
INSERT INTO customer VALUES ('790413-1234567', '이나영', '대전', '1979-04-13', 'lee@naver.com', '010-2101-7904', '회사원');
INSERT INTO customer VALUES ('660912-1234567', '원빈', '대전', '1966-09-12', 'one@daum.net', '010-2104-6609', '배우');

select * from customer;

-- Card
INSERT INTO card VALUES ('2111-1001-1001', '760121-1234567', '1011-1001-1001', '2020-01-21', '1000000', '2020-02-10', 'check');
INSERT INTO card VALUES ('2041-1001-1002', '890530-1234567', '1011-1001-1002', '2020-06-11', '3000000', '2020-06-15', 'check');
INSERT INTO card VALUES ('2011-1001-1003', '790413-1234567', '1011-1001-1003', '2020-05-30', '5000000', '2020-06-25', 'check');
INSERT INTO card VALUES ('2611-1001-1005', '750611-1234567', '1011-1002-1005', '2020-09-12', '1500000', '2020-10-10', 'check');

select * from card;

-- Account
INSERT INTO account VALUES ('1011-1001-1001', '760121-1234567', '자유입출금', '4160000', 'Y', '2020-01-21 13:00:02');
INSERT INTO account VALUES ('1011-1001-1002', '890530-1234567', '자유입출금', '376000', 'Y', '2020-06-11 13:00:02');
INSERT INTO account VALUES ('1011-1001-1003', '790413-1234567', '자유입출금', '1200000', 'Y', '2020-05-30 13:00:02');
INSERT INTO account VALUES ('1011-2001-1004', '660912-1234567', '정기적금', '1000000', 'N', '2020-04-13 13:00:02');
INSERT INTO account VALUES ('1011-1002-1005', '750611-1234567', '자유입출금', '820000', 'Y', '2020-09-12 13:00:02');

SELECT * from account;

-- Transaction
INSERT INTO transaction VALUES (transaction_trans_id_seq.nextval, '1011-1001-1001', '입금', '2월 정기급여', '3500000', '2020-02-10 12:36:12');
INSERT INTO transaction VALUES (transaction_trans_id_seq.nextval, '1011-1001-1003', '출금', 'ATM 출금', '300000', '2020-02-10 12:37:21');
INSERT INTO transaction VALUES (transaction_trans_id_seq.nextval, '1011-1001-1002', '입금', '2월 급여', '2800000', '2020-02-10 12:38:21');
INSERT INTO transaction VALUES (transaction_trans_id_seq.nextval, '1011-1001-1001', '출금', '2월 공과금', '116200', '2020-02-10 12:39:21');
INSERT INTO transaction VALUES (transaction_trans_id_seq.nextval, '1011-1002-1005', '출금', 'ATM 출금', '50000', '2020-02-10 12:40:21');

SELECT * from transaction;

-- 작업3. SQL 실행

-- 문제1. 모든 고객 정보를 조회하시오.
select * from customer;

-- 문제2. 모든 카드 정보를 조회하시오.
select * from card;

-- 문제3. 모든 예금계좌 정보를 조회하시오.
select * from account;

-- 문제4. 가장 최근 거래 내역 3건 조회하시오.
select * from transaction
order by trans_date asc
fetch first 3 rows only;

-- 문제5. 카드한도금액이 200만원 이상인 고객의 이름과 카드 종류를 조회하시오.
select 
    a.name,
    b.card_type
from customer a
join card b on a.cust_jumin = b.cust_jumin
where b.card_limit >= '2000000';

-- 문제6. 예금 계좌별 거래 건수를 조회하시오.
SELECT 
    a.acc_id,
    count(*) as "거래 건수"
FROM account a
join transaction b on a.acc_id = b.trans_acc_id
group by a.acc_id;

-- 문제7. 거래금액이 100만원 이상인 거래 내역을 조회하시오. (최근 거래순)
select 
    trans_id,
    trans_acc_id,
    trans_type,
    trans_message,
    trans_money,
    trans_date
from transaction 
where trans_money >= '1000000'
order by trans_date desc;

-- 문제8. 계좌와 연결된 카드 정보(계좌ID, 카드ID, 카드종류)를 조회하시오.
select 
    b.acc_id,
    a.card_no,
    a.card_type
from card a
join account b on a.acc_id = b.acc_id
where a.acc_id is not null;

-- 문제9. 예금구분이 '입금'인 거래의 총합을 조회하시오.
select sum(trans_money) as 총합 from transaction
    where trans_type = '입금';

-- 문제10. 예금잔고가 4,000,000원 이상 고객에 대한 고객명, 주민번호, 전화번호, 주소를 조회하시오.
select 
    a.name,
    a.cust_jumin,
    a.hp,
    a.address
from customer a
join account b on a.cust_jumin = b.cust_jumin
where b.acc_balance >= '4000000';
