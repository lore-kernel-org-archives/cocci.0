From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 05 May 2015 14:32:59 +0200
Subject: [Cocci] [PATCH RFC] Coccinelle: Check for return not matching
 function signature
In-Reply-To: <1430820761-28122-1-git-send-email-hofrat@osadl.org>
References: <1430820761-28122-1-git-send-email-hofrat@osadl.org>
Message-ID: <5548B87B.4060103@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Check if the signature of a function and the return value type match.

Is this a task that is usually performed by a compiler?


> In many cases this mismatch will have no side-effects
> but in some cases it may lead to hard to locate problems

It is another software development challenge to find concrete
open issues there.


> - and for readability and code understanding it is also helpful
> when types match.

How would you like to check for compatible data types here?


> The output is a bit lengthy - not sure if that is too much
> but it seemed useful to me to see the non-matching types explicitly
> in the warning message.

How do you think about to import the result list into a database table?


> +if T1 != T2:
> +   print "%s:%s,%s WARNING: return of wrong type (%s != %s)" % (p[0].file,fn,p[0].line,T1,T2)

Is such a check a bit too simple?

Regards,
Markus
