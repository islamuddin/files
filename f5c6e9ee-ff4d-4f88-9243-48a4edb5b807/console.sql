create table tbl_student
(
	id int auto_increment,
	name varchar(100) null,
	constraint tbl_student_pk
		primary key (id)
);


INSERT INTO `db1`.`tbl_student` (`name`) VALUES ('ali');
INSERT INTO `db1`.`tbl_student` (`name`) VALUES ('wali');

select * from `db1`.`tbl_student`;
select * from `db2`.`tbl_student`;
select * from `db1`.`tbl_teacher`;
select * from `db2`.`tbl_teacher`;


create table tbl_teacher
(
	id int auto_increment,
	name varchar(100) null,
	constraint tbl_teacher_pk
		primary key (id)
);

INSERT INTO `db2`.`tbl_teacher` (`name`) VALUES ('sir ali');
INSERT INTO `db2`.`tbl_teacher` (`name`) VALUES ('sir wali');

/*select * from nt_m2_cl_sales_flat_order
select * from nt_cl_sales_flat_order
*/

