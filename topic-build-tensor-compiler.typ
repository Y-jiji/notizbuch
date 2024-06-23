#import "template.typ": *
#show: setup

= Build a Smarter Tensor Compiler

#summary[
    Neujit is a topic trying to build a jit compiler for tensor computation workloads backed by WebGPU. While there are many tensor compilers, neujit    tries to find a smarter way to minimize the need of writing custom kernels. 
]

== Input

The input of tensor jit is usually an operation graph, where each node is a tensor, coupled with a descriptor of how it is computed from other nodes. 

== Problem Formulation

In compilers for general purpose languages, we usually deal with register allocation with interference graph, and try to achieve a K-coloring of this graph. When K-coloring doesn't work, the data represented by uncolored nodes are spilled to memory. 

Here we have to deal with the same problem, but in a more complicated way. The extra complexity comes from the architectural difference between CPU and GPU: GPU have more physical threads and associated programmable cache memory. Therefore, to transport data, we not only need to consider a coloring problem, but also take synchronization into consideration. 

The interference graph represents how data co-exists at the same time so that the same register cannot hold another data. Also, unlike the CPU case, data transferring is limited inside GPU and memory chunks have contiguousity requirements, which is also different from registers. 

== Workgroup-Local Operators

Workgroup memory can be utilized when and only when computation is happening locally inside workgroups. Therefore, we can just provide some workgroup-local operators and let the compiler to use them. 

Now the problem is how to decompose higher-level operators into a combination of workgroup-local operators. For eg, everyone knows that a matrix multiplication can be written as a tiled matrix multiplication, but it is always harder and error-prone way. Besides, the compiler needs extra aid to make sure it will not be "intimidiated" from intermediate steps. It can be helpful to warp the matrix evaluation order. 

$
    "all-map"(i,k: "all-reduce"(j: A[i,j] dot B[j,k]))
$

