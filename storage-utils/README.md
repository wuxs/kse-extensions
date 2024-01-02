This extension contains the following utilities:
- snapshot-controller, which is used to do volume snapshot for PVC.
- snapshotclass-controller, which is used to count volume snapshots per snapshot class.
- pvc-auto-resizer, which is used to expand the PVC's capacity automatically when it's short of storage space.
- storageclass-accessor, which is used to validat if a PVC can be created in target namespace and workspace by providing a admission webhook.