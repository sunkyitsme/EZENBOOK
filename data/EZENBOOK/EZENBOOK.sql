-----------------
--EZENBOOK(SQL)--
-----------------

--���� ������ �Է½� ��ü���� ��� ������� �ʱ�
set define off;

--------------------------------------
-- GRADE ���̺�
DROP TABLE grade CASCADE CONSTRAINTS;

CREATE TABLE grade(
	gradeNo NUMBER(2) PRIMARY KEY,
	gradeName VARCHAR2(20) NOT NULL
);

-- GRADE ���̺� ���� ������
INSERT INTO grade(gradeNo, gradeName)
VALUES('1', '�Ϲ�ȸ��');
COMMIT;

INSERT INTO grade(gradeNo, gradeName)
VALUES('9', '������');
COMMIT;
--------------------------------------


--------------------------------------
-- MEMBER ���̺�
DROP TABLE member CASCADE CONSTRAINTS;

CREATE TABLE member(
	id VARCHAR2(20) PRIMARY KEY,
	pw VARCHAR2(20) NOT NULL,
	name VARCHAR2(30) NOT NULL,
	gender VARCHAR2(6) NOT NULL CHECK(gender in('����', '����')),
	birth DATE NOT NULL,
	tel VARCHAR2(13) NOT NULL,
	email VARCHAR2(50) NOT NULL,
	addr1 VARCHAR2(100) NOT NULL, 
	addr2 VARCHAR2(100) NOT NULL,
	addr3 VARCHAR2(100) NOT NULL,
	regDate DATE DEFAULT SYSDATE,
	status VARCHAR2(6) DEFAULT '����' check(status in('����','����','Ż��','�޸�')),
	gradeNo NUMBER(2) DEFAULT '1' REFERENCES grade(gradeNo)
);


-- MEMBER ���̺� ���� ������
INSERT INTO member(id, pw, name, gender, birth, tel, email, addr1, addr2, addr3, gradeNo)
VALUES('admin', '1234', '������', '����', '95/12/14', '010-1234-5678', 'admin@naver.com', '11671', '��� �����ν� �Ｑ�� 128���� 29-8', '201ȣ', 9);
COMMIT;

INSERT INTO member(id, pw, name, gender, birth, tel, email, addr1, addr2, addr3, gradeNo)
VALUES('itsmesunky', '1234', 'ȫ�浿', '����', '95/12/14', '010-1234-5678', 'test@naver.com',  '11671', '��� �����ν� �Ｑ�� 128���� 29-8', '201ȣ', 1);
COMMIT;
--------------------------------------


--------------------------------------
--BOOKS ���̺�
DROP TABLE books CASCADE CONSTRAINTS;
DROP SEQUENCE books_seq;

CREATE TABLE books(
	no NUMBER PRIMARY KEY,
	bookName VARCHAR2(50) NOT NULL,
	writer VARCHAR2(50) NOT NULL,
	publeYear DATE NOT NULL,
	publisher VARCHAR2(70) NOT NULL,
	bookPrice VARCHAR2(30) NOT NULL,
	content VARCHAR2(2000) NOT NULL,
   	fileName VARCHAR2(50) NOT NULL,
	id VARCHAR2(20) REFERENCES member(id),
	bookInfo VARCHAR2(2000) NOT NULL,
	bookStock NUMBER DEFAULT '99'
);

CREATE SEQUENCE books_seq;

