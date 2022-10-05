-----------------------------------------------------------------
----------------------------- 5주차 수업 -------------------------
-----------------------------------------------------------------





-- 추출 대상 (레이아웃)
-- 직원번호 / 직원성명 / 배우자 성명 (사내부부) / 자녀성명 / 자녀생년월일 / 쌍둥이여부
-- EMP_C / EMP_C / EMP_C , FAM_REL_C / FAM_C / FAM_C / FAM_C
-- 요구사항
-- 테이블과 컬럼정보
-- 분할 정복법 --> 문제를 바라볼 때 나누어서 , 잘게 쪼개서 문제를 해결하고, 결합.
-- 쪼개 진 sql 한개 씩 만들어 보고
-- 합치기
-- 자녀 가있고 , 생년월일이 20120101' AND '20151231' , 쌍둥이 첫째만.
-- 재직중인
 
---1번째.
SELECT
 EMP.EMP_NO AS "직원번호"
,EMP.EMP_NM AS  "직원성명"
,FAM.FAM_NM AS "자녀성명"
,FAM.BIRTH_YMD AS "자녀생년월일"
  FROM
 EMP_C EMP
 INNER JOIN FAM_C FAM
ON EMP.EMP_NO = FAM.EMP_NO
AND FAM.REL_TYPE_CD= 'A27'
WHERE '20221005' BETWEEN HIRE_YMD AND RETIRE_YMD -- 재직중
AND FAM.BIRTH_YMD BETWEEN '20120101' AND '20151231'
;
 --2번째 --사내부부여부 --> 사내부부 일수도 .? 아닐수도 ? 선택적,
 --남편을 기준으로 아내를 뽑음.
SELECT
 * FROM EMP_C EMP
LEFT OUTER JOIN FAM_REL_C FAMR
ON EMP.EMP_NO = FAMR.EMP_NO
AND FAMR.REL_TYPE_CD IN ('A18','A02')
;
 --3번째 쌍둥이 =
 --생년월일 같다. =
--이름은 다르다. <>
-- 같은 테이블을 두번 JOIN
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
 
  -- INNER JOIN 교집합 : 직원이면서 자녀가 있다. EMP_C FAM_C
  -- LEFT OUTER JOIN 교집합 + 기준테이블 ROW : 직원중에 사내부부인 경우 -- 사내부부는 ? 모든 임직원이 사내부부 아님.
  -- 필수적관계는 아님, 선택적, 사내부부일수도 있고, 아닐수도 있고,
  
  ---합치기
  -- 김선호:
  -- 김소현:
  -- 정세희:
  -- 최신영:
  -- 한수연:
 
 
 
 -- 입사일(19700101) ------ >   현재 '20221005' -------> 미래(9991231)
 
 
 
 
 
 
 
 
 -- 합치기
SELECT
  EMP.EMP_NO AS "직원번호"
,EMP.EMP_NM AS  "직원성명"
,FAM.FAM_NM AS "자녀성명"
,FAM.BIRTH_YMD AS "자녀생년월일"
,FAMR.EMP_REL_NO AS "배우자의직원번호"
, TWIN.*
  FROM
 EMP_C EMP  --기준1
INNER JOIN FAM_C FAM --대상1
ON EMP.EMP_NO = FAM.EMP_NO
AND FAM.REL_TYPE_CD= 'A27'
 LEFT OUTER JOIN FAM_REL_C FAMR --대상2
--INNER JOIN FAM_REL_C FAMR --대상2
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
) TWIN --자녀 인라인뷰
ON FAM.EMP_NO = TWIN.EMP_NO
AND FAM.FAM_NM = TWIN.FAM_NM
WHERE '20221005' BETWEEN HIRE_YMD AND RETIRE_YMD -- 재직중
AND FAM.BIRTH_YMD BETWEEN '20120101' AND '20151231'
;












