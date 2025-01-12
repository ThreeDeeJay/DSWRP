@ECHO OFF
SETlocal EnableExtensions
SETlocal EnableDelayedExpansion
MODE con: cols=150 lines=50
pushd "%~dp0"

reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL || SET "WindowsArchitectureBits=64"

SET RegistryHive[0]=HKEY_LOCAL_MACHINE
SET RegistryHive[1]=HKEY_CURRENT_USER

SET RegistryNode[0]=\
SET RegistryNode[1]=\WOW6432Node\

SET RegistryID[0]={11AB3EC0-25EC-11D1-A4D8-00C04FC28ACA}
SET RegistryID[1]={3901CC3F-84B5-4FA4-BA35-AA8172B8A09B}
SET RegistryID[2]={47D4D946-62E8-11CF-93BC-444553540000}
SET RegistryID[3]={B0210780-89CD-11d0-AF08-00A0C925CD16}
SET RegistryID[4]={B2F586D4-5558-49D1-A07B-3249DBBB33C2}
SET RegistryID[5]={E4BCAC13-7F99-4908-9A8E-74E3BF24B6E1}
SET RegistryID[6]={FEA4300C-7959-4147-B26A-2377B9E7A91D}

TITLE DirectSound wrapper registry patcher v1.0 - By 3DJ with credit to Henky!!, John-Paul Ownby and Nucleoprotein
ECHO.
ECHO Registering DirectSound references (dsound.dll)...

IF NOT EXIST "Backup.reg" (
	ECHO Windows Registry Editor Version 5.00>"Backup.reg"
	)

for /F "tokens=2 delims==" %%H in ('set RegistryHive[') do (
	for /F "tokens=2 delims==" %%N in ('set RegistryNode[') do (
		for /F "tokens=2 delims==" %%I in ('set RegistryID[') do (
			SET "RegistryPath=%%H\SOFTWARE\Classes%%NCLSID\%%I\InprocServer32"
			IF NOT EXIST "Backup" (MKDIR "Backup")
			IF NOT EXIST "Backup\!RegistryPath:\=-!.reg" (
				reg query "!RegistryPath!" 1>> NUL 2>&1
				IF !ERRORLEVEL! EQU 0 (
					reg export "!RegistryPath!" "Backup\!RegistryPath:\=-!.reg" /y 1>>NUL 2>&1
					IF EXIST "Backup\!RegistryPath:\=-!.reg" (type "Backup\!RegistryPath:\=-!.reg" | find /v "Windows Registry Editor Version 5.00">>"Backup.reg")
					) ELSE (
					ECHO Windows Registry Editor Version 5.00>"Backup\!RegistryPath:\=-!.reg"
					ECHO.>>"Backup\!RegistryPath:\=-!.reg"
					ECHO [-!RegistryPath!]>>"Backup\!RegistryPath:\=-!.reg"
					ECHO.>>"Backup\!RegistryPath:\=-!.reg"
					ECHO.>>"Backup\!RegistryPath:\=-!.reg"
					type "Backup\!RegistryPath:\=-!.reg" | find /v "Windows Registry Editor Version 5.00">>"Backup.reg"
					)
				)
			SET /P var=!RegistryPath!: <NUL
			IF "!WindowsArchitectureBits!"=="64" (
				SetACL.exe -on "!RegistryPath!" -ot reg -actn setowner -ownr "n:Administrators" -rec Yes  1>>NUL 2>&1
				SetACL.exe -on "!RegistryPath!" -ot reg -actn ace -ace "n:Administrators;p:full" -rec Yes  1>>NUL 2>&1
				)
			reg add "!RegistryPath!" /V "" /T "REG_SZ" /D "dsound.dll" /F <NUL
			IF !ERRORLEVEL! NEQ 0 (SET FailedTask=True)
			)
		)
	)
ECHO.
IF "!FailedTask!"=="True" (
	COLOR C
	ECHO WARNING: Some tasks have failed. Please, close this window then right click this .bat ^> Run as administrator
	) ELSE (
	COLOR A
	ECHO SUCCESS: All registry keys have been updated.
	)
PAUSE