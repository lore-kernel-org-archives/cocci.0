From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 28 Sep 2015 15:13:48 +0200 (CEST)
Subject: [Cocci] [PATCH v2] coccinelle: assign signed result to unsigned
 variable
In-Reply-To: <560938D6.70305@users.sourceforge.net>
References: <alpine.DEB.2.10.1509261106040.2737@hadrien>
 <1443437687-16559-1-git-send-email-a.hajda@samsung.com>
 <56092D7B.4030106@users.sourceforge.net> <56092E98.9000103@samsung.com>
 <560930A7.2070400@users.sourceforge.net>
 <alpine.DEB.2.10.1509281440320.3108@hadrien>
 <560938D6.70305@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1509281512510.3148@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 28 Sep 2015, SF Markus Elfring wrote:

> > I guess parallelism would be helpful?
> > You could try the following options:
> >
> > -j n --chunksize 10 --recursive-includes --include-headers-for-types
> >
> > where n is the number of cores that you want to use.
>
> Has the make target "coccicheck" direct support for such special parameters?
>
>
> > Parsed header files will be cached within chunks.
>
> Can the Coccinelle software work together with a kind of "precompiled
> header database"?

There is an option --use-cache, which caches the compiled code on the
disk.  But I have not found the effects to be very satisfactory.  It is
still necessary to read in the serialized code.

julia
