#import "template.typ": *
#show: with-setup

= Database Management System

== Storage & Index

=== Geometric Data

#tag[dbms:geo:intro] For most database systems, we can produce good enough index by merely knowing the *type* of data. For example, we can use B-Tree-Index for ordered data, and Hash-Index for any hashable data. However, in geometric data, we cannot exactly do that, because the data has complicated structures, and cannot be easily found or reasoned by human. 

