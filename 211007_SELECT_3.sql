-- DAY 4, SELECT3

-- 舘析楳 敗呪 域紗 遭楳------------------------------------------------------------------------------
-- LTRIM('庚切伸軒斗群' | 庚切亜 奄系吉 鎮軍誤, '薦暗拝 庚切(級)')
-- 庚切伸税 図楕拭 赤澗 庚切研 薦暗敗. (薦暗拝 庚切亜 焼観 陥献 庚切研 幻蟹檎 TRIM 曽戟喫)
-- RTRIM('庚切伸軒斗群' | 庚切亜 奄系吉 鎮軍誤, '薦暗拝 庚切(級)')
-- 庚切伸税 神献楕拭 赤澗 庚切研 薦暗敗. (薦暗拝 庚切亜 焼観 陥献 庚切研 幻蟹檎 TRIM 曽戟喫)
SELECT      '           012154ASDASQKLばせROACLEGBVZXCASDZXCOHH      ',
                LTRIM('           012154ASDASQKLばせROACLEGBVZXCASDZXCOHH      '),
                LTRIM('           012154ASDASQKLばせROACLEGBVZXCASDZXCOHH      ', ' '),
                LTRIM('           012154ASDASQKLばせROACLEGBVZXCASDZXCOHH      ', ' 0123456789'),
                LTRIM('           012154ASDASQKLばせROACLEGBVZXCASDZXCOHH      ', ' 0123456ABCDEHOZNB')
FROM DUAL;


SELECT      '           012154ASDASQKLばせROACLEGBVZXCASDZXCOHH      ',
                RTRIM('           012154ASDASQKLばせROACLEGBVZXCASDZXCOHH      '),
                RTRIM('           012154ASDASQKLばせROACLEGBVZXCASDZXCOHH      ', ' '),
                RTRIM('           012154ASDASQKLばせROACLEGBVZXCASDZXCOHH      ', ' 0123456789'),
                RTRIM('           012154ASDASQKLばせROACLEGBVZXCASDZXCOHH      ', ' 0123456ABCDEHOZNB')
FROM DUAL;

-- TRIM(LEADING | TRAILING | BOTH '薦暗拝庚切馬蟹' FROM '庚切軒斗群' | 庚切亜 奄系吉 鎮軍誤)
-- 奄沙精 丞楕税 庚切 薦暗馬澗 敗呪 (奄沙戚 BOTH 績)
-- 薦暗拝 庚切 持繰 獣 因拷庚切 薦暗研 税耕敗
SELECT 'aaORACLEaa',
            TRIM('a' FROM 'aaORACLEaa'),
            TRIM(LEADING 'a' FROM 'aaORACLEaa'),
            TRIM(TRAILING 'a' FROM 'aaORACLEaa'),
            TRIM(BOTH 'a' FROM 'aaORACLEaa')
FROM DUAL;

-- SUBSTR('庚切軒斗群' | 庚切亜 奄系吉 鎮軍誤, 蓄窒拝 獣拙是帖, 蓄窒拝 越切呪)
-- 蓄窒拝 獣拙是帖 : 丞呪(蒋拭辞採斗税 是帖), 製呪(及拭辞採斗税 是帖) 却 陥 亜管
-- 蓄窒拝 越切呪 : 持繰鞠檎 越切 魁猿走研 税耕敗
SELECT 'ORACLE 18C',
            SUBSTR('ORACLE 18C', 5),
            SUBSTR('ORACLE 18C', 8, 2),
            SUBSTR('ORACLE 18C', -7, 3)
FROM DUAL;

-- 送据級税 爽肯腰硲拭辞 持鰍, 持杉, 持析聖 唖唖 歳軒 繕噺, 紺暢 旋遂
SELECT EMP_NAME 紫据誤,
            EMP_NO 爽肯腰硲,
            SUBSTR(EMP_NO, 1, 2) 持鰍,
            SUBSTR(EMP_NO, 3, 2) 持杉,
            SUBSTR(EMP_NO, 5, 2) 持析
