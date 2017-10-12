From: mstefani@mykolab.com (Michael Stefaniuc)
Date: Thu, 12 Oct 2017 21:22:32 +0200
Subject: [Cocci] make install broken
In-Reply-To: <1791440820.5185535.1507765384109.JavaMail.zimbra@inria.fr>
References: <9bf92fad-06e9-b1d5-cae2-6ba4fb9fc022@mykolab.com>
 <alpine.DEB.2.20.1710061604140.6420@hadrien>
 <5ecbf5f5-0af4-7c44-258e-c2b464d9a01f@mykolab.com>
 <1237246237.5049793.1507728493328.JavaMail.zimbra@inria.fr>
 <5ad98857-a96d-ecd4-4267-35013ba9ce62@mykolab.com>
 <1791440820.5185535.1507765384109.JavaMail.zimbra@inria.fr>
Message-ID: <bcd3ffc7-5048-3450-72fd-496c572c7aea@mykolab.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Thanks Thierry,

On 10/12/2017 01:43 AM, Thierry Martinez wrote:
> Michael:
>> A quick search finds libproc.h on github but that has an Apple copyright
>> in it. It's basically this one:
>> https://opensource.apple.com/source/xnu/xnu-2422.1.72/libsyscall/wrappers/libproc/libproc.h.auto.html
> 
> Oops, sorry. I was confused by this (old) package:
> https://pkgs.org/download/libproc-dev
> 
> It should be fixed now (by using /proc/self/exe if available, or
> the environment variable _).
> 
>> my shell (GNU bash, version 4.3.43(1)) does show the executable in $_
>> but that is the symlink and not the real path to the executable.
> 
> Yes, but spatch should have resolved the symlink. Anyway, I changed
> the code to use realpath, which should be more reliable (the code
> before only resolved symlinks on the executable file, without
> considering parent directories).
the code builds, installs and runs!
luna:~$ spatch --version
spatch version 1.0.6-00335-g6e5973d compiled with OCaml version 4.02.3
Flags passed to the configure script:
--prefix=/usr/local/packages/coccinelle-1.0.6-335-g6e5973d
--with-python=/usr/bin/python3 --with-menhir=/usr/bin/menhir
Python scripting support: yes
Syntax of regular expresssions: PCRE

thanks again
bye
	michael
