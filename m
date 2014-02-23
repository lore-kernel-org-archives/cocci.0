From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 23 Feb 2014 17:42:26 +0100 (CET)
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <530A22F5.4000301@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A22F5.4000301@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1402231740070.1985@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > You may also want to specify that input has pointer type, since you are
> > actually looking for NULL tests, not zero tests.
> 
> This is an important implementation detail which I would like to generalise so
> that also functions like "btrfsic_process_written_block" will be safely found by
> further source code searches.
> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/fs/btrfs/check-integrity.c?id=878a876b2e10888afe53766dcca33f723ae20edc#n1835
> 
> This one was found by the previous simple pattern for example despite I expected
> it to handle primarily pointer data types instead of an "unsigned int" in this case.

As you like.  As a general principle, I think it is better to work on 
fewer things at once.  There are many reason why values may be null or 0, 
and if you lump too many of them together, you will end up with more 
information than is manageable.  No bugs are involved here, you are only 
making the code simpler, and if you miss some possibilities for making the 
code simpler, it doesn't matter.  You can just work on them later.

julia
