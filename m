From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 18 May 2018 18:49:20 +0200 (CEST)
Subject: [Cocci] Checking run times for transformation of Linux source
 code with SmPL
In-Reply-To: <416a7972-d6ce-38b2-9983-ce0446b5ab61@users.sourceforge.net>
References: <alpine.DEB.2.20.1805172241400.2273@hadrien>
 <d1902859-7b9b-4dea-0e5b-8d4876f90495@users.sourceforge.net>
 <alpine.DEB.2.20.1805181802060.3339@hadrien>
 <416a7972-d6ce-38b2-9983-ce0446b5ab61@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1805181848290.3339@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 18 May 2018, SF Markus Elfring wrote:

> >>> In terms of the running time, I get a running time of 11 seconds with the
> >>> command line of 48 files and I get a running time of 22 seconds if I just
> >>> run spatch on the entire kernel.
> >>
> >> * Can such a comparison result be amazing?
> >
> > No, I don't see anything suprising about it.
>
> I suggest to take another look at these performance numbers from your
> powerful test environment. All Linux source files were checked to some degree
> according to another specific search pattern.
> The half of this execution time was taken by only a tiny fraction
> of update candidates.

The 48 files are all parsed.  Coccinelle doesn't parse every file in the
kernel.  It only parses the files that contain the name of the function
being modified.

julia

>
>
> > More work takes more time.
>
> This usual in principle. It seems that I got a bit of understanding difficulties
> for this simple test report.
> How reasonable is it that a lot of more work could be performed somehow
> in the double time range?
>
> Regards,
> Markus
>
