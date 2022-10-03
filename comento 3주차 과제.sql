-----------------------------------------------------------------
----------------------------- 3주차 과제 -------------------------
-----------------------------------------------------------------

/*
1.질의 결과처럼 데이터를 추출 할 수 있도록 sql을 작성해 보세요.
2.사용코드 (REL_TYPE_CD)
자녀 = A27, 아내 = A02, 남편 = A18
*/

SELECT * FROM EMP_C;
SELECT * FROM FAM_C;
SELECT * FROM ORG_C;
SELECT * FROM FAM_REL_C;


--1)생년월일이 20120101에서 20151231 사이인 쌍둥이 자녀를 가진 임직원을 구하세요.
--HINT1: FAM_C테이블과 FAM_C테이블을 서로 조인해야합니다. 조인 시 쌍둥이의 조건에 대해 잘 생각해보세요. 이름이 다르고, 생년월일이 같음

SELECT
    f.birth_ymd,
    f.fam_nm
--SELECT *
FROM
         emp_c e
    JOIN fam_c     f ON ( e.emp_no = f.emp_no )
    JOIN fam_rel_c fr ON ( f.emp_no = fr.emp_no ) -- REL_TYPE_CD에서 자녀(=A27)를 뽑아보기 위해 JOIN추가
WHERE
    f.birth_ymd BETWEEN 20120101 AND 20151231;
GROUP BY F.BIRTH_YMD, F.FAM_NM;     

SELECT F.BIRTH_YMD, F.FAM_NM
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE F.BIRTH_YMD BETWEEN 20120101 AND 20151231
AND REL_TYPE_CD = 'A27'
GROUP BY F.BIRTH_YMD, F.FAM_NM;    
-- 쌍둥이1,2를 컬럼 나눠서 출력해야함

SELECT F.BIRTH_YMD, /*COUNT(*)*/ 
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE F.BIRTH_YMD BETWEEN 20120101 AND 20151231
AND REL_TYPE_CD = 'A27'
GROUP BY F.BIRTH_YMD;  
-- 찍어야하는 기준이 직원번호/쌍둥이1/쌍둥이2임
-- GROUP BY가 아닌 이유 : 조회 시, 그룹으로 묶여 나오는데 
-- 이러면 제시한 조회결과처럼 직원번호 하나에 쌍둥이1,2 한줄로 못나옴

SELECT EMP_NO, F.FAM_NM 쌍둥이1, F.FAM_NM 쌍둥이2
FROM EMP_C E
    JOIN FAM_C F USING(EMP_NO)
WHERE F.BIRTH_YMD BETWEEN 20120101 AND 20151231
-- 쌍둥이 1,2를 어떻게 나눠할지 음...
;


--2)20210321 기준으로 재직중인 임직원이며, 
-- 생년월일이 20120101에서 20151231인 자녀를 가진 임직원을 구하는 sql을 작성하세요.
--HINT : EMP_C와 FAM_C를 조인해야 합니다.

SELECT F.BIRTH_YMD, COUNT(*)
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
GROUP BY F.BIRTH_YMD 
HAVING F.BIRTH_YMD BETWEEN 20120101 AND 20151231
ORDER BY 1;

SELECT E.EMP_NO, F.BIRTH_YMD, F.FAM_NM 쌍둥이1, F.FAM_NM 쌍둥이2
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE F.BIRTH_YMD BETWEEN 20120101 AND 20151231
GROUP BY E.EMP_NO,F.BIRTH_YMD, F.FAM_NM; 


SELECT E.EMP_NO "직원번호", F.FAM_NM 자녀성명, F.BIRTH_YMD AS 자녀생년월일
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE F.BIRTH_YMD BETWEEN 20120101 AND 20151231
AND E.RETIRE_YMD > '990101'
ORDER BY 1 DESC;


-- =으로 991231은 안나오나
-- =으로 99991231은 나옴
select * from emp_c 
where retire_ymd = '99991231' 
order by retire_ymd desc;


-- SELF JOIN : FAM_C + FAM_C
SELECT F1.EMP_NO, F2.FAM_NM
FROM FAM_C F1
    JOIN FAM_C F2 ON(F1.EMP_NO = F2.FAM_NM) 
-- EMP_NO이 숫자고 FAM_NM이 STR이라 데이터타입 오류 발생
;
SELECT F1.EMP_NO, F2.FAM_NM
FROM FAM_C F1
    JOIN FAM_C F2 ON(F1.EMP_NO = F2.EMP_NO) 
;    
  


select * from FAM_C; 



