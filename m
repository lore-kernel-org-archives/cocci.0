From: amiddelk@gmail.com (Arie Middelkoop)
Date: Tue, 5 Mar 2013 09:36:54 +0100
Subject: [Cocci] 1.0.0-rc16: Further fine-tuning for the build system?
In-Reply-To: <5134C654.3050706@users.sourceforge.net>
References: <513268ED.5070703@users.sourceforge.net>
 <alpine.DEB.2.02.1303022218010.2033@localhost6.localdomain6>
 <51348708.1000005@users.sourceforge.net>
 <alpine.DEB.2.02.1303041334270.1984@hadrien>
 <5134C06D.4070906@users.sourceforge.net>
 <alpine.DEB.2.02.1303041645030.1984@hadrien>
 <5134C654.3050706@users.sourceforge.net>
Message-ID: <CANrVCd3SaNhoMzaLFYsrkB6gX7vz9Nxb5L85be48pFNZ03Q6CA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

There is something else than you can try, although I cannot guarantee
that it (still) works. If it does not work, then you should forget
about it.

In a fresh checkout(!), configure with an extra configuration
parameter: --enable-ocamlbuild
This will configure the project to use ocamlbuild to resolve
dependencies and invoke the ocaml tools. The makefiles are still used
to invoke ocamlbuild with the appropriate parameters.

Ocamlbuild puts build outputs in a separate directory, thus it is
doing an out-of-source build.
You can probably make it also output ocamldoc files of all the source
files, although that is speculation. Understanding of ocamlbuild would
be required in that case.

Arie

2013/3/4 SF Markus Elfring <elfring@users.sourceforge.net>:
>>> https://github.com/coccinelle/coccinelle/issues/9
>>
>> Maybe you have python but not the developer libraries?
>
> The package "python-devel 2.7.3-3.6.1" is installed at the moment.
>
> I do not get the mentioned error message if I repeat the command from within the
> source directory.
>
> elfring at Sonne:~/Projekte/Coccinelle/lokal> make distclean && ./configure
> --enable-opt --enable-ocaml --enable-python --enable-release
>
>
> Regards,
> Markus
