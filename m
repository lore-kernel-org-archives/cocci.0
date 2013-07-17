From: neleai@seznam.cz (=?utf-8?B?T25kxZllaiBCw61sa2E=?=)
Date: Wed, 17 Jul 2013 17:51:32 +0200
Subject: [Cocci] Formatting issues
In-Reply-To: <alpine.DEB.2.02.1307171728420.2113@hadrien>
References: <51E6B08E.9030600@monom.org>
 <alpine.DEB.2.02.1307171706400.2113@hadrien>
 <51E6B532.8010909@monom.org>
 <alpine.DEB.2.02.1307171728420.2113@hadrien>
Message-ID: <20130717155132.GA20499@domone.kolej.mff.cuni.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jul 17, 2013 at 05:31:15PM +0200, Julia Lawall wrote:
> >Another formatting issue I found is triggered by a different rule. I figure
> >the expression 'E' is written out as one line and the original formatting gets
> >lost.
> 
> Yes, there is not much I can do about this one.  When you match code
> into a metavariable, all of the whitespace and comments go away.  It
> doesn't know that you still want them in the place where you add the
> metavariable back in.
> 
> If you have a probleme with this, as in your example, you can try to
> rewrite the semantic patch so that the metavariable is there but
> does not appear in the - and + code.  For example, for your first
> case below you can write
> 
I ran to problems with formating when I tried use cocci in glibc.

I think that semantic patch and its formatting are two separate issues.

Ideal situation is when project formatting is fully machine specified.
Then we can apply patch, run formatter and we are done. 
Otherwise we can try to convince other developers that benefit of refactoring
is bigger than formatting issues it causes or fix it by hand.

I now try to convince others to use first option as this allows all
submitted patches have perfect formatting because formatter took care of
it. This can save few round trips when reviewer wants space after comma
etc.

Ondra
