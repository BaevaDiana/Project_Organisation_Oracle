--Черновик индивидуального задания

--------------------------------------------------------------------------------------------------------------------------------
--SQL-код создания БД 
--создание таблиц,создание последовательностей,заполненние БД тестовыми данными


--создание таблицы Должность
CREATE TABLE post
(
post_id NUMBER(5) PRIMARY KEY, --id_должности
job_title VARCHAR2(1000), --название должности
salary NUMBER(8,2), --заработная плата
department_id NUMBER(5) --id_отдела(внешний ключ, из таблицы Отдел)
);
--ограничения на таблицу Должность
ALTER TABLE post ADD CONSTRAINT salary CHECK(salary>0); --зарплата не может быть нулевой
ALTER TABLE post MODIFY (job_title not null); --название должности не пустое
--вставка значений
INSERT INTO post VALUES(10,'Инженер-конструктор',500000,101);
INSERT INTO post VALUES(15,'Инженер',450000,102);
INSERT INTO post VALUES(20,'Техник',400000,103);
INSERT INTO post VALUES(25,'Младшиц лаборант',300000,104);
INSERT INTO post VALUES(30,'Старший лаборант',400000,104);
INSERT INTO post VALUES(35,'Секретарь',20000,105);
INSERT INTO post VALUES(45,'Младший инженер',450000,101);
INSERT INTO post VALUES(50,'Инженер-планировщик',470000,102);
INSERT INTO post VALUES(55,'Младший техник',400000,103);
INSERT INTO post VALUES(60,'Бухгалтер',50000,105);


--создание таблицы Сотрудник
CREATE TABLE employee
(
employee_id NUMBER(5) PRIMARY KEY, --id_сотрудника
post_id NUMBER(5), --id_должности (внешний ключ, из таблицы Должность)
last_name VARCHAR2(1000), --фамилия
first_name VARCHAR2(1000),  -- имя
patronymic VARCHAR2(1000),  --отчество
date_of_birth DATE, --дата рождения
phone_number VARCHAR2(15), --номер телефона
email VARCHAR2(100),--электронная почта
employee_category VARCHAR2(1000), --категория 
hire_date DATE --дата начала работы в должности
);
ALTER TABLE employee ADD CONSTRAINT fk_post_id FOREIGN KEY(post_id) REFERENCES post(post_id); -- внешний ключ, в таблицу Сотрудник
--ограничения на таблицу Сотрудник
ALTER TABLE employee ADD CONSTRAINT phone_number CHECK (SUBSTR(phone_number,0,1)='+' AND LENGTH(phone_number)>10 AND LENGTH(phone_number)<13); -- номер телефона начинается с '+' и длина от 12 до 15 символов
ALTER TABLE employee MODIFY (first_name not null,last_name not null,patronymic not null, phone_number not null, email not null,employee_category not null); --непустые столбцы
--последовательность для таблицы Сотрудник(для id_сотрудника)
CREATE SEQUENCE employee_seq
    START WITH 1
    INCREMENT BY 1
    CACHE 20
    NOCYCLE;
