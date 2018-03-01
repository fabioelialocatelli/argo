USE flamsteed;

DROP VIEW IF EXISTS stellarIdentifiersTransient;

CREATE VIEW stellarIdentifiersTransient AS
    SELECT 
        parametersAlias.designation AS designation,
        parametersAlias.identifierHD AS identifierHD,
        parametersAlias.identifierHIP AS identifierHIP,
        parametersAlias.identifierSAO AS identifierSAO
    FROM
        stellarParameters parametersAlias;

DROP VIEW IF EXISTS stellarMagnitudesTransient;

CREATE VIEW stellarMagnitudesTransient AS
    SELECT 
        parametersAlias.designation AS designation,
        parametersAlias.apparentMagnitude AS apparentMagnitude,
        parametersAlias.absoluteMagnitude AS absoluteMagnitude,
        parametersAlias.bolometricMagnitude AS bolometricMagnitude
    FROM
        stellarParameters parametersAlias;

DROP VIEW IF EXISTS stellarParametersTransient;

CREATE VIEW stellarParametersTransient AS
    SELECT 
        parametersAlias.designation AS designation,
        parametersAlias.solarMass AS solarMass,
        parametersAlias.solarDiameter AS solarDiameter,
        parametersAlias.absoluteLuminosity AS absoluteLuminosity,
        parametersAlias.bolometricLuminosity AS bolometricLuminosity
    FROM
        stellarParameters parametersAlias;

DROP VIEW IF EXISTS stellarBoundariesTransient;

CREATE VIEW stellarBoundariesTransient AS
    SELECT 
        parametersAlias.designation AS designation,
        parametersAlias.innerBoundary AS innerBoundary,
        parametersAlias.outerBoundary AS outerBoundary,
        parametersAlias.gregorianYear AS gregorianYear
    FROM
        stellarParameters parametersAlias;
    
DROP VIEW IF EXISTS stellarClassesTransient;

CREATE VIEW stellarClassesTransient AS
    SELECT 
        parametersAlias.designation AS designation,
        classesAlias.spectralClass AS spectralClass,
        classesAlias.stellarCategory AS stellarCategory,
        classesAlias.temperatureKelvin AS temperatureKelvin
    FROM
        stellarParameters parametersAlias
            LEFT JOIN
        stellarClasses classesAlias ON parametersAlias.spectralClass = classesAlias.spectralClass
            AND parametersAlias.stellarCategory = classesAlias.stellarCategory;
    
DROP VIEW IF EXISTS stellarBolometricsTransient; 	
	    
CREATE VIEW stellarBolometricsTransient AS
    SELECT 
        parametersAlias.designation,
        parametersAlias.absoluteMagnitude,
        parametersAlias.bolometricMagnitude,
        classesAlias.magnitudeCorrection
    FROM    
        stellarParameters parametersAlias
            LEFT JOIN
        stellarClasses classesAlias ON parametersAlias.spectralClass = classesAlias.spectralClass
            AND parametersAlias.stellarCategory = classesAlias.stellarCategory;

DROP VIEW IF EXISTS stellarDiametersTransient;
            
CREATE VIEW stellarDiametersTransient AS
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

DROP VIEW IF EXISTS stellarParadesTransient;

CREATE VIEW stellarParadesTransient AS
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
