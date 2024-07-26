Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC57C3DA4A
	for <cocci@archiver.kernel.org>; Fri, 26 Jul 2024 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=K7DJvUKMMLyu6T00EeJ9nlTp5AzBrKVq644SNnT55Jw=;
  b=EX0iOmbEoGnYlM2r0QRbzRI/Of/z5wwUE/x2BROzZI3/yKrrgTrykkCl
   NB3SwtHdPmcCcJONY6g1osSI4XcfGFWa30CVx0w60b88sNFalIyeXh8sG
   47BbWjsmOVqCyVphGqbtAhHqWyWl8hso11z5zKkbY4dd/ErtjitK3XnSO
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
X-IronPort-AV: E=Sophos;i="6.09,238,1716242400"; 
   d="scan'208";a="177114461"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Jul 2024 15:55:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5A98FE0141; Fri, 26 Jul 2024 15:55:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 937A2E0035
	for <cocci@sympa.inria.fr>; Fri, 26 Jul 2024 15:55:48 +0200 (CEST)
IronPort-SDR: 66a3aae2_Fzcm8ad9e7jzaCmad0ROpN4JNrsFQZjIIXy6RIfJKYd4uGa
 adTup9I/kaSab/rhrEnJRUMyKRxiyHZ1E1M2HhQ==
X-IPAS-Result: =?us-ascii?q?A0FTAADMqaNmh07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDYhoGVDMEC0iEVogdhy6CIgOEO48LiHWBVoFAPg8BAwENOQgBA?=
 =?us-ascii?q?gQBAQMEhH8CiToCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBOgcOO4V1DYJnARCBEoEmAQEBAQEBAQEBAQEBAQEBAQEBFwINO?=
 =?us-ascii?q?kQBAQECASMdAQERJgEECwsaAiYCAlYGARQBAYJ8AYIvAQMOIwcNrTeBMhNug?=
 =?us-ascii?q?gwBAQbaWR8sIleBYwMGgRouAYg8AYYMg016Jw+BVUSBPAuCRzE+gmEEAYFdg?=
 =?us-ascii?q?1uCaYxLgQiDamkEBRWILAODTSaNTlR7HANZIRMBVRMXCwkCBRCJYAqDJSmBS?=
 =?us-ascii?q?SaEGwiBLRWDZIFrDGGHdmKBD4E+gV8BSYJ3S4NoHIFlbB1AAgELbT01CQsbB?=
 =?us-ascii?q?j2iJoNwHWwXIVCBT0kSxSc0B4I2gWKBYwyKJZUqBhMvhAWNAIY3DgaSbh6YT?=
 =?us-ascii?q?yKNWJsXgWc6gVwzGiSDNk8DGQ+OIRmDYTPMFUE1OwIHAQoBAQMJhUYBAYNag?=
 =?us-ascii?q?UoBAQ?=
IronPort-PHdr: A9a23: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
 twCR+0DPLTaPuwXAAJpEY5bSKo=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:WyY7/a08YBrU2bRpdPIbogqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:rlOa2mMNeK7tn+5DVxtKyGoyI+sZVHDhlTDMfmSHBT9YcejA
X-Talos-MUID: 9a23:l97HlApJwrCdZl7dC44ezyAlNsFY+qWtM3pXsdYp4cOZN2toBR7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,238,1716242400"; 
   d="scan'208";a="93030524"
X-MGA-submission: =?us-ascii?q?MDGbNSKI7Jcl1M+OTbd24vvFsanH1QwRiyevqJ?=
 =?us-ascii?q?UYV+dYD+c4neIHyStR0kTqoCzzekc7FoJnJDfBrZrbOB55wc7z1G2OUd?=
 =?us-ascii?q?cNh62QBeRDTMeKCjjB9hlIJtATuPEeLJ/GCKZd0SIaIrSIRFmkSRWiQF?=
 =?us-ascii?q?s/mxdWUdXP9fTGEet0puOn6A=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 15:55:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722002134; x=1722606934; i=markus.elfring@web.de;
	bh=K7DJvUKMMLyu6T00EeJ9nlTp5AzBrKVq644SNnT55Jw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SFxYkSpe9D8/vMzst9TNbf2ZtKc6L/SnBOOpJ2Y6HKQnbVkHVnGD2QG7mf9hZn7J
	 5WG4owLXNZRHsMi4MBPPXP2ETjNSsS5Yv9W1+9CIPHCTC8Lq17lwQtuh12Y9FF6zV
	 Lfm9kXodWZrMBlcQtYnkl+t/S1nYa5t2Am+y4ZSYlwBMFJm7kLwQM6LtcgLeXMIXy
	 7yHp+kx48XjzeFSOwwM9SStpgXDxYyfCA8beCmRoEPclu07VgUEuGw6MezKhSOJhc
	 MoqiNlVpk0+CO1OrcR5pqyskSBvAqc7nFQawdDCBCRMvNmeNRhDGPKhPu7N8SvZ/f
	 EuweXyuOCdZ1CE5hcQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M91Lg-1scJUW2CSk-006KIK; Fri, 26
 Jul 2024 15:55:34 +0200
