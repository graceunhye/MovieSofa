create database moviesofa;
use moviesofa;

create table movieinfo
(
	mv_no      int auto_increment comment '영화번호',
	mv_type	   varchar(4) comment '영화분류',
	mv_thum	   varchar(100) comment '영화썸네일',
	mv_title   varchar(200) comment '영화제목',
	mv_gen     varchar(50) comment '영화장르',
	mv_date    date  comment '영화개봉일',
	mv_dire    varchar(50) comment '영화감독',
	mv_act     varchar(100) comment '영화출연자',
	mv_story   text comment '영화줄거리',
	mv_clip    varchar(300) comment '영화예고',
	primary key (mv_no)
);

create table movieimg
(
	mv_imgno  int auto_increment comment '영화이미지번호',
	mv_no     int comment '영화번호',
	mv_img    varchar(100) comment '영화포스터',
	mv_title  varchar(200) comment '영화제목',
	primary key (mv_imgno),
	foreign key (mv_no) references movieinfo (mv_no)
);


create table user
(
	id varchar(20),
	pw varchar(20),
	primary key(id)
);

create table review
(
	rv_no int auto_increment comment '글번호',
	id varchar(20) comment '아이디',
	mv_no int comment '영화번호',
	rv_title varchar(200) comment '제목',
	rv_body text comment '내용',
	rv_date date  comment '작성일',
	rv_hit int default 0 comment '조회수',
	rv_file varchar(255) comment '첨부파일',
	primary key (rv_no),
	foreign key (id) references user(id),
	foreign key (mv_no) references movieinfo(mv_no)
);


create table comment
(
	id varchar(20) comment '아이디',
	rv_no int comment '글번호',
	c_no int auto_increment comment '댓글번호',
	mv_no int comment '영화번호',
	c_body text comment '댓글내용',
	c_date date comment '댓글작성일',
	primary key (c_no),
	foreign key (id) references user(id),
	foreign key (rv_no) references review(rv_no),
	foreign key (mv_no) references movieinfo(mv_no)
);


