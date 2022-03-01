///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

#Область ОбработчикиСлужебныхСобытий

#Область СтандартныеПодсистемы

#Область БазоваяФункциональность

// Процедура является обработчиком одноименного события, возникающего при обмене данными в распределенной информационной
// базе.
//
// Параметры:
//   см. описание обработчика события ПриОтправкеДанныхГлавному() в синтаксис-помощнике.
// 
Процедура ПриОтправкеДанныхГлавному(ЭлементДанных, ОтправкаЭлемента, Получатель) Экспорт
	
	Если ОтправкаЭлемента = ОтправкаЭлементаДанных.Игнорировать Тогда
		//
	ИначеЕсли ОбщегоНазначения.ЭтоАвтономноеРабочееМесто() Тогда
		
		Если ТипЗнч(ЭлементДанных) = Тип("СправочникОбъект.ДополнительныеОтчетыИОбработки") Тогда
			
			Если Не ЭтоОбработкаСервиса(ЭлементДанных.Ссылка) Тогда
				ОтправкаЭлемента = ОтправкаЭлементаДанных.Игнорировать;
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// Процедура является обработчиком одноименного события, возникающего при обмене данными в распределенной информационной
// базе.
//
// Параметры:
//   см. описание обработчика события ПриОтправкеДанныхПодчиненному() в синтаксис-помощнике.
// 
Процедура ПриОтправкеДанныхПодчиненному(ЭлементДанных, ОтправкаЭлемента, СозданиеНачальногоОбраза, Получатель) Экспорт
	
	Если Не ОбщегоНазначения.РазделениеВключено() Тогда
		Возврат;
	КонецЕсли;
	
	Если ОтправкаЭлемента = ОтправкаЭлементаДанных.Удалить
		ИЛИ ОтправкаЭлемента = ОтправкаЭлементаДанных.Игнорировать Тогда
		Возврат;
	КонецЕсли;
		
	Если ТипЗнч(ЭлементДанных) = Тип("СправочникОбъект.ДополнительныеОтчетыИОбработки") Тогда
		Если ДополнительныеОтчетыИОбработкиВМоделиСервиса.ЭтоПоставляемаяОбработка(ЭлементДанных.Ссылка) Тогда
			ПараметрыЗапускаОбработки = ДополнительныеОтчетыИОбработкиВМоделиСервиса.ПараметрыПодключенияИспользуемойОбработки(ЭлементДанных.Ссылка);
			ЗаполнитьЗначенияСвойств(ЭлементДанных, ПараметрыЗапускаОбработки);
		КонецЕсли;
	КонецЕсли;
	
	Если ТипЗнч(ЭлементДанных) = Тип("КонстантаМенеджерЗначения.ИспользоватьДополнительныеОтчетыИОбработки") Тогда
		Если Не СозданиеНачальногоОбраза Тогда
			ОтправкаЭлемента = ОтправкаЭлементаДанных.Игнорировать;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

