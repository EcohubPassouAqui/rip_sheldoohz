local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local EcoHub = {}
EcoHub.Version = "1.0.0"

-- Biblioteca completa de ícones Lucide
local IconLibrary = {
	["accessibility"] = "rbxassetid://10709751939",
	["activity"] = "rbxassetid://10709752035",
	["air-vent"] = "rbxassetid://10709752131",
	["airplay"] = "rbxassetid://10709752254",
	["alarm-check"] = "rbxassetid://10709752405",
	["alarm-clock"] = "rbxassetid://10709752630",
	["alarm-clock-off"] = "rbxassetid://10709752508",
	["alarm-minus"] = "rbxassetid://10709752732",
	["alarm-plus"] = "rbxassetid://10709752825",
	["album"] = "rbxassetid://10709752906",
	["alert-circle"] = "rbxassetid://10709752996",
	["alert-octagon"] = "rbxassetid://10709753064",
	["alert-triangle"] = "rbxassetid://10709753149",
	["align-center"] = "rbxassetid://10709753570",
	["align-center-horizontal"] = "rbxassetid://10709753272",
	["align-center-vertical"] = "rbxassetid://10709753421",
	["align-end-horizontal"] = "rbxassetid://10709753692",
	["align-end-vertical"] = "rbxassetid://10709753808",
	["align-horizontal-distribute-center"] = "rbxassetid://10747779791",
	["align-horizontal-distribute-end"] = "rbxassetid://10747784534",
	["align-horizontal-distribute-start"] = "rbxassetid://10709754118",
	["align-horizontal-justify-center"] = "rbxassetid://10709754204",
	["align-horizontal-justify-end"] = "rbxassetid://10709754317",
	["align-horizontal-justify-start"] = "rbxassetid://10709754436",
	["align-horizontal-space-around"] = "rbxassetid://10709754590",
	["align-horizontal-space-between"] = "rbxassetid://10709754749",
	["align-justify"] = "rbxassetid://10709759610",
	["align-left"] = "rbxassetid://10709759764",
	["align-right"] = "rbxassetid://10709759895",
	["align-start-horizontal"] = "rbxassetid://10709760051",
	["align-start-vertical"] = "rbxassetid://10709760244",
	["align-vertical-distribute-center"] = "rbxassetid://10709760351",
	["align-vertical-distribute-end"] = "rbxassetid://10709760434",
	["align-vertical-distribute-start"] = "rbxassetid://10709760612",
	["align-vertical-justify-center"] = "rbxassetid://10709760814",
	["align-vertical-justify-end"] = "rbxassetid://10709761003",
	["align-vertical-justify-start"] = "rbxassetid://10709761176",
	["align-vertical-space-around"] = "rbxassetid://10709761324",
	["align-vertical-space-between"] = "rbxassetid://10709761434",
	["anchor"] = "rbxassetid://10709761530",
	["angry"] = "rbxassetid://10709761629",
	["annoyed"] = "rbxassetid://10709761722",
	["aperture"] = "rbxassetid://10709761813",
	["apple"] = "rbxassetid://10709761889",
	["archive"] = "rbxassetid://10709762233",
	["archive-restore"] = "rbxassetid://10709762058",
	["armchair"] = "rbxassetid://10709762327",
	["arrow-big-down"] = "rbxassetid://10747796644",
	["arrow-big-left"] = "rbxassetid://10709762574",
	["arrow-big-right"] = "rbxassetid://10709762727",
	["arrow-big-up"] = "rbxassetid://10709762879",
	["arrow-down"] = "rbxassetid://10709767827",
	["arrow-down-circle"] = "rbxassetid://10709763034",
	["arrow-down-left"] = "rbxassetid://10709767656",
	["arrow-down-right"] = "rbxassetid://10709767750",
	["arrow-left"] = "rbxassetid://10709768114",
	["arrow-left-circle"] = "rbxassetid://10709767936",
	["arrow-left-right"] = "rbxassetid://10709768019",
	["arrow-right"] = "rbxassetid://10709768347",
	["arrow-right-circle"] = "rbxassetid://10709768226",
	["arrow-up"] = "rbxassetid://10709768939",
	["arrow-up-circle"] = "rbxassetid://10709768432",
	["arrow-up-down"] = "rbxassetid://10709768538",
	["arrow-up-left"] = "rbxassetid://10709768661",
	["arrow-up-right"] = "rbxassetid://10709768787",
	["asterisk"] = "rbxassetid://10709769095",
	["at-sign"] = "rbxassetid://10709769286",
	["award"] = "rbxassetid://10709769406",
	["axe"] = "rbxassetid://10709769508",
	["axis-3d"] = "rbxassetid://10709769598",
	["baby"] = "rbxassetid://10709769732",
	["backpack"] = "rbxassetid://10709769841",
	["baggage-claim"] = "rbxassetid://10709769935",
	["banana"] = "rbxassetid://10709770005",
	["banknote"] = "rbxassetid://10709770178",
	["bar-chart"] = "rbxassetid://10709773755",
	["bar-chart-2"] = "rbxassetid://10709770317",
	["bar-chart-3"] = "rbxassetid://10709770431",
	["bar-chart-4"] = "rbxassetid://10709770560",
	["bar-chart-horizontal"] = "rbxassetid://10709773669",
	["barcode"] = "rbxassetid://10747360675",
	["baseline"] = "rbxassetid://10709773863",
	["bath"] = "rbxassetid://10709773963",
	["battery"] = "rbxassetid://10709774640",
	["battery-charging"] = "rbxassetid://10709774068",
	["battery-full"] = "rbxassetid://10709774206",
	["battery-low"] = "rbxassetid://10709774370",
	["battery-medium"] = "rbxassetid://10709774513",
	["beaker"] = "rbxassetid://10709774756",
	["bed"] = "rbxassetid://10709775036",
	["bed-double"] = "rbxassetid://10709774864",
	["bed-single"] = "rbxassetid://10709774968",
	["beer"] = "rbxassetid://10709775167",
	["bell"] = "rbxassetid://10709775704",
	["bell-minus"] = "rbxassetid://10709775241",
	["bell-off"] = "rbxassetid://10709775320",
	["bell-plus"] = "rbxassetid://10709775448",
	["bell-ring"] = "rbxassetid://10709775560",
	["bike"] = "rbxassetid://10709775894",
	["binary"] = "rbxassetid://10709776050",
	["bitcoin"] = "rbxassetid://10709776126",
	["bluetooth"] = "rbxassetid://10709776655",
	["bluetooth-connected"] = "rbxassetid://10709776240",
	["bluetooth-off"] = "rbxassetid://10709776344",
	["bluetooth-searching"] = "rbxassetid://10709776501",
	["bold"] = "rbxassetid://10747813908",
	["bomb"] = "rbxassetid://10709781460",
	["bone"] = "rbxassetid://10709781605",
	["book"] = "rbxassetid://10709781824",
	["book-open"] = "rbxassetid://10709781717",
	["bookmark"] = "rbxassetid://10709782154",
	["bookmark-minus"] = "rbxassetid://10709781919",
	["bookmark-plus"] = "rbxassetid://10709782044",
	["bot"] = "rbxassetid://10709782230",
	["box"] = "rbxassetid://10709782497",
	["box-select"] = "rbxassetid://10709782342",
	["boxes"] = "rbxassetid://10709782582",
	["briefcase"] = "rbxassetid://10709782662",
	["brush"] = "rbxassetid://10709782758",
	["bug"] = "rbxassetid://10709782845",
	["building"] = "rbxassetid://10709783051",
	["building-2"] = "rbxassetid://10709782939",
	["bus"] = "rbxassetid://10709783137",
	["cake"] = "rbxassetid://10709783217",
	["calculator"] = "rbxassetid://10709783311",
	["calendar"] = "rbxassetid://10709789505",
	["calendar-check"] = "rbxassetid://10709783474",
	["calendar-check-2"] = "rbxassetid://10709783392",
	["calendar-clock"] = "rbxassetid://10709783577",
	["calendar-days"] = "rbxassetid://10709783673",
	["calendar-heart"] = "rbxassetid://10709783835",
	["calendar-minus"] = "rbxassetid://10709783959",
	["calendar-off"] = "rbxassetid://10709788784",
	["calendar-plus"] = "rbxassetid://10709788937",
	["calendar-range"] = "rbxassetid://10709789053",
	["calendar-search"] = "rbxassetid://10709789200",
	["calendar-x"] = "rbxassetid://10709789407",
	["calendar-x-2"] = "rbxassetid://10709789329",
	["camera"] = "rbxassetid://10709789686",
	["camera-off"] = "rbxassetid://10747822677",
	["car"] = "rbxassetid://10709789810",
	["carrot"] = "rbxassetid://10709789960",
	["cast"] = "rbxassetid://10709790097",
	["charge"] = "rbxassetid://10709790202",
	["check"] = "rbxassetid://10709790644",
	["check-circle"] = "rbxassetid://10709790387",
	["check-circle-2"] = "rbxassetid://10709790298",
	["check-square"] = "rbxassetid://10709790537",
	["chef-hat"] = "rbxassetid://10709790757",
	["cherry"] = "rbxassetid://10709790875",
	["chevron-down"] = "rbxassetid://10709790948",
	["chevron-first"] = "rbxassetid://10709791015",
	["chevron-last"] = "rbxassetid://10709791130",
	["chevron-left"] = "rbxassetid://10709791281",
	["chevron-right"] = "rbxassetid://10709791437",
	["chevron-up"] = "rbxassetid://10709791523",
	["chevrons-down"] = "rbxassetid://10709796864",
	["chevrons-down-up"] = "rbxassetid://10709791632",
	["chevrons-left"] = "rbxassetid://10709797151",
	["chevrons-left-right"] = "rbxassetid://10709797006",
	["chevrons-right"] = "rbxassetid://10709797382",
	["chevrons-right-left"] = "rbxassetid://10709797274",
	["chevrons-up"] = "rbxassetid://10709797622",
	["chevrons-up-down"] = "rbxassetid://10709797508",
	["chrome"] = "rbxassetid://10709797725",
	["circle"] = "rbxassetid://10709798174",
	["circle-dot"] = "rbxassetid://10709797837",
	["circle-ellipsis"] = "rbxassetid://10709797985",
	["circle-slashed"] = "rbxassetid://10709798100",
	["citrus"] = "rbxassetid://10709798276",
	["clapperboard"] = "rbxassetid://10709798350",
	["clipboard"] = "rbxassetid://10709799288",
	["clipboard-check"] = "rbxassetid://10709798443",
	["clipboard-copy"] = "rbxassetid://10709798574",
	["clipboard-edit"] = "rbxassetid://10709798682",
	["clipboard-list"] = "rbxassetid://10709798792",
	["clipboard-signature"] = "rbxassetid://10709798890",
	["clipboard-type"] = "rbxassetid://10709798999",
	["clipboard-x"] = "rbxassetid://10709799124",
	["clock"] = "rbxassetid://10709805144",
	["clock-1"] = "rbxassetid://10709799535",
	["clock-10"] = "rbxassetid://10709799718",
	["clock-11"] = "rbxassetid://10709799818",
	["clock-12"] = "rbxassetid://10709799962",
	["clock-2"] = "rbxassetid://10709803876",
	["clock-3"] = "rbxassetid://10709803989",
	["clock-4"] = "rbxassetid://10709804164",
	["clock-5"] = "rbxassetid://10709804291",
	["clock-6"] = "rbxassetid://10709804435",
	["clock-7"] = "rbxassetid://10709804599",
	["clock-8"] = "rbxassetid://10709804784",
	["clock-9"] = "rbxassetid://10709804996",
	["cloud"] = "rbxassetid://10709806740",
	["cloud-cog"] = "rbxassetid://10709805262",
	["cloud-drizzle"] = "rbxassetid://10709805371",
	["cloud-fog"] = "rbxassetid://10709805477",
	["cloud-hail"] = "rbxassetid://10709805596",
	["cloud-lightning"] = "rbxassetid://10709805727",
	["cloud-moon"] = "rbxassetid://10709805942",
	["cloud-moon-rain"] = "rbxassetid://10709805838",
	["cloud-off"] = "rbxassetid://10709806060",
	["cloud-rain"] = "rbxassetid://10709806277",
	["cloud-rain-wind"] = "rbxassetid://10709806166",
	["cloud-snow"] = "rbxassetid://10709806374",
	["cloud-sun"] = "rbxassetid://10709806631",
	["cloud-sun-rain"] = "rbxassetid://10709806475",
	["cloudy"] = "rbxassetid://10709806859",
	["clover"] = "rbxassetid://10709806995",
	["code"] = "rbxassetid://10709810463",
	["code-2"] = "rbxassetid://10709807111",
	["codepen"] = "rbxassetid://10709810534",
	["codesandbox"] = "rbxassetid://10709810676",
	["coffee"] = "rbxassetid://10709810814",
	["cog"] = "rbxassetid://10709810948",
	["coins"] = "rbxassetid://10709811110",
	["columns"] = "rbxassetid://10709811261",
	["command"] = "rbxassetid://10709811365",
	["compass"] = "rbxassetid://10709811445",
	["component"] = "rbxassetid://10709811595",
	["concierge-bell"] = "rbxassetid://10709811706",
	["connection"] = "rbxassetid://10747361219",
	["contact"] = "rbxassetid://10709811834",
	["contrast"] = "rbxassetid://10709811939",
	["cookie"] = "rbxassetid://10709812067",
	["copy"] = "rbxassetid://10709812159",
	["copyleft"] = "rbxassetid://10709812251",
	["copyright"] = "rbxassetid://10709812311",
	["corner-down-left"] = "rbxassetid://10709812396",
	["corner-down-right"] = "rbxassetid://10709812485",
	["corner-left-down"] = "rbxassetid://10709812632",
	["corner-left-up"] = "rbxassetid://10709812784",
	["corner-right-down"] = "rbxassetid://10709812939",
	["corner-right-up"] = "rbxassetid://10709813094",
	["corner-up-left"] = "rbxassetid://10709813185",
	["corner-up-right"] = "rbxassetid://10709813281",
	["cpu"] = "rbxassetid://10709813383",
	["croissant"] = "rbxassetid://10709818125",
	["crop"] = "rbxassetid://10709818245",
	["cross"] = "rbxassetid://10709818399",
	["crosshair"] = "rbxassetid://10709818534",
	["crown"] = "rbxassetid://10709818626",
	["cup-soda"] = "rbxassetid://10709818763",
	["curly-braces"] = "rbxassetid://10709818847",
	["currency"] = "rbxassetid://10709818931",
	["database"] = "rbxassetid://10709818996",
	["delete"] = "rbxassetid://10709819059",
	["diamond"] = "rbxassetid://10709819149",
	["dice-1"] = "rbxassetid://10709819266",
	["dice-2"] = "rbxassetid://10709819361",
	["dice-3"] = "rbxassetid://10709819508",
	["dice-4"] = "rbxassetid://10709819670",
	["dice-5"] = "rbxassetid://10709819801",
	["dice-6"] = "rbxassetid://10709819896",
	["dices"] = "rbxassetid://10723343321",
	["diff"] = "rbxassetid://10723343416",
	["disc"] = "rbxassetid://10723343537",
	["divide"] = "rbxassetid://10723343805",
	["divide-circle"] = "rbxassetid://10723343636",
	["divide-square"] = "rbxassetid://10723343737",
	["dollar-sign"] = "rbxassetid://10723343958",
	["download"] = "rbxassetid://10723344270",
	["download-cloud"] = "rbxassetid://10723344088",
	["droplet"] = "rbxassetid://10723344432",
	["droplets"] = "rbxassetid://10734883356",
	["drumstick"] = "rbxassetid://10723344737",
	["edit"] = "rbxassetid://10734883598",
	["edit-2"] = "rbxassetid://10723344885",
	["edit-3"] = "rbxassetid://10723345088",
	["egg"] = "rbxassetid://10723345518",
	["egg-fried"] = "rbxassetid://10723345347",
	["electricity"] = "rbxassetid://10723345749",
	["electricity-off"] = "rbxassetid://10723345643",
	["equal"] = "rbxassetid://10723345990",
	["equal-not"] = "rbxassetid://10723345866",
	["eraser"] = "rbxassetid://10723346158",
	["euro"] = "rbxassetid://10723346372",
	["expand"] = "rbxassetid://10723346553",
	["external-link"] = "rbxassetid://10723346684",
	["eye"] = "rbxassetid://10723346959",
	["eye-off"] = "rbxassetid://10723346871",
	["factory"] = "rbxassetid://10723347051",
	["fan"] = "rbxassetid://10723354359",
	["fast-forward"] = "rbxassetid://10723354521",
	["feather"] = "rbxassetid://10723354671",
	["figma"] = "rbxassetid://10723354801",
	["file"] = "rbxassetid://10723374641",
	["file-archive"] = "rbxassetid://10723354921",
	["file-audio"] = "rbxassetid://10723355148",
	["file-audio-2"] = "rbxassetid://10723355026",
	["file-axis-3d"] = "rbxassetid://10723355272",
	["file-badge"] = "rbxassetid://10723355622",
	["file-badge-2"] = "rbxassetid://10723355451",
	["file-bar-chart"] = "rbxassetid://10723355887",
	["file-bar-chart-2"] = "rbxassetid://10723355746",
	["file-box"] = "rbxassetid://10723355989",
	["file-check"] = "rbxassetid://10723356210",
	["file-check-2"] = "rbxassetid://10723356100",
	["file-clock"] = "rbxassetid://10723356329",
	["file-code"] = "rbxassetid://10723356507",
	["file-cog"] = "rbxassetid://10723356830",
	["file-cog-2"] = "rbxassetid://10723356676",
	["file-diff"] = "rbxassetid://10723357039",
	["file-digit"] = "rbxassetid://10723357151",
	["file-down"] = "rbxassetid://10723357322",
	["file-edit"] = "rbxassetid://10723357495",
	["file-heart"] = "rbxassetid://10723357637",
	["file-image"] = "rbxassetid://10723357790",
	["file-input"] = "rbxassetid://10723357933",
	["file-json"] = "rbxassetid://10723364435",
	["file-json-2"] = "rbxassetid://10723364361",
	["file-key"] = "rbxassetid://10723364605",
	["file-key-2"] = "rbxassetid://10723364515",
	["file-line-chart"] = "rbxassetid://10723364725",
	["file-lock"] = "rbxassetid://10723364957",
	["file-lock-2"] = "rbxassetid://10723364861",
	["file-minus"] = "rbxassetid://10723365254",
	["file-minus-2"] = "rbxassetid://10723365086",
	["file-output"] = "rbxassetid://10723365457",
	["file-pie-chart"] = "rbxassetid://10723365598",
	["file-plus"] = "rbxassetid://10723365877",
	["file-plus-2"] = "rbxassetid://10723365766",
	["file-question"] = "rbxassetid://10723365987",
	["file-scan"] = "rbxassetid://10723366167",
	["file-search"] = "rbxassetid://10723366550",
	["file-search-2"] = "rbxassetid://10723366340",
	["file-signature"] = "rbxassetid://10723366741",
	["file-spreadsheet"] = "rbxassetid://10723366962",
	["file-symlink"] = "rbxassetid://10723367098",
	["file-terminal"] = "rbxassetid://10723367244",
	["file-text"] = "rbxassetid://10723367380",
	["file-type"] = "rbxassetid://10723367606",
	["file-type-2"] = "rbxassetid://10723367509",
	["file-up"] = "rbxassetid://10723367734",
	["file-video"] = "rbxassetid://10723373884",
	["file-video-2"] = "rbxassetid://10723367834",
	["file-volume"] = "rbxassetid://10723374172",
	["file-volume-2"] = "rbxassetid://10723374030",
	["file-warning"] = "rbxassetid://10723374276",
	["file-x"] = "rbxassetid://10723374544",
	["file-x-2"] = "rbxassetid://10723374378",
	["files"] = "rbxassetid://10723374759",
	["film"] = "rbxassetid://10723374981",
	["filter"] = "rbxassetid://10723375128",
	["fingerprint"] = "rbxassetid://10723375250",
	["flag"] = "rbxassetid://10723375890",
	["flag-off"] = "rbxassetid://10723375443",
	["flag-triangle-left"] = "rbxassetid://10723375608",
	["flag-triangle-right"] = "rbxassetid://10723375727",
	["flame"] = "rbxassetid://10723376114",
	["flashlight"] = "rbxassetid://10723376471",
	["flashlight-off"] = "rbxassetid://10723376365",
	["flask-conical"] = "rbxassetid://10734883986",
	["flask-round"] = "rbxassetid://10723376614",
	["flip-horizontal"] = "rbxassetid://10723376884",
	["flip-horizontal-2"] = "rbxassetid://10723376745",
	["flip-vertical"] = "rbxassetid://10723377138",
	["flip-vertical-2"] = "rbxassetid://10723377026",
	["flower"] = "rbxassetid://10747830374",
	["flower-2"] = "rbxassetid://10723377305",
	["focus"] = "rbxassetid://10723377537",
	["folder"] = "rbxassetid://10723387563",
	["folder-archive"] = "rbxassetid://10723384478",
	["folder-check"] = "rbxassetid://10723384605",
	["folder-clock"] = "rbxassetid://10723384731",
	["folder-closed"] = "rbxassetid://10723384893",
	["folder-cog"] = "rbxassetid://10723385213",
	["folder-cog-2"] = "rbxassetid://10723385036",
	["folder-down"] = "rbxassetid://10723385338",
	["folder-edit"] = "rbxassetid://10723385445",
	["folder-heart"] = "rbxassetid://10723385545",
	["folder-input"] = "rbxassetid://10723385721",
	["folder-key"] = "rbxassetid://10723385848",
	["folder-lock"] = "rbxassetid://10723386005",
	["folder-minus"] = "rbxassetid://10723386127",
	["folder-open"] = "rbxassetid://10723386277",
	["folder-output"] = "rbxassetid://10723386386",
	["folder-plus"] = "rbxassetid://10723386531",
	["folder-search"] = "rbxassetid://10723386787",
	["folder-search-2"] = "rbxassetid://10723386674",
	["folder-symlink"] = "rbxassetid://10723386930",
	["folder-tree"] = "rbxassetid://10723387085",
	["folder-up"] = "rbxassetid://10723387265",
	["folder-x"] = "rbxassetid://10723387448",
	["folders"] = "rbxassetid://10723387721",
	["form-input"] = "rbxassetid://10723387841",
	["forward"] = "rbxassetid://10723388016",
	["frame"] = "rbxassetid://10723394389",
	["framer"] = "rbxassetid://10723394565",
	["frown"] = "rbxassetid://10723394681",
	["fuel"] = "rbxassetid://10723394846",
	["function-square"] = "rbxassetid://10723395041",
	["gamepad"] = "rbxassetid://10723395457",
	["gamepad-2"] = "rbxassetid://10723395215",
	["gauge"] = "rbxassetid://10723395708",
	["gavel"] = "rbxassetid://10723395896",
	["gem"] = "rbxassetid://10723396000",
	["ghost"] = "rbxassetid://10723396107",
	["gift"] = "rbxassetid://10723396402",
	["gift-card"] = "rbxassetid://10723396225",
	["git-branch"] = "rbxassetid://10723396676",
	["git-branch-plus"] = "rbxassetid://10723396542",
	["git-commit"] = "rbxassetid://10723396812",
	["git-compare"] = "rbxassetid://10723396954",
	["git-fork"] = "rbxassetid://10723397049",
	["git-merge"] = "rbxassetid://10723397165",
	["git-pull-request"] = "rbxassetid://10723397431",
	["git-pull-request-closed"] = "rbxassetid://10723397268",
	["git-pull-request-draft"] = "rbxassetid://10734884302",
	["glass"] = "rbxassetid://10723397788",
	["glass-2"] = "rbxassetid://10723397529",
	["glass-water"] = "rbxassetid://10723397678",
	["glasses"] = "rbxassetid://10723397895",
	["globe"] = "rbxassetid://10723404337",
	["globe-2"] = "rbxassetid://10723398002",
	["grab"] = "rbxassetid://10723404472",
	["graduation-cap"] = "rbxassetid://10723404691",
	["grape"] = "rbxassetid://10723404822",
	["grid"] = "rbxassetid://10723404936",
	["grip-horizontal"] = "rbxassetid://10723405089",
	["grip-vertical"] = "rbxassetid://10723405236",
	["hammer"] = "rbxassetid://10723405360",
	["hand"] = "rbxassetid://10723405649",
	["hand-metal"] = "rbxassetid://10723405508",
	["hard-drive"] = "rbxassetid://10723405749",
	["hard-hat"] = "rbxassetid://10723405859",
	["hash"] = "rbxassetid://10723405975",
	["haze"] = "rbxassetid://10723406078",
	["headphones"] = "rbxassetid://10723406165",
	["heart"] = "rbxassetid://10723406885",
	["heart-crack"] = "rbxassetid://10723406299",
	["heart-handshake"] = "rbxassetid://10723406480",
	["heart-off"] = "rbxassetid://10723406662",
	["heart-pulse"] = "rbxassetid://10723406795",
	["help-circle"] = "rbxassetid://10723406988",
	["hexagon"] = "rbxassetid://10723407092",
	["highlighter"] = "rbxassetid://10723407192",
	["history"] = "rbxassetid://10723407335",
	["home"] = "rbxassetid://10723407389",
	["hourglass"] = "rbxassetid://10723407498",
	["ice-cream"] = "rbxassetid://10723414308",
	["image"] = "rbxassetid://10723415040",
	["image-minus"] = "rbxassetid://10723414487",
	["image-off"] = "rbxassetid://10723414677",
	["image-plus"] = "rbxassetid://10723414827",
	["import"] = "rbxassetid://10723415205",
	["inbox"] = "rbxassetid://10723415335",
	["indent"] = "rbxassetid://10723415494",
	["indian-rupee"] = "rbxassetid://10723415642",
	["infinity"] = "rbxassetid://10723415766",
	["info"] = "rbxassetid://10723415903",
	["inspect"] = "rbxassetid://10723416057",
	["italic"] = "rbxassetid://10723416195",
	["japanese-yen"] = "rbxassetid://10723416363",
	["joystick"] = "rbxassetid://10723416527",
	["key"] = "rbxassetid://10723416652",
	["keyboard"] = "rbxassetid://10723416765",
	["lamp"] = "rbxassetid://10723417513",
	["lamp-ceiling"] = "rbxassetid://10723416922",
	["lamp-desk"] = "rbxassetid://10723417016",
	["lamp-floor"] = "rbxassetid://10723417131",
	["lamp-wall-down"] = "rbxassetid://10723417240",
	["lamp-wall-up"] = "rbxassetid://10723417356",
	["landmark"] = "rbxassetid://10723417608",
	["languages"] = "rbxassetid://10723417703",
	["laptop"] = "rbxassetid://10723423881",
	["laptop-2"] = "rbxassetid://10723417797",
	["lasso"] = "rbxassetid://10723424235",
	["lasso-select"] = "rbxassetid://10723424058",
	["laugh"] = "rbxassetid://10723424372",
	["layers"] = "rbxassetid://10723424505",
	["layout"] = "rbxassetid://10723425376",
	["layout-dashboard"] = "rbxassetid://10723424646",
	["layout-grid"] = "rbxassetid://10723424838",
	["layout-list"] = "rbxassetid://10723424963",
	["layout-template"] = "rbxassetid://10723425187",
	["leaf"] = "rbxassetid://10723425539",
	["library"] = "rbxassetid://10723425615",
	["life-buoy"] = "rbxassetid://10723425685",
	["lightbulb"] = "rbxassetid://10723425852",
	["lightbulb-off"] = "rbxassetid://10723425762",
	["line-chart"] = "rbxassetid://10723426393",
	["link"] = "rbxassetid://10723426722",
	["link-2"] = "rbxassetid://10723426595",
	["link-2-off"] = "rbxassetid://10723426513",
	["list"] = "rbxassetid://10723433811",
	["list-checks"] = "rbxassetid://10734884548",
	["list-end"] = "rbxassetid://10723426886",
	["list-minus"] = "rbxassetid://10723426986",
	["list-music"] = "rbxassetid://10723427081",
	["list-ordered"] = "rbxassetid://10723427199",
	["list-plus"] = "rbxassetid://10723427334",
	["list-start"] = "rbxassetid://10723427494",
	["list-video"] = "rbxassetid://10723427619",
	["list-x"] = "rbxassetid://10723433655",
	["loader"] = "rbxassetid://10723434070",
	["loader-2"] = "rbxassetid://10723433935",
	["locate"] = "rbxassetid://10723434557",
	["locate-fixed"] = "rbxassetid://10723434236",
	["locate-off"] = "rbxassetid://10723434379",
	["lock"] = "rbxassetid://10723434711",
	["log-in"] = "rbxassetid://10723434830",
	["log-out"] = "rbxassetid://10723434906",
	["luggage"] = "rbxassetid://10723434993",
	["magnet"] = "rbxassetid://10723435069",
	["mail"] = "rbxassetid://10734885430",
	["mail-check"] = "rbxassetid://10723435182",
	["mail-minus"] = "rbxassetid://10723435261",
	["mail-open"] = "rbxassetid://10723435342",
	["mail-plus"] = "rbxassetid://10723435443",
	["mail-question"] = "rbxassetid://10723435515",
	["mail-search"] = "rbxassetid://10734884739",
	["mail-warning"] = "rbxassetid://10734885015",
	["mail-x"] = "rbxassetid://10734885247",
	["mails"] = "rbxassetid://10734885614",
	["map"] = "rbxassetid://10734886202",
	["map-pin"] = "rbxassetid://10734886004",
	["map-pin-off"] = "rbxassetid://10734885803",
	["maximize"] = "rbxassetid://10734886735",
	["maximize-2"] = "rbxassetid://10734886496",
	["medal"] = "rbxassetid://10734887072",
	["megaphone"] = "rbxassetid://10734887454",
	["megaphone-off"] = "rbxassetid://10734887311",
	["meh"] = "rbxassetid://10734887603",
	["menu"] = "rbxassetid://10734887784",
	["message-circle"] = "rbxassetid://10734888000",
	["message-square"] = "rbxassetid://10734888228",
	["mic"] = "rbxassetid://10734888864",
	["mic-2"] = "rbxassetid://10734888430",
	["mic-off"] = "rbxassetid://10734888646",
	["microscope"] = "rbxassetid://10734889106",
	["microwave"] = "rbxassetid://10734895076",
	["milestone"] = "rbxassetid://10734895310",
	["minimize"] = "rbxassetid://10734895698",
	["minimize-2"] = "rbxassetid://10734895530",
	["minus"] = "rbxassetid://10734896206",
	["minus-circle"] = "rbxassetid://10734895856",
	["minus-square"] = "rbxassetid://10734896029",
	["monitor"] = "rbxassetid://10734896881",
	["monitor-off"] = "rbxassetid://10734896360",
	["monitor-speaker"] = "rbxassetid://10734896512",
	["moon"] = "rbxassetid://10734897102",
	["more-horizontal"] = "rbxassetid://10734897250",
	["more-vertical"] = "rbxassetid://10734897387",
	["mountain"] = "rbxassetid://10734897956",
	["mountain-snow"] = "rbxassetid://10734897665",
	["mouse"] = "rbxassetid://10734898592",
	["mouse-pointer"] = "rbxassetid://10734898476",
	["mouse-pointer-2"] = "rbxassetid://10734898194",
	["mouse-pointer-click"] = "rbxassetid://10734898355",
	["move"] = "rbxassetid://10734900011",
	["move-3d"] = "rbxassetid://10734898756",
	["move-diagonal"] = "rbxassetid://10734899164",
	["move-diagonal-2"] = "rbxassetid://10734898934",
	["move-horizontal"] = "rbxassetid://10734899414",
	["move-vertical"] = "rbxassetid://10734899821",
	["music"] = "rbxassetid://10734905958",
	["music-2"] = "rbxassetid://10734900215",
	["music-3"] = "rbxassetid://10734905665",
	["music-4"] = "rbxassetid://10734905823",
	["navigation"] = "rbxassetid://10734906744",
	["navigation-2"] = "rbxassetid://10734906332",
	["navigation-2-off"] = "rbxassetid://10734906144",
	["navigation-off"] = "rbxassetid://10734906580",
	["network"] = "rbxassetid://10734906975",
	["newspaper"] = "rbxassetid://10734907168",
	["octagon"] = "rbxassetid://10734907361",
	["option"] = "rbxassetid://10734907649",
	["outdent"] = "rbxassetid://10734907933",
	["package"] = "rbxassetid://10734909540",
	["package-2"] = "rbxassetid://10734908151",
	["package-check"] = "rbxassetid://10734908384",
	["package-minus"] = "rbxassetid://10734908626",
	["package-open"] = "rbxassetid://10734908793",
	["package-plus"] = "rbxassetid://10734909016",
	["package-search"] = "rbxassetid://10734909196",
	["package-x"] = "rbxassetid://10734909375",
	["paint-bucket"] = "rbxassetid://10734909847",
	["paintbrush"] = "rbxassetid://10734910187",
	["paintbrush-2"] = "rbxassetid://10734910030",
	["palette"] = "rbxassetid://10734910430",
	["palmtree"] = "rbxassetid://10734910680",
	["paperclip"] = "rbxassetid://10734910927",
	["party-popper"] = "rbxassetid://10734918735",
	["pause"] = "rbxassetid://10734919336",
	["pause-circle"] = "rbxassetid://10735024209",
	["pause-octagon"] = "rbxassetid://10734919143",
	["pen-tool"] = "rbxassetid://10734919503",
	["pencil"] = "rbxassetid://10734919691",
	["percent"] = "rbxassetid://10734919919",
	["person-standing"] = "rbxassetid://10734920149",
	["phone"] = "rbxassetid://10734921524",
	["phone-call"] = "rbxassetid://10734920305",
	["phone-forwarded"] = "rbxassetid://10734920508",
	["phone-incoming"] = "rbxassetid://10734920694",
	["phone-missed"] = "rbxassetid://10734920845",
	["phone-off"] = "rbxassetid://10734921077",
	["phone-outgoing"] = "rbxassetid://10734921288",
	["pie-chart"] = "rbxassetid://10734921727",
	["piggy-bank"] = "rbxassetid://10734921935",
	["pin"] = "rbxassetid://10734922324",
	["pin-off"] = "rbxassetid://10734922180",
	["pipette"] = "rbxassetid://10734922497",
	["pizza"] = "rbxassetid://10734922774",
	["plane"] = "rbxassetid://10734922971",
	["play"] = "rbxassetid://10734923549",
	["play-circle"] = "rbxassetid://10734923214",
	["plus"] = "rbxassetid://10734924532",
	["plus-circle"] = "rbxassetid://10734923868",
	["plus-square"] = "rbxassetid://10734924219",
	["podcast"] = "rbxassetid://10734929553",
	["pointer"] = "rbxassetid://10734929723",
	["pound-sterling"] = "rbxassetid://10734929981",
	["power"] = "rbxassetid://10734930466",
	["power-off"] = "rbxassetid://10734930257",
	["printer"] = "rbxassetid://10734930632",
	["puzzle"] = "rbxassetid://10734930886",
	["quote"] = "rbxassetid://10734931234",
	["radio"] = "rbxassetid://10734931596",
	["radio-receiver"] = "rbxassetid://10734931402",
	["rectangle-horizontal"] = "rbxassetid://10734931777",
	["rectangle-vertical"] = "rbxassetid://10734932081",
	["recycle"] = "rbxassetid://10734932295",
	["redo"] = "rbxassetid://10734932822",
	["redo-2"] = "rbxassetid://10734932586",
	["refresh-ccw"] = "rbxassetid://10734933056",
	["refresh-cw"] = "rbxassetid://10734933222",
	["refrigerator"] = "rbxassetid://10734933465",
	["regex"] = "rbxassetid://10734933655",
	["repeat"] = "rbxassetid://10734933966",
	["repeat-1"] = "rbxassetid://10734933826",
	["reply"] = "rbxassetid://10734934252",
	["reply-all"] = "rbxassetid://10734934132",
	["rewind"] = "rbxassetid://10734934347",
	["rocket"] = "rbxassetid://10734934585",
	["rocking-chair"] = "rbxassetid://10734939942",
	["rotate-3d"] = "rbxassetid://10734940107",
	["rotate-ccw"] = "rbxassetid://10734940376",
	["rotate-cw"] = "rbxassetid://10734940654",
	["rss"] = "rbxassetid://10734940825",
	["ruler"] = "rbxassetid://10734941018",
	["russian-ruble"] = "rbxassetid://10734941199",
	["sailboat"] = "rbxassetid://10734941354",
	["save"] = "rbxassetid://10734941499",
	["scale"] = "rbxassetid://10734941912",
	["scale-3d"] = "rbxassetid://10734941739",
	["scaling"] = "rbxassetid://10734942072",
	["scan"] = "rbxassetid://10734942565",
	["scan-face"] = "rbxassetid://10734942198",
	["scan-line"] = "rbxassetid://10734942351",
	["scissors"] = "rbxassetid://10734942778",
	["screen-share"] = "rbxassetid://10734943193",
	["screen-share-off"] = "rbxassetid://10734942967",
	["scroll"] = "rbxassetid://10734943448",
	["search"] = "rbxassetid://10734943674",
	["send"] = "rbxassetid://10734943902",
	["separator-horizontal"] = "rbxassetid://10734944115",
	["separator-vertical"] = "rbxassetid://10734944326",
	["server"] = "rbxassetid://10734949856",
	["server-cog"] = "rbxassetid://10734944444",
	["server-crash"] = "rbxassetid://10734944554",
	["server-off"] = "rbxassetid://10734944668",
	["settings"] = "rbxassetid://10734950309",
	["settings-2"] = "rbxassetid://10734950020",
	["share"] = "rbxassetid://10734950813",
	["share-2"] = "rbxassetid://10734950553",
	["sheet"] = "rbxassetid://10734951038",
	["shield"] = "rbxassetid://10734951847",
	["shield-alert"] = "rbxassetid://10734951173",
	["shield-check"] = "rbxassetid://10734951367",
	["shield-close"] = "rbxassetid://10734951535",
	["shield-off"] = "rbxassetid://10734951684",
	["shirt"] = "rbxassetid://10734952036",
	["shopping-bag"] = "rbxassetid://10734952273",
	["shopping-cart"] = "rbxassetid://10734952479",
	["shovel"] = "rbxassetid://10734952773",
	["shower-head"] = "rbxassetid://10734952942",
	["shrink"] = "rbxassetid://10734953073",
	["shrub"] = "rbxassetid://10734953241",
	["shuffle"] = "rbxassetid://10734953451",
	["sidebar"] = "rbxassetid://10734954301",
	["sidebar-close"] = "rbxassetid://10734953715",
	["sidebar-open"] = "rbxassetid://10734954000",
	["sigma"] = "rbxassetid://10734954538",
	["signal"] = "rbxassetid://10734961133",
	["signal-high"] = "rbxassetid://10734954807",
	["signal-low"] = "rbxassetid://10734955080",
	["signal-medium"] = "rbxassetid://10734955336",
	["signal-zero"] = "rbxassetid://10734960878",
	["siren"] = "rbxassetid://10734961284",
	["skip-back"] = "rbxassetid://10734961526",
	["skip-forward"] = "rbxassetid://10734961809",
	["skull"] = "rbxassetid://10734962068",
	["slack"] = "rbxassetid://10734962339",
	["slash"] = "rbxassetid://10734962600",
	["slice"] = "rbxassetid://10734963024",
	["sliders"] = "rbxassetid://10734963400",
	["sliders-horizontal"] = "rbxassetid://10734963191",
	["smartphone"] = "rbxassetid://10734963940",
	["smartphone-charging"] = "rbxassetid://10734963671",
	["smile"] = "rbxassetid://10734964441",
	["smile-plus"] = "rbxassetid://10734964188",
	["snowflake"] = "rbxassetid://10734964600",
	["sofa"] = "rbxassetid://10734964852",
	["sort-asc"] = "rbxassetid://10734965115",
	["sort-desc"] = "rbxassetid://10734965287",
	["speaker"] = "rbxassetid://10734965419",
	["sprout"] = "rbxassetid://10734965572",
	["square"] = "rbxassetid://10734965702",
	["star"] = "rbxassetid://10734966248",
	["star-half"] = "rbxassetid://10734965897",
	["star-off"] = "rbxassetid://10734966097",
	["stethoscope"] = "rbxassetid://10734966384",
	["sticker"] = "rbxassetid://10734972234",
	["sticky-note"] = "rbxassetid://10734972463",
	["stop-circle"] = "rbxassetid://10734972621",
	["stretch-horizontal"] = "rbxassetid://10734972862",
	["stretch-vertical"] = "rbxassetid://10734973130",
	["strikethrough"] = "rbxassetid://10734973290",
	["subscript"] = "rbxassetid://10734973457",
	["sun"] = "rbxassetid://10734974297",
	["sun-dim"] = "rbxassetid://10734973645",
	["sun-medium"] = "rbxassetid://10734973778",
	["sun-moon"] = "rbxassetid://10734973999",
	["sun-snow"] = "rbxassetid://10734974130",
	["sunrise"] = "rbxassetid://10734974522",
	["sunset"] = "rbxassetid://10734974689",
	["superscript"] = "rbxassetid://10734974850",
	["swiss-franc"] = "rbxassetid://10734975024",
	["switch-camera"] = "rbxassetid://10734975214",
	["sword"] = "rbxassetid://10734975486",
	["swords"] = "rbxassetid://10734975692",
	["syringe"] = "rbxassetid://10734975932",
	["table"] = "rbxassetid://10734976230",
	["table-2"] = "rbxassetid://10734976097",
	["tablet"] = "rbxassetid://10734976394",
	["tag"] = "rbxassetid://10734976528",
	["tags"] = "rbxassetid://10734976739",
	["target"] = "rbxassetid://10734977012",
	["tent"] = "rbxassetid://10734981750",
	["terminal"] = "rbxassetid://10734982144",
	["terminal-square"] = "rbxassetid://10734981995",
	["text-cursor"] = "rbxassetid://10734982395",
	["text-cursor-input"] = "rbxassetid://10734982297",
	["thermometer"] = "rbxassetid://10734983134",
	["thermometer-snowflake"] = "rbxassetid://10734982571",
	["thermometer-sun"] = "rbxassetid://10734982771",
	["thumbs-down"] = "rbxassetid://10734983359",
	["thumbs-up"] = "rbxassetid://10734983629",
	["ticket"] = "rbxassetid://10734983868",
	["timer"] = "rbxassetid://10734984606",
	["timer-off"] = "rbxassetid://10734984138",
	["timer-reset"] = "rbxassetid://10734984355",
	["toggle-left"] = "rbxassetid://10734984834",
	["toggle-right"] = "rbxassetid://10734985040",
	["tornado"] = "rbxassetid://10734985247",
	["toy-brick"] = "rbxassetid://10747361919",
	["train"] = "rbxassetid://10747362105",
	["trash"] = "rbxassetid://10747362393",
	["trash-2"] = "rbxassetid://10747362241",
	["tree-deciduous"] = "rbxassetid://10747362534",
	["tree-pine"] = "rbxassetid://10747362748",
	["trees"] = "rbxassetid://10747363016",
	["trending-down"] = "rbxassetid://10747363205",
	["trending-up"] = "rbxassetid://10747363465",
	["triangle"] = "rbxassetid://10747363621",
	["trophy"] = "rbxassetid://10747363809",
	["truck"] = "rbxassetid://10747364031",
	["tv"] = "rbxassetid://10747364593",
	["tv-2"] = "rbxassetid://10747364302",
	["type"] = "rbxassetid://10747364761",
	["umbrella"] = "rbxassetid://10747364971",
	["underline"] = "rbxassetid://10747365191",
	["undo"] = "rbxassetid://10747365484",
	["undo-2"] = "rbxassetid://10747365359",
	["unlink"] = "rbxassetid://10747365771",
	["unlink-2"] = "rbxassetid://10747397871",
	["unlock"] = "rbxassetid://10747366027",
	["upload"] = "rbxassetid://10747366434",
	["upload-cloud"] = "rbxassetid://10747366266",
	["usb"] = "rbxassetid://10747366606",
	["user"] = "rbxassetid://10747373176",
	["user-check"] = "rbxassetid://10747371901",
	["user-cog"] = "rbxassetid://10747372167",
	["user-minus"] = "rbxassetid://10747372346",
	["user-plus"] = "rbxassetid://10747372702",
	["user-x"] = "rbxassetid://10747372992",
	["users"] = "rbxassetid://10747373426",
	["utensils"] = "rbxassetid://10747373821",
	["utensils-crossed"] = "rbxassetid://10747373629",
	["venetian-mask"] = "rbxassetid://10747374003",
	["verified"] = "rbxassetid://10747374131",
	["vibrate"] = "rbxassetid://10747374489",
	["vibrate-off"] = "rbxassetid://10747374269",
	["video"] = "rbxassetid://10747374938",
	["video-off"] = "rbxassetid://10747374721",
	["view"] = "rbxassetid://10747375132",
	["voicemail"] = "rbxassetid://10747375281",
	["volume"] = "rbxassetid://10747376008",
	["volume-1"] = "rbxassetid://10747375450",
	["volume-2"] = "rbxassetid://10747375679",
	["volume-x"] = "rbxassetid://10747375880",
	["wallet"] = "rbxassetid://10747376205",
	["wand"] = "rbxassetid://10747376565",
	["wand-2"] = "rbxassetid://10747376349",
	["watch"] = "rbxassetid://10747376722",
	["waves"] = "rbxassetid://10747376931",
	["webcam"] = "rbxassetid://10747381992",
	["wifi"] = "rbxassetid://10747382504",
	["wifi-off"] = "rbxassetid://10747382268",
	["wind"] = "rbxassetid://10747382750",
	["wrap-text"] = "rbxassetid://10747383065",
	["wrench"] = "rbxassetid://10747383470",
	["x"] = "rbxassetid://10747384394",
	["x-circle"] = "rbxassetid://10747383819",
	["x-octagon"] = "rbxassetid://10747384037",
	["x-square"] = "rbxassetid://10747384217",
	["zoom-in"] = "rbxassetid://10747384552",
	["zoom-out"] = "rbxassetid://10747384679",
}

