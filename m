From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 18 May 2016 11:08:18 +0200 (CEST)
Subject: [Cocci] Build configuration challenges around "Menhir"
In-Reply-To: <1d2aa73f-8374-6060-b415-4e936ea651b9@users.sourceforge.net>
References: <CAB=NE6X4mqH+Vj41bba4e7y7vYKqhpsC5dqHUZLrmDKtA1XVwA@mail.gmail.com>
 <alpine.DEB.2.02.1605172250560.2064@localhost6.localdomain6>
 <CAB=NE6V=aqW8VC4OML6vc+hJHkbcfH3dBzo==3uVRAuZK8Mv6A@mail.gmail.com>
 <alpine.DEB.2.02.1605180711280.2031@localhost6.localdomain6>
 <a3fa0af3-b679-124d-09c3-60385e6ad34f@users.sourceforge.net>
 <alpine.DEB.2.10.1605181043320.2887@hadrien>
 <1d2aa73f-8374-6060-b415-4e936ea651b9@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1605181103490.2887@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 18 May 2016, SF Markus Elfring wrote:

> >> Are there a few build challenges left over for proper configuration checks
> >> around the bundling (or other source) of this software library?
> >
> > Please find them and report on them rather than making vague questions.
>
> I am waiting for improvements of the affected build scripts for years.
> Who will dare to tackle open issues there a bit more?

In a general sense, perhaps no one.  If you have a specific issue in mind
that is causing problems in practice (not just offending your sense of how
things should be done), then you can report it with detailed information
about your build environment, and we will look at it.

Alternatively, you are welcome to propose the code for what you consider
to be the perfect build system.  The only requirement is to keep the
dependencies on external software to an absolute minimum.  There are also
various developer-friendly make targets such as --testall that should be
preserved.  And the ability to run make in the subdirectories without
remaking the whole project.

julia
