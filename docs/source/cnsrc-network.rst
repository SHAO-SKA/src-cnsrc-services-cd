cnSRC Network
=============

Temporary network tuning for JPSRC interop (SOG-536)
-----------------------------------------------------

.. note::

   For testing only. These settings are temporary and will be lost after reboot.

.. code-block:: shell

   # 1. Increase kernel core buffer limits (set to 1GB)
   sysctl -w net.core.rmem_max=1073741824
   sysctl -w net.core.wmem_max=1073741824
   sysctl -w net.core.rmem_default=1073741824
   sysctl -w net.core.wmem_default=1073741824

   # 2. UDP buffer tuning (set to 1GB)
   sudo sysctl -w net.core.rmem_max=1073741824
   sudo sysctl -w net.core.wmem_max=1073741824

   # Minimum UDP buffer size (256 KB)
   sudo sysctl -w net.ipv4.udp_rmem_min=262144
   sudo sysctl -w net.ipv4.udp_wmem_min=262144

   # UDP memory control (safer configuration)
   sudo sysctl -w net.ipv4.udp_mem="262144 524288 1048576"
