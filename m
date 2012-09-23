From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 23 Sep 2012 07:47:07 +0200 (CEST)
Subject: [Cocci] Unwanted space added at end of line
In-Reply-To: <1348352839.1867.8.camel@ice-age.regit.org>
References: <1348302555.11590.8.camel@ice-age.regit.org>
 <alpine.DEB.2.02.1209221907450.1899@localhost6.localdomain6>
 <1348352839.1867.8.camel@ice-age.regit.org>
Message-ID: <alpine.DEB.2.02.1209230746040.1869@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 23 Sep 2012, Eric Leblond wrote:

> Hello,
>
> Thanks a lot Julia for your fast and efficient answer !
>
> Le samedi 22 septembre 2012 ? 19:08 +0200, Julia Lawall a ?crit :
>> A proposed patch that fixes this and some other trailing whitespace
>> problems is attached.  I still need to check that it does not break
>> anything, so let me know if there are any new problems.
>
> First of all, it fixes the whitespace issue described in my previous
> mail.
>
> I've runned all my cocci test with this patch applied and no problem
> appears.
>
> I've only one issue left regarding formatting but this is dependant of
> my indentation style and can not be considered as a real problem. The
> issue is that the transformation modifies my indentation like shows in
> the following example:
>
> -    if (new_pe == NULL) {
> -        return NULL;
> -    }
> +    if (unlikely(new_pe == NULL))
> +        {
> +            return NULL;
> +        }
>
> I obtain a code which is not with the good coding style and need to be
> reindented. Is there a way to specify to coccinelle we want to use a
> specific model of indentation ?

To me, it looks like a bug, not a model of indentation.  It should have 
put the first { where it was before, and then everything would have been 
OK.  I'll take a look.

julia
