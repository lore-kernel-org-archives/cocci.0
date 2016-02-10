From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 10 Feb 2016 10:00:53 +0100
Subject: [Cocci] coccinelle: add style check for assignment in if
In-Reply-To: <1455062207.3333.6.camel@perches.com>
References: <1454935571-4054-1-git-send-email-kborer@gmail.com>
 <56B9A2F6.4040109@users.sourceforge.net>
 <alpine.DEB.2.10.1602091016200.2578@hadrien>
 <56B9E1C2.7070008@users.sourceforge.net>
 <1455062207.3333.6.camel@perches.com>
Message-ID: <56BAFC45.5000003@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Can the check result display be more convenient from the semantic
>> patch script interface in comparison to the other tool?
> 
> -ENOPARSE.  More detail please.

Kris Borer suggested a SmPL script which can generate (only) patches
so far by the usual application of the Coccinelle software.
I assume that this approach was limited just because Julia Lawall
indicated that this functionality would be sufficient for a while.

The documentation for the command "make coccicheck" mentions
additional modes.
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/coccinelle.txt?id=ec97946ed038f4b3faa587bc76152b198805b0c4#n170

They refer to specific output formats for the result from the
static source code analysis.

* How often would you like to look at proposed changes by the
  Org mode format (of Emacs)?
  http://orgmode.org/

* Do you find the report mode also useful occasionally?


Are you interested to get further output variants?

Examples:
* CSV
* XML

Regards,
Markus
