--�������� ��������������� �������

--------------------------------------------------------------------------------------------------------------------------------
--SQL-��� �������� �� 
--�������� ������,�������� �������������������,����������� �� ��������� �������


--�������� ������� ���������
CREATE TABLE post
(
post_id NUMBER(5) PRIMARY KEY, --id_���������
job_title VARCHAR2(1000), --�������� ���������
salary NUMBER(8,2), --���������� �����
department_id NUMBER(5) --id_������(������� ����, �� ������� �����)
);
--����������� �� ������� ���������
ALTER TABLE post ADD CONSTRAINT salary CHECK(salary>0); --�������� �� ����� ���� �������
ALTER TABLE post MODIFY (job_title not null); --�������� ��������� �� ������
--������� ��������
INSERT INTO post VALUES(10,'�������-�����������',500000,101);
INSERT INTO post VALUES(15,'�������',450000,102);
INSERT INTO post VALUES(20,'������',400000,103);
INSERT INTO post VALUES(25,'������� ��������',300000,104);
INSERT INTO post VALUES(30,'������� ��������',400000,104);
INSERT INTO post VALUES(35,'���������',20000,105);
INSERT INTO post VALUES(45,'������� �������',450000,101);
INSERT INTO post VALUES(50,'�������-�����������',470000,102);
INSERT INTO post VALUES(55,'������� ������',400000,103);
INSERT INTO post VALUES(60,'���������',50000,105);


--�������� ������� ���������
CREATE TABLE employee
(
employee_id NUMBER(5) PRIMARY KEY, --id_����������
post_id NUMBER(5), --id_��������� (������� ����, �� ������� ���������)
last_name VARCHAR2(1000), --�������
first_name VARCHAR2(1000),  -- ���
patronymic VARCHAR2(1000),  --��������
date_of_birth DATE, --���� ��������
phone_number VARCHAR2(15), --����� ��������
email VARCHAR2(100),--����������� �����
employee_category VARCHAR2(1000), --��������� 
hire_date DATE --���� ������ ������ � ���������
);
ALTER TABLE employee ADD CONSTRAINT fk_post_id FOREIGN KEY(post_id) REFERENCES post(post_id); -- ������� ����, � ������� ���������
--����������� �� ������� ���������
ALTER TABLE employee ADD CONSTRAINT phone_number CHECK (SUBSTR(phone_number,0,1)='+' AND LENGTH(phone_number)>10 AND LENGTH(phone_number)<13); -- ����� �������� ���������� � '+' � ����� �� 12 �� 15 ��������
ALTER TABLE employee MODIFY (first_name not null,last_name not null,patronymic not null, phone_number not null, email not null,employee_category not null); --�������� �������
--������������������ ��� ������� ���������(��� id_����������)
CREATE SEQUENCE employee_seq
    START WITH 1
    INCREMENT BY 1
    CACHE 20
    NOCYCLE;
--������� ��������
INSERT INTO employee VALUES(employee_seq.nextval,10,'����','�������','����������','01.01.1973','+79186760165','baev_nikolay@gmail.com','��������������� �����','25.03.2009');
INSERT INTO employee VALUES(employee_seq.nextval,15,'������','�������','�������������','16.02.1995','+79183364145','naumov_nikolay@gmail.com','���������� �����','31.03.2013');
INSERT INTO employee VALUES(employee_seq.nextval,20,'��������','������','����������','25.07.1982','+79251160132','golubina_galina@gmail.com','����� ������������ ������������','23.06.2018');
INSERT INTO employee VALUES(employee_seq.nextval,25,'����������','������','����������','03.03.1990','+79526764467','podstavkin_kirill@gmail.com','������������ �����','01.09.2005');
INSERT INTO employee VALUES(employee_seq.nextval,30,'������','�����','���������','06.05.2000','+79358640151','osipyan_alina@gmail.com','������������ �����','18.01.2000');
INSERT INTO employee VALUES(employee_seq.nextval,35,'������','���������','����������','15.09.2004','+79188778887','zybova_elizaveta@gmail.com','����� ������������ ���������','15.10.2021');
INSERT INTO employee VALUES(employee_seq.nextval,45,'��������','�������','�������','23.04.1985','+79188776336','shatohina_nataliya@gmail.com','�������������� �����','16.10.2000');
INSERT INTO employee VALUES(employee_seq.nextval,50,'������','����','���������','15.09.2000','+79361457801','chaliyan_nina@gmail.com','���������� �����','01.10.2020');
INSERT INTO employee VALUES(employee_seq.nextval,55,'������','����','������������','22.06.2001','+79188778887','yrenko_artem@gmail.com','����� ������������ ������������','10.02.2016');
INSERT INTO employee VALUES(employee_seq.nextval,60,'�������','����','�����������','03.03.1989','+79188778887','shatohin_artem@gmail.com','����� ������������ ���������','18.01.2019');


