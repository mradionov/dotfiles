set windows_font_face=Consolas
set windows_font_size=11

set user_dir=%userprofile%\AppData\Roaming\Sublime Text 3\Packages\User

set source_dir=%cd%\sublime

move "%user_dir%" "%user_dir%-pre-dotfiles"
rem xcopy "%source_dir%" "%user_dir%" /s /y
mklink /J "%user_dir%" "%source_dir%"

set source_pref=%source_dir%\Preferences.sublime-settings.template
set user_pref=%user_dir%\Preferences.sublime-settings

copy "%source_pref%" "%user_pref%"

powershell -Command "(gc \"%user_pref%\") -replace '%%FONT_FACE%%', '%windows_font_face%' -replace '%%FONT_SIZE%%', '%windows_font_size%' | out-file -encoding utf8 \"%user_pref%\""

rem Removes BOM from UTF-8, because Sublime does not read settings with BOM
dos2unix "%user_pref%"
