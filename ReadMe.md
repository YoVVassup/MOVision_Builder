<p align="center">
	<a href="https://github.com/YoVVassup/MOVision_Builder">
		<img src="https://github.com/YoVVassup/MOVision_Builder/blob/main/logo.png" alt="Mental Omega Vision Logo">
	</a>
</p>

# MOVision_Builder

[![N|Solid](https://i.ibb.co/yFBZZqJ/mo.gif)](http://mentalomega.com/)

MOVision_Builder - это пакетный сборщик CLI дополнительных расширений контента фанатского мода Mental Omega для RA2YR, ныне аддона [Mental Omega Vision (Clean Edition)](https://www.moddb.com/games/cc-red-alert-yuris-revenge/addons/mo-336-mental-omega-vision)

Аддон Mental Omega Vision (Clean Edition) на текущий момент включает следующие наборы миссий:
- RA2 and RA2YR Remake - 24 (RA2) + 14 (RA2YR) + 5 (RA2FoehnRevolt) миссий. (Оригинальный автор карт и скриптов 帝王审判者, название MORA2重制战役V2.02By帝王审判者 и была создана для версии мода Mental Omega 3.3.4);
- APRA Series - 18 (APRA V0.6) + 2 (Scorpion Cell Chronicles V0.2) + 1 (Flipped APRA) миссий (APRA - Перевод Moroznik, Scorpion Cell Chronicles, FAPRA - перевод mah-boi, авторство серии карт - [APRA2](https://discord.gg/SfxbURT5gT));
- Soviet Mission Pack - 67 миссий различных авторов;
- Epsilon Mission Pack - 27 миссий различных авторов;
- B.M.A. Series - 5 оригинальных + 3 побочных миссии (Оригинальное авторство принадлежит 「B.M.A」, название 「B.M.A」往昔回忆录, была создана для версии мода Mental Omega 3.3.2-3.3.4);
- P.M.O.S. Series - 3 миссии (Оригинальное авторство за prry, название P.M.O.S.系列心灵终结任务包, была создан для версии мода Mental Omega 3.3.4);
- WanNiang Series - 10 миссий (Оригинальное авторство за WanNiang, название 【WanNiang任務系列】殺時間的任務包, была создан для версии мода Mental Omega 3.3.4-3.3.5);
- Foehn Mission Pack - 25 миссий различных авторов;
- Режим COOP миссии в соло добовляет 3 новых режима в мультиплеере - SP Co-Op Easy, SP Co-Op Medium и SP Co-Op Hard, где управление заточено под одного игрока (`FIX`, теперь не требуются дополнительные действия для выбора);
- Новые мультиплеерные режимы Armor Fist, Elite Force, Helpless, Monster Truck, Mixed Modes, Scavengers, Blinded, Clone, Lost Journey, Lucky, Tech Climb, Lost Colony, Shadow Raid (Оригинальное авторство за Morphunk, Hoa Tuyet и A Very Festive Scarecrow);
- Последний русификатор от Damfoos для Mental Omega (3.3.6), он же администратор русскоязычной группы vk по [Mental Omega](https://vk.com/mental.omega).

Дополнительно:
- Видео на русском для RA2 and RA2YR Remake компании, чтобы включить опцию жмем `Настройки` → `Display` → `Cutscenes` → (выбираем что-либо в соответствии с вашим разрешение экрана) `Enabled RA2&RA2YR (720p)` / `Enabled RA2&RA2YR (768p)` / `Enabled RA2&RA2YR (1080p)` / `Enabled RA2&RA2YR (1440p)` → Соглашаемся с изменениями.
- Шейдеры, активируются по кнопке "Home", когда миссия или сражение запущено, чтобы включить опцию жмем `Настройки` → `Display` → `ReShade` (Шейдеры работают только для рендеров типа CnC-DDraw, CnC-DDraw-Old и DirectX. Тип DX11 должен подходить для большинства пользователей. Если при загрузке игры не отображается сообщения о загрузке ReShade, используйте DX9 или OpenGL.).
- Новые треки для музыкального плеера игры, в которые были добавлены все скрытые оригинальные треки, а также дополнительные треки из фан-компаний (`FIX`, для переключения используется список выбора который можно найти на вкладке `Настройки` → `Audio` → `Soundtrack` → `Vision (Extendet) Soundtrack` → Соглашаемся с изменениями и перезагрузкой).
- Полный сброс на параметры по умолчанию, для обновления на новую версию и для случаев некорректного использования аддона с помощью файла `Reset[Использовать-только-при-ошибке-запуска].bat` `FIX`.
- Набор инструментов для пост-пользовательской CLI доработки аддона (`Resources\Tools`).
- Обновлены и добавлены версии стабильных рендеров [DDrawCompat](https://github.com/narzoul/DDrawCompat) (текущая стабильная версия 0.6.0, лучший выбор для встроенной графики от Intel, для вызова окна доп. настроек нажать Shift+F11), [CnC-DDraw](https://github.com/FunkyFr3sh/cnc-ddraw) (текущая версия 7.1.0.0), [CnC-DDraw-Old](https://github.com/FunkyFr3sh/cnc-ddraw/releases/tag/1.4.0.0) (старая версия CnC-DDraw 1.4.0.0 от FunkyFr3sh, оставлена для совместимости с шейдерами DX9), [DirectX](https://github.com/FunkyFr3sh/cnc-ddraw/releases/tag/v5.1.0.0) (специально перенастроенная версия CnC-DDraw 5.1.0.0 от FunkyFr3sh, лучший выбор для видеокарт от NVIDIA, см. [доп.настройки](https://github.com/YoVVassup/MOVision_Builder/blob/main/Doc/DirectX.md)).
- Обновлен файл `qres.dat`, отвечающий за разрешения экрана в игре (добавлены редкие разрешения).
- Опциональное изменение шрифтов как для самой игры, так и для лаунчера DTA, опции доступны из `Настройки` → `Display` → `Fonts [Game]` и `Настройки` → `Display` → `Fonts [DTA]`.
- Опциональные расширения для Ares&Phobos ExtMiniFix.dll и ObjectInfo.dll (см. [ReadMe](https://github.com/YoVVassup/MOVision_Builder/blob/main/CustomFiles/MOV/Extention/Dll/README.md)), опции доступны из `Настройки` → `Updater` → `ExtMiniFix` и `Настройки` → `Updater` → `ObjectInfo`.
- Опциональное расширение редактора карт [FA2sp](https://github.com/secsome/FA2sp) [v.1.6.3.1](https://github.com/NyaCl/FA2sp), опция доступна из `Настройки` → `Updater` → `MapEditor` → `FA2sp`.
- Опциональный выключатель погодных эффектов дождя и снега, опция доступна из `Настройки` → `Game` → `Weather effect`.
- Опциональный полупрозрачный черный туман (который скрывает карту), опция доступна из `Настройки` → `Game` → `Translucent black fog`.
- Расширитель логики приоритета загрузки [MixLoader.dll](https://github.com/Multfinite/MixLoader) (может загрузить кастомные mix-файлы с самым высоким приоритетом в произвольном порядке, пока не используется).

## Сборка

Из-за ограничений на размер файлов в гитхабе, дополнительно выкачиваем [все файлы катсцен](https://disk.yandex.ru/d/-zPgKtQGGuv-gw) (Upd) и [дополнительные аудиотреки](https://disk.yandex.by/d/9vlVRaY419TpLw), после чего разархивируем и закидываем их в папку сборки.  
Вся сборка проекта происходит в режиме CLI. Достаточно запустить `Build.bat`, процесс сборки достаточно долгий, по этому дождитесь приглашения командной строки "Можно закртыть эту консоль." для завершения.  
Файлы катсцен (видевставок) и дополнительных аудиотреков можно пересобирать отдельно с помощью `Build_OnlyVideo.bat` и `Build_OnlyAudio.bat`, сделано для удобства и опционально позволяет не использовать ту часть контента, которая вам не нужна.

## Ограничение

Для сборщика:  
Любая версия Windows, начиная от Windows XP. Наличие [.NET Framework 4.0](https://www.microsoft.com/ru-ru/download/details.aspx?id=17718).  
Для аддона Mental Omega Vision:  
Такие же, что и для чистой Mental Omega. 

## Установка

Просто скопируйте получившийся файлы из папки `Build` в директорию игры и запустите `Reset[Использовать-только-при-ошибке-запуска].bat` для сброса на настройки по умолчанию. Запуск батника требуется для корректного обнуления данных и должен применяться после каждого изменения сборки проекта, т.е. после перемещения его в папку с игрой.

Уточнение для корректной работы по оригинальной Mental Omega:
- Следуем официальной [инструкции по установке](https://mentalomega.com/ru/index.php?page=install).
- Не используем папку Red Aler 2 Yuri's Revenge в качестве базы для установки, берем из нее лишь указанные файлы: BINKW32.dll, BLOWFISH.dll, gamemd.exe (обязательно версии 1.001), ra2.mix, ra2md.mix, language.mix, langmd.mix
- Русскую локализацию ставить не обязательно, она уже включена в аддон.
- Для установки аддона использовать только версию Mental Omega 3.3.6.
- Проверяем работоспособность вашей сборки Mental Omega, до установки аддона, т.к. сам аддон не влияет на запуск игры.
- Если не получается запустить "ванильную" Mental Omega без аддона или имеют места быть некоторые ошибки смотрим [руководство](https://cncseries.ru/ra2yr-faq/?ysclid=ltr7hwoy4a307032792) или попробуйте полуавтоматизированный софт [Mental Omega Регистратор](https://github.com/YoVVassup/Mo3RegUI).  

## Документация

[Дополнительные требования при создании\изменении игровых файлов](https://github.com/YoVVassup/MOVision_Builder/blob/main/Doc/Requirements.md)  
[Общая информация по CLI-утилитам сборки](https://github.com/YoVVassup/MOVision_Builder/blob/main/Doc/ReadmeUtil.md)  