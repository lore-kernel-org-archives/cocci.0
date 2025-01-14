Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BADCC02185
	for <cocci@archiver.kernel.org>; Fri, 17 Jan 2025 09:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=QrPme/WIbFeVyhaWxs0oN2w92bTe7BGCW2bjJCkeTOE=;
  b=rVWxdvWOwP/362j4NNSFc4LGX5W70R7OqGzfN703Q8kqfKJQJGEtiCnT
   07pGeQi47GYDmgZygp8YTkK49gA+EB40dhLAZepvLITvIqoda8DRZUV0b
   Y00wukuBw1wVCjX+yKuhw0VaqbwRkAexHl2xRcqjCOdHxMB/WWxLFQ7p4
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.13,211,1732575600"; 
   d="scan'208,217";a="203646325"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Jan 2025 10:48:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BB7AAE0D22; Fri, 17 Jan 2025 10:48:56 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 74888E0077
	for <cocci@sympa.inria.fr>; Tue, 14 Jan 2025 23:27:08 +0100 (CET)
IronPort-SDR: 6786e4bb_3LXq2CyqPm+u3mlsiY8wJuPnjA/YHf6ZhaU1E45tllbEWnB
 97vU2aqECnzUNomf5zeIKCtzHNUgX/p/7Us+Tzg==
X-IPAS-Result: =?us-ascii?q?A0FRAAB944Zng3yBCqpaHQEBAQEJARIBBQUBggEGAQsBA?=
 =?us-ascii?q?YE/gQOCCgQLSIRWgSOOKoF/BR0Di3OSJYF+DwEDAQsBAUQEAQEDBIUAAop1A?=
 =?us-ascii?q?h4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQE5B?=
 =?us-ascii?q?w47hXsNSQEQAYIHAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg19AQEBAQIBE?=
 =?us-ascii?q?hEEGQEBNwEECwkCCw0gAQkCAiESAQUBHAYTCBqCX4JCIwOXeo5RAW6BBUKKQ?=
 =?us-ascii?q?wEBAXh/M4EBggwBAQbcH4FkCRSBNAGITQGBXAIOh3x6JxuBSUSBSoJ1PoFSh?=
 =?us-ascii?q?kyCaYI4S3ougllnhlSDIYh8i2ImJgMHBw4NHkkOASEDJjMsAVUTFwsHBYEqH?=
 =?us-ascii?q?ysBAgGBEyWBJwU1QTkBggxpSTcCDQI1gh58giuCIYI7ghiCL0eEDoVighSBZ?=
 =?us-ascii?q?QMDFhABgXOBNXEdQAMLYgs9NxQbTJs/AWg8g3ECeg4FARsnCYJapQqhA4Qlo?=
 =?us-ascii?q?WAzqlOYfKNqhRkCCgcGESOBSwgrgVxNIxU7MQaCME8DGQ+OIRmDYb9iJTU8A?=
 =?us-ascii?q?gcBCgEBAwmNYoIogUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:bbgHeK5A765Qy5xzGAPXwEfXdLJyesId70hD6qm+c20rTiX4rb
 HcoB1/73TJYVkqKQkdcLy7SdC9qDbnhPhICOoqTNOftWvdyRGVxehZhOOJrAEIWReOkdK1vp
 0QDpSWZueAcWRSvILV5E2WH9483MKK6smT9Jzj5kYoYwUvRa8I1WdE48Wgc3GehjMpOXP0Lu
 v/2iLrzADMRV0nKuC6AnUOV/Lf4/nlvtbPTzBDJzNP0mWzpALtzL7/HxKRxApbdxxkhY4Y10
 KAsyGR3NTTjxk9oSWsp1M6O/9t6aXcIxJ4da/87/QoFg==
X-Talos-CUID: 9a23:72v+v262vJbv9uEestssrhMEN9o3UVjkw0z6ehOTEiE4U+GWYArF
X-Talos-MUID: 9a23:f+PrRwU4UaellHLq/A/xhQpCFsBR37aROGsCj5YtivOBOQUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,315,1728943200"; 
   d="scan'208,217";a="106359121"
