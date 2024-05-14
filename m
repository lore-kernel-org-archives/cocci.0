Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76963C25B7A
	for <cocci@archiver.kernel.org>; Tue, 14 May 2024 09:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zcGOKDe0mgLdse1yfXem5mYwJv+F9jbqW/hz9594UsE=;
  b=GtPd5e1yL0LZRWL4IRRoMSqsi9Nm78f4T0WI/HDC0HLJPdH7y5tyGnK5
   CQvS7/q0ezm5tdHp4uJ1nq8rX0G8fHHYN7TISt/bS0YA69Ms53K5Rn00y
   IPnTO90jMSrwC2FF7tmoUzMnZ4Uxh6PuuK5srjStLc1SdmMmHQmSrD/7F
   o=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.08,159,1712613600"; 
   d="scan'208";a="165620863"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 May 2024 11:56:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 83A0FE0CCF; Tue, 14 May 2024 11:56:51 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0DA3BE004E
	for <cocci@sympa.inria.fr>; Tue, 14 May 2024 11:56:45 +0200 (CEST)
IronPort-SDR: 6643355c_k/XUolGduyBl+D+DEmBCghc5lbgTZU44+jrmhNSS4rnvbCT
 Cvk9qyEJc7OVgwPGDmOT0F0Qp4NNzchiFbLQaAg==
X-IPAS-Result: =?us-ascii?q?A0FqBQC1NENmhwsR49RaHgEBCxIMQIFEC4JEfARUMwQLS?=
 =?us-ascii?q?IRWj0iBdTCEO48IiHGBVoFAPg8BAwENOQgBAgQBAQMEgguCLkYCiEACHgcBB?=
 =?us-ascii?q?DEIDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxMEBw4QJ?=
 =?us-ascii?q?4V0DYJnARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwINOkIBAQECASMdAQERJ?=
 =?us-ascii?q?wQLCxoCJgICVgYBFAEBgnwBgi8BAw4jBw2xMYEygQGCDAEBBtpZHywiV4FjA?=
 =?us-ascii?q?waBGi6ILgGFfIRAJw+BVUSBPAuCeD6CYQKBYINbgmmWJYN1iBaIKVR9HANZI?=
 =?us-ascii?q?RMBVRMXCz4JFgIWAxsUBDAPCQsmKgY2AhIMBgYGWQYaFgkEIwMIBANEAyAzP?=
 =?us-ascii?q?hEDBBoECwd1gXaBNQQTRAOBOIl1DIMvgXUphB8IQ1oSFYNzgXYOYYNRgUqDA?=
 =?us-ascii?q?mOBRh1AAgELbT01CQsbBiIBHaMuhFAsIn6BWqIvolQ0B4I2gWCBYQyKIZUjB?=
 =?us-ascii?q?hMvg3KTRg4GkmiYYiCNVJVVhT6BZwI2gVwzGiSDNk8DGQ+OIRmDYTPHeEE1O?=
 =?us-ascii?q?wIHCwEBAwmFRgEBg1qBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:UFxzeqxOI/gu/lrP/uh6t+f4wirEfRIJ4+MujC+fZmUNrF6WrkUCy
 mEaXGmBO66KY2f3KIt+PY3g8U9S6p7Tn4VqQFBlqlhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjg24c3l48sfrZ9Esy5a+q4lv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFPPmNpLLxs1Y7cC6/kmKztz8
 awEBhwSO0Xra+KemNpXS8Fpgdk/atbmNsUTtxmMzxmDVKxgG8qcBfyVo4YBtNszrpgm8fL2Q
 sMDaid0KjnEbQdOPFg/F5802uul7pX6W20G+QLF+PJui4TV5FZ89ZTHPeSIQOeLe8p3h0CTp
 0be8XusV3n2M/TElWrdqSLz7gPVpgv/UZ0bELmQ5P9vikeagG0VEhwfE1WhydGyjUW1WvpEO
 kkM82wvq7Iz/QqlVLHAswaQpXmZolgDVtAWH+BSBByxJrT8wF22I0teTWB7cs055eVseDh6y
 nGlgIa8bdBwi4G9RXWY/7aSiDq9PykJMGMPDRPoqyNbvbEPR6lt0XryosZfLUKjsjHiMR3dq
 w1mQQA7gKgPy9EG3eO38DgrYg5ARLCYF2bZBS2OAApJCz+Vgqb4OeREDnCGsp59wH6xFAXpg
 ZT+p+CQ7foVEbaGnzGXTeMGEdmBvqncbWOG3g42T8Z8qVxBHkJPm6gPu1mSw282b645lcPBO
 h+J4mu9GbcIZyXxPfMfj3yZWpxwlsAM6ugJptiPMooWOcguHON21CBpY0mLl3vg+HXAYolvU
 ap3hf2EVC5AYYw+lGTeb75EjdcDmHhjrUuNH8yT50r8i9K2OiXKIYrpxXPVM4gR9r2fmgzJ/
 r53bo3So/mpeLakM3G/HE96BQxiEEXX8rit85cKL7Tdc1Y9cIzjYteIqY4cl0Vet/w9vo/1E
 ruVACe0EXKu2yOVGhbAcX15drLkULB2qH9xb2RmPk+l1zJnKcyj5bsWPcl/N7Q21v1R/dgtR
 dk8euKEHqtuTBbD8G8jdpXTltFpWymqogOsBBCbRgYDUaRufCHzwe+8TDDTrHEPKgGVqfoBp
 6aR01KHYJgbGCVnIsXkSNOu6FKT5koiuf9AcHbJBvJxe0zc1pdgBAKsr/0wIuAKcQ7iwBnD3
 SmoIB4on8v/iK5rz8vsmoa/sJaPL+tyOmF4Dlvrx++6GgeC91Xy3LIadviDeA7scV/d+YKgV
 L1z9O79OvhWp2R6mdNwPJgzxJ1v+ua1gaFRyzllO3D5b16LLLdECVve1Oltspx9/JNoiTGUa
 GmupOYDYa6oPfn7GmE/PAAmN+SP9c8FkwnosMgaHh/I2z9VzpGmD2NpIBi+uA5MJuBUMaQk4
 9sbluw41gidsicuY/G61n161mLUNXERcbQVhrdDCq/Rtwcb4FVjY5vdNyzI3K+ye+h8akkEH
 hLEhY7ppaht+U7ZQn9iSVnPxbV8gLoNijBrzXgDBUiDweSdovk72CxQrDcFdSVO7xB9y+koE
 HNaB050AqSv/jlTm8lIWV63KTxBHBG0/k/QyUMDsX/wFW2Ec3PrF3IsH9qN8GQy0XNuThIC8
 J62kG/aACvXJufv1S4MaGtZgv3ET+0p0DbdmcqiTv+3L7NjbRXL2qaRNHc18T35CsYMhWrCl
 +lg3MB0TYbZbScwgakKO7O25IQqaiKvBTJ9GKl63aYzA2vjVim42mGOJ2CPa8p9HaH23nHiO
 fN+BPBkdkqY7zmPnAA5FKRXAr5TndwV3vQgVI7vB1Y7t+q4kmI0nrPWrjPzlU06ceVIyMwdE
 L7cRxiGM26XhEZXpVPzkdl5CjKGRucANSLB37GT0eQWFpg8nvlmXmMs35CV4XiEEgtV0CiFn
 QHEZqOM8e1GzL5ovorzE5dsAxe/BsPzWd+priGykYVqRvHePfjeszg6rgHcAD1XGr8KSfFbq
 K+osuOr7Hjavb0zbX/Vq6OBG4ZN+8+2euhdaeDzE1V3ggqAX5XKzyYY2mXlN6FMrsxR1vOnS
 yS8dsG0U9wfAPVZ5X9NbhlhAwQvMLv2YojgtBGCgay1UDZF6jP+LfSj6XPNRkNYfHVRO5TBV
 ynFi8z37dVc9IlxFBsIAs99OKBBIXjhZLAHcuPgvjzJH0iqhVK/4oHZryQC0g2SKHe4E5fd2
 6nnFyjOLEH4/OmCydxCqIV9syEGFHs306F6YksZ/MUwkDygSnIPKeMGK5gdF5VIiWrI2YrlY
 C3WJn4XYcknse+orT2niDgiYuueOgDKEtL+OyBv4E6eLSu7bG9F7H2N6Q84i0qauBO6pA1kF
 T3a0mL9NF69z/mFgM4Ns+ejj74PKuzynxo1FIOUryA2KwkTC/MG2RSN2eaLuTPvS6nwqakAG
 YT5qa2ojq12pY4d3PuMo0JoJSw=