--�������� ������� �����
CREATE TABLE department
(
department_id NUMBER(5) PRIMARY KEY, --id_������
department_name VARCHAR2(1000), --��������
department_head_id NUMBER(5) --id_�����_������
);
ALTER TABLE post ADD CONSTRAINT fk_department_id FOREIGN KEY(department_id) REFERENCES department(department_id); --������� ����,�� ������� �����, � ������� ��������� 
ALTER TABLE department ADD CONSTRAINT fk_department_head_id FOREIGN KEY(department_head_id) REFERENCES employee(employee_id); --������� ����,�� ������� ���������
--����������� �� ������� �����
ALTER TABLE department MODIFY (department_name not null); --�������� ������ �� ������
--������� ��������
INSERT INTO department VALUES(101,'��������������� �����',1);
INSERT INTO department VALUES(102,'���������� �����',2);
INSERT INTO department VALUES(103,'����� ������������ ������������',3);
INSERT INTO department VALUES(104,'������������ �����',5);
INSERT INTO department VALUES(105,'����� ������������ ���������',6);


--�������� ������� �������_������_����������
CREATE TABLE employee_history
(
employee_id NUMBER(5) PRIMARY KEY, --id_����������
post_id NUMBER(5) REFERENCES post(post_id), --������� ����,�� ������� ���������
first_name VARCHAR2(1000), --���
last_name VARCHAR2(1000),  -- �������
patronymic VARCHAR2(1000),  --��������
phone_number VARCHAR2(15), --����� ��������
email VARCHAR2(100), --����������� �����
start_date DATE, --���� ������
end_date DATE, --���� ���������
last_modification VARCHAR2(1000) --��������� ��������� ����
);
ALTER TABLE employee_history ADD CONSTRAINT fk_employee_id FOREIGN KEY(employee_id) REFERENCES employee(employee_id); --������� ����,�� ������� ���������
--����������� �� ������� �������_����������
ALTER TABLE employee_history ADD CONSTRAINT employee_history_phone_number CHECK (SUBSTR(phone_number,0,1)='+' AND LENGTH(phone_number)>12 AND LENGTH(phone_number)<16); -- ����� �������� ���������� � + � ����� �� 12 �� 15 ��������
ALTER TABLE employee_history MODIFY (first_name not null,last_name not null,patronymic not null, phone_number not null, email not null);--�������� �������


--�������� ������� �������
CREATE TABLE contract
(
number_contract NUMBER(5) PRIMARY KEY, --����� ��������
total_cost NUMBER(8,2), --����� ��������� �����
contract_start_date DATE, --���� ���������� 
guess_contract_end_date DATE, -- �������������� ���� ���������� 
factual_contract_end_date DATE -- ����������� ���� ����������
);
--����������� �� ������� �������
ALTER TABLE contract ADD CONSTRAINT total_cost CHECK(total_cost>0); --����� ��������� ����� �� 0
ALTER TABLE contract ADD CONSTRAINT contract_date CHECK(TO_CHAR(contract_start_date)!=TO_CHAR(guess_contract_end_date) AND TO_CHAR(contract_start_date)!=TO_CHAR(factual_contract_end_date)); --���� ���������� � ���� ���������� �������� �� �������� ����� ����
--������������������ ��� ������� �������(��� ������_��������)
CREATE SEQUENCE contract_seq
    START WITH 1
    INCREMENT BY 1
    CACHE 20 
    NOCYCLE;
