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