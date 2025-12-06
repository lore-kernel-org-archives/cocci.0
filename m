Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4148ED3B7DB
	for <cocci@archiver.kernel.org>; Sat,  6 Dec 2025 20:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=sT/34qxJ3lAhxasdqX7/mab6PoAZRI+9nYiDUbjHrxU=;
  b=LHcJ6k+GsqeVKcWKLKZliwRxMrlO0bdKn6WKkTRpY0PY7BS+BJw3is1V
   sKX4uF97QM9lav5Fq7o4Z8EqsN2j0BbcunhzPYfWI+qHqw6P8r3RDbtZa
   Ls2TXL3Kf92hmxkwheCt/Ddx1uggPKKAU8Vlb+QMsolwE2jiZE9pquif3
   4=;
X-CSE-ConnectionGUID: n2JHsXteS0uYALlIIUbSBg==
X-CSE-MsgGUID: cXCJRixeSTO3D5SJtktGVw==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.20,255,1758578400"; 
   d="scan'208";a="253136712"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Dec 2025 21:10:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 42538E00B7; Sat,  6 Dec 2025 21:10:00 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 719F5E00A5
	for <cocci@sympa.inria.fr>; Sat,  6 Dec 2025 21:09:56 +0100 (CET)
X-CSE-ConnectionGUID: KOMPmcFETkyr5R148xM73w==
X-CSE-MsgGUID: MuvhUGdvSjyQ0R/7EiEAoA==
IronPort-SDR: 69348d81_K0DzHBF7Ca7Fa1dKgsRuxAauXfeOADvpymlyHwvjEaFE6BM
 dMdz4rYowIH1LB/lj+y7xYHS4RzpAEiLqwV1igA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GNAgBBjTRpg3yBCqpagQmBUIJAghgHCEmEVZ1rkFGDU?=
 =?us-ascii?q?gIPAQMBCwEBUQQBAQMEkWkCHwYBBDMGDgECBAEBAQEDAgMBAQEBAQEBAQENA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEBATkHDjuGTw2CW4EsgSYBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEXAg2BFhEEGQEBOCUPAiYCIxIBBQFXgmCCIwdKA6RtAW6BBUKKQwEBA?=
 =?us-ascii?q?Xh/M4EBggwBAQbcJ4FkCRSBCS6IOBsBBW57h356JxuBSUSBSoJEgkGDPoMOg?=
 =?us-ascii?q?mmCJoEOmSYmCR0DBwcOK0YPBRwDWSwBVRMXCwcFgWMBAgGBCm4yHYEjPhdzg?=
 =?us-ascii?q?RSDSR5oDwaBEYNRhSuDbw+HToJoAwtiCz03FBtMlH9OgjGBaoEvlBuzNYQmB?=
 =?us-ascii?q?YpzlnkzqmuZBqNohS0CCgcHESSBWiSBXHAVbAaCME8DGQ+OOoNnwR9CNTwCB?=
 =?us-ascii?q?wsBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23:wpdvKB+a4TFpdf9uWfi0ngc9DxPPW53KNwIYoqAql6hJOvz6uci5Y
 AqHvb401Q+UFcWDsrQY0LGQ6/uhEUU7or+/81k6OKRWUBEEjchE1ycBO+WiTWDdErvBQhd+I
 v5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vI
 BmsogjcuMYbjZF+JqotxRfFv2ZEdudWyGh1IV6fgwvw6t2/8ZNt/Slcoe4t+sBFXa7nY6k2U
 LtUASgpPGwy+MDlrwTIQxGV5nsbXGUWkx5IDBbA4RrnQJr/sTb0u/Rk1iWCMsP4Vb87VS284
 qlkVRHkkCgIOSI3/2HRkcxwkblUoAm9qBxlwo7be5+aOfxjda7AZ9waRG5BXsFMVyxdB463c
 oUCA/YdMetesoLwoUYFoxmjCgm2HO7gxT9GiHH106MnzeouDRrL3BA8E98UrHjYsMn5OaUUX
 OuozKfI1zLDb/ZO1Drh7ojHbwohru+WUrJrbMHfyFMvFx7bgVWWsoPqJS+a1uQTvGiB8uFtU
 vigi2E9qwFsvDevwNwjhZPSi4IP1F/L6CV5z5wpJdGiVEF7ZtukHYJWuiqHOIR4XtksTHt0u
 CYm1LIGo5i7cTAWxZoowxPTd/2KfpaH7B/nSeqfLit0iGxldr6hgxu/8EetxOL9W8WozFtHo
 DZIn93MuH0Q2BLf98eKR+Zy8Eu93zuEygPd6vlcLEwpl6fXN4QtzqMsmpYJrEjPACv7lF/rg
 KOIeUgo4vak5/jjb7n8pZKRN5V4hhzgPqktgMCzHOA1PwwIUmOG4+qzzqfj8lf8QLhSjv05j
 K3ZsJfCKMQGva61GhRV0oM/6xanFjupzcoXnX0GLFJbZh2HlYjoN0jTLPzmAvqzmVGskDZux
 //YIrLuGI7NLmTZnLj9erZ97lZQyAs1zd9B+5JZEqwNLfDvVkPrqdDUEgU1PxGqz+vjEtlxy
 50SVG2XDq+cKqzSsFuI5uw1I+mLYY8YoCzyK/c/5/7zk3A5n0QScrOy0JsNdn+3A/RmLF+FY
 Xb2ntgBFmIKshIkTOP2kF2CTSJTZ3GqUq0g4TE0FJ6pDYbYS4C2gL2B2T+7EYdMamBHDFCMC
 3boeJ+eV/cCciKeOslhnSccWri7V4AhzQ2utBP9y7d/M+bY4iIYuozk1NZ2/ePejR89+yFsA
 8SHzW6NUWJ6kHkQSj8rx6BzuFd9ylKf0ahgmvBXCMJc5/dIUgckK5Hc1ex7B8nvVg7fcdqFU
 lOmQtSjAT4vUt0+2cQOY1pnF9q+iRDD2jKmDKIWl7yKAZw56rrS0Xf/KMhj13jLyK8vg0E7T
 ctKL2KmnLJw+hDLCYDQi0uXmL6mdb8E3C7D7GqN13aDslxFXgJoSqXFRX4faVPWrdvn4kPCS
 KejB647PwVc1MDRYpdNP9buhl5HbPblItXXJWyryEmqAhPd77WAdofjYC0yxjjQDkINmAAe5
 z7SPAckGyqnqWv2FjFiFVvzJUjr9L8t+zuAUkYowlTSPAVa3L2v90tN7RT9Y/Ya37Zf/Twkt
 y0xB1GlmdTfF9uHoQNlOqRae9I0plldhirCrwIoGJumIuh5g0IGNRxtthbn2A9qB4NKmOAwo
 X8qxRY0IqWdgxtabz3N5ZnrIfXML3XquhWmaqrYwFbbhd+Z4LoC7v4xg0/usAGgCgwp9HA0m
 8JN3S6k747RRBEXTYq3Uksz8E1ioKrGZyAm+47O/WB3dLKxrieH198tBfUo0AflJo0DdqaFE
 QL5GtYGQcOpLYTGgnCPaRQJdKBX/a8wZIa9cueenbWsJKBmlS6nimJO5MZ81FiN/mxyULyA2
 ZFN2Pye0gadMlW0xF68rsD6n5xFbjAODyK+zybjHotYeqx1e84CF26vJ8S9wtg2iYTqXjZU8
 1uqBlVO38HMG1LaZlPnwABW300/u3GrmSKkiTdzlnBhr6aS2jDP3/W3bAAOaSZAQGhvi0upI
 JDh1o9CGhHwKVFzxV38vxqposoT7L5yJGTSX0pSKi3/LmU5F7C1qqLHeMlXrpUhrSRQVu24J
 1GcUL/05RUAgEaBVyNTwi42czayt9D3hRt/3SiUI2xuoXzTcOlqyBvf7cCaTvlUlGljJmEwm
 XzMC16wMsP8t9ybjYrOtOq3f3isWp1abW/gyobK52OroGZtBxO4hfW6nNbqRBM73SHM3N5vT
 SzUrRz4b+EHzoyCOPl8NgltDV74sI9hH51m15A3nNcW0GQbgZOc+TwGl33yOJNVw/C2YH0IT
 D8Ni9nbhWqtkERsNG+EwYjwfm+Qzstoe5+xZWZe1i8m7s9MAbuZ9/QdwnMz+wL+9FiAJ6Enw
 n8U0rM25WQfgv0VtQZIrG3VGb0UEURCfGTtmxmO89GivfBSbWerf6K30Rk2ltSgAbee5wBED
 S+mItF7RWkptJQ5aQiQgxiRosn+ddLdbMwerEiRmhbE1K1OLY4p0+ENnWxhMH78unssz6g6i
 wZv1Ne0ptviSS0l8aSnDxpfLjCwadkU/2SnhKlEg8uQ1YmHBJhtGjwXGpDvSLj7dVBa/eSiL
 AuIHDAm/z2SFqDCEAmV4W98on7PGoztPHaSbip8r50qVFyWI0pRhxoRVTMxk8siFwyk88fmd
 V9w+jEb4lOr4gsJ0O9jMAPzF3vOvAr9IClhU4CRdVAFi2MKr1eQK8GV6fh/Wj1V7oH05hLYM
 XSVPkxFHWASRlfWSkPiK/+Z/sHOte2ED6ylJv/DeruJs+dTEfyPwPfNmsNr7zeXKt7dc2pjG
 rsMwVJNG2t8B9yfniQQTDYUmyvcKcWcoV+94nEl9Jjgtq6yAUS0vM3XTOEPVLcnsxGu3fXZb
 7PW3X0ob28BjtVUgiWUgLkHgAxI0n8oLWHwV+5c83aKFv6Ym7cLXUdEM2UqbI0RtfN6hk4XZ
 au5wpv0zuIq0KVzUg0VEwa43JnuP5BCInnhZgqYXADSbPLffmaNm4atPeu9UeEC1bUJ8UDg/
 2bHVR64W1bL3zjxC0L1ab4K1njCekAH/tjkKV5sETSxFoq5LEfiaZks1Xtonfpu2DvLLTJOa
 2AjNRkU9/vLtWUB2KU4QTEkjDItLPHYyXzAsa+BdstQ66EyRHwzzb4S4WxmmeIKtGcdHLosw
 nuU9pk0/xmnirXdk2U/FkMW7G8Q3sTW4wI4aMC7vtFBQSqWpU1VqzzITU1R/Z07Vpq16uhR0
 oSdzfOibm4ftYiNp41EQJKOTaDPeHsnOh70FDOGU1AZEjO5N3OGwXtGiP/UwXHTq5k/7JXn0
 N8HTrsRPLAsPssTEV8tXNkLIZMsGyghjabel8kQo3y3sBjWQsxe+JHBTPObR/v1en6VirxNZ
 h1Axr2dT8xbLorgx0lrcUV3hqzXAA/LWMxV5yFsag4qrV9ctSEkEis22kfoYQq2/DkYEvv8k
 hMtiwR4aPgg71KOqx9ueQKM/XN2yRNg34y/3XiYa3bpIb21XJ1KBia8rEU3Pp7hAk50YQC0g
 U14JWLESrZW3N4CPShgjA7Rv4cKGOYJFPIcJkZIg6jNNrNxiwgPz0fvjVVK7ubEF5Z4wQ4jc
 Jr36mlFxxomd9ktY6rZOKtOyFFUwKOIpC6hkO4rk2p8bw4A9n2ffCkQtQkGLL4jcmCh8fZx5
 AqIkhNZdWQMXuZsqfVvvBBYWazI32f73rhPJ1rkffSYNL+csnPcmNSgX0h1zUYUjwxJ8Lx3z
 8o5Yg/NDRxpybqUGh8ALtaEIgZQJZk3ljCbbWOFtuPDxohwNoO2G7XzTOOAg60Th1qtAAcjG
 4lfptREBJSn11vUaNv2NLNQgwt4/xzlfR/WaZYBMALOijoMpNuziYN6zZUIbC9IGn1zaG2+r
 rfRrQs3jPfRQcxwVXEXQoEAMXk1Q4u/mitUtH1bEH+81ed8qkDKqjb4om645NzUdddvZP6II
 xhrDYPukd3Q27K7hV7e7tPVIGSobLyKW/fS8qYBooqfTv9ZSbhjvl3N3tACGzqvUmvCGteuO
 977bIx+NLTJ
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:XFERCqrz1EwuCXM4kegNOxkaV5q2eYIsimQD101hICG9E/bo6f
 xG+c5x6faaskd2ZJhNo6HmBEDiewK5yXcW2/hoAV7KZmCP0gSVxepZnPDfKlPbalfD398Y+6
 MlXKR3FcHqAUISt7eC3CCIV/glhPeImZrJuQ4c9RZQpMNRBZ2IIz0JaDpyvyZNKTVuNN4cFJ
 6R7MJcun6FVl5SRuqUQlkpNtKum/T70LbnZRINDwQ7rC2gp3eQ05jRVzi0ty1uLw+mRtwZgB
 f4e9iT3NTfjxhz8G6+pgru06g=
