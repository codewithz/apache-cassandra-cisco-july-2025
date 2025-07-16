
# ⚙️ Cassandra Administration and Internal Settings

Apache Cassandra is a highly tunable distributed database. As an administrator, you have access to several files and tools that allow you to control its behavior — from replication and consistency to compaction strategies, heap sizes, and gossip settings.

## 📁 Core Configuration Files

| File | Purpose |
|------|---------|
| `cassandra.yaml` | Main configuration for node behavior (replication, compaction, partitioner, etc.) |
| `cassandra-env.sh` | JVM tuning: heap size, GC settings |
| `jvm.options` | JVM options like garbage collection |
| `logback.xml` | Logging configuration |
| `cassandra-rackdc.properties` | Defines the datacenter and rack for each node (used in snitching) |

## 🧠 cassandra.yaml — The Brain of the Node

Located in `/etc/cassandra/cassandra.yaml` (or `conf/` in source installations), this file contains almost all critical settings.

### Key Settings:

#### 1. `cluster_name`
```yaml
cluster_name: 'MyCassandraCluster'
```

#### 2. `num_tokens`
```yaml
num_tokens: 256
```

#### 3. `partitioner`
```yaml
partitioner: org.apache.cassandra.dht.Murmur3Partitioner
```

#### 4. `data_file_directories`
```yaml
data_file_directories:
   - /var/lib/cassandra/data
```

#### 5. `commitlog_directory`
```yaml
commitlog_directory: /var/lib/cassandra/commitlog
```

#### 6. `saved_caches_directory`
```yaml
saved_caches_directory: /var/lib/cassandra/saved_caches
```

#### 7. `seed_provider`
```yaml
seed_provider:
  - class_name: org.apache.cassandra.locator.SimpleSeedProvider
    parameters:
         - seeds: "192.168.1.10,192.168.1.11"
```

#### 8. `listen_address` / `rpc_address`
```yaml
listen_address: localhost
rpc_address: 0.0.0.0
```

#### 9. `endpoint_snitch`
```yaml
endpoint_snitch: GossipingPropertyFileSnitch
```

## 🌐 Snitches and Topology

```properties
dc=DC1
rack=RAC1
```

## 🧹 Compaction Strategy

```sql
ALTER TABLE my_table WITH compaction = {
  'class': 'LeveledCompactionStrategy'
};
```

## 🔐 Authentication & Authorization

```yaml
authenticator: PasswordAuthenticator
authorizer: CassandraAuthorizer
```

## 🧠 JVM Tuning (`cassandra-env.sh` / `jvm.options`)

```sh
MAX_HEAP_SIZE="4G"
HEAP_NEWSIZE="800M"
```

## 🛠️ Monitoring Tools

| Tool | Use |
|------|-----|
| `nodetool status` | View cluster health |
| `nodetool ring` | Token distribution |
| `nodetool tpstats` | Thread pool stats |
| `nodetool compactionstats` | Active compactions |
| `nodetool repair` | Manual data repair between replicas |
| JMX / Prometheus Exporter | Deep metrics & dashboards |

## 🔄 Repair & Hinted Handoff

```bash
nodetool repair
```

```yaml
hinted_handoff_enabled: true
max_hint_window_in_ms: 10800000  # 3 hours
```

## 🗂️ System Keyspaces

| Keyspace | Purpose |
|----------|---------|
| `system` | Internal metadata |
| `system_schema` | Schema definitions |
| `system_auth` | User credentials (when enabled) |
| `system_traces` | Query tracing data |

## 🪛 Useful Admin Commands

```bash
nodetool status
nodetool info
nodetool flush
nodetool repair
nodetool cleanup
```

## 📌 Best Practices

- Avoid using `localhost` in cluster setups — use real IPs.
- Always set the correct `dc` and `rack` for topology-aware replication.
- Use **QUORUM** or **LOCAL_QUORUM** for consistency in prod.
- Regularly run **`nodetool repair`** to maintain consistency.
- Keep `cassandra.yaml` in source control with clear documentation.

## 😂 Funny Analogy

Imagine Cassandra nodes as roommates in a big house. The `cassandra.yaml` file is their *chore schedule*. It defines:
- Who lives where (dc/rack)
- How groceries (data) are divided (partitioner, replication)
- How loud they can be (heap size)
- How often they clean up (compaction)
- Who talks to whom (snitch, seed nodes)

If one roommate (node) misses a meeting (down), others leave sticky notes (hinted handoff) and occasionally hold a big catch-up session (repair).

## 📚 References

- [Official Cassandra Docs](https://cassandra.apache.org/doc/)
- [YAML Reference](https://cassandra.apache.org/doc/latest/configuration/cassandra.yaml/)
- [Monitoring](https://cassandra.apache.org/doc/latest/operating/metrics.html)
- [Tuning](https://cassandra.apache.org/doc/latest/operating/hardware.html)
