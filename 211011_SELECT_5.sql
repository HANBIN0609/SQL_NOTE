-- DAY6_SELECT5

-- ORDER BY 절 ------------------------------------------------------------------------------------------------------
-- 사용형식 : ORDER BY 정렬기준1 정렬조건, 정렬기준2 정렬조건, ...
-- 사용위치 : SELECT 구문 가장 마지막에 사용함
-- 실행순서도 가장 마지막에 작동됨
-- 정렬기준 : SELECT 절에 정렬된 컬럼명 | 컬럼별칭 | 컬럼나열순번 (1부터 시작함)
-- 정렬조건 : ASC(오름차순, 기본값이므로 생략할 수 있음), DESC(내림차순)
-- 첫번째 정렬 후에 정렬기준 컬럼값에 같은 값이 있을 때, 두번째 정렬기준으로 같은 값이 있는 행들만 재정렬할 수 있음

-- 직원 정보에서 부서코드가 50이거나 NULL인 직원들 조회
-- 이름, 급여 조회
-- 급여기준 내림차순정렬하고, 같은 급여에 대해서는 이름기준 오름차순정렬 처리함
SELECT EMP_NAME 이름, SALARY 급여
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL
ORDER BY SALARY DESC, EMP_NAME ASC;
-- ORDER BY 급여 DESC, 이름;
-- ORDER BY 2 DESC, 1;

-- 2003년 1월 1일 이후 입사한 직원 조회
-- 이름, 입사일, 부서코드, 급여 : 별칭
-- 부서코드 기준 내림차순정렬하고, 같은 부서코드일때는 입사일 기준 오름차순정렬, 입사일이 같으면 이름 기준 오름차순정렬 처리함
SELECT EMP_NAME 이름, HIRE_DATE 입사일, DEPT_ID 부서코드, SALARY 급여
FROM EMPLOYEE
WHERE HIRE_DATE >= TO_DATE('20030101', 'RRRRMMDD')
ORDER BY DEPT_ID DESC NULLS LAST, HIRE_DATE, EMP_NAME; -- NULLS FIRST/LAST 를 이용하여 NULL 의 표시 위치 변경 가능
-- ORDER BY 부서코드 DESC, 입사일, 이름;
-- ORDER BY 3 DESC, 2, 1;

-- ORDER BY 절의 NULL 위치 조정 구문
-- ORDER BY 정렬기준 정렬조건 NULLS LAST : NULL 이 있는 행을 아래에 배치
-- [기본] : ORDER BY 정렬기준 정렬조건 NULLS FIRST : NULL 이 있는 행을 위쪽에 배치

-- GROUP BY 절--------------------------------------------------------------------------------------------------------
-- 같은 값들이 여러 개 기록된 컬럼에 대해 그룹을 묶을 수 있음
-- 사용형식 : GROUP BY 컬럼명 | 그루핑을 위한 계산식
-- 사용목적 : 같은 값들을 그룹별로 묶어서 각각 그룹함수를 적용하기 위해 사용
-- 사용위치 : WHERE 절 아래에 사용함
-- 실행순서 : WHERE 절 다음에 실행됨
-- SELECT 절 전에 GROUP BY 절이 실행되므로 SELECT 절의 별칭과 순번은 사용할 수 없음

-- 기록값 확인
SELECT EMP_NAME, SALARY, DEPT_ID
FROM EMPLOYEE;

SELECT DISTINCT DEPT_ID 
FROM EMPLOYEE;

-- 부서별 급여 합계 조회
SELECT DEPT_ID 부서코드, SUM(SALARY) "부서별 급여합계"
FROM EMPLOYEE
GROUP BY DEPT_ID
ORDER BY 부서코드 NULLS LAST;

-- 직급별 급여의 합계 조회, 급여의 평균, 직원수 조회
-- 급여의 평균은 천단위에서 반올림 처리 
-- 직급코드에 대해 오름차순 정렬(NULL은 아래쪽에 배치)
SELECT JOB_ID 직급코드, SUM(SALARY) 직급별급여합계,
            ROUND(AVG(SALARY), -4) 직급별급여평균, 
            COUNT(*) 직원수 -- COUNT(JOB_ID)를 사용하게 되면 NULL 칸은 계산되지 않기 때문에 * 을 쓰는게 맞음
