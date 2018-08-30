From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 30 Aug 2018 09:51:18 -0700 (PDT)
Subject: [Cocci] Checking support for the analysis of preprocessor
 definitions
In-Reply-To: <c78ab16d-c26b-9a90-1989-c5a91e276e67@users.sourceforge.net>
References: <alpine.DEB.2.21.1808281514290.2555@hadrien>
 <c78ab16d-c26b-9a90-1989-c5a91e276e67@users.sourceforge.net>
Message-ID: <alpine.DEB.2.21.1808300947350.2604@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 30 Aug 2018, SF Markus Elfring wrote:

> >>  #define PADARG64 "0x%016"QUAD"x"
>
> How does the support for such preprocessor definitions look like by
> the Coccinelle software currently?
> https://github.com/coccinelle/coccinelle/issues/139
>
> I have tried another source code analysis experiment out.
> I got the following information then.
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch --parse-cocci ~/Projekte/Coccinelle/Probe/find_macro_without_spaces_besides_identifier1.cocci
> ?
> minus: parse error:

The only options before the : in such messages are minus and plus.  Minus
is the removed and context code as it should be matched against the
existing code. Plus is the added code or the context in which it occurs.

>   ?
>   around = 'Q',
>   whole content =  #define P64 "a"@literal_end Q at usage "@literal_startb"

I don't think that the semantic patch language supports concatenated
strings as patterns.

julia

>
> I find this error message questionable because my test SmPL script does not
> contain a deletion specification (no ?minus? there).
>
> Are these double quotation characters treated as tokens (for the attempted
> data processing with position metavariables)?
> http://coccinelle.lip6.fr/docs/main_grammar002.html
>
> Does such an example indicate challenges to see the end of the used variables
> (by the means of the semantic patch language)?
>
> Regards,
> Markus
>
