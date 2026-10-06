# Math Strike

An offline-first, cross-platform educational math shooting game built with
Flutter. Players solve math problems by shooting the correct answer before
enemies reach them. Supports Android, iOS, Windows, macOS, Linux and Web.

## Status

| Phase | Scope | Status |
|------:|-------|--------|
| 1 | Architecture, packages, theme, routing, DI | ✅ Done |
| 2 | Splash screen & start-up pipeline | ✅ Done |
| 3 | Google Sign-In, Drive backup detection, restore | ⏳ Next |
| 4–17 | See the project brief | Planned |

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
    widgets/              shared widgets: brand logo, responsive helpers
  features/
    settings/             appearance & accessibility
    splash/               animated splash + start-up pipeline
      domain/ presentation/ splash_providers.dart (task registry)
  routing/                GoRouter, route constants, start-up guard
  screens/                app-level screens: shell, placeholders, errors
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

Keyboard: `Alt+1…5` switches tabs.

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

### Accessibility

`AccessibilityMediaScope` merges in-app preferences with the OS ones:
text scale multiplies the system scale, and "reduce motion" is exposed via
`MediaQuery.disableAnimations`. Use `context.motion(duration)` for every
animation. High-contrast themes apply automatically when the OS asks for
them.
