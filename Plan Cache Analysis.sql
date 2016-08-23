--retrieve single-use plans
SELECT text, cp.objtype, cp.size_in_bytes
FROM sys.dm_exec_cached_plans AS cp 
CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) st
WHERE cp.cacheobjtype = N'Compiled Plan'
AND cp.objtype IN (N'Adhoc', N'Prepared')
AND cp.usecounts = 1
ORDER BY cp.size_in_bytes DESC 
OPTION (RECOMPILE);


--Shows the cache type and amount of memory dedicated ti single use plans.
SELECT objtype AS [CacheType]
        , count_big(*) AS [Total Plans]
        , sum(cast(size_in_bytes as decimal(18,2)))/1024/1024 AS [Total MBs]
        , avg(cast(usecounts as bigint)) AS [Avg Use Count]
        , sum(cast((CASE WHEN usecounts = 1 THEN size_in_bytes ELSE 0 END) as decimal(18,2)))/1024/1024 AS [Total MBs - USE Count 1]
        , sum(CASE WHEN usecounts = 1 THEN 1 ELSE 0 END) AS [Total Plans - USE Count 1]
FROM sys.dm_exec_cached_plans
GROUP BY objtype
ORDER BY [Total MBs - USE Count 1] DESC



--Finds all missing indexes
;WITH XMLNAMESPACES(DEFAULT N'http://schemas.microsoft.com/sqlserver/2004/07/showplan')       
SELECT dec.usecounts, dec.refcounts, dec.objtype
      ,dec.cacheobjtype, des.dbid, des.text      
      ,deq.query_plan 
FROM sys.dm_exec_cached_plans AS dec 
     CROSS APPLY sys.dm_exec_sql_text(dec.plan_handle) AS des 
     CROSS APPLY sys.dm_exec_query_plan(dec.plan_handle) AS deq 
WHERE deq.query_plan.exist(N'/ShowPlanXML/BatchSequence/Batch/Statements/StmtSimple/QueryPlan/MissingIndexes/MissingIndexGroup') <> 0 
ORDER BY dec.usecounts DESC 

--Find implicit type conversions
;WITH XMLNAMESPACES(DEFAULT N'http://schemas.microsoft.com/sqlserver/2004/07/showplan')
SELECT 
cp.query_hash, cp.query_plan_hash,
ConvertIssue = operators.value('@ConvertIssue', 'nvarchar(250)'), 
Expression = operators.value('@Expression', 'nvarchar(250)'), qp.query_plan
FROM sys.dm_exec_query_stats cp
CROSS APPLY sys.dm_exec_query_plan(cp.plan_handle) qp
CROSS APPLY query_plan.nodes('//Warnings/PlanAffectingConvert') rel(operators)



-- find logically identical queries
SELECT top 10 COUNT(*) AS [Count], query_stats.query_hash, 
    query_stats.statement_text AS [Text]
FROM 
    (SELECT QS.*, 
    SUBSTRING(ST.text, (QS.statement_start_offset/2) + 1,
    ((CASE statement_end_offset 
        WHEN -1 THEN DATALENGTH(ST.text)
        ELSE QS.statement_end_offset END 
            - QS.statement_start_offset)/2) + 1) AS statement_text
     FROM sys.dm_exec_query_stats AS QS
     CROSS APPLY sys.dm_exec_sql_text(QS.sql_handle) as ST) as query_stats
GROUP BY query_stats.query_hash, query_stats.statement_text
ORDER BY 1 DESC