X-MGA-submission: =?us-ascii?q?MDHtf2DxauPCrqgvR/Gqj2dmXKKN51m5Ze1Vkd?=
 =?us-ascii?q?viz3MVYpVK0sE71afNWl1SqWYZaKrQH/Pxg97kQk3T38iRzdJYbuV2Et?=
 =?us-ascii?q?nBG0DJQCjjrq3JwoTYvbq+/RZp2xqL0Z1QhEc2BGTHDJvD8Bc3fNCAGS?=
 =?us-ascii?q?YKZ7AhPyFvKft2wcomUFHqhw=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 23:27:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736893624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QrPme/WIbFeVyhaWxs0oN2w92bTe7BGCW2bjJCkeTOE=;
	b=eLAdVBUJratw22fP0l/Q6585/ci6X00LHSyIwnRxZSJsbo5uZ+rU9CG7qD2wYxVeYDsyfN
	rjD7B70OqfyHhAfc+3MHFhDKaFq/CXtGxgg+286QYtO6kJL0AcSZ5tHsGzSG8Vk0ESA5Y9
	oQytydpRnVrDR+GHJz1U79NYwOf88lo=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-Fjbua3VyNGqbsB8xPfSm4Q-1; Tue, 14 Jan 2025 17:27:03 -0500
X-MC-Unique: Fjbua3VyNGqbsB8xPfSm4Q-1
X-Mimecast-MFC-AGG-ID: Fjbua3VyNGqbsB8xPfSm4Q
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e39993d8594so14770466276.3
        for <cocci@inria.fr>; Tue, 14 Jan 2025 14:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736893622; x=1737498422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QrPme/WIbFeVyhaWxs0oN2w92bTe7BGCW2bjJCkeTOE=;
        b=IB5qaa53+WHaa0AqcycVcrnBgRRTrvGf2A7DsQrGYUq/hoBmZJkIL560Kv6mG0ZQPD
         D3Bwq14z45yn/AXyO0r/JrF/As46hsOtr5DbmIHSm6Acf3uZ1ThBlIrbpTMi8pbA64wQ
         HyyTipZRjCzkKjUvwY/p+pBlHTa5YlZbbqwR1ZuvyRtIeDw5iNHHNbOf8ppqnch2KJHu
         AnANmpsQ0PJfNBZbKwYOmJ1EV9+NBQf7b59TcTkXDX/MMwugF2u/VFj9zhSDMHbr0dBn
         CVDB1/cXfiRsj2G+AuZtiuKZvqLZIuqoCYOToztrtk0P9v+k1JC+a7TjKnOyFdloIr0M
         ORvQ==
X-Gm-Message-State: AOJu0YwNipo2Ycx3GmfMrPvd5nuOtKdRWo3j+zzTl5h2LSZgTUxWqUfZ
	v8ythzP80Wu1gzDB67SGTUSiMVKRaj5lQqcTYJ57xaB89qg//ovCDkC1EbylaTxmy5jT8wRpqf5
	1as+wadUgWtHhnJOC5qx0CY/fDbN4c+JGmVCcNn4FMm0axVqxvT4l01ozX+iBVdY9OJjcuOrvKy
	65X2SL5ymu47DOCWsMM6RC6HhSEzDG
X-Gm-Gg: ASbGncsg29KlLORPIDTzSSruq662OQaUQrO1HWiwL511PIDvphN3aUfBNZZbFxSDE+b
	uRblVwoE/3qbhKBD1MrZbYmW5l3/n16YJ2MpA
X-Received: by 2002:a05:6902:200f:b0:e54:a0b3:fb40 with SMTP id 3f1490d57ef6-e54edf40128mr21785270276.20.1736893622441;
        Tue, 14 Jan 2025 14:27:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsE/1gt4tSa6GphhzsAm0JPMZD92JUoxd5Y0LdyEjMIaTrQcK9G3kCfADByKKdftDKp4a39QlkqffJ3eSsXv0=
X-Received: by 2002:a05:6902:200f:b0:e54:a0b3:fb40 with SMTP id
 3f1490d57ef6-e54edf40128mr21785194276.20.1736893622167; Tue, 14 Jan 2025
 14:27:02 -0800 (PST)
MIME-Version: 1.0
References: <CAN9Xe3T2LjcD9Xr8vAGQWu5MUvVjr-eEaMhB-JauL5DW0aA9QQ@mail.gmail.com>
 <dcaf63e4-78bf-3111-8494-6380e6118fd8@inria.fr> <CAN9Xe3TBb2GYNeqL1f1_GTPT2W5J78gniK0ZTZJyLwJL=KydoQ@mail.gmail.com>
 <fbdc13e1-d713-c4c0-35f0-f6a1de5a9e9@inria.fr>
