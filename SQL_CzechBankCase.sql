-- ------------------------------------- DATA CASE STUDY ------------------------------------- 
-- -------------- Identify the good clients to whom we can other services --------------------
USE bank;
-- --------------  GOOD CLIENT 

-- Frequency: > 193 transactions (avg/cliente = 193) (1976)
WITH a AS 
(SELECT account_id, COUNT(trans_id) as total_trans FROM trans GROUP BY account_id ORDER BY total_trans DESC),
b AS
(SELECT account_id, total_trans, AVG(total_trans) OVER() AS trans_average FROM a)
SELECT * FROM b WHERE total_trans > trans_average;

-- If there is a loan, loan status = A and C (606)
SELECT status, account_id FROM loan WHERE status = 'A' or status = 'C';
SELECT status, COUNT(account_id) FROM loan WHERE status = 'A' or status = 'C' GROUP BY status;

-- Total good frequent and good loan status clients (313)
WITH freq AS
(SELECT account_id, COUNT(trans_id) as total_trans FROM trans GROUP BY account_id HAVING total_trans >= 193 ORDER BY total_trans),
good_status AS
(SELECT status, account_id FROM loan WHERE status = 'A' or status = 'C')
SELECT *, COUNT(*) OVER() as total_goodclients FROM freq
JOIN good_status ON freq.account_id = good_status.account_id;

-- Most of all costumers are in 'Hl.m. Praha' district (554 clients): 100% urban, highest average salary (12541; min 8110 - max 12541) and lowest unemplyment rate (0.43; min 0.43 - max 9.4)
SELECT COUNT(account_id), district_id FROM account GROUP BY district_id ORDER BY COUNT(account_id) DESC;
SELECT * FROM district WHERE A1 = 1;

-- Most of frequent clients with good loan status are from 'Hl.m. Praha'
WITH freq AS
(SELECT account_id, COUNT(trans_id) as total_trans FROM trans GROUP BY account_id HAVING total_trans >= 193 ORDER BY total_trans),
good_status AS
(SELECT status, account_id FROM loan WHERE status = 'A' or status = 'C'),
district_info AS
(SELECT * FROM account JOIN district WHERE account.district_id = district.A1)
SELECT district_info.A2, COUNT(A2) OVER (partition by A2) FROM freq
LEFT JOIN good_status ON freq.account_id = good_status.account_id
JOIN district_info ON district_info.account_id = good_status.account_id
ORDER BY COUNT(A2) OVER (partition by A2) DESC;

-- Total good frequent and status clients in Hl.m. Praha: 39 in total. these can be considered not only 'good', but 'great clients', since their stable demographic features make them even more reliable to the bank. 
WITH freq AS
(SELECT account_id, COUNT(trans_id) as total_trans FROM trans GROUP BY account_id HAVING total_trans >= 193 ORDER BY total_trans),
good_status AS
(SELECT * FROM loan WHERE status = 'A' or status = 'C'),
district_info AS
(SELECT * FROM account JOIN district WHERE account.district_id = district.A1 HAVING A2 = 'Hl.m. Praha')
SELECT * FROM freq
JOIN good_status ON freq.account_id = good_status.account_id
JOIN district_info ON district_info.account_id = good_status.account_id;

-- From the 39 great clients above, all of them already have loans. 
-- AVG loan amount = 110205.2308 X 151410.1760 all clients
-- AVG loan duration = 30.7 X 36.5 all clients

WITH freq AS
(SELECT account_id, COUNT(trans_id) as total_trans FROM trans GROUP BY account_id HAVING total_trans >= 193),
good_status AS
(SELECT * FROM loan WHERE status = 'A' or status = 'C'),
district_info AS
(SELECT * FROM account JOIN district WHERE account.district_id = district.A1 HAVING A2 = 'Hl.m. Praha')
SELECT COUNT(*) FROM freq
JOIN good_status ON freq.account_id = good_status.account_id
JOIN district_info ON district_info.account_id = good_status.account_id
WHERE good_status.loan_id IS NOT NULL;

-- card types: many classic, junior and gold cards for loan status = A and C 
SELECT card.type, loan.status, COUNT(*) OVER(PARTITION BY status, type) as CONT FROM loan 
JOIN disp ON disp.account_id = loan.account_id
JOIN card ON disp.disp_id = card.disp_id ORDER BY CONT DESC;

-- --------------  BAD CLIENT 
-- frequency: < 193 transactions (avg/cliente = 193)
WITH a AS 
(SELECT account_id, COUNT(trans_id) as total_trans FROM trans GROUP BY account_id ORDER BY total_trans ASC)
SELECT account_id, total_trans, AVG(total_trans) OVER() AS trans_average FROM a;

-- if there is a loan, loan status = B and D
SELECT account_id, status FROM loan WHERE status = 'B' or status = 'D';
SELECT COUNT(account_id), status FROM loan WHERE status = 'B' or status = 'D' group by STATUS;

-- card types: just a few cards for loan status = B and C
SELECT card.type, loan.status, COUNT(*) OVER(PARTITION BY status, type) as CONT FROM loan 
JOIN disp ON disp.account_id = loan.account_id
JOIN card ON disp.disp_id = card.disp_id ORDER BY CONT ASC;
