USE flamsteed;

SET SQL_SAFE_UPDATES = 0;
UPDATE table_stellarparameters SET apparentMagnitude = NULL;
CALL PROCEDURE_apparentMagnitude();
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE table_stellarparameters SET absoluteMagnitude = NULL;
CALL PROCEDURE_absoluteMagnitude();
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE table_stellarparameters SET bolometricMagnitude = NULL;
CALL PROCEDURE_bolometricMagnitude();
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE table_stellarparameters SET absoluteLuminosity = NULL;
CALL PROCEDURE_absoluteLuminosity();
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE table_stellarparameters SET bolometricLuminosity = NULL;
CALL PROCEDURE_bolometricLuminosity();
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE table_stellarparameters SET solarMass = NULL;
CALL PROCEDURE_solarMass();
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE table_stellarparameters SET parsecs = NULL;
CALL PROCEDURE_distanceConversion(0);
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE table_stellarparameters SET lightYears = NULL;
CALL PROCEDURE_distanceConversion(1);
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE table_stellarparameters SET solarDiameter = NULL;
CALL PROCEDURE_solarDiameter();
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE table_stellarparameters SET innerBoundary = NULL;
UPDATE table_stellarparameters SET outerBoundary = NULL;
UPDATE table_stellarparameters SET gregorianYear = NULL;
CALL PROCEDURE_goldilocksBoundaries();
SET SQL_SAFE_UPDATES = 1;
