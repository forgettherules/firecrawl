# Base image
FROM node:18

# Instalar Redis
RUN apt-get update && apt-get install -y redis-server

# Criar diretório da aplicação
WORKDIR /app

# Copiar package.json e pnpm-lock.yaml
COPY package*.json pnpm-lock.yaml ./

# Instalar pnpm
RUN npm install -g pnpm

# Instalar dependências
RUN pnpm install

# Copiar o resto dos arquivos
COPY . .

# Expor porta
EXPOSE 3002

# Script de inicialização
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]