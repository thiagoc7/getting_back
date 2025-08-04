# System Tests com Selenium

Este projeto está configurado para rodar system tests usando Selenium com Chrome/Chromium headless.

## Configuração

O ambiente de desenvolvimento já está configurado com:
- Chromium (navegador)
- ChromeDriver (driver para Selenium)
- Xvfb (servidor X virtual para headless)

## Como rodar os system tests

### Rodar todos os system tests
```bash
bundle exec rails test:system
```

### Rodar um arquivo específico de system test
```bash
bundle exec rails test test/system/books_test.rb
```

### Rodar um teste específico
```bash
bundle exec rails test test/system/books_test.rb:26
```

## Configuração do Selenium

O projeto usa a seguinte configuração em `test/application_system_test_case.rb`:

```ruby
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
end
```

## Troubleshooting

### Se os testes não rodarem
1. Verifique se o Chromium está instalado:
   ```bash
   chromium --version
   ```

2. Verifique se o ChromeDriver está instalado:
   ```bash
   chromedriver --version
   ```

3. Se necessário, reinstale as dependências:
   ```bash
   sudo apt-get update && sudo apt-get install -y chromium chromium-driver xvfb
   ```

### Screenshots de falhas
Quando um teste falha, um screenshot é automaticamente salvo em `tmp/screenshots/` para ajudar no debug.

## Dicas para escrever system tests

1. Use seletores específicos para evitar ambiguidade
2. Aguarde elementos aparecerem antes de interagir com eles
3. Use `find` com `wait` para elementos que podem demorar para carregar
4. Teste o comportamento real do usuário, não apenas a presença de elementos

## Exemplo de system test

```ruby
require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  test "user can create a new book" do
    visit books_path
    click_on "New Book"
    
    fill_in "Title", with: "My New Book"
    fill_in "Author", with: "John Doe"
    click_on "Create Book"
    
    assert_text "Book was successfully created"
  end
end
``` 