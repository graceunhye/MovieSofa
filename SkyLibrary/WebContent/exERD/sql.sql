-- �����ͺ��̽� ���� �� ��� ����
create database skylibrary;
use skylibrary;

-- ȸ������
create table user
(
	id    	  varchar(20)	 		comment 'ȸ�� ���̵�' ,  
	pw 		  varchar(50)  			comment '��й�ȣ',
	name      varchar(20)     		comment '�̸�',
	num		  varchar(15)     	 	comment '��ȭ��ȣ',
	postNum   int 					comment '�����ȣ', 
	addr1     varchar(100) comment '�ּ�',
	addr2     varchar(100) comment '�ּ�',
	email1    varchar(20) comment '�̸���',
	email2    varchar(100) comment '�̸���', 
	primary key (id)
);

-- �缭����
create table manager
(
	mid  varchar(20) comment '�缭���̵�',
	pw   varchar(50) comment '��й�ȣ',
	name varchar(20) comment '�̸�',
	primary key (mid)
);


-- ���� ���̺� 
create table q
(
	no     int auto_increment                comment '�۹�ȣ',
	id     varchar(20)                       comment 'ȸ�����̵�',
	title  varchar(100)                      comment '����',
	body   text                              comment '����',
	wdate  date 							 comment '�ۼ���',
	hit    int   default 0                   comment '��ȸ��',
	atype  int   default 0                   comment '�亯����',
	primary key (no),
	foreign key (id) references user(id)
);

-- �亯 ���̺� 
create table a
(
	no     int           comment '�۹�ȣ',
	mid    varchar(20)   comment '�缭���̵�',
	title  varchar(100)  comment '����',
	body   text  		 comment '����',
	wdate  date          comment '�ۼ���',
	foreign key (no)  references q(no),
	foreign key (mid) references manager(mid)
);

-- �������� ���̺� 
create table notice
(
	no    int auto_increment   comment '�۹�ȣ',
	mid   varchar(20)   	   comment '�缭���̵�',
	title varchar(100)  	   comment '����',
	body  text          	   comment '����',
	ndate date 				   comment '�ۼ���',
	hit   int default 0  	   comment '��ȸ��',
	nfile  varchar(255)  	   comment '÷������',
	primary key (no),
	foreign key (mid) references manager(mid)
);

-- ��������
create table book
(
	isbn    varchar(20)                   comment 'ISBN',
	subject varchar(100)           comment '����',
	story   text                   comment '�ٰŸ�', 
	bcount   int       default 0   comment '����Ƚ��',
	company varchar(50)            comment '���ǻ�',
	writer  varchar(100)           comment '�۰�',
	pdate   date                   comment '������',
	rent    int         default 0  comment '�뿩����',
	primary key (isbn)
);

-- �缭��õ�������� 
create table rbook
(
	isbn    varchar(20)  comment 'ISBN',
	mid     varchar(20)  comment '�缭���̵�',
	subject varchar(100) comment '����',
	story   text         comment '�ٰŸ�',
	company varchar(50)  comment '���ǻ�',
	writer  varchar(100) comment '�۰�',
	pdate   date         comment '������: published date',
	why     text         comment '����',
	foreign key (isbn) references book (isbn),
	foreign key (mid) references manager (mid) 
);


-- ��û��������
create table abook
(
	no     	  int 	auto_increment  comment '��û��ȣ', 
	id    	  varchar(20)	 		comment 'ȸ�� ���̵�',  
	isbn      varchar(20)			comment 'ISBN',
	subject   varchar(100)     		comment '����',
	company	  varchar(50)      		comment '���ǻ�',
	pdate  	  varchar(100) 			comment '������', 
	wdate     date                  comment '��û��',
	okdate    date                  comment 'ó����',
	writer    varchar(100)			comment '�۰�', 
	price     varchar(20)           comment '����',
	why       text 					comment '����', 	
	atype	  int	  default 0	    comment 'ó������',
	primary key (no),
	foreign key(id) references user(id)
	
);

-- �뿩��������
create table rent
(
	id    	  varchar(20)	 		comment 'ȸ�� ���̵�',
	isbn      varchar(20)			comment 'ISBN',
	startd	  date			  		comment	'�뿩������',
	endd	  date                  comment '�ݳ�������',				
	foreign key(id)   references user(id),
	foreign key(isbn) references book(isbn)
);



