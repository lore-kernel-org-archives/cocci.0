From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 6 Oct 2016 07:42:50 +0200
Subject: [Cocci] Replacing one variable name with another
In-Reply-To: <878tu2ctnm.fsf@thinkpad.rath.org>
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
 <f49b95f0-071f-7c36-55cc-8dd02921e211@users.sourceforge.net>
 <878tu2ctnm.fsf@thinkpad.rath.org>
Message-ID: <ff8ef53c-e67f-eec7-212b-3e4e729fcce5@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> @name_replacement@
>> @@
>>  my_type *
>> -ptr
>> +pointer
>>  ;
> 
> I could try it, but I'm actually more interested in understanding how
> this works (I already solved my primariy problem).

Thanks for your interest.


> Could you explain this script a bit more?

Yes, of course.

It shows the general structure of a simple script for the semantic patch language.

Outline:
* Block for definition of SmPL metavariables
* Specification of C source code fragments (together with desired changes)


> What exactly does "@name_replacement@" mean?

Such a SmPL rule can specify a name for it. Which identifier would you
choose there according to your naming preferences?
http://coccinelle.lip6.fr/docs/main_grammar002.html


> Does it the interpretation of "my_type *" further down?

No. - I tend to use a title there which is descriptive somewhat.


>> How will your software development experiments evolve for the desired
>> application of the semantic patch language?
> 
> Aeh, sorry, I don't understand the question.

Do you plan to try any more SmPL scripts out?
How do you think about to share further experiences?

Regards,
Markus
