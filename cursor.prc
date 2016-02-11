/**************************CHALLENGER*****************************/
/*    1. demo_orders order_total 칼럼(new_total) 을 하나 추가    */
/*                                                               */
/*    2. demo_orders  전체를 looping                             */
/*                                                               */
/*       order_total을 계산해서 넣는다                           */ 
/*****************************************************************/
CREATE OR REPLACE PROCEDURE mumble(
                                   p_method IN NUMBER
                                   )
  IS
  -- c_total 커서에 합계와 ID를 저장한다.
  CURSOR c_total IS
  SELECT sum(i.unit_price*i.quantity) t_sum, i.order_id t_id, avg(i.unit_price*i.quantity) t_avg
  FROM demo_order_items i
  GROUP BY i.order_id;
BEGIN
  -- UPDATE함수를 사용하여 c_total 커서와 demo_orders를 비교하여 자료를 추가한다.
  IF p_method = 1 THEN
    FOR rec_total IN c_total LOOP
      UPDATE demo_orders
      SET demo_orders.new_total = rec_total.t_sum
      WHERE demo_orders.order_id = rec_total.t_id;
    END LOOP;
    COMMIT;
    RETURN;
  ELSIF p_method = 2 THEN
        FOR rec_total IN c_total LOOP
      UPDATE demo_orders
      SET demo_orders.new_total = rec_total.t_avg
      WHERE demo_orders.order_id = rec_total.t_id;
    END LOOP;
    COMMIT;
    RETURN;
  ELSE 
    DBMS_OUTPUT.PUT_LINE('BAAAAAAAAANG');
  END IF;
  
EXCEPTION
  -- ERROR Message
       WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');
end mumble;
