#let summary(title, content) = [
    #align(center)[
        #pad(x: 10%, y: 2em)[
            #align(left)[
                #line(length: 100%, stroke: red)
                #pad(x: 2em)[_
                    #set text(size: 1.2em)
                    *#title*\
                    #set text(size: (1em/1.2))
                    #content
                _]
                #line(length: 100%, stroke: red)
            ]
        ]
    ]
]