-- BOOKS ���̺� ���� ������
INSERT INTO books(no, bookName, writer, publeYear, publisher, bookPrice, content, fileName, id, bookInfo, bookStock)
VALUES(books_seq.nextval, '7���� ��', '������', '11/03/23', '���೪��', '13,050��', '&#39;����ȣ�� ���&#39;�̶� �Ҹ��� ��ǿ��� ��Ƴ��� ���� �� ����. ������ �׿��� &#39;���θ��� �Ƶ�&#39;�̶�� �ð��̸� �������, ģô���� �����ϴ� ���� �ᱹ ��ο��� ������ ������ ���ɸ������� �������� ���´� ��ȯ�� �ٽ� ���� �Բ� ��� �����Ѵ�. ����ȣ�� ������κ��� 7�� ��, ������ ���� ���� ��� ��ȯ�� ������ �߰� ��������̺��� �ϴٰ� ��� ���� û����� �����ϰ� �ǰ�, �� �Ϸ� ������ ������ �ް� �� ������ �������κ��� �� ���� �Ҽ��� ��� �޴´�.<br /><br />������ ���� �� ���������� �� ���� ���� �ҳฦ �ѷ��ΰ� ���ɸ������� �Ͼ�� �׳� ���� ���. �������� ������ �Ҽ� ������ȣ���� ��ȯ�� �� ������, 7�� �� ����ȣ�� ����� ������ ����� ����� �̸鿡 ������ �ִ� ������ �̾߱��Ѵ�. ���� �Ⱓ ���� �Ʒ��� �����ִ� ������ 7���� �ð��� �Ѿ� �ٽ� �� ����� �巯����, ��ǰ� ���� ���̿��� ��Ȳ�ϸ� ����� �ð��� �ɾ�� ������� �� �ð��� ��� ������ ������ �� �󱼰� �����ϱ� �����Ѵ�.<br /><br />�۰��� ���ſ� ������ �׸��ڸ� ���� ��ƿ� ������ ��ȯ �ܿ���, ��ǿ� ���� �ι����� ���� �ٸ� ����� ���� �� �ô븦 ��ư��� �پ��� �ΰ�����, �ΰ��� ������ �е� �ְ� �����Ѵ�. �״� �� Ư���� ¥���� ����� źź�� ĳ���� ����, �� �� ƴ ���� ��������� ������ �� ��ǰ�� ���� �� ���� ������ īŸ���ý��� �Ȱ��ش�.<br /><br /><br /><iframe allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="" frameborder="0" height="315" src="https://www.youtube.com/embed/c6dCDbCv-kI" width="560"></iframe>', '/upload/books/7���ǹ�.jpg', 'admin', '���蹮�л� ���� �۰� ������ ����Ҽ�7���� �� ���� �ƹ����� �Ƶ鿡�� �Ͼ ������ �ź�ο�� ����� �̾߱�. ��1ȸ ����û�ҳ⹮�л� ������ ���� �λ��� ������ ķ����, ��5ȸ ���蹮�л� ������ ���� ������ ������ �۰� �������� ����Ҽ�. ������ ���� ġ���� �󰳿� �ӵ��� ��ġ�� ��ü, ��� �ִ� ĳ���Ϳ� �������ҿ� ������ �����ӱ���, ���� ������ ������ ���̸� ������ �ָ��� �ޱ� ������ �۰��� �ٽ� �� �� ġ���� ���� ����� �е����� �������� ������ ��ǰ ��7���� �㡻���� ���ڵ鿡�� ������ �λ��� �����.', 99);
commit;

