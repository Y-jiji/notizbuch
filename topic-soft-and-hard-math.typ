#import "template.typ": *
#show: setup("Topic")

= Soft and Hard Math

== Motivating Example

I noticed my tendency towards soft-style mathematics when I'm composing a simple proof of the following lemma (@Lemma:Matrix_Determinant). 

#lemma("Matrix Determinant")[
    When $A$ is an invertible matrix, the following equation holds:
    $
        det(A+u v^T) = (1+v^T A^(-1)u) det(A)
    $
]

While my friends told me that they constructed a block matrix to make the proof, I was super confused because this is what I did at the first place:

#proof("Lemma:Matrix_Determinant", extra: "A")[
    $
        det(A + u v^T) = det(A) dot det(I+A^(-1)u v^T)
    $
    Because $A^(-1)u v^T$ is a dyiad matrix, its eigen vector of non-zero eigen values must have the same direction as $A^(-1)u$ , so the eigen value is just $\|A^(-1) u v^T A^(-1) u\|slash\|A^(-1) u\|= v^T A^(-1) u$. Take $lambda = 1$ in the characteristic polynomial proves the final result. 
    $
        & det(lambda I + A^(-1)u v^T) = lambda^(n-1)(lambda + v^T A^(-1)u)\
        & "where" n "is the number of rows/columns in" A 
    $
    #TODO[Refer to some results in linear algebra]
]

Compared to the "normally hard" approach:

#proof("Lemma:Matrix_Determinant", extra: "B")[Constructing block matrix
    $
        mat(I, 0; v^T, 1)
        mat(I + u v^T, u; 0, 1)
        mat(I, 0; -v^T, 1)
        =
        mat(I, u; 0, 1 + v^T u)
    $
    Therefore,
    $
        det(I + u v^T) = 1 + v^T u\
        det(A + u v^T) = det(A) det(I + A^(-1) u v^T) 
                       = det(A) (1 + v^T A^(-1) u)
    $
]

The soft style @Proof-A:Lemma:Matrix_Determinant proof makes use of more geometric intuition, but being less direct. This kind of approach is very hard to proceed when the understanding of the subject is not complete. 

== Psychological Cause

=== T/ First Impact <Heading-L3:First-Impact>

As I remember, when I was at 2nd grade in primary school, my math teacher called my parents because I failed at a unit test "carrying in addition". This unit test is composed of ten questions, all of them are 3-digits number plus 3-digits number problems. I only get one of them correct... So later my parents suspected that I might be intellectually invalid. 

I don't know about ADHD stuff that young, and mental disorder, even at the slightest extent, is considered stigma in my community. Since then, I tend to avoid computation as much as possible, leaving a plenty of blanks in test papers to disguise my inability to complete them. My parents got me into a tutoring center, and fortunately there was a incredibly good teacher that really knows that he is doing. Thanks to him and well-prepared problem sets from the tutoring center, I got to bypass computation but delved into other parts of mathematics. And through some tough mental process I finally acquired the ability to calculate addition and subtraction correctly (and slowly) 2 years later than my peers. 

=== T/ Second Impact

From the @Heading-L3:First-Impact, people may infer that I would still be considered dum in secondary school. But ridiculously, I kind of earned a reputation of being smart because I once confused my class teacher with my homework. Cutting corners and turning stones as I usually do, I tended to work out super confusing solutions to a problem, and they were mostly correct, so I was doing fine in tests but got whoever grade my test papers really mad (this partially attributes to my awful handwritting). 

Since my reputation was built upon this confusing style, there was no reason for me to stop being more confusing! In the late stages, I even coined new concepts as middle steps of my proof. 

=== T/ Third Impact

It was not until I got into university that I finally started to work on formal mathematics. I learned some ZFC set theory, and tried to write everything in set theory. At that time, I thought that was the only correct way of doing mathematics, and kind of ditched the tricks that I acquired in my earlier stages of study. (This was kind of ironic, because IAS is babysitting univalence foundations at this point, and later HoTT prevails. ) And I was obsessed with abstraction. Unlike Grothendieck who extracts knowledge from "आकाश", most human beings tends to over-abstract some simple concepts and finally turns them into nothing, so do I. While getting more adept at ZFC, I lost most of my hard-style skills, which is already very scarce in my knowledge base 😢.

== Methods for Correction

#TODO[Write what the heading suggests]