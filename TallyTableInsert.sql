use scratchpad
go
WITH Tally (N) AS
(
    SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM sys.all_columns a CROSS JOIN sys.all_columns b
)
insert into t1
SELECT N, 2
FROM Tally
order by N
offset 100000 ROWS fetch next 10 rows only;
