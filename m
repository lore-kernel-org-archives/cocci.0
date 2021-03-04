Return-Path: <SRS0=4GFK=IC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E13DC433DB
	for <cocci@archiver.kernel.org>; Thu,  4 Mar 2021 09:32:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D7964E12
	for <cocci@archiver.kernel.org>; Thu,  4 Mar 2021 09:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D7964E12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1249VwgE015513;
	Thu, 4 Mar 2021 10:31:58 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7299877CC;
	Thu,  4 Mar 2021 10:31:58 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 92B783993
 for <cocci@systeme.lip6.fr>; Thu,  4 Mar 2021 09:34:55 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:52f])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1248YrDx004501
 for <cocci@systeme.lip6.fr>; Thu, 4 Mar 2021 09:34:54 +0100 (CET)
Received: by mail-pg1-x52f.google.com with SMTP id b21so18448676pgk.7
 for <cocci@systeme.lip6.fr>; Thu, 04 Mar 2021 00:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=mmuLcjAgnblnLeE5GzKmO6cYGIgJ+61oaoVrgNV4rtk=;
 b=P6f07n46RSFwVwiOu4eDZp9YV1a+A+HsVEcpU4m5H3SRdREvrHpeSUtjqm192f7Sru
 oANp34i80gbFd7NnVrytkc/sxnTsGWh3C8787UffH6mdatnZi3X3llReroITawH26XxF
 4OIU3vkUw4vb1RCXDImmE35NYZ1Uf3nQSq6Y/B3XZfLCkjbovwZL7hUTQOu5iSvA8FBN
 xD7vK7bXAZI53jXQo9T7CmYinhKRFRTZAbU1q6t+jGjwSIwlAZW98mZfp39qKkRGCryt
 KE+jojsBBSjZpf5LFwKJNtslqjCjTNtTcvr1DQHW8+/Oz8sJXhWiI5nxoHTn0mk0K3ty
 Nlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=mmuLcjAgnblnLeE5GzKmO6cYGIgJ+61oaoVrgNV4rtk=;
 b=iv80HVd4xd4K3nSdIuMP4XtMz4L9NPkP6WF7XKSDFb+hi0dY7D2vCAwQSKG7MSGuyM
 WGZsWFuQmTa2evOi7aedkroMq0qw8mT4SSoBi6jjaluKBw3stBK2Rd6Il5cV3i/HuOox
 KeFRWXA3UACKQK0uqwYvS5P6F5u2g85oAwsW+fVxthFKa90H4rvXrogE3hlR36Gy6fJr
 Be3UXvJ9n2FL8dl6Jyie0W7zOhYRikm2/MpFaR//jqicVJ0X/3/bQfox0CHnhVNXHB6q
 HTYCQbfxovT4rYFQ3jm68bXpJro+/xK8NvfJClTiEOrQDNdqkLsIf/XJCkVAMU0EtZOq
 eUTA==
X-Gm-Message-State: AOAM531WinW8BymTaIaJEr9I+C8/GpyVlXGQyaU1OtxE7fu3Oy3Im66h
 JHOAyjpwM+pcJU3ZC/PdgWfiM2vm0TQxYE1DnJk=
X-Google-Smtp-Source: ABdhPJxZKxL/bfdipqA4RUQu49+P1LcXq25umxZVG7z4j/0Ck6TV3XT1zCcjjsnI5C727A3u7rswu1jACNV9r3kWPBc=
X-Received: by 2002:a65:5ac9:: with SMTP id d9mr2815457pgt.74.1614846893244;
 Thu, 04 Mar 2021 00:34:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:90a:738c:0:0:0:0 with HTTP; Thu, 4 Mar 2021 00:34:52
 -0800 (PST)
In-Reply-To: <22d22edd-4213-0f57-d801-1c570f04ec05@petrovitsch.priv.at>
References: <053b06c47f08631675c295b5c893b90be4248347.camel@perches.com>
 <22d22edd-4213-0f57-d801-1c570f04ec05@petrovitsch.priv.at>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Mar 2021 10:34:52 +0200
Message-ID: <CAHp75Vfy+63qnRWd4mp1ZkLeEw6XaRxHXzUBXtw8SA4dbuGskg@mail.gmail.com>
To: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 04 Mar 2021 10:31:59 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 04 Mar 2021 09:34:54 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Thu, 04 Mar 2021 10:31:56 +0100
Cc: Joe Perches <joe@perches.com>, cocci <cocci@systeme.lip6.fr>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: [Cocci] linux-kernel janitorial RFP: Mark static arrays as const
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
Content-Type: multipart/mixed; boundary="===============1832677326=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============1832677326==
Content-Type: multipart/alternative; boundary="0000000000007045fb05bcb1d765"

--0000000000007045fb05bcb1d765
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, March 3, 2021, Bernd Petrovitsch <bernd@petrovitsch.priv.at>
wrote:

