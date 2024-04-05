-- 建立 department 表格
CREATE TABLE `department` (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100),
    building VARCHAR(100)
);

-- 新增部門資料
INSERT INTO department (dept_id, dept_name, building) VALUES
(0, '資訊工程學系', '資電館'),
(1, '電機工程學系', '資電館');
