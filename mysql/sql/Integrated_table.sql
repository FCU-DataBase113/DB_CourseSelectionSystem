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
INSERT INTO `Course` VALUES ('014', '測試wait', 1, 0, 3, '一門關於資料庫設計與管理的課程', 'null', 3, 2, 1);
INSERT INTO `Course` VALUES ('015', '人工智慧導論', 1, 0, 3, '一門介紹人工智慧基礎概念的課程，需要先完成「微積分」與「線性代數」', 'null', 4, 2, 0);
INSERT INTO `Course` VALUES ('016', 'FULLCOURSE', 1, 0, 3, '一門介紹機器學習基本原理的課程', 'null', 4, 2, 2);
INSERT INTO `Course` VALUES ('017', '29Credits', 1, 0, 29, '一門介紹數據挖掘方法與工具的課程', 'null', 2, 2, 0);
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
INSERT INTO `CourseTime` VALUES ('006', '1', '7');

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
INSERT INTO `CourseTime` VALUES ('016', '5', '8');
INSERT INTO `CourseTime` VALUES ('017', '5', '7');
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




/* Record the courses students have 'selected' */

/*
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

INSERT INTO `CourseTime` VALUES ('001', '1', '1');
INSERT INTO `PrerequisiteCourses` (`MainSubject`, `RequiredCourse`) VALUES ('人工智慧導論', '微積分');
INSERT INTO `COURSE_RATE` VALUES ('001', 4, 'comment::狗都不修',1);

1, '資訊工程學系'
2, '電機工程學系'
3, '電子工程學系'
4, '自動控制工程學系'
5, '資訊電機學院學士班'
6, '通訊工程學系'
7, '光電科學與工程學系'
8, '通識中心'
9, '應用數學學系'
10,'統計學系'
*/
INSERT INTO `Course` VALUES ('025', '程式設計(二)', 1, 0, 3, '一門呱呱課程呱呱呱'    , '001', 1, 2, 0);
INSERT INTO `Course` VALUES ('026', '程式設計(三)', 1, 0, 3, '一門呱呱課程呱呱呱呱'  , '025', 2, 2, 0);
INSERT INTO `Course` VALUES ('027', '程式設計(四)', 1, 0, 3, '一門呱呱課程呱呱呱呱呱', '026', 2, 2, 0);

INSERT INTO `Course` VALUES ('028',  '高等元素論' , 3, 1, 1, '原神傷害機制的課程呱', 'null', 1, 5, 0);
INSERT INTO `Course` VALUES ('029',  '賽馬娘概論' , 3, 1, 1, '馬兒跳馬兒跳呱呱呱'  , 'null', 1, 10, 0);
INSERT INTO `Course` VALUES ('030',  '椰蛋數學'   , 3, 1, 1, '椰蛋樹是龍系寶可夢呱', 'null', 3, 10, 0);

INSERT INTO `Course` VALUES ('031',  '路由戲王概論'   , 4, 1, 1, '出老千入門呱'            , 'null', 3, 10, 0);
INSERT INTO `Course` VALUES ('032',  '蔚藍檔案導論'   , 4, 1, 1, '教師面試準備呱'          , 'null', 2, 10, 0);
INSERT INTO `Course` VALUES ('033',  '碧藍航線抽卡論' , 4, 1, 1, '海上作戰入門呱'          , 'null', 2, 10, 0);

INSERT INTO `Course` VALUES ('034',  '無職轉生'         , 5, 1, 1, '異世界呱' , 'null', 1, 10, 0);
INSERT INTO `Course` VALUES ('035',  '吹響吧！上低音號' , 5, 1, 1, '音樂入門呱', 'null', 1, 10, 0);
INSERT INTO `Course` VALUES ('036',  '轉生為第七王子'   , 5, 1, 1, '魔法入門呱'  , 'null', 3, 10, 0);

INSERT INTO `Course` VALUES ('037',  '魔法科高中的劣等生'  , 6, 1, 1, '繪畫入門呱' , 'null', 1, 10, 0);
INSERT INTO `Course` VALUES ('038',  '魔王學院的不適任者' , 6, 1, 1, '謙虛入門呱', 'null', 1, 10, 0);
INSERT INTO `Course` VALUES ('039',  '我的英雄學院'       , 6, 1, 1, '蝙蝠俠入門呱'  , 'null', 3, 10, 0);

INSERT INTO `Course` VALUES ('040',  '光劍製作'  , 7, 1, 1, '光的魔法入門呱' , 'null', 1, 10, 0);
INSERT INTO `Course` VALUES ('041',  '光的藝術' , 7, 1, 1, '光藝術入門呱', 'null', 1, 10, 0);
INSERT INTO `Course` VALUES ('042',  '巴斯光電物理', 7, 1, 1, '物理入門呱'  , 'null', 3, 10, 0);

INSERT INTO `Course` VALUES ('043',  '超越手錶導論'  , 8, 1, 1, '失敗遊戲製作呱' , 'null', 1, 10, 0);
INSERT INTO `Course` VALUES ('044',  '爐石與戰記' , 8, 1, 1,    '副程式製作呱', 'null', 1, 10, 0);
INSERT INTO `Course` VALUES ('045',  '迪亞波羅麵包烹飪科學', 8, 1, 1, '烹飪技巧呱'  , 'null', 3, 10, 0);

INSERT INTO `Course` VALUES ('046',  '德州撲克機率與統計'  , 9, 1, 1, '賺錢入門呱' , 'null', 1, 10, 0);
INSERT INTO `Course` VALUES ('047',  '麻將機率與統計' , 9, 1, 1,    '賠錢入門呱', 'null', 1, 10, 0);
INSERT INTO `Course` VALUES ('048',  '學分機率與統計', 9, 1, 1,     '愛校呱'  , 'null', 3, 10, 0);

