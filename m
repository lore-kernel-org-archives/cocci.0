From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 6 Oct 2016 08:30:52 +0200
Subject: [Cocci] Replacing one (specific!) type with another
In-Reply-To: <8760p6ctgw.fsf@thinkpad.rath.org>
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610052158110.3130@hadrien>
 <8760p6ctgw.fsf@thinkpad.rath.org>
Message-ID: <34e90c59-2d96-6c77-4185-40e77511488c@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> @@
>> typedef my_type;
>> idexpression mytype * p1;
>> @@
>>
>> - ptr at p1
>> + pointer
>>
>> This checks for the word ptr, and also checks that it is an identifier of
>> the right type.  I haven't tested it, so let me know if there is any problem.
> 
> Well, I don't have an actual use-case anymore.

I am curious when the next one will evolve for you.


> My problem is solved,

Nice to hear.


> I'm just curious what else I could do with Coccinelle to do :-).

This software supports a lot of development possibilities.


> Somehow I'm having a really hard time grasping the fundamentals.

The learning process can take a while as usual.


> The first two examples make sense - I could adapt them for similar situations.

Thanks for your understanding.


> But then, I still have absolutely no idea how I would come
> up with the third example, or how to adapt it.

The usage of SmPL metavariables was demonstrated a bit.


> What does "idexpression" mean?

This is a specific metavariable type which handles C variables.


> What does "ptr at p1" mean?

This expression shows the restriction of a C code identifier by the means
of a SmPL variable.


> Is this documented anywhere?

Yes, of course.
http://coccinelle.lip6.fr/docs/main_grammar002.html#elem

Would you like to help in improving corresponding descriptions?


> I'd hate to waste your time asking tons of such trivial questions
> on the mailing list,

The answers will be published from which others can hopefully learn a bit.
It will take some time to become more familiar with an evolving
software technology.

Are you looking for a FAQ document?


> but I just can't find any helpful documentation at all...

I find this feedback strange. - Where did you look so far?

The help could become better there as usual.
Which information sources did you check before?

Regards,
Markus
