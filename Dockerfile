# Reproducible build environment for Warranty Vault (Blueprint Section 6.4).
#
# Produces the release APK from a clean source checkout with pinned toolchain
# versions. Usage:
#   docker build -t warranty-vault-build .
#   docker run --rm -v "$PWD/out:/out" warranty-vault-build \
#       cp build/app/outputs/flutter-apk/app-fdroid-release.apk /out/
FROM debian:bookworm-slim

ENV FLUTTER_VERSION=3.44.1 \
    ANDROID_SDK_ROOT=/opt/android-sdk \
    DEBIAN_FRONTEND=noninteractive \
    PATH=/opt/flutter/bin:/opt/android-sdk/cmdline-tools/latest/bin:/opt/android-sdk/platform-tools:${PATH}

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl git unzip xz-utils openjdk-21-jdk-headless \
    && rm -rf /var/lib/apt/lists/*

# Pinned Flutter SDK.
RUN git clone --depth 1 --branch ${FLUTTER_VERSION} \
        https://github.com/flutter/flutter.git /opt/flutter \
    && flutter config --no-analytics \
    && flutter precache --android

# Android command-line tools + required SDK packages.
RUN mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools \
    && curl -fsSL -o /tmp/tools.zip \
        https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip \
    && unzip -q /tmp/tools.zip -d ${ANDROID_SDK_ROOT}/cmdline-tools \
    && mv ${ANDROID_SDK_ROOT}/cmdline-tools/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/latest \
    && rm /tmp/tools.zip \
    && yes | sdkmanager --licenses \
    && sdkmanager "platform-tools" "platforms;android-35" "build-tools;35.0.0"

WORKDIR /app
COPY . .

RUN flutter pub get \
    && dart run build_runner build --delete-conflicting-outputs \
    && flutter gen-l10n \
    && flutter build apk --release --flavor fdroid

CMD ["sh", "-c", "ls -lh build/app/outputs/flutter-apk/"]
