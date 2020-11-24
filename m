Return-Path: <SRS0=QPCx=E6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FF7C56202
	for <cocci@archiver.kernel.org>; Tue, 24 Nov 2020 20:19:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF8D206F7
	for <cocci@archiver.kernel.org>; Tue, 24 Nov 2020 20:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzaPlom0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF8D206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AOKIwj8012472;
	Tue, 24 Nov 2020 21:18:58 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 721795C34;
	Tue, 24 Nov 2020 21:18:58 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6D0E57B6
 for <cocci@systeme.lip6.fr>; Tue, 24 Nov 2020 21:18:56 +0100 (CET)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AOKIsG9026495
 for <cocci@systeme.lip6.fr>; Tue, 24 Nov 2020 21:18:54 +0100 (CET)
Received: by mail-ej1-x643.google.com with SMTP id i19so30329897ejx.9
 for <cocci@systeme.lip6.fr>; Tue, 24 Nov 2020 12:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vDim2mFLi6666bbac9S+dgADpI5iFzIoIjRGxDP6yZA=;
 b=BzaPlom0olyYPK/EyeOzTpY7JLKSWuGBhkDYOdNrVo7mPvj4YM7+a6Jz40XnDS/gDv
 uYFMq1X4VvOd3xL29S2jzPHbaxSB99YYvlaDVh61fBdGpjgygtwvPhFSPAxwX6TlJdQ8
 VTzjdH4oVbvB+x2v2NkFnu3Mmzu6+dCNNDX0XpRQvDeFJkSRjlyHYJapkbhQOkXEvdFG
 fvkZyUOj876H8gsWQy7X6MbWfjNGEDSOOCRySMGC8084YWIN9ABe39kt1FYymWs5uhFS
 XX4x2G5xsGVvfHGr8Qqk6F9PXMaMEoyB7OD8MAu3uQ8gi5VhtEwNEmWds46AvTYBxra5
 I83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vDim2mFLi6666bbac9S+dgADpI5iFzIoIjRGxDP6yZA=;
 b=jyH5jXXYtWQ1Em2PHB79rs9sMCqMdDL9DiX1ZjlDlEFlM2xX2EnbXy2KIFYZCm0CA6
 O/tz06SLNG9nL7ON1NE4DINM//HshO5GpHBqmBlQersfJJKA1iDhVyw0h894XqKZdc05
 bbH+sS5rHoeN3cRZ95OTACndaosvIYSZctoPKmfdfafL9e5dtleU7eANXJOIW1h8ZXIV
 XasKV6UNhLGDHzACdHnGZKrYCMSlUxTpgo1emgs6nSaTC29irhViqyo85pBbJWyHe4ey
 C+1UVPpa1veE1ngh8G+u9bqfydl4Sg8y+rcR1GZMmL+nw7JNtIr3OOQ2EdN6O5A/Ytzy
 OGkg==
X-Gm-Message-State: AOAM530vCnwoCR1sOxPGcgIdpCy6ynLhA6MNB4kcwk9CGldK3pkrjsP5
 esYZbG+N9az2uZsNkWt3y3G5bL73QOpBuG85Avo=
X-Google-Smtp-Source: ABdhPJyu01lEoCNoCmXXI9fsMOimdnJ30OVc31nmToUrpXmEKbWmOSaALV7LMnQRJ4EEqiJpXI5Ozxcymv98erlkkZw=
X-Received: by 2002:a17:906:b852:: with SMTP id
 ga18mr173531ejb.80.1606249134362; 
 Tue, 24 Nov 2020 12:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20201118082705.ympf6ulol6wua4cl@adolin>
 <alpine.DEB.2.22.394.2011232204550.2682@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2011232204550.2682@hadrien>
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
Date: Wed, 25 Nov 2020 01:48:42 +0530
Message-ID: <CACAkLupWCKPR7knKA0YX6n+k35z653DXdhViFPfCkY3UoLyBHw@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Nov 2020 21:18:59 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 24 Nov 2020 21:18:54 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH v2] scripts: coccicheck: Correct usage of make
	coccicheck
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
Content-Type: multipart/mixed; boundary="===============0951508968=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0951508968==
Content-Type: multipart/alternative; boundary="00000000000013148c05b4e0055c"

--00000000000013148c05b4e0055c
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 24, 2020 at 2:36 AM Julia Lawall <julia.lawall@inria.fr> wrote:

