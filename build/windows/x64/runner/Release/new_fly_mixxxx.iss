[Setup]
AppName=New Fly Mixxx
AppVersion=1.0
DefaultDirName={pf}\New Fly Mixxx
DefaultGroupName=New Fly Mixxx
DisableProgramGroupPage=no
OutputDir=G:\TangoMixx\Release
OutputBaseFilename=new_fly_mixxxx_setup
Compression=lzma
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64
PrivilegesRequired=admin
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a &desktop icon"; GroupDescription: "Additional icons:"; Flags: unchecked

[Files]
; Основной исполняемый файл
Source: "C:\Users\strog\StudioProjects\new_fly_mixxxx\build\windows\x64\runner\Release\new_fly_mixxxx.exe"; DestDir: "{app}"; Flags: ignoreversion
; Библиотеки Flutter
Source: "C:\Users\strog\StudioProjects\new_fly_mixxxx\build\windows\x64\runner\Release\flutter_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\strog\StudioProjects\new_fly_mixxxx\build\windows\x64\runner\Release\native_assets.json"; DestDir: "{app}"; Flags: ignoreversion
; Данные Flutter
Source: "C:\Users\strog\StudioProjects\new_fly_mixxxx\build\windows\x64\runner\Release\data\app.so"; DestDir: "{app}\data"; Flags: ignoreversion
Source: "C:\Users\strog\StudioProjects\new_fly_mixxxx\build\windows\x64\runner\Release\data\icudtl.dat"; DestDir: "{app}\data"; Flags: ignoreversion
Source: "C:\Users\strog\StudioProjects\new_fly_mixxxx\build\windows\x64\runner\Release\data\flutter_assets\*"; DestDir: "{app}\data\flutter_assets"; Flags: recursesubdirs createallsubdirs

; VC++ Redistributable (встраиваем в установщик, чтобы не просить пользователя качать отдельно)
Source: "G:\TangoMixx\vc_redist.x64.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Icons]
Name: "{group}\New Fly Mixxx"; Filename: "{app}\new_fly_mixxxx.exe"
Name: "{commondesktop}\New Fly Mixxx"; Filename: "{app}\new_fly_mixxxx.exe"; Tasks: desktopicon

[Run]
; Запускаем установку VC++ Redist в тихом режиме, если его нет
Filename: "{tmp}\vc_redist.x64.exe"; Parameters: "/install /quiet /norestart"; StatusMsg: "Installing Microsoft Visual C++ Redistributable..."; Check: NotIsVCRedistPresent; Flags: runhidden
; Запуск приложения после установки (опционально)
Filename: "{app}\new_fly_mixxxx.exe"; Description: "{cm:LaunchProgram,New Fly Mixxx}"; Flags: nowait postinstall skipifsilent

[Code]
function NotIsVCRedistPresent(): Boolean;
var
  msvcp140, vcruntime140: String;
begin
  msvcp140 := ExpandConstant('{sys}\msvcp140.dll');
  vcruntime140 := ExpandConstant('{sys}\vcruntime140.dll');
  Result := (not FileExists(msvcp140)) or (not FileExists(vcruntime140));
end;

