#import "template.typ": *
#show: setup

= Logic, Types & Categories

#summary[
    #tag[tcs:division] The theory of computing is clearly divided into two pieces: one of them study what is computable, and the other study how fast we can compute. This chapter is about a recent endeavor to make logic verification computable in a less trivial way. 
    #tag[trinity] The related content will serves as an introduction to logic and category theory. Therefore, other stuff about logic and category theory also goes here. 
]

== Category Theory

===  Category & Functors

#tag[cat] A category is a directed graph, where the arrows in category can be composed into another arrow in this graph. Formally, a category have the following components @Paper:Agda-Categories: 
#align(center)[```agda
record Category {o l e : Level} : Type (lsuc (o ⊔ l ⊔ e)) where field
    obj  : Type o
    hom  : obj → obj → Type o
    id   : ∀ {A : obj} → hom A A
    _@_  : ∀ {A B C : obj} → hom B C → hom A B → hom A C
    ass  : ∀ {f} → ∀ {g} → ∀ {h} → f @ (g @ h) = (f @ g) @ h
    idl  : ∀ {f} → comp id f = f
    idr  : ∀ {f} → comp f id = f
```]

#todo[Currently this is just pseudocode. Rewrite in AGDA. ]

#tag[cat:notation] In the context of category theory, we use upper case $frak("FRAK")$ for functors, upper case $cal("CAL")$ for categories, normal lower case for morphisms, and normal upper case for objects. 

#tag[cat:opposite] An opposite category $cal(C^"op")$ of category $cal(C)$ is a category where each morphism is reversed. 
$
    "obj"_cal(C^"op") = "obj"_cal(C)\
    "hom"_cal(C^"op")(X,Y) = "hom"_cal(C)(Y, X)
$

#tag[cat:functor] A functor $frak(F): cal(C) => cal(D)$ from category $cal(C)$ to category $cal(D)$ maps both objects and morphisms from $cal(C)$ to $cal(D)$. And keep the relation between objects and morphisms:
$
    forall { X sp Y : "obj"_cal(C) } sp
    forall { f: hom_cal(C)(X,Y) } sp 
        frak(F)(f):hom_cal(D)(X,Y)\
    forall { f sp g : hom_cal(D)(bullet, bullet)} sp
        frak(F)(f compose g) = frak(F)(f) compose frak(F)(g)
$

#tag[cat:functor:notation] In @cat:functor, we write ${f sp g :hom_cal(D)(bullet, bullet)}$ to denote $f$ and $g$ can be any morphism that satisfy the prequisites of composition, i.e. when for some ${X sp Y}$ we have $g: hom_cal(C)(X,Y)$ then we must have $f: hom_cal(C)(Y,Z)$ . 

#tag[cat:functor:contra-variant] For @cat:functor, mathematicians sometimes call functor $frak(F) : cal(C^"op") => cal(D)$ "contra-variant functor from $cal(C)$ to $cal(D)$". This is a matter of convenience and convention. 

===  Categorical Limits

#tag[cat:cone] A cone $(A, phi)$ of a functor $frak(F) : cal(D) => cal(C)$ is an object $A$ in $cal(C)$ and a family $phi: forall {X : "obj"_(cal(D))} -> hom(A, F(X))$ such that: 
$
    forall {X sp Y: "obj"_cal(D)} sp 
    forall {f: hom_cal(D)(X,Y)} sp 
    frak(F)(f) compose phi(X) = phi(Y)
$

#tag[cat:cone:illustration] In @cat:cone, the name "cone" seems like some abstract nonsense @Meme:Abstract-Nonsense, but when we examine it carefully, the commutative diagram actually looks like a cone, tipping on object $A$ . 
#align(center)[#commutative-diagram(
    node((0, 1), $A$, "A"),
    node((1, 0), $frak(F)(X)$, "FX"),
    node((1, 2), $frak(F)(Y)$, "FY"),
    arr("A" , "FX", $phi(X)$,     label-pos: right),
    arr("A" , "FY", $phi(Y)$,     label-pos: left),
    arr("FX", "FY", $frak(F)(f)$, label-pos: right),
)]

#tag[cat:limit] A categorical *limit* $(A, phi)$ of a functor $frak(F) : cal(D) => cal(C)$ is a cone of $frak(F)$ such that for any other cone $(B, psi)$ of $frak(F)$ , there always exists a unique morphism $g: hom(A, B)$ such that 
$
    forall {X: "obj"_cal(C)} sp phi(X) compose g = psi(X)
$

#tag[cat:limit:why] While we can convince ourselves to accept the triviality @cat:cone, we cannot help to ask why categorical limit is important, and why it looks like the current way, not the other (if we replace that last sentence in @cat:limit with $g: hom(B, A)$ such that $phi(X) = psi(X) compose g$) . I convinced myself that $A$ preseves the information of other cones, because once we give another object $B$, we can either recover a $psi$ such that $(B, psi)$ is a cone over $frak(F)$, or we can decide that $B$ cannot constitute a cone. Therefore, a limit $(A, phi)$ of functor $frak(F)$ bookeeps the information for all "cones". But the one in the alternated definition doesn't have the same property. 
#align(center)[#commutative-diagram(
    node((0, 1), $A$, "A"),
    node((1, 1), $B$, "B"),
    node((2, 0), $frak(F)(X)$, "FX"),
    node((2, 2), $frak(F)(Y)$, "FY"),
    arr("A" , "FX", $phi(X)$,     label-pos: right),
    arr("A" , "FY", $phi(Y)$,     label-pos: left),
    arr("B" , "FX", $psi(X)$,     label-pos: left),
    arr("B" , "FY", $psi(Y)$,     label-pos: right),
    arr("B" , "A",  $g$,          label-pos: right, "dashed"),
    arr("FX", "FY", $frak(F)(f)$, label-pos: right),
)]

#tag[cat:co-cone] A categorical *co-cone* $(A, phi)$ of a functor $frak(F) : cal(D) => cal(C)$ is an object $A$ in $cal(C)$ and a mapping $phi: forall {X:"obj"_cal(D)} -> hom(F(X), A)$ such that:
$
    forall {X sp Y: "obj"_cal(D)} sp 
    forall {f: hom_cal(D)(X,Y)} sp 
    phi(X) = phi(Y) compose frak(F)(f)
$

#tag[cat:co-cone:illustration] Comparing @cat:co-cone and @cat:cone, we can find that in @cat:co-cone, the usage of $frak(F)(f)$ happens in the $phi(bullet)$'s co-domain instead of $phi(bullet)$'s domain, and the object that fills the $(bullet)$ is also "inversed". 
#align(center)[#commutative-diagram(
    node((0, 1), $A$, "A"),
    node((1, 0), $frak(F)(X)$, "FX"),
    node((1, 2), $frak(F)(Y)$, "FY"),
    arr("FX", "A", $phi(X)$, label-pos: left),
    arr("FY", "A", $phi(Y)$, label-pos: right),
    arr("FX", "FY", $frak(F)(f)$, label-pos: right),
)]

#tag[cat:co-limit] A categorical *co-limit* $(A, phi)$ of a functor $frak(F) : cal(D) => cal(C)$ is a co-cone of $frak(F)$ such that for every co-cone $(B, psi)$ for functor $frak(F)$ there exists a unique morphism $g: hom_cal(C)(B,A)$ such that
$
    forall {X: "obj"_cal(C)} sp phi(X) = g compose psi(X)
$

#tag[cat:co-limit:why] As in @cat:limit:why, we also ask the same question about co-limits, and as expected, we can answer it similarly: we can only recover other co-cones with the current definition, but not with the alternated one. 
#align(center)[#commutative-diagram(
    node((0, 1), $A$, "A"),
    node((1, 1), $B$, "B"),
    node((2, 0), $frak(F)(X)$, "FX"),
    node((2, 2), $frak(F)(Y)$, "FY"),
    arr("FX" , "A", $phi(X)$,     label-pos: left),
    arr("FY" , "A", $phi(Y)$,     label-pos: right),
    arr("FY" , "B", $psi(Y)$,     label-pos: left),
    arr("FX" , "B", $psi(X)$,     label-pos: right),
    arr("A"  , "B", $g$,          label-pos: left, "dashed"),
    arr("FX", "FY", $frak(F)(f)$, label-pos: right),
)]

== Topology

#tag[top:simplex:idea] A simplex can be seen as a generalization of a directed edge, where we may have $n$-vertices instead of just $2$-vertices. We generalize the concept of "direction" between 2 vertices to a permutation of $n$ vertices. An abstract $n$-simplex is defined as $(n+1)$-permutation in $frak(S)_(n+1)$. 

#tag[top:simplicial-set:idea] In @top:simplex:idea, we only defined simplicies as an independent object, but as edges is only interesting in directed graph, we also want to study the "hyper" directed graph consists of simplicies. Therefore, we first specify a set of vertices $V$, and define a simplex as a sequence of vertices. Moreover, when we have simplex $v_1,dots,v_n$ in this system, we must also have $v_1,dots, cancel(v_i), dots, v_n$ and $v_1,dots, v_i, v_i, dots, v_n$ in this system. From this point, we only discuss simplices in the context of given vertices. This is structure of (vertices, simplicies) is called simplicial set. 

#tag[top:delta-category:idea] To describe simplicial sets in category theory, we should construct of a free simplicial set. However, vertex set's size can be a problem: a free structure is supposed to be arbitrarily large, but this is usually forbidden in formal languages. Therefore, we choose a workaround that describes simplicies by how they interacts. 

#tag[top:delta-category] $cal(Delta)$-category is a category whose objects $"obj"_Delta$ are natural numbers and morphisms $hom_(cal(Delta))(n,m)$ are order-preserving functions from $[0 dots n] -> [0 dots m]$ . 

#tag[top:simplicial-set] A simplicial set is a contra-variant functor $frak(K)$ (see @cat:functor:contra-variant) from $cal(Delta)$-category (as in @top:delta-category) to $cal("Set")$-category, i.e. $frak(K) : cal(Delta^"op") => cal("Set")$ . 

#tag[top:simplicial-set:remark] Mind that there are many functors that satisfy the given condition in @top:simplicial-set. The difference between two simplicial sets depends on how they stick objects together (i.e. map different objects to the same object). 

#tag[top:simplicial-set:structure] For each order-preserving map $f$ mentioned in @top:delta-category, it can be decomposed into two kinds of maps, called "face map" and "degeneracy maps". 
The face maps can be written as $f : forall {n: NN} => hom_(Delta)(n+1, n)$ , which removes an element from 
#todo[face map and degeneracy map]

#tag[top:nerve] A nerve of a category $cal(C)$, written as $"nerve"_cal(C)$, is a simplicial set constructed from a (small) category using the following method. 


#todo[definition of small category. ]

#todo[defintion of nerve]

== Logic

#todo[Synthetic Tait Computability Paper: Logic]

== Type Theory

#todo[Synthetic Tait Computability Paper: TT]

== Cubical Type Theory

#todo[Synthetic Tait Computability Paper: CTT]
