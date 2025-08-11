-- 생성자 Oracle SQL Developer Data Modeler 24.3.1.347.1153
--   위치:        2025-08-11 15:52:01 KST
--   사이트:      Oracle Database 21c
--   유형:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE cart (
    cartno        NUMBER NOT NULL,
    userid        VARCHAR2(20 BYTE) NOT NULL,
    prodno        NUMBER(6) NOT NULL,
    cartprodcount NUMBER,
    cartproddate  DATE NOT NULL
);

ALTER TABLE cart ADD CONSTRAINT cart_pk PRIMARY KEY ( cartno );

CREATE TABLE category (
    cateno   NUMBER(2) NOT NULL,
    catename VARCHAR2(100 BYTE) NOT NULL
);

ALTER TABLE category ADD CONSTRAINT category_pk PRIMARY KEY ( cateno );

CREATE TABLE orders (
    orderno         CHAR(11 BYTE) NOT NULL,
    userid          VARCHAR2(20 BYTE) NOT NULL,
    ordertotalprice NUMBER NOT NULL,
    orderaddress    VARCHAR2(200 BYTE) NOT NULL,
    orderstatus     NUMBER,
    orderdate       DATE NOT NULL
);

ALTER TABLE orders ADD CONSTRAINT orders_pk PRIMARY KEY ( orderno );

CREATE TABLE ordersitem (
    itemno       NUMBER NOT NULL,
    orderno      CHAR(11 BYTE) NOT NULL,
    prodno       NUMBER(6) NOT NULL,
    itemprice    NUMBER NOT NULL,
    itemdiscount NUMBER NOT NULL,
    itemcount    NUMBER
);

ALTER TABLE ordersitem ADD CONSTRAINT ordersitem_pk PRIMARY KEY ( itemno );

CREATE TABLE point (
    pointno   NUMBER NOT NULL,
    userid    VARCHAR2(20 BYTE) NOT NULL,
    point     NUMBER NOT NULL,
    "desc"    VARCHAR2(100 BYTE) NOT NULL,
    pointdate DATE NOT NULL
);

ALTER TABLE point ADD CONSTRAINT point_pk PRIMARY KEY ( pointno );

CREATE TABLE product (
    prodno       NUMBER(6) NOT NULL,
    cateno       NUMBER(2) NOT NULL,
    sellerno     NUMBER(5),
    prodname     VARCHAR2(20 BYTE) NOT NULL,
    prodprice    NUMBER NOT NULL,
    prodstock    NUMBER,
    prodsold     NUMBER,
    proddiscount NUMBER
);

ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( prodno );

CREATE TABLE seller (
    sellerno NUMBER(5) NOT NULL,
    company  VARCHAR2(100 BYTE) NOT NULL,
    tel      VARCHAR2(20 BYTE) NOT NULL,
    manager  VARCHAR2(20 BYTE) NOT NULL,
    address  VARCHAR2(100 BYTE) NOT NULL
);

ALTER TABLE seller ADD CONSTRAINT seller_pk PRIMARY KEY ( sellerno );

CREATE TABLE "User" (
    userid  VARCHAR2(20 BYTE) NOT NULL,
    name    VARCHAR2(20 BYTE) NOT NULL,
    birth   CHAR(10 BYTE) NOT NULL,
    gender  CHAR(1 BYTE) NOT NULL,
    hp      CHAR(13 BYTE) NOT NULL,
    email   VARCHAR2(100 BYTE),
    point   NUMBER,
    "level" NUMBER,
    address VARCHAR2(100 BYTE),
    regdate DATE NOT NULL
);

ALTER TABLE "User" ADD CONSTRAINT user_pk PRIMARY KEY ( userid );

ALTER TABLE "User" ADD CONSTRAINT user__un UNIQUE ( hp,
                                                    email );

ALTER TABLE cart
    ADD CONSTRAINT cart_product_fk FOREIGN KEY ( prodno )
        REFERENCES product ( prodno );

ALTER TABLE cart
    ADD CONSTRAINT cart_user_fk FOREIGN KEY ( userid )
        REFERENCES "User" ( userid );

ALTER TABLE orders
    ADD CONSTRAINT orders_user_fk FOREIGN KEY ( userid )
        REFERENCES "User" ( userid );

ALTER TABLE ordersitem
    ADD CONSTRAINT ordersitem_orders_fk FOREIGN KEY ( orderno )
        REFERENCES orders ( orderno );

ALTER TABLE ordersitem
    ADD CONSTRAINT ordersitem_product_fk FOREIGN KEY ( prodno )
        REFERENCES product ( prodno );

