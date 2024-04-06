use courseselectionsystem;
CREATE TABLE `User` (
    `user_id` INT PRIMARY KEY,
    `user_name` VARCHAR (20),
    `department` VARCHAR (20),
    `gender` VARCHAR (10),
    `mailbox` VARCHAR (100)
);

CREATE TABLE `Department` (
    `department_id` INT PRIMARY KEY,
    `department_name` VARCHAR (500)
);

INSERT INTO `Department` VALUES(1, '資訊工程學系');
INSERT INTO `Department` VALUES(2, '電機工程學系');
INSERT INTO `Department` VALUES(3, '電子工程學系');
INSERT INTO `Department` VALUES(4, '自動控制工程學系');
INSERT INTO `Department` VALUES(5, '資訊電機學院學士班');
INSERT INTO `Department` VALUES(6, '通訊工程學系');
INSERT INTO `Department` VALUES(7, '光電科學與工程學系');
INSERT INTO `Department` VALUES(8, '通識中心');
INSERT INTO `Department` VALUES(9, '應用數學學系');
INSERT INTO `Department` VALUES(10, '統計學系');