INSERT INTO books(no, bookName, writer, publeYear, publisher, bookPrice, content, fileName, id, bookInfo, bookStock)
VALUES(books_seq.nextval, '������ ������', '��ȣ��', '21/04/20', '����������', '12,600��', '2013�� ���蹮�л� ����� ������ �������� ���������� ������ �� �ϻ��� ������ ��Ʈ �ְ� �׸� ������ ��ǰ�� �ΰ��� ������ ����� ����� �������� Ǯ� ������ �帣�� ������ �������� ��ǰ ���踦 �׾ƿø� �۰� ��ȣ��. ���� �ټ� ��° ����Ҽ� �������� ���������� �Ⱓ�Ǿ���. �������� ���������� û�ĵ� ��� �����̿� �ڸ� ���� ���� �������� ����� ���ܿ� �ô븦 ��ư��� �츮 �̿����� ���� �ӳ��� ��ξֶ��� �����ϰ� ���ӷ����ϰ� ��Ƴ� ��ǰ�̴�. �������� ������������ �������̶�� ������ ü���� �������� �� Ȱ���� ������ ��̿� ������ �̲���µ� �̹����� ������ ������ ���� û�ĵ��� ���� �������� �����ϰ� ������ �� �ϳ��� ��������� &lsquo;���� �̾߱�&rsquo;�� ź�����״�.<br /><br />���￪���� ����� ��Ȱ�� �ϴ� ������ ���ڰ� ��� �� 70�� ������ ������ �ֿ��� �ο����� �׳డ ��ϴ� ���������� �߰� �˹ٸ� �ϸ鼭 �̾߱Ⱑ ���۵ȴ�. ��ġ�� �� ���� �� �系�� ���ڿü� ġ�ŷ� ���Ÿ� ������� ���ϴ� ���� ���� ��ϰ� �ൿ�� ���� ���� �մ��� ����� ����� �� ������ �Ǳ����� ���� �ϴµ� ����, �ǿܷ� �״� ���� �� ���س� �� �ƴ϶� �ֺ� ������� ���ϰ� ��������鼭 �������� ���� ��Ű�� ����� �ϲ��� �Ǿ��.<br /><br /><iframe allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="" frameborder="0" height="315" src="https://www.youtube.com/embed/fTf-KrprLW4" width="560"></iframe><br />&nbsp;', '/upload/books/������������.jpg', 'admin', '�����ѵ� �ڲ� ���� ���� �������� �ִ�!����� ��Ƴ� ������ �����ϴ� �������� ����ü�Ҹ��� �˹ٷκ��� ���۵� ������ ������ ����ȿ���������� �������� ��ȣ���� ������ �̾߱⡯ ���� 2', 99);

INSERT INTO books(no, bookName, writer, publeYear, publisher, bookPrice, content, fileName, id, bookInfo, bookStock)
VALUES(books_seq.nextval, '�������, �޳��� �����Դϴ�.', 'Ȳ����', '22/01/17', 'Ŭ�����Ͽ콺', '13,500��', '<img alt="" src="/ckUpload/�������, �޳��� �����Դϴ�.jpg" style="height:720px; width:720px" /><br /><br />&ldquo;å�� ������ ���� ���ο� ���踦 �����, ������ �Ͼ�� ���� �־��� ������� �̾߱Ⱑ ���� �ְ� ��������.&rdquo;(�Ҽ��� ����� �ɻ���)<br /><br />���� ��𿡳� ���� �� ���� ������ �Ĺ��� ����. ������ ����� ���� ���� �������� ���̿� ����� ���� ���� �ϳ��� ����. �ٷ� �޳��� ����! ���� �翬�� ���� �ִ� ���ó�� �󱼿� �ƹ��� �ǿ嵵 ������ �ʴ� ���� ���� ���ִ� ó�� �� �ް��� �ڽ��� �մ��� �� ���� ���� �ʰ� ������ �ɾ� å�� �д´�. �׷��� �Ҿ���� �͵��� �ϳ��� ��ã�� ������� �Ϸ��Ϸ縦 ������ ���� �����ǰ� �� �� �͸� ���Ҵ� ������ ������ ������ �������. �׷��� ��� ���� ���ݴ´�. �ڽ��� �� �ǰ������ٴ� �����. �� �������� �޳��� ������ ������ ���ο� ������ �ȴ�. ����� ���̰� ������ ���̰� �������� �̾߱Ⱑ ���̴� ��������.<br /><br />�ٸ���Ÿ ����, �ν��� ��ü ��ǥ ����, �۰� �¿�, �ܰ�մ� ����, ��� �� ��̾��� ����л� ��ö�� ���� ���� ���� �� ũ�� ���� ��ó�� ����� ���� ������� �޳��� �����̶�� ������ �Ƚ�ó�� ��� �Բ� ��ư��� ���� ����. ��� ������, �޳��� �����Դϴ١��� �츮�� �Ҿ���� ä ��� ������ ��� �� �� �ʿ��� �͵��� ������ å�̴�. ����� ģ��, �Ÿ��� ��ų �� �ƴ� ����鳢���� ������ ������ ����, �����ϰ� ���� �ִ� ��ȭ ��. �Ⱓ ��� ����å TOP 10 ����Ʈ������ ������ ������ ������ ���縦 ���� �Ҽ��� ���ڵ��� ������ ��û���� ��ħ�� ����å���� �ٽ� �¾��.', '/upload/books/�������.jpg', 'admin', '���޾Ƶ鿩���� �ִٴ� ������ �̷��� ������ ���� ���̾�!���귱ġ�� ����å ���� ������Ʈ ������! ���� ��û �⵵�� ���� ����å �Ⱓ', 99);

