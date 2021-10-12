-- DAY7_SELECT6

-- ****************************************************************************************************************************
-- ���� ������ (SET OPERATOR)
-- UNION, UNION ALL, INTERSECT, MINUS
-- �� SELECT ���� ���� ���(������� - RESULTSET)�� �ϳ��� ǥ���ϱ� ���� �����
-- ������ : UNION, UNION ALL - �� ���� RESULTSET ����� �ϳ��� ��ħ
--             UNION (��ĥ �� �ߺ����� �ϳ��� ������), UNION ALL (�ߺ����� ��� ������)
-- ������ : INTERSECT - �� ���� RESULTSET ������� ��ġ��(�ߺ� ��ġ�Ǵ�) ���� ������
-- ������ : MINUS - ù��° RESULTSET ������� �ι��� RESULTSET �� ��ġ�� ���� ������ ������

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE -- 22��
UNION -- 25�� (�ߺ����� 1���� ����)
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY; -- 4��

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE -- 22��
UNION ALL-- 26�� (�ߺ��� �� ����)
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY; -- 4��

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE -- 22��
INTERSECT -- 1�� (�ߺ��� 1��)
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY; -- 4��

SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE -- 22��
MINUS -- 21�� (ù��° �������� �ι�° ������ �ߺ��Ǵ� ���� ��)
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY; -- 4�� : �ߺ��� 1�� ����

-- SET ������ ���� ���ǻ���
-- �� �������� SELECT ���� �÷� ������ �� �÷��� �ڷ����� �ݵ�� ���ƾ� ��
-- ������ ���� �÷�(DUMMY COLUMN - NULL ĭ)�� ����� �� ����

-- ���� ����ġ, �ذ� ���
SELECT EMP_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_ID = '20'
UNION
SELECT DEPT_NAME, DEPT_ID, NULL -- DUMMY COLUMN �߰�, NULL�� � �ڷ����̵� �� �� ����
FROM DEPARTMENT
WHERE DEPT_ID = '20';

-- �� �÷��� �ڷ��� ����ġ
SELECT EMP_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_ID = '20'
UNION
SELECT NULL, DEPT_NAME, DEPT_ID -- �ڷ����� ��ġ���� ������ ERROR
FROM DEPARTMENT
WHERE DEPT_ID = '20';

-- Ȱ�� : ���� ��ȸ��  ����� �� ���̺�� �������� �� �� �ַ� �̿��� �� ����
-- 50�� �μ��� �Ҽӵ� ���� �� �����ڿ� �Ϲ� ������ ���� ��ȸ�ؼ� �ϳ��� ���Ķ�.
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = '50';

SELECT EMP_ID, EMP_NAME, '������' ����
FROM EMPLOYEE
WHERE EMP_ID = '141' AND DEPT_ID = '50'
UNION
SELECT EMP_ID, EMP_NAME, '����' ����
FROM EMPLOYEE
WHERE EMP_ID != '141' AND DEPT_ID = '50'
ORDER BY 3, 1;

SELECT 'SQL�� �����ϰ� �ֽ��ϴ�.', 3 ���� FROM DUAL
UNION
SELECT '�츮�� ����', 1  FROM DUAL
UNION
SELECT '���� ����ְ�', 2 FROM DUAL
ORDER BY 2;

-- SET �����ڿ� JOIN �� ����
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
INTERSECT
SELECT EMP_ID, ROLE_NAME
FROM ROLE_HISTORY;

-- �� �������� SELECT ���� ���õ� �÷����� ������ ��쿡 ���α������� �ٲ� �� ����
-- USING (EMP_ID, ROLE_NAME) ����� �� ����
-- (104 SE) = (104 SE) : ���� 
-- (104 SE-ANLY) != (104 SE) : �ٸ���

-- ���� �������� �ٲ۴ٸ�
SELECT EMP_ID, ROLE_NAME
FROM EMPLOYEE_ROLE
JOIN ROLE_HISTORY USING (EMP_ID, ROLE_NAME);

