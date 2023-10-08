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

/* Funções de Data */
create table eventos (
    data_evento DATE
);
insert into eventos (data_evento)
values ('2023-10-08'),
       ('2023-10-15'),
       ('2023-10-22'),
       ('2023-11-05');

insert into eventos (data_evento) values (NOW());

select DATEDIFF(NOW(), (select MIN(data_evento) from eventos)) as dias_diff;

select data_evento, DAYNAME(data_evento) as nome_dia_semana from eventos;

/* Funções de Controle de Fluxo */
select produto,
    case
        when quantidade > 0 then 'Em estoque'
        else 'Fora de estoque'
    end as status
from produtos;

select produto,
    case
        when preco < 50 then 'Barato'
        when preco >= 50 and preco <= 100 then 'Médio'
        else 'Caro'
    end as categoria_preco
from produtos;

/* Função Personalizada */ 
DELIMITER //
create function TOTAL_VALOR(preco DECIMAL(10, 2), quantidade INT)
returns DECIMAL(10, 2)
begin
    declare valor_total DECIMAL(10, 2);
    set valor_total = preco * quantidade;
    return valor_total;
end //
DELIMITER ;

select produto, preco, quantidade, TOTAL_VALOR(preco, quantidade) as valor_total
from produtos;
