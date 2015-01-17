From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 17 Jan 2015 23:09:37 +0100 (CET)
Subject: [Cocci] Possible to install on OSX?
In-Reply-To: <0F92B6B9-47F3-4A44-8D5A-ED04BC698EF0@gmail.com>
References: <0F92B6B9-47F3-4A44-8D5A-ED04BC698EF0@gmail.com>
Message-ID: <alpine.DEB.2.10.1501172308080.2777@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 17 Jan 2015, Eliseo Mart?nez wrote:

> Hi,
>
> Up to now, I?ve been using coccinelle in an Ubuntu virtual machine, running in my OSX Yosemite machine.
> Now I?d like to try installing it on OSX itself.
> As I don?t see anything about this on the website, I wanted to ask first.
> Has anybody managed to successfully install coccinelle on OSX?

Yes, I think it should be OK.  The only detail may be with PCRE (ocaml
library for regular expressions).  Some people reported that configure
correctly detected that they did not have pcre installed, but when it came
tie to link Coccinelle, pcre was expected.  So they had to install pcre.

julia