INSERT INTO books(no, bookName, writer, publeYear, publisher, bookPrice, content, fileName, id, bookInfo, bookStock)
VALUES(books_seq.nextval, '���� ���� �½�', '���ʿ�', '21/08/18', '���̾�Ʈ�Ͻ�', '13,500��', '<img alt="" src="/ckUpload/�������ǿ½�.jpg" style="height:710px; width:710px" /><br /><br /><img alt="" src="/ckUpload/�������ǿ½�2.jpg" style="height:710px; width:710px" /><br /><br /><strong>���ʿ� ù ����Ҽ�, ��ΰ� ������ ��ٷ��� �̾߱�</strong><br /><br />�̹� ������ �������� �����ϸ� ������ ����� �ް� �ִ� ���ʿ� �۰��� ����Ʈ�� ����� ������ ���踦 ù ����Ҽ��� ����� ��Ҵ�. �״� ������ �� �÷��� ���縦 ���� ��ǥ�� �̾߱⸦ �ݳ��� ��½ �Ѵ� �ð� ���� �����ϸ鼭 ���� �� �����͵��� �������. �׸��Ͽ� �� �������� �������� ����� ���� �������� ������ ���Ӱ� ź���� ������ ���� �½ǡ��� 2021�� 8�� ���� ���ڵ��� ������.<br /><br />������ ���� �½ǡ��� ���̾�Ʈ�Ͻ��� �� ��° �����̴�. �������� ù �ø��� �Ҽ� �������� ���ΰ���, ����� ����Ҽ� �����ۺ��� ���ֱ���, �׸��� �ѱ������� ������ �ϰ� ���� �۰��� &lsquo;��ſ�&rsquo;�� Ű����� �� ����Ҽ��� ���� �ؼַ��� �������ʹ� 24�á�����, �۰����� �����ο� ������ �����ϸ� ���� �״ٿ� ��ǰ�� ������ �� �ֵ��� �ؿ� ���̾�Ʈ�Ͻ��� �̹� ���ΰ����� ���ʿ��� ������ ���� �½ǡ��� �Ⱓ�Ͽ���.<br /><br /><iframe allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="" frameborder="0" height="315" src="https://www.youtube.com/embed/qbXG5NVlRng" width="560"></iframe>', '/upload/books/�������ǿ½�.jpg',  'admin', 'MD �Ѹ���[�� �������� �츮�� ���� ���̴�] �Ҽ��� ���ʿ��� ù ����. �̾߱�� ������Ʈ���� ����� �������� ������ �޲ٴ� �̵��, ���� ��ǵ� ���迡�� ���� ������ ������ �������� �̵��� ������ ���󰣴�. ���� ������� ������ ���� ������ ��� �Ŵ��� �������κ��� ��θ� ���ϴ�����, ��鸲 ���� ��� �׷������� �Ҽ� -�Ҽ�MD ������', 99);

