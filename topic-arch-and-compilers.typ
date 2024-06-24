#import "template.typ": *
#show: setup

= Compilers & Architectures <compiler>

#summary[
    #tag[compiler-arch] In general, the boundary of computability is maintained by TCS people and logicians (see @tcs:division). However, people also care about how to implement computation in our physical world. Given that intricacy of modern hardware, implementation can also be a very hard subject, especially when one want to compute efficiently. We ended up write compilers to do these for us, i.e. translating programs into machine code. 
    #tag[compiler-arch:misc-use] On the other hand, people also write compilers targeting not only machine code, and not only from high-level languages. In these scenarios, we also have different requirements for compilers. 
]

== Principles of Translation

#tag[translation] A binary operation $bullet arrow.b.dashed bullet$ is a translation between two transition systems $(arrow.r, S, mono("val"_s))$ and $(arrow.r.stroked, T, mono("val"_t))$  iff 
$
frac(
    s arrow.b.dashed t sp sp sp
    s arrow.r^* s_* sp sp sp 
    t arrow.r.stroked^* t_*
    ,
    s_* arrow.b.dashed t_*
)
$

#todo[Link transition system, star over arrow means evaluation]

== Tiger Compiler

#todo[Tiger Compiler]