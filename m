From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 17 May 2018 22:45:29 +0200 (CEST)
Subject: [Cocci] exists do not work if file group is too big
In-Reply-To: <20180517144527.GA5048@redhat.com>
References: <20180516191634.GB2994@redhat.com>
 <128b6146-5368-12bb-ae42-236982ff3494@users.sourceforge.net>
 <20180517144527.GA5048@redhat.com>
Message-ID: <alpine.DEB.2.20.1805172241400.2273@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

In terms of the running time, I get a running time of 11 seconds with the
command line of 48 files and I get a running time of 22 seconds if I just
run spatch on the entire kernel.  That seems slower, but if I use the
command line of 48 files, I get changes in 27 files, while if I run it on
the entire kernel, I get changes in 75 files.  If I run it on the entire
kernel using 40 cores (-j 40), I get changes in 75 files in 1.7 seconds.

julia
