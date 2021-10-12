-- 1. 2020�� 12�� 25���� ���� �������� ��ȸ�Ͻÿ�.
SELECT TO_CHAR(TO_DATE('20201225', 'RRRRMMDD'), 'DAY')
FROM DUAL;

-- 2. �ֹι�ȣ�� 60��� ���̸鼭 ������ �����̰�, 
-- ���� �达�� �������� 
-- �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.

-- ����Ŭ ���뱸��
SELECT EMP_NAME �����, EMP_NO �ֹι�ȣ, DEPT_NAME �μ���, JOB_TITLE ���޸�
FROM EMPLOYEE E,
        DEPARTMENT D,
        JOB J
WHERE E.DEPT_ID = D.DEPT_ID(+)
AND E.JOB_ID = J.JOB_ID(+)
AND SUBSTR(EMP_NO, 1, 2) LIKE '6%'
AND SUBSTR(EMP_NO, 8) LIKE '2%' 
AND SUBSTR(EMP_NAME, 1) LIKE '��%';

-- ANSI ǥ�ر���
SELECT EMP_NAME �����, EMP_NO �ֹι�ȣ, DEPT_NAME �μ���, JOB_TITLE ���޸�
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN JOB USING (JOB_ID)
WHERE /*SUBSTR(EMP_NO, 1, 2)*/ EMP_NO LIKE '6%'
AND /*SUBSTR(EMP_NO, 8)*/ SUBSTR(EMP_NO, 8, 1) IN ('2', '4') 
AND /*SUBSTR(EMP_NAME, 1)*/ EMP_NAME LIKE '��%';

-- 3. ���� ���̰� ���� ������ 
-- ���, �����, ����, �μ���, ���޸��� ��ȸ�Ͻÿ�. (JOIN, GROUP BY, HAVING ��� �� ���)
-- ������ �ּҰ� ��ȸ
SELECT MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) ����
FROM EMPLOYEE;

-- ��ȸ�� ������ �ּҰ��� �̿��� ������ ���� ��ȸ��
-- outer join �ʿ���.
-- ����Ŭ ���뱸��
SELECT EMP_ID ���, EMP_NAME �̸�, 
            MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) ����, 
            DEPT_NAME �μ���, JOB_TITLE ���޸�
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) = 31;

-- ANSI ǥ�ر���
SELECT EMP_ID ���, EMP_NAME �̸�, 
            MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) ����, 
            DEPT_NAME �μ���, JOB_TITLE ���޸�
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) = 31;

-- ���������� ����� ���
SELECT EMP_ID ���, EMP_NAME �̸�, 
            MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) ����, 
            DEPT_NAME �μ���, JOB_TITLE ���޸�
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) =
            (SELECT MIN(TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12)) ����
            FROM EMPLOYEE);

-- �ζ��� ��� RANK() �Լ� ���
SELECT ���, �̸�, ����, �μ���, ���޸�
FROM (SELECT EMP_ID ���, EMP_NAME �̸�, 
                TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12) ����,
                DEPT_NAME �μ���, JOB_TITLE ���޸�,
                RANK() OVER (ORDER BY TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 4), 'RRMM')) / 12) ASC) ����
        FROM EMPLOYEE
        LEFT JOIN JOB USING (JOB_ID)
        LEFT JOIN DEPARTMENT USING (DEPT_ID))
WHERE ���� = 1; --  TOP-1 �м�

-- 4. �̸��� '��'�ڰ� ���� �������� 
-- ���, �����, �μ����� ��ȸ�Ͻÿ�.
-- ����Ŭ ���뱸��
SELECT EMP_ID ���, EMP_NAME �����, DEPT_NAME �μ���
FROM EMPLOYEE E,
        DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID(+)
AND EMP_NAME LIKE '%��%';

-- ANSI ǥ�ر���
SELECT EMP_ID ���, EMP_NAME �����, DEPT_NAME �μ���
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE EMP_NAME LIKE '%��%';

-- 5. �ؿܿ������� �ٹ��ϴ� 
-- �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.
-- ����Ŭ ���뱸��
SELECT EMP_NAME �����, JOB_TITLE ���޸�, E.DEPT_ID �μ��ڵ�, DEPT_NAME �μ��� 
FROM EMPLOYEE E,
        DEPARTMENT D,
        JOB J
WHERE E.DEPT_ID = D.DEPT_ID(+)
AND E.JOB_ID = J.JOB_ID(+)
AND DEPT_NAME LIKE '�ؿܿ���%'
ORDER BY 4;

-- ANSI ǥ�ر���
SELECT EMP_NAME �����, JOB_TITLE ���޸�, DEPT_ID �μ��ڵ�, DEPT_NAME �μ��� 
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING(DEPT_ID)
LEFT JOIN JOB USING (JOB_ID)
WHERE DEPT_NAME LIKE '�ؿܿ���%'
ORDER BY 4;

-- 6. ���ʽ�����Ʈ�� �޴� �������� 
-- �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
-- ����Ŭ ���뱸��
SELECT EMP_NAME �����, BONUS_PCT ���ʽ�����Ʈ, DEPT_NAME �μ���, LOC_DESCRIBE �ٹ�������  
FROM EMPLOYEE E,
        DEPARTMENT D,
        LOCATION L
