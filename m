Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8497C35FF3
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 17:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JVjTEZHE5H6jLrjFhZjjyEzb+JFJiZSUsTMko0VyzVI=;
  b=X1SWI1Uq6LcbKUX/N8vAZrmpo8njPFZr8SC1jFGtulcAQUyNFP+7jEMb
   wCpB1qbPRVwtdCg6UY9QcPMiQCfbylH5GfOKu98OAxB9cmFrDevmicPPU
   VsUGa+1QIGG1/GSdchPGc/T07jCSrCR5QHu4jPAy0iXcgwkffUruiaz3r
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213558954"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 18:43:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B2F35E0D1E; Tue, 18 Mar 2025 18:43:40 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E9A4BE0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 18:43:35 +0100 (CET)
IronPort-SDR: 67d9b0c7_qRLv8G4KppzWsNpjchiYGCF9Es+D6piDT9Q1focSdBKCD7o
 L95H3lkh2CWHVo+WG06M6s9uWYrArEQ8BYBTuuw==
X-IPAS-Result: =?us-ascii?q?A0G7DQAtsNlngAMP49RagQmBU4JEYnUzBAtIhFaPUIF0M?=
 =?us-ascii?q?IQ7hzuHU4h1g1QPAQMBDUEBAgQBAQMEggyCdAKLIAIeBwEEMwYOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNgmIBgSSBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAR0CR0QBAQECASMdAQERJwQLCxoCJgICVgYBFAEBgn6CMAEDD?=
 =?us-ascii?q?iMHrkyBMoEBggwBAQbaXB8sIleBZQmBGi6FbYJjAYYnhDwnD4FVRIEVJwuCe?=
 =?us-ascii?q?D6EQ4NbgmmCM4RDZ4lRiFaHVJAvUnscA1ksAVUTFwsHBYEpQwMqNDEjgSIFN?=
 =?us-ascii?q?DQOOCmBY2lJOgINAjWCGyRYgihqBAWBJII3hD6EQYVQghGBXQMDIgGCMG91H?=
 =?us-ascii?q?IMTNXY+hGQtUIF8HUACAQttPTcJCxsGPaNihVMbyG80B4I4gWaBYwyfXgYTL?=
 =?us-ascii?q?5dGDgaSfS6YUCKpEYF9JIFcMxokgzZPAxkPji0WhAu1IEI1PAIHAQoBAQMJh?=
 =?us-ascii?q?UYBAYpUgUsBAQ?=
IronPort-PHdr: A9a23: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
 D9hbwVSo7fW4S4K2p2X/kRe43AjIeTWw06k
IronPort-Data: A9a23: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
 FUI
IronPort-HdrOrdr: A9a23:5yRh+ajKJHyr2Tu/pGVVp2YVkXBQXgQji2hC6mlwRA09TyXqrb
 HKoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhWYtKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AOu5yU2ho0amLGZGKYyTsS2VQQzJuWH7NnE71DmG?=
 =?us-ascii?q?CIkFJT7DNW2/K2aFBup87?=
X-Talos-MUID: 9a23:xgBwiQnBvmrYbRSQjSzTdno6LZlk+rjxVXsRmKk6v+KKKDdOGzKk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="111943318"
X-MGA-submission: =?us-ascii?q?MDGmc9k3pcTK6v4rF0y5RmE1m/zquUrgRA3AIG?=
 =?us-ascii?q?3netqX6Eez1LEKvJ+4lEi/73TEMtEq8gJhKU14OuEayJZu3Oj22wYI9X?=
 =?us-ascii?q?Vsuj2qIU2BmStm9h8+fg+gizLqUsOjrx3jYvIaNqvhhWnLx6Y5T8cYT6?=
 =?us-ascii?q?Gsm6mqs8wNVKyeDxajGXIBDA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 18:43:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742319814; x=1742924614; i=markus.elfring@web.de;
	bh=JVjTEZHE5H6jLrjFhZjjyEzb+JFJiZSUsTMko0VyzVI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lj1d5603TC3bpTK1hxh7MEb0O0iSkiYIkYMBK2ubKS9i0aDeeI0Qy6E4VQY4UkLU
	 NR3hLN/JBBR9+X7NzT0RidvH9hvMVJ2IRgf2gFugfA5vfMTul7oc4ifwJpwuUPRqr
	 3abZW1B+nBsIqtM457p+hUuAnpHVjc9mZst53J6vNbYbK+5HeASwmGKNb1GY2Ijer
	 zV+cyRYoyecBLKS4CXBkwLrweDgbusb6YxPGrBP1xA82aOdL7QoAOCmxLApTGZoCp
	 6WQUf8mFAyGicajRIYLxD4upD1h6t8+ZUUgtcdsUWgxHBqXGRj+l0tSKMuCLhc6Hv
	 +d3wN1+fT8Wm7B0MXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.69]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzCA3-1szag10MpX-00xoDO; Tue, 18
 Mar 2025 18:43:34 +0100
Message-ID: <d8c968f9-db1e-4127-86dc-e9c42abf0806@web.de>
Date: Tue, 18 Mar 2025 18:43:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kees Cook <kees@kernel.org>, cocci@inria.fr
References: <202503171135.B1CCC51FA@keescook>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <202503171135.B1CCC51FA@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z2ZHVHf+AGFeruifybvGPe7sneiIYxYH5geU9sESSkmS/uZurn9
 W9VjYz1GHFYqtr62bY3lOs0OwkxQ8m6Y4E6/qGUuSZwI4jlacnOmpjPyJLlk8ll/8lqQzXd
 cX/uCXIHl99ZczaDzudxZ/DmWHd85RVTtgKGc5Jjb4m3w6Ez/I2BG1ypQX9dFtuBwML+JwV
 1pirsF2BS6hnF/hWBor4g==
