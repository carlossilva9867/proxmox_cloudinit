# Proxmox Ubuntu Cloud-Init Template Provisioning

Automatiza a criação de um template Ubuntu Cloud-Init no Proxmox, já com qemu-guest-agent instalado e configurado. Ideal para ambientes de laboratório ou produção, permitindo clonar VMs rapidamente com Cloud-Init pronto.

## Funcionalidades

- Baixa a última Ubuntu Cloud Image oficial.  
- Customiza a imagem para instalar o qemu-guest-agent.  
- Cria a VM base no Proxmox com memória, CPU e rede configuradas.  
- Configura o Cloud-Init drive.  
- Habilita o QEMU Guest Agent.  
- Converte a VM em template, pronta para clonar.

## Pré-requisitos

- Proxmox VE instalado e funcionando.  
- Acesso root ou permissões suficientes no host.  
- Pacotes no host: `libguestfs-tools`, `wget`.

## Uso

1. Clone o repositório:
   ```bash
   git clone <URL_DO_REPOSITORIO>
   cd <PASTA_DO_REPOSITORIO>