FROM EMPLOYEE;

-- 劾促 汽戚斗亀 SUBSTR 紫遂拝 呪 赤製
-- 送据級税 脊紫析拭辞 脊紫鰍亀, 脊紫杉, 脊紫析聖 歳軒 繕噺
SELECT EMP_NAME 紫据誤, HIRE_DATE 脊紫析,
            SUBSTR(HIRE_DATE, 1, 2) 脊紫鰍亀,
            SUBSTR(HIRE_DATE, 4, 2) 脊紫杉,
            SUBSTR(HIRE_DATE, 7, 2) 脊紫析
FROM EMPLOYEE;

-- SUBSTRB('庚切軒斗群' | 庚切亜 奄系吉 鎮軍誤, 蓄窒拝 獣拙郊戚闘是帖, 蓄窒拝 郊戚闘)
SELECT  SUBSTR('ORACLE', 3, 2), -- AC 蓄窒
            SUBSTRB('ORACLE', 3, 2), -- AC 蓄窒(慎庚精 1越切雁 1郊戚闘戚奄 凶庚拭 疑析敗)
            SUBSTR('神虞適', 2, 2), -- 虞適 蓄窒
            SUBSTRB('神虞適', 4, 6) -- 虞適 蓄窒
FROM DUAL;

-- UPPER('庚切軒斗群' | 庚切亜 奄系吉 鎮軍誤) : 慎庚切析 凶 企庚切稽 郊荷澗 敗呪
-- LOWER('庚切軒斗群' | 庚切亜 奄系吉 鎮軍誤) : 慎庚切析 凶 社庚切稽 郊荷澗 敗呪
-- INITCAP('庚切軒斗群' | 庚切亜 奄系吉 鎮軍誤) : 慎庚切析 凶 湛越切幻 企庚切稽, 蟹袴走澗 社庚切稽 郊荷澗 敗呪
SELECT UPPER('ORACLE'), UPPER('oracle'),
            LOWER('ORACLE'), LOWER('ORACLE'),
            INITCAP('ORACLE'), INITCAP('oracle')    
FROM DUAL;

-- 敗呪 掻淡 紫遂 : 敗呪照拭 敗呪研 紫遂拝 呪 赤製 ----------------------------------------------------------------------

-- 送据 舛左拭辞 戚硯, 焼戚巨 繕噺
-- 焼戚巨澗 戚五析拭辞 歳軒 蓄窒敗
SELECT EMP_NAME 戚硯,
            SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) 焼戚巨
FROM EMPLOYEE;

-- 送据 砺戚鷺拭辞 戚硯, 爽肯腰硲 繕噺
-- 舘, 爽肯腰硲澗 持鰍杉析幻 左戚惟 馬壱 急切軒澗 '*'稽 坦軒敗 : 781225-1******
SELECT EMP_NAME 戚硯,
            RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') 爽肯腰硲
FROM EMPLOYEE;

-- 収切 坦軒 敗呪---------------------------------------------------------------------------------------------
-- ROUND( ), TRUNC( ), FLOOR( ), ABS( ), MOD( )

-- ROUND(収切 | 収切亜 奄系吉 鎮軍誤 | 域至縦, 鋼臣顕拝 切鹸呪)
-- 獄形走澗 切軒税 葵戚 5 戚雌戚檎 切疑 鋼臣顕敗
-- 鋼臣顕拝 切鹸呪 : 丞呪戚檎 社収繊 焼掘 切軒研 税耕敗 (益 急切軒拭辞 鋼臣顕背辞 益 切軒猿走 妊獣敗)
-- 鋼臣顕拝 切鹸呪 : 製呪戚檎 社収繊 図楕 舛呪採 切軒研 税耕敗 (背雁 切軒葵聖 臣顕 | 鎧顕 坦軒敗)

