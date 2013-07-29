From: wagi@monom.org (Daniel Wagner)
Date: Mon, 29 Jul 2013 16:59:30 +0200
Subject: [Cocci] Formatting issues
In-Reply-To: <20130729092851.GA8704@domone.kolej.mff.cuni.cz>
References: <51E6B08E.9030600@monom.org>
 <alpine.DEB.2.02.1307171706400.2113@hadrien> <51E6B532.8010909@monom.org>
 <alpine.DEB.2.02.1307171728420.2113@hadrien>
 <20130717155132.GA20499@domone.kolej.mff.cuni.cz>
 <51F62B0C.2040906@monom.org> <alpine.DEB.2.02.1307291047250.2271@hadrien>
 <51F630D7.1070701@monom.org> <20130729092851.GA8704@domone.kolej.mff.cuni.cz>
Message-ID: <51F68352.1060107@monom.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 07/29/2013 11:28 AM, Ond?ej B?lka wrote:
> On Mon, Jul 29, 2013 at 11:07:35AM +0200, Daniel Wagner wrote:
>> On 07/29/2013 10:49 AM, Julia Lawall wrote:
>>>>> I now try to convince others to use first option as this allows all
>>>>> submitted patches have perfect formatting because formatter took care of
>>>>> it. This can save few round trips when reviewer wants space after comma
>>>>> etc.
>>>>
>>>> The main problem I see is as soon you start modifing the output from spatch by
>>>> hand you risk to introduce an error and as soon one does several rounds of
>>>> review it one will introduce an error.
>>>>
>>>> For the changes in ConnMan I did applied the semantic patch and then
>>>> went over the code base via checkpatch.pl and fixed up the errors.
>>>>
>>>> I don't know if a simple rule like 80 chars max couldn't be added for
>>>> the --linux-spacing switch. That was the offender in my case. The
>>>> rest of the patch was okay.
>>>
>>> It's a simple rule in theory, but not so simple in practice.  Pretty
>>> printing is a hard problem, because doing a good job requires knowing both
>>> what you have seen before and what is coming up.  Also, when Coccinelle is
>>> generating code, it doesn't see the AST any more, only tokens, so it has
>>> limited information.
>>
>> I understand that in reality this is a hard problem. Something what
>> I would helpful here would be a list of lines (emacs/vim parseable)
>> where the the result line is too long, presumed that detecting of
>> long lines is easy.
>>
> I already did it in stylepp. You need to install it

Thanks, I give it a try.

cheers,
daniel
