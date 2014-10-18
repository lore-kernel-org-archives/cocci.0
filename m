From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 18 Oct 2014 08:13:47 +0200
Subject: [Cocci] sgen problems
In-Reply-To: <alpine.DEB.2.02.1410180800200.2049@localhost6.localdomain6>
References: <20141017202400.GA2576@katana>
 <alpine.DEB.2.02.1410180726100.2049@localhost6.localdomain6>
 <20141018055143.GA1266@katana>
 <alpine.DEB.2.02.1410180800200.2049@localhost6.localdomain6>
Message-ID: <20141018061347.GB1266@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Oct 18, 2014 at 08:02:00AM +0200, Julia Lawall wrote:
> > @fix1_context depends on match1 && !patch && (context || org || report)@
> > identifier match1.__driver;
> > position j0;
> > @@
> > 
> > * 	static struct platform_driver __driver at j0 = {
> > 		.driver = {
> > 			.owner = THIS_MODULE,
> > 		}
> > 	};
> > 
> > @fix2_context depends on match2 && !patch && (context || org || report)@
> > identifier match2.__driver;
> > position j0;
> > @@
> > 
> > * 	static struct platform_driver __driver at j0 = {
> > 		.driver = {
> > 			.owner = THIS_MODULE,
> > 		}
> > 	};
> 
> In these cases, I think it would look nicer to put the *s and the @j0's 
> on .owner rather than at the start of the structure.

Is this a manual fix or a fix to sgen?

> Unless there is some situation in which the transformation is not 
> required, I think High confidence would be appropriate.

The calls I check for always set .owner. So it should be 'high', I'd
guess. However, if the behavioue of these calls are ever to be changed
there is a risk that this spatch gets not updated. More like a general
problem, though, which does not really influence the confidence.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141018/7101dc6f/attachment-0001.asc>