SELECT 123.456,
            ROUND(123.456), -- 123 : 社収繊 切軒 奄沙葵 0 旋遂, 湛属切軒拭辞 鋼臣顕 旋遂馬壱 窒径精 舛呪採幻
            ROUND(123.456, 0), -- 123
            ROUND(123.456, 1), -- 123.5
            ROUND(123.456, -1) -- 120
FROM DUAL;

-- 送据 舛左拭辞 紫腰, 戚硯, 厭食, 左格什匂昔闘, 左格什匂昔闘亜 旋遂吉 尻裟 繕噺
-- 尻裟精 紺暢 坦軒 : 1鰍厭食
-- 尻裟精 探舘是拭辞 鋼臣顕敗
SELECT EMP_ID 紫腰, EMP_NAME 戚硯, SALARY 厭食, BONUS_PCT 左格什匂昔闘,
           ROUND((SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12, -4) "1鰍厭食"
FROM EMPLOYEE; 

-- TRUNC(収切 | 収切亜 奄系吉 鎮軍誤 | 域至縦, 切鹸呪) : 箭肢敗呪
-- 切鹸呪 : 持繰鞠檎 0. (0精 社収繊 是帖績)
-- 走舛廃 切鹸呪猿走(丞呪) 暁澗 走舛廃 切鹸呪(製呪)税 葵聖 獄軒澗 敗呪. (鋼臣顕 蒸製)
SELECT 145.678,
            TRUNC(145.678), -- 145
            TRUNC(145.678, 0), -- 145
            TRUNC(145.678, 1), -- 145.6
            TRUNC(145.678, -1), -- 140
            TRUNC(145.678, -3) -- 0
FROM DUAL;

-- 送据 舛左拭辞 厭食税 汝液聖 繕噺
-- 10舘是拭辞 箭肢
SELECT AVG(SALARY) 厭食汝液社収繊,
            TRUNC(AVG(SALARY), -2) 厭食汝液
FROM EMPLOYEE;

-- FLOOR(収切 | 収切亜 奄系吉 鎮軍誤 | 域至縦)
-- 舛呪 幻級奄 敗呪 (社収繊 焼掘葵 獄軒澗 敗呪)
SELECT ROUND(123.56), TRUNC(123.56), FLOOR(123.56)
FROM DUAL;

-- ABS(収切 | 収切亜 奄系吉 鎮軍誤 | 域至縦)
-- 箭企葵 坦軒 敗呪 (丞呪澗 益企稽, 製呪澗 丞呪稽 郊嘩)
SELECT ABS(123), ABS(-123)
FROM DUAL;

-- 脊紫析 - 神潅, 神潅 - 脊紫析 繕噺 : 紺暢 悦巷析呪
-- 悦巷析呪澗 舛呪稽 坦軒, 乞砧 丞呪稽 坦軒
-- 神潅 劾促 姥馬澗 敗呪 : SYSDATE
SELECT HIRE_DATE - SYSDATE 悦巷析呪,
            SYSDATE - HIRE_DATE 悦巷析呪,
            ABS(FLOOR(HIRE_DATE - SYSDATE)) 悦巷析呪,
            ABS(FLOOR(SYSDATE - HIRE_DATE)) 悦巷析呪
FROM EMPLOYEE;

-- MOD(蟹喚 企雌葵, 蟹喚 呪)
-- 蟹刊奄廃 蟹袴走 葵聖 軒渡馬澗 敗呪
-- 切郊坦軍 (蟹喚 企雌葵 % 蟹喚 呪) 紫遂 公 敗
SELECT FLOOR(25 / 7) 交, MOD(25, 7) 蟹袴走
FROM DUAL;

-- 送据 舛左拭辞 紫腰戚 筈呪昔 送据級 繕噺
-- 紫腰, 戚硯
SELECT EMP_ID 紫腰, EMP_NAME 戚硯
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = 1;

-- SYSDATE 敗呪
-- 獣什奴生稽採斗 薄仙 劾切人 獣娃聖 繕噺背 身
SELECT SYSDATE
FROM DUAL;

--************************************************************************************************************************
-- 神虞適拭辞澗 発井竺舛, 汽戚斗今戚什 梓端 淫恵 舛左級聖 乞砧 煽舌 淫軒馬壱 赤製
-- 汽戚斗 拒偲格軒 (Data Dictionary : 汽戚斗 紫穿) 慎蝕拭 砺戚鷺 莫殿稽 唖唖 煽舌鞠檎辞 淫軒鞠壱 赤製
-- 汽戚斗 拒偲格軒澗 DB 獣什奴戚 淫軒敗, 紫遂切澗 謝喜 呪 蒸製
-- 紫遂切澗 煽舌吉 舛左研 繕噺背辞 瑳 呪澗 赤製

-- 発井竺舛引 淫恵吉 汽戚斗 拒偲格軒拭辞 実特 舛左幻 析採 痕井拝 呪 赤製
SELECT *
FROM SYS.NLS_SESSION_PARAMETERS;

-- 劾促 匂庫引 淫恵吉 痕呪 葵幻 繕噺
SELECT VALUE
FROM SYS.NLS_SESSION_PARAMETERS
WHERE PARAMETER = 'NLS_DATE_FORMAT';

-- 劾促 匂庫聖 呪舛廃陥檎
ALTER SESSION
SET NLS_DATE_FORMAT = 'DD-MM-RR';

-- 溌昔
SELECT SYSDATE
FROM DUAL;

-- 据掘 匂庫生稽 痕井
ALTER SESSION
SET NLS_DATE_FORMAT = 'RR/MM/DD';
--************************************************************************************************************************
-- ADD_MONTHS('劾促軒斗群' | 劾促亜 奄系吉 鎮軍誤, 希馬奄拝 鯵杉呪)
-- 希廃 鯵杉呪拭 企廃 劾促亜 軒渡喫

-- 神潅 劾促拭辞 10鰍 及 劾促澗?
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 120)
FROM DUAL;

