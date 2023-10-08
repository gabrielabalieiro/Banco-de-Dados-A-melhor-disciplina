/* Funções de String */ 
create table nomes (
    nome VARCHAR(50)
);

insert into nomes (nome) values
    ('Roberta'),
    ('Roberto'),
    ('Maria Clara'),
    ('João');

select UPPER(nome) from nomes;

select nome, LENGTH(nome) as tamanho from nomes;

select
    case
        when nome like '%Maria%' then CONCAT('Sra. ', nome)
        else CONCAT('Sr. ', nome)
    end as nome_formatado
from nomes;


/* Funções Numéricas */
create table produtos (
    produto VARCHAR(50),
    preco DECIMAL(10, 2),
    quantidade INT
);
insert into produtos (produto, preco, quantidade)
values ('Produto 1', 19.99, 100),
       ('Produto 2', 29.99, 75),
       ('Produto 3', 9.99, 150);

select produto, ROUND(preco, 2) as preco_arredondado from produtos;

select produto, ABS(quantidade) as quantidade_absoluta from produtos;

select AVG(preco) as media_preco from produtos;

