create trigger after_novo_cliente
	after insert on Clientes
    for each row 
insert into Auditoria (mensagem) values ('Cliente adicionado');
select * from Auditoria
