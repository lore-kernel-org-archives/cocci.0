From: fabf@skynet.be (Fabian Frederick)
Date: Sun, 29 Jun 2014 10:27:14 +0200
Subject: [Cocci] [PATCH V3] scripts/coccinelle/free: Delete NULL test
 before freeing functions?
In-Reply-To: <53AF2CE6.5020300@users.sourceforge.net>
References: <1403945247-21549-1-git-send-email-fabf@skynet.be>
 <53AE8613.8080600@users.sourceforge.net>
 <20140628120052.0b8670723928a967808dd544@skynet.be>
 <53AEA927.3010100@users.sourceforge.net>
 <20140628140157.98304218ad0919b1567cfee4@skynet.be>
 <53AF2CE6.5020300@users.sourceforge.net>
Message-ID: <20140629102714.ea430bbd1f7c19e2f18fa56f@skynet.be>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 28 Jun 2014 23:00:22 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> > Sorry but I'm not working on coccinelle ; just did a small script for kernel tree.
> 
> I would appreciate a more constructive feedback for my update suggestions around
> the topic "Deletion of unnecessary checks before specific function calls".
> - Did you look at the concrete patches?
> - How do you think about the general approach?
> 
> Examples:
> https://systeme.lip6.fr/pipermail/cocci/2014-March/000676.html
> http://marc.info/?l=kernel-janitors&m=139405971927100&w=2
> 
> https://systeme.lip6.fr/pipermail/cocci/2014-March/000677.html
> http://marc.info/?l=kernel-janitors&m=139405983727148&w=2
> 
> Regards,
> Markus

Hello Markus,

	I hope you had information you wanted from Julia ?
If you want more feedback, maybe you can create a new RFC (Request For Comment) in Linux Kernel mailing.

Regards,
Fabian
