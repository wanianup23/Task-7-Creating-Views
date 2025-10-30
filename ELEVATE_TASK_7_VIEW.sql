select*from employees;

create or replace view v1
as select*from departments;

select*from v1;

drop view v1;


---constraints on view
select *from b7;
create view b6 
as select * from b7 with read only;

insert into b6 values(80,'sonu','abc@gmail.com');--"cannot perform a DML operation on a read-only view"
insert into b7 values(80,'sonu','abc@gmail.com'); --we can try add in base table
select*from b7; ----but opeartion perform on main table
select*from b6;----and its rflected or changes done in view also--

CREATE TABLE TD12
AS SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME
FROM EMPLOYEES WHERE ROWNUM<5;

SELECT*FROM TD12;

CREATE OR REPLACE VIEW V2

AS SELECT*FROM TD12;

SELECT*FROM V2;

INSERT INTO V2 VALUES(104,'ANUP','WANI'); --IF WE ADD IN VIEW SAME ROW ADDED IN BASE TABLE ALSO

DELETE FROM V2
WHERE EMPLOYEE_ID=103;------DATA DELETED FROM VIEW AND BASE TABLE ALSO--

commit;

SELECT*FROM TD12;
ROLLBACK;

---WITH CHECK OPTION
SELECT*FROM TD12;
CREATE OR REPLACE VIEW V2
AS SELECT * FROM TD12 WHERE EMPLOYEE_ID <104 WITH CHECK OPTION;
SELECT*FROM V2;
INSERT INTO V2 VALUES(104,'SAM','KUR');---view WITH CHECK OPTION where-clause violation

----COMPLEX VIEW----
 create or replace view v7
 as select e.first_name,e.last_name,d.department_name
 from employees e join departments d
 on e.department_id=d.department_id;
 
 select*from v7;
 delete from v7;
 insert into v7 values ('sam','kur','II');--
 ---"cannot modify more than one base table through a join view"
---*Cause:    Columns belonging to more than one underlying table were either
  ---         inserted into or updated.
 ---in complex view insert, update ,delete(DML) commands are not possible--
 --You cannot update data through a complex view if it:
---Includes group functions or GROUP BY
---Has joins of multiple tables
---Has DISTINCT or UNION
---You can select from it and even use it inside another query.
 create or replace view v7
 as select sum(e.salary) as sum_sa,avg(e.salary) as av_s,d.department_name
 from employees e join departments d
 on d.department_id=e.department_id
 group by department_name;
 select*from v7;
 
 ----materised view----
 create materialized view vm
 as select first_name,last_name,salary
 from employees;--Ask your database administrator or designated security
          ------- administrator to grant you the necessary privileges

 
 commit;


----force view---
---when table is not availabe 
create force view vf1 
as select*from  empt_12;
select*from vf1;

create table empt_12
(sr_no number(10),nm varchar2(10));
insert into empt_12 values(12,'anup');

select*from vf1;

