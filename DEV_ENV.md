# Development Environment — AppForge CLI / Generated Apps

This file documents the pinned toolchain that all contributors and CI should use
to avoid compatibility problems.

> Goal: Make builds reproducible. Use FVM for Flutter version pinning and commit
> the Gradle wrapper so Gradle/AGP behavior is consistent.

## Recommended pinned baseline (project-specific)
- Flutter (stable): use **a stable Flutter that satisfies your generated apps' `pubspec.yaml`** (see "Verification" below).
  - Recommended: use **FVM** to pin the exact Flutter version per-project.
- Dart SDK: use the Dart bundled with the pinned Flutter.
- Java (JDK): **17 (LTS)** — set `JAVA_HOME` to JDK 17 on all dev machines & CI.
- Gradle wrapper: **8.14** (project Gradle wrapper; do not use global gradle).
- Android Gradle Plugin (AGP): **8.11.1**
- Kotlin Gradle Plugin: **2.2.20**
- Android compileSdk / targetSdk: **35**
- minSdkVersion (generated app): **23** (the generated app currently sets minSdk=23)
- Android NDK: **29.0.14206865** (r29). Add `ndkVersion` to `android` block.
- CI: use the same matrix (FVM + JDK17 + Gradle wrapper + NDK r29).

## Why these choices
- Pinning Gradle and AGP prevents subtle build-tool inconsistencies.
- Explicit `compileSdk` and `targetSdk` values avoid differing builds when a dev's Flutter auto-selects a different value.
- NDK r29 is broadly compatible with many native plugins.

## Files to commit (ensure these are present & committed)
- `android/gradle/wrapper/gradle-wrapper.properties` (points to gradle-8.14)
- `android/build.gradle[.kts]` or `android/app/build.gradle[.kts]` updates:
  - `compileSdk 35`, `targetSdk 35`
  - `ndkVersion "29.0.14206865"`
  - `minSdk 23`
  - Java/kotlin compile options compatible with JDK17
- `.github/workflows/android-ci.yml` (or equivalent CI config using pinned toolchain)
- `.fvm/` config (if using FVM)

## Local verification — run these commands
```bash
# Flutter / Dart
flutter --version   # verify Flutter version and Dart SDK version (use FVM-managed flutter if using FVM)

# Java
java -version       # should show Java 17

# Gradle wrapper
( cd android && ./gradlew --version )

# Quick check for pinned files:
grep "gradle-8.14" android/gradle/wrapper/gradle-wrapper.properties || echo "gradle wrapper not pinned to 8.14"
grep "ndkVersion" -n android || echo "ndkVersion not set in android build files"
