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

/* Exercicio 3 */ 
DELIMITER //
create procedure sp_ContarLivrosPorCategoria(in categoriaNome VARCHAR(100), out totalLivros INT)
begin
    select count(*) into totalLivros
    from Livro
    inner join Categoria on Livro.Categoria_ID = Categoria.Categoria_ID
    where Categoria.Nome = categoriaNome;
end //
DELIMITER ;

call sp_ContarLivrosPorCategoria('Romance', @total);
select @total;

/* Exercicio 4 */
DELIMITER //
create procedure sp_VerificarLivrosCategoria(in categoriaNome VARCHAR(100), out possuiLivros BOOLEAN)
begin
    set possuiLivros = exists (
        select 1
        from Livro
        inner join Categoria on Livro.Categoria_ID = Categoria.Categoria_ID
        where Categoria.Nome = categoriaNome
    );
end //
DELIMITER ;

call sp_VerificarLivrosCategoria('Romance', @possuiLivros);
select @possuiLivros;

/* Exercicio 5 */ 
DELIMITER //
create procedure sp_LivrosAteAno(in anoLimite INT)
begin
    select Livro.Titulo, Livro.Ano_Publicacao, Autor.Nome, Autor.Sobrenome
    from Livro
    inner join Autor_Livro on Livro.Livro_ID = Autor_Livro.Livro_ID
    inner join Autor on Autor_Livro.Autor_ID = Autor.Autor_ID
    where Livro.Ano_Publicacao <= anoLimite;
end //
DELIMITER ;

call sp_LivrosAteAno(2005);

/* Exercicio 6 */ 
DELIMITER //
create procedure sp_TitulosPorCategoria(in categoriaNome VARCHAR(100))
begin
    select Livro.Titulo
    from Livro
    inner join Categoria on Livro.Categoria_ID = Categoria.Categoria_ID
    where Categoria.Nome = categoriaNome;
end //
DELIMITER ;

call sp_TitulosPorCategoria('Romance');

/* Exercicio 7 */ 
DELIMITER //
create procedure sp_AdicionarLivro(
    in tituloLivro VARCHAR(255),
    in editoraID INT,
    in anoPublicacao INT,
    in numPaginas INT,
    in categoriaID INT
)
begin
    insert IGNORE into Livro (Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID)
    values (tituloLivro, editoraID, anoPublicacao, numPaginas, categoriaID);
    
end //
DELIMITER ;

call sp_AdicionarLivro('Novo Livro', 1, 2023, 250, 1);
