From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 10 Mar 2014 20:24:26 +0100 (CET)
Subject: [Cocci] Selection of class libraries ...?
In-Reply-To: <531E04D9.5000605@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
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
 <531DFDBC.9010801@users.sourceforge.net>
 <alpine.DEB.2.10.1403101919350.2082@hadrien>
 <531E04D9.5000605@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1403102022510.2181@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 10 Mar 2014, SF Markus Elfring wrote:

> >> Would you like to suggest any references for class libraries which work in OCaml
> >> with popular data structures in a way I am used to from other programming languages?
> >> Is the "convenience" and software speed similar there?
> > 
> > I have no idea what you are asking for.
> 
> The programming language "OCaml" has got the property that values from standard
> data types are immutable. Now I am looking for a well-known OCaml class library
> which supports the modification of data structures like strings and lists in
> place. I would prefer to reuse an existing one instead of developing another
> variation for my experiments.

Why do you want to do this?  There is a String.set function that allows 
you to modify a character of a string.  For a list, if you need to modify 
an element then it should be a list of reference cells.  But I think that 
in practice it would be strange for either operation to be necessary.

julia
