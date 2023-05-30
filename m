Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAE1C7EE2C
	for <cocci@archiver.kernel.org>; Tue, 30 May 2023 12:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pQ3ev6IqO9AClfyiuoIcO7a3sO8Qzq6ryqsLx3ttdxI=;
  b=nC0Cf/vYjvwqbRzM8+6tlh5KGWqtLQGxDcQYJoa8W/+wtR2Es+oHJNDZ
   Z0Qr1cx8P3C3pLtrAW9lVFg0LMIQJm5QoAYP2W8IeJgkUgsnikPerAP7h
   tSgdSEW1u0YWBZaVvrCQntMfGPY8gGxCyjNRRxoGok64TV6PRnU6QJ9G1
   c=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.00,204,1681164000"; 
   d="scan'208";a="110279105"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 May 2023 14:22:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E4D28E2697; Tue, 30 May 2023 14:22:55 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 45EDDE0090
	for <cocci@sympa.inria.fr>; Tue, 30 May 2023 14:22:55 +0200 (CEST)
IronPort-SDR: 6475ea9e_Op/dJ+5N+4K+lSvgYid6rBLTS7woPBmTwaPFdTYNbNK224z
 BG0VH8IzktmtR85lwpqCv9XrBd/Oeyz9RPRpvBw==
X-IPAS-Result: =?us-ascii?q?A0FYAABa6XVkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYIueFMwBAtHhFKPGYZahzCHRIhqgVaBQD4PAQMBDUEBAgQBAQMEg?=
 =?us-ascii?q?UyDMwKFXQIdBwEEMQgOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBA?=
 =?us-ascii?q?hABAQEjFwcOECeFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?gJHPwMDIx0BAREmAQ8LGgImAgJXBgEMCAEBgnqCKAEDMQeuQ4EygQGCCAEBB?=
 =?us-ascii?q?pwOHywiVYFfCYEVLQGMakKEMScPgVVEgTwMgng+hESDW4JniTCFD40kgS9wg?=
 =?us-ascii?q?SGBJ4ECAgkCEWeBDghmgXRAAg1VCwtlgSNVPYFHAgIRKxMUBUh8DgERAwcEA?=
 =?us-ascii?q?oEHEC8HBDIJFgkGCRgZGCcGVgctJAkTFUIEg2wDCoEjNSUEDgMZKx1AAgELc?=
 =?us-ascii?q?D01BgMLHwYmAR4CK4FYBC9aeSgkn0OBQnLFSTUHgjCBW4FdDJ8bBhMvg2yTJ?=
 =?us-ascii?q?Q4GkiuYDiCoEoFkATiBXDMaJE+CZ08DGQ+OIBmEDo9IPzQ7AgcBCgEBAwmFR?=
 =?us-ascii?q?gEBhX4BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:tPhME6/8ITPaLr06yNpuk+DeI+orL9Y04lQ7vn1ZYhZeG/bo8f
 xG/c5rsiMc7Qx6ZJhOo6HiBEDtexPhHP1OgLX5X43SPjUO0VHAROpfBODZsljd8kPFh4pgPG
 RbH5SWyuecMbG3t6nHCcCDfeod/A==
X-Talos-CUID: =?us-ascii?q?9a23=3ADJULHmtaCC2LazIJRg4GNqSO6IsoYlLP6HvUG3a?=
 =?us-ascii?q?YSmhHVLvIaX+x/6Brxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AkTB2YA2VryrBdn/z9MU9L18x2zUj/L+wBEAqz5A?=
 =?us-ascii?q?6oOaPJydvMDKsnSa+Xdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,204,1681164000"; 
   d="scan'208";a="57336760"
X-MGA-submission: =?us-ascii?q?MDEaCnzz91YePePAZKnV01ffYPqdCBP8fWHWKi?=
 =?us-ascii?q?+jswQiWYk6ks4YdWzjs16dAWm17W++4tOfKQyprs6+UPddxmV2VRqi9M?=
 =?us-ascii?q?LPriYXxptLkJkNWylVLsP3dgncc6SrKrwO2EYt2kaAODHhkIhpaYN6IP?=
 =?us-ascii?q?fcL2aOFSlq0J5Kbiq+Up3y/A=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 14:22:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1685449371; i=markus.elfring@web.de;
	bh=u2uyHe4HjtLnsBoFhna5b12U5BhRw9TEDlnLPf5v4Jw=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=rzC/Go+OZDPacecOIQ58cZnWAlD1GHRKb1UFxFWJKfDDTzwGZtT7rpHyGxooUKgGS
	 yGcci3jaj0rIMHvWo1E+Smo1yII4KRNcbT6VdarElDS7l9GPK0QHgKytI30bBuLVtJ
	 t/k5SyLK903VMhVmJ6YgpliBRMqB2AQTHX/QlZo1SydxEf0bRxJtNKvWiDB2RRwQ6q
	 GqqmhcziEvr9gnS6Uu/FsoJ4BpkX59vFlwBtNU+2farTO46n7ygqh9f3XLtD7WzK6u
	 52uPDyFtP7YwdO6T3Gtfqc8mbbMBe3bwztG4O6Fi2yG+Aym1aX/WvGnA8gJD/Lu3IT
	 jcCiTa1x6dNTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlLA1-1qV1Ko0XsL-00lSuq; Tue, 30
 May 2023 14:22:51 +0200
