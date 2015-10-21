From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 21 Oct 2015 15:54:09 +0200 (CEST)
Subject: [Cocci] [andrew@trailofbits.com: Static analysis to assist
 policy creation?]
In-Reply-To: <20151021134655.GI9528@wotan.suse.de>
References: <20151021134655.GI9528@wotan.suse.de>
Message-ID: <alpine.DEB.2.10.1510211551560.2588@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 21 Oct 2015, Luis R. Rodriguez wrote:

> Not sure what techniques are used today to derive SELinux policies but if you
> can figure things out from C code you could perhaps use Coccinelle and its
> scripting capabilities (python, for instance) to generate them. This will of
> course depend on how tied down generating rules from C code can be. Another
> thing one could consider is: what things could be ammdended to C code to
> annotate or help with static analysis to automatically generate SELinux
> policy rules.

I don't know how useful the current state of Coccinelle would be for
issues that really need alias analysis.  But it is possible that
Coccinelle could be made to read and take into account alias analysis
information.  Alternatively, Coccinelle could be used to take care of the
low hanging fruit that doesn't require alias or other kinds of valee
analyses, making the code more amenable to whatever more complex analyses
are needed.

julia


>
>   Luis
>
> ----- Forwarded message from Andrew Ruef <andrew@trailofbits.com> -----
>
> Date: Tue, 20 Oct 2015 13:17:27 -0400
> From: Andrew Ruef <andrew@trailofbits.com>
> To: selinux at tycho.nsa.gov
> Subject: Static analysis to assist policy creation?
>
> Hello SELinux list,
>
> We?ve been thinking about creating a static (or potentially concolic) analysis and testing infrastructure that would assist in the creation of finer grained SELinux policies than audit2allow. We think that some work can be done through alias analysis and domain specific object (strings, memory regions/files, etc) analysis wholly statically, but we?ve developed an extensive symbolic execution system for C/binary programs that could also be applied.
>
> I?ve done some searching and asking around and it doesn?t seem like there are any tools that do this. I?m aware of some past projects that made use of static analysis tools to help create security policies, like the IBM SWORD4J work. The IBM people seemed really happy with those results and they have relayed that it really helped their internal efforts for security labeling, so maybe there is some hope for tools in this area.
>
> My question is two-fold
>
> 1. Is there a history of using static analysis to create SELinux policies that I haven?t found so far?
>
> 2. Is there any interest in the community for such an effort today?
>
> Thank you,
>
> Andrew
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux at tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave at tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request at tycho.nsa.gov.
>
>
> ----- End forwarded message -----
>
> --
> Luis Rodriguez, SUSE LINUX GmbH
> Maxfeldstrasse 5; D-90409 Nuernberg
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
