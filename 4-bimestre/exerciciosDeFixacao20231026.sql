CREATE TRIGGER  insere_cliente_auditoria
AFTER INSERT ON Clientes
FOR EACH ROW
    INSERT INTO Auditoria (mensagem)
    VALUES ('Novo cliente inserido em '));
    
CREATE TRIGGER deleta_cliente_auditoria
BEFORE DELETE ON Clientes
FOR EACH ROW
	INSERT INTO Auditoria (mensagem)
    VALUES ('exclusão do cliente ' + OLD.nome);
    
CREATE TRIGGER atualiza_cliente_auditoria
AFTER UPDATE ON Clientes
FOR EACH ROW 
	INSERT INTO Auditoria (mensagem)
        VALUES ('Nome do cliente ' + OLD.nome + ' atualizado para ' + NEW.nome);

CREATE TRIGGER atualiza_nome_cliente_auditoria
BEFORE UPDATE ON Clientes
FOR EACH ROW
delimiter //
    IF NEW.nome = NULL OR NEW.nome='' THEN
		INSERT INTO Auditoria(mensagem, data_hora)
        values ('Há uma tentiva de atulização de cliente para nulo');

	END IF //
delimiter ;
/*PROFESSOR  NÃO SEI OQUE ESTÁ DANDO ERRO DE SINTAXE  no (if)E NÃO SEI COMO ARRUMAR PROCUREI EN TODOS OS LUGARES E ELES TEM A MESMA SOLUÇÃO Q ESTÁ AI*/

CREATE TRIGGER novo_pedido_auditoria_estoque
AFTER INSERT ON Pedidos
FOR EACH ROW
    UPDATE Produtos SET estoque = estoque - NEW.quantidade WHERE id = NEW.produto_id;
delimiter //
    IF (SELECT estoque FROM Produtos WHERE id = NEW.produto_id) < 5 THEN
        INSERT INTO Auditoria (mensagem)
        VALUES ('Estoque baixo para o produto com ID ' + NEW.produto_id);
    END IF //
    delimiter ;
