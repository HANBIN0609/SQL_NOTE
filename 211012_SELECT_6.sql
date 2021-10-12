-- DAY7_SELECT6

-- ****************************************************************************************************************************
-- 집합 연산자 (SET OPERATOR)
-- UNION, UNION ALL, INTERSECT, MINUS
-- 각 SELECT 문의 실행 결과(결과집합 - RESULTSET)를 하나로 표현하기 위해 사용함
-- 합집합 : UNION, UNION ALL - 두 개의 RESULTSET 결과를 하나로 합침
--             UNION (합칠 때 중복행은 하나만 선택함), UNION ALL (중복행을 모두 포함함)
-- 교집합 : INTERSECT - 두 개의 RESULTSET 결과에서 겹치는(중복 일치되는) 행을 선택함
-- 차집합 : MINUS - 첫번째 RESULTSET 결과에서 두번재 RESULTSET 과 겹치는 행을 제외한 나머지

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE -- 22행
UNION -- 25행 (중복행은 1개만 선택)
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY; -- 4행

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE -- 22행
UNION ALL-- 26행 (중복행 다 포함)
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY; -- 4행

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE -- 22행
INTERSECT -- 1행 (중복행 1개)
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY; -- 4행

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE -- 22행
MINUS -- 21행 (첫번째 쿼리에서 두번째 쿼리와 중복되는 행을 뺌)
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY; -- 4행 : 중복행 1개 존재

-- SET 연산자 사용시 주의사항
-- 각 쿼리문의 SELECT 절의 컬럼 갯수와 각 컬럼별 자료형이 반드시 같아야 함
-- 갯수는 더미 컬럼(DUMMY COLUMN - NULL 칸)을 사용할 수 있음

-- 갯수 불일치, 해결 방법
SELECT EMP_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_ID = '20'
UNION
SELECT DEPT_NAME, DEPT_ID, NULL -- DUMMY COLUMN 추가, NULL은 어떤 자료형이든 될 수 있음
FROM DEPARTMENT
WHERE DEPT_ID = '20';

-- 각 컬럼별 자료형 불일치
SELECT EMP_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_ID = '20'
UNION
SELECT NULL, DEPT_NAME, DEPT_ID -- 자료형이 일치하지 않으면 ERROR
FROM DEPARTMENT
WHERE DEPT_ID = '20';

-- 활용 : 각각 조회한  결과를 한 테이블로 보여지게 할 때 주로 이용할 수 있음
-- 50번 부서에 소속된 직원 중 관리자와 일반 직원을 따로 조회해서 하나로 합쳐라.
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = '50';

SELECT EMP_ID, EMP_NAME, '관리자' 구분
FROM EMPLOYEE
WHERE EMP_ID = '141' AND DEPT_ID = '50'
UNION
SELECT EMP_ID, EMP_NAME, '직원' 구분
FROM EMPLOYEE
WHERE EMP_ID != '141' AND DEPT_ID = '50'
ORDER BY 3, 1;

SELECT 'SQL을 공부하고 있습니다.', 3 순서 FROM DUAL
UNION
SELECT '우리는 지금', 1  FROM DUAL
UNION
SELECT '아주 재미있게', 2 FROM DUAL
ORDER BY 2;

-- SET 연산자와 JOIN 의 관계
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
INTERSECT
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

-- 각 쿼리문의 SELECT 절에 선택된 컬럼명이 동일한 경우에 조인구문으로 바꿀 수 있음
-- USING (EMP_ID, ROLE_NAME) 사용할 수 있음
-- (104 SE) = (104 SE) : 같다 
-- (104 SE-ANLY) != (104 SE) : 다르다

-- 조인 구문으로 바꾼다면
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
JOIN ROLE_HISTORY USING (EMP_ID, ROLE_NAME);

-- SET 연산자와 IN 연산자의 관계
-- UNION 과 IN 이 같은 결과를 만들 수도 있음
-- 집합 연산자에 대한 쿼리문의 SELECT 절의 컬럼들이 같고, 참조하는 테이블이 같고
-- WHERE 조건절의 비교값만 다른 경우에 IN 으로 바꿀 수 있음

