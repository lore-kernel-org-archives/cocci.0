Return-Path: <SRS0=BNCH=BX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5907C433E1
	for <cocci@archiver.kernel.org>; Thu, 13 Aug 2020 10:57:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246B120771
	for <cocci@archiver.kernel.org>; Thu, 13 Aug 2020 10:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noJvP8wa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246B120771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07DAujQQ016433;
	Thu, 13 Aug 2020 12:56:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0C0077780;
	Thu, 13 Aug 2020 12:56:45 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 763CF4084
 for <cocci@systeme.lip6.fr>; Thu, 13 Aug 2020 12:56:43 +0200 (CEST)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07DAufrc028387
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 13 Aug 2020 12:56:41 +0200 (CEST)
Received: by mail-ej1-x642.google.com with SMTP id o18so5674235eje.7
 for <cocci@systeme.lip6.fr>; Thu, 13 Aug 2020 03:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xrC10J+a65IS0FsbJz+FgMrvQEPp8dYXarkPxt9tw7Y=;
 b=noJvP8waXIZu8w38dwAIX9DBvRKnEoVz6inIw2Ryh1mXg00kHaOPKma8yCIbwYxaSX
 Bo83yejLweI1CAWimCd2lyTdd8ncgm35+B6o8TyD/VXj5F/H0zMOiSjk84VNJkSnPNUg
 2Q+a7hth3U6w6G1kkowR+9OpfsKlMGP36tnqdkCZwg2rPocsy5YM1lrYDpV4PLvAfQRX
 mqsxLdQnTtOn9BY9OnR3QpeYCwSRpUG/nFcCyN8rWLc3Dj1X+PgQG8jc4mYSh1qD2kGh
 6hknXHY1n2w5bS4SUkSSTqXu6XXP298kSPsdA2k5i9Ou/pJSezrpd+ha2W6bqRDvD3he
 Nrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xrC10J+a65IS0FsbJz+FgMrvQEPp8dYXarkPxt9tw7Y=;
 b=HHkU7QzcvjZsRR+gEMIgILjtgoec8M3wXHu81FlfiW4VJsBI8FABCIKx24rzfc2EZP
 Ui3K3jgfR/4I2EkUzx0bkn9QCsNGIBXTSWnwCre1Id/h7HtbzACtu7CACkHXdjdYmPa7
 GanZQk1cjE59gsntLNlHJLitUmtddg2Lq9aw07cSeEEZlKAnPIXKUQXEYPaTpG50LTKw
 J8aKKA3PHOrtN7iT5nDzXOc8p44FThipebklcsDcvMXhuKJUpHy1s9CAh6vbWhpLCrms
 GPC72LuYBItjRwPeTvW5dI6tbv8eVf8kYo7i+pbnVy390Bxrfrii9rR/9CPvf9NBe/Fm
 nMbA==
X-Gm-Message-State: AOAM530jqZO2J2xSbjnpcfSECUlm/NRoOleP27Ai1DYSScr18pLIKha0
 0wUCkbGSuJHrqUUcZ1wcYpKv6W+hYzL8VNxmeqg=
X-Google-Smtp-Source: ABdhPJzbfEnewR2CuF3B4mAHzqCcrVcPU6g3Dbq3N6u9LVHINj93qbixY0E+KdvXtr9WnlL/zz+2gd2wC8KX4RLObso=
X-Received: by 2002:a17:906:7155:: with SMTP id
 z21mr4452441ejj.282.1597316200988; 
 Thu, 13 Aug 2020 03:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200812182722.4553-1-sylphrenadin@gmail.com>
 <alpine.DEB.2.22.394.2008122211330.2468@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2008122211330.2468@hadrien>
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
Date: Thu, 13 Aug 2020 16:26:28 +0530
Message-ID: <CACAkLuqo+CJeyvVZ0oaN=6SqQNxXinfv8t6FNPyORO=GCCvstA@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 13 Aug 2020 12:56:45 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 13 Aug 2020 12:56:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, Gilles.Muller@lip6.fr, gregkh@linuxfoundation.org,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts: coccicheck: Change default value for
	parallelism
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1946912574=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============1946912574==
Content-Type: multipart/alternative; boundary="000000000000c103dd05acc02876"

--000000000000c103dd05acc02876
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Aug, 2020, 1:45 AM Julia Lawall, <julia.lawall@inria.fr> wrote:

>
>
> On Wed, 12 Aug 2020, Sumera Priyadarsini wrote:
>
> > By default, coccicheck utilizes all available threads to implement
> > parallelisation. However, when hyperthreading is enabled, this leads
> > to all threads per core being occupied resulting in longer wall-clock
> > times and higher power consumption.
>
> I have the feeling that the above sentence is not quite optimal.
> Actually, using all of the available hardware threads would not be a bad
> thing, if it was giving a benefit.  The point is that it doesn't.  It
> makes the performance worse instead.
>

How does this sound?

However, when all available threads are used, a decrease in performance was
noted. The elapsed time was minimum when at most one thread per core was
used.




