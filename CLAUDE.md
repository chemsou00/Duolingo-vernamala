# Varnamala - Duolingo-Style Language Learning App

## Project Overview

**Varnamala** is a Flutter-based language learning app for Indian languages (Kannada, Tamil, Telugu, Malayalam) inspired by Duolingo. The app uses Firebase for backend services and follows a clean architecture pattern.

---

## Architecture

### Layer Structure
```
lib/
├── application/       # State management (Providers)
├── core/              # Enums, extensions, utilities
├── courses/           # Language course data
│   ├── alphabets/     # Alphabet learning content
│   └── languages/     # Language-specific course files
├── di/                # Dependency injection (GetIt + Injectable)
├── domain/            # Domain models (Course, User, etc.)
├── routing/           # Auto Route configuration
├── service/           # App services (Preferences, locator)
└── views/             # UI layer organized by feature
```

### Key Patterns
- **State Management**: Provider + ChangeNotifier
- **Dependency Injection**: GetIt with Injectable annotations
- **Routing**: Auto Route with code generation
- **Models**: Freezed for immutable data classes with JSON serialization

---

## Firebase Services

| Service | Purpose | Status |
|---------|---------|--------|
| **Authentication** | Google Sign-In, user management | ✅ Implemented |
| **Firestore** | User data, scores, leaderboards | ✅ Implemented |
| **Analytics** | User behavior tracking | ✅ Implemented |
| **Crashlytics** | Error reporting | ✅ Implemented |
| **Messaging** | Push notifications | 🔧 Setup Done |
| **Storage** | Asset storage | 🔧 Setup Done |

### Firestore Collections
```
users/
├── {userId}/
│   ├── name: string
│   ├── email: string
│   ├── profileImage: string
│   ├── score: number (XP)
│   ├── streak: number
│   ├── lastStreakDate: timestamp
│   └── languages: array<string>
```

---

## Duolingo Features - Implementation Status

### ✅ Currently Implemented
- [x] Google Authentication
- [x] Course tree with progressive levels
- [x] Multiple choice questions
- [x] Translation exercises  
- [x] XP scoring system
- [x] Basic streak tracking
- [x] Leaderboard (top 30 users)
- [x] Character/alphabet practice
- [x] Shop UI (streak freeze, power-ups, outfits)
- [x] Multi-language support (Kannada, Tamil, Telugu, Malayalam)

### 🔴 Features Needed (Firebase-Based)

#### Gamification System
- [ ] **Leagues/Tiers** - Amethyst, Pearl, Ruby, Emerald, Diamond, etc.
  - Weekly league progression
  - Top 10 promotion, bottom 5 demotion
  - League-specific leaderboards
  
- [ ] **XP System Enhancement**
  - XP boost multipliers
  - Daily XP goals
  - XP for completing lessons, streaks, challenges

- [ ] **Streak System**
  - Streak freeze purchase/activation
  - Weekend amulet
  - Streak repair with gems
  - Streak milestone rewards (7, 30, 100, 365 days)

- [ ] **Hearts/Lives System**
  - Limited hearts for mistakes
  - Heart refill timers
  - Unlimited hearts (premium)

- [ ] **Gems/Lingots Currency**
  - Earn from achievements
  - Purchase power-ups
  - Streak freezes

#### Notifications & Reminders
- [ ] **Daily Practice Reminders**
  - Customizable reminder times
  - Smart notifications based on user patterns
  - Streak-at-risk warnings

- [ ] **Push Notification Types**
  - Lesson reminders
  - Streak maintenance
  - Friend activity
  - Achievement unlocks
  - League updates

#### Social Features
- [ ] **Friends System**
  - Add friends by username/email
  - Friend activity feed
  - Challenge friends

- [ ] **Achievements/Badges**
  - Lesson milestones
  - Streak achievements
  - Social achievements
  - Language-specific badges

#### Course Features
- [ ] **Skill Levels**
  - Crown levels (0-5 per skill)
  - Legendary skill unlock
  - Skill degradation over time