In-Reply-To: <fbdc13e1-d713-c4c0-35f0-f6a1de5a9e9@inria.fr>
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 14 Jan 2025 16:25:30 -0500
X-Gm-Features: AbW1kvY8LW6HqeWJenFw195CXD1OXicQ_HgA2blYrnXLQv-kNiMhC3ku17KvmHM
Message-ID: <CAN9Xe3Q99urpL68p8RxXta1xzHE6PCnfL7S3XktuLUK7KhMCXg@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, Maxime Ripard <mripard@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9VWchwd9ZsSCvlnhOEUuhM0aeZizkUeOmP-l3OMNG3Q_1736893622
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000005cbffe062bb20f7f"
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] Ellipses usage in line addition
Reply-To: Anusha Srivatsa <asrivats@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 2212
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/CAN9Xe3Q99urpL68p8RxXta1xzHE6PCnfL7S3XktuLUK7KhMCXg%40mail.gmail.com>

--0000000000005cbffe062bb20f7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 1:39=E2=80=AFPM Julia Lawall <julia.lawall@inria.fr=
> wrote:

>
>
> On Tue, 14 Jan 2025, Anusha Srivatsa wrote:
>
> > Julai, Thanks for the response. More info inline.
> >
> > On Tue, Jan 14, 2025 at 12:50=E2=80=AFPM Julia Lawall <julia.lawall@inr=
ia.fr>
> wrote:
> >
> >
> >       On Tue, 14 Jan 2025, Anusha Srivatsa wrote:
> >
> >       > Hi all,
> >       > Wanted to know if ellipses usage is not allowed in the lines
> that we want to add in the code. To be more precise,I want to replace
> mipi_dsi_generic_write_seq() usage with
> >       mipi_dsi_generic_write_seq_multi() .
> >       > the coccinelle semantic patch that I am using is:
> >       > //rule_1
> ->s/mipi_dsi_generic_write_seq/mipi_dsi_generic_write_seq_multi
> >       > @@
> >       > identifier dsi_var,dsi_device;
> >       > @@
> >       > struct mipi_dsi_device *dsi_var =3D dsi_device;
> >       > +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var }=
;
> >       > ...
> >       > -mipi_dsi_dcs_write_seq(dsi_var,...);
> >       > +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
> >       >
> >       > this throws:
> >       > init_defs_builtins: /usr/lib64/coccinelle/standard.h
> >       > lexical error: invalid in a + context: ...
> >       >   File "mipi.cocci", line 9, column 39, charpos =3D 298
> >       >   around =3D '...',
> >       >   whole content =3D +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...)=
;
> >       >
> >       > Just commenting out the function replacing the snippet (i.e
> having only dsi_ctx being populated) works just fine. But the intended
> change is ofc the proper usage of the _multi API.
> >       >
> >       > Would be nice to know what is going wrong with this approach.
> >
> >       Add a metavariable declaration like:
> >
> >       expression list es;
> >
> >       And then your change can be:
> >
> >       -mipi_dsi_dcs_write_seq(dsi_var,es);
> >       +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
> >
> > This doesnt find any match ....skips through all files.
> >
> >       Another approach is to write:
> >
> >       -mipi_dsi_dcs_write_seq(dsi_var,
> >       +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,
> >          ...);
> >
> >
> > This again throws the error : init_defs_builtins:
> /usr/lib64/coccinelle/standard.h
> > lexical error: invalid in a + context: ...
> >   File "mipi_julia.cocci", line 8, column 39, charpos =3D 220
> >   around =3D '...',
> >   whole content =3D +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
>
> I'll have to check on this.  It all looks fine to me.
>
> >
> >
> >       Another issue is that you may have many calls to
> mipi_dsi_dcs_write_seq,
> >       or taht some code paths might not contain such a call.  You
> probably just
> >       want to make such a change whereever it occurs.  So you can write=
:
> >
> > Correct. Somehow the below approach : <...P...> ends up matching all
> mipi_dsi_device *dsi_var declaration and adds a mipi_dsi_multi_ctx
> declaration regardless of mipi_dsi_dcs_write_seq() being used ...
>
> Ah, good point.  Just change <... ...> to <+... ...+>.
>
> Tried that. Results below.

Code:

@@

identifier dsi_var,dsi_device;

@@