ALTER TABLE point
    ADD CONSTRAINT point_user_fk FOREIGN KEY ( userid )
        REFERENCES "User" ( userid );

ALTER TABLE product
    ADD CONSTRAINT product_category_fk FOREIGN KEY ( cateno )
        REFERENCES category ( cateno );

ALTER TABLE product
    ADD CONSTRAINT product_seller_fk FOREIGN KEY ( sellerno )
        REFERENCES seller ( sellerno );

CREATE SEQUENCE cart_cartno_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER cart_cartno_trg BEFORE
    INSERT ON cart
    FOR EACH ROW
    WHEN ( new.cartno IS NULL )
BEGIN
    :new.cartno := cart_cartno_seq.nextval;
END;
/

CREATE SEQUENCE ordersitem_itemno_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER ordersitem_itemno_trg BEFORE
    INSERT ON ordersitem
    FOR EACH ROW
    WHEN ( new.itemno IS NULL )
BEGIN
    :new.itemno := ordersitem_itemno_seq.nextval;
END;
/

CREATE SEQUENCE point_pointno_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER point_pointno_trg BEFORE
    INSERT ON point
    FOR EACH ROW
    WHEN ( new.pointno IS NULL )
BEGIN
    :new.pointno := point_pointno_seq.nextval;
END;
/

INSERT INTO "User" VALUES ('user1', '김유신', '1976-01-21', 'M', '010-1101-1976', 'kimys@naver.com', '7000', '1', '서울', '2022-01-10 10:50:12');
INSERT INTO "User" VALUES ('user2', '계백', '1975-06-11', 'M', '010-1102-1975', NULL, '5650', '1', '서울', '2022-01-10 10:50:12');
INSERT INTO "User" VALUES ('user3', '김춘추', '1989-05-30', 'M', '010-1103-1989', NULL, '4320', '2', '서울', '2022-01-10 10:50:12');
INSERT INTO "User" VALUES ('user4', '이사부', '1979-04-13', 'M', '010-2101-1979', 'leesabu@gmail.com', '0', '1', '서울', '2022-01-10 10:50:12');
INSERT INTO "User" VALUES ('user5', '장보고', '1966-09-12', 'M', '010-2104-1966', 'jangbg@naver.com', '3000', '4', '대전', '2022-01-10 10:50:12');
INSERT INTO "User" VALUES ('user6', '선덕여왕', '1979-07-28', 'F', '010-3101-1979', 'queen@naver.com', '15840', '2', '대전', '2022-01-10 10:50:12');
INSERT INTO "User" VALUES ('user7', '강감찬', '1984-06-15', 'M', '010-4101-1984', 'kang@daum.net', '3610', '0', '대구', '2022-01-10 10:50:12');
INSERT INTO "User" VALUES ('user8', '신사임당', '1965-10-21', 'F', '010-5101-1965', 'sinsa@gmail.com', '0', '1', '대구', '2022-01-10 10:50:12');
INSERT INTO "User" VALUES ('user9', '이이', '1972-11-28', 'M', '010-6101-1972', 'leelee@nate.com', '0', '3', '부산', '2022-01-10 10:50:12');
INSERT INTO "User" VALUES ('user10', '허난설헌', '1992-09-07', 'F', '010-7103-1992', NULL, '0', '3', '광주', '2022-01-10 10:50:12');

INSERT INTO Point VALUES (point_pointNo_seq.nextval, 'user1', '1000', '회원가입 1000 적립', '2022-01-10 10:50:12');
INSERT INTO Point VALUES (point_pointNo_seq.nextval, 'user1', '6000', '상품구매 5% 적립', '2022-01-10 10:50:12');
INSERT INTO Point VALUES (point_pointNo_seq.nextval, 'user3', '2820', '상품구매 5% 적립', '2022-01-10 10:50:12');
INSERT INTO Point VALUES (point_pointNo_seq.nextval, 'user7', '3610', '상품구매 5% 적립', '2022-01-10 10:50:12');
INSERT INTO Point VALUES (point_pointNo_seq.nextval, 'user5', '3000', '이벤트 응모 3000 적립', '2022-01-10 10:50:12');
INSERT INTO Point VALUES (point_pointNo_seq.nextval, 'user2', '1000', '회원가입 1000 적립', '2022-01-10 10:50:12');
INSERT INTO Point VALUES (point_pointNo_seq.nextval, 'user2', '2000', '이벤트 응모 2000 적립', '2022-01-10 10:50:12');
INSERT INTO Point VALUES (point_pointNo_seq.nextval, 'user2', '2650', '상품구매 5% 적립', '2022-01-10 10:50:12');
INSERT INTO Point VALUES (point_pointNo_seq.nextval, 'user3', '1500', '이벤트 응모 1500 적립', '2022-01-10 10:50:12');
INSERT INTO Point VALUES (point_pointNo_seq.nextval, 'user6', '15840', '상품구매 2% 적립', '2022-01-10 10:50:12');

