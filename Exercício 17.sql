select produto, min(receita) as receita_minima from vendas group by produto order by receita_minima;