-- SET �����ڿ� IN �������� ����
-- UNION �� IN �� ���� ����� ���� ���� ����
-- ���� �����ڿ� ���� �������� SELECT ���� �÷����� ����, �����ϴ� ���̺��� ����
-- WHERE �������� �񱳰��� �ٸ� ��쿡 IN ���� �ٲ� �� ����

-- ������ �븮 �Ǵ� ����� ������ �̸�, ���޸� ��ȸ
-- ���޼� ������������, ���� ������ �̸��� ������������ ó����
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE IN ('�븮', '���')
ORDER BY 2, 1;

-- UNION ��� �������� �ٲ۴ٸ�
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '�븮'
UNION
SELECT EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '���'
ORDER BY 2, 1;

-- ***********************************************************************************************************
-- SUBQUERY (��������)
/*
        �Լ�(���ϰ��� �ִ� �Լ�()) -> �ȿ� ���� �Լ��� ���� ������ �ǰ�, ������ ���� �ٱ� �Լ��� ����ϴ� ����
        SELECT ���������� �÷��� �񱳿����� �񱳰� <-- �񱳰��� �˾Ƴ��� ���� SELECT���� �񱳰� �ڸ��� �ٷ� ����� �� ����
        �÷��� �񱳿����� (�񱳰� �˾Ƴ��� ���� SELECT ����) <-- ��������(��������) ��� ��
        �ٱ� SELECT ���� ��������(�ܺ�����) ��� ��
*/
-- ���¿��� ���� �μ��� �ٹ��ϴ� ���� ��ȸ
-- 1. ���¿��� �μ��ڵ� ��ȸ
SELECT DEPT_ID
FROM EMPLOYEE
WHERE EMP_NAME = '���¿�';

--2. ��ȸ�� ���� ����ؼ� ���� ���� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_ID = '50';

-- �������� ��� ���� ����
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_ID = (SELECT DEPT_ID -- 50
                            FROM EMPLOYEE
                            WHERE EMP_NAME = '���¿�');

-- ���������� ����
-- ������ ��������, ������ ��������, ���߿� ��������, ������ ���߿� ��������, 
-- ��ȣ���� ��������, ��Į�� ��������
-- �������� ������ ���� �������� �տ� ����ϴ� �����ڰ� �ٸ�. *�߿�*

-- ������ (SINGLE ROW) ��������
-- �������� ���� ������� �� ���� ��� (�� 1��)
-- ������ �������� �տ��� �Ϲ� �񱳿����� ����� �� ����.
-- >, <, >=, <=, =, !=(<>, ^=)

-- �� : ���¿��� ������ �����鼭 ���¿����� �޿��� ���� �޴� ���� ��ȸ
-- 1. ���¿� ���� ��ȸ
SELECT JOB_ID -- J5
FROM EMPLOYEE
WHERE EMP_NAME = '���¿�';

-- 2. ���¿� �޿� ��ȸ
SELECT SALARY -- 2300000
FROM EMPLOYEE
WHERE EMP_NAME = '���¿�';

-- 3. �񱳰����� ���
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE JOB_ID = 'J5' 
AND SALARY > 2300000;

-- �������� �������� ����
SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE JOB_ID = (SELECT JOB_ID -- J5
                            FROM EMPLOYEE
                            WHERE EMP_NAME = '���¿�')
AND SALARY > (SELECT SALARY -- 2300000
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '���¿�');

-- ���� �߿��� ���� �޿��� �޴� ���� ��� ��ȸ
-- 1. ���� �޿�
SELECT MIN(SALARY)
FROM EMPLOYEE;

-- 2.  ���� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY = 1500000;

-- WHERE ���� �׷��Լ� ��� ���� -> ���������� �ذ�
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
-- WHERE SALARY = MIN(SALARY); -- ERROR
WHERE SALARY = (SELECT MIN(SALARY)
                            FROM EMPLOYEE);

