CREATE TABLE TraceResults_DW01_20171005_0600 (
 TextData VARCHAR(max),
 Duration INT,
 Reads INT,
 Writes INT,
 CPU INT,
 StartTime DATETIME,
 ProcedureName VARCHAR(100)
)
GO
 
INSERT INTO TraceResults_DW01_20171005_0600 
(TextData, Duration, Reads, Writes, CPU, StartTime)
SELECT TextData, Duration/1000, Reads, Writes, CPU, StartTime
FROM fn_trace_gettable('C:\Users\jshurak\Documents\Clients\IRC\SQL Performance\Traces\BVA_DW01_20171005060119.trc',1)