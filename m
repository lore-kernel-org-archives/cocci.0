From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 12 Mar 2014 13:10:40 +0100
Subject: [Cocci] Clarification for OCaml scripts in SmPL
In-Reply-To: <5320328F.5090507@users.sourceforge.net>
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
 <531DFDBC.9010801@users.sourceforge.net>
 <alpine.DEB.2.10.1403101919350.2082@hadrien>
 <531E04D9.5000605@users.sourceforge.net>
 <alpine.DEB.2.02.1403102022510.2181@localhost6.localdomain6>
 <531E2A51.5050000@users.sourceforge.net>
 <alpine.DEB.2.02.1403102215010.2181@localhost6.localdomain6>
 <5320328F.5090507@users.sourceforge.net>
Message-ID: <53204EC0.5030804@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> let store_positions fun count places =
>     current_function := fun;

Does OCaml not like my name selection here?
Do I accidentally stumble on another software development "surprise" with
reserved key words?
http://ocaml.org/learn/faq.html

  let store_positions fu count places =
      current_fu := fu;
      current_count := string_of_int count;
      List.iter append places

Regards,
Markus
