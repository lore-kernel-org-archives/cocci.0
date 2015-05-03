From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 3 May 2015 23:58:10 +0200 (CEST)
Subject: [Cocci] smpl-spacing Whitespace Issue on Assignments
 (regression)
In-Reply-To: <55468FCA.5000402@redhat.com>
References: <55468FCA.5000402@redhat.com>
Message-ID: <alpine.DEB.2.02.1505032357060.2221@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 3 May 2015, Michael Stefaniuc wrote:

> Hello Julia,
> 
> sorry for the delay, here is the whitespace regression though it affects
> only --smpl-spacing
> 
> foo.cocci:
> @@
> expression e1, e2;
> @@
> - e1 = e2
> + c = d
> 
> foo.c:
> void foo(void)
> {
>     int a, b;
>     b = a;
> }
> 
> spatch --smpl-spacing foo.cocci foo.c
> gives:
> -    b = a;
> +    c=d;

Just out of curiosity, did it work recently?  I don't think I have changed 
anything recently related to assignments.  I will look into it.

Thanks for the report.

julia