-- 직급이 대리 또는 사원인 직원의 이름, 직급명 조회
-- 직급순 오름차순정렬, 같은 직급은 이름순 오름차순정렬 처리함
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE IN ('대리', '사원')
ORDER BY 2, 1;

-- UNION 사용 구문으로 바꾼다면
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '대리'
UNION
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '사원'
ORDER BY 2, 1;

-- ***********************************************************************************************************
-- SUBQUERY (서브쿼리)
/*
        함수(리턴값이 있는 함수()) -> 안에 사용된 함수가 먼저 실행이 되고, 리턴한 값을 바깥 함수가 사용하는 구조
        SELECT 구문에서도 컬럼명 비교연산자 비교값 <-- 비교값을 알아내기 위한 SELECT문을 비교값 자리에 바로 사용할 수 있음
        컬럼명 비교연산자 (비교값 알아내기 위한 SELECT 구문) <-- 서브쿼리(내부쿼리) 라고 함
        바깥 SELECT 문을 메인쿼리(외부쿼리) 라고 함
*/
-- 나승원과 같은 부서에 근무하는 직원 조회
-- 1. 나승원의 부서코드 조회
SELECT DEPT_ID
FROM EMPLOYEE
WHERE EMP_NAME = '나승원';

--2. 조회된 값을 사용해서 직원 정보 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_ID = '50';

-- 서브쿼리 사용 구문 변경
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_ID = (SELECT DEPT_ID -- 50
                            FROM EMPLOYEE
                            WHERE EMP_NAME = '나승원');

-- 서브쿼리의 유형
-- 단일행 서브쿼리, 다중행 서브쿼리, 다중열 서브쿼리, 다중행 다중열 서브쿼리, 
-- 상호연관 서브쿼리, 스칼라 서브쿼리
-- 서브쿼리 유형에 따라 서브쿼리 앞에 사용하는 연산자가 다름. *중요*

-- 단일행 (SINGLE ROW) 서브쿼리
-- 서브쿼리 실행 결과값이 한 개인 경우 (값 1개)
-- 단일행 서브쿼리 앞에는 일반 비교연산자 사용할 수 있음.
-- >, <, >=, <=, =, !=(<>, ^=)

-- 예 : 나승원과 직급이 같으면서 나승원보다 급여를 많이 받는 직원 조회
-- 1. 나승원 직급 조회
SELECT JOB_ID -- J5
FROM EMPLOYEE
WHERE EMP_NAME = '나승원';

-- 2. 나승원 급여 조회
SELECT SALARY -- 2300000
FROM EMPLOYEE
WHERE EMP_NAME = '나승원';

-- 3. 비교값으로 사용
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE JOB_ID = 'J5' 
AND SALARY > 2300000;

-- 서브쿼리 구문으로 변경
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE JOB_ID = (SELECT JOB_ID -- J5
                            FROM EMPLOYEE
                            WHERE EMP_NAME = '나승원')
AND SALARY > (SELECT SALARY -- 2300000
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '나승원');

-- 직원 중에서 최저 급여를 받는 직원 명단 조회
-- 1. 최저 급여
SELECT MIN(SALARY)
FROM EMPLOYEE;

-- 2.  직원 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY = 1500000;

-- WHERE 절에 그룹함수 사용 못함 -> 서브쿼리로 해결
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
-- WHERE SALARY = MIN(SALARY); -- ERROR
WHERE SALARY = (SELECT MIN(SALARY)
                            FROM EMPLOYEE);

-- HAVING 절에서도 서브쿼리 사용할 수 있음
-- 예 : 부서별 급여합계 중 가장 큰값에 대한 부서명과 급여합계 조회
SELECT DEPT_NAME, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY DEPT_ID, DEPT_NAME
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                                      FROM EMPLOYEE
                                      GROUP BY DEPT_ID);

