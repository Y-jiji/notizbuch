#import "template-attributes.typ": *

#let dd = math.upright("d")
#let pp = math.partial

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

#let TODO(content) = text(green, [TODO: #content])

#let box(meta, name, justification, content) = [
    #figure(supplement: [#meta])[
        // this context allow us to use the figure counter after figure
        #context [#align(center)[
            // center the rectangle
            #rect(width: 95%, height: auto, stroke: box-stroke, inset: 10pt)[
                // however, the inner text should be aligned to left
                #align(justification)[
                    // theorem
                    *#meta (#name)* #h(1pt)
                    // make the rest italic
                    _
                        #content
                    _
                ]
                #align(right)[#text(blue, counter(figure).display())]
            ]
        ]]
    ]
    #label(name)
]

#let attach-to(meta, adposition, target, extra, content) = [
    #figure(supplement: meta)[
        #context [#align(center)[
            // center the rectangle
            #rect(width: 95%, height: auto, stroke: box-stroke, inset: 10pt)[
                // this is somewhat hack-ish
                // however, the inner text should be aligned to left
                #set ref(supplement: it => [#meta #extra #adposition])
                #align(left)[
                    *#ref(label(target)) (#target) #h(1pt)*
                    _
                        #content
                    _
                ]
                #align(right)[#text(blue, counter(figure).display())]
            ]
        ]]
    ]
    #label(to-string[#meta #extra of (#target)])
]

#let proof(name, extra: none, content) = attach-to("Proof", "of", name, extra, content)

#let comment(name, extra: none, content) = attach-to("Comment", "on", name, extra, content)

#let illustration(name, content) = box("Figure", name, center, content)

#let definition(name, content) = box("Definition", name, left, content)

#let theorem(name, content) = box("Theorem", name, left, content)

#let example(name, content) = box("Example", name, left, content)