function EcoHub:GetIcon(iconName)
    return IconLibrary[iconName] or nil
end

local TabModule = {
    Window = nil,
    Tabs = {},
    Pages = {},
    SelectedTab = nil,
    TabCount = 0,
}

function TabModule:Init(Window)
    TabModule.Window = Window
    TabModule.Tabs = {}
    TabModule.Pages = {}
    TabModule.SelectedTab = nil
    TabModule.TabCount = 0
    return TabModule
end

function TabModule:CreateTab(Config)
	local Window = TabModule.Window
	TabModule.TabCount = TabModule.TabCount + 1
	local TabIndex = TabModule.TabCount

	local Tab = {
		Title = Config.Title or "Tab",
		Icon = Config.Icon,
		Selected = false,
		Index = TabIndex,
	}

	local IconImage = nil
	if Tab.Icon and Tab.Icon ~= "" then
		IconImage = EcoHub:GetIcon(Tab.Icon) or Tab.Icon
	end

	local TabButton = Instance.new("TextButton")
	TabButton.Name = Tab.Title
	TabButton.Parent = Window.TabBar
	TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	TabButton.BorderSizePixel = 0
	TabButton.Size = UDim2.new(1, 0, 0, 35)
	TabButton.Font = Enum.Font.GothamSemibold
	TabButton.Text = ""
	TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
	TabButton.TextSize = 13
	TabButton.LayoutOrder = TabIndex
	TabButton.ClipsDescendants = true

	local TabCorner = Instance.new("UICorner")
	TabCorner.CornerRadius = UDim.new(0, 6)
	TabCorner.Parent = TabButton

	if IconImage then
		local TabIcon = Instance.new("ImageLabel")
		TabIcon.Name = "Icon"
		TabIcon.Parent = TabButton
		TabIcon.AnchorPoint = Vector2.new(0, 0.5)
		TabIcon.BackgroundTransparency = 1
		TabIcon.Position = UDim2.new(0, 8, 0.5, 0)
		TabIcon.Size = UDim2.fromOffset(16, 16)
		TabIcon.Image = IconImage
		TabIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
	end

	local TabLabel = Instance.new("TextLabel")
	TabLabel.Name = "Label"
	TabLabel.Parent = TabButton
	TabLabel.AnchorPoint = Vector2.new(0, 0.5)
	TabLabel.BackgroundTransparency = 1
	TabLabel.Position = IconImage and UDim2.new(0, 30, 0.5, 0) or UDim2.new(0, 12, 0.5, 0)
	TabLabel.Size = UDim2.new(1, IconImage and -34 or -16, 1, 0)
	TabLabel.Font = Enum.Font.GothamSemibold
	TabLabel.Text = Tab.Title
	TabLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	TabLabel.TextSize = 12
	TabLabel.TextXAlignment = Enum.TextXAlignment.Left
	TabLabel.TextTruncate = Enum.TextTruncate.AtEnd

	local TabPage = Instance.new("ScrollingFrame")
	TabPage.Name = Tab.Title .. "Page"
	TabPage.Parent = Window.PageContainer
	TabPage.BackgroundTransparency = 1
	TabPage.BorderSizePixel = 0
	TabPage.Size = UDim2.fromScale(1, 1)
	TabPage.CanvasSize = UDim2.fromScale(0, 0)
	TabPage.ScrollBarThickness = 4
	TabPage.ScrollBarImageColor3 = Color3.fromRGB(72, 138, 182)
	TabPage.ScrollBarImageTransparency = 0.5
	TabPage.Visible = false
	TabPage.ClipsDescendants = true
	TabPage.ScrollingDirection = Enum.ScrollingDirection.Y
	TabPage.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
	TabPage.ScrollingEnabled = true
	TabPage.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable

	local PageLayout = Instance.new("UIListLayout")
	PageLayout.Parent = TabPage
	PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	PageLayout.Padding = UDim.new(0, 8)

	local PagePadding = Instance.new("UIPadding")
	PagePadding.Parent = TabPage
	PagePadding.PaddingTop = UDim.new(0, 12)
	PagePadding.PaddingBottom = UDim.new(0, 12)
	PagePadding.PaddingLeft = UDim.new(0, 12)
	PagePadding.PaddingRight = UDim.new(0, 12)

	PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 24)
	end)
	
	-- Sistema de scroll com mouse wheel
	TabPage.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseWheel then
			local scrollAmount = -input.Position.Z * 30
			local newPosition = math.clamp(
				TabPage.CanvasPosition.Y + scrollAmount,
				0,
				math.max(0, TabPage.CanvasSize.Y.Offset - TabPage.AbsoluteSize.Y)
			)
			
			TweenService:Create(TabPage, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
				CanvasPosition = Vector2.new(0, newPosition)
			}):Play()
		end
	end)
    
    Tab.Button = TabButton
    Tab.Page = TabPage
    Tab.PageLayout = PageLayout
    
    TabButton.MouseEnter:Connect(function()
        if not Tab.Selected then
            TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
    end)
    
    TabButton.MouseLeave:Connect(function()
        if not Tab.Selected then
            TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end
    end)
    
    TabButton.MouseButton1Click:Connect(function()
        TabModule:SelectTab(TabIndex)
    end)
    
    TabModule.Tabs[TabIndex] = Tab
    TabModule.Pages[TabIndex] = TabPage
    
    if TabIndex == 1 then
        task.spawn(function()
            task.wait(0.1)
            TabModule:SelectTab(1)
        end)
    end
    
    local TabObject = {}
    TabObject.Page = TabPage
    TabObject.Title = Tab.Title
    TabObject.Index = TabIndex
    
    function TabObject:AddBox(name)
        local Box = {}
        
        local BoxFrame = Instance.new("Frame")
        BoxFrame.Name = name
        BoxFrame.Parent = TabPage
        BoxFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        BoxFrame.BorderSizePixel = 1
        BoxFrame.BorderColor3 = Color3.fromRGB(50, 50, 50)
        BoxFrame.Size = UDim2.new(1, -10, 0, 40)
        BoxFrame.ClipsDescendants = true
        
        local BoxCorner = Instance.new("UICorner")
        BoxCorner.CornerRadius = UDim.new(0, 6)
        BoxCorner.Parent = BoxFrame
        
        local AccentBar = Instance.new("Frame")
        AccentBar.Name = "AccentBar"
        AccentBar.Parent = BoxFrame
        AccentBar.BackgroundColor3 = Color3.fromRGB(72, 138, 182)
        AccentBar.Size = UDim2.new(0, 4, 1, 0)
        AccentBar.Position = UDim2.new(0, 0, 0, 0)
        AccentBar.BorderSizePixel = 0
        
        local BoxHeader = Instance.new("TextButton")
        BoxHeader.Name = "Header"
        BoxHeader.Parent = BoxFrame
        BoxHeader.BackgroundTransparency = 1
        BoxHeader.Position = UDim2.new(0, 8, 0, 0)
        BoxHeader.Size = UDim2.new(1, -8, 0, 40)
        BoxHeader.Font = Enum.Font.GothamBold
        BoxHeader.Text = "  " .. name
        BoxHeader.TextColor3 = Color3.fromRGB(230, 230, 230)
        BoxHeader.TextSize = 14
        BoxHeader.TextXAlignment = Enum.TextXAlignment.Left
        BoxHeader.AutoButtonColor = false
        
        local Arrow = Instance.new("TextLabel")
        Arrow.Parent = BoxHeader
        Arrow.BackgroundTransparency = 1
        Arrow.Position = UDim2.new(1, -30, 0.5, -10)
        Arrow.Size = UDim2.new(0, 20, 0, 20)
        Arrow.Font = Enum.Font.GothamBold
        Arrow.Text = "▼"
        Arrow.TextColor3 = Color3.fromRGB(72, 138, 182)
        Arrow.TextSize = 12
        
        local BoxContent = Instance.new("Frame")
        BoxContent.Name = "BoxContent"
        BoxContent.Parent = BoxFrame
        BoxContent.BackgroundTransparency = 1
        BoxContent.Position = UDim2.new(0, 0, 0, 40)
        BoxContent.Size = UDim2.new(1, 0, 0, 0)
        BoxContent.Visible = false
        BoxContent.ClipsDescendants = false
        
        local BoxLayout = Instance.new("UIListLayout")
        BoxLayout.Parent = BoxContent
        BoxLayout.SortOrder = Enum.SortOrder.LayoutOrder
        BoxLayout.Padding = UDim.new(0, 6)
        
        local BoxPadding = Instance.new("UIPadding")
        BoxPadding.Parent = BoxContent
        BoxPadding.PaddingTop = UDim.new(0, 8)
        BoxPadding.PaddingBottom = UDim.new(0, 8)
        BoxPadding.PaddingLeft = UDim.new(0, 8)
        BoxPadding.PaddingRight = UDim.new(0, 8)
        
        local boxOpen = false
        local animating = false
        
        BoxHeader.MouseButton1Click:Connect(function()
            if animating then return end
            animating = true
            
            boxOpen = not boxOpen
            
            if boxOpen then
                BoxContent.Visible = true
                local contentHeight = BoxLayout.AbsoluteContentSize.Y + 16
                
                TweenService:Create(BoxFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                    Size = UDim2.new(1, -10, 0, 40 + contentHeight)
                }):Play()
                
                TweenService:Create(Arrow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                    Rotation = 180
                }):Play()
                
                BoxContent.Size = UDim2.new(1, 0, 0, contentHeight)
                task.wait(0.3)
                animating = false
            else
                TweenService:Create(BoxFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                    Size = UDim2.new(1, -10, 0, 40)
                }):Play()
                
                TweenService:Create(Arrow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                    Rotation = 0
                }):Play()
                
                task.wait(0.3)
                BoxContent.Visible = false
                animating = false
            end
        end)
        
        BoxHeader.MouseEnter:Connect(function()
            TweenService:Create(BoxFrame, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            }):Play()
        end)
        
        BoxHeader.MouseLeave:Connect(function()
            TweenService:Create(BoxFrame, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            }):Play()
        end)
        
        BoxLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            if boxOpen and not animating then
                local contentHeight = BoxLayout.AbsoluteContentSize.Y + 16
                BoxContent.Size = UDim2.new(1, 0, 0, contentHeight)
                BoxFrame.Size = UDim2.new(1, -10, 0, 40 + contentHeight)
            end
        end)
        
        function Box:AddButton(config)
            config = config or {}
            local Container = Instance.new("Frame")
            Container.Parent = BoxContent
            Container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            Container.BorderSizePixel = 0
            Container.Size = UDim2.new(1, 0, 0, 45)
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = Container
            
            local Button = Instance.new("TextButton")
            Button.Parent = Container
            Button.BackgroundColor3 = Color3.fromRGB(72, 138, 182)
            Button.BorderSizePixel = 0
            Button.Position = UDim2.new(1, -70, 0.5, -14)
            Button.Size = UDim2.new(0, 60, 0, 28)
            Button.Font = Enum.Font.GothamBold
            Button.Text = "Click"
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 11
            
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 4)
            BtnCorner.Parent = Button
            
            local TitleLabel = Instance.new("TextLabel")
            TitleLabel.Parent = Container
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Position = UDim2.new(0, 10, 0, 5)
            TitleLabel.Size = UDim2.new(1, -85, 0, 16)
            TitleLabel.Font = Enum.Font.GothamSemibold
            TitleLabel.Text = config.Title or "Button"
            TitleLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
            TitleLabel.TextSize = 12
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            local DescLabel = Instance.new("TextLabel")
            DescLabel.Parent = Container
            DescLabel.BackgroundTransparency = 1
            DescLabel.Position = UDim2.new(0, 10, 0, 22)
            DescLabel.Size = UDim2.new(1, -85, 0, 18)
            DescLabel.Font = Enum.Font.Gotham
            DescLabel.Text = config.Description or ""
            DescLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            DescLabel.TextSize = 10
            DescLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            Button.MouseButton1Click:Connect(function()
                if config.Callback then
                    config.Callback()
                end
            end)
            
            Button.MouseEnter:Connect(function()
                Button.BackgroundColor3 = Color3.fromRGB(90, 160, 200)
            end)
            
            Button.MouseLeave:Connect(function()
                Button.BackgroundColor3 = Color3.fromRGB(72, 138, 182)
            end)
        end
        
        function Box:AddToggle(config)
            config = config or {}
            local toggled = config.Default or false
            
            local Container = Instance.new("Frame")
            Container.Parent = BoxContent
            Container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            Container.BorderSizePixel = 0
            Container.Size = UDim2.new(1, 0, 0, 38)
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = Container
            
            local TitleLabel = Instance.new("TextLabel")
            TitleLabel.Parent = Container
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Position = UDim2.new(0, 10, 0, 0)
            TitleLabel.Size = UDim2.new(1, -60, 1, 0)
            TitleLabel.Font = Enum.Font.GothamSemibold
            TitleLabel.Text = config.Title or "Toggle"
            TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
            TitleLabel.TextSize = 12
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Parent = Container
            ToggleButton.BackgroundColor3 = toggled and Color3.fromRGB(72, 138, 182) or Color3.fromRGB(50, 50, 50)
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Position = UDim2.new(1, -48, 0.5, -10)
            ToggleButton.Size = UDim2.new(0, 40, 0, 20)
            ToggleButton.Text = ""
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(1, 0)
            ToggleCorner.Parent = ToggleButton
            
            local ToggleCircle = Instance.new("Frame")
            ToggleCircle.Parent = ToggleButton
            ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleCircle.BorderSizePixel = 0
            ToggleCircle.Position = toggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
            
            local CircleCorner = Instance.new("UICorner")
            CircleCorner.CornerRadius = UDim.new(1, 0)
            CircleCorner.Parent = ToggleCircle
            
            local Toggle = {}
            Toggle.Value = toggled
            
            function Toggle:SetValue(value)
                toggled = value
                Toggle.Value = value
                
                TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = toggled and Color3.fromRGB(72, 138, 182) or Color3.fromRGB(50, 50, 50)
                }):Play()
                
                TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {
                    Position = toggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                }):Play()
                
                if config.Callback then
                    config.Callback(toggled)
                end
            end
            
            ToggleButton.MouseButton1Click:Connect(function()
                Toggle:SetValue(not toggled)
            end)
            
            return Toggle
        end
        
        function Box:AddSlider(config)
            config = config or {}
            local min = config.Min or 0
            local max = config.Max or 100
            local default = config.Default or min
            local rounding = config.Rounding or 1
            local currentValue = default
            
            local Container = Instance.new("Frame")
            Container.Parent = BoxContent
            Container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            Container.BorderSizePixel = 0
            Container.Size = UDim2.new(1, 0, 0, 58)
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = Container
            
            local TitleLabel = Instance.new("TextLabel")
            TitleLabel.Parent = Container
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Position = UDim2.new(0, 10, 0, 6)
            TitleLabel.Size = UDim2.new(0.6, 0, 0, 16)
            TitleLabel.Font = Enum.Font.GothamSemibold
            TitleLabel.Text = config.Title or "Slider"
            TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
            TitleLabel.TextSize = 12
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Parent = Container
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Position = UDim2.new(0.6, 0, 0, 6)
            ValueLabel.Size = UDim2.new(0.4, -10, 0, 16)
            ValueLabel.Font = Enum.Font.GothamBold
            ValueLabel.Text = tostring(default)
            ValueLabel.TextColor3 = Color3.fromRGB(72, 138, 182)
            ValueLabel.TextSize = 12
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            
            local SliderBack = Instance.new("Frame")
            SliderBack.Parent = Container
            SliderBack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SliderBack.BorderSizePixel = 0
            SliderBack.Position = UDim2.new(0, 10, 0, 30)
            SliderBack.Size = UDim2.new(1, -20, 0, 16)
            
            local SliderBackCorner = Instance.new("UICorner")
            SliderBackCorner.CornerRadius = UDim.new(1, 0)
            SliderBackCorner.Parent = SliderBack
            
            local SliderFill = Instance.new("Frame")
            SliderFill.Parent = SliderBack
            SliderFill.BackgroundColor3 = Color3.fromRGB(72, 138, 182)
            SliderFill.BorderSizePixel = 0
            SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            
            local SliderFillCorner = Instance.new("UICorner")
            SliderFillCorner.CornerRadius = UDim.new(1, 0)
            SliderFillCorner.Parent = SliderFill
            
            local SliderButton = Instance.new("TextButton")
            SliderButton.Parent = SliderBack
            SliderButton.BackgroundTransparency = 1
            SliderButton.Size = UDim2.new(1, 0, 1, 0)
            SliderButton.Text = ""
            
            local draggingSlider = false
            
            local function updateSlider(input)
                local pos = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
                currentValue = math.floor((min + (max - min) * pos) / rounding + 0.5) * rounding
                
                SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                ValueLabel.Text = tostring(currentValue)
                
                if config.Callback then
                    config.Callback(currentValue)
                end
            end
            
            SliderButton.MouseButton1Down:Connect(function()
                draggingSlider = true
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSlider = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateSlider(input)
                end
            end)
            
            local Slider = {}
            Slider.Value = currentValue
            
            function Slider:SetValue(value)
                currentValue = math.clamp(value, min, max)
                local pos = (currentValue - min) / (max - min)
                SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                ValueLabel.Text = tostring(currentValue)
                Slider.Value = currentValue
            end
            
            return Slider
        end
        
        function Box:AddDropdown(config)
            config = config or {}
            local values = config.Values or {}
            local selected = config.Default or values[1] or ""
            local isOpen = false
            
            local Container = Instance.new("Frame")
            Container.Parent = BoxContent
            Container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            Container.BorderSizePixel = 0
            Container.Size = UDim2.new(1, 0, 0, 45)
            Container.ClipsDescendants = false
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = Container
            
            local TitleLabel = Instance.new("TextLabel")
            TitleLabel.Parent = Container
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Position = UDim2.new(0, 10, 0, 6)
            TitleLabel.Size = UDim2.new(1, -20, 0, 14)
            TitleLabel.Font = Enum.Font.GothamSemibold
            TitleLabel.Text = config.Title or "Dropdown"
            TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
            TitleLabel.TextSize = 12
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Parent = Container
            DropdownButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            DropdownButton.BorderSizePixel = 0
            DropdownButton.Position = UDim2.new(0, 10, 0, 22)
            DropdownButton.Size = UDim2.new(1, -20, 0, 18)
            DropdownButton.Font = Enum.Font.Gotham
            DropdownButton.Text = "  " .. selected
            DropdownButton.TextColor3 = Color3.fromRGB(200, 200, 200)
            DropdownButton.TextSize = 11
            DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
            
            local DropCorner = Instance.new("UICorner")
            DropCorner.CornerRadius = UDim.new(0, 3)
            DropCorner.Parent = DropdownButton
            
            local Arrow = Instance.new("TextLabel")
            Arrow.Parent = DropdownButton
            Arrow.BackgroundTransparency = 1
            Arrow.Position = UDim2.new(1, -18, 0, 0)
            Arrow.Size = UDim2.new(0, 18, 1, 0)
            Arrow.Font = Enum.Font.GothamBold
            Arrow.Text = "▼"
            Arrow.TextColor3 = Color3.fromRGB(150, 150, 150)
            Arrow.TextSize = 9
            
            local OptionsFrame = Instance.new("Frame")
            OptionsFrame.Parent = Container
            OptionsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            OptionsFrame.BorderSizePixel = 1
            OptionsFrame.BorderColor3 = Color3.fromRGB(72, 138, 182)
            OptionsFrame.Position = UDim2.new(0, 10, 0, 42)
            OptionsFrame.Size = UDim2.new(1, -20, 0, 0)
            OptionsFrame.ClipsDescendants = true
            OptionsFrame.Visible = false
            OptionsFrame.ZIndex = 10
            
            local OptionsCorner = Instance.new("UICorner")
            OptionsCorner.CornerRadius = UDim.new(0, 3)
            OptionsCorner.Parent = OptionsFrame
            
            local OptionsList = Instance.new("UIListLayout")
            OptionsList.SortOrder = Enum.SortOrder.LayoutOrder
            OptionsList.Parent = OptionsFrame
            
            for _, value in ipairs(values) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Parent = OptionsFrame
                OptionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                OptionButton.BorderSizePixel = 0
                OptionButton.Size = UDim2.new(1, 0, 0, 22)
                OptionButton.Font = Enum.Font.Gotham
                OptionButton.Text = "  " .. value
                OptionButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                OptionButton.TextSize = 10
                OptionButton.TextXAlignment = Enum.TextXAlignment.Left
                
                OptionButton.MouseEnter:Connect(function()
                    OptionButton.BackgroundColor3 = Color3.fromRGB(72, 138, 182)
                end)
                
                OptionButton.MouseLeave:Connect(function()
                    OptionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                end)
                
                OptionButton.MouseButton1Click:Connect(function()
                    selected = value
                    DropdownButton.Text = "  " .. selected
                    
                    TweenService:Create(OptionsFrame, TweenInfo.new(0.2), {
                        Size = UDim2.new(1, -20, 0, 0)
                    }):Play()
                    
                    task.wait(0.2)
                    OptionsFrame.Visible = false
                    Container.Size = UDim2.new(1, 0, 0, 45)
                    isOpen = false
                    
                    if config.Callback then
                        config.Callback(selected)
                    end
                end)
            end
            
            DropdownButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                
                if isOpen then
                    OptionsFrame.Visible = true
                    local optionsHeight = #values * 22
                    Container.Size = UDim2.new(1, 0, 0, 45 + optionsHeight + 2)
                    
                    TweenService:Create(OptionsFrame, TweenInfo.new(0.2), {
                        Size = UDim2.new(1, -20, 0, optionsHeight)
                    }):Play()
                else
                    TweenService:Create(OptionsFrame, TweenInfo.new(0.2), {
                        Size = UDim2.new(1, -20, 0, 0)
                    }):Play()
                    
                    task.wait(0.2)
                    OptionsFrame.Visible = false
                    Container.Size = UDim2.new(1, 0, 0, 45)
                end
            end)
            
            local Dropdown = {}
            Dropdown.Value = selected
            
            function Dropdown:SetValue(value)
                selected = value
                DropdownButton.Text = "  " .. selected
                Dropdown.Value = selected
            end
            
            return Dropdown
        end
        
        function Box:AddInput(config)
            config = config or {}
            
            local Container = Instance.new("Frame")
            Container.Parent = BoxContent
            Container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            Container.BorderSizePixel = 0
            Container.Size = UDim2.new(1, 0, 0, 48)
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 4)
            Corner.Parent = Container
            
            local TitleLabel = Instance.new("TextLabel")
            TitleLabel.Parent = Container
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Position = UDim2.new(0, 10, 0, 6)
            TitleLabel.Size = UDim2.new(1, -20, 0, 14)
            TitleLabel.Font = Enum.Font.GothamSemibold
            TitleLabel.Text = config.Title or "Input"
            TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
            TitleLabel.TextSize = 12
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            local InputBox = Instance.new("TextBox")
            InputBox.Parent = Container
            InputBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            InputBox.BorderSizePixel = 0
            InputBox.Position = UDim2.new(0, 10, 0, 24)
            InputBox.Size = UDim2.new(1, -20, 0, 20)
            InputBox.Font = Enum.Font.Gotham
            InputBox.PlaceholderText = config.Placeholder or "Enter text..."
            InputBox.Text = config.Default or ""
            InputBox.TextColor3 = Color3.fromRGB(220, 220, 220)
            InputBox.TextSize = 11
            InputBox.TextXAlignment = Enum.TextXAlignment.Left
            InputBox.ClearTextOnFocus = false
            
            local InputCorner = Instance.new("UICorner")
            InputCorner.CornerRadius = UDim.new(0, 3)
            InputCorner.Parent = InputBox
            
            local InputPadding = Instance.new("UIPadding")
            InputPadding.PaddingLeft = UDim.new(0, 8)
            InputPadding.PaddingRight = UDim.new(0, 8)
            InputPadding.Parent = InputBox
            
            InputBox.FocusLost:Connect(function(enterPressed)
                if config.Finished and not enterPressed then
                    return
                end
                
                if config.Callback then
                    config.Callback(InputBox.Text)
                end
            end)
            
            local Input = {}
            Input.Value = InputBox.Text
            
            InputBox:GetPropertyChangedSignal("Text"):Connect(function()
                Input.Value = InputBox.Text
            end)
            
            return Input
        end
        
        function Box:AddLabel(text)
            local Label = Instance.new("TextLabel")
            Label.Parent = BoxContent
            Label.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            Label.BorderSizePixel = 0
            Label.Size = UDim2.new(1, 0, 0, 28)
            Label.Font = Enum.Font.Gotham
            Label.Text = "  " .. text
            Label.TextColor3 = Color3.fromRGB(180, 180, 180)
            Label.TextSize = 11
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.TextWrapped = true
            Label.AutomaticSize = Enum.AutomaticSize.Y
            
            local LabelCorner = Instance.new("UICorner")
            LabelCorner.CornerRadius = UDim.new(0, 4)
            LabelCorner.Parent = Label
            
            local LabelPadding = Instance.new("UIPadding")
            LabelPadding.PaddingLeft = UDim.new(0, 8)
            LabelPadding.PaddingRight = UDim.new(0, 8)
            LabelPadding.PaddingTop = UDim.new(0, 6)
            LabelPadding.PaddingBottom = UDim.new(0, 6)
            LabelPadding.Parent = Label
            
            return Label
        end
        
        return Box
    end
    
    return TabObject
