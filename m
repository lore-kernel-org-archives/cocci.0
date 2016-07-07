From: Thierry.Martinez@inria.fr (Thierry Martinez)
Date: Fri, 08 Jul 2016 00:53:56 +0300
Subject: [Cocci] Checking build dependencies for "pyml"
In-Reply-To: <64de7df6-acd6-7ddf-efc7-b4055203211c@users.sourceforge.net>
References: <64de7df6-acd6-7ddf-efc7-b4055203211c@users.sourceforge.net>
Message-ID: <ow4h9c1qfm3.fsf@mbp-thierry.rsr.lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello, Markus.

Markus:
> make[2]: *** @MAKE_pyml@: No such file or directory.  Stop.

Thank you for the report. Does this error continue to happen if you
delete the subdirectory autom4te.cache/ and then execute ./autogen,
./configure, etc.?

-- 
Thierry.

SF Markus Elfring (2016/07/07, 23:40 MSK)?:
> Hello,
>
> I have tried to generate the current software also on my openSUSE Tumbleweed system.
>
>
> elfring at Sonne:~/Projekte/Coccinelle/20160205> ./configure --enable-release --enable-ocaml && LANG=C make
> ?
> make[2]: *** @MAKE_pyml@: No such file or directory.  Stop.
> ?
>
>
> Unfortunately, I stumble on an error message.
>
> How is the development status after the commit "Fixed: Bundles compilation
> and pyml update" on 2016-06-26?
> https://github.com/coccinelle/coccinelle/commit/62f2df8c7d35967a1eca4dcd487d59a9918dd5aa
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
