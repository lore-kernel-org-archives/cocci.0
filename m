From: Thierry.Martinez@inria.fr (Thierry Martinez)
Date: Wed, 25 Jan 2017 15:01:48 +0100
Subject: [Cocci] Selecting Python 3 at configure time
In-Reply-To: <20170125101421.GA9653@redhat.com>
References: <20170125101421.GA9653@redhat.com>
Message-ID: <ow4o9yvnsqb.fsf@inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi, Richard.

Richard:
> I looked at configure.ac and the Makefiles, but I cannot work out how
> you tell ./configure to use /usr/bin/python3 instead of
> /usr/bin/python, if indeed that is possible at all - it's not clear
> that it is.

It is not possible in 1.0.6. It is possible upstream
(https://github.com/coccinelle/, commit c8025ac) via the option
--with-python of ./configure or directly via the option --python of
spatch.

Since 1.0.6, the version of python available at building time is
irrelevant. The "spatch" executable only looks at the version of python
available at runtime (and, unfortunately, in 1.0.6, it is the version
returned by the "python" command, hard wired, that is taken into
account).

It should not prevent spatch to find the libraries, though, since
spatch.sh adds ${COCCINELLE_HOME}/python (where the libraries are
supposed to be installed, independently from python version) to
PYTHONPATH before executing "spatch".

Best regards,
--
Thierry.

Richard W. M. Jones (2017/01/25, 10:14 UTC)?:
> This bug was filed against the Fedora package:
> https://bugzilla.redhat.com/show_bug.cgi?id=1416323
>
> I looked at configure.ac and the Makefiles, but I cannot work out how
> you tell ./configure to use /usr/bin/python3 instead of
> /usr/bin/python, if indeed that is possible at all - it's not clear
> that it is.
>
> Rich.