--вставка значений
INSERT INTO employee VALUES(employee_seq.nextval,10,'Баев','Николай','Николаевич','01.01.1973','+79186760165','baev_nikolay@gmail.com','Конструкторский отдел','25.03.2009');
INSERT INTO employee VALUES(employee_seq.nextval,15,'Наумов','Николай','Александрович','16.02.1995','+79183364145','naumov_nikolay@gmail.com','Инженерный отдел','31.03.2013');
INSERT INTO employee VALUES(employee_seq.nextval,20,'Голубина','Галина','Викторовна','25.07.1982','+79251160132','golubina_galina@gmail.com','Отдел обслуживания оборудования','23.06.2018');
INSERT INTO employee VALUES(employee_seq.nextval,25,'Подставкин','Кирилл','Васильевич','03.03.1990','+79526764467','podstavkin_kirill@gmail.com','Лабораторный отдел','01.09.2005');
INSERT INTO employee VALUES(employee_seq.nextval,30,'Осипян','Алина','Николевна','06.05.2000','+79358640151','osipyan_alina@gmail.com','Лабораторный отдел','18.01.2000');
INSERT INTO employee VALUES(employee_seq.nextval,35,'Зубова','Елизавета','Алексеевна','15.09.2004','+79188778887','zybova_elizaveta@gmail.com','Отдел обслуживания персонала','15.10.2021');
INSERT INTO employee VALUES(employee_seq.nextval,45,'Шатохина','Наталья','Юрьевна','23.04.1985','+79188776336','shatohina_nataliya@gmail.com','Констукторский отдел','16.10.2000');
INSERT INTO employee VALUES(employee_seq.nextval,50,'Чалиян','Нина','Сергеевна','15.09.2000','+79361457801','chaliyan_nina@gmail.com','Инженерный отдел','01.10.2020');
INSERT INTO employee VALUES(employee_seq.nextval,55,'Юренко','Артём','Владимирович','22.06.2001','+79188778887','yrenko_artem@gmail.com','Отдел обслуживания оборудования','10.02.2016');
INSERT INTO employee VALUES(employee_seq.nextval,60,'Шатохин','Артём','Анатольевич','03.03.1989','+79188778887','shatohin_artem@gmail.com','Отдел обслуживания персонала','18.01.2019');


--создание таблицы Отдел
CREATE TABLE department
(
department_id NUMBER(5) PRIMARY KEY, --id_отдела
department_name VARCHAR2(1000), --название
department_head_id NUMBER(5) --id_главы_отдела
);
ALTER TABLE post ADD CONSTRAINT fk_department_id FOREIGN KEY(department_id) REFERENCES department(department_id); --внешний ключ,из таблицы Отдел, в таблицу Должность 
ALTER TABLE department ADD CONSTRAINT fk_department_head_id FOREIGN KEY(department_head_id) REFERENCES employee(employee_id); --внешний ключ,из таблицы Сотрудник
--ограничения на таблицу Отдел
ALTER TABLE department MODIFY (department_name not null); --название отдела не пустое
--вставка значений
INSERT INTO department VALUES(101,'Конструкторский отдел',1);
INSERT INTO department VALUES(102,'Инженерный отдел',2);
INSERT INTO department VALUES(103,'Отдел обслуживания оборудования',3);
INSERT INTO department VALUES(104,'Лабораторный отдел',5);
INSERT INTO department VALUES(105,'Отдел обслуживания персонала',6);


--создание таблицы История_работы_сотрудника
CREATE TABLE employee_history
(
employee_id NUMBER(5) PRIMARY KEY, --id_сотрудника
post_id NUMBER(5) REFERENCES post(post_id), --внешний ключ,из таблицы Должность
first_name VARCHAR2(1000), --имя
last_name VARCHAR2(1000),  -- фамилия
patronymic VARCHAR2(1000),  --отчество
phone_number VARCHAR2(15), --номер телефона
email VARCHAR2(100), --электронная почта
start_date DATE, --дата начала
end_date DATE, --дата окончания
last_modification VARCHAR2(1000) --последнее изменённое поле
);
ALTER TABLE employee_history ADD CONSTRAINT fk_employee_id FOREIGN KEY(employee_id) REFERENCES employee(employee_id); --внешний ключ,из таблицы Сотрудник
--ограничения на таблицу История_Сотрудника
ALTER TABLE employee_history ADD CONSTRAINT employee_history_phone_number CHECK (SUBSTR(phone_number,0,1)='+' AND LENGTH(phone_number)>12 AND LENGTH(phone_number)<16); -- номер телефона начинается с + и длина от 12 до 15 символов
ALTER TABLE employee_history MODIFY (first_name not null,last_name not null,patronymic not null, phone_number not null, email not null);--непустые столбцы