UI-OutboundReport: notjunk:1;M01:P0:yuLXlhmu0kM=;OjbS56RRc7S+yExDF7HOfm9oLX4
 nJ0EjnJEGUhRTrMGYJB67KEvmXU9VXqQr2JlQZAYQyC7zJ7w5HeAbydgaTCWvHR6FL4jryvKl
 SQaFccrxdha/sOEDuaBBL31Kx6p47t0lRjuBHyGz2NpiggUrmXA934xdEw2i0Mtx3utVBq1VZ
 yP9Qn4f8Fbn18CkIoWS6yi0eylAbwcZY4/OlZ4k/p32YZTO2F9B6fIYEA7Lvr3qghUCOrBNG5
 h8ojjrKkK6Z656lo5yAx561/7Lu3dOq3rkXyVOCgHjBq9y27Pin8Etf1Sgz0Ehz6y69uWrwe0
 wlpJNcF3vURo5h/BpjB2zVpL8K+uksQ7SkqLC3OgtajoJ8G1UmUc9GYHTK981g3YDDevYNBrm
 g7FxPYeB1Y1vKWd2fu8AynjekndTVY15RXMVf0rwj2VyKqGM1tIwoeiHhK9Sm3OttRdB4R9TT
 Pri2wFad6h/Dkc94mao0/wLGjkR3CJwO8bTXNMnSXtrxHgl54S7Wu7Xykzm9imQwdKoYrNDJp
 Z74TgAKgoosI/QZdshCTtyY0wS5PvVUR6neisdmzrLf8UZWx08YVJGciiNDX1nRfPew+jSBL5
 tC/jGjj44T6Kt9YbaaEIArVwlZQZl75Yfx92TtkU53Hd0PtLaSIJKfNp++8pOX+ZX9AAVAGWK
 1/R9ahopFeGcP0OL0RG09pz1+6FKnI6zB7WNaJthhuvohftSlqy2bZXUQQ5BtZFe/Kku0lft2
 w2kg9G3f+QhXDtMb5Cr7ARMWU68Vsxqw02NZrpaWf/+01i9YnQ/uqrg1ZVovoGWro9+D8y8KJ
 3Vm5+x3VsyMv4XcPZ937WQVYyiSwNAmeSMfxdJ9Tv0/XeFy9gPHsA4sqqChOFvP9vNFqkchY0
 bgXeIo8nMxHL+CBh8wpWgmB/dkvdborc38SkFTZ4D36wiJa4tFpl3ar4oG9nhQoRSuKHFk4FZ
 E0iEkgXovPnUb9IQwNEGOTR5/8uojsnLXmu9Lx2WC/skKp6V6BUU5tAMh/iHBnhNsE9I2sOjr
 hDCgwblxP+gZhhENK1k3Kaav6Z4wzSRrZNvWmGdQHU7bVPM1pJ02L/nlnQgnyZ7z1kLyE5EvC
 F2EiXVA07wWaqdvtAJQF+oYuTUQ+/+CQbSQV9X8n8hpOTKZobHdgkAmlVHAg3l1m9vX5ohOhz
 jRG+2nz50yUIugs+2qnkz2ichMpEa/ymT0casM/B9fgWUUMrYRUGJEzuXoJd1Ig16QF+BOLdV
 pLHBLjHPkbsVwgWP95f3/pDaUQhHYq2kLteKAP+yThu9h9QWkrzUiDPCWCJZgIt+hrwDECN+Z
 +rCqMu8GG97Y/7KCvLyKkr6pI36v4YZ1S6lPKlT3Rpi7/IALy+66ofKlxc549aJCUHVhXR5qP
 nN3nFWGfuDk67jspNMucVN2bsFATlUyjzQAbUgRELm6tpHB4vi2wYOsbHAXY4uSXEHMdM2kB1
 x4P2fPqRiWYIrEO+9q8yEJgZk71CROjqqYD8Somnmw/ICqlQZpYFwXigkmwayB+cmNRNakg==
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2628
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/d8c968f9-db1e-4127-86dc-e9c42abf0806%40web.de>

> It seems that the mere presence of the "__free" attribute breaks matchin=
g:
>
> $ cat test.c
> static void why(void)
> {
>         u64 *rates_64 __free(kfree) =3D NULL;
>         rates_64 =3D kcalloc(count, sizeof(*rates_64), GFP_KERNEL);
> }


Questionable test result (with the software combination =E2=80=9CCoccinell=
e 1.3-00083-g4093aad2d=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --parse-c=
 example_by_Kees_Cook-20250317.c
=E2=80=A6
BAD:!!!!!         u64 *rates_64 __free(kfree) =3D NULL;
=E2=80=A6
maybe 10 most problematic tokens
=E2=80=A6
NB total files =3D 1; perfect =3D 0; pbs =3D 1; timeout =3D 0; =3D=3D=3D=
=3D=3D=3D=3D=3D=3D> 0%
nb good =3D 0,  nb passed =3D 1 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 12.50% passed
nb good =3D 0,  nb bad =3D 7 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 12.50% good or p=
assed



> $ cat match.cocci
> @replace@
> expression THING, COUNT;
> expression GFP;
> @@
>
> -       kcalloc(COUNT, sizeof(*THING), GFP)
> +       kzalloc_objs(*THING, COUNT, GFP)

Would another SmPL code variant be occasionally helpful?

@replacement@
expression THING, COUNT, GFP;
@@
-kcalloc
+kzalloc_objs
 (
-COUNT,
-sizeof(
        *THING
-      )
+, COUNT
 , GFP
 )


Regards,
Markus
