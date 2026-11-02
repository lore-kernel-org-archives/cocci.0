Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDA7606A332
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=jC2CEehS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ns1CwBUJxze9256gcbwyclT1GC4r57u33UNeieRrAs4=;
  b=jC2CEehSRofPu/kkyEl4cHHywgZ7QyiRr6g0OFlDoVKLrEEo69s7gRsd
   UaGZoVgLNZmf021QDUk5DFUNY0uStyqS87CBmIC6av0PFrnU3/Bi+wQAI
   3RkF69xreq2paaqn+kYfm1I9Z/jMDJO7vjklttyYjKKeX7gYOLZg2/53k
   s=;
X-CSE-ConnectionGUID: M+Qyr52cTmep1buRgtepEQ==
X-CSE-MsgGUID: R5Tc9EnZQaec+2UUCkzNQA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304323427"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:21 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1756781ACF; Sat,  7 Nov 2026 11:59:22 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 93E1881273
	for <cocci@sympa.inria.fr>; Mon,  2 Nov 2026 10:34:13 +0100 (CET)
X-CSE-ConnectionGUID: /Ao/vyPPSuivCMcWlRBtFQ==
X-CSE-MsgGUID: b5v5CnLISx+ad7VqIg+czg==
IronPort-SDR: 6ae85914_N23pMFsZNEGRmjpse60M0kW27KSPCe7VCFoSXZ6/zH9JBC/
 33lNGCEQ1VoIUyuMYDNPUsPyQsgKzJzcolDccuw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HDAQDeV+hqj07ASNlaHgEBCxIMggULgkGBC2A0BAtJh?=
 =?us-ascii?q?FiDT4wEgiEDk02IfYFVgT89Ag8BAwENNxcBAgQBAQECAQOEfgKOHQIeBwEEM?=
 =?us-ascii?q?gcOAQIEAwIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBAQI6B?=
 =?us-ascii?q?Q47hk8NjBoBM3FgBz4BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEGAg06RAEBAQIBIx0BAREmAQQLCxIIAhgOAgJIDgYBFAEBgn4BgiIBB?=
 =?us-ascii?q?hABAxAnB7wVgTKBAYIMAQEGgQnZYh8sIl2BawMGgR8uhXKCbQGGNINIeicPg?=
 =?us-ascii?q?VVEgTyCUzE+gmECgWB8gmCCaoImgQyCWIVOA45iUngcA1ksAVUTFwsHBYElE?=
 =?us-ascii?q?DMDKi8tI0sFLR1wDCcSDx0PCBEeWBsGBRIgKkFDW4EZgQddgSspYAECH0YtF?=
 =?us-ascii?q?YF2AoJRgSMCWwIBSUEOB0VTCSVDEkckIggSCQETGiwLgRo1PAkmBD0VDGQLG?=
 =?us-ascii?q?gUaSAgCCwIMdigREBMdICYwBR0mHW09NwYECxkEPZJ3gh1sgUGCPZM4swg0B?=
 =?us-ascii?q?4I5gWmBZwyKMI40hwsGEy+EBE2MR4Y7D5MOHphqI4o7SYJjlXeFQ4FvATKBX?=
 =?us-ascii?q?DMaJIM2UAMZD44iDA0Jg2AzhGDJKEYyPQIHAgcOAwuFRAEBjFaBTAEB?=