-- 送据 舛左拭辞 脊紫析 奄層 20鰍吉 劾促 繕噺
-- 紫腰, 戚硯, 脊紫析, 20鰍吉 劾促
SELECT EMP_ID 紫腰, EMP_NAME 戚硯, HIRE_DATE 脊紫析,
            ADD_MONTHS(HIRE_DATE, 240) "20鰍吉 劾促"
FROM EMPLOYEE;

-- 送据級 掻 悦巷鰍呪亜 20鰍 戚雌吉 送据 舛左 繕噺
-- 紫腰, 戚硯, 採辞坪球, 送厭坪球, 脊紫析
SELECT EMP_ID 紫腰, EMP_NAME 戚硯, DEPT_ID 採辞坪球, JOB_ID 送厭坪球, HIRE_DATE 脊紫析
FROM EMPLOYEE
WHERE ADD_MONTHS(HIRE_DATE, 240) < SYSDATE;

-- MONTHS_BETWEEN('劾促軒斗群' | 劾促亜 奄系吉 鎮軍誤 | 劾促敗呪, '劾促軒斗群' | 劾促亜 奄系吉 鎮軍誤 | 劾促敗呪)
-- 砧 劾促税 鯵杉 呪税 託戚研 鋼発敗

-- 送据級税 戚硯, 脊紫析, 薄仙猿走税 悦巷析呪 悦巷鯵杉呪, 悦巷鰍呪 繕噺
-- 乞砧 舛呪莫生稽 坦軒敗
SELECT EMP_NAME 戚硯, HIRE_DATE 脊紫析,
            FLOOR(SYSDATE - HIRE_DATE) 悦巷析呪,
            FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))悦巷鯵杉呪,
            FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12)悦巷鰍呪
FROM EMPLOYEE;

