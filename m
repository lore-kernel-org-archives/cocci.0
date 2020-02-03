Return-Path: <SRS0=ES+2=3X=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A2FC35247
	for <cocci@archiver.kernel.org>; Mon,  3 Feb 2020 21:10:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9620D2084E
	for <cocci@archiver.kernel.org>; Mon,  3 Feb 2020 21:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnoVXRBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9620D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 013L9mkd027140;
	Mon, 3 Feb 2020 22:09:48 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CE49277E8;
	Mon,  3 Feb 2020 22:09:48 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F3B6B772B
 for <cocci@systeme.lip6.fr>; Mon,  3 Feb 2020 22:01:12 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:32d])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 013L1BYe005524
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 3 Feb 2020 22:01:12 +0100 (CET)
Received: by mail-ot1-x32d.google.com with SMTP id p8so15001289oth.10
 for <cocci@systeme.lip6.fr>; Mon, 03 Feb 2020 13:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8MVaez1EiXOpV6/LNHod1jdxMKGjlMvzzW2sLZ5v7m0=;
 b=XnoVXRBBOuH8rbxpO3ueEI9JbuBKeuRYCrD98oj8p5Fmrzg1KjngK6sgrUuwuDbtbG
 dog9N3E9xSjzBUFFuLDAp+/a5McjN5IKvD2dOn6DLuuRMD/j5P5e63v3eaU6U/5Uee2r
 MmudPkdWgoac4+25wJMXFhHBg19ytqJUWnFwgBCV70cLxXdhbLu3qgwRsJmxzp/XUQ5x
 P1T/7u2FgX7DnMcAH78J2Bm9XakeZtE7L4+lZ+eAFol2NydonrDHoB9I7xK54341lxX2
 AUExTmjUZz68A7oQmw93ka+1LA59XIiRNJKlkswkqbz8r7jdcFglAQ93aer4B798govo
 ObEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8MVaez1EiXOpV6/LNHod1jdxMKGjlMvzzW2sLZ5v7m0=;
 b=dKf4e9ftJhLGW7nRomam8Bgrmq9yx4OOvnKG8ATaS+bfLIZ6Sz3HhXpsqf9X5f1iP+
 CFIzqZMY+r9jDwNSBuCD7a9o+KwvpkEN2xF8goAfpneqE8SK3U5TkihJjYPQ+X0U3ANt
 aCB5h5sAHOnkiPTh2LfjPphxFDl6OPu0TbgS/bqmEk3j1tS7nRrYP/xWUp7jCy2k7Lka
 6KQKn+N6JS+X5EY9DR7psCLgiXbWItzVAtEoGEqV81MUlA+dwhcfAGH0jbBCqIrQZseQ
 7z7TP4+tI887iSRkqzdZLSfAfPg0ggw/ZZLj0TKmSx8hzzrHgGJvfBydsv4tFAVzUoJ4
 XVOw==
X-Gm-Message-State: APjAAAWdqj05mNyNinY2uw46jPOehyxV3rb/m18IppTG8NdQKFGu03mA
 vP20Yn+z+sk4J/VrFpvXLe+Fp3Iz9rPsehhBcyA=
X-Google-Smtp-Source: APXvYqzDE2sSJwcVB1+z2KG7OGFxRtex+TlVhZgq/8DNM5OueqZgOkemIyQ98psgzO6JAUWs21w63AqEp2VjGl9YbV4=
X-Received: by 2002:a05:6830:1257:: with SMTP id
 s23mr19339143otp.241.1580763670695; 
 Mon, 03 Feb 2020 13:01:10 -0800 (PST)
MIME-Version: 1.0
References: <72729ef6-f8df-942f-57aa-4b3fac75a20d@web.de>
In-Reply-To: <72729ef6-f8df-942f-57aa-4b3fac75a20d@web.de>
From: wellington wallace <wellingtonwallace@gmail.com>
Date: Mon, 3 Feb 2020 18:00:59 -0300
Message-ID: <CAAJnyheEpd44ShTijdOAq6QZ9dyjJ387dcJDHg5qcd4aN90PYw@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 03 Feb 2020 22:09:49 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 03 Feb 2020 22:01:12 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Mon, 03 Feb 2020 22:09:47 +0100
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Replacing a std::string check by strcmp() with SmPL
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
Content-Type: multipart/mixed; boundary="===============1889782980=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============1889782980==
Content-Type: multipart/alternative; boundary="00000000000010d9f1059db239cc"

--00000000000010d9f1059db239cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

I did not have the time to look at this file. Lots of places comparing two
chars indeed.

The strcmp output has to be compared to zero strcmp(src_name,
"equalizer_input_level") =3D=3D 0. This is the result returned when the
arguments are equal.

Best Regards,
              Wellington.

On Mon, Feb 3, 2020 at 5:45 PM Markus Elfring <Markus.Elfring@web.de> wrote=
:

