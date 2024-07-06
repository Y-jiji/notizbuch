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

== Optimization Problems

=== Array Scanning

#tag[algo:max-cont-seq] Given an array of integers, find the maximal sum of contiguous subarrays. 

#tag[algo:max-cont-seq:solution] To solve @algo:max-cont-seq, we first try the prefix sum strategy so the maximal sum converts into the maximal difference $a[j]-a[i]$ between a pair of $(a[j],a[i])$, where $j >= i$. For each given $j$, we want to select the smallest $a[i]$, so we also compute a prefix minimum. 

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

#tag[algo:scan] 

=== 

== 