SELECT temperatureKelvin FROM stellarClasses WHERE REGEXP_LIKE (spectralclass ,'^R[0-9]');
SELECT COUNT(designation) FROM stellarClasses WHERE designation LIKE '%Ophiuchi';