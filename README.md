# DRb Lab

A place for dRuby experiments.

## Server Monitor

An experiment to monitor servers with DRb and Rinda.

### Server

Ring Server lets clients auto register without a uri and keeps track of them.
```
  bin/server/ring
```

TupleSpace is a shared data store for all clients.
```
  bin/server/tuplespace
```

### Client

The Client runs on the machine to be monitored, registers with the Ring server and sends data (cpu snapshot and uptime) to the TupleSpace.
```
  bin/client
```

### Monitor

Monitor outputs data from TupleSpace grouped by Client.
```
  bin/monitor
```
