From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 7 Mar 2016 20:55:35 +0100
Subject: [Cocci] Parsing C source files by Coccinelle
In-Reply-To: <CAO=9Y+0KUsrK4OpR9YrNpp5JJ2tDDoY-DOq0xfDBcY8GdKWwCQ@mail.gmail.com>
References: <CAJTCqFadstafOZPgjDoV48zNFBHkTdp+4=a0WLGbfKaTCSqgOw@mail.gmail.com>
 <56D99C75.7080100@users.sourceforge.net>
 <CAO=9Y+2Qm+A9a91zGrYNJavOXcWFR2hj5Xx+=FPG1p02KdC7Ew@mail.gmail.com>
 <56DDCAD3.2080309@users.sourceforge.net>
 <CAO=9Y+0KUsrK4OpR9YrNpp5JJ2tDDoY-DOq0xfDBcY8GdKWwCQ@mail.gmail.com>
Message-ID: <56DDDCB7.5060206@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> In particular, we would like to see whether it is possible to improve Coccinelle results
> by supplying it with aliasing information about variables.

Does such a goal indicate that you are going to experiment also with data flow analysis?


> On executing,
> *
> spatch -sp_file demos/simple.cocci demos/simple.c -o /tmp/new_simple.c*
> 
> I get "spatch is not installed".

Did you call the command "make install" with appropriate permissions
and configuration parameters?


> Also when I execute the following to test spatch,
> 
> *COCCINELLE_HOME=/home/aftab/workspace/coccinelle-master ./scripts/spatch -sp_file demos/simple.cocci demos/simple.c -o /tmp/new_simple.c
> *
> I get,
> 
> *bash: ./scripts/spatch: No such file or directory*
> 
> I would like to let you know that I performed all the installation steps (make, make install),
> and I noticed no errors.

Interesting ?


> However, I am sceptical about why "make install" is carrying out the following operations,
> 
> *rm -f /usr/local/lib/coccinelle/spatch
> rm -f /usr/local/lib/coccinelle/spatch.opt
> rm -f /usr/local/bin/pycocci*
> 
> I wonder whether this is causing the problem.

I am also unsure about your software situation at the moment.
Would you like to share any more information about your test environment?


> Would be great if you could advise me on this.

I hope that we can help you a bit more.

Regards,
Markus
