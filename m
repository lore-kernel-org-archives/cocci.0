From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 18 Aug 2017 11:15:49 +0200
Subject: [Cocci] Improving size determinations with SmPL
In-Reply-To: <alpine.DEB.2.20.1708181046390.3580@hadrien>
References: <788ea49a-14c4-7dfe-d868-c8df90dd4439@users.sourceforge.net>
 <alpine.DEB.2.20.1708171721280.3748@hadrien>
 <alpine.DEB.2.20.1708171818300.3748@hadrien>
 <1a936e2d-a2aa-5e2e-923b-bfc585bda5c6@users.sourceforge.net>
 <7ac95e61-aab1-9182-7f8c-136254a94d24@users.sourceforge.net>
 <alpine.DEB.2.20.1708181046390.3580@hadrien>
Message-ID: <737c9cf2-5268-6fcf-973f-3a787709c400@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Here I have the c code,

You have also access to the referenced source files for this Linux software module.


> but not the semantic patch.

I find this kind of feedback surprising.

We discussed it a bit yesterday so that this SmPL script was stored also in
the mailing list archive.
https://systeme.lip6.fr/pipermail/cocci/2017-August/004350.html


> In particular, I don't know whether you are using the version with <... ...>

I am using the optional nest construct for a while also because


> or <+... ...+>.

this SmPL construct does not work for my use case. (I stored a corresponding
test script under an other file name.)
How will the discussion be continued for the bug report ?Get the non-optional
nest construct completely working for SmPL??
https://github.com/coccinelle/coccinelle/issues/114


> The latter is more time consuming because it has to do extra chcks.

I am curious if the software execution can fit better into more pleasing
time ranges.


> Both, however, need to follow the control-flow of the function,
> so they can be expensive if there are many loops or conditionals.

I assume that there are further improvement possibilities available
for the desired run time characteristics.

Regards,
Markus
