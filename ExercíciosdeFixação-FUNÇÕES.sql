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

/* Funções de Agregação */ 
select count(*) as total_de_produtos from produtos;

select produto, preco from produtos
where preco = (select MAX(preco) from produtos);

select produto, preco from produtos
where preco = (select MIN(preco) from produtos);

select SUM(if(quantidade > 0, preco * quantidade, 0)) as total_em_estoque
from produtos;

/* Criando funções */ 
DELIMITER //
create function FATORIAL(n INT)
returns INT
begin
    if n <= 1 then
        return 1;
    else
        return n * FATORIAL(n - 1);
    end if;
end;
//
DELIMITER ;

DELIMITER //
create function F_EXPONENCIAL(base INT, expoente INT)
returns INT
begin
    declare resultado INT;
    set resultado = 1;
    while expoente > 0 do
        set resultado = resultado * base;
        set expoente = expoente - 1;
    end while;
    return resultado;
end;
//
DELIMITER ;

DELIMITER //
create function E_PALINDROMO(palavra VARCHAR(50))
returns INT
begin
    declare tamanho INT;
    declare i INT;
    declare reversa VARCHAR(50);
    
    set tamanho = LENGTH(palavra);
    set i = tamanho;
    set reversa = '';
    
    while i > 0 do
        set reversa = CONCAT(reversa, SUBSTRING(palavra, i, 1));
        set i = i - 1;
    end while;
    
    if palavra = reversa then
        return 1;
    else
        return 0;
    end if;
end;
//
DELIMITER ;
