From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 2 Dec 2016 15:20:29 +0100
Subject: [Cocci] Comparing SmPL script constraints with direct regular
 expression interface
In-Reply-To: <alpine.DEB.2.10.1612021456580.3056@hadrien>
References: <99797688-d8b2-5001-dd92-26f98e3a4901@users.sourceforge.net>
 <19d8e848-da35-10af-6773-deab88137852@users.sourceforge.net>
 <alpine.DEB.2.10.1612021441470.3056@hadrien>
 <55445a2c-87c9-3794-4dee-5a006b6d1029@users.sourceforge.net>
 <alpine.DEB.2.10.1612021456580.3056@hadrien>
Message-ID: <8e4a9ea0-9bb4-740e-a3d7-a434eb7cdcb6@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I don't think there is anything to be more explicit about.

Do you find the documentation complete for this functionality at the moment?


> I don't foresee any change in the regular expression syntax,

I imagine a need for advanced configuration possibilities around ?regexp? engines.


> and I don't forsee any change in the constraint script syntax.

Is the current approach the official one already?


> Perhaps the constraint scrpt syntax could be generalized to allow more
> in practice than function calls.

Which software development concerns can hinder progress in the way
I imagine so far?


> That might happen some day, but it is an extremely low priority.

I am curious if the involved dependencies can be clarified further.


>> Have we got just different views about the relevance of curly brackets around
>> the specification of a function name (instead of a complete function body)?
> 
> No idea what this means.  What curly braces?  What function name?

I find this kind of feedback strange.

I hope that communication difficulties can be resolved better around
the provided test case, can't it?
https://github.com/coccinelle/coccinelle/blob/cbc751b30d9e02390d60ebed643c8e4a3fa0bb2b/tests/idcon_ocaml.cocci

Regards,
Markus
