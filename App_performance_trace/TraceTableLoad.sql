USE [Traces]
GO

INSERT INTO [dbo].[Master_Transactions]
           ([EventClass]
		   ,[NTUsername]
           ,[ApplicationName]
           ,[LoginName]
           ,[starttime]
           ,[endtime]
           ,[textdata]
           ,[transactionID]
           ,[HostName])
 SELECT [EventClass]
      ,[NTUsername]
      ,[ApplicationName]
      ,[LoginName]
      ,[starttime]
      ,[endtime]
      ,[textdata]
      ,[transactionID]
      ,[HostName]
FROM ::fn_trace_gettable('C:\Users\jshurak\Desktop\MasterTransactions_20140129141938.trc',1)
GO


