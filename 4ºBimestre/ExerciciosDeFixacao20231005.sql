--Estava com dificuldades em utilizar o "create function" então com a procedure parecia funcionar melhor. Consultei outros colegas e disseram que fizeram assim também.

--Exercício 1
delimiter $$
create procedure total_livros_por_genero(nome_genero_param varchar(255), out tot_livro_genero int)
begin
	declare done_loop int default 0;
    declare id_livro_genero int;
    declare cursor_livros cursor for select genero.id 
    from genero 
    inner join livro on livro.id_genero = genero.id 
    where nome_genero = nome_genero_param;
    declare continue handler for not found set done_loop = 1;
    set tot_livro_genero = 0;
	open cursor_livros;
    while(done_loop != 1) do
		fetch cursor_livros into id_livro_genero;
		set tot_livro_genero = tot_livro_genero + 1;
        if done_loop != 0 then
			set tot_livro_genero = tot_livro_genero - 1;
        end if;
    end while;
    close cursor_livros;
end;
$$
delimiter ;
call total_livros_por_genero('História',@liv_gen);
select @liv_gen;

--Exercício 2
delimiter $$
create procedure listar_livros_por_autor(primeiro_nome_param varchar(255), ultimo_nome_param varchar(255))
begin
	declare done_loop int default 0;
    declare id_autor_var int;
    declare id_autor_cursor_var int;
    declare id_livro_var int;
    declare titulo_livro varchar(255);
    declare cursor_livros_autor cursor for select id_autor, id_livro from livro_autor;
    declare continue handler for not found set done_loop = 1;
    create temporary table if not exists temp_tabela (titulo_livro VARCHAR(255));
    select id into id_autor_var from autor where primeiro_nome = primeiro_nome_param and ultimo_nome = ultimo_nome_param;
    open cursor_livros_autor;
    while(done_loop != 1) do
		fetch cursor_livros_autor into id_autor_cursor_var, id_livro_var;
		 if id_autor_var = id_autor_cursor_var then
			select titulo into titulo_livro from livro where id = id_livro_var;
			insert into temp_tabela values(titulo_livro);
        end if;
    end while;
    close cursor_livros_autor;
    select * from temp_tabela;
end;
$$
delimiter ;
call listar_livros_por_autor ('Bruno','Machado');

--Exercício 3
delimiter $$ 
create procedure atualizar_resumos()
begin
	declare done_loop int default 0;
    declare id_livro_cursor int;
    declare resumo_liv text;
    declare cursor_resumos_livros cursor for select id, resumo from livro;
    declare continue handler for not found set done_loop = 1;
    open cursor_resumos_livros;
    while(done_loop != 1)do
		fetch cursor_resumos_livros into id_livro_cursor, resumo_liv;
        update livro set resumo = concat(resumo_liv, " Este é um excelente livro!") where id = id_livro_cursor;
    end while;
    close cursor_resumos_livros;
    select resumo from livro;
end;
$$
delimiter ;
call atualizar_resumos();

--Exercício 4
delimiter $$
create procedure media_livros_por_editora()
begin
	declare done_loop int default 0;
    declare id_editora_var int;
    declare total_editora_var int default 0;
    declare total_livros int default 0;
    declare livro_editora int;
    declare cursor_id_editora cursor for select id from editora;
    declare continue handler for not found set done_loop = 1;
    open cursor_id_editora;
    while(done_loop != 1)do
		fetch cursor_id_editora into id_editora_var;
        set total_editora_var = total_editora_var + 1;
        select count(livro.id) into livro_editora from livro inner join editora on livro.id_editora = editora.id where id_editora = id_editora_var;
        set total_livros = total_livros + livro_editora;
        if done_loop != 0 then
			set total_livros = total_livros - livro_editora;
            set total_editora_var = total_editora_var - 1;
			select round(total_livros/total_editora_var, 2);
            end if;
    end while;
    close cursor_id_editora;
end;
$$
delimiter ;
call media_livros_por_editora();

--Exercício 5
delimiter $$
create procedure autores_sem_livros ()
begin
	declare done_loop int default 0;
    declare id_autor_var int;
    declare livro_var int;
    declare primeiro_nome_var varchar(255);
    declare ultimo_nome_var varchar(255);
    declare cursor_id_autor cursor for select id from autor;
    declare continue handler for not found set done_loop = 1;
    create temporary table if not exists temp_tabela (primeiro_nome varchar(255) default "Todos os autores possuem livros", ultimo_nome VARCHAR(255));
    open cursor_id_autor;
    while(done_loop != 1)do
		fetch cursor_id_autor into id_autor_var;
        select count(id_livro) into livro_var from livro_autor where id_autor = id_autor_var;
        if livro_var <=> 0 then
			select primeiro_nome, ultimo_nome into primeiro_nome_var, ultimo_nome_var from autor where id = id_autor_var;
			if not exists(select primeiro_nome, ultimo_nome from temp_tabela where primeiro_nome = primeiro_nome_var and ultimo_nome = ultimo_nome_var)
            then 
				insert into temp_tabela values(primeiro_nome_var, ultimo_nome_var);
            end if;
        end if;
    end while;
    close cursor_id_autor;
    select * from temp_tabela;
end;
$$
delimiter ;
call autores_sem_livros ();