// Project imports:
import 'package:words625/gen/assets.gen.dart';

List<List<dynamic>> getNepaliData(String firstName) {
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
                "sentence": "Timro naam k ho?",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "Mero naam $firstName ho.",
                  "Ma bidyarthi hu.",
                  "Malai thaha chaina."
                ],
                "correctAnswer": "Mero naam $firstName ho.",
                "translatedSentence": "My name is $firstName."
              },
              {
                "type": "translate",
                "prompt": "Translate the sentence",
                "sentence": "Ma bidyarthi hu.",
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
                "sentence": "Ma khadai chu.",
                "sentenceIsTargetLanguage": true,
                "options": ["I am eating.", "I am walking.", "I am sitting."],
                "correctAnswer": "I am eating."
              },
              {
                "type": "translate",
                "prompt": "Translate the sentence",
                "sentence": "Bholi aauchu.",
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
                "sentence": "Kaso chau?",
                "sentenceIsTargetLanguage": true,
                "options": ["Ma thik chu.", "Malai thaha chaina.", "Mero naam $firstName."],
                "correctAnswer": "Ma thik chu.",
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
                "sentence": "Timi kaha baschau?",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "Ma Kathmandu ma baschu.",
                  "Malai thaha chaina.",
                  "Bholi aauchu."
                ],
                "correctAnswer": "Ma Kathmandu ma baschu."
              },
              {
                "type": "translate",
                "prompt": "Translate the sentence",
                "sentence": "Uha mero bhai ho.",
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
                "sentence": "Uha mero dai ho.",
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
                "sentence": "Malai Nepali aaucha.",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "I know Nepali.",
                  "I speak Nepali.",
                  "I am learning Nepali."
                ],
                "correctAnswer": "I know Nepali."
              },
              {
                "type": "multiple_choice",
                "prompt": "Choose an appropriate response",
                "sentence": "Coffee khanuhuncha?",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "Hajur, coffee khanchu.",
                  "Nai, ma coffee khadinna.",
                  "Chiya khanchu."
                ],
                "correctAnswer": "Hajur, coffee khanchu."
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
                "options": ["Namaste", "Bida", "Dhanyabad"],
                "correctAnswer": "Namaste",
                "translatedSentence": "Hello"
              },
              {
                "type": "translate",
                "prompt": "Translate to English",
                "sentence": "Swagatam",
                "sentenceIsTargetLanguage": true,
                "options": ["Welcome", "Goodbye", "Thank you"],
                "correctAnswer": "Welcome"
              },
              {
                "type": "translate",
                "prompt": "Translate to Nepali",
                "sentence": "Good Morning",
                "options": ["Subha Prabhat", "Subha Ratri", "Namaste"],
                "correctAnswer": "Subha Prabhat"
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
                "sentence": "Mero naam ... ho",
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
                "sentence": "Kukur",
                "sentenceIsTargetLanguage": true,
                "options": ["Dog", "Cat", "Cow"],
                "correctAnswer": "Dog"
              },
              {
                "type": "translate",
                "prompt": "Translate 'Cat'",
                "sentence": "Biralo",
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
                "sentence": "Rato",
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
        "courseName": "Life in Kathmandu",
        "image": Assets.images.bandages.path,
        "color": 0xff00FF00,
        "levels": [
          {
            "level": 1,
            "questions": [
              {
                "type": "translate",
                "prompt": "Ask 'How much?'",
                "sentence": "Kati paisa?",
                "sentenceIsTargetLanguage": true,
                "options": ["How much money?", "What time?", "Where?"],
                "correctAnswer": "How much money?"
              },
              {
                "type": "translate",
                "prompt": "Direction",
                "sentence": "Thamel jane?",
                "sentenceIsTargetLanguage": true,
                "options": ["Will you go to Thamel?", "Where is Thamel?", "Is this Thamel?"],
                "correctAnswer": "Will you go to Thamel?"
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
                "sentence": "Ma busy chu.",
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
                "sentence": "Ma khushi chu.",
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
                "sentence": "Ek plate Momo dinu.",
                "sentenceIsTargetLanguage": true,
                "options": ["Give me one plate Momo.", "I like Momo.", "Where is Momo?"],
                "correctAnswer": "Give me one plate Momo."
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
                "sentence": "Paani paryo",
                "sentenceIsTargetLanguage": true,
                "options": ["It rained", "It is sunny", "It is windy"],
                "correctAnswer": "It rained"
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
                "prompt": "Translate 'Bus'",
                "sentence": "Bus",
                "sentenceIsTargetLanguage": true,
                "options": ["Bus", "Train", "Car"],
                "correctAnswer": "Bus"
              }
            ]
          }
        ]
      }
    ]
  ];
}

Map<String, String> nepaliDictionary = {
  "Timro": "Your",
  "naam": "name",
  "k": "what",
  "Mero": "My",
  "Ma": "I",
  "bidyarthi": "student",
  "khadai": "eating",
  "Bholi": "tomorrow",
  "aauchu": "will come",
  "Kaso": "How",
  "chau": "are (you)",
  "thik": "fine",
  "thaha chaina": "don't know",
  "kaha": "where",
  "baschau": "stay/live",
  "Uha": "He/She",
  "bhai": "younger brother",
  "dai": "elder brother",
  "aaucha": "know/comes",
  "khanuhuncha": "eat/drink (honorific)",
  "Hajur": "Yes (polite)",
  "Nai": "No",
  "Chiya": "Tea",
  "Namaste": "Hello",
  "Dhanyabad": "Thank you",
  "Swagatam": "Welcome",
  "Subha": "Good",
  "Prabhat": "Morning",
  "Ratri": "Night",
  "Kukur": "Dog",
  "Biralo": "Cat",
  "Rato": "Red",
  "Kati": "How much"
};

