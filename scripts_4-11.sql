
-- TASK 4
SELECT A.* FROM ACCOUNTS A LEFT JOIN PRODUCTS P ON A.PRODUCT_REF=P.ID
WHERE P.PRODUCT_TYPE_ID=2 AND P.CLIENT_REF NOT IN (
    SELECT P.CLIENT_REF FROM PRODUCTS P WHERE (
        P.PRODUCT_TYPE_ID=1 AND P.CLOSE_DATE IS NULL
        ) 
    );

-- TASK 9
UPDATE PRODUCTS p
SET close_date=current_date FROM ACCOUNTS a RIGHT JOIN RECORDS r ON a.id=r.acc_ref 
WHERE p.product_type_id=1 AND a.saldo=0 AND p.id=a.product_ref

	
-- TASK 10
UPDATE PRODUCT_TYPE p
SET end_date=current_date
WHERE (SELECT max(r.oper_date) FROM RECORDS r 
	   LEFT JOIN ACCOUNTS a ON r.acc_ref=a.id 
	   WHERE a.product_ref=p.id) < date_trunc('month', current_date - interval '1' month);

UPDATE PRODUCT_TYPE t
SET end_date=current_date
WHERE (SELECT max(r.oper_date) FROM PRODUCTS p LEFT JOIN ACCOUNTS a ON a.product_ref=p.id 
	   LEFT JOIN RECORDS r ON r.acc_ref=a.id 
	   WHERE p.product_type_id=t.id) < date_trunc('month', current_date - interval '1' month);

-- TASK 11
ALTER TABLE PRODUCTS ADD COLUMN IF NOT EXISTS cont_sum numeric;

UPDATE PRODUCTS p
SET cont_sum=(SELECT max(r.sum) FROM ACCOUNTS a
RIGHT JOIN RECORDS r ON a.id=r.acc_ref where r.dt=false and a.product_ref=p.id) WHERE product_type_id=1;

UPDATE PRODUCTS p
SET cont_sum=(SELECT max(r.sum) FROM ACCOUNTS a
RIGHT JOIN RECORDS r ON a.id=r.acc_ref where r.dt=true and a.product_ref=p.id) WHERE product_type_id!=1;