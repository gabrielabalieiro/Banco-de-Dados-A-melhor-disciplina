/* exercicio 1 */
DELIMITER //
CREATE FUNCTION total_livros_por_genero(genero_nome VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE total INT;
    SET total = 0;
    
    DECLARE done INT DEFAULT 0;
    DECLARE genre_id INT;
    
    SELECT id INTO genre_id FROM Genero WHERE nome_genero = genero_nome;
    
    DECLARE cur CURSOR FOR
        SELECT id_genero FROM Livro;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO genre_id;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;
        IF genre_id = genre_id THEN
            SET total = total + 1;
        END IF;
    END LOOP;
    CLOSE cur;
    
    RETURN total;
END//
DELIMITER ;

SELECT total_livros_por_genero('Romance');

/*exercico 2 */
DELIMITER //
CREATE FUNCTION listar_livros_por_autor(primeiro_nome_autor VARCHAR(255), ultimo_nome_autor VARCHAR(255))
RETURNS VARCHAR(255)
BEGIN
    DECLARE lista_titulos VARCHAR(255);
    SET lista_titulos = '';
    
    DECLARE author_id INT;
    DECLARE book_id INT;
    
    SELECT id INTO author_id FROM Autor WHERE primeiro_nome = primeiro_nome_autor AND ultimo_nome = ultimo_nome_autor;
    
    DECLARE cur CURSOR FOR
        SELECT id_livro FROM Livro_Autor WHERE id_autor = author_id;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO book_id;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;
        
        SELECT CONCAT(lista_titulos, titulo) INTO lista_titulos FROM Livro WHERE id = book_id;
        SELECT CONCAT(lista_titulos, ', ') INTO lista_titulos;
    END LOOP;
    CLOSE cur;
    
    RETURN lista_titulos;
END//
DELIMITER ;

SELECT listar_livros_por_autor('João', 'Silva');

/* exercicio 3 */
DELIMITER //
CREATE FUNCTION atualizar_resumos()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE book_id INT;
    DECLARE book_resumo TEXT;
    
    DECLARE cur CURSOR FOR
        SELECT id, resumo FROM Livro;
    
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    update_loop: LOOP
        FETCH cur INTO book_id, book_resumo;
        IF done = 1 THEN
            LEAVE update_loop;
        END IF;
        
        SET book_resumo = CONCAT(book_resumo, ' Este é um excelente livro!');
        UPDATE Livro SET resumo = book_resumo WHERE id = book_id;
    END LOOP;
    CLOSE cur;
END//
DELIMITER ;

CALL atualizar_resumos();

/* exercico 4 */
DELIMITER //
CREATE FUNCTION media_livros_por_editora()
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE total_livros INT;
    DECLARE total_editoras INT;
    DECLARE avg_livros DECIMAL(10,2);
    
    SELECT COUNT(*) INTO total_livros FROM Livro;
    
    SELECT COUNT(*) INTO total_editoras FROM Editora;
    
    SET avg_livros = total_livros / total_editoras;
    
    RETURN avg_livros;
END//
DELIMITER ;

SELECT media_livros_por_editora();

/* exercicio 5 */
DELIMITER //
CREATE FUNCTION autores_sem_livros()
RETURNS VARCHAR(255)
BEGIN
    DECLARE lista_autores_sem_livros VARCHAR(255);
    SET lista_autores_sem_livros = '';
    
    DECLARE done INT DEFAULT 0;
    DECLARE author_id INT;
    
    DECLARE cur CURSOR FOR
        SELECT id FROM Autor;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    check_loop: LOOP
        FETCH cur INTO author_id;
        IF done = 1 THEN
            LEAVE check_loop;
        END IF;
        
        IF NOT EXISTS (SELECT 1 FROM Livro_Autor WHERE id_autor = author_id) THEN
            SELECT CONCAT(lista_autores_sem_livros, primeiro_nome, ' ', ultimo_nome) INTO lista_autores_sem_livros FROM Autor WHERE id = author_id;
            SELECT CONCAT(lista_autores_sem_livros, ', ') INTO lista_autores_sem_livros;
        END IF;
    END LOOP;
    CLOSE cur;
    
    RETURN lista_autores_sem_livros;
END//
DELIMITER ;

SELECT autores_sem_livros();
