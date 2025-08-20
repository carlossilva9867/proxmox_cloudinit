#!/bin/bash
# Script de provisionamento Proxmox com Ubuntu Cloud-Init 0.1
# Criado por Carlos Silva

set -e  # para o script se der erro em algum comando

VMID=9000
VMNAME="ubuntu-template"
MEMORY=2048
CORES=2
BRIDGE="vmbr0"
IMG="noble-server-cloudimg-amd64.img"
IMG_URL="https://cloud-images.ubuntu.com/noble/current/${IMG}"
ISO_PATH="/var/lib/vz/template/iso"
STORAGE="local"

echo "[INFO] Instalando pacotes necessários..."
apt update && apt install -y libguestfs-tools wget

echo "[INFO] Baixando imagem Ubuntu Cloud..."
mkdir -p $ISO_PATH
cd $ISO_PATH
wget -N $IMG_URL

echo "[INFO] Customizando imagem para instalar qemu-guest-agent..."
virt-customize -a $IMG --install qemu-guest-agent --run-command 'systemctl enable qemu-guest-agent'

echo "[INFO] Criando VM base..."
qm create $VMID --name $VMNAME --memory $MEMORY --cores $CORES --net0 virtio,bridge=$BRIDGE

echo "[INFO] Importando disco para storage $STORAGE..."
qm importdisk $VMID $IMG $STORAGE

echo "[INFO] Configurando VM..."
qm set $VMID --scsihw virtio-scsi-pci --scsi0 $STORAGE:vm-$VMID-disk-0
qm set $VMID --ide2 $STORAGE:cloudinit
qm set $VMID --boot c --bootdisk scsi0
qm set $VMID --agent enabled=1

echo "[INFO] Convertendo VM para template..."
qm template $VMID

echo "[SUCCESS] Template $VMNAME (ID $VMID) criado com sucesso!"
