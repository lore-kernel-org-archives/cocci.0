From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 8 Mar 2014 22:59:44 +0100 (CET)
Subject: [Cocci] Determination of the number for named function
 parameters
In-Reply-To: <531B32F4.9080004@users.sourceforge.net>
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
Message-ID: <alpine.DEB.2.02.1403082257440.2126@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 8 Mar 2014, SF Markus Elfring wrote:

> > In declaratin a parameter list, you can also say;
> > 
> > parameter list[n] ps;
> > 
> > and then n is the number of parameters that are matched.
> 
> Thanks for your interesting details.
> 
> I find the use of the element "n" (the name in square brackets) not obvious from
> the Coccinelle manual so far.

It is the number of elements that have been matched.  You can use it in 
python code (as a string, I think), in ocaml code (as an integer), or 
inherit it into another list-typed metavariable.

> But I would like to try more analysis with the data that is passed by the
> metavariable type "parameter list". I have started to look a bit into it by the
> function "pickle.dumps". This kind of display is not so useful for me yet.
> I am missing documentation for corresponding data structures I can depend on in
> further reports.

What analysis do you want to do?  If you write an ocaml script, you can 
have access to the comple abstract syntax trees.  Python code only 
receives a string representation.

julia
