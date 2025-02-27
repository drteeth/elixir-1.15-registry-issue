# Testing repository for Elixir Commanded issue

## Issue

Since Elixir 1.15, when using Commanded process managers, running the test suite of the application is likely to produce a series of error message such as these:

```log
10:10:00.974 [error] GenServer {MyApp.EventStore.EventStore.Subscriptions.Registry, {"$all", "MyProcessManager"}} terminating
** (ArgumentError) unknown registry: MyApp.EventStore.EventStore.PubSub
    (elixir 1.15.7) lib/registry.ex:1391: Registry.info!/1
    (elixir 1.15.7) lib/registry.ex:1007: Registry.register/3
    (eventstore 1.4.7) lib/event_store/pubsub.ex:38: EventStore.PubSub.subscribe/3
    (eventstore 1.4.7) lib/event_store/subscriptions/subscription_fsm.ex:70: EventStore.Subscriptions.SubscriptionFsm.transition/3
    (eventstore 1.4.7) lib/event_store/subscriptions/subscription.ex:221: EventStore.Subscriptions.Subscription.handle_call/3
    (stdlib 4.3.1.6) gen_server.erl:1149: :gen_server.try_handle_call/4
    (stdlib 4.3.1.6) gen_server.erl:1178: :gen_server.handle_msg/6
    (stdlib 4.3.1.6) proc_lib.erl:240: :proc_lib.init_p_do_apply/3
Last message (from #PID<0.367.0>): {:connect, #PID<0.367.0>, [retry_interval: 60000, hibernate_after: 15000, partition_by: nil, concurrency_limit: 1, name: MyApp.EventStore, mapper: &Commanded.EventStore.Adapters.EventStore.Mapper.from_recorded_event/1, conn: MyApp.EventStore.Postgrex, event_store: MyApp.EventStore, query_timeout: 15000, schema: "public", serializer: Commanded.Serialization.JsonSerializer, stream_uuid: "$all", subscription_name: "MyProcessManager", start_from: 0]}
domain=otp file=gen_server.erl line=1402 mfa=:gen_server.error_info/8 pid=<0.368.0>
```

This is a minimal repository to reproduce this issue.

## Pre-conditions

- Run a PostgreSQL database cluster locally with trusted authentication and the following setting:
  - username: `postgres`
  - host: `localhost`
  - port: `5432`
  - database: `postgres`
  Or modify `config.exs` accordingly
- Install Elixir >= 1.15.0

## Steps to reproduce

- Start the PostgreSQL database cluster

- Setup Elixir environment

  ```shell
  mix deps.get
  ```

- Setup Elixir environment

  ```shell
  MIX_ENV=test mix event_store.init
  ```

- Start the test suite

  ```shell
  mix test
  ```

- Observe the results

  ```shell
  .10:20:31.528 [error] GenServer {MyApp.EventStore.EventStore.Subscriptions.Registry, {"$all", "MyProcessManager"}} terminating
  ** (ArgumentError) unknown registry: MyApp.EventStore.EventStore.PubSub
      (elixir 1.15.7) lib/registry.ex:1391: Registry.info!/1
      (elixir 1.15.7) lib/registry.ex:1007: Registry.register/3
      (eventstore 1.4.7) lib/event_store/pubsub.ex:38: EventStore.PubSub.subscribe/3
      (eventstore 1.4.7) lib/event_store/subscriptions/subscription_fsm.ex:70: EventStore.Subscriptions.SubscriptionFsm.transition/3
      (eventstore 1.4.7) lib/event_store/subscriptions/subscription.ex:221: EventStore.Subscriptions.Subscription.handle_call/3
      (stdlib 4.3.1.6) gen_server.erl:1149: :gen_server.try_handle_call/4
      (stdlib 4.3.1.6) gen_server.erl:1178: :gen_server.handle_msg/6
      (stdlib 4.3.1.6) proc_lib.erl:240: :proc_lib.init_p_do_apply/3
  Last message (from #PID<0.367.0>): {:connect, #PID<0.367.0>, [retry_interval: 60000, hibernate_after: 15000, partition_by: nil, concurrency_limit: 1, name: MyApp.EventStore, mapper: &Commanded.EventStore.Adapters.EventStore.Mapper.from_recorded_event/1, conn: MyApp.EventStore.Postgrex, event_store: MyApp.EventStore, query_timeout: 15000, schema: "public", serializer: Commanded.Serialization.JsonSerializer, stream_uuid: "$all", subscription_name: "MyProcessManager", start_from: 0]}
  domain=otp file=gen_server.erl line=1402 mfa=:gen_server.error_info/8 pid=<0.368.0>

  .10:20:31.660 [error] GenServer {MyApp.EventStore.EventStore.Subscriptions.Registry, {"$all", "MyProcessManager"}} terminating
  ** (ArgumentError) unknown registry: MyApp.EventStore.EventStore.PubSub
      (elixir 1.15.7) lib/registry.ex:1391: Registry.info!/1
      (elixir 1.15.7) lib/registry.ex:1007: Registry.register/3
      (eventstore 1.4.7) lib/event_store/pubsub.ex:38: EventStore.PubSub.subscribe/3
      (eventstore 1.4.7) lib/event_store/subscriptions/subscription_fsm.ex:70: EventStore.Subscriptions.SubscriptionFsm.transition/3
      (eventstore 1.4.7) lib/event_store/subscriptions/subscription.ex:221: EventStore.Subscriptions.Subscription.handle_call/3
      (stdlib 4.3.1.6) gen_server.erl:1149: :gen_server.try_handle_call/4
      (stdlib 4.3.1.6) gen_server.erl:1178: :gen_server.handle_msg/6
      (stdlib 4.3.1.6) proc_lib.erl:240: :proc_lib.init_p_do_apply/3
  Last message (from #PID<0.428.0>): {:connect, #PID<0.428.0>, [retry_interval: 60000, hibernate_after: 15000, partition_by: nil, concurrency_limit: 1, name: MyApp.EventStore, mapper: &Commanded.EventStore.Adapters.EventStore.Mapper.from_recorded_event/1, conn: MyApp.EventStore.Postgrex, event_store: MyApp.EventStore, query_timeout: 15000, schema: "public", serializer: Commanded.Serialization.JsonSerializer, stream_uuid: "$all", subscription_name: "MyProcessManager", start_from: 0]}
  domain=otp file=gen_server.erl line=1402 mfa=:gen_server.error_info/8 pid=<0.429.0>

  .
  Finished in 0.4 seconds (0.00s async, 0.4s sync)
  3 tests, 0 failures

  Randomized with seed 81778
  ```
  