IronPort-HdrOrdr: A9a23:ClQgJ6r1RSa0Z5iNqGs4Y7caV5oQeYIsimQD101hICG9Kvbo9f
 xG785rsCMc6QxhIU3I9urhBEDtex7hHP1OkPEs1NWZLWrbUQKTRekIh7cKqAeOJ8SKzI9gPN
 BbHZSWZuedMbEwt7ef3ODxKadG/DCoytHPudvj
X-Talos-CUID: =?us-ascii?q?9a23=3APIDKu2qMkGoGG1ZYcH3LzDPmUeN+XVj+lnSOGVW?=
 =?us-ascii?q?pFjdDEoCRGUO+1Lwxxg=3D=3D?=
X-Talos-MUID: 9a23:t2KMwAgguxIumRhjZcZ2EMMpbspNz46jNh03qpQ4tOudMydxHy+Tk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,159,1712613600"; 
   d="scan'208";a="86988501"
X-MGA-submission: =?us-ascii?q?MDHPAgnQxw7rulk3sD+m+WTN7J6twDVY0EMezS?=
 =?us-ascii?q?mmMSIQx4D3SSeM0uNA1dMtgYvR0kDvzlP8QUOnEqxQDMznH3jxsAJFod?=
 =?us-ascii?q?zBadEX9nMLmeUqv1DcdBBQOS1qORlDb2MX0vGyCijfJ+IpTV6Y5+mQAH?=
 =?us-ascii?q?oEcFQaQVk1PiPDQUMU+vyt/Q=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 11:56:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715680603; x=1716285403; i=markus.elfring@web.de;
	bh=zcGOKDe0mgLdse1yfXem5mYwJv+F9jbqW/hz9594UsE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FzxpoNzeIW/FtwzphEwqtSkl23znGb+KvlTNGCM2Q0beVv452zh4yszFsu7B9yeU
	 c523sDx5vHDsNvNUWIRNrA9xkvw+kBJt8MfQ8FPiRYVkyyduqEyITrz1/9B8iKLoj
	 5BkIaXpM2Wu4ygmXy0HPfvaWWCq+dLYgIyg6amti2EMyIFzQsDrjLDAJUb4gk9nKP
	 GaesvEocwE9rYdcS4wAdZb3d6voTzCJM9lVngSM8TqiJgJ+1SqwTvO4/XDDtM9Kjj
	 JrJe7+UqtiUNVTThtokjPSvfEXbJ/DP2OOHPHIxRjx1PF9TatJ3ZB548hFjp2TDT3
	 pinWIR6yZ+UknSgVuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjxeE-1sr8550jWq-00h4jc; Tue, 14
 May 2024 11:56:43 +0200