insert into movieinfo
(mv_type, mv_thum, mv_title, mv_gen, mv_date, mv_dire, mv_act, mv_story, mv_clip)
values 
('k', '도굴.jpg','도굴', '범죄', '2020.11.04', '박정배', '이제훈, 조우진, 신혜선 등', '흙 맛만 봐도 보물을 찾아내는 타고난 천재 도굴꾼 강동구(이제훈). 자칭 한국의 인디아나 존스로 불리는 고분벽화 도굴 전문가 존스 박사(조우진), 전설의 삽질 달인 삽다리(임원희)를 만나 환상(?)의 팀플레이를 자랑하며 위험천만하고도 짜릿한 도굴의 판을 키운다. 한편, 그의 재능을 알아본 고미술계 엘리트 큐레이터 윤실장(신혜선)은 강동구에게 매력적이면서도 위험한 거래를 제안하는데...! 황영사 금동불상, 고구려 고분벽화 그리고 서울 강남 한복판 선릉까지! 팔수록 판이 커지는 도굴의 세계! 급이 다른 삽질이 시작된다!', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/4fPWyBLkk6o" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '삼진그룹영어토익반.jpg','삼진그룹 영어토익반', '드라마', '2020.10.21', '이종필', '고아성, 이솜, 박혜수 등', '입사 8년차 동기인 말단 여직원들이 ‘삼진그룹 영어토익반’에 모인다! 실무 능력 퍼펙트, 현실은 커피 타기 달인인 생산관리3부 오지랖 ‘이자영’(고아성), 추리소설 마니아로 뼈 때리는 멘트의 달인 마케팅부 돌직구 ‘정유나’(이솜), 수학 올림피아드 우승 출신, 실체는 가짜 영수증 메꾸기 달인 회계부 수학왕 ‘심보람’(박혜수)은 대리가 되면 진짜 ‘일’을 할 수 있을 것이라는 희망에 부푼다. 내부고발이라도 하게? 나서지 마. 우리만 다쳐 잔심부름을 하러 간 공장에서 검은 폐수가 유출되는 것을 목격한 ‘자영’은 ‘유나’,‘보람’과 함께 회사가 무엇을 감추고자 하는지, 결정적 증거를 찾으려 한다. 불가능해 보이는 싸움, 세 친구는 해고의 위험을 무릅쓰고 고군분투를 시작하는데… 아이 캔 두 잇, 유 캔 두 잇, 위 캔 두 잇!', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/BHGHKoX-qSw" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '담보.jpg', '담보', '드라마', '2020.09.29', '강대규', '성동일, 하지원, 김희원 등', '1993년 인천 거칠고 까칠한 사채업자 두석(성동일)과 종배(김희원)는 떼인 돈 받으러 갔다가 얼떨결에 9살 승이(박소이)를 담보로 맡게 된다. “담보가 무슨 뜻이에요?”뜻도 모른 채 담보가 된 승이와 승이 엄마의 사정으로 아이의 입양까지 책임지게 된 두석과 종배. 하지만 부잣집으로 간 줄 알았던 승이가 엉뚱한 곳에 있다는 것을 알게 된 두 사람은 승이를 데려와 돌보게 된다. 예고 없이 찾아온 아이에게 인생을 담보 잡힌 두석과 종배. 빚 때문에 아저씨들에게 맡겨진 담보 승이. 두석, 종배, 승이 세 사람은 어느덧 서로에게 특별한 존재가 되는데.. 돈 받으러 갔다가 인생의 보물을 만났다!', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/fWZcwe6TBWg" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '노트북.jpg', '노트북 (The Notebook)', '멜로/로맨스', '2004.11.26', '닉 카사베츠 (Nick Cassavetes)', '라이언 고슬링, 레이첼 맥아담스  등', '17살,‘노아’는 밝고 순수한 ‘앨리’를 보고 첫눈에 반한다.빠른 속도로 서로에게 빠져드는 둘. 그러나 이들 앞에 놓인 장벽에 막혀 이별하게 된다. 24살, ‘앨리’는 우연히 신문에서 ‘노아’의 소식을 접하고 잊을 수 없는 첫사랑 앞에서 다시 한 번 선택의 기로에 서게 되는데… 열일곱의 설렘, 스물넷의 아픈 기억, 그리고 마지막까지… 한 사람을 지극히 사랑했으니 내 인생은 성공한 인생입니다.', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/AF4IzD6aVU4" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '미스터트롯더무비.jpg', '미스터트롯: 더 무비', '공연실황', '2020.10.22', '-', '임영웅, 영탁, 이찬원 등', '대한민국을 뒤흔든 사상 최초 트로트 서바이벌 [내일은 미스터트롯] 최고 시청률 35.7%, 전국민적인 사랑을 받은 TOP6의 탄생! ‘내일은 미스터트롯 대국민 감사콘서트’서울 공연의 뜨거웠던 무대 실황과 그 너머, TOP6의 매력적인 일상이 선물처럼 찾아온다. 다시 한번 펼쳐질 그들의 찬란한 꿈, 다시 한번 위로를 건넬 우리의 빛나는 동행.', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/9QUOy74JTw8" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '위플래쉬.jpg', '위플래쉬 (Whiplash)', '드라마', '2015.03.12', '데이미언 셔젤 (Damien Chazelle)', '마일드 텔러, J.K. 시몬스 멜리사 베노이스트 등', '뉴욕의 명문 셰이퍼 음악학교에서 최고의 스튜디오 밴드에 들어가게 된 신입생 ‘앤드류’ 최고의 지휘자이지만 동시에 최악의 폭군인 ‘플레쳐’교수는 폭언과 학대로 ‘앤드류’를 한계까지 몰아붙이고 또 몰아붙인다. 드럼 주위로 뚝뚝 떨어지는 피, 빠르게 달리는 선율 뒤로 아득해지는 의식, 그 순간, 드럼에 대한 앤드류의 집착과 광기가 폭발한다. 최고의 연주를 위한 완벽한 스윙이 시작된다!', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/tvR7mbk65qk" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '테넷.jpg', '테넷 (Tenet)', '액션', '2020.08.26', '크리스토퍼 놀란 (Christopher Nolan)', '존 데이비드 워싱턴, 로버트 패틴슨, 엘리자베스 데비키 등', '시간의 흐름을 뒤집는 인버전을 통해 현재와 미래를 오가며 세상을 파괴하려는 사토르(케네스 브래너)를 막기 위해 투입된 작전의 주도자(존 데이비드 워싱턴). 인버전에 대한 정보를 가진 닐(로버트 패틴슨)과 미술품 감정사이자 사토르에 대한 복수심이 가득한 그의 아내 캣(엘리자베스 데비키)과 협력해 미래의 공격에 맞서 제3차 세계대전을 막아야 한다!', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/7oKAPbnl7mQ" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '더랍스터.jpg', '더 랍스터 (The labster)', '멜로/로맨스', '2015.10.29', '요르고스 란티모스 (Yorgos Lanthimos)', '콜린 파렐, 레이첼 와이즈, 레아 세두 등 ', '전대미문의 커플 메이킹 호텔! 이곳에선 사랑에 빠지지 않은 자, 모두 유죄! 유예기간 45일 안에 짝을 찾지 못하면 동물이 되어야 한다! 가까운 미래, 모든 사람들은 서로에게 완벽한 짝을 찾아야만 한다. 홀로 남겨진 이들은 45일간 커플 메이킹 호텔에 머무르며, 완벽한 커플이 되기 위한 교육을 받는다. 그럼에도 불구하고 짝을 얻지 못한 사람은 동물로 변해 영원히 숲 속에 버려지게 된다. 근시란 이유로 아내에게 버림받고 호텔로 오게 된 데이비드(콜린 파렐)는 새로운 짝을 찾기 위해 노력하지만 결국 참지 못하고 숲으로 도망친다. 숲에는 커플을 거부하고 혼자만의 삶을 선택한 솔로들이 모여 살고 있다. 솔로 생활을 유지하기 위한 그들의 절대규칙은 바로 절대 사랑에 빠지지 말 것! 아이러니하게도 데이비드는 사랑이 허락되지 않는 그곳에서 자신과 같이 근시를 가진 완벽한 짝(레이첼 와이즈)을 만나고 마는데..!', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/IacpphyPpNY" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '빌리엘리어트.jpg', '빌리 엘리어트 (Billy Elliot)', '드라마/가족/코미디', '2001.02.17', '스티븐 달드리 (Stephen Daldry)', '제이미 벨, 줄리 월터스, 게리 루이스 등', '빌리, 왜 발레를 하니? 그냥 기분이 좋아요. 하늘을 나는 새가 된 것처럼요! 영국 북부 탄광촌에 사는 11살 소년 빌리. 매일 복싱을 배우러 가는 체육관에서 우연히 발레 수업을 보게 된 그는 토슈즈를 신은 여학생들 뒤에서 동작을 따라한다.그에게 재능을 발견한 발레 선생님 윌킨슨 부인은 빌리에게 특별 수업을 해주고 로얄발레학교의 오디션을 보라고 권유한다. 발레는 여자들이나 하는 거라며 반대하는 아버지 몰래 신나게 춤을 추던 어느 날, 빌리는 불쑥 체육관에 찾아온 아버지와 맞닥뜨리게 되는데...', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/y1TF1ZcNzmg" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '지금만나러갑니다한국.jpg', '지금 만나러 갑니다', '멜로/로맨스', '2018.03.14', '이장훈', '소지섭, 손예진, 김지환 등', '비가 오는 날 다시 돌아오겠다는 믿기 힘든 약속을 남기고 세상을 떠난 ‘수아’. 그로부터 1년 뒤 장마가 시작되는 어느 여름 날, 세상을 떠나기 전과 다름없는 모습의 ‘수아’가 나타난다. 하지만 ‘수아’는 ‘우진’이 누구인지조차도 기억하지 못한다. 난, 너와 다시 사랑에 빠졌어. 자신을 기억하지 못해도 그녀가 곁에 있다는 사실만으로 행복에 젖은 ‘우진’과 자신이 기억하지 못하는 그와의 이야기가 궁금한 ‘수아’. ‘우진’이 들려주는 첫 만남, 첫 사랑, 첫 데이트, 첫 행복의 순간을 함께 나누며 ‘수아’는 ‘우진’과 다시 사랑에 빠지는데… 기다려 주세요 지금 만나러 갑니다.', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/TE3JUjexFJ8" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '캐롤.jpg', '캐롤 (Carol)', '드라마/멜로/로맨스', '2016.02.04', '토드 헤인즈 (Todd Haynes)', '케이트 블란쳇, 루니 마라, 카일 챈들러 등 ', '당신의 마지막, 나의 처음.. 모든 걸 내던질 수 있는 사랑1950년대 뉴욕, 맨해튼 백화점 점원인 테레즈(루니 마라)와 손님으로 찾아온 캐롤(케이트 블란쳇)은 처음 만난 순간부터 거부할 수 없는 강한 끌림을 느낀다. 하나뿐인 딸을 두고 이혼 소송 중인 캐롤과 헌신적인 남자친구가 있지만 확신이 없던 테레즈, 각자의 상황을 잊을 만큼 통제할 수 없이 서로에게 빠져드는 감정의 혼란 속에서 둘은 확신하게 된다. 인생의 마지막에, 그리고 처음으로 찾아온 진짜 사랑임을…', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/6b1tkL00hjU" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '기생충.jpg', '기생충', '드라마', '2019.05.30', '봉준호', '송강호, 이선균, 조여정 등 ', '“폐 끼치고 싶진 않았어요”전원백수로 살 길 막막하지만 사이는 좋은 기택(송강호) 가족. 장남 기우(최우식)에게 명문대생 친구가 연결시켜 준 고액 과외 자리는 모처럼 싹튼 고정수입의 희망이다. 온 가족의 도움과 기대 속에 박사장(이선균) 집으로 향하는 기우. 글로벌 IT기업 CEO인 박사장의 저택에 도착하자 젊고 아름다운 사모님 연교(조여정)가 기우를 맞이한다. 그러나 이렇게 시작된 두 가족의 만남 뒤로, 걷잡을 수 없는 사건이 기다리고 있었으니…', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/jBdRhhSt3Bc" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '뷰티인사이드.jpg', '뷰티 인사이드', '멜로/로맨스', '2015.08.20', '백종열', '한효주, 김대명, 도지한 등 ', '남자, 여자, 아이, 노인.. 심지어 외국인까지! 자고 일어나면 매일 다른 모습으로 변하는 남자, ‘우진’. 그에게 처음으로 비밀을 말하고 싶은 단 한 사람이 생겼다. 드디어 D-DAY! ‘우진’은 그녀에게 자신의 마음을 고백하기로 하는데…“초밥이 좋아요? 스테이크가 좋아요? 사실.. 연습 엄청 많이 했어요. 오늘 꼭 그쪽이랑 밥 먹고 싶어서…”', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/cBqkax8WFb8" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '라라랜드.jpg', '라라랜드 (La La Land)', '드라마', '2020.03.25', '데이미언 셔젤 (Damien Chazelle)', '라이언 고슬링, 엠마 스톤, 존 레전드 등', '황홀한 사랑, 순수한 희망, 격렬한 열정… 이 곳에서 모든 감정이 폭발한다! 꿈을 꾸는 사람들을 위한 별들의 도시 ‘라라랜드’. 재즈 피아니스트 ‘세바스찬’(라이언 고슬링)과 배우 지망생 ‘미아’(엠마 스톤), 인생에서 가장 빛나는 순간 만난 두 사람은 미완성인 서로의 무대를 만들어가기 시작한다.', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/Dt5hFexM5BI" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '그랜드부다페스트호텔.jpg', '그랜드 부다페스트 호텔 (The Grand Budapest Hotel)', '미스터리', '2014.03.20', '웨스 앤더슨 (Wes Anderson)', '랄프 파인즈, 틸다 스윈튼, 토니 레볼로리 등', '1927년 세계대전이 한창이던 어느 날, 세계 최고의 부호 마담 D.가 의문의 살인을 당한다.유력한 용의자로 지목된 사람은 바로 전설적인 호텔 지배인이자 그녀의 연인 ‘구스타브’!	구스타브는 누명을 벗기 위해 충실한 로비보이 ‘제로’에게 도움을 청하고, 그 사이 구스타브에게 남겨진 마담 D.의 유산을 노리던 그녀의 아들 ‘드미트리’는 무자비한 킬러를 고용해 [그랜드 부다페스트 호텔]을 찾게 되는데…', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/bBrTTSlCzNk" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '플립.jpg', '플립 (Flipped)', '멜로/로맨스', '2017.07.12', '로브 라이너 (Rob Reiner)', '매들린 캐롤, 캘런 맥오리피 등', '새로 이사 온 미소년 브라이스를 보고 첫눈에 사랑을 직감한 7살 소녀 줄리. 솔직하고 용감한 줄리는 자신의 마음을 적극적으로 표현하지만 브라이스는 그런 줄리가 마냥 부담스럽다.	줄리의 러브빔을 요리조리 피해 다니기를 6년! 브라이스는 줄리에게 받은 달걀을 쓰레기통에 버리다 들키고, 화가 난 줄리는 그날부터 브라이스를 피하기 시작한다. 하지만 성가신 그녀가 사라지자 브라이스는 오히려 전 같지 않게 줄리가 신경 쓰이기 시작하는데…', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/o8j70yHzTJs" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '히든피겨스.jpg', '히든 피겨스 (Hidden Figures)', '드라마', '2017.03.23', '데오도르 델피 (Theodore Melfi)', '타라지 P. 헨슨, 옥타비아 스펜서, 자넬 모네 등', '천부적인 수학 능력의 흑인 여성 캐서린 존슨 NASA 흑인 여성들의 리더이자 프로그래머 도로시 본 흑인 여성 최초의 NASA 엔지니어를 꿈 꾸는 메리 잭슨 미국과 러시아의 치열한 우주 개발 경쟁으로 보이지 않는 전쟁이 벌어지고 있던 시절, 천부적인 두뇌와 재능을 가진 그녀들이 NASA 최초의 우주궤도 비행 프로젝트에 선발된다. 하지만, 흑인이라는 이유로 800m 떨어진 유색인종 전용 화장실을 사용해야 하고, 여자라는 이유로 중요한 회의에 참석할 수 없으며, 공용 커피포트 조차 용납되지 않는 따가운 시선에 점점 지쳐 간다. 한편, 우주궤도 비행 프로젝트는 난항을 겪게 되고, 해결방법은 오직 하나, 비전을 제시할 수 있는 새로운 수학 공식을 찾아내는 것뿐인데…. 천재성에는 인종이 없고, 강인함에는 남녀가 없으며, 용기에는 한계가 없다! 세계를 놀라게 한 그녀들의 이야기가 시작된다.', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/ItSUOpH4A5w" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '우리들.jpg', '우리들', '드라마', '2016.06.16', '윤가은', '최수인, 설혜인, 이서연 등', '그 여름, 나에게도 친구가 생겼다… “내 마음이 들리니”언제나 혼자인 외톨이 선은 모두가 떠나고 홀로 교실에 남아있던 방학식 날, 전학생 지아를 만난다. 서로의 비밀을 나누며 순식간에 세상 누구보다 친한 사이가 된 선과 지아는 생애 가장 반짝이는 여름을 보내는데, 개학 후 학교에서 만난 지아는 어쩐 일인지 선에게 차가운 얼굴을 하고 있다. 선을 따돌리는 보라의 편에 서서 선을 외면하는 지아와 다시 혼자가 되고 싶지 않은 선. 어떻게든 관계를 회복해보려 노력하던 선은 결국 지아의 비밀을 폭로해버리고 마는데... 선과 지아. 우리는 다시 ‘우리’가 될 수 있을까?', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/17UdBIj-TTM" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '부산행.jpg', '부산행', '액션,스릴러', '2016.07.20', '연상호', '공유, 정유미, 마동석 등', '정체불명의 바이러스가 전국으로 확산되고 대한민국 긴급재난경보령이 선포된 가운데, 열차에 몸을 실은 사람들은 단 하나의 안전한 도시 부산까지 살아가기 위한 치열한 사투를 벌이게 된다. 서울에서 부산까지의 거리 442KM 지키고 싶은, 지켜야만 하는 사람들의 극한의 사투!', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/UOTOjA0ngmk" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '극한직업.jpg', '극한직업', '코미디', '2019.01.23', '이병헌', '류승룡, 이하늬, 진선규 등', '불철주야 달리고 구르지만 실적은 바닥,급기야 해체 위기를 맞는 마약반! 더 이상 물러설 곳이 없는 팀의 맏형 고반장은 국제 범죄조직의 국내 마약 밀반입 정황을 포착하고 장형사, 마형사, 영호, 재훈까지 4명의 팀원들과 함께 잠복 수사에 나선다. 마약반은 24시간 감시를 위해 범죄조직의 아지트 앞 치킨집을 인수해 위장 창업을 하게 되고, 뜻밖의 절대미각을 지닌 마형사의 숨은 재능으로 치킨집은 일약 맛집으로 입소문이 나기 시작한다. 수사는 뒷전, 치킨장사로 눈코 뜰 새 없이 바빠진 마약반에게 어느 날 절호의 기회가 찾아오는데… 범인을 잡을 것인가, 닭을 잡을 것인가!!', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/BaIRaKXrLPk" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '지금만나러갑니다일본.jpg', '지금 만나러 갑니다', '멜로/로맨스', '2005.03.25', '도이 노부히로', '다케우치 유코, 나카무라 시도, 다케이 아카시 등', '남편 ‘타쿠미’와 아들 ‘유우지’에게 비의 계절에 다시 돌아오겠다는 약속을 남기고 세상을 떠난 ‘미오’. 어느 날, 두 사람 앞에 거짓말처럼 이전의 모든 기억을 잃은 ‘미오’가 나타난다. 미오’와 함께 새로운 사랑을 시작하는 ‘타쿠미’, 그리고 엄마의 품에서 행복을 느끼는 ‘유우지’. 하지만 ‘미오’는 비의 계절이 끝나면 떠나야 하는 자신의 운명을 알게 되는데…  가족의 특별한 비밀, 그리고 사랑이 만든 기적 같은 순간….“사랑하기 때문에… 지금, 만나러 갑니다”', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/3aXwfdMFh0U" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '어벤져스엔드게임.jpg', '어벤져스: 엔드게임 (Avengers: Endgame)','액션','2019.04.24','안소니 루소 (Anthony Russo) ','로버트 다우니 주니어, 크리스 에반스, 크리스 헴스워스 등','인피니티 워 이후 절반만 살아남은 지구 마지막 희망이 된 어벤져스 먼저 떠난 그들을 위해 모든 것을 걸었다! 위대한 어벤져스 운명을 바꿀 최후의 전쟁이 펼쳐진다!', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/Ko2NWhXI9e8" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '겨울왕국.jpg', '겨울왕국 (Frozen)','애니메이션','2014.01.16','크리스 벅 (Chris Buck)','크리스틴 벨, 이디나 멘젤, 조시 게드 등','서로가 최고의 친구였던 자매 ‘엘사’와 ‘안나’. 하지만 언니 ‘엘사’에게는 하나뿐인 동생에게조차 말 못할 비밀이 있다. 모든 것을 얼려버리는 신비로운 힘이 바로 그것. ‘엘사’는 통제할 수 없는 자신의 힘이 두려워 왕국을 떠나고, 얼어버린 왕국의 저주를 풀기 위해 ‘안나’는 언니를 찾아 환상적인 여정을 떠나는데……', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/bbh1NIpDo-c" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '그녀.jpg', '그녀 (Her)','드라마','2014.05.22','스파이크 존즈 (Spike Jonze)','호아킨 피닉스, 에이미 아담스, 루니 마라','다른 사람의 편지를 써주는 대필 작가로 일하고 있는 ‘테오도르’는 타인의 마음을 전해주는 일을 하고 있지만 정작 자신은 아내와 별거 중인 채 외롭고 공허한 삶을 살아가고 있다. 어느 날, 스스로 생각하고 느끼는 인공지능 운영체제 ‘사만다’를 만나게 되고, 자신의 말에 귀를 기울이며 이해해주는 ‘사만다’로 인해 조금씩 상처를 회복하고 행복을 되찾기 시작한 ‘테오도르’는 어느새 점점 그녀에게 사랑의 감정을 느끼게 되는데...', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/NHA69lCd1ZM" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '말할수없는비밀.jpg', '말할 수 없는 비밀 ','멜로/로맨스','2008.01.10','주걸륜','주걸륜, 계륜미, 황추생 등','나는 너를 사랑해!너도 나를 사랑하니? 예술학교로 전학 온 상륜(주걸륜)은 아버지의 영향을 받아 피아노에 천부적인 소질을 보인다. 학교를 둘러보던 중, 신비스러운 피아노 연주가 흘러나오는 옛 음악실을 발견하게 되고, 그곳에서 샤오위(계륜미)를 만난다. 그들은 아름다운 피아노 선율처럼 즐거운 시간을 보내고, 둘 사이에는 애틋한 마음이 싹튼다. 그러나 상륜이 샤오위를 더 알고 싶어할 때마다 그녀는 비밀이라고 일관하며 의미심장한 미소만 짓는다. 그러던 어느 날, 샤오위는 상륜이 같은 반 여학생 칭요와 뽀뽀하는 모습을 보게 되고, 그의 곁에서 사라지는데…', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/Ceoe2wf-bbo" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '어바웃타임.jpg', '어바웃 타임 (About Time)','멜로/로맨스','2013.12.05','리차드 커티스 (Richard Curtis)','도널 글리슨, 레이첼 맥아담스, 빌 나이 등','모태솔로 팀(돔놀 글리슨)은 성인이 된 날, 아버지(빌 나이)로부터 놀랄만한 가문의 비밀을 듣게 된다. 바로 시간을 되돌릴 수 있는 능력이 있다는 것! 그것이 비록 히틀러를 죽이거나 여신과 뜨거운 사랑을 할 수는 없지만, 여자친구는 만들어 줄 순 있으리.. 꿈을 위해 런던으로 간 팀은 우연히 만난 사랑스러운 여인 메리에게 첫눈에 반하게 된다. 그녀의 사랑을 얻기 위해 자신의 특별한 능력을 마음껏 발휘하는 팀. 어설픈 대시, 어색한 웃음은 리와인드! 뜨거웠던 밤은 더욱 뜨겁게 리플레이! 꿈에 그리던 그녀와 매일매일 최고의 순간을 보낸다. 하지만 그와 그녀의 사랑이 완벽해질수록 팀을 둘러싼 주변 상황들은 미묘하게 엇갈리고, 예상치 못한 사건들이 여기저기 나타나기 시작하는데… 어떠한 순간을 다시 살게 된다면, 과연 완벽한 사랑을 이룰 수 있을까?', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/tnyWkyDGWuM" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '파수꾼.jpg', '파수꾼','드라마','2011.03.03','윤성현','이제훈, 서준영, 박정민 등','한 소년이 죽었다. 평소 아들에게 무심했던 소년의 아버지(조성하)는 아들의 갑작스런 공백에 매우 혼란스러워하며 뒤늦은 죄책감과 무력함에, 아들 기태(이제훈)의 죽음을 뒤쫓기 시작한다. 아들의 책상 서랍 안, 소중하게 보관되어 있던 사진 속에는 동윤(서준영)과 희준(박정민)이 있다. 하지만 학교를 찾아가 겨우 알아낸 사실은 한 아이는 전학을 갔고 한 아이는 장례식장에 오지도 않았다는 것. 뭔가 이상하다. 그러던 중, 간신히 찾아낸 희준은 ‘기태와 제일 친했던 것은 동윤’이라고 말하며 자세한 대답을 회피한다. 결국 아버지의 부탁으로 동윤을 찾아나선 희준. 하지만, 학교를 자퇴하고 떠나버린 친구는 어디에도 없다. 천진하고 순수했던 그 시절, 미성숙한 소통의 오해가 불러 일으킨 비극적 파국. 독단적 우정이 가져온 폭력과 그 상처의 전염은 우리를 아프고 충격적인 결말로 이끌어간다. 서로가 전부였던 이 세 친구들 사이에서 과연 무슨 일이 벌어진 걸까?', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/D6E2WRBUIMg" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '세얼간이.jpg', '세 얼간이 (3 Idiots)','코미디','2011.08.18','라지쿠마르 히라니 (Rajkumar Hirani)','아미르 칸, 마드하반, 셔먼 조쉬 등','천재들만 간다는 일류 명문대 ICE, 성적과 취업만을 강요하는 학교를 발칵 뒤집어 놓은 대단한 녀석 란초! 아버지가 정해준 꿈, `공학자`가 되기 위해 정작 본인이 좋아하는 일은 포기하고 공부만하는 파파보이 파르한! 찢어지게 가난한 집, 병든 아버지와 식구들을 책임지기 위해 무조건 대기업에 취직해야만 하는 라주! 친구의 이름으로 뭉친 `세 얼간이`! 삐딱한 천재들의 진정한 꿈을 찾기 위한 세상 뒤집기 한판이 시작된다!', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/vtyuYXrJDrI" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '노팅힐.jpg', '노팅힐 (Notting Hill)','멜로/로맨스','1999.07.03','로저 미첼 (Roger Michell)','줄리아 로버츠, 휴 그랜트, 휴 보네빌 등','세계적인 스타이자 지구상에서 가장 아름다운 여자 ‘애나 스콧’ 런던의 노팅 힐에서 여행 전문 서점을 운영하는 남자 ‘윌리엄 태커’ 아주 평범한 사랑을 기다리는 그녀와 너무 특별한 사랑이 두려운 그의 꿈 같은 로맨스가 다시, 시작된다! 여기 노팅 힐에서…', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/gPhXjrDANGk" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '써니.jpg', '써니','코미디','2011.05.04','강형철','유호정, 심은경, 강소라 등','전라도 벌교 전학생 나미는 긴장하면 터져 나오는 사투리 탓에 첫날부터 날라리들의 놀림감이 된다. 이때 범상치 않는 포스의 친구들이 어리버리한 그녀를 도와주는데… 그들은 진덕여고 의리짱 춘화, 쌍꺼풀에 목숨 건 못난이 장미, 욕배틀 대표주자 진희, 괴력의 다구발 문학소녀 금옥, 미스코리아를 꿈꾸는 사차원 복희 그리고 도도한 얼음공주 수지. 나미는 이들의 새 멤버가 되어 경쟁그룹 ‘소녀시대’와의 맞짱대결에서 할머니로부터 전수받은 사투리 욕 신공으로 위기상황을 모면하는 대활약을 펼친다. 일곱 명의 단짝 친구들은 언제까지나 함께 하자는 맹세로 칠공주 ‘써니’를 결성하고 학교축제 때 선보일 공연을 야심차게 준비하지만 축제 당일, 뜻밖의 사고가 일어나 뿔뿔이 흩어지게 된다. 그로부터 25년 후, 잘 나가는 남편과 예쁜 딸을 둔 나미의 삶은 무언가 2프로 부족하다.', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/v8yKqG7ibd0" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '보헤미안랩소디.jpg', '보헤미안 랩소디 (Bohemian Rhapsody)', '드라마', '2018.10.31', '브라이언 싱어 (Bryan Singer)', '라미 말렉, 루시 보인턴, 귈림 리 등 ', '공항에서 수하물 노동자로 일하며 음악의 꿈을 키우던 이민자 출신의 아웃사이더 ‘파록버사라’ 보컬을 구하던 로컬 밴드에 들어가게 되면서 ‘프레디 머큐리’라는 이름으로 밴드 ‘퀸’을 이끌게 된다. 시대를 앞서가는 독창적인 음악과 화려한 퍼포먼스로 관중들을 사로잡으며 성장하던 ‘퀸’은 라디오와 방송에서 외면을 받을 것이라는 음반사의 반대에도 불구하고 무려 6분 동안 이어지는 실험적인 곡 ‘보헤미안 랩소디’로 대성공을 거두며 월드스타 반열에 오른다. 그러나 독보적인 존재감을 뿜어내던 ‘프레디 머큐리’는 솔로 데뷔라는 유혹에 흔들리게 되고 결국 오랜 시간 함께 해왔던 멤버들과 결별을 선언하게 되는데… 세상에서 소외된 아웃사이더에서 전설의 록밴드 ‘퀸’이 되기까지, 우리가 몰랐던 그들의 진짜 이야기가 시작된다!', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/XTZko22Ze3o" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '베테랑.jpg', '베테랑', '액션', '2015.08.05', '류승완', '황정민, 유아인, 유해진 등', '한 번 꽂힌 것은 무조건 끝을 보는 행동파 ‘서도철’(황정민), 20년 경력의 승부사 ‘오팀장’(오달수), 위장 전문 홍일점 ‘미스봉’(장윤주), 육체파 ‘왕형사’(오대환), 막내 ‘윤형사’(김시후)까지 겁 없고, 못 잡는 것 없고, 봐 주는 것 없는 특수 강력사건 담당 광역수사대. 오랫동안 쫓던 대형 범죄를 해결한 후 숨을 돌리려는 찰나, 서도철은 재벌 3세 ‘조태오’(유아인)를 만나게 된다. 세상 무서울 것 없는 안하무인의 조태오와 언제나 그의 곁을 지키는 오른팔 ‘최상무’(유해진). 서도철은 의문의 사건을 쫓던 중 그들이 사건의 배후에 있음을 직감한다. 건들면 다친다는 충고에도 불구하고 포기하지 않는 서도철의 집념에 판은 걷잡을 수 없이 커져가고 조태오는 이를 비웃기라도 하듯 유유히 포위망을 빠져 나가는데… 베테랑 광역수사대 VS 유아독존 재벌 3세 2015년 여름, 자존심을 건 한판 대결이 시작된다!', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/hcKp68DtBb0" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '인터스텔라.jpg', '인터스텔라 (Interstellar)', 'SF', '2014.11.06', '크리스토퍼 놀란 (Christopher Nolan) ', '매튜 맥커너히, 앤 해서웨이, 마이클 케인 등', '세계 각국의 정부와 경제가 완전히 붕괴된 미래가 다가온다. 지난 20세기에 범한 잘못이 전 세계적인 식량 부족을 불러왔고, NASA도 해체되었다. 이때 시공간에 불가사의한 틈이 열리고, 남은 자들에게는 이 곳을 탐험해 인류를 구해야 하는 임무가 지워진다. 사랑하는 가족들을 뒤로 한 채 인류라는 더 큰 가족을 위해, 그들은 이제 희망을 찾아 우주로 간다. 그리고 우린 답을 찾을 것이다. 늘 그랬듯이…', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/d2VN6NNa9BE" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '이터널선샤인.jpg', '이터널 선샤인 (Eternal Sunshine)', '멜로/로맨스', '2005.11.10', '미셸 공드리 (Michel Gondry) ', '짐 캐리, 케이트 윈슬렛, 커스틴 던스트 등', '조엘은 아픈 기억만을 지워준다는 라쿠나사를 찾아가 헤어진 연인 클레멘타인의 기억을 지우기로 결심한다. 기억이 사라져 갈수록 조엘은 사랑이 시작되던 순간, 행복한 기억들, 가슴 속에 각인된 추억들을 지우기 싫어지기만 하는데... 당신을 지우면 이 아픔도 사라질까요? 사랑은 그렇게 다시 기억된다.', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/qmth-PGDD0Q" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '동주.jpg', '동주', '드라마', '2016.02.17', '이준익', '강하늘, 박정민, 김인우 등', '이름도, 언어도, 꿈도, 모든 것이 허락되지 않았던 일제강점기. 한 집에서 태어나고 자란 동갑내기 사촌지간 동주와 몽규. 시인을 꿈꾸는 청년 동주에게 신념을 위해 거침없이 행동하는 청년 몽규는 가장 가까운 벗이면서도, 넘기 힘든 산처럼 느껴진다. 창씨개명을 강요하는 혼란스러운 나라를 떠나 일본 유학 길에 오른 두 사람. 일본으로 건너간 뒤 몽규는 더욱 독립 운동에 매진하게 되고, 절망적인 순간에도 시를 쓰며 시대의 비극을 아파하던 동주와의 갈등은 점점 깊어진다. 어둠의 시대, 평생을 함께 한 친구이자 영원한 라이벌이었던 윤동주와 송몽규의 끝나지 않은 이야기가 지금 시작된다.', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/bcTsa0ZEnzM" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '러브액츄얼리.jpg', '러브 액츄얼리 (Love Actually)', '멜로/로맨스', '2003.12.05', '리차드 커티스 (Richard Curtis)', '휴 그랜트, 리암 니슨, 콜린 퍼스 등', '사랑에 상처받은 당신을 위해, 사랑하지만 말하지 못했던 당신을 위해, 사랑에 확신하지 못했던 당신을 위해, 모두의 마음을 따뜻하게 할 선물이 찾아옵니다.', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/K-mdSC6jujU" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '트루먼쇼.jpg', '트루먼 쇼 (The Truman Show)', '코미디', '1998.10.24', '피터 위어 (Peter Weir)', '짐 캐리, 에드 해리스, 로라 리니 등', '작은 섬에서 평범한 삶을 사는 30세 보험회사원 트루먼 버뱅크 아내와 홀어머니를 모시고 행복한 하루 하루를 보내던 어느 날, 하늘에서 조명이 떨어진다! 의아해하던 트루먼은 길을 걷다 죽은 아버지를 만나고 라디오 주파수를 맞추다 자신의 일거수일투족이 라디오에 생중계되는 기이한 일들을 연이어 겪게 된다. 지난 30년간 일상이라고 믿었던 모든 것들이 어딘가 수상하다고 느낀 트루먼은 모든 것이 ‘쇼’라는 말을 남기고 떠난 첫사랑 ‘실비아’를 찾아 피지 섬으로 떠나기로 결심한다. 가족, 친구, 회사… 하나부터 열까지 모든 것이 가짜인 ‘트루먼 쇼’ 과연 트루먼은 진짜 인생을 찾을 수 있을까?', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/mYkp9IqhluY" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '벌새.jpg', '벌새', '드라마', '2019.08.29', '김보라', '박지후, 김새벽, 정인기 등', '나는 이 세계가 궁금했다 1994년, 알 수 없는 거대한 세계와 마주한 14살 ‘은희’의 아주- 보편적이고 가장- 찬란한 기억의 이야기', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/c7mypsyhLfA" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '엑시트.jpg', '엑시트', '액션', '2019.07.31', '이상근', '조정석, 윤아, 고두심 등', '대학교 산악 동아리 에이스 출신이지만 졸업 후 몇 년째 취업 실패로 눈칫밥만 먹는 용남은 온 가족이 참석한 어머니의 칠순 잔치에서 연회장 직원으로 취업한 동아리 후배 의주를 만난다 어색한 재회도 잠시, 칠순 잔치가 무르익던 중 의문의 연기가 빌딩에서 피어 오르며 피할 새도 없이 순식간에 도심 전체는 유독가스로 뒤덮여 일대혼란에 휩싸이게 된다. 용남과 의주는 산악 동아리 시절 쌓아 뒀던 모든 체력과 스킬을 동원해 탈출을 향한 기지를 발휘하기 시작하는데…', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/M2_7wzCXun8" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '명량.jpg', '명량', '액션', '2014.07.30', '김한민', '최민식, 류승룡, 조진웅 등', '1597년 임진왜란 6년, 오랜 전쟁으로 인해 혼란이 극에 달한 조선. 무서운 속도로 한양으로 북상하는 왜군에 의해 국가존망의 위기에 처하자 누명을 쓰고 파면 당했던 이순신 장군(최민식)이 삼도수군통제사로 재임명된다. 하지만 그에게 남은 건 전의를 상실한 병사와 두려움에 가득 찬 백성, 그리고 12척의 배 뿐. 마지막 희망이었던 거북선마저 불타고 잔혹한 성격과 뛰어난 지략을 지닌 용병 구루지마(류승룡)가 왜군 수장으로 나서자 조선은 더욱 술렁인다. 330척에 달하는 왜군의 배가 속속 집결하고 압도적인 수의 열세에 모두가 패배를 직감하는 순간, 이순신 장군은 단 12척의 배를 이끌고 명량 바다를 향해 나서는데…! 12척의 조선 vs 330척의 왜군 역사를 바꾼 위대한 전쟁이 시작된다!', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/spQtwggaCy4" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '인사이드아웃.jpg', '인사이드 아웃 (Inside Out)', '애니메이션', '2015.07.09', '피트 닥터 (Pete Docter)', '에이미 포엘러, 필리스 스미스, 민디 캘링 등', '모든 사람의 머릿속에 존재하는 감정 컨트롤 본부 그곳에서 불철주야 열심히 일하는 기쁨, 슬픔, 버럭, 까칠, 소심 다섯 감정들. 이사 후 새로운 환경에 적응해야 하는 ‘라일리’를 위해 그 어느 때 보다 바쁘게 감정의 신호를 보내지만 우연한 실수로 ‘기쁨’과 ‘슬픔’이 본부를 이탈하게 되자 ‘라일리’의 마음 속에 큰 변화가 찾아온다. ‘라일리’가 예전의 모습을 되찾기 위해서는 ‘기쁨’과 ‘슬픔’이 본부로 돌아가야만 한다! 그러나 엄청난 기억들이 저장되어 있는 머릿속 세계에서 본부까지 가는 길은 험난하기만 한데… 과연, ‘라일리’는 다시 행복해질 수 있을까? 지금 당신의 머릿속에서 벌어지는 놀라운 일! 하루에도 몇번씩 변하는 감정의 비밀이 밝혀진다!', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/1KGZtWbZtq8" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('w', '비긴어게인.jpg', '비긴 어게인 (Begin Again)', '드라마', '2014.08.13', '존 카니 (John Carney)', '키이라 나이틀리, 마크 러팔로, 애덤 리바인 등', '싱어송라이터인 ‘그레타’(키이라 나이틀리)는 남자친구 ‘데이브’(애덤 리바인)가 메이저 음반회사와 계약을 하게 되면서 뉴욕으로 오게 된다. 그러나 행복도 잠시, 오랜 연인이자 음악적 파트너로서 함께 노래를 만들고 부르는 것이 좋았던 그레타와 달리 스타가 된 데이브의 마음은 어느새 변해버린다. 스타 음반프로듀서였지만 이제는 해고된 ‘댄’(마크 러팔로)은 미치기 일보직전 들른 뮤직바에서 그레타의 자작곡을 듣게 되고 아직 녹슬지 않은 촉을 살려 음반제작을 제안한다. 거리 밴드를 결성한 그들은 뉴욕의 거리를 스튜디오 삼아 진짜로 부르고 싶었던 노래를 만들어가는데…', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/MQMmng1qGOE" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '신과함께죄와벌.jpg', '신과함께-죄와 벌', '판타지', '2017.12.20', '김용화', '하정우, 차태현, 주지훈 등', '저승 법에 의하면, 모든 인간은 사후 49일 동안 7번의 재판을 거쳐야만 한다. 살인, 나태, 거짓, 불의, 배신, 폭력, 천륜 7개의 지옥에서 7번의 재판을 무사히 통과한 망자만이 환생하여 새로운 삶을 시작할 수 있다. “김자홍 씨께선, 오늘 예정 대로 무사히 사망하셨습니다” 화재 사고 현장에서 여자아이를 구하고 죽음을 맞이한 소방관 자홍, 그의 앞에 저승차사 해원맥과 덕춘이 나타난다. 자신의 죽음이 아직 믿기지도 않는데 덕춘은 정의로운 망자이자 귀인이라며 그를 치켜세운다. 저승으로 가는 입구, 초군문에서 그를 기다리는 또 한 명의 차사 강림, 그는 차사들의 리더이자 앞으로 자홍이 겪어야 할 7개의 재판에서 변호를 맡아줄 변호사이기도 하다. 염라대왕에게 천년 동안 49명의 망자를 환생시키면 자신들 역시 인간으로 환생시켜 주겠다는 약속을 받은 삼차사들, 그들은 자신들이 변호하고 호위해야 하는 48번째 망자이자 19년 만에 나타난 의로운 귀인 자홍의 환생을 확신하지만, 각 지옥에서 자홍의 과거가 하나 둘씩 드러나면서 예상치 못한 고난과 맞닥뜨리는데… 누구나 가지만 아무도 본 적 없는 곳, 새로운 세계의 문이 열린다!', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/5O5PVvHTWRo" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('k', '신세계.jpg', '신세계', '범죄', '2013.02.21', '박훈정', '이정재, 최민식, 황정민 등', '"너, 나하고 일 하나 같이 하자" 경찰청 수사 기획과 강과장(최민식)은 국내 최대 범죄 조직인 ‘골드문’이 기업형 조직으로 그 세력이 점점 확장되자 신입경찰 이자성(이정재)에게 잠입 수사를 명한다. 그리고 8년, 자성은 골드문의 2인자이자 그룹 실세인 정청(황정민)의 오른팔이 되기에 이른다. "우리 브라더는 그냥 딱, 이 형님만 믿으면 돼야!" 골드문 회장이 갑자기 사망하자, 강과장(최민식)은 후계자 결정에 직접 개입하는 ‘신세계’ 작전을 설계한다. 피도 눈물도 없는 후계자 전쟁의 한 가운데, 정청(황정민)은 8년 전, 고향 여수에서 처음 만나 지금까지 친형제처럼 모든 순간을 함께 해 온 자성(이정재)에게 더욱 강한 신뢰를 보낸다. "약속 했잖습니까... 이번엔 진짜 끝이라고" 한편, 작전의 성공만 생각하는 강과장(최민식)은 계속해서 자성(이정재)의 목을 조여만 간다. 시시각각 신분이 노출될 위기에 처한 자성(이정재)은 언제 자신을 배신할 지 모르는 경찰과, 형제의 의리로 대하는 정청(황정민) 사이에서 갈등하게 되는데…', '<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/rvLMVcRkRfY" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
;

insert into movieclip
(movievideo)
values ('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/4fPWyBLkk6o" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/BHGHKoX-qSw" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/fWZcwe6TBWg" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/AF4IzD6aVU4" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/9QUOy74JTw8" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/tvR7mbk65qk" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/7oKAPbnl7mQ" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/IacpphyPpNY" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/y1TF1ZcNzmg" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/TE3JUjexFJ8" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/6b1tkL00hjU" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/jBdRhhSt3Bc" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/cBqkax8WFb8" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/Dt5hFexM5BI" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/bBrTTSlCzNk" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/o8j70yHzTJs" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/ItSUOpH4A5w" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/17UdBIj-TTM" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/UOTOjA0ngmk" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/BaIRaKXrLPk" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/3aXwfdMFh0U" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/Ko2NWhXI9e8" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/bbh1NIpDo-c" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/NHA69lCd1ZM" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/Ceoe2wf-bbo" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/tnyWkyDGWuM" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/D6E2WRBUIMg" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/vtyuYXrJDrI" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/gPhXjrDANGk" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/v8yKqG7ibd0" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/XTZko22Ze3o" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/hcKp68DtBb0" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/d2VN6NNa9BE" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/qmth-PGDD0Q" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/bcTsa0ZEnzM" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/waBB11rlSXw" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/mYkp9IqhluY" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/c7mypsyhLfA" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/M2_7wzCXun8" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/spQtwggaCy4" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/1KGZtWbZtq8" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/MQMmng1qGOE" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/rvLMVcRkRfY" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
('<iframe class="clip" width="500" height="300" src="https://www.youtube.com/embed/5O5PVvHTWRo" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
;



insert into movieimg
(mv_no, mv_img, mv_title) 
values (1, '도굴.jpg', '도굴'),
(2, '삼진그룹영어토익반.jpg', '삼진그룹 영어토익반'),
(3, '담보.jpg', '담보'),
(4, '노트북.jpg', '노트북'),
(5, '미스터트롯더무비.jpg', '미스터트롯: 더 무비'),
(6, '위플래쉬.jpg', '위플래쉬'),
(7, '테넷.jpg', '테넷'),
(8, '더랍스터.jpg', '더 랍스터'),
(9, '빌리엘리어트.jpg', '빌리 엘리어트'),
(10, '지금만나러갑니다한국.jpg', '지금 만나러 갑니다'),
(11, '캐롤.jpg', '캐롤'),
(12, '기생충.jpg', '기생충'),
(13, '뷰티인사이드.jpg', '뷰티인사이드'),
(14, '라라랜드.jpg', '라라랜드'),
(15, '그랜드부다페스트호텔.jpg', '그랜드 부다페스트 호텔'),
(16, '플립.jpg', '플립'),
(17, '히든피겨스.jpg', '히든 피겨스'),
(18, '우리들.jpg', '우리들'),
(19, '부산행.jpg', '부산행'),
(20, '극한직업.jpg', '극한직업'),
(21, '지금만나러갑니다일본.jpg', '지금 만나러 갑니다'),
(22, '어벤져스엔드게임.jpg', '어벤져스: 엔드게임'),
(23, '겨울왕국.jpg', '겨울왕국'),
(24, '그녀.jpg', '그녀'),
(25, '말할수없는비밀.jpg', '말할 수 없는 비밀'),
(26, '어바웃타임.jpg', '어바웃타임'),
(27, '파수꾼.jpg', '파수꾼'),
(28, '세얼간이.jpg', '세 얼간이'),
(29, '노팅힐.jpg', '노팅 힐'),
(30, '써니.jpg', '써니'),
(31, '보헤미안랩소디.jpg', '보헤미안 랩소디'),
(32, '베테랑.jpg', '베테랑'),
(33, '인터스텔라.jpg', '인터스텔라'),
(34, '이터널선샤인.jpg', '이터널 선샤인'),
(35, '동주.jpg', '동주'),
(36, '러브액츄얼리.jpg', '러브 액츄얼리'),
(37, '트루먼쇼.jpg', '트루먼 쇼'),
(38, '벌새.jpg', '벌새'),
(39, '엑시트.jpg', '엑시트'),
(40, '명량.jpg', '명량'),
(41, '인사이드아웃.jpg', '인사이드 아웃'),
(42, '비긴어게인.jpg', '비긴 어게인'),
(43, '신세계.jpg', '신세계'),
(44, '신과함께죄와벌.jpg', '신과 함께-죄와 벌');


insert into user
(id,pw)
values
('abcd','1234'),
('eunhye','7942');

insert into review
(id, mv_no, rv_title, rv_body, rv_date)
values
('abcd',44,'신세계 추천','신세계 너무 재밌어요.1',now()),
('abcd',44,'신세계 추천','신세계 너무 재밌어요.2',now()),
('aa',44,'신세계 추천','신세계 너무 재밌어요.3',now()),
('aa',44,'신세계 추천','신세계 너무 재밌어요.4',now()),
('aa',44,'신세계 추천','신세계 너무 재밌어요.5',now()),
('abcd',44,'신세계 추천','신세계 너무 재밌어요.6',now());



insert into comment
(id, rv_no, mv_no, c_body, c_date)
values
('abcd',1,44,'맞아요!',now()),
('abcd',2,44,'하하!',now()),
('abcd',3,44,'호호!',now()),
('abcd',4,44,'피곤!',now()),
('abcd',5,44,'하하ㅏㅎ하ㅏㅎ!',now());
