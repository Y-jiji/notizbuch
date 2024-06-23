#import "template.typ": *

// display todo collector
#show: setup
#context text(green)[#todo-collector.final().map(it => [\[TODO: #ref(it.at(1)) #it.at(0)\]]).join("\n")]

#include "subject-mathematics.typ"
#include "subject-engineering.typ"
#include "topic-build-tensor-compiler.typ"
#include "topic-build-music-dsl.typ"

#bibliography(
    "references.bib", 
    full: true,
    title: "References", 
    style: "ieee"
)