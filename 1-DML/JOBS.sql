select * from  [LOG].[AUDIT_JOBS];

insert into [LOG].[AUDIT_JOBS]
values
('TMP_Shippers',getdate(),SYSTEM_USER,1);
insert into [LOG].[AUDIT_JOBS]
values
('TMP_Regions',getdate(),SYSTEM_USER,1);
insert into [LOG].[AUDIT_JOBS]
values
('TMP_Territories',getdate(),SYSTEM_USER,1);
insert into [LOG].[AUDIT_JOBS]
values
('TMP_Categories',getdate(),SYSTEM_USER,1);