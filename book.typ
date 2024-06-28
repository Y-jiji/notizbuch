#import "template.typ": *

// -- Display TODO Collector -- //
#{
    show: setup
    [TODO:]
    context table(
        columns: 2,
        ..{
            let map = it => ([#ref(it.at(1))], [#it.at(0)]);
            todo-collector.final().map(map).flatten()
        }
    )
}

#build-eva-variant-0(595.28pt-5cm, 841.89pt-5cm, 2.5cm, 2.5cm, "Mathematical", "Analysis", "解析", "か", "いせき")
#include "topic-fourier-analysis.typ"
// #include "topic-ordinary-diff-eq.typ"
// #include "topic-differential-geometry.typ"

#build-eva-variant-0(
    595.28pt-5cm, 
    841.89pt-5cm, 
    2.5cm, 2.5cm, 
    "Advanced", "Algebra", 
    "代数", "だ", "いすう"
)
// #include "topic-finite-linear-space.typ"

#build-eva-variant-0(
    595.28pt-5cm, 
    841.89pt-5cm, 
    2.5cm, 2.5cm, 
    [Computing], [Theory], 
    "計算", "", "理論"
)
// #include "topic-formal-languages.typ"
#include "topic-type-theory.typ"

// -- Engineering -- //

#build-eva-variant-1(
    595.28pt-5cm, 
    841.89pt-5cm, 
    2.5cm, 2.5cm, 
    "Engineering", "System", 
    "系", "統", "開発"
)

#include "topic-arch-and-compilers.typ"
#include "topic-distributed-computing.typ"

#build-eva-variant-1(
    595.28pt-5cm, 
    841.89pt-5cm, 
    2.5cm, 2.5cm, 
    "Intelligence", 
    "Artificial", 
    "人", "工", "知能"
)

#include "topic-neural-networks.typ"
#include "topic-llm-safety.typ"

// #include "topic-build-tensor-compiler.typ"
// #include "topic-build-music-dsl.typ"

// -- Bibliography -- //

#show: it => setup(supplement: "Appendix", it)

= References
#bibliography(
    "references.bib", 
    full: true,
    title: none, 
    style: "ieee"
)