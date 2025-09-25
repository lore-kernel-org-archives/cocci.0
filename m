Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CAFCAC5A7
	for <cocci@archiver.kernel.org>; Thu, 25 Sep 2025 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=06Rk5hx4rBoiZk1a/BE38euS1iIEAjuVsTnbFIfdpTQ=;
  b=mmx3X112OM9upaHfPsoiem3/sKFtNLOhhCxj9yVycrgBKkVxiL+pzbGS
   172JwhGrX/TYZi8rU0GYS2ypBfOCKsmIKu8ZlwTHg+1V5j+Ud1mhBcmhj
   ovLfWYeTi0mPxNqDCPQIbRerA+TYnvZci1R1Tb2EKQ1LN3KS0SMSiXPXc
   c=;
X-CSE-ConnectionGUID: XIEpix4cTsClVzFgHdUpjg==
X-CSE-MsgGUID: sJjPocjxRbiws2JJ0tkRnQ==
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
X-IronPort-AV: E=Sophos;i="6.18,292,1751234400"; 
   d="scan'208";a="241055792"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Sep 2025 17:08:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DCB45E0BE9; Thu, 25 Sep 2025 17:08:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3830CE0171
	for <cocci@sympa.inria.fr>; Thu, 25 Sep 2025 17:08:16 +0200 (CEST)
X-CSE-ConnectionGUID: Kd8RacreRp2yMw2Aa+lDvQ==
X-CSE-MsgGUID: 3g8BazkXRf2RA4RYc++JKA==
IronPort-SDR: 68d55ae0_CkCnYOe8XwYQ8O94KGGl8BXpFTNbcxH48SQwF6+aROjVHiZ
 WzNGxPdtgPWki/DeHc9F5JlS5jQ1/0HlQPE/xmw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ENAAC0WdVogAwR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFABAEBAQELAYI/gQIGVDMEC0mEVY9Qhl+PEYh5gVWBfQIPA?=
 =?us-ascii?q?QMBDT0RAQIEAQEDAwGFAAKMRAIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBAQEBA?=
 =?us-ascii?q?Q0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NgmIBgSSBJgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAkdEAgEDIx0BAREmAQ8LG?=
 =?us-ascii?q?gImAgJWBgEUAQGCfgGCIgEGEAEDNQcNt0mBMoEBggwBAQbaXx8sIlmBZAMGg?=
 =?us-ascii?q?RsuAYVrgmQBhWw7hDwnD4FVRIE8gwM+hEODW4JpgiaBFoNYjFmNQlJ4HANZL?=
 =?us-ascii?q?AFVExcLBwWBIBAzAyAKNDECFA0QEg8EFgUtHXMMKBJlgweBDYNZRStPghxyg?=
 =?us-ascii?q?QB0PhlBg1MeBmsPBoEVGUkCAgIFAiwXPoFrBQEcBh8SAgMBAgI6Vw2BegICB?=
 =?us-ascii?q?II0gRKBBEACAQttPTcGAwsbBj2XdWIIhAeCDi86kn+DGAGvazQHgjiBZ4FkD?=
 =?us-ascii?q?IoulT4GEy+XUg4GkwUumFgijWaWGYUggWoDNYFcMxokT4JnTwMZD44hPoN1g?=
 =?us-ascii?q?QuNfwG6O0E1AjoCBwEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 PDbq11z6BJidNIxf2tcQYYOcH47CpXSpg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Z2U/razXVE8Q079SLV6AKrPxKugkLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9IYgBapTiBUJPwIk80hqQFm7X5XI3SFzUO3VHFEGgM1/qE/9SNIUzDH6tmpN
 9dmstFeZfN5DpB/KDHCWCDer5OruVvsprY/Ns2pE0dLz2CHpsQizuRfTzrd3GeKjMnObMJUL
 6nouZXrTupfnoaKuy9G3k+RuDG4/HbiZ78ZhYCJhg/rC2Dlymh5rLWGwWRmk52aUIC/Z4StU
 z+1yDp7KSqtP+2jjfaym/o9pxT3Pfx19dZA8SIq84NbhHhkByhaohNU6CL+Bo1vOaswlA3l8
 SkmWZsA+1Dr1fqOk2lqxrk3AftlBw07WX59FOeiXz/5eTkWTMTEaN69MxkWyqcz3BlkMB30a
 pN0W7cnYFQFwn8kCP04MWNfw12l3CzvWEpnYco/j1iuMolGf9sRL4kjQFo+aQ7bWfHAUccYa
 1T5fTnlbVrmJWhHjfkVydUsZqRtz8Ib2q7qwA5y7CoOn5t7T9EJgIjtbMit2ZF+5QnR5Ze4e
 PYdqxuibFVV8cTKblwHeEbXKKMexrwqD/3QRavyG7cZdY6EmOIr4Sy7KQ+5emsdpBNxJwumI
 7ZWFcdsWIpYUrhBcCHwZUOq3n2MS2AdCWoztsb64lyu7X6SrauOSqfSEo2m8/lp/kEGMXUV/
 u6JZoTCf7+KmnlH5pPwmTFKtBvAGhbVNdQtscwWlqIrM6OIor2tvbDePKWP7bpGSZMYBKLPp
 LCZkmAGCxt1DHaZpajummuZ5rEQD2PwbtgVLTG8/ka0swDLYtJ9gQFjz2Cl7K2FQE=
