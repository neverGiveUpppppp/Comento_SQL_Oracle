
-----------------------------------------------------------------
----------------------------- 3���� ���� -------------------------
-----------------------------------------------------------------


SELECT * FROM EMP_C;
SELECT * FROM FAM_C;
SELECT * FROM ORG_C;
SELECT * FROM FAM_REL_C;


-- ORDER BY ��������
SELECT * FROM EMP_C
ORDER BY EMP_NM ASC, BIRTH_YMD DESC;

SELECT * FROM EMP_C
ORDER BY NOTE DESC;
SELECT * FROM EMP_C
ORDER BY NOTE DESC, EMP_NO ASC;


-- LIKE
SELECT * FROM EMP_C
WHERE EMP_NM LIKE '��%'; 
-- 11500019	������	1 ...
SELECT *
     FROM EMP_C
WHERE EMP_NM LIKE '%��%'; 

-- IN

-- GROUP BY

/*
----------------------------------------------------------
-------------------------���� ����-------------------------
----------------------------------------------------------

    select  -- �����Ͷ�
      *     -- ���
      from emp_c
      ;
       
    select  -- �����Ͷ�
      emp_no
      from emp_c
      ;
      
    select  -- �����Ͷ�
       emp_no
      ,emp_nm
      from emp_c
      ;
      
    select  -- �����Ͷ�
       emp_no
      ,emp_nm
      ,gender_cd
      from emp_c
    where gender_cd = '1';
    
    select  -- �����Ͷ�
       emp_no
      ,emp_nm
      ,gender_cd
      from emp_c
    where gender_cd = '1'
    and birth_ymd > '19500101' -- and�� ���ǰ� ������ �̾���.
    ;
    
    select 
     * 
    from emp_c
    order by emp_nm asc;-- ��������
    
    select 
     * 
    from emp_c
    order by emp_nm DESC;-- ��������
    
    select 
     * 
    from emp_c
    order by emp_nm ASC, BIRTH_YMD DESC;-- ��������
    
    --�ֵ��� --> ��ǥ: �̸����� �������� ���� �� ������.
    
    select  -- �����Ͷ�
       emp_no
      ,emp_nm
      ,gender_cd
      from emp_c
    where EMP_NM LIKE '��%'
    ;
    
    select  -- �����Ͷ�
       emp_no
      ,emp_nm
      ,gender_cd
      from emp_c
    where EMP_NM LIKE '%��'
    ;
    
    ����
    ������
    
    ;
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM = '����'
    ;
    
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM IN ('����','������','�֤�ȣ')
    ;
    
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM <> '����'
    ;
    
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM NOT IN ('����','������','�֤�ȣ')
    ;
    
    select  -- �����Ͷ�
       emp_no
      ,emp_nm
      ,gender_cd
      from emp_c
    where EMP_NM NOT LIKE '��%'
    ;
    
    -- �׷���
    SELECT 
     GENDER_CD
     ,COUNT(*) -- COUNT, SUM, MAX, MIN, AVG
     FROM EMP_C
     GROUP BY GENDER_CD
     ;
     
    SELECT 
     GENDER_CD
     ,birth_ymd
     ,COUNT(*) -- COUNT, SUM, MAX, MIN, AVG
     FROM EMP_C
     GROUP BY GENDER_CD, birth_ymd
     ;
    
     SELECT 
     GENDER_CD
     ,MIN(birth_ymd) -- COUNT, SUM, MAX, MIN, AVG
     FROM EMP_C
     GROUP BY GENDER_CD
     ;
     
     --SELECT * FROM EMP_C WHERE GENDER_CD = 1 AND BIRTH_YMD = '19560712';


*/
----------------------------------------------------------
----------------------------------------------------------

-- DECODE
SELECT GENDER_CD, DECODE(GENDER_CD, 1,'��',2,'��'), COUNT(*), MAX(GENDER_CD), SUM(GENDER_CD)
FROM EMP_C
GROUP BY GENDER_CD;

--SELECT GENDER_CD, DECODE(GENDER_CD, 1>0,'A','B'), COUNT(*) -- ���ڵ� �� �ε�ȣ ��� �ȵǴ� ��
--ORA-00907: ������ ���ȣ
--00907. 00000 -  "missing right parenthesis"
SELECT GENDER_CD, DECODE(GENDER_CD, 1,'A','B'), COUNT(*)    
    FROM EMP_C
GROUP BY GENDER_CD;

-- CASE WHEN THEN
SELECT GENDER_CD,
    CASE GENDER_CD WHEN 1 THEN '��'
                   WHEN 2 THEN '��'
    ELSE ''
    END AS ����
    FROM EMP_C 
