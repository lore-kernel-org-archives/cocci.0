Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05374C282EC
	for <cocci@archiver.kernel.org>; Mon, 17 Mar 2025 21:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lVo31CoNtcDqukH3uhfgx/Ve9UxdoDXI1M0MSEzSPlY=;
  b=WxHNv3qKDHNrhD7S9l+AeulmIjg76BFpBI7Tl0aza88UpIfQvnTDycn1
   lcCpp2ZIcNme+iWqw5vnu3EGxUZwf0x1iwtLaeEDCH6QK9sjxrxpblzYv
   85Cy9xQ1YGfeMDeunM9fNXV+m0KtcnFyAOKBnnM3WoysTHY6KmLFSpNj2
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.14,254,1736809200"; 
   d="scan'208";a="213352559"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2025 22:00:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7F139E0261; Mon, 17 Mar 2025 22:00:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CC312E0260
	for <cocci@sympa.inria.fr>; Mon, 17 Mar 2025 22:00:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=lVo31CoNtcDqukH3uhfgx/Ve9UxdoDXI1M0MSEzSPlY=;
  b=UF9aXKMOusJehvVDjuozhP6YaDTLOaE5dJPGvZUYpLI1J+B9a9g0qQkP
   EyNx4AAJ04UYaXCR4D6MBEbombB8aqkaj1xU0eG1FuTGWZOmGqjWWMLmD
   ZQF0vk0I+JueKkdkUYSWLQPo1rtrB4Q3pLCjfuNhUfAfG24pxmHRlaOWj
   A=;
X-IronPort-AV: E=Sophos;i="6.14,254,1736809200"; 
   d="scan'208";a="213352549"
Received: from static-81-27-112-106.teledata-fttx.de (HELO smtpclient.apple) ([81.27.112.106])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 22:00:06 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Mon, 17 Mar 2025 21:59:55 +0100
Message-Id: <26B3A647-3A45-425C-B758-6CC6DCEF5A6C@inria.fr>
References: <202503171135.B1CCC51FA@keescook>
Cc: cocci@inria.fr
In-Reply-To: <202503171135.B1CCC51FA@keescook>
To: Kees Cook <kees@kernel.org>
X-Mailer: iPhone Mail (22C152)
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2591
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/26B3A647-3A45-425C-B758-6CC6DCEF5A6C%40inria.fr>


Sent from my iPhone

> On 17 Mar 2025, at 19:44, Kees Cook <kees@kernel.org> wrote:
>=20
> =EF=BB=BFHi!
>=20
> It seems that the mere presence of the "__free" attribute breaks
> matching:
>=20
> $ cat test.c
> static void why(void)
> {
>        u64 *rates_64 __free(kfree) =3D NULL;
>        rates_64 =3D kcalloc(count, sizeof(*rates_64), GFP_KERNEL);
> }
>=20
> $ cat match.cocci
> @replace@
> expression THING, COUNT;
> expression GFP;
> @@
>=20
> -       kcalloc(COUNT, sizeof(*THING), GFP)
> +       kzalloc_objs(*THING, COUNT, GFP)
>=20
>=20
> $ spatch --very-quiet --cocci-file match.cocci test.c
>=20
>=20
> Which doesn't match. If I comment out the "__free()" it works:
>=20
> $ cat test.c
> static void why(void)
> {
>        u64 *rates_64 /*__free(kfree)*/ =3D NULL;
>        rates_64 =3D kcalloc(count, sizeof(*rates_64), GFP_KERNEL);
> }
>=20
> $ spatch --very-quiet --cocci-file match.cocci test.c
> --- test.c
> +++ cocci-output-1466652-b8a5c5-test.c
> @@ -1,5 +1,5 @@
> static void why(void)
> {
>        u64 *rates_64 /*__free(kfree)*/ =3D NULL;
> -       rates_64 =3D kcalloc(count, sizeof(*rates_64), GFP_KERNEL);
> +       rates_64 =3D kzalloc_objs(*rates_64, count, GFP_KERNEL);
> }
>=20
>=20
> I have tried adding "attribute name __free;" to the rule (which didn't
> seem sane, but also didn't work). I have tried adding this line to my
> standard.h:
> #define __free(x) MACROANNOTATION

Try the above with an empty definition.

> but that didn't work either.
>=20
> What is going wrong here?
>=20
> Thanks!
>=20
> -Kees
>=20
> --
> Kees Cook

