@echo off
cd.>light.txt
echo light%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%>>light.txt
git status
git add .
git commit -m "light%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2% "
git push
echo "3秒后自动关闭"
timeout /t 3