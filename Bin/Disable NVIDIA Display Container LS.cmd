@echo off

whoami /user | find /i "S-1-5-18" > nul 2>&1 || (
	call RunAsTI.cmd "%~f0" %*
	exit /b
)

reg query "HKLM\SYSTEM\CurrentControlSet\Services\NVDisplay.ContainerLocalSystem" > nul 2>&1 || (
    echo Служба NVIDIA Display Container LS не существует, вы не можете продолжить.
	echo Возможно, у вас не установлены драйверы NVIDIA.
    echo]
    pause
    exit /b 1
)

echo Отключение службы "NVIDIA Display Container LS" приведет к прекращению работы панели управления NVIDIA.
echo Скорее всего, это также нарушит работу других функций драйвера NVIDIA.
echo.
call setSvc.cmd NVDisplay.ContainerLocalSystem 4
sc stop NVDisplay.ContainerLocalSystem > nul 2>&1
