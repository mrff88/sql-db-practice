SELECT * FROM apostatadores;

SELECT COUNT(*) as 'número de partidos' FROM partidos;
 

-- RETO
SELECT a2.name, COUNT(ma.apostador_id) AS aciertos FROM apostatadores a2 
	JOIN marcador_apostado ma ON a2.apostador_id = ma.apostador_id 
	JOIN apuestas a ON ma.apostador_id = a.apostador_id AND ma.partido_id = a.partido_id
	JOIN partidos p ON a.partido_id = p.partido_id 
	JOIN marcador_definitivo md ON p.partido_id = md.partido_id 
WHERE ma.partido_id = md.partido_id AND ma.second_equipo_score = md.second_equipo_score AND ma.first_equipo_score = md.first_equipo_score
GROUP BY ma.apostador_id
ORDER BY aciertos DESC
LIMIT 1;
