#import "t-attributes.typ": *

#let cover-0(width, height, h-margin, w-margin, long-0, long-1, short-0, short-1, short-2) = {
    set text(fill: fg-color, font: "FOT-Matisse Pro")
    set page(fill: bg-color)
    show heading: it => {}
    heading(level: 1, supplement: none)[#repeat("-")]
    context {
        let long-1-size = width.pt() / measure(long-1).width.pt() * 1em.to-absolute();
        place(bottom + right, dx: 0pt, dy: 0pt)[#text(long-1-size, long-1)]
        let long-1-height = measure(text(long-1-size, long-1)).height;
        let long-0-size  = (height - long-1-size + 0.5*h-margin) / measure(long-0).width * 1em.to-absolute();
        place(top + right, dx: 0pt, dy: -0.5*h-margin, rotate(90deg, reflow: true)[#text(long-0-size, long-0)])
        let long-0-height = measure(text(long-0-size, long-0)).height;
        let short-width = (width - long-0-height) * 0.75;
        let short-0-size = short-width / measure(short-0).width * 1em;
        let short-2-size = short-width / measure(short-2).width * 1em;
        place(top + left)[
            #align(left)[
                #stack(dir: ttb, spacing: 20pt)[
                    #text(short-0-size)[#short-0]
                ][
                    #v(long-1-size*0.25)
                    #text(short-2-size)[#short-1]
                ][
                    #text(short-2-size)[#short-2]
                ]
            ]
        ]
    }
}

#let cover-1(width, height, h-margin, w-margin, long-0, long-1, short-0, short-1, short-2) = {
    set text(fill: fg-color, font: "FOT-Matisse Pro", weight: "bold")
    set page(fill: bg-color)
    show heading: it => {}
    heading(level: 1, supplement: none)[#repeat("-")]
    context[
        #set scale(origin: bottom + center)
        #let long-1-size = width.pt() / measure(long-1).width.pt() * 1em.to-absolute();
        #place(top + right, dx: 0pt, dy: 0pt)[#text(long-1-size, long-1)]
        #let long-1-height = measure(text(long-1-size, long-1)).height;
        #let long-0-size  = (height - long-1-size + 0.5*h-margin) / measure(long-0).width * 1em.to-absolute();
        #place(bottom + left, dx: 0pt, dy: +0.5*h-margin, rotate(-90deg, reflow: true)[#text(long-0-size, long-0)])
        #let long-0-height = measure(text(long-0-size, long-0)).height;
        #let short-width = (width - long-0-height) * 0.65;
        #let short-0-size = short-width / measure(short-0).width * 1em;
        #let short-2-size = short-width / measure(short-2).width * 1em;
        #place(bottom + right)[
            #align(right)[
                #stack(dir: ttb, spacing: 40pt)[
                    #text(short-0-size)[#short-0]
                ][
                    #text(short-0-size)[#short-1]
                ][
                    #text(short-2-size)[#short-2]
                ]
            ]
        ]
    ]
}

