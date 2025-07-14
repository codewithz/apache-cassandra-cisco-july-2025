# 🚀 Deploying Cassandra Clusters with Docker

This guide walks you through deploying both **Single Data Center** and **Multi Data Center** Cassandra clusters using Docker and Docker Compose.

---

## 🏗️ Single Data Center Deployment

### Step 1: Launch the First Node

```bash
cd single-dc
docker-compose up -d n1
```

### Step 2: Check Cluster Status

```bash
docker-compose exec n1 nodetool status
```

Repeat this until the status is:

```
UN = Up and Normal
```

---

### Step 3: Add Second Node

```bash
docker-compose up -d n2
```

Check status again with:

```bash
docker-compose exec n1 nodetool status
```

Wait until both nodes show status `UN`.

---

### Step 4: Add Third Node

```bash
docker-compose up -d n3
```

Check status until all three nodes are `UN`.

---

### Step 5: View Token Allocations

```bash
docker-compose exec n1 nodetool ring
```

---

### Step 6: View Cassandra Configuration

```bash
docker-compose exec n1 more /etc/cassandra/cassandra.yaml
```

---

### Step 7: Tear Down the Cluster

```bash
docker-compose down
```

---

## 🌐 Multi-Data Center Deployment

### Step 1: Launch Node in First Datacenter (DC1, RAC1)

```bash
cd multi-dc
docker-compose up -d n1
```

Check status with:

```bash
docker-compose exec n1 nodetool status
```

Wait until status is `UN`.

---

### Step 2: Add Second Node in Different Rack (DC1, RAC2)

```bash
docker-compose up -d n2
```

Check again:

```bash
docker-compose exec n1 nodetool status
```

Wait for both nodes to be `UN`.

---

### Step 3: Add Third Node in New Datacenter (DC2)

```bash
docker-compose up -d n3
```

Again, check with:

```bash
docker-compose exec n1 nodetool status
```

Ensure all three nodes are `UN`.

---

### Step 4: View DC and Rack Configuration

```bash
docker-compose exec n3 bash
more /etc/cassandra/cassandra-rackdc.properties
exit
```

---

### Step 5: View Cluster Details

You can run:

```bash
docker-compose exec n1 nodetool status
docker-compose exec n1 nodetool ring
```

---

## 🧹 Cleanup

To stop and remove all Cassandra containers:

```bash
docker-compose down
```

---

## 🧾 Sample Output (Multi-DC)

```text
Datacenter: DC1
===============
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load       Tokens       Owns (effective)  Host ID                               Rack
UN  172.18.0.2  138.2 KiB  256          63.1%             afabf7c2-99db-48f2-8d06-1e1b41df8de0  RAC1
UN  172.18.0.3  119.03 KiB  256         68.4%             32421e38-cc9f-4e61-afc5-acf52eaf56c5  RAC2

Datacenter: DC2
===============
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load       Tokens       Owns (effective)  Host ID                               Rack
UN  172.18.0.4  70.91 KiB  256          68.5%             1964a4f4-8475-456c-9939-b377fe6d4582  RAC1
```

---

**✅ Tip:** Use `nodetool help` to explore more operational commands for Cassandra clusters.
