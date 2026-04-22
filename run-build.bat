@echo off
echo === PlantUML Build Automation ===
call gradlew.bat clean build -x test -x javadoc
if %ERRORLEVEL% neq 0 (
  echo BUILD FAILED
  exit /b %ERRORLEVEL%
)
echo BUILD SUCCESS
echo Check build\libs for generated artifact