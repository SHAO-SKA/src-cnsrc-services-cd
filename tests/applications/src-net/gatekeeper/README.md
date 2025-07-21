## Inference
- https://ska-telescope.gitlab.io/src/kb/ska-src-docs-operator/services/local/mandatory/authorization/gatekeeper.html#testing
- https://gitlab.com/ska-telescope/src/src-service-apis/ska-src-clients

## Prerequisites
- [SKA SRC Client](https://gitlab.com/ska-telescope/src/src-service-apis/ska-src-clients) Binary has been installed
- [Gatekeeper](https://ska-telescope.gitlab.io/src/kb/ska-src-docs-operator/services/local/mandatory/authorization/gatekeeper.html) service is up

## Running the Connectivity Test
Gatekeeper is an nginx reverse proxy that acts as a protected access point for firewalled compute services by first authorising requests via the Permissions API.

### Environment Variables Setup
Set the environment variable "SKA_TOKEN". 
```bash
srcnet-oper token request

srcnet-oper token get authn-api

export SKA_TOKEN=xxxx.xxx
```

### Running the Connectivity Test

Using the docker command directly against the remote image
```bash
curl -XGET https://gatekeeper.ska.zverse.space/ping -H "Authorization: Bearer $SKA_TOKEN" 

curl -XGET https://gatekeeper.ska.zverse.space/services -H "Authorization: Bearer $SKA_TOKEN" 

curl -XGET https://gatekeeper.ska.zverse.space/echo?hello=world -H "Authorization: Bearer $SKA_TOKEN" 
```

## Test History
### ska132
- 2025-07-21: [step1.png](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/gatekeeper/test-history/ska132-20250721/step1.png), [step2.png](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/gatekeeper/test-history/ska132-20250721/step2.png), [step3.png](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/gatekeeper/test-history/ska132-20250721/step3.png), [step4.png](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/gatekeeper/test-history/ska132-20250721/step4.png), [step5.png](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/gatekeeper/test-history/ska132-20250721/step5.png), [result1.png](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/gatekeeper/test-history/ska132-20250721/result1.png), [result2.png](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/gatekeeper/test-history/ska132-20250721/result2.png), [result3.png](https://gitlab.com/AaronYang2333/ska-src-cnsrc-services-cd/-/raw/main/tests/applications/src-net/gatekeeper/test-history/ska132-20250721/result3.png)