--3)20210321 기준으로 재직중인 임직원이며,사내부부인 임직원의 직원번호를 구하는 sql을 작성하세요.
--HINT : EMP_C와 FAM_REL_C를 조인해야 합니다.
-- 조회 : 직원번호
-- 재직중 : RETIRE 99/12/31 조건
-- 사내부부 : ? // 일단 EMP_NO = EMP_REL_NO 아님


-- 직원번호와 직원가족번호 =조건 해봤으나 X
SELECT *
FROM EMP_C E
    JOIN FAM_REL_C FR ON(E.EMP_NO = FR.EMP_NO)
WHERE E.EMP_NO = FR.EMP_REL_NO  -- 직원번호와 직원가족번호 =조건 해봤으나 X
;    


SELECT *
FROM EMP_C E
    JOIN FAM_REL_C FR ON(E.EMP_NO = FR.EMP_REL_NO)
    -- JOIN ON절의 컬럼을 바꿔서 해봄
WHERE E.EMP_NO = FR.EMP_REL_NO  
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




--3-2) 현재 날짜 기준 재직중인 "이씨 성＂을 가진 직원의 자녀명수가 몇 명인지 리스트를 만드세요.
--힌트: substr, count(*)를 사용
-- 재직중 : RETIRE 99/12/31 조건
-- 현재 날짜 기준
-- 이씨성 : LIKE '이%'
-- 자녀수 : COUNT

-- 조건 : 재직중+이씨성
SELECT *
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE E.RETIRE_YMD = '99991231'
AND E.EMP_NM LIKE '이%'
;    

-- COUNT + LIKE
SELECT E.EMP_NM 직원명, COUNT(*)
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE E.RETIRE_YMD = '99991231'
AND E.EMP_NM LIKE '이%'
GROUP BY E.EMP_NM
;    

-- COUNT(SUBSTR)+ LIKE
SELECT E.EMP_NM, COUNT(SUBSTR(E.EMP_NM,2,4)) AS "자녀명수"
FROM EMP_C E
    JOIN FAM_C F USING(EMP_NO)
WHERE E.RETIRE_YMD = '99991231'
AND E.EMP_NM LIKE '이%'
GROUP BY E.EMP_NM
;    

-- COUNT + SUBSTR
SELECT E.EMP_NM, COUNT(*) AS "자녀명수"
FROM EMP_C E
    JOIN FAM_C F USING(EMP_NO)
WHERE E.RETIRE_YMD = '99991231'
AND SUBSTR(E.EMP_NM, 1,1) = '이'
GROUP BY E.EMP_NM
;  


--3-3) 자녀 명수가 2명 이상인 직원의 리스트를 구하세요.(직원번호?/?성명?/?자녀명수?)
--힌트 having
-- 조회 컬럼 : 직원번호/성명/자녀명수
-- 자녀수 2명 이상 : REL_TYPE_CD A=27이 자녀이므로 이거 2ROW 이상

-- A27타입인 자녀수만 조회
SELECT COUNT(F.REL_TYPE_CD)
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE F.REL_TYPE_CD = 'A27'    
;

SELECT E.EMP_NO 직원번호, E.EMP_NM 성명, COUNT(*)
FROM EMP_C E 
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE F.REL_TYPE_CD = 'A27'    -- 자녀(A27) 조건 적용
GROUP BY E.EMP_NO ,E.EMP_NM    
-- 조회에 필요한 EMP_NO,EMP_NM을 조회하기 위해 GROUP BY 사용 필요. 
-- COUNT가 단일행 그룹 함수이기에 단일행 그룹함수 COUNT와 다른 행도 조회하기 위해 사용함
HAVING COUNT(F.REL_TYPE_CD) > 2 
-- WHERE절에서 자녀있는 직원만 골라낸 후, HAVING으로 2명이상 조건 적용
-- 이후 GROUP BY 직원번호와 성명을 묶어서 조회
;    


SELECT * FROM EMP_C;
SELECT * FROM FAM_C;
SELECT * FROM ORG_C;
SELECT * FROM FAM_REL_C;


--3-4) 현재 기준 조직의 부서별 직원이 몇 명인지 구하는 sql을 작성하세요. (조직코드, 조직명, 직원수)
--힌트 group by org_cd, org_nm
-- 현재 기준 : ?
-- 부
-- 부서별 직원 수 : COUNT(*)서별 직원 : GROUP BY ?(ORG..?)
SELECT
    org_nm   조직분류,
    COUNT(*) 직원수
FROM
         emp_c e
    JOIN org_c o USING ( org_cd )
GROUP BY
    org_nm;    
;    




-----------------------------------------------------------------
------------------------- 3주차 과제 모범답안 ----------------------
-----------------------------------------------------------------