--создание таблицы Договор
CREATE TABLE contract
(
number_contract NUMBER(5) PRIMARY KEY, --номер договора
total_cost NUMBER(8,2), --общая стоимость услуг
contract_start_date DATE, --дата заключения 
guess_contract_end_date DATE, -- предполагаемая дата завершения 
factual_contract_end_date DATE -- фактическая дата завершения
);
--ограничения на таблицу Договор
ALTER TABLE contract ADD CONSTRAINT total_cost CHECK(total_cost>0); --общая стоимость услуг не 0
ALTER TABLE contract ADD CONSTRAINT contract_date CHECK(TO_CHAR(contract_start_date)!=TO_CHAR(guess_contract_end_date) AND TO_CHAR(contract_start_date)!=TO_CHAR(factual_contract_end_date)); --дата заключения и даты завершения договора не являются одним днем
--последовательность для таблицы Договор(для номера_договора)
CREATE SEQUENCE contract_seq
    START WITH 1
    INCREMENT BY 1
    CACHE 20 
    NOCYCLE;
--вставка значений
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


--создание таблицы Проект
CREATE TABLE projects
(
project_id NUMBER(5) PRIMARY KEY, --id_проекта
number_contract NUMBER(5), --номер договора
project_manager_id NUMBER(5), --id_руководителя_проета
project_cost NUMBER(8,2), --стоимость проекта
project_start_date DATE, --дата начала проекта
guess_project_end_date DATE, -- предполагаемая дата окончания проекта
factual_project_end_date DATE --фактическая дата окончания проекта
);
ALTER TABLE projects ADD CONSTRAINT fk_number_contract FOREIGN KEY(number_contract) REFERENCES contract(number_contract); --внешний ключ,из таблицы Договор
ALTER TABLE projects ADD CONSTRAINT fk_project_manager_id FOREIGN KEY(project_manager_id) REFERENCES employee(employee_id); --внешний ключ,из таблицы Сотрудник
--ограничения на таблицу Проект
ALTER TABLE projects ADD CONSTRAINT project_cost CHECK(project_cost>0); --стоимость проекта не нулевая
ALTER TABLE projects ADD CONSTRAINT project_date CHECK( TO_CHAR(project_start_date)!=TO_CHAR(guess_project_end_date) AND TO_CHAR(project_start_date)!=TO_CHAR(factual_project_end_date)); --дата начала и даты окончания проекта не являются одним днем
--последовательность для таблицы Проект(для id_проекта)
CREATE SEQUENCE project_seq
    START WITH 1
    INCREMENT BY 1
    CACHE 20 
    NOCYCLE;
--вставка значений
INSERT INTO projects VALUES(project_seq.nextval,1,1,40000,'01.06.2015','01.08.2017','01.08.2017');
INSERT INTO projects VALUES(project_seq.nextval,1,1,60000,'01.06.2016','01.08.2016','01.08.2016');
INSERT INTO projects VALUES(project_seq.nextval,2,2,50000,'20.01.2017','27.02.2017','20.02.2017');
INSERT INTO projects VALUES(project_seq.nextval,4,3,200000,'04.08.2017','04.03.2018','02.03.2018');
INSERT INTO projects VALUES(project_seq.nextval,4,3,700000,'05.03.2018','02.08.2018','01.08.2018');
INSERT INTO projects VALUES(project_seq.nextval,3,1,500000,'01.09.2018','20.09.2018','15.09.2018');


--создание таблицы Участиник_проекта
CREATE TABLE project_member 
(
employee_id NUMBER(5) REFERENCES employee(employee_id), --id_сотрудника(внешний ключ, из таблицы Сотрудник)
project_id NUMBER(5) REFERENCES projects(project_id), --id_проекта(внешний ключ, из таблицы Проект)
start_date DATE, --дата начала участия 
end_date DATE, --дата окончания участия
project_role VARCHAR2(100) -- роль участника в проекте
);
--создание составного первичного ключа
ALTER TABLE project_member ADD CONSTRAINT pk_project_member PRIMARY KEY(employee_id,project_id);
--ограничения на таблице Участник_проекта
ALTER TABLE project_member ADD CONSTRAINT s_e_date CHECK(TO_CHAR(start_date)!=TO_CHAR(end_date)); --дата начала и дата конца участия не совпадают
ALTER TABLE project_member MODIFY (project_role not null); --роль участника не пустая
--вставка значений
INSERT INTO project_member VALUES(8,1,'01.06.2015','01.08.2017','Инженер проекта');
INSERT INTO project_member VALUES(9,2,'01.06.2016','01.08.2016','Техник проекта');
INSERT INTO project_member VALUES(7,3,'20.01.2017','20.02.2017','Инженер проекта');
INSERT INTO project_member VALUES(1,1,'01.06.2015','01.08.2017','Руводитель проекта');
INSERT INTO project_member VALUES(1,2,'01.06.2016','01.08.2016','Руководитель проекта');
INSERT INTO project_member VALUES(2,3,'20.01.2017','20.02.2017','Рукводитель проекта');
INSERT INTO project_member VALUES(3,4,'04.08.2017','02.03.2018','Рукводитель проекта');
INSERT INTO project_member VALUES(3,5,'05.03.2018','02.08.2018','Рукводитель проекта');
INSERT INTO project_member VALUES(1,6,'02.03.2017','08.07.2017','Рукводитель проекта');


