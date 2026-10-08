# Math Strike

An offline-first, cross-platform educational math shooting game built with
Flutter. Players solve math problems by shooting the correct answer before
enemies reach them. Supports Android, iOS, Windows, macOS, Linux and Web.

## Status

| Phase | Scope | Status |
|------:|-------|--------|
| 1 | Architecture, packages, theme, routing, DI | ✅ Done |
| 2 | Splash screen & start-up pipeline | ✅ Done |
| 3 | Google Sign-In, Drive backup detection, restore | ✅ Done |
| 4 | Onboarding (profile, avatar, age, difficulty, theme, sound) | ✅ Done |
| 5 | Home dashboard, statistics, daily rewards | ✅ Done |
| 6 | Math engine, question generator, adaptive difficulty, practice mode | ✅ Done |
| 7 | Core shooting gameplay (Flame) | ⏳ Next |
| 8–17 | See the project brief | Planned |

## Getting started

```bash
flutter pub get
dart run build_runner build      # generate *.freezed.dart / *.g.dart
flutter run -d chrome            # or windows, macos, linux, android, ios
```

Environment selection (defaults to `development`):

```bash
flutter run --dart-define=APP_ENV=production
```

Google Sign-In / Drive credentials (see [docs/google_setup.md](docs/google_setup.md)):

```bash
flutter run --dart-define-from-file=config/google.json
```

Without credentials, development builds use a labelled **demo account** and
an in-memory Drive. Add `--dart-define=DEMO_BACKUP=true` to start with a
sample backup (profile, coins, a reward streak and a week of statistics)
and see the restore flow.

Quality gates:

```bash
flutter analyze
flutter test                               # all tests
flutter test --exclude-tags golden         # skip pixel tests (other OSes)
flutter test --update-goldens --tags golden # regenerate golden images
```

Preview a release web build locally (caching disabled, so a reload always
runs the latest build):

```bash
flutter build web --release
python tool/serve_web.py        # http://127.0.0.1:8765
```

> **Windows desktop:** Flutter needs symlink support for plugins. Enable
> *Developer Mode* (Settings → System → For developers) before
> `flutter run -d windows`.

## Architecture

Clean Architecture, organised feature-first. Dependencies point inward only:

```
presentation  ──▶  domain  ◀──  data
 (widgets,         (entities,     (repository impls,
  controllers)      repository     data sources)
                    contracts)
```

* **Domain** — pure entities (Freezed) and repository *interfaces*.
* **Data** — repository implementations; convert exceptions into `Failure`s
  and return `Result<T>` (never throw across the boundary).
* **Presentation** — Riverpod `Notifier` controllers + widgets.
* **DI** — Riverpod is the container. Services are provided by interface;
  platform-bound services (`AppConfig`, `LocalDatabase`) are bound in
  `lib/bootstrap.dart` and replaced with fakes in tests.

### Folder layout

```
lib/
  main.dart               entry point → bootstrap()
  bootstrap.dart          composition root: error handlers, ProviderScope
  app.dart                MaterialApp.router: theme + accessibility + router
  core/
    config/               AppConfig (Freezed), AppEnvironment
    constants/            app constants, breakpoints, durations
    di/                   core providers (config, logger, database, app info)
    errors/               AppException → Failure, Result<T>
    services/
      app_info/           version (package_info_plus) + launch tracking
      logging/            AppLogger interface + console impl
      storage/            LocalDatabase / KeyValueStore (encrypted Hive CE)
    startup/              StartupTask model
    theme/                AppTheme (M3), GamePalette, BrandColors, tokens
    utils/                CalendarDay (local dates), HUD formatters
    widgets/              shared widgets: brand logo, responsive helpers,
                          animated counter, confetti burst
  features/
    authentication/       Google sign-in gateways (plugin/desktop/demo),
                          account link, sign-in screen
    backup/               Drive app-folder data source, snapshot codec,
                          restore flow
    math/                 question engine (18 topics × 10 levels),
                          difficulty profiles, adaptive learning,
                          practice mode
    profile/              player profile, vector avatars, onboarding wizard
    rewards/              wallet (coins, diamonds, XP), levels & ranks,
                          7-day daily rewards
    settings/             appearance, accessibility & audio settings
    splash/               animated splash + start-up pipeline
    statistics/           per-game and per-day totals, Progress tab
      domain/ presentation/ splash_providers.dart (task registry)
  routing/                GoRouter, route constants, start-up guard
  screens/                app-level screens: shell, home dashboard,
                          placeholders, errors
test/                     mirrors lib/; helpers/ holds shared fakes
  goldens/                pixel tests (tag: golden)
```

