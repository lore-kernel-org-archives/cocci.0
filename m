From: aftab.hussain46@gmail.com (Aftab Hussain)
Date: Mon, 7 Mar 2016 07:54:06 -0800
Subject: [Cocci] Coccinelle Compilation Problem: configure file
In-Reply-To: <alpine.DEB.2.02.1603040808450.2062@localhost6.localdomain6>
References: <CAJTCqFadstafOZPgjDoV48zNFBHkTdp+4=a0WLGbfKaTCSqgOw@mail.gmail.com>
 <alpine.DEB.2.02.1603040808450.2062@localhost6.localdomain6>
Message-ID: <CAO=9Y+2fMJ58zUc5JdxZrvist=vj3AVMGd9gj9opVtOXJrjQDg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia Lawall and the Coccinelle Team,

I really appreciate your response. I was able to generate the configure
file using *>./autogen*,
and all the installation steps. Thank you so much. Unfortunately, now I'm
unable to execute spatch.

On executing this:

*spatch -sp_file demos/simple.cocci demos/simple.c -o /tmp/new_simple.c*

I get "spatch is not installed".

Also when I execute the following to test spatch,


*COCCINELLE_HOME=/home/aftab/workspace/coccinelle-master ./scripts/spatch
-sp_file demos/simple.cocci demos/simple.c -o /tmp/new_simple.c*
I get,

*bash: ./scripts/spatch: No such file or directory*

I would like to let you know that I performed all the installation steps (make,
make install), and I noticed no errors.
However, I am sceptical about why "make install" is carrying out the
following operations,



*rm -f /usr/local/lib/coccinelle/spatchrm -f
/usr/local/lib/coccinelle/spatch.optrm -f /usr/local/bin/pycocci*

I wonder whether this is causing the problem. I would be most glad if you
could please help me install spatch.

Just in case, I installed the latest versions of OCaml and Menhir using
OPAM.

Best Regards,
Aftab

On Thu, Mar 3, 2016 at 11:09 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:

> On Thu, 3 Mar 2016, Aftab Hussain wrote:
>
> > Dear Members of the Coccinelle Team,
> >
> > Hope you are doing well. Me and my team mates have been recently working
> on
> > program analysis, and are very keen on working with your tool.
> > Unfortunately, we faced a compilation problem.
> >
> > I was trying to compile Coccinelle using the source
> > (https://github.com/coccinelle/coccinelle). I followed all instructions,
> > mentioned in the "install.txt" file, but
> > when I enter the following command in the "coccinelle-master" directory,
> >
> > ./configure --enable-release
> >
> > I get the following error message,
> >
> > bash: ./configure: No such file or directory
> >
> > I see the "configure" file is missing from your source. I would be most
> > grateful if you could please advise on how I may fix this.
>
> Did you run ./autogen first?  Probably the install.txt file needs to be
> updated.  Thanks for the report.
>
> julia
>
> >
> > Thanks,
> > Aftab
> >
> > Aftab Hussain
> > PhD Student,
> > Department of Computer Science,
> > University of California, Irvine
> >
> >
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160307/c282673f/attachment.html>
