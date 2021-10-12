-- 1. 2020년 12월 25일이 무슨 요일인지 조회하시오.
SELECT TO_CHAR(TO_DATE('20201225', 'RRRRMMDD'), 'DAY')
FROM DUAL;

-- 2. 주민번호가 60년대 생이면서 성별이 여자이고, 
-- 성이 김씨인 직원들의 
-- 사원명, 주민번호, 부서명, 직급명을 조회하시오.

-- 오라클 전용구문
SELECT EMP_NAME 사원명, EMP_NO 주민번호, DEPT_NAME 부서명, JOB_TITLE 직급명
FROM EMPLOYEE E,
        DEPARTMENT D,
        JOB J
WHERE E.DEPT_ID = D.DEPT_ID(+)
AND E.JOB_ID = J.JOB_ID(+)
AND SUBSTR(EMP_NO, 1, 2) LIKE '6%'
AND SUBSTR(EMP_NO, 8) LIKE '2%' 
AND SUBSTR(EMP_NAME, 1) LIKE '김%';

-- ANSI 표준구문
SELECT EMP_NAME 사원명, EMP_NO 주민번호, DEPT_NAME 부서명, JOB_TITLE 직급명
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN JOB USING (JOB_ID)
WHERE /*SUBSTR(EMP_NO, 1, 2)*/ EMP_NO LIKE '6%'
AND /*SUBSTR(EMP_NO, 8)*/ SUBSTR(EMP_NO, 8, 1) IN ('2', '4') 
AND /*SUBSTR(EMP_NAME, 1)*/ EMP_NAME LIKE '김%';

-- 3. 가장 나이가 적은 직원의 
-- 사번, 사원명, 나이, 부서명, 직급명을 조회하시오. (JOIN, GROUP BY, HAVING 모두 다 사용)
-- 나이의 최소값 조회
SELECT MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) 나이
FROM EMPLOYEE;

-- 조회한 나이의 최소값을 이용해 직원의 정보 조회함
-- outer join 필요함.
-- 오라클 전용구문
SELECT EMP_ID 사번, EMP_NAME 이름, 
            MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) 나이, 
            DEPT_NAME 부서명, JOB_TITLE 직급명
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) = 31;

-- ANSI 표준구문
SELECT EMP_ID 사번, EMP_NAME 이름, 
            MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) 나이, 
            DEPT_NAME 부서명, JOB_TITLE 직급명
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) = 31;

-- 서브쿼리를 사용할 경우
SELECT EMP_ID 사번, EMP_NAME 이름, 
            MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) 나이, 
            DEPT_NAME 부서명, JOB_TITLE 직급명
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) =
            (SELECT MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) 나이
            FROM EMPLOYEE);

-- 인라인 뷰와 RANK() 함수 사용
SELECT 사번, 이름, 나이, 부서명, 직급명
FROM (SELECT EMP_ID 사번, EMP_NAME 이름, 
                TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12) 나이,
                DEPT_NAME 부서명, JOB_TITLE 직급명,
                RANK() OVER (ORDER BY TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12) ASC) 순위
        FROM EMPLOYEE
        LEFT JOIN JOB USING (JOB_ID)
        LEFT JOIN DEPARTMENT USING (DEPT_ID))
WHERE 순위 = 1; --  TOP-1 분석

-- 4. 이름에 '성'자가 들어가는 직원들의 
-- 사번, 사원명, 부서명을 조회하시오.
-- 오라클 전용구문
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_NAME 부서명
FROM EMPLOYEE E,
        DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID(+)
AND EMP_NAME LIKE '%성%';

-- ANSI 표준구문
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_NAME 부서명
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE EMP_NAME LIKE '%성%';

-- 5. 해외영업팀에 근무하는 
-- 사원명, 직급명, 부서코드, 부서명을 조회하시오.
-- 오라클 전용구문
SELECT EMP_NAME 사원명, JOB_TITLE 직급명, E.DEPT_ID 부서코드, DEPT_NAME 부서명 
FROM EMPLOYEE E,
        DEPARTMENT D,
        JOB J
WHERE E.DEPT_ID = D.DEPT_ID(+)
AND E.JOB_ID = J.JOB_ID(+)
AND DEPT_NAME LIKE '해외영업%'
ORDER BY 4;

-- ANSI 표준구문
SELECT EMP_NAME 사원명, JOB_TITLE 직급명, DEPT_ID 부서코드, DEPT_NAME 부서명 
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING(DEPT_ID)
LEFT JOIN JOB USING (JOB_ID)
WHERE DEPT_NAME LIKE '해외영업%'
ORDER BY 4;

-- 6. 보너스포인트를 받는 직원들의 
-- 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
-- 오라클 전용구문
SELECT EMP_NAME 사원명, BONUS_PCT 보너스포인트, DEPT_NAME 부서명, LOC_DESCRIBE 근무지역명  
FROM EMPLOYEE E,
        DEPARTMENT D,
        LOCATION L
