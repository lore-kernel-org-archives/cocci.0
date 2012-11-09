From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 9 Nov 2012 22:29:13 +0100 (CET)
Subject: [Cocci] [Review needed] Ensure that calls to d_find_alias() are
 followed by dput().
In-Reply-To: <509C118D.3010109@gmail.com>
References: <509B0B81.50304@gmail.com>
 <alpine.DEB.2.02.1211080820540.1945@localhost6.localdomain6>
 <509C118D.3010109@gmail.com>
Message-ID: <alpine.DEB.2.02.1211092221370.2302@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I have attached a new version.  I put some more headers at the top of the 
file.  For the Confidence you should put High, Moderate, or Low.  I put 
Moderate, but perhaps you will think that something else is better.

Exists causes the rule to match when there is a single control-flow path 
through the function that satisfies the specified pattern.  Without it, 
all paths from the first thing that matches are required to match the 
pattern, unless * is used (context mode).

<... P ...> allows 0 or more occurrences of P within the path matched by 
<... ...>.  It is just like ... except that it allows the occurrences of P 
(that you might want to modify, collect the position of etc.)

<+... P ...+> is like <... P ...> except that it requires that there is at 
least one occurrence of P in the control-flow path.

I am not sure that Peter's false positive is really a false positive.  The 
missing dput is at the beginning of the function, whereas the patch 
addressed the end of the function.  Perhaps the author of the patch 
thought about the function an realized that a dput wasn't needed at the 
beginning.  But the patch at least doesn't say why.

Semantic patches for integration into Linux should be sent to Michal Marek 
<mmarek@suse.cz>, as well as to the people at COCCINELLE/Semantic Patches 
(SmPL) in MAINTAINERS.

thanks,
julia
-------------- next part --------------
/// Make sure calls to d_find_alias() have a corresponding call to dput().
//
// Keywords: d_find_alias, dput
//
// Confidence: Moderate?
// URL: http://coccinelle.lip6.fr/
// Options: -include_headers

virtual context
virtual org
virtual patch
virtual report

@initialize:python depends on org || report@
msg = "Missing call to dput() at line %s."

@r exists@
local idexpression struct dentry *dent;
expression E, E1;
statement S1, S2;
position p1, p2;
@@
(
	if (!(dent at p1 = d_find_alias(...))) S1
|
	dent at p1 = d_find_alias(...)
)

<...when != dput(dent)
    when != if (...) { <+... dput(dent) ...+> }
    when != true !dent || ...
    when != dent = E
    when != E = dent
if (!dent || ...) S2
...>
(
	return <+...dent...+>;
|
	return @p2 ...;
|
	dent at p2 = E1;
|
	E1 = dent;
)

@depends on context@
local idexpression struct dentry *r.dent;
position r.p1,r.p2;
@@
* dent at p1 = ...
  ...
(
* return at p2 ...;
|
* dent at p2
)


@script:python depends on org@
p1 << r.p1;
p2 << r.p2;
@@
cocci.print_main("Missing call to dput()",p1)
cocci.print_secs("",p2)

@depends on patch@
local idexpression struct dentry *r.dent;
position r.p2;
@@
(
+ dput(dent);
  return @p2 ...;
|
+ dput(dent);
  dent@p2 = ...;
)

@script:python depends on report@
p1 << r.p1;
p2 << r.p2;
@@
coccilib.report.print_report(p1[0], msg % (p2[0].line))