--������� ��������
INSERT INTO contract VALUES(contract_seq.nextval,100000,'01.09.2015','01.09.2017','01.09.2017');
INSERT INTO contract VALUES(contract_seq.nextval,50000,'20.01.2017','27.02.2017','20.02.2017');
INSERT INTO contract VALUES(contract_seq.nextval,500000,'01.03.2017','28.05.2017','08.07.2017');
INSERT INTO contract VALUES(contract_seq.nextval,900000,'04.08.2017','08.08.2018','02.08.2018');
INSERT INTO contract VALUES(contract_seq.nextval,600000,'01.09.2018','23.09.2018','23.09.2018');
INSERT INTO contract VALUES(contract_seq.nextval,350000,'02.10.2018','11.10.2018','11.10.2018');
INSERT INTO contract VALUES(contract_seq.nextval,100000000,'01.11.2018','01.02.2019','27.03.2020');
INSERT INTO contract VALUES(contract_seq.nextval,100000,'24.08.2020','09.10.2020','01.10.2020');
INSERT INTO contract VALUES(contract_seq.nextval,200000,'10.10.2020','20.12.2020','20.12.2020');
INSERT INTO contract VALUES(contract_seq.nextval,750000,'28.12.2020','24.03.2021','04.03.2021');
INSERT INTO contract VALUES(contract_seq.nextval,800000,'14.04.2021','13.12.2021','13.12.2021');


--�������� ������� ������
CREATE TABLE projects
(
project_id NUMBER(5) PRIMARY KEY, --id_�������
number_contract NUMBER(5), --����� ��������
project_manager_id NUMBER(5), --id_������������_������
project_cost NUMBER(8,2), --��������� �������
project_start_date DATE, --���� ������ �������
guess_project_end_date DATE, -- �������������� ���� ��������� �������
factual_project_end_date DATE --����������� ���� ��������� �������
);
ALTER TABLE projects ADD CONSTRAINT fk_number_contract FOREIGN KEY(number_contract) REFERENCES contract(number_contract); --������� ����,�� ������� �������
ALTER TABLE projects ADD CONSTRAINT fk_project_manager_id FOREIGN KEY(project_manager_id) REFERENCES employee(employee_id); --������� ����,�� ������� ���������
--����������� �� ������� ������
ALTER TABLE projects ADD CONSTRAINT project_cost CHECK(project_cost>0); --��������� ������� �� �������
ALTER TABLE projects ADD CONSTRAINT project_date CHECK( TO_CHAR(project_start_date)!=TO_CHAR(guess_project_end_date) AND TO_CHAR(project_start_date)!=TO_CHAR(factual_project_end_date)); --���� ������ � ���� ��������� ������� �� �������� ����� ����
--������������������ ��� ������� ������(��� id_�������)
CREATE SEQUENCE project_seq
    START WITH 1
    INCREMENT BY 1
    CACHE 20 
    NOCYCLE;
--������� ��������
INSERT INTO projects VALUES(project_seq.nextval,1,1,40000,'01.06.2015','01.08.2017','01.08.2017');
INSERT INTO projects VALUES(project_seq.nextval,1,1,60000,'01.06.2016','01.08.2016','01.08.2016');
INSERT INTO projects VALUES(project_seq.nextval,2,2,50000,'20.01.2017','27.02.2017','20.02.2017');
INSERT INTO projects VALUES(project_seq.nextval,4,3,200000,'04.08.2017','04.03.2018','02.03.2018');
INSERT INTO projects VALUES(project_seq.nextval,4,3,700000,'05.03.2018','02.08.2018','01.08.2018');
INSERT INTO projects VALUES(project_seq.nextval,3,1,500000,'01.09.2018','20.09.2018','15.09.2018');


--�������� ������� ���������_�������
CREATE TABLE project_member 
(
employee_id NUMBER(5) REFERENCES employee(employee_id), --id_����������(������� ����, �� ������� ���������)
project_id NUMBER(5) REFERENCES projects(project_id), --id_�������(������� ����, �� ������� ������)
start_date DATE, --���� ������ ������� 
end_date DATE, --���� ��������� �������
project_role VARCHAR2(100) -- ���� ��������� � �������
);
--�������� ���������� ���������� �����
ALTER TABLE project_member ADD CONSTRAINT pk_project_member PRIMARY KEY(employee_id,project_id);
--����������� �� ������� ��������_�������
ALTER TABLE project_member ADD CONSTRAINT s_e_date CHECK(TO_CHAR(start_date)!=TO_CHAR(end_date)); --���� ������ � ���� ����� ������� �� ���������
ALTER TABLE project_member MODIFY (project_role not null); --���� ��������� �� ������
--������� ��������
INSERT INTO project_member VALUES(8,1,'01.06.2015','01.08.2017','������� �������');
INSERT INTO project_member VALUES(9,2,'01.06.2016','01.08.2016','������ �������');
INSERT INTO project_member VALUES(7,3,'20.01.2017','20.02.2017','������� �������');
INSERT INTO project_member VALUES(1,1,'01.06.2015','01.08.2017','���������� �������');
INSERT INTO project_member VALUES(1,2,'01.06.2016','01.08.2016','������������ �������');
INSERT INTO project_member VALUES(2,3,'20.01.2017','20.02.2017','����������� �������');
INSERT INTO project_member VALUES(3,4,'04.08.2017','02.03.2018','����������� �������');
INSERT INTO project_member VALUES(3,5,'05.03.2018','02.08.2018','����������� �������');
INSERT INTO project_member VALUES(1,6,'02.03.2017','08.07.2017','����������� �������');


