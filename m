From: mstefani@redhat.com (Michael Stefaniuc)
Date: Tue, 11 Oct 2016 13:52:19 +0200
Subject: [Cocci] Regression in Python Support
Message-ID: <57FCD273.9070607@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello Thierry,

I've run into a regression in coccinelle 1.0.6 for the python support:
I am getting this error on Fedora 24:
Python error: /usr/lib64/python2.7/lib-dynload/_collectionsmodule.so:
undefined symbol: PyObject_SetItem

On Fedora 23 I get a similar error but for a different symbol.

The error is strange as I expected it to use python3 as I use:
./configure --with-python=/usr/bin/python3

That works just fine in coccinelle-1.0.5. I've bisected it to:
# first bad commit: [62f2df8c7d35967a1eca4dcd487d59a9918dd5aa] Fixed:
Bundles compilation and pyml update
commit 62f2df8c7d35967a1eca4dcd487d59a9918dd5aa
Author: Thierry Martinez <martinez@nsup.org>
Date:   Sun Jun 26 20:22:59 2016 +0200

    Fixed: Bundles compilation and pyml update

    - %.cmx: %.cmo dependency (with .ml files that do not have .mli,
      compiling the .ml into .cmo or into .cmx both write to the same .cmi
      file, so that cannot be done concurrently)
    - untarred pyml distribution to ease updates
    - Python exception catched in pycocci interface


thanks
bye
	michael
