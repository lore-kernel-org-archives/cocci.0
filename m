From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 4 Mar 2016 08:09:16 +0100 (CET)
Subject: [Cocci] Coccinelle Compilation Problem: configure file
In-Reply-To: <CAJTCqFadstafOZPgjDoV48zNFBHkTdp+4=a0WLGbfKaTCSqgOw@mail.gmail.com>
References: <CAJTCqFadstafOZPgjDoV48zNFBHkTdp+4=a0WLGbfKaTCSqgOw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1603040808450.2062@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 3 Mar 2016, Aftab Hussain wrote:

> Dear Members of the Coccinelle Team,
> 
> Hope you are doing well. Me and my team mates have been recently working on
> program analysis, and are very keen on working with your tool.
> Unfortunately, we faced a compilation problem.
> 
> I was trying to compile Coccinelle using the source
> (https://github.com/coccinelle/coccinelle). I followed all instructions,
> mentioned in the "install.txt" file, but
> when I enter the following command in the "coccinelle-master" directory,
> 
> ./configure --enable-release
> 
> I get the following error message,
> 
> bash: ./configure: No such file or directory
> 
> I see the "configure" file is missing from your source. I would be most
> grateful if you could please advise on how I may fix this.

Did you run ./autogen first?  Probably the install.txt file needs to be 
updated.  Thanks for the report.

julia

> 
> Thanks,
> Aftab
> 
> Aftab Hussain
> PhD Student,
> Department of Computer Science,
> University of California, Irvine
> 
> 
