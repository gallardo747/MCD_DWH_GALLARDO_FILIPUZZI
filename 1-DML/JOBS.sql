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
insert into [LOG].[AUDIT_JOBS]
values
('TMP_Customers',getdate(),SYSTEM_USER,1);
insert into [LOG].[AUDIT_JOBS]
values
('TMP_Employee_Territories',getdate(),SYSTEM_USER,1);
insert into [LOG].[AUDIT_JOBS]
values
('TMP_Employee',getdate(),SYSTEM_USER,1);
insert into [LOG].[AUDIT_JOBS]
values
('TMP_Order_Details',getdate(),SYSTEM_USER,1);
insert into [LOG].[AUDIT_JOBS]
values
('TMP_Orders',getdate(),SYSTEM_USER,1);
insert into [LOG].[AUDIT_JOBS]
values
('TMP_Products',getdate(),SYSTEM_USER,1);
insert into [LOG].[AUDIT_JOBS]
values
('TMP_Suppliers',getdate(),SYSTEM_USER,1);
insert into [LOG].[AUDIT_JOBS]
values
('TMP_Countries',getdate(),SYSTEM_USER,1);