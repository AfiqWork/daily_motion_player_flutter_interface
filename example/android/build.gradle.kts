
// Root-level build.gradle.kts

buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:8.7.3")
        classpath(kotlin("gradle-plugin", version = "2.1.0"))
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
        maven("https://mvn.dailymotion.com/repository/releases/")
        maven("https://jitpack.io")
    }
}

// Optional: custom build directory
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
