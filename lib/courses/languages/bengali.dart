// Project imports:
import 'package:words625/gen/assets.gen.dart';

List<List<dynamic>> getBengaliData(String firstName) {
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
                "sentence": "Tomar naam ki?",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "Amar naam $firstName.",
                  "Ami chatro.",
                  "Ami jani na."
                ],
                "correctAnswer": "Amar naam $firstName.",
                "translatedSentence": "My name is $firstName."
              },
              {
                "type": "translate",
                "prompt": "Translate the sentence",
                "sentence": "Ami chatro.",
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
                "sentence": "Ami khacchi.",
                "sentenceIsTargetLanguage": true,
                "options": ["I am eating.", "I am walking.", "I am sitting."],
                "correctAnswer": "I am eating."
              },
              {
                "type": "translate",
                "prompt": "Translate the sentence",
                "sentence": "Kaal ashbo.",
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
                "sentence": "Kemon acho?",
                "sentenceIsTargetLanguage": true,
                "options": ["Ami bhalo achi.", "Ami jani na.", "Amar naam $firstName."],
                "correctAnswer": "Ami bhalo achi.",
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
                "sentence": "Tumi kothay thako?",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "Ami Kolkata-e thaki.",
                  "Ami jani na.",
                  "Kaal ashbo."
                ],
                "correctAnswer": "Ami Kolkata-e thaki."
              },
              {
                "type": "translate",
                "prompt": "Translate the sentence",
                "sentence": "O amar chhoto bhai.",
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
                "sentence": "O amar dada.",
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
                "sentence": "Ami Bangla jani.",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "I know Bengali.",
                  "I speak Bengali.",
                  "I am learning Bengali."
                ],
                "correctAnswer": "I know Bengali."
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
                "options": ["Nomoshkar", "Biday", "Dhonnobad"],
                "correctAnswer": "Nomoshkar",
                "translatedSentence": "Hello"
              },
              {
                "type": "translate",
                "prompt": "Translate to English",
                "sentence": "Shagotom",
                "sentenceIsTargetLanguage": true,
                "options": ["Welcome", "Goodbye", "Thank you"],
                "correctAnswer": "Welcome"
              },
              {
                "type": "translate",
                "prompt": "Translate to Bengali",
                "sentence": "Good Morning",
                "options": ["Su-probhat", "Subho Ratri", "Nomoshkar"],
                "correctAnswer": "Su-probhat"
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
                "sentence": "Amar naam ...",
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
                "sentence": "Beral",
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
                "sentence": "Laal",
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
        "courseName": "Life in Kolkata",
        "image": Assets.images.bandages.path,
        "color": 0xff00FF00,
        "levels": [
          {
            "level": 1,
            "questions": [
              {
                "type": "translate",
                "prompt": "Ask 'Will you go?'",
                "sentence": "Dada, jaben?",
                "sentenceIsTargetLanguage": true,
                "options": ["Brother, will you go?", "Where are you going?", "How much?"],
                "correctAnswer": "Brother, will you go?"
              },
              {
                "type": "translate",
                "prompt": "Ask 'How much?'",
                "sentence": "Koto holo?",
                "sentenceIsTargetLanguage": true,
                "options": ["How much?", "What time?", "Where?"],
                "correctAnswer": "How much?"
              },
              {
                "type": "translate",
                "prompt": "Direction",
                "sentence": "Howrah Station jabo.",
                "sentenceIsTargetLanguage": true,
                "options": ["I will go to Howrah Station.", "Where is Howrah Station?", "Is this Howrah Station?"],
                "correctAnswer": "I will go to Howrah Station."
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
                "sentence": "Ami byasto achi.",
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
                "sentence": "Ami khushi.",
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
                "sentence": "Ek plate mishti doi din.",
                "sentenceIsTargetLanguage": true,
                "options": ["Give me one plate of sweet curd.", "I like sweet curd.", "Where is sweet curd?"],
                "correctAnswer": "Give me one plate of sweet curd."
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
                "sentence": "Brishti",
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
                "prompt": "Translate 'Metro'",
                "sentence": "Metro",
                "sentenceIsTargetLanguage": true,
                "options": ["Metro", "Bus", "Tram"],
                "correctAnswer": "Metro"
              }
            ]
          }
        ]
      }
    ]
  ];
}

Map<String, String> bengaliDictionary = {
  "Tomar": "Your",
  "naam": "name",
  "ki": "what",
  "Amar": "My",
  "Ami": "I",
  "chatro": "student",
  "khacchi": "eating",
  "Kaal": "tomorrow",
  "ashbo": "will come",
  "Kemon": "How",
  "acho": "are (you)",
  "bhalo": "good/fine",
  "jani na": "don't know",
  "kothay": "where",
  "thako": "stay/live",
  "O": "He/She",
  "chhoto": "younger/small",
  "bhai": "brother",
  "dada": "elder brother",
  "jani": "know",
  "khabe": "will eat/drink",
  "Hyang": "Yes",
  "Na": "No",
  "Cha": "Tea",
  "Nomoshkar": "Hello",
  "Dhonnobad": "Thank you",
  "Shagotom": "Welcome",
  "Su-probhat": "Good Morning",
  "Subho Ratri": "Good Night",
  "Kukur": "Dog",
  "Beral": "Cat",
  "Laal": "Red",
  "Koto": "How much",
  "Brishti": "Rain"
};

