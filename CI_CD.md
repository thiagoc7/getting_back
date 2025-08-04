# CI/CD Setup

Este projeto está configurado com CI/CD completo usando GitHub Actions e Render.

## 🚀 CI (GitHub Actions)

O CI roda automaticamente em:
- Pull Requests
- Push para `main` e `develop`

### Jobs do CI:

1. **Security Scan** (`scan_ruby`)
   - Usa Brakeman para análise estática de segurança
   - Verifica vulnerabilidades comuns do Rails

2. **Linting** (`lint`)
   - Usa RuboCop para verificar estilo de código
   - Garante consistência no código

3. **Tests** (`test`)
   - **Unit Tests**: Testes de modelos e controllers
   - **Integration Tests**: Testes de API e rotas
   - **System Tests**: Testes end-to-end com Selenium
   - **Database**: SQLite para development e test

### System Tests no CI:

- Chrome/ChromeDriver instalado automaticamente
- Screenshots salvos em caso de falha
- SQLite como banco de teste
- Execução em modo headless

## 🚀 CD (Render)

### Deploy Automático:

- **Trigger**: Após CI passar com sucesso
- **Branch**: `main`
- **Database**: PostgreSQL gerenciado pelo Render
- **Environment**: Production

### Configuração:

O arquivo `render.yaml` define:
- **Build Command**: `npm install && bundle install && bundle exec rails assets:precompile`
- **Start Command**: `bundle exec rails server -p $PORT -e production`
- **Database**: PostgreSQL automático
- **Environment Variables**: Configuradas no Render

## 🔧 Configuração Local

### Para rodar os testes localmente:

```bash
# Instalar dependências
bundle install

# Setup do banco
bin/rails db:create
bin/rails db:migrate

# Rodar testes
bundle exec rails test
bundle exec rails test:system
```

### Para desenvolvimento:

```bash
# SQLite é usado por padrão em development e test
# Não precisa de configuração adicional

# Para usar PostgreSQL local (opcional):
# export POSTGRES_USER=postgres
# export POSTGRES_PASSWORD=postgres
# export POSTGRES_HOST=localhost
# export POSTGRES_PORT=5432
# Editar config/database.yml para usar postgresql
```

## 📊 Monitoramento

### Screenshots de Falhas:
- Salvos automaticamente em `tmp/screenshots/`
- Upload como artifacts no GitHub Actions
- Disponíveis para download em caso de falha

### Logs:
- GitHub Actions: Disponível na aba "Actions"
- Render: Disponível no dashboard do Render

## 🔄 Workflow

1. **Desenvolvimento**: Código no branch feature
2. **Pull Request**: CI roda automaticamente
3. **Review**: Aprovado pelos maintainers
4. **Merge**: Para `main`
5. **Deploy**: Automático no Render

## 🛠️ Troubleshooting

### CI falhando:
- Verificar logs no GitHub Actions
- Baixar screenshots para debug
- Verificar se todos os testes passam localmente

### Deploy falhando:
- Verificar logs no Render
- Verificar variáveis de ambiente
- Verificar se o CI passou

### System Tests falhando:
- Verificar se Chrome/ChromeDriver está instalado
- Verificar se SQLite está funcionando
- Verificar seletores nos testes 