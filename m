From: wagi@monom.org (Daniel Wagner)
Date: Wed, 17 Jul 2013 17:41:58 +0200
Subject: [Cocci] Formatting issues
In-Reply-To: <alpine.DEB.2.02.1307171728420.2113@hadrien>
References: <51E6B08E.9030600@monom.org>
 <alpine.DEB.2.02.1307171706400.2113@hadrien> <51E6B532.8010909@monom.org>
 <alpine.DEB.2.02.1307171728420.2113@hadrien>
Message-ID: <51E6BB46.7020100@monom.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 07/17/2013 05:31 PM, Julia Lawall wrote:
>> Another formatting issue I found is triggered by a different rule. I
>> figure
>> the expression 'E' is written out as one line and the original
>> formatting gets
>> lost.
>
> Yes, there is not much I can do about this one.  When you match code
> into a metavariable, all of the whitespace and comments go away.  It
> doesn't know that you still want them in the place where you add the
> metavariable back in.
>
> If you have a probleme with this, as in your example, you can try to
> rewrite the semantic patch so that the metavariable is there but does
> not appear in the - and + code.  For example, for your first case below
> you can write
>
> E
> - == TRUE

Well, it is there only around 20 places where the formatting gets 
corrupted via this rule. I'll just write a cleanup patch after
this automatic change. That is okay.

cheers,
daniel
