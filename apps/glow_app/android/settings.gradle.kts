pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.7.3" apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
}

include(":app")

// Ensure third-party Android library modules that lack an explicit namespace get a default one
// This works around older packages that haven't migrated to the AGP 'namespace' requirement.
gradle.settingsEvaluated {
    rootProject.children.forEach { proj ->
        proj.pluginManager.withPlugin("com.android.library") {
            try {
                val androidExt = proj.extensions.getByName("android")
                if (androidExt != null) {
                    @Suppress("UNCHECKED_CAST")
                    val libExt = androidExt as com.android.build.gradle.LibraryExtension
                    if (libExt.namespace.isNullOrBlank()) {
                        libExt.namespace = "dev.glow.${proj.name}"
                    }
                }
            } catch (ignored: Throwable) {
                // best-effort, ignore if extension not available
            }
        }
    }
}
