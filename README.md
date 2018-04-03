# FashionStore

[![CI Status](http://img.shields.io/travis/saragiotto/FashionStore.svg?style=flat)](https://travis-ci.org/saragiotto/FashionStore)
[![codecov.io](https://codecov.io/gh/saragiotto/FashionStore/branch/master/graphs/badge.svg)](https://codecov.io/gh/saragiotto/FashionStore/branch/master)

Aplicativo simples para apresentação de catálogo de produtos e carrinho de compras.


O app mostra uma lista de produtos com nome, foto e preço. O preço promocional é apresentado se houver desconto no produto. Na foto do produto também é apresentado em destaque um indicativo em casa de desconto. Na tela principal é possível filtrar a lista somente por itens na promoção.

***

Na tela de detalhe é apresentada uma foto grande do produto, seu respectivo desconto, caso se aplique, e a cor disponível. Também é apresentado uma lista de tamanhos disponíveis para o produto. O botão de comprar no rodapé da tela adiciona o produto na sacola do cliente e apresenta a tela da sacola na sequencia.

***

A tela da Sacola pode ser acessada tanto pela tela de catalogo como pela tela de detalhe. Essa tela apresenta a lista de todos os produtos na sacalo. A cor e o tamanho selecionados no momento da compra e também a quantidade. O cliente pode alterar a quantidade de itens livremente. Na parte inferior da tela é apresentado o total dos itens na sacola, o custo de envio e o total da compra. Ao clicar em Finalizar Compra é apresentada uma mensagem de agradecimento e a sacola é envaziada.

Design pattern utilizado Model-View-ViewModel (MVVM)

##Travis CI
Utilizado Travis-CI na integração continua do projeto [![CI Status](http://img.shields.io/travis/saragiotto/FashionStore.svg?style=flat)](https://travis-ci.org/saragiotto/FashionStore)

![](https://avatars0.githubusercontent.com/u/639823?s=100&v=4)

##Code Cov 
Report de code coverage registrado no CodeCov.io [![codecov.io](https://codecov.io/gh/saragiotto/FashionStore/branch/master/graphs/badge.svg)](https://codecov.io/gh/saragiotto/FashionStore/branch/master)

![](https://avatars0.githubusercontent.com/u/8226205?s=100&v=4)

##Source Files
####Model files

```
Product.swift
ProductSize.swift
```

####ViewModel files

```ProductViewModel.swift```

####ViewController files

```
ProductViewController.swift
ProductDetailViewController.swift
```

## Lista de Produtos

![Imagem](https://raw.githubusercontent.com/saragiotto/FashionStore/master/ScreenShots/IMG_6675.PNG)

## Detalhe do Produto

![Imagem](https://raw.githubusercontent.com/saragiotto/FashionStore/master/ScreenShots/IMG_6676.PNG)

## Sacola de Compras

![Imagem](https://raw.githubusercontent.com/saragiotto/FashionStore/master/ScreenShots/IMG_6677.PNG)