>
>
> On Wed, 18 Nov 2020, Sumera Priyadarsini wrote:
>
> > The command "make coccicheck C=1 CHECK=scripts/coccicheck" results in the
> > error:
> >         ./scripts/coccicheck: line 65: -1: shift count out of range
> >
> > This happens because every time the C variable is specified,
> > the shell arguments need to be "shifted" in order to take only
> > the last argument, which is the C file to test. These shell arguments
> > mostly comprise flags that have been set in the Makefile. However,
> > when coccicheck is specified in the make command as a rule, the
> > number of shell arguments is zero, thus passing the invalid value -1
> > to the shift command, resulting in an error.
> >
> > Modify coccicheck to print correct usage of make coccicheck so as to
> > avoid the error.
> >
> > Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> > ---
> > Changes in v2:
> > - Move test to only display error message
> > ---
> >  scripts/coccicheck | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/scripts/coccicheck b/scripts/coccicheck
> > index 209bb0427b43..f3b8bf505c5f 100755
> > --- a/scripts/coccicheck
> > +++ b/scripts/coccicheck
> > @@ -61,6 +61,18 @@ COCCIINCLUDE=${COCCIINCLUDE// -include/ --include}
> >  if [ "$C" = "1" -o "$C" = "2" ]; then
> >      ONLINE=1
> >
> > +    if [[ $# -le 0 ]]; then
> > +         echo ''
> > +         echo 'Specifying both the variable "C" and rule "coccicheck"
> in the make
> > +command results in a shift count error.'
> > +         echo ''
> > +         echo 'Try specifying "scripts/coccicheck" as a value for the
> CHECK variable instead.'
> > +         echo ''
> > +         echo 'Example:      make C=2 CHECK=scripts/coccicheck
> drivers/staging/wfx/hi_t.o'
>
> I think that this file doesn't exist any more.  Even though you can't
> guarantee that any particular file will be around forever, a file in
> staging is probably not a good choice, since they are usually on their way
> in or on the way out of the kernel.
>

Fair, I will send a v3 with a better example.

regards,
sumera


> julia
>
> > +         echo ''
> > +         exit 1
> > +    fi
> > +
> >      # Take only the last argument, which is the C file to test
> >      shift $(( $# - 1 ))
> >      OPTIONS="$COCCIINCLUDE $1"
> > --
> > 2.25.1
> >
> > _______________________________________________
> > Cocci mailing list
> > Cocci@systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci
> >
>

--00000000000013148c05b4e0055c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 24, 2020 at 2:36 AM Julia=
 Lawall &lt;<a href=3D"mailto:julia.lawall@inria.fr">julia.lawall@inria.fr<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
br>
<br>
On Wed, 18 Nov 2020, Sumera Priyadarsini wrote:<br>
<br>
&gt; The command &quot;make coccicheck C=3D1 CHECK=3Dscripts/coccicheck&quo=
t; results in the<br>
&gt; error:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./scripts/coccicheck: line 65: -1: sh=
ift count out of range<br>
&gt;<br>
&gt; This happens because every time the C variable is specified,<br>
&gt; the shell arguments need to be &quot;shifted&quot; in order to take on=
ly<br>
&gt; the last argument, which is the C file to test. These shell arguments<=
br>
&gt; mostly comprise flags that have been set in the Makefile. However,<br>
&gt; when coccicheck is specified in the make command as a rule, the<br>
&gt; number of shell arguments is zero, thus passing the invalid value -1<b=
r>
&gt; to the shift command, resulting in an error.<br>
&gt;<br>
&gt; Modify coccicheck to print correct usage of make coccicheck so as to<b=
r>
&gt; avoid the error.<br>
&gt;<br>
&gt; Signed-off-by: Sumera Priyadarsini &lt;<a href=3D"mailto:sylphrenadin@=
gmail.com" target=3D"_blank">sylphrenadin@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; Changes in v2:<br>
&gt; - Move test to only display error message<br>
&gt; ---<br>
&gt;=C2=A0 scripts/coccicheck | 12 ++++++++++++<br>
&gt;=C2=A0 1 file changed, 12 insertions(+)<br>
&gt;<br>
&gt; diff --git a/scripts/coccicheck b/scripts/coccicheck<br>
&gt; index 209bb0427b43..f3b8bf505c5f 100755<br>
&gt; --- a/scripts/coccicheck<br>
&gt; +++ b/scripts/coccicheck<br>
&gt; @@ -61,6 +61,18 @@ COCCIINCLUDE=3D${COCCIINCLUDE// -include/ --include=
}<br>
&gt;=C2=A0 if [ &quot;$C&quot; =3D &quot;1&quot; -o &quot;$C&quot; =3D &quo=
t;2&quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ONLINE=3D1<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 if [[ $# -le 0 ]]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &#39;&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &#39;Specifying both the varia=
ble &quot;C&quot; and rule &quot;coccicheck&quot; in the make<br>
&gt; +command results in a shift count error.&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &#39;&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &#39;Try specifying &quot;scri=
pts/coccicheck&quot; as a value for the CHECK variable instead.&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &#39;&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &#39;Example:=C2=A0 =C2=A0 =C2=
=A0 make C=3D2 CHECK=3Dscripts/coccicheck drivers/staging/wfx/hi_t.o&#39;<b=
r>
<br>
I think that this file doesn&#39;t exist any more.=C2=A0 Even though you ca=
n&#39;t<br>
guarantee that any particular file will be around forever, a file in<br>
staging is probably not a good choice, since they are usually on their way<=
br>
in or on the way out of the kernel.<br></blockquote><div><br></div><div>Fai=
r, I will send a v3 with a better example.</div><div><br></div><div>regards=
,<br></div><div>sumera</div><div><br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
julia<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &#39;&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
&gt; +=C2=A0 =C2=A0 fi<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # Take only the last argument, which is the C file=
 to test<br>
&gt;=C2=A0 =C2=A0 =C2=A0 shift $(( $# - 1 ))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 OPTIONS=3D&quot;$COCCIINCLUDE $1&quot;<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Cocci mailing list<br>
&gt; <a href=3D"mailto:Cocci@systeme.lip6.fr" target=3D"_blank">Cocci@syste=
me.lip6.fr</a><br>
&gt; <a href=3D"https://systeme.lip6.fr/mailman/listinfo/cocci" rel=3D"nore=
ferrer" target=3D"_blank">https://systeme.lip6.fr/mailman/listinfo/cocci</a=
><br>
&gt;<br>
</blockquote></div></div>

--00000000000013148c05b4e0055c--

--===============0951508968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0951508968==--
