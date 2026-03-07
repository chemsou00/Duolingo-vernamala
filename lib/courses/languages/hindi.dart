// Project imports:
import 'package:words625/gen/assets.gen.dart';

List<List<dynamic>> getHindiData(String firstName) {
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
                "sentence": "Tumhara naam kya hai?",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "Mera naam $firstName hai.",
                  "Main student hoon.",
                  "Mujhe nahi pata."
                ],
                "correctAnswer": "Mera naam $firstName hai.",
                "translatedSentence": "My name is $firstName."
              },
              {
                "type": "translate",
                "prompt": "Translate the sentence",
                "sentence": "Main vidyarthi hoon.",
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
                "sentence": "Main khaana kha raha hoon.",
                "sentenceIsTargetLanguage": true,
                "options": ["I am eating.", "I am walking.", "I am sitting."],
                "correctAnswer": "I am eating."
              },
              {
                "type": "translate",
                "prompt": "Translate the sentence",
                "sentence": "Kal aaunga.",
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
                "sentence": "Kaise ho?",
                "sentenceIsTargetLanguage": true,
                "options": ["Main theek hoon.", "Mujhe nahi pata.", "Mera naam $firstName."],
                "correctAnswer": "Main theek hoon.",
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
                "sentence": "Tum kahan se ho?",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "Main Delhi se hoon.",
                  "Mujhe nahi pata.",
                  "Kal aaunga."
                ],
                "correctAnswer": "Main Delhi se hoon."
              },
              {
                "type": "translate",
                "prompt": "Translate the sentence",
                "sentence": "Woh mera chhota bhai hai.",
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
                "sentence": "Woh mera bada bhai hai.",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "He is my friend.",
                  "He is my elder brother.",
                  "He is my cousin."
                ],
                "correctAnswer": "He is my elder brother."
              },
              {
                "type": "multiple_choice",
                "prompt": "Choose an appropriate response",
                "sentence": "Tum kahan jaa rahe ho?",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "Main ghar jaa raha hoon.",
                  "Mera ghar yeh hai.",
                  "Kal aaunga."
                ],
                "correctAnswer": "Main ghar jaa raha hoon."
              },
              {
                "type": "translate",
                "prompt": "Translate the sentence",
                "sentence": "Mujhe Hindi aati hai.",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "I know Hindi.",
                  "I speak Hindi fluently.",
                  "I am learning Hindi."
                ],
                "correctAnswer": "I know Hindi."
              },
              {
                "type": "multiple_choice",
                "prompt": "Choose an appropriate response",
                "sentence": "Kya tumhein coffee chahiye?",
                "sentenceIsTargetLanguage": true,
                "options": [
                  "Haan, mujhe coffee chahiye.",
                  "Nahi, main coffee nahi peeta.",
                  "Mujhe chai chahiye."
                ],
                "correctAnswer": "Haan, mujhe coffee chahiye."
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
                "sentence": "Hello (formal)",
                "options": ["Namaste", "Alvida", "Dhanyavaad"],
                "correctAnswer": "Namaste",
                "translatedSentence": "Hello"
              },
              {
                "type": "translate",
                "prompt": "Translate to English",
                "sentence": "Aapka swagat hai",
                "sentenceIsTargetLanguage": true,
                "options": ["Welcome", "Goodbye", "Thank you"],
                "correctAnswer": "Welcome"
              },
              {
                "type": "translate",
                "prompt": "Translate to Hindi",
                "sentence": "Good Morning",
                "options": ["Shubh Prabhat", "Shubh Ratri", "Namaste"],
                "correctAnswer": "Shubh Prabhat"
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
                "sentence": "Mera naam ... hai",
                "sentenceIsTargetLanguage": true,
                "options": ["My name is ...", "I am ...", "Who are you?"],
                "correctAnswer": "My name is ..."
              },
              {
                "type": "multiple_choice",
                "prompt": "Ask 'Who are you?'",
                "sentence": "Tum kaun ho?",
                "sentenceIsTargetLanguage": true,
                "options": ["Tum kaun ho?", "Tum kaise ho?", "Tum kahan ho?"],
                "correctAnswer": "Tum kaun ho?"
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
                "sentence": "Kutta",
                "sentenceIsTargetLanguage": true,
                "options": ["Dog", "Cat", "Cow"],
                "correctAnswer": "Dog"
              },
              {
                "type": "translate",
                "prompt": "Translate 'Cat'",
                "sentence": "Billi",
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
              },
              {
                "type": "translate",
                "prompt": "Translate 'Blue'",
                "sentence": "Neela",
                "sentenceIsTargetLanguage": true,
                "options": ["Blue", "Red", "Yellow"],
                "correctAnswer": "Blue"
              }
            ]
          }
        ]
      }
    ],
    [
      {
        "courseName": "Life in Delhi",
        "image": Assets.images.bandages.path,
        "color": 0xff00FF00,
        "levels": [
          {
            "level": 1,
            "questions": [
              {
                "type": "multiple_choice",
                "prompt": "Call an auto",
                "sentence": "Auto wale bhaiya!",
                "sentenceIsTargetLanguage": true,
                "options": ["Auto driver brother!", "Bus driver!", "Taxi driver!"],
                "correctAnswer": "Auto driver brother!"
              },
              {
                "type": "translate",
                "prompt": "Ask for price",
                "sentence": "Connaught Place chaloge?",
                "sentenceIsTargetLanguage": true,
                "options": ["Will you go to Connaught Place?", "Where is Connaught Place?", "I am in Connaught Place."],
                "correctAnswer": "Will you go to Connaught Place?"
              },
              {
                "type": "translate",
                "prompt": "Ask 'How much?'",
                "sentence": "Kitna hua?",
                "sentenceIsTargetLanguage": true,
                "options": ["How much?", "What time?", "Where?"],
                "correctAnswer": "How much?"
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
                "prompt": "Translate 'When is the meeting?'",
                "sentence": "Meeting kab hai?",
                "sentenceIsTargetLanguage": true,
                "options": ["When is the meeting?", "Where is the meeting?", "Who is in the meeting?"],
                "correctAnswer": "When is the meeting?"
              },
              {
                "type": "translate",
                "prompt": "Translate 'I am busy'",
                "sentence": "Main vyast hoon.",
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
                "sentence": "Do",
                "sentenceIsTargetLanguage": true,
                "options": ["Two", "Three", "Four"],
                "correctAnswer": "Two"
              },
              {
                "type": "translate",
                "prompt": "Translate 'Ten'",
                "sentence": "Dus",
                "sentenceIsTargetLanguage": true,
                "options": ["Ten", "Nine", "Eight"],
                "correctAnswer": "Ten"
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
                "sentence": "Main khush hoon.",
                "sentenceIsTargetLanguage": true,
                "options": ["I am happy.", "I am sad.", "I am angry."],
                "correctAnswer": "I am happy."
              },
              {
                "type": "translate",
                "prompt": "Translate 'I am sad'",
                "sentence": "Main dukhi hoon.",
                "sentenceIsTargetLanguage": true,
                "options": ["I am sad.", "I am happy.", "I am tired."],
                "correctAnswer": "I am sad."
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
                "sentence": "Ek plate chole bhature dena.",
                "sentenceIsTargetLanguage": true,
                "options": ["Give me one plate chole bhature.", "Where are chole bhature?", "I like chole bhature."],
                "correctAnswer": "Give me one plate chole bhature."
              },
              {
                "type": "translate",
                "prompt": "Gym question",
                "sentence": "Aaj kya workout hai?",
                "sentenceIsTargetLanguage": true,
                "options": ["What is today's workout?", "Where is the gym?", "How much weight?"],
                "correctAnswer": "What is today's workout?"
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
                "sentence": "Baarish",
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
                "sentence": "Train (Railgaadi)",
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

Map<String, String> hindiDictionary = {
  "Tumhara": "Your",
  "naam": "name",
  "kya": "what",
  "Mera": "My",
  "Main": "I",
  "vidyarthi": "student",
  "khaana": "food",
  "kha rha": "eating",
  "Kal": "tomorrow",
  "aaunga": "will come",
  "Kaise ho?": "How are you?",
  "Theek": "Fine",
  "Mujhe": "I",
  "pata": "know",
  "kahan": "where",
  "se": "from",
  "Woh": "He/She",
  "chhota": "small/younger",
  "bhai": "brother",
  "bada": "big/elder",
  "ghar": "home",
  "jaa": "go",
  "aati": "knows/comes",
  "chahiye": "want",
  "Haan": "Yes",
  "Nahi": "No",
  "Namaste": "Hello",
  "swagat": "welcome",
  "Shubh": "Good",
  "Prabhat": "Morning",
  "Ratri": "Night",
  "Kutta": "Dog",
  "Billi": "Cat",
  "Laal": "Red",
  "Neela": "Blue",
  "Kitna": "How much",
  "Meeting": "Meeting",
  "Ek": "One",
  "Do": "Two",
  "Khush": "Happy",
  "Dukhi": "Sad",
  "Baarish": "Rain"
};

