
-----------------------------------------------------------------
----------------------------- 3주차 수업 -------------------------
-----------------------------------------------------------------


SELECT * FROM EMP_C;
SELECT * FROM FAM_C;
SELECT * FROM ORG_C;
SELECT * FROM FAM_REL_C;


-- ORDER BY 이중정렬
SELECT * FROM EMP_C
ORDER BY EMP_NM ASC, BIRTH_YMD DESC;

SELECT * FROM EMP_C
ORDER BY NOTE DESC;
SELECT * FROM EMP_C
ORDER BY NOTE DESC, EMP_NO ASC;


-- LIKE
SELECT * FROM EMP_C
WHERE EMP_NM LIKE '가%'; 
-- 11500019	가ㅇ수	1 ...
SELECT *
     FROM EMP_C
WHERE EMP_NM LIKE '%가%'; 

-- IN

-- GROUP BY

/*
----------------------------------------------------------
-------------------------수업 쿼리-------------------------
----------------------------------------------------------

    select  -- 가져와라
      *     -- 모두
      from emp_c
      ;
       
    select  -- 가져와라
      emp_no
      from emp_c
      ;
      
    select  -- 가져와라
       emp_no
      ,emp_nm
      from emp_c
      ;
      
    select  -- 가져와라
       emp_no
      ,emp_nm
      ,gender_cd
      from emp_c
    where gender_cd = '1';
    
    select  -- 가져와라
       emp_no
      ,emp_nm
      ,gender_cd
      from emp_c
    where gender_cd = '1'
    and birth_ymd > '19500101' -- and는 조건과 조건을 이어줌.
    ;
    
    select 
     * 
    from emp_c
    order by emp_nm asc;-- 오름차순
    
    select 
     * 
    from emp_c
    order by emp_nm DESC;-- 내림차순
    
    select 
     * 
    from emp_c
    order by emp_nm ASC, BIRTH_YMD DESC;-- 내림차순
    
    --쌍둥이 --> 대표: 이름으로 오름차순 했을 때 상위자.
    
    select  -- 가져와라
       emp_no
      ,emp_nm
      ,gender_cd
      from emp_c
    where EMP_NM LIKE '이%'
    ;
    
    select  -- 가져와라
       emp_no
      ,emp_nm
      ,gender_cd
      from emp_c
    where EMP_NM LIKE '%이'
    ;
    
    고ㅇ이
    강ㅇ이
    
    ;
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM = '고ㅇ이'
    ;
    
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM IN ('고ㅇ이','강ㅇ이','최ㅇ호')
    ;
    
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM <> '고ㅇ이'
    ;
    
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM NOT IN ('고ㅇ이','강ㅇ이','최ㅇ호')
    ;
    
    select  -- 가져와라
       emp_no
      ,emp_nm
      ,gender_cd
      from emp_c
    where EMP_NM NOT LIKE '이%'
    ;
    
    -- 그룹핑
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
SELECT GENDER_CD, DECODE(GENDER_CD, 1,'남',2,'여'), COUNT(*), MAX(GENDER_CD), SUM(GENDER_CD)
FROM EMP_C
GROUP BY GENDER_CD;

--SELECT GENDER_CD, DECODE(GENDER_CD, 1>0,'A','B'), COUNT(*) -- 디코드 안 부등호 계산 안되는 듯
--ORA-00907: 누락된 우괄호
--00907. 00000 -  "missing right parenthesis"
SELECT GENDER_CD, DECODE(GENDER_CD, 1,'A','B'), COUNT(*)    
    FROM EMP_C
GROUP BY GENDER_CD;

-- CASE WHEN THEN
SELECT GENDER_CD,
    CASE GENDER_CD WHEN 1 THEN '남'
                   WHEN 2 THEN '여'
    ELSE ''
    END AS 성별
    FROM EMP_C 
GROUP BY GENDER_CD;  
--ORA-00932: 일관성 없는 데이터 유형: CHAR이(가) 필요하지만 NUMBER임
--00932. 00000 -  "inconsistent datatypes: expected %s got %s"


-- UNION 중복X
-- UNION ALL 중복O

-- 순위 함수
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
수업 쿼리

     
     --SELECT * FROM EMP_C WHERE GENDER_CD = 1 AND BIRTH_YMD = '19560712';
     
     SELECT 
      GENDER_CD
      ,DECODE(GENDER_CD , '1' , '남자' , '2' , '여자', '이상값')
      FROM EMP_c;
      
     SELECT 
      GENDER_CD
      ,CASE WHEN GENDER_CD = '1' THEN '남자'
            WHEN GENDER_CD = '2' THEN '여자'
            ELSE '이상값' END
      FROM EMP_c;
      
    SELECT 
      GENDER_CD
      ,BIRTH_YMD
      ,CASE WHEN GENDER_CD = '1' AND BIRTH_YMD > '19700101' THEN '젊은남자'
            WHEN GENDER_CD = '1' AND BIRTH_YMD <= '19700101' THEN '늙은남자'
            WHEN GENDER_CD = '2' THEN '여자'
            ELSE '이상값' END --IF, IFELSE . IFELSE ELSE
      FROM EMP_c;
      
    ;
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM IN ('고ㅇ이','강ㅇ이')
    ;
    
    -->
    UNION ALL -- 행과 행을 합친다.
    
    ;
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM = '고ㅇ이'
    UNION ALL -- 결합 --> 중복을 허용한다.
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM = '강ㅇ이'
    ;
    
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM = '고ㅇ이'
    UNION  ALL -- 결합 --> 중복을 허용한다.
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM = '고ㅇ이'
    ;
    
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM = '고ㅇ이'
    UNION  -- 결합 --> 중복을 제거한다.
    SELECT 
    * 
    FROM EMP_C
    WHERE EMP_NM = '고ㅇ이'
    ;
    
    --순번. 순서
    ROWNUM --> 그냥 순서 1,2,3,4
    RANK --> 중복 (같은 등수)을 띄어넘고 
    DENSE_RANK --> 중복 (같은 등수)을 띄어넘지 않고 
    
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
      FAM.FAM_NM AS "가족성명"
     ,FAM.GENDER_CD AS "가족성별"
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

-- JOIN : 테이블과 테이블을 연결(기준 테이블 + 결합 테이블)
-- INNER JOIN(교집합)
-- LEFT OUTER JOIN(차집합 + 합집합)

SELECT
    * FROM      -- 기준
    EMP_C EMP   -- 교집합
    INNER JOIN  -- 대상 (교집합) 임직이면서 동시에 가족이 있는 회사원들 조회
    FAM_C FAM 
    ON EMP.EMP_NO = FAM.EMP_NO
    ;
    -- JOIN KEY : 합쳐주는 컬럼

--LEFT OUTER JOIN 개념
--  기준컬럼은 무조건 조회하고 대상이 되는 컬럼을 조회함. 없으면 NULL반환
--  실무에서 INNER보다 LEFT OUTER를 더 많이씀
--  LEFT OUTER JOIN과 잘쓰는게 NVL()
-- EX)
SELECT
EMP.*
, FAM.*
,NVL(FAM.FAM_NM, '가족없음')
    FROM
    EMP_C EMP -- 기준 1명
    LEFT OUTER JOIN
    FAM_C FAM
    ON EMP.EMP_NO = FAM.EMP_NO
    WHERE EMP.EMP_NO = '10005454' 
--10005454	이ㅇ근	1	19580814	A185940	13/07/23	11/01/03							
    ;




------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------



/*
   --순번. 순서
    ROWNUM --> 그냥 순서 1,2,3,4
    RANK --> 중복 (같은 등수)을 띄어넘고 
    DENSE_RANK --> 중복 (같은 등수)을 띄어넘지 않고 
    
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
      FAM.FAM_NM AS "가족성명"
     ,FAM.GENDER_CD AS "가족성별"
     FROM FAM_C FAM
     ;
     
    SELECT 
     FAM.*
     FROM FAM_C FAM
     ;
     
     --JOIN : 테이블과 테이블을 연결한다. (기준 + 결합)
     --INNER JOIN (교집합)
     --LEFT OUTER JOIN (차집합 + 교집합)
     --JOIN IN KEY 
    SELECT 
     * FROM 
     EMP_C EMP -- 기준 1명
     INNER JOIN --교집합 --> 임직원이면서 동시에 가족이 있는 사람의 결과
     FAM_C FAM -- 대상 7명
     ON EMP.EMP_NO = FAM.EMP_NO -- JOIN_KEY 합쳐주는 컬럼
     WHERE EMP.EMP_NO = '11502131'
     ;
     
   SELECT 
     * FROM 
     EMP_C EMP -- 기준 1명
     INNER JOIN --교집합 --> 임직원이면서 동시에 가족이 있는 사람의 결과
     FAM_C FAM -- 대상 7명 / 0명
     ON EMP.EMP_NO = FAM.EMP_NO -- JOIN_KEY 합쳐주는 컬럼
     WHERE EMP.EMP_NO = '10005454'
     ;
     
    SELECT * FROM EMP_C EMP
    WHERE NOT EXISTS (SELECT 1 FROM FAM_C FAM WHERE FAM.EMP_NO = EMP.EMP_NO); -- 가족이 없는 사람.
    ;
    
    SELECT * FROM FAM_C WHERE EMP_NO = '10005454';
    
    SELECT 
     * FROM 
     EMP_C EMP -- 기준 1명
     LEFT OUTER JOIN --교집합 --> 임직원이면서 동시에 가족이 있는 사람의 결과
     FAM_C FAM -- 대상 7명 / 0명
     ON EMP.EMP_NO = FAM.EMP_NO -- JOIN_KEY 합쳐주는 컬럼
     WHERE EMP.EMP_NO = '10005454'
     ;
     
    SELECT 
     EMP.*
    ,FAM.*
    ,NVL(FAM.FAM_NM , '가족없음')
    ,CASE WHEN FAM.FAM_NM IS NULL THEN '가족없음'
          WHEN FAM.FAM_NM IS NOT NULL THEN '가족있음' END
      FROM 
     EMP_C EMP -- 기준 1명
     LEFT OUTER JOIN --교집합 --> 임직원이면서 동시에 가족이 있는 사람의 결과
     FAM_C FAM -- 대상 7명 / 0명
     ON EMP.EMP_NO = FAM.EMP_NO -- JOIN_KEY 합쳐주는 컬럼
     WHERE EMP.EMP_NO IN ( '10005454' , '11502131')
     ;
    
    

*/

