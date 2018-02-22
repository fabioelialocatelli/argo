USE flamsteed;

DROP VIEW IF EXISTS VIEW_stellarIdentifiers;
CREATE VIEW VIEW_stellarIdentifiers AS
    SELECT 
        classicAlias.denomination AS denomination,
        classicAlias.designation AS designation,
        parameterAlias.identifierHD AS identifierHD,
        parameterAlias.identifierHIP AS identifierHIP,
        parameterAlias.identifierSAO AS identifierSAO
    FROM
        TABLE_stellarName classicAlias
            LEFT JOIN
        TABLE_stellarParameters parameterAlias ON classicAlias.designation = parameterAlias.designation;

DROP VIEW IF EXISTS VIEW_stellarMagnitudes;
CREATE VIEW VIEW_stellarMagnitudes AS
    SELECT 
        classicAlias.denomination AS denomination,
        classicAlias.designation AS designation,
        parameterAlias.apparentMagnitude AS apparentMagnitude,
        parameterAlias.absoluteMagnitude AS absoluteMagnitude,
        parameterAlias.bolometricMagnitude AS bolometricMagnitude
    FROM
        TABLE_stellarName classicAlias
            LEFT JOIN
        TABLE_stellarParameters parameterAlias ON classicAlias.designation = parameterAlias.designation;

DROP VIEW IF EXISTS VIEW_stellarParameters;
CREATE VIEW VIEW_stellarParameters AS
    SELECT 
        classicAlias.denomination AS denomination,
        classicAlias.designation AS designation,
        parameterAlias.solarDiameter AS solarDiameter,
        parameterAlias.absoluteLuminosity AS absoluteLuminosity,
        parameterAlias.bolometricLuminosity AS bolometricLuminosity,
        parameterAlias.solarMass AS solarMass
    FROM
        TABLE_stellarName classicAlias
            LEFT JOIN
        TABLE_stellarParameters parameterAlias ON classicAlias.designation = parameterAlias.designation;

DROP VIEW IF EXISTS VIEW_stellarHabitability;
CREATE VIEW VIEW_stellarHabitability AS
    SELECT 
        classicAlias.denomination AS denomination,
        classicAlias.designation AS designation,
        parameterAlias.innerBoundary AS innerBoundary,
        parameterAlias.outerBoundary AS outerBoundary,
        parameterAlias.gregorianYear AS gregorianYear
    FROM
        TABLE_stellarName classicAlias
            LEFT JOIN
        TABLE_stellarParameters parameterAlias ON classicAlias.designation = parameterAlias.designation;
    
DROP VIEW IF EXISTS VIEW_stellarSpectra;
CREATE VIEW VIEW_stellarSpectra AS
    SELECT 
        classicAlias.denomination AS denomination,
        classicAlias.designation AS designation,
        parameterAlias.spectralClass AS spectralClass,
        parameterAlias.stellarCategory AS stellarCategory
    FROM
        TABLE_stellarName classicAlias
            LEFT JOIN
        TABLE_stellarParameters parameterAlias ON classicAlias.designation = parameterAlias.designation;
        
DROP VIEW IF EXISTS VIEW_stellarConsole;
CREATE VIEW VIEW_stellarConsole AS
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
        TABLE_stellarName classicAlias
            LEFT JOIN
        TABLE_stellarParameters parameterAlias ON classicAlias.designation = parameterAlias.designation;
        
DROP VIEW IF EXISTS VIEW_bolometricMagnitude;
CREATE VIEW VIEW_bolometricMagnitude AS
    SELECT 
        parametersAlias.designation,
        parametersAlias.absoluteMagnitude,
        classAlias.magnitudeCorrection
    FROM
        TABLE_stellarParameters parametersAlias
            LEFT JOIN
        TABLE_stellarClass classAlias ON parametersAlias.spectralClass = classAlias.spectralClass
            AND parametersAlias.stellarCategory = classAlias.stellarCategory;
            
DROP VIEW IF EXISTS VIEW_solarDiameter;
CREATE VIEW VIEW_solarDiameter AS
    SELECT 
        parametersAlias.designation,
        parametersAlias.bolometricMagnitude,
        parametersAlias.solarDiameter,
        classAlias.spectralClass,
        classAlias.stellarCategory,
        classAlias.temperatureKelvin
    FROM
        TABLE_stellarParameters parametersAlias
            LEFT JOIN
        TABLE_stellarClass classAlias ON parametersAlias.spectralClass = classAlias.spectralClass
            AND parametersAlias.stellarCategory = classAlias.stellarCategory;
