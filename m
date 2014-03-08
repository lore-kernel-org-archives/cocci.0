From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 8 Mar 2014 15:16:57 +0100 (CET)
Subject: [Cocci] Determination of the number for named function
 parameters
In-Reply-To: <531B0D52.5070008@users.sourceforge.net>
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
Message-ID: <alpine.DEB.2.10.1403081514140.2156@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 8 Mar 2014, SF Markus Elfring wrote:

> > A source code search with the following pattern found 893 functions which check
> > their single parameter.
>
> I am also interested to generate statistics for the declaration of function
> parameters and their use.
> Is it possible to analyse the function parameter list by interfaces from the
> semantic patch language? Can any useful numbers be extracted at this place?

The question is not very precise.  I don't know what you mean by analyse,
nor what you mean by interfaces, nor what you mean by useful.  You can
write things like:

f(...,T i,...) { ... }
where T is a type and i is an identifier

or

f(...,p,...) { ... }
where p is a parameter

or

f(ps,p,...) { ... }
where ps is a parameter list and p is a parameter.

In declaratin a parameter list, you can also say;

parameter list[n] ps;

and then n is the number of parameters that are matched.

julia