--�������� ������� ������������
CREATE TABLE equipment
(
equipment_id NUMBER(5) PRIMARY KEY, --id_������������
department_id NUMBER(5) REFERENCES department(department_id), --������� ����, �� ������� �����
number_equipment NUMBER(7,-2), --���������� 
equipment_start_date DATE, --���� ������ ������������� 
equipment_end_date DATE -- ���� ��������� �������������
);
--����������� �� ������� ������������
ALTER TABLE equipment ADD CONSTRAINT number_equipment CHECK(number_equipment>0); --���������� ������������ �� �������
ALTER TABLE equipment ADD CONSTRAINT equipment_date CHECK( TO_CHAR(equipment_start_date)!=TO_CHAR(equipment_end_date)); --���� ������ � ���� ����� ������������� �� �������� ����� ����
--������������������ ��� ������� ������������(��� id_������������)
CREATE SEQUENCE equipment_seq
    START WITH 1
    INCREMENT BY 1
    CACHE 20 
    NOCYCLE; 
--������� ��������
INSERT INTO equipment VALUES(equipment_seq.nextval,102,50,'01.01.2018','01.03.2018');
INSERT INTO equipment VALUES(equipment_seq.nextval,103,100,'10.03.2018','10.04.2018');
INSERT INTO equipment VALUES(equipment_seq.nextval,104,1000,'15.04.2017','22.04.2017');


--�������� ������� ������������_�_�������
CREATE TABLE equipment_project
(
equipment_id NUMBER(5) REFERENCES equipment(equipment_id) , --id_������������(������� ����, �� ������� ������������)
project_id NUMBER(5) REFERENCES projects(project_id) --id_�������(������� ����, �� ������� ������)
);
--�������� ���������� �����
ALTER TABLE equipment_project ADD CONSTRAINT pk_equipment_project PRIMARY KEY(equipment_id,project_id);
--������� ��������
INSERT INTO equipment_project VALUES(1,4);
INSERT INTO equipment_project VALUES(2,5);
INSERT INTO equipment_project VALUES(3,6);


--�������� ������� ������������_�����������
CREATE TABLE subcontr
(
subcontr_id NUMBER(5) PRIMARY KEY, --id_������������_�����������
subcontr_name VARCHAR2(1000), --��������
INN VARCHAR2(10), --���
subcontr_phone_number VARCHAR2(15), --�������
subcontr_head VARCHAR2(1000) --������������(������� � ��������)
);
--����������� �� ������� ������������_�����������
ALTER TABLE subcontr ADD CONSTRAINT subcontr_phone_number CHECK (SUBSTR(subcontr_phone_number,0,1)='+' AND LENGTH(subcontr_phone_number)>10 AND LENGTH(subcontr_phone_number)<13); -- ����� �������� ���������� � + � ����� �� 12 
ALTER TABLE subcontr ADD CONSTRAINT inn_check CHECK(LENGTH(INN)>0 AND LENGTH(INN)<11); --��� ������� �� 10 ��������
ALTER TABLE subcontr MODIFY(subcontr_name not null,subcontr_head not null); --�������� �������
--������������������ ��� ������� ������������_�����������(��� id_������������_�����������)
CREATE SEQUENCE subcontr_seq
    START WITH 1
    INCREMENT BY 1
    CACHE 20 
    NOCYCLE; 
--������� ��������
INSERT INTO subcontr VALUES(subcontr_seq.nextval,'���������-����','1234567890','+79081234567','������ �.�.');
INSERT INTO subcontr VALUES(subcontr_seq.nextval,'����������','1834178906','+79524817890','���������� �.�.');
INSERT INTO subcontr VALUES(subcontr_seq.nextval,'����','7530168555','+7908168555','�������� �.�.');