-- 서브쿼리는 SELECT, FROM, WHERE, HAVING 에서 주로 사용할 수 있음.

-- 다중행 서브쿼리 (MULTIPLE ROW SUBQUERY)
-- 서브쿼리 결과행의 갯수가 여러 개인 경우 (값이 여러 개)
-- 다중행 서브쿼리 앞에는 일반 비교연산자 사용 못 함
-- 여러 개의 값을 비교할 수 있는 연산자 사용해야함 : IN, ANY, ALL

-- 예 : 각 부서별로 급여가 제일 작은 직원 정보 조회
-- 1. 부서별 급여 최소값 조회
SELECT MIN(SALARY) -- 7행 (값이 7개)
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- 2. 메인쿼리에 적용
SELECT EMP_ID, EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) 
                            FROM EMPLOYEE
                            GROUP BY DEPT_ID); -- ERROR : 잘못된 연산자 사용

-- 서브쿼리가 만든 여러 개의 값들을 모두 한번씩 비교해서 같은지를 확인하려면,
-- 컬럼명 IN (값, 값, 값, ...) -> 컬럼명 IN (다중행 서브쿼리)
-- 컬럼값 = 비교값1 OR 컬럼값 = 비교값2 OR 컬럼값 = 비교값3 OR .....
-- 컬럼값이 여러 개의 값 중에서 일치하는 값이 있다면 컬럼값을 선택함
SELECT EMP_ID, EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MIN(SALARY) 
                            FROM EMPLOYEE
                            GROUP BY DEPT_ID); -- 해결

-- 컬럼명 NOT IN (다중행 서브쿼리)
-- NOT (컬럼값 = 비교값1 OR 컬럼값 = 비교값2 OR 컬럼값 = 비교값3 OR .....)
-- 컬럼값이 여러 개의 값 중에서 일치하는 값이 없다면 (일치하는 값이 아닌)

-- 예 : 관리자인 직원과 관리자가 아닌 직원 정보를 별도로 조회해서 합쳐라
-- 관리자 사번 조회
SELECT DISTINCT MGR_ID -- 6행
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL;

-- 직원 정보에서 관리자만 조회
SELECT EMP_ID, EMP_NAME, '관리자' 구분
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT DISTINCT MGR_ID -- 6행
                            FROM EMPLOYEE
                            WHERE MGR_ID IS NOT NULL)
UNION
SELECT EMP_ID, EMP_NAME, '직원' 구분
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT DISTINCT MGR_ID 
                                    FROM EMPLOYEE
                                    WHERE MGR_ID IS NOT NULL)
ORDER BY 3, 1;

-- SELECT 절에서도 서브쿼리 사용할 수 있음
-- 함수 계산식 안에서 주로 사용됨
SELECT EMP_ID, EMP_NAME,
            CASE WHEN EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE) THEN '관리자'
            ELSE '직원'
            END 구분
FROM EMPLOYEE
ORDER BY 3, 1;

-- 컬럼명 > ANY (다중행 서브쿼리) : 가장 작은 값보다 큰
-- 컬럼명 < ANY (다중행 서브쿼리) : 가장 큰 값보다 작은
-- 컬럼명 > (값1, 값2, 값3, .....) -> 컬럼명 > 값1 OR 컬럼명 > 값2 OR 컬럼명 > 값3 OR .....
-- 컬럼명 < (값1, 값2, 값3, .....) -> 컬럼명 < 값1 OR 컬럼명 < 값2 OR 컬럼명 < 값3 OR .....

-- 예 : 대리 직급의 직원 중에서 과장 직급 급여의 최소값보다 급여를 많이 받는 직원 조회
SELECT EMP_ID , EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '대리'
AND SALARY > ANY (SELECT SALARY 
                                FROM EMPLOYEE 
                                JOIN JOB USING (JOB_ID) 
                                WHERE JOB_TITLE = '과장');

