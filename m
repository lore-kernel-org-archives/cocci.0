From: mstefani@redhat.com (Michael Stefaniuc)
Date: Fri, 04 Jan 2013 22:53:20 +0100
Subject: [Cocci] Parsing error for struct names starting with two underscore
Message-ID: <50E74F50.6000308@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

there seems to be an error in parsing struct/union names that start with
two underscore:

@@
struct __foo bar;
@@
* sizeof(bar)

Fatal error: exception Failure("meta: parse error:
 = File "__foo.cocci", line 2, column 7,  charpos = 10
    around = '__foo', whole content = struct __foo bar;
")

Removing one of the underscore makes it parse.

thanks
bye
	michael
