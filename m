From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 29 Nov 2017 22:51:21 +0100
Subject: [Cocci] Having rules span multiple files
In-Reply-To: <alpine.DEB.2.20.1711292224510.2074@hadrien>
References: <20171129205814.GV729@wotan.suse.de>
 <alpine.DEB.2.20.1711292224510.2074@hadrien>
Message-ID: <20171129215121.GX729@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Nov 29, 2017 at 10:28:43PM +0100, Julia Lawall wrote:
> Anohter option is to create a file with lists of file names that should be
> considered together.  So you could have:
> 
> a/foo.c
> a/xyz.c
> 
> b/bar.c
> b/mno.c
> b/zzz.c
> 
> Then use --file-groups with the name of this file.

Ah, now we just need something which given a directory or config option
infers the number of associated files to that config option. :)

  Luis
