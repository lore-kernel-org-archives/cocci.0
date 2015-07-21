From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Mon, 20 Jul 2015 18:11:24 -0700
Subject: [Cocci] [PATCH v3 5/5] pycocci: add man page and promote
 pycocci to install target
In-Reply-To: <1437431544-32662-6-git-send-email-mcgrof@do-not-panic.com>
References: <1437431544-32662-1-git-send-email-mcgrof@do-not-panic.com>
 <1437431544-32662-6-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <CAB=NE6VDgbDz9uF4OJeBc_y+4qycRHo1sqTcpcFGO7dm9HU85Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Jul 20, 2015 at 3:32 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> diff --git a/Makefile b/Makefile
> index 27904f150204..63130b00af0f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -448,6 +448,7 @@ install-man:
>         $(MKDIR_P) $(DESTDIR)$(MANDIR)/man1
>         $(MKDIR_P) $(DESTDIR)$(MANDIR)/man3
>         $(INSTALL_DATA) docs/spatch.1 $(DESTDIR)$(MANDIR)/man1/
> +       $(INSTALL_DATA) docs/pycocci.1 $(DESTDIR)$(MANDIR)/man1/
>         $(INSTALL_DATA) docs/Coccilib.3cocci $(DESTDIR)$(MANDIR)/man3/
>
>  install-bash:
> @@ -487,6 +488,8 @@ install-stubs:
>  install: install-man install-common install-stubs $(PYTHON_INSTALL_TARGET)
>         rm -f $(DESTDIR)$(LIBDIR)/spatch
>         rm -f $(DESTDIR)$(LIBDIR)/spatch.opt
> +       rm -f $(DESTDIR)$(LIBDIR)/pycocci
> +       $(INSTALL_PROGRAM) tools/pycoci $(DESTDIR)$(LIBDIR)
>         @if test -x spatch -o -x spatch.opt; then \
>                 $(MAKE) install-def;fi
>         @if test -x spatch ; then \

Whoops sorry this should be using $BINDIR instead. There was already a
target for pycocci also on the install-tools target, but distros are
not using that install target so we just would move that to the
default install target to get distros to start carrying this.

 Luis
