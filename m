From: cakturk@gmail.com (Cihangir Akturk)
Date: Fri, 22 Sep 2017 22:28:25 +0300
Subject: [Cocci] [PATCH] coccicheck: improve pattern for getting
	relative path
In-Reply-To: <alpine.DEB.2.20.1708102108110.2174@hadrien>
References: <1502386825-363-1-git-send-email-cakturk@gmail.com>
 <alpine.DEB.2.20.1708102108110.2174@hadrien>
Message-ID: <20170922192825.GA12554@yoga.localdomain>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Aug 10, 2017 at 09:08:31PM +0200, Julia Lawall wrote:
> 
> 
> On Thu, 10 Aug 2017, Cihangir Akturk wrote:
> 
> > When invoked with V=1, coccicheck script prints the information about
> > which semantic patch (*.cocci file) used for this operation.  Actually,
> > it prints out the relative path of the related semantic patch. The
> > script uses sed to remove the source tree part from cocci file path like
> > so:
> >
> > FILE=`echo $COCCI | sed "s|$srctree/||"`
> >
> > This pattern works well most of the time. But in cases where $COCCI
> > doesn't start with "./" characters, it doesn't remove the right part.
> >
> > Consider the following scenario:
> >
> > $ make coccicheck COCCI=scripts/coccinelle/api/drm-get-put.cocci \
> >                         MODE=patch M=drivers/staging V=1
> >
> > where
> >
> > COCCI=scripts/coccinelle/api/drm-get-put.cocci and srctree=.
> >
> > In this case, out pattern matches the first "s/", and we end up
> > assigning "scriptcoccinelle/api/drm-get-put.cocci" to $FILE.
> >
> > Fix this by adding a caret ^ at the beginning of regex pattern, so that
> > it matches only start of the path.
> 
> Nicolas, is this ok?

Any comments on this patch? No one has commented yet. But I still get
the same results on current linux-next.

> 
> julia
> 
> >
> > Signed-off-by: Cihangir Akturk <cakturk@gmail.com>
> > ---
> >  scripts/coccicheck | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/coccicheck b/scripts/coccicheck
> > index ec487b8..8de4245 100755
> > --- a/scripts/coccicheck
> > +++ b/scripts/coccicheck
> > @@ -193,7 +193,7 @@ coccinelle () {
> >
> >      if [ $VERBOSE -ne 0 -a $ONLINE -eq 0 ] ; then
> >
> > -	FILE=`echo $COCCI | sed "s|$srctree/||"`
> > +	FILE=`echo $COCCI | sed "s|^$srctree/||"`
> >
> >  	echo "Processing `basename $COCCI`"
> >  	echo "with option(s) \"$OPT\""
> > --
> > 2.7.4
> >
> >
