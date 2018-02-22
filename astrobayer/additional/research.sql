USE bayer;

DROP VIEW IF EXISTS VIEW_stellarComparison;
CREATE VIEW VIEW_stellarComparison AS
    SELECT 
        nameAlias.denomination,
        nameAlias.designation,
        parameterAlias.solarMass,
        parameterAlias.solarDiameter,
        parameterAlias.absoluteLuminosity,
        parameterAlias.bolometricLuminosity,
        parameterAlias.innerBoundary,
        parameterAlias.outerBoundary,
        parameterAlias.gregorianYear,
        parameterAlias.spectralClass,
        parameterAlias.stellarCategory
    FROM
        table_stellarname nameAlias
            LEFT JOIN
        table_stellarparameters parameterAlias ON parameterAlias.designation = nameAlias.designation
        ORDER BY parameterAlias.solarMass;
