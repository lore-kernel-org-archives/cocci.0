From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 9 Oct 2016 08:32:19 +0200
Subject: [Cocci] Replacing one (specific!) type with another
In-Reply-To: <87shs6y3hq.fsf@vostro.rath.org>
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610052158110.3130@hadrien>
 <8760p6ctgw.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610060750180.3179@hadrien> <878ttzjzss.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610080743040.3176@hadrien> <87shs6y3hq.fsf@vostro.rath.org>
Message-ID: <7cf0dddc-90e4-9d77-c171-009877c6ae62@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> The name is illustrated in Advanced SmPL:
>> http://coccinelle.lip6.fr/papers/cocciwk4_talk2.pdf
> 
> Call me stupid, but I just went through it again and I still don't see
> it. There are lots of examples with "@ ..stuff..@" (the first on slide
> 4), but as far as I can tell it never explains what this means.

How do you find information from a corresponding syntax description
for the semantic patch language?

Metavariables for transformations
http://coccinelle.lip6.fr/docs/main_grammar002.html


> Actually, the frequent occurence of @script:python@ makes me think that
> this actually has semantic signficance and is much more than a label
> that I can choose for my own convenience...?

Did you read another published document already?

Metavariables for scripts
http://coccinelle.lip6.fr/docs/main_grammar003.html

Regards,
Markus