WHERE E.DEPT_ID = D.DEPT_ID(+)
AND D.LOC_ID = L.LOCATION_ID(+)
AND (BONUS_PCT IS NOT NULL OR BONUS_PCT != 0.0); -- ������ �켱���� �Ű�����. �ȱ׷��� ����� ������ �޶���.

-- ANSI ǥ�ر���
SELECT EMP_NAME �����, BONUS_PCT ���ʽ�����Ʈ, DEPT_NAME �μ���, LOC_DESCRIBE �ٹ������� 
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING(DEPT_ID)
LEFT JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE BONUS_PCT IS NOT NULL OR BONUS_PCT != 0.0;

-- 7. �μ��ڵ尡 20�� �������� 
-- �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
-- ����Ŭ ���뱸��
SELECT EMP_NAME �����, JOB_TITLE ���޸�, DEPT_NAME �μ���, LOC_DESCRIBE �ٹ�������  
FROM EMPLOYEE E,
        JOB J,
        DEPARTMENT D,
        LOCATION L
WHERE E.JOB_ID = J.JOB_ID(+)
AND E.DEPT_ID = D.DEPT_ID(+)
AND D.LOC_ID = L.LOCATION_ID(+)
AND E.DEPT_ID = '20';

-- ANSI ǥ�ر���
SELECT EMP_NAME �����, JOB_TITLE ���޸�, DEPT_NAME �μ���, LOC_DESCRIBE �ٹ������� 
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING(DEPT_ID)
LEFT JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE DEPT_ID = '20';

-- 8. ���޺� ������ �ּұ޿�(MIN_SAL)���� ���� �޴� ��������
-- �����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
-- ������ ���ʽ�����Ʈ�� �����Ͻÿ�.
-- ����Ŭ ���뱸��
SELECT EMP_NAME �����, JOB_TITLE ���޸�, SALARY �޿�, (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 ����
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID(+)  
AND (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 > MIN_SAL;

-- ANSI ǥ�ر���
SELECT EMP_NAME �����, JOB_TITLE ���޸�, SALARY �޿�, (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 ����
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 > MIN_SAL;


-- 9 . �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� 
-- �����(emp_name), �μ���(dept_name), ������(loc_describe),
--  ������(country_name)�� ��ȸ�Ͻÿ�.
-- ����Ŭ ���뱸��
SELECT EMP_NAME �����, DEPT_NAME �μ���, LOC_DESCRIBE ������, COUNTRY_NAME ������
FROM EMPLOYEE E,
            DEPARTMENT D,
            LOCATION L,
            COUNTRY C
WHERE E.DEPT_ID = D.DEPT_ID 
AND D.LOC_ID = L.LOCATION_ID
AND L.COUNTRY_ID = C.COUNTRY_ID
AND L.COUNTRY_ID IN ('KO', 'JP');

-- ANSI ǥ�ر���
SELECT EMP_NAME �����, DEPT_NAME �μ���, LOC_DESCRIBE ������, COUNTRY_NAME ������
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
JOIN COUNTRY USING (COUNTRY_ID)
WHERE COUNTRY_ID IN ('KO', 'JP');

-- 10. ���� �μ��� �ٹ��ϴ� �������� 
-- �����, �μ��ڵ�, �����̸�, �μ��ڵ带 ��ȸ�Ͻÿ�.
-- self join ���
-- ����Ŭ ���뱸��
SELECT DISTINCT E.EMP_NAME �����, E.DEPT_ID �μ��ڵ�, M.EMP_NAME �����̸�, M.DEPT_ID �μ��ڵ�
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.DEPT_ID = M.DEPT_ID
AND E.EMP_NAME != M.EMP_NAME
ORDER BY 2;

-- ANSI ǥ�ر��� : ���̺� ��Ī ���ÿ��� ON �����
SELECT E.EMP_NAME �����, E.DEPT_ID �μ��ڵ�, M.EMP_NAME �����̸�, M.DEPT_ID �μ��ڵ�
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.DEPT_ID = M.DEPT_ID)
WHERE E.EMP_NAME != M.EMP_NAME
ORDER BY 2;

-- 11. ���ʽ�����Ʈ�� ���� ������ �߿��� 
-- �����ڵ尡 J4�� J7�� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�.
-- ����Ŭ ���뱸��
SELECT EMP_NAME �����, JOB_TITLE ���޸�, SALARY �޿�
FROM EMPLOYEE E,
            JOB J
WHERE E.JOB_ID = J.JOB_ID(+) 
AND (BONUS_PCT IS NULL OR BONUS_PCT = 0.0) 
AND E.JOB_ID IN ('J4', 'J7');

-- ANSI ǥ�ر���
SELECT EMP_NAME �����, JOB_TITLE ���޸�, SALARY �޿�
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE (BONUS_PCT IS NULL OR BONUS_PCT = 0.0) 
AND JOB_ID IN ('J4', 'J7');

-- 12. �ҼӺμ��� 50 �Ǵ� 90�� ������ 
-- ��ȥ�� ������ ��ȥ�� ������ ���� ��ȸ�Ͻÿ�.
SELECT DECODE(MARRIAGE, 'Y', '��ȥ', '��ȥ') ��ȥ����, COUNT(*) ������
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90')
GROUP BY DECODE(MARRIAGE, 'Y', '��ȥ', '��ȥ')
ORDER BY 1;
