# kindergarten-the-sun
Login: andriy.yarchak.20@creative-shark-ss3ocy.com
Password:  kindergarten17
GitHub: https://github.com/BOEHKOMAT/kindergarten-the-sun/tree/master

### Опис проекту:
Згідно теми проекту створив:
##### Ролі та Профайли:
- Teacher
- Manager
##### Основні моделі об‘єктів:
- Teacher
- Kid
- Parent
##### Допоміжні кастомні:
- Visit
- Group
##### Використав стандартні:
- Cases
- Reports

Основні сутності це Вчитель Дитина Батько (Teacher, Kid, Parent Record types of Contact).

*Teacher* - це Юзер з профілем та роллю Teacher і відповідним рекордом типу Teacher прив‘язаним до цього Юзера. До Юзера, за наявності, приєднується група вказана у його відповідному рекорді.
*Kid* - це Дитина. Особливості: має поля Батька та Групи.
*Parent* - це відповідно хтось із Батьків.

Ролі та відповідні профайли *Manager* i *Teacher* та надаються юзерам при створенні.

*Teacher* - Юзер з таким профілем та роллю має доступ Лише до своєї Групи, відповідних їй Дітей, їх Батьків та Відвідуваність(Візити). Створювати Вчитель може тільки Візити, також редагувати їх для указання з ким Дитина прийшла. Працює Вчитель на сторінці своєї Групи, за наявності такої.

Решту клопоту щодо адміністрування бере на себе Менеджер
*Manager* - Юзер з таким профілем та роллю має доступ до усього та може змінювати усе (наприклад: переходи Дітей/Вчителів між Групами, редагування інформації рекордів тощо). Також менеджеру доступні усі Cases, у яких вказуються проблеми (згідно теми наявною проблемою може виникнути лише відсутність дитини). Reports створенні для моніторингу Відвідуваності Дітей (по місяцях/ тижнях).

Левову частку бізнес логіки становить зміна та/або передавання прав (надання доступу) на рекорд залежно від дії. 
Доступ до тих чи інших рекордів для кожного Вчителя реалізовано за допомогою:
- ієрархії ролей (Менеджер бачить УСІ записи, оскільки він "вище" Вчителя) 
- OWD Private для Kid(Contact), Visit i Group (Вчитель матиме доступ лише до тих Дітей Групи і Візитів, власником яких він являється)
- Profiles (уже було вище згадано у описі роллі та профайлу)
- Manual Sharing (пов'язано з Батьками, адже у Батьків може бути декілька дітей в різних групах, тому і декілька Вчителів мають мати доступ до Батька)
Так чи інакше усі сутності тісно пов'язані між собою тому при зміні власника у однієї треба змінювати і у релевантних рекордів. Вручну Менеджер загнеться) це робити, тому вся логіка Шерінгу реалізована у flows.

### Список класів та тригерів:
- ContactTrigger(ContactTriggerHandler) - перевіряє чи достатньо місця у Групі, яку присвоюються Дитині; якщо Групі присвоюють Вчителя, перевіряє чи його у групи уже є Вчитель.
- VisitTrigger(VisitTriggerHandler) - перевіряє чи уже відмічали сьогодні конкретну Дитину
- GroupController - отримує з бази даних рекорди Дітей для конкретної Групи, та тих хто найбільше відвідував садок протягом місяця/тижня також конкретної групи.
- ContactTriggerTest
- VisitTriggerTest
- GroupControllerTest
- TestDataFactory
### Список lwc компонент:
- kidsList - імплементує lightning-datatable для створення "сторінки журналу" для відмічання Дітей відповідної Групи. Використовується на RecordPage Групи
- topKids - показує Дітей відповідної групи, які найбільше відвідували садок протягом місяця/тижня. Використовується аналогічно.
Список flows:
- Set Group Owner - коли Вчитель отримує нову групу, то до усіх, релевантних старій групі, рекордів Дітей i Батьків доступ закривається, а для релевантних новій - надається. До покинутої групи, до призначення їй нового вчителя, має доступ лише Менеджер.
- Set Kid Owner - коли Дитина змінює або покидає групу, доступ до неї у відповідних Вчителів змінюється. Якщо просто покидає, то рекорд доступний лише Менеджеру.
- Set Visit Owner - при створенні Візиту, робить творця власником рекорду
- Parent1 Sharing - при зміні Дитиною групи від "старого" Вчителя забирається доступ до Батьківського рекорду і надається "новому" Вчителю. Якщо просто покидає групу, то - Батьківський рекорд доступний лише Менеджеру.
Також при зміні дитиною Батька, доступ до "старого" Батька  у Вчителя Дитини забирається, і надається до "нового". Це все за умови відсутності інших Дітей "старого" Батька у групі Вчителя
- User-Teacher - при створенні рекордуВчителя, переносить усі дані вказаного Юзера, у відповідні поля, та запобігає їх зміні, поки вказаний даний Юзер. При виборі для даного рекорду нового Юзера поля перезапишуться.
- Default Account - Встановлює для будь якого Contact рекорду Account "Chikago"
- Visit owner sharing - встановлює доступ до Візитів дітей конкретної Групи для Вчителя, відповідно до покидання/(переходу)  Дітьми чи самим Вчителями (між) групами.
- Check The Absents - кожного дня о 11:00 перевіряє які діти відсутні, та створює для кожного Кейс з проблемою та надсилає лист Батьку. (Я відключив надсилання листа через обмеження, але при дебагу все працює - листи надсилав собі на пошту)

