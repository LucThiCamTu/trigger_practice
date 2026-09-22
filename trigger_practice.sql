-- Bước 1: Tạo CSDL và Bảng
CREATE DATABASE IF NOT EXISTS company;
USE company;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);

-- Bước 2: Tạo Trigger tự động cập nhật department trước khi INSERT
DROP TRIGGER IF EXISTS update_department;

DELIMITER //

CREATE TRIGGER update_department
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary >= 5000 THEN
        SET NEW.department = 'Management';
    ELSEIF NEW.salary >= 3000 THEN
        SET NEW.department = 'Sales';
    ELSE
        SET NEW.department = 'Support';
    END IF;
END //

DELIMITER ;

-- Bước 3: Thêm dữ liệu để kiểm tra Trigger
-- Dù nhập department ban đầu là 'A', Trigger sẽ tự động sửa thành Management, Sales hoặc Support
INSERT INTO employees (name, department, salary)
VALUES 
    ('John Doe', 'A', 3500),
    ('Jane Smith', 'A', 2000),
    ('David Johnson', 'A', 6000);

-- Bước 4: Kiểm tra kết quả trong bảng
SELECT * FROM employees;