struct mipi_dsi_device *dsi_var =3D dsi_device;

+struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };

<...

-mipi_dsi_dcs_write_seq(dsi_var,...);

+mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);

...>

Output:

spatch mipi_expt.cocci --dir ~/linux/drivers/gpu/drm/

init_defs_builtins: /usr/lib64/coccinelle/standard.h

lexical error: invalid in a + context: ...

  File "mipi_expt.cocci", line 8, column 39, charpos =3D 226

  around =3D '...',

  whole content =3D +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);

Code:

@@

identifier dsi_var,dsi_device;

@@

struct mipi_dsi_device *dsi_var =3D dsi_device;

+struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };

<+...

-mipi_dsi_dcs_write_seq(dsi_var,...);

+mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);

...+>

Output:

spatch mipi_expt.cocci --dir ~/linux/drivers/gpu/drm/

init_defs_builtins: /usr/lib64/coccinelle/standard.h

lexical error: invalid in a + context: ...

  File "mipi_expt.cocci", line 8, column 39, charpos =3D 227

  around =3D '...',

  whole content =3D +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);

Code:

@@

identifier dsi_var,dsi_device;

expression list es;

@@

struct mipi_dsi_device *dsi_var =3D dsi_device;

+struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };

<+...

-mipi_dsi_dcs_write_seq(dsi_var,es);

+mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);

...+>

Output:

Skipping=E2=80=A6..

Feel like  I am missing something fundamental ...

Regards,
Anusha

> >
> > For the lexical error, should spatch be run with  some headers that I a=
m
> notexplicitly adding? I wonder if I am running with wrong options instead
> of the semantic patch needing a tweak.
>
> I don't think so. Spatch doesn't care much about header files.
>
> julia
>
> >       @@
> >       identifier dsi_var,dsi_device;
> >       @@
> >       struct mipi_dsi_device *dsi_var =3D dsi_device;
> >       +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> >       <...
> >       -mipi_dsi_dcs_write_seq(dsi_var,...);
> >       +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
> >       ...>
> >
> >       The <... P ...> notation is like ... but it makes the change
> whereever the
> >       pattern P occurs.
> >
> > Yes. spatch however disregarding the pattern ....not sure why
> >
> > Regards,
> > Anusha
> >       julia
> >
> >
> >

--0000000000005cbffe062bb20f7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 14,=
 2025 at 1:39=E2=80=AFPM Julia Lawall &lt;<a href=3D"mailto:julia.lawall@in=
ria.fr">julia.lawall@inria.fr</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><br>
<br>
On Tue, 14 Jan 2025, Anusha Srivatsa wrote:<br>
<br>
&gt; Julai, Thanks for the response. More info inline.<br>
&gt;<br>
&gt; On Tue, Jan 14, 2025 at 12:50=E2=80=AFPM Julia Lawall &lt;<a href=3D"m=
ailto:julia.lawall@inria.fr" target=3D"_blank">julia.lawall@inria.fr</a>&gt=
; wrote:<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0On Tue, 14 Jan 2025, Anusha Srivatsa wrote:<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Hi all,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Wanted to know if ellipses usage is not=
 allowed in the lines that we want to add in the code. To be more precise,I=
 want to replace mipi_dsi_generic_write_seq() usage with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mipi_dsi_generic_write_seq_multi() .<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; the coccinelle semantic patch that I am=
 using is:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; //rule_1 -&gt;s/mipi_dsi_generic_write_=
