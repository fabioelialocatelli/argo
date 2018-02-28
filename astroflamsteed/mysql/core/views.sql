USE flamsteed;

DROP VIEW IF EXISTS stellarIdentifiersTransient;
CREATE VIEW stellarIdentifiersTransient AS
    SELECT 
        classicAlias.denomination AS denomination,
        classicAlias.designation AS designation,
        parameterAlias.identifierHD AS identifierHD,
        parameterAlias.identifierHIP AS identifierHIP,
        parameterAlias.identifierSAO AS identifierSAO
    FROM
        stellarNames classicAlias
            LEFT JOIN
        stellarParameters parameterAlias ON classicAlias.designation = parameterAlias.designation;

DROP VIEW IF EXISTS stellarMagnitudesTransient;
CREATE VIEW stellarMagnitudesTransient AS
    SELECT 
        classicAlias.denomination AS denomination,
        classicAlias.designation AS designation,
        parameterAlias.apparentMagnitude AS apparentMagnitude,
        parameterAlias.absoluteMagnitude AS absoluteMagnitude,
        parameterAlias.bolometricMagnitude AS bolometricMagnitude
    FROM
        stellarNames classicAlias
            LEFT JOIN
        stellarParameters parameterAlias ON classicAlias.designation = parameterAlias.designation;

DROP VIEW IF EXISTS stellarParametersTransient;
CREATE VIEW stellarParametersTransient AS
    SELECT 
        classicAlias.denomination AS denomination,
        classicAlias.designation AS designation,
        parameterAlias.solarDiameter AS solarDiameter,
        parameterAlias.absoluteLuminosity AS absoluteLuminosity,
        parameterAlias.bolometricLuminosity AS bolometricLuminosity,
        parameterAlias.solarMass AS solarMass
    FROM
        stellarNames classicAlias
            LEFT JOIN
        stellarParameters parameterAlias ON classicAlias.designation = parameterAlias.designation;

DROP VIEW IF EXISTS stellarBoundariesTransient;
CREATE VIEW stellarBoundariesTransient AS
    SELECT 
        classicAlias.denomination AS denomination,
        classicAlias.designation AS designation,
        parameterAlias.innerBoundary AS innerBoundary,
        parameterAlias.outerBoundary AS outerBoundary,
        parameterAlias.gregorianYear AS gregorianYear
    FROM
        stellarNames classicAlias
            LEFT JOIN
        stellarParameters parameterAlias ON classicAlias.designation = parameterAlias.designation;
    
DROP VIEW IF EXISTS stellarClassesTransient;
CREATE VIEW stellarClassesTransient AS
    SELECT 
        classicAlias.denomination AS denomination,
        classicAlias.designation AS designation,
        parameterAlias.spectralClass AS spectralClass,
        parameterAlias.stellarCategory AS stellarCategory
    FROM
        stellarNames classicAlias
            LEFT JOIN
        stellarParameters parameterAlias ON classicAlias.designation = parameterAlias.designation;
        
DROP VIEW IF EXISTS stellarParadesTransient;
CREATE VIEW stellarParadesTransient AS
    SELECT 
        classicAlias.denomination AS denomination,
        classicAlias.designation AS designation,
        parameterAlias.identifierHIP AS identifierHIP,
        parameterAlias.lightYears AS lightYears,
        parameterAlias.radialVelocity AS radialVelocity,
        parameterAlias.parallax AS parallax,
        parameterAlias.apparentMagnitude AS apparentMagnitude,
        parameterAlias.absoluteMagnitude AS absoluteMagnitude,
        parameterAlias.absoluteLuminosity AS absoluteLuminosity,
        parameterAlias.solarDiameter AS solarDiameter,
        parameterAlias.innerBoundary AS innerBoundary,
        parameterAlias.outerBoundary AS outerBoundary,
        parameterAlias.gregorianYear AS gregorianYear,
        parameterAlias.spectralClass AS spectralClass,
        parameterAlias.stellarCategory AS stellarCategory
    FROM
        stellarNames classicAlias
            LEFT JOIN
        stellarParameters parameterAlias ON classicAlias.designation = parameterAlias.designation;
        
DROP VIEW IF EXISTS stellarBolometricsTransient;
CREATE VIEW stellarBolometricsTransient AS
    SELECT 
        parametersAlias.designation,
        parametersAlias.absoluteMagnitude,
        classAlias.magnitudeCorrection
    FROM
        stellarParameters parametersAlias
            LEFT JOIN
        stellarClasses classAlias ON parametersAlias.spectralClass = classAlias.spectralClass
            AND parametersAlias.stellarCategory = classAlias.stellarCategory;
            
DROP VIEW IF EXISTS stellarDiametersTransient;
CREATE VIEW stellarDiametersTransient AS
    SELECT 
        parametersAlias.designation,
        parametersAlias.bolometricMagnitude,
        parametersAlias.solarDiameter,
        classAlias.spectralClass,
        classAlias.stellarCategory,
        classAlias.temperatureKelvin
    FROM
        stellarParameters parametersAlias
            LEFT JOIN
        stellarClasses classAlias ON parametersAlias.spectralClass = classAlias.spectralClass
            AND parametersAlias.stellarCategory = classAlias.stellarCategory;
