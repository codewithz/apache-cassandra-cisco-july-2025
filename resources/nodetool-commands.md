
# 📘 Cassandra `nodetool` Commands: Explained with Usage

Apache Cassandra ships with the `nodetool` utility for managing and monitoring nodes in a cluster. It is one of the most powerful tools in the Cassandra administrator's toolkit.

---

## 🔧 What is `nodetool`?

`nodetool` is a command-line interface (CLI) used to manage a Cassandra node. It connects to the **JMX port** (default 7199) of a node and provides information like cluster status, performance metrics, data flushes, repairs, etc.

---

## 🧪 Basic Node and Cluster Health Commands

### ✅ `nodetool status`

Shows the status of all nodes in the cluster.

```bash
nodetool status
```

**Columns:**
- `UN`: Up and Normal
- `DN`: Down and Normal
- `UJ`: Up and Joining
- `UL`: Up and Leaving
- `UM`: Up and Moving

---

### 🧬 `nodetool ring`

Displays the token distribution and ownership information across nodes.

```bash
nodetool ring
```

✅ Useful to confirm balanced token distribution in `vnode`-enabled clusters.

---

### 🧠 `nodetool info`

Displays information about the node like uptime, load, data center, etc.

```bash
nodetool info
```

---

## 🔍 Monitoring & Diagnostics

### 📦 `nodetool cfstats`

Shows statistics about column families (tables) such as read/write latency, space used.

```bash
nodetool cfstats
```

---

### 📶 `nodetool netstats`

Shows internode communication stats, such as streaming operations, data transfers.

```bash
nodetool netstats
```

✅ Helpful during node repair, bootstrap, or decommission.

---

### ⏱️ `nodetool tpstats`

Reports thread pool activity like active, pending, and completed tasks.

```bash
nodetool tpstats
```

---

### 📊 `nodetool tablehistograms <keyspace> <table>`

Shows latency histograms for read, write, range, and CAS operations.

```bash
nodetool tablehistograms my_keyspace my_table
```

---

## 🔄 Repair & Maintenance

### 🧼 `nodetool flush`

Flushes in-memory memtable contents to disk (SSTables).

```bash
nodetool flush
```

---

### 🔧 `nodetool repair`

Triggers anti-entropy repair across replicas for a keyspace or the entire node.

```bash
nodetool repair my_keyspace
```

---

### 🧹 `nodetool cleanup`

Removes data that no longer belongs to the node after a topology change (like decommission).

```bash
nodetool cleanup
```

---

### 🔄 `nodetool compact`

Forces manual compaction of SSTables for a keyspace or table.

```bash
nodetool compact my_keyspace my_table
```

---

### ❌ `nodetool decommission`

Gracefully removes a node from the cluster (use with care!).

```bash
nodetool decommission
```

---

## 🔒 Security & Auth

### 👤 `nodetool setlogginglevel`

Changes the logging level at runtime.

```bash
nodetool setlogginglevel com.datastax.driver.core INFO
```

---

## 🧪 Debugging & Testing

### 🔁 `nodetool describecluster`

Displays cluster metadata like name, partitioner, snitch, etc.

```bash
nodetool describecluster
```

---

### 🛠️ `nodetool proxyhistograms`

Prints histograms of read/write latency across the coordinator node.

```bash
nodetool proxyhistograms
```

---

### 🔍 `nodetool gossipinfo`

Shows gossip protocol info — what the node knows about others.

```bash
nodetool gossipinfo
```

---

## ⚠️ Common Gotchas

- 🔐 If `nodetool` fails with authentication errors, ensure you have JMX credentials and Cassandra is configured to allow JMX.
- 📦 Avoid using `repair` on the whole cluster repeatedly — it’s resource-intensive.
- ⚡ Some commands are **disruptive**, like `decommission`, `removenode`, or `bootstrap`.

---

## 📌 Bonus Tip

To run `nodetool` on a Docker-based Cassandra node:
```bash
docker exec -it cassandra-node nodetool status
```

Or for Kubernetes:
```bash
kubectl exec -it <pod-name> -- nodetool status
```

---

## 📚 Reference

- [Apache Cassandra Official Docs – nodetool](https://cassandra.apache.org/doc/latest/tools/nodetool/nodetool.html)
- [JMX Troubleshooting Guide](https://docs.datastax.com/en/archived/cassandra/2.2/cassandra/troubleshooting/trblshootJmxIssues.html)

---