IronPort-PHdr: A9a23:JrsaZxNHXi/zxni0N1ol6nZyBBdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDvqsr1AWCBNqHu6kMotGVmp6jcFRI2YyGvnEGfc4EfD4+ouJSsioeReWoMgnFFsPsdDEwB
 89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL58L
 Ri6txndutcZjYd/KKs8xRjEr3VVcOlK2G1kIk6ekBn76sqs5pBo7j5eu+gm985OUKX6e7o3Q
 LlFBzk4MG47+dPmuwDbQQWA/nUTXXwanwRHDQbY9B31UYv/vSX8tupmxSmVJtb2QqwuWTSj9
 KhkVhnlgzoaOjEj8WHXjstwjL9HoB+kuhdyzZLYbJ2TOfFjZa7WY88USnRdUcZQTyxBA52zb
 40TD+oaIO1Uq5Dxq0YSoReiAAWhAv7kxD1ViX/sxaA00OovHg7I0wI9AdwDrnrUotX3O6gOX
 u6417XIzSzZYv9KxTvx9orFfxY8qv+MR7Jwds/RxFEoGQzflFWQqpHlPyiI3eoCt2ib4fBgV
 eOpi24otgp8pT+hyd02ionKm4IV0UrI+yp9wIY7P924SUh7YdG/HZpeqS6VLJF6Td48TGxxv
 isx17IJt4KhcicQ1JQn2wDQa+aBc4WQ4hzuVuKcLSl3iX94dryyiRa//0evxOP8Wce5zFlHo
 CRFnNTMqH0ByQLe5MabRvZ+4kqs1zWC2g/d5O1aPUw6m6zWIIMvzL43k5ocq0XDHinulUrrj
 a+WbVkk9fS05Oj9ZbXmvJCcO5d7igH/LqQumtG/Dv8iPgcSWGib/OKx36Dg803hWLhGkOA6n
 6vDvJ3YO8gXvLO1DgtL3oo56RuyDDGr28kCk3YdNlJKYheHgpDpO17QJPD4Cu+yg1GrkDd22
 /DKJLPgDYvWIXTZjbjuY65x609ayAUt0dBS/4xYBqwDLf7pWEL9qsbUAgI9PgCq2erqCtZw2
 psbWW2VA6+ZNK3SsUWP5uIqO+SCY5UauCz+K/g4/P7il3A3mVsTfamz3JsXbn+4E+9oIkqHe
 nXgmMoOHnkSsgokUOPqkEGCUSJUZ3uqW6Iz/D86B5iiDYfHXY2sgb2B3CKgEZ1MfG9KEFGME
 XHyd4WFQfgAciySItV5njweSbehU5Mh1Q2ptALi17VnKfbb9TEZtZ/4z9h05+jTlQko+jBuD
 sSd1XuNT2BukW8SST82xrhzoUpmxViby6h3n+RYFcBP5/NOSgo2K4bQz+NkBND1WQzPZM+ER
 lipTNm+GzE+UMwxzdwUbUtlHtWiiQ3D3zawD74bibOEH4Y4/b/C0HTpOsl9yHfG1Kw5glc+T
 cVAO3OoiLJj+gbVH4LGjkCZmLywdasAxCPD7H6Nw3KBsk1ASw5wSavFUGgFaEbKsNr3+1vOT
 6S2CbQpKgRBydCNKq9NatDxlVtIXe/tNtuNK162zkWtAReBjpeFc4Pufy1J3jjZCUFClwkM9
 HKCHQk4HCao5WzEWngmHlXkaELE8O9kqXr9QFVwhx2NaEl6/7m44BgYgbqbUfxA8KgDvXIEo
 i93AU318tbYEduGqEI1WaxGYs4mpnpD23jYsQNVIZGqaaxv0A1NOz9rtl/jgk0kQr5LltIn+
 TZzlFIawcOw1VpAc2jdxpXsIvjMLXG0+hmzaqnQ01WY0dCM+65J5u5r4077slSPEUwvu25iz
 8ETy2GVs7DDFgkPStTcVkgt9h51j67XaG8x6tCczmViZJG9qSSKwNc1HK0gwxekcc1YNfahH
 RXxDtZcKsygMu0slHC2YxhCMO0BvLUsMZaAcP2LkLWuIP4mnD+iijFf55th10uX6ydmYuvPw
 opD3PySmAeKP9vlpHGmtM2/2YVNZDVJW3G61TChH4lJIKt7YYcMD26qZcyx3NR3wZD3CTZe8
 xa4ClUK1dXMG1LaZkHh3QBWyUUcoGC20Sq+wTtuljg1r62ZlCXQyuXmfRADNyZFXm5nxVvrJ
 IG1iZgdUi3KJ0AMnQGm+F286qxVvqV5IEHMTE0OcyW3Z2BuX62st6aTNtZV4cBguiFWXeKgJ
 FGCH+Sk/F1FiWW6TjEYm2BoElPi8o/0lBF7lm+HeXN6rX6CPNp12Q+a/9vEA/hYwjsBQiB8z
 zjRHFm1edezrrD239/OtP6zU2W5W9hday7umMmlvTG4+HYsLBmxhfG1lfX4HAJ83SKxhLwIH
 W3Y6Q3xZIXmzfHwFOt9fVRzQnL45dB7HI5WjYY6wp0dkyt/5N3d7T8MlmH9Ns9e0KT1YS8WR
 DIF9NXS5RDsxExpKn/hK5vRbnyG2YMhYtC7ZjhTwSch94VRD7/S6rVYnCxzq17+rATLYPE7k
 C1Pgfcp7XcbhakOtm9Phm24C6oRAFIeECjijRWO4Pihoa8RaGvnfbWr1UV4lMysF/nY+14aB
 yy/I8Z4W3AgpsxkeErBynjy9p3pdLyyJZoIuxuYng2Bx+lZJZQtl+Yb0C9uOGbzp3ogmKYwi
 R1j243/vZDScTwyuv3jREcJbHuqN5B2mHmll6tVk8eI0pr6G5xgHm5OR570VbezFypUs/37N
 gGIGTl6q3GBGLOZExXMjSUu53/JDZ2vMGmaYXcDytA3DjyUPk9Cm0Y5WDsgn5g2Ph+nzortf
 Q0qg1JZrk69sRZKxu9yYlPaW33cuRzuRzM6UpmZIzJJ4wsE60qfYqn8pqpjWipf+JOmtgmEL
 GeWMh9JAW8+UUuBH1n/P7Oq6IqI462CC+G5NfeLfaSWpLkUSaKT3Zz2mNgDnX7EJoCVM3JlF
 fF+xkdTQSUzBZHCgztWAyVFkiXQc4iEqR369iA/p5K69+n3HRLh4pGQAqFed8pi8Va6jMLhf
 6aZ1iN+NCod3JQRw3TFjqcS1hgehmlnJTyqDKhFvjXHUabT3PZeCRJCLSh0Ma4qp+o1jAxKJ
 NKegcj+0aRgyKc8DVscE1fmn4m/bMgOaQlRLXvhA0CGfPSDLDzPmITsZL+kDKZXlKNSvgGxv
 jCSFwniOC6Cnn/nTULnN+YElyydMBFE3eP1Oh9wFWjuSs7nYRynIZd2izMx27g9mnLNMyYVL
 zF9d0pHqrDY4zlfh71zHGlI73wtKufh+W7R9+7DNpMfqudmGAxxkP9Gpms3wf1Z4WAMRfB4n
 jfTss87o1yilbrqqHIvWx5PpzBXwYOT6B87ZuOGrN8ZCCyCo0JeiAfYQw4HrNZkFND17qVZy
 9yU0bn2NC8H6NXMu80VG8nTLsuDdnsnKxvgXjDOX25nBXamM3/Sg0tFnbSc7HqQ+9Ifo4Lvh
 YFIZ7tVTl0zGdsFB04jENFIc/IVFns01KWWisIF/y/0tB7KWMBTpYzKTNqXBujzbimUh/9Ia
 lFbpNGwZZRWPYr91Ut4b1B8l4mfAEvcU+dGpSh5ZxM1qkFAmJCfZmg0xl6jdQ6npnMeR6bcd
 vEelQZ0J+ggpm6EC7IfOVfA4ic9whFZpA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:6wqrKqxLhf0KOVIkDlqwKrPwFr1zdoMgy1knxilNoNJuE/BwTP
 re+MjzsCWftN9/YhwdcLy7Scu9qDbnhPtICOoqUYtKPjOMhILAFugL0WKh+V3d8kbFmdK1u5
 0PT4FOTPD9BkR1yejcpCaiFdJI+qjlzJyV
