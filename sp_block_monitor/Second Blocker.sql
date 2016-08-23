begin transaction
use mace
go
update CTApplication 
set applicationid = 1
where Applicationname = 'test2'

rollback transaction