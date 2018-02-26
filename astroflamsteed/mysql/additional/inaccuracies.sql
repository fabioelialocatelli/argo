USE flamsteed;

DROP VIEW IF EXISTS VIEW_stellarInaccuracies;
CREATE VIEW VIEW_stellarInaccuracies AS
    SELECT 
        parameterAlias.designation AS flamsteedDesignation,
        nameAlias.denomination AS properName,
        parameterAlias.parallax,
        parameterAlias.parsecs,
        parameterAlias.lightYears,
        parameterAlias.apparentMagnitude,
        parameterAlias.absoluteMagnitude,
        parameterAlias.bolometricMagnitude,
        parameterAlias.solarDiameter,
        parameterAlias.absoluteLuminosity,
        parameterAlias.bolometricLuminosity,
        parameterAlias.innerBoundary,
        parameterAlias.outerBoundary,
        parameterAlias.gregorianYear,
        parameterAlias.spectralClass,
        parameterAlias.stellarCategory
    FROM
        flamsteed.TABLE_stellarName nameAlias
            RIGHT JOIN
        flamsteed.TABLE_stellarParameters parameterAlias ON nameAlias.designation = parameterAlias.designation
    WHERE
        parameterAlias.designation IN ('61 Tauri' , '54 Tauri',
            '35 Tauri',
            '46 Leonis Minoris')
    ORDER BY flamsteedDesignation;