-- HAVING �������� �������� ����� �� ����
-- �� : �μ��� �޿��հ� �� ���� ū���� ���� �μ���� �޿��հ� ��ȸ
SELECT DEPT_NAME, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY DEPT_ID, DEPT_NAME
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                                      FROM EMPLOYEE
                                      GROUP BY DEPT_ID);

-- ���������� SELECT, FROM, WHERE, HAVING ���� �ַ� ����� �� ����.

-- ������ �������� (MULTIPLE ROW SUBQUERY)
-- �������� ������� ������ ���� ���� ��� (���� ���� ��)
-- ������ �������� �տ��� �Ϲ� �񱳿����� ��� �� ��
-- ���� ���� ���� ���� �� �ִ� ������ ����ؾ��� : IN, ANY, ALL

-- �� : �� �μ����� �޿��� ���� ���� ���� ���� ��ȸ
-- 1. �μ��� �޿� �ּҰ� ��ȸ
SELECT MIN(SALARY) -- 7�� (���� 7��)
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- 2. ���������� ����
SELECT EMP_ID, EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) 
                            FROM EMPLOYEE
                            GROUP BY DEPT_ID); -- ERROR : �߸��� ������ ���

-- ���������� ���� ���� ���� ������ ��� �ѹ��� ���ؼ� �������� Ȯ���Ϸ���,
-- �÷��� IN (��, ��, ��, ...) -> �÷��� IN (������ ��������)
-- �÷��� = �񱳰�1 OR �÷��� = �񱳰�2 OR �÷��� = �񱳰�3 OR .....
-- �÷����� ���� ���� �� �߿��� ��ġ�ϴ� ���� �ִٸ� �÷����� ������
SELECT EMP_ID, EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MIN(SALARY) 
                            FROM EMPLOYEE
                            GROUP BY DEPT_ID); -- �ذ�

-- �÷��� NOT IN (������ ��������)
-- NOT (�÷��� = �񱳰�1 OR �÷��� = �񱳰�2 OR �÷��� = �񱳰�3 OR .....)
-- �÷����� ���� ���� �� �߿��� ��ġ�ϴ� ���� ���ٸ� (��ġ�ϴ� ���� �ƴ�)

-- �� : �������� ������ �����ڰ� �ƴ� ���� ������ ������ ��ȸ�ؼ� ���Ķ�
-- ������ ��� ��ȸ
SELECT DISTINCT MGR_ID -- 6��
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL;

-- ���� �������� �����ڸ� ��ȸ
SELECT EMP_ID, EMP_NAME, '������' ����
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT DISTINCT MGR_ID -- 6��
                            FROM EMPLOYEE
                            WHERE MGR_ID IS NOT NULL)
UNION
SELECT EMP_ID, EMP_NAME, '����' ����
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT DISTINCT MGR_ID 
                                    FROM EMPLOYEE
                                    WHERE MGR_ID IS NOT NULL)
ORDER BY 3, 1;

-- SELECT �������� �������� ����� �� ����
-- �Լ� ���� �ȿ��� �ַ� ����
SELECT EMP_ID, EMP_NAME,
            CASE WHEN EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE) THEN '������'
            ELSE '����'
            END ����
FROM EMPLOYEE
ORDER BY 3, 1;

-- �÷��� > ANY (������ ��������) : ���� ���� ������ ū
-- �÷��� < ANY (������ ��������) : ���� ū ������ ����
-- �÷��� > (��1, ��2, ��3, .....) -> �÷��� > ��1 OR �÷��� > ��2 OR �÷��� > ��3 OR .....
-- �÷��� < (��1, ��2, ��3, .....) -> �÷��� < ��1 OR �÷��� < ��2 OR �÷��� < ��3 OR .....

-- �� : �븮 ������ ���� �߿��� ���� ���� �޿��� �ּҰ����� �޿��� ���� �޴� ���� ��ȸ
SELECT EMP_ID , EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '�븮'
AND SALARY > ANY (SELECT SALARY 
                                FROM EMPLOYEE 
                                JOIN JOB USING (JOB_ID) 
                                WHERE JOB_TITLE = '����');