-- 컬럼명 > ALL (다중행 서브쿼리) : 가장 큰 값보다 큰
-- 컬럼명 < ALL (다중행 서브쿼리) : 가장 작은 값보다 작은
-- 컬럼명 > (값1, 값2, 값3, .....) -> 컬럼명 > 값1 AND 컬럼명 > 값2 AND 컬럼명 > 값3 AND .....
-- 컬럼명 < (값1, 값2, 값3, .....) -> 컬럼명 < 값1 AND 컬럼명 < 값2 AND 컬럼명 < 값3 AND .....
-- 예 : 모든 과장들의 급여보다 더 많은 급여를 받는 대리 직원 조회
SELECT EMP_ID , EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '대리'
AND SALARY > ALL (SELECT SALARY 
                                FROM EMPLOYEE 
                                JOIN JOB USING (JOB_ID) 
                                WHERE JOB_TITLE = '과장');

-- 서브쿼리의 사용 위치 : SELECT 절, FROM 절, WHERE 절, GROUP BY 절, HAVING 절, ORDER BY 절
-- INSERT 문, UPDATE 문, CREATE TABLE 문, CREATE VIEW 문

-- 자기 직급의 평균 급여를 받는 직원 조회
-- 1. 직급별 급여 평균
SELECT JOB_ID, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
GROUP BY JOB_ID;

-- 2. 서브쿼리 적용
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE SALARY IN (SELECT TRUNC(AVG(SALARY), -5)
                            FROM EMPLOYEE
                            GROUP BY JOB_ID);

-- 다중행 다중열 서브쿼리
-- 서브쿼리 SELECT 절에 항목이 여러 개인 경우 : 다중 열 (MULTIPLE COLUMN)
-- (비교컬럼명, 비교컬럼명) 비교연산자 (다중열 서브쿼리)
-- 서브쿼리 SELECT 절의 항목(컬럼) 갯수와 자료형을 맞추어서 비교해야함 *중요*
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE (JOB_ID, SALARY) IN (SELECT JOB_ID, TRUNC(AVG(SALARY), -5)
                            FROM EMPLOYEE
                            GROUP BY JOB_ID);

-- FROM 절에서 서브쿼리 사용할 수 있음 : 테이블 대신에 사용함
-- FROM (서브쿼리) 별칭 <-- 별칭(ALIAS)이 테이블명 대신함
-- FROM 절에서 사용된 서브쿼리가 만들 결과집합을 인라인뷰(INLINE VIEW)라고 함
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM (SELECT JOB_ID, TRUNC(AVG(SALARY), -5) JOBAVG
            FROM EMPLOYEE
            GROUP BY JOB_ID) V -- 인라인 뷰
JOIN EMPLOYEE E ON (V.JOBAVG = E.SALARY AND NVL(V.JOB_ID, ' ') = NVL(E.JOB_ID, ' '))
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
ORDER BY 3, 2;

-- 서브쿼리의 종류
-- 단일행 서브쿼리, 다중행 서브쿼리, 다중행 다중열 서브쿼리, 상[호연]관 서브쿼리, 스칼라 서브쿼리 
-- 대부분의 서브쿼리는 서브쿼리가 만들어 낸 결과값을 메인쿼리가 사용하는 방식임
-- 상관쿼리는 서브쿼리가 메인쿼리의 값을 가져다가 결과를 만들어내는 구조
-- 그러므로 메인쿼리의 값이 바뀌면 서브쿼리의 결과도 달라지게됨 -> 그래서 상호연관 서브쿼리라고 함

-- 자기 직급의 평균 급여를 받는 직원 조회 : 상호연관 서브쿼리를 사용한 경우
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID) 
WHERE SALARY = (SELECT TRUNC(AVG(SALARY), -5)
                            FROM EMPLOYEE
                            WHERE JOB_ID = E.JOB_ID) -- 메인쿼리에 있는 항목을 가져다가 서브쿼리에서 사용함
ORDER BY 3 DESC NULLS LAST;