--создание таблицы Оборудование
CREATE TABLE equipment
(
equipment_id NUMBER(5) PRIMARY KEY, --id_оборудования
department_id NUMBER(5) REFERENCES department(department_id), --внешний ключ, из таблицы Отдел
number_equipment NUMBER(7,-2), --количество 
equipment_start_date DATE, --дата начала использования 
equipment_end_date DATE -- дата окончания использования
);
--ограничения на таблицу Оборудование
ALTER TABLE equipment ADD CONSTRAINT number_equipment CHECK(number_equipment>0); --количество оборудования не нулевое
ALTER TABLE equipment ADD CONSTRAINT equipment_date CHECK( TO_CHAR(equipment_start_date)!=TO_CHAR(equipment_end_date)); --дата начала и даты конца использования не являются одним днем
--последовательность для таблицы Оборудование(для id_оборудования)
CREATE SEQUENCE equipment_seq
    START WITH 1
    INCREMENT BY 1
    CACHE 20 
    NOCYCLE; 
--вставка значений
INSERT INTO equipment VALUES(equipment_seq.nextval,102,50,'01.01.2018','01.03.2018');
INSERT INTO equipment VALUES(equipment_seq.nextval,103,100,'10.03.2018','10.04.2018');
INSERT INTO equipment VALUES(equipment_seq.nextval,104,1000,'15.04.2017','22.04.2017');


--создание таблицы Оборудование_в_проекте
CREATE TABLE equipment_project
(
equipment_id NUMBER(5) REFERENCES equipment(equipment_id) , --id_оборудования(внешний ключ, из таблицы Оборудование)
project_id NUMBER(5) REFERENCES projects(project_id) --id_проекта(внешний ключ, из таблицы Проект)
);
--создание первичного ключа
ALTER TABLE equipment_project ADD CONSTRAINT pk_equipment_project PRIMARY KEY(equipment_id,project_id);
--вставка значений
INSERT INTO equipment_project VALUES(1,4);
INSERT INTO equipment_project VALUES(2,5);
INSERT INTO equipment_project VALUES(3,6);


--создание таблицы Субподрядные_организации
CREATE TABLE subcontr
(
subcontr_id NUMBER(5) PRIMARY KEY, --id_субподрядной_организации
subcontr_name VARCHAR2(1000), --название
INN VARCHAR2(10), --ИНН
subcontr_phone_number VARCHAR2(15), --телефон
subcontr_head VARCHAR2(1000) --руководитель(фамилия и инициалы)
);
--ограничения на таблицу Субподрядные_организации
ALTER TABLE subcontr ADD CONSTRAINT subcontr_phone_number CHECK (SUBSTR(subcontr_phone_number,0,1)='+' AND LENGTH(subcontr_phone_number)>10 AND LENGTH(subcontr_phone_number)<13); -- номер телефона начинается с + и длина от 12 
ALTER TABLE subcontr ADD CONSTRAINT inn_check CHECK(LENGTH(INN)>0 AND LENGTH(INN)<11); --ИНН состоит из 10 символов
ALTER TABLE subcontr MODIFY(subcontr_name not null,subcontr_head not null); --непустые столбцы
--последовательность для таблицы Субподрядные_организации(для id_субподрядной_организации)
CREATE SEQUENCE subcontr_seq
    START WITH 1
    INCREMENT BY 1
    CACHE 20 
    NOCYCLE; 
