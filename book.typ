#import "t-main.typ": *

// --------------------==========--------------------- //
//                                                     //
//                     Book Cover                      //
//                                                     //
// --------------------==========--------------------- //

#{
    show: with-page-setup
    align(center, rect()[#rect(inset: 40pt, stroke: 0.5pt)[
        #text(size: 60pt)[#strong[Y-jiji's Note]]
    ]])
    align(center)[
        #text(size: 20pt)[#emph[Y-jiji & Friends]]
    ]
    align(center)[#rect(height: 70%, width: 90%, stroke: none)[
        #place(center + bottom)[#text(10pt, fill: fg-color, stroke: none)[
            #repeat[#rotate(-30deg)[Why?] #h(0.5em)]
            #repeat[#rotate(-30deg)[Pardon?] #h(0.5em)]
            #repeat[#rotate(30deg)[Why?] #h(0.5em)]
            #repeat[#rotate(30deg)[Pardon?] #h(0.5em)]
            #repeat[#rotate(-30deg)[Why?] #h(0.5em)]
            #repeat[#rotate(-30deg)[Pardon?] #h(0.5em)]
            #repeat[#rotate(30deg)[Why?] #h(0.5em)]
            #repeat[#rotate(30deg)[Pardon?] #h(0.5em)]
            #repeat[#rotate(-30deg)[Why?] #h(0.5em)]
            #repeat[#rotate(-30deg)[Pardon?] #h(0.5em)]
            #repeat[#rotate(30deg)[Why?] #h(0.5em)]
            #repeat[#rotate(30deg)[Pardon?] #h(0.5em)]
            #repeat[#rotate(-30deg)[Why?] #h(0.5em)]
            #repeat[#rotate(-30deg)[Pardon?] #h(0.5em)]
            #repeat[#rotate(30deg)[Why?] #h(0.5em)]
            #repeat[#rotate(30deg)[Pardon?] #h(0.5em)]
        ]]
    ]]
}

// -----------------=================----------------- //
//                                                     //
//                  Table of Contents                  //
//                                                     //
// -----------------=================----------------- //

#{
    show: with-page-setup
    align(center)[#text(size: 2em)[#strong[Table of Contents]]]
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

// --------------------===========-------------------- //
//                                                     //
//                     Mathematics                     //
//                                                     //
// --------------------===========-------------------- //

#cover-0(
    595.28pt-5cm, 
    841.89pt-5cm, 
    2.5cm, 2.5cm, 
    "Mathematical", "Analysis", 
    "解析", "か", "いせき"
)
#include "c-analysis-prequisites.typ"
#include "c-fourier-analysis.typ"
// #include "c-ordinary-diff-eq.typ"
// #include "c-differential-geometry.typ"

#cover-0(
    595.28pt-5cm, 
    841.89pt-5cm, 
    2.5cm, 2.5cm, 
    "Advanced", "Algebra", 
    "代数", "だ", "いすう"
)
#include "c-finite-linear-space.typ"

#cover-0(
    595.28pt-5cm, 
    841.89pt-5cm, 
    2.5cm, 2.5cm, 
    [Computing], [Theory], 
    "計算", "", "理論"
)
#include "c-type-theory.typ"
// #include "c-formal-languages.typ"

// --------------------===========-------------------- //
//                                                     //
//                     Engineering                     //
//                                                     //
// --------------------===========-------------------- //

#cover-1(
    595.28pt-5cm, 
    841.89pt-5cm, 
    2.5cm, 2.5cm, 
    "Engineering", "System", 
    "系", "統", "開発"
)
#include "c-arch-and-compilers.typ"
#include "c-distributed-computing.typ"
#include "c-dbms.typ"

#cover-1(
    595.28pt-5cm, 
    841.89pt-5cm, 
    2.5cm, 2.5cm, 
    "Intelligence", 
    "Artificial", 
    "人", "工", "知能"
)

#include "c-self-supervision.typ"

#cover-1(
    595.28pt-5cm, 
    841.89pt-5cm, 
    2.5cm, 2.5cm, 
    "Programming", 
    "Pragmatic", 
    "実", "務", "プログラミング"
)

#include "c-project-from-scratch.typ"
#include "c-project-enhance.typ"
#include "c-algorithmic-problem.typ"

// --------------------===========-------------------- //
//                                                     //
//                     Liberal Art                     //
//                                                     //
// --------------------===========-------------------- //

#cover-1(
    595.28pt-5cm, 
    841.89pt-5cm, 
    2.5cm, 2.5cm, 
    "Production", 
    "Music", 
    "音", "楽", "制作"
)

#include "c-music-composition.typ"
#include "c-motivation-and-improvision.typ"

// --------------------============------------------- //
//                                                     //
//                     Bibliography                    //
//                                                     //
// --------------------============------------------- //

#cover-0(
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

#include "c-casual-essay.typ"

// -----------------------=====----------------------- //
//                                                     //
//                        Tasks                        //
//                                                     //
// -----------------------=====----------------------- //

#{
    show: doc => with-setup(supplement: none, doc)
    align(center)[#text(size: 2em)[#strong[Author Tasks]]]
    task-display()
}
