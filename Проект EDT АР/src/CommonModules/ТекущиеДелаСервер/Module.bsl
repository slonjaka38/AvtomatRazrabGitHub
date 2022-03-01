///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Таблица текущих дел пользователя.
// Передается в обработчики ПриЗаполненииСпискаТекущихДел.
//
// Возвращаемое значение:
//  ТаблицаЗначений - определяет параметры дела:
//    * Идентификатор  - Строка - внутренний идентификатор дела, используемый подсистемой.
//    * ЕстьДела       - Булево - если Истина, дело выводится в списке текущих дел пользователя.
//    * Важное         - Булево - если Истина, дело будет выделено красным цветом.
//    * ВыводитьВОповещениях - Булево - если Истина, уведомление о деле будет дублироваться всплывающим
//                             оповещением и отображением в центре оповещений.
//    * СкрыватьВНастройках - Булево - если Истина, то дело будет скрыто в форме настроек текущих дел.
//                            Можно применять для дел, которые не предполагают многократного
//                            использования, т.е. после выполнения они для данной информационной базы
//                            больше отображаться не будут.
//    * Представление  - Строка - представление дела, выводимое пользователю.
//    * Количество     - Число  - количественный показатель дела, выводится в строке заголовка дела.
//    * Форма          - Строка - полный путь к форме, которую необходимо открыть при нажатии на гиперссылку
//                                дела на панели "Текущие дела".
//    * ПараметрыФормы - Структура - параметры, с которыми нужно открывать форму показателя.
//    * Владелец       - Строка
//                     - ОбъектМетаданных - строковый идентификатор дела, которое будет владельцем для текущего
//                       или объект метаданных подсистема.
//    * Подсказка      - Строка - текст подсказки.
//    * ОбъектВладелецДел - Строка - полное имя объекта метаданных, в котором расположен обработчик заполнения дел.
//
Функция ТекущиеДела() Экспорт
	
	ДелаПользователя = Новый ТаблицаЗначений;
	ДелаПользователя.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка", Новый КвалификаторыСтроки(250)));
	ДелаПользователя.Колонки.Добавить("ЕстьДела", Новый ОписаниеТипов("Булево"));
	ДелаПользователя.Колонки.Добавить("Важное", Новый ОписаниеТипов("Булево"));
	ДелаПользователя.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка", Новый КвалификаторыСтроки(250)));
	ДелаПользователя.Колонки.Добавить("СкрыватьВНастройках", Новый ОписаниеТипов("Булево"));
	ДелаПользователя.Колонки.Добавить("ВыводитьВОповещениях", Новый ОписаниеТипов("Булево"));
	ДелаПользователя.Колонки.Добавить("Количество", Новый ОписаниеТипов("Число"));
	ДелаПользователя.Колонки.Добавить("Форма", Новый ОписаниеТипов("Строка", Новый КвалификаторыСтроки(250)));
	ДелаПользователя.Колонки.Добавить("ПараметрыФормы", Новый ОписаниеТипов("Структура"));
	ДелаПользователя.Колонки.Добавить("Владелец");
	ДелаПользователя.Колонки.Добавить("Подсказка", Новый ОписаниеТипов("Строка", Новый КвалификаторыСтроки(250)));
	ДелаПользователя.Колонки.Добавить("ОбъектВладелецДел", Новый ОписаниеТипов("Строка", Новый КвалификаторыСтроки(256)));
	
	Возврат ДелаПользователя;
	
КонецФункции

