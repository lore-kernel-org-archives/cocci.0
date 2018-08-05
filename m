From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 5 Aug 2018 17:04:19 +0200 (CEST)
Subject: [Cocci] bash completion doesn't work
In-Reply-To: <20180805120416.GA22450@himanshu-Vostro-3559>
References: <20180805120416.GA22450@himanshu-Vostro-3559>
Message-ID: <alpine.DEB.2.20.1808051703550.2620@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 5 Aug 2018, Himanshu Jha wrote:

> Hi,
>
>
> Installed fresh Coccinelle from Github and following
> install.txt for bash completion using 'make install-bash'.
> The bash completion didn't work because of placement of file:

Thanks for the reports.  I will ask Thierry to look at it when he is
available.

julia

>
> himanshu at himanshu-Vostro-3559:~/coccinelle$ ls -l /usr/local/etc/bash_completion.d/
> total 4
> -rw-r--r-- 1 root root 3213 Aug  5 16:40 spatch
> himanshu at himanshu-Vostro-3559:~/coccinelle$ ls -l /etc/bash_completion.d/
> total 24
> -rw-r--r-- 1 root root  6636 Nov 20  2017 apport_completion
> -rw-r--r-- 1 root root   439 May 31 23:20 git-prompt
> -rw-r--r-- 1 root root 11144 Jul 17 23:43 grub
>
> So, I copied spatch from /usr/local/etc/bash_completion.d/ to
> /etc/bash_completion.d/
>
> himanshu at himanshu-Vostro-3559:~/coccinelle$ ls -l /etc/bash_completion.d/
> total 28
> -rw-r--r-- 1 root root  6636 Nov 20  2017 apport_completion
> -rw-r--r-- 1 root root   439 May 31 23:20 git-prompt
> -rw-r--r-- 1 root root 11144 Jul 17 23:43 grub
> -rw-r--r-- 1 root root  3213 Aug  5 17:10 spatch
>
> And now it does work. Don't if it is a ugly hack but it works!
>
> So, install.txt says:
> " It will install the shell script 'scripts/spatch.bash_completion'
>   in /etc/bash_completion.d/spatch"
>
> But it isn't true in my case, if it were then I wouldn't have to
> cp it manually.
>
> Maybe change that line to
> " .. in /usr/local/etc/bash_completion.d/spatch "
>
> Or if script is replaced to install at /etc/bash_completion.d/
> then local users(non-root) wouldn't be able to use it !?
>
> So, better to edit text in install.txt and then it is clearly mentioned
> in the install.txt:
>
> " You can manually copy that file elsewhere if you have a different
>   bash_completion directory."
>
>
> Another previous issue that hit up again:
> https://www.mail-archive.com/cocci at systeme.lip6.fr/msg04973.html
>
> -----------------------------------------------------------
> cp: cannot stat '/usr/lib/ocaml/parmap/parmap.cmx': No such file or directory
> Makefile:644: recipe for target 'ocaml/parmap.cmi' failed
> make: [ocaml/parmap.cmi] Error 1 (ignored)
> rm parsing_cocci/lexer_cli.ml parsing_cocci/parser_cocci_menhir.ml.d tools/spgen/source/spgen_lexer.ml parsing_cocci/parser_cocci_menhir.mli.d parsing_cocci/lexer_script.ml parsing_cocci/lexer_cocci.ml parsing_c/lexer_c.ml
> -----------------------------------------------------------
>
> Though it is a "warning" but it is really misleading. I knew already
> about this issue therefore I proceeded with any caution. But for
> other developers doing a fresh install, it would certainly save their
> time and effort.
>
> Distributor ID:	Ubuntu
> Description:	Ubuntu 18.04.1 LTS
> Release:	18.04
> Codename:	bionic
>
>
> --
> Himanshu Jha
> Undergraduate Student
> Department of Electronics & Communication
> Guru Tegh Bahadur Institute of Technology
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
