@echo off
cls
chcp 65001

echo.
echo      Hello World!
echo.
echo      Скрипт для создания нового локального хоста (сайта) для сервера XAMPP
echo      начал работу .....
echo.
echo.

pause

:inputhost
cls
color 07
echo.
echo      Введите правильное ИМЯ создаваемого локального хоста
echo      (например my-new-host.loc)
echo.

set /p NEW_HOST_NAME=
set V_HOST_FILE=f:\2018\DevProg\XAMPP-717\apache\conf\extra\httpd-vhosts.conf
set HOSTS_WINFILE=c:\Windows\System32\drivers\etc\hosts
set NEW_HOST_DIR=e:\www\2017\SANDBOX\%NEW_HOST_NAME%

echo.
echo =============================================================
echo Вами указан виртуальный хост: %NEW_HOST_NAME%
echo Все верно? Можно продолжить? y (если "Да") или n (если "Нет")
echo =============================================================
echo.

choice /M "Выбрать ..." 

rem проверка на наличие такого же хоста
if exist %NEW_HOST_DIR% (
	cls
	echo. 
	echo.
	echo.
	echo.
	color 0C
	echo Такой хост уже существует!
	echo.
	pause
	goto inputhost
	)

echo.
echo Ваш выбор сделан.
echo Будет проведена проверка условий ...
echo.

pause

if %ERRORLEVEL% == 1 (

	echo.
	echo Все в порядке.
	echo Будем выполнять скрипт ...
	echo.

	pause

	rem создать рабочий каталог нового виртуального хоста [сайта]
	md e:\www\2017\SANDBOX\%NEW_HOST_NAME%

	rem создать в рабочем каталоге файл index.php и записать в него информацию
	@echo ^<?php > e:\www\2017\SANDBOX\%NEW_HOST_NAME%\index.php
	@echo echo "<h1>Hello World!</h1>"; >> e:\www\2017\SANDBOX\%NEW_HOST_NAME%\index.php
	@echo echo "<div style='color: green'>Ваш новый локальный хост (сайт) готов!</div>"; >> e:\www\2017\SANDBOX\%NEW_HOST_NAME%\index.php
	@echo echo "<div><a href='http://%NEW_HOST_NAME%'>http://%NEW_HOST_NAME%</a></div>"; >> e:\www\2017\SANDBOX\%NEW_HOST_NAME%\index.php
	@echo phpinfo(^); >> e:\www\2017\SANDBOX\%NEW_HOST_NAME%\index.php
	@echo ^?^> >> e:\www\2017\SANDBOX\%NEW_HOST_NAME%\index.php

	rem в каталоге Apache в файле виртуального хоста httpd-vhosts.conf создать новый виртуальный хост [сайт]
	@echo. >> %V_HOST_FILE%
	@echo. >> %V_HOST_FILE%
	@echo ^## Хост %NEW_HOST_NAME% >> %V_HOST_FILE%
	@echo ^#  >> %V_HOST_FILE%
	@echo ^<VirtualHost *:80^> >> %V_HOST_FILE%
	@echo     ServerAdmin azwebdds@gmail.com >> %V_HOST_FILE%
	@echo     DocumentRoot "e:\www\2017\SANDBOX\%NEW_HOST_NAME%" >> %V_HOST_FILE%
	@echo     ServerName %NEW_HOST_NAME% >> %V_HOST_FILE%
	@echo     ErrorLog "e:\www\2017\logs\xampp717\error.log" >> %V_HOST_FILE%
	@echo     CustomLog "e:\www\2017\logs\xampp717\access.log" common >> %V_HOST_FILE%
	@echo ^</VirtualHost^> >> %V_HOST_FILE%
	@echo ^<Directory "e:\www\2017\SANDBOX\%NEW_HOST_NAME%"^> >> %V_HOST_FILE%
	@echo     AllowOverride All >> %V_HOST_FILE%
	@echo     Require all granted >> %V_HOST_FILE%
	@echo ^</Directory^> >> %V_HOST_FILE%

	rem в файле hosts создать новый виртуальный хост [сайт]
	@echo. >> %HOSTS_WINFILE%
	@echo 127.0.0.1		%NEW_HOST_NAME% >> %HOSTS_WINFILE%

	rem перезапустить Apache
	echo.
	echo      Теперь после небольшой паузы будет перезапущен серер Apache.
	echo.
	echo      После того, как сервер запустится (окно не будет изменяться), нажмите любую клавишу ...

	start /b f:\2018\DevProg\XAMPP-717\apache_stop.bat
	timeout /T 5
	start /b f:\2018\DevProg\XAMPP-717\apache_start.bat

	pause

	cls
	color 05
	echo.
	echo.
	echo Каталог нового хоста создан.
	echo Виртуальные хосты созданы и настроены.
	echo Запускается браузер для проверки работы созданного хоста ...
	echo.

	"C:\Users\AlexPapa\AppData\Local\Mozilla Firefox\firefox.exe" http://%NEW_HOST_NAME%

	echo Если все получилось, нажмите любую клавишу.
	echo При этом закроются все окна и остановится сервер Apache.
	echo.
	echo Настройка закончена успешно.

	echo Перезапустите сервер Apache в контрольной панели XAMPP
	echo и приятной работы!
	echo.
	echo.
	pause


	) else (

	echo.
	color 0C
	echo Тупо облом
	echo Выход из программы ...
	echo.

	pause

	)