--вставка значений
INSERT INTO subcontr VALUES(subcontr_seq.nextval,'Компьютер-Сити','1234567890','+79081234567','Езубов Е.А.');
INSERT INTO subcontr VALUES(subcontr_seq.nextval,'Флорентина','1834178906','+79524817890','Мартыненко В.Г.');
INSERT INTO subcontr VALUES(subcontr_seq.nextval,'ЛККЗ','7530168555','+7908168555','Полякова Т.В.');

--создание таблицы Субподрядные_организации_в_проекте
CREATE TABLE subcontr_project
(
subcontr_id NUMBER(5) REFERENCES subcontr(subcontr_id) , --id_субподрядной_организации(внешний ключ, из таблицы Субподрядные_организации)
project_id NUMBER(5) REFERENCES projects(project_id), --id_проекта(внешний ключ, из таблицы Проект)
service_name VARCHAR2(1000), --название услуги
service_cost NUMBER(8,2) --стоимость
);
--создание первичного ключа
ALTER TABLE subcontr_project ADD CONSTRAINT pk_subcontr_project PRIMARY KEY(subcontr_id,project_id);
--ограничения на таблицу Субподрядные_организации_в_проекте
ALTER TABLE subcontr_project ADD CONSTRAINT service_cost_check CHECK(service_cost>0); --стоимость услуги не нулевая
ALTER TABLE subcontr_project MODIFY(service_name not null); --непустые столбцы
DROP SEQUENCE service_seq;
--вставка значений
INSERT INTO subcontr_project VALUES(1,3,'аренда свободного сервера',50000);
INSERT INTO subcontr_project VALUES(2,1,'услуги квалифицированного эксперта',100000);
INSERT INTO subcontr_project VALUES(3,1,'предоставление лабораторного оборудования',200000);


-------------------------------------------------------------------------------------------------------------------------------
----------Тригеры---------------------------------------------------------------------------------------------------------------

--процедура для тригера
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
--тригер
--изменение в таблице Сотрудник приводит к добавлении записи в таблицу История_Сотрудника
CREATE OR REPLACE TRIGGER update_employee_history
  AFTER UPDATE ON employee
  FOR EACH ROW
BEGIN
  add_employee_history(:old.employee_id,:old.post_id,:old.first_name,:old.last_name,:old.patronymic,:old.phone_number,:old.email,:old.hire_date,sysdate,:old.last_modification);
END;

----------функции---------------------------------------------------------------------------------------------------------------

-- функция, которая возвращает id_проектов, которые указаны в рамках указанного договора, номер которого является аргументом
--данная функция будем использоваться в дальнейшем для запроса к БД
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

--функция, которая возвращает id_оборудования, которое используется в указанном проекте(аргумент - id_проекта)
--данная функция будем использоваться в дальнейшем для запроса к БД
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

--функция, которая возвращает id_проектах, в который он участвовал(аргумент - id_сотрудника)
--данная функция будем использоваться в дальнейшем для запроса к БД
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


----------джобсы----------------------------------------------------------------------------------------------------------------
--процедура по удалению из таблицы История_работы_сотрудника тех записей, которые хранятся более 25 лет 
CREATE OR REPLACE PROCEDURE delete_old_inform
 IS 

BEGIN 
  DELETE FROM employee_history
  WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, end_date)/12)>25;
  COMMIT; 
  CLOSE; 

--задание будет запускаться раз в году 1 декабря
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name          =>  'historic_job',
   job_action        =>  'for_job'	, 
   repeat_interval   =>  'FREQ=YEARLY;BYMONTH=DEC;BYMONTHDAY=1',
   comments          =>  'Once a year December 1');
END;    


--------------------------------------------------------------------------------------------------------------------------------
--запросы к БД

--1.Получить данные о составе указанного отдела или всей организации полностью, по указанной категории сотрудников, по возрастному составу.
--данные о составе указанного отдела по возрастному составу
SELECT dep.department_name Название_отдела, emp.first_name Имя, emp.last_name Фамилия,emp.patronymic Отчество, TRUNC(MONTHS_BETWEEN(SYSDATE, date_of_birth)/12) Возраст
FROM employee emp
INNER JOIN post ps ON emp.post_id = ps.post_id
INNER JOIN department dep ON ps.department_id = dep.department_id;