- [ ] **Learning Modes**
  - Stories mode
  - Speaking exercises (using flutter_tts)
  - Listening exercises
  - Fill-in-the-blank
  - Word matching (partially done)

---

## UI Theming Guidelines

### Color Palette (Differentiate from Duolingo)
```dart
// Primary: Teal/Cyan instead of Duolingo's green
const primaryColor = Color(0xff25D5C8);     // Current - Keep this
const primaryDark = Color(0xff1AB3A8);
const primaryLight = Color(0xff5DE8DC);

// Accent: Coral/Salmon for actions
const accentColor = Color(0xffFF6B6B);

// Success: Gold/Amber instead of green checkmarks
const successColor = Color(0xffFFD93D);

// League Colors - Use jewel tones
const amethystLeague = Color(0xff9B59B6);
const pearlLeague = Color(0xffF5F5F5);
const rubyLeague = Color(0xffE74C3C);
const emeraldLeague = Color(0xff27AE60);
const diamondLeague = Color(0xff3498DB);
```

### Design Principles
- Use rounded corners (16-24dp radius)
- Subtle shadows instead of heavy borders
- Gradient backgrounds for league cards
- Custom mascot "Mala" (peacock) as guide character

---

## Course Data Structure

### Question Types
```dart
enum QuestionType {
  multipleChoice,    // Choose correct translation
  translate,         // Translate sentence
  fillBlank,         // Complete the sentence (TODO)
  matchWords,        // Match pairs (partially implemented)
  listening,         // Listen and select (TODO)
  speaking,          // Speak the phrase (TODO)
}
```

### Course Format (in lib/courses/languages/)
```dart
{
  "courseName": "basics",
  "image": "assets/images/course_icon.png",
  "color": 0xff2b70c9,
  "levels": [
    {
      "level": 1,
      "questions": [
        {
          "type": "multiple_choice",
          "prompt": "Choose an appropriate response",
          "sentence": "Ninna hesaru enu?",
          "sentenceIsTargetLanguage": true,
          "options": ["Option A", "Option B", "Option C"],
          "correctAnswer": "Option A",
          "translatedSentence": "What is your name?"
        }
      ]
    }
  ]
}
```

---

## Development Commands

```bash
# Install dependencies
flutter pub get

# Generate code (routes, freezed, json_serializable)
flutter pub run build_runner build --delete-conflicting-outputs

# Run app
flutter run

# Run on specific device
flutter run -d chrome
flutter run -d ios
flutter run -d android

# Clean build
flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Key Files Reference

| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry point, Firebase init |
| `lib/views/app.dart` | Root widget with providers |
| `lib/routing/routing.dart` | Auto Route configuration |
| `lib/di/injection.dart` | GetIt DI setup |
| `lib/service/locator.dart` | AppPrefs, preferences |
| `lib/application/game_provider.dart` | Score/streak logic |
| `lib/domain/course/course.dart` | Course/Level/Question models |
| `lib/courses/languages/*.dart` | Language course data |

---

## Firebase Security Rules (Recommended)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Leaderboard - all authenticated users can read
    match /users/{userId} {
      allow read: if request.auth != null;
    }
    
    // Leagues collection
    match /leagues/{leagueId} {
      allow read: if request.auth != null;
      allow write: if false; // Only cloud functions
    }
  }
}
```

---

## Agents Available

### Flutter/Firebase Expert
Location: `.claude/agents/FLUTTER_FIREBASE_EXPERT.md`
- Architecture guidance
- Firebase implementation
- State management patterns
- Performance optimization

### Course Generator Agent
Location: `.claude/agents/COURSE_GENERATOR_AGENT.md`
- Generate new language courses
- Create question sets
- Validate course structure
- Subject matter expertise for languages

---

## Contributing

1. Follow existing code patterns
2. Run `build_runner` after model changes
3. Test on both iOS and Android
4. Ensure Firebase rules are considered
5. Use the theming guidelines for UI consistency

