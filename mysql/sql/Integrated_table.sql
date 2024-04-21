/* CREATE DATABASE `CourseSelectionSystem` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER DBAdmin@'%' identified by '123';
grant all PRIVILEGES on *.* to DBAdmin@'%' WITH GRANT OPTION;
flush privileges;

use CourseSelectionSystem; */

CREATE TABLE `Department` (
    `department_id`     INT PRIMARY KEY,
    `department_name`   VARCHAR (500)
);

INSERT INTO `Department` VALUES (1, '資訊工程學系');
INSERT INTO `Department` VALUES (2, '電機工程學系');
INSERT INTO `Department` VALUES (3, '電子工程學系');
INSERT INTO `Department` VALUES (4, '自動控制工程學系');
INSERT INTO `Department` VALUES (5, '資訊電機學院學士班');
INSERT INTO `Department` VALUES (6, '通訊工程學系');
INSERT INTO `Department` VALUES (7, '光電科學與工程學系');
INSERT INTO `Department` VALUES (8, '通識中心');
INSERT INTO `Department` VALUES (9, '應用數學學系');
INSERT INTO `Department` VALUES (10, '統計學系');

CREATE TABLE `Student` (
    /*name              VARCHAR(500) we don't need it right now */            
    `student_id`        VARCHAR (10) PRIMARY KEY,
    `student_password`  VARCHAR (500) NOT NULL,
    `department_id`     INT NOT NULL,
    `credits`           INT DEFAULT 0,
    `grade`             INT NOT NULL
);

INSERT INTO `Student` VALUES ('D1234567', '123', 1, 0, 1);
INSERT INTO `Student` VALUES ('E2345678', '234', 1, 0, 2);
INSERT INTO `Student` VALUES ('D5555555', '567', 1, 30, 1);
INSERT INTO `Student` VALUES ('F3456789', '345', 2, 0, 3);
INSERT INTO `Student` VALUES ('G4567890', '456', 2, 0, 4);
INSERT INTO `Student` VALUES ('H5678901', '567', 3, 0, 1);

CREATE TABLE `Course` (
    `course_id`         VARCHAR (10) PRIMARY KEY,
    `course_name`       VARCHAR (500) NOT NULL,
    `department_id`     INT NOT NULL,
    `required`          INT NOT NULL DEFAULT 0,
    `credit`            INT NOT NULL, 
    `description`       VARCHAR (500),
    `prerequisite_id`   VARCHAR (10),
    `grade`             INT NOT NULL,
    `maxNumOfSelect`    INT NOT NULL,
    `curNumOfSelect`    INT NOT NULL DEFAULT 0
);

INSERT INTO `Course` VALUES ('001', '程式設計', 1, 1, 3, '一門呱呱課程呱呱', 'null', 1, 2, 0);
INSERT INTO `Course` VALUES ('002', '資料結構', 1, 1, 3, '一門很重要的課程呱', 'null', 2, 2, 0);
INSERT INTO `Course` VALUES ('003', '演算法', 1, 1, 3, '一門涵蓋廣泛的呱呱', '001', 3, 2, 0);
INSERT INTO `Course` VALUES ('004', '微積分', 1, 1, 3, '一門呱呱與實踐相結合的課程', '001', 2, 5, 0);
INSERT INTO `Course` VALUES ('005', '線性代數', 1, 1, 3, '一呱基礎性的課程', 'null', 1, 2, 0);
INSERT INTO `Course` VALUES ('006', '系統程式', 1, 1, 3, '一呱基礎性的課程', 'null', 2, 2, 0);
INSERT INTO `Course` VALUES ('007', '系統程式', 1, 1, 3, '一呱基礎性的課程', 'null', 2, 2, 0);