INSERT INTO Seller VALUES ('10001', '(주)다팔아', '02-201-1976', '정우성', '서울');
INSERT INTO Seller VALUES ('10002', '판매의 민족', '02-102-1975', '이정재', '서울');
INSERT INTO Seller VALUES ('10003', '멋남', '031-103-1989', '원빈', '경기');
INSERT INTO Seller VALUES ('10004', '스타일살아', '032-201-1979', '이나영', '경기');
INSERT INTO Seller VALUES ('10005', '(주)삼성전자', '02-214-1966', '장동건', '서울');
INSERT INTO Seller VALUES ('10006', '복실이옷짱', '051-301-1979', '고소영', '부산');
INSERT INTO Seller VALUES ('10007', '컴퓨존(주)', '055-401-1984', '유재석', '대구');
INSERT INTO Seller VALUES ('10008', '(주)LG전자', '02-511-1965', '강호동', '서울');
INSERT INTO Seller VALUES ('10009', '굿바디스포츠', '070-6101-1972', '조인성', '부산');
INSERT INTO Seller VALUES ('10010', '누리푸드', '051-710-1992', '강동원', '부산');

INSERT INTO Category VALUES ('10', '여성의류패션');
INSERT INTO Category VALUES ('11', '남성의류패션');
INSERT INTO Category VALUES ('12', '식품·생필품');
INSERT INTO Category VALUES ('13', '취미·반려견');
INSERT INTO Category VALUES ('14', '홈·문구');
INSERT INTO Category VALUES ('15', '자동차·공구');
INSERT INTO Category VALUES ('16', '스포츠·건강');
INSERT INTO Category VALUES ('17', '컴퓨터·가전·디지털');
INSERT INTO Category VALUES ('18', '여행');
INSERT INTO Category VALUES ('19', '도서');

INSERT INTO Product VALUES ('100101', '11', '10003', '반팔티 L~2XL', '869', '25000', '132', '20');
INSERT INTO Product VALUES ('100110', '10', '10004', '트레이닝 통바지', '1602', '38000', '398', '15');
INSERT INTO Product VALUES ('110101', '10', '10003', '신상 여성운동화', '160', '76000', '40', '5');
INSERT INTO Product VALUES ('120101', '12', '10010', '암소 1등급 구이셋트 1.2kg', '0', '150000', '87', '15');
INSERT INTO Product VALUES ('120103', '12', '10010', '바로구이 부채살 250g', '0', '21000', '61', '10');
INSERT INTO Product VALUES ('130101', '13', '10006', '[ANF] 식스프리 강아지 사료', '58', '56000', '142', '0');
INSERT INTO Product VALUES ('130112', '13', '10006', '중대형 사계절 강아지옷', '120', '15000', '80', '0');
INSERT INTO Product VALUES ('141001', '14', '10001', '라떼 2인 소파/방수 패브릭', '0', '320000', '42', '0');
INSERT INTO Product VALUES ('170115', '17', '10007', '지포스 3080 그래픽카드', '28', '900000', '12', '12');
INSERT INTO Product VALUES ('160103', '16', '10009', '치닝디핑 33BR 철봉', '32', '120000', '28', '0');

INSERT INTO Orders VALUES ('22010210001', 'user2', '52300', '서울시 마포구 121', '1', '2022-01-10 10:50:12');
INSERT INTO Orders VALUES ('22010210002', 'user3', '56700', '서울시 강남구 21-1', '1', '2022-01-10 10:50:12');
INSERT INTO Orders VALUES ('22010210010', 'user4', '72200', '서울시 강서구 큰대로 38', '2', '2022-01-10 10:50:12');
INSERT INTO Orders VALUES ('22010310001', 'user5', '127000', '경기도 광주시 초월로 21', '1', '2022-01-10 10:50:12');
INSERT INTO Orders VALUES ('22010310100', 'user1', '120000', '경기도 수원시 120번지', '0', '2022-01-10 10:50:12');
INSERT INTO Orders VALUES ('22010410101', 'user6', '792000', '부산시 남구 21-1', '2', '2022-01-10 10:50:12');
INSERT INTO Orders VALUES ('22010510021', 'user7', '92200', '부산시 부산진구 56 10층', '4', '2022-01-10 10:50:12');
INSERT INTO Orders VALUES ('22010510027', 'user8', '112000', '대구시 팔달로 19', '3', '2022-01-10 10:50:12');
INSERT INTO Orders VALUES ('22010510031', 'user10', '792000', '대전시 한밭로 24-1', '2', '2022-01-10 10:50:12');
INSERT INTO Orders VALUES ('22010710110', 'user9', '94500', '광주시 충열로 11', '1', '2022-01-10 10:50:12');

