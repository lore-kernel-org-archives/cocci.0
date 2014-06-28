From: fabf@skynet.be (Fabian Frederick)
Date: Sat, 28 Jun 2014 14:01:57 +0200
Subject: [Cocci] [PATCH V3] scripts/coccinelle/free: Delete NULL test
 before freeing functions?
In-Reply-To: <53AEA927.3010100@users.sourceforge.net>
References: <1403945247-21549-1-git-send-email-fabf@skynet.be>
 <53AE8613.8080600@users.sourceforge.net>
 <20140628120052.0b8670723928a967808dd544@skynet.be>
 <53AEA927.3010100@users.sourceforge.net>
Message-ID: <20140628140157.98304218ad0919b1567cfee4@skynet.be>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 28 Jun 2014 13:38:15 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> 
> >> How do you think about my previous update suggestion "Deletion of
> >> unnecessary checks before specific function calls"?
> >> https://systeme.lip6.fr/pipermail/cocci/2014-March/000675.html
> >> https://lkml.org/lkml/2014/3/5/344
> >     I didn't see you made the same kind of script.
> 
> Will my approach become a bit more complete in the near future?
> http://article.gmane.org/gmane.comp.version-control.coccinelle/3512/
> 

Sorry but I'm not working on coccinelle ; just did a small script for kernel tree. I guess you'll have an answer from coccinelle people.

Regards,
Fabian

> Regards,
> Markus
