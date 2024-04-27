#let dd = math.upright("d")

#let to-string(content) = {
    if content.has("text") {
        content.text
    } else if content.has("children") {
        content.children.map(to-string).join("")
    } else if content.has("body") {
        to-string(content.body)
    } else if content == [ ] {
        " "
    }
}

#let box(meta, name, content) = context [
    #figure(supplement: [#meta], placement: none)[
        #context [#align(center)[
            #let figcounter = counter(figure).display()
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
        ]]
    ]
    #label(name)
]

#let proof(name, content, version: none) = context [
    #figure(supplement: "Proof", placement: none)[
        #context [#align(center)[
            // center the rectangle
            #rect(width: 95%, height: auto, stroke: 0.5pt + rgb("#0f0f0f"), inset: 10pt)[
                // this is somewhat hack-ish
                // however, the inner text should be aligned to left
                #set ref(supplement: it => [Proof #version of])
                #align(left)[
                    *#ref(label(name)) (#name) #h(1pt)*
                    _
                        #content
                    _
                ]
            ]
        ]]
    ]
    #label(to-string[Proof #version of (#name)])
]

#let definition(name, content) = box("Definition", name, content)

#let theorem(name, content) = box("Theorem", name, content)
