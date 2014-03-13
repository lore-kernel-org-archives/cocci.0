From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 13 Mar 2014 19:58:38 -0400 (EDT)
Subject: [Cocci] Clarification for OCaml scripts in SmPL
In-Reply-To: <alpine.DEB.2.10.1403131955490.2146@hadrien>
References: <5307CAA2.8060406@users.sourceforge.net>
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
 <alpine.DEB.2.02.1403102022510.2181@localhost6.localdomain6>
 <531E2A51.5050000@users.sourceforge.net>
 <alpine.DEB.2.02.1403102215010.2181@localhost6.localdomain6>
 <5320328F.5090507@users.sourceforge.net>
 <alpine.DEB.2.10.1403131955490.2146@hadrien>
Message-ID: <alpine.DEB.2.10.1403131958090.2146@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 13 Mar 2014, Julia Lawall wrote:

> >    let output text = Printf.printf "%s\r\n" text in
>
> It's not related to the problem, but I'm not sure to understand "let
> output text = ..."  Normally the left hand side of a let has only one
> variable.

I'm sorry.  That was a stupid comment :)  It is the definition fo a
function.

julia