INSERT INTO OrdersItem VALUES (ordersItem_itemNo_seq.nextval, '22010210001', '100110', '38000', '15', '1');
INSERT INTO OrdersItem VALUES (ordersItem_itemNo_seq.nextval, '22010210001', '100101', '25000', '20', '1');
INSERT INTO OrdersItem VALUES (ordersItem_itemNo_seq.nextval, '22010210002', '120103', '21000', '10', '3');
INSERT INTO OrdersItem VALUES (ordersItem_itemNo_seq.nextval, '22010310001', '130112', '15000', '0', '1');
INSERT INTO OrdersItem VALUES (ordersItem_itemNo_seq.nextval, '22010310001', '130101', '56000', '0', '2');
INSERT INTO OrdersItem VALUES (ordersItem_itemNo_seq.nextval, '22010210010', '110101', '76000', '5', '1');
INSERT INTO OrdersItem VALUES (ordersItem_itemNo_seq.nextval, '22010310100', '160103', '120000', '0', '1');
INSERT INTO OrdersItem VALUES (ordersItem_itemNo_seq.nextval, '22010410101', '170115', '900000', '12', '1');
INSERT INTO OrdersItem VALUES (ordersItem_itemNo_seq.nextval, '22010510021', '110101', '76000', '5', '1');
INSERT INTO OrdersItem VALUES (ordersItem_itemNo_seq.nextval, '22010510027', '130101', '56000', '0', '2');
INSERT INTO OrdersItem VALUES (ordersItem_itemNo_seq.nextval, '22010510021', '100101', '25000', '20', '1');
INSERT INTO OrdersItem VALUES (ordersItem_itemNo_seq.nextval, '22010510031', '170115', '900000', '12', '1');
INSERT INTO OrdersItem VALUES (ordersItem_itemNo_seq.nextval, '22010710110', '120103', '21000', '10', '5');

INSERT INTO Cart VALUES (cart_cartNo_seq.nextval, 'user1', '100101', '1', '2022-01-10 10:50:12');
INSERT INTO Cart VALUES (cart_cartNo_seq.nextval, 'user1', '100110', '2', '2022-01-10 10:50:12');
INSERT INTO Cart VALUES (cart_cartNo_seq.nextval, 'user3', '120103', '1', '2022-01-10 10:50:12');
INSERT INTO Cart VALUES (cart_cartNo_seq.nextval, 'user4', '130112', '1', '2022-01-10 10:50:12');
INSERT INTO Cart VALUES (cart_cartNo_seq.nextval, 'user5', '130101', '1', '2022-01-10 10:50:12');
INSERT INTO Cart VALUES (cart_cartNo_seq.nextval, 'user2', '110101', '3', '2022-01-10 10:50:12');
INSERT INTO Cart VALUES (cart_cartNo_seq.nextval, 'user2', '160103', '1', '2022-01-10 10:50:12');
INSERT INTO Cart VALUES (cart_cartNo_seq.nextval, 'user2', '170115', '1', '2022-01-10 10:50:12');
INSERT INTO Cart VALUES (cart_cartNo_seq.nextval, 'user3', '110101', '1', '2022-01-10 10:50:12');
INSERT INTO Cart VALUES (cart_cartNo_seq.nextval, 'user6', '130101', '1', '2022-01-10 10:50:12');

-- 문제1. 모든 장바구니 내역에서 고객명, 상품명, 상품수량을 조회하시오. (단 상품수량 2건 이상만 조회 할 것)
SELECT
    name, prodName, cartProdCount
from cart a
join "User" b on a.userId = b.userId
join product c on a.prodNo = c.prodNo
where cartProdCount >= 2;

-- 문제2. 모든 상품내역에서 상품번호, 카테고리명, 상품명, 가격, 판매자 이름, 판매자 연락처를 조회하시오.
SELECT
    prodNo, 
    cateName, 
    prodName, 
    prodPrice, 
    manager, 
    tel
from product a
join category b on a.cateNo = b.cateNo
join seller c on a.sellerNo = c.sellerNo;

-- 문제3. 모든 고객의 아이디, 이름, 휴대폰, 현재포인트, 적립포인트 총합을 조회하시오. (단 적립포인트 내역이 없으면 0으로 출력)
SELECT
    a.userId, 
    a.name, 
    a.hp, 
    a.point,
    NVL(SUM(b.point), 0) AS 적립포인트_총합