INSERT INTO `Course` VALUES ('049',  '統記學'  , 10, 1, 1,   '呱' , 'null', 1, 10, 0);
INSERT INTO `Course` VALUES ('050',  '計算機概論' , 10, 0, 1,    '呱呱', 'null', 2, 10, 0);
INSERT INTO `Course` VALUES ('051',  '國文', 10, 1, 1,     '呱呱呱'  , 'null', 3, 10, 0);

INSERT INTO `Course` VALUES ('052',  '微處理機系統', 3, 1, 3,     '呱呱呱呱'  , 'null', 3, 10, 0);
INSERT INTO `Course` VALUES ('053',  '進階 C#程式設計', 3, 0, 3,     '呱呱呱呱呱'  , 'null', 3, 10, 0);
INSERT INTO `Course` VALUES ('054',  '積體電路導論', 3, 0, 3,     '呱呱呱呱呱呱'  , 'null', 3, 10, 0);



INSERT INTO `CourseTime` VALUES ('025', '2', '2');
INSERT INTO `CourseTime` VALUES ('025', '2', '3');
INSERT INTO `CourseTime` VALUES ('025', '2', '4');
INSERT INTO `CourseTime` VALUES ('026', '3', '3');
INSERT INTO `CourseTime` VALUES ('026', '3', '4');
INSERT INTO `CourseTime` VALUES ('026', '3', '5');
INSERT INTO `CourseTime` VALUES ('027', '4', '4');
INSERT INTO `CourseTime` VALUES ('027', '4', '5');
INSERT INTO `CourseTime` VALUES ('027', '4', '6');
INSERT INTO `CourseTime` VALUES ('028', '5', '3');
INSERT INTO `CourseTime` VALUES ('029', '2', '3');
INSERT INTO `CourseTime` VALUES ('030', '4', '1');
INSERT INTO `CourseTime` VALUES ('031', '4', '8');
INSERT INTO `CourseTime` VALUES ('032', '4', '7');
INSERT INTO `CourseTime` VALUES ('033', '4', '6');
INSERT INTO `CourseTime` VALUES ('034', '2', '6');
INSERT INTO `CourseTime` VALUES ('035', '3', '2');
INSERT INTO `CourseTime` VALUES ('036', '4', '3');
INSERT INTO `CourseTime` VALUES ('037', '2', '6');
INSERT INTO `CourseTime` VALUES ('038', '3', '2');
INSERT INTO `CourseTime` VALUES ('039', '2', '3');
INSERT INTO `CourseTime` VALUES ('040', '2', '6');
INSERT INTO `CourseTime` VALUES ('041', '3', '2');
INSERT INTO `CourseTime` VALUES ('042', '2', '3');
INSERT INTO `CourseTime` VALUES ('043', '2', '6');
INSERT INTO `CourseTime` VALUES ('044', '3', '2');
INSERT INTO `CourseTime` VALUES ('045', '2', '3');
INSERT INTO `CourseTime` VALUES ('046', '2', '6');
INSERT INTO `CourseTime` VALUES ('047', '3', '2');
INSERT INTO `CourseTime` VALUES ('048', '2', '3');
INSERT INTO `CourseTime` VALUES ('049', '2', '6');
INSERT INTO `CourseTime` VALUES ('050', '3', '2');
INSERT INTO `CourseTime` VALUES ('051', '2', '3');
INSERT INTO `CourseTime` VALUES ('052', '2', '6');
INSERT Into `CourseTime` VALUES ('053', '3', '2');
INSERT INTO `CourseTime` VALUES ('054', '2', '3');

INSERT INTO `PrerequisiteCourses` (`MainSubject`, `RequiredCourse`) VALUES ('程式設計(二)', '程式設計');
INSERT INTO `PrerequisiteCourses` (`MainSubject`, `RequiredCourse`) VALUES ('程式設計(三)', '程式設計(二)');
INSERT INTO `PrerequisiteCourses` (`MainSubject`, `RequiredCourse`) VALUES ('程式設計(四)', '程式設計(三)');

INSERT INTO `COURSE_RATE` VALUES ('025', 2, 'comment::狗都不修呱'       ,1);
INSERT INTO `COURSE_RATE` VALUES ('026', 3, 'comment::狗都不修呱呱'     ,1);
INSERT INTO `COURSE_RATE` VALUES ('027', 4, 'comment::狗都不修呱呱呱'   ,1);
INSERT INTO `COURSE_RATE` VALUES ('028', 5, 'comment::原神，啟動!!'     ,1);
INSERT INTO `COURSE_RATE` VALUES ('029', 5, 'comment::好想被東海帝王踢喔',1);
INSERT INTO `COURSE_RATE` VALUES ('030', 3, 'comment::寶可夢get打ze呱'  ,1);
INSERT INTO `COURSE_RATE` VALUES ('031', 2, 'comment::高貴的非指定送墓呱',1);
INSERT INTO `COURSE_RATE` VALUES ('032', 4, 'comment::天靈靈地靈靈優香體重100',1);
INSERT INTO `COURSE_RATE` VALUES ('033', 3, 'comment::從小玩到大'       ,1);
INSERT INTO `COURSE_RATE` VALUES ('034', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('035', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('036', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('037', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('038', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('039', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('040', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('041', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('042', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('043', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('044', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('045', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('046', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('047', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('048', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('049', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('050', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('051', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('052', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('053', 0, 'comment'       ,0);
INSERT INTO `COURSE_RATE` VALUES ('054', 0, 'comment'       ,0);

CREATE TABLE  `WAITLIST` (
    `course_id` VARCHAR (10) NOT NULL,
    `student_id` VARCHAR (10) NOT NULL,
    PRIMARY KEY (`course_id`, `student_id`)
);