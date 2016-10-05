From: Nikolaus@rath.org (Nikolaus Rath)
Date: Wed, 05 Oct 2016 15:34:05 -0700
Subject: [Cocci] Replacing one variable name with another
In-Reply-To: <f49b95f0-071f-7c36-55cc-8dd02921e211@users.sourceforge.net> (SF
 Markus Elfring's message of "Wed, 5 Oct 2016 19:21:49 +0200")
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
 <f49b95f0-071f-7c36-55cc-8dd02921e211@users.sourceforge.net>
Message-ID: <878tu2ctnm.fsf@thinkpad.rath.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Oct 05 2016, SF Markus Elfring <elfring@users.sourceforge.net> wrote:
>> 2. ..and how would I go about if instead of the type, I want to replace
>>    a variable name? (my_type *ptr --> my_type *pointer).
>
> Would you like to try another small SmPL script out like the following?
>
>
> @name_replacement@
> @@
>  my_type *
> -ptr
> +pointer
>  ;

I could try it, but I'm actually more interested in understanding how
this works (I already solved my primariy problem). Could you explain
this script a bit more? What exactly does "@name_replacement@" mean?
Does it the interpretation of "my_type *" further down?


> How will your software development experiments evolve for the desired
> application of the semantic patch language?

Aeh, sorry, I don't understand the question.


Best,
-Nikolaus

-- 
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             ?Time flies like an arrow, fruit flies like a Banana.?
