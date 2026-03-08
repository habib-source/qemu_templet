# QEMU Virtual Machine Setup on Linux

This repository discrbe my personal aproech for running VMs.

## Requirements

* **Operating System:** Any modern Linux distribution.
* **Packages:**
* `qemu-system-x86` (The main emulator)
* `qemu-utils` (For disk image management)
* qemu-desktop  (For the graphical display)



To check if your CPU supports virtualization, run:

```bash
LC_ALL=C.UTF-8 lscpu | grep Virtualization

```

If not you can use tcg (emulation mode) thu it's 10 times slower!!!!

---

## Getting Started

### 1. Create a Virtual Disk

First, you need to create a `qcow2` file. This format is superior to raw images because it supports snapshots and grows dynamically (it only takes up space as you use it).

```bash
qemu-img create -f qcow2 name.qcow2 20G

```

### 2. Prepare the ISO

Ensure you have an installation ISO (e.g., Ubuntu, Arch, or Windows) downloaded and ready in your project directory.

---

## Running the VM

Save the script `qemu_templet.sh` and give it execution permissions (`chmod +x ./qemu_templet.sh`) and change what needs to be changed(qcow2 file path and iso file path ...).

### Script Options Breakdown

| Flag | Purpose |
| --- | --- |
| `-enable-kvm` | Uses the Linux Kernel-based Virtual Machine for hardware acceleration. |
| `-m 4G` | Allocates 4 Gigabytes of RAM to the guest. |
| `-smp 5` | Allocates 5 CPU cores/threads to the guest. |
| `-display sdl` | Opens the VM in an SDL window (Change to `gtk` or `-nographic` if preferred). |
| `-nic user` | Sets up a basic NAT network (Internet access without root config). |

---

## Troubleshooting

* **Permission Denied (/dev/kvm):** If you get a KVM error, add your user to the kvm group:
`sudo usermod -aG kvm $USER` (then log out and back in).
* **Performance:** Always ensure `virtio-net-pci` is used for networking and `virtio-blk` for disks if the guest OS supports it, as it significantly reduces overhead.

---
