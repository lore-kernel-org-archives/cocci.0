From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 2 Dec 2016 16:06:32 +0100
Subject: [Cocci] Comparing SmPL script constraints with direct regular
 expression interface
In-Reply-To: <alpine.DEB.2.10.1612021526560.3056@hadrien>
References: <99797688-d8b2-5001-dd92-26f98e3a4901@users.sourceforge.net>
 <19d8e848-da35-10af-6773-deab88137852@users.sourceforge.net>
 <alpine.DEB.2.10.1612021441470.3056@hadrien>
 <55445a2c-87c9-3794-4dee-5a006b6d1029@users.sourceforge.net>
 <alpine.DEB.2.10.1612021456580.3056@hadrien>
 <8e4a9ea0-9bb4-740e-a3d7-a434eb7cdcb6@users.sourceforge.net>
 <alpine.DEB.2.10.1612021526560.3056@hadrien>
Message-ID: <d4721682-6a48-f4c8-b32a-a68f2b298dc5@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Do you find the documentation complete for this functionality at the moment?
> 
> No idea.

How can we achieve a better common understanding on this aspect for example?


>> I imagine a need for advanced configuration possibilities around ?regexp? engines.
> 
> You imagine many things.

Yes, of course.   ;-)


> Changes will only happen when there is a concrete need.

I came along some development needs also together with software experiments
around SmPL scripts.
How do your needs look different over time?


>> Is the current approach the official one already?
> 
> Yes.

Thanks for this information.


>>> Perhaps the constraint scrpt syntax could be generalized to allow more
>>> in practice than function calls.
>>
>> Which software development concerns can hinder progress in the way
>> I imagine so far?
> 
> Lack of time.
> 
>>
>>> That might happen some day, but it is an extremely low priority.
>>
>> I am curious if the involved dependencies can be clarified further.
> 
> I doubt there are any dependencies.

Our software development capacity is limited as usual.
Will future software research activities improve the situation a bit more?


>> https://github.com/coccinelle/coccinelle/blob/cbc751b30d9e02390d60ebed643c8e4a3fa0bb2b/tests/idcon_ocaml.cocci
> 
> In the test case the braces are around a function call, not a function name.

This detail is also clear for me to some degree.


> No idea what could be relevant or irrelevant about it.

I got further ideas for this software area after a delay.


> That is the syntax that has been implemented.

I wonder still why such a variant was chosen.


> It may change when someone when someone motivated enough to work on the
> implementation writes the code to make the change and tests the result.

My motivation could eventually increase if the understanding of the
corresponding OCaml source code could become better somehow besides
other factors.


> It won't change just because someone finds it conceptually inelegant
> and sends lots of emails about it.

So there is some usual change resistance. I dare to provide intensive feedback
in the hope that details can be uncovered which can support more progress.


> It's actually strange that you want to define regexps in other places,

This detail is just another aspect for the involved software evolution.


> but you don't want to define scripts in other places.

I got also further ideas around the placement of script fragments.


> Why not just define a python function that you can call in a script
> to do your big regexp for you?

This approach can only work safely if script constraints will be completely
documented in the manual (besides one test case in OCaml and Python).

Regards,
Markus
