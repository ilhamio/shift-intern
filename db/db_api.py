import psycopg2 as ps
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT


class DataBase:

    def __init__(self, host, user, port, password, dbname):
        '''
        Конструктор
        :param host: хост
        :param user: имя пользователя
        :param port: порт подключения
        :param password: пароль
        :param dbname: имя базы данных
        '''
        self._host = host
        self._user = user
        self._port = port
        self._password = password
        self._dbname = dbname

        try:
            conn = ps.connect(user=user, password=password, host=host, port=port)
            conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
            cursor = conn.cursor()
            req = f"CREATE DATABASE \"{dbname}\" WITH OWNER = postgres  ENCODING = 'UTF8' CONNECTION LIMIT = -1;"
            cursor.execute(req)
            cursor.close()
            conn.close()
        except Exception as err:
            print("Возникла ошибка при создании базы данных: ", err)

        try:
            self._connection = ps.connect(user=user, password=password, host=host, port=port, dbname=dbname)
            self._cursor = self._connection.cursor()
        except Exception as err:
            print(f"Возникла ошибка при подключении к базе данных {dbname}: ", err)

    def execute_script(self, file):
        '''
        Задания №1,2,3: Запуск скриптов с помощью файла
        :param file: название файла
        :return:
        '''
        try:
            with self._connection:
                req = open(file, "r", encoding='UTF-8').read()
                self._cursor.execute(req)
        except Exception as err:
            print("Возникла ошибка при запуске скрипта: ", err)

    def dep_accounts_without_credits(self):
        '''
        Задание №4: Сформируйте отчет, который содержит все счета, относящиеся к продуктам типа ДЕПОЗИТ,
        принадлежащих клиентам, у которых нет открытых продуктов типа КРЕДИТ.
        :return:
        '''
        try:
            with self._connection:
                req = '''SELECT A.* FROM ACCOUNTS A LEFT JOIN PRODUCTS P ON A.PRODUCT_REF=P.ID
                            WHERE P.PRODUCT_TYPE_ID=2 AND P.CLIENT_REF NOT IN (
                                SELECT P.CLIENT_REF FROM PRODUCTS P WHERE (
                                    P.PRODUCT_TYPE_ID=1 AND P.CLOSE_DATE IS NULL
                                ) 
                            );'''
                self._cursor.execute(req)
                result = self._cursor.fetchall()
                for i in result:
                    print(i)
        except Exception as err:
            print("Возникла ошибка при выполнении команды: ", err)

    def close_products(self):
        '''
        Задание №9: Закройте продукты (установите дату закрытия равную текущей) типа КРЕДИТ,
        у которых произошло полное погашение, но при этом не было повторной выдачи.
        :return:
        '''
        try:
            with self._connection:
                req = '''UPDATE PRODUCTS p
                        SET close_date=current_date FROM ACCOUNTS a RIGHT JOIN RECORDS r ON a.id=r.acc_ref 
                        WHERE p.product_type_id=1 AND a.saldo=0 AND p.id=a.product_ref
                        '''
                self._cursor.execute(req)
                print("Операция закрытия продуктов выполнена!")
        except Exception as err:
            print("Возникла ошибка при выполнении команды: ", err)

    def close_non_active_product_type(self):
        '''
        Задание №10: Закройте возможность открытия (установите дату окончания действия) для типов продуктов,
        по счетам продуктов которых, не было движений более одного месяца.
        :return:
        '''
        try:
            with self._connection:
                req = '''BEGIN;
                UPDATE PRODUCT_TYPE t
                        SET end_date=current_date
                        WHERE (SELECT max(r.oper_date) FROM PRODUCTS p LEFT JOIN ACCOUNTS a ON a.product_ref=p.id 
	                    LEFT JOIN RECORDS r ON r.acc_ref=a.id 
	                    WHERE p.product_type_id=t.id) < date_trunc('month', current_date - interval '1' month);
	                    COMMIT;
                '''
                self._cursor.execute(req)
                print("Операция закрытия неактивных типов продуктов выполнена!")
        except Exception as err:
            print("Возникла ошибка при выполнении команды: ", err)

    def add_contract_sum(self):
        '''
        Задание №11: В модель данных добавьте сумму договора по продукту. Заполните поле для всех продуктов суммой
        максимальной дебетовой операции по счету для продукта типа КРЕДИТ, и суммой максимальной кредитовой операции
        счету продукта для продукта типа ДЕПОЗИТ или КАРТА
        :return:
        '''
        try:
            with self._connection:
                req = '''ALTER TABLE PRODUCTS ADD COLUMN cont_sum numeric;
                        UPDATE PRODUCTS p
                        SET cont_sum=(SELECT max(r.sum) FROM ACCOUNTS a LEFT JOIN RECORDS r ON a.id=r.acc_ref 
                        where a.product_ref=p.id and r.dt=false) WHERE product_type_id=1;
                        UPDATE PRODUCTS p
                        SET cont_sum=(SELECT max(r.sum) FROM ACCOUNTS a LEFT JOIN RECORDS r ON a.id=r.acc_ref 
                        where a.product_ref=p.id and r.dt=true) WHERE product_type_id!=1;
                    '''
            self._cursor.execute(req)
            print("Операция выполнена успешно!")
        except Exception as err:
            print("Возникла ошибка при выполнении команды: ", err)