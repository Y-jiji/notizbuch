#import "template.typ": *

#{
    show: with-page-setup
    text(size: 2em)[#strong[Table of Contents]]
    show outline.entry.where(): it => link(it.element.location())[
        #h(15pt + it.level * 15pt - 2 * 15pt)
        #it.body.children.at(0).text.split("/").at(1)
        #it.body.children.slice(1).join("")
    ]
    show outline.entry.where(level: 1): it => {
        v(0pt)
        strong[#link(it.element.location())[#text(size: 1.2em)[
            #it.element.supplement
            #it.body
        ]]]
        v(0pt, weak: true)
    }
    outline(title: none)
}

// -----------------------=====----------------------- //
//                                                     //
//                        Tasks                        //
//                                                     //
// -----------------------=====----------------------- //

#{
    show: with-setup
    heading(numbering: none, outlined: false)[A List of Tasks]
    task-display()
}

// --------------------===========-------------------- //
//                                                     //
//                     Mathematics                     //
//                                                     //
// --------------------===========-------------------- //

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
#include "topic-finite-linear-space.typ"

#build-eva-variant-0(
    595.28pt-5cm, 
    841.89pt-5cm, 
    2.5cm, 2.5cm, 
    [Computing], [Theory], 
    "計算", "", "理論"
)
// #include "topic-formal-languages.typ"
#include "topic-type-theory.typ"

// --------------------===========-------------------- //
//                                                     //
//                     Engineering                     //
//                                                     //
// --------------------===========-------------------- //

#build-eva-variant-1(
    595.28pt-5cm, 
    841.89pt-5cm, 
    2.5cm, 2.5cm, 
    "Engineering", "System", 
    "系", "統", "開発"
)
#include "topic-arch-and-compilers.typ"
#include "topic-distributed-computing.typ"
#include "topic-dbms.typ"

#build-eva-variant-1(
    595.28pt-5cm, 
    841.89pt-5cm, 
    2.5cm, 2.5cm, 
    "Intelligence", 
    "Artificial", 
    "人", "工", "知能"
)

#include "topic-self-supervision.typ"

#build-eva-variant-1(
    595.28pt-5cm, 
    841.89pt-5cm, 
    2.5cm, 2.5cm, 
    "Programming", 
    "Pragmatic", 
    "実", "務", "プログラミング"
)

#include "topic-project-from-scratch.typ"
#include "topic-project-enhance.typ"

// --------------------===========-------------------- //
//                                                     //
//                     Liberal Art                     //
//                                                     //
// --------------------===========-------------------- //

#build-eva-variant-1(
    595.28pt-5cm, 
    841.89pt-5cm, 
    2.5cm, 2.5cm, 
    "Production", 
    "Music", 
    "音", "楽", "制作"
)

#include "topic-music-composition.typ"

// --------------------============-------------------- //
//                                                      //
//                     Bibliography                     //
//                                                      //
// --------------------============-------------------- //

#build-eva-variant-0(
    595.28pt-5cm, 
    841.89pt-5cm, 
    2.5cm, 2.5cm, 
    "付録付録付録付録",
    "Appendix", 
    "Appendix", "", "付録"
)
#show: it => with-setup(supplement: "Appendix", it)
= References
#bibliography(
    "references.bib", 
    full: true,
    title: none, 
    style: "ieee"
)