--данные о составе указанного отдела по указанной категории сотрудников
SELECT dep.department_name, emp.first_name Имя, emp.last_name Фамилия,emp.patronymic Отчество, emp.employee_category Категория_сотрудника
FROM employee emp
INNER JOIN post ps ON emp.post_id = ps.post_id
INNER JOIN department dep ON ps.department_id = dep.department_id
WHERE emp.employee_category = 'Инженерный отдел';

--данные о составе всей организации полностью по возрастному составу
SELECT emp.first_name Имя, emp.last_name Фамилия,emp.patronymic Отчество,emp.phone_number Номер_телефона, emp.email Электронна_почта, emp.employee_category Категория_сотрудника, TRUNC(MONTHS_BETWEEN(SYSDATE, date_of_birth)/12) Возраст
FROM employee emp;

----данные о составе всей организации полностью по указанной категории сотрудника
SELECT emp.first_name Имя, emp.last_name Фамилия,emp.patronymic Отчество,emp.phone_number Номер_телефона, emp.email Электронна_почта, emp.employee_category Категория_сотрудника
FROM employee emp;

--2.Получить перечень руководителей отделов.
SELECT emp.first_name Имя,emp.last_name Фамилия,emp.patronymic Отчество,dep.department_name Название_отдела
FROM department dep 
INNER JOIN employee emp ON dep.department_head_id = emp.employee_id;

--3.Получить перечень договоров или проектов, выполняемых в данный момент или в период указанного интервала времени.
--перечень договоров, которые были заключены и завершены в 2017 году
SELECT contr.number_contract Номер_договора,contr.total_cost Общая_стоимость_услуг,contr.contract_start_date Дата_заключения_договора, contr.factual_contract_end_date Фактическая_дата_завершения_довогора
FROM contract contr
WHERE TO_CHAR(contr.contract_start_date,'YYYY')='2017' AND TO_CHAR(contr.factual_contract_end_date,'YYYY')='2017';

--перечень проектов, которые выполнялись в 2018 году
SELECT proj.number_contract Номер_договора,emp.first_name Имя_руководителя_проекта, emp.last_name Фамилия_руководителя_проекта,proj.project_start_date Дата_начала_проекта,proj.factual_project_end_date Фактическая_дата_окончания_проекта
FROM projects proj
INNER JOIN employee emp ON proj.project_manager_id = emp.employee_id
WHERE TO_CHAR(proj.project_start_date,'YYYY')='2018' OR TO_CHAR(proj.factual_project_end_date,'YYYY')='2018';

--4.Получить информацию о том, какие проекты выполняются (выполнялись) в рамках указанного договора и какие договоры поддерживаются указанными проектами.
--какие проекты выполнялись в рамках указанного договора
SELECT contr.number_contract Номер_договора,contr.contract_start_date Дата_заключения_договора, contr.factual_contract_end_date Фактическая_дата_завершения_довогора,proj.project_id ID_проекта,proj.project_start_date Дата_начала_проекта,proj.factual_project_end_date Фактическая_дата_окончания_проекта,emp.first_name Имя_руководителя_проекта, emp.last_name Фамилия_руководителя_проекта
FROM contract contr
INNER JOIN projects proj ON contr.number_contract = proj.number_contract
INNER JOIN employee emp ON proj.project_manager_id = emp.employee_id;

--какие договоры поддерживаются указанными проетами
SELECT proj.project_id ID_проекта,proj.project_start_date Дата_начала_проекта,proj.factual_project_end_date Фактическая_дата_окончания_проекта,contr.number_contract Номер_договора,contr.contract_start_date Дата_заключения_договора, contr.factual_contract_end_date Фактическая_дата_завершения_довогора
FROM projects proj
INNER JOIN contract contr ON  proj.number_contract = contr.number_contract;

