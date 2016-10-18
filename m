From: Thierry.Martinez@inria.fr (Thierry Martinez)
Date: Tue, 18 Oct 2016 18:54:45 +0200
Subject: [Cocci] Regression in Python Support
In-Reply-To: <57FCD273.9070607@redhat.com>
References: <57FCD273.9070607@redhat.com>
Message-ID: <ow4d1ixwqay.fsf@inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello, Michael.

This should now be fixed in trunk. Thank you for the report.

The support of --with-python had been dropped since the Python version
was determined during run-time since 1.0.5 (even if it had not been
properly documented, sorry for that). The option --with-python is now
restored in trunk to specify the name of the default Python
interpreter. The interpreter can also be changed by passing the option
--python in the command line of spatch.

Note that it is still possible that Fedora 23 and 24 are shipped with
Python versions that have not been tested yet. If such a similar error
is still raised with trunk, would you give me the output of
"python3 --version"?

Thank you again for the report.
-- 
Thierry.

Michael Stefaniuc (2016/10/11, 13:52 CEST)?:
> Hello Thierry,
>
> I've run into a regression in coccinelle 1.0.6 for the python support:
> I am getting this error on Fedora 24:
> Python error: /usr/lib64/python2.7/lib-dynload/_collectionsmodule.so:
> undefined symbol: PyObject_SetItem
>
> On Fedora 23 I get a similar error but for a different symbol.
>
> The error is strange as I expected it to use python3 as I use:
> ./configure --with-python=/usr/bin/python3
>
> That works just fine in coccinelle-1.0.5. I've bisected it to:
> # first bad commit: [62f2df8c7d35967a1eca4dcd487d59a9918dd5aa] Fixed:
> Bundles compilation and pyml update
> commit 62f2df8c7d35967a1eca4dcd487d59a9918dd5aa
> Author: Thierry Martinez <martinez@nsup.org>
> Date:   Sun Jun 26 20:22:59 2016 +0200
>
>     Fixed: Bundles compilation and pyml update
>
>     - %.cmx: %.cmo dependency (with .ml files that do not have .mli,
>       compiling the .ml into .cmo or into .cmx both write to the same .cmi
>       file, so that cannot be done concurrently)
>     - untarred pyml distribution to ease updates
>     - Python exception catched in pycocci interface
>
>
> thanks
> bye
> 	michael
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
