From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 13 Mar 2014 20:19:56 -0400 (EDT)
Subject: [Cocci] Clarification for OCaml scripts in SmPL
In-Reply-To: <53204EC0.5030804@users.sourceforge.net>
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
 <53204EC0.5030804@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1403132019170.2146@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 12 Mar 2014, SF Markus Elfring wrote:

> > let store_positions fun count places =
> >     current_function := fun;
>
> Does OCaml not like my name selection here?
> Do I accidentally stumble on another software development "surprise" with
> reserved key words?

Well, it is not really a surprise.  Fun is indeed a reserved keyword in
ocaml.

julia

> http://ocaml.org/learn/faq.html
>
>   let store_positions fu count places =
>       current_fu := fu;
>       current_count := string_of_int count;
>       List.iter append places
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