--5.Получить данные о стоимости выполненных договоров (проектов) в течение указанного периода времени.
--стоимость выполнненых договоров в 2017 году
SELECT number_contract Номер_договора, total_cost Стоимость_договора,SUM(total_cost) OVER() Стоимость_договоров_выполненных_в_2017_году
FROM contract
WHERE TO_CHAR(contract_start_date,'YYYY')='2017' AND TO_CHAR(factual_contract_end_date,'YYYY')='2017';

--стоимость проектов,выполненных в 2017 и 2018 году
SELECT project_id id_проекта, number_contract Номер_договора,project_start_date Дата_начала_проекта,factual_project_end_date Фактическая_дата_окончания_проекта,project_cost Стоимость_проекта,SUM(project_cost) OVER() Стоимость_договоров_выполненных_в_2018_2019__году
FROM projects
WHERE TO_CHAR(project_start_date,'YYYY')>'2016' AND TO_CHAR(factual_project_end_date,'YYYY')<'2019';

--6.Получить данные о распределении оборудования на данный момент или на некоторую указанную дату.
--распределение оборудования в каждый год
SELECT eqpr.equipment_id id_оборудования,eq.number_equipment Количество_оборудования,eq.equipment_start_date Дата_начала_использования, eq.equipment_end_date Дата_окончания_использования
FROM equipment_project eqpr
INNER JOIN equipment eq ON eqpr.equipment_id = eq.equipment_id
WHERE TO_CHAR(eq.equipment_start_date,'YYYY')>'2014';

--7.Получить сведения об использовании оборудования указанными проектами (договорами).
SELECT proj.project_id id_проекта,eqpr.equipment_id id_оборудования,eq.number_equipment Количество_оборудования,eq.equipment_start_date Дата_начала_использования, eq.equipment_end_date Дата_окончания_использования
FROM projects proj
INNER JOIN equipment_project eqpr ON proj.project_id =eqpr.equipment_id
INNER JOIN equipment eq ON eqpr.equipment_id = eq.equipment_id;

--8.Получить сведения об участии указанного сотрудника или категории сотрудников в проектах (договорах) за определенный период времени
--сведения об участии указанного сотрудника в проекте в 2016 году
SELECT emp.first_name Фамилия_сотрудника,emp.last_name Имя_сотрудника,projmem.start_date Дата_начала_участия,projmem.end_date Дата_окончания_участия, projmem.project_role Роль_участника_в_проекте
FROM employee emp
INNER JOIN project_member projmem ON emp.employee_id = projmem.employee_id
WHERE TO_CHAR(projmem.start_date,'YYYY')='2016';

--сведения об участии категории сотрудников(Инженерный_отдел) в проектах за определенный период времени(осень 2018 года)
SELECT emp.employee_category Категория_сотрудника,emp.first_name Фамилия_сотрудника,emp.last_name Имя_сотррудника,projmem.start_date Дата_начала_участия,projmem.end_date Дата_окончания_участия
FROM employee emp
INNER JOIN project_member projmem ON emp.employee_id = projmem.employee_id
WHERE emp.employee_category = 'Инженерный отдел' AND TO_CHAR(projmem.start_date,'MM')>'08' AND TO_CHAR(projmem.start_date,'YYYY')='2018' AND TO_CHAR(projmem.end_date,'MM')<'12' AND TO_CHAR(projmem.end_date,'YYYY')='2018' ;

--9.Получить перечень и стоимость работ, выполненных субподрядными организациями.
SELECT sub.subcontr_name Название_организации,subpr.service_name Название_услуги,subpr.service_cost Стоимость_услуги,proj.project_id id_проекта
FROM subcontr sub
INNER JOIN subcontr_project subpr ON sub.subcontr_id =subpr.subcontr_id
INNER JOIN projects proj ON proj.project_id = subpr.project_id; 

--10.Получить данные о численности и составе сотрудников в целом и по отдельным категориям, участвующим в указанном проекте.
--сотрудник в целом
SELECT DISTINCT projmem.project_id id_проекта,emp.first_name Фамилия_сотрудника,emp.last_name Имя_сотрудника,projmem.start_date Дата_начала_участия,projmem.end_date Дата_окончания_участия, projmem.project_role Роль_участника_в_проекте,COUNT(projmem.employee_id) OVER(PARTITION BY projmem.project_id) Количество_участников_в_проектe
FROM project_member projmem 
INNER JOIN employee emp ON emp.employee_id =projmem.employee_id
ORDER BY projmem.project_id;