INSERT INTO books(no, bookName, writer, publeYear, publisher, bookPrice, content, fileName, id, bookInfo, bookStock)
VALUES(books_seq.nextval, '�޷���Ʈ �� ��ȭ��', '�̹̿�', '10/07/08', '���丮����', '12,420��', '<strong>����� ����߸� ������ �� �ִ� &lsquo;�޷���Ʈ �� ��ȭ��&rsquo;�Դϴ�</strong><br /><br />����߸� ������ �� �ִ� ��Ư�� ����. �װ��� ���� ��� �մԵ鿡�� ���� �α� �ִ� ����, �°� ���� �ѵ� ��� �Ǹ��ϴ� &lsquo;�޷���Ʈ�� �� ��ȭ��&rsquo;�̴�. �� ���� �ڴ� ������� �����̰�, ª�� ������ �ڴ� ������ ������� ���ϸ��� �뼺Ȳ�� �̷��. ����ġ ���� ������ ������ &lsquo;�޷���Ʈ&rsquo;, �׸��� ���� �����ٿ��� ���ϰ� �� ���� ���� &lsquo;���&rsquo;, ���� ����� ������ &lsquo;�ư��� ����&rsquo;, �׸��� ���Ͽ� �ѷ����� ��� ���̾&hellip;���� �����Ѵ�. ���޷���Ʈ �� ��ȭ������ &lsquo;���ǽĿ����� �����ϴ� ���� ���� ��� �� �� ������?&rsquo;��� ����� ������ ���� ã�ư���, ���� ����� ���, �Ĵ� ���, ��� ����� ��н��� ���Ǽҵ带 ��� �ִ� ��Ÿ�� �Ҽ��̴�. �Һ�� �ݵ� 1812% �޼�, ����å �Ⱓ ��� ����Ʈ���� 1���� 3�ְ� ����ϸ� ������ ���ڵ��� ��û���� ����å���� �Ⱓ�ϰ� �Ǿ���.<br /><br /><iframe allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="" frameborder="0" height="315" src="https://www.youtube.com/embed/CkM21p0dPG8" width="560"></iframe>', '/upload/books/�޷���Ʈ�޹�ȭ��.jpg', 'admin', 'MD �Ѹ�������߸� ������ �� �ִ� ������ ����, �� �߿����� ���� �α� �ִ� ���� �°� ���� ��� �Ĵ� ������! ���޷���Ʈ �� ��ȭ������ ���� ���� ���� ��ȭ������ ����� �װ����� �������� ��н����� ���� ��Ŭ�� �̾߱⸦ �׸���. ���ǿ� ��ģ �̵��� ���� ���� ���� ���� ��Ÿ��. -�Ҽ�MD ������', 99);
COMMIT;
--------------------------------------


--------------------------------------
-- BOOKS_CART ���̺�
DROP TABLE books_cart CASCADE CONSTRAINTS;
DROP SEQUENCE books_cart_seq;

CREATE TABLE books_cart(
	cartNum NUMBER PRIMARY KEY,
	id VARCHAR2(20) REFERENCES member(id) NOT NULL,
	no NUMBER REFERENCES books(no)ON DELETE CASCADE NOT NULL,
	cartStock NUMBER NOT NULL,
	addDate DATE DEFAULT SYSDATE
);

CREATE SEQUENCE books_cart_seq;
--------------------------------------


--------------------------------------
-- BOOKS_REPLY ���̺�
DROP TABLE books_reply CASCADE CONSTRAINTS;
DROP SEQUENCE books_reply_seq;

CREATE TABLE books_reply(
	no NUMBER REFERENCES books(no) ON DELETE CASCADE,
	id VARCHAR2(20) REFERENCES member(id) ON DELETE CASCADE,
	repNum NUMBER PRIMARY KEY,
	repCon VARCHAR2(2000) NOT NULL,
	repDate DATE DEFAULT SYSDATE
);

CREATE SEQUENCE books_reply_seq;
--------------------------------------