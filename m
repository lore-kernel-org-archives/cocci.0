From: wagi@monom.org (Daniel Wagner)
Date: Mon, 29 Jul 2013 10:42:52 +0200
Subject: [Cocci] Formatting issues
In-Reply-To: <20130717155132.GA20499@domone.kolej.mff.cuni.cz>
References: <51E6B08E.9030600@monom.org>
 <alpine.DEB.2.02.1307171706400.2113@hadrien> <51E6B532.8010909@monom.org>
 <alpine.DEB.2.02.1307171728420.2113@hadrien>
 <20130717155132.GA20499@domone.kolej.mff.cuni.cz>
Message-ID: <51F62B0C.2040906@monom.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 07/17/2013 05:51 PM, Ond?ej B?lka wrote:
> On Wed, Jul 17, 2013 at 05:31:15PM +0200, Julia Lawall wrote:
>>> Another formatting issue I found is triggered by a different rule. I figure
>>> the expression 'E' is written out as one line and the original formatting gets
>>> lost.
>>
>> Yes, there is not much I can do about this one.  When you match code
>> into a metavariable, all of the whitespace and comments go away.  It
>> doesn't know that you still want them in the place where you add the
>> metavariable back in.
>>
>> If you have a probleme with this, as in your example, you can try to
>> rewrite the semantic patch so that the metavariable is there but
>> does not appear in the - and + code.  For example, for your first
>> case below you can write
>>
> I ran to problems with formating when I tried use cocci in glibc.
>
> I think that semantic patch and its formatting are two separate issues.

Thought semantic patching can't just ignore formatting.

> Ideal situation is when project formatting is fully machine specified.
> Then we can apply patch, run formatter and we are done.

In my case, I can use checkpatch.pl to report some errors.

> Otherwise we can try to convince other developers that benefit of refactoring
> is bigger than formatting issues it causes or fix it by hand.
>
> I now try to convince others to use first option as this allows all
> submitted patches have perfect formatting because formatter took care of
> it. This can save few round trips when reviewer wants space after comma
> etc.

The main problem I see is as soon you start modifing the output from 
spatch by hand you risk to introduce an error and as soon one does 
several rounds of review it one will introduce an error.

For the changes in ConnMan I did applied the semantic patch and then
went over the code base via checkpatch.pl and fixed up the errors.

I don't know if a simple rule like 80 chars max couldn't be added for
the --linux-spacing switch. That was the offender in my case. The
rest of the patch was okay.

cheers,
daniel
