CREATE OR REPLACE VIEW stellarIdentifiersTransient AS
    SELECT 
        namesAlias.denomination AS denomination,
        namesAlias.designation AS designation,
        parametersAlias.identifierHD AS identifierHD,
        parametersAlias.identifierHIP AS identifierHIP,
        parametersAlias.identifierSAO AS identifierSAO
    FROM
        stellarNames namesAlias
            LEFT JOIN
        stellarParameters parametersAlias ON namesAlias.designation = parametersAlias.designation;

CREATE OR REPLACE VIEW stellarMagnitudesTransient AS
    SELECT 
        namesAlias.denomination AS denomination,
        namesAlias.designation AS designation,
        parametersAlias.apparentMagnitude AS apparentMagnitude,
        parametersAlias.absoluteMagnitude AS absoluteMagnitude,
        parametersAlias.bolometricMagnitude AS bolometricMagnitude
    FROM
        stellarNames namesAlias
            LEFT JOIN
        stellarParameters parametersAlias ON namesAlias.designation = parametersAlias.designation;

CREATE OR REPLACE VIEW stellarParametersTransient AS
    SELECT 
        namesAlias.denomination AS denomination,
        namesAlias.designation AS designation,
        parametersAlias.solarDiameter AS solarDiameter,
        parametersAlias.absoluteLuminosity AS absoluteLuminosity,
        parametersAlias.bolometricLuminosity AS bolometricLuminosity,
        parametersAlias.solarMass AS solarMass
    FROM
        stellarNames namesAlias
            LEFT JOIN
        stellarParameters parametersAlias ON namesAlias.designation = parametersAlias.designation;

CREATE OR REPLACE VIEW stellarBoundariesTransient AS
    SELECT 
        namesAlias.denomination AS denomination,
        namesAlias.designation AS designation,
        parametersAlias.innerBoundary AS innerBoundary,
        parametersAlias.outerBoundary AS outerBoundary,
        parametersAlias.gregorianYear AS gregorianYear
    FROM
        stellarNames namesAlias
            LEFT JOIN
        stellarParameters parametersAlias ON namesAlias.designation = parametersAlias.designation;
    
CREATE OR REPLACE VIEW stellarClassesTransient AS
    SELECT 
        namesAlias.denomination AS denomination,
        namesAlias.designation AS designation,
        parametersAlias.spectralClass AS spectralClass,
        parametersAlias.stellarCategory AS stellarCategory
    FROM
        stellarNames namesAlias
            LEFT JOIN
        stellarParameters parametersAlias ON namesAlias.designation = parametersAlias.designation;
        
CREATE OR REPLACE VIEW stellarParadesTransient AS
    SELECT 
        namesAlias.denomination AS denomination,
        namesAlias.designation AS designation,
        parametersAlias.identifierHIP AS identifierHIP,
        parametersAlias.lightYears AS lightYears,
        parametersAlias.radialVelocity AS radialVelocity,
        parametersAlias.parallax AS parallax,
        parametersAlias.apparentMagnitude AS apparentMagnitude,
        parametersAlias.absoluteMagnitude AS absoluteMagnitude,
        parametersAlias.absoluteLuminosity AS absoluteLuminosity,
        parametersAlias.solarDiameter AS solarDiameter,
        parametersAlias.innerBoundary AS innerBoundary,
        parametersAlias.outerBoundary AS outerBoundary,
        parametersAlias.gregorianYear AS gregorianYear,
        parametersAlias.spectralClass AS spectralClass,
        parametersAlias.stellarCategory AS stellarCategory
    FROM
        stellarNames namesAlias
            LEFT JOIN
        stellarParameters parametersAlias ON namesAlias.designation = parametersAlias.designation;
        
CREATE OR REPLACE VIEW stellarBolometricsTransient AS
    SELECT 
        parametersAlias.designation,
        parametersAlias.absoluteMagnitude,
        classesAlias.magnitudeCorrection
    FROM
        stellarParameters parametersAlias
            LEFT JOIN
        stellarClasses classesAlias ON parametersAlias.spectralClass = classesAlias.spectralClass
            AND parametersAlias.stellarCategory = classesAlias.stellarCategory;
            
CREATE OR REPLACE VIEW stellarDiametersTransient AS
    SELECT 
        parametersAlias.designation,
        parametersAlias.bolometricMagnitude,
        parametersAlias.solarDiameter,
        classesAlias.spectralClass,
        classesAlias.stellarCategory,
        classesAlias.temperatureKelvin
    FROM
        stellarParameters parametersAlias
            LEFT JOIN
        stellarClasses classesAlias ON parametersAlias.spectralClass = classesAlias.spectralClass
            AND parametersAlias.stellarCategory = classesAlias.stellarCategory;
            