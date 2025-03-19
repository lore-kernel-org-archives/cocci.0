Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF1BC35FF1
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 05:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6RW/t/vbSJL+tt+6evhsJWt7uvpb14c+fIHpC7obEIQ=;
  b=CBDcTMexh/yIyitMqjY5+UvAcJuSBJWGjQxqvBYjwHjO742fgk44qlF0
   aAtPZNvxE8w2S/PT25IqsBo/vIGkwkvrHtQ4CwkJ+jMe1oqUO6APqpUK3
   t1h2uu5JvY2KoY3wk2zJt1t8OlzzsWVjbGittqoIYRj/ew/8s+n+NebE8
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
X-IronPort-AV: E=Sophos;i="6.14,258,1736809200"; 
   d="scan'208";a="213606924"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 06:55:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 00322E0264; Wed, 19 Mar 2025 06:55:52 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 62364E007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 06:55:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=6RW/t/vbSJL+tt+6evhsJWt7uvpb14c+fIHpC7obEIQ=;
  b=ti65OuuVKqJ9uAiXpMP2AT7/EYQf+kWBz7BcdTvx0v3ddY8KtuAkcxog
   N3Ac5ZXEnnOkS34125ZA+g+uT1ppYyuMIn1Mw53uyyUfJv5p6/L3CJswe
   ZpUZwp7LwgKzlKvnZxKlaGpMKCfwcG6j64RkGHrra4/huvHOXl2aTKQ9q
   U=;
X-IronPort-AV: E=Sophos;i="6.14,258,1736809200"; 
   d="scan'208";a="111978564"
Received: from static-81-27-112-106.teledata-fttx.de (HELO smtpclient.apple) ([81.27.112.106])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 06:55:47 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Wed, 19 Mar 2025 06:55:35 +0100
Message-Id: <0F8C28C0-B4BD-4806-8094-51B04BD649C7@inria.fr>
References: <202503182023.D7C4D91@keescook>
Cc: cocci@inria.fr
In-Reply-To: <202503182023.D7C4D91@keescook>
To: Kees Cook <kees@kernel.org>
X-Mailer: iPhone Mail (22C152)
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2633
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/0F8C28C0-B4BD-4806-8094-51B04BD649C7%40inria.fr>

If it doesn=E2=80=99t match then it doesn=E2=80=99t find the type informatio=
n?
Sent from my iPhone

> On 19 Mar 2025, at 04:31, Kees Cook <kees@kernel.org> wrote:
>=20
> =EF=BB=BFOn Tue, Mar 18, 2025 at 06:56:40PM +0100, Julia Lawall wrote:
>> I think you want
>>=20
>> Expression *m;
>>=20
>> A->@m b
>>=20
>> B would be an identifier
>=20
> But how does "B" get correctly type restricted? (Or in my example,
> "NAME"?)
>=20
> I tried:
>=20
> @direct depends on !(file in "tools") && !(file in "samples")@
> type TYPE;
> TYPE *P;
> TYPE *MEMBER;
> TYPE INST;
> identifier NAME;
> expression COMP;
> identifier ALLOC =3D~ "^kv?[mz]alloc";
> fresh identifier ALLOC_OBJ =3D ALLOC ## "_obj";
> @@
>=20
>       \(\(P\|COMP.@MEMBER NAME\|COMP->@MEMBER NAME\) \& VAR\)
> -       =3D ALLOC((\(sizeof(*VAR)\|sizeof(TYPE)\|sizeof(INST)\)), GFP);
> +       =3D ALLOC_OBJ(*VAR, GFP);
>=20
> This parses, but don't match (from crypto/asymmetric_keys/x509_cert_parser=
.c):
>=20
>    cert->pub =3D kzalloc(sizeof(struct public_key), GFP_KERNEL);
>=20
> But does match (via "P"):
>=20
>    cert =3D kzalloc(sizeof(struct x509_certificate), GFP_KERNEL);
>=20
> /me continues to scratch head
>=20
>=20
> --
> Kees Cook