WHERE E.DEPT_ID = D.DEPT_ID(+)
AND D.LOC_ID = L.LOCATION_ID(+)
AND (BONUS_PCT IS NOT NULL OR BONUS_PCT != 0.0); -- 연산자 우선순위 신경써야함. 안그러면 결과가 완전히 달라짐.

-- ANSI 표준구문
SELECT EMP_NAME 사원명, BONUS_PCT 보너스포인트, DEPT_NAME 부서명, LOC_DESCRIBE 근무지역명 
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING(DEPT_ID)
LEFT JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE BONUS_PCT IS NOT NULL OR BONUS_PCT != 0.0;

-- 7. 부서코드가 20인 직원들의 
-- 사원명, 직급명, 부서명, 근무지역명을 조회하시오.
-- 오라클 전용구문
SELECT EMP_NAME 사원명, JOB_TITLE 직급명, DEPT_NAME 부서명, LOC_DESCRIBE 근무지역명  
FROM EMPLOYEE E,
        JOB J,
        DEPARTMENT D,
        LOCATION L
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
AND D.LOC_ID = L.LOCATION_ID(+)
AND E.DEPT_ID = '20';

-- ANSI 표준구문
SELECT EMP_NAME 사원명, JOB_TITLE 직급명, DEPT_NAME 부서명, LOC_DESCRIBE 근무지역명 
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING(DEPT_ID)
LEFT JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE DEPT_ID = '20';

-- 8. 직급별 연봉의 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉은 보너스포인트를 적용하시오.
-- 오라클 전용구문
SELECT EMP_NAME 사원명, JOB_TITLE 직급명, SALARY 급여, (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 연봉
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID(+)  
AND (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 > MIN_SAL;

-- ANSI 표준구문
SELECT EMP_NAME 사원명, JOB_TITLE 직급명, SALARY 급여, (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 연봉
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 > MIN_SAL;


-- 9 . 한국(KO)과 일본(JP)에 근무하는 직원들의 
-- 사원명(emp_name), 부서명(dept_name), 지역명(loc_describe),
--  국가명(country_name)을 조회하시오.
-- 오라클 전용구문
SELECT EMP_NAME 사원명, DEPT_NAME 부서명, LOC_DESCRIBE 지역명, COUNTRY_NAME 국가명
FROM EMPLOYEE E,
            DEPARTMENT D,
            LOCATION L,
            COUNTRY C
WHERE E.DEPT_ID = D.DEPT_ID 
AND D.LOC_ID = L.LOCATION_ID
AND L.COUNTRY_ID = C.COUNTRY_ID
AND L.COUNTRY_ID IN ('KO', 'JP');

-- ANSI 표준구문
SELECT EMP_NAME 사원명, DEPT_NAME 부서명, LOC_DESCRIBE 지역명, COUNTRY_NAME 국가명
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
JOIN COUNTRY USING (COUNTRY_ID)
WHERE COUNTRY_ID IN ('KO', 'JP');

-- 10. 같은 부서에 근무하는 직원들의 
-- 사원명, 부서코드, 동료이름, 부서코드를 조회하시오.
-- self join 사용
-- 오라클 전용구문
SELECT DISTINCT E.EMP_NAME 사원명, E.DEPT_ID 부서코드, M.EMP_NAME 동료이름, M.DEPT_ID 부서코드
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.DEPT_ID = M.DEPT_ID
AND E.EMP_NAME != M.EMP_NAME
ORDER BY 2;

-- ANSI 표준구문 : 테이블 별칭 사용시에는 ON 사용함
SELECT E.EMP_NAME 사원명, E.DEPT_ID 부서코드, M.EMP_NAME 동료이름, M.DEPT_ID 부서코드
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.DEPT_ID = M.DEPT_ID)
WHERE E.EMP_NAME != M.EMP_NAME
ORDER BY 2;

-- 11. 보너스포인트가 없는 직원들 중에서 
-- 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 오라클 전용구문
SELECT EMP_NAME 사원명, JOB_TITLE 직급명, SALARY 급여
FROM EMPLOYEE E,
            JOB J
WHERE E.JOB_ID = J.JOB_ID(+) 
AND (BONUS_PCT IS NULL OR BONUS_PCT = 0.0) 
AND E.JOB_ID IN ('J4', 'J7');

-- ANSI 표준구문
SELECT EMP_NAME 사원명, JOB_TITLE 직급명, SALARY 급여
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE (BONUS_PCT IS NULL OR BONUS_PCT = 0.0) 
AND JOB_ID IN ('J4', 'J7');

-- 12. 소속부서가 50 또는 90인 직원중 
-- 기혼인 직원과 미혼인 직원의 수를 조회하시오.
SELECT DECODE(MARRIAGE, 'Y', '기혼', '미혼') 결혼여부, COUNT(*) 직원수
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90')
GROUP BY DECODE(MARRIAGE, 'Y', '기혼', '미혼')
ORDER BY 1;