-- �÷��� > ALL (������ ��������) : ���� ū ������ ū
-- �÷��� < ALL (������ ��������) : ���� ���� ������ ����
-- �÷��� > (��1, ��2, ��3, .....) -> �÷��� > ��1 AND �÷��� > ��2 AND �÷��� > ��3 AND .....
-- �÷��� < (��1, ��2, ��3, .....) -> �÷��� < ��1 AND �÷��� < ��2 AND �÷��� < ��3 AND .....
-- �� : ��� ������� �޿����� �� ���� �޿��� �޴� �븮 ���� ��ȸ
SELECT EMP_ID , EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '�븮'
AND SALARY > ALL (SELECT SALARY 
                                FROM EMPLOYEE 
                                JOIN JOB USING (JOB_ID) 
                                WHERE JOB_TITLE = '����');

-- ���������� ��� ��ġ : SELECT ��, FROM ��, WHERE ��, GROUP BY ��, HAVING ��, ORDER BY ��
-- INSERT ��, UPDATE ��, CREATE TABLE ��, CREATE VIEW ��

-- �ڱ� ������ ��� �޿��� �޴� ���� ��ȸ
-- 1. ���޺� �޿� ���
SELECT JOB_ID, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
GROUP BY JOB_ID;

-- 2. �������� ����
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE SALARY IN (SELECT TRUNC(AVG(SALARY), -5)
                            FROM EMPLOYEE
                            GROUP BY JOB_ID);

-- ������ ���߿� ��������
-- �������� SELECT ���� �׸��� ���� ���� ��� : ���� �� (MULTIPLE COLUMN)
-- (���÷���, ���÷���) �񱳿����� (���߿� ��������)
-- �������� SELECT ���� �׸�(�÷�) ������ �ڷ����� ���߾ ���ؾ��� *�߿�*
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE (JOB_ID, SALARY) IN (SELECT JOB_ID, TRUNC(AVG(SALARY), -5)
                            FROM EMPLOYEE
                            GROUP BY JOB_ID);

-- FROM ������ �������� ����� �� ���� : ���̺� ��ſ� �����
-- FROM (��������) ��Ī <-- ��Ī(ALIAS)�� ���̺�� �����
-- FROM ������ ���� ���������� ���� ��������� �ζ��κ�(INLINE VIEW)��� ��
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM (SELECT JOB_ID, TRUNC(AVG(SALARY), -5) JOBAVG
            FROM EMPLOYEE
            GROUP BY JOB_ID) V -- �ζ��� ��
JOIN EMPLOYEE E ON (V.JOBAVG = E.SALARY AND NVL(V.JOB_ID, ' ') = NVL(E.JOB_ID, ' '))
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
ORDER BY 3, 2;

-- ���������� ����
-- ������ ��������, ������ ��������, ������ ���߿� ��������, ��[ȣ��]�� ��������, ��Į�� �������� 
-- ��κ��� ���������� ���������� ����� �� ������� ���������� ����ϴ� �����
-- ��������� ���������� ���������� ���� �����ٰ� ����� ������ ����
-- �׷��Ƿ� ���������� ���� �ٲ�� ���������� ����� �޶����Ե� -> �׷��� ��ȣ���� ����������� ��

-- �ڱ� ������ ��� �޿��� �޴� ���� ��ȸ : ��ȣ���� ���������� ����� ���
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID) 
WHERE SALARY = (SELECT TRUNC(AVG(SALARY), -5)
                            FROM EMPLOYEE
                            WHERE JOB_ID = E.JOB_ID) -- ���������� �ִ� �׸��� �����ٰ� ������������ �����
ORDER BY 3 DESC NULLS LAST;

