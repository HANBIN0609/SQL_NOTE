-- SELECT 문 
/*
테이블에 기록 저장된 데이터를 검색(조회, 찾아내기 위한)하기 위해 작성하는 SQL 구문.
DQL(Data Query Language) 이라고도 함, 보통은 SELECT라고 부름

기본 구문 작성법 : 
SELECT * | 컬럼명, 컬럼명, 컬럼명, ... | 계산식 | 함수식
FROM 조회에 사용할 테이블명;

마찬가지로 테이블명에서 대/소문자 상관없음
실행순서 : FROM >>> WHERE >>> SELECT
*/
-- * 사용 : 테이블이 가진 모든 컬럼값들을 조회할 때 사용
-- 직원(EMPLOYEE) 테이블에 저장된 전체 데이터 조회하려면
SELECT * FROM EMPLOYEE;

-- 특정 컬럼의 값들을 조회할 경우의 SELECT 문 : 
SELECT EMP_NAME, PHONE, SALARY
FROM EMPLOYEE;

-- 특정 행(ROW)을 조회하고자 할 경우의 SELECT 문 : 
SELECT * 
FROM EMPLOYEE
WHERE DEPT_ID = '20'; -- DEPT_ID 컬럼에 '20'이 기록된 행들을 골라냄

-- 특정 행에서 특정 컬럼을 조회하는 SELECT 문 :
SELECT EMP_ID, EMP_NAME, PHONE, SALARY, DEPT_ID
FROM EMPLOYEE
WHERE DEPT_ID = '20';

-- 기본은 한 개의 테이블에 대해서 값 조회함.
-- 필요할 경우 여러개의 테이블을 합쳐서(조인) 원하는 컬럼을 선택할 수도 있음
SELECT EMP_ID, EMP_NAME, DEPT_NAME
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID);

/*
SELECT 구문 작성 형식 :
5. SELECT * | 컬럼명, 컬럼명, ... | 계산식 [AS 별칭]
1. FROM 테이블명
2. WHERE 컬럼명 비교연산자 비교값(행단위로 필터링함)
3. GROUP BY 컬럼명 | 계산식
4. HAVING 그룹함수 비교연산자 비교값(그룹별 조건에 해당하는 그룹을 선택함)
6. ORDER BY 컬럼명 정렬기준, 순번 정렬기준, 별칭 정렬기준(ASC | DESC)
*/

-- SELECT 사용 예 1 :
-- 직원 테이블에서 사번과 이름 조회
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE;

-- 직원 테이블에서 직원들의 모든 정보 조회
SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, HIRE_DATE, JOB_ID
            SALARY, BONUS_PCT, MARRIAGE, MGR_ID, DEPT_ID
FROM EMPLOYEE;
-- 또는
SELECT *
FROM EMPLOYEE;

-- SELECT 절에 컬럼값에 대한 계산식도 사용할 수 있음.
-- 사번, 이름, 급여, 급여에 대한 연봉, 보너스 포인트가 적용된 연봉 조회
SELECT EMP_ID, EMP_NAME, SALARY, 
            SALARY * 12, 
            (SALARY + (SALARY * BONUS_PCT)) * 12
FROM EMPLOYEE;

