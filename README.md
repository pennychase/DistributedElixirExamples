# Distributed Elixir Examples
Implementation of Ricardo Garcia Vega's blog series on distributed Elixir. [Part 1](https://bigardone.dev/blog/2021/05/22/three-real-world-examples-of-distributed-elixir-pt-1) has links to the entire series.

- **simple_cluster** implements a simple two node cluster, first just using erlang's sys.config to specifiy the nodes, and then using [libcluster](https://hexdocs.pm/libcluster/readme.html)

- three repositories implement "a singleton process across the cluster that executes a periodic task and restarts in any node when it dies or starts in a new node when the current node where it is running goes down." Making a process unique across the cluster requires registration, and each repo uses different global registries:
    - **global_background_job** uses erlang's [:global](https://www.erlang.org/doc/apps/kernel/global.html) registry facility
    - **swarm_background_job** uses [swarm](https://hexdocs.pm/swarm/readme.html), which is "architected to handle dynamic node membership and large volumes of process registrations being created/removed in short time windows." libcuster was extracted from swarm.
    - **horde_background_job** uses [horde](https://hexdocs.pm/horde/readme.html), a distributed registry and supervisor built on top of delta-CRDTs (conflict free replicated data types). It was inspired by swarm, but separates registry and supervisor.