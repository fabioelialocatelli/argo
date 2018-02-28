USE flamsteed;

SET SQL_SAFE_UPDATES = 0;
UPDATE stellarParameters SET apparentMagnitude = NULL;
CALL apparentMagnitude(2);
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE stellarParameters SET absoluteMagnitude = NULL;
CALL absoluteMagnitude(2);
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE stellarParameters SET bolometricMagnitude = NULL;
CALL bolometricMagnitude(2);
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE stellarParameters SET absoluteLuminosity = NULL;
CALL absoluteLuminosity(4);
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE stellarParameters SET bolometricLuminosity = NULL;
CALL bolometricLuminosity(4);
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE stellarParameters SET solarMass = NULL;
CALL solarMass(2);
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE stellarParameters SET parsecs = NULL;
CALL distanceConversion(0, 2);
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE stellarParameters SET lightYears = NULL;
CALL distanceConversion(1, 2);
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE stellarParameters SET solarDiameter = NULL;
CALL solarDiameter(2);
SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE stellarParameters SET innerBoundary = NULL;
UPDATE stellarParameters SET outerBoundary = NULL;
UPDATE stellarParameters SET gregorianYear = NULL;
CALL goldilocksBoundaries(2);
SET SQL_SAFE_UPDATES = 1;
