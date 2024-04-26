#let dd = math.upright("d")

#let box(meta, name, content) = [
    #let figcounter = [#context counter(figure).display()]
    #figure(supplement: [#meta], placement: none)[
        #align(center)[
            // center the rectangle
            #rect(width: 95%, height: auto, stroke: 0.5pt + rgb("#0f0f0f"), inset: 10pt)[
                // however, the inner text should be aligned to left
                #align(left)[
                    // theorem
                    *#meta #figcounter (#name)* #h(1pt)
                    // make the rest italic
                    _
                        #content
                    _
                ]
            ]
        ]
    ]
    #label(name)
]

#let proof(name, content) = [
    #figure(supplement: "Proof", placement: none)[
        #align(center)[
            // center the rectangle
            #rect(width: 95%, height: auto, stroke: 0.5pt + rgb("#0f0f0f"), inset: 10pt)[
                // this is somewhat hack-ish
                #show ref: it => {
                    let el = it.element
                    // override theorem references.
                    numbering(
                        el.numbering,
                        ..counter(figure).at(el.location())
                    )
                }
                // however, the inner text should be aligned to left
                #align(left)[
                    *#link(label(name))[Proof of #ref(label(name)) (#name)]  #h(1pt)*
                    _
                        #content
                    _
                ]
            ]
        ]
    ]
]

#let definition(name, content) = box("Definition", name, content)

#let theorem(name, content) = box("Theorem", name, content)
