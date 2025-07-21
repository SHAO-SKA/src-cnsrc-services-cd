## Inference
- https://ska-telescope.gitlab.io/src/kb/ska-src-docs-operator/services/local/mandatory/rucio-storage-element/rucio-storage-element.html#testing
- https://gitlab.com/ska-telescope/src/operations/ska-src-operator-toolbox

## Prerequisites
- A Rucio account

## Running the Connectivity Test
xrootd is a RSE(Rucio Storage Element).Before requesting that the RSE be integrated into the datalake, a precursor connectivity test should be undertaken. This checks for common faults that will cause problems during integration.  
the operator toolbox can be used to check the connectivity of storage endpoints.

### Environment Variables Setup
Set the environment variable "RUCIO_CFG_CLIENT_ACCOUNT". RUCIO_CFG_CLIENT_ACCOUNT is the name of your Rucio account
```bash
export RUCIO_CFG_CLIENT_ACCOUNT=shaoguang

```

### Running the Connectivity Test

Using the docker command directly against the remote image
```bash
docker run -it --rm -e RUCIO_CFG_CLIENT_ACCOUNT=$RUCIO_CFG_CLIENT_ACCOUNT registry.gitlab.com/ska-telescope/src/operations/ska-src-operator-toolbox:release-35.6.0 "report_rse_connectivity"

```
**Execution Workflow**  
1. Authentication Process:
  - The container will display an authentication URL (e.g., https://rucio.srcnet.skao.int/auth/oidc_redirect?P0QaFcDccXAF9Ojw86wVqhM)
  - Open this URL in a browser and complete authentication
  - Copy the returned code and paste it into the terminal
2. Parameter Input:
    ```
    ucio account name [shaoguang]:  # Press Enter for default or enter new value
    Endpoint URL []: https://xrootd.ska.zverse.space:443/data  # Enter endpoint URL
    RSE []: STFC_STORM  # Enter RSE name
    Enable debug mode (y/n) [n]: y  # Enable debug output
    Enable port check (y/n) [y]: y  # Enable port connectivity check
    Enable SSL check (y/n) [y]: y  # Enable SSL certificate verification
    Enable gfal check (y/n) [y]: y  # Enable gfal-based checks
    Enable Davix check (y/n) [n]: y  # Enable Davix checks
    Enable XRD check (y/n) [n]: y  # Enable XRD protocol checks
    Enable Rucio check (y/n) [n]: y  # Enable Rucio integration checks
    ```
3. Results Review:
- The tool will execute all enabled checks and display results
- Debug mode (ENABLE_DEBUG=y) will show detailed command execution