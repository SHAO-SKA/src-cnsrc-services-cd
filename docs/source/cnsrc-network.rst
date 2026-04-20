cnSRC Network
=============

Temporary network tuning for interop
--------------------------------------

Both **TCP** and **UDP** temporary sysctl settings are documented below; apply the blocks that match your test traffic.

.. note::

   For testing only. These settings are temporary and will be lost after reboot.

TCP (temporary)
~~~~~~~~~~~~~~~

.. code-block:: shell

   # 1. Increase kernel core buffer limits (set to 1GB)
   sysctl -w net.core.rmem_max=1073741824
   sysctl -w net.core.wmem_max=1073741824
   sysctl -w net.core.rmem_default=1073741824
   sysctl -w net.core.wmem_default=1073741824

   # 2. TCP buffer tuning

   # TCP receive buffer (min / default / max)
   sysctl -w net.ipv4.tcp_rmem="4096 1048576 268435456"

   # TCP send buffer (min / default / max)
   sysctl -w net.ipv4.tcp_wmem="4096 1048576 268435456"

   # Enable TCP window scaling (required for high BDP links)
   sysctl -w net.ipv4.tcp_window_scaling=1

   # Enable TCP auto-tuning for receive buffer
   sysctl -w net.ipv4.tcp_moderate_rcvbuf=1

   # 2.1 Optimization

   # Set TCP congestion control algorithm (BBR is recommended for high bandwidth-delay product networks)
   sysctl -w net.ipv4.tcp_congestion_control=bbr

   # Set default queuing discipline (fq works best with BBR)
   sysctl -w net.core.default_qdisc=fq

UDP (temporary)
~~~~~~~~~~~~~~~

.. code-block:: shell

   # UDP buffer tuning (set to 1GB)
   sudo sysctl -w net.core.rmem_max=1073741824
   sudo sysctl -w net.core.wmem_max=1073741824
   sudo sysctl -w net.core.rmem_default=1073741824
   sudo sysctl -w net.core.wmem_default=1073741824

   # Minimum UDP buffer size (256 KB)
   sudo sysctl -w net.ipv4.udp_rmem_min=262144
   sudo sysctl -w net.ipv4.udp_wmem_min=262144

   # UDP memory control (safer configuration)
   sudo sysctl -w net.ipv4.udp_mem="262144 524288 1048576"