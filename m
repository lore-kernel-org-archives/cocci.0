Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5604ACCFA13
	for <cocci@archiver.kernel.org>; Sun,  9 Nov 2025 14:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KYnMBaPpLYVMECfIYx0fZ+Abg8yDtkZAkCSfBnzuwKw=;
  b=EjwFtRe07QrDEo20CV4TgaNb3/n5d7L1en2EQTYp9UpbkRapMtp5JHaG
   RSQVBAwnfHB+vwzdul7d6mPXYenSx1vmfqhddIuXPrqHMuVpSWZB4pYgA
   gMROyuCPtXhj4CN/2JZcirXAlsC+j0n+twLP3tY/wsYfo2B3kRJCrIj0A
   o=;
X-CSE-ConnectionGUID: LK3crd6NSomawfRSrhLvXg==
X-CSE-MsgGUID: 74Gu3BT8Ro2wHerrlJpwDg==
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
X-IronPort-AV: E=Sophos;i="6.19,291,1754949600"; 
   d="scan'208";a="248362875"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Nov 2025 15:01:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8D86DE0172; Sun,  9 Nov 2025 15:01:09 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B5066E0171
	for <cocci@sympa.inria.fr>; Sun,  9 Nov 2025 15:01:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=KYnMBaPpLYVMECfIYx0fZ+Abg8yDtkZAkCSfBnzuwKw=;
  b=BCd+FG9QD6h3n2NjdezGKJp8CPBb7NyEHxWXo+6qBKgW32LGP/wxsjhb
   HyX/vmiImu3Swbf8/Ow87XRrjaPR22d5m31WFw8vyP7xUR4rjTVvVeOe8
   CpX/2mtGdEc2MmjKljHnxIs8/IM7pJmPdpyI6jhZJJ3CzxMDzYs5uwjua
   I=;
X-CSE-ConnectionGUID: hp4UfOyMSGihfpQBsGI9sA==
X-CSE-MsgGUID: HSWnNWVqSPWPvmhsrDM35w==
X-IronPort-AV: E=Sophos;i="6.19,291,1754949600"; 
   d="scan'208";a="130375434"
Received: from 59.149.22.93.rev.sfr.net (HELO smtpclient.apple) ([93.22.149.59])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 15:01:05 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Sun, 9 Nov 2025 09:00:53 -0500
Message-Id: <5C6B7613-D38D-463D-A586-4AD8070BD390@inria.fr>
References: <e27551b2-34e9-40ad-9a14-f7b5cdf9a02c@web.de>
Cc: cocci@inria.fr
In-Reply-To: <e27551b2-34e9-40ad-9a14-f7b5cdf9a02c@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Mailer: iPhone Mail (22C152)
Subject: Re: [cocci] Restricting information search for header files
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3153
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/5C6B7613-D38D-463D-A586-4AD8070BD390%40inria.fr>

If you don=E2=80=99t use include headers they will not be included in the fi=
le list, only included from other files.
Sent from my iPhone

> On 9 Nov 2025, at 07:52, Markus Elfring <Markus.Elfring@web.de> wrote:
>=20
> =EF=BB=BF
>>=20
>>> Some information was provided for the clarification approach =E2=80=9CSo=
urce code
>>> analysis for header files=E2=80=9D.
>>> https://lore.kernel.org/cocci/alpine.DEB.2.10.1501071549410.3328@hadrien=
/
>>>=20
>>> Did interests evolve any further also for such a development topic?
>> You can also use script code to exit if the file name is not suitable.
>=20
> Would this programming interface mean that the parameter =E2=80=9C--includ=
e-headers=E2=80=9D
> should be passed to the program =E2=80=9Cspatch=E2=80=9D before?
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e6f8731b851f5d76d2731=
a9d546dc4f0b181526e/docs/Coccilib.3cocci#L253-259
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e6f8731b851f5d76d2731=
a9d546dc4f0b181526e/docs/manual/cocci-python.txt#L39-40
>=20
> Will related system configuration options become more interesting?
>=20
> Regards,
> Markus