Message-ID: <f16a66f7-460e-3577-ec5c-e4ccf00065f2@web.de>
Date: Tue, 30 May 2023 14:22:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-GB
To: Claudiu Beznea <claudiu.beznea@microchip.com>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <20230530074044.1603426-1-claudiu.beznea@microchip.com>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20230530074044.1603426-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kLw6fw39GrriARp2j0LdPQ+3OIoK8Ti4FUpT8UdaF9JnIM3NyDd
 dgiyKUuIJx9P+Mi/14uoPozsTtcgXyZ81r6hROLYLdThQcOJJRHyykEfOfwJ0ka869GpSl2
 pJiQvA3+/be/k/7gE5HLYyoOmltEruwX3qn8ucbXL5w90EG4A1biUDyhLHGnDN2hU6lxmpG
 1kqWdEvC5X3/kkjxZXHGQ==
UI-OutboundReport: notjunk:1;M01:P0:w7JtAJk0h50=;RxFn3mkosxzbg9Oi+RVWF6Fd3KS
 NqlEvZ9+P2nP/f82JEI2Vt7vwQjPWnT8Iu8WCGJi/xKQulQYCXohv/gZE/gvgHBrRi+apxUWl
 iysTc/xNo/WSYw5HKWL2uGsScmwi+7KIzTl0QP7LHzR+/ODolI1qVCtLMi+oQ1MC331EX+MKp
 XGldjQh3RFxLac5cLpQfBzucK0x9Vtm+5B3CiLSyzZ611ZI9/9fkyrf1BnINDZHi+bh8yWuwc
 dwjOOOgLGRu/V0M8HJejAdQxDV10I4TPfkXSNRIzKJvg1jJhTLZ88ypNeB2t2NbMtI8HGTHwF
 LJSAOo2CFsbYrlQ0EupssSg4ZNkSMepuRPfHKGzYUB3+HFLi83hQWXOkRsYPMYbpRm8rFywmo
 tLookBFnHdhHDT1ytfc/vXE6j/cjLvDkFltxbra7NB7Wph92G3kWml25Ro9rWXnPA8b9Yj5T4
 1reSGBMvKUsZ51J2NY29yHygyTA+dqqgFSSDjvfjwNxpg9CNT5T+39XQ7txB6SZjzpEgwr2wX
 hQ4GIjP9WnWHwkBkocnVs12yMkZqTf79rDew21uaWr8dMEEd3W7dTjpnlCqxfnRSGXTbMg1ep
 NEX4HbLShuoT8UxDgsAAQYo5nklWNqRQZUiWcWbqB2PpXsm7LD0zU5tZisvf7MbAHdy3V3tTK
 8akE/UPKpYlbAMazXHQdlpeihWIp5+8N5QZDFyBLW+My8LO3TFMHtI7ozghGYi9tznNK41Zlp
 CVbgnNT7jjT2+HjKa1RFX29TCzwPx7X60lE4G2ZUahFKZjqpQzlwaatcYI7OfBg9AXiZTQw5i
 ftD2i5Mkt9QzpkNDTg30tF3VQrmDmev7k31mdsNGKf9fwAdSWntg/lZkCX8az2iUdd4XDTolQ
 FqTzOP5vvsG6QIfgSjNB2OPOMOmjWM3sQMq/be2Uxo5lo2f0iR1qGGAX6OWXdZMRa+v2zT1gx
 9OJf2g==
Subject: Re: [cocci] [PATCH] Coccinelle: kmerr: increase check list
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1162
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/f16a66f7-460e-3577-ec5c-e4ccf00065f2%40web.de>

=E2=80=A6
> +++ b/scripts/coccinelle/null/kmerr.cocci
=E2=80=A6
> @@ -51,7 +51,7 @@ position any withtest.p;
>  identifier f;
>  @@
>
> -x@p1 =3D \(kmalloc\|kzalloc\|kcalloc\)(...);
> +x@p1 =3D \(kmalloc\|devm_kmalloc\|kmalloc_array\|devm_kmalloc_array\|kr=
ealloc_array\|kzalloc\|devm_kzalloc\|kcalloc\|devm_kcalloc\|kasprintf\|dev=
m_kasprintf\|kstrdup\|kstrdup_const\)(...);
>  ...
>  x1@p =3D f@p2(...);
>  if (!x1) S

Can it be nicer to specify desired function names on multiple lines
for such a SmPL disjunction?

Would you sort them according to their call probability?

Regards,
Markus
