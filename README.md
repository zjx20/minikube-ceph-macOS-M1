minikube-ceph-macOS-M1
======================

Install ceph with minikube on macOS M1, for development or testing purposes.

Most of the code comes from the ceph and rook git repositories:
* https://github.com/ceph/ceph-csi/blob/51decb097c25561f9f615e4795d972db9cc8f784/scripts/minikube.sh
* https://github.com/rook/rook/blob/10756740675e81378b7b0c5acba3c8beea6bc308/deploy/examples/csi/rbd/storageclass-test.yaml


## Install

1. Edit `start_minikube.sh` to adjust the CPU, memory, disk size or something else to your actual needs.
2. Run `./start_minikube.sh` and wait for it to finish successfully. This script starts a single node k8s cluster, and the node has two 20GB disks by default (/dev/vba and /dev/vbb).
3. Run `./rook.sh deploy` to install rook, and wait for it to complete successfully.
4. `rook.sh` doesn't enable cephcsi drivers by default, run the following script to enable them:

    ```bash
    # enable rbd csi
    kubectl get cm rook-ceph-operator-config -n rook-ceph -o yaml | sed 's|ROOK_CSI_ENABLE_RBD: "false"|ROOK_CSI_ENABLE_RBD: "true"|g' | kubectl apply -f -

    # optional: enable cephfs csi
    kubectl get cm rook-ceph-operator-config -n rook-ceph -o yaml | sed 's|ROOK_CSI_ENABLE_CEPHFS: "false"|ROOK_CSI_ENABLE_CEPHFS: "true"|g' | kubectl apply -f -
    ```

## Usage

### Provision Block Volumes

```bash
# create storage class
kubectl create -f ./storageclass-test.yaml

# create PVC
kubectl create -f ./raw-block-pvc.yaml

# create a Pod that use the PVC
kubectl create -f ./raw-block-pod.yaml

# check the block device, dev path: /dev/xvda
kubectl exec -it pod-with-raw-block-volume -- bash
```
