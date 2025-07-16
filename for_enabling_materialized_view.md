
# ✅ Editing cassandra.yaml in Docker

When using a minimal Docker container, it may not have tools like `vi`, `nano`, or `sudo`. Here’s how you can edit the `cassandra.yaml` safely using your host system.

---

## 🔁 Step-by-Step Instructions

### 📤 Step 1: Copy the File from the Container to Your Host

```bash
docker cp n1:/etc/cassandra/cassandra.yaml ./cassandra.yaml
```

---

### ✏️ Step 2: Edit the `cassandra.yaml` on Your Host

Open the file in any editor like **VS Code**, **Sublime Text**, or **Notepad++**.

Search for:

```yaml
materialized_views_enabled: false
```

Change it to:

```yaml
materialized_views_enabled: true
```

Save the file.

---

### 📥 Step 3: Copy the Edited File Back to the Container

```bash
docker cp ./cassandra.yaml n1:/etc/cassandra/cassandra.yaml
```

---

### 🔄 Step 4: Restart the Cassandra Container

```bash
docker restart n1
```

---

## ✅ Done!

You’ve now successfully enabled materialized views in your Cassandra Docker container.