> > Hence, to improve performance,
> > modify coccicheck to use only one thread per core atmost.
>
> "atmost" is not a word.  It would be clearer to say "to use at most one
> thread per core".
>
> > In the cases where the total number of threads is more than 8 and
> > hyperthreading is enabled, it was observed that optimum performance
> > is achieved around one-fourth of the total number of cores.
> > Modify the script further to accommodate this use case.
>
> It would be nice to give some performance numbers and some information
> about the machine used.
>

Alright, will add this.


> thanks,
> julia
>
> >
> > Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> > ---
> >  scripts/coccicheck | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/scripts/coccicheck b/scripts/coccicheck
> > index e04d328210ac..dd228dcc915e 100755
> > --- a/scripts/coccicheck
> > +++ b/scripts/coccicheck
> > @@ -75,8 +75,17 @@ else
> >          OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
> >      fi
> >
> > +    # Use only one thread per core by default if hyperthreading is
> enabled
> > +    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd
> [:digit:])
> >      if [ -z "$J" ]; then
> >          NPROC=$(getconf _NPROCESSORS_ONLN)
> > +     if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
> > +             if [ $NPROC -gt 8 ] ; then
> > +                     NPROC=$((NPROC/4))
> > +             else
> > +                     NPROC=$((NPROC/2))
> > +             fi
> > +     fi
> >      else
> >          NPROC="$J"
> >      fi
> > --
> > 2.17.1
> >
> > _______________________________________________
> > Cocci mailing list
> > Cocci@systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci
> >
>

--000000000000c103dd05acc02876
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, 13 Aug, 2020, 1:45 AM Julia Lawall, &lt;<a hre=
f=3D"mailto:julia.lawall@inria.fr">julia.lawall@inria.fr</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><br>
<br>
On Wed, 12 Aug 2020, Sumera Priyadarsini wrote:<br>
<br>
&gt; By default, coccicheck utilizes all available threads to implement<br>
&gt; parallelisation. However, when hyperthreading is enabled, this leads<b=
r>
&gt; to all threads per core being occupied resulting in longer wall-clock<=
br>
&gt; times and higher power consumption.<br>
<br>
I have the feeling that the above sentence is not quite optimal.<br>
Actually, using all of the available hardware threads would not be a bad<br=
>
thing, if it was giving a benefit.=C2=A0 The point is that it doesn&#39;t.=
=C2=A0 It<br>
makes the performance worse instead.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">How does this sound?=C2=A0</div><div =
dir=3D"auto">=C2=A0</div><div dir=3D"auto">However, when all available thre=
ads are used, a decrease in performance was noted. The elapsed time was min=
imum when at most one thread per core was used.=C2=A0</div><div dir=3D"auto=
"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; Hence, to improve performance,<br>
&gt; modify coccicheck to use only one thread per core atmost.<br>
<br>
&quot;atmost&quot; is not a word.=C2=A0 It would be clearer to say &quot;to=
 use at most one<br>
thread per core&quot;.<br>
<br>
&gt; In the cases where the total number of threads is more than 8 and<br>
&gt; hyperthreading is enabled, it was observed that optimum performance<br=
>
&gt; is achieved around one-fourth of the total number of cores.<br>
&gt; Modify the script further to accommodate this use case.<br>
<br>
It would be nice to give some performance numbers and some information<br>
about the machine used.<br></blockquote></div></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Alright, will add this.=C2=A0</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
thanks,<br>
julia<br>
<br>
&gt;<br>
&gt; Signed-off-by: Sumera Priyadarsini &lt;<a href=3D"mailto:sylphrenadin@=
gmail.com" target=3D"_blank" rel=3D"noreferrer">sylphrenadin@gmail.com</a>&=
gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/coccicheck | 9 +++++++++<br>
&gt;=C2=A0 1 file changed, 9 insertions(+)<br>
&gt;<br>
&gt; diff --git a/scripts/coccicheck b/scripts/coccicheck<br>
&gt; index e04d328210ac..dd228dcc915e 100755<br>
&gt; --- a/scripts/coccicheck<br>
&gt; +++ b/scripts/coccicheck<br>
&gt; @@ -75,8 +75,17 @@ else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPTIONS=3D&quot;--dir $KBUILD_EXTMOD=
 $COCCIINCLUDE&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 # Use only one thread per core by default if hyperthrea=
ding is enabled<br>
&gt; +=C2=A0 =C2=A0 THREADS_PER_CORE=3D$(lscpu | grep &quot;Thread(s) per c=
ore: &quot; | tr -cd [:digit:])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if [ -z &quot;$J&quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NPROC=3D$(getconf _NPROCESSORS_ONLN)=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; =
then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $NPROC -gt 8 ] ;=
 then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0NPROC=3D$((NPROC/4))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0NPROC=3D$((NPROC/2))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NPROC=3D&quot;$J&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Cocci mailing list<br>
&gt; <a href=3D"mailto:Cocci@systeme.lip6.fr" target=3D"_blank" rel=3D"nore=
ferrer">Cocci@systeme.lip6.fr</a><br>
&gt; <a href=3D"https://systeme.lip6.fr/mailman/listinfo/cocci" rel=3D"nore=
ferrer noreferrer" target=3D"_blank">https://systeme.lip6.fr/mailman/listin=
fo/cocci</a><br>
&gt;<br>
</blockquote></div></div></div>

--000000000000c103dd05acc02876--

--===============1946912574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1946912574==--
