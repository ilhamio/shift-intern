BEGIN;

insert into clients values (4, 'Алиев Ильхам Рамисович', 'Россия, Москва', to_date('15.06.2002','DD.MM.YYYY'), 'Россия, г.Москва, ул. Пушкина, д. 36', '1414 444322, выдан ОВД г. Москва, 10.01.2016');
insert into clients values (5, 'Мирный Павел Петрович', 'Россия, Московская облать, г. Клин', to_date('20.02.2000','DD.MM.YYYY'), 'Россия, Московская облать, г. Клин, ул. Мясникова, д. 3', '3525 6624226, выдан ОВД г. Клин, 10.01.2014');
insert into clients values (6, 'Пушной Александр Владимирович', 'Россия, Московская облать, г. Балашиха', to_date('12.01.1999','DD.MM.YYYY'), 'Россия, Московская облать, г. Балашиха, ул. Пушкина, д. 7', '4444 666666, выдан ОВД г. Клин, 10.01.2013');


insert into products values (4, 1, 'Кредитный договор с Алиевым И.Р.', 4, to_date('01.06.2018','DD.MM.YYYY'), to_date('01.06.2019','DD.MM.YYYY'));
insert into products values (5, 1, 'Кредитный договор с Мирным П.П.', 5, to_date('01.08.2017','DD.MM.YYYY'), null);
insert into products values (6, 2, 'Депозитный договор с Алиевым И.Р.', 4, to_date('01.08.2017','DD.MM.YYYY'), null);
insert into products values (7, 2, 'Депозитный договор с Пушным А.В.', 6, to_date('01.08.2017','DD.MM.YYYY'), null);
insert into products values (8, 1, 'Кредитный договор с Пушным А.В.', 6, to_date('01.08.2017','DD.MM.YYYY'), null);
insert into products values (9, 1, 'Кредитный договор с Алиевым И.Р.', 4, to_date('21.09.2019','DD.MM.YYYY'), null);

insert into accounts values (4, 'Кредитный счет для Алиева И.Р.', 0, 4, to_date('01.06.2018','DD.MM.YYYY'), null, 4, '45502810401020000022');
insert into accounts values (5, 'Кредитный счет для Мирного П.П.', 6000, 5, to_date('01.08.2017','DD.MM.YYYY'), null, 5, '42301810400000000001');
insert into accounts values (6, 'Депозитный счет для Алиева И.Р.', 8000, 4, to_date('01.08.2017','DD.MM.YYYY'), null, 6, '40817810700000000001');
insert into accounts values (7, 'Депозитный счет для Пушного А.В.', -2000, 6, to_date('01.06.2015','DD.MM.YYYY'), null, 7, '45502811401020000022');
insert into accounts values (8, 'Кредитный счет для Пушного А.В.', 6000, 6, to_date('01.08.2017','DD.MM.YYYY'), null, 8, '42301810400000000001');
insert into accounts values (9, 'Кредитный счет для Алиева И.Р.', 8000, 4, to_date('01.08.2017','DD.MM.YYYY'), null, 9, '40817810700000000001');

insert into records values (16, false, 1000, 6, to_date('12.01.2022', 'DD.MM.YYYY'));
insert into records values (17, true, 2000, 8, to_date('14.02.2023', 'DD.MM.YYYY'));

INSERT INTO CLIENTS VALUES(111, 'Соловьев Василий Пертович', 'Россия, Москва', to_date('12.11.2000', 'DD.MM.YYYY'), 'ул. Ленина 22', '1242 242444 выдан ОВД г.Москвы');
INSERT INTO PRODUCTS VALUES (111, 1, 'Кредитный договор c Соловьевым В.П.', 111, to_date('12.11.2020', 'DD.MM.YYYY'), null);
INSERT INTO ACCOUNTS VALUES(111, 'Кредитный счет для Соловьева В.П.', 0, 111, to_date('12.11.2020', 'DD.MM.YYYY'), null, 111, '42301810400023120001');
INSERT INTO RECORDS VALUES(111, true, 1000, 111, to_date('12.12.2020', 'DD.MM.YYYY'));
INSERT INTO RECORDS VALUES(112, false, 1000, 111, to_date('12.12.2020', 'DD.MM.YYYY'));
INSERT INTO CLIENTS VALUES(112, 'Васильев Андрей Максимович', 'Россия, Москва', to_date('12.11.2000', 'DD.MM.YYYY'), 'ул. 11-я Парковая 22', '1224 244444 выдан ОВД г. Москвы');
INSERT INTO PRODUCTS VALUES (112, 1, 'Кредитный договор с Васильевым А.М.', 112, to_date('12.11.2020', 'DD.MM.YYYY'), null);
INSERT INTO ACCOUNTS VALUES(112, 'Кредитный счет для Васильева А.М.', 0, 112, to_date('12.11.2020', 'DD.MM.YYYY'), null, 112, '42301810300023120001');
INSERT INTO RECORDS VALUES(113, true, 1000, 112, to_date('12.01.2022', 'DD.MM.YYYY'));
INSERT INTO RECORDS VALUES(114, false, 1000, 112, to_date('12.01.2022', 'DD.MM.YYYY'));
INSERT INTO RECORDS VALUES(115, true, 1000, 112, to_date('12.12.2020', 'DD.MM.YYYY'));
INSERT INTO RECORDS VALUES(116, false, 1000, 112, to_date('12.12.2020', 'DD.MM.YYYY'));

COMMIT;