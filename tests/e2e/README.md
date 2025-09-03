### Step

1. install ska-src-clients
```shell
python3 -m pip install ska-src-clients --index-url https://gitlab.com/api/v4/groups/70683489/-/packages/pypi/simple 
```

2. stage specific data on [https://gateway.srcdev.skao.int/](https://gateway.srcdev.skao.int/)

3. run E2E test script
```shell
bash tests/e2e/cnsrc.PTF10tce.test.sh 
```

if you wanna try different fits file, you need to stage it before execute script file