X-Talos-CUID: 9a23:7dWTtW+5dVEId61KeWCVv20YSvoseWfQ9m+KMmqnU09gC7m5V2bFrQ==
X-Talos-MUID: 9a23:lsvEqwX+dIhdmdnq/GTj1BtrJsRY2ar0MmlRq6QN+IqmFgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,292,1751234400"; 
   d="scan'208";a="241055773"
X-MGA-submission: =?us-ascii?q?MDH8lOsDkOetXM5kf91PaPuIPJEE1E02wSXUP/?=
 =?us-ascii?q?FIojtY62O8B0Bdm+96OTqzoFsTllT0fsbDfW+reRhzZ3a8WTxZMXOPZT?=
 =?us-ascii?q?a7jkA8IXCje77OIJA7TFDzLvrXiE1vCE5MUf/m1LsrAXohku5EF0jvbH?=
 =?us-ascii?q?AClSICVNfLTSi9XnYA9cH14Q=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 17:08:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758812851; x=1759417651; i=markus.elfring@web.de;
	bh=06Rk5hx4rBoiZk1a/BE38euS1iIEAjuVsTnbFIfdpTQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iGtCWCaVpBt26+JQmVnTnB3hxqP5ax/dEXiMXcYOxtLWqDp2ZkpVB874e1rTj58a
	 HEBRH8DScsYjZyTXmpSlhTP1h8vq0891u7oOLWrtToNJa7eyQ1Pa+YEg6QjcZJ6kW
	 IYwA5jrP1RZkY/iexDpBaIcJuwNifqgu/mi/CBGVTFy3cDcs3+dB82bdYvUDW3wz5
	 iPw7VLjWCVLqyoliIUYU0lsGchcG2pJ2i9h3jQs8S9kLpwb1qCFspVtAjIvFCUpIT
	 Zzvm1sZxI9SnbCsZ/zkkkheEp9/3qUGlIOwTF8siENmOV8o9FLXeiC7AJVQSp9D1D
	 PNBUO08kkk2Kx8/euA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.253]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdO5C-1uSjnX2F1M-00mywx; Thu, 25
 Sep 2025 17:07:31 +0200
Message-ID: <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de>
Date: Thu, 25 Sep 2025 17:07:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
In-Reply-To: <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7mgn5Iw3/ePGX0b5l1Rpa0nZNxgsv4lo29NVxcWljgubZrqWgSS
 /Bw+kJ7wL0a45cMgHIJbYJKRt29S/OQujATXl8eUD/7E/1mmtbTTZat7h67XaorOKtKgj4R
 O+AzXliPdhVd1CepRRvkycnU9mzzoVwzYfqi1GQtvvX1VY9Ze1g4b0vz26UFMxyUQk3z+Ds
 mA/Tbt/40Hjms3osleeWA==
UI-OutboundReport: notjunk:1;M01:P0:Ii7A5UxXGI4=;qS3BL0sQ1f5u9keu6QEwPh/mebq
 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
 bDsxw==
Subject: Re: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR()
 to %pe candidates
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3041
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/48a8dbb8-adf1-475e-897d-7369e2c3f6eb%40web.de>

=E2=80=A6> The script supports context, report, and org modes.

I suggest to omit this sentence from the description.


Will the hint =E2=80=9Cscripts/=E2=80=9D be omitted from the patch prefix?


=E2=80=A6> +++ b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
=E2=80=A6> +// URL: https://coccinelle.gitlabpages.inria.fr/website

I suggest to omit this comment line.


=E2=80=A6> +virtual context
> +virtual org
> +virtual report

The restriction on the support for three operation modes will need further=
 development considerations.


> +@r@
> +expression ptr;
> +constant fmt;
> +position p;
> +identifier print_func;
> +@@
> +* print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)

How do you think about to use the metavariable type =E2=80=9Cformat list=
=E2=80=9D?

Would it matter to restrict expressions to pointer expressions?


> +@script:python depends on r && org@

I guess that such an SmPL dependency specification can be simplified a bit=
.


> +p << r.p;
> +@@
> +coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print PTR=
_ERR()")

I suggest to reconsider the implementation detail once more
if the SmPL asterisk functionality fits really to the operation modes =E2=
=80=9Corg=E2=80=9D and =E2=80=9Creport=E2=80=9D.

The operation mode =E2=80=9Ccontext=E2=80=9D can usually work also without=
 an extra position variable,
can't it?

Regards,
Markus
