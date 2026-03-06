#!/bin/bash
exec qemu-system-x86_64 \
	# if your CPU support virtualization (VT-x for Intel processors and AMD-V for AMD processors)
	-enable-kvm -cpu host \
	# if not
	# -accel tcg, thread=multi -cpu max \
	-cdrom ./path/to_your.iso \
	-drive file=./path/to_your_Virtual_disk.qcow2,format=qcow2 \
	-boot menu=on \
	-m 4G \
        -smp 5 \
        -name "Your vm name" \
	# For GUI:
	-display sdl \ # or gtk
	# or for no gui or if you want to use VNC
	# -nographic \
	# for internet:
	-nic user, model=virtio-net-pci,mac=02:00:00:00:00:01 \
	# for using a bridge:
        # -nic bridge,br=br0,model=e1000,mac=02:00:00:00:00:01 \
        $@
