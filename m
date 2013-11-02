From: josh@joshtriplett.org (Josh Triplett)
Date: Sat, 2 Nov 2013 08:52:24 -0700
Subject: [Cocci] Matching an absence of statements before the closing
 brace of a function?
In-Reply-To: <alpine.DEB.2.02.1311021555360.2261@hadrien>
References: <20131102133648.GA4190@leaf>
 <alpine.DEB.2.02.1311021455070.2261@hadrien>
 <20131102145412.GT15704@leaf>
 <alpine.DEB.2.02.1311021555360.2261@hadrien>
Message-ID: <20131102155224.GX15704@leaf>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Nov 02, 2013 at 04:02:28PM +0100, Julia Lawall wrote:
> On Sat, 2 Nov 2013, Josh Triplett wrote:
> > On Sat, Nov 02, 2013 at 03:27:35PM +0100, Julia Lawall wrote:
> > > On Sat, 2 Nov 2013, Josh Triplett wrote:
> > > > I wanted to write a semantic patch that matched (and removed) "return;"
> > > > at the end of a void function.  I've attached the full .cocci file
> > > > written for coccicheck, but the key bit looks like this:
> > > >
> > > > @@
> > > > identifier fn;
> > > > @@
> > > > void fn ( ... )
> > > > {
> > > > ...
> > > > - return;
> > > > }
> > > >
> > > > However, that patch also produces results like this:
> > > >
> > > > --- a/drivers/scsi/aacraid/dpcsup.c
> > > > +++ b/drivers/scsi/aacraid/dpcsup.c
> > > > @@ -255,7 +255,6 @@ static void aac_aif_callback(void *conte
> > > >  	    cpu_to_le32(NoMoreAifDataAvailable)) {
> > > >  		aac_fib_complete(fibptr);
> > > >  		aac_fib_free(fibptr);
> > > > -		return;
> > > >  	}
> > > >
> > > >  	aac_intr_normal(dev, 0, 1, 0, fibptr->hw_fib_va);
> > > >
> > > > I'm guessing that either coccinelle didn't pair the braces (so that the
> > > > '}' matches close braces other than the one matching fn's opening brace)
> > > > or coccinelle allowed extra statements before the logical end of the
> > > > function despite the lack of '...'.
> > >
> > > The problem is that Coccinlle works on control-flow paths, and a return is
> > > always at the end of a control-flow path...
> >
> > Not sure I fully understand what you mean.  I do understand why
> > coccinelle works on control-flow paths rather than literal code, and
> > that makes it much more powerful, but I'm still not sure how coccinelle
> > manages to match the patch above to the code above.  Do the braces in
> > the semantic patch above not pair with each other?  If not, why not?  If
> > so, how does "return; }" match something between the "return;" and the
> > "}"?
> 
> The return is followed by all of the nested }s to get it out of the
> function.  I think that there is something special for these }s to skip
> over them, so that the return always seems to be next to the final }.

Huh.  Odd.

> > > Try the following:
> > >
> > > @start@
> > > identifier f;
> > > position p;
> > > @@
> > > f(...) {@p ... }
> > >
> > > @bad@
> > > position p, s != start.p;
> > > @@
> > >
> > > {@s <... return;@p ...> }
> > >
> > > @ef@
> > > position p;
> > > statement S;
> > > @@
> > >
> > > (
> > > while (...) return;@p
> > > |
> > > if (...) return;@p else S
> > > )
> > >
> > > @@
> > > position p != {bad.p,ef.p};
> > > @@
> > >
> > > - return;@p
> >
> > Interesting; I didn't know about the ability to exclude specific
> > positions that way.  However, that doesn't quite work, since it still
> > matches code like this:
> 
> OK, good point.  I will try to find something else.
> 
> return;
> S
> 
> doesn't work, because no statement follows a return.  A return is just
> followed by a sequence of closing braces.

In the control-flow sense, sure.  However, in addition to making this
particular case difficult, that also makes it difficult to use
coccinelle to detect dead code after a return.

> You can try this:
> 
> @@
> @@
> 
> - return;
> + RETURN;
> 
> @r exists@
> identifier f;
> position p;
> @@
> 
> f(...) {
>   ...
>   RETURN at p;
> }
> 
> @@
> position r.p;
> @@
> 
> - RETURN at p;
> 
> @@
> @@
> 
> - RETURN;
> + return;

Cute.  I'm not sure why you need the two separate rules with matching
positions; consolidating the two middle rules into one seems to work as
well.  I did have to add a rule for when the return immediately followed
a label, to make sure there was a statement to target.

However, this seems to have two issues.  First, to some extent I
*wanted* the control-flow matching, to handle cases like this without
having to do so explicitly:

void f(void)
{
	if (...) {
		foo();
-		return;
	}
}

Second, this seems to lead to many formatting issues:

--- a/kernel/rcutree.c
+++ b/kernel/rcutree.c
@@ -895,7 +895,7 @@ static void print_other_cpu_stall(struct
 
 	rcu_print_detail_task_stall(rsp);
 
-	force_quiescent_state(rsp);  /* Kick them all. */
+	force_quiescent_state(rsp);
 }
 
 static void print_cpu_stall(struct rcu_state *rsp)

No idea why coccinelle touched this comment.  Do functions have an
implicit "return;" at the end that got patched here?

--- a/lib/xz/xz_crc32.c
+++ b/lib/xz/xz_crc32.c
@@ -43,7 +43,7 @@ XZ_EXTERN void xz_crc32_init(void)
 		xz_crc32_table[i] = r;
 	}
 
-	return;
+	RETURN;
 }
 
 XZ_EXTERN uint32_t xz_crc32(const uint8_t *buf, size_t size, uint32_t crc)

No idea what happened here to prevent the RETURN; from getting
substituted back.


Also, I noticed some cases where the return; in question immediately
followed a label, so removing it would give that label no statement to
jump to.  I tried handling that explicitly:

@r1 depends on patch exists@
identifier f, l;
statement S;
position p;
@@
void f(...)
{
...
(
l:
- RETURN;@p
  S
|
l:
- RETURN at p
  ;
|
- RETURN;@p
)
}

However, while this did produce the desired result when the return
immeidately followed the label, it produced odd results in other cases:

--- a/crypto/seqiv.c
+++ b/crypto/seqiv.c
@@ -45,6 +45,7 @@ static void seqiv_complete2(struct skcip
 
 out:
 	kfree(subreq->info);
+	return;
 }
 
 static void seqiv_complete(struct crypto_async_request *base, int err)

Many instances like this where coccinelle added "return;" where none
existed before.

- Josh Triplett
