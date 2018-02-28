USE flamsteed
GO

DROP VIEW IF EXISTS testSolarMass
GO

CREATE VIEW testSolarMass AS
    SELECT 
        ROUND(POWER(parametersAlias.bolometricLuminosity,
                        0.256),
                4) AS valueCalculated,
        parametersAlias.solarMass AS valueCurrent
    FROM
        stellarParameters parametersAlias
    WHERE
        parametersAlias.designation LIKE '%Canum Venaticorum'
GO
        
DROP VIEW IF EXISTS testAbsoluteLuminosity
GO

CREATE VIEW testAbsoluteLuminosity AS
    SELECT 
        ROUND(POWER(10,
                        (4.83 - parametersAlias.absoluteMagnitude) / 2.5),
                4) AS valueCalculated,
        parametersAlias.absoluteLuminosity AS valueCurrent
    FROM
        stellarParameters parametersAlias
    WHERE
        parametersAlias.designation LIKE '%Canum Venaticorum'
GO
        
DROP VIEW IF EXISTS testAbsoluteMagnitude
GO

CREATE VIEW testAbsoluteMagnitude AS
    SELECT 
        ROUND(parametersAlias.apparentMagnitude - (5 * (LOG10(parametersAlias.Parsecs / 10))),
                2) AS valueCalculated,
        parametersAlias.absoluteMagnitude AS valueCurrent
    FROM
        stellarParameters parametersAlias
    WHERE
        parametersAlias.designation LIKE '%Canum Venaticorum'
GO
        
DROP VIEW IF EXISTS testApparentMagnitude
GO

CREATE VIEW testApparentMagnitude AS
    SELECT 
        ROUND(parametersAlias.absoluteMagnitude - (5 * (1 - LOG10(parametersAlias.Parsecs))),
                2) AS valueCalculated,
        parametersAlias.apparentMagnitude AS valueCurrent
    FROM
        stellarParameters parametersAlias
    WHERE
        parametersAlias.designation LIKE '%Canum Venaticorum'
GO
        
DROP VIEW IF EXISTS testBolometricLuminosity
GO

CREATE VIEW testBolometricLuminosity AS
    SELECT 
        ROUND(POWER(10,
                        ((4.75 - parametersAlias.bolometricMagnitude) / 2.5)),
                4) AS valueCalculated,
        parametersAlias.bolometricLuminosity AS valueCurrent
    FROM
        stellarParameters parametersAlias
    WHERE
        parametersAlias.designation LIKE '%Canum Venaticorum'
GO
               
DROP VIEW IF EXISTS testGoldilocksBoundaries
GO

CREATE VIEW testGoldilocksBoundaries AS
    SELECT 
        parametersAlias.innerBoundary AS currentInnerBoundary,
        ROUND(SQRT((parametersAlias.bolometricLuminosity / 1.10)),
                4) AS calculatedInnerBoundary,
        parametersAlias.outerBoundary AS currentOuterBoundary,
        ROUND(SQRT((parametersAlias.bolometricLuminosity / 0.53)),
                4) AS calculatedOuterBoundary,
        parametersAlias.gregorianYear AS currentGregorianYear,
        ROUND((((parametersAlias.innerBoundary + parametersAlias.outerBoundary) / 2.795883) * 365.2425),
                4) AS calculatedGregorianYear
    FROM
        stellarParameters parametersAlias
    WHERE
        designation LIKE '%Canum Venaticorum'
GO
        
DROP VIEW IF EXISTS testBolometricMagnitude
GO

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
        magnitudesAlias.designation LIKE '%Canum Venaticorum'
GO
        
DROP VIEW IF EXISTS testDistanceConversion
GO

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
        designation LIKE '%Canum Venaticorum'
GO

DROP VIEW IF EXISTS testSolarDiameter
GO

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
        stellarClassesTransient classesAlias ON classesAlias.spectralClass = procedureViewAlias.spectralClass
            AND classesAlias.stellarCategory = procedureViewAlias.stellarCategory
    WHERE
        classesAlias.designation LIKE '%Canum Venaticorum'
GO