// Возвращает массив подсистем командного интерфейса, в которые включен переданный
// объект метаданных.
//
// Параметры:
//  ИмяОбъектаМетаданных - Строка - полное имя объекта метаданных.
//
// Возвращаемое значение: 
//  Массив - массив подсистем командного интерфейса программы.
//
Функция РазделыДляОбъекта(ИмяОбъектаМетаданных) Экспорт
	ПринадлежностьОбъектов = ТекущиеДелаСлужебныйПовтИсп.ПринадлежностьОбъектовРазделамКомандногоИнтерфейса();
	
	ПодсистемыКомандногоИнтерфейса = Новый Массив;
	ИменаПодсистем                 = ПринадлежностьОбъектов.Получить(ИмяОбъектаМетаданных);
	Если ИменаПодсистем <> Неопределено Тогда
		Для Каждого ИмяПодсистемы Из ИменаПодсистем Цикл
			ПодсистемыКомандногоИнтерфейса.Добавить(Метаданные.НайтиПоПолномуИмени(ИмяПодсистемы));
		КонецЦикла;
	КонецЕсли;
	
	Если ПодсистемыКомандногоИнтерфейса.Количество() = 0 Тогда
		ПодсистемыКомандногоИнтерфейса.Добавить(Обработки.ТекущиеДела);
	КонецЕсли;
	
	Возврат ПодсистемыКомандногоИнтерфейса;
КонецФункции

// Определяет, нужно ли выводить дело в списке дел пользователя.
//
// Параметры:
//  ИдентификаторДела - Строка - идентификатор дела, которое надо искать в списке отключенных.
//
// Возвращаемое значение:
//  Булево - Истина, если дело было программно отключено и его не требуется выводить пользователю.
//
Функция ДелоОтключено(ИдентификаторДела) Экспорт
	ОтключаемыеДела = Новый Массив;
	ИнтеграцияПодсистемБСП.ПриОтключенииТекущихДел(ОтключаемыеДела);
	ТекущиеДелаПереопределяемый.ПриОтключенииТекущихДел(ОтключаемыеДела);
	
	Возврат (ОтключаемыеДела.Найти(ИдентификаторДела) <> Неопределено)
	
КонецФункции

// Возвращает структуру общих значений, используемых для расчета текущих дел.
//
// Возвращаемое значение:
//  Структура:
//    * Пользователь - СправочникСсылка.Пользователи
//                   - СправочникСсылка.ВнешниеПользователи - текущий пользователь.
//    * ЭтоПолноправныйПользователь - Булево - Истина, если пользователь полноправный.
//    * ТекущаяДата - Дата - текущая дата сеанса.
//    * ПустаяДата  - Дата - пустая дата.
//
Функция ОбщиеПараметрыЗапросов() Экспорт
	Возврат ТекущиеДелаСлужебный.ОбщиеПараметрыЗапросов();
КонецФункции

// Устанавливает общие параметры запросов для расчета текущих дел.
//
// Параметры:
//  Запрос                 - Запрос    - выполняемый запрос, которому
//                                       необходимо заполнить общие параметры.
//  ОбщиеПараметрыЗапросов - Структура - общие значения для расчета показателей.
//
Процедура УстановитьПараметрыЗапросов(Запрос, ОбщиеПараметрыЗапросов) Экспорт
	ТекущиеДелаСлужебный.УстановитьОбщиеПараметрыЗапросов(Запрос, ОбщиеПараметрыЗапросов);
КонецПроцедуры

// Получает числовые значения дел из переданного запроса.
//
// Запрос с данными должен содержать только одну строку с произвольным количеством полей.
// Значения этих полей должны являться значениями соответствующих показателей.
//
// Например, такой запрос может иметь следующий вид:
//   ВЫБРАТЬ
//      Количество(*) КАК <Имя предопределенного элемента - показателя количества документов>.
//   ИЗ
//      Документ.<Имя документа>.
//
// Параметры:
//  Запрос - Запрос - выполняемый запрос.
//  ОбщиеПараметрыЗапросов - Структура - общие значения для расчета текущих дел.
//
// Возвращаемое значение:
//  Структура:
//     * Ключ     - Строка - имя показателя текущих дел.
//     * Значение - Число - числовое значение показателя.
//
Функция ЧисловыеПоказателиТекущихДел(Запрос, ОбщиеПараметрыЗапросов = Неопределено) Экспорт
	Возврат ТекущиеДелаСлужебный.ЧисловыеПоказателиТекущихДел(Запрос, ОбщиеПараметрыЗапросов);
КонецФункции

#КонецОбласти

