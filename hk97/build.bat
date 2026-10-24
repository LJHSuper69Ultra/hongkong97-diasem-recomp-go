@echo off
rem Builds HongKong97.exe from the sources and assets (Go 1.22+ required).
go mod tidy || goto :err
go generate ./cmd/hk97 || goto :err
go build -trimpath -ldflags "-s -w -H=windowsgui" -o HongKong97.exe ./cmd/hk97 || goto :err
echo Built HongKong97.exe
exit /b 0
:err
echo Build failed.
exit /b 1