> Hi all!
>
> On 02/03/2021 18:42, Joe Perches wrote:
> [...]
> > ------------- For instance: (head -10 of the git grep for file statics)
> >
> > drivers/accessibility/speakup/keyhelp.c:18:static u_short masks[] =3D {
> 32, 16, 8, 4, 2, 1 };
> > drivers/accessibility/speakup/keyhelp.c:26:static u_char funcvals[] =3D=
 {
> > drivers/accessibility/speakup/main.c:2059:static spkup_hand
> spkup_handler[] =3D {
> > drivers/accessibility/speakup/speakup_acntpc.c:35:static unsigned int
> synth_portlist[] =3D { 0x2a8, 0 };
> > drivers/accessibility/speakup/speakup_decpc.c:133:static int
> synth_portlist[] =3D { 0x340, 0x350, 0x240, 0x250, 0 };
> > drivers/accessibility/speakup/speakup_dectlk.c:110:static int
> ap_defaults[] =3D {122, 89, 155, 110, 208, 240, 200, 106, 306};
> > drivers/accessibility/speakup/speakup_dectlk.c:111:static int
> g5_defaults[] =3D {86, 81, 86, 84, 81, 80, 83, 83, 73};
> > drivers/accessibility/speakup/speakup_dtlk.c:34:static unsigned int
> synth_portlist[] =3D {
> > drivers/accessibility/speakup/speakup_keypc.c:34:static unsigned int
> synth_portlist[] =3D { 0x2a8, 0 };
> > drivers/acpi/ac.c:137:static enum power_supply_property ac_props[] =3D =
{
> >
> > For drivers/accessibility/speakup/keyhelp.c:18:static u_short masks[] =
=3D
> { 32, 16, 8, 4, 2, 1 };
>
> Looking at the examples: Just s/^static /static const / in the lines
> reported by the grep's above and see if it compiles (and save space)?



I did two reverts and reported at least one issue with blind
constification. Besides that we have a lot of data structures that require
to drop const sp=C3=A9cifier and the consumer won=E2=80=99t actually know i=
f it=E2=80=99s
possible to write there or not. I=E2=80=99m talking about driver data field=
s where
they are defined as type of kernel_ulong_t. So, first you need to fix that,



>
> MfG,
>         Bernd
> --
> Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
>      There is NO CLOUD, just other people's computers. - FSFE
>                      LUGA : http://www.luga.at
>


--=20
With Best Regards,
Andy Shevchenko

--0000000000007045fb05bcb1d765
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, March 3, 2021, Bernd Petrovitsch &lt;<a href=3D"mailt=
o:bernd@petrovitsch.priv.at">bernd@petrovitsch.priv.at</a>&gt; wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">Hi all!<br>
<br>
On 02/03/2021 18:42, Joe Perches wrote:<br>
[...]<br>
&gt; ------------- For instance: (head -10 of the git grep for file statics=
)<br>
&gt; <br>
&gt; drivers/accessibility/speakup/<wbr>keyhelp.c:18:static u_short masks[]=
 =3D { 32, 16, 8, 4, 2, 1 };<br>
&gt; drivers/accessibility/speakup/<wbr>keyhelp.c:26:static u_char funcvals=
[] =3D {<br>
&gt; drivers/accessibility/speakup/<wbr>main.c:2059:static spkup_hand spkup=
_handler[] =3D {<br>
&gt; drivers/accessibility/speakup/<wbr>speakup_acntpc.c:35:static unsigned=
 int synth_portlist[] =3D { 0x2a8, 0 };<br>
&gt; drivers/accessibility/speakup/<wbr>speakup_decpc.c:133:static int synt=
h_portlist[] =3D { 0x340, 0x350, 0x240, 0x250, 0 };<br>
&gt; drivers/accessibility/speakup/<wbr>speakup_dectlk.c:110:static int ap_=
defaults[] =3D {122, 89, 155, 110, 208, 240, 200, 106, 306};<br>
&gt; drivers/accessibility/speakup/<wbr>speakup_dectlk.c:111:static int g5_=
defaults[] =3D {86, 81, 86, 84, 81, 80, 83, 83, 73};<br>
&gt; drivers/accessibility/speakup/<wbr>speakup_dtlk.c:34:static unsigned i=
nt synth_portlist[] =3D {<br>
&gt; drivers/accessibility/speakup/<wbr>speakup_keypc.c:34:static unsigned =
int synth_portlist[] =3D { 0x2a8, 0 };<br>
&gt; drivers/acpi/ac.c:137:static enum power_supply_property ac_props[] =3D=
 {<br>
&gt; <br>
&gt; For drivers/accessibility/speakup/<wbr>keyhelp.c:18:static u_short mas=
ks[] =3D { 32, 16, 8, 4, 2, 1 };<br>
<br>
Looking at the examples: Just s/^static /static const / in the lines<br>
reported by the grep&#39;s above and see if it compiles (and save space)?</=
blockquote><div><br></div><div><br></div><div>I did two reverts and reporte=
d at least one issue with blind constification. Besides that we have a lot =
of data structures that require to drop const sp=C3=A9cifier and the consum=
er won=E2=80=99t actually know if it=E2=80=99s possible to write there or n=
ot. I=E2=80=99m talking about driver data fields where they are defined as =
type of kernel_ulong_t. So, first you need to fix that,</div><div><br></div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
MfG,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Bernd<br>
-- <br>
Bernd Petrovitsch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Email : <a href=3D"mailto:bernd@petrovitsch.priv.at">bernd@petrovits=
ch.priv.at</a><br>
=C2=A0 =C2=A0 =C2=A0There is NO CLOUD, just other people&#39;s computers. -=
 FSFE<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0LUGA : <a href=3D"http://www.luga.at" target=3D"_blank">http://www.luga.=
at</a><br>
</blockquote><br><br>-- <br>With Best Regards,<br>Andy Shevchenko<br><br><b=
r>

--0000000000007045fb05bcb1d765--

--===============1832677326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1832677326==--