X-Talos-CUID: =?us-ascii?q?9a23=3AHcYYgmmELNznq68kzbwm1HtQ5hXXOTr0yzDOMne?=
 =?us-ascii?q?AMntoVpawQmCUwol4vfM7zg=3D=3D?=
X-Talos-MUID: 9a23:G5RJrAbd0JEEsOBTvWLy2RpkEOZT8+enBB8ziLQJ+MKWOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,191,1787004000"; 
   d="scan'208";a="161469477"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDG/phZr2hxJXqsGcaK6WZFiaARixmvtesIPR8?=
 =?us-ascii?q?pgzE27JIezR5FqKajRo04iMrlvAfN4WylMv8sItbrY+GP6kQsCS1Cl5l?=
 =?us-ascii?q?u9Uwe3Tw/8GlzLLdgCAr1yuVdVfapGrCTtB+nRnIQ/zRfKctYEMhUsmA?=
 =?us-ascii?q?eYwYtxPvF/PTQ+jvH6636h5A=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 10:34:12 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melf5-1wq8Ag3y6v-00pYmJ; Mon, 02
 Nov 2026 10:34:12 +0100
Message-ID: <7a14fdbc-fefe-4c7e-8b57-3c42b5d1a453@web.de>
Date: Mon, 2 Nov 2026 10:34:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr, tools@kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <aefccf2d-3ca6-4d15-9026-649fb0a0f63c@web.de>
 <b55ad049-86e0-f737-a96a-f3151db5012@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b55ad049-86e0-f737-a96a-f3151db5012@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QWbbZ5y+Q0skZNLqWL1P+CN2/LAG52/P/lCgURyNxWbgfJoqkKi
 X/RdhdOOWQdjthUQCh17gqF191hm+/HQo3PrT1JT6UQHpzJ53UtNYWlgYQuNCgDFhiR/km5
 Z9fD9DVPwWoxbzYhR4HpqT5Gw1RIIXg1JWLOb6PwaGPXCvz9bpBW26T9rNCbN3TlpbQsB/F
 FNcZwFX9a2PEs8cpBWapA==
UI-OutboundReport: notjunk:1;M01:P0:hBeRhHUrv3A=;f1btxB4m5cVqyQjTOFT9Rcitv85
 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
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [RFC] Distributed data processing for SmPL scripts
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3773
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/0Y63I7X91f_ecox-BJmoqA>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>> Some developers got used to tools which support distributed data proces=
sing
>> for compilation tasks.
>>
>> Examples:
>> https://www.distcc.org/
>> https://github.com/icecc/icecream
>=20
> Maybe such things can just be used off the shelf, since Coccinelle can b=
e
> invoked from make.

Did you notice how such development tools were implemented?

How would you distinguish single programs from a service-oriented architec=
ture?


> In any case, I have no intention of working on this.

Under which circumstances would you become more interested in related topi=
cs?

How many components can eventually be extracted from the OCaml (and Rust)
implementation for better reuse with other programming languages?


>                                                       If you want to
> contribute something, please go ahead.

I would appreciate additional development resources also for advanced
source code analyses and transformations.

Regards,
Markus
