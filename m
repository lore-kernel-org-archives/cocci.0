From: thierry.martinez@inria.fr (Thierry Martinez)
Date: Thu, 12 Oct 2017 01:43:04 +0200 (CEST)
Subject: [Cocci] make install broken
In-Reply-To: <5ad98857-a96d-ecd4-4267-35013ba9ce62@mykolab.com>
References: <9bf92fad-06e9-b1d5-cae2-6ba4fb9fc022@mykolab.com>
 <alpine.DEB.2.20.1710061604140.6420@hadrien>
 <5ecbf5f5-0af4-7c44-258e-c2b464d9a01f@mykolab.com>
 <1237246237.5049793.1507728493328.JavaMail.zimbra@inria.fr>
 <5ad98857-a96d-ecd4-4267-35013ba9ce62@mykolab.com>
Message-ID: <1791440820.5185535.1507765384109.JavaMail.zimbra@inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello, Michael.

Michael:
> A quick search finds libproc.h on github but that has an Apple copyright
> in it. It's basically this one:
> https://opensource.apple.com/source/xnu/xnu-2422.1.72/libsyscall/wrappers/libproc/libproc.h.auto.html

Oops, sorry. I was confused by this (old) package:
https://pkgs.org/download/libproc-dev

It should be fixed now (by using /proc/self/exe if available, or
the environment variable _).

> my shell (GNU bash, version 4.3.43(1)) does show the executable in $_
> but that is the symlink and not the real path to the executable.

Yes, but spatch should have resolved the symlink. Anyway, I changed
the code to use realpath, which should be more reliable (the code
before only resolved symlinks on the executable file, without
considering parent directories).

Sorry for the wrong commit!
-- 
Thierry.

----- Original Message -----
> From: "Michael Stefaniuc" <mstefani@mykolab.com>
> To: "Thierry Martinez" <thierry.martinez@inria.fr>
> Cc: cocci at systeme.lip6.fr
> Sent: Wednesday, October 11, 2017 9:26:57 PM
> Subject: Re: [Cocci] make install broken
> 
> Hello Thierry,
> 
> On 10/11/2017 03:28 PM, Thierry Martinez wrote:
> > Michael Stefaniuc:
> >> But it isn't working when I have a symlink to spatch.
> > 
> > This surprises me because this is precisely what 82a6a045 is supposed to
> > fix,
> > and your version 3ba77b3 includes it.
> > 
> > I suppose it is because your shell does not define the environment variable
> > "_" to the path of the running executable.
> my shell (GNU bash, version 4.3.43(1)) does show the executable in $_
> but that is the symlink and not the real path to the executable.
> 
> luna:~$ cd
> luna:~$ echo -e '#!/bin/bash\necho $_' > foo.sh
> luna:~$ chmod a+x foo.sh
> luna:~$ ln -s ../foo.sh bin/foo.sh
> luna:~$ ./foo.sh
> ./foo.sh
> luna:~$ bin/foo.sh
> bin/foo.sh
> luna:~$ foo.sh
> /home/michi/bin/foo.sh
> 
> bye
> 	michael
> 
> > 
> > I just pushed on GitHub a more portable way for determining the path of the
> > executable relying on proc_pidpath.
> > 
> > Thank you for the report.
> > 
> 
> 
