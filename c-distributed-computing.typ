#import "t-main.typ": *
#show: with-setup

= Distrbuted Computing

== Replication & Availability

=== Raft

While Raft @Paper:Raft greatly simplifies Multi-Paxos @Paper:Paxos, it is still to complicated to understand at the first glance. However, we can first work on how Raft replicates a single message. 

Raft gives a role to each node, 