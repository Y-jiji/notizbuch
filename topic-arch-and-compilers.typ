#import "template.typ": *
#show: setup("Topic")

= Architecture & Compilers

#summary[
    In this topic, we generally discuss how compilers work from the viewpoint of system softwares. However, we still have to include a minimal presentation of syntax analysis and semantic analysis, which should have being included in programming languages (as part of TCS)
]

== Syntax Analysis

=== Tokenizer / Lexer

Given a piece of programming language, compilers usually don't just directly parse the text string into parsing trees, which is eventually needed in code generation. Instead, compilers usually chop the text into marked pieces, for example, marking something as a number, a string literal, or an identifier. 

Usually the rule of parsing is given as regular languages (@Heading-L2:Regular_Langauges), which serves as predicates. In general, if a piece of text $s$ belongs to a regular language $r$ , we say $s$ is a *token* of *lexicon* $r$. Loosely speaking, we $s$ is somewhat analogous to a word in english, and $r$ is the kind of this word, e.g. a noun or a verb. 

Here, we have a major problem to address. 
- When a token $x$ of lexicon $r_x$ has a prefix $p$ s.t. somehow $p$ is also of a lexicon $r_p$, should we take $x$ or $p$?

As a common practice in engineering, the following heuristics is proposed:
- If $p$ is a strict prefix of $x$ i.e. shorter then $x$, $x$ is unconditionally taken. 
- Ask users to provide a priority for each lexicon, if $p$ and $x$ are the same token, recognize it as the lexicon with higher priority. 

Here are some exercises: 
+ Write regular expressions: #enum(numbering: "a.", 
    [
        Strings over the alphabet ${a,b,c}$ where the first $a$ precedes the first $b$\ 
        _Answer: $c^*(a(a|b|c)^*)?$, the string after first b can be recognized by $(a|b|c)^*$_
    ],
    [
        Strings over the alphabet ${a,b,c}$ with an even number of $a$'s\
        _Answer: $[b c]^*(a[b c]^*a[b c]^*)^*$_
    ],
    [
        Binary numbers that are multiples of four.\
        _Answer: $0|(1(0|1)^*00)$_
    ],
    [
        Binary numbers that are greater than $101001$.\
        _Answer: $(10101[01])|(1011[01]{2})|(11[01]{4})|(1[01]{6}[01]^*)$_
    ],
    [
        Strings over the alphabet ${a,b,c}$ that don't contain the contiguous sub-string $b a a$.
        _Answer: $[a c]^* | (b (a|c|(a c | c c | c a)[a c]^*)?)^*$, slice a string by $b$, enumerate anything possible after a $b$ (case-by-case, classified by the length of the ac string) _
    ],
    [
        Nonnegative integer constants in C, where numbers beginning with 0 are octal constants and other numbers are decimal constants. \
        _Answer: $0[0 dash 8]^* | [1dash 9][0dash 9]^*$_
    ],
    [
        Binary numbers $n$ such that there exists an integer solution of $a^n + b^n = c^n$ . \
        _Answer: $1[01]^*$, just don't let it be zero. _
    ]
)
+ For each of the following, why there is no regular expressino defining it. #enum(numbering: "a.", 
    [
        Strings of $a$'s and $b$'s where there are more $a$'s than $b$'s. \
        _Answer: by pumping lemma, divide the string $omega$ of only has one more $a$ than $b$ such that $omega=alpha beta gamma$, an arbitrary division gives forces the number of $a$ and $b$ to be the same in $beta$.  _
    ],
    [
        Strings of $a$'s and $b$'s where that are parlindromes. \
        _Answer: prove by contradiction using pumping lemma. _
    ],
    [
        Syntactically correct C programs. \
        _Answer: pairing brackets.  _
    ]
)
+ Explain what these finite state automata recognizes. #enum(numbering: "a.", 
    [
        #align(center, image("pics/tiger-ex-2.3-1.png", width: 300pt))
        _Answer: binary numbers starts with $1,00,01,010,0111$ and has constant length 4_. 
    ],
    [
        #align(center, image("pics/tiger-ex-2.3-2.png", width: 300pt))
        _Answer: letters $a$ repeating $4n+1$ times, where $n$ is a natural number._
    ],
    [
        #align(center, image("pics/tiger-ex-2.3-3.png", width: 250pt))
        _Answer: repetition of _
    ]
)
+ Convert these regular expressions into NFA. #enum(numbering: "a.", 
    [
        $("if" | "then" | "else")$\
        _
            Answer: 
        _
    ],
    [
    ]
)
+ Lex 

