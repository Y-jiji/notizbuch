#import "template.typ": *
#show: with-setup

= DSL for Digital Audio Processing

== Problem Statement

The problem that I try to solve is the current rendering problem in DAW (digital audio workstation) area. 

For most use cases, the DAW eats up all the memory, while still kind of have some delay in all kinds of immediate sound delivery and rendering. 

This mainly roots in two sources: 
+ DAW always try to load all the used samples into memory, regardless of whether they are played at the current instant. 
+ On the other hand, internal states of after-effect processors and synthesizers are not managed/saved by DAW, and therefore, expensive computation is operated repetitively to compute these internal states, even if some tracks stay unchanged between changes. 

To solve this problem, I want to design a programming language that eventually describes a stream of sound, and can be computed incrementally both between editing changes and temporal changes, while providing parsimonous memory usages by offloading stuff to disk.

== Declarative State Manipulation

#task[Introducing ODE as state manipulation method, time as predefined free variable]

