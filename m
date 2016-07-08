From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 8 Jul 2016 15:02:01 +0200
Subject: [Cocci] Checking build dependencies for "Menhir"
In-Reply-To: <ow4bn28qpyb.fsf@mbp-thierry.rsr.lip6.fr>
References: <64de7df6-acd6-7ddf-efc7-b4055203211c@users.sourceforge.net>
 <ow4h9c1qfm3.fsf@mbp-thierry.rsr.lip6.fr>
 <adef0045-4d3b-8e8c-9f5d-bf00de66c722@users.sourceforge.net>
 <ow4furkqwl3.fsf@mbp-thierry.rsr.lip6.fr>
 <trinity-8ac09448-d240-4749-abb6-a492eca97242-1467977569565@3capp-webde-bs29>,
 <ow4bn28qpyb.fsf@mbp-thierry.rsr.lip6.fr>
Message-ID: <trinity-8994e07b-f08f-4e12-a523-ae4c673b2ac2-1467982921657@3capp-webde-bs29>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > Is the bundled Menhir version currently required for a working
> > Coccinelle software?
> 
> No, you can use a more recent version of Menhir if you want.

I would appreciate that.

I am struggling to complete the needed dependencies for current releases
of various OCaml software.


> The reason of having an old version of Menhir in the bundles is that the
> newer versions of Menhir require OCaml 4.02 (for "match exception"), and
> we would like to keep the compatibility with OCaml 4.01 (or even 3.12).

Do such constraints need any more configuration checks in the build scripts?


> I don?t know if dependencies can be made more precise

I guess that it is generally possible to improve the build system safety.


> between the Coccinelle code and bundled libraries.

I am unsure on the efforts that we would like to invest here.


> I think it is not too demanding, but I agree that we should write
> more clearly in the commit message when cleaning is required.

I hope that such an extra build script clean-up should not be needed usually.

Regards,
Markus
