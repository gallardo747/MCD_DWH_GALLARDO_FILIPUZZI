select * from  [LOG].[AUDIT_JOBS];

insert into [LOG].[AUDIT_JOBS]
values
('TMP_Shippers',getdate(),SYSTEM_USER,1);