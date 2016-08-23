
begin transaction


INSERT INTO [mace].[dbo].[CTApplication] values (1,'test block');


WAITFOR DELAY '0:10:00'

rollback transaction


--sp_whoisactive @help=1