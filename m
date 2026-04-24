Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34456FAD41C
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2026 08:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=vpSHXidCax2H61mZmVOko9E2q/G4IDalksFpph/x5tY=;
  b=LwbFI2xnRhs8YHie5vyDEcn54SaoPRaiI4ixysyz7fJzmR/ElSKnCe8E
   LjJcDURBXkfdGeRVUTA6rm6prO3Ee5EWx6vGbxrHp8bF/Sw2LvImdudYw
   ockKUx7J/VzHgTyYMb514L6XQt+lGXeWHP8NRBbcQsRiEQTkkra19zD3d
   o=;
X-CSE-ConnectionGUID: UhChH9tBTsSrYgqVfHoshA==
X-CSE-MsgGUID: sqe+vJ5fT3GmUIOig/kF6Q==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,196,1770591600"; 
   d="scan'208";a="273951821"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Apr 2026 10:43:44 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9AB6F8162C; Fri, 24 Apr 2026 10:43:44 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id E8CC281610
	for <cocci@sympa.inria.fr>; Fri, 24 Apr 2026 10:43:41 +0200 (CEST)
X-CSE-ConnectionGUID: X5Au57tTSwGxJyz526YWdg==
X-CSE-MsgGUID: S0V0Y9BpTOyNT//h1vitqA==
IronPort-SDR: 69eb2d3d_s4L/2hM3GpQy8YMC3Tqw2aQ2Pt3oOBImDO0jJkDwcI2jkR+
 q9cTun3NsL6bo1JHit5I8sdAQpn5K/sFpoo+u0w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H7BAC/LOtpgAQP49RagluCP4EHXjQEC0mEWI9Thl+PE?=
 =?us-ascii?q?Yh5gWmBLD0CDwEDAQ1ECgECBAEBAQEBAwGCC4IujXYCHgcBBDUFDQECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQE7Bw47hk8Ng?=
 =?us-ascii?q?luBLGAHPwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAg06bR0BAREnNAIRBw4CcwEBgn4BgiIBBhABAzYHDbYLgTKBAYIMAQEGg?=
 =?us-ascii?q?mrXex8sIlmBZwMGgR8vhXGCShwBBW6JfScPgVVEgTyGIgICGH+BBg6DDoJpg?=
 =?us-ascii?q?iaBDo8pgUocA1ksAVUTFwsHBYFmA4EGbjIdgSM+FzNYGwcFgUuFX4EKAYMqg?=
 =?us-ascii?q?TZ4NgIBC209NwkLGwQ9i0AgD4NkIpVXkTyhRTQHgjiBZwWBXwyJCIEmlT8GE?=
 =?us-ascii?q?y+DcQGTYA6TC5kGjgmVYIVYggAigVwzGiSDNlADGQ+SIjOBC8drRDI9AQEHA?=
 =?us-ascii?q?gcNAwuBaINcAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Yl2x0Ac9SRdDn2kqSj/KxB7bSpaKivm+081
IronPort-HdrOrdr: A9a23:V22DqKzEiCf2thvee9WWKrPwDr1zdoMgy1knxilNoG9uA6+lfq
 eV7ZMmPH7P+VIssRQb8uxoV5PufZqxz+8W3WBzB9mftWvd1FdARbsKhebfKlbbakjDH4BmtZ
 tIT4g7LsHsBl5nisvA7BC/CMtI+qj+zEnlv4bjJ2wGd3ANV0iM1XYBNu4Rf3cdeDV7
X-Talos-CUID: 9a23:ENcrQmOEGGaBr+5DaHRO6RNLBvwebVLN7mbCfhXmOFllR+jA
X-Talos-MUID: 9a23:t4izsQW8o+ces2Pq/AS0umlTZe1w34O/LnxK1pVfpciYLAUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,196,1770591600"; 
   d="scan'208";a="144955592"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFsB6uLOewij6tWsa1h2CImezlkuPuZt9aXuK?=
 =?us-ascii?q?esL6eex/rZ844iVJpgrslA4BN5Y55JdSUatGBPPeJ17TVq7a7pCkfnNy?=
 =?us-ascii?q?Mc+2cNDk7NB+1FjsvllrLhn1uvRFGYAOgYZk1rkFVrXrBPaPwTaCnWnr?=
 =?us-ascii?q?mWXZkeKgY3hMWYuTx8xmrslg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 10:43:41 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsrhU-1vNOeh473I-00y5qp for
 <cocci@inria.fr>; Fri, 24 Apr 2026 10:43:40 +0200
Message-ID: <138f6f86-b875-42fd-bc00-f0ad5e1f6f6b@web.de>
Date: Fri, 24 Apr 2026 10:43:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lgtAFuH9tmPimU6pe2Dmj5vx27U9moVFC7UnIeTaySwmqXCnwze
 vdIPNV5AronpxDN3D3KWsOwyxcWdtwVuUAs3aZCuM1X1H9sFecHOa23MQXFf+hD/hihLpl9
 ah/V9JwFZdDp41WWDNE1X6bN2Y2jO9jKdApQflIYv1AcvKkdd9/ny1npTZy336st5g4v0IZ
 ZOoptXHFVuwewxUijvzuA==
UI-OutboundReport: notjunk:1;M01:P0:qTPu3r3vckE=;SU/iya9fTPybRivHiXZc6Osiy6S
 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
 agGZrjSuXCT
Subject: [cocci] Planning the next software release?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3481
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-04/QQOK5OKDZ8ip-87qNv8VVg>

Hello,

Some software adjustments were published recently.
https://gitlab.inria.fr/coccinelle/coccinelle/-/commits/master?ref_type=heads

Will any refinements be taken still into account for another software release?
https://github.com/coccinelle/coccinelle/issues/337
https://github.com/coccinelle/coccinelle/issues/308

With which delay will known improvements become available for general applications?

Regards,
Markus
