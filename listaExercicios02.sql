/* Exercicio 1*/
DELIMITER //
create procedure sp_ListarAutores()
begin
    select * from Autor;
end //
DELIMITER ;

call sp_ListarAutores();
