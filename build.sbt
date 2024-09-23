// Set Scala version to 2.13.10 to match HardFloat
scalaVersion := "2.13.10"

// Compiler options
scalacOptions ++= Seq(
  "-feature",
  "-language:reflectiveCalls"
)

// Chisel version 3.5 and related plugins
addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % "3.5.6" cross CrossVersion.full)
libraryDependencies += "edu.berkeley.cs" %% "chisel3" % "3.5.6"
libraryDependencies += "edu.berkeley.cs" %% "chiseltest" % "0.5.6"

// Use resolvers to fetch dependencies
resolvers ++= Seq(
  Resolver.sonatypeRepo("snapshots"),
  Resolver.sonatypeRepo("releases")
)

// Define the HardFloat submodule using the same Scala version (2.13.10)
lazy val hardfloat = (project in file("lib/hardfloat"))
  .settings(
    scalaVersion := "2.13.10"
  )

// Main project definition, depending on HardFloat
lazy val root = (project in file("."))
  .dependsOn(hardfloat)
  .aggregate(hardfloat)
  .settings(
    scalaVersion := "2.13.10"
  )
