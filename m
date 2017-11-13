From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 13 Nov 2017 17:45:00 +0100 (CET)
Subject: [Cocci] [PATCH v2] coccinelle: fix parallel build with
 CHECK=scripts/coccicheck
In-Reply-To: <CAK7LNASpxfq6Vg42rogQg1bixNL15O=8152=KJEnKQA=Ez6Dxw@mail.gmail.com>
References: <1510210850-28866-1-git-send-email-yamada.masahiro@socionext.com>
 <alpine.DEB.2.20.1711131628370.20333@hadrien>
 <CAK7LNASpxfq6Vg42rogQg1bixNL15O=8152=KJEnKQA=Ez6Dxw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1711131744290.20292@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 14 Nov 2017, Masahiro Yamada wrote:

> Hi Julia,
>
>
> 2017-11-14 0:30 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
> >
> >
> > On Thu, 9 Nov 2017, Masahiro Yamada wrote:
> >
> >> The command "make -j8 C=1 CHECK=scripts/coccicheck" produces lots of
> >> "coccicheck failed" error messages.
> >>
> >> I do not know the coccinelle internals, but I guess --jobs does not
> >> work well if spatch is invoked from Make running in parallel.
> >> Disable --jobs in this case.
> >
> > Why is this change under:
> >
> > if [ "$C" = "1" -o "$C" = "2" ];
> >
> > The coccicheck failed messages come also if one runs Coccinelle on the
> > entire kernel.
>
> As far as I tested, "coccicheck failed" error only happens
> when ONLINE=1.
>
>
> make -j8 C=1 CHECK=scripts/coccicheck  COCCI=scripts/coccinelle/misc/bugon.cocci
>
> emits lots of errors.
>
>
> make -j8 coccicheck  COCCI=scripts/coccinelle/misc/bugon.cocci
>
> is fine.
>
>
> Have you tested it?
> Do you mean you got a different result from mine?

I agree with your results, with respect to the number of errors.

julia

>
>
>
> > julia
> >
> >
> >>
> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >> ---
> >>
> >> Changes in v2:
> >>   - Grep '-j' instead of '--jobserver-auth'.
> >>     '--jobserver-*' is not a stable option flag.
> >>     Make 4.2 change '--jobserver-fds' into '--jobserver-auth'
> >>   - Add -q option to grep
> >>
> >>  scripts/coccicheck | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/scripts/coccicheck b/scripts/coccicheck
> >> index 040a8b1..8bab11e 100755
> >> --- a/scripts/coccicheck
> >> +++ b/scripts/coccicheck
> >> @@ -70,6 +70,9 @@ if [ "$C" = "1" -o "$C" = "2" ]; then
> >>      # Take only the last argument, which is the C file to test
> >>      shift $(( $# - 1 ))
> >>      OPTIONS="$COCCIINCLUDE $1"
> >> +
> >> +    # --jobs does not work if Make is running in parallel
> >> +    echo $MAKEFLAGS | grep -q -E '(^| )-j' && USE_JOBS="no"
> >>  else
> >>      ONLINE=0
> >>      if [ "$KBUILD_EXTMOD" = "" ] ; then
> >> --
> >> 2.7.4
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Best Regards
> Masahiro Yamada
>
