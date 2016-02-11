/*LEVEL과 LPAD함수는 하나의 테이블에서 하나의 컬럼이 다른 컬럼의 값을 참조하는 구조를 가진 경우에 사용*/
SELECT ename, LEVEL, empno, mgr
FROM emp
START WITH ename = 'KING'
CONNECT BY PRIOR empno = mgr;
/*CONNECT BY PRIOR empno = mgr; : Top-Down방식(조직도를 큰 값부터 작은 값 순으로 조회할 때)*/
/*CONNECT BY PRIOR mgr = empno; : Bottom-Up방식(조직도를 작은 값부터 큰 값 순으로 조회)*/
/*START WITH ename= 'KING' : 조직도를 생성할 때 기준이 될 컴럼과 값을 정의할 수 있다.*/
SELECT LPAD(' ', 3*LEVEL-3)||ename 조직도, LEVEL, empno,  mgr
FROM emp
START WITH ename = 'KING'
CONNECT BY PRIOR empno=mgr;
/* LPAD를 이용하면 더 보기 좋게 조직도를 만들 수 있다. */

/* USING절 */
/* USING절을 사용하면 USING절에 정의된 컬럼을 기준으로 NATURAL 조인이 발생합니다. */
SELECT e.empno, e.ename, d.dname
FROM EMP e JOIN DEPT d
     USING (deptno);
SELECT E.EMPNO, E.ENAME, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO;

/*WITH절*/
/*참조되는 SUB-QUERY가 참조하는 SUB-QUERY 보다 우선적으로 선언되어야한다.*/

WITH
      /*SUB-QUERY 1.*/
      DEPT_COSTS AS (SELECT D.DEPTNO,
                     SUM(E.SAL) AS "DEPT_TOTAL"
                     FROM EMP E, DEPT D
                     WHERE E.DEPTNO = D.DEPTNO
                     GROUP BY D.DEPTNO),
      /*SUB-QUERY 2.*/
      AVG_COST AS (SELECT SUM(DEPT_TOTAL)/COUNT(*) AS "DEPT_AVG"
                   FROM DEPT_COSTS)
      /*MAIN-QUERY*/
      SELECT *
      FROM DEPT_COSTS
      WHERE DEPT_TOTAL > (SELECT DEPT_AVG
                          FROM AVG_COST)
      ORDER BY DEPTNO;
      
/*매개변수쿼리*/
/* & : SQL문장이 실행될 때마다 새로운 값을 요구합니다.*/
SELECT empno, job, hiredate, deptno
FROM emp
WHERE deptno=&department; /*부서번호를 입력하면 쿼리를 만든다.*/
/*치환변수가 문자, 날짜 타입이면 인용부호를 반드시 사용해야 한다.*/
SELECT *
FROM emp
WHERE UPPER(ename)=UPPER('&employee_name');
/* ACCEPT문 */
ACCEPT department
PROMPT 'Please Enter The Department Number?'
ACCEPT name
PROMPT 'Please Enter The Department Name?'
ACCEPT location
PROMPT 'Please Enter The Department Location?'
INSERT INTO dept(deptno, dname, loc)
VALUES(&department, '&name', '&location');
SELECT *
FROM dept;

/* http://www.tutorialspoint.com/plsql/plsql_strings.htm */

/* PL/SQL 기본 */
/*
DECLARE
  - Optional
  - Variables, cursors, user-defined exceptions

BEGIN
  - Mandatory
  - SQL Statements
  - PL/SQL Statements

EXCEPTION
	- Actions to perform when errors occur 

END
  - Mandatory
*/
DECLARE
   message VARCHAR2(20) := 'Hello, World!';
BEGIN
  dbms_output.put_line(message);
END;
/

BEGIN
  GREETINGS;
END;
/
DROP PROCEDURE GREETINGS;

BEGIN
  update_sal(7369);
END;

SELECT *
FROM EMP;

-- Find a Minimum Number
DECLARE
   a number;
   b number;
   c number;

PROCEDURE findMin(x IN number, y IN number, z OUT number) IS
BEGIN
   IF x < y THEN
      z:= x;
   ELSE
      z:= y;
   END IF;
END; 