INSERT INTO `Course` VALUES ('008', '離散數學', 2, 1, 3, '一呱基礎性的課程', 'null', 2, 2, 0);
INSERT INTO `Course` VALUES ('009', '數學離散', 2, 1, 3, '一呱基礎性的課程', 'null', 1, 2, 0);
INSERT INTO `Course` VALUES ('010', '離散數學離散', 2, 1, 3, '一呱基礎性的課程', 'null', 3, 2, 0);
INSERT INTO `Course` VALUES ('011', '數學離散數學', 2, 1, 3, '一呱基礎性的課程', 'null', 4, 2, 0);
INSERT INTO `Course` VALUES ('012', '呱呱鴨呱呱', 2, 1, 3, '一呱基礎性的課程', 'null', 3, 2, 0);

INSERT INTO `Course` VALUES ('013', '網路程式設計', 1, 0, 3, '一門涉及網路技術的課程，需要先完成「程式設計」', 'null', 2, 2, 0);
INSERT INTO `Course` VALUES ('014', '資料庫系統', 1, 0, 3, '一門關於資料庫設計與管理的課程', 'null', 3, 2, 0);
INSERT INTO `Course` VALUES ('015', '人工智慧導論', 1, 0, 3, '一門介紹人工智慧基礎概念的課程，需要先完成「微積分」與「線性代數」', 'null', 4, 2, 0);
INSERT INTO `Course` VALUES ('016', '機器學習基礎', 1, 0, 3, '一門介紹機器學習基本原理的課程', 'null', 4, 2, 0);
INSERT INTO `Course` VALUES ('017', '數據挖掘技術', 1, 0, 3, '一門介紹數據挖掘方法與工具的課程', 'null', 2, 2, 0);
INSERT INTO `Course` VALUES ('018', '網路安全基礎', 1, 0, 3, '一門介紹網路安全基本概念的課程', 'null', 2, 2, 0);

INSERT INTO `Course` VALUES ('019', '軟體工程概論', 2, 0, 3, '一門介紹軟體工程基礎概念的課程', 'null', 2, 2, 0);
INSERT INTO `Course` VALUES ('020', '電腦圖學入門', 2, 0, 3, '一門介紹電腦圖學基礎知識的課程', 'null', 3, 2, 0);
INSERT INTO `Course` VALUES ('021', '多媒體技術導論', 2, 0, 3, '一門介紹多媒體技術基本原理的課程', 'null', 4, 2, 0);
INSERT INTO `Course` VALUES ('022', '編譯原理與技術', 2, 0, 3, '一門介紹編譯原理與技術的課程', 'null', 1, 2, 0);
INSERT INTO `Course` VALUES ('023', '物聯網導論', 2, 0, 3, '一門介紹物聯網基礎知識的課程', 'null', 2, 2, 0);
INSERT INTO `Course` VALUES ('024', '嵌入式系統設計', 2, 0, 3, '一門介紹嵌入式系統設計的課程', 'null', 1, 2, 0);



/* Record the courses start and end time */
CREATE TABLE `CourseTime` (
    `course_id`         VARCHAR (10),
    `week_day`          INT,
    `time_index`        INT, /* 1 ~ 12 */
    PRIMARY KEY (`course_id`, `week_day`, `time_index`)
);

INSERT INTO `CourseTime` VALUES ('001', '1', '1');
INSERT INTO `CourseTime` VALUES ('002', '2', '3');
INSERT INTO `CourseTime` VALUES ('003', '4', '4');
INSERT INTO `CourseTime` VALUES ('004', '5', '5');
INSERT INTO `CourseTime` VALUES ('005', '1', '6');
INSERT INTO `CourseTime` VALUES ('006', '1', '6');

INSERT INTO `CourseTime` VALUES ('007', '2', '6');
INSERT INTO `CourseTime` VALUES ('008', '3', '6');
INSERT INTO `CourseTime` VALUES ('009', '4', '6');
INSERT INTO `CourseTime` VALUES ('009', '4', '5');
INSERT INTO `CourseTime` VALUES ('010', '5', '6');
INSERT INTO `CourseTime` VALUES ('011', '5', '8');
INSERT INTO `CourseTime` VALUES ('012', '4', '8');

