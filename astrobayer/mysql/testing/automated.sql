USE bayer;

DROP VIEW IF EXISTS testSolarMass;

CREATE VIEW testSolarMass AS
    SELECT 
        ROUND(POWER(parametersAlias.bolometricLuminosity,
                        0.256),
                4) AS valueCalculated,
        parametersAlias.solarMass AS valueCurrent
    FROM
        stellarParameters parametersAlias
    WHERE
        parametersAlias.designation LIKE '%Ophiuchi';

DROP VIEW IF EXISTS testAbsoluteLuminosity;
        
CREATE VIEW testAbsoluteLuminosity AS
    SELECT 
        ROUND(POWER(10,
                        (4.83 - parametersAlias.absoluteMagnitude) / 2.5),
                4) AS valueCalculated,
        parametersAlias.absoluteLuminosity AS valueCurrent
    FROM
        stellarParameters parametersAlias
    WHERE
        parametersAlias.designation LIKE '%Ophiuchi';

DROP VIEW IF EXISTS testAbsoluteMagnitude;
        
CREATE VIEW testAbsoluteMagnitude AS
    SELECT 
        ROUND(parametersAlias.apparentMagnitude - (5 * (LOG(10, (parametersAlias.Parsecs / 10)))),
                2) AS valueCalculated,
        parametersAlias.absoluteMagnitude AS valueCurrent
    FROM
        stellarParameters parametersAlias
    WHERE
        parametersAlias.designation LIKE '%Ophiuchi';

DROP VIEW IF EXISTS testApparentMagnitude;
        
CREATE VIEW testApparentMagnitude AS
    SELECT 
        ROUND(parametersAlias.absoluteMagnitude - (5 * (1 - LOG(10, (parametersAlias.Parsecs)))),
                2) AS valueCalculated,
        parametersAlias.apparentMagnitude AS valueCurrent
    FROM
        stellarParameters parametersAlias
    WHERE
        parametersAlias.designation LIKE '%Ophiuchi';

DROP VIEW IF EXISTS testBolometricLuminosity;
        
CREATE VIEW testBolometricLuminosity AS
    SELECT 
        ROUND(POWER(10,
                        ((4.75 - parametersAlias.bolometricMagnitude) / 2.5)),
                4) AS valueCalculated,
        parametersAlias.bolometricLuminosity AS valueCurrent
    FROM
        stellarParameters parametersAlias
    WHERE
        parametersAlias.designation LIKE '%Ophiuchi';

DROP VIEW IF EXISTS testGoldilocksBoundaries;
               
CREATE VIEW testGoldilocksBoundaries AS
    SELECT 
        parametersAlias.innerBoundary AS currentInnerBoundary,
        ROUND(SQRT((parametersAlias.bolometricLuminosity / 1.10)),
                2) AS calculatedInnerBoundary,
        parametersAlias.outerBoundary AS currentOuterBoundary,
        ROUND(SQRT((parametersAlias.bolometricLuminosity / 0.53)),
                2) AS calculatedOuterBoundary,
        parametersAlias.gregorianYear AS currentGregorianYear,
        ROUND(((((parametersAlias.bolometricLuminosity / 1.10) +
				(parametersAlias.bolometricLuminosity / 0.53)) / 2.795883) * 365.2425), 2) AS calculatedGregorianYear
    FROM
        stellarParameters parametersAlias
    WHERE
        designation LIKE '%Ophiuchi';

DROP VIEW IF EXISTS testDistanceConversion;
        
CREATE VIEW testDistanceConversion AS
    SELECT 
        ROUND((parametersAlias.lightYears * 0.306594845),
                2) AS calculatedParsecs,
        parametersAlias.parsecs AS currentParsecs,
        ROUND((parametersAlias.parsecs * 3.261633440),
                2) AS calculatedLightYears,
        parametersAlias.lightYears AS currentLightYears
    FROM
        stellarParameters parametersAlias
    WHERE
        designation LIKE '%Ophiuchi';

DROP VIEW IF EXISTS testBolometricMagnitude;
        
CREATE VIEW testBolometricMagnitude AS
    SELECT 
        ROUND((procedureViewAlias.absoluteMagnitude + procedureViewAlias.magnitudeCorrection),
                2) AS valueCalculated,
        magnitudesAlias.bolometricMagnitude AS valueCurrent
    FROM
        stellarBolometricsTransient procedureViewAlias
            LEFT JOIN
        stellarMagnitudesTransient magnitudesAlias ON magnitudesAlias.designation = procedureViewAlias.designation
    WHERE
        magnitudesAlias.designation LIKE '%Ophiuchi';

DROP VIEW IF EXISTS testSolarDiameter;

CREATE VIEW testSolarDiameter AS
    SELECT 
        ROUND(POWER((5777 / procedureViewAlias.temperatureKelvin),
                        2) * (POWER(POWER(2.511886431,
                                (4.75 - procedureViewAlias.bolometricMagnitude)),
                        0.5)),
                2) AS valueCalculated,
        procedureViewAlias.solarDiameter AS valueCurrent
    FROM
        stellarDiametersTransient procedureViewAlias
            LEFT JOIN
        stellarClassesTransient classesAlias ON classesAlias.designation = procedureViewAlias.designation
    WHERE
        classesAlias.designation LIKE '%Ophiuchi';
