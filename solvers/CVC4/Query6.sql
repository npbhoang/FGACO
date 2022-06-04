DROP PROCEDURE IF EXISTS Query6;
/* SELECT COUNT(students) FROM Enrollment */
DELIMITER //
CREATE PROCEDURE Query6(in kcaller varchar(250), in krole varchar(250))
BEGIN
DECLARE _rollback int DEFAULT 0;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  SET _rollback = 1;
  GET STACKED DIAGNOSTICS CONDITION 1 
    @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
  SELECT @p1, @p2;
  ROLLBACK;
END;
START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS TEMP1;
CREATE TEMPORARY TABLE TEMP1 AS (
  SELECT Lecturer_id AS lecturers, Student_id AS students 
  FROM Lecturer, Student
);

DROP TEMPORARY TABLE IF EXISTS TEMP2;
CREATE TEMPORARY TABLE TEMP2 AS (
  SELECT * FROM TEMP1
  WHERE CASE auth_READ_Enrollment(kcaller, krole, lecturers, students) 
    WHEN TRUE THEN TRUE ELSE throw_error() END
);

DROP TEMPORARY TABLE IF EXISTS TEMP3;
CREATE TEMPORARY TABLE TEMP3 AS (
  SELECT students FROM Enrollment
);

IF _rollback = 0
THEN SELECT COUNT(*) from TEMP3;
END IF;
END //
DELIMITER ;