GROUP BY GENDER_CD;  
--ORA-00932: �ϰ��� ���� ������ ����: CHAR��(��) �ʿ������� NUMBER��
--00932. 00000 -  "inconsistent datatypes: expected %s got %s"


-- UNION �ߺ�X
-- UNION ALL �ߺ�O

-- ���� �Լ�
-- RANK, DENSE_RANK, ROWNUN
SELECT 
RANK() OVER(ORDER BY FAM_NM ASC),
FAM.*
    FROM 
    FAM_C FAM
;    
SELECT
DENSE_RANK() OVER(ORDER BY FAM_NM ASC),
    FAM.*
    FROM
    FAM_C FAM
    ;    
SELECT
    ROWNUM, 
    FAM.*
    FROM 
    FAM_C FAM
    ;
SELECT 
    ROWNUM, EMP_NO
    FROM EMP_C
WHERE EMP_NO > 10002458;   


/*
���� ����

     
     --SELECT * FROM EMP_C WHERE GENDER_CD = 1 AND BIRTH_YMD = '19560712';
     
     SELECT 
      GENDER_CD
      ,DECODE(GENDER_CD , '1' , '����' , '2' , '����', '�̻�')
      FROM EMP_c;
      
     SELECT 
      GENDER_CD
      ,CASE WHEN GENDER_CD = '1' THEN '����'
            WHEN GENDER_CD = '2' THEN '����'
            ELSE '�̻�' END
      FROM EMP_c;
      
    SELECT 
      GENDER_CD
      ,BIRTH_YMD
      ,CASE WHEN GENDER_CD = '1' AND BIRTH_YMD > '19700101' THEN '��������'
            WHEN GENDER_CD = '1' AND BIRTH_YMD <= '19700101' THEN '��������'
            WHEN GENDER_CD = '2' THEN '����'
            ELSE '�̻�' END --IF, IFELSE . IFELSE ELSE
      FROM EMP_c;
      
    ;
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM IN ('����','������')
    ;
    
    -->
    UNION ALL -- ��� ���� ��ģ��.
    
    ;
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM = '����'
    UNION ALL -- ���� --> �ߺ��� ����Ѵ�.
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM = '������'
    ;
    
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM = '����'
    UNION  ALL -- ���� --> �ߺ��� ����Ѵ�.
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM = '����'
    ;
    
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM = '����'
    UNION  -- ���� --> �ߺ��� �����Ѵ�.
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM = '����'
    ;
    
    --����. ����
    ROWNUM --> �׳� ���� 1,2,3,4
    RANK --> �ߺ� (���� ���)�� ���Ѱ� 
    DENSE_RANK --> �ߺ� (���� ���)�� ������ �ʰ� 
    
    SELECT
    * FROM 
    FAM_C
    WHERE EMP_NO = '11502023'
    ORDER BY FAM_NM ASC
    ;
    
    SELECT
    ROWNUM,
    FAM.*
     FROM 
    FAM_C FAM
    WHERE EMP_NO = '11502023'
    --ORDER BY FAM_NM ASC
    ;
    
    SELECT
    rank() OVER (ORDER BY FAM_NM ASC),
    FAM.*
     FROM 
    FAM_C FAM
    WHERE EMP_NO = '11502023'
    ;
    
    SELECT
    DENSE_rank() OVER (ORDER BY FAM_NM ASC),
    FAM.*
     FROM 
    FAM_C FAM
    --WHERE EMP_NO = '11502023'
    ;
    SELECT
    rank() OVER (ORDER BY FAM_NM ASC),
    FAM.*
     FROM 
    FAM_C FAM
    ;
    
    SELECT 
     FAM.FAM_NM 
     FROM FAM_C FAM
     ;
    
    SELECT 
      FAM.FAM_NM AS "��������"
     ,FAM.GENDER_CD AS "��������"
     FROM FAM_C FAM
     ;
     
    SELECT 
     FAM.*
     FROM FAM_C FAM
     ;

*/
---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------

-- JOIN : ���̺�� ���̺��� ����(���� ���̺� + ���� ���̺�)
-- INNER JOIN(������)
-- LEFT OUTER JOIN(������ + ������)

SELECT
    * FROM      -- ����
    EMP_C EMP   -- ������
    INNER JOIN  -- ��� (������) �����̸鼭 ���ÿ� ������ �ִ� ȸ����� ��ȸ
    FAM_C FAM 
    ON EMP.EMP_NO = FAM.EMP_NO
    ;
    -- JOIN KEY : �����ִ� �÷�

