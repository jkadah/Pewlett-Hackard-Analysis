--part1
SELECT ts.emp_no, 
	ts.title,
	ts.from_date,
	em.first_name,
	em.last_name,
	sa.salary
INTO part1
FROM titles as ts
RIGHT JOIN employees AS em
ON (ts.emp_no = em.emp_no)
RIGHT JOIN salaries AS sa
ON (ts.emp_no = sa.emp_no)
WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31');

--part 2 
SELECT tmp.first_name, tmp.last_name, tmp.from_date, tmp.title 
INTO part2_challengefinal
FROM
  (SELECT pcf.first_name, pcf.last_name, pcf.from_date, pcf.title,
     ROW_NUMBER() OVER 
(PARTITION BY (pcf.first_name, pcf.last_name) 
 ORDER BY pcf.from_date DESC) rn
   FROM part1_challengefinal AS pcf
  ) tmp WHERE rn = 1;
  
 SELECT COUNT (*), title
 FROM part2_challengefinal
 GROUP BY title;
--export below 
 SELECT COUNT (*), title, from_date
 INTO part2_challenge
 FROM part2_challengefinal
 GROUP BY title, from_date
 ORDER BY from_date DESC;
 
 --part3
SELECT em.emp_no, em.first_name, em.last_name, ts.from_date, ts.to_date, ts.title
INTO part3_challenge
FROM titles AS ts
RIGHT JOIN employees AS em
ON (ts.emp_no = em.emp_no)
WHERE (ts.to_date = '9999-01-01')
	AND (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31');
    