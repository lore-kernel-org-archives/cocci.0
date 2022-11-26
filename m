Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3207CC4332F
	for <cocci@archiver.kernel.org>; Sat, 26 Nov 2022 10:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=c0VpFkr90Y6/0fKqMNlYEaSjAkNNXRunC6c8LXxPMOw=;
  b=D8UXKbxyznCTnelL0ARtW/G6PkVIxel+uEW8hwpbY5CnLxEI8JNlGwL8
   1Se7oJXkNeNi6AIqFQaJpkahubZLx9BJdypvG2emF/MGzU1fT+yPuLRHw
   QQEsYKjHYw7LXH5raO76J7MFflo617bhMl9nRum86POSOhajSlOkZG+Vj
   E=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,196,1665439200"; 
   d="scan'208";a="80174650"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Nov 2022 11:49:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1F8A1E00DA; Sat, 26 Nov 2022 11:49:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A50FFE0010
	for <cocci@sympa.inria.fr>; Sat, 26 Nov 2022 11:49:01 +0100 (CET)
IronPort-SDR: 6381ef1d_XS6/AlIGgH3x+cLVDzqp3OXhW7YHDuBG3u0dh2P4rRZ8FL6
 K/cszAajtjOVU1oJEaUmox1SZE2BaRrGEuW8q6Q==
X-IPAS-Result: =?us-ascii?q?A0F2BQAh7oFjhwMP49RaHgE8DAILFYN8gVouBAtFhE+Od?=
 =?us-ascii?q?oF3MYQphyGHMIw2DwEDAQ1BAQIEAQEDBIILgnMChQgCHQcBBDQTAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGgkXBw4QBSKFaA2CNSkBd?=
 =?us-ascii?q?YEIAQEBAQEBAQEBAQEBAQEBAQEBARYCR1M9AQICASMdAQERJgEECwsaAiYCA?=
 =?us-ascii?q?lcGDQgBAYJ5gm4BAw4jB69ZgTKBAYIIAQEGnAYfLCJTgV4JgRQskBx6JxCBV?=
 =?us-ascii?q?USBPAyCRzA+hESDV4JFIo54ghophyQlBA4DGSsdQAIBCzsyCkUbMScOCR8cC?=
 =?us-ascii?q?gQXDQUGEgMgbAUKNw8oL2QrHBsHgQwqKBUDBAQDAgYTAyACDSkxFAQpEw0rJ?=
 =?us-ascii?q?28JAgMhZQUDAwQoLAMJIR8HFhEkPAdWOgEEAwIPIDgGAwkDAiJVcwIuERUFA?=
 =?us-ascii?q?wsVJQgFSwQIOQUGUhICChEDEg8GJEUOSD45FgYnQgEwDg4TA12BaQQ1ZoELC?=
 =?us-ascii?q?jEvnFGBU4IKwiSBATQHgh+BTYFPDJ5nBhMulm8OBpIWHZcap3iBeSOBXDMaJ?=
 =?us-ascii?q?IM2TwMZD445hAyKLEA0OwIHAQoBAQMJhUcBAYRWAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:4BnIMKPNV27uscBcTvqjsMiBIKoaSvp037BL7TESdfUxSKalfq
 +V7ZImPHPP+VUssQ8b6Le90di7MBbhHPdOiOF7XYtKNDOGhILCFvAH0WKN+UyYJ8Q8zIJgPG
 VbHpSWxOeeMbEDt7eD3OBwKbgd/OU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,196,1665439200"; 
   d="scan'208";a="40862430"
X-MGA-submission: =?us-ascii?q?MDEFa6UzNErasuE33uv96slBPBKzEX/8nKFcAH?=
 =?us-ascii?q?eyldBD05pWlcxnNblQ3hNtZuMCpW8WWLWEcL7xv/b33iiNv3rXZ0Sq3h?=
 =?us-ascii?q?y4u29QUzy2qjB+ANGB3EKbSPEY1L2m5/Vh/EBXNdedwkSAUUtCMCE+GG?=
 =?us-ascii?q?GZ6Mvr0hUxaPK9wuiZSKe8Dw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 11:49:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1669459740; bh=3KlJu4BsPid3Klt+HuHdz5gsDDPVm9YpiX4NstVaHy8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mQqDVF3Yw2OwAaaAzXMoHbqEWd/bLO1KsI/43k2/dq59A7RmXBUeSaCLL8A8hgUQH
	 OCdrOx1DCEMF73S+0cu0wJxlgVTBQAFpn6hbLR3CRgn6giJXRsqDi+yK/vHm41sMge
	 RuCcLCXJmyrZoyvVBLdyKt5ANAvxNtE1MFai/GpT8MafAuKoxqjogcnGU9UMDyu8ud
	 QPPcsAudHMxzXq5FEdv+wnRFhgOXrkbbfx2vVmTu6GbwxYRPZvs72eKjaWhIhCjDwk
	 mrCeIIvezx11ZZyRK6lLGxMa+pErcr3HdiccSuWnBl6TUmyhVMo03nio24WCcVe/lV
	 ZF+X/aKnc8emw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N01di-1on8by0vrS-00x3x9; Sat, 26
 Nov 2022 11:49:00 +0100
