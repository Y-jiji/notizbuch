#import "t-main.typ": *
#show: with-setup

= Solving Algorithmic Problems

#summary[
    #tag[algo:bg] In engineering, only 5%-10% of the time is devoted to performance issues, and only 80% of them can be attributed to algorithmic problems. However, these problems can still be fairly important, as once you encounter them, you will definitely have to solve them, or your app cannot respond in reasonable time. Also, you need them for your job interviews. 
    #tag[algo:intro] Usually, algorithmic problems can be solved by simply replacing classic data structures with more efficient ones. Of course, simple augmentation is often needed. The others, however, will need design techniques like dynamic programming, which involves fairly hard reasoning and some experience. To manage this techniques, we mainly learn how to recognize patterns while keeping a 'perturbated space' of these patterns in semantic space. The hard thing is to maintaing a mostly correct and flexible 'perturbated space'. ("Let's add something new")
]

== Solution Strategies

=== Data Structures

#tag[algo:data-structure] Data structures are basically pre-solved problems (state-of-art solutions) and sometimes multiple of the problems can be solved by one data structure. When I cannot really understand how a data structure works internally, I memorize what problem it solves and computational cost. 

#task[More data structures]

=== Sub-problem Division

#tag[algo:fix-variables] Suppose we want to compute $f(x,y,dots,z)$, we can fix some arguments to simplify the problem. 

=== Data Sharing

#tag[algo:data-share] Sometimes, some computation share the same information from others. By tuning the computation process carefully, we can utilize this property. 

#tag[algo:optim:difference] Differencing is often applied to arrays $a$. Suppose we have a fixed array $a$. When query $f(i, j) = g(a[i dots j])$ is needed many times in a computing process, we may construct an array $b$ and a binary operation $(compose)$ such that $f(i, j) = b[i] compose b[j]$. where $(compose)$ can be computed efficiently (usually $O(1)$ time).

== Optimization Problems

=== Function Rewriting

#tag[algo:optim:fn-rewrite] Sometimes, an optimization problem's domain can be written as ${f(x): x in X}$. Therefore, rewriting the function can help make this problem simpler. 

#tag[algo:gcd-as-min] Given a non-negative number $a,p,q$ , try to find $n$ such that $n$ minimizes $
a + n p mod q
$
#tag[algo:gcd-as-min:solution] As in @algo:optim:fn-rewrite, we know that this problem can be written as $
min {f(n): n in NN}
$
where function $f(n) = a + n p mod q$. However, this representation makes this problem hard to solve. To simplify this problem, we may notice that $f(n) = a + n p + m q mod q$ holds for all $m$, where $n,m in ZZ$. (Yes, we extend $NN$ to $ZZ$, and suppose $mod$ always take positive values, like $-1 mod m = m-1$). We notice that $(a + n p + m q) mod m = min { a + n p + m q : m in ZZ} $, so we can finally rewrite our problem as: 
$
    min { a + n p + m q : n,m in ZZ }
$
To this point, we can easily rewrite it as
$
    min { a + n dot gcd(p, q): n in ZZ }
$
#tag[algo:gcd-as-min:comment] In @algo:gcd-as-min:solution, we notice that for min/max operation on set ${f(x): x in X}$, if we can rewrite $f(x)$ as an min/max of $min {g(x, y): y in Y}$, then the whole problem can be re-written as min/max of ${g(x,y): x in X and y in Y}$. Making a space for further thinking. 

#tag[algo:least-10] Given a $n times n$ grid filled with natural numbers, find a path from the upper-left corner to the lower-right corner such that when we multiply all the numbers alone the path, the number of trailing zeros in the decimal representation of is minmized. 

#tag[algo:least-10:solution] To solve this problem, we first have to write out the minimized set. $
    min {product_{(i,j) : P} g r i d [i][j] || 10 : P in P a t h}
$
where $x || 10$ means $max { i :  x mod 10^i = 0}$ when $x eq.not 0$, and $x || 10 = 1$ when $x = 0$. \
We know that $x mod 10 ^i = 0$ means $x mod 5^i = 0$ and $x mod 2^i = 0$. So when $x eq.not 0$, we write $x || 10 = min {x || 5, x || 2}$. Using the property of $min {...}$ operation, we can rewrite our problem as: 
$
    min {
        min {product_{(i,j) : P} g r i d [i][j] || 2 : P in P a t h},
        min {product_{(i,j) : P} g r i d [i][j] || 5 : P in P a t h}
    }
$
This can be solved using dynamic programming trivially. 

#task[Write comments to @algo:least-10]

=== Array Scanning

#tag[algo:max-cont-seq] Given an array of integers, find the maximal sum of contiguous subarrays. 

#tag[algo:max-cont-seq:solution] To solve @algo:max-cont-seq, we first try the prefix sum strategy so the maximal sum converts into the maximal difference $a[j]-a[i]$ between a pair of $(a[j],a[i])$, where $j >= i$. For each given $j$, we want to select the smallest $a[i]$, so we also compute a prefix minimum. This can be done on-the-fly to cut down on memory cost. 

#align(center)[#rect(stroke: (dash: "dashed", thickness: 0.7pt), inset: 15pt)[
    ```rust
    fn maxsum(arr: &[i64]) -> i64 {
        let pre = arr.fold(vec![0], |mut x, &y| {
            let z = x[x.len() - 1] + y; 
            x.push(z); x
        });
        let min = i64::MAX;
        let sum = i64::MIN;
        for x in pre {
            min = min.min(x);
            sum = sum.max(x - min);
        }
        return sum;
    }
    ```
]]

== Counting Problems

=== 

== Number Theory Problems

== Searching & Satisfiablity Problems

