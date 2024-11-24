# Base image
FROM node:18

# Instalar Redis
RUN apt-get update && apt-get install -y redis-server

# Criar diretório da aplicação
WORKDIR /app

# Copiar arquivos do projeto API
COPY apps/api/package*.json apps/api/pnpm-lock.yaml ./

# Instalar pnpm
RUN npm install -g pnpm

# Instalar dependências
RUN pnpm install

# Copiar o resto dos arquivos da API
COPY apps/api ./

# Expor porta
EXPOSE 3002

# Configurar comando de inicialização
RUN echo '#!/bin/bash\n\
redis-server --daemonize yes\n\
pnpm run start:production' > /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh"]