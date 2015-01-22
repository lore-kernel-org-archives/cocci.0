From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 22 Jan 2015 10:37:16 +0200 (SAST)
Subject: [Cocci] Run time differences between SmPL disjunctions and
 regular expressions (in constraints)
In-Reply-To: <54C0B4DF.9060203@users.sourceforge.net>
References: <D59A6A6F-9D60-44DE-9B6C-8B615B776EA8@gmail.com>
 <54BFD099.8030002@users.sourceforge.net>
 <F6392E9E-0D22-4398-8173-DD84FFEBAB98@gmail.com>
 <alpine.DEB.2.10.1501212342170.2599@hadrien>
 <54C0B4DF.9060203@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1501221032270.4079@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 22 Jan 2015, SF Markus Elfring wrote:

> > Only use regular expressions if you absolutely have to.  They are not
> > interpreted when preselecting files, so they drasticaly hurt performance.
>
> How is a file pre-selection involved here?

Perhaps it is not relevant in this case, because it is a negative
constraint.  Still, at least in the case of positive constraints, one
should be aware that a regular expression is much more expensive than just
listing n functions.

> Would anybody like to compare the concrete run time consequences for the
> specification
> of a specific function name list in semantic patch scripts?
> * Alternation for regular expressions in SmPL constraints
> * SmPL disjunction variant

Since you care so much about performance, why not do it yourself?  But I
think that it is very highly dependent on the semantic patch and the
function names involved.  For example if you mention just one function
name that is used just once in the Linux kernel, there will be only the
cost of scanning the strings in each file for that token.  If you put it
in a regular expression there will be the cost of parsing every file.  But
if the function is used in every file, eg kmalloc, the scanning cost will
go down, because the relevant files will be identified more quickly, but
the overall runtime will be high, eg the same as a regular expression for
kmalloc, because (almmost) every file will be processed anyway.

julia