-- EXISTS / NOT EXISTS 연산자
-- 상호연관 서브쿼리문 앞에서만 사용함
-- 서브쿼리가 만든 결과가 존재하는지 물어볼 때는 EXISTS 사용
-- 서브쿼리의 SELECT 절에 컬럼 기술하면 안됨. 그래서 NULL 사용하여 더미컬럼 생성.

-- 예 : 관리자인 직원들 조회
SELECT EMP_ID, EMP_NAME, '관리자' 구분
FROM EMPLOYEE E
WHERE EXISTS (SELECT NULL
                        FROM EMPLOYEE
                        WHERE E.EMP_ID = MGR_ID);

-- 관리자가 아닌 직원들 조회
SELECT EMP_ID, EMP_NAME, '직원' 구분
FROM EMPLOYEE E
WHERE NOT EXISTS (SELECT NULL
                        FROM EMPLOYEE
                        WHERE E.EMP_ID = MGR_ID);
                        
-- 스칼라 서브쿼리
-- 단일행 서브쿼리 + 상호연관 서브쿼리
-- 예 : 이름, 부서코드, 급여, 해당 직원이 소속된 부서의 급여평균
SELECT EMP_NAME, DEPT_ID, SALARY, 
            (SELECT TRUNC(AVG(SALARY), -5)
            FROM EMPLOYEE
            WHERE DEPT_ID = E.DEPT_ID) AVGSAL
FROM EMPLOYEE E;

-- CASE 표현식을 사용한 스칼라 서브쿼리
-- 부서의 근무지역이 'OT' 이면 '지역팀', 아니면 '본사팀' 으로 표시 조회
SELECT EMP_ID, EMP_NAME,
            CASE WHEN DEPT_ID = (SELECT DEPT_ID
                                                FROM DEPARTMENT
                                                WHERE LOC_ID = 'OT')
            THEN '지역팀'
            ELSE '본사팀'
            END 소속
FROM EMPLOYEE
ORDER BY 소속 DESC;

-- ORDER BY 절에 스칼라 서브쿼리 사용 예
-- 직원이 소속된 부서의 부서명이 큰 값부터 정렬해서 직원 정보 조회
SELECT EMP_ID, EMP_NAME, DEPT_ID, HIRE_DATE
FROM EMPLOYEE E
ORDER BY (SELECT DEPT_NAME
                    FROM DEPARTMENT
                    WHERE DEPT_ID = E.DEPT_ID) DESC;

-- TOP-N 분석 ----------------------------------------------------------------------------------------
-- 상위 몇 개, 하위 몇 개를 조회하는 것
-- 인라인 뷰와 RANK() 함수를 이용하는 방법과
-- ROWNUM 을 이용한 TOP-N 분석 

-- 1. 인라인 뷰와 RANK() 함수를 이용한 TOP-N 분석
-- 직원 정보에서 급여를 가장 많이 받는 직원 5명 조회 
-- 이름, 급여, 순위
SELECT *
FROM (SELECT EMP_NAME, SALARY, RANK() OVER (ORDER BY SALARY DESC) 순위
            FROM EMPLOYEE)
WHERE 순위 <= 5;

-- 2. ROWNUM 을 이용한 TOP-N 분석
-- ORDER BY 한 결과에 ROWNUM 을 붙이는 작업해야함 -> 서브쿼리를 이용해야함
-- ROWNUM : 행번호를 의미함, WHERE 처리 후에 자동으로 부여됨

-- 확인
SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE -- 각 행 앞에 ROWNUM 표시됨
ORDER BY SALARY DESC;

-- 급여 많이 받는 직원 3명 조회
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM < 4 -- WHERE 절 다음에 ROWNUM 부여됨
ORDER BY SALARY DESC; -- 틀린 결과 나옴

-- 해결 : 정렬하고 나서 ROWNUM 이 부여되게끔 하면 됨
-- 인라인 뷰 사용
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
            FROM EMPLOYEE
            ORDER BY SALARY DESC) -- 정렬 후에 ROWNUM 이 부여됨
WHERE ROWNUM < 4;
