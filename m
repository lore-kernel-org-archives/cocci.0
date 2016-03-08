From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Tue, 8 Mar 2016 09:57:27 +0100
Subject: [Cocci] Coccinelle Compilation Problem: configure file
In-Reply-To: <CAO=9Y+2fMJ58zUc5JdxZrvist=vj3AVMGd9gj9opVtOXJrjQDg@mail.gmail.com>
References: <CAJTCqFadstafOZPgjDoV48zNFBHkTdp+4=a0WLGbfKaTCSqgOw@mail.gmail.com>
 <alpine.DEB.2.02.1603040808450.2062@localhost6.localdomain6>
 <CAO=9Y+2fMJ58zUc5JdxZrvist=vj3AVMGd9gj9opVtOXJrjQDg@mail.gmail.com>
Message-ID: <20160308085727.GA1455@pl-59055.rocqadm.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear Aftab,

Many thanks for your interest in Coccinelle.

> Hi Julia Lawall and the Coccinelle Team,
> 
> I really appreciate your response. I was able to generate the configure
> file using *>./autogen*,
> and all the installation steps. Thank you so much. Unfortunately, now I'm
> unable to execute spatch.
> 
> On executing this:
> 
> *spatch -sp_file demos/simple.cocci demos/simple.c -o /tmp/new_simple.c*
> 
> I get "spatch is not installed".

Odd. What does
which spatch
say? Can you look at the file it points to?
This file should be a shell script that tries to find the real spatch
executable. If you are a bit familiar with shell scripts, perhaps you
can go through this file and see whether the executables it tries to
look for are there?

> Also when I execute the following to test spatch,
> 
> 
> *COCCINELLE_HOME=/home/aftab/workspace/coccinelle-master ./scripts/spatch
> -sp_file demos/simple.cocci demos/simple.c -o /tmp/new_simple.c*
> I get,
> 
> *bash: ./scripts/spatch: No such file or directory*

You can try to replace ./scripts/spatch by ./spatch in this command, I
think it should work better.

> I would like to let you know that I performed all the installation steps (make,
> make install), and I noticed no errors.
> However, I am sceptical about why "make install" is carrying out the
> following operations,
> 
> 
> 
> *rm -f /usr/local/lib/coccinelle/spatchrm -f
> /usr/local/lib/coccinelle/spatch.optrm -f /usr/local/bin/pycocci*
> 
> I wonder whether this is causing the problem. I would be most glad if you
> could please help me install spatch.

I don't think these commands can cause a problem: they are supposed to
make sure there is nothing left from previous installs.

Feel free to send us the output of make install to make sure there is no
problem there.


> 
> Just in case, I installed the latest versions of OCaml and Menhir using
> OPAM.

Okay. FYI, Coccinelle is also packaged for opam. It is not the latest
version but depending on what you intend to do it might be good enough,
at least for a start.

S?bastien.
