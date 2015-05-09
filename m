From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 09 May 2015 14:01:28 +0200
Subject: [Cocci] Checking for null pointers
In-Reply-To: <CABBGRWt7k-3xxFVgeYcPwdjAVxJ6jfUuEdKrcDk8_2BQ06+PGg@mail.gmail.com>
References: <CABBGRWueC78515AqDfkX4buzjipbkNhAvZ5G5OAkWhX+4WwAuA@mail.gmail.com>	<554DB33D.2000000@users.sourceforge.net>	<CABBGRWvwuuVAyB_re1h-W4p2Gye-r195x5yjaxnURzuZX2Gaqg@mail.gmail.com>	<554DE908.5060009@users.sourceforge.net>	<CABBGRWtb1aectYA8M62QwdScdPjBnDaK+GrT0PDtx1ach0a=SA@mail.gmail.com>	<554DF181.5070707@users.sourceforge.net>
 <CABBGRWt7k-3xxFVgeYcPwdjAVxJ6jfUuEdKrcDk8_2BQ06+PGg@mail.gmail.com>
Message-ID: <554DF718.80209@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> this code was implemented just to test the script.

I find that such test code should generally also compile,
shouldn't it?


> my SmPL script will be applied to a big embedded project.

Did you try any other static source code analysis tools out?
https://en.wikipedia.org/wiki/List_of_tools_for_static_code_analysis#C.2FC.2B.2B

How many details need to be repeated by SmPL scripts for
more complete checking of return values?

Regards,
Markus