// Процедура является обработчиком одноименного события, возникающего при обмене данными в распределенной информационной
// базе.
//
// Параметры:
//   см. описание обработчика события ПриПолученииДанныхОтГлавного() в синтаксис-помощнике.
// 
Процедура ПриПолученииДанныхОтГлавного(ЭлементДанных, ПолучениеЭлемента, ОтправкаНазад, Отправитель) Экспорт
	
	Если ПолучениеЭлемента = ПолучениеЭлементаДанных.Игнорировать Тогда
		
		// Стандартную обработку не переопределяем
		
	ИначеЕсли ОбщегоНазначения.ЭтоАвтономноеРабочееМесто() Тогда
		
		Если ТипЗнч(ЭлементДанных) = Тип("СправочникОбъект.ДополнительныеОтчетыИОбработки") Тогда
			
			Если ЗначениеЗаполнено(ЭлементДанных.Ссылка) Тогда
				СсылкаОбработки = ЭлементДанных.Ссылка;
			Иначе
				СсылкаОбработки = ЭлементДанных.ПолучитьСсылкуНового();
			КонецЕсли;
			
			ЗарегистрироватьОбработкуСервиса(СсылкаОбработки);
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// Процедура является обработчиком одноименного события, возникающего при обмене данными в распределенной информационной
// базе.
//
// Параметры:
//   см. описание обработчика события ПриПолученииДанныхОтПодчиненного() в синтаксис-помощнике.
// 
Процедура ПриПолученииДанныхОтПодчиненного(ЭлементДанных, ПолучениеЭлемента, ОтправкаНазад, Отправитель) Экспорт
	
	Если Не ОбщегоНазначения.РазделениеВключено() Тогда
		Возврат;
	КонецЕсли;
	
	Если ПолучениеЭлемента = ПолучениеЭлементаДанных.Игнорировать Тогда
		
		// Стандартную обработку не переопределяем
		
	Иначе
		
		Если ТипЗнч(ЭлементДанных) = Тип("СправочникОбъект.ДополнительныеОтчетыИОбработки") Тогда
			
			Если ДополнительныеОтчетыИОбработкиВМоделиСервиса.ЭтоПоставляемаяОбработка(ЭлементДанных.Ссылка) Тогда
				
				ПараметрыЗапускаОбработки = ДополнительныеОтчетыИОбработкиВМоделиСервиса.ПараметрыПодключенияИспользуемойОбработки(ЭлементДанных.Ссылка);
				ЗаполнитьЗначенияСвойств(ЭлементДанных, ПараметрыЗапускаОбработки);
				ЭлементДанных.ХранилищеОбработки = Неопределено;
				
			Иначе
				
				Если Не ПолучитьФункциональнуюОпцию("НезависимоеИспользованиеДополнительныхОтчетовИОбработокВМоделиСервиса") Тогда
					ПолучениеЭлемента = ПолучениеЭлементаДанных.Игнорировать;
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ДополнительныеОтчетыИОбработки

// Вызывается при определении наличия у текущего пользователя права на добавление дополнительного
// отчета или обработки в область данных.
//
// Параметры:
//  ДополнительнаяОбработка - СправочникОбъект.ДополнительныеОтчетыИОбработки, элемент справочника,
//    который записывается пользователем.
//  Результат - Булево - в этот параметр в данной процедуре устанавливается флаг наличия права,
//  СтандартнаяОбработка - Булево - в этот параметр в данной процедуре устанавливается флаг выполнения
//    стандартной обработки проверки права.
//
Процедура ПриПроверкеПраваДобавления(Знач ДополнительнаяОбработка, Результат, СтандартнаяОбработка) Экспорт
	
	Если ОбщегоНазначения.ЭтоАвтономноеРабочееМесто() Тогда
		
		Результат = Истина;
		СтандартнаяОбработка = Ложь;
		Возврат;
		
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при проверке возможности загрузки дополнительного отчета или обработки из файла.
//
// Параметры:
//  ДополнительнаяОбработка - СправочникСсылка.ДополнительныеОтчетыИОбработки,
//  Результат - Булево - в этот параметр в данной процедуре устанавливается флаг наличия возможности
//    загрузки дополнительного отчета или обработки из файла,
//  СтандартнаяОбработка - Булево - в этот параметр в данной процедуре устанавливается флаг выполнения
//    стандартной обработки проверки возможности загрузки дополнительного отчета или обработки из файла.
//
Процедура ПриПроверкеВозможностиЗагрузкиОбработкиИзФайла(Знач ДополнительнаяОбработка, Результат, СтандартнаяОбработка) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если ОбщегоНазначения.ЭтоАвтономноеРабочееМесто() Тогда
		
		Результат = Не ЭтоОбработкаСервиса(ДополнительнаяОбработка);
		СтандартнаяОбработка = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при проверке возможности выгрузки дополнительного отчета или обработки в файл.
