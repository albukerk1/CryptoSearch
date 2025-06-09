# CryptoSearch – App de Cotação de Criptomoedas

Este é um aplicativo desenvolvido em Flutter que exibe uma lista de cotações de criptomoedas consumindo a API da **CoinMarketCap**. O projeto segue as boas práticas de desenvolvimento e utiliza a arquitetura **MVVM** (Model-View-ViewModel) para uma organização clara e escalável do código.

---

## 🏛️ Arquitetura do Projeto

O aplicativo foi estruturado seguindo o padrão **MVVM**, dividindo as responsabilidades da seguinte forma:

-   **UI (View)**: Camada responsável pela exibição dos dados e interação com o usuário. É composta pelas telas e widgets do Flutter.
-   **ViewModel**: Atua como um *State Manager*, contendo a lógica da interface do usuário, gerenciando os estados (como carregamento, sucesso e erro) e preparando os dados para a View.
-   **Repository**: Responsável por abstrair a origem dos dados. Ele se comunica com o `DataSource` para obter as informações e as entrega para o `ViewModel` em formato de Entidades.
-   **DataSource**: A camada de comunicação direta com a API da CoinMarketCap. Realiza as chamadas HTTP e trata as respostas.

---

## ✨ Funcionalidades

O aplicativo implementa os seguintes requisitos:

-   **Listagem de Criptomoedas**: Exibe uma lista de moedas com sua sigla, nome e cotação em USD e BRL.
-   **Atualização de Dados**: Permite atualizar as informações através de um botão de "requisitar" e da funcionalidade *pull-to-refresh* (puxar para atualizar).
-   **Indicador de Carregamento**: Mostra um indicador visual (`Processing Indicator`) sempre que uma busca por dados está em andamento.
-   **Busca Múltipla**: Um campo de pesquisa permite buscar múltiplas criptomoedas simultaneamente, separando suas siglas por vírgula (ex: `BTC,ETH,SOL`).
-   **Valores Padrão**: Caso nenhuma criptomoeda seja pesquisada, o app busca uma lista pré-definida de moedas, incluindo BTC, ETH, SOL, ADA, entre outras.
-   **Tela de Detalhes**: Ao clicar em uma criptomoeda da lista, uma página é exibida com informações adicionais, como nome, símbolo, data de adição e preços formatados.

---

## 🚀 Como Executar o Projeto

Siga os passos abaixo para configurar e executar o aplicativo em sua máquina local.

### **Pré-requisitos**

-   Ter o **Flutter SDK** instalado.
-   Uma IDE configurada para o desenvolvimento com Flutter (VS Code ou Android Studio).
-   Uma conta no site da **[CoinMarketCap API](https://pro.coinmarketcap.com/signup)** para obter uma chave de API.

### **Passo 1: Obter a API Key**

1.  Acesse **[https://pro.coinmarketcap.com/signup](https://pro.coinmarketcap.com/signup)** e crie uma conta (o plano gratuito é suficiente).
2.  Após o login, navegue até o seu *dashboard* e copie a sua **API Key**.

### **Passo 2: Clonar e Configurar o Projeto**

1.  Clone este repositório para a sua máquina:
    ```bash
    git clone https://github.com/albukerk1/CryptoSearch.git
    cd CryptoSearch
    ```

2.  Abra o projeto na sua IDE e navegue até o arquivo:
    `lib/core/library/constants.dart`

3.  Cole a sua API Key na variável `X-CMC_PRO_API_KEY`:
    ```dart
    // lib/core/library/service/http_service.dart

    // (...)
    Future<void> _changeDioOptionsAsync() async {
    _dio.options.headers.clear();
    _dio.options.headers.addAll({
      'X-CMC_PRO_API_KEY': 'SUA_CHAVE_API_AQUI',
      });
    }
    // (...)
    ```

### **Passo 3: Instalar Dependências e Executar**

1.  Pelo terminal, na raiz do projeto, instale as dependências:
    ```bash
    flutter pub get
    ```

2.  Conecte um emulador ou dispositivo físico e execute o aplicativo:
    ```bash
    flutter run
    ```

Pronto! O aplicativo deverá ser compilado e executado.
