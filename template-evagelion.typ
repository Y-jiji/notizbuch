#let build-eva(width, height, h-margin, w-margin, long-0, long-1, short-0, short-1, short-2) = {
    set text(font: "FOT-Matisse Pro")
    set page(fill: black)
    set text(fill: white)
    context[
        #let long-1-size = width.pt() / measure(long-1).width.pt() * 1em.to-absolute();
        #place(bottom + right, dx: 0pt, dy: 0pt)[#text(long-1-size, long-1)]
        #let long-1-height = measure(text(long-1-size, long-1)).height;
        #let long-0-size  = (height - long-1-size + 0.5*h-margin) / measure(long-0).width * 1em.to-absolute();
        #place(top + right, dx: 0pt, dy: -0.5*h-margin, rotate(90deg, reflow: true)[#text(long-0-size, long-0)])
        #let long-0-height = measure(text(long-0-size, long-0)).height;
        #let short-width = (width - long-0-height) * 0.75;
        #let short-0-size = short-width / measure(short-0).width * 1em;
        #let short-2-size = short-width / measure(short-2).width * 1em;
        #place(top + left)[
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
    ]
}