end

function TabModule:SelectTab(TabIndex)
    if TabModule.SelectedTab == TabIndex then return end
    
    local Window = TabModule.Window
    local Tab = TabModule.Tabs[TabIndex]
    if not Tab then return end
    
    for _, TabData in pairs(TabModule.Tabs) do
        TabData.Selected = false
        TabData.Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabData.Button.Label.TextColor3 = Color3.fromRGB(200, 200, 200)
        if TabData.Button:FindFirstChild("Icon") then
            TabData.Button.Icon.ImageColor3 = Color3.fromRGB(200, 200, 200)
        end
        TabData.Page.Visible = false
    end
    
    Tab.Selected = true
    Tab.Button.BackgroundColor3 = Color3.fromRGB(72, 138, 182)
    Tab.Button.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    if Tab.Button:FindFirstChild("Icon") then
        Tab.Button.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    end
    
    Tab.Page.Visible = true
    TabModule.SelectedTab = TabIndex
end

function EcoHub:CreateWindow(Config)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "EcoHub"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
    if not ScreenGui.Parent then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    Config.Title = Config.Title or "EcoHub"
    Config.SubTitle = Config.SubTitle or ""
    Config.Size = Config.Size or UDim2.fromOffset(580, 460)
    Config.TabWidth = Config.TabWidth or 160
    Config.Theme = Config.Theme or "Dark"
    Config.ToggleKey = Config.ToggleKey or Enum.KeyCode.RightControl
    
    local Colors = {
        Background = Color3.fromRGB(15, 15, 15),
        Secondary = Color3.fromRGB(20, 20, 20),
        TitleBar = Color3.fromRGB(25, 25, 25),
        Border = Color3.fromRGB(50, 50, 50),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(200, 200, 200),
    }
    
    local Icons = {
        Close = "rbxassetid://9886659671",
        Max = "rbxassetid://9886659406",
        Restore = "rbxassetid://9886659001",
        Minimize = "rbxassetid://9886659276",
    }
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Colors.Background
    MainFrame.BorderSizePixel = 1
    MainFrame.BorderColor3 = Colors.Border
    MainFrame.Position = UDim2.new(0.5, -Config.Size.X.Offset/2, 0.5, -Config.Size.Y.Offset/2)
    MainFrame.Size = Config.Size
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame
    
    MainFrame.ClipsDescendants = true
    
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Colors.TitleBar
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    
    local TitleBarCorner = Instance.new("UICorner")
    TitleBarCorner.CornerRadius = UDim.new(0, 8)
    TitleBarCorner.Parent = TitleBar
    
    local Title = Instance.new("TextLabel")
    Title.Parent = TitleBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 12, 0, 4)
    Title.Size = UDim2.new(1, -120, 0, 18)
    Title.Text = Config.Title
    Title.TextColor3 = Colors.Text
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    if Config.SubTitle ~= "" then
        local SubTitle = Instance.new("TextLabel")
        SubTitle.Parent = TitleBar
        SubTitle.BackgroundTransparency = 1
        SubTitle.Position = UDim2.new(0, 12, 0, 22)
        SubTitle.Size = UDim2.new(1, -120, 0, 14)
        SubTitle.Text = Config.SubTitle
        SubTitle.TextColor3 = Colors.SubText
        SubTitle.Font = Enum.Font.Gotham
        SubTitle.TextSize = 11
        SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    end
    
    local ButtonHolder = Instance.new("Frame")
    ButtonHolder.Parent = TitleBar
    ButtonHolder.AnchorPoint = Vector2.new(1, 0.5)
    ButtonHolder.Position = UDim2.new(1, -8, 0.5, 0)
    ButtonHolder.Size = UDim2.new(0, 92, 0, 24)
    ButtonHolder.BackgroundTransparency = 1
    
    local Layout = Instance.new("UIListLayout")
    Layout.FillDirection = Enum.FillDirection.Horizontal
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    Layout.VerticalAlignment = Enum.VerticalAlignment.Center
    Layout.Padding = UDim.new(0, 8)
    Layout.Parent = ButtonHolder
    
    local function MakeButton(iconId, color, hoverColor)
        local btn = Instance.new("ImageButton")
        btn.BackgroundTransparency = 0.5
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        btn.Image = iconId
        btn.ImageColor3 = color
        btn.Size = UDim2.new(0, 24, 0, 24)
        btn.Parent = ButtonHolder
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 4)
        btnCorner.Parent = btn
        
        btn.MouseEnter:Connect(function()
            btn.BackgroundTransparency = 0
            btn.BackgroundColor3 = hoverColor
            btn.ImageColor3 = Color3.fromRGB(255, 255, 255)
        end)
        
        btn.MouseLeave:Connect(function()
            btn.BackgroundTransparency = 0.5
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            btn.ImageColor3 = color
        end)
        
        return btn
    end
    
    local MinimizeButton = MakeButton(Icons.Minimize, Color3.fromRGB(220, 220, 220), Color3.fromRGB(60, 120, 180))
    local MaxButton = MakeButton(Icons.Max, Color3.fromRGB(220, 220, 220), Color3.fromRGB(60, 120, 180))
    local CloseButton = MakeButton(Icons.Close, Color3.fromRGB(255, 100, 100), Color3.fromRGB(200, 50, 50))
    
    local dragStart, startPos, dragging = nil, nil, false
    local maximized = false
    local minimized = false
    local originalSize, originalPos = MainFrame.Size, MainFrame.Position
    local uiVisible = true
    
    local function enableDrag(frame)
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and not maximized then
                dragging = true
                dragStart = input.Position
                startPos = MainFrame.Position
            end
        end)
        frame.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
    end
    enableDrag(TitleBar)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundColor3 = Colors.Secondary
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Position = UDim2.new(0, 0, 0, 40)
    ContentFrame.Size = UDim2.new(1, 0, 1, -40)
    
    local TabBar = Instance.new("Frame")
    TabBar.Name = "TabBar"
    TabBar.Parent = ContentFrame
    TabBar.BackgroundColor3 = Colors.TitleBar
    TabBar.BorderSizePixel = 0
    TabBar.Size = UDim2.new(0, Config.TabWidth, 1, 0)
    
    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)
    TabList.Parent = TabBar
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 10)
    TabPadding.PaddingBottom = UDim.new(0, 10)
    TabPadding.PaddingLeft = UDim.new(0, 8)
    TabPadding.PaddingRight = UDim.new(0, 8)
    TabPadding.Parent = TabBar
    
    local Separator = Instance.new("Frame")
    Separator.Name = "Separator"
    Separator.Parent = ContentFrame
    Separator.BackgroundColor3 = Colors.Border
    Separator.BorderSizePixel = 0
    Separator.Position = UDim2.new(0, Config.TabWidth, 0, 0)
    Separator.Size = UDim2.new(0, 1, 1, 0)
    
    local PageContainer = Instance.new("Frame")
    PageContainer.Name = "PageContainer"
    PageContainer.Parent = ContentFrame
    PageContainer.BackgroundTransparency = 1
    PageContainer.Position = UDim2.new(0, Config.TabWidth + 1, 0, 0)
    PageContainer.Size = UDim2.new(1, -Config.TabWidth - 1, 1, 0)
    
    local MinimizedButton = Instance.new("TextButton")
    MinimizedButton.Name = "MinimizedButton"
    MinimizedButton.Parent = ScreenGui
    MinimizedButton.BackgroundColor3 = Colors.TitleBar
    MinimizedButton.BorderSizePixel = 1
    MinimizedButton.BorderColor3 = Color3.fromRGB(72, 138, 182)
    MinimizedButton.Position = UDim2.new(0, 10, 1, -60)
    MinimizedButton.Size = UDim2.new(0, 150, 0, 45)
    MinimizedButton.Font = Enum.Font.GothamBold
    MinimizedButton.Text = Config.Title
    MinimizedButton.TextColor3 = Colors.Text
    MinimizedButton.TextSize = 14
    MinimizedButton.Visible = false
    MinimizedButton.ZIndex = 100
    
    local MinButtonCorner = Instance.new("UICorner")
    MinButtonCorner.CornerRadius = UDim.new(0, 8)
    MinButtonCorner.Parent = MinimizedButton
    
    local MinButtonIcon = Instance.new("ImageLabel")
    MinButtonIcon.Parent = MinimizedButton
    MinButtonIcon.BackgroundTransparency = 1
    MinButtonIcon.Position = UDim2.new(1, -30, 0.5, -10)
    MinButtonIcon.Size = UDim2.fromOffset(20, 20)
    MinButtonIcon.Image = Icons.Max
    MinButtonIcon.ImageColor3 = Color3.fromRGB(72, 138, 182)
    
    MinimizedButton.MouseEnter:Connect(function()
        MinimizedButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)
    
    MinimizedButton.MouseLeave:Connect(function()
        MinimizedButton.BackgroundColor3 = Colors.TitleBar
    end)
    
    MinimizedButton.MouseButton1Click:Connect(function()
        minimized = false
        MinimizedButton.Visible = false
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Size = originalSize
        }):Play()
    end)
    
    MinimizeButton.MouseButton1Click:Connect(function()
        if not minimized then
            minimized = true
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()
            task.wait(0.3)
            MainFrame.Visible = false
            MinimizedButton.Visible = true
        end
    end)
    
    MaxButton.MouseButton1Click:Connect(function()
        if maximized then
            MaxButton.Image = Icons.Max
            MainFrame.Size = originalSize
            MainFrame.Position = originalPos
        else
            MaxButton.Image = Icons.Restore
            originalSize = MainFrame.Size
            originalPos = MainFrame.Position
            MainFrame.Size = UDim2.new(1, -20, 1, -20)
            MainFrame.Position = UDim2.new(0, 10, 0, 10)
        end
        maximized = not maximized
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Config.ToggleKey then
            uiVisible = not uiVisible
            MainFrame.Visible = uiVisible
        end
    end)
    
    local Window = {
        MainFrame = MainFrame,
        PageContainer = PageContainer,
        TabBar = TabBar,
        ScreenGui = ScreenGui,
    }
    
    TabModule:Init(Window)
    
    function Window:AddTab(Config)
        return TabModule:CreateTab(Config)
    end
    
    function Window:Toggle()
        uiVisible = not uiVisible
        MainFrame.Visible = uiVisible
    end
    
    return Window
end