seq/mipi_dsi_generic_write_seq_multi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; identifier dsi_var,dsi_device;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; struct mipi_dsi_device *dsi_var =3D dsi=
_device;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; +struct mipi_dsi_multi_context dsi_ctx =
=3D { .dsi =3D dsi_var };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; ...<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; -mipi_dsi_dcs_write_seq(dsi_var,...);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; +mipi_dsi_dcs_write_seq_multi(&amp;dsi_=
ctx,...);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; this throws:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; init_defs_builtins: /usr/lib64/coccinel=
le/standard.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; lexical error: invalid in a + context: =
...<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 File &quot;mipi.cocci&quot;, lin=
e 9, column 39, charpos =3D 298<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 around =3D &#39;...&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 whole content =3D +mipi_dsi_dcs_=
write_seq_multi(&amp;dsi_ctx,...);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Just commenting out the function replac=
ing the snippet (i.e having only dsi_ctx being populated) works just fine. =
But the intended change is ofc the proper usage of the _multi API.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Would be nice to know what is going wro=
ng with this approach.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Add a metavariable declaration like:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0expression list es;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0And then your change can be:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-mipi_dsi_dcs_write_seq(dsi_var,es);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+mipi_dsi_dcs_write_seq_multi(&amp;dsi_ctx,e=
s);<br>
&gt;<br>
&gt; This doesnt find any match ....skips through all files.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Another approach is to write:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-mipi_dsi_dcs_write_seq(dsi_var,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+mipi_dsi_dcs_write_seq_multi(&amp;dsi_ctx,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0...);<br>
&gt;<br>
&gt;<br>
&gt; This again throws the error : init_defs_builtins: /usr/lib64/coccinell=
e/standard.h<br>
&gt; lexical error: invalid in a + context: ...<br>
&gt; =C2=A0 File &quot;mipi_julia.cocci&quot;, line 8, column 39, charpos =
=3D 220<br>
&gt; =C2=A0 around =3D &#39;...&#39;,<br>
&gt; =C2=A0 whole content =3D +mipi_dsi_dcs_write_seq_multi(&amp;dsi_ctx,..=
.);<br>
<br>
I&#39;ll have to check on this.=C2=A0 It all looks fine to me.<br>
<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Another issue is that you may have many call=
s to mipi_dsi_dcs_write_seq,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0or taht some code paths might not contain su=
ch a call.=C2=A0 You probably just<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0want to make such a change whereever it occu=
rs.=C2=A0 So you can write:<br>
&gt;<br>
&gt; Correct. Somehow the below approach : &lt;...P...&gt; ends up matching=
 all mipi_dsi_device *dsi_var declaration and adds a mipi_dsi_multi_ctx dec=
laration regardless of mipi_dsi_dcs_write_seq() being used ...<br>
<br>
Ah, good point.=C2=A0 Just change &lt;... ...&gt; to &lt;+... ...+&gt;.<br>
<br></blockquote><div>Tried that. Results below.</div><div><br></div><div><=
p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" i=
d=3D"gmail-docs-internal-guid-1da68764-7fff-3e3d-628a-79448b4c528c"><span s=
tyle=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);backgr=
ound-color:transparent;font-weight:400;font-style:normal;font-variant:norma=
l;text-decoration:none;vertical-align:baseline;white-space:pre-wrap">Code:<=
/span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bo=
ttom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:=
rgb(0,0,0);background-color:rgb(255,255,255);font-weight:700;font-style:nor=
mal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-=
space:pre-wrap">@@</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margi=
n-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Aria=
l,sans-serif;color:rgb(0,0,0);background-color:rgb(255,255,255);font-weight=
:700;font-style:normal;font-variant:normal;text-decoration:none;vertical-al=
ign:baseline;white-space:pre-wrap">identifier dsi_var,dsi_device;</span></p=
><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0=
);background-color:rgb(255,255,255);font-weight:700;font-style:normal;font-=
variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre=
-wrap">@@</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt=
;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-se=
rif;color:rgb(0,0,0);background-color:rgb(255,255,255);font-weight:700;font=
-style:normal;font-variant:normal;text-decoration:none;vertical-align:basel=
ine;white-space:pre-wrap">struct mipi_dsi_device *dsi_var =3D dsi_device;</=
span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bot=
tom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:r=
gb(0,0,0);background-color:rgb(255,255,255);font-weight:700;font-style:norm=
al;font-variant:normal;text-decoration:none;vertical-align:baseline;white-s=
pace:pre-wrap">+struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_va=
r };</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;marg=
in-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;c=
olor:rgb(0,0,0);background-color:rgb(255,255,255);font-weight:700;font-styl=
e:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;w=
hite-space:pre-wrap">&lt;...</span></p><p dir=3D"ltr" style=3D"line-height:=
1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-f=
amily:Arial,sans-serif;color:rgb(0,0,0);background-color:rgb(255,255,255);f=
ont-weight:700;font-style:normal;font-variant:normal;text-decoration:none;v=
ertical-align:baseline;white-space:pre-wrap">-mipi_dsi_dcs_write_seq(dsi_va=
r,...);</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;m=
argin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-seri=
f;color:rgb(0,0,0);background-color:rgb(255,255,255);font-weight:700;font-s=
tyle:normal;font-variant:normal;text-decoration:none;vertical-align:baselin=
e;white-space:pre-wrap">+mipi_dsi_dcs_write_seq_multi(&amp;dsi_ctx,...);</s=
pan></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bott=
om:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rg=
b(0,0,0);background-color:rgb(255,255,255);font-weight:700;font-style:norma=
l;font-variant:normal;text-decoration:none;vertical-align:baseline;white-sp=
ace:pre-wrap">...&gt;</span></p><br><p dir=3D"ltr" style=3D"line-height:1.3=
8;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-fami=
ly:Arial,sans-serif;color:rgb(0,0,0);background-color:rgb(255,255,255);font=
-weight:700;font-style:normal;font-variant:normal;text-decoration:none;vert=
ical-align:baseline;white-space:pre-wrap">Output:</span></p><p dir=3D"ltr" =
style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"=
font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-col=
or:rgb(255,255,255);font-weight:700;font-style:normal;font-variant:normal;t=
ext-decoration:none;vertical-align:baseline;white-space:pre-wrap">spatch mi=
pi_expt.cocci --dir ~/linux/drivers/gpu/drm/</span></p><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-=
size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:rg=
b(255,255,255);font-weight:700;font-style:normal;font-variant:normal;text-d=
ecoration:none;vertical-align:baseline;white-space:pre-wrap">init_defs_buil=
tins: /usr/lib64/coccinelle/standard.h</span></p><p dir=3D"ltr" style=3D"li=
ne-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:1=
1pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:rgb(255,=
255,255);font-weight:700;font-style:normal;font-variant:normal;text-decorat=
ion:none;vertical-align:baseline;white-space:pre-wrap">lexical error: inval=
id in a + context: ...</span></p><p dir=3D"ltr" style=3D"line-height:1.38;m=
argin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:=
Arial,sans-serif;color:rgb(0,0,0);background-color:rgb(255,255,255);font-we=
ight:700;font-style:normal;font-variant:normal;text-decoration:none;vertica=
l-align:baseline;white-space:pre-wrap">=C2=A0=C2=A0File &quot;mipi_expt.coc=
ci&quot;, line 8, column 39, charpos =3D 226</span></p><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-=
size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:rg=
b(255,255,255);font-weight:700;font-style:normal;font-variant:normal;text-d=
ecoration:none;vertical-align:baseline;white-space:pre-wrap">=C2=A0=C2=A0ar=
ound =3D &#39;...&#39;,</span></p><p dir=3D"ltr" style=3D"line-height:1.38;=
margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family=
:Arial,sans-serif;color:rgb(0,0,0);background-color:rgb(255,255,255);font-w=
eight:700;font-style:normal;font-variant:normal;text-decoration:none;vertic=
al-align:baseline;white-space:pre-wrap">=C2=A0=C2=A0whole content =3D +mipi=
_dsi_dcs_write_seq_multi(&amp;dsi_ctx,...);</span></p><br><p dir=3D"ltr" st=
yle=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"fo=
nt-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color=
:rgb(255,255,255);font-weight:700;font-style:normal;font-variant:normal;tex=
t-decoration:none;vertical-align:baseline;white-space:pre-wrap">Code:</span=
></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:=
0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0=
,0,0);background-color:rgb(255,255,255);font-weight:700;font-style:normal;f=
ont-variant:normal;text-decoration:none;vertical-align:baseline;white-space=
:pre-wrap">@@</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top=
:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,san=
s-serif;color:rgb(0,0,0);background-color:rgb(255,255,255);font-weight:700;=
font-style:normal;font-variant:normal;text-decoration:none;vertical-align:b=
aseline;white-space:pre-wrap">identifier dsi_var,dsi_device;</span></p><p d=
ir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><spa=
n style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);bac=
kground-color:rgb(255,255,255);font-weight:700;font-style:normal;font-varia=
nt:normal;text-decoration:none;vertical-align:baseline;white-space:pre-wrap=
">@@</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;marg=
in-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;c=
olor:rgb(0,0,0);background-color:rgb(255,255,255);font-weight:700;font-styl=
e:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;w=
hite-space:pre-wrap">struct mipi_dsi_device *dsi_var =3D dsi_device;</span>=
</p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0=
pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,=
0,0);background-color:rgb(255,255,255);font-weight:700;font-style:normal;fo=
nt-variant:normal;text-decoration:none;vertical-align:baseline;white-space:=
pre-wrap">+struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };<=
/span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bo=
ttom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:=
rgb(0,0,0);background-color:rgb(255,255,255);font-weight:700;font-style:nor=
mal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-=
space:pre-wrap">&lt;+...</span></p><p dir=3D"ltr" style=3D"line-height:1.38=
;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-famil=
y:Arial,sans-serif;color:rgb(0,0,0);background-color:rgb(255,255,255);font-=
weight:700;font-style:normal;font-variant:normal;text-decoration:none;verti=
cal-align:baseline;white-space:pre-wrap">-mipi_dsi_dcs_write_seq(dsi_var,..=
.);</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margi=
n-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;co=
lor:rgb(0,0,0);background-color:rgb(255,255,255);font-weight:700;font-style=
:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;wh=
ite-space:pre-wrap">+mipi_dsi_dcs_write_seq_multi(&amp;dsi_ctx,...);</span>=
</p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0=
pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,=
0,0);background-color:rgb(255,255,255);font-weight:700;font-style:normal;fo=
nt-variant:normal;text-decoration:none;vertical-align:baseline;white-space:=
pre-wrap">...+&gt;</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;m=
argin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:=
Arial,sans-serif;color:rgb(0,0,0);background-color:rgb(255,255,255);font-we=
ight:700;font-style:normal;font-variant:normal;text-decoration:none;vertica=
l-align:baseline;white-space:pre-wrap">Output:</span></p><p dir=3D"ltr" sty=
le=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"fon=
t-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:=
rgb(255,255,255);font-weight:700;font-style:normal;font-variant:normal;text=
-decoration:none;vertical-align:baseline;white-space:pre-wrap">spatch mipi_=
expt.cocci --dir ~/linux/drivers/gpu/drm/</span></p><p dir=3D"ltr" style=3D=
"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-siz=
e:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:rgb(2=
55,255,255);font-weight:700;font-style:normal;font-variant:normal;text-deco=
ration:none;vertical-align:baseline;white-space:pre-wrap">init_defs_builtin=
s: /usr/lib64/coccinelle/standard.h</span></p><p dir=3D"ltr" style=3D"line-=
height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt=
;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:rgb(255,255=
,255);font-weight:700;font-style:normal;font-variant:normal;text-decoration=
:none;vertical-align:baseline;white-space:pre-wrap">lexical error: invalid =
in a + context: ...</span></p><p dir=3D"ltr" style=3D"line-height:1.38;marg=
in-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Ari=
al,sans-serif;color:rgb(0,0,0);background-color:rgb(255,255,255);font-weigh=
t:700;font-style:normal;font-variant:normal;text-decoration:none;vertical-a=
lign:baseline;white-space:pre-wrap">=C2=A0=C2=A0File &quot;mipi_expt.cocci&=
quot;, line 8, column 39, charpos =3D 227</span></p><p dir=3D"ltr" style=3D=
"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-siz=
e:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:rgb(2=
55,255,255);font-weight:700;font-style:normal;font-variant:normal;text-deco=
ration:none;vertical-align:baseline;white-space:pre-wrap">=C2=A0=C2=A0aroun=
d =3D &#39;...&#39;,</span></p><p dir=3D"ltr" style=3D"line-height:1.38;mar=
gin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Ar=
ial,sans-serif;color:rgb(0,0,0);background-color:rgb(255,255,255);font-weig=
ht:700;font-style:normal;font-variant:normal;text-decoration:none;vertical-=
align:baseline;white-space:pre-wrap">=C2=A0=C2=A0whole content =3D +mipi_ds=
i_dcs_write_seq_multi(&amp;dsi_ctx,...);</span></p><br><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-=
size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:rg=
b(255,255,255);font-weight:700;font-style:normal;font-variant:normal;text-d=
ecoration:none;vertical-align:baseline;white-space:pre-wrap">Code:</span></=
p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt=
"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,=
0);background-color:rgb(255,255,255);font-weight:700;font-style:normal;font=
-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pr=
e-wrap">@@</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0p=
t;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-s=
erif;color:rgb(0,0,0);background-color:rgb(255,255,255);font-weight:700;fon=
t-style:normal;font-variant:normal;text-decoration:none;vertical-align:base=
line;white-space:pre-wrap">identifier dsi_var,dsi_device;</span></p><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span =
style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);backg=
round-color:rgb(255,255,255);font-weight:700;font-style:normal;font-variant=
:normal;text-decoration:none;vertical-align:baseline;white-space:pre-wrap">=
expression list es;</span></p><p dir=3D"ltr" style=3D"line-height:1.38;marg=
in-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Ari=
al,sans-serif;color:rgb(0,0,0);background-color:rgb(255,255,255);font-weigh=
t:700;font-style:normal;font-variant:normal;text-decoration:none;vertical-a=
lign:baseline;white-space:pre-wrap">@@</span></p><p dir=3D"ltr" style=3D"li=
ne-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:1=
1pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:rgb(255,=
255,255);font-weight:700;font-style:normal;font-variant:normal;text-decorat=
ion:none;vertical-align:baseline;white-space:pre-wrap">struct mipi_dsi_devi=
ce *dsi_var =3D dsi_device;</span></p><p dir=3D"ltr" style=3D"line-height:1=
.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-fa=
mily:Arial,sans-serif;color:rgb(0,0,0);background-color:rgb(255,255,255);fo=
nt-weight:700;font-style:normal;font-variant:normal;text-decoration:none;ve=
rtical-align:baseline;white-space:pre-wrap">+struct mipi_dsi_multi_context =
dsi_ctx =3D { .dsi =3D dsi_var };</span></p><p dir=3D"ltr" style=3D"line-he=
ight:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;f=
ont-family:Arial,sans-serif;color:rgb(0,0,0);background-color:rgb(255,255,2=
55);font-weight:700;font-style:normal;font-variant:normal;text-decoration:n=
one;vertical-align:baseline;white-space:pre-wrap">&lt;+...</span></p><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span =
style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);backg=
round-color:rgb(255,255,255);font-weight:700;font-style:normal;font-variant=
:normal;text-decoration:none;vertical-align:baseline;white-space:pre-wrap">=
-mipi_dsi_dcs_write_seq(dsi_var,es);</span></p><p dir=3D"ltr" style=3D"line=
-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11p=
t;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:rgb(255,25=
5,255);font-weight:700;font-style:normal;font-variant:normal;text-decoratio=
n:none;vertical-align:baseline;white-space:pre-wrap">+mipi_dsi_dcs_write_se=
q_multi(&amp;dsi_ctx,es);</span></p><p dir=3D"ltr" style=3D"line-height:1.3=
8;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-fami=
ly:Arial,sans-serif;color:rgb(0,0,0);background-color:rgb(255,255,255);font=
-weight:700;font-style:normal;font-variant:normal;text-decoration:none;vert=
ical-align:baseline;white-space:pre-wrap">...+&gt;</span></p><p dir=3D"ltr"=
 style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D=
