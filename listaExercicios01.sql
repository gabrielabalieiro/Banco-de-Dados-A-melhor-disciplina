/*Exercicio 1*/
select titulo from livros;

/* Exercicio 2 */
SELECT nome
FROM autores
WHERE nascimento < '1900-01-01';

/* Exercicio 3 */
select titulo 
from livros
inner join autores on livros.autor_id = autores.id
where autores.nome = 'J.K. Rowling';

/* Exercicio 4 */
select nome
from alunos 
inner join matriculas on alunos.id = matriculas.aluno_id
where matriculas.curso = 'Engenharia de Software';

/* Execicio 5 */
select produto, SUM(receita) as receita_total
from vendas
group by produto;

/* Exercicio 6*/
select autores.nome as autor, COUNT(livros.id) as numero_de_livros
from autores
left join livros on autores.id = livros.autor_id
group by autores.nome;