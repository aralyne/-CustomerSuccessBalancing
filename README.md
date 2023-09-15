
## Projeto: Customer Success Balancing

[![Run tests](https://github.com/aralyne/-CustomerSuccessBalancing/actions/workflows/main.yml/badge.svg)](https://github.com/aralyne/-CustomerSuccessBalancing/actions/workflows/main.yml)


Este projeto visa equilibrar a distribuição de clientes entre os Customer Success (CS) disponíveis, garantindo que os clientes sejam atendidos pelo CS mais apto, com base em uma pontuação de experiência.

### Descrição do Problema:

Cada CS tem uma pontuação representando sua experiência, e cada cliente também tem uma pontuação que representa o tamanho de sua empresa. O objetivo é alocar o máximo de clientes a cada CS sem exceder a capacidade do CS e garantir que o cliente seja atendido por um CS que tenha, pelo menos, a mesma pontuação que a empresa.

### Solução:

1. **Filtragem de CS Ativos**: Primeiro, removemos os CSs que não estão disponíveis. Esta etapa é realizada usando uma estrutura de dados `Set` para eficiência.

2. **Ordenação por Pontuação**: Tanto os CSs quanto os clientes são ordenados com base em suas pontuações. Isso nos permite alocar clientes a CSs de maneira eficiente.

3. **Alocação de Clientes a CSs**: Usando uma abordagem de dois ponteiros, percorremos os arrays de clientes e CSs para fazer a alocação. A ideia é associar cada cliente ao CS mais qualificado disponível, atualizando um contador de clientes por CS.

4. **Determinação do CS com Maior Carga**: Por fim, identificamos o CS que atende ao maior número de clientes. Em caso de empate, não retornamos nenhum CS específico (representado por 0).

### Conceitos Aplicados:

1. **Clean Code**: O código é estruturado em funções claras e concisas, cada uma realizando uma tarefa específica. Isso não só torna o código mais legível, mas também facilita a manutenção e a depuração.

2. **Otimização de Complexidade**: Consideramos a complexidade tanto em termos de tempo quanto de espaço. O uso de estruturas de dados adequadas, como `Set`, e algoritmos otimizados, como busca com dois ponteiros, nos permite lidar eficientemente com grandes volumes de dados.

3. **Testes Unitários**: Para garantir a corretude da solução, são fornecidos testes unitários que cobrem diferentes cenários, desde os mais simples até testes de estresse com grandes volumes de dados.

---

Para iniciar o projeto, execute os testes usando o comando:

```bash
rails test test/customer_success_balancing_test.rb
```
