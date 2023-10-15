DECLARE v_autor_nome VARCHAR(255);
DECLARE v_livro_titulo VARCHAR(255);


DECLARE cursor_autores_livros CURSOR FOR
SELECT A.nome AS autor_nome, L.titulo AS livro_titulo
FROM Autor A
JOIN Livro_Autor LA ON A.id_autor = LA.id_autor
JOIN Livro L ON LA.id_livro = L.id_livro;

OPEN cursor_autores_livros;

fetch_loop: LOOP
    FETCH cursor_autores_livros INTO v_autor_nome, v_livro_titulo;

    IF done THEN
        LEAVE fetch_loop;
    END IF;

       SELECT CONCAT('Autor: ', v_autor_nome, ', Livro: ', v_livro_titulo) AS resultado;

END LOOP fetch_loop;


CLOSE cursor_autores_livros;
