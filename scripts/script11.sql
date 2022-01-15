BEGIN;
ALTER TABLE PRODUCTS ADD COLUMN IF NOT EXISTS cont_sum numeric;

UPDATE PRODUCTS p
SET cont_sum=(SELECT max(r.sum) FROM ACCOUNTS a
RIGHT JOIN RECORDS r ON a.id=r.acc_ref where r.dt=false and a.product_ref=p.id) WHERE product_type_id=1;

UPDATE PRODUCTS p
SET cont_sum=(SELECT max(r.sum) FROM ACCOUNTS a
RIGHT JOIN RECORDS r ON a.id=r.acc_ref where r.dt=true and a.product_ref=p.id) WHERE product_type_id!=1;
COMMIT;