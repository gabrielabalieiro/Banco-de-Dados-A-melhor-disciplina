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
