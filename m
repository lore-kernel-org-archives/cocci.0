From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 09 Mar 2014 09:50:25 +0100
Subject: [Cocci] Determination of the number for named function
	parameters
In-Reply-To: <alpine.DEB.2.02.1403090906180.2030@localhost6.localdomain6>
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
 <alpine.DEB.2.02.1403090906180.2030@localhost6.localdomain6>
Message-ID: <531C2B51.1040700@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I didn't implement it, and I never use python.

I would struggle with OCaml script development more so far.


> Have a special rule for such functions and use position variables to 
> prevent the rule that matches interesting parameter lists from matching 
> functions that have satisfied this case:

Thanks for your SmPL pattern suggestion.


> @r@
> position p;
> identifier f;
> @@
> 
> f at p(void} { ... }
> 
> @goodfunctions@
> position p != r.p;
> parameter list[n] ps;
> identifier f;
> @@
> 
> f at p(ps) { ... }

I would prefer to specify a meaningful constraint for the metavariable "ps" somehow.


> Or you can just use your python code to see if ps is just the string 
> "void".

I thought also in a similar direction. But I would like to be sure about the
passed data structures. I imagine that I would need to inspect the class
"coccilib.elems.TermList" if the corresponding documentation is unclear.


> 
>> I am also interested a bit in run time optimisation. A passed list should be
>> sufficient for further computations. I do not really need a count in another
>> variable which was specified between square brackets of a SmPL rule.
> 
> It is hard to imagine why converting all the elements of a list to strings 
> as is done in the interface to python would be more efficient than just 
> passing a single number.

I would like to try out two reports at least.

1. What is the maximum number of named function parameters in a source code base?
   I need only the value "n" (without the additional data from the related
metavariable).

2. Comparison for the incidence of unnamed function parameters to all of them
   The parameter count could be determined from the list of parameter names
alone, couldn't it?

Regards,
Markus
