USE flamsteed
GO

DROP VIEW IF EXISTS stellarInaccuraciesTransient
GO

CREATE VIEW stellarInaccuraciesTransient AS
    SELECT 
        namesAlias.designation AS designationFlamsteed,
        namesAlias.denomination AS properName,
        parametersAlias.parallax,
        parametersAlias.parsecs,
        parametersAlias.lightYears,
        parametersAlias.apparentMagnitude,
        parametersAlias.absoluteMagnitude,
        parametersAlias.bolometricMagnitude,
        parametersAlias.solarDiameter,
        parametersAlias.absoluteLuminosity,
        parametersAlias.bolometricLuminosity,
        parametersAlias.innerBoundary,
        parametersAlias.outerBoundary,
        parametersAlias.gregorianYear,
        parametersAlias.spectralClass,
        parametersAlias.stellarCategory
    FROM
        stellarNames namesAlias
            RIGHT JOIN
        stellarParameters parametersAlias ON namesAlias.designation = parametersAlias.designation
    WHERE
        parametersAlias.designation IN ('61 Tauri' , '54 Tauri',
            '35 Tauri',
            '46 Leonis Minoris')
GO
