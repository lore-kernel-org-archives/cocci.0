From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 21 Jun 2016 22:51:00 +0200
Subject: [Cocci] [PATCH v3 0/8] coccicheck: modernize
In-Reply-To: <alpine.DEB.2.02.1606212211210.2040@localhost6.localdomain6>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.02.1606212211210.2040@localhost6.localdomain6>
Message-ID: <20160621205100.GV25646@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jun 21, 2016 at 10:13:31PM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 21 Jun 2016, Luis R. Rodriguez wrote:
> 
> > This v3 series addresses the feedback from the last v2 series
> > on the coccicheck enhancements [0], namely:
> > 
> > o it drops the indexing heuristics in favor for a .cocciconfig use
> > o drops glimpse support as its simply not well maintained, recommends
> >   idutils instead.
> > o adds a Linux .cocciconfig -- the assumption is you'd run spatch when
> >   you're at the top level of the kernel. This has not only the side effect
> >   of picking up .cocciconfig, but also that the coccicheck use of the
> >   make variables passed on are assumed to be correct given the base
> >   directory as the current directory.
> 
> I don't understand this point.  Coccinelle picks up the .cocciconfig, if 
> any, of the directory on which you want to work, not of the current one.

The order of precedence for variables for .coccoconfig is as follows:

 o Your current user's home directory is processed first
 o Your directory from which spatch is called is processed next
 o The directory provided with the --dir option is processed last, if used

Since coccicheck runs through make, it naturally runs from the kernel proper
dir, as such the second rule above would be implied for picking up a .cocciconfig.
That's part of the point I'm making.

Up next let us consider when M= is used or when it is not used, if used
it populates KBUILD_EXTMOD.

    if [ "$KBUILD_EXTMOD" = "" ] ; then
        OPTIONS="--dir $srctree $COCCIINCLUDE"
    else                                                                        
        OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
    fi

Either way --dir is used, so the third rule applies and so your .cocciconfig
from there is also read if one is found. My other point was that $COCCIINCLUDE
has some useful tidbits of includes for coccinelle, and that also assumes
one is on the top level dir of the kernel.

That is sanitized as follows:

# spatch only allows include directories with the syntax "-I include"           
# while gcc also allows "-Iinclude" and "-include include"                      
COCCIINCLUDE=${LINUXINCLUDE//-I/-I }                                            
COCCIINCLUDE=${COCCIINCLUDE// -include/ --include} 

So the point is to annotate that the .cocconfig is picked up first due
to the fact make is used and its issued from the top level makefile
and starts from the top level. The fact that --dir is used is important
but secondary to its introduction as well.

  Luis