X-Talos-CUID: 9a23:33ymumNjjXHDT+5Dew5CzEsfNO0ZcWzHkU2Jfx+oLDkyV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AzEDdnAzYLm56mTkZYD+VRIyBGSiaqIGzFkAwvpk?=
 =?us-ascii?q?YgMuVDHRKfGiwjRmeRaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,255,1758578400"; 
   d="scan'208";a="132986414"
X-MGA-submission: =?us-ascii?q?MDG92OB8U8si6usx4ZpoHK8wUMycwq2xGs554e?=
 =?us-ascii?q?oLO2+1kj2N7iSuLoJ+5zkMBgiYPz8mCdJsHK1SSpRVExXflQ4N22cdUR?=
 =?us-ascii?q?MGz5RC62ludddtGJHSJkVx4Hzm/iIUwn96LPeM8nK6ajiU1Tv0Cl/VYQ?=
 =?us-ascii?q?dQIHocchxaBdTDQngp8mNccw=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 21:09:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765051775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=sT/34qxJ3lAhxasdqX7/mab6PoAZRI+9nYiDUbjHrxU=;
	b=cDr9WbAp2KLeib/K6IsWXH0YOxc6p/3HT35ZF6u+ieeT24IUxDs0guQ3Zckbe2+UKk0KBx
	tFuAiV99d8d2Ha617k7DFhoR/6Hb/cTI7S+aEcgdUAYha2BQ8jaz4R/4rcJTh89EAFnWi2
	bVPGxlDhCALlWrNRxp8OuJYWau7eQuU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-nljf1HWbOd-n1ICRWjlRXw-1; Sat, 06 Dec 2025 15:09:33 -0500
