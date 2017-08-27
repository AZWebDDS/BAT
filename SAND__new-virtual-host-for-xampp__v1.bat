@echo off
chcp 65001
cls

echo.
echo Hello World!
echo.
echo Создание нового виртуального (локального) хоста
echo для локального сервера XAMPP
echo -----------------------------------------------
echo.

pause

echo.
echo Введите правильное ИМЯ создаваемого локального хоста
echo (например my-new-host.loc)
echo.

set /p NEW_HOST_NAME=

echo.
echo =============================================================
echo Вами указан виртуальный хост: %NEW_HOST_NAME%
echo Все верно? Можно продолжить? y (если "Да") или n (если "Нет")
echo =============================================================
echo.

choice /M "Выбрать ..." 

if %ERRORLEVEL% == 1 (

	echo Будем выполнять скрипт ...

	rem создать рабочий каталог
	md e:\www\2017\SANDBOX\%NEW_HOST_NAME%

	rem создать в рабочем каталоге файл index.php
	rem и записать в созданный файл какую-то информацию

	pause

	@echo ^<?php > e:\www\2017\SANDBOX\%NEW_HOST_NAME%\index.php
	@echo echo "<h1>Hello World!</h1>"; >> e:\www\2017\SANDBOX\%NEW_HOST_NAME%\index.php
	@echo echo "<div style='color: green'>Ваш новый локальный хост (сайт) %NEW_HOST_NAME% готов!</div>"; >> e:\www\2017\SANDBOX\%NEW_HOST_NAME%\index.php
	rem @echo . >> e:\www\2017\SANDBOX\%NEW_HOST_NAME%\index.php
	rem @echo phpinfo(); >> e:\www\2017\SANDBOX\%NEW_HOST_NAME%\index.php
	rem @echo . >> e:\www\2017\SANDBOX\%NEW_HOST_NAME%\index.php
	rem @echo ?^> >> e:\www\2017\SANDBOX\%NEW_HOST_NAME%\index.php


	rem создать в каталоге Apache в файле виртуального хоста httpd-vhosts.conf новый виртуальный хост (сайт)
	set /p V_HOST_FILE=



	pause

	) else (

	echo.
	echo Тупо облом
	echo Выход из программы ...
	echo.

	pause

	)


