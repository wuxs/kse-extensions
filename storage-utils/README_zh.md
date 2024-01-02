这个扩展组件包含以下工具:
- snapshot-controller， 用来为 PVC 做快照。
- snapshotclass-controller，用来为快照计数。
- pvc-auto-resizer，用来为 PVC 在容量不足的情况下实现自动扩容。
- storageclass-accessor， 提供了一个准入控制器，用来验证是否准许在某个命名空间或企业空间创建 PVC。