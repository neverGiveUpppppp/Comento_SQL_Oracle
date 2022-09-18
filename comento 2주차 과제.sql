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
----------------------------- 2주차 과제 -------------------------
-----------------------------------------------------------------

--문제1) 직원번호 10004141 의 이름은? 힌트 : emp_c에 있음
--  최ㅇ규
SELECT EMP_NM FROM EMP_C
WHERE EMP_NO = 10004141;
SELECT * FROM EMP_C
WHERE EMP_NO = 10004141;

--문제2) 직원번호 10004141 는 몇 명의 가족이 있나요? 힌트 fam_c
--  5명
SELECT * FROM FAM_C
WHERE EMP_NO = 10004141;

--문제3) 직원번호 10004141 의 소속 부서 코드는? 힌트 emp_c
-- A183500
SELECT ORG_CD FROM EMP_C
WHERE EMP_NO = 10004141;


--문제4) 직원번호 10004141 의 소속 부서 명은?  힌트 org_c
-- 전XX룹
SELECT ORG_NM FROM ORG_C
WHERE ORG_CD = 'A183500';

--문제5) 남자 / 여자 직원이 몇 명인지 한번에 알 수 있는 sql을 작성하세요. (group by gender_cd)
-- 남 1374명 // 여 621명
-- 전체 개수를 세어야하니 COUNT집계 함수 사용해야함

--SELECT COUNT(GENDER_CD) --DECODE(SUBSTR(GENDER_CD,1,1),1,'남','여') AS 성별  
--FROM EMP_C
--GROUP BY GENDER_CD;
--HAVING GENDER_CD = 2; -- 필요없는 조건

SELECT GENDER_CD,COUNT(*)
FROM EMP_C
GROUP BY GENDER_CD;

-- DECODE+ALIAS로 분류 컬럼 추가
SELECT DECODE(SUBSTR(GENDER_CD,1,1),1,'남','여') AS 성별, COUNT(*)
FROM EMP_C
GROUP BY GENDER_CD;





--문제6) 직원별 자녀가 몇 명인지 한번에 알 수 있는 sql을 작성하세요. (rel_type_cd가 A27이면 자녀)
--

SELECT *
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE REL_TYPE_CD = 'A27';    
--WHERE EMP_NO = 10004141;

-- WHERE문에 E.EMP_NO = 10004141 추가로 넣어서 사원 한명의 자녀 목록 확인
SELECT E.EMP_NO, EMP_NM, E.BIRTH_YMD, FAM_NM, REL_TYPE_CD,F.BIRTH_YMD
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE REL_TYPE_CD = 'A27'
AND E.EMP_NO = 10004141; -- 10004141	최ㅇ규	19551223	최ㅇ철	A27	19850503

-- 자녀 둘인 걸 확인 했으니 COUNT()로 자녀수 조회ㄱㄱ
SELECT COUNT(E.EMP_NO)
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE REL_TYPE_CD = 'A27'
AND E.EMP_NO = 10004141; -- 2

-- 전체 직원의 자녀수 인듯. 직원 별 자녀수가 필요
SELECT COUNT(E.EMP_NO)
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)
WHERE REL_TYPE_CD = 'A27'; -- 2412

-- 직원 별이니까 GROUP BY 통해 묶고 대상은 EMP_NO이면 될 듯
SELECT E.EMP_NO, COUNT(E.EMP_NO)
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)    
WHERE REL_TYPE_CD = 'A27'
GROUP BY E.EMP_NO; -- 인출행 수 1239

--SELECT E.EMP_NO,E.EMP_NM, COUNT(E.EMP_NO)
--FROM EMP_C E
--    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)    
--WHERE REL_TYPE_CD = 'A27'
--GROUP BY E.EMP_NO; -- 인출행 수 1239 -> 조회할려는 컬럼이 그룹바이로 지정이 안됐기에 에러 발생

-- ANSI 표준 JOIN
SELECT E.EMP_NO, E.EMP_NM, COUNT(E.EMP_NO) "자녀수"
FROM EMP_C E
    JOIN FAM_C F ON(E.EMP_NO = F.EMP_NO)    
WHERE REL_TYPE_CD = 'A27'
GROUP BY E.EMP_NO, E.EMP_NM; -- 인출행 수 1239

-- 오라클 전용 JOIN구문
SELECT E.EMP_NO, E.EMP_NM, COUNT(E.EMP_NO) "자녀수"
FROM EMP_C E, FAM_C F
WHERE E.EMP_NO = F.EMP_NO
AND REL_TYPE_CD = 'A27'
GROUP BY E.EMP_NO, E.EMP_NM;  -- 인출행 수 1239



--문제7) 생년월일이 1970년 1월 1일 이전인 직원의 수를 구하는 sql을 작성하세요.
--


--문제8) 현재 재직 중인 직원의 전체 수를 구하는 sql을 작성하세요


SELECT * FROM EMP_C;
SELECT * FROM FAM_C;
SELECT * FROM ORG_C;
SELECT * FROM FAM_REL_C;