//
// Параметры:
//  ДополнительнаяОбработка - СправочникСсылка.ДополнительныеОтчетыИОбработки,
//  Результат - Булево - в этот параметр в данной процедуре устанавливается флаг наличия возможности
//    выгрузки дополнительного отчета или обработки в файл,
//  СтандартнаяОбработка - Булево - в этот параметр в данной процедуре устанавливается флаг выполнения
//    стандартной обработки проверки возможности выгрузки дополнительного отчета или обработки в файл.
//
Процедура ПриПроверкеВозможностиВыгрузкиОбработкиВФайл(Знач ДополнительнаяОбработка, Результат, СтандартнаяОбработка) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если ОбщегоНазначения.ЭтоАвтономноеРабочееМесто() Тогда
		
		Результат = Не ЭтоОбработкаСервиса(ДополнительнаяОбработка);
		СтандартнаяОбработка = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

// Заполняет виды публикации дополнительных отчетов и обработок, недоступные для использования
// в текущей модели информационной базы.
//
// Параметры:
//  НедоступныеВидыПубликации - Массив из Строка
//
Процедура ПриЗаполненииНедоступныхВидовПубликации(Знач НедоступныеВидыПубликации) Экспорт
	
	Если ОбщегоНазначения.ЭтоАвтономноеРабочееМесто() Тогда
		НедоступныеВидыПубликации.Добавить("РежимОтладки");
	КонецЕсли;
	
КонецПроцедуры

// Процедура должна вызываться из события ПередЗаписью справочника
//  ДополнительныеОтчетыИОбработки, выполняет проверку правомерности изменения реквизитов
//  элементов данного справочника для дополнительных обработок, полученных из
//  каталога дополнительных обработок менеджера сервиса.
//
// Параметры:
//  Источник - СправочникОбъект.ДополнительныеОтчетыИОбработки,
//  Отказ - Булево - флаг отказа от выполнения записи элемента справочника.
//
Процедура ПередЗаписьюДополнительнойОбработки(Источник, Отказ) Экспорт
	
	Если Источник.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ОбщегоНазначения.ЭтоАвтономноеРабочееМесто() Тогда
		
		Если (Источник.ПометкаУдаления ИЛИ Источник.Публикация = Перечисления.ВариантыПубликацииДополнительныхОтчетовИОбработок.Отключена) И ЭтоОбработкаСервиса(Источник.Ссылка) Тогда
			
			ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Дополнительный отчет или обработка %1 был загружен из сервиса и не может быть отключен из автономного рабочего места.
					|Для удаления дополнительного отчета или обработки выполните операцию отключения в
					|приложении сервиса и проведите синхронизацию данных автономного рабочего места с сервисом.'"),
				Источник.Наименование);
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Регистрирует дополнительный отчет иди обработку в качестве обработки, полученной
// в автономное рабочее место из сервиса.
//
// Параметры:
//  Ссылка - СправочникСсылка.ДополнительныеОтчетыИОбработки.
//
Процедура ЗарегистрироватьОбработкуСервиса(Знач Ссылка)
	
	Набор = РегистрыСведений.ИспользованиеДополнительныхОтчетовИОбработокСервисаВАвтономномРабочемМесте.СоздатьНаборЗаписей();
	Набор.Отбор.ДополнительныйОтчетИлиОбработка.Установить(Ссылка);
	Запись = Набор.Добавить();
	Запись.ДополнительныйОтчетИлиОбработка = Ссылка;
	Запись.Поставляемый = Истина;
	Набор.Записать();
	
КонецПроцедуры

// Функция проверяет, была ли дополнительная обработка получена в автономное рабочее место из сервиса.
//
// Параметры:
//   Ссылка - СправочникСсылка.ДополнительныеОтчетыИОбработки.
//
// Возвращаемое значение:
//  Булево
//
Функция ЭтоОбработкаСервиса(Ссылка)
	
	Менеджер = РегистрыСведений.ИспользованиеДополнительныхОтчетовИОбработокСервисаВАвтономномРабочемМесте.СоздатьМенеджерЗаписи();
	Менеджер.ДополнительныйОтчетИлиОбработка = Ссылка;
	Менеджер.Прочитать();
	
	Если Менеджер.Выбран() Тогда
		Возврат Менеджер.Поставляемый;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

#КонецОбласти