--по отдельным категориям
SELECT DISTINCT projmem.project_id id_проекта,emp.first_name Фамилия_сотрудника,emp.last_name Имя_сотрудника,projmem.start_date Дата_начала_участия,projmem.end_date Дата_окончания_участия, projmem.project_role Роль_участника_в_проекте,COUNT(projmem.employee_id) OVER(PARTITION BY projmem.project_id) Количество_участников_в_проектe
FROM project_member projmem 
INNER JOIN employee emp ON emp.employee_id =projmem.employee_id
WHERE emp.employee_category = 'Инженерный отдел'
ORDER BY projmem.project_id;

--11.Получить данные об эффективности использования оборудования (объемы проектных работ, выполненных с использованием того или иного оборудования).
SELECT DISTINCT proj.project_id id_проекта,proj.project_cost Стоимость_проекта,SUM(eq.number_equipment) OVER(PARTITION BY eq.equipment_id) Количество_оборудования_в_проектe 
FROM equipment eq
INNER JOIN equipment_project eqpr ON eq.equipment_id=eqpr.equipment_id
INNER JOIN projects proj ON eqpr.project_id = proj.project_id
WHERE eqpr.project_id = proj.project_id;

--12.Получить сведения об эффективности договоров (стоимость договоров соотнесенная с затраченным временем или стоимость с учетом привлеченных людских ресурсов).
--стоимость с учетом привлеченных людских ресурсов
SELECT DISTINCT contr.total_cost Стоимость_договора,COUNT(projmem.employee_id) OVER(PARTITION BY projmem.project_id) Количество_участников_в_проектe 
FROM project_member projmem
INNER JOIN projects proj ON projmem.project_id=proj.project_id
INNER JOIN contract contr ON proj.number_contract = contr.number_contract;

--13.Получить данные о численности и составе сотрудников в целом и по отдельным категориям, участвующим в проектах за указанный период времени.
--сотрудник в целом, в 2017 году
SELECT DISTINCT projmem.project_id id_проекта,emp.first_name Фамилия_сотрудника,emp.last_name Имя_сотрудника,projmem.start_date Дата_начала_участия,projmem.end_date Дата_окончания_участия, projmem.project_role Роль_участника_в_проекте,COUNT(projmem.employee_id) OVER(PARTITION BY projmem.project_id) Количество_участников_в_проектe
FROM project_member projmem 
INNER JOIN employee emp ON emp.employee_id =projmem.employee_id
WHERE TO_CHAR(projmem.start_date,'YYYY')='2017' AND TO_CHAR(projmem.end_date,'YYYY')='2017'
ORDER BY projmem.project_id;

--по отдельным категориям, в 2017 году
SELECT DISTINCT projmem.project_id id_проекта,emp.first_name Фамилия_сотрудника,emp.last_name Имя_сотрудника,projmem.start_date Дата_начала_участия,projmem.end_date Дата_окончания_участия, projmem.project_role Роль_участника_в_проекте,COUNT(projmem.employee_id) OVER(PARTITION BY projmem.project_id) Количество_участников_в_проектe
FROM project_member projmem 
INNER JOIN employee emp ON emp.employee_id =projmem.employee_id
WHERE emp.employee_category = 'Инженерный отдел' AND TO_CHAR(projmem.start_date,'YYYY')='2017' AND TO_CHAR(projmem.end_date,'YYYY')='2017'
ORDER BY projmem.project_id;

--14.Получить данные о численности и составе сотрудников в целом и по отдельным категориям, участвующим в проектах за указанный период времени.
SELECT DISTINCT proj.project_cost Стоимость_договора,COUNT(projmem.employee_id) OVER(PARTITION BY projmem.project_id) Количество_участников_в_проектe 
FROM project_member projmem
INNER JOIN projects proj ON projmem.project_id=proj.project_id
INNER JOIN contract contr ON proj.number_contract = contr.number_contract
ORDER BY proj.project_cost
 