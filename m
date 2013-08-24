From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 24 Aug 2013 08:11:39 +0200 (CEST)
Subject: [Cocci] coccinelle-1.0.0-rc18
In-Reply-To: <54AA37D70A06414FB8288E4A5662904A01024F2DD4@NB-EX-MBX01.diasemi.com>
References: <54AA37D70A06414FB8288E4A5662904A01024F2DD4@NB-EX-MBX01.diasemi.com>
Message-ID: <alpine.DEB.2.02.1308240806340.1996@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I am having difficulties enabling python scripting with
> coccinelle-1.0.0-rc18 as follows

What OS/distribution are you using?  Perhaps the problem could be that you 
have python 2.6?  I have 2.7.

Maybe you should try something like

pkg-config --exists --print-errors python-2.6

julia
