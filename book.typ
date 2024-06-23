#import "template.typ": *

// display todo collector
#show: setup
#context {
    [TODO:]
    let map = it => ([#ref(it.at(1))], [#it.at(0)]);
    table(
        columns: 2, 
        stroke: none,
        ..todo-collector.final().map(map).flatten()
    )
}

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