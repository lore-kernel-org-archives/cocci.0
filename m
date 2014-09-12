From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 12 Sep 2014 13:08:03 +0200
Subject: [Cocci] [PATCH 1/6] Coccinelle: Semantic patch for replacing
 puts with putc
In-Reply-To: <1410513954-28909-2-git-send-email-linux@rasmusvillemoes.dk>
References: <1410513954-28909-1-git-send-email-linux@rasmusvillemoes.dk>
 <1410513954-28909-2-git-send-email-linux@rasmusvillemoes.dk>
Message-ID: <5412D413.3080404@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Using seq_puts to write a one-character string is suboptimal,
> since puts has to call strlen().

Are there any more functions which work with such strings in a similar way?
Would it make sense to look also at other function names?

Regards,
Markus
