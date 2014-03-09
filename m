From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 09 Mar 2014 09:00:45 +0100
Subject: [Cocci] Determination of the number for named function
	parameters
In-Reply-To: <alpine.DEB.2.02.1403082240410.2126@localhost6.localdomain6>
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
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <531B0D52.5070008@users.sourceforge.net>
 <alpine.DEB.2.10.1403081514140.2156@hadrien>
 <531B32F4.9080004@users.sourceforge.net>
 <531B771D.3020900@users.sourceforge.net>
 <alpine.DEB.2.02.1403082240410.2126@localhost6.localdomain6>
Message-ID: <531C1FAD.6030009@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Would you like to clarify data analysis according to the current situation
>> around "coccilib.elems.TermList instance"?
> 
> I know nothing about this.

I am surprised by this feedback.

I assume that a corresponding interface description would be nice if I look at
"man 3cocci Coccilib". How are the chances to improve the mapping from the OCaml
API to the Python binding?


> But I am not sure that using it is the best way to do whjat you 
> want, although I also don't know what you want to do.

The tool "spatch" counts all elements in a metavariable of the type "parameter
list". I would like to treat list elements that have got the function parameter
type "void" or no name differently.
- How can I assign the number "zero" (instead of "1") in this case?
- Should I generally exclude parameters without names from another report variant?

I am also interested a bit in run time optimisation. A passed list should be
sufficient for further computations. I do not really need a count in another
variable which was specified between square brackets of a SmPL rule.

Regards,
Markus