-- NEXT_DAY('劾促軒斗群' | 劾促亜 奄系吉 鎮軍誤, '推析戚硯')
-- 走舛廃 劾促 及楕 劾促拭辞 亜舌 亜猿錘 走舛 推析税 劾促研 鋼発敗
-- 薄仙 DBMS 税 紫遂情嬢亜 'KOREAN' 戚糠稽 推析戚硯精 廃越稽 潤醤敗
-- 慎嬢稽 推析戚硯 紫遂馬檎 拭君害
SELECT SYSDATE, NEXT_DAY(SYSDATE, '析推析')
FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'SUNDAY')
FROM DUAL; -- ERROR, DBMS税 紫遂情嬢亜 KOREAN戚糠稽 神嫌害

-- 発井竺舛拭辞 紫遂 情嬢 痕井背砂
ALTER SESSION
SET NLS_LANGUAGE = AMERICAN;

ALTER SESSION
SET NLS_LANGUAGE = KOREAN;

-- LAST_DAY('劾促軒斗群' | 劾促亜 奄系吉 鎮軍誤)
-- 走舛廃 劾促税 杉拭 企廃 原走厳 劾促(DATE)研 鋼発敗
SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM DUAL;

-- 送据 舛左拭辞 戚硯, 脊紫析, 脊紫廃 含税 悦巷析呪 繕噺
-- 爽源 匂敗 析呪
SELECT EMP_NAME 戚硯, HIRE_DATE 脊紫析, 
            LAST_DAY(HIRE_DATE) - HIRE_DATE "脊紫 湛含 悦巷析呪"
FROM EMPLOYEE;

-- 神潅 劾促 繕噺 敗呪, 督虞耕斗研 閤走省壱 敗呪誤生稽幻 叔楳喫
SELECT SYSDATE, SYSTIMESTAMP,
            CURRENT_DATE, CURRENT_TIMESTAMP
FROM DUAL;

-- EXTRACT(蓄窒拝舛左 FROM 劾促)
-- 劾促 汽戚斗拭辞 据馬澗 舛左幻 蓄窒背辞 鋼発馬澗 敗呪
-- 蓄窒拝 舛左 : YEAR, MONTH, DAY, HOUR, MINUTE, SECOND

-- 神潅 劾促拭辞 鰍亀, 杉, 析 魚稽 蓄窒
SELECT SYSDATE,
            EXTRACT(YEAR FROM SYSDATE),
            EXTRACT(MONTH FROM SYSDATE),
            EXTRACT(DAY FROM SYSDATE)
FROM DUAL;

-- 送据税 戚硯, 脊紫析, 悦巷鰍呪1, 悦巷鰍呪2 繕噺
-- 悦巷鰍呪澗 神潅 劾促 奄層生稽 域至敗 : EXTRACT, MONTHS_BETWEEN 唖唖 紫遂背砂
SELECT EMP_NAME 戚硯, HIRE_DATE 脊紫析,
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "悦巷鰍呪1",
            FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) "悦巷鰍呪2" -- 幻 悦巷鰍呪 魚走奄拭 旋杯敗
FROM EMPLOYEE;
--*********************************************************************************************************************************

-- 莫痕発 敗呪*******************************古酔掻推*************************************************************************
-- NUMBER, DATE, CHARACTER 娃税 展脊聖 郊荷澗 敗呪

-- 切疑 莫痕発 井酔 
SELECT 25 + '10'        -- NUMBER + CHARACTER >>> 切疑生稽 NUMBER 稽 郊会(切疑 莫痕発)
FROM DUAL;

-- 誤獣旋 莫痕発
SELECT 25 + TO_NUMBER('10')
FROM DUAL;

SELECT *
FROM EMPLOYEE
-- WHERE EMP_ID = 100;         -- CHAR = NUMBER >>> CHAR 稽 切疑 莫痕発 喫, ORACLE戚 鎧採旋生稽 切疑 莫痕発 背捜
WHERE EMP_ID = TO_CHAR(100);  -- 誤獣莫痕発

-- 切疑 莫痕発戚 照鞠澗 井酔 >>> 莫痕発聖 誤獣背醤 敗
SELECT SYSDATE - '15/03/25'             -- DATE - CHARACTER 税 展脊淫域 : 切疑莫痕発 照喫
FROM DUAL;      -- ERROR