=== Top-down Parser

==== Prediction-Only LL(1)

A top-down parser, i.e. recursive-descendent parser, only applies to grammars whose each terminal symbol only appears in one $"FIRST"$ set of one non-terminal symbol. 

#definition("FIRST-SET")[
    Given grammar $G$, its $"FIRST-SET"$ for a symbol string $alpha$ is defined as:
    $
        "FIRST-SET"(G, alpha) = {t: alpha arrow.tail^* t gamma in G^*}
    $
    where $G^*$ is all the set of all derivations by $G$ . 
]

A very special case is left-recursion, which means there exists a derivation $N arrow.tail^* N gamma$, a naively recurse into $N$'s derviation may case an non-stopping recursion. 
#TODO[refer to basic definition of formal grammar (else where)]

#theorem("Compute FIRST-SET")[
    $"FIRST-SET"$ of each non-terminal symbol in $G$ can be computed as follows:
    #move(dx: 10%)[#algo-function[first-set][(g: Grammar)][
        *let* nont = g.non-terminal()\
        *let* first-of = {n: {} *for* n *in* nont}\
        #nest[*loop*][
            *let* change = *false*\
            #nest[*for* n *in* nont][
                #nest[*for* n $arrow.tail$ p *in* g.production-of(n)][
                    #nest[*if* p *is* $epsilon$][
                        change = $epsilon$ $in.not$ first-of[n]\
                        first-of[n] = first-of[n] $union$ {$epsilon$}\
                    ]
                    #nest[*for* s *in* p[0..]][
                        #nest[*if* s *is* Teminal][
                            change = s $in.not$ first-of[n]\
                            first-of[n] = first-of[n] $union$ {s}\
                            *break*
                        ]
                        change = first-of[s] $\\$ first-of[n] != $emptyset$\
                        first-of[n] = first-of[n] $union$ first-of[s]\
                        #nest[*if* $epsilon$ *not in* first-of[s]][
                            *break*
                        ]
                    ]
                ]
            ]
            #nest[*if* *not* change][
                *break*
            ]
        ]
        *return* first-of
    ]]
]

#proof("Theorem:Compute_FIRST-SET")[
    $"FIRST-SET"$ of a non-terminal symbol $n$ is the union of $" FIRST-SET"(G, gamma)$ where $n arrow.tail gamma$ . 
    $"FIRST-SET"$ of a string $gamma$ is just its first symbol if $gamma$ starts with a non-terminal, and $" FIRST-SET"$ of its suffix whenever the corresponding prefix can derve empty string $epsilon$. \
    Therefore, verify that the algorithm only stops when each computed $" FIRST-SET"$ equals $" FIRST-SET"$ of $gamma$ merged. 
]

There is also a definition of $"FOLLOW-SET"$, which we will use later: 
#definition("FOLLOW-SET")[
    $"FOLLOW-SET"$ is just the terminals that may appear after a non-terminal. 
    $
        "FOLLOW-SET"(G, X) = union.big_(alpha X beta in G) "FIRST-SET"(beta)
    $
]

==== Parsing with PEG

=== Bottom-up Parser

==== Shift-Reduce Parsing

Shift-reduce parsing does a better job then LL(1) method, it procrastinate the decision of what non-terminal symbol to use until it has seen *all* symbols of this non-terminal symbols (or more). 

==== Parsing with LR(0) <Heading-L4:Parsing-with-LR0>

First, construct an NFA where each state is a *progression* in a production rule. 

The states are
- $[X <- alpha dot beta] "where" (X <- alpha beta) "is a production"$

