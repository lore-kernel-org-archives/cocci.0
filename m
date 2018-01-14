From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 14 Jan 2018 13:48:25 +0100 (CET)
Subject: [Cocci] Coccinelle: alloc_cast: Add more memory allocating
 functions to the list
In-Reply-To: <5e10af93-14cd-371d-2262-bef2fb2ca387@users.sourceforge.net>
References: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
 <68dd2f4a-7921-922c-399d-284d3506415d@users.sourceforge.net>
 <alpine.DEB.2.20.1801141003270.7902@hadrien>
 <2fd51b6d-75d8-ee9a-b52f-beab2299d9b0@users.sourceforge.net>
 <alpine.DEB.2.20.1801141056190.7902@hadrien>
 <0ca5933b-6973-8273-2646-3241157058cf@users.sourceforge.net>
 <alpine.DEB.2.20.1801141126290.7902@hadrien>
 <8649d987-c6f2-f36d-3a6f-cfda02557362@users.sourceforge.net>
 <20180114112844.GA2649@himanshu-Vostro-3559>
 <5e10af93-14cd-371d-2262-bef2fb2ca387@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1801141344350.7902@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> 4. Is is more efficient to use the Python key word ?in? to look for
>    a short string instead of fiddling with the programming interface
>    for regular expressions?

If you test it and find that it is significantly more efficient, then
please send a patch accordingly.

>
> 5. Please omit the variable ?msg? in the last SmPL rule.
>    The need data can be passed directly instead.

The use of the msg variable is common in the semantic patches in the
kernel.  Ampng other things it increases the chance that the line will fit
in 80 characters.  It is not completely a success here, but at least it is
more of a success than it would be otherwise.

julia
