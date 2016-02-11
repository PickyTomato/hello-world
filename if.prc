create or replace procedure giveNtake(
                                      p_deptno IN OUT dept.deptno%TYPE
                                     , p_empno IN OUT emp.empno%TYPE 
                                     , p_zipcode IN OUT address.zip_code%TYPE
                                     , x_err_msg OUT VARCHAR2
                                     , x_result OUT VARCHAR2
                                     )
                                     
--------------------------------------Objective--------------------------------------
/*   1. I want to fill the instance automatically when I enter any value           */
/*      of empno, deptno, or zipcode.                                              */
/*   2. I search any information which same with entered data that you write in    */
/*     input blank.                                                                */
/*   3. If you don't understand upto these Objective section, please call me.      */
/*                                                                                 */
/*                 생산최적화팀 안유찬 : 010-6779-2804, 070-7761-1915              */
-------------------------------------------------------------------------------------
IS
  -- emp, dept, address를 조인한 커서에에서 매개변수를 조회하는 쿼리
  CURSOR c_fill IS
  SELECT e.empno, e.ename, d.deptno, d.dname, a.zip_code, a.address
  FROM emp e, dept d, address a
  WHERE ((e.empno = a.empno) AND (d.deptno = e.deptno)) AND ((p_deptno = d.deptno) OR (p_empno = e.empno) OR (p_zipcode = a.zip_code))
  ORDER BY p_deptno, p_empno, p_zipcode;
  
  l_deptno NUMBER := 0;
  l_empno NUMBER := 0;
  l_zipcode NUMBER := 0;
BEGIN
  
-- 기본 서식
	DBMS_OUTPUT.PUT_LINE('   이   름       부 서 명            위    치     ');
	DBMS_OUTPUT.PUT_LINE('-------------  -------------  --------------------');
-- 어떠한 데이터도 존재하지 않을 경우  
  IF (p_deptno IS NULL and p_empno IS NULL and p_zipcode IS NULL) THEN
    x_err_msg := '아무 데이터나 입력하세요';
    x_result := 'Insert something in any blanks';
    DBMS_OUTPUT.PUT_LINE(x_err_msg);
    DBMS_OUTPUT.PUT_LINE(x_result); 
    RETURN;
  END IF;
  
-- 부서 코드 검색
  IF p_deptno IS NOT NULL THEN
    -- 입력한 값이 dept 테이블에 있는 값인가?
    SELECT count(1)
    INTO l_deptno
    FROM dept
    WHERE deptno = p_deptno;
    -- 입력한 값이 존재하지 않을 경우
    IF l_deptno != 1 THEN
      x_err_msg := '존재하지 않는 부서 번호입니다.';
      x_result := 'Check deptno';
      DBMS_OUTPUT.PUT_LINE(x_err_msg);
      DBMS_OUTPUT.PUT_LINE(x_result);  
    ELSE -- 입력한 값이 존재할 경우
      FOR rec_fill IN c_fill LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(rec_fill.ename||'('||rec_fill.empno||')', 15)||RPAD(rec_fill.dname||'('||rec_fill.deptno||')', 15)||RPAD(rec_fill.address||'('||rec_fill.zip_code||')',25));  
      END LOOP;
        x_result := 'Success';
        DBMS_OUTPUT.PUT_LINE(x_result);
      RETURN;
    END IF;
  END IF;
  
-- 사원 코드 검색  
  IF p_empno IS NOT NULL THEN
    -- 입력한 값이 emp 테이블에 있는 값인가?
    SELECT count(1)
    INTO l_empno
    FROM emp
    WHERE empno = p_empno;
    -- 입력한 값이 존재하지 않을 경우
    IF l_empno != 1 THEN
      x_err_msg := '존재하지 않는 사원 번호입니다.';
      x_result := 'Check empno';
      DBMS_OUTPUT.PUT_LINE(x_err_msg);
      DBMS_OUTPUT.PUT_LINE(x_result);  
      RETURN;
    ELSE --  입력한 값이 존재할 경우
      FOR rec_fill IN c_fill LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(rec_fill.ename||'('||rec_fill.empno||')', 15)||RPAD(rec_fill.dname||'('||rec_fill.deptno||')', 15)||RPAD(rec_fill.address||'('||rec_fill.zip_code||')',25));
        x_result := 'Success';
        DBMS_OUTPUT.PUT_LINE(x_result);  
      END LOOP;
      RETURN;
    END IF;
  END IF;
  
-- 우편 번호 검색
  IF p_zipcode IS NOT NULL THEN
    -- 입력한 값이 address 테이블에 있는 값인가?
    SELECT count(1)
    INTO l_zipcode
    FROM address
    WHERE zip_code = p_zipcode;
    -- 입력한 값이 존재하지 않을 경우
    IF l_zipcode != 1 THEN
      x_err_msg := '존재하지 않는 우편 번호입니다.';
      x_result := 'Check zipcode';
      DBMS_OUTPUT.PUT_LINE(x_err_msg);
      DBMS_OUTPUT.PUT_LINE(x_result);  
      RETURN;
    ELSE -- 입력한 값이 존재할 경우
      FOR rec_fill IN c_fill LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(rec_fill.ename||'('||rec_fill.empno||')', 15)||RPAD(rec_fill.dname||'('||rec_fill.deptno||')', 15)||RPAD(rec_fill.address||'('||rec_fill.zip_code||')',25));
        x_result := 'Success';
        DBMS_OUTPUT.PUT_LINE(x_result);  
      END LOOP;
      RETURN;
    END IF;
  END IF;    
END giveNtake;
