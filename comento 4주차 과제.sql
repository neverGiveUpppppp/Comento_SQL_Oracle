-----------------------------------------------------------------
----------------------------- 4주차 과제 -------------------------
-----------------------------------------------------------------


SELECT * FROM EMP_C;
SELECT * FROM FAM_C;
SELECT * FROM ORG_C;
SELECT * FROM FAM_REL_C;


--1)아래와 같이 최종 결과를 추출하는 sql을 작성해보세요
--이미 70% 정도 짜여진 SQL을 완성하세요. (SQL DEVELOPER에 다음 장에 있는 SQL을 붙여넣기 하여 실행하시면서 최종 SQL을 작성해보세요.
--- 추출조건1 :  현재 재직중인 직원의 생년월일이 2012년 1월 1일 부터 2015년 12월 31일 인 자녀 모두추출
--- 추출조건2 : 쌍둥이의 경우 두명 모두 추출하고, 쌍둥이 여부에  ‘Y’ 표시 요망
--- 추출조건3 : 사내부부인 경우도 예외 없이 직원과 자녀를 모두 추출하고, 이 때 상대 배우자의 직원번호를 추출 요망
---  추출 요청 컬럼 → 직원번호 / 직원성명 / 배우자성명 (사내부부일 때만) / 배우자직원번호 / 자녀성명 / 자녀성별 / 자녀생년월일 / 쌍생아여부


-- 조건 brainstorming
-- 재직중 : RETIRE 99/12/31 조건
-- 자녀 생년월일 2012.01.01~2015.12.31 : BETWEEN 20120101 AND 20151231
-- 쌍둥이의 경우 두명 모두 추출 : FAM_C SELF JOIN FAM_NM을 F1,F2 따로 조회 및 조건에 NM <>추가
--쌍둥이 여부 표시 'Y' : 리터럴 작성
-- 사내부부의 경우, 상대 배우자의 직원번호 추출 : ?
-- 조회 목록 : EMP_NO, EMP_NM, CASE(SPOUSE_EMP_NO 사내부부일때,일반일때), CHILD_NM, CHILD_GENDER, CHILD_BIRTH_YMD, TWIN_YN
--(직원번호 / 직원성명 / 배우자성명 (사내부부일 때만) / 배우자직원번호 / 자녀성명 / 자녀성별 / 자녀생년월일 / 쌍생아여부)


--- 추출조건1
--- 현재 재직중인 직원의 생년월일이 2012년 1월 1일 부터 2015년 12월 31일 인 자녀 모두추출
SELECT *
FROM FAM_C
WHERE REL_TYPE_CD = 'A27'
AND BIRTH_YMD BETWEEN 20120101 AND 20151231
;

--- 추출조건2
--- 쌍둥이의 경우 두명 모두 추출하고, 쌍둥이 여부에 'Y' 표시 요망
SELECT F1.EMP_NO 직원번호, F1.FAM_NM 쌍둥이1, F2.FAM_NM 쌍둥이2, 'Y' "쌍둥이 여부"
FROM FAM_C F1
    JOIN FAM_C F2 ON(F1.EMP_NO = F2. EMP_NO)
AND F1.FAM_NM <> F2.FAM_NM
AND F1.REL_TYPE_CD = 'A27'
AND F1.REL_TYPE_CD = F2.REL_TYPE_CD
AND F1.BIRTH_YMD = F2.BIRTH_YMD
;
    
 
 
 
--- 추출조건1 + 추출조건2
--- 현재 재직중인 직원의 생년월일이 2012년 1월 1일 부터 2015년 12월 31일 인 자녀 모두추출
--- 쌍둥이의 경우 두명 모두 추출하고, 쌍둥이 여부에 'Y' 표시 요망
SELECT *
FROM FAM_C
WHERE REL_TYPE_CD = 'A27' 
AND BIRTH_YMD BETWEEN 20120101 AND 20151231
;

SELECT F1.EMP_NO 직원번호, F1.FAM_NM 쌍둥이1, F2.FAM_NM 쌍둥이2, 'Y' "쌍둥이 여부"
FROM FAM_C F1
    JOIN FAM_C F2 ON(F1.EMP_NO = F2. EMP_NO)
AND F1.FAM_NM <> F2.FAM_NM
AND F1.REL_TYPE_CD = 'A27'
AND F1.REL_TYPE_CD = F2.REL_TYPE_CD
AND F1.BIRTH_YMD = F2.BIRTH_YMD
;

-- FROM절의 AND조건들을 WHERE절로 돌려서 넣으면 뭐가 다를까?
SELECT F1.EMP_NO 직원번호, F1.FAM_NM 쌍둥이1, F2.FAM_NM 쌍둥이2, 'Y' "쌍둥이 여부"
FROM FAM_C F1
    JOIN FAM_C F2 ON(F1.EMP_NO = F2. EMP_NO)
WHERE F1.FAM_NM <> F2.FAM_NM
AND F1.REL_TYPE_CD = 'A27'
AND F1.REL_TYPE_CD = F2.REL_TYPE_CD
AND F1.BIRTH_YMD = F2.BIRTH_YMD    
;


    
--- 추출조건3
--- 사내부부인 경우도?예외 없이 직원과 자녀를 모두 추출하고, 이 때 상대 배우자의 직원번호를 추출 요망
-- 조회 : 직원, 자녀, 배우자직원번호
-- 사내부부 : 서브쿼리 + REL_TYPE_CD = 'A02,18' + UNION ALL
-- 상대 배우자의 직원번호를 추출 요망


SELECT EMP.EMP_NO  FROM
(SELECT * FROM EMP_C WHERE '20210321' BETWEEN HIRE_YMD AND RETIRE_YMD) EMP
INNER JOIN
(SELECT * FROM FAM_REL_C WHERE '20210321' BETWEEN STA_YMD AND END_YMD) FREL
ON EMP.EMP_NO = FREL.EMP_NO
AND FREL.REL_TYPE_CD = 'A02' --아내
UNION ALL
SELECT EMP.EMP_NO FROM
(SELECT * FROM EMP_C WHERE '20210321' BETWEEN HIRE_YMD AND RETIRE_YMD) EMP
INNER JOIN
(SELECT * FROM FAM_REL_C WHERE '20210321' BETWEEN STA_YMD AND END_YMD) FREL
ON EMP.EMP_NO = FREL.EMP_NO
AND FREL.REL_TYPE_CD = 'A18' --남편
;


-- CASE 쌍둥이 구문 디버깅해보기
SELECT 
CASE 
    NVL2((SELECT F1.EMP_NO 직원번호, F1.FAM_NM 쌍둥이1, F2.FAM_NM 쌍둥이2, 'Y' "쌍둥이 여부"
    FROM FAM_C F1
        JOIN FAM_C F2 ON(F1.EMP_NO = F2. EMP_NO)
    AND F1.FAM_NM <> F2.FAM_NM
    AND F1.REL_TYPE_CD = 'A27'
    AND F1.REL_TYPE_CD = F2.REL_TYPE_CD
    AND F1.BIRTH_YMD = F2.BIRTH_YMD),0,1)
WHEN 1 THEN 'Y'
ELSE 'N'
END "쌍둥이 여부"
FROM DUAL; 
-- ORA-00913: 값의 수가 너무 많습니다
-- 00913. 00000 -  "too many values"
-- 왜 값이 너무 많은걸까...?


-- 힌트 구문
SELECT
EMP.EMP_NO AS 직원번호
,EMP.EMP_NM AS 직원성명
,-- --> ★★★ 배우자 직원번호 완성하세요!!
,FAM.FAM_NM AS 자녀성명
,FAM.GENDER_CD AS  자녀성별
,FAM.BIRTH_YMD AS 자녀생년월일
,CASE WHEN -- --> ★★★ CASE WHEN을 사용하여 쌍둥이 여부를 표시해보세요.
--CASE WHEN 조건식 THEN 결과값
--WHEN 조건식THEN 결과값
--ELSE 결과값
--END
-- 쌍둥이 여부를 가를려면 변수 같은거나 일정 값 줘야하는데 어떻게 줘야할까?
-- 서브쿼리로 뭔가 조건 넣어서 하면 될 것 같은데, 나오는 데이터 형태를 어떻게 맞춰야할까?
-- 쌍둥이 여부가 Y라면 1 아니면 2식으로 해보자
-- CASE WHEN에 WHEN 조건 넣을 때 서브쿼리식으로 넣어서 나오는게 뭐면 Y로 넣어야하는데..
-- NVL2로 감싸서 수치변환 : NVL2(컬럼명, NULL이면 이걸로 변경, NULL이 아니면 이걸로 변경)
-- OR DECODE : DECODE(계산식|컬럼명, 조건값1, 선택값1, 조건값2, 선택값2, ...)

CASE 
    NVL2((SELECT F1.EMP_NO 직원번호, F1.FAM_NM 쌍둥이1, F2.FAM_NM 쌍둥이2, 'Y' "쌍둥이 여부"
    FROM FAM_C F1
        JOIN FAM_C F2 ON(F1.EMP_NO = F2. EMP_NO)
    AND F1.FAM_NM <> F2.FAM_NM
    AND F1.REL_TYPE_CD = 'A27'
    AND F1.REL_TYPE_CD = F2.REL_TYPE_CD
    AND F1.BIRTH_YMD = F2.BIRTH_YMD),0,1)
WHEN 0 THEN 'N'
WHEN 1 THEN 'Y'
ELSE '?'
END "쌍둥이 여부"
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
                AND TWIN1.FAM_NM <> TWIN2.FAM_NM-- 이름이 다른 조건
                AND TWIN1.BIRTH_YMD = TWIN2.BIRTH_YMD -- 생년월일이 같을 조건
        ) TWIN
WHERE EMP.EMP_NO = FAM.EMP_NO
AND -- --> ★★★ 현재 재직자만 추출 되도록 조건을 넣으세요.
AND FAM.REL_TYPE_CD  = 'A27'
AND -- --> ★★★ 2012년 1월 1일 부터 2015년 12월 31일 생년월일 조건을 넣으세요.
AND EMP.EMP_NO = FAMR.EMP_NO (+)
AND FAMR.REL_TYPE_CD (+) IN ('A02','A18')
AND EMP.EMP_NO = TWIN.EMP_NO (+)
AND FAM.FAM_NM = TWIN.TWIN1 (+)

;



SELECT * FROM EMP_C;
SELECT * FROM FAM_C;
SELECT * FROM ORG_C;
SELECT * FROM FAM_REL_C;



-- 2)LISTAGG를 활용하여 직원번호가 10001483 인 자녀의 성명이 한줄로 추출 되도록 SQL을 작성해 보세요. (선택과제, 공부하는 차원에서 한번 해보세요!^^;)
-- HINT : LISTAGG 활용 --> https://gent.tistory.com/328


SELECT * FROM EMP_C;
SELECT * FROM FAM_C;
SELECT * FROM ORG_C;
SELECT * FROM FAM_REL_C;
















