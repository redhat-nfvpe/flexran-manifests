This will contain a set of files to run functional testing on the platform.
The initial openshift-tests need to be run on installer host, with podman.
Pod will be deployed with : ```
podman play kube ./openshift-tests.yaml
```

After that you can enter into the pod and execute tests using openshift-tests binary.