New features follow the `settings/` template:

```
features/<name>/
  domain/entities/        Freezed models
  domain/repositories/    abstract interfaces
  data/repositories/      implementations
  presentation/controllers/  Riverpod notifiers
  presentation/screens/ | widgets/
  <name>_providers.dart   DI bindings for the feature
```

### Key decisions

| Concern | Choice | Why |
|---|---|---|
| State / DI | Riverpod 3 + generator | Compile-safe DI, trivial test overrides |
| Routing | go_router, `StatefulShellRoute` | Per-tab stacks, web URLs, redirect guards |
| Models | Freezed + json_serializable | Immutable, `copyWith`, JSON for backups |
| Local DB | Hive CE, AES-256, JSON values | Works on all 6 platforms incl. web; one uniform format makes encrypted Drive snapshots simple |
| DB key | flutter_secure_storage | Key kept in the OS keystore, never on disk in plaintext |
| Game engine | Flame (Phase 7) | Game loop, collision, particles |
| Fonts | Bundled (Phase 17) | No runtime font downloads, so the app stays offline |

### Responsive design

Material 3 window size classes (`WindowSize`):

| Width | Navigation |
|---|---|
| < 600 | Bottom `NavigationBar` |
| 600–1199 | Collapsed `NavigationRail` |
| ≥ 1200 | Extended sidebar with branding |

Keyboard: `Alt+1…5` switches tabs. A dot on **Home** means a daily reward
is waiting.

### Start-up pipeline

`bootstrap()` does nothing slow or fallible, so the first frame appears at
once. Everything else runs behind the animated splash as an ordered list
of `StartupTask`s (`features/splash/splash_providers.dart`):

| Task | Critical | Purpose |
|---|---|---|
| `database` | yes | Open the encrypted Hive database |
| `theme` | no | Load the saved appearance |
| `version` | no | Read app version, record launch (first launch / upgrade) |

* **Critical** failures stop start-up and show *Try again*; retry resumes
  at the failed task without re-running completed ones.
* **Non-critical** failures are logged and skipped, so the game always
  starts offline. Ads, Drive and audio register here as non-critical tasks
  in Phases 3, 8 and 12.
* Each task has a timeout; progress is weighted per task.
* The splash stays up at least 2.2 s, measured from when its first frame is
  actually *rasterized* (on the web, the engine may still be loading behind
  the HTML pre-loader in `web/index.html`).
* A router guard sends every location, including web deep links, to
  `/splash?from=…` until start-up completes, then on to the original
  destination.

### First launch, sign-in and restore

The router gate (`routing/app_gate.dart`) enforces, in order:

```text
splash → sign in (mandatory) → backup check / restore → onboarding → app
                                                     (whenever no profile exists)
```

* **Sign-in** links the device to a Google account (`AccountLink`, stored in
  the device-local box). The gate checks the *link*, not a live session, so
  after the first sign-in the game is fully playable **offline**.
* **Platforms:** `google_sign_in` on Android/iOS/macOS/web (web uses a single
  authorisation pop-up); a loopback OAuth flow with the system browser on
  Windows/Linux (refresh token kept in the OS keystore).
* **Scope:** only `drive.appdata` (a hidden, app-private Drive folder).
* **Restore:** if a backup exists it is restored automatically with progress;
  the download is fully validated before any local data is replaced, and
  device-local data is never overwritten. `LocalDataEpoch` makes cached
  controllers reload afterwards.
* **Backup format v1:** versioned JSON envelope (`BackupSnapshotCodec`);
  Phase 13 adds encryption and incremental backups as v2.