Message-ID: <6d254822-e785-4954-99ff-95d0546a7189@web.de>
Date: Fri, 26 Jul 2024 15:55:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Chen Ni <nichen@iscas.ac.cn>
References: <959b8771-76a1-4cee-a7b1-2b391deb23cc@web.de>
 <1584412e-94b-4c10-6f96-9da68f4ed1d@inria.fr>
 <d3f11294-5751-442e-b7d4-616c3bd217b9@web.de>
 <bea5cf4d-0e4-d141-1365-4d5f76bcf513@inria.fr>
 <f7cb87e7-3a17-44b7-87a1-8fec22e649ea@web.de>
 <fea78c48-494a-ee18-97ee-fc6930fce7d@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <fea78c48-494a-ee18-97ee-fc6930fce7d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vNtYn3zMiFntuuUUhntUCFmt+fYCRbPF+wtexlyDBv/ATIGtzhR
 aQHXzjLDoDWnncY8ZIROwy3AFXFJPI9QcmqCKd9p4avf5s5d6PsiljZoP4QMZy/7EqbGHPF
 YdpObPqit+PWf3anmLFNw5w08a6jl9W0nhExDEkTy+dbvNeZbuTBcvclYnj4UhECcixMaCe
 RjjdE/h/sXT+0hHbfHutw==
UI-OutboundReport: notjunk:1;M01:P0:QSGyR9qdD8Q=;obYoVb40FV5oIw3TbhFP/xQ+lfm
 8z6+bkKE1mrEa4YEy3JJ5VBuuWi4QMRzr3SjNKMXfgc/NSHCvTDrbhV1ExJaJytMr/IE0g/sN
 89D6hEPDwPr8kiymOuq5zXmR56XQ0jZCxohAuoqEt5gkcAugxUFA9fUSUfvGSo/rTMONW+IYC
 4v7u4oDJKOehsRrQEKIW4z74F9mmXbfpPvKvGBJ7Op0rLT6G9oX9CtRkEHex+X8cwKh/eGzN0
 jdP5ZHxeYxfCgr71WTpGYSnP3/aSYI2zbggj1lErFtTJKk3Uh+v3npg0uPqZz8S7DImKCMAFA
 QTsyu/IF9wWgU8i8WlwPXA0nEYZQ+Q0tESwbJaJcP20Y7YNrovyvqpeO0nufQBW7FdWwacuBw
 UK8xf8qnZ3vitG1yM7QOhHWL1F5AHpj3/+RpFVZivmNWl8LzIsHFnSAvjmIJfmU1qhULdt1hy
 ZQXpwmKCgsW3eHOXv3Lv49Pv2RajvWaAl6rMsI1VPS39pRXrUzRe8LrMas28TPZrZmb3z8Ob8
 SxBXjw+LpJ2JsCFzvHEXNpxJMHM01xCZoAS0UQNvQTUsDJjvoZkXw7p7prPtlfQ4xBNpvTB74
 5VjJYriouQ8qRzpv9nzq0Hb+estlWyVsdrkp+h6RPNp1pldQeuF2OVc+Ac9iL3RMBpEH6IAC9
 IghMXlIkSRIICIS/8r7liJFhUvxiDd5PW/nQ9Ku7fRu2xla64HuZ0enWZqOVPxKMr7qJl2/Hk
 dVi0j9p0k78ZvafuRru/KFPgQruVP/qqUKS0lT7jrIvi0szDTNqfUaEx9WBxOmKD4GYPpiDJI
 +R2uJ+N4mAQEUyaP75ohYKTA==
Subject: Re: [cocci] Data processing challenges according to the comma
 operator
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1820
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/6d254822-e785-4954-99ff-95d0546a7189%40web.de>

>>>> Please reconsider such a view once more.
>>>> https://en.cppreference.com/w/c/language/operator_other#Comma_operato=
r
>>>
>>> The link you cite says:
>>>
>>> The comma operator expression has the form
>>> lhs , rhs
>>>
>>> That doesn't end in a comma.  There is no rhs within the <+... ...+>
>>
>> Can subexpressions be supported by the semantic patch language
>> for such a =E2=80=9Cbinary=E2=80=9D operator?
>
> A subexpression is also an expression.

There is a desire to express special source code search restrictions.


> There is nothing specific about this operator.

Its parameters should be matched (or even captured) here.


> The rule in Coccinelle is that when you write <+... ...+>,
> the term in the middle has to be a complete expression or statement.

This should be the case for the discussed SmPL script example.

Regards,
Markus