FROM EMPLOYEE
GROUP BY JOB_ID
ORDER BY JOB_ID NULLS LAST;

-- GROUP BY 절에는 그룹핑을 위한 계산식을 사용할 수도 있음
-- 직원 정보에서 성별별 급여합계, 급여평균(천단위에서 반올림함), 직원수 조회
-- 성별에 대해 오름차순 정렬 처리함
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남자', '3', '남자', '여자') 성별,
            SUM(SALARY),
            ROUND(AVG(SALARY), -4) 급여평균,
            COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남자', '3', '남자', '여자')
ORDER BY 성별;

-- GROUP BY 한 계산값들 중에서 조건을 만족하는 값을 골라내야 될 때는?
-- 예 : 부서별 급여합계 중 가장 큰 값에 대한 부서코드와 급여합계 조회
SELECT /*DEPT_ID, MAX(SUM(SALARY))*/ -- 7행, 1행 -> 결과행의 갯수가 다름, ERROR
            DEPT_ID, 
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- HAVING 절 ----------------------------------------------------------------------------------
-- GROUP BY 절 다음 위치에 사용
-- 그룹핑한 값들에 대해 그룹함수 적용 결과값에 대한 조건처리를 위해 사용
-- 사용형식 : HAVING 그룹함수(그룹핑한 컬럼명) 비교연산자 비교값

-- 부서별 급여합계 중 가장 큰 값에 대한 부서코드와 급여합계 조회
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID
HAVING SUM(SALARY) = 18100000;
-- HAVING SUM(SALARY) = MAX(SUM(SALARY)); -- ERROR : 서브쿼리로 해결
/*HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY)) -- 서브쿼리 
                                        FROM EMPLOYEE
                                        GROUP BY DEPT_ID);*/

-- 부서별 급여합계 값이 9백만을 초과하는 부서와 급여합계를 조회
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID
HAVING SUM(SALARY) > 9000000;

-- 분석 함수(Analytic Function) ------------------------------------------------------------------------
-- 일반함수와 사용형식이 다름

-- RANK( ) 함수 : 해당 컬럼의 전체 값들에서의 값의 순위(등수) 반환함
-- 컬럼값에 등수(순위) 매길 때 사용함
-- 사용법 1 : 값 전체에 순위를 매기는 경우
--                RANK() OVER (ORDER BY 순위매길 컬럼명 정렬방식)
-- 사용법 2 : 특정 값의 순위만 조회할 경우
--                RANK(순위를 알고자 하는 값) WITHIN GROUP (ORDER BY 순위매길 컬럼명 정렬방식)

-- 1. 급여를 많이 받는 순으로 순위를 매긴다면?
SELECT EMP_NAME, SALARY,
            RANK() OVER (ORDER BY SALARY DESC) 순위
FROM EMPLOYEE
ORDER BY 순위;

-- 2. 급여 230만이 내림차순정렬했을 때 전체 급여 중 몇 순위?
SELECT RANK(2300000) WITHIN GROUP (ORDER BY SALARY DESC) 해당순위
FROM EMPLOYEE;

-- ROLLUP( ) 함수
-- GROUP BY 절에서만 사용할 수 있음
-- 그룹별로 묶어서 계산한 결과에 대한 총 집계와 중간 집계를 표현할 때 사용함
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID;

SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_ID);

SELECT DEPT_ID, SUM(SALARY), MAX(SALARY), MIN(SALARY), ROUND(AVG(SALARY), -4)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID); -- 마지막에 NULL 로 표기되는 값은 총 집계에 해당함

-- 실습 : 부서코드와 직급코드를 함께 그룹을 묶고, 급여의 합계를 구함
-- ROLLUP 사용함
-- NULL 칸은 제외함
SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL 
GROUP BY ROLLUP(DEPT_ID, JOB_ID); -- 중간에 섞인 JOB_ID의 NULL 값은 해당 부서 급여의 합, 즉, 중간 집계에 해당함

SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL 
GROUP BY ROLLUP(DEPT_ID), ROLLUP(JOB_ID); -- 부서별 중간집계 먼저, 그다음은 직업코드별 중간집계 나옴


SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL 
GROUP BY ROLLUP(JOB_ID), ROLLUP(DEPT_ID); -- 직업코드별 중간집계 먼저, 그다음은 부서별 중간집계 나옴


SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL 
GROUP BY CUBE(DEPT_ID, JOB_ID); -- 총 집계가 제일 위에 나타남

-- ROWID
-- 테이블에 데이터 기록 저장시 (INSERT 문으로 행 추가시) 자동으로 부여됨
-- DBMS 가 자동으로 관리함. 사용자가 수정은 못하지만 조회, 확인은 가능
SELECT  EMP_ID, ROWID
FROM EMPLOYEE;

-- ************************************************************************************************
-- 조인 (JOIN)
-- 여러 개의 테이블을 하나로 합쳐서 큰 테이블을 만든 다음 필요한 컬럼들을 조회하는 방식
-- 오라클 전용구문과 ANSI 표준구문으로 작성할 수 있음
-- 조인은 기본이 EQUAL JOIN 임 : 각 테이블의 같은 값을 가진 컬럼을 이용해서, 일치하는 값끼리 연결하는 구조

-- 오라클 전용구문 : 오라클에서만 사용함
-- 조인할 테이블을 FROM 절에 나열함 FROM 테이블명1, 테이블명2, .....
-- 합칠 조건을 WHERE 절에 작성함 -> WHERE 테이블명1.컬럼명 = 테이블명2.컬럼명 
SELECT *
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DEPT_ID = DEPARTMENT.DEPT_ID; -- RESULT SET : 20행 / EMPLOYEE 의 DEPT_ID 가 NULL 인 직원은 조인에서 제외됨
-- WHERE DEPT_ID = DEPT_ID; -> ERROR, 어느 테이블에 속한 컬럼인지 명시해야함

-- 조인시 테이블명에도 별칭(ALIAS)을 붙일 수 있음
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

-- 직원이름과 부서명을 조회
SELECT EMP_NAME 직원명, DEPT_NAME 부서명
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

-- ANSI 표준구문
-- 모든 DBMS 가 공통으로 사용하는 표준구문임
-- 조인 처리를 위한 구문을 FROM 절 바로 아래에 별도로 작성함 
SELECT *
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID);

-- 직원이름, 부서코드, 부서명 조회
SELECT EMP_NAME 직원이름, DEPT_ID 부서코드, DEPT_NAME 부서명
FROM EMPLOYEE
/*INNER*/ JOIN DEPARTMENT USING (DEPT_ID); -- INNER 는 생략가능

-- JOIN USING : 두 테이블을 연결할 컬럼명이 같을 때 사용
-- JOIN ON : 두 테이블을 연결할 컬럼명이 다를 때 사용. *단, 값은 일치해야함*
SELECT *
FROM DEPARTMENT
JOIN LOCATION ON (LOC_ID = LOCATION_ID); -- 합친 결과가 오라클 전용구문과 같음

SELECT *
FROM DEPARTMENT D, LOCATION L
WHERE D.LOC_ID = L.LOCATION_ID;

-- 부서코드, 부서명, 근무지역명 조회
SELECT DEPT_ID 부서코드, DEPT_NAME 부서명, LOC_DESCRIBE 근무지역명
FROM DEPARTMENT
JOIN LOCATION ON (LOC_ID = LOCATION_ID);

SELECT DEPT_ID 부서코드, DEPT_NAME 부서명, LOC_DESCRIBE 근무지역명
FROM DEPARTMENT D, LOCATION L
WHERE D.LOC_ID = L.LOCATION_ID;

-- 실습 : 사번, 이름, 직급명 조회
-- 오라클 전용구문
SELECT EMP_ID 사번, EMP_NAME 이름, E.JOB_ID 직급코드, JOB_TITLE 직급명
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID;

-- ANSI 표준구문
SELECT EMP_ID 사번, EMP_NAME 이름, JOB_ID 직급코드, JOB_TITLE 직급명
FROM EMPLOYEE
JOIN JOB USING (JOB_ID);

