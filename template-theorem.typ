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

#let box-style = (paint: rgb("#ff0000"), thickness: 0.8pt, dash: "dashed")

#let box(meta, name, justification, content) = [
    #figure(supplement: [#meta], placement: none)[
        // this context allow us to use the figure counter after figure
        #context [#align(center)[
            // center the rectangle
            #rect(width: 95%, height: auto, stroke: box-style, inset: 10pt)[
                // however, the inner text should be aligned to left
                #align(justification)[
                    // theorem
                    *#meta (#name)* #h(1pt)
                    // make the rest italic
                    _
                        #content
                    _
                ]
                #align(right)[#text(rgb("#0000ff"), counter(figure).display())]
            ]
        ]]
    ]
    #label(name)
]

#let proof(name, content, version: none) = [
    #figure(supplement: "Proof", placement: none)[
        #context [#align(center)[
            // center the rectangle
            #rect(width: 95%, height: auto, stroke: box-style, inset: 10pt)[
                // this is somewhat hack-ish
                // however, the inner text should be aligned to left
                #set ref(supplement: it => [Proof #version of])
                #align(left)[
                    *#ref(label(name)) (#name) #h(1pt)*
                    _
                        #content
                    _
                ]
                #align(right)[#text(rgb("#0000ff"), counter(figure).display())]
            ]
        ]]
    ]
    #label(to-string[Proof #version of (#name)])
]

#let illustration(name, content) = box("Figure", name, center, content)

#let definition(name, content) = box("Definition", name, left, content)

#let theorem(name, content) = box("Theorem", name, left, content)
