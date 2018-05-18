From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 18 May 2018 19:13:47 +0200 (CEST)
Subject: [Cocci] Checking run times for transformation of Linux source
 code with SmPL
In-Reply-To: <f9b0c961-7182-86ea-bb39-486ffc732db0@users.sourceforge.net>
References: <alpine.DEB.2.20.1805172241400.2273@hadrien>
 <d1902859-7b9b-4dea-0e5b-8d4876f90495@users.sourceforge.net>
 <alpine.DEB.2.20.1805181802060.3339@hadrien>
 <416a7972-d6ce-38b2-9983-ce0446b5ab61@users.sourceforge.net>
 <alpine.DEB.2.20.1805181848290.3339@hadrien>
 <f9b0c961-7182-86ea-bb39-486ffc732db0@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1805181912360.3339@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 18 May 2018, SF Markus Elfring wrote:

> > Coccinelle doesn't parse every file in the kernel.
>
> I find this information strange.
>
>
> > It only parses the files that contain the name of the function being modified.
>
> Do you interpret the required source code parsing efforts in a special way?

Coccinelle searches the semantic patch for the important words.  Then it
implements something like grep to find files that contain those imprtant
words.  Or maybe it just uses git grep by default.

julia