-- INNER JOIN :
-- 조인은 기본이 INNER EQUAL JOIN 임 (EQU JOIN 이라고도 함)
-- 조인으로 연결되는 컬럼의 값이 일치하는 행들만 조인이 됨
-- 일치하는 값이 없는 행은 조인에서 제외됨

-- 만약, 일치하는 값이 없는 행도 조인의 결과에 포함시키고 싶다면? -> OUTER EQUAL JOIN 사용하면 됨
-- OUTER JOIN 이라고 함 (EQUAL JOIN 임 -> 테이블에 없는 행을 추가해서 EQUAL 이 되게 억지로 만들고 조인하는 방식임)

-- OUTER JOIN ----------------------------------------------------------------------------
-- EMPLOYEE 테이블이 가진 모든 행(직원 전체)을 조인에 포함시키고자 할 경우
-- 오라클 전용구문
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID(+); -- 없는 쪽에 (+) 추가

-- ANSI 표준구문
SELECT *
FROM EMPLOYEE 
LEFT /*OUTER*/ JOIN DEPARTMENT USING (DEPT_ID); 

-- DEPARTMENT 테이블이 가진 모든 행을 조인에 포함시키고자 할 경우
-- 오라클 전용구문
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID; -- 없는 쪽에 (+) 추가

-- ANSI 표준구문
SELECT *
FROM EMPLOYEE 
RIGHT /*OUTER*/ JOIN DEPARTMENT USING (DEPT_ID); 

--두 테이블의 일치하지 않는 행을 모두 조인에 포함시키고자 할 경우
-- FULL OUTER JOIN 사용

-- ANSI 표준구문
SELECT *
FROM EMPLOYEE
FULL /*OUTER*/ JOIN DEPARTMENT USING (DEPT_ID); -- RESULT SET : 23행

-- 오라클 전용구문은 FULL OUTER JOIN 을 표현할 수 없음
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID(+); -- ERROR

-- 조인의 결과에서 제외된 값을 전부 다 포함시키고 싶을 때 OUTER JOIN 사용(OUTER는 생략가능)
-- JOIN 기준 왼쪽 값을 다 넣고싶으면 LEFT JOIN, 오른쪽 값을 다 넣고싶으면 RIGHT JOIN
-- 양 테이블 모두 넣고싶으면 FULL OUTER JOIN 사용

-- CROSS JOIN --------------------------------------------------------------------------------------------
-- 두 테이블을 연결할 컬럼이 없는 경우에 사용함
-- N개 행 X M개 행 의 결과가 만들어짐

-- ANSI 표준구문
SELECT *
FROM LOCATION
CROSS JOIN COUNTRY;

-- 오라클 전용구문
SELECT *
FROM LOCATION, COUNTRY;

-- NON EQUAL JOIN ***************************************************************************
-- 지정하는 컬럼의 값이 일치하는 경우가 아닌, 값의  해당되는 행들을 연결하는 방식의 조인

-- 직원들의 급여에 대한 급여등급을 매기고자 할 경우
-- EMPLOYEE, SAL_GRADE NON-EQU JOIN
SELECT *
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN LOWEST AND HIGHEST);

-- SELF JOIN -----------------------------------------------------------------------------------
-- 같은 테이블을 두번 조인하는 경우
-- 같은 테이블 안의 다른 컬럼을 외래키(FOREIGN KEY)로 참조하고 있는 경우에 사용할 수 있음
-- EMP_ID : 직원의 사번, MGR_ID : 관리자인 직원의 사번 (EMP_ID 를 참조함)
-- 직원중에 관리자인 직원을 의미함 : MGR_ID

-- ANSI 표준구문 : 테이블 별칭 사용해야 함, JOIN ON 사용
SELECT *
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID); -- 관리자가 있는직원, 오른쪽에는 해당 직원의 관리자 테이블 표현됨

-- 오라클 전용구문
SELECT *
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MGR_ID = M.EMP_ID;

-- 직원 이름과 관리자 이름 조회
-- ANSI 표준구문
SELECT E.EMP_NAME 직원이름, M.EMP_NAME 관리자이름
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID);

-- 오라클 전용구문
SELECT E.EMP_NAME 직원이름, M.EMP_NAME 관리자이름
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MGR_ID = M.EMP_ID;