"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-co=
lor:rgb(255,255,255);font-weight:700;font-style:normal;font-variant:normal;=
text-decoration:none;vertical-align:baseline;white-space:pre-wrap">Output:<=
/span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bo=
ttom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color:=
rgb(0,0,0);background-color:rgb(255,255,255);font-weight:700;font-style:nor=
mal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-=
space:pre-wrap">Skipping=E2=80=A6..=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span></p>=C2=A0</=
div><div>Feel like=C2=A0 I am missing something fundamental ...</div><div><=
br></div><div>Regards,</div><div>Anusha<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
&gt;<br>
&gt; For the lexical error, should spatch be run with=C2=A0 some headers th=
at I am notexplicitly adding? I wonder if I am running with wrong options i=
nstead of the semantic patch needing a tweak.<br>
<br>
I don&#39;t think so. Spatch doesn&#39;t care much about header files.<br>
<br>
julia<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0identifier dsi_var,dsi_device;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mipi_dsi_device *dsi_var =3D dsi_devi=
ce;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+struct mipi_dsi_multi_context dsi_ctx =3D {=
 .dsi =3D dsi_var };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;...<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-mipi_dsi_dcs_write_seq(dsi_var,...);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+mipi_dsi_dcs_write_seq_multi(&amp;dsi_ctx,.=
..);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0...&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0The &lt;... P ...&gt; notation is like ... b=
ut it makes the change whereever the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pattern P occurs.<br>
&gt;<br>
&gt; Yes. spatch however disregarding the pattern ....not sure why<br>
&gt;<br>
&gt; Regards,<br>
&gt; Anusha<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0julia<br>
&gt;<br>
&gt;<br>
&gt;</blockquote></div></div>

--0000000000005cbffe062bb20f7f--

