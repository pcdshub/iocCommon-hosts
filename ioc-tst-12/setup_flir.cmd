#!/bin/sh


rm -rf /tmp/udev_rules_flir
mkdir /tmp/udev_rules_flir

umount /etc/udev/rules.d || /bin/true
cp -r /etc/udev/rules.d/* /tmp/udev_rules_flir/.

echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="2000", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="2001", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="2002", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="2003", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="2004", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="2005", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3000", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3001", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3004", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3005", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3006", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3007", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3008", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="300A", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="300B", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3100", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3101", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3102", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3103", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3104", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3105", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3106", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3107", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3108", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3109", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'ATTRS{idVendor}=="1e10", ATTRS{idProduct}=="3300", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'KERNEL=="raw1394", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'KERNEL=="video1394*", MODE="0664", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'SUBSYSTEM=="firewire", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules
echo 'SUBSYSTEM=="usb", GROUP="ps-ioc"' >> /tmp/udev_rules_flir/40-flir.rules

mount --bind /tmp/udev_rules_flir /etc/udev/rules.d

udevadm control --reload-rules && udevadm trigger

## Set USBFS limits higher to work with higher-resolution cameras
sh -c 'echo 1000 > /sys/module/usbcore/parameters/usbfs_memory_mb'
