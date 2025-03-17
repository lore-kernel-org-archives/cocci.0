Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BBEC282EC
	for <cocci@archiver.kernel.org>; Mon, 17 Mar 2025 23:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FCuuZNXVDB7Nxuw58DhZGZOb9t0Iy1niYnDaxe3yoN0=;
  b=k0zjdpG/6DRpljAPzKaY1vYmcyIQ/v/+977Wh4CH6BR+SVseU1b5quFL
   n6EV8OLeXgs2WcWLi9zaXa6hqPkZW5mXjzDqqWV+XuXXX+300t1xpNoqN
   cqJpxZEd99HFGHqRRdW2KGJZrH4AFg7B7tz8+Hl6AQQCbwwlyh5CCYBWh
   I=;
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
X-IronPort-AV: E=Sophos;i="6.14,255,1736809200"; 
   d="scan'208";a="213360400"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 00:13:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 336DDE0261; Tue, 18 Mar 2025 00:13:33 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1EF69E0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 00:13:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=FCuuZNXVDB7Nxuw58DhZGZOb9t0Iy1niYnDaxe3yoN0=;
  b=SdPZLGfDjeepX8nn+h80ACQeD7Z9o+4JmMGEStSJ4rr6siWumwa5ytH6
   qZ1b+HkA4jl1Q3F/ryQTrNJMsfj8NpSb0nVIrCRV6/DFwwAjdYvCHyqzJ
   IAUnaTohoPOyQa0ixcWpYImDYAkRdjjdNGojTupw1L4ROpZRqddaJgXhC
   I=;
X-IronPort-AV: E=Sophos;i="6.14,255,1736809200"; 
   d="scan'208";a="213360388"
Received: from static-81-27-112-106.teledata-fttx.de (HELO smtpclient.apple) ([81.27.112.106])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 00:13:26 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Tue, 18 Mar 2025 00:13:15 +0100
Message-Id: <C8ED8386-4D0E-4177-B124-65B5B8F01B15@inria.fr>
References: <202503171601.9B8ECEA00@keescook>
Cc: cocci@inria.fr
In-Reply-To: <202503171601.9B8ECEA00@keescook>
To: Kees Cook <kees@kernel.org>
X-Mailer: iPhone Mail (22C152)
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2595
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/C8ED8386-4D0E-4177-B124-65B5B8F01B15%40inria.fr>

It makes the call just disappear.
Sent from my iPhone

> On 18 Mar 2025, at 00:02, Kees Cook <kees@kernel.org> wrote:
>=20
> =EF=BB=BFOn Mon, Mar 17, 2025 at 09:59:55PM +0100, Julia Lawall wrote:
>>>> On 17 Mar 2025, at 19:44, Kees Cook <kees@kernel.org> wrote:
>>> seem sane, but also didn't work). I have tried adding this line to my
>>> standard.h:
>>> #define __free(x) MACROANNOTATION
>>=20
>> Try the above with an empty definition.
>=20
> As in just:
>=20
> #define __free(x)
>=20
> ?
>=20
> Ah! Yes, that worked! Thank you!
>=20
> --
> Kees Cook