The original transitions in NFA are:
- $[Y <- alpha dot X beta] xarrow(X) [Y <- alpha X dot beta]$
- $[Y <- alpha dot X beta] xarrow(epsilon) [X <- dot gamma]$
- $[Y <- alpha dot t beta] xarrow(t) [Y <- alpha t dot beta]$ 

Constructing DFA for LR(0), when we merge a state $[Y <- alpha dot ]$ with something else, we are having a problem, because with this state machine only, we will never be able to judge what to do with $Y$. 

==== Better with SLR(1)

The states are 
- $[X <- alpha dot, a] "where" a in "FOLLOW"(G, X) and (X <- alpha) "is a production"$
- $[X <- alpha dot beta] "where" (X <- alpha beta) "is a production" and beta != 0$ 

The original transitions in NFA are: 
- $[Y <- alpha dot X beta] xarrow(X) [Y <- alpha X dot beta]$
- $[Y <- alpha dot X beta] xarrow(epsilon) [X <- dot gamma]$
- $[Y <- alpha dot t beta] xarrow(t) [Y <- alpha t dot beta]$ 

==== Parsing with LR(1)

State is a *progression* in a production rule, with the follow-set of the targeted terminal symbol. 

The states are 
- $[X <- alpha dot beta, a] "where" a in "FOLLOW"(G, X) and (X <- alpha beta) "is a production"$
- $[S <- alpha dot beta, \$] "where" S "is the start symbol"$

The original transitions in NFA are: 
- $[Y <- alpha dot X beta, a] xarrow(X) [Y <- alpha X dot beta, a]$
- $[Y <- alpha dot X beta, a] xarrow(epsilon) [X <- dot gamma, b] "where" b in "FIRST-SET"(beta a)$
- $[Y <- alpha dot t beta, a] xarrow(t) [Y <- alpha t dot beta, a]$ 

The conflicts are the same as in @Heading-L4:Parsing-with-LR0. 

==== Parsing with LALR(1)

LR(1) have way to many states, but in real-world languages, some of these states can be merged without losing too much of the expressive power. 

This is done by merging DFA states that only differ in lookahead sets. Note that the states are still different from LR(0) table in that LR(0) table merge two DFA states wherever there exists a pair of NFA states that only differ in lookahead sets, but LALR(1) requires 1-1 correspondence between each pair of NFA states. 

Merge any two states that only differs in lookahead symbol. 

In practice, this is implemented by removing lookahead symbols from LR(1) items when generating possible next states with GOTO function and merge the new lookahead symbols into the newly generated DFA state. 
 
== Semantic Analysis

=== Scoping

Defining occurrences of symbols. 

=== Type Checking

== Code Generation

=== Activation Records

==== Basic Subject

#definition("Activation Record")[
    An activation record is a block of memory allocated with an invocation of procedure. 
]

Typically, this concept usually involves stack allocation & calling conventions, i.e. the following problems needs to be addressed before we proceed engineering:
- How to pass the computation results?
- What kind of computation can be done in registers?
- When a function is invoked, where to put the parameters?

==== Considerations: Closure

For some languages, they support nested functions, or closure. Nested functions can access the local definitions of its parent function. Which means even when a function ends its scope, when a nested function is returned, these local definitions must be kept in storage. Therefore, for these kind of langauges, stack allocation may not work. 

#example("returning nested functions")[
    #align(center)[
        ```
        # both x and z should be stored on heap
        def f(x:int):
            z = x + 10
            def g(y:int):
                return x + y + z
            return g
        ```
    ]
]

Some advanced languages like rust or cpp use a smarter approach. They allow users to optionally pack callable objects into heap allocation, and force users to use heap allocation when they want to return callable objects (rust: through Sized trait bound + borrow checking, cpp: provide tools to handle or check validity). 

==== Considerations: Using Registers

By convention, some registers are *caller saved*, which means it is the caller's liablity to preserve the value of these registers, and callees can modify them arbitrarily as they see fit. Some registers are *callee saved*, which means the callee should preserve the value of these registers. 

