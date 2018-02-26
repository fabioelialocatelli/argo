USE bayer;

DROP VIEW IF EXISTS TEST_solarMass;
CREATE VIEW TEST_solarMass AS
    SELECT 
        ROUND(POW(parametersAlias.bolometricLuminosity,
                        0.256),
                4) AS VALUE_CALCULATED,
        parametersAlias.solarMass AS VALUE_CURRENT
    FROM
        TABLE_stellarParameters parametersAlias
    WHERE
        parametersAlias.designation LIKE '%Ophiuchi';
        
DROP VIEW IF EXISTS TEST_absoluteLuminosity;
CREATE VIEW TEST_absoluteLuminosity AS
    SELECT 
        ROUND(POW(10,
                        (4.83 - parametersAlias.absoluteMagnitude) / 2.5),
                4) AS VALUE_CALCULATED,
        parametersAlias.absoluteLuminosity AS VALUE_CURRENT
    FROM
        TABLE_stellarParameters parametersAlias
    WHERE
        parametersAlias.designation LIKE '%Ophiuchi';
        
DROP VIEW IF EXISTS TEST_absoluteMagnitude;
CREATE VIEW TEST_absoluteMagnitude AS
    SELECT 
        ROUND(parametersAlias.apparentMagnitude - (5 * (LOG10(parametersAlias.Parsecs / 10))),
                2) AS VALUE_CALCULATED,
        parametersAlias.absoluteMagnitude AS VALUE_CURRENT
    FROM
        TABLE_stellarParameters parametersAlias
    WHERE
        parametersAlias.designation LIKE '%Ophiuchi';
        
DROP VIEW IF EXISTS TEST_apparentMagnitude;
CREATE VIEW TEST_apparentMagnitude AS
    SELECT 
        ROUND(parametersAlias.absoluteMagnitude - (5 * (1 - LOG10(parametersAlias.Parsecs))),
                2) AS VALUE_CALCULATED,
        parametersAlias.apparentMagnitude AS VALUE_CURRENT
    FROM
        TABLE_stellarParameters parametersAlias
    WHERE
        parametersAlias.designation LIKE '%Ophiuchi';
        
DROP VIEW IF EXISTS TEST_bolometricLuminosity;
CREATE VIEW TEST_bolometricLuminosity AS
    SELECT 
        ROUND(POW(10,
                        ((4.75 - parametersAlias.bolometricMagnitude) / 2.5)),
                4) AS VALUE_CALCULATED,
        parametersAlias.bolometricLuminosity AS VALUE_CURRENT
    FROM
        TABLE_stellarParameters parametersAlias
    WHERE
        parametersAlias.designation LIKE '%Ophiuchi';
               
DROP VIEW IF EXISTS TEST_goldilocksBoundaries;
CREATE VIEW TEST_goldilocksBoundaries AS
    SELECT 
        parametersAlias.innerBoundary AS INNERBOUNDARY_CURRENT,
        ROUND(SQRT((parametersAlias.bolometricLuminosity / 1.10)),
                4) AS INNERBOUNDARY_CALCULATED,
        parametersAlias.outerBoundary AS OUTERBOUNDARY_CURRENT,
        ROUND(SQRT((parametersAlias.bolometricLuminosity / 0.53)),
                4) AS OUTERBOUNDARY_CALCULATED,
        parametersAlias.gregorianYear AS GREGORIANYEAR_CURRENT,
        ROUND((((parametersAlias.innerBoundary + parametersAlias.outerBoundary) / 2.795883) * 365.2425),
                4) AS GREGORIANYEAR_CALCULATED
    FROM
        TABLE_stellarParameters parametersAlias
    WHERE
        designation LIKE '%Ophiuchi';
        
DROP VIEW IF EXISTS TEST_bolometricMagnitude;
CREATE VIEW TEST_bolometricMagnitude AS
    SELECT 
        ROUND((procedureViewAlias.absoluteMagnitude + procedureViewAlias.magnitudeCorrection),
                2) AS VALUE_CALCULATED,
        magnitudesAlias.bolometricMagnitude AS VALUE_CURRENT
    FROM
        VIEW_bolometricMagnitude procedureViewAlias
            LEFT JOIN
        VIEW_stellarMagnitudes magnitudesAlias ON magnitudesAlias.designation = procedureViewAlias.designation
    WHERE
        magnitudesAlias.designation LIKE '%Ophiuchi';
        
DROP VIEW IF EXISTS TEST_distanceConversion;
CREATE VIEW TEST_distanceConversion AS
    SELECT 
        ROUND((parametersAlias.lightYears * 0.306594845),
                2) AS PARSECS_CALCULATED,
        parametersAlias.parsecs AS PARSECS_CURRENT,
        ROUND((parametersAlias.parsecs * 3.261633440),
                2) AS LIGHTYEARS_CALCULATED,
        parametersAlias.lightYears AS LIGHTYEARS_CURRENT
    FROM
        TABLE_stellarParameters parametersAlias
    WHERE
        designation LIKE '%Ophiuchi';

DROP VIEW IF EXISTS TEST_solarDiameter;
CREATE VIEW TEST_solarDiameter AS
    SELECT 
        ROUND(POW((5777 / procedureViewAlias.temperatureKelvin),
                        2) * (POW(POW(2.511886431,
                                (4.75 - procedureViewAlias.bolometricMagnitude)),
                        0.5)),
                2) AS VALUE_CALCULATED,
        procedureViewAlias.solarDiameter AS VALUE_CURRENT
    FROM
        VIEW_solarDiameter procedureViewAlias
            LEFT JOIN
        VIEW_stellarSpectra classesAlias ON classesAlias.spectralClass = procedureViewAlias.spectralClass
            AND classesAlias.stellarCategory = procedureViewAlias.stellarCategory
    WHERE
        classesAlias.designation LIKE '%Ophiuchi';