-- EXISTS / NOT EXISTS ������
-- ��ȣ���� ���������� �տ����� �����
-- ���������� ���� ����� �����ϴ��� ��� ���� EXISTS ���
-- ���������� SELECT ���� �÷� ����ϸ� �ȵ�. �׷��� NULL ����Ͽ� �����÷� ����.

-- �� : �������� ������ ��ȸ
SELECT EMP_ID, EMP_NAME, '������' ����
FROM EMPLOYEE E
WHERE EXISTS (SELECT NULL
                        FROM EMPLOYEE
                        WHERE E.EMP_ID = MGR_ID);

-- �����ڰ� �ƴ� ������ ��ȸ
SELECT EMP_ID, EMP_NAME, '����' ����
FROM EMPLOYEE E
WHERE NOT EXISTS (SELECT NULL
                        FROM EMPLOYEE
                        WHERE E.EMP_ID = MGR_ID);
                        
-- ��Į�� ��������
-- ������ �������� + ��ȣ���� ��������
-- �� : �̸�, �μ��ڵ�, �޿�, �ش� ������ �Ҽӵ� �μ��� �޿����
SELECT EMP_NAME, DEPT_ID, SALARY, 
            (SELECT TRUNC(AVG(SALARY), -5)
            FROM EMPLOYEE
            WHERE DEPT_ID = E.DEPT_ID) AVGSAL
FROM EMPLOYEE E;

-- CASE ǥ������ ����� ��Į�� ��������
-- �μ��� �ٹ������� 'OT' �̸� '������', �ƴϸ� '������' ���� ǥ�� ��ȸ
SELECT EMP_ID, EMP_NAME,
            CASE WHEN DEPT_ID = (SELECT DEPT_ID
                                                FROM DEPARTMENT
                                                WHERE LOC_ID = 'OT')
            THEN '������'
            ELSE '������'
            END �Ҽ�
FROM EMPLOYEE
ORDER BY �Ҽ� DESC;

-- ORDER BY ���� ��Į�� �������� ��� ��
-- ������ �Ҽӵ� �μ��� �μ����� ū ������ �����ؼ� ���� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_ID, HIRE_DATE
FROM EMPLOYEE E
ORDER BY (SELECT DEPT_NAME
                    FROM DEPARTMENT
                    WHERE DEPT_ID = E.DEPT_ID) DESC;

-- TOP-N �м� ----------------------------------------------------------------------------------------
-- ���� �� ��, ���� �� ���� ��ȸ�ϴ� ��
-- �ζ��� ��� RANK() �Լ��� �̿��ϴ� �����
-- ROWNUM �� �̿��� TOP-N �м� 

-- 1. �ζ��� ��� RANK() �Լ��� �̿��� TOP-N �м�
-- ���� �������� �޿��� ���� ���� �޴� ���� 5�� ��ȸ 
-- �̸�, �޿�, ����
SELECT *
FROM (SELECT EMP_NAME, SALARY, RANK() OVER (ORDER BY SALARY DESC) ����
            FROM EMPLOYEE)
WHERE ���� <= 5;

-- 2. ROWNUM �� �̿��� TOP-N �м�
-- ORDER BY �� ����� ROWNUM �� ���̴� �۾��ؾ��� -> ���������� �̿��ؾ���
-- ROWNUM : ���ȣ�� �ǹ���, WHERE ó�� �Ŀ� �ڵ����� �ο���

-- Ȯ��
SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE -- �� �� �տ� ROWNUM ǥ�õ�
ORDER BY SALARY DESC;

-- �޿� ���� �޴� ���� 3�� ��ȸ
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM < 4 -- WHERE �� ������ ROWNUM �ο���
ORDER BY SALARY DESC; -- Ʋ�� ��� ����

-- �ذ� : �����ϰ� ���� ROWNUM �� �ο��ǰԲ� �ϸ� ��
-- �ζ��� �� ���
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
            FROM EMPLOYEE
            ORDER BY SALARY DESC) -- ���� �Ŀ� ROWNUM �� �ο���
WHERE ROWNUM < 4;
