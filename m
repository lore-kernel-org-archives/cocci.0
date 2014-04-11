From: jesper.louis.andersen@gmail.com (Jesper Louis Andersen)
Date: Fri, 11 Apr 2014 20:49:37 +0200
Subject: [Cocci] Software parallelisation?
In-Reply-To: <5347ACF3.9040308@users.sourceforge.net>
References: <1397152097-315-1-git-send-email-mcgrof@do-not-panic.com>
 <1397152289.4757.28.camel@jlt4.sipsolutions.net>
 <20140410175748.GK14815@wotan.suse.de>
 <alpine.DEB.2.02.1404102131390.2201@localhost6.localdomain6>
 <5347ACF3.9040308@users.sourceforge.net>
Message-ID: <CAGrdgiUtFnTCH+HmhfLhxTmp=btBqx3mYJGQLN6AeaUnxW=YSw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Apr 11, 2014 at 10:50 AM, SF Markus Elfring <
elfring@users.sourceforge.net> wrote:

> Would you like to share any more ideas about corresponding software
> improvements?
>

The quick answer: It is currently somewhat hard. Ocaml is not
multi-threaded because it does not have a garbage collector able to execute
in multiple threads at the same time. This is being worked on seriously
now, but is at least 2-3 years out on the horizon for a stable solution.

So to make cocci faster on the inside requires some multi-processing
hackery. Certainly possible, but not as easy.


-- 
J.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20140411/03c92539/attachment.html>