### Home, rewards and statistics

The **Home** tab composes features rather than owning data: player header
(avatar, level, XP), Quick play, the daily-reward card and today's stats
with a 7-day activity chart. Phones get one column; from 840dp of content
width the dashboard splits into two.

| Box | Key | Contents |
|---|---|---|
| `rewards` | `wallet` | coins, diamonds, lifetime XP |
| `rewards` | `daily_reward` | last claim day, streak, longest streak |
| `statistics` | `player` | lifetime totals, per-day totals (400 days), bests |
| `learning` | `progress` | per-topic rating, attempts, recent results |

These boxes are backed up automatically (every `StorageBox` with
`backedUp: true` is part of the snapshot).

* **Dates** — day-based logic uses `CalendarDay` (local calendar date, no
  time), read through `clockProvider`; never call `DateTime.now()` in
  features. `currentDayProvider` rolls over at local midnight and is
  re-checked when the app resumes.
* **Daily rewards** (`DailyRewardSchedule`) — one claim per local day;
  consecutive days walk a 7-day cycle ending in a treasure chest
  (300 coins, 3 diamonds, 100 XP), then the cycle repeats while the streak
  keeps counting. Missing a day resets to day 1. Moving the clock back
  never makes a reward claimable again. The claim record is written before
  the wallet, so an interrupted save cannot pay out twice.
* **Levels** — derived from lifetime XP: level *n* → *n+1* costs
  100 + 50·(n−1) XP, up to level 100; ranks Rookie → Legend.
* **Statistics** — gameplay (Phase 7) reports each finished game with
  `StatisticsController.recordSession(GameSessionSummary)` and pays out
  with `WalletController.credit(Reward)`. The Progress tab summarises
  Today / 7 days / 30 days / All time; Phase 14 adds topic analysis and
  reports.

### Math engine and adaptive learning

`features/math/domain` is pure Dart: no Flutter widgets, deterministic for
a given `Random` seed.

* **Engine** (`MathEngine`) — one generator per topic, 10 levels each. Every
  `Question` has a prompt, shuffled choices built from *typical mistakes*
  (forgetting to carry, adding denominators, misplacing the decimal point,
  sign errors…), a hint and a worked explanation. Recent prompts are not
  repeated.
* **Canonical text** (`MathText`) — every value is written exactly one way
  (`1.5`, never `1.50`; fractions in lowest terms), so duplicate choices are
  caught by string comparison. Exponents are marked up as `2^5` and drawn
  raised by `MathTextView`, because bundled fonts lack most Unicode
  superscripts (they would need a runtime font download). A test checks
  every generated string uses font-safe characters only.
* **Difficulty** (`DifficultyProfile`) — the age group decides the topics
  (preschool: 3, ages 6–8: 9, ages 9–12: 14, teens/adults: all 18), the top
  level and the number of choices; the difficulty decides the starting
  level and the answer time.
* **Adaptive learning** (`AdaptiveModel`) — each topic has a rating whose
  whole part is its level. Correct answers raise it (more when fast or for
  a harder question; less with a hint), mistakes lower it more sharply, so
  players settle where they mostly succeed. Questions are usually at the
  current level, sometimes one below or above. A topic is *weak* below 60%
  recent accuracy and *strong* at 85%+ over 10+ attempts; the recommended
  mix favours weak, new and long-unpractised topics.
* **Practice mode** — `/practice` (topic picker) and `/practice/session`:
  10 questions with hints, explanations, keyboard shortcuts (`1`–`4`, `H`,
  `Enter`) and a summary with level changes and a mistake review. Sessions
  count towards statistics. Gameplay (Phase 7) will use the same engine
  and `LearningController.recordAnswer`.

Mastery is stored in the backed-up `learning` box.

### Accessibility

`AccessibilityMediaScope` merges in-app preferences with the OS ones:
text scale multiplies the system scale, and "reduce motion" is exposed via
`MediaQuery.disableAnimations`. Use `context.motion(duration)` for every
animation. High-contrast themes apply automatically when the OS asks for
them.
