from db import db_api


def menu():
    print(
        "========================= Menu ==========================",
        "1. Запуск DDL-скрипта;          9. Запуск задания 9;",
        "2. Запуск скрипта с данными;    10. Запуск задания 10;",
        "3. Запуск задания 3;            11. Запуск задания 11;",
        "4. Запуск задания 4;            0. Завершение работы.",
        sep='\n'
    )


def switcher(y: int, db):
    if y == 1:
        db.execute_script('scripts/ddl.sql')
    elif y == 2:
        db.execute_script('scripts/script.sql')
    elif y == 3:
        db.execute_script('scripts/script2.sql')
    elif y == 4:
        db.dep_accounts_without_credits()
    elif y == 9:
        db.close_products()
    elif y == 10:
        db.close_non_active_product_type()
    elif y == 11:
        db.execute_script('scripts/script11.sql')
    elif y == 0:
        print("Завершение работы..")
    else:
        print("Выбрано неподходящее значение!")


host = input("Введите host: ")
user = input("Введите user: ")
port = input("Введите port: ")
password = input("Введите password: ")
dbname = input("Введите название бд для ее создания: ")

db = db_api.DataBase(host, user, port, password, dbname)

y = -1
menu()
while y != 0:
    y = int(input("Выберите номер: "))
    switcher(y, db)
