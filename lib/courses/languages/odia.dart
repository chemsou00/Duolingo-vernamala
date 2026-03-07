// Project imports:
import 'package:words625/gen/assets.gen.dart';

List<List<dynamic>> getOdiaData(String firstName) {
  return [
    [
      {
        "courseName": "basics",
        "image": Assets.images.egg.path,
        "color": 0xff2b70c9,
        "levels": [
          {
            "level": 1,
            "questions": [
              {
                "type": "multiple_choice",
                "prompt": "Choose an appropriate response",
                "sentence": "Tumara nama kana?",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "Mora nama $firstName.",
                  "Mu chatra.",
                  "Mate jana nahi."
                ],
                "correctAnswer": "Mora nama $firstName.",
                "translatedSentence": "My name is $firstName."
              },
              {
                "type": "translate",
                "prompt": "Translate the sentence",
                "sentence": "Mu chatra.",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "I am a student.",
                  "You are a student.",
                  "They are students."
                ],
                "correctAnswer": "I am a student."
              },
              {
                "type": "translate",
                "prompt": "Translate the sentence",
                "sentence": "Mu khauchi.",
                "sentenceIsTargetLanguage": true,
                "options": ["I am eating.", "I am walking.", "I am sitting."],
                "correctAnswer": "I am eating."
              },
              {
                "type": "translate",
                "prompt": "Translate the sentence",
                "sentence": "Kali asibi.",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "I will come tomorrow.",
                  "I am going now.",
                  "I will not come."
                ],
                "correctAnswer": "I will come tomorrow."
              },
              {
                "type": "multiple_choice",
                "prompt": "Choose an appropriate response",
                "sentence": "Kemiti acha?",
                "sentenceIsTargetLanguage": true,
                "options": ["Mu bhala achi.", "Mate jana nahi.", "Mora nama $firstName."],
                "correctAnswer": "Mu bhala achi.",
                "translatedSentence": "I am fine."
              }
            ]
          },
          {
            "level": 2,
            "questions": [
              {
                "type": "multiple_choice",
                "prompt": "Choose an appropriate response",
                "sentence": "Tume kauthi raha?",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "Mu Bhubaneswar re rahe.",
                  "Mate jana nahi.",
                  "Kali asibi."
                ],
                "correctAnswer": "Mu Bhubaneswar re rahe."
              },
              {
                "type": "translate",
                "prompt": "Translate the sentence",
                "sentence": "Se mora sana bhai.",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "He is my friend.",
                  "He is my younger brother.",
                  "He is my cousin."
                ],
                "correctAnswer": "He is my younger brother."
              },
              {
                "type": "translate",
                "prompt": "Translate the sentence",
                "sentence": "Se mora bada bhai.",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "He is my friend.",
                  "He is my elder brother.",
                  "He is my cousin."
                ],
                "correctAnswer": "He is my elder brother."
              },
              {
                "type": "translate",
                "prompt": "Translate the sentence",
                "sentence": "Mate Odia ase.",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "I know Odia.",
                  "I speak Odia.",
                  "I am learning Odia."
                ],
                "correctAnswer": "I know Odia."
              },
              {
                "type": "multiple_choice",
                "prompt": "Choose an appropriate response",
                "sentence": "Coffee piiba ki?",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "Han, mu Coffee piibi.",
                  "Na, mu Coffee piibi nahi.",
                  "Cha piibi."
                ],
                "correctAnswer": "Han, mu Coffee piibi."
              }
            ]
          }
        ]
      }
    ],
    [
      {
        "courseName": "greetings",
        "image": Assets.images.hand.path,
        "color": 0xffFFD700,
        "levels": [
          {
            "level": 1,
            "questions": [
              {
                "type": "multiple_choice",
                "prompt": "Choose the correct greeting",
                "sentence": "Hello",
                "options": ["Namaskar", "Bidaya", "Dhanyabad"],
                "correctAnswer": "Namaskar",
                "translatedSentence": "Hello"
              },
              {
                "type": "translate",
                "prompt": "Translate to English",
                "sentence": "Swagata",
                "sentenceIsTargetLanguage": true,
                "options": ["Welcome", "Goodbye", "Thank you"],
                "correctAnswer": "Welcome"
              },
              {
                "type": "translate",
                "prompt": "Translate to Odia",
                "sentence": "Good Morning",
                "options": ["Subha Sakala", "Subha Ratri", "Namaskar"],
                "correctAnswer": "Subha Sakala"
              }
            ]
          }
        ]
      }
    ],
    [
      {
        "courseName": "introduction",
        "image": Assets.images.pen.path,
        "color": 0xffCE82FF,
        "levels": [
          {
            "level": 1,
            "questions": [
              {
                "type": "translate",
                "prompt": "Translate 'My name is ...'",
                "sentence": "Mora nama ...",
                "sentenceIsTargetLanguage": true,
                "options": ["My name is ...", "I am ...", "Who are you?"],
                "correctAnswer": "My name is ..."
              }
            ]
          }
        ]
      }
    ],
    [
      {
        "courseName": "animals",
        "image": Assets.images.fish.path,
        "color": 0xffFFA500,
        "levels": [
          {
            "level": 1,
            "questions": [
              {
                "type": "translate",
                "prompt": "Translate 'Dog'",
                "sentence": "Kukura",
                "sentenceIsTargetLanguage": true,
                "options": ["Dog", "Cat", "Cow"],
                "correctAnswer": "Dog"
              },
              {
                "type": "translate",
                "prompt": "Translate 'Cat'",
                "sentence": "Bilei",
                "sentenceIsTargetLanguage": true,
                "options": ["Cat", "Dog", "Mouse"],
                "correctAnswer": "Cat"
              }
            ]
          }
        ]
      },
      {
        "courseName": "colors",
        "image": Assets.images.bucket.path,
        "color": 0xffFF0000,
        "levels": [
          {
            "level": 1,
            "questions": [
              {
                "type": "translate",
                "prompt": "Translate 'Red'",
                "sentence": "Nali",
                "sentenceIsTargetLanguage": true,
                "options": ["Red", "Blue", "Green"],
                "correctAnswer": "Red"
              }
            ]
          }
        ]
      }
    ],
    [
      {
        "courseName": "Life in Bhubaneswar",
        "image": Assets.images.bandages.path,
        "color": 0xff00FF00,
        "levels": [
          {
            "level": 1,
            "questions": [
              {
                "type": "translate",
                "prompt": "Ask 'How much?'",
                "sentence": "Kete tanka?",
                "sentenceIsTargetLanguage": true,
                "options": ["How much money?", "What time?", "Where?"],
                "correctAnswer": "How much money?"
              },
              {
                "type": "translate",
                "prompt": "Direction",
                "sentence": "Lingaraj Mandira jibi.",
                "sentenceIsTargetLanguage": true,
                "options": ["I will go to Lingaraj Temple.", "Where is Lingaraj Temple?", "Is this Lingaraj Temple?"],
                "correctAnswer": "I will go to Lingaraj Temple."
              }
            ]
          }
        ]
      }
    ],
    [
      {
        "courseName": "office",
        "image": Assets.images.heel.path,
        "color": 0xffFFD700,
        "levels": [
          {
            "level": 1,
            "questions": [
              {
                "type": "translate",
                "prompt": "Translate 'I am busy'",
                "sentence": "Mu byasta achi.",
                "sentenceIsTargetLanguage": true,
                "options": ["I am busy.", "I am free.", "I am tired."],
                "correctAnswer": "I am busy."
              }
            ]
          }
        ]
      },
      {
        "courseName": "numbers",
        "image": Assets.images.hammer.path,
        "color": 0xff808080,
        "levels": [
          {
            "level": 1,
            "questions": [
              {
                "type": "translate",
                "prompt": "Translate 'One'",
                "sentence": "Ek",
                "sentenceIsTargetLanguage": true,
                "options": ["One", "Two", "Three"],
                "correctAnswer": "One"
              },
              {
                "type": "translate",
                "prompt": "Translate 'Two'",
                "sentence": "Dui",
                "sentenceIsTargetLanguage": true,
                "options": ["Two", "Three", "Four"],
                "correctAnswer": "Two"
              }
            ]
          }
        ]
      },
      {
        "courseName": "emotions",
        "image": Assets.images.emotion.path,
        "color": 0xff0000FF,
        "levels": [
          {
            "level": 1,
            "questions": [
              {
                "type": "translate",
                "prompt": "Translate 'I am happy'",
                "sentence": "Mu khusi achi.",
                "sentenceIsTargetLanguage": true,
                "options": ["I am happy.", "I am sad.", "I am angry."],
                "correctAnswer": "I am happy."
              }
            ]
          }
        ]
      }
    ],
    [
      {
        "courseName": "food & gym",
        "image": Assets.images.dumbbell.path,
        "color": 0xff2b70c9,
        "levels": [
          {
            "level": 1,
            "questions": [
              {
                "type": "translate",
                "prompt": "Order food",
                "sentence": "Mate Dahi Bara dia.",
                "sentenceIsTargetLanguage": true,
                "options": ["Give me Dahi Bara.", "I like Dahi Bara.", "Where is Dahi Bara?"],
                "correctAnswer": "Give me Dahi Bara."
              }
            ]
          }
        ]
      },
      {
        "courseName": "nature",
        "image": Assets.images.tree.path,
        "color": 0xffFF0000,
        "levels": [
          {
            "level": 1,
            "questions": [
              {
                "type": "translate",
                "prompt": "Translate 'Rain'",
                "sentence": "Barsha",
                "sentenceIsTargetLanguage": true,
                "options": ["Rain", "Sun", "Wind"],
                "correctAnswer": "Rain"
              }
            ]
          }
        ]
      },
      {
        "courseName": "travel",
        "image": Assets.images.egg.path,
        "color": 0xffFFA500,
        "levels": [
          {
            "level": 1,
            "questions": [
              {
                "type": "translate",
                "prompt": "Translate 'Train'",
                "sentence": "Train",
                "sentenceIsTargetLanguage": true,
                "options": ["Train", "Bus", "Car"],
                "correctAnswer": "Train"
              }
            ]
          }
        ]
      }
    ]
  ];
}

Map<String, String> odiaDictionary = {
  "Tumara": "Your",
  "nama": "name",
  "kana": "what",
  "Mora": "My",
  "Mu": "I",
  "chatra": "student",
  "khauchi": "eating",
  "Kali": "tomorrow",
  "asibi": "will come",
  "Kemiti": "How",
  "acha": "are (you)",
  "bhala": "good/fine",
  "jana nahi": "don't know",
  "kauthi": "where",
  "raha": "stay/live",
  "Se": "He/She",
  "sana": "younger",
  "bada": "elder/big",
  "bhai": "brother",
  "ase": "know/comes",
  "piiba": "drink",
  "Han": "Yes",
  "Na": "No",
  "Cha": "Tea",
  "Namaskar": "Hello",
  "Dhanyabad": "Thank you",
  "Swagata": "Welcome",
  "Subha": "Good",
  "Sakala": "Morning",
  "Ratri": "Night",
  "Kukura": "Dog",
  "Bilei": "Cat",
  "Nali": "Red",
  "Kete": "How much",
  "Barsha": "Rain"
};