X-MC-Unique: nljf1HWbOd-n1ICRWjlRXw-1
X-Mimecast-MFC-AGG-ID: nljf1HWbOd-n1ICRWjlRXw_1765051773
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-787cf398a53so36604297b3.3
        for <cocci@inria.fr>; Sat, 06 Dec 2025 12:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765051773; x=1765656573;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sT/34qxJ3lAhxasdqX7/mab6PoAZRI+9nYiDUbjHrxU=;
        b=YVMiNUDhs1liETew8eaLmUyMClvsNKyyX3iLV9CiCkmIRQuGxoBzo1t83gugRRW+cK
         YbKunh8iGcPdy45xn29A5yvMyBbb72TyUTtxZcsqmy3q+BVkydh2dtG7ax+kG0M0r1Ur
         eRVJvMojPWcmti4Vo/Q5UV28LhaJv1+QlnsK2OpBE0/weyHUOfKNJaShl7ooBqINXL+a
         xgIWlDgYYxzClqaKIR22Wr2RKqzldVPSGARZ65ppuTfJNSF4r0SBQyiAH403lIl7PdST
         G6MQj8P/64EUpvOK1zr+gQeX84QAelzq/nGMgN9UFSJuGLWz3FNGKZfSt6H2dgxr0Up8
         gqYg==