-- 계산하는 값이 NULL (값 없다.) 이면 결과도 무조건 NULL 임.
-- 계산식에 함수를 사용할 수 있음.
-- 컬럼의 값이 NULL 이면, 다른 값으로 바꾸는 함수를 이용함.
-- NVL(값 읽어올 컬럼명, NULL일 때 바꿀값) >>> 해당 함수
SELECT EMP_ID , EMP_NAME, SALARY, 
            SALARY * 12, 
            (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12
FROM EMPLOYEE;

-- SELECT 절에 컬럼명, 계산식에 별칭(ALIAS)을 사용할 수도 있음
-- 컬럼명 AS 별칭, 계산식 AS 별칭
-- AS 는 생략할 수 있음 >>> 컬럼명 별칭, 계산식 별칭
-- 주의사항 : 별칭에 숫자, 공백, 기호가 사용될 때는 반드시 "별칭" (큰 따옴표올 묶어야 함, 그렇지 않으면 에러)
-- 별칭글자는 30바이트이하로 작성할 수 있음.
SELECT EMP_ID AS 사번 , EMP_NAME AS 이름, SALARY AS 급여, 
            SALARY * 12 "1년 급여", 
            (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 "보너스포인트적용연봉"
FROM EMPLOYEE;

SELECT LENGTHB('한글'), LENGTHB('ORACLE')  
FROM DUAL; -- 오라클이 제공하는 가짜 테이블, 더미 테이블.
-- 오라클 정품에서는 한글 1글자가 2바이트임, XE에서는 한글 1글자가 3바이트임

-- SELECT 절에 리터럴(LITERAL, 임의의 문자열 값) 사용할 수 있음.
-- 가상의 컬럼이 하나 추가됨.
-- SELECT 한 데이터들의 상태값 표시용으로 이용할 수 있음.
-- '리터럴문자열' AS 별칭
SELECT EMP_ID 사번, EMP_NAME 이름, '재직' 근무상태
FROM EMPLOYEE;

-- DISTINCT : SELECT 절에서 컬럼명 앞에 사용할 수 있음
-- DISTINCT 컬럼명, 컬럼명, ...
-- DISTINCT 는 SELECT 절에 1번만 사용할 수 있음
-- 컬럼별로 DISTINCT 사용 못 함.

-- 직원들의 직급 코드 조회
SELECT JOB_ID
FROM EMPLOYEE; -- 결과 22행

-- 직원 테이블에 사용된 직급 코드 조회
SELECT DISTINCT JOB_ID -- 같은 값은 1개만 선택함 (일종의 중복제외)
FROM EMPLOYEE; -- 결과 8행
 
SELECT DISTINCT JOB_ID, DEPT_ID
FROM EMPLOYEE; -- 두 컬럼값을 하나의 값으로 보고 따져서 중복 판단함
-- 'J3 50' 과 'J3 60' 은 다른 값임

-- 직원 테이블에서 사용된 부서코드 조회
SELECT DISTINCT DEPT_ID
FROM EMPLOYEE;

-- WHERE 절 ********************************************
-- 작동순서 : FROM 절 >>> WHERE 절
-- WHERE 컬럼명 비교연산자 비교값
-- 조건절이라고 함 : 테이블에서 해당 컬럼의 값이 조건을 만족하는 행들만 골라냄
-- 비교연산자 : > (크냐, 초과), < (작냐, 미만), >= (크거나 같냐, 이상), <= (작거나 같냐, 이하)
--                  = (같냐), != | <> | ^= (같지 않느냐)
-- 논리연산자 : AND(&&와 같음), OR(||와 같음) >>> 단어의 형태로 표현함

-- 부서코드가 '90'인 직원들만 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = '90'; -- 값이 있는 행을 골라냄

-- 직급코드가 'J7'인 직원들만 조회
SELECT *
FROM EMPLOYEE
WHERE JOB_ID = 'J7'; -- 값이 있는 행을 골라냄
-- WHERE JOB_ID = 'j7'; -- 기록값은 대/소문자 구분함. 기록된 형태 그대로 비교해야 함

-- 직원들 중에서 급여가 4백만을 초과하는 직원 명단 조회
-- 사번, 이름, 급여
SELECT EMP_ID 사번, EMP_NAME 이름, SALARY 급여
FROM EMPLOYEE
WHERE SALARY > 4000000;

-- 90번 부서에 근무하는 직원 중 급여가 2백만을 초과하는 직원 정보 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = '90'
AND SALARY > 2000000;

-- 90 또는 20번 부서에 근무하는 직원 정보 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = '90'
OR DEPT_ID = '20';
