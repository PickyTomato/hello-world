/*우편번호(기본키) 생성 */
CREATE SEQUENCE zipcode
       START WITH 1
       CACHE 5;
/* CACHE? : 빠르게 엑세스하기 위해 메모리에 SEQUENCE를 CACHE합니다. */
       
/* SEQUENCE 조회 */
SELECT sequence_name, min_value, max_value, increment_by, last_number
FROM user_sequences;

/* 주소 테이블 생성*/
CREATE TABLE address(
       zip_code NUMBER PRIMARY KEY
       ,address VARCHAR2(40)
       ,empno NUMBER
       ); 
       
SELECT *
FROM address;

/* 주소 삽입 */
INSERT INTO address(zip_code, address, empno)
VALUES(zipcode.currval, 'Guro, Seoul', 7839);
INSERT INTO address(zip_code, address, empno)
VALUES(zipcode.Nextval, 'Kangnam, Seoul', 7698);
INSERT INTO address(zip_code, address, empno)
VALUES(zipcode.Nextval, 'Jongro, Seoul', 7782);
INSERT INTO address(zip_code, address, empno)
VALUES(zipcode.Nextval, 'Kangdong, Seoul', 7566);
INSERT INTO address(zip_code, address, empno)
VALUES(zipcode.Nextval, 'Hwasung, Kyunggi', 7788);
INSERT INTO address(zip_code, address, empno)
VALUES(zipcode.Nextval, 'Anyang, Kyunggi', 7902);
INSERT INTO address(zip_code, address, empno)
VALUES(zipcode.Nextval, 'Gwangju, Kyunggi', 7369);
INSERT INTO address(zip_code, address, empno)
VALUES(zipcode.Nextval, 'Paju, Kyunggi', 7499);
INSERT INTO address(zip_code, address, empno)
VALUES(zipcode.Nextval, 'Gwangmyung, Kyunggi', 7521);
INSERT INTO address(zip_code, address, empno)
VALUES(zipcode.Nextval, 'Paju, Kyunggi', 7654);
INSERT INTO address(zip_code, address, empno)
VALUES(zipcode.Nextval, 'Guro, Seoul', 7844);
INSERT INTO address(zip_code, address, empno)
VALUES(zipcode.Nextval, 'Gwangmyung, Kyunggi', 7876);
INSERT INTO address(zip_code, address, empno)
VALUES(zipcode.Nextval, 'Guro, Seoul', 7900);
INSERT INTO address(zip_code, address, empno)
VALUES(zipcode.Nextval, 'Paju, Kyunggi', 7934);

/* 확인 */
SELECT *
FROM ADDRESS;

/* 결과 테이블 삭제 */
DROP TABLE RES;

/* 결과 테이블 생성 */
CREATE TABLE RES(
       deptno NUMBER NOT NULL
       , empno NUMBER NOT NULL
       , zipcode NUMBER NOT NULL
       );
       
/* 확인 */
SELECT *
FROM RES;

/* 값은 값이 있는가 검색하는 매개변수쿼리 */
select count(*)
from dual
where &p_empno in (select empno from emp);

/* TEST */
DECLARE
  v_x_err_msg VARCHAR2(50);
  v_x_result VARCHAR2(50);
BEGIN
  HAHA(p_empno => 7521,
       p_deptno => 10,
       p_zipcode => 10,
       x_err_msg => v_x_err_msg,
       x_result => v_x_result);
END;
/

-- PK를 통해 정보를 받아오는 쿼리
SELECT r.empno, r.deptno, r.zipcode, e.ename, d.dname, a.address
FROM emp e, dept d, address a, res r
WHERE (r.empno = e.empno 
      and r.deptno = d.deptno 
      and r.zipcode = a.zip_code);

-------------
/* LOOPING */
-------------
-- 테이블의 컬럼 삭제 (새로 만든 컬럼 초기화)
ALTER TABLE demo_orders
DROP COLUMN NEW_TOTAL;

-- 테이블의 컬럼 추가
ALTER TABLE demo_orders
ADD (NEW_TOTAL NUMBER);

-- demo_orders의 데이터 확인
SELECT *
FROM demo_orders;
SELECT *
FROM demo_order_items;

-- 프로시저 실행
begin
  -- Call the procedure
  mumble(p_method => 1);
end;
/

/* Group by는 업데이트 함수에서 적용되지 않는다.
UPDATE demo_orders
SET demo_orders.new_total = sum(demo_order_items.unit_price*demo_order_items.quantity)
WHERE demo_order_items.order_id = demo_orders.order_id
GROUP BY demo_order_items.order_id;
*/
