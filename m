Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A90DCCFA13
	for <cocci@archiver.kernel.org>; Sat,  8 Nov 2025 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VTz1Vba3BJIOIUpECrSiNOkmsAOMV2QEhv62h0PfEes=;
  b=UCToIafCertQ4ilmBSu41vXcytfMiY+f98ayt2NLQtQRX4bmZgt1vqfy
   Wd1sa4BkdSMSvyY96DHA1MAf6grd6OvSdAqGGco9j9zkejVebX4k9tKo5
   4evrQahpAhGxdHfvk+1IbGKINl5l20Rk6MM0xzDkOakWziBPAe53elWDC
   s=;
X-CSE-ConnectionGUID: 4yiRVIOZR76sy8/Jixgi9w==
X-CSE-MsgGUID: C+HW7Jz0T3Che5I6LMGPxQ==
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
   d="scan'208";a="248313741"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2025 17:22:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 720ADE0B0D; Sat,  8 Nov 2025 17:22:26 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0C6CBE0171
	for <cocci@sympa.inria.fr>; Sat,  8 Nov 2025 17:22:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=VTz1Vba3BJIOIUpECrSiNOkmsAOMV2QEhv62h0PfEes=;
  b=rIPh8la3xecq8WxM6MZydUVOhvPNUdPRKfxIusnwZoi4IYXssLrS3OcT
   5eiwkuHOEMrghEuzVeznWXerZ6KIObjYJk7/+zKZMUNeDAX02F6G90lik
   pKwSl37dbMSrZNHeCONl8eNeLy0PHoSlUlMIT4A2RrVUoHJTxl0hZ6Sn+
   0=;
X-CSE-ConnectionGUID: jpIvb5YWT7STajL6zCt/Gw==
X-CSE-MsgGUID: rdvpnx3xTEiTN3evFVqNmQ==
X-IronPort-AV: E=Sophos;i="6.19,289,1754949600"; 
   d="scan'208";a="130344398"
Received: from 74-95-99-105-richmond.hfc.comcastbusiness.net (HELO smtpclient.apple) ([74.95.99.105])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 17:22:20 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Sat, 8 Nov 2025 11:22:08 -0500
Message-Id: <0A7E25B0-BD29-4AA0-80A6-AB5B351CA52D@inria.fr>
References: <71e805cb-29bf-4fcb-bd90-9d012f977c4f@web.de>
Cc: cocci@inria.fr
In-Reply-To: <71e805cb-29bf-4fcb-bd90-9d012f977c4f@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Mailer: iPhone Mail (22C152)
Subject: Re: [cocci] Searching for switch statements with SmPL?
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3147
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/0A7E25B0-BD29-4AA0-80A6-AB5B351CA52D%40inria.fr>

Yes. You used * so paths are considered individually=20
Sent from my iPhone

> On 8 Nov 2025, at 09:47, Markus Elfring <Markus.Elfring@web.de> wrote:
>=20
> =EF=BB=BF
>>=20
>>> Which SmPL script variant would you find more reasonable for the mention=
ed
>>> use case?
>>=20
>> Just remove the <+=E2=80=A6 =E2=80=A6+>
>=20
> May switch statements contain multiple cases?
> https://cppreference.com/w/c/language/switch.html
>=20
> Regards,
> Markus