--�������� ������� ������������_�����������_�_�������
CREATE TABLE subcontr_project
(
subcontr_id NUMBER(5) REFERENCES subcontr(subcontr_id) , --id_������������_�����������(������� ����, �� ������� ������������_�����������)
project_id NUMBER(5) REFERENCES projects(project_id), --id_�������(������� ����, �� ������� ������)
service_name VARCHAR2(1000), --�������� ������
service_cost NUMBER(8,2) --���������
);
--�������� ���������� �����
ALTER TABLE subcontr_project ADD CONSTRAINT pk_subcontr_project PRIMARY KEY(subcontr_id,project_id);
--����������� �� ������� ������������_�����������_�_�������
ALTER TABLE subcontr_project ADD CONSTRAINT service_cost_check CHECK(service_cost>0); --��������� ������ �� �������
ALTER TABLE subcontr_project MODIFY(service_name not null); --�������� �������
DROP SEQUENCE service_seq;
--������� ��������
INSERT INTO subcontr_project VALUES(1,3,'������ ���������� �������',50000);
INSERT INTO subcontr_project VALUES(2,1,'������ ������������������ ��������',100000);
INSERT INTO subcontr_project VALUES(3,1,'�������������� ������������� ������������',200000);


-------------------------------------------------------------------------------------------------------------------------------
----------�������---------------------------------------------------------------------------------------------------------------

--��������� ��� �������
CREATE OR REPLACE PROCEDURE add_employee_history
  (  emp_id IN NUMBER, 
     pst_id IN NUMBER,
     fst_name IN VARCHAR2,
     lst_name IN VARCHAR2,
     patron IN VARCHAR2,
     ph_number IN VARCHAR2,
     e_mail IN VARCHAR2,
     strt_date IN DATE,
     en_date IN DATE,
     lst_modification IN VARCHAR2
   )
IS
BEGIN
  INSERT INTO employee_history (employee_id,post_id,first_name,last_name,patronymic,phone_number,email, start_date, end_date,last_modification)
    VALUES(emp_idpst_id,fst_name,lst_name,patron,ph_number,e_mail,strt_date, en_date, lst_modification);
END add_employee_history;
--������
--��������� � ������� ��������� �������� � ���������� ������ � ������� �������_����������
CREATE OR REPLACE TRIGGER update_employee_history
  AFTER UPDATE ON employee
  FOR EACH ROW
BEGIN
  add_employee_history(:old.employee_id,:old.post_id,:old.first_name,:old.last_name,:old.patronymic,:old.phone_number,:old.email,:old.hire_date,sysdate,:old.last_modification);
END;

----------�������---------------------------------------------------------------------------------------------------------------

-- �������, ������� ���������� id_��������, ������� ������� � ������ ���������� ��������, ����� �������� �������� ����������
--������ ������� ����� �������������� � ���������� ��� ������� � ��
CREATE OR REPLACE FUNCTION find_project (num_contr IN NUMBER)
    RETURN NUMBER
    IS
    proj_id NUMBER;
    CURSOR fnd_proj IS
    SELECT project_id
    FROM projects
    WHERE number_contract = num_contr;
BEGIN
    OPEN fnd_proj;
    FETCH fnd_proj INTO proj_id;
    IF fnd_proj%notfound THEN
        proj_id := 9999;
    END IF;
    CLOSE fnd_proj;
RETURN proj_id;
END;

--�������, ������� ���������� id_������������, ������� ������������ � ��������� �������(�������� - id_�������)
--������ ������� ����� �������������� � ���������� ��� ������� � ��
CREATE OR REPLACE FUNCTION find_equipment_project (proj_id IN NUMBER)
    RETURN NUMBER
    IS
    equip_proj NUMBER;
    CURSOR fnd_equip_proj IS
    SELECT equipment_id
    FROM equipment_project
    WHERE project_id = proj_id;
BEGIN
    OPEN fnd_equip_proj;
    FETCH fnd_equip_proj INTO equip_proj;
    IF fnd_equip_proj%notfound THEN
        equip_proj := 9999;
    END IF;
    CLOSE fnd_equip_proj;
RETURN equip_proj;
END;

--�������, ������� ���������� id_��������, � ������� �� ����������(�������� - id_����������)
--������ ������� ����� �������������� � ���������� ��� ������� � ��
CREATE OR REPLACE FUNCTION find_employee_projects (emp_id IN NUMBER)
    RETURN NUMBER
    IS
    emp_proj NUMBER;
    CURSOR fnd_emp_proj IS
    SELECT project_id
    FROM project_member
    WHERE employee_id = emp_id;
