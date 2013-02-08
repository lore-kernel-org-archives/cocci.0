From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 8 Feb 2013 07:06:52 +0100 (CET)
Subject: [Cocci] Wrong --parse-c stats
In-Reply-To: <511420BF.50704@redhat.com>
References: <511420BF.50704@redhat.com>
Message-ID: <alpine.DEB.2.02.1302080704140.2079@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> dlls/msxml3/tests/domdoc.c
> NB total files = 1; perfect = 0; pbs = 1; timeout = 0; =========> 0%
> nb good = 0,  nb passed = 168 =========> inf% passed
> nb good = 0,  nb bad = 3250 =========> 0.000000% good

It would be possible to miss every token in a file, if there is a parsing 
problem in the first declaration and the parser never manages to recover.  
For example, it will never recover if there is a space at the beginning of 
every line.  It is a little bit strange that it considers some tokens to 
be passed even if none of them are good.  Passed tokens are things like 
macro arguments that it is not able to parse.  It would seem more 
consistent if the passed tokens were only the good tokens.

Thanks for the report about the rest.  We will look into it.

julia
