-----------------------------------------------------------------
----------------------------- 5���� ���� -------------------------
-----------------------------------------------------------------





-- ���� ��� (���̾ƿ�)
-- ������ȣ / �������� / ����� ���� (�系�κ�) / �ڳ༺�� / �ڳ������� / �ֵ��̿���
-- EMP_C / EMP_C / EMP_C , FAM_REL_C / FAM_C / FAM_C / FAM_C
-- �䱸����
-- ���̺�� �÷�����
-- ���� ������ --> ������ �ٶ� �� ����� , �߰� �ɰ��� ������ �ذ��ϰ�, ����.
-- �ɰ� �� sql �Ѱ� �� ����� ����
-- ��ġ��
-- �ڳ� ���ְ� , ��������� 20120101' AND '20151231' , �ֵ��� ù°��.
-- ��������
 
---1��°.
SELECT
 EMP.EMP_NO AS "������ȣ"
,EMP.EMP_NM AS  "��������"
,FAM.FAM_NM AS "�ڳ༺��"
,FAM.BIRTH_YMD AS "�ڳ�������"
  FROM
 EMP_C EMP
 INNER JOIN FAM_C FAM
ON EMP.EMP_NO = FAM.EMP_NO
AND FAM.REL_TYPE_CD= 'A27'
WHERE '20221005' BETWEEN HIRE_YMD AND RETIRE_YMD -- ������
AND FAM.BIRTH_YMD BETWEEN '20120101' AND '20151231'
;
 --2��° --�系�κο��� --> �系�κ� �ϼ��� .? �ƴҼ��� ? ������,
 --������ �������� �Ƴ��� ����.
SELECT
 * FROM EMP_C EMP
LEFT OUTER JOIN FAM_REL_C FAMR
ON EMP.EMP_NO = FAMR.EMP_NO
AND FAMR.REL_TYPE_CD IN ('A18','A02')
;
 --3��° �ֵ��� =
 --������� ����. =
--�̸��� �ٸ���. <>
-- ���� ���̺��� �ι� JOIN
SELECT
  FAM1.*
   FROM
  FAM_C FAM1
  INNER JOIN FAM_C FAM2
  ON FAM1.EMP_NO = FAM2.EMP_NO
  AND FAM1.REL_TYPE_CD = FAM2.REL_TYPE_CD
  AND FAM1.BIRTH_YMD = FAM2.BIRTH_YMD
  AND FAM1.FAM_NM <> FAM2.FAM_NM
  --WHERE FAM1.EMP_NO = '10007225'
  ;
  -- EQUAL =
  -- NOT EQUAL <>
 
  -- INNER JOIN ������ : �����̸鼭 �ڳడ �ִ�. EMP_C FAM_C
  -- LEFT OUTER JOIN ������ + �������̺� ROW : �����߿� �系�κ��� ��� -- �系�κδ� ? ��� �������� �系�κ� �ƴ�.
  -- �ʼ�������� �ƴ�, ������, �系�κ��ϼ��� �ְ�, �ƴҼ��� �ְ�,
  
  ---��ġ��
  -- �輱ȣ:
  -- �����:
  -- ������:
  -- �ֽſ�:
  -- �Ѽ���:
 
 
 
 -- �Ի���(19700101) ------ >   ���� '20221005' -------> �̷�(9991231)
 
 
 
 
 
 
 
 
 -- ��ġ��
SELECT
  EMP.EMP_NO AS "������ȣ"
,EMP.EMP_NM AS  "��������"
,FAM.FAM_NM AS "�ڳ༺��"
,FAM.BIRTH_YMD AS "�ڳ�������"
,FAMR.EMP_REL_NO AS "�������������ȣ"
, TWIN.*
  FROM
 EMP_C EMP  --����1
INNER JOIN FAM_C FAM --���1
ON EMP.EMP_NO = FAM.EMP_NO
AND FAM.REL_TYPE_CD= 'A27'
 LEFT OUTER JOIN FAM_REL_C FAMR --���2
--INNER JOIN FAM_REL_C FAMR --���2
ON EMP.EMP_NO = FAMR.EMP_NO
AND FAMR.REL_TYPE_CD IN ('A18','A02')
LEFT OUTER JOIN
(
  SELECT
  FAM1.EMP_NO
  ,FAM1.FAM_NM
  --.FAM1.*
   FROM
  FAM_C FAM1
  INNER JOIN FAM_C FAM2
  ON FAM1.EMP_NO = FAM2.EMP_NO
  AND FAM1.REL_TYPE_CD = FAM2.REL_TYPE_CD
  AND FAM1.BIRTH_YMD = FAM2.BIRTH_YMD
  AND FAM1.FAM_NM <> FAM2.FAM_NM
) TWIN --�ڳ� �ζ��κ�
ON FAM.EMP_NO = TWIN.EMP_NO
AND FAM.FAM_NM = TWIN.FAM_NM
WHERE '20221005' BETWEEN HIRE_YMD AND RETIRE_YMD -- ������
AND FAM.BIRTH_YMD BETWEEN '20120101' AND '20151231'
;