BEGIN
    OPEN fnd_emp_proj;
    FETCH fnd_emp_proj INTO emp_proj;
    IF fnd_emp_proj%notfound THEN
        emp_proj := 9999;
    END IF;
    CLOSE fnd_emp_proj;
RETURN emp_proj;
END;


----------������----------------------------------------------------------------------------------------------------------------
--��������� �� �������� �� ������� �������_������_���������� ��� �������, ������� �������� ����� 25 ��� 
CREATE OR REPLACE PROCEDURE delete_old_inform
 IS 

BEGIN 
  DELETE FROM employee_history
  WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, end_date)/12)>25;
  COMMIT; 
  CLOSE; 

--������� ����� ����������� ��� � ���� 1 �������
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name          =>  'historic_job',
   job_action        =>  'for_job'	, 
   repeat_interval   =>  'FREQ=YEARLY;BYMONTH=DEC;BYMONTHDAY=1',
   comments          =>  'Once a year December 1');
END;    


--------------------------------------------------------------------------------------------------------------------------------
--������� � ��

--1.�������� ������ � ������� ���������� ������ ��� ���� ����������� ���������, �� ��������� ��������� �����������, �� ����������� �������.
--������ � ������� ���������� ������ �� ����������� �������
SELECT dep.department_name ��������_������, emp.first_name ���, emp.last_name �������,emp.patronymic ��������, TRUNC(MONTHS_BETWEEN(SYSDATE, date_of_birth)/12) �������
FROM employee emp
INNER JOIN post ps ON emp.post_id = ps.post_id
INNER JOIN department dep ON ps.department_id = dep.department_id;

--������ � ������� ���������� ������ �� ��������� ��������� �����������
SELECT dep.department_name, emp.first_name ���, emp.last_name �������,emp.patronymic ��������, emp.employee_category ���������_����������
FROM employee emp
INNER JOIN post ps ON emp.post_id = ps.post_id
INNER JOIN department dep ON ps.department_id = dep.department_id
WHERE emp.employee_category = '���������� �����';

--������ � ������� ���� ����������� ��������� �� ����������� �������
SELECT emp.first_name ���, emp.last_name �������,emp.patronymic ��������,emp.phone_number �����_��������, emp.email ����������_�����, emp.employee_category ���������_����������, TRUNC(MONTHS_BETWEEN(SYSDATE, date_of_birth)/12) �������
FROM employee emp;

----������ � ������� ���� ����������� ��������� �� ��������� ��������� ����������
SELECT emp.first_name ���, emp.last_name �������,emp.patronymic ��������,emp.phone_number �����_��������, emp.email ����������_�����, emp.employee_category ���������_����������
FROM employee emp;

--2.�������� �������� ������������� �������.
SELECT emp.first_name ���,emp.last_name �������,emp.patronymic ��������,dep.department_name ��������_������
FROM department dep 
INNER JOIN employee emp ON dep.department_head_id = emp.employee_id;

--3.�������� �������� ��������� ��� ��������, ����������� � ������ ������ ��� � ������ ���������� ��������� �������.
--�������� ���������, ������� ���� ��������� � ��������� � 2017 ����
SELECT contr.number_contract �����_��������,contr.total_cost �����_���������_�����,contr.contract_start_date ����_����������_��������, contr.factual_contract_end_date �����������_����_����������_��������
FROM contract contr
WHERE TO_CHAR(contr.contract_start_date,'YYYY')='2017' AND TO_CHAR(contr.factual_contract_end_date,'YYYY')='2017';

--�������� ��������, ������� ����������� � 2018 ����
SELECT proj.number_contract �����_��������,emp.first_name ���_������������_�������, emp.last_name �������_������������_�������,proj.project_start_date ����_������_�������,proj.factual_project_end_date �����������_����_���������_�������
FROM projects proj
INNER JOIN employee emp ON proj.project_manager_id = emp.employee_id
WHERE TO_CHAR(proj.project_start_date,'YYYY')='2018' OR TO_CHAR(proj.factual_project_end_date,'YYYY')='2018';

--4.�������� ���������� � ���, ����� ������� ����������� (�����������) � ������ ���������� �������� � ����� �������� �������������� ���������� ���������.
--����� ������� ����������� � ������ ���������� ��������
SELECT contr.number_contract �����_��������,contr.contract_start_date ����_����������_��������, contr.factual_contract_end_date �����������_����_����������_��������,proj.project_id ID_�������,proj.project_start_date ����_������_�������,proj.factual_project_end_date �����������_����_���������_�������,emp.first_name ���_������������_�������, emp.last_name �������_������������_�������
FROM contract contr
INNER JOIN projects proj ON contr.number_contract = proj.number_contract
INNER JOIN employee emp ON proj.project_manager_id = emp.employee_id;