--1)생년월일이?20120101?에서?20151231?사이인 쌍둥이 자녀를 가진 임직원을 구하세요.
--HINT1: FAM_C테이블과?FAM_C테이블을 서로?조인해야합니다.?조인 시 쌍둥이의 조건에 대해 잘 생각해보세요.?이름이 다르고,?생년월일이 같음

SELECT
  FAM1.EMP_NO AS 직원번호
, FAM1.FAM_NM AS 쌍둥이1
, FAM2.FAM_NM AS 쌍둥이2
FROM FAM_C FAM1
	INNER JOIN FAM_C FAM2
		ON FAM1.EMP_NO = FAM2.EMP_NO
AND FAM1.FAM_NM <> FAM2.FAM_NM
AND FAM1.REL_TYPE_CD = FAM2.REL_TYPE_CD
AND FAM1.REL_TYPE_CD = 'A27'
AND FAM1.BIRTH_YMD = FAM2.BIRTH_YMD
;


--2) 20210321?기준으로 재직중인 임직원이며,?생년월일이?20120101?에서?20151231인 자녀를 가진 임직원을 구하는?sql을 작성하세요.
--HINT : EMP_C와?FAM_C를 조인해야 합니다.

SELECT
EMP.EMP_NO AS 직원번호
,FAM.FAM_NM AS 자녀성명
,FAM.BIRTH_YMD AS 자녀생년월일
 FROM EMP_C EMP
LEFT OUTER JOIN FAM_C FAM
ON EMP.EMP_NO = FAM.EMP_NO
AND FAM.REL_TYPE_CD = 'A27'
WHERE '20210321' BETWEEN EMP.HIRE_YMD AND RETIRE_YMD
AND FAM.BIRTH_YMD BETWEEN '20120101' AND '20151231'
ORDER BY FAM.BIRTH_YMD
;


--3) 20210321?기준으로 재직중인 임직원이며, 사내부부인 임직원의 직원번호를 구하는?sql을 작성하세요.
--HINT : EMP_C와?FAM_REL_C를 조인해야 합니다.

SELECT
EMP.EMP_NO AS 직원번호
,FAM.FAM_NM AS 자녀성명
,FAM.BIRTH_YMD AS 자녀생년월일
 FROM EMP_C EMP
LEFT OUTER JOIN FAM_C FAM
ON EMP.EMP_NO = FAM.EMP_NO
AND FAM.REL_TYPE_CD = 'A27'
WHERE '20210321' BETWEEN EMP.HIRE_YMD AND RETIRE_YMD
AND FAM.BIRTH_YMD BETWEEN '20120101' AND '20151231'
ORDER BY FAM.BIRTH_YMD
;



--3-2) 현재 날짜 기준 재직중인?“이씨 성＂을 가진 직원의?자녀명수가?몇 명인지 리스트를 만드세요.
--힌트:?substr?, count(*)를 사용

SELECT
EMP_NM
,COUNT(*)
FROM EMP_C EMP
INNER JOIN FAM_C FAM
ON EMP.EMP_NO = FAM.EMP_NO
AND FAM.REL_TYPE_CD = 'A27'
AND SYSDATE BETWEEN EMP.HIRE_YMD AND EMP.RETIRE_YMD
WHERE -- 또는 emp.emp_nm like '이%'
SUBSTR(EMP_NM,1,1) = '이'
GROUP BY EMP_NM
;



--3-3) 자녀 명수가?2명 이상인 직원의 리스트를 구하세요.??(직원번호?/?성명?/?자녀명수?)
--힌트?having

SELECT
ABC.EMP_NO
,EMP.EMP_NM
,ABC.CNT
FROM
EMP_C EMP
INNER JOIN
    (SELECT
    EMP_NO,
    COUNT(*) AS CNT
    FROM FAM_C
    WHERE REL_TYPE_CD= 'A27'
    GROUP BY EMP_NO
    HAVING COUNT(*) >= 2
    ) ABC
ON EMP.EMP_NO = ABC.EMP_NO
;





--3-4) 현재 기준 조직의 부서별 직원이 몇 명인지 구하는?sql을 작성하세요. (조직코드,?조직명,?직원수)
--힌트?group by?org_cd,?org_nm

SELECT
ORG.ORG_CD
,ORG.ORG_NM
,COUNT(*)
FROM
 EMP_C EMP
 INNER JOIN ORG_C ORG
 ON EMP.ORG_CD = ORG.ORG_C
 AND SYSDATE BETWEEN ORG.STA_YMD AND ORG.END_YMD
 AND SYSDATE BETWEEN EMP.HIRE_YMD AND EMP.RETIRE_YMD
GROUP BY ORG.ORG_CD, ORG.ORG_NM
;










