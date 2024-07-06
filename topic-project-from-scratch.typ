#import "template.typ": *
#show: with-setup

= Engineering from Scratch

#summary[
    #tag[pragmatic:intro] In engineering practice, we mainly perform 3 kinds of actions: initiate, extend, and refactor. The difference between the last two is whether they break something. 
    #tag[pragmatic:ini:intro] In this chapter, we discuss several examples of starting projects from scratch. 
]

== Spectrum: Partial Rollback

=== Background Story

#tag[spectrum:story] In 2024/05, we published a VLDB paper @Paper:Spectrum. This paper is about adapting deterministic concurrency control into blockchain database. But actually most people can understand this paper with merely knowledge about OCC @Paper:OCC (optimistic concurrency control). In traditional OCC, a transaction will fully rollback if it reads a value produced by transaction with lower timestamp. This is not a problem in common OLTP. But blockchain ledgers have super-long transactions, so we may have to figure out a way to continue from where we failed. In most part of 2023, we tried to implement a memorization mechanism for each transaction, so we can recompute with the memorized data from storage engine, without accessing the database again. However, this doesn't work. We have to switch to a smarter approach that changes the Ethereum Virtual Machine internally. 

#tag[spectrum:legacy]
The original codebase of Spectrum was adapted from Aria's codebase @Paper:Aria-DCC. This codebase can haunt any decent engineer. It also introduced unnecessary overhead that spoiled our experimental results (overused virtual inheritance kills icache). Therefore, we (I mean me) decided to completely rewrite it (https://github.com/jacklightChen/spectrum).  

#task[Describe Spectrum] 

== GraphChase: Pursuit-Evasion Game on Graphs

#task[Describe GraphChase] 

== TMTB: A Timetable That Sucks Less

=== Background

#tag[tmtb:story] Most timetable applications require too much clicking. If you actually have learned how to operate an abacus, you know how it feels: it is just an operatable memorization tool, so after all, you still have to calculate everything yourself. Given what computational power of modern computers, that feels rural to me. And these timetables cannot even memorize information properly! For example, I would like to know whether some resource is available at a point, but there is no such a thing in a common timetable application. 

=== Efficiency
