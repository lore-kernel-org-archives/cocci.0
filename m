From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 9 Mar 2014 09:12:18 +0100 (CET)
Subject: [Cocci] Determination of the number for named function
 parameters
In-Reply-To: <531C1FAD.6030009@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
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
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <531B0D52.5070008@users.sourceforge.net>
 <alpine.DEB.2.10.1403081514140.2156@hadrien>
 <531B32F4.9080004@users.sourceforge.net>
 <531B771D.3020900@users.sourceforge.net>
 <alpine.DEB.2.02.1403082240410.2126@localhost6.localdomain6>
 <531C1FAD.6030009@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1403090906180.2030@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 9 Mar 2014, SF Markus Elfring wrote:

> >> Would you like to clarify data analysis according to the current situation
> >> around "coccilib.elems.TermList instance"?
> > 
> > I know nothing about this.
> 
> I am surprised by this feedback.

I didn't implement it, and I never use python.  The thing you are citing 
was implemented by a masters student for his masters thesis project, and 
it contains whatever he found useful.

> I assume that a corresponding interface description would be nice if I 
> look at "man 3cocci Coccilib". How are the chances to improve the 
> mapping from the OCaml API to the Python binding?

If you would like to have such a thing you are welcome to implement.  In 
my experience the AST is very rarely useful.

> > But I am not sure that using it is the best way to do whjat you 
> > want, although I also don't know what you want to do.
> 
> The tool "spatch" counts all elements in a metavariable of the type 
> "parameter list". I would like to treat list elements that have got the 
> function parameter type "void" or no name differently.
> - How can I assign the number "zero" (instead of "1") in this case?

Have a special rule for such functions and use position variables to 
prevent the rule that matches interesting parameter lists from matching 
functions that have satisfied this case:

@r@
position p;
identifier f;
@@

f at p(void} { ... }

@goodfunctions@
position p != r.p;
parameter list[n] ps;
identifier f;
@@

f at p(ps) { ... }

Or you can just use your python code to see if ps is just the string 
"void".

> I am also interested a bit in run time optimisation. A passed list should be
> sufficient for further computations. I do not really need a count in another
> variable which was specified between square brackets of a SmPL rule.

It is hard to imagine why converting all the elements of a list to strings 
as is done in the interface to python would be more efficient than just 
passing a single number.

Anyway, the runtime cost is not here, in either case.  The runtime cost 
will be that you have to parse every function of every file.

julia
