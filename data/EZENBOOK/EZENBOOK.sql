-----------------
--EZENBOOK(SQL)--
-----------------

--샘플 데이터 입력시 대체변수 기능 사용하지 않기
set define off;

--------------------------------------
-- GRADE 테이블
DROP TABLE grade CASCADE CONSTRAINTS;

CREATE TABLE grade(
	gradeNo NUMBER(2) PRIMARY KEY,
	gradeName VARCHAR2(20) NOT NULL
);

-- GRADE 테이블 샘플 데이터
INSERT INTO grade(gradeNo, gradeName)
VALUES('1', '일반회원');
COMMIT;

INSERT INTO grade(gradeNo, gradeName)
VALUES('9', '관리자');
COMMIT;
--------------------------------------


--------------------------------------
-- MEMBER 테이블
DROP TABLE member CASCADE CONSTRAINTS;

CREATE TABLE member(
	id VARCHAR2(20) PRIMARY KEY,
	pw VARCHAR2(20) NOT NULL,
	name VARCHAR2(30) NOT NULL,
	gender VARCHAR2(6) NOT NULL CHECK(gender in('남자', '여자')),
	birth DATE NOT NULL,
	tel VARCHAR2(13) NOT NULL,
	email VARCHAR2(50) NOT NULL,
	addr1 VARCHAR2(100) NOT NULL, 
	addr2 VARCHAR2(100) NOT NULL,
	addr3 VARCHAR2(100) NOT NULL,
	regDate DATE DEFAULT SYSDATE,
	status VARCHAR2(6) DEFAULT '정상' check(status in('정상','강퇴','탈퇴','휴면')),
	gradeNo NUMBER(2) DEFAULT '1' REFERENCES grade(gradeNo)
);


-- MEMBER 테이블 샘플 데이터
INSERT INTO member(id, pw, name, gender, birth, tel, email, addr1, addr2, addr3, gradeNo)
VALUES('admin', '1234', '관리자', '남자', '95/12/14', '010-1234-5678', 'admin@naver.com', '11671', '경기 의정부시 흥선로 128번길 29-8', '201호', 9);
COMMIT;

INSERT INTO member(id, pw, name, gender, birth, tel, email, addr1, addr2, addr3, gradeNo)
VALUES('itsmesunky', '1234', '홍길동', '남자', '95/12/14', '010-1234-5678', 'test@naver.com',  '11671', '경기 의정부시 흥선로 128번길 29-8', '201호', 1);
COMMIT;
--------------------------------------


--------------------------------------
--BOOKS 테이블
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

