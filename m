From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Fri, 8 May 2015 08:59:16 +0200
Subject: [Cocci] [PATCH RFC] Coccinelle: Check for return not matching
	function	signature
In-Reply-To: <alpine.DEB.2.10.1505052323270.2915@hadrien>
References: <1430820761-28122-1-git-send-email-hofrat@osadl.org>
 <alpine.DEB.2.10.1505051633550.2640@hadrien>
 <20150505160035.GB9724@opentech.at>
 <alpine.DEB.2.10.1505052323270.2915@hadrien>
Message-ID: <20150508065916.GA3886@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 05 May 2015, Julia Lawall wrote:

> 
> 
> On Tue, 5 May 2015, Nicholas Mc Guire wrote:
> 
> > On Tue, 05 May 2015, Julia Lawall wrote:
> >
> > > > + at match@
> > > > +identifier f,ret;
> > > > +position p;
> > > > +type T1,T2;
> > > > +@@
> > > > +
> > > > +T1 f(...) {
> > > > + T2 ret;
> > > > +<+...
> > > > +* return at p ret
> > > > +;
> > > > +...+>
> > > > +}
> > >
> > > Given the number of results, it may seem surprising, but I think that you
> > > are actually missing a lot of results.  Becaue you require that ret be the
> > > first variable that is declared in the function.  Also, you require that
> > > ret be an identifier.  If you want to keep the restriction about being an
> > > identifier, you could put:
> > >
> > > @match exists@
> > > type T1,T2;
> > > idexpression T2 ret;
> 
> I was think ing that you don't want expression in general, because for all
> contansts that will give you int.
> 
> You can of course put return C; for constant metavariable C in the
> disjunction to avoid that possibility.
>
looks a lot better and removed a lot of false positives - the main problem 
now is managing classification of the kernels type "system" - seems like there
are atleast 5 ways to describe every type (except for enum) and infinitely
many possible assignments for ssize_t ...

here a little summary of the outputs - might be motivation to put some 
quite simple scanners into mainline to catch such issues.

comparison of return types in functions to the functions signature for 
kernel 4.1-rc2, glibc-2.9 and busybox 1.2.2.1 - no particular reason for
that glibc/busybox versions they just happend to be on my harddrive.

This is using the version that was fixed by Julia Lawal
<snip>
@match exists@                                                                 
type T1,T2;
idexpression T1 ok;
idexpression T2 ret;
identifier f;
constant C;
position p;
@@

T1 f(...) {
<+...
(
return ok;
|
return C;
|
return@p ret;
)
...+>
}
<snip>

component  Nr funcs != type    %
kernel   :  374600   10727   2.85 
glibc    :    9184     268   2.92
busybox  :    3645      43   1.18

                         kernel  glibc busybox  criticality
wrong ?                :     8     4    0       not sure
sign missmatch         :  2279    30    9       critical
down sized             :   435    49    4       critical
up sized               :   910    20    3       ugly
declaration missmatch  :  7095   165   27       wishlist

wrong: seems plain wrong like float assigned to int (did not check details yet)
sign missmatch: assigning signed types to unsiggned or vice versa
down sized:  some form of possible truncation like u64 being assigned u32
up sized: non-critical as it was correct type and it fit
declaration missmatch: means that they were named differently s32/int

Some limitations:
The glibc runs produced some error cases (spatch level) that were ignored
for now e.g.:
<snip>
EXN:Failure("match: node 194: return ...[1,2,90] in rec_dirsearch reachable
by inconsistent control-flow paths")
<snip>
The kernel numbers are a bit inaccurate because not all types can be 
checked reliably - e.g. when they are config dependent also due to the
enourmous type-"system" in the kernel not all assignments are sure
but that does not change the overall result.
I did not yet manage to automate the classification - just too many types
where its hard to say due to config dependencies - probably need to put
thos into a "don't know" category. Also all assignments of pointers of
any type on one side to void * on the other side was counted as legitimate.
Some results were mangled probably because of inacurate filtering resulting 
in things like "_EXTERN_INLINE != mp_limb_t" just dropped those for now.

Conclusion:
* atleast the sign missmatch cases (2279) and potentially truncating 
  assignments (435) are problematic. 
* the scripts needs a lot more cleanup in the classification of the reported
  types to be useful
* probably not realistic to cleanup all currently present tupe mismatches
  but scanning continuously and reporting before it goes into mainline or
  integrating such a check in the routine submission process seems
  worthwhile

 Once the classifier is working properly I'll post the next version.

thx!
hofrat