--����� �������� �������������� ���������� ��������
SELECT proj.project_id ID_�������,proj.project_start_date ����_������_�������,proj.factual_project_end_date �����������_����_���������_�������,contr.number_contract �����_��������,contr.contract_start_date ����_����������_��������, contr.factual_contract_end_date �����������_����_����������_��������
FROM projects proj
INNER JOIN contract contr ON  proj.number_contract = contr.number_contract;

--5.�������� ������ � ��������� ����������� ��������� (��������) � ������� ���������� ������� �������.
--��������� ����������� ��������� � 2017 ����
SELECT number_contract �����_��������, total_cost ���������_��������,SUM(total_cost) OVER() ���������_���������_�����������_�_2017_����
FROM contract
WHERE TO_CHAR(contract_start_date,'YYYY')='2017' AND TO_CHAR(factual_contract_end_date,'YYYY')='2017';

--��������� ��������,����������� � 2017 � 2018 ����
SELECT project_id id_�������, number_contract �����_��������,project_start_date ����_������_�������,factual_project_end_date �����������_����_���������_�������,project_cost ���������_�������,SUM(project_cost) OVER() ���������_���������_�����������_�_2018_2019__����
FROM projects
WHERE TO_CHAR(project_start_date,'YYYY')>'2016' AND TO_CHAR(factual_project_end_date,'YYYY')<'2019';

--6.�������� ������ � ������������� ������������ �� ������ ������ ��� �� ��������� ��������� ����.
--������������� ������������ � ������ ���
SELECT eqpr.equipment_id id_������������,eq.number_equipment ����������_������������,eq.equipment_start_date ����_������_�������������, eq.equipment_end_date ����_���������_�������������
FROM equipment_project eqpr
INNER JOIN equipment eq ON eqpr.equipment_id = eq.equipment_id
WHERE TO_CHAR(eq.equipment_start_date,'YYYY')>'2014';

--7.�������� �������� �� ������������� ������������ ���������� ��������� (����������).
SELECT proj.project_id id_�������,eqpr.equipment_id id_������������,eq.number_equipment ����������_������������,eq.equipment_start_date ����_������_�������������, eq.equipment_end_date ����_���������_�������������
FROM projects proj
INNER JOIN equipment_project eqpr ON proj.project_id =eqpr.equipment_id
INNER JOIN equipment eq ON eqpr.equipment_id = eq.equipment_id;

--8.�������� �������� �� ������� ���������� ���������� ��� ��������� ����������� � �������� (���������) �� ������������ ������ �������
--�������� �� ������� ���������� ���������� � ������� � 2016 ����
SELECT emp.first_name �������_����������,emp.last_name ���_����������,projmem.start_date ����_������_�������,projmem.end_date ����_���������_�������, projmem.project_role ����_���������_�_�������
FROM employee emp
INNER JOIN project_member projmem ON emp.employee_id = projmem.employee_id
WHERE TO_CHAR(projmem.start_date,'YYYY')='2016';

--�������� �� ������� ��������� �����������(����������_�����) � �������� �� ������������ ������ �������(����� 2018 ����)
SELECT emp.employee_category ���������_����������,emp.first_name �������_����������,emp.last_name ���_�����������,projmem.start_date ����_������_�������,projmem.end_date ����_���������_�������
FROM employee emp
INNER JOIN project_member projmem ON emp.employee_id = projmem.employee_id
WHERE emp.employee_category = '���������� �����' AND TO_CHAR(projmem.start_date,'MM')>'08' AND TO_CHAR(projmem.start_date,'YYYY')='2018' AND TO_CHAR(projmem.end_date,'MM')<'12' AND TO_CHAR(projmem.end_date,'YYYY')='2018' ;

--9.�������� �������� � ��������� �����, ����������� ������������� �������������.
SELECT sub.subcontr_name ��������_�����������,subpr.service_name ��������_������,subpr.service_cost ���������_������,proj.project_id id_�������
FROM subcontr sub
INNER JOIN subcontr_project subpr ON sub.subcontr_id =subpr.subcontr_id
INNER JOIN projects proj ON proj.project_id = subpr.project_id; 