-- BOOKS 테이블 샘플 데이터
INSERT INTO books(no, bookName, writer, publeYear, publisher, bookPrice, content, fileName, id, bookInfo, bookStock)
VALUES(books_seq.nextval, '7년의 밤', '정유정', '11/03/23', '은행나무', '13,050원', '&#39;세령호의 재앙&#39;이라 불리는 사건에서 살아남은 열두 살 서원. 세상은 그에게 &#39;살인마의 아들&#39;이라는 올가미를 덧씌우고, 친척집을 전전하던 끝에 결국 모두에게 버려진 서원은 세령마을에서 한집에서 지냈던 승환을 다시 만나 함께 살기 시작한다. 세령호의 재앙으로부터 7년 후, 세간의 눈을 피해 살던 승환과 서원은 야간 스쿠버다이빙을 하다가 사고를 당한 청년들을 구조하게 되고, 이 일로 세간의 관심을 받게 된 서원은 누군가로부터 한 편의 소설을 배달 받는다.<br /><br />교통사고를 당한 뒤 누군가에게 목 졸려 죽은 소녀를 둘러싸고 세령마을에서 일어났던 그날 밤의 사건. 서원에게 전해진 소설 『세령호』는 승환이 쓴 것으로, 7년 전 세령호의 재앙을 낱낱이 기록해 사건의 이면에 숨겨져 있던 진실을 이야기한다. 오랜 기간 수면 아래에 잠들어있던 진실은 7년의 시간을 넘어 다시 그 모습을 드러내고, 사실과 진실 사이에서 방황하며 어둠의 시간을 걸어온 존재들은 그 시간을 딛고 서서히 진실의 맨 얼굴과 조우하기 시작한다.<br /><br />작가는 무거운 과거의 그림자를 지고 살아온 서원과 승환 외에도, 사건에 얽힌 인물들의 각기 다른 면면을 통해 이 시대를 살아가는 다양한 인간군상, 인간의 본질을 밀도 있게 조명한다. 그는 그 특유의 짜릿한 문장과 탄탄한 캐릭터 설정, 물 샐 틈 없는 세계관으로 직조된 이 작품을 통해 숨 가쁜 서사적 카타르시스를 안겨준다.<br /><br /><br /><iframe allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="" frameborder="0" height="315" src="https://www.youtube.com/embed/c6dCDbCv-kI" width="560"></iframe>', '/upload/books/7년의밤.jpg', 'admin', '세계문학상 수상 작가 정유정 장편소설7년의 밤 동안 아버지와 아들에게 일어난 슬프고 신비로우며 통렬한 이야기. 제1회 세계청소년문학상 수상작 『내 인생의 스프링 캠프』, 제5회 세계문학상 수상작 『내 심장을 쏴라』의 작가 정유정의 장편소설. 전작을 통해 치밀한 얼개와 속도감 넘치는 문체, 살아 있는 캐릭터와 적재적소에 터지는 블랙유머까지, 놀라운 문학적 역량을 보이며 문단의 주목을 받기 시작한 작가는 다시 한 번 치밀한 사전 조사와 압도적인 상상력으로 무장한 작품 『7년의 밤』으로 독자들에게 강렬한 인상을 남긴다.', 99);
commit;

INSERT INTO books(no, bookName, writer, publeYear, publisher, bookPrice, content, fileName, id, bookInfo, bookStock)
VALUES(books_seq.nextval, '불편한 편의점', '김호연', '21/04/20', '나무옆의자', '12,600원', '2013년 세계문학상 우수상 수상작 『망원동 브라더스』로 데뷔한 후 일상적 현실을 위트 있게 그린 경쾌한 작품과 인간의 내밀한 욕망을 기발한 상상력으로 풀어낸 스릴러 장르를 오가며 독자적인 작품 세계를 쌓아올린 작가 김호연. 그의 다섯 번째 장편소설 『불편한 편의점』이 출간되었다. 『불편한 편의점』은 청파동 골목 모퉁이에 자리 잡은 작은 편의점을 무대로 힘겨운 시대를 살아가는 우리 이웃들의 삶의 속내와 희로애락을 따뜻하고 유머러스하게 담아낸 작품이다. 『망원동 브라더스』에서 망원동이라는 공간의 체험적 지리지를 잘 활용해 유쾌한 재미와 공감을 이끌어냈듯 이번에는 서울의 오래된 동네 청파동에 대한 공감각을 생생하게 포착해 또 하나의 흥미진진한 &lsquo;동네 이야기&rsquo;를 탄생시켰다.<br /><br />서울역에서 노숙인 생활을 하던 독고라는 남자가 어느 날 70대 여성의 지갑을 주워준 인연으로 그녀가 운영하는 편의점에서 야간 알바를 하면서 이야기가 시작된다. 덩치가 곰 같은 이 사내는 알코올성 치매로 과거를 기억하지 못하는 데다 말도 어눌하고 행동도 굼떠 과연 손님을 제대로 상대할 수 있을까 의구심을 갖게 하는데 웬걸, 의외로 그는 일을 꽤 잘해낼 뿐 아니라 주변 사람들을 묘하게 사로잡으면서 편의점의 밤을 지키는 든든한 일꾼이 되어간다.<br /><br /><iframe allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="" frameborder="0" height="315" src="https://www.youtube.com/embed/fTf-KrprLW4" width="560"></iframe><br />&nbsp;', '/upload/books/불편한편의점.jpg', 'admin', '불편한데 자꾸 가고 싶은 편의점이 있다!힘들게 살아낸 오늘을 위로하는 편의점의 밤정체불명의 알바로부터 시작된 웃음과 감동의 나비효과『망원동 브라더스』 김호연의 ‘동네 이야기’ 시즌 2', 99);

INSERT INTO books(no, bookName, writer, publeYear, publisher, bookPrice, content, fileName, id, bookInfo, bookStock)
VALUES(books_seq.nextval, '어서오세요, 휴남동 서점입니다.', '황보름', '22/01/17', '클레이하우스', '13,500원', '<img alt="" src="/ckUpload/어서오세요, 휴남동 서점입니다.jpg" style="height:720px; width:720px" /><br /><br />&ldquo;책과 서점을 통해 새로운 관계를 만들고, 스스로 일어서기 위해 애쓰는 사람들의 이야기가 깊이 있게 펼쳐진다.&rdquo;(소설가 김금희 심사평)<br /><br />서울 어디에나 있을 것 같은 동네의 후미진 골목길. 오가는 사람도 많지 않은 가정집들 사이에 평범한 동네 서점 하나가 들어선다. 바로 휴남동 서점! 슬픈 사연을 갖고 있는 사람처럼 얼굴에 아무런 의욕도 보이지 않는 서점 주인 영주는 처음 몇 달간은 자신이 손님인 듯 일은 하지 않고 가만히 앉아 책만 읽는다. 그렇게 잃어버린 것들을 하나둘 되찾는 기분으로 하루하루를 보내다 보니 소진되고 텅 빈 것만 같았던 내면의 느낌이 서서히 사라진다. 그러다 어느 순간 깨닫는다. 자신이 꽤 건강해졌다는 사실을. 그 순간부터 휴남동 서점은 완전히 새로운 공간이 된다. 사람이 모이고 감정이 모이고 저마다의 이야기가 모이는 공간으로.<br /><br />바리스타 민준, 로스팅 업체 대표 지미, 작가 승우, 단골손님 정서, 사는 게 재미없는 고등학생 민철과 그의 엄마 희주 등 크고 작은 상처와 희망을 가진 사람들이 휴남동 서점이라는 공간을 안식처로 삼아 함께 살아가는 법을 배운다. 『어서 오세요, 휴남동 서점입니다』는 우리가 잃어버린 채 살고 있지만 사는 데 꼭 필요한 것들이 가득한 책이다. 배려와 친절, 거리를 지킬 줄 아는 사람들끼리의 우정과 느슨한 연대, 진솔하고 깊이 있는 대화 등. 출간 즉시 전자책 TOP 10 베스트셀러에 오르며 수많은 독자의 찬사를 받은 소설이 독자들의 강력한 요청으로 마침내 종이책으로 다시 태어났다.', '/upload/books/어서오세요.jpg', 'admin', '“받아들여지고 있다는 느낌이 이렇게 슬프고도 좋을 줄이야!”브런치북 전자책 출판 프로젝트 수상작! 독자 요청 쇄도로 전격 종이책 출간', 99);

