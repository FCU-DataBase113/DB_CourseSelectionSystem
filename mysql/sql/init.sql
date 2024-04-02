CREATE DATABASE `CourseSelectionSystem` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER DBAdmin@'%' identified by '123';
grant all PRIVILEGES on *.* to DBAdmin@'%' WITH GRANT OPTION;
flush privileges;
use CourseSelectionSystem;