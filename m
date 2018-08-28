From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 27 Aug 2018 21:00:37 -0700 (PDT)
Subject: [Cocci] about cocci installing
In-Reply-To: <265E382B26F78742B972BE038FD292C61DD2DE28@FZEX3.ruijie.com.cn>
References: <265E382B26F78742B972BE038FD292C61DD2DE28@FZEX3.ruijie.com.cn>
Message-ID: <alpine.DEB.2.21.1808272059570.2601@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 28 Aug 2018, linjia at ruijie.com.cn wrote:

>
> Dear sir:
>
> ? I try to install cocci by opam in centos, but failed as following
>
> ?
>
> [root at localhost]# opam install coccinelle
>
> [WARNING] Running as root is not recommended
>
> Your request can't be satisfied:
>
> ? - No package matches coccinelle.
>
> ?
>
> ?
>
> And I didn?t find packages for centos on homepage of cocci
>
> ?
>
> Packages exist for several distributions:
>
>  *  Slackware, thanks to Dimitris Zlatanidis
>  *  Debian, thanks to Eugeniy Meshcheryakov
>  *  Ubuntu See also the Ubuntu package on PPA, which contains a more recent version of Coccincelle.
>  *  Fedora, thanks to Richard W.M. Jones and Michal Schmidt
>  *  OpenSUSE
>  *  Arch Linux, thanks to Sylvain HENRY
>  *  NetBSD, thanks to Thomas Klausner
>  *  FreeBSD
>  *  OpenBSD
>  *  Gentoo
>
> So is there ready packages for download and installing ? thanks a lot!

Not that I know of.  Could you just get the github version and compile it
yourself?  That way you will have the most up to date version anyway.

julia