INSERT INTO `CourseTime` VALUES ('013', '1', '1');
INSERT INTO `CourseTime` VALUES ('014', '2', '3');
INSERT INTO `CourseTime` VALUES ('015', '4', '4');
INSERT INTO `CourseTime` VALUES ('016', '5', '5');
INSERT INTO `CourseTime` VALUES ('017', '1', '6');
INSERT INTO `CourseTime` VALUES ('018', '1', '6');

INSERT INTO `CourseTime` VALUES ('019', '2', '6');
INSERT INTO `CourseTime` VALUES ('020', '3', '6');
INSERT INTO `CourseTime` VALUES ('021', '4', '6');
INSERT INTO `CourseTime` VALUES ('021', '4', '5');
INSERT INTO `CourseTime` VALUES ('022', '5', '6');
INSERT INTO `CourseTime` VALUES ('023', '5', '8');
INSERT INTO `CourseTime` VALUES ('024', '4', '8');




/* Record the courses required relations */
CREATE TABLE `PrerequisiteCourses` (
    `prerequisiteId`       INT AUTO_INCREMENT,
    `MainSubject`          VARCHAR (10),
    `RequiredCourse`       VARCHAR (10),
    PRIMARY KEY (`prerequisiteId`)
);

INSERT INTO `PrerequisiteCourses` (`MainSubject`, `RequiredCourse`) VALUES ('人工智慧導論', '微積分');
INSERT INTO `PrerequisiteCourses` (`MainSubject`, `RequiredCourse`) VALUES ('人工智慧導論', '線性代數');
INSERT INTO `PrerequisiteCourses` (`MainSubject`, `RequiredCourse`) VALUES ('網路程式設計', '程式設計');


/* Record the courses students have 'selected' */
CREATE TABLE `SelectedCourse` (
    `selected_num`      INT AUTO_INCREMENT,
    `course_id`         VARCHAR (10),
    `student_id`        VARCHAR (10),
    PRIMARY KEY (`Selected_num`)
);

CREATE TABLE `HistoryTable` (
    `history_id`        INT AUTO_INCREMENT,
    `course_id`         VARCHAR (10),
    `course_name`       VARCHAR (10),
    `student_id`        VARCHAR (10),
    PRIMARY KEY (`history_id`)
);

INSERT INTO `HistoryTable` (`course_id`, `course_name`, `student_id`) VALUES ('001', '程式設計', 'D1234567');
INSERT INTO `HistoryTable` (`course_id`, `course_name`, `student_id`) VALUES ('004', '微積分', 'D1234567');
INSERT INTO `HistoryTable` (`course_id`, `course_name`, `student_id`) VALUES ('005', '線性代數', 'D1234567');

/* -- INSERT INTO `SelectedCourse` (`course_id`, `student_id`) VALUES ('001', 'D1234567');
-- INSERT INTO `SelectedCourse` (`course_id`, `student_id`) VALUES ('002', 'E2345678');
-- INSERT INTO `SelectedCourse` (`course_id`, `student_id`) VALUES ('003', 'F3456789');
-- INSERT INTO `SelectedCourse` (`course_id`, `student_id`) VALUES ('004', 'G4567890');
-- INSERT INTO `SelectedCourse` (`course_id`, `student_id`) VALUES ('005', 'H5678901'); */

CREATE TABLE `COURSE_RATE` (
    `course_id`         VARCHAR (10) PRIMARY KEY,
    `rate`              INT,
    `comment`           VARCHAR (500),
    `comment_total`    INT
);

INSERT INTO `COURSE_RATE` VALUES ('001', 4, 'comment::狗都不修',1);
INSERT INTO `COURSE_RATE` VALUES ('002', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('003', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('004', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('005', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('006', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('007', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('008', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('009', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('010', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('011', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('012', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('013', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('014', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('015', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('016', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('017', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('018', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('019', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('020', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('021', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('022', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('023', 0, 'comment', 0);
INSERT INTO `COURSE_RATE` VALUES ('024', 0, 'comment', 0);