BEGIN
   a:= 23;
   b:= 45;
   findMin(a, b, c);
   dbms_output.put_line(' Minimum of (23, 45) : ' || c);
END;
/
-- Calculate Square Number
DECLARE
   a number;
PROCEDURE squareNum(x IN OUT number) IS
BEGIN
  x := x * x;
END; 
BEGIN
   a:= 23;
   squareNum(a);
   dbms_output.put_line(' Square of (23): ' || a);
END;
/

--Global variable & Local variable.
DECLARE
   -- GLOBAL variables
   num1 number := 95;
   num2 number := 85;
BEGIN
  dbms_output.put_line('Outer Variable num1: ' || num1);
  dbms_output.put_line('Outer Variable num2: ' || num2);
  DECLARE
     -- Local variables
     num1 number := 195;
     num2 number := 185;
  BEGIN
    dbms_output.put_line('Inner Variable num1: ' || num1);
    dbms_output.put_line('Inner Variable num2: ' || num2);
  END;
END;
/

-- Make Customer Table
CREATE TABLE CUSTOMERS(
   ID INT NOT NULL,
   NAME VARCHAR2 (20) NOT NULL,
   AGE INT NOT NULL,
   ADDRESS CHAR (25),
   SALARY DECIMAL (18,2),
   PRIMARY KEY (ID)
);
-- Insert some values in customer table.
INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (1, 'Ramesh', 32, 'Ahmedabad', 2000.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (2, 'Khilan', 25, 'Delhi', 1500.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (3, 'kaushik', 23, 'Kota', 2000.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (4, 'Chaitali', 25, 'Mumbai', 6500.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (5, 'Hardik', 27, 'Bhopal', 8500.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (6, 'Komal', 22, 'MP', 4500.00 );

SELECT *
FROM CUSTOMERS;

-- Loop
DECLARE
   i number(1);
   j number(1);
BEGIN
   << outer_loop >>
   FOR i IN 1..3 LOOP
      << inner_loop >>
      FOR j IN 1..10 LOOP
         dbms_output.put_line('i is: '|| i || ' and j is: ' || j);
      END loop inner_loop;
   END loop outer_loop;
END;
/

DECLARE
  v_cnt NUMBER := 1;
  v_str VARCHAR2(20) := NULL;
BEGIN
  LOOP
    v_str := v_str || '*';
    DBMS_OUTPUT.PUT_LINE(v_str);
    v_cnt := v_cnt + 1;
    IF v_cnt >= 20 THEN
      EXIT;
    END IF;
  END LOOP;
END;
/

DECLARE
  x VARCHAR2(100) := 'Call my name';
BEGIN
  FOR i_idx IN 1..20 LOOP 
    x := x  || ' A@ ';
    DBMS_OUTPUT.PUT_LINE(x);
  END LOOP;
END;
/ 

DECLARE
	v_str	VARCHAR2(10) := NULL;
BEGIN
	FOR i_idx IN 1..10 LOOP
		v_str := v_str || '*';
		DBMS_OUTPUT.PUT_LINE(v_str);
	END LOOP;
END;
/

-- Declaring String Variables.
DECLARE
   name varchar2(20);
   company varchar2(30);
   introduction clob;
   choice char(1);
BEGIN
  name := 'John Smith';
  company := 'Infotech';
  introduction := 'Hello! I''m John Smith from Infotech';
  choice := 'y';
  IF choice = 'y' THEN
    dbms_output.put_line(name);
    dbms_output.put_line(company);
    dbms_output.put_line(introduction);
  END IF;
END;
/
/* RTRIM, LTRIM, TRIM */
DECLARE
   greetings varchar2(30) := '......Hello World.....';
BEGIN
   dbms_output.put_line(RTRIM(greetings,'.'));
   dbms_output.put_line(LTRIM(greetings, '.'));
   dbms_output.put_line(TRIM( '.' from greetings));
END;
/
/* UPPER, LOWER, INITCAP, SUBSTR, INSTR */

-- Varray
CREATE Or REPLACE TYPE namearray AS VARRAY(3) OF VARCHAR2(10);
/
-- Example of Varray
DECLARE
   type namesarray IS VARRAY(5) OF VARCHAR2(10);
   type grades IS VARRAY(5) OF INTEGER;
   names namesarray;
   marks grades;
   total integer;
BEGIN
   names := namesarray('Kavita', 'Pritam', 'Ayan', 'Rishav', 'Aziz');
   marks:= grades(98, 97, 78, 87, 92);
   total := names.count;
   dbms_output.put_line('Total '|| total || ' Students');
   FOR i in 1 .. total LOOP
      dbms_output.put_line('Student: ' || names(i) || '  Marks: ' || marks(i));
   END LOOP;
END;
/
-- Example of Cursor
DECLARE
   CURSOR c_customers is
   SELECT  name FROM customers;
   type c_list is varray (6) of customers.name%type;
   name_list c_list := c_list();
   counter integer :=0;
BEGIN
   FOR n IN c_customers LOOP
      counter := counter + 1;
      name_list.extend;
      name_list(counter)  := n.name;
      dbms_output.put_line('Customer('||counter ||'):'||name_list(counter));
   END LOOP;
END;
/

-- Search people who hired company earlier.
SELECT A.EMPNO, A.ENAME, COUNT(B.HIREDATE) AS "HIRED EARLIER"
FROM EMP A, EMP B
WHERE B.HIREDATE(+) < A.HIREDATE
GROUP BY A.EMPNO, A.ENAME

-- Function 만들기
CREATE OR REPLACE FUNCTION totalCustomers
RETURN number IS
   total number(2) := 0;
BEGIN
  SELECT count(*) into total
  FROM customers;
  
  RETURN total;
END;
-- Function 활용하기
DECLARE
   c number(2);
BEGIN
  c := totalCustomers();
  dbms_output.put_line('total no. of Customers: ' || c);
END;
/

-- 커서(cursor)를 활용해보자
/* 내가 느끼기에 커서는 테이블을 임시적으로 저장해놓는 공간같다.*/
DECLARE
  v_empno emp.empno%TYPE;
  v_ename emp.ename%TYPE;
--커서를 선언 cursor 커서이름 is 
      cursor mycursor is 
      select empno, ename
      from emp
      order by 1 desc ;
BEGIN
  --2. open 커서명; (데이터를 불러오기 위한 준비단계)
  open mycursor;
  -- 출력구문
  dbms_output.put_line('사번-----이름');
     for i in 1..10 loop 
     --3. FETCH 커서명 (레코드르 1개씩 읽어들이는 기능)
     --into 출력변수명...
       FETCH mycursor
       into v_empno, v_ename;
       dbms_output.put_line(v_empno    ||    '-----'   ||  v_ename);
     end loop;
  --4. 커서 종료 -> 메모리 해제 
  close mycursor ;   --4. close 닫을 커서명 ;
END;
/

DECLARE
  CURSOR emp_cursor is
  SELECT deptno, ename, sal
  FROM emp;
BEGIN
  for item in emp_cursor loop
    IF item.deptno = 30 THEN
      dbms_output.put_line('이름: ' || item.ename);
      dbms_output.put_line('급여: ' || item.sal);
    END IF;
  END LOOP;
END;
/

/* 배열 변수(array variable) = Composite 변수 */
-- TABLE만들기
CREATE TABLE top_dogs(
            name         varchar2(10)
            , salary     number(7,2));
-- 프로시저 만들기            
begin
  test2(v_empno => 7900);
end;

select *
from top_dogs;

/* LOOP ~ END LOOP문 안에 정의된 sql문이 반복적으로 실행되다가 EXIT WHEN절에 만족되는 조건을 만나면 반복작업은 중단됩니다. */
DECLARE
   CNT NUMBER :=0 ;
BEGIN
   LOOP
     CNT:= CNT+1;
     dbms_output.put_line(CNT);
     EXIT WHEN CNT = 100;
   END LOOP;
END;
/
/* FOR ~ LOOP문에 의해 반복 실행되는 횟수를 정확히 아는 경우에 사용할 수 있습니다.
정의된 변수가 최소값과 최대값 범위 내에서 반복적으로 실행되며 변수가 최대값을 만나는 순간 반복작업은 완료됩니다.
[REVERSE] 키워드는 최대값에서 최소값 순으로 거꾸로 값을 설정합니다. */
DECLARE
  i NUMBER;
BEGIN
  FOR i IN 1..10 LOOP
    IF (MOD(i,2)=1) THEN
      dbms_output.put_line(i);
    END IF;
  END LOOP;
END;
/

/* 중첩된 LOOP문이란?
반복문 내에 또 다른 분복문을 중첩된 LOOP문이라고 합니다. 
각각의 반복문을 구별하기 위해 라벨(LABEL)이 사용되며 각 반복문을 벗어나기 위해서는 EXIT문을 사용합니다.
다음은 구구단을 작성하는 중첩 LOOP문의 예제입니다. */
DECLARE 
  x NUMBER := 0;
  y NUMBER := 0;
  z NUMBER := 0;
BEGIN
  <<FIRST_LOOP>>
  LOOP
    y := 0;
    x := x + 1;
    EXIT FIRST_LOOP WHEN x = 10;
    dbms_output.put_line('
    ▽' || x || '단▽');
    <<SECOND_LOOP>>
    LOOP
      y := y + 1;
      z := x * y;
      EXIT SECOND_LOOP WHEN y = 10;
      dbms_output.put_line(x || ' * ' || y || ' = ' || z );
    END LOOP SECOND_LOOP;    
  END LOOP FIRST_LOOP;
END;
/

/* View의 개념
View는 자체의 데이터는 없지만 테이블의 데이터를 보거나 변경할 수 있는 창과 같다.*/
/* View의 장점
1. 한 개의 View로 여러 테이블에 대한 데이터를 검색할 수 있다.
2. 동일한 데이터의 다른 VIEW를 나타낸다.
3. 특정 평가기준에 따른 사용자 별로 다른 데이터를 액세스할 수 있다. */
CREATE VIEW emp_20
AS SELECT * FROM emp WHERE deptno = 20;

SELECT *
FROM emp_20;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
create table temp(
                  NUM_COL1 NUMBER
                  ,NUM_COL2 NUMBER
                  ,CHAR_COL VARCHAR2(100)
                  );
                  
select *
from temp;

-- available online in file 'sample3'
DECLARE
   x NUMBER := 0;
   counter NUMBER := 0;
BEGIN
   FOR i IN 1..4 LOOP
      x := x + 1000;
      counter := counter + 1;
      INSERT INTO temp VALUES (x, counter, 'in OUTER loop');
      /* start an inner block */
      DECLARE
         x NUMBER := 0;  -- this is a local version of x
         counter NUMBER := 0;
      BEGIN
         FOR i IN 1..4 LOOP
            x := x + 1;  -- this increments the local x
            counter := counter + 1;
            INSERT INTO temp VALUES (x, counter, 'inner loop');
         END LOOP;
      END;
   END LOOP;
   COMMIT;
END;
/
DROP TABLE temp;


DECLARE
   CURSOR c1 is
      SELECT ename, empno, sal FROM emp
         ORDER BY sal DESC;   -- start with highest paid employee
   my_ename VARCHAR2(10);
   my_empno NUMBER(4);
   my_sal   NUMBER(7,2);
BEGIN
   OPEN c1;
   FOR i IN 1..5 LOOP
      FETCH c1 INTO my_ename, my_empno, my_sal;
      EXIT WHEN c1%NOTFOUND;  /* in case the number requested */
                              /* is more than the total       */
                              /* number of employees          */
      INSERT INTO temp VALUES (my_sal, my_empno, my_ename);
      COMMIT;
   END LOOP;
   CLOSE c1;
END;
/

-- available online in file 'examp4'
DECLARE
   CURSOR my_cursor IS
     SELECT sal+NVL(comm,0) wages, ename 
     FROM emp;
   my_rec my_cursor%ROWTYPE;
BEGIN
  OPEN my_cursor;
  LOOP
    FETCH my_cursor 
    INTO my_rec;
    EXIT WHEN my_cursor%NOTFOUND;
    IF my_rec.wages > 2000 THEN
      INSERT INTO temp VALUES (NULL, my_rec.wages, my_rec.ename);
    END IF;
  END LOOP;
  CLOSE my_cursor;
END;
/

SELECT *
FROM temp;
    
