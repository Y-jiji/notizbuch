#import "template.typ": *
#show: with-setup

= Self-supervision

#summary[
    #tag[self-supervision] In current world, human cannot really label piece of data. Therefore, the efficacy of a data-driven system mostly depends on how algorithms can memorize meaningful representations without human instruction, and how well they apply these representations to downstream tasks. Self-supervision methods try to solve this problem by designing downstream-alike tasks where labeling can be automated. 
    #tag[self-supervision:chapter] In this chapter I plan to introduce several self-supervision methods. Each of them organized as a pipeline: task design $->$ model design $->$ adaption plan. 
]

== Language Modeling

#task[Language Modeling]

=== Low Rank Adaptation

In industry, companies like openai allow users to #link("https://web.archive.org/web/20240301122528/https://openai.com/blog/introducing-gpts", "customize language models") by uploading finetuning data. Consequently, it will results in multiple LoRAs served at the same time. Whereas intergrating LoRAs into base parameters is beneficial for a single language model, it is definitely a burden when serving multiple LoRAs. 

To serve multiple LoRAs, we better keep these LoRAs and engineer a custom CUDA kernel to compute them in parallel. Also, we have to mind batching and offloading strategy. 