Message-ID: <b5d197ec-2525-4ca3-bd80-3c1be06af408@web.de>
Date: Tue, 14 May 2024 11:56:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <48e0b9a3-dfa0-4e39-b049-93faa76c0735@web.de>
 <d65aaff8-48a0-c670-fc16-abc97415a99@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d65aaff8-48a0-c670-fc16-abc97415a99@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:umUlJwlz677z0hKoqXgKGdF/bDy771VYC4OUQuzqbcc3J9bN4hD
 bkcq8hJZHkBnctEfo2LYIdRHqzwVKHWr8LHavfyrWjZykv7A0bvQZHhmxsJm9XYPZpctC3w
 mi72roe+3f03VfTACmmN9wLV2wW8ZdWYvUPzHccquVWRdPDT1/1MCFraCidG3wM/JxWqP4r
 QGViBY6lEcILuFLU7DrhA==
UI-OutboundReport: notjunk:1;M01:P0:bX+LcCbaAC0=;CJxEr+dUPYzMTZmlTcA6pO1Zr63
 URG6I9x3B9qIPOJIt++yiOQ5lBJwvWzYqAFAkAo0+5R6/nuMl08bL6Sy7T8/T5xH0cuJtMgQ0
 7ueylf1xBOeRo7M+o4/Tqbh8VlJRW1tM4bHH/q5WjbEZvoKnZDeUxuG3DXE5v6GunFUGminpg
 Xi839x8PIwr2yTdP8xjaMmvBaFT+du8CQs85RRh2su9AMHzzrl+eAJbqlASuauehLkfe86vmO
 hzeFHHnttmFDpa0Y2hG1gsraXgCEzF3fDAquKZqyp0q9sqWg6bKHwLaVT9Wknc3z47w7R+svW
 z9PpbYN4KgT+1R7Hpf0j4b6P9X88SBar1gwyrfZ2RybKS0P7I8tTrPDfFKzSdUWDP7M6OYt6L
 8uXLNRXaBqjvNEakX3o4/71NehykxovtZ8ER2SIV3h2HTIEX7lq3rARVw3XAtHUs1ImHltxId
 wVbrFyyFmBt9QY9K6dPiY7/T6UqByEGkohRpg2eaVNq5fTclgRvohFa72mXiGomASG9A+NWuB
 jezWEs25XqPOt8YEzLSmMqO5brcOiDDM/esllIuRferPwzh+A59CrodivRm5ZAADdtJjkW9JF
 CswZG+D5ldYwGFnGk0SNo5WwdcfnR08F7mMI7s7QCqpqpkBG4GcO1yCJMZ4299YkTnFe5gp/J
 drLEXBljIClX/CZwGOE6J7GyIV5s3d67sf4V34uibZxdaJ++18jKpZrAMJqucxgZYoF3tckUl
 Ov8mNe4IX2usJyLxAi5lf5y9iwX4Vt3ZZYgBqQowlyPdK8Xs7IP7HCYWNsBFF29CzGvr98G75
 PuqdJzm6ybkWjw/S9WdJJSxGcysLF4zGpTa+WzSsztGS0=
Subject: Re: [cocci] Checking CTL code?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1739
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/b5d197ec-2525-4ca3-bd80-3c1be06af408%40web.de>

>> The Coccinelle software supports a computation tree logic variant.
>> Can CTL code be directly passed to a corresponding tool for further ana=
lyses
>> and system tests?
>
> Not sure what you are asking.

I hope that adjustments can be achieved also for another clarification app=
roach.

Determination of CTL code without C file name
2019-01-09
https://github.com/coccinelle/coccinelle/issues/156


> On the other hand, you can also hand write CTL formulas and pass them to
> Coccinelle.  I think that can be done in some way with the --test option=
s.

It seems that I am still missing corresponding software documentation.

Regards,
Markus
