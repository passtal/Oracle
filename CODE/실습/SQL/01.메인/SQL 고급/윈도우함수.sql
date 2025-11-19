-- 윈도우 함수
-- 행과 행 간의 관계를 정의하는 함수
-- 순위 / 합계 / 평균 / 행 위치 등 계산 결과를 사용할 수 있다


-- 순위 함수
-- 결과 집합 내에서 행의 순위를 결정하는 함수


-- RANK ( 공동 순위 다음 SKIP )
-- 동일한 값이 있다면 다음 순위는 건너뛰고 그 다음 순위 부여
SELECT employee_id, salary
     , RANK() 
		OVER (ORDER BY salary DESC) AS salary_rank
FROM employees
;


-- DENSE_RANK ( 공동 순위 다음 이어서 )
-- 동일한 값이 있다면 다음 순위도 그 다음 순위와 동일한 값을 가짐
SELECT employee_id
       ,salary
       ,DENSE_RANK() 
        OVER (ORDER BY salary DESC) AS dense_salary_rank
FROM employees
;


-- ROW_NUMBER ( 넘버링 )
-- 순서대로 숫자를 부여하여 각 행에 대한 유일한 순위를 부여
SELECT employee_id
			,salary
			,ROW_NUMBER() 
				OVER (ORDER BY salary DESC) AS row_num
FROM employees;


-- FIRST_VALUE
SELECT department_id
    , employee_id
    , salary
    ,FIRST_VALUE(salary) 
        OVER (PARTITION BY department_id 
              ORDER BY hire_date) AS first_salary
FROM employees
;


-- LAST_VALUE
SELECT department_id
    , employee_id
    , salary
    , LAST_VALUE(salary) 
        OVER (PARTITION BY department_id 
              ORDER BY hire_date
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_salary
FROM employees
;


-- LAG
SELECT employee_id, first_name, hire_date,
       LAG(first_name) OVER (ORDER BY hire_date) AS previous_name,
       LAG(hire_date) OVER (ORDER BY hire_date) AS previous_hire_date
FROM employees
;


-- LEAD
SELECT employee_id, first_name, hire_date,
       LEAD(first_name) OVER (ORDER BY hire_date) AS next_first_name,
       LEAD(hire_date) OVER (ORDER BY hire_date) AS next_hire_date
FROM employees
;


-- CUME_DIST
SELECT employee_id
    , salary
    , CUME_DIST() 
        OVER (ORDER BY salary DESC) AS cumulative_distribution
FROM employees
;


-- PERCENT_RANK
SELECT employee_id
    , salary
    , PERCENT_RANK() 
        OVER (ORDER BY salary DESC) AS percent_rank
FROM employees
;


-- NTILE
SELECT employee_id
    , salary
    , NTILE(4) 
        OVER (ORDER BY salary DESC) AS quartile
FROM employees
;


-- RATIO_TO_REPORT
SELECT department_id
    , employee_id
    , salary
    , RATIO_TO_REPORT(salary) 
        OVER (PARTITION BY department_id) AS salary_ratio
FROM employees
;

