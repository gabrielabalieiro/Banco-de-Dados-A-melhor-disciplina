/* Exercicio 1*/
DELIMITER //
create procedure sp_ListarAutores()
begin
    select * from Autor;
end //
DELIMITER ;

call sp_ListarAutores();

/* Exercicio 2 */
DELIMITER //
create procedure sp_LivrosPorCategoria(in categoriaNome VARCHAR(100))
begin
    select Livro.Titulo, Autor.Nome, Autor.Sobrenome
    from Livro
    inner join Categoria on Livro.Categoria_ID = Categoria.Categoria_ID
    inner join Autor_Livro on Livro.Livro_ID = Autor_Livro.Livro_ID
    inner join Autor on Autor_Livro.Autor_ID = Autor.Autor_ID
    where Categoria.Nome = categoriaNome;
end //
DELIMITER ;

call sp_LivrosPorCategoria('Ciência');
call sp_LivrosPorCategoria('Autoajuda');

