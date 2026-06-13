import com.android.build.gradle.internal.api.ApkVariantOutputImpl

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.robinroy.warrantyboxx"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    dependenciesInfo {
        includeInApk = false
        includeInBundle = false
    }

    compileOptions {
        // Required by flutter_local_notifications (core library desugaring).
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.robinroy.warrantyboxx"
        // Blueprint Section 9.1: Android 8.0 (Oreo) minimum.
        minSdk = 26
        targetSdk = flutter.targetSdkVersion
        // Version code formula: MAJOR*10000 + MINOR*100 + PATCH => 1.0.1 == 10001.
        versionCode = 10001
        versionName = "1.0.1"
    }

    buildTypes {
        release {
            // Blueprint Section 9.1: enable R8 minification with keep rules for Drift/Riverpod.
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
            // Release signing credentials are injected via CI secrets only (Section 9.1).
            // Falls back to debug signing locally so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

val abiCodes = mapOf("armeabi-v7a" to 1, "arm64-v8a" to 2, "x86_64" to 3)
android {
    applicationVariants.configureEach {
        val variant = this
        variant.outputs.forEach { output ->
            val abiVersionCode = abiCodes[output.filters.find { it.filterType == "ABI" }?.identifier]
            if (abiVersionCode != null) {
                (output as ApkVariantOutputImpl).versionCodeOverride = variant.versionCode * 10 + abiVersionCode
            }
        }
    }
}
