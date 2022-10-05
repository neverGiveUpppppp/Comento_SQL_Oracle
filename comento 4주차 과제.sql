-----------------------------------------------------------------
----------------------------- 4���� ���� -------------------------
-----------------------------------------------------------------


SELECT * FROM EMP_C;
SELECT * FROM FAM_C;
SELECT * FROM ORG_C;
SELECT * FROM FAM_REL_C;


--1)�Ʒ��� ���� ���� ����� �����ϴ� sql�� �ۼ��غ�����
--�̹� 70% ���� ¥���� SQL�� �ϼ��ϼ���. (SQL DEVELOPER�� ���� �忡 �ִ� SQL�� �ٿ��ֱ� �Ͽ� �����Ͻø鼭 ���� SQL�� �ۼ��غ�����.
--- ��������1 :  ���� �������� ������ ��������� 2012�� 1�� 1�� ���� 2015�� 12�� 31�� �� �ڳ� �������
--- ��������2 : �ֵ����� ��� �θ� ��� �����ϰ�, �ֵ��� ���ο�  ��Y�� ǥ�� ���
--- ��������3 : �系�κ��� ��쵵 ���� ���� ������ �ڳฦ ��� �����ϰ�, �� �� ��� ������� ������ȣ�� ���� ���
---  ���� ��û �÷� �� ������ȣ / �������� / ����ڼ��� (�系�κ��� ����) / �����������ȣ / �ڳ༺�� / �ڳ༺�� / �ڳ������� / �ֻ��ƿ���


-- ���� brainstorming
-- ������ : RETIRE 99/12/31 ����
-- �ڳ� ������� 2012.01.01~2015.12.31 : BETWEEN 20120101 AND 20151231
-- �ֵ����� ��� �θ� ��� ���� : FAM_C SELF JOIN FAM_NM�� F1,F2 ���� ��ȸ �� ���ǿ� NM <>�߰�
--�ֵ��� ���� ǥ�� 'Y' : ���ͷ� �ۼ�
-- �系�κ��� ���, ��� ������� ������ȣ ���� : ?
-- ��ȸ ��� : EMP_NO, EMP_NM, CASE(SPOUSE_EMP_NO �系�κ��϶�,�Ϲ��϶�), CHILD_NM, CHILD_GENDER, CHILD_BIRTH_YMD, TWIN_YN
--(������ȣ / �������� / ����ڼ��� (�系�κ��� ����) / �����������ȣ / �ڳ༺�� / �ڳ༺�� / �ڳ������� / �ֻ��ƿ���)


--- ��������1
--- ���� �������� ������ ��������� 2012�� 1�� 1�� ���� 2015�� 12�� 31�� �� �ڳ� �������
SELECT *
FROM FAM_C
WHERE REL_TYPE_CD = 'A27'
AND BIRTH_YMD BETWEEN 20120101 AND 20151231
;

--- ��������2
--- �ֵ����� ��� �θ� ��� �����ϰ�, �ֵ��� ���ο� 'Y' ǥ�� ���
SELECT F1.EMP_NO ������ȣ, F1.FAM_NM �ֵ���1, F2.FAM_NM �ֵ���2, 'Y' "�ֵ��� ����"
FROM FAM_C F1
    JOIN FAM_C F2 ON(F1.EMP_NO = F2. EMP_NO)
AND F1.FAM_NM <> F2.FAM_NM
AND F1.REL_TYPE_CD = 'A27'
AND F1.REL_TYPE_CD = F2.REL_TYPE_CD
AND F1.BIRTH_YMD = F2.BIRTH_YMD
;
    
 
 
 
--- ��������1 + ��������2
--- ���� �������� ������ ��������� 2012�� 1�� 1�� ���� 2015�� 12�� 31�� �� �ڳ� �������
--- �ֵ����� ��� �θ� ��� �����ϰ�, �ֵ��� ���ο� 'Y' ǥ�� ���
SELECT *
FROM FAM_C
WHERE REL_TYPE_CD = 'A27' 
AND BIRTH_YMD BETWEEN 20120101 AND 20151231
;

SELECT F1.EMP_NO ������ȣ, F1.FAM_NM �ֵ���1, F2.FAM_NM �ֵ���2, 'Y' "�ֵ��� ����"
FROM FAM_C F1
    JOIN FAM_C F2 ON(F1.EMP_NO = F2. EMP_NO)
AND F1.FAM_NM <> F2.FAM_NM
AND F1.REL_TYPE_CD = 'A27'
AND F1.REL_TYPE_CD = F2.REL_TYPE_CD
AND F1.BIRTH_YMD = F2.BIRTH_YMD
;

-- FROM���� AND���ǵ��� WHERE���� ������ ������ ���� �ٸ���?
SELECT F1.EMP_NO ������ȣ, F1.FAM_NM �ֵ���1, F2.FAM_NM �ֵ���2, 'Y' "�ֵ��� ����"
FROM FAM_C F1
    JOIN FAM_C F2 ON(F1.EMP_NO = F2. EMP_NO)
WHERE F1.FAM_NM <> F2.FAM_NM
AND F1.REL_TYPE_CD = 'A27'
AND F1.REL_TYPE_CD = F2.REL_TYPE_CD
AND F1.BIRTH_YMD = F2.BIRTH_YMD    
;


    
--- ��������3
--- �系�κ��� ��쵵?���� ���� ������ �ڳฦ ��� �����ϰ�, �� �� ��� ������� ������ȣ�� ���� ���
-- ��ȸ : ����, �ڳ�, �����������ȣ
-- �系�κ� : �������� + REL_TYPE_CD = 'A02,18' + UNION ALL
-- ��� ������� ������ȣ�� ���� ���


SELECT EMP.EMP_NO  FROM
(SELECT * FROM EMP_C WHERE '20210321' BETWEEN HIRE_YMD AND RETIRE_YMD) EMP
INNER JOIN
(SELECT * FROM FAM_REL_C WHERE '20210321' BETWEEN STA_YMD AND END_YMD) FREL
ON EMP.EMP_NO = FREL.EMP_NO
AND FREL.REL_TYPE_CD = 'A02' --�Ƴ�
UNION ALL
SELECT EMP.EMP_NO FROM
(SELECT * FROM EMP_C WHERE '20210321' BETWEEN HIRE_YMD AND RETIRE_YMD) EMP
INNER JOIN
(SELECT * FROM FAM_REL_C WHERE '20210321' BETWEEN STA_YMD AND END_YMD) FREL
ON EMP.EMP_NO = FREL.EMP_NO
AND FREL.REL_TYPE_CD = 'A18' --����
;


-- CASE �ֵ��� ���� ������غ���
SELECT 
CASE 
    NVL2((SELECT F1.EMP_NO ������ȣ, F1.FAM_NM �ֵ���1, F2.FAM_NM �ֵ���2, 'Y' "�ֵ��� ����"
    FROM FAM_C F1
        JOIN FAM_C F2 ON(F1.EMP_NO = F2. EMP_NO)
    AND F1.FAM_NM <> F2.FAM_NM
    AND F1.REL_TYPE_CD = 'A27'
    AND F1.REL_TYPE_CD = F2.REL_TYPE_CD
    AND F1.BIRTH_YMD = F2.BIRTH_YMD),0,1)
WHEN 1 THEN 'Y'
ELSE 'N'
END "�ֵ��� ����"
FROM DUAL; 
-- ORA-00913: ���� ���� �ʹ� �����ϴ�
-- 00913. 00000 -  "too many values"
-- �� ���� �ʹ� �����ɱ�...?


-- ��Ʈ ����
SELECT
EMP.EMP_NO AS ������ȣ
,EMP.EMP_NM AS ��������
,-- --> �ڡڡ� ����� ������ȣ �ϼ��ϼ���!!
,FAM.FAM_NM AS �ڳ༺��
,FAM.GENDER_CD AS  �ڳ༺��
,FAM.BIRTH_YMD AS �ڳ�������
,CASE WHEN -- --> �ڡڡ� CASE WHEN�� ����Ͽ� �ֵ��� ���θ� ǥ���غ�����.
--CASE WHEN ���ǽ� THEN �����
--WHEN ���ǽ�THEN �����
--ELSE �����
--END
-- �ֵ��� ���θ� �������� ���� �����ų� ���� �� ����ϴµ� ��� ����ұ�?
-- ���������� ���� ���� �־ �ϸ� �� �� ������, ������ ������ ���¸� ��� ������ұ�?
-- �ֵ��� ���ΰ� Y��� 1 �ƴϸ� 2������ �غ���
-- CASE WHEN�� WHEN ���� ���� �� �������������� �־ �����°� ���� Y�� �־���ϴµ�..
-- NVL2�� ���μ� ��ġ��ȯ : NVL2(�÷���, NULL�̸� �̰ɷ� ����, NULL�� �ƴϸ� �̰ɷ� ����)
-- OR DECODE : DECODE(����|�÷���, ���ǰ�1, ���ð�1, ���ǰ�2, ���ð�2, ...)

CASE 
    NVL2((SELECT F1.EMP_NO ������ȣ, F1.FAM_NM �ֵ���1, F2.FAM_NM �ֵ���2, 'Y' "�ֵ��� ����"
    FROM FAM_C F1
        JOIN FAM_C F2 ON(F1.EMP_NO = F2. EMP_NO)
    AND F1.FAM_NM <> F2.FAM_NM
    AND F1.REL_TYPE_CD = 'A27'
    AND F1.REL_TYPE_CD = F2.REL_TYPE_CD
    AND F1.BIRTH_YMD = F2.BIRTH_YMD),0,1)
WHEN 0 THEN 'N'
WHEN 1 THEN 'Y'
ELSE '?'
END "�ֵ��� ����"
        FROM EMP_C EMP,
        FAM_C FAM,
        FAM_REL_C FAMR,
        (
              SELECT
                TWIN1.EMP_NO
                ,TWIN1.FAM_NM AS TWIN1
                ,TWIN2.FAM_NM AS TWIN2
                FROM
                   FAM_C TWIN1 , FAM_C TWIN2
                WHERE TWIN1.EMP_NO = TWIN2.EMP_NO
                AND TWIN1.REL_TYPE_CD = TWIN2.REL_TYPE_CD
                AND TWIN1.REL_TYPE_CD = 'A27'
                AND TWIN2.REL_TYPE_CD = 'A27'
                AND TWIN1.FAM_NM <> TWIN2.FAM_NM-- �̸��� �ٸ� ����
                AND TWIN1.BIRTH_YMD = TWIN2.BIRTH_YMD -- ��������� ���� ����
        ) TWIN
WHERE EMP.EMP_NO = FAM.EMP_NO
AND -- --> �ڡڡ� ���� �����ڸ� ���� �ǵ��� ������ ��������.
AND FAM.REL_TYPE_CD  = 'A27'
AND -- --> �ڡڡ� 2012�� 1�� 1�� ���� 2015�� 12�� 31�� ������� ������ ��������.
AND EMP.EMP_NO = FAMR.EMP_NO (+)
AND FAMR.REL_TYPE_CD (+) IN ('A02','A18')
AND EMP.EMP_NO = TWIN.EMP_NO (+)
AND FAM.FAM_NM = TWIN.TWIN1 (+)

;



SELECT * FROM EMP_C;
SELECT * FROM FAM_C;
SELECT * FROM ORG_C;
SELECT * FROM FAM_REL_C;



-- 2)LISTAGG�� Ȱ���Ͽ� ������ȣ�� 10001483 �� �ڳ��� ������ ���ٷ� ���� �ǵ��� SQL�� �ۼ��� ������. (���ð���, �����ϴ� �������� �ѹ� �غ�����!^^;)
-- HINT : LISTAGG Ȱ�� --> https://gent.tistory.com/328


SELECT * FROM EMP_C;
SELECT * FROM FAM_C;
SELECT * FROM ORG_C;
SELECT * FROM FAM_REL_C;
















