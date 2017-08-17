From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 17 Aug 2017 13:31:42 +0200
Subject: [Cocci] Coccinelle: add atomic_as_refcounter script
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B6FF489CB@IRSMSX102.ger.corp.intel.com>
References: <1502884342-10702-2-git-send-email-elena.reshetova@intel.com>
 <ae535db6-f568-9424-466d-596844c1ab9f@users.sourceforge.net>
 <2236FBA76BA1254E88B949DDB74E612B6FF489CB@IRSMSX102.ger.corp.intel.com>
Message-ID: <e3de8671-68e8-a6d6-5d7b-4886c06e5bff@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Why do you insist to use the variables ?fname2? till ?fname6? in
>> this evolving SmPL script (instead of merging them into a single one
>> with a special constraint)?
> 
> I am pretty new to Coccinelle

This is fine. I am curious then how your interests will evolve further
in this software area.


> and Julia has recommended against this approach,

She showed a special response.

If you search in the mailing list archive, you will find some details
where she had different opinions than me for some technical aspects
during usual discussions.


> so I was merely following her advice.

Not completely. - You expressed a need to use regular expressions for
constraints in the SmPL rule ?r1? already.
I suggest to take another look at available design choices.
Under which circumstances will it be helpful to switch between
involved programming languages?


> I really do not understand the implications of the change as well 
> as she does.

My software understanding is also still evolving in this area.

* Some clarification approaches did not reach the point so that
  missing information could be resolved in a desired way.

* Some knowledge did not find their way from research papers and
  corresponding OCaml source code into other documentation formats
  for a better understanding of system dependencies so far.


> Your approach would certainly look prettier script-wise,

Thanks for such a feedback.


> but I don't want to cause any undesirable side-effects.

You would like to implement a special search (and transformation) pattern.

* Are you keen to find the ?effects? out which are really desirable for you?

* Would you try any precise system tests out for the determination of
  preferred run time behaviour?


>> How do you think about to omit the cover letter for the addition
>> of such a script (when the change log can be integrated into
>> the same message for your update suggestion)?
> 
> Sorry, not sure I understood this. Could you please explain more?

You replied with the message ?[PATCH] Coccinelle: add atomic_as_refcounter
script? (from ?Aug 16 13:52:22 CEST 2017?) to your own message
?[PATCH v3] provide rule for finding refcounters? (from ?Aug 16
13:52:21 CEST 2017?), didn't you?
https://systeme.lip6.fr/pipermail/cocci/2017-August/004333.html
https://systeme.lip6.fr/pipermail/cocci/2017-August/004334.html

Will it be sufficient to send only SmPL script variants for
further clarification to achieve the desired consensus?


How do you think about to reconsider another implementation detail?
Example:
Why do you see a need to enclose the identifier ?a? by parentheses?

Regards,
Markus
