-----------------------------------------------------------------
----------------------------- 3���� ���� -------------------------
-----------------------------------------------------------------

/*
1.���� ���ó�� �����͸� ���� �� �� �ֵ��� sql�� �ۼ��� ������.
2.����ڵ� (REL_TYPE_CD)
�ڳ� = A27, �Ƴ� = A02, ���� = A18
*/

SELECT * FROM EMP_C;
SELECT * FROM FAM_C;
SELECT * FROM ORG_C;
SELECT * FROM FAM_REL_C;


--1)��������� 20120101���� 20151231 ������ �ֵ��� �ڳฦ ���� �������� ���ϼ���.
--HINT1: FAM_C���̺�� FAM_C���̺��� ���� �����ؾ��մϴ�. ���� �� �ֵ����� ���ǿ� ���� �� �����غ�����. �̸��� �ٸ���, ��������� ����

SELECT
    f.birth_ymd,
    f.fam_nm
--SELECT *
FROM
         emp_c e
    JOIN fam_c     f ON ( e.emp_no = f.emp_no )
    JOIN fam_rel_c fr ON ( f.emp_no = fr.emp_no ) -- REL_TYPE_CD���� �ڳ�(=A27)�� �̾ƺ��� ���� JOIN�߰�
WHERE
    f.birth_ymd BETWEEN 20120101 AND 20151231;
GROUP BY F.BIRTH_YMD, F.FAM_NM;     

SELECT F.BIRTH_YMD, F.FAM_NM
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE F.BIRTH_YMD BETWEEN 20120101 AND 20151231
AND REL_TYPE_CD = 'A27'
GROUP BY F.BIRTH_YMD, F.FAM_NM;    
-- �ֵ���1,2�� �÷� ������ ����ؾ���

SELECT F.BIRTH_YMD, /*COUNT(*)*/ 
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE F.BIRTH_YMD BETWEEN 20120101 AND 20151231
AND REL_TYPE_CD = 'A27'
GROUP BY F.BIRTH_YMD;  
-- �����ϴ� ������ ������ȣ/�ֵ���1/�ֵ���2��
-- GROUP BY�� �ƴ� ���� : ��ȸ ��, �׷����� ���� �����µ� 
-- �̷��� ������ ��ȸ���ó�� ������ȣ �ϳ��� �ֵ���1,2 ���ٷ� ������

SELECT EMP_NO, F.FAM_NM �ֵ���1, F.FAM_NM �ֵ���2
FROM EMP_C E
    JOIN FAM_C F USING(EMP_NO)
WHERE F.BIRTH_YMD BETWEEN 20120101 AND 20151231
-- �ֵ��� 1,2�� ��� �������� ��...
;


--2)20210321 �������� �������� �������̸�, 
-- ��������� 20120101���� 20151231�� �ڳฦ ���� �������� ���ϴ� sql�� �ۼ��ϼ���.
--HINT : EMP_C�� FAM_C�� �����ؾ� �մϴ�.

SELECT F.BIRTH_YMD, COUNT(*)
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
GROUP BY F.BIRTH_YMD 
HAVING F.BIRTH_YMD BETWEEN 20120101 AND 20151231
ORDER BY 1;

SELECT E.EMP_NO, F.BIRTH_YMD, F.FAM_NM �ֵ���1, F.FAM_NM �ֵ���2
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE F.BIRTH_YMD BETWEEN 20120101 AND 20151231
GROUP BY E.EMP_NO,F.BIRTH_YMD, F.FAM_NM; 


SELECT E.EMP_NO "������ȣ", F.FAM_NM �ڳ༺��, F.BIRTH_YMD AS �ڳ�������
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE F.BIRTH_YMD BETWEEN 20120101 AND 20151231
AND E.RETIRE_YMD > '990101'
ORDER BY 1 DESC;


-- =���� 991231�� �ȳ�����
-- =���� 99991231�� ����
select * from emp_c 
where retire_ymd = '99991231' 
order by retire_ymd desc;



--3)20210321 �������� �������� �������̸�,�系�κ��� �������� ������ȣ�� ���ϴ� sql�� �ۼ��ϼ���.
--HINT : EMP_C�� FAM_REL_C�� �����ؾ� �մϴ�.
-- ��ȸ : ������ȣ
-- ������ : RETIRE 99/12/31 ����
-- �系�κ� : ? // �ϴ� EMP_NO = EMP_REL_NO �ƴ�


-- ������ȣ�� ����������ȣ =���� �غ����� X
SELECT *
FROM EMP_C E
    JOIN FAM_REL_C FR ON(E.EMP_NO = FR.EMP_NO)
WHERE E.EMP_NO = FR.EMP_REL_NO  -- ������ȣ�� ����������ȣ =���� �غ����� X
;    