Message-ID: <433b8c36-21ac-2458-49bb-0bacea62b47b@web.de>
Date: Sat, 26 Nov 2022 11:48:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <dce20c86-de6b-92ef-3bc3-af39ca99b5c4@web.de>
 <alpine.DEB.2.22.394.2211201641340.40755@hadrien>
 <79bb70c9-3257-504c-7d52-55ccaf51f640@web.de>
 <alpine.DEB.2.22.394.2211261130330.15234@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2211261130330.15234@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+QWDtKzHN3jbDDMAw/0T4OtGRoSvt8AZQEjv+vJfzbuPzbz6Cen
 x2zgCa4nt6Oetn4fQz8jOOCkvbuJWF2ClkBL6b+1GLWRgw52IrKMglNpcefEptXs5HCGMoK
 Dk56U8S4KJEBwL+kf8lUwAgnNoJ+BJAueMvQELYjU9CqAK9LQk5gRfJiLC5kh7QCPa9jhSe
 7UJvW4cxeBXrp4HJ3Dn5A==
UI-OutboundReport: notjunk:1;M01:P0:X+YcWGJgZOo=;w3FFV8kRsANchYybCM6d3YX65/5
 ClGZJgCSvqt2L+tmhX7LBAmVI+Fw+Exslx68MGiCNjeQKYW7LZMOFow3yr9FSUgE00JLKZdjo
 r24T0/4MU9ssTzDY+U41REi0nIxwk1jAfMj18zAb9wxhP2qPdU4Yi7Xczv6GbAX5SyojBCUKH
 Q+pVbTm00BFl/h5XEm7GyrJ0l80GN7TE3lOrHBr7cPRHCNpIdBeyyPEEtUTFy/hbHaVoe8SHp
 eR0LCMxNC67Ze5IwdQRZiy7jdqGmzYsEYtou8NRN1veKp3Ddqepf2t9BDzx9aMvb70rp+CA2Y
 tgiJqjyyf5Ok1f+AG5NVVZN/bpG3+p3vI5PjIHqNl3uwfuIeETyEY+WnLtTUKmy5fAegycIp+
 jsgvCRqV+q7ryxif4nJ2Yx26KoUQEycKjoULNP3AIumww6R6nSzqGCXRq6Vd5qw2BAXF5Hvoh
 FmFrS0AwVn1IzY4OmG8wdRuRfd/0kwYK36aGEAyptoBGYqAZ+0m7PEcgZVNuAFOyYQ1peLVl3
 yp3GDKCS+G5d9RWPwTPSdNtcoQ0meA/HVK2ASEYZMM5OKZTRoX2y962REPIpY8+M1JH6AElQX
 tEtTgKGVuWBjFzw4L6NKJ/iRMFyhYeSqjb9xPayT/Ygjzz0uxD9gYRZ8HUQ+Qx7W5Xfbzbh83
 lmc/OQYazznRxF/vjwuH3hFVWFJAA1ectB7cPe6Ldew4mHV7fddcrCxQ1WKqPYYmYcC9/xd5F
 sqsqIQQa12Fx/NpZ5XF29Jhw8ispvdSSo4Vz4cA/rRjW3rcPt2bXQL5vp+JfxcSFr8UtCKP2b
 LWsiZpa2dzThDph8/eBzi9BfwQuqwz1eJBz+0X/ukqZmdMw4F7QU6W4Ns9WGlU+i51t/sAWjS
 HpxZA9s16xRdCYb7LHP0csz1OIkSDzryymgY9gO/MFEXyJSt1b8bI9h2MU9E5QKKhxxHrUL3w
 M+YDmw==
Subject: Re: [cocci] Data structures for source file analyses
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 757
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/433b8c36-21ac-2458-49bb-0bacea62b47b%40web.de>

>> How are preprocessor directives (for example) integrated into the taxon=
omy of
>> the Coccinelle software?
> I have no real idea what the above question means.


I hope that further development ideas will influence software evolution
in desirable directions.



>                                                     Things that Coccinel=
le
> is able to parse are put into the AST.  Things that it is not able to
> parse are attached as comments to neighboring tokens.  There is no gener=
al
> anser for preprocessing directives.  Some are parsed and some are not.

Would you become interested to export data from the mentioned =E2=80=9Cabs=
tract syntax tree=E2=80=9D
and =E2=80=9Ccontrol-flow graph=E2=80=9D into any other standard file form=
ats?

Regards,
Markus
