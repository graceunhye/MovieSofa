-- insert�� ���� �� ����

insert into user
(id, pw, name, num, postNum, addr, email)
values
("skylibrary", "1234", "ȸ��", "010-1111-1111", "12345", "���ֽ� ������", "skylibrary@naver.com"),
("sample", "1234", "���", "010-2222-2222", "23456", "���ֽ� �ϻ걸", "sample@daum.net");


insert into book
(isbn, subject, story, company, writer, pdate)
value
("9788995886441", "�������� ����", "���������� �������¡������� ���ڡ��̾߱⸦ ��Ƽ��� �� ��ǰ�̴�. 
���ΰ��� �������� ������ ���������� Ű���� �� ������ �������� ������ Ǯ����� Ŀ�� ������ ������ �������� ���� ������ 
�Ǵ� �̾߱��. �̷� �Ⱑ���� ������ ���ڿ��� å�� �д� ��̸� �����Ѵ�. �������� ������ ������ �ɸ� ���ڸ� ������
���� ������ �������� ���ϰ� �Ǵ� ��ó�� ���忡 ������. ó������ �ʹ� ���� �Ǹ������� ������ �ٸ� ������ ���� ��Ȳ
�� �����ϰ� ���⸦ �غ��� ����� ã�Ƴ�����. �� ������ �����ϰ� ����ִ� �������� ������ ������ ��������.", 
"���ϳ���", "E.D.����Ŀ", "2007-05-04");

insert into manager
(mid, pw, name)
value
("ezen", "1234", "�Ŵ���");

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
(mid, title, body)  -- ���� ����
value
("ezen", "this is notice title", "this is notice body");

insert into rbook
(isbn, mid, subject, story, company, writer, pdate, why)