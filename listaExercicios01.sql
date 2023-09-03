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

/* Exercicio 7 */ 
select curso, COUNT(aluno_id) as total_alunos
from matriculas
group by curso;

/* Exercicio 8 */ 
select produto, AVG(receita) as receita_media
from vendas
group by produto;

/* Exercicio 9 */
select produto, SUM(receita) as receita_total
from vendas
group by produto
having SUM(receita) > 10000.00;

/* Exercicio 10 */
select autores.nome as autor, COUNT(livros.id) as numero_de_livros
from autores
left join livros on autores.id = livros.autor_id
group by autores.nome
having COUNT(livros.id) > 2;

/* Exercicio 11 */
select livros.titulo as livro, autores.nome as autor
from livros
inner join autores on livros.autor_id = autores.id;

/* Exercicio 12 */ 
select alunos.nome as aluno, matriculas.curso
from alunos
inner join matriculas on alunos.id = matriculas.aluno_id;

/* Exercico 13 */
select autores.nome as autor, livros.titulo
from autores
left join livros on autores.id = livros.autor_id;

/* Exercicio 14 */ 
select matriculas.curso, alunos.nome as aluno
from matriculas
right join alunos on matriculas.aluno_id = alunos.id;

/* Exercicio 15 */
select alunos.nome as aluno, matriculas.curso
from alunos
inner join matriculas on alunos.id = matriculas.aluno_id;

/* Exercicio 16 */
select autores.nome as autor, COUNT(livros.id) as numero_de_livros
from autores
left join livros on autores.id = livros.autor_id
group by autores.nome
order by  numero_de_livros desc
limit 1;

/* Exercicio 17 */
select produto, SUM(receita) as receita_total
from vendas
group by produto
order by receita_total asc
limit 1;