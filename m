Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C10CCFA18
	for <cocci@archiver.kernel.org>; Sat,  8 Nov 2025 14:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=N/sl1omHGfGtNCTzrC9evN68bino0GpkoPvL+a2AqZ4=;
  b=S3LLlBpQK8C1+xRo+k3VfwB8duUbZbuc3oNb9TGbBFK8ONlxmZDD2h4T
   4tvjfp9T4jrzW/BYMkLDrtWyxsXNfkl89WLCQdpbfG3+5YLSTSwH/lXhr
   +ZpjUiYNbQhdjdGJcBFFb1HF0PiZFJqxWqAYVFzV+c7GV0KOftW+yxMp8
   k=;
X-CSE-ConnectionGUID: LjhyJWZRSnqEn68ebHYv4A==
X-CSE-MsgGUID: z3Lx/Y7iRECPvmPrGb7Log==
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
X-IronPort-AV: E=Sophos;i="6.19,289,1754949600"; 
   d="scan'208";a="248309317"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2025 15:44:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4BA0DE0BE9; Sat,  8 Nov 2025 15:44:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E86EAE0171
	for <cocci@sympa.inria.fr>; Sat,  8 Nov 2025 15:44:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=N/sl1omHGfGtNCTzrC9evN68bino0GpkoPvL+a2AqZ4=;
  b=LdzzgQw8c0hgoZ1YCXx506ki9nonvLNDSRxoF4vzZ9r2PEzpFTFrDbJs
   Brr6SSnDCi1Qw4es1+t6lh1gVPJvV2XxRboC14NUHg6Q2M8edvgIiagRY
   /x49E10kS9WLzwe/iJUlOfvaVFCIGORzRhtAZUimQS+fGwQRYxPRyjm3Y
   0=;
X-CSE-ConnectionGUID: +8/NvZkaRYymMAOUhA43UA==
X-CSE-MsgGUID: gi8KxqEkROOO49ixCp2aww==
X-IronPort-AV: E=Sophos;i="6.19,289,1754949600"; 
   d="scan'208";a="130341549"
Received: from 72.12.23.93.rev.sfr.net (HELO smtpclient.apple) ([93.23.12.72])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 15:44:29 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Sat, 8 Nov 2025 09:44:15 -0500
Message-Id: <BCA1262B-159B-480D-9FFD-CA6318D3BDDB@inria.fr>
References: <7e3a6e91-b89c-4fb6-91e3-cf43313b9e20@web.de>
Cc: cocci@inria.fr
In-Reply-To: <7e3a6e91-b89c-4fb6-91e3-cf43313b9e20@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Mailer: iPhone Mail (22C152)
Subject: Re: [cocci] Searching for switch statements with SmPL?
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3144
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/BCA1262B-159B-480D-9FFD-CA6318D3BDDB%40inria.fr>



> On 8 Nov 2025, at 09:37, Markus Elfring <Markus.Elfring@web.de> wrote:
>=20
> =EF=BB=BF
>>=20
>>> Under which circumstances will such data processing become better suppor=
ted?
>> None. All cases are directly attached to the { of the switch, like if bra=
nches are attached to an if header. So the nest doesn=E2=80=99t make sense.
>=20
> I hope that better common understanding can be achieved for more desirable=

> software behaviour also according to such a feedback.
>=20
> Which SmPL script variant would you find more reasonable for the mentioned=

> use case?
>=20

Just remove the <+=E2=80=A6 =E2=80=A6+>

> Regards,
> Markus