X-Gm-Message-State: AOJu0YwAFXfftjucnHN28Ak/MSXPbYGR4E/IztbkQM77+LLdgeOnoLsz
	4J+A5+8aWI7M78XE7G9h5OYUkyH2tBS5AU+GYvjfHr13Ub75a2/r191DYmuPBIcIXj33k2cog87
	2WeTVi9ccVvClfEpuexCGF1WeZM0IxjkB7dB6Ed2yG+BZKSgs1fXlA85awqhdxrk4XJ8+ACIJF1
	N9vreYTkeavFscpC2kx897Z0gYiTOc+4g1
X-Gm-Gg: ASbGncvYUXQlJIX1cEWDubjf4yv0UgY+NQ5jvyiyNMaDpO70DTEN9QpRxgSlnjP+1Y7
	V8yeAfcq3jegUZ8uzXQHA3ynR/R2QahZ+4yFlx8Eq06f7bd1QUa+6vvGkhN+Wxu7XRlMSmJbokt
	j/Ef/9bOn6w7e9b3EC50enK220jxGEa5gao16JtZxLFPPoqsQPbNPGyAvIYsT6x1Mk
X-Received: by 2002:a05:690c:6803:b0:788:161c:722e with SMTP id 00721157ae682-78c33b64322mr28950477b3.26.1765051773050;
        Sat, 06 Dec 2025 12:09:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbNx+rHCqNZP2lHkVXVGztnXOOAi8h1Mgdfc1s6ChMIppehSSgPNfF7miglBTsdNChzt5Qcqrf7mvf4GsIiEs=
