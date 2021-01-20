-- 데이터베이스 생성 및 사용 선언
create database skylibrary;
use skylibrary;

-- 회원정보
create table user
(
	id    	  varchar(20)	 		comment '회원 아이디' ,  
	pw 		  varchar(50)  			comment '비밀번호',
	name      varchar(20)     		comment '이름',
	num		  varchar(15)     	 	comment '전화번호',
	postNum   int 					comment '우편번호', 
	addr1     varchar(100) comment '주소',
	addr2     varchar(100) comment '주소',
	email1    varchar(20) comment '이메일',
	email2    varchar(100) comment '이메일', 
	primary key (id)
);

-- 사서정보
create table manager
(
	mid  varchar(20) comment '사서아이디',
	pw   varchar(50) comment '비밀번호',
	name varchar(20) comment '이름',
	primary key (mid)
);


-- 질문 테이블 
create table q
(
	no     int auto_increment                comment '글번호',
	id     varchar(20)                       comment '회원아이디',
	title  varchar(100)                      comment '제목',
	body   text                              comment '내용',
	wdate  date 							 comment '작성일',
	hit    int   default 0                   comment '조회수',
	atype  int   default 0                   comment '답변여부',
	primary key (no),
	foreign key (id) references user(id)
);

-- 답변 테이블 
create table a
(
	no     int           comment '글번호',
	mid    varchar(20)   comment '사서아이디',
	title  varchar(100)  comment '제목',
	body   text  		 comment '내용',
	wdate  date          comment '작성일',
	foreign key (no)  references q(no),
	foreign key (mid) references manager(mid)
);

-- 공지사항 테이블 
create table notice
(
	no    int auto_increment   comment '글번호',
	mid   varchar(20)   	   comment '사서아이디',
	title varchar(100)  	   comment '제목',
	body  text          	   comment '내용',
	ndate date 				   comment '작성일',
	hit   int default 0  	   comment '조회수',
	nfile  varchar(255)  	   comment '첨부파일',
	primary key (no),
	foreign key (mid) references manager(mid)
);

-- 도서정보
create table book
(
	isbn    varchar(20)                   comment 'ISBN',
	subject varchar(100)           comment '제목',
	story   text                   comment '줄거리', 
	bcount   int       default 0   comment '대출횟수',
	company varchar(50)            comment '출판사',
	writer  varchar(100)           comment '작가',
	pdate   date                   comment '발행일',
	rent    int         default 0  comment '대여구분',
	primary key (isbn)
);

-- 사서추천도서정보 
create table rbook
(
	isbn    varchar(20)  comment 'ISBN',
	mid     varchar(20)  comment '사서아이디',
	subject varchar(100) comment '제목',
	story   text         comment '줄거리',
	company varchar(50)  comment '출판사',
	writer  varchar(100) comment '작가',
	pdate   date         comment '발행일: published date',
	why     text         comment '이유',
	foreign key (isbn) references book (isbn),
	foreign key (mid) references manager (mid) 
);


-- 신청도서정보
create table abook
(
	no     	  int 	auto_increment  comment '신청번호', 
	id    	  varchar(20)	 		comment '회원 아이디',  
	isbn      varchar(20)			comment 'ISBN',
	subject   varchar(100)     		comment '제목',
	company	  varchar(50)      		comment '출판사',
	pdate  	  varchar(100) 			comment '발행일', 
	wdate     date                  comment '신청일',
	okdate    date                  comment '처리일',
	writer    varchar(100)			comment '작가', 
	price     varchar(20)           comment '가격',
	why       text 					comment '이유', 	
	atype	  int	  default 0	    comment '처리구분',
	primary key (no),
	foreign key(id) references user(id)
	
);

-- 대여도서정보
create table rent
(
	id    	  varchar(20)	 		comment '회원 아이디',
	isbn      varchar(20)			comment 'ISBN',
	startd	  date			  		comment	'대여시작일',
	endd	  date                  comment '반납예정일',				
	foreign key(id)   references user(id),
	foreign key(isbn) references book(isbn)
);



