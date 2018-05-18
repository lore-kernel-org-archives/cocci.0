From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 18 May 2018 18:03:18 +0200 (CEST)
Subject: [Cocci] Checking run times for transformation of Linux source
 code with SmPL
In-Reply-To: <d1902859-7b9b-4dea-0e5b-8d4876f90495@users.sourceforge.net>
References: <alpine.DEB.2.20.1805172241400.2273@hadrien>
 <d1902859-7b9b-4dea-0e5b-8d4876f90495@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1805181802060.3339@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 18 May 2018, SF Markus Elfring wrote:

> > In terms of the running time, I get a running time of 11 seconds with the
> > command line of 48 files and I get a running time of 22 seconds if I just
> > run spatch on the entire kernel.
>
> * Can such a comparison result be amazing?

No, I don't see anything suprising about it.  More work takes more time.

>
> * How do you think about share any more information about the concrete
>   test environment?
>
>
> > That seems slower, but if I use the command line of 48 files, I get changes
> > in 27 files, while if I run it on the entire kernel, I get changes in 75 files.
>
> Did this try work without the command parameter ?--file-groups??

Yes.  --file-groups is not needed here.

>
>
> > If I run it on the entire kernel using 40 cores (-j 40), I get changes
> > in 75 files in 1.7 seconds.
>
> Have you got access to computation resources which are so powerful?

Yes.

julia