-- N 개의 테이블 조인 : 조인 순서가 중요함
-- 첫번째와 두번재가 조인되고 나서, 조인결과에 세번째가 조인되는 구조임
SELECT EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING(DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
JOIN COUNTRY USING(COUNTRY_ID);

-- 직급이 대리이면서, 아시아지역에 근무하는 직원 조회
-- 사번, 이름, 직급명, 부서명, 근무지역명, 급여
-- 오라클 전용구문 :
SELECT EMP_ID 사번, EMP_NAME 이름, JOB_TITLE 직급명, DEPT_NAME 부서명, LOC_DESCRIBE 근무지역명, SALARY 급여
FROM EMPLOYEE E,
            JOB J,
            DEPARTMENT D,
            LOCATION L
WHERE E.JOB_ID = J.JOB_ID
AND E.DEPT_ID = D.DEPT_ID
AND D.LOC_ID = L.LOCATION_ID
AND JOB_TITLE = '대리' AND LOC_DESCRIBE LIKE '아시아%';

-- ANSI 전용구문 : 
SELECT EMP_ID 사번, EMP_NAME 이름, JOB_TITLE 직급명, DEPT_NAME 부서명, LOC_DESCRIBE 근무지역명, SALARY 급여
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING(DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE JOB_TITLE = '대리' AND LOC_DESCRIBE LIKE '아시아%';

-- JOIN 연습문제

-- 1. 2020년 12월 25일이 무슨 요일인지 조회하시오.
SELECT TO_CHAR(TO_DATE('20201225', 'RRRRMMDD'), 'YYYY"년" MM"월" DD"일" DY"요일"')
FROM DUAL;

-- 2. 주민번호가 60년대 생이면서 성별이 여자이고, 
-- 성이 김씨인 직원들의 
-- 사원명, 주민번호, 부서명, 직급명을 조회하시오.

-- 오라클 전용구문
SELECT EMP_NAME 사원명, EMP_NO 주민번호, DEPT_NAME 부서명, JOB_TITLE 직급명
FROM EMPLOYEE E,
        DEPARTMENT D,
        JOB J
WHERE E.DEPT_ID = D.DEPT_ID
AND E.JOB_ID = J.JOB_ID
AND SUBSTR(EMP_NO, 1, 2) LIKE '6%'
AND SUBSTR(EMP_NO, 8) LIKE '2%' 
AND SUBSTR(EMP_NAME, 1) LIKE '김%';

-- ANSI 표준구문
SELECT EMP_NAME 사원명, EMP_NO 주민번호, DEPT_NAME 부서명, JOB_TITLE 직급명
FROM EMPLOYEE 
JOIN DEPARTMENT USING(DEPT_ID)
JOIN JOB USING (JOB_ID)
WHERE SUBSTR(EMP_NO, 1, 2) LIKE '6%'
AND SUBSTR(EMP_NO, 8) LIKE '2%' 
AND SUBSTR(EMP_NAME, 1) LIKE '김%';

-- 3. 가장 나이가 적은 직원의 
-- 사번, 사원명, 나이, 부서명, 직급명을 조회하시오. (JOIN, GROUP BY, HAVING 모두 다 사용)
-- 나이의 최소값 조회
-- 조회한 나이의 최소값을 이용해 직원의 정보 조회함
-- outer join 필요함.
-- 오라클 전용구문


-- ANSI 표준구문


-- 4. 이름에 '성'자가 들어가는 직원들의 
-- 사번, 사원명, 부서명을 조회하시오.
-- 오라클 전용구문
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_NAME 부서명
FROM EMPLOYEE E,
        DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID
AND SUBSTR(EMP_NAME, 1) LIKE '%성%';

-- ANSI 표준구문
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_NAME 부서명
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
WHERE SUBSTR(EMP_NAME, 1) LIKE '%성%';

-- 5. 해외영업팀에 근무하는 
-- 사원명, 직급명, 부서코드, 부서명을 조회하시오.
-- 오라클 전용구문
SELECT EMP_NAME 사원명, JOB_TITLE 직급명, E.DEPT_ID 부서코드, DEPT_NAME 부서명 
FROM EMPLOYEE E,
        DEPARTMENT D,
        JOB J
WHERE E.DEPT_ID = D.DEPT_ID
AND E.JOB_ID = J.JOB_ID
AND DEPT_NAME LIKE '해외영업%';

-- ANSI 표준구문
SELECT EMP_NAME 사원명, JOB_TITLE 직급명, DEPT_ID 부서코드, DEPT_NAME 부서명 
FROM EMPLOYEE
JOIN DEPARTMENT USING(DEPT_ID)
JOIN JOB USING (JOB_ID)
WHERE DEPT_NAME LIKE '해외영업%';

-- 6. 보너스포인트를 받는 직원들의 
-- 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
-- 오라클 전용구문
SELECT EMP_NAME 사원명, BONUS_PCT 보너스포인트, DEPT_NAME 부서명, LOC_DESCRIBE 근무지역명  
FROM EMPLOYEE E,
        DEPARTMENT D,
        LOCATION L
WHERE E.DEPT_ID = D.DEPT_ID
AND D.LOC_ID = L.LOCATION_ID
AND BONUS_PCT IS NOT NULL;

-- ANSI 표준구문
SELECT EMP_NAME 사원명, BONUS_PCT 보너스포인트, DEPT_NAME 부서명, LOC_DESCRIBE 근무지역명 
FROM EMPLOYEE
JOIN DEPARTMENT USING(DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE BONUS_PCT IS NOT NULL;

-- 7. 부서코드가 20인 직원들의 
-- 사원명, 직급명, 부서명, 근무지역명을 조회하시오.
-- 오라클 전용구문
SELECT EMP_NAME 사원명, JOB_TITLE 직급명, DEPT_NAME 부서명, LOC_DESCRIBE 근무지역명  
FROM EMPLOYEE E,
        JOB J,
        DEPARTMENT D,
        LOCATION L
WHERE E.JOB_ID = J.JOB_ID
AND E.DEPT_ID = D.DEPT_ID
AND D.LOC_ID = L.LOCATION_ID
AND E.DEPT_ID = '20';

-- ANSI 표준구문
SELECT EMP_NAME 사원명, JOB_TITLE 직급명, DEPT_NAME 부서명, LOC_DESCRIBE 근무지역명 
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING(DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE DEPT_ID = '20';

-- 8. 직급별 연봉의 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉은 보너스포인트를 적용하시오.
-- 오라클 전용구문

-- ANSI 표준구문
SELECT JOB_TITLE, SALARY > MIN(SALARY)
FROM EMPLOYEE 
JOIN JOB USING (JOB_ID)
GROUP BY JOB_TITLE
HAVING SALARY > MIN_SAL;

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
AND C.COUNTRY_ID IN ('KO', 'JP');

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
AND E.EMP_NAME != M.EMP_NAME;

-- ANSI 표준구문
SELECT E.EMP_NAME 사원명, E.DEPT_ID 부서코드, M.EMP_NAME 동료이름, M.DEPT_ID 부서코드
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.DEPT_ID = M.DEPT_ID)
WHERE E.EMP_NAME != M.EMP_NAME;

-- 11. 보너스포인트가 없는 직원들 중에서 
-- 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 오라클 전용구문
SELECT EMP_NAME 사원명, JOB_TITLE 직급명, SALARY 급여
FROM EMPLOYEE E,
            JOB J
WHERE E.JOB_ID = J.JOB_ID 
AND BONUS_PCT IS NULL 
AND E.JOB_ID IN ('J4', 'J7');

-- ANSI 표준구문
SELECT EMP_NAME 사원명, JOB_TITLE 직급명, SALARY 급여
FROM EMPLOYEE
JOIN JOB USING(JOB_ID)
WHERE BONUS_PCT IS NULL 
AND JOB_ID IN ('J4', 'J7');

-- 12. 소속부서가 50 또는 90인 직원중 
-- 기혼인 직원과 미혼인 직원의 수를 조회하시오.
SELECT DECODE(MARRIAGE, 'Y', '기혼', '미혼') 결혼여부, COUNT(*) 직원수
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90')
GROUP BY DECODE(MARRIAGE, 'Y', '기혼', '미혼');



