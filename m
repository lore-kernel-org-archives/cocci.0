From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 23 Oct 2012 23:42:04 +0200 (CEST)
Subject: [Cocci] licensing concerns with cocci patches
In-Reply-To: <50870DB7.8010601@vu.nl>
References: <50870DB7.8010601@vu.nl>
Message-ID: <alpine.DEB.2.02.1210232339230.1942@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 23 Oct 2012, Angelos Oikonomopoulos wrote:

>> On Tue, Oct 23, 2012 at 8:04 AM, Eitan Adler <lists@eitanadler.com> 
>> wrote:
>>> On 22 October 2012 13:05, Julia Lawall <julia.lawall@lip6.fr> wrote:
>>>> My understanding is that the output of a semantic patch should not be 
>>>> GPL.
>>>> But I am not an expert.  In any case, that is the intent.  We would
>>>> certainly be happy that the scripts be part of BSD.
>>> 
>>> Awesome. Hopefully I will be able to start gathering a set of useful
>>> scripts soon.
>> 
>> So... We should talk a bit more :) Also I'd love to help iron out any
>> FUD over licensing issues given that it seems the intent expressed is
>> not to enforce requirement of output being GPL derivative.
>
> Hello,
>
> I apologize for not replying in-thread, but I'm only an occasional user of 
> coccinelle, so I wasn't subscribed to the list.
>
> The concept that the GPL would apply to the output of spatch, just because 
> spatch itself is under the GPL is well beyond far-fetched. By the same logic, 
> it could as well apply to the results of a search-and-replace in emacs :)

Not quite.  Because thre is no GPL on the replace.  The user writes the 
replace himself.  What is being discussed is semantic patches that are 
GPL'd, not the fact that Coccinelle itself is GPL'd.

> The FSF claims that this is not even legally possible, let alone a 
> requirement of the GPL. That goes for any version of the GPL, but I'll just 
> link to the GPLv2 FAQ, as that's what coccinelle uses:
>
> https://www.gnu.org/licenses/old-licenses/gpl-2.0-faq.html#GPLOutput
>
> Coccinelle itself does not produce any code, it transforms code according to 
> supplied rules. If the rules are under the GPL, again there is no requirement 
> about the result of the transformation whatsoever. There are numerous clauses 
> in the GPLv2 to support this statement, but I'll just quote the 0th one:
>
> "The act of running the Program is not restricted, and the output from the 
> Program is covered only if its contents constitute a work based on the 
> Program (independent of having been made by running the Program)"
>
> As a general rule of thumb, one should keep in mind that the the GPL is 
> concerned with preventing the GPL code itself from becoming proprietary and 
> does NOT try to force people to open up their code.
>
> I'm happy that coccinelle is around, I like having it in my toolbox and I 
> would like it if even more projects used it (and more semantic patches became 
> available). I would not want to see its adoption hindered based on some 
> unfounded misconception, nor would I want to see this misconception spread to 
> the coccinelle community :)
>
> FWIW, the DragonFlyBSD project (to which I occasionally contribute) has been 
> happily using coccinelle semantic patches with good results for a while now 
> and I'm glad to hear FreeBSD is going to embrace it further.

Thanks for the input.  It is clearly an issue that needs to be understood 
better.

julia