> Hello,
>
> I have tried the following small script variant out for
> the semantic patch language.
>
> @replacement@
> constant c;
> identifier text;
> expression x;
> statement is, es;
> @@
> char* text =3D x(...);
>
> if (
> +   strcmp(
>     text
> +   ,
> -   =3D=3D std::string(
>     c
>     )
>    )
>    is
> else
>    es
>
>
> A corresponding transformation result from the software
> =E2=80=9CCoccinelle 1.0.8-00029-ga549b9f0=E2=80=9D looks promising (in pr=
inciple).
>
> elfring@Sonne:~/Projekte/Coccinelle/Probe> spatch --c++
> replace_std_string_check_by_strcmp2.cocci
> PulseEffects-source_output_effects-excerpt2.cpp
> =E2=80=A6
> @@ -1,7 +1,7 @@
>  void on_message_element(const GstBus* gst_bus, GstMessage* message,
> SourceOutputEffects* soe) {
>    char* src_name =3D GST_OBJECT_NAME(message->src);
>
> -  if (src_name =3D=3D std::string("equalizer_input_level")) {
> +  if (strcmp(src_name, "equalizer_input_level")) {
>      soe->equalizer_input_level.emit(soe->get_peak(message));
>  // Deleted part
>    } else if (src_name =3D=3D std::string("webrtc_output_level")) {
>
>
> 1. But I wonder about an additional space character at the beginning
>    of the shown function in the generated patch.
>
> 2. Will it become possible to achieve a similar change
>    if the specification =E2=80=9Cauto=E2=80=9D would be used instead of
>    the data type =E2=80=9Cchar*=E2=80=9D?
>
> https://github.com/wwmm/pulseeffects/blob/acb5161a6ab8d3b0c395ed2809d3318=
ccf4931bc/src/source_output_effects.cpp#L6
>
> Regards,
> Markus
>


--=20
Prof.=C2=B0 Wellington Wallace Miguel Melo

CEFET/RJ Uned Nova Igua=C3=A7u

--00000000000010d9f1059db239cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi!<div><br></div><div>I did not have the time to look at =
this file. Lots of places comparing two chars indeed.=C2=A0</div><div><br><=
/div><div>The strcmp output has to be compared to zero strcmp(src_name, &qu=
ot;equalizer_input_level&quot;) =3D=3D 0. This is the result returned when =
the arguments are equal.</div><div><br></div><div>Best Regards,</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Wellington.</div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, F=
eb 3, 2020 at 5:45 PM Markus Elfring &lt;<a href=3D"mailto:Markus.Elfring@w=
eb.de">Markus.Elfring@web.de</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Hello,<br>
<br>
I have tried the following small script variant out for<br>
the semantic patch language.<br>
<br>
@replacement@<br>
constant c;<br>
identifier text;<br>
expression x;<br>
statement is, es;<br>
@@<br>
char* text =3D x(...);<br>
<br>
if (<br>
+=C2=A0 =C2=A0strcmp(<br>
=C2=A0 =C2=A0 text<br>
+=C2=A0 =C2=A0,<br>
-=C2=A0 =C2=A0=3D=3D std::string(<br>
=C2=A0 =C2=A0 c<br>
=C2=A0 =C2=A0 )<br>
=C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0is<br>
else<br>
=C2=A0 =C2=A0es<br>
<br>
<br>
A corresponding transformation result from the software<br>
=E2=80=9CCoccinelle 1.0.8-00029-ga549b9f0=E2=80=9D looks promising (in prin=
ciple).<br>
<br>
elfring@Sonne:~/Projekte/Coccinelle/Probe&gt; spatch --c++ replace_std_stri=
ng_check_by_strcmp2.cocci PulseEffects-source_output_effects-excerpt2.cpp<b=
r>
=E2=80=A6<br>
@@ -1,7 +1,7 @@<br>
=C2=A0void on_message_element(const GstBus* gst_bus, GstMessage* message, S=
ourceOutputEffects* soe) {<br>
=C2=A0 =C2=A0char* src_name =3D GST_OBJECT_NAME(message-&gt;src);<br>
<br>
-=C2=A0 if (src_name =3D=3D std::string(&quot;equalizer_input_level&quot;))=
 {<br>
+=C2=A0 if (strcmp(src_name, &quot;equalizer_input_level&quot;)) {<br>
=C2=A0 =C2=A0 =C2=A0soe-&gt;equalizer_input_level.emit(soe-&gt;get_peak(mes=
sage));<br>
=C2=A0// Deleted part<br>
=C2=A0 =C2=A0} else if (src_name =3D=3D std::string(&quot;webrtc_output_lev=
el&quot;)) {<br>
<br>
<br>
1. But I wonder about an additional space character at the beginning<br>
=C2=A0 =C2=A0of the shown function in the generated patch.<br>
<br>
2. Will it become possible to achieve a similar change<br>
=C2=A0 =C2=A0if the specification =E2=80=9Cauto=E2=80=9D would be used inst=
ead of<br>
=C2=A0 =C2=A0the data type =E2=80=9Cchar*=E2=80=9D?<br>
=C2=A0 =C2=A0<a href=3D"https://github.com/wwmm/pulseeffects/blob/acb5161a6=
ab8d3b0c395ed2809d3318ccf4931bc/src/source_output_effects.cpp#L6" rel=3D"no=
referrer" target=3D"_blank">https://github.com/wwmm/pulseeffects/blob/acb51=
61a6ab8d3b0c395ed2809d3318ccf4931bc/src/source_output_effects.cpp#L6</a><br=
>
<br>
Regards,<br>
Markus<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Prof.=C2=B0 Wellington Wallace =
Miguel Melo<br><br><div>CEFET/RJ Uned Nova Igua=C3=A7u<br><br></div></div><=
/div>

--00000000000010d9f1059db239cc--

--===============1889782980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1889782980==--
