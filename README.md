# SQL_CzechBankCase
 
# Project Goal and Description
 The main goal of this case study was to identify good X bad clients in a financial data set so new services could be suggested to the bank.
  
# Technologies 
  - SQL

# Steps and Analysis
SQL queries were made and analyzed as described below.
 - 'Good clients' might have certain features:
 1. Good frequency: more than the 193 average number of transactions/client (1976 clients);
 2. Good loan status: A (contract finished, no problems) and C (running contract, OK so far) (606 clients);
 - When 1 and 2 are combined, we are left with 313 good clients; 
 - Most of the good clients are from 'Hl.m. Praha' (39 clients), a district with promising demographic features: 100% urban, the highest average salary (12541; min 8110 - max 12541) and the lowest unemployment rate (0.43; min 0.43 - max 9.4). Therefore, these can be considered not only 'good', but 'great clients', since their stable demographic features make them even more reliable for the bank. 
 - All 'great clients' already have loans, which do not differ much in terms of average amount and duration from all the clients with loans (110205.2308 X 151410.1760 and 30.7 X 36.5, respectively);
 - 'Bad clients', on the other hand, are the ones with less than the 193 average number of transactions/client and loan status = B (contract finished, loan not paid) and D (running contract, client in debt). These were not the main focus for in this study, since new services might be suggested to 'good' and 'great' clients. 

# Conclusions
From the above analysis, a few services and actions are suggested to the bank:
- 'Good clients' could have an exclusive service support line and yearly receive a 'congratulations' card for their status, so they feel like keeping it that way; 
- 'Good clients' could have higher loans available, since their behavior (good frequency and good loan status) make them reasonably reliable;
- 'Great clients' could have even higher loans available and more time to pay, since their behavior (good frequency and good loan status) and demographic features make them even more reliable; 
- There could be more physical units of the bank where 'great clients' are and more advertisement in the area (Hl.m. Praha District) to bring more of these clients to the bank;
- Other clients who are not in these categories could be informed how to be a 'good client' and the benefits of it.
   
# Contact
- LinkedIn: vanessadechen
- GitHub: /vdechen
- Email: vanessadechen@gmail.com
