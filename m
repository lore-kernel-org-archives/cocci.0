From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 25 Feb 2014 21:20:57 +0100 (CET)
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <530CF8FF.8080600@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 25 Feb 2014, SF Markus Elfring wrote:

> > I don't think it is a good approach to do anything related to 5142
> > different functions at once.
> 
> A source code search with the following pattern found only six functions for
> further consideration.
> 
> @is_unnecessary_check@
> expression data;
> identifier work;
> identifier release =~ "^kz?free$";
> position pos;
> type t;
> @@
>  t work at pos(...)
>  {
>   ...
> ( if (data) release(data);
> | if (likely(data)) release(data);
> )
>   ...
>  }
> 
> 
> I wonder a bit about this analysis result because the SmPL pattern I started
> this discussion thread with showed a few more update candidates.

Remember that ... matches the shortest path between what is before and 
what is after.  So if there is another if test on the same data in the 
function, that will cause a failure.  If yo udon't care to have this 
constraint, you can put when any on a ...

> > It would be better to pick a small set of functions, and work on them 
> > carefully.
> 
> I would prefer to handle a more complete fix pattern.

As you like, but I think that no Linux maintainer will accept a patch that 
makes more than a few changes, so doing them all at once is a waste of 
time.  Anyway, you would have to split up the patches according to 
maintainer.

> By the way: I read about corresponding software update approaches in an 
> article "Best practices for a big patch series" by Wolfram Sang.
> 
> 
> How are the chances to resolve the message "Fatal error: exception
> Pcre.Error(_)" with a proposed long alternation?

Pcre is a standard library.  I know nothing about its implementation.  But 
it is not surprising that a regular expression with over 5000 options 
exceeds its capacity.

julia