SELECT *
FROM EMP_C E
    JOIN FAM_REL_C FR ON(E.EMP_NO = FR.EMP_REL_NO)
WHERE E.EMP_NO = FR.EMP_REL_NO  -- ������ȣ�� ����������ȣ =���� �غ����� X
;    

SELECT *
FROM EMP_C E
    JOIN FAM_REL_C FR ON(E.EMP_NO = FR.EMP_REL_NO)
WHERE E.EMP_NO = FR.EMP_REL_NO 
AND REL_TYPE_CD IN('A02', 'A18')
;   

SELECT * FROM EMP_C;
SELECT * FROM FAM_C;
SELECT * FROM ORG_C;
SELECT * FROM FAM_REL_C;

SELECT * 
FROM EMP_C  
WHERE EMP_NO = 11501824;
SELECT * 
FROM FAM_C
WHERE EMP_NO = 11501824;
SELECT * 
FROM FAM_REL_C
WHERE EMP_NO = 11501824;




--3-2) ���� ��¥ ���� �������� "�̾� ������ ���� ������ �ڳ����� �� ������ ����Ʈ�� ���弼��.
--��Ʈ: substr, count(*)�� ���
-- ������ : RETIRE 99/12/31 ����
-- ���� ��¥ ����
-- �̾��� : LIKE '��%'
-- �ڳ��

-- ���� : ������+�̾���
SELECT *
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE E.RETIRE_YMD = '99991231'
AND E.EMP_NM LIKE '��%'
;    

-- COUNT + LIKE
SELECT E.EMP_NM ������, COUNT(*)
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE E.RETIRE_YMD = '99991231'
AND E.EMP_NM LIKE '��%'
GROUP BY E.EMP_NM
;    

-- COUNT(SUBSTR)+ LIKE
SELECT E.EMP_NM, COUNT(SUBSTR(E.EMP_NM,2,4)) AS "�ڳ���"
FROM EMP_C E
    JOIN FAM_C F USING(EMP_NO)
WHERE E.RETIRE_YMD = '99991231'
AND E.EMP_NM LIKE '��%'
GROUP BY E.EMP_NM
;    

-- COUNT + SUBSTR
SELECT E.EMP_NM, COUNT(*) AS "�ڳ���"
FROM EMP_C E
    JOIN FAM_C F USING(EMP_NO)
WHERE E.RETIRE_YMD = '99991231'
AND SUBSTR(E.EMP_NM, 1,1) = '��'
GROUP BY E.EMP_NM
;  


--3-3) �ڳ� ����� 2�� �̻��� ������ ����Ʈ�� ���ϼ���.(������ȣ?/?����?/?�ڳ���?)
--��Ʈ having
-- ��ȸ �÷� : ������ȣ/����/�ڳ���
-- �ڳ�� 2�� �̻� : REL_TYPE_CD A=27�� �ڳ��̹Ƿ� �̰� 2ROW �̻�

-- A27Ÿ���� �ڳ���� ��ȸ
SELECT COUNT(F.REL_TYPE_CD)
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE F.REL_TYPE_CD = 'A27'    
;

SELECT E.EMP_NO ������ȣ, E.EMP_NM ����, COUNT(*)
FROM EMP_C E 
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE F.REL_TYPE_CD = 'A27'    -- �ڳ�(A27) ���� ����
GROUP BY E.EMP_NO ,E.EMP_NM    
-- ��ȸ�� �ʿ��� EMP_NO,EMP_NM�� ��ȸ�ϱ� ���� GROUP BY ��� �ʿ�. 
-- COUNT�� ������ �׷� �Լ��̱⿡ ������ �׷��Լ� COUNT�� �ٸ� �൵ ��ȸ�ϱ� ���� �����
HAVING COUNT(F.REL_TYPE_CD) > 2 
-- WHERE������ �ڳ��ִ� ������ ��� ��, HAVING���� 2���̻� ���� ����
-- ���� GROUP BY ������ȣ�� ������ ��� ��ȸ
;    


SELECT * FROM EMP_C;
SELECT * FROM FAM_C;
SELECT * FROM ORG_C;
SELECT * FROM FAM_REL_C;


--3-4) ���� ���� ������ �μ��� ������ �� ������ ���ϴ� sql�� �ۼ��ϼ���. (�����ڵ�, ������, ������)
--��Ʈ group by org_cd, org_nm
-- ���� ���� : ?
-- ��
-- �μ��� ���� �� : COUNT(*)���� ���� : GROUP BY ?(ORG..?)
SELECT
    org_nm   �����з�,
    COUNT(*) ������
FROM
         emp_c e
    JOIN org_c o USING ( org_cd )
GROUP BY
    org_nm;    
;    