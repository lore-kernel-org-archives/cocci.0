Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE011C71136
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=1AHPpjHt1Cr4PyEO5tisGJE4vMZeMsGS5eu1rpr/RH8=;
  b=qsFUGHejZmBkVUKagnCOt+M23nakDUG3ObvvXGjFefvJEkqsSEFVibrT
   3zAmI+CiSGc8pyiWz/JEY+YSemjBAnuUzgtn3zKlYF/5KzfPdJWs29Mve
   oiLyhz8e1N6U09z8ln3sUXbO0Al3XY8cDPHyM0HZhX+bM8xhkaJffV+Sq
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226905113"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 16:23:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A9FC6E0AF1; Thu, 12 Jun 2025 16:23:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C58C5E0131
	for <cocci@sympa.inria.fr>; Thu, 12 Jun 2025 16:23:28 +0200 (CEST)
IronPort-SDR: 684ae2e0_cs7ZDNLmk/lFMR73JX8Ny/M/QGwOT+V+YbQblTs6t17XNVd
 I9ql1Kh9Wom0hIl3lW83tO3CggwHoNGoIkSTU3w==
X-IPAS-Result: =?us-ascii?q?A0EJAgDy4Upog07ASNlaHQEBAQEJARIBBQUBQIFTgkSBA?=
 =?us-ascii?q?FozBAtJhFWPUIIkhDuPD4xJAg8BAwENPREBAgQBAQMEhDo8CgKLZwIeBwEEN?=
 =?us-ascii?q?BMBAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAToHDjuFew2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBFwINOkQBAQECASMdAQERJgEECwsaA?=
 =?us-ascii?q?iYCAlYGFQEBgn4BgiEBBhABAw4kBw2xLoEygQGCDAEBBtpeHywiWIFlAwaBG?=
 =?us-ascii?q?y6FbYJjAYlpeicPgVVEgTwLgkcxPoJhAoEnOYNbgmmCKIEWjRaUCFJ4HANZL?=
 =?us-ascii?q?AFVExcLBwWBIEMDgQ8jDzwFLR2CDYUZH4FzgVkDAxYPAYIkgV4cg0KBI4RJK?=
 =?us-ascii?q?0+DIoF/TBlBg2EeBnIPBkdAAgELbT03CQsbBj2Yf4NvgTsigSMMYMY6NAeCO?=
 =?us-ascii?q?IFmgWQMii2VOwYTL4Nxk1oOBpMCmQSOB5sxgX8jgVwzGiSDNk8DGQ+OIRklg?=
 =?us-ascii?q?0IztyZBNTwCBwEKAQEDCYVGAQGKMzSBSwEB?=
IronPort-PHdr: A9a23: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
 ZBIRrIJDDQI
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:MBdl56sgQ/wcKT8YcwsZxNJZ7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:fcHaBWFRxwqbgImeqmJd+RFPFM8pbkHij3rQfxScD09xWeWsHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AdmUTPwwCPeaPO4c4YIzunej67p6aqP28Bwc/lJQ?=
 =?us-ascii?q?egcOJEih9a3Sjry6ITIByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="118906797"
X-MGA-submission: =?us-ascii?q?MDGUpeyvsBDnjlhug3xY708aoPWPISJ7DXvoHn?=
 =?us-ascii?q?dJgVx6hbDHXAXAK3dRfBclj6IZsZ1UwWVYF1cw6ZA7ItXdMrsdZYtwR3?=
 =?us-ascii?q?kWPe7vImFujFHRHQygcnkSyoEHNA17Z/gk5Dm95y7GaHudbQcfz7ZOxb?=
 =?us-ascii?q?Vv33pgfW8PPWfgmbMG7KehIw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 16:23:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749738207; x=1750343007; i=markus.elfring@web.de;
	bh=1AHPpjHt1Cr4PyEO5tisGJE4vMZeMsGS5eu1rpr/RH8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RH4/dHCANVt0jsxUhtexDEs41VdimTDID/Y5fvhD/byupQuChxTOcCn7EOF0HHMv
	 t/u/sW6EZETyrpuY8tecaIZcb8GR/w5KvL30N0uALpLAPPFi3a5UPV0yImlkjpYP6
	 XgQzj6T/aiSNfu5nOynRFiQ9/tdVdgewgRzfRpkvyTRMFRT/+OjohFwZxss/WVZLG
	 hTHFioLlvcN7FFHgedTjAA+9cxVvXeWj9JkPK5RAhd2Oi3yOmbUMYw6sSfWHR6mzm
	 mh11AGAKWliP8yHyzqBRVVznxaCxTJnUw2cUPyrRhCWYOGkq1uXQnRig3qenha1yy
	 /I8yamPxE7hS/YrL0A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.213]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJWoU-1u5rZG4AkS-00UWGN; Thu, 12
 Jun 2025 16:23:27 +0200
Message-ID: <9c9262a2-022e-4574-b951-e96bd2cbc642@web.de>
Date: Thu, 12 Jun 2025 16:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <90822099-5434-4421-a611-785511926ecb@web.de>
 <alpine.DEB.2.22.394.2506101739440.4658@hadrien>
 <9eeab48f-1bc7-4395-b998-6a49330cfc2b@web.de>
 <45eb943d-1ae3-439c-8b05-7c355a54c48d@web.de>
 <cc827ab9-6e22-89f2-2e79-a844c7e1f1a2@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cc827ab9-6e22-89f2-2e79-a844c7e1f1a2@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L7OE92eIFjCJZRnYspNLvLy+dVZH5YEKsjwfxXy++oJ/RDD0Xbx
 IDHIwOp/Yk9Q7Mq8M7CEwpa3ORhlN5+Bg2pK8bC4yXpfXUsS32/kdiMo8DNQiH2Hv6OyftH
 ZwCfxfdhswemCx91ZaC4Cm22XjnFvmhkTMcSkpa3JvvT5rBMp3EzZzzHypoFghA+1/fjaDA
 FICbmCRWcX5lOrv1X0TSA==
UI-OutboundReport: notjunk:1;M01:P0:NQ1Q55RnR1k=;Sb5QjSxvtRQOwd0nzwS+q5q+8Jv
 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
Subject: Re: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2779
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/9c9262a2-022e-4574-b951-e96bd2cbc642%40web.de>

>> Would you become interested to clarify why I do not see another search =
result here
>> (while the program =E2=80=9Cspatch=E2=80=9D would still generate an exp=
ected diff output for
>> the selected directory)?
>=20
> I have no idea what is the program rg,

See also:
Make program selection configurable for =E2=80=9Cgrep=E2=80=9D
2023-02-04
https://github.com/coccinelle/coccinelle/issues/299


> but the problem is already fixed.
Which change would you like to point out here?

Regards,
Markus