--10.�������� ������ � ����������� � ������� ����������� � ����� � �� ��������� ����������, ����������� � ��������� �������.
--��������� � �����
SELECT DISTINCT projmem.project_id id_�������,emp.first_name �������_����������,emp.last_name ���_����������,projmem.start_date ����_������_�������,projmem.end_date ����_���������_�������, projmem.project_role ����_���������_�_�������,COUNT(projmem.employee_id) OVER(PARTITION BY projmem.project_id) ����������_����������_�_������e
FROM project_member projmem 
INNER JOIN employee emp ON emp.employee_id =projmem.employee_id
ORDER BY projmem.project_id;

--�� ��������� ����������
SELECT DISTINCT projmem.project_id id_�������,emp.first_name �������_����������,emp.last_name ���_����������,projmem.start_date ����_������_�������,projmem.end_date ����_���������_�������, projmem.project_role ����_���������_�_�������,COUNT(projmem.employee_id) OVER(PARTITION BY projmem.project_id) ����������_����������_�_������e
FROM project_member projmem 
INNER JOIN employee emp ON emp.employee_id =projmem.employee_id
WHERE emp.employee_category = '���������� �����'
ORDER BY projmem.project_id;

--11.�������� ������ �� ������������� ������������� ������������ (������ ��������� �����, ����������� � �������������� ���� ��� ����� ������������).
SELECT DISTINCT proj.project_id id_�������,proj.project_cost ���������_�������,SUM(eq.number_equipment) OVER(PARTITION BY eq.equipment_id) ����������_������������_�_������e 
FROM equipment eq
INNER JOIN equipment_project eqpr ON eq.equipment_id=eqpr.equipment_id
INNER JOIN projects proj ON eqpr.project_id = proj.project_id
WHERE eqpr.project_id = proj.project_id;

--12.�������� �������� �� ������������� ��������� (��������� ��������� ������������ � ����������� �������� ��� ��������� � ������ ������������ ������� ��������).
--��������� � ������ ������������ ������� ��������
SELECT DISTINCT contr.total_cost ���������_��������,COUNT(projmem.employee_id) OVER(PARTITION BY projmem.project_id) ����������_����������_�_������e 
FROM project_member projmem
INNER JOIN projects proj ON projmem.project_id=proj.project_id
INNER JOIN contract contr ON proj.number_contract = contr.number_contract;

--13.�������� ������ � ����������� � ������� ����������� � ����� � �� ��������� ����������, ����������� � �������� �� ��������� ������ �������.
--��������� � �����, � 2017 ����
SELECT DISTINCT projmem.project_id id_�������,emp.first_name �������_����������,emp.last_name ���_����������,projmem.start_date ����_������_�������,projmem.end_date ����_���������_�������, projmem.project_role ����_���������_�_�������,COUNT(projmem.employee_id) OVER(PARTITION BY projmem.project_id) ����������_����������_�_������e
FROM project_member projmem 
INNER JOIN employee emp ON emp.employee_id =projmem.employee_id
WHERE TO_CHAR(projmem.start_date,'YYYY')='2017' AND TO_CHAR(projmem.end_date,'YYYY')='2017'
ORDER BY projmem.project_id;

--�� ��������� ����������, � 2017 ����
SELECT DISTINCT projmem.project_id id_�������,emp.first_name �������_����������,emp.last_name ���_����������,projmem.start_date ����_������_�������,projmem.end_date ����_���������_�������, projmem.project_role ����_���������_�_�������,COUNT(projmem.employee_id) OVER(PARTITION BY projmem.project_id) ����������_����������_�_������e
FROM project_member projmem 
INNER JOIN employee emp ON emp.employee_id =projmem.employee_id
WHERE emp.employee_category = '���������� �����' AND TO_CHAR(projmem.start_date,'YYYY')='2017' AND TO_CHAR(projmem.end_date,'YYYY')='2017'
ORDER BY projmem.project_id;

--14.�������� ������ � ����������� � ������� ����������� � ����� � �� ��������� ����������, ����������� � �������� �� ��������� ������ �������.
SELECT DISTINCT proj.project_cost ���������_��������,COUNT(projmem.employee_id) OVER(PARTITION BY projmem.project_id) ����������_����������_�_������e 
FROM project_member projmem
INNER JOIN projects proj ON projmem.project_id=proj.project_id
INNER JOIN contract contr ON proj.number_contract = contr.number_contract
ORDER BY proj.project_cost
 