--LEFT OUTER JOIN ����
--  �����÷��� ������ ��ȸ�ϰ� ����� �Ǵ� �÷��� ��ȸ��. ������ NULL��ȯ
--  �ǹ����� INNER���� LEFT OUTER�� �� ���̾�
--  LEFT OUTER JOIN�� �߾��°� NVL()
-- EX)
SELECT
EMP.*
, FAM.*
,NVL(FAM.FAM_NM, '��������')
    FROM
    EMP_C EMP -- ���� 1��
    LEFT OUTER JOIN
    FAM_C FAM
    ON EMP.EMP_NO = FAM.EMP_NO
    WHERE EMP.EMP_NO = '10005454' 
--10005454	�̤���	1	19580814	A185940	13/07/23	11/01/03							
    ;




------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------



/*
   --����. ����
    ROWNUM --> �׳� ���� 1,2,3,4
    RANK --> �ߺ� (���� ���)�� ���Ѱ� 
    DENSE_RANK --> �ߺ� (���� ���)�� ������ �ʰ� 
    
    SELECT
    * FROM 
    FAM_C
    WHERE EMP_NO = '11502023'
    ORDER BY FAM_NM ASC
    ;
    
    SELECT
    ROWNUM,
    FAM.*
     FROM 
    FAM_C FAM
    WHERE EMP_NO = '11502023'
    --ORDER BY FAM_NM ASC
    ;
    
    SELECT
    rank() OVER (ORDER BY FAM_NM ASC),
    FAM.*
     FROM 
    FAM_C FAM
    WHERE EMP_NO = '11502023'
    ;
    
    SELECT
    DENSE_rank() OVER (ORDER BY FAM_NM ASC),
    FAM.*
     FROM 
    FAM_C FAM
    --WHERE EMP_NO = '11502023'
    ;
    SELECT
    rank() OVER (ORDER BY FAM_NM ASC),
    FAM.*
     FROM 
    FAM_C FAM
    ;
    
    SELECT 
     FAM.FAM_NM 
     FROM FAM_C FAM
     ;
    
    SELECT 
      FAM.FAM_NM AS "��������"
     ,FAM.GENDER_CD AS "��������"
     FROM FAM_C FAM
     ;
     
    SELECT 
     FAM.*
     FROM FAM_C FAM
     ;
     
     --JOIN : ���̺�� ���̺��� �����Ѵ�. (���� + ����)
     --INNER JOIN (������)
     --LEFT OUTER JOIN (������ + ������)
     --JOIN IN KEY 
    SELECT 
     * FROM 
     EMP_C EMP -- ���� 1��
     INNER JOIN --������ --> �������̸鼭 ���ÿ� ������ �ִ� ����� ���
     FAM_C FAM -- ��� 7��
     ON EMP.EMP_NO = FAM.EMP_NO -- JOIN_KEY �����ִ� �÷�
     WHERE EMP.EMP_NO = '11502131'
     ;
     
   SELECT 
     * FROM 
     EMP_C EMP -- ���� 1��
     INNER JOIN --������ --> �������̸鼭 ���ÿ� ������ �ִ� ����� ���
     FAM_C FAM -- ��� 7�� / 0��
     ON EMP.EMP_NO = FAM.EMP_NO -- JOIN_KEY �����ִ� �÷�
     WHERE EMP.EMP_NO = '10005454'
     ;
     
    SELECT * FROM EMP_C EMP
    WHERE NOT EXISTS (SELECT 1 FROM FAM_C FAM WHERE FAM.EMP_NO = EMP.EMP_NO); -- ������ ���� ���.
    ;
    
    SELECT * FROM FAM_C WHERE EMP_NO = '10005454';
    
    SELECT 
     * FROM 
     EMP_C EMP -- ���� 1��
     LEFT OUTER JOIN --������ --> �������̸鼭 ���ÿ� ������ �ִ� ����� ���
     FAM_C FAM -- ��� 7�� / 0��
     ON EMP.EMP_NO = FAM.EMP_NO -- JOIN_KEY �����ִ� �÷�
     WHERE EMP.EMP_NO = '10005454'
     ;
     
    SELECT 
     EMP.*
    ,FAM.*
    ,NVL(FAM.FAM_NM , '��������')
    ,CASE WHEN FAM.FAM_NM IS NULL THEN '��������'
          WHEN FAM.FAM_NM IS NOT NULL THEN '��������' END
      FROM 
     EMP_C EMP -- ���� 1��
     LEFT OUTER JOIN --������ --> �������̸鼭 ���ÿ� ������ �ִ� ����� ���
     FAM_C FAM -- ��� 7�� / 0��
     ON EMP.EMP_NO = FAM.EMP_NO -- JOIN_KEY �����ִ� �÷�
     WHERE EMP.EMP_NO IN ( '10005454' , '11502131')
     ;
    
    

*/

