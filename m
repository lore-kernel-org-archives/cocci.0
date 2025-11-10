Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5108CCF9E3
	for <cocci@archiver.kernel.org>; Mon, 10 Nov 2025 18:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BO+Werv4xlpkr6LA4mEzHcB5AsoQ7Ub58IBM4E6WIS4=;
  b=N5HxiMIkPQRf+LgmSe/h9NuC/voucTZox32cHrW+aMbEout9/7HcmXiw
   cW9rCDkeIVsZtGP2m6cgSB3+3qHDs3q1iawKZIZ+ExTvep6cDfAZmFaSO
   Kddxm1usvNViwHOPzQaDcXym09nMNUrQSftanK5Po/Fue0eZO/XvAKMHa
   Y=;
X-CSE-ConnectionGUID: rI6yIe4DRmuh3pjYDLUvHg==
X-CSE-MsgGUID: KmjN1htsQwqpIehRCqqVVw==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.19,294,1754949600"; 
   d="scan'208";a="248520933"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Nov 2025 19:25:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A108BE0BE9; Mon, 10 Nov 2025 19:25:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BEA70E0171
	for <cocci@sympa.inria.fr>; Mon, 10 Nov 2025 19:24:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=BO+Werv4xlpkr6LA4mEzHcB5AsoQ7Ub58IBM4E6WIS4=;
  b=C7JwQJQ2cLhDWCrCSwbBqaVNKChvCNNyGclf8OgA3YPmjhCYJ5RUnxQn
   YNP76fSFQK5OIu+bBGkdVhYDiv1FLs8ydXNtq265dRvl2ueFFIjYzApF9
   EJSYAefCTr5e+7X5Jjy/xJYzJ06KIv7S5i67KyRckNJ0SKZMZfpbyQSx6
   k=;
X-CSE-ConnectionGUID: 3jK/Q/aRT/ih7+HlxJswsQ==
X-CSE-MsgGUID: 9tk7Qr7ITB6XrjLo//ULCA==
X-IronPort-AV: E=Sophos;i="6.19,294,1754949600"; 
   d="scan'208";a="248520931"
Received: from 149.148.22.93.rev.sfr.net (HELO smtpclient.apple) ([93.22.148.149])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 19:24:55 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Mon, 10 Nov 2025 13:24:42 -0500
Message-Id: <338F2B21-0F98-450A-BDA0-6F7E4F22F9FD@inria.fr>
References: <a2551ccb-edd1-403c-bcd6-3f9cd5381bcb@web.de>
Cc: cocci@inria.fr
In-Reply-To: <a2551ccb-edd1-403c-bcd6-3f9cd5381bcb@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Mailer: iPhone Mail (22C152)
Subject: Re: [cocci] Moving string literals with SmPL?
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3157
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/338F2B21-0F98-450A-BDA0-6F7E4F22F9FD%40inria.fr>



> On 10 Nov 2025, at 10:10, Markus Elfring <Markus.Elfring@web.de> wrote:
>=20
> =EF=BB=BFHello,
>=20
> I would appreciate if another source code transformation can be achieved
> also by the means of the semantic patch language.
> Thus I tried the following SmPL script variant out.
>=20
> // See also:
> // crypto_rng_show()
> // https://elixir.bootlin.com/linux/v6.18-rc4/source/crypto/rng.c#L82-L86
> @adjustment@
> constant char[] last_literal, literal;
> expression context;
> @@
> -seq_printf(context, literal);
> seq_printf(context,
> +           literal

Why is there no comma after literal?

>            last_literal,
>            ...);
>=20
>=20
> Unfortunately, I am wondering about the following information.
>=20
> Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --parse-cocci combine_selected_seq_printf_calls.cocci
> =E2=80=A6
> plus: parse error:
>  File "combine_selected_seq_printf_calls.cocci", line 11, column 12, charp=
os =3D 267
>  around =3D 'last_literal',
>  whole content =3D             last_literal,
>=20
>=20
> Under which circumstances will such data processing become better supporte=
d?
> http://www.en.cppreference.com/w/c/language/string_literal.html
>=20
> Regards,
> Markus

