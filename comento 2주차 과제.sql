SELECT * FROM ALL_TABLES;

SELECT * FROM T_DEPT;
SELECT * FROM T_EMP;

SELECT * FROM EMP_C;
SELECT * FROM FAM_C;
SELECT * FROM ORG_C;
SELECT * FROM FAM_REL_C;

SELECT * FROM EMP_C
WHERE emp_no = 10004141;
SELECT * FROM FAM_C 
WHERE emp_no = 10004141;
SELECT * FROM FAM_REL_C
WHERE emp_no = 10004141;

-----------------------------------------------------------------
----------------------------- 2���� ���� -------------------------
-----------------------------------------------------------------

--����1) ������ȣ 10004141 �� �̸���? ��Ʈ : emp_c�� ����
--  �֤���
SELECT EMP_NM FROM EMP_C
WHERE EMP_NO = 10004141;
SELECT * FROM EMP_C
WHERE EMP_NO = 10004141;

--����2) ������ȣ 10004141 �� �� ���� ������ �ֳ���? ��Ʈ fam_c
--  5��
SELECT * FROM FAM_C
WHERE EMP_NO = 10004141;

--����3) ������ȣ 10004141 �� �Ҽ� �μ� �ڵ��? ��Ʈ emp_c
-- A183500
SELECT ORG_CD FROM EMP_C
WHERE EMP_NO = 10004141;


--����4) ������ȣ 10004141 �� �Ҽ� �μ� ����?  ��Ʈ org_c
-- ��XX��
SELECT ORG_NM FROM ORG_C
WHERE ORG_CD = 'A183500';

--����5) ���� / ���� ������ �� ������ �ѹ��� �� �� �ִ� sql�� �ۼ��ϼ���. (group by gender_cd)
-- �� 1374�� // �� 621��
-- ��ü ������ ������ϴ� COUNT���� �Լ� ����ؾ���

--SELECT COUNT(GENDER_CD) --DECODE(SUBSTR(GENDER_CD,1,1),1,'��','��') AS ����  
--FROM EMP_C
--GROUP BY GENDER_CD;
--HAVING GENDER_CD = 2; -- �ʿ���� ����

SELECT GENDER_CD,COUNT(*)
FROM EMP_C
GROUP BY GENDER_CD;

-- DECODE+ALIAS�� �з� �÷� �߰�
SELECT DECODE(SUBSTR(GENDER_CD,1,1),1,'��','��') AS ����, COUNT(*)
FROM EMP_C
GROUP BY GENDER_CD;





--����6) ������ �ڳడ �� ������ �ѹ��� �� �� �ִ� sql�� �ۼ��ϼ���. (rel_type_cd�� A27�̸� �ڳ�)
--

SELECT *
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE REL_TYPE_CD = 'A27';    
--WHERE EMP_NO = 10004141;

-- WHERE���� E.EMP_NO = 10004141 �߰��� �־ ��� �Ѹ��� �ڳ� ��� Ȯ��
SELECT E.EMP_NO, EMP_NM, E.BIRTH_YMD, FAM_NM, REL_TYPE_CD,F.BIRTH_YMD
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE REL_TYPE_CD = 'A27'
AND E.EMP_NO = 10004141; -- 10004141	�֤���	19551223	�֤�ö	A27	19850503

-- �ڳ� ���� �� Ȯ�� ������ COUNT()�� �ڳ�� ��ȸ����
SELECT COUNT(E.EMP_NO)
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE REL_TYPE_CD = 'A27'
AND E.EMP_NO = 10004141; -- 2

-- ��ü ������ �ڳ�� �ε�. ���� �� �ڳ���� �ʿ�
SELECT COUNT(E.EMP_NO)
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE REL_TYPE_CD = 'A27'; -- 2412

-- ���� ���̴ϱ� GROUP BY ���� ���� ����� EMP_NO�̸� �� ��
SELECT E.EMP_NO, COUNT(E.EMP_NO)
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)    
WHERE REL_TYPE_CD = 'A27'
GROUP BY E.EMP_NO; -- ������ �� 1239

--SELECT E.EMP_NO,E.EMP_NM, COUNT(E.EMP_NO)
--FROM EMP_C E
--    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)    
--WHERE REL_TYPE_CD = 'A27'
--GROUP BY E.EMP_NO; -- ������ �� 1239 -> ��ȸ�ҷ��� �÷��� �׷���̷� ������ �ȵƱ⿡ ���� �߻�

-- ANSI ǥ�� JOIN
SELECT E.EMP_NO, E.EMP_NM, COUNT(E.EMP_NO) "�ڳ��"
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)    
WHERE REL_TYPE_CD = 'A27'
GROUP BY E.EMP_NO, E.EMP_NM; -- ������ �� 1239

-- ����Ŭ ���� JOIN����
SELECT E.EMP_NO, E.EMP_NM, COUNT(E.EMP_NO) "�ڳ��"
FROM EMP_C E, FAM_C F
WHERE E.EMP_NO = F.EMP_NO
AND REL_TYPE_CD = 'A27'
GROUP BY E.EMP_NO, E.EMP_NM;  -- ������ �� 1239



--����7) ��������� 1970�� 1�� 1�� ������ ������ ���� ���ϴ� sql�� �ۼ��ϼ���.
--


--����8) ���� ���� ���� ������ ��ü ���� ���ϴ� sql�� �ۼ��ϼ���


SELECT * FROM EMP_C;
SELECT * FROM FAM_C;
SELECT * FROM ORG_C;
SELECT * FROM FAM_REL_C;

