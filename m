Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF05EC83F1A
	for <cocci@archiver.kernel.org>; Mon, 14 Jul 2025 09:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nuRSzl3T5mFowZ6W0Juuj6Ybu7MjUQxlJoD1U5dfHjI=;
  b=TSJkhy4qRx1MsinKMsOkOMPnsS0mrWNbKsXQA9vWewwR4sbInrqn0BO/
   jdeyETrZMpcJuSi/FQ724xlbKEP5yDxJQ4npMnxtm2rFSQvlwpb3VK036
   lcMwmAgfWY4zFIdrYbC6rTmgl/5NW9/dGNaTlCp2UFD64tdQ9gTUpPDQG
   A=;
X-CSE-ConnectionGUID: cd1vbIWrRnO4L+Dg7rVkJg==
X-CSE-MsgGUID: r2OtbhnfTPGHMCz2rh9e9g==
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
X-IronPort-AV: E=Sophos;i="6.16,310,1744063200"; 
   d="scan'208";a="231555148"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jul 2025 11:57:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F4210E0CCF; Mon, 14 Jul 2025 11:57:31 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 07980E007A
	for <cocci@sympa.inria.fr>; Mon, 14 Jul 2025 11:57:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=nuRSzl3T5mFowZ6W0Juuj6Ybu7MjUQxlJoD1U5dfHjI=;
  b=VbQJK7MLQzr2ZIoKr0df3QMhWnJdElUA8YX72KQziDXjBCloff9uLOFV
   /9bvCXCHHDRy1NJKwwg7h7eDSoX3IHOnVhCAnq0cXV9MSUAYqf277Ei1Q
   KeXXnKI12qvpajJ/BwifKy5WHb3Il8MEFqVhyxGcx//Fd4ElQBud8Z61A
   E=;
X-CSE-ConnectionGUID: AdXK9HezQzmyxEfdn0YhHA==
X-CSE-MsgGUID: ywB+jGPcR4OdicbokYDaeA==
X-IronPort-AV: E=Sophos;i="6.16,310,1744063200"; 
   d="scan'208";a="231555053"
Received: from unknown (HELO smtpclient.apple) ([172.59.115.247])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 11:57:27 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Mon, 14 Jul 2025 05:57:14 -0400
Message-Id: <BBB485D5-F5B1-493D-BDD1-FF8A1FD38BF7@inria.fr>
References: <8b094c79-c6e5-4398-a2a9-37e9d46a46e8@web.de>
Cc: cocci@inria.fr, Yue Haibing <yuehaibing@huawei.com>,
 Kuniyuki Iwashima <kuniyu@google.com>
In-Reply-To: <8b094c79-c6e5-4398-a2a9-37e9d46a46e8@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Mailer: iPhone Mail (22C152)
Subject: Re: [cocci] Deleting duplicate condition checks (with SmPL)?
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2868
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/BBB485D5-F5B1-493D-BDD1-FF8A1FD38BF7%40inria.fr>



> On 14 Jul 2025, at 03:27, Markus Elfring <Markus.Elfring@web.de> wrote:
>=20
> =EF=BB=BF
>>=20
>> Which software improvements will become more desirable for such an use ca=
se?
>=20
> Will another script variant for the semantic patch language become helpful=
?
>=20
>=20
> // See also:
> // [PATCH net-next] ipv6: mcast: Remove unnecessary null check in mld_del_=
delrec()
> // https://lore.kernel.org/netdev/CAAVpQUC-mV=3DSuNNhKbpy_1Mbh_sOs856+oNqD=
VJ4KcLjhDh2kw@mail.gmail.com/
> // https://lkml.org/lkml/2025/7/12/336
> //
> // https://elixir.bootlin.com/linux/v6.16-rc5/source/net/ipv6/mcast.c#L786=
-L813
> @adjustment disable braces0@
> expression e;
> identifier i;
> @@
> void i(...)
> {
> ... when any
> if (
> +    !
>     e
>    )
> +   return;
> -   {
>    ... when any

I have no idea what is the question here, but the above when any is useless.=
 Braces always match up properly.

> -   }
> -if (e)
> -   {
>    ... when any
> -   }
> ... when any
> }
>=20
>=20
> Would you be looking for further source code layout refinements then?
>=20
> Regards,
> Markus

