#import "template-attributes.typ": *
#import "@preview/xarrow:0.3.0": xarrow

#let dd = math.upright("d")
#let pp = math.partial
#let sp = math.display(" ")

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

#let TODO(content) = [
    // never remove this new line!
    
    #text(green, style: "normal", [[TODO: #content]])
]

#let theorem-box(meta, name, justification, breakable, content) = [
    #align(center)[#block(width: 98%, height: auto, breakable: breakable, stroke: box-stroke, inset: 10pt)[
        #place[#figure(supplement: meta)[]#label(to-string[#meta:#name.replace(" ", "_")])]
        // however, the inner text should be aligned to left
        #align(justification)[
            // theorem
            *#meta (#name)* #h(1pt)
            // make the rest italic
            _
                #content
            _
        ]
        #align(right)[
            #text(blue, counter(figure).display())
        ]
    ]]
]

#let attach-box(meta, adposition, target, extra, alter, breakable, content) = [
    // center the rectangle
    #align(center)[#block(width: 98%, height: auto, stroke: box-stroke, inset: 10pt, breakable: breakable)[
        #if alter != none {
            place[#figure(supplement: meta)[]#label(to-string[#meta:#alter.replace(" ", "_")])]
        } else if extra == none {
            place[#figure(supplement: meta)[]#label(to-string[#meta:#target])]
        } else {
            place[#figure(supplement: meta)[]#label(to-string[#meta\-#extra.replace(" ", "_"):#target])]
        }
        #let alter = if alter == none {
            target.split(":").at(-1).replace("_", " ")
        } else {
            alter
        }
        // this is somewhat hack-ish
        // however, the inner text should be aligned to left
        #align(left)[
            #[
                #set ref(supplement: it => [#meta #extra #adposition])
                *#ref(label(target)) (#alter) #h(1pt)*
            ]
            _
                #content
            _
        ]
        #align(right)[#text(blue, counter(figure).display())]
    ]]
]

#let proof(name, extra: none, breakable: true, alter: none,  content) = attach-box("Proof", "of", name, extra, alter, breakable, content)

#let comment(name, extra: none, breakable: true, alter: none,  content) = attach-box("Comment", "on", name, extra, alter, breakable, content)

#let collary(name, extra: none, breakable: true, alter: none, content) = attach-box("Collary", "of", name, extra, alter, breakable, content)

#let illustration(name, breakable: false, content) = theorem-box("Figure", name, center, breakable, content)

#let definition(name, breakable: true, content) = theorem-box("Definition", name, left, breakable, content)

#let theorem(name, breakable: true, content) = theorem-box("Theorem", name, left, breakable, content)

#let example(name, breakable: true, content) = theorem-box("Example", name, left, breakable, content)

#let lemma(name, breakable: true, content) = theorem-box("Lemma", name, left, breakable, content)