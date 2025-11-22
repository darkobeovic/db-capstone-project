-- Little Lemon - Stored Procedures
-- Asegúrate de estar usando la BD correcta
USE LittleLemonDB;

-- =========================================
-- 1) GetMaxQuantity
-- Devuelve la cantidad máxima de la tabla Orders
-- =========================================
DROP PROCEDURE IF EXISTS GetMaxQuantity;
DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(Quantity) AS `Max Quantity in Order`
    FROM Orders;
END //
//
DELIMITER ;

-- =========================================
-- 2) CancelOrder
-- Elimina una orden por OrderID y devuelve confirmación
-- =========================================
DROP PROCEDURE IF EXISTS CancelOrder;
DELIMITER //
CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
    DELETE FROM Orders
    WHERE OrderID = order_id;

    SELECT CONCAT('Order ', order_id, ' is cancelled') AS Confirmation;
END //
//
DELIMITER ;

-- =========================================
-- 3) CheckBooking
-- Revisa si una mesa está reservada en una fecha dada
-- =========================================
DROP PROCEDURE IF EXISTS CheckBooking;
DELIMITER //
CREATE PROCEDURE CheckBooking(
    IN booking_date DATE,
    IN table_number INT
)
BEGIN
    DECLARE booking_status VARCHAR(255);

    IF EXISTS (
        SELECT 1
        FROM Bookings
        WHERE DATE(BookingDate) = booking_date
          AND TableNumber = table_number
    ) THEN
        SET booking_status = CONCAT('Table ', table_number, ' is already booked');
    ELSE
        SET booking_status = CONCAT('Table ', table_number, ' is available');
    END IF;

    SELECT booking_status AS `Booking status`;
END //
//
DELIMITER ;

-- =========================================
-- 4) AddValidBooking
-- Usa transacción: inserta la reserva solo si la mesa
-- NO está ya reservada en esa fecha.
-- Parámetros: booking_date, table_number, customer_id
-- =========================================
DROP PROCEDURE IF EXISTS AddValidBooking;
DELIMITER //
CREATE PROCEDURE AddValidBooking(
    IN booking_date DATE,
    IN table_number INT,
    IN customer_id INT
)
BEGIN
    DECLARE existing_count INT DEFAULT 0;
    DECLARE booking_status VARCHAR(255);

    START TRANSACTION;

    SELECT COUNT(*)
    INTO existing_count
    FROM Bookings
    WHERE DATE(BookingDate) = booking_date
      AND TableNumber = table_number;

    IF existing_count > 0 THEN
        SET booking_status = CONCAT('Table ', table_number, ' is already booked - booking cancelled');
        ROLLBACK;
    ELSE
        INSERT INTO Bookings (BookingDate, TableNumber, CustomerID)
        VALUES (booking_date, table_number, customer_id);

        SET booking_status = CONCAT('Booking confirmed for table ', table_number);
        COMMIT;
    END IF;

    SELECT booking_status AS `Booking status`;
END //
//
DELIMITER ;

-- =========================================
-- 5) AddBooking
-- Inserta una reserva con BookingID, CustomerID, fecha y mesa
-- (ejercicio "AddBooking")
-- =========================================
DROP PROCEDURE IF EXISTS AddBooking;
DELIMITER //
CREATE PROCEDURE AddBooking(
    IN booking_id INT,
    IN customer_id INT,
    IN booking_date DATE,
    IN table_number INT
)
BEGIN
    INSERT INTO Bookings (BookingID, CustomerID, BookingDate, TableNumber)
    VALUES (booking_id, customer_id, booking_date, table_number);

    SELECT 'New booking added' AS Confirmation;
END //
//
DELIMITER ;

-- =========================================
-- 6) UpdateBooking
-- Actualiza la fecha de una reserva dada por BookingID
-- =========================================
DROP PROCEDURE IF EXISTS UpdateBooking;
DELIMITER //
CREATE PROCEDURE UpdateBooking(
    IN booking_id INT,
    IN new_booking_date DATE
)
BEGIN
    UPDATE Bookings
    SET BookingDate = new_booking_date
    WHERE BookingID = booking_id;

    SELECT CONCAT('Booking ', booking_id, ' updated') AS Confirmation;
END //
//
DELIMITER ;

-- =========================================
-- 7) CancelBooking
-- Elimina una reserva por BookingID y devuelve confirmación
-- =========================================
DROP PROCEDURE IF EXISTS CancelBooking;
DELIMITER //
CREATE PROCEDURE CancelBooking(
    IN booking_id INT
)
BEGIN
    DELETE FROM Bookings
    WHERE BookingID = booking_id;

    SELECT CONCAT('Booking ', booking_id, ' cancelled') AS Confirmation;
END //
//
DELIMITER ;