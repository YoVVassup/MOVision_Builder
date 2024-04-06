## Требования к некоторым файлам для компиляции (для корректного их воспроизведения в игре):

### Файлы игровых звуков и музыкальных треков:

Основные понятия по аудиофайлам можно прочитать на [modenc](https://modenc.renegadeprojects.com/Adding_A_Song).  
Сделаю лишь некоторое уточнение, к которому я пришел после нескольких проб (попыток) добиться хорошего качества при небольшом весе файлов:

- Используйте `Audacity Portable` (зачем инсталлировать, то что и так работает?) для конвертации в `.wav` закинув трек/звук в программу.
- Для экспорта нажать "Ctrl + Shift + E".
- В настройках экспорта для звуков выбрать wav, частоту дискретизации 22050 Hz, канал Mono, 16 bit и кодирование - IMA ADPCM.
- В настройках экспорта для игровых треков выбрать wav, частоту дискретизации 44100 Hz (можно и 22050, но звук будет хуже, а оригинальные треки из MO тоже в 44100), канал не менять (по умолчанию Stereo) и кодирование - IMA ADPCM.
- Готово, останется лишь прописать нужные звуки в `soundmo.ini` (fan_soundmo.ini) и `thememo.ini` (fan_thememo.ini) соответственно.

Примечание:  
Наборы звуков принято хранить в "сумках" (`.bag`), хотя с выходом Ares это изменилось и уже давно как звуки можно хранить прямо в `.mix` файлах.  
Т.е. на выбор есть 2 варианта, я использую классический метод, т.к. благодаря Ares, файлы с "сумками" обзавелись индексами, по аналогии с .mix файлами (см. [Ares](https://ares-developers.github.io/Ares-docs/new/misc/bagfiles.html?highlight=audio)).  
Большой плюс этого метода в том, что сумки можно запихнуть в mix-файлы более раннего порядка, но с высшим приоритетом, т.е. к примеру положить в expandmo09.mix файлы audio99.bag и audio99.idx, которые могут переопределить сумки в `.mix` более старших порядков, но с меньшим порядковым номером самих "сумок".  
Мне это подходит как нельзя кстати.  
Минус этого метода в том, что придется копаться в RA2/RA2YR (или моде), чтобы достать оригинальные audio.bag и audio.idx, затем с помощью программы `XCC Mixer` → `Launch` → `XCC Sound Editor` → `Open` (указать на оригинальные audio.bag и audio.idx).  
Потом, попав внутрь нашего audio.bag сносим там все на ноль, после чего размер файла audio.idx должен измениться, если это так значит все ОК. От файла audio.bag можно избавиться, он больше не нужен. Заместо него создаем пустой файл созданный из чего угодно с именем audio.bag.  
Вот теперь все готово для создания кастомной "сумки", пустой файл индекса - audio.idx и наш из ничего созданный audio.bag по аналогии открываются в `XCC Sound Editor` и только теперь готовы принять новые файлы звуков... (хотя можно это все не делать и тупо дописывать в оригинальную сумку, но не рекомендую)  
Второй минус этого способа - это ручная пересборка таких сумок, в отличии от тех же файлов упакованных в .mix, для которых есть инструменты CLI.  

Доп. примечание:  
Кастомные файлы audioXX.bag и audioXX.idx необязательно хранить в `.mix`, достаточно положить их в корень игры.  

### Небольшой ликбез по работе с soundmo.ini и thememo.ini...
Пример основных параметров для soundmo.ini:  

`[SoundList]`  
\+ = Имя регистрации звука/набора звуков // использование "+" для нумерации решает проблему поиска и продолжения последнего номера звука/набора звуков в списке для сборки, в которой правила раскиданы по нескольким файлам (к примеру soundmo.ini, fan_soundmo.ini и др.).

`[Имя регистрации звука/набора звуков]`  
Sounds = имя wav-файла без расширения, требуется 22050 Hz, или несколько файлов разделенных пробелами (знак $ перед именем создает исключение для владельца, т.е. воспроизведение будет без звука для всех остальных)  
Control = метод воспроизведения, ограниченный следующими параметрами:  
// ALL 			Воспроизводить все wav-файлы по порядку  
// LOOP 		Воспроизводить первый звук в неслучайном порядке бесконечно, пока количество циклов не достигнет предела или звук не исчезнет  
// RANDOM 		Воспроизведение звуков в случайном порядке  
// PREDELAY 	Задержка воспроизведения на определенный период времени, если установлен тег Delay  
// INTERRUPT 	Прерывать или нет другие звуки  
// AMBIENT 		Заставить систему решить, что данный звуковой эффект является фоновым и не будет прерываться INTERRUPT  
FShift = -3 3 ; // Верхний и нижний пределы сдвига частоты воспроизведения (т.е. в пределах от на 3% медленнее и на 3% быстрее, чем обычно)  
Volume = 70 ; // Громкость (0-100)  
Priority = NORMAL ; // Определить приоритет воспроизведения, LOWEST LOW NORMAL HIGH CRITICAL в порядке возрастания, по умолчанию NORMAL.  
Delay = 0 1000 ; // Если установлено значение PREDELAY, возьмите случайное значение между верхним и нижним пределами, указанными здесь, в миллисекундах (отрицательные значения задержки могут быть использованы для того, чтобы сделать звук воспроизводимым только один раз за игру).  
Limit = 1 ; // Максимальное количество звуковых эффектов, которые могут воспроизводиться одновременно.  

Пример основных параметров для thememo.ini:

`[Themes]`  
\+ = Имя регистрации трека // использование "+" для нумерации решает проблему поиска и продолжения последнего номера трека в списке для сборки, в которой правила раскиданы по нескольким файлам (к примеру thememo.ini, fan_thememo.ini и др.).

`[Имя регистрации трека]`  
Name = имя переменной для названия трека (к примеру THEME:Morphscape), которое должно быть определено в одном из .csf файлов игры  
Sound = имя wav-файла трека без расширения  
Normal = yes ; // определяет, указана ли эта тема в плейлисте игры (yes/no)  
Length = 5.21 ; // указывает продолжительность воспроизведения трека (если надо воспроизвести лишь его часть)  
Repeat = yes ; // используется вместо параметра Length, если не нужно указывать продолжительность воспроизведения и для зацикливания трека (yes/no)  
Side = GDI ; // необязательный параметр, отвечающий за принадлежность трека к определенной фракции (GDI,Nod,ThirdSide,FourthSide)  

Примечание:  
Для регистрации звука/набора звуков или треков в другом файле, нужно использовать конструкцию `#incude` в оригинальном файле правил (soundmo.ini,thememo.ini), пример:  

`[#include]`  
1=имя_файла.ini ; // где имя_файла.ini ваш файл с новыми звуками или треками  

Доп. примечание:  
Ввиду некоторых ограничений платформы Ares (20000 переменных под текст) не стоит разбрасываться переменными для именования треков.  
Можно давать имена трекам прямо в коде INI (без создания записи в таблице строк), используя префикс `NOSTR:`, к примеру:  

`[FreezeLoop1X]`  
Name=NOSTR:Stranded in Space  
Sound=vfreeze1  
Normal=yes  

В плеере игры трек будет отображаться как «Stranded in Space». Однако длина строки (включая префикс) не может превышать 31 символ.  


Файлы игровых видеороликов:  

В процессе создания катсцен были использованы наработки `MugnumAF`, вот его [статья](https://www.nexusmods.com/commandandconquerredalert2/articles/1) на тему конвертации `.bik` файлов, там же там имеются видеоролики в формате 1080p и 768p.  
Для локализации были взяты оригинальные ролики от "Фаргуса", чтобы наложить их звуковую дорожку на имеющиеся катсцены в новых разрешениях.  
ВСЕ ЧТО НАПИСАНО ДАЛЕЕ ИМЕЕТ СУГУБО ОЗНАКОМИТЕЛЬНЫЙ ХАРАКТЕР, т.к. эти операции уже проделаны с имеющимися файлами.  
Можно конечно тупо воспользоваться алгоритмом из статьи:  
Запустите устаревшую версию программы RAD Tools (radvideo.exe).  
- Перейдите в папку с катсценами в новых разрешениях (.bik) (в нашем случае это ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p" и ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p").  
- Выберите файл и нажмите "Mix in sound".  
- Если появится подсказка о последовательности (File, "XXX.bik", appears to be part of a sequence of files (1 to XXX). Do you want to treat the sequence as a single animation?), выберите "Нет".  
- Установите "Sound file to mix" на файл с таким же названием как микшируемый, но из папки с локализацией от "Фаргуса" (в нашем случае это ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p").  
- В разделе "Output file info" удалите префикс "New_".  
- Установите флажок "Automatic overwrite?".  
- Установите "Sound compression level (0=lossless, 4=perceptibly lossless, 99=very lossy)" на 0.  
- Нажмите "Mix". Повторите эти действия для каждого видео файла .bik.  

Но ввиду того, что файлов много (в моем варианте 83 файла на каждый тип разрешения, т.к. автор серии "RA2 and RA2YR Remake" не использовал все оригинальные видео) лучше воспользоваться пакетной обработкой CLI-утилитой от устаревшей версии программы RAD Tools (binkmix.exe).  
Т.е. в моем случае итоговая конструкция для катсцен 768p имеет вид:  
```sh
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a01_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a01_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a01_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a01_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a01_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a01_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a01_p03e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a01_p03e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a01_p03e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a01yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a01yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a01yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a01yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a01yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a01yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a01yr-2.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a01yr-2.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a01yr-2.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a01yr-3.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a01yr-3.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a01yr-3.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a02_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a02_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a02_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a02_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a02_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a02_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a02_p02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a02_p02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a02_p02e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a02yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a02yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a02yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a03_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a03_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a03_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a03_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a03_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a03_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a03yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a03yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a03yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a03yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a03yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a03yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a03yr-2.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a03yr-2.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a03yr-2.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a03yr-3.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a03yr-3.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a03yr-3.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a04_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a04_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a04_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a04_f03e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a04_f03e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a04_f03e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a04_p02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a04_p02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a04_p02e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a04yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a04yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a04yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a04yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a04yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a04yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a04yr-2.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a04yr-2.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a04yr-2.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a05_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a05_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a05_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a05yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a05yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a05yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a06_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a06_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a06_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a06yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a06yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a06yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a06yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a06yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a06yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a06yr-2.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a06yr-2.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a06yr-2.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a07_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a07_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a07_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a07yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a07yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a07yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a08_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a08_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a08_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a08_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a08_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a08_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a08yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a08yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a08yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a09_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a09_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a09_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a09_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a09_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a09_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a10_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a10_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a10_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a10_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a10_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a10_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a11_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a11_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a11_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a11_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a11_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a11_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a12_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a12_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a12_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a12_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a12_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a12_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a13_f01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a13_f01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a13_f01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a13_f02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a13_f02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\a13_f02e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\ra2mdre00.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\ra2mdre00.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\ra2mdre00.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\ra2re00.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\ra2re00.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\ra2re00.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s01_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s01_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s01_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s01yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s01yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s01yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s01yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s01yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s01yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s02_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s02_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s02_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s02_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s02_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s02_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s02_p02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s02_p02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s02_p02e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s02_p03e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s02_p03e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s02_p03e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s02yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s02yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s02yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s03_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s03_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s03_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s03yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s03yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s03yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s03yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s03yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s03yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s04_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s04_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s04_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s04_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s04_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s04_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s04yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s04yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s04yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s04yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s04yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s04yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s05_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s05_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s05_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s05_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s05_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s05_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s05_p02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s05_p02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s05_p02e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s05yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s05yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s05yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s05yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s05yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s05yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s06_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s06_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s06_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s06yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s06yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s06yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s06yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s06yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s06yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s07_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s07_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s07_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s07_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s07_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s07_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s07yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s07yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s07yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s08_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s08_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s08_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s08_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s08_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s08_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s08yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s08yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s08yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s09_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s09_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s09_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s09_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s09_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s09_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s10_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s10_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s10_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s11_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s11_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s11_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s11_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s11_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s11_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s12_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s12_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s12_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s13_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s13_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s13_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s13_f01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s13_f01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p\s13_f01e.bik /L0 /O
```
А для катсцен 1080p:  
```sh
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a01_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a01_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a01_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a01_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a01_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a01_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a01_p03e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a01_p03e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a01_p03e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a01yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a01yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a01yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a01yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a01yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a01yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a01yr-2.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a01yr-2.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a01yr-2.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a01yr-3.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a01yr-3.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a01yr-3.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a02_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a02_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a02_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a02_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a02_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a02_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a02_p02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a02_p02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a02_p02e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a02yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a02yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a02yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a03_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a03_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a03_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a03_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a03_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a03_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a03yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a03yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a03yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a03yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a03yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a03yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a03yr-2.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a03yr-2.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a03yr-2.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a03yr-3.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a03yr-3.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a03yr-3.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a04_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a04_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a04_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a04_f03e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a04_f03e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a04_f03e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a04_p02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a04_p02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a04_p02e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a04yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a04yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a04yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a04yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a04yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a04yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a04yr-2.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a04yr-2.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a04yr-2.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a05_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a05_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a05_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a05yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a05yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a05yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a06_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a06_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a06_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a06yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a06yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a06yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a06yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a06yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a06yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a06yr-2.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a06yr-2.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a06yr-2.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a07_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a07_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a07_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a07yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a07yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a07yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a08_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a08_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a08_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a08_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a08_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a08_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a08yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a08yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a08yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a09_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a09_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a09_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a09_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a09_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a09_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a10_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a10_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a10_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a10_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a10_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a10_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a11_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a11_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a11_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a11_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a11_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a11_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a12_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a12_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a12_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a12_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a12_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a12_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a13_f01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a13_f01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a13_f01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a13_f02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\a13_f02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\a13_f02e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\ra2mdre00.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\ra2mdre00.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\ra2mdre00.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\ra2re00.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\ra2re00.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\ra2re00.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s01_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s01_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s01_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s01yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s01yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s01yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s01yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s01yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s01yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s02_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s02_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s02_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s02_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s02_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s02_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s02_p02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s02_p02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s02_p02e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s02_p03e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s02_p03e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s02_p03e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s02yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s02yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s02yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s03_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s03_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s03_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s03yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s03yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s03yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s03yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s03yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s03yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s04_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s04_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s04_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s04_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s04_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s04_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s04yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s04yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s04yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s04yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s04yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s04yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s05_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s05_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s05_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s05_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s05_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s05_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s05_p02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s05_p02e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s05_p02e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s05yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s05yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s05yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s05yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s05yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s05yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s06_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s06_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s06_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s06yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s06yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s06yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s06yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s06yr-1.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s06yr-1.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s07_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s07_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s07_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s07_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s07_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s07_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s07yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s07yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s07yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s08_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s08_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s08_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s08_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s08_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s08_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s08yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s08yr-0.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s08yr-0.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s09_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s09_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s09_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s09_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s09_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s09_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s10_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s10_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s10_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s11_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s11_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s11_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s11_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s11_p01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s11_p01e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s12_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s12_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s12_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s13_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s13_f00e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s13_f00e.bik /L0 /O
Tools\BinkMix .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s13_f01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p\s13_f01e.bik .\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p\s13_f01e.bik /L0 /O
```
На этом пока все, выходное качество не велико и по прежнему использует 15 кадров с секунду, нужна будет хорошая AI модель для апскейлинга и глобального повышения качества катсцен минимум до 2K в дальнейшем, здесь же, просто увеличен размер кадра.


Файлы игровых аудиотреков:

С ростом размера коллекции дополнительных аудиотреков приходит нужда в их проверке на уникальность чтобы не дублировать уже имеющийся контент, т.к. вручную проверить такой объем информации довольно затруднительно стоит воспользоваться специальными программами для поиска дубляжей "по звукам".  
Для начала необходимо извлечь оригинальные и дополнительные аудиотреки Mental Omega (сам процесс описывать не буду, т.к. их mix файлы зашифрованы) из mix файлов `expandmo94.mix` и `thememo.mix`. Дополнительно сюда включаем аудиотреки из RA2 и RA2YR, которые объедены в файле `expandmo10.mix` после сборки или лежат в папке проекта в ```.\CustomCompileFiles\MOV\expandmo10```  
А также фанатские треки MOV `expandmo90.mix`, папке проекта в `.\CustomCompileFiles\expandmo90` (после скачивания см. [Сборка](https://github.com/YoVVassup/MOVision_Builder/tree/main?tab=readme-ov-file#%D1%81%D0%B1%D0%BE%D1%80%D0%BA%D0%B0)).  
Я использую программу [Similarity](https://www.similarityapp.com/), т.к. в ходе моих тестов она показала наилучшие результаты. (см. [Текущее состояние аудиоколекции треков](https://raw.githubusercontent.com/YoVVassup/MOVision_Builder/main/Doc/Audiotest.jpg))  
