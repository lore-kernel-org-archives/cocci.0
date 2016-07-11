From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 11 Jul 2016 18:32:35 +0200
Subject: [Cocci] Checking build dependencies for "Menhir"
In-Reply-To: <ow460scqqna.fsf@mbp-thierry.rsr.lip6.fr>
References: <64de7df6-acd6-7ddf-efc7-b4055203211c@users.sourceforge.net>
 <ow4h9c1qfm3.fsf@mbp-thierry.rsr.lip6.fr>
 <adef0045-4d3b-8e8c-9f5d-bf00de66c722@users.sourceforge.net>
 <ow4furkqwl3.fsf@mbp-thierry.rsr.lip6.fr>
 <trinity-8ac09448-d240-4749-abb6-a492eca97242-1467977569565@3capp-webde-bs29>
 <ow4bn28qpyb.fsf@mbp-thierry.rsr.lip6.fr>
 <a3ee1a3d-e547-d336-ac51-8f9dd77fc35d@users.sourceforge.net>
 <f3220b01-edc4-0124-f38e-bcb96bcdeb91@users.sourceforge.net>
 <ow460scqqna.fsf@mbp-thierry.rsr.lip6.fr>
Message-ID: <84249af2-77ff-7b54-1c66-5e7d007f7436@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> menhir and menhirLib were detected independently, and the detection of
> menhirLib required ocamlfind: so, if menhir was installed on your system
> but if you didn't have ocamlfind,

This software tool was available in my use case.


> Coccinelle used the system menhir but the bundled menhirLib,
> hence the failure your noticed in case of version mismatch.

Did you consider also another implementation detail already?

* How do you think about the relevance of a make command parameter
  or setting in the environment like "USE_OCAMLFIND=1"?

* Fran?ois Pottier is thinking about improvements for the document "INSTALLATION".

Regards,
Markus
