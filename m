From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 3 Dec 2014 10:19:46 +0100 (CET)
Subject: [Cocci] Determination of the number for named function
 parameters
In-Reply-To: <547ED432.8060204@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
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
 <531C63B8.6090403@users.sourceforge.net>
 <alpine.DEB.2.10.1403091404230.2101@hadrien>
 <531C6E71.8020807@users.sourceforge.net>
 <alpine.DEB.2.10.1403091439160.2101@hadrien>
 <547EC539.5060300@users.sourceforge.net>
 <alpine.DEB.2.10.1412030948030.2373@hadrien>
 <547ED432.8060204@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1412031018310.2373@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 3 Dec 2014, SF Markus Elfring wrote:

> >> Does the OCaml scripting interface provide more information (besides the
> >> SmPL API) which can be useful in advanced source code analysis?
> >
> > No.
>
> How is the status about an abstract syntax tree interface which was mentioned
> in a wiki article a while ago?

No idea what you are referring to.  In an ocaml script, if you declare a
metavariable as:

(a,b) << r.e;

then b is the abstract syntax tree of e.  You can eg process it using the
visitors available visitor_c.ml.

julia
