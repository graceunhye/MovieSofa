-- insert문 예시 및 샘플

insert into user
(id, pw, name, num, postNum, addr, email)
values
("skylibrary", "1234", "회원", "010-1111-1111", "12345", "전주시 덕진구", "skylibrary@naver.com"),
("sample", "1234", "멤버", "010-2222-2222", "23456", "전주시 완산구", "sample@daum.net");


insert into book
(isbn, subject, story, company, writer, pdate)
value
("9788995886441", "프린세스 엠마", "『프린세스 엠마』는「개구리 왕자」이야기를 모티브로 한 작품이다. 
주인공인 프린세스 엠마는 개구리에게 키스를 해 주지만 개구리의 마법이 풀리기는 커녕 오히려 엠마가 개구리로 변해 버리게 
되는 이야기다. 이런 기가막힌 반전은 독자에게 책을 읽는 재미를 선사한다. 프린세스 엠마는 마법에 걸린 왕자를 도와주
려다 오히려 개구리로 변하게 되는 난처한 입장에 빠진다. 처음에는 너무 놀라고 실망스러워 어찌할 바를 모르지만 차츰 상황
에 적응하고 위기를 극복할 방법을 찾아나선다. 이 때부터 씩씩하고 용기있는 프린세스 엠마의 모험이 펼쳐진다.", 
"개암나무", "E.D.베이커", "2007-05-04");

insert into manager
(mid, pw, name)
value
("ezen", "1234", "매니저");

insert into q
(id, title, body, wdate)
values
("skylibrary", "this is title", "this is body", now()),
("sample", "this is sample", "this is sample body", now());

insert into a
(no, mid, id, title, body, wdate)
value
(1, "ezen", "skylibrary", "this is answer", "this is answer body", now());

insert into notice
(mid, title, body)  -- 파일 제외
value
("ezen", "this is notice title", "this is notice body");

insert into rbook
(isbn, mid, subject, story, company, writer, pdate, why)