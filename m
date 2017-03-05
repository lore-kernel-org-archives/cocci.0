From: 96701051@mail2.nccu.tw (Jeremy)
Date: Sun, 5 Mar 2017 11:45:29 +0800
Subject: [Cocci] How to execute coccicheck outside linux source tree?
Message-ID: <CAAJ24apcC3TYyMwR0g=aBavk9JC9mb8+v=63LTK6eGDeD8WDDg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi all,

I'd like to scan some driver by coccicheck, but don't know how to execute it.
I know that we could scan driver in linux source tree by
`make coccicheck MODE=report -M=drivers/'

btw, it will print a lot of errors as follow:

Fatal error: exception Failure("meta: parse error:
 = File "./scripts/coccinelle/misc/boolconv.cocci", line 47, column 7,
 charpos = 773
    around = 'true', whole content = symbol true, false;
")
773 777
Fatal error: exception Failure("meta: parse error:
 = File "./scripts/coccinelle/misc/boolconv.cocci", line 47, column 7,
 charpos = 773
    around = 'true', whole content = symbol true, false;
")

Jeremy