INSERT INTO books(no, bookName, writer, publeYear, publisher, bookPrice, content, fileName, id, bookInfo, bookStock)
VALUES(books_seq.nextval, '지구 끝의 온실', '김초엽', '21/08/18', '자이언트북스', '13,500원', '<img alt="" src="/ckUpload/지구끝의온실.jpg" style="height:710px; width:710px" /><br /><br /><img alt="" src="/ckUpload/지구끝의온실2.jpg" style="height:710px; width:710px" /><br /><br /><strong>김초엽 첫 장편소설, 모두가 간절히 기다려온 이야기</strong><br /><br />이미 폭넓은 독자층을 형성하며 열렬한 사랑을 받고 있는 김초엽 작가는 더스트로 멸망한 이후의 세계를 첫 장편소설의 무대로 삼았다. 그는 지난해 말 플랫폼 연재를 통해 발표한 이야기를 반년이 훌쩍 넘는 시간 동안 수정하면서 한층 더 무르익도록 만들었다. 그리하여 장 구성부터 세부적인 장면은 물론 문장들까지 완전히 새롭게 탄생한 『지구 끝의 온실』이 2021년 8월 드디어 독자들을 만난다.<br /><br />『지구 끝의 온실』은 자이언트북스의 네 번째 도서이다. 김중혁의 첫 시리즈 소설 『내일은 초인간』, 배명훈 장편소설 『빙글빙글 우주군』, 그리고 한국문학의 빛나는 일곱 명의 작가가 &lsquo;즐거움&rsquo;을 키워드로 쓴 단편소설을 묶은 앤솔로지 『놀이터는 24시』까지, 작가들의 자유로운 상상력을 응원하며 가장 그다운 작품을 선보일 수 있도록 해온 자이언트북스는 이번 주인공으로 김초엽의 『지구 끝의 온실』을 출간하였다.<br /><br /><iframe allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="" frameborder="0" height="315" src="https://www.youtube.com/embed/qbXG5NVlRng" width="560"></iframe>', '/upload/books/지구끝의온실.jpg',  'admin', 'MD 한마디[이 마음들이 우리를 구할 것이다] 소설가 김초엽의 첫 장편. 이야기는 ‘더스트’로 멸망한 지구에서 생존을 꿈꾸는 이들과, 이후 재건된 세계에서 묻힌 과거의 진실을 밝히려는 이들의 여정을 따라간다. 보통 사람들의 진심을 다한 분투가 어떻게 거대한 절망으로부터 모두를 구하는지를, 흔들림 없이 곧게 그려나가는 소설 -소설MD 박형욱', 99);

INSERT INTO books(no, bookName, writer, publeYear, publisher, bookPrice, content, fileName, id, bookInfo, bookStock)
VALUES(books_seq.nextval, '달러구트 꿈 백화점', '이미예', '10/07/08', '팩토리나인', '12,420원', '<strong>여기는 잠들어야만 입장할 수 있는 &lsquo;달러구트 꿈 백화점&rsquo;입니다</strong><br /><br />잠들어야만 입장할 수 있는 독특한 마을. 그곳에 들어온 잠든 손님들에게 가장 인기 있는 곳은, 온갖 꿈을 한데 모아 판매하는 &lsquo;달러구트의 꿈 백화점&rsquo;이다. 긴 잠을 자는 사람들은 물론이고, 짧은 낮잠을 자는 사람들과 동물들로 매일매일 대성황을 이룬다. 범상치 않은 혈통의 주인장 &lsquo;달러구트&rsquo;, 그리고 그의 최측근에서 일하게 된 신참 직원 &lsquo;페니&rsquo;, 꿈을 만드는 제작자 &lsquo;아가넵 코코&rsquo;, 그리고 베일에 둘러싸인 비고 마이어스&hellip;등이 등장한다. 『달러구트 꿈 백화점』은 &lsquo;무의식에서만 존재하는 꿈을 정말 사고 팔 수 있을까?&rsquo;라는 기발한 질문에 답을 찾아가며, 꿈을 만드는 사람, 파는 사람, 사는 사람의 비밀스런 에피소드를 담고 있는 판타지 소설이다. 텀블벅 펀딩 1812% 달성, 전자책 출간 즉시 베스트셀러 1위를 3주간 기록하며 수많은 독자들의 요청으로 종이책으로 출간하게 되었다.<br /><br /><iframe allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="" frameborder="0" height="315" src="https://www.youtube.com/embed/CkM21p0dPG8" width="560"></iframe>', '/upload/books/달러구트꿈백화점.jpg', 'admin', 'MD 한마디잠들어야만 입장할 수 있는 상점가 마을, 그 중에서도 가장 인기 있는 곳은 온갖 꿈을 모아 파는 상점가! 『달러구트 꿈 백화점』은 유서 깊은 ‘꿈 백화점’을 무대로 그곳에서 벌어지는 비밀스럽고도 가슴 뭉클한 이야기를 그린다. 현실에 지친 이들을 위한 선물 같은 힐링 판타지. -소설MD 박형욱', 99);
COMMIT;
--------------------------------------


--------------------------------------
-- BOOKS_CART 테이블
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
-- BOOKS_REPLY 테이블
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