SELECT SYSDATE - TO_DATE('15/03/25')        -- 誤獣 莫痕発
FROM DUAL;

-- TO_CHAR() 敗呪 *************************************************************************************
-- 収切(NUMBER)蟹 劾促(DATE)拭 企背 窒径 匂庫(FORMAT : 窒径莫縦) 走舛獣 紫遂馬澗 敗呪
-- NUMBER + FORMAT => CHARACTER (匂庫戚 旋遂吉 庚切伸稽 痕発喫)
-- DATE + FORMAT => CHARACTER(匂庫戚 旋遂吉 庚切伸稽 痕発喫)

-- 収切拭 匂庫 旋遂馬澗 TO_CHAR() 敗呪 紫遂
-- 紫遂莫縦 : TO_CHAR(収切葵 | 収切亜 奄系吉 鎮軍誤, '匂庫走舛遂庚切伸')
-- 爽稽 搭鉢舘是 妊獣, 探舘是 姥歳切, 社収繊 妊獣, 叔呪莫 汽戚斗 走呪莫(引俳遂 妊奄)生稽 妊獣

SELECT EMP_NAME 戚硯,
           TO_CHAR(SALARY, 'L99,999,999') 厭食,
           TO_CHAR(NVL(BONUS_PCT, 0), '90.00') 左格什匂昔闘
FROM EMPLOYEE;

-- 劾促拭 匂庫 旋遂馬澗 TO_CHAR() 敗呪 紫遂
-- 紫遂莫縦 : TO_CHAR('劾促汽戚斗' | 劾促亜 奄系吉 鎮軍誤, '匂庫走舛庚切伸')
-- 鰍据析 獣歳段 歳奄 推析 神穿|神板 去聖 窒径坦軒拝 凶 紫遂敗

-- 鰍亀 窒径 匂庫
SELECT SYSDATE,
            TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'RRRR'), -- Y 企重拭 R亀 紫遂亜管
            TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'RR'),
            TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- 鰍亀 窒径 匂庫 + '績税税 庚切伸'
-- ' ' 照拭 ' ' 研 紫遂拝 呪 蒸製. 拙精 魚身妊 照拭 笛 魚身妊研 隔嬢辞 嘘企稽 紫遂馬澗 依精 亜管.
SELECT SYSDATE,
            TO_CHAR(SYSDATE, 'YYYY "鰍"'), TO_CHAR(SYSDATE, 'RRRR "鰍"'), 
            TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'RR'),
            TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- 杉拭 企廃 匂庫
SELECT SYSDATE,
            TO_CHAR(SYSDATE, 'YYYY "鰍" MM "杉"'), TO_CHAR(SYSDATE, 'RRRR "鰍" fmMM "杉"'), 
            TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'RM'),
            TO_CHAR(SYSDATE, 'MONTH'), TO_CHAR(SYSDATE, 'MON')
FROM DUAL;
 
 -- 劾促拭 企廃 匂庫
SELECT SYSDATE,
            TO_CHAR(SYSDATE, '"1鰍奄層" DDD "析属"'), 
            TO_CHAR(SYSDATE, '"杉奄層" DD "析属"'), 
            TO_CHAR(SYSDATE, '"爽奄層" D "析属"')
FROM DUAL;

-- 歳奄人 推析 匂庫
SELECT SYSDATE,
            TO_CHAR(SYSDATE, 'Q "歳奄"'),
            TO_CHAR(SYSDATE, 'DAY'),
            TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- 送据 舛左拭辞 戚硯, 脊紫析 繕噺
-- 脊紫析精 匂庫 旋遂 : '2016鰍 05杉 19析 (鯉)'
SELECT EMP_NAME 戚硯,
            TO_CHAR(HIRE_DATE, 'YYYY"鰍" MM"杉" DD"析" "("DY")"') 脊紫析,
            TO_CHAR(HIRE_DATE, 'YYYY"鰍" MON DD"析" "("DY")"') 脊紫析
FROM EMPLOYEE;
