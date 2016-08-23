set nocount on
--find out how big buffer pool is and determine percentage used by each database

IF OBJECT_ID('tempdb..#PagesBreakdown') IS NOT NULL
	DROP TABLE #PagesBreakdown

CREATE TABLE #PagesBreakdown
(
	Object varchar(25)
	,value float
)

select object_name,CAST(count(*)/SUM(1/(cntr_value*1000.0))/1000 AS INT) as PLE,CAST(count(*)/SUM(1/(cntr_value*1000.0))/1000 AS INT)/60/60 AS PLE_Hours
from sys.dm_os_performance_counters
where 
object_name like '%Buffer Node%'and 
counter_name = 'page life expectancy'
group by object_name


DECLARE @Version INT, @total_buffer INT,@free_pages int,@stolen_pages int,@db_pages int,@total_plans bigint,@SQL varchar(5000),@pages_string varchar(25);

SELECT @Version =  CAST(LEFT(CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR),CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR)) -1) AS INT)
IF @Version < 11
BEGIN
	insert into #PagesBreakdown
	SELECT 'Total Buffer',cntr_value   FROM sys.dm_os_performance_counters
	WHERE RTRIM([object_name]) LIKE '%Buffer Manager'   AND counter_name = 'Total Pages';

	insert into #PagesBreakdown
	SELECT 'DB Pages',cntr_value   FROM sys.dm_os_performance_counters
	WHERE RTRIM([object_name]) LIKE '%Buffer Manager'   AND counter_name = 'Database Pages';

	insert into #PagesBreakdown
	SELECT 'Free Pages',cntr_value   FROM sys.dm_os_performance_counters
	WHERE RTRIM([object_name]) LIKE '%Buffer Manager'   AND counter_name = 'Free Pages';

	insert into #PagesBreakdown
	SELECT 'Stolen Pages',cntr_value   FROM sys.dm_os_performance_counters
	WHERE RTRIM([object_name]) LIKE '%Buffer Manager'   AND counter_name = 'Stolen Pages';
END
ELSE
BEGIN

	insert into #PagesBreakdown
	SELECT 'DB Pages',cntr_value   FROM sys.dm_os_performance_counters
	WHERE RTRIM([object_name]) LIKE '%Buffer Manager'   AND counter_name = 'Database Pages';

	insert into #PagesBreakdown
	SELECT 'Free Pages',cntr_value/8    FROM sys.dm_os_performance_counters
	WHERE RTRIM([object_name]) LIKE '%Memory Manager'   AND counter_name = 'Free Memory (KB)';

	insert into #PagesBreakdown
	SELECT 'Stolen Pages',cntr_value/8   FROM sys.dm_os_performance_counters
	WHERE RTRIM([object_name]) LIKE '%Memory Manager'   AND counter_name = 'Stolen Server Memory (KB)';
	
	INSERT INTO #PagesBreakdown
	SELECT 'Total Buffer',sum(value)
	FROM #PagesBreakdown
END
select @db_pages = value
from #PagesBreakdown
where object = 'db pages'

SELECT @total_buffer = Value
FROM #PagesBreakdown
WHERE Object = 'Total Buffer'


SELECT OBJECT, VALUE as Pages, CAST(VALUE/128.0 AS DECIMAL(10,2)) as MB_In_Cache,cast((VALUE/@Total_Buffer) * 100 as decimal (4,2)) as Percentage
FROM #PagesBreakdown
where object <> 'total buffer'
UNION
SELECT Object,Value,CAST(VALUE/128.0 AS DECIMAL(10,2)) as MB_In_Cache,100.0
FROM #PagesBreakdown
where object = 'total buffer'

IF @Version < 11
	SET @pages_string = 'single_pages_kb'
ELSE 
	SET @pages_string = 'pages_kb'

SET @SQL = 'select Type,Name,sum(' + @pages_string + ')/1024 as MemoryMB, CAST(((sum(' + @pages_string +'/8.0))/' + CAST(@total_buffer AS VARCHAR) + ') * 100 AS DECIMAL(4,2)) AS PercentageOfBufferPool
	from sys.dm_os_memory_clerks
	WHERE Type <> ''MEMORYCLERK_SQLBUFFERPOOL''
	AND ' + @pages_string + '/1024 > 0
	group by type,name
	union all
	select ''BufferCache'',''DatabasePages'',COUNT(*) * 8/1024 AS MemoryMB,CAST((COUNT(*)*1.0/' + CAST(@total_buffer AS VARCHAR) +')*100 AS DECIMAL(4,2)) AS PercentageOfBufferPool
	from sys.dm_os_buffer_descriptors
	order by MemoryMB desc'

EXEC(@SQL);

;WITH src AS
(
	SELECT database_id, db_buffer_pages = COUNT_BIG(*) 
	FROM sys.dm_os_buffer_descriptors       --WHERE database_id BETWEEN 5 AND 32766       
	GROUP BY database_id
)

SELECT   [db_name] = 
			CASE [database_id] 
				WHEN 32767 THEN 'Resource DB'
				ELSE DB_NAME([database_id]) 
			END
			,db_buffer_pages
			,db_buffer_MB = db_buffer_pages / 128
			,db_buffer_percent = CONVERT(DECIMAL(6,3)
			,db_buffer_pages * 100.0 / @DB_pages)
			,Percent_total = CONVERT(DECIMAL(6,3)
			,db_buffer_pages * 100.0 / @total_buffer)
FROM src
ORDER BY db_buffer_pages DESC;

select @total_plans = count_big(*)
FROM sys.dm_exec_cached_plans

--Shows the cache type and amount of memory dedicated to single use plans.
SELECT objtype AS [CacheType]
        , count_big(*) AS [Total Plans]
        , sum(cast(size_in_bytes as decimal(18,2)))/1024/1024 AS [Total MBs]
        , avg(cast(usecounts as bigint)) AS [Avg Use Count]
        , sum(cast((CASE WHEN usecounts = 1 THEN size_in_bytes ELSE 0 END) as decimal(18,2)))/1024/1024 AS [Total MBs - USE Count 1]
        , sum(CASE WHEN usecounts = 1 THEN 1 ELSE 0 END) AS [Total Plans - USE Count 1]
		,CAST(CAST(count_big(*) AS FLOAT)/CAST(@total_plans AS FLOAT) * 100 AS DECIMAL(4,2)) AS PercentagePlans
FROM sys.dm_exec_cached_plans
GROUP BY objtype
ORDER BY [Total MBs - USE Count 1] DESC
go
sp_configure

/*IF @Version < 11
begin	
	SELECT  
	   LEFT([name], 20) AS [name],
	   LEFT([type], 20) AS [type],
	   SUM([single_pages_kb] + [multi_pages_kb]) AS cache_kb,
	   SUM([entries_count]) AS No_Entries
	FROM sys.dm_os_memory_cache_counters 
	WHERE TYPE IN ('CACHESTORE_SQLCP','CACHESTORE_PHDR','CACHESTORE_OBJCP')
	GROUP BY [type], [name]
	ORDER BY cache_kb DESC
end

*/

