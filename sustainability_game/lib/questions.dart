class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}

typedef QuestionsByLevel = Map<String, List<Question>>;
typedef QuestionsByLanguage = Map<String, QuestionsByLevel>;

final QuestionsByLanguage questions = {
  'ar': {
    'beginner': [
      Question(
        questionText: "ما هو تعريف الاستدامة؟",
        options: [
          "استخدام الموارد بشكل عشوائي",
          "تلبية احتياجات الحاضر دون المساس بقدرة الأجيال القادمة",
          "زيادة استهلاك الموارد الطبيعية",
          "تجاهل الآثار البيئية للتنمية"
        ],
        correctAnswerIndex: 1,
        explanation: "الاستدامة تعني التوازن بين احتياجات الحاضر والمستقبل",
      ),
      Question(
        questionText: "ما هي أحد أهم مصادر الطاقة المتجددة؟",
        options: [
          "الفحم",
          "النفط",
          "الطاقة الشمسية",
          "الغاز الطبيعي"
        ],
        correctAnswerIndex: 2,
        explanation: "الطاقة الشمسية مصدر متجدد ونظيف للطاقة",
      ),
      Question(
        questionText: "ما هي أفضل طريقة لتقليل النفايات؟",
        options: [
          "إعادة التدوير",
          "الحرق",
          "الدفن",
          "الرمي في البحر"
        ],
        correctAnswerIndex: 0,
        explanation: "إعادة التدوير تساعد في الحفاظ على البيئة وتقليل النفايات",
      ),
      Question(
        questionText: "ما هو أفضل أسلوب لترشيد استهلاك المياه؟",
        options: [
          "ترك الصنبور مفتوحاً",
          "استخدام المياه بلا حدود",
          "إصلاح التسريبات فوراً",
          "تجاهل تسرب المياه"
        ],
        correctAnswerIndex: 2,
        explanation: "إصلاح التسريبات يوفر كميات كبيرة من المياه",
      ),
      Question(
        questionText: "ما هو تأثير زراعة الأشجار على البيئة؟",
        options: [
          "زيادة التلوث",
          "تقليل الأكسجين",
          "تحسين جودة الهواء",
          "زيادة درجة الحرارة"
        ],
        correctAnswerIndex: 2,
        explanation: "الأشجار تنقي الهواء وتقلل من التلوث",
      ),
      Question(
        questionText: "ما هي أفضل وسيلة للتنقل صديقة للبيئة؟",
        options: [
          "السيارات الخاصة",
          "الدراجات الهوائية",
          "الطائرات",
          "السيارات القديمة"
        ],
        correctAnswerIndex: 1,
        explanation: "الدراجات الهوائية لا تسبب أي تلوث للبيئة",
      ),
      Question(
        questionText: "كيف يمكن توفير الطاقة في المنزل؟",
        options: [
          "ترك الأجهزة تعمل دائماً",
          "استخدام مصابيح LED",
          "فتح النوافذ مع تشغيل المكيف",
          "تشغيل جميع الأضواء"
        ],
        correctAnswerIndex: 1,
        explanation: "مصابيح LED توفر الطاقة وتدوم لفترة أطول",
      ),
      Question(
        questionText: "ما هو أفضل مكان لرمي البطاريات المستعملة؟",
        options: [
          "في القمامة العادية",
          "في الحديقة",
          "في مراكز إعادة التدوير المخصصة",
          "في المجاري"
        ],
        correctAnswerIndex: 2,
        explanation: "البطاريات تحتوي على مواد خطرة تحتاج لمعالجة خاصة",
      ),
      Question(
        questionText: "ما هو تأثير البلاستيك على البيئة البحرية؟",
        options: [
          "لا يوجد تأثير",
          "يساعد الكائنات البحرية",
          "يضر بالكائنات البحرية",
          "يحسن جودة المياه"
        ],
        correctAnswerIndex: 2,
        explanation: "البلاستيك يهدد حياة الكائنات البحرية ويلوث المحيطات",
      ),
      Question(
        questionText: "ما هي أفضل طريقة للتسوق المستدام؟",
        options: [
          "شراء كل ما نراه",
          "استخدام أكياس قماشية قابلة لإعادة الاستخدام",
          "طلب أكياس بلاستيكية إضافية",
          "شراء المنتجات ذات التغليف الزائد"
        ],
        correctAnswerIndex: 1,
        explanation: "الأكياس القماشية تقلل من استهلاك البلاستيك",
      ),
    ],
    'professional': [
      Question(
        questionText: "ما هي اتفاقية باريس للمناخ؟",
        options: [
          "اتفاقية تجارية",
          "معاهدة للحد من انبعاثات الغازات الدفيئة",
          "اتفاقية سياحية",
          "معاهدة عسكرية"
        ],
        correctAnswerIndex: 1,
        explanation: "اتفاقية باريس تهدف للحد من ارتفاع درجة حرارة الأرض",
      ),
      Question(
        questionText: "ما هو مفهوم البصمة الكربونية؟",
        options: [
          "آثار الأقدام على الأرض",
          "كمية ثاني أكسيد الكربون المنبعثة من الأنشطة البشرية",
          "نوع من أنواع الطباعة",
          "قياس مساحة الغابات"
        ],
        correctAnswerIndex: 1,
        explanation: "البصمة الكربونية تقيس تأثير الإنسان على البيئة",
      ),
      Question(
        questionText: "ما هو الاقتصاد الدائري؟",
        options: [
          "نظام اقتصادي تقليدي",
          "نظام يعتمد على إعادة استخدام الموارد وتقليل النفايات",
          "نظام مصرفي",
          "نظام ضريبي"
        ],
        correctAnswerIndex: 1,
        explanation: "الاقتصاد الدائري يهدف لتقليل الهدر وإعادة استخدام الموارد",
      ),
      Question(
        questionText: "ما هي تقنية الطاقة الحرارية الأرضية؟",
        options: [
          "حرق الوقود الأحفوري",
          "استخدام حرارة باطن الأرض لتوليد الطاقة",
          "تخزين الطاقة في البطاريات",
          "استخدام الطاقة النووية"
        ],
        correctAnswerIndex: 1,
        explanation: "الطاقة الحرارية الأرضية مصدر متجدد للطاقة",
      ),
      Question(
        questionText: "ما هو مفهوم التنوع البيولوجي؟",
        options: [
          "تربية الحيوانات الأليفة",
          "تنوع الكائنات الحية في النظام البيئي",
          "زراعة نوع واحد من النباتات",
          "تربية الأسماك"
        ],
        correctAnswerIndex: 1,
        explanation: "التنوع البيولوجي ضروري لتوازن النظام البيئي",
      ),
      Question(
        questionText: "ما هي تقنية التقاط الكربون وتخزينه؟",
        options: [
          "زراعة الأشجار فقط",
          "تقنية لالتقاط وتخزين ثاني أكسيد الكربون من الانبعاثات الصناعية",
          "حرق النفايات",
          "تخزين النفط"
        ],
        correctAnswerIndex: 1,
        explanation: "هذه التقنية تساعد في تقليل انبعاثات الغازات الدفيئة",
      ),
      Question(
        questionText: "ما هو مفهوم العمارة الخضراء؟",
        options: [
          "طلاء المباني باللون الأخضر",
          "تصميم وبناء مباني مستدامة وصديقة للبيئة",
          "بناء الحدائق فقط",
          "تزيين المباني بالنباتات"
        ],
        correctAnswerIndex: 1,
        explanation: "العمارة الخضراء تهدف لتقليل الأثر البيئي للمباني",
      ),
      Question(
        questionText: "ما هي تقنية الهيدروجين الأخضر؟",
        options: [
          "تلوين الهيدروجين",
          "إنتاج الهيدروجين باستخدام الطاقة المتجددة",
          "استخراج الهيدروجين من النفط",
          "تخزين الغاز الطبيعي"
        ],
        correctAnswerIndex: 1,
        explanation: "الهيدروجين الأخضر وقود نظيف للمستقبل",
      ),
      Question(
        questionText: "ما هو مفهوم الزراعة المستدامة؟",
        options: [
          "استخدام المبيدات بكثرة",
          "ممارسات زراعية تحافظ على البيئة وتضمن إنتاج طويل المدى",
          "زراعة نوع واحد من المحاصيل",
          "استنزاف التربة"
        ],
        correctAnswerIndex: 1,
        explanation: "الزراعة المستدامة تحافظ على خصوبة التربة والموارد",
      ),
      Question(
        questionText: "ما هو مفهوم التمويل الأخضر؟",
        options: [
          "طباعة النقود الخضراء",
          "تمويل المشاريع الصديقة للبيئة والمستدامة",
          "الاستثمار في النفط",
          "تمويل المصانع التقليدية"
        ],
        correctAnswerIndex: 1,
        explanation: "التمويل الأخضر يدعم التحول نحو اقتصاد مستدام",
      ),
    ],
  },
  'en': {
    'beginner': [
      Question(
        questionText: "What is the definition of sustainability?",
        options: [
          "Using resources randomly",
          "Meeting present needs without compromising future generations",
          "Increasing consumption of natural resources",
          "Ignoring environmental impacts of development"
        ],
        correctAnswerIndex: 1,
        explanation: "Sustainability means balancing present and future needs",
      ),
      Question(
        questionText: "What is one of the most important renewable energy sources?",
        options: [
          "Coal",
          "Oil",
          "Solar energy",
          "Natural gas"
        ],
        correctAnswerIndex: 2,
        explanation: "Solar energy is a clean and renewable source",
      ),
      Question(
        questionText: "What is the best way to reduce waste?",
        options: [
          "Recycling",
          "Burning",
          "Landfilling",
          "Dumping in the sea"
        ],
        correctAnswerIndex: 0,
        explanation: "Recycling helps preserve the environment and reduce waste",
      ),
      Question(
        questionText: "What is the best way to conserve water?",
        options: [
          "Leaving taps running",
          "Using unlimited water",
          "Fixing leaks immediately",
          "Ignoring water leaks"
        ],
        correctAnswerIndex: 2,
        explanation: "Fixing leaks saves large amounts of water",
      ),
      Question(
        questionText: "What is the impact of planting trees on the environment?",
        options: [
          "Increasing pollution",
          "Reducing oxygen",
          "Improving air quality",
          "Increasing temperature"
        ],
        correctAnswerIndex: 2,
        explanation: "Trees purify the air and reduce pollution",
      ),
      Question(
        questionText: "What is the most environmentally friendly mode of transport?",
        options: [
          "Private cars",
          "Bicycles",
          "Airplanes",
          "Old cars"
        ],
        correctAnswerIndex: 1,
        explanation: "Bicycles cause no pollution to the environment",
      ),
      Question(
        questionText: "How can we save energy at home?",
        options: [
          "Leaving devices running",
          "Using LED bulbs",
          "Opening windows with AC on",
          "Turning on all lights"
        ],
        correctAnswerIndex: 1,
        explanation: "LED bulbs save energy and last longer",
      ),
      Question(
        questionText: "What is the best place to dispose of used batteries?",
        options: [
          "Regular trash",
          "Garden",
          "Dedicated recycling centers",
          "Sewers"
        ],
        correctAnswerIndex: 2,
        explanation: "Batteries contain hazardous materials that need special handling",
      ),
      Question(
        questionText: "What is the impact of plastic on marine life?",
        options: [
          "No impact",
          "Helps marine life",
          "Harms marine life",
          "Improves water quality"
        ],
        correctAnswerIndex: 2,
        explanation: "Plastic threatens marine life and pollutes oceans",
      ),
      Question(
        questionText: "What is the best way for sustainable shopping?",
        options: [
          "Buying everything we see",
          "Using reusable cloth bags",
          "Requesting extra plastic bags",
          "Buying over-packaged products"
        ],
        correctAnswerIndex: 1,
        explanation: "Cloth bags reduce plastic consumption",
      ),
    ],
    'professional': [
      Question(
        questionText: "What is the Paris Climate Agreement?",
        options: [
          "A trade agreement",
          "A treaty to limit greenhouse gas emissions",
          "A tourism agreement",
          "A military treaty"
        ],
        correctAnswerIndex: 1,
        explanation: "The Paris Agreement aims to limit global temperature rise",
      ),
      Question(
        questionText: "What is the concept of carbon footprint?",
        options: [
          "Footprints on the ground",
          "Amount of CO2 emitted from human activities",
          "A type of printing",
          "Measuring forest area"
        ],
        correctAnswerIndex: 1,
        explanation: "Carbon footprint measures human impact on the environment",
      ),
      Question(
        questionText: "What is the circular economy?",
        options: [
          "A traditional economic system",
          "A system based on reusing resources and reducing waste",
          "A banking system",
          "A tax system"
        ],
        correctAnswerIndex: 1,
        explanation: "Circular economy aims to reduce waste and reuse resources",
      ),
      Question(
        questionText: "What is geothermal energy technology?",
        options: [
          "Burning fossil fuels",
          "Using Earth's heat to generate energy",
          "Storing energy in batteries",
          "Using nuclear energy"
        ],
        correctAnswerIndex: 1,
        explanation: "Geothermal energy is a renewable energy source",
      ),
      Question(
        questionText: "What is the concept of biodiversity?",
        options: [
          "Pet breeding",
          "Variety of living organisms in an ecosystem",
          "Growing one type of plant",
          "Fish farming"
        ],
        correctAnswerIndex: 1,
        explanation: "Biodiversity is essential for ecosystem balance",
      ),
      Question(
        questionText: "What is carbon capture and storage technology?",
        options: [
          "Just planting trees",
          "Technology to capture and store CO2 from industrial emissions",
          "Burning waste",
          "Storing oil"
        ],
        correctAnswerIndex: 1,
        explanation: "This technology helps reduce greenhouse gas emissions",
      ),
      Question(
        questionText: "What is the concept of green architecture?",
        options: [
          "Painting buildings green",
          "Designing and building sustainable, eco-friendly buildings",
          "Building only gardens",
          "Decorating buildings with plants"
        ],
        correctAnswerIndex: 1,
        explanation: "Green architecture aims to reduce buildings' environmental impact",
      ),
      Question(
        questionText: "What is green hydrogen technology?",
        options: [
          "Coloring hydrogen",
          "Producing hydrogen using renewable energy",
          "Extracting hydrogen from oil",
          "Storing natural gas"
        ],
        correctAnswerIndex: 1,
        explanation: "Green hydrogen is a clean fuel for the future",
      ),
      Question(
        questionText: "What is the concept of sustainable agriculture?",
        options: [
          "Using pesticides extensively",
          "Agricultural practices that maintain environment and ensure long-term production",
          "Growing one type of crop",
          "Depleting soil"
        ],
        correctAnswerIndex: 1,
        explanation: "Sustainable agriculture maintains soil fertility and resources",
      ),
      Question(
        questionText: "What is the concept of green finance?",
        options: [
          "Printing green money",
          "Financing eco-friendly and sustainable projects",
          "Investing in oil",
          "Financing traditional factories"
        ],
        correctAnswerIndex: 1,
        explanation: "Green finance supports the transition to a sustainable economy",
      ),
    ],
  },
}; 