From: yamada.masahiro@socionext.com (yamada.masahiro at socionext.com)
Date: Tue, 14 Nov 2017 03:29:14 +0000
Subject: [Cocci] Coccinelle: fix parallel build with
	CHECK=scripts/coccicheck
In-Reply-To: <b99135b2-3a57-5c78-c820-9b0ea51dad42@users.sourceforge.net>
References: <1510210850-28866-1-git-send-email-yamada.masahiro@socionext.com>
 <b99135b2-3a57-5c78-c820-9b0ea51dad42@users.sourceforge.net>
Message-ID: <54280dcc7b584812bcc475d62bac9625@SOC-EX01V.e01.socionext.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Markus,

I will add more description in the commit log.
Thanks

> -----Original Message-----
> From: SF Markus Elfring [mailto:elfring at users.sourceforge.net]
> Sent: Saturday, November 11, 2017 1:27 AM
> To: Yamada, Masahiro/?? ?? <yamada.masahiro@socionext.com>
> Cc: cocci at systeme.lip6.fr
> Subject: Re: Coccinelle: fix parallel build with CHECK=scripts/coccicheck
> 
> > The command "make -j8 C=1 CHECK=scripts/coccicheck" produces lots of
> > "coccicheck failed" error messages.
> 
> * Which software versions did you try out for these source file checks?
> 
> * Can the software situation be clarified any more?
> 
> 
> > I do not know the coccinelle internals,
> 
> Would you like to extend your knowledge in this area?
> 
> 
> > but I guess --jobs does not work well if spatch is invoked from Make
> > running in parallel.
> 
> The desired parallelisation support can evolve into additional directions,
> can't it?
> 
> 
> > Disable --jobs in this case.
> 
> How do you think about further possibilities for separation of work between
> Coccinelle and Make processes?
> 
> Regards,
> Markus
