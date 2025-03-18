Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98269C282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 17:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OSh9wQ2a+ogAxUh8S5XY3Jtrg/D90uyM6WoU8m9aq0Q=;
  b=sVj4d9YlF6eAX0SiNg9FWXCf0RaIc2YCncpk1Z10JLxN7doTuNLn3I5/
   Bzx5VAgystio6qCPCNjR2wZs6AevoejewwRQrxb08+CJ3HVr/zD/uuPsx
   NNRtfAxSrumUEGcHlM+3D2Y/aL06lRTp/Or26MYJLZ6fZfxV4DZ9ijxTL
   g=;
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
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213560460"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 18:56:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 13917E0D1D; Tue, 18 Mar 2025 18:56:56 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6494FE0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 18:56:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=OSh9wQ2a+ogAxUh8S5XY3Jtrg/D90uyM6WoU8m9aq0Q=;
  b=QtVKgSfK6Td6Vut1C+Znx0psUougaGp7thdjsf36+Sh7vUj7hq7TK+6c
   FvdOmLG586gf7iFB6b7mcWLoGxF6eX+3NqrnLmcQg14bRH7PS+7IZQBR9
   7WHG1Fys9/O0pydEVSDXat+zCNGH+40n3eIGDSXmchunnhp/YJIKLp4bQ
   0=;
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="111944414"
Received: from 111.169.185.81.rev.sfr.net (HELO smtpclient.apple) ([81.185.169.111])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 18:56:52 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Tue, 18 Mar 2025 18:56:40 +0100
Message-Id: <F7BB5789-F9F2-4D17-986A-AD7BC976F18B@inria.fr>
References: <202503180924.2135CF8FD@keescook>
Cc: cocci@inria.fr
In-Reply-To: <202503180924.2135CF8FD@keescook>
To: Kees Cook <kees@kernel.org>
X-Mailer: iPhone Mail (22C152)
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2629
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/F7BB5789-F9F2-4D17-986A-AD7BC976F18B%40inria.fr>

I think you want

Expression *m;

A->@m b

B would be an identifier

Sent from my iPhone

> On 18 Mar 2025, at 17:31, Kees Cook <kees@kernel.org> wrote:
>=20
> =EF=BB=BFOn Tue, Mar 18, 2025 at 04:43:30PM +0100, Julia Lawall wrote:
>>>> On 18 Mar 2025, at 16:39, Kees Cook <kees@kernel.org> wrote:
>>>=20
>>> =EF=BB=BFOn Tue, Mar 18, 2025 at 12:13:15AM +0100, Julia Lawall wrote:
>>>> It makes the call just disappear.
>>>=20
>>> Right, unfortunately this breaks replacement, because the __free
>>> vanishes completely even in the replacement:
>>>=20
>>> -       struct platform_profile_handler *pprof __free(kfree) =3D kzalloc=
(
>>> -               sizeof(*pprof), GFP_KERNEL);
>>> +       struct platform_profile_handler *pprof =3D kzalloc_obj(*pprof, G=
FP_KERNEL);
>>>=20
>>> How do we get __free to be treated like any other variable attribute?
>>>=20
>>=20
>> It would certainly be good to supp=C3=B4t it better. But I have the impre=
ssion that you are removing and recreating the whole part to the left of the=
 equal? It could work better to remove and recreate only the kzalloc call.
>=20
> Oh! Yes, thank you. That works. :)
>=20
> Okay, next question. Based on your advise on constructing matches for
> arbitrarily long dereferences[1], I am trying to apply the same logic,
> but to also tie identifiers to types:
>=20
> @direct depends on !(file in "tools") && !(file in "samples")@
> type TYPE;
> TYPE *P;
> TYPE *MEMBER;
> TYPE INST;
> expression COMP;
> identifier ALLOC =3D~ "^kv?[mz]alloc";
> fresh identifier ALLOC_OBJ =3D ALLOC ## "_obj";
> @@
>=20
>        \(\(P\|COMP.MEMBER\|COMP->MEMBER\) \& VAR\)
> -       =3D ALLOC((\(sizeof(*VAR)\|sizeof(TYPE)\|sizeof(INST)\)), GFP);
> +       =3D ALLOC_OBJ(*VAR, GFP);
>=20
> This won't parse:
>=20
> minus: parse error:
>  File "scripts/coccinelle/api/kmalloc_objs.cocci", line 58, column 13, cha=
rpos =3D 1303
>  around =3D 'MEMBER',
>  whole content =3D       \(\(P\|COMP.MEMBER\|COMP->MEMBER\) \& VAR\)
>=20
>=20
> If I change MEMBER to:
>=20
> identifier MEMBER;
>=20
> it parses, but then I lose the association of "MEMBER" being a "TYPE"
> pointer. Is there some why to make that work?
>=20
> Thanks!
>=20
> -Kees
>=20
> [1] https://lore.kernel.org/cocci/alpine.DEB.2.22.394.2006182155260.2367@h=
adrien/
>=20
> --
> Kees Cook

