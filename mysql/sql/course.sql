CREATE TABLE `course` (
    `course_id` INT PRIMARY KEY,
    `title` VARCHAR (100),
    `dept_id` INT,
    `credits` INT,
    `numberOfPeoPle` INT,
    `selected` BOOLEAN
);
-- 資訊工程學系課程
INSERT INTO course (course_id, title, credits, dept_id, numberOfPeoPle, selected) VALUES
(1, '網頁程式設計', 3, 0, 25, TRUE),
(2, '資料庫系統', 4, 0, 20, TRUE),
(3, '演算法與資料結構', 3, 0, 18, TRUE);

-- 電機工程學系課程
INSERT INTO course (course_id, title, credits, dept_id, numberOfPeoPle, selected) VALUES
(4, '電子電路', 4, 1, 22, TRUE),
(5, '信號與系統', 3, 1, 16, TRUE),
(6, '微處理機系統', 3, 1, 20, TRUE);