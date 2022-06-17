# Metacon 1.0

Приложение, написанное по ТЗ во время прохождения практики на предприятии
Программа считывает через COM-порт измерения температур с регулятора Метакон-562-ТП' с настроенным адресом, имеющим значение "3" из шести возможных.

## Функции программы

- "Настройки" - открывает окно с настройками COM-порта.
- "Открыть порт" - устанавливает соединение между устройством и компьютером.
- "Закрыть порт" - разрывает установленное соединение.
- "Начать считывание" - программа начинает опрос каналов устройства и выводит измеренные значения на экран.
- "Закончить считывание" - программа заканчивает опрос каналов устройства и очищает информацию об измерениях.
- "Температура" - сюда вводится значение, с которым будет сравниваться измеренная температура.

### Состояния каналов:

- *Зеленый - температура оптимальна (ниже введённого значения);
- *Красный - температура не оптимальна (выше введённого значения);
- *Желтый - к каналу не подключен термопреобразователь.

При разрыве соединения с устройством рекомендуется перезапустить программу.
