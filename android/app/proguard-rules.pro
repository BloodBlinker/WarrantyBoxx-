# WarrantyBoxx — R8 keep rules (Blueprint Section 9.1)

# Flutter
# NOTE: no blanket `-keep class io.flutter.**` — Flutter's tooling injects the
# keep rules the engine needs (JNI entry points are @Keep-annotated). A blanket
# keep retains the unused Play-Store deferred-components classes, whose
# com.google.android.play.core references fail F-Droid's non-free scanner.
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.embedding.**

# Drift / SQLite — generated query classes use reflection-free codegen but keep
# the native loader entry points to be safe.
-keep class app.drift.** { *; }
-keep class com.simolus3.** { *; }

# flutter_local_notifications uses Gson internally for scheduled notification payloads.
-keep class com.dexterous.** { *; }
-keepattributes *Annotation*
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# workmanager
-keep class dev.fluttercommunity.workmanager.** { *; }

# home_widget
-keep class es.antonborri.home_widget.** { *; }

# Keep enum values (used across notification scheduling).
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Preserve AndroidX, WorkManager internals, and Coroutines (common causes of instant crashes in plugins)
-keep class androidx.** { *; }
-dontwarn androidx.**
-keep class kotlinx.coroutines.** { *; }
-dontwarn kotlinx.coroutines.**
-keep class kotlin.** { *; }
-dontwarn kotlin.**
-keep class com.flutter_image_compress.** { *; }
-keep class dev.fluttercommunity.plus.share.** { *; }
