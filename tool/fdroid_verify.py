#!/usr/bin/env python3
"""F-Droid compliance verifier (Blueprint Sections 6.4, 9.2).

Fails (exit 1) if the project or a built APK contains:
  * proprietary SDK references (Google Mobile Services, Firebase, Crashlytics);
  * outbound network usage in the Dart source (HttpClient / package:http / Dio);
  * known tracker / disallowed domains embedded in the APK.

Usage:
    python3 tool/fdroid_verify.py [path/to/app-release.apk]

The APK argument is optional; source checks always run.
"""
from __future__ import annotations

import re
import subprocess
import sys
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

# Substrings that must never appear in android/ build files or the APK.
FORBIDDEN_SDK = [
    "com.google.android.gms",
    "com.google.firebase",
    "firebase-",
    "crashlytics",
    "play-services",
]

# Dart APIs that would indicate an outbound network call (Section 6.4).
FORBIDDEN_DART = [
    re.compile(r"\bHttpClient\b"),
    re.compile(r"package:http/"),
    re.compile(r"package:dio/"),
    re.compile(r"\bWebSocket\b"),
]

# Known tracker / analytics domains that must not be embedded.
FORBIDDEN_DOMAINS = [
    "google-analytics.com",
    "firebaseio.com",
    "crashlytics.com",
    "doubleclick.net",
    "facebook.com",
    "graph.facebook",
]

failures: list[str] = []


def check_android_sources() -> None:
    android = ROOT / "android"
    for path in android.rglob("*"):
        if not path.is_file() or path.suffix not in {".gradle", ".kts", ".xml", ".properties"}:
            continue
        text = path.read_text(errors="ignore").lower()
        for token in FORBIDDEN_SDK:
            if token in text:
                failures.append(f"Forbidden SDK '{token}' in {path.relative_to(ROOT)}")


def check_dart_sources() -> None:
    lib = ROOT / "lib"
    for path in lib.rglob("*.dart"):
        if path.name.endswith(".g.dart"):
            continue  # generated code
        text = path.read_text(errors="ignore")
        for pattern in FORBIDDEN_DART:
            if pattern.search(text):
                failures.append(
                    f"Possible network call '{pattern.pattern}' in {path.relative_to(ROOT)}"
                )


def check_apk(apk_path: Path) -> None:
    if not apk_path.exists():
        failures.append(f"APK not found: {apk_path}")
        return
    with zipfile.ZipFile(apk_path) as zf:
        blob = b""
        for name in zf.namelist():
            if name.endswith(".dex") or name == "AndroidManifest.xml":
                blob += zf.read(name)
    haystack = blob.decode("latin-1").lower()
    for token in FORBIDDEN_SDK:
        if token in haystack:
            failures.append(f"Forbidden SDK '{token}' embedded in APK")
    for domain in FORBIDDEN_DOMAINS:
        if domain in haystack:
            failures.append(f"Forbidden domain '{domain}' embedded in APK")


def main() -> int:
    check_android_sources()
    check_dart_sources()
    if len(sys.argv) > 1:
        check_apk(Path(sys.argv[1]))

    if failures:
        print("F-Droid verification FAILED:")
        for failure in failures:
            print(f"  - {failure}")
        return 1
    print("F-Droid verification passed: no proprietary SDKs, no network calls.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
