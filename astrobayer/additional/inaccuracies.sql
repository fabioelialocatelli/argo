USE bayer;

DROP VIEW IF EXISTS VIEW_stellarInaccuracies;
CREATE VIEW VIEW_stellarInaccuracies AS
    SELECT 
        parameterAlias.designation AS bayerDesignation,
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
        parameterAlias.solarMass,
        parameterAlias.innerBoundary,
        parameterAlias.outerBoundary,
        parameterAlias.gregorianYear,
        parameterAlias.spectralClass,
        parameterAlias.stellarCategory
    FROM
        bayer.TABLE_stellarName nameAlias
            RIGHT JOIN
        bayer.TABLE_stellarParameters parameterAlias ON nameAlias.designation = parameterAlias.designation
    WHERE
        parameterAlias.designation IN ('α Andromedae' , 'α Cassiopeiae',
            'α Columbae',
            'α Fornacis',
            'α Gruis',
            'α Persei',
            'α Pyxidis',
            'β Gruis',
            'β Phoenicis',
            'γ Cassiopeiae',
            'γ Cephei',
            'γ Draconis',
            'γ Lyrae',
            'γ Persei',
            'γ Piscium',
            'δ Cygni',
            'δ Pegasi',
            'δ Persei',
            'δ Virginis',
            'ε Aquilae',
            'ε Persei',
            'ζ Aquilae',
            'ζ Centauri',
            'η Carinae',
            'η Ceti',
            'η Geminorum',
            'η Persei',
            'θ Cassiopeiae',
            'ι Draconis',
            'ι Geminorum',
            'κ Crucis',
            'κ Geminorum',
            'κ Persei',
            'λ Geminorum',
            'λ Herculis',
            'μ Cassiopeiae',
            'μ Geminorum',
            'μ Velorum',
            'π Puppis',
            'σ Scorpii',
            'τ Scorpii')
    ORDER BY bayerDesignation;