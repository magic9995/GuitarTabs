@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  Audiveris startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Add default JVM options here. You can also use JAVA_OPTS and AUDIVERIS_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto init

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto init

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:init
@rem Get command-line arguments, handling Windows variants

if not "%OS%" == "Windows_NT" goto win9xME_args

:win9xME_args
@rem Slurp the command line arguments.
set CMD_LINE_ARGS=
set _SKIP=2

:win9xME_args_slurp
if "x%~1" == "x" goto execute

set CMD_LINE_ARGS=%*

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\audiveris.jar;%APP_HOME%\lib\args4j-2.33.jar;%APP_HOME%\lib\bsaf-1.9.2.jar;%APP_HOME%\lib\logback-classic-1.1.7.jar;%APP_HOME%\lib\proxymusic-3.0.1.jar;%APP_HOME%\lib\deeplearning4j-core-0.8.0.jar;%APP_HOME%\lib\deeplearning4j-modelimport-0.8.0.jar;%APP_HOME%\lib\nd4j-native-0.8.0.jar;%APP_HOME%\lib\nd4j-native-0.8.0-windows-x86_64.jar;%APP_HOME%\lib\deeplearning4j-nn-0.8.0.jar;%APP_HOME%\lib\datavec-data-image-0.8.0.jar;%APP_HOME%\lib\datavec-nd4j-common-0.8.0.jar;%APP_HOME%\lib\nd4j-native-api-0.8.0.jar;%APP_HOME%\lib\nd4j-api-0.8.0.jar;%APP_HOME%\lib\datavec-api-0.8.0.jar;%APP_HOME%\lib\nd4j-buffer-0.8.0.jar;%APP_HOME%\lib\nd4j-context-0.8.0.jar;%APP_HOME%\lib\nd4j-common-0.8.0.jar;%APP_HOME%\lib\slf4j-api-1.7.21.jar;%APP_HOME%\lib\jcip-annotations-1.0.jar;%APP_HOME%\lib\eventbus-1.4.jar;%APP_HOME%\lib\jgoodies-forms-1.9.0.jar;%APP_HOME%\lib\jgoodies-looks-2.7.0.jar;%APP_HOME%\lib\jai-core-1.1.3.jar;%APP_HOME%\lib\ij-1.51f.jar;%APP_HOME%\lib\jPodRenderer-5.6.jar;%APP_HOME%\lib\jgrapht-core-1.0.0.jar;%APP_HOME%\lib\jfreechart-1.0.19.jar;%APP_HOME%\lib\itextpdf-5.5.9.jar;%APP_HOME%\lib\jama-1.0.3.jar;%APP_HOME%\lib\reflections-0.9.10.jar;%APP_HOME%\lib\tesseract-3.04.01-1.3.jar;%APP_HOME%\lib\tesseract-3.04.01-1.3-windows-x86_64.jar;%APP_HOME%\lib\leptonica-platform-1.73-1.3.jar;%APP_HOME%\lib\leptonica-1.73-1.3.jar;%APP_HOME%\lib\leptonica-1.73-1.3-windows-x86_64.jar;%APP_HOME%\lib\leptonica-1.73-1.3-android-arm.jar;%APP_HOME%\lib\leptonica-1.73-1.3-android-x86.jar;%APP_HOME%\lib\leptonica-1.73-1.3-linux-x86.jar;%APP_HOME%\lib\leptonica-1.73-1.3-linux-x86_64.jar;%APP_HOME%\lib\leptonica-1.73-1.3-linux-armhf.jar;%APP_HOME%\lib\leptonica-1.73-1.3-linux-ppc64le.jar;%APP_HOME%\lib\leptonica-1.73-1.3-macosx-x86_64.jar;%APP_HOME%\lib\leptonica-1.73-1.3-windows-x86.jar;%APP_HOME%\lib\javacv-1.3.1.jar;%APP_HOME%\lib\openblas-platform-0.2.19-1.3.jar;%APP_HOME%\lib\openblas-0.2.19-1.3.jar;%APP_HOME%\lib\openblas-0.2.19-1.3-android-arm.jar;%APP_HOME%\lib\openblas-0.2.19-1.3-android-x86.jar;%APP_HOME%\lib\openblas-0.2.19-1.3-linux-x86.jar;%APP_HOME%\lib\openblas-0.2.19-1.3-linux-x86_64.jar;%APP_HOME%\lib\openblas-0.2.19-1.3-linux-armhf.jar;%APP_HOME%\lib\openblas-0.2.19-1.3-linux-ppc64le.jar;%APP_HOME%\lib\openblas-0.2.19-1.3-macosx-x86_64.jar;%APP_HOME%\lib\openblas-0.2.19-1.3-windows-x86.jar;%APP_HOME%\lib\openblas-0.2.19-1.3-windows-x86_64.jar;%APP_HOME%\lib\hdf5-platform-1.10.0-patch1-1.3.jar;%APP_HOME%\lib\hdf5-1.10.0-patch1-1.3.jar;%APP_HOME%\lib\hdf5-1.10.0-patch1-1.3-linux-x86.jar;%APP_HOME%\lib\hdf5-1.10.0-patch1-1.3-linux-x86_64.jar;%APP_HOME%\lib\hdf5-1.10.0-patch1-1.3-linux-ppc64le.jar;%APP_HOME%\lib\hdf5-1.10.0-patch1-1.3-macosx-x86_64.jar;%APP_HOME%\lib\hdf5-1.10.0-patch1-1.3-windows-x86.jar;%APP_HOME%\lib\hdf5-1.10.0-patch1-1.3-windows-x86_64.jar;%APP_HOME%\lib\opencv-platform-3.1.0-1.3.jar;%APP_HOME%\lib\flandmark-1.07-1.3.jar;%APP_HOME%\lib\opencv-3.1.0-1.3.jar;%APP_HOME%\lib\opencv-3.1.0-1.3-android-arm.jar;%APP_HOME%\lib\opencv-3.1.0-1.3-android-x86.jar;%APP_HOME%\lib\opencv-3.1.0-1.3-linux-x86.jar;%APP_HOME%\lib\opencv-3.1.0-1.3-linux-x86_64.jar;%APP_HOME%\lib\opencv-3.1.0-1.3-linux-armhf.jar;%APP_HOME%\lib\opencv-3.1.0-1.3-linux-ppc64le.jar;%APP_HOME%\lib\opencv-3.1.0-1.3-macosx-x86_64.jar;%APP_HOME%\lib\opencv-3.1.0-1.3-windows-x86.jar;%APP_HOME%\lib\opencv-3.1.0-1.3-windows-x86_64.jar;%APP_HOME%\lib\ffmpeg-3.2.1-1.3.jar;%APP_HOME%\lib\flycapture-2.9.3.43-1.3.jar;%APP_HOME%\lib\libdc1394-2.2.4-1.3.jar;%APP_HOME%\lib\libfreenect-0.5.3-1.3.jar;%APP_HOME%\lib\libfreenect2-0.2.0-1.3.jar;%APP_HOME%\lib\librealsense-1.9.6-1.3.jar;%APP_HOME%\lib\videoinput-0.200-1.3.jar;%APP_HOME%\lib\artoolkitplus-2.3.1-1.3.jar;%APP_HOME%\lib\javacpp-1.3.2.jar;%APP_HOME%\lib\jai-imageio-core-1.3.1.jar;%APP_HOME%\lib\org.apache.commons.io-2.4.jar;%APP_HOME%\lib\logback-core-1.1.7.jar;%APP_HOME%\lib\jgoodies-common-1.8.1.jar;%APP_HOME%\lib\jPod-5.6.jar;%APP_HOME%\lib\iscwt-5.6.jar;%APP_HOME%\lib\isfreetype-5.6.jar;%APP_HOME%\lib\isrt-4.11.jar;%APP_HOME%\lib\com.springsource.javax.media.jai.codec-1.1.3.jar;%APP_HOME%\lib\com.springsource.javax.media.jai.core-1.1.3.jar;%APP_HOME%\lib\jPodFonts-5.5.jar;%APP_HOME%\lib\jcommon-1.0.23.jar;%APP_HOME%\lib\guava-18.0.jar;%APP_HOME%\lib\javassist-3.18.2-GA.jar;%APP_HOME%\lib\annotations-2.0.1.jar;%APP_HOME%\lib\commons-math3-3.4.1.jar;%APP_HOME%\lib\deeplearning4j-ui-components-0.8.0.jar;%APP_HOME%\lib\commons-io-2.4.jar;%APP_HOME%\lib\commons-compress-1.8.1.jar;%APP_HOME%\lib\commons-lang3-3.3.1.jar;%APP_HOME%\lib\jackson-0.8.0.jar;%APP_HOME%\lib\json-20131018.jar;%APP_HOME%\lib\lombok-1.16.10.jar;%APP_HOME%\lib\commons-codec-1.10.jar;%APP_HOME%\lib\jbig2-5.5.1.jar;%APP_HOME%\lib\neoitertools-1.0.0.jar;%APP_HOME%\lib\snakeyaml-1.12.jar;%APP_HOME%\lib\stax2-api-3.1.4.jar;%APP_HOME%\lib\joda-time-2.9.2.jar;%APP_HOME%\lib\freemarker-2.3.23.jar;%APP_HOME%\lib\stream-2.7.0.jar;%APP_HOME%\lib\imageio-jpeg-3.1.1.jar;%APP_HOME%\lib\imageio-tiff-3.1.1.jar;%APP_HOME%\lib\imageio-psd-3.1.1.jar;%APP_HOME%\lib\imageio-bmp-3.1.1.jar;%APP_HOME%\lib\isnativec-5.6.jar;%APP_HOME%\lib\junit-4.8.2.jar;%APP_HOME%\lib\fastutil-6.5.7.jar;%APP_HOME%\lib\imageio-metadata-3.1.1.jar;%APP_HOME%\lib\imageio-core-3.1.1.jar;%APP_HOME%\lib\common-image-3.1.1.jar;%APP_HOME%\lib\common-io-3.1.1.jar;%APP_HOME%\lib\common-lang-3.1.1.jar;%APP_HOME%\lib\jna-3.2.7.jar

@rem Execute Audiveris
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %AUDIVERIS_OPTS%  -classpath "%CLASSPATH%" Audiveris %CMD_LINE_ARGS%

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable AUDIVERIS_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%AUDIVERIS_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