X-Received: by 2002:a05:690c:6803:b0:788:161c:722e with SMTP id
 00721157ae682-78c33b64322mr28950317b3.26.1765051772703; Sat, 06 Dec 2025
 12:09:32 -0800 (PST)
MIME-Version: 1.0
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 6 Dec 2025 21:09:21 +0100
X-Gm-Features: AWmQ_bmf5OHYVMKbCyXDc8wiZAwIE2wQiSW58n_qttVhHLusSbvz_eZWkonyQfQ
Message-ID: <CAHc6FU46Pusn-rq2TeCV+nBOiW5YUEGOuVRLQHOatniVJaT8pg@mail.gmail.com>
To: cocci@inria.fr
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tX8-ZyGYAKTjs-iuVOl0jbK20cbVSxwUNwb-Vz-DvZY_1765051773
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Subject: [cocci] Matching objects as well as pointers to objects?
Reply-To: Andreas Gruenbacher <agruenba@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 3245
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/CAHc6FU46Pusn-rq2TeCV%2BnBOiW5YUEGOuVRLQHOatniVJaT8pg%40mail.gmail.com>

Hello,

I have a question about using Coccinelle for C code (for the Linux
kernel). I'm trying to get Coccinelle to make the following change for
me:

@@
expression bio, errno;
@@
- bio->bi_status = errno_to_blk_status(errno);
- bio_endio(bio);
+ bio_endio_errno(bio, errno);

This matches when bio is a pointer, but when bio is a struct, the
following patch seems to be needed:

@@
expression bio, errno;
@@
- bio.bi_status = errno_to_blk_status(errno);
- bio_endio(&bio);
+ bio_endio_errno(&bio, errno);

Both cases are equivalent at the C code level. Can Coccinelle
recognize this kind of equivalence and is there a way to match both
cases with a single patch?

Thanks a lot,
Andreas

