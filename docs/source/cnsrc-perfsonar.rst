.. _cnsrc-perfsonar:

PerfSONAR (CNSRC GitOps)
========================

This repository deploys the perfSONAR testpoint via Kustomize pulling a Helm chart. 
The development overlay lives under ``cnsrc/apps/perfsonar``.

Repository layout
-----------------

.. list-table::
   :header-rows: 1
   :widths: 35 65

   * - Path
     - Description
   * - ``cnsrc/apps/perfsonar/base/``
     - Shared Kustomization (namespace ``perfsonar``)
   * - ``cnsrc/apps/perfsonar/overlays/dev/``
     - Dev environment: Helm values, Ingress, Service patches

Helm chart
----------

.. list-table::
   :header-rows: 1
   :widths: 35 65

   * - Field
     - Value
   * - Chart name
     - ``perfsonar``
   * - Version
     - ``0.1.0`` (see ``overlays/dev/kustomization.yaml``)
   * - Repository
     - ``https://gitlab.com/api/v4/projects/62739897/packages/helm/stable``

Runtime settings (dev overlay)
-------------------------------

See ``cnsrc/apps/perfsonar/overlays/dev/values.yaml``.

- **Image**: Harbor ``harbor.cnsrc.shao.ac.cn/library/testpoint``; use the tag from that file (e.g. ``v5.1.3``).
- **serviceDNSName**: perfSONAR/pscheduler requires a **DNS hostname**, not an IP; it must match the target hostname you use for measurements with pscheduler (command-line **--dest**). In dev this is ``perfsonar.dev.cnsrc.shao.ac.cn``. Background: `pscheduler issue #1476 <https://github.com/perfsonar/pscheduler/issues/1476>`_.
- **psconfig**: On startup the PSConfig URL is read from ``psconfigUrl``. Current dev-overlay example (adjust per environment):

  .. code-block:: text

     https://perfsonar01.jc.rl.ac.uk/psconfig/psconfig-test.json
- **OWAMP UDP port range**: 8760–8770 (override in values if needed).
- **Resources**: Dev example requests 2 CPU / 2Gi, limits 4 CPU / 4Gi.

Ingress (dev)
---------------

- **Class**: ``gatekeeper-nginx``
- **Host**: ``perfsonar.dev.cnsrc.shao.ac.cn``
- **Backend protocol**: HTTPS (annotation ``nginx.ingress.kubernetes.io/backend-protocol: HTTPS``)
- **Service port**: 443

See :ref:`cnsrc-urls` for related URLs.
