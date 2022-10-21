Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699C3C433FE
	for <cocci@archiver.kernel.org>; Fri, 21 Oct 2022 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2ETA3I8n5t/cRS7b3EEO4erg7K+6WwvbsM1BQhYpv+8=;
  b=lI26X2qiFdn/oCAlsfTARMgfMsILLzmrDodfoWjCJx0JF3T2jw52zpR4
   EEkw1fMXWmu8l3fO+/6w8BGNJfiYkOAN3TAzMDiAw5G1JF09qfukqs1BD
   j6pWvyFeSqjgg8ipNgd+wp6r43ZPo+Rkzq4ZbmgcCqKhLziadXEwtUJ4E
   Y=;
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
X-IronPort-AV: E=Sophos;i="5.95,202,1661810400"; 
   d="scan'208";a="66426545"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Oct 2022 16:30:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5347AE01D1; Fri, 21 Oct 2022 16:30:19 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3F413E0130
	for <cocci@sympa.inria.fr>; Fri, 21 Oct 2022 16:30:14 +0200 (CEST)
IronPort-SDR: 6352acf6_I3WpmoZ65rmVCQVe3U6ZTSoMQ7XtJdwedxY+Z9ydgHjIxVB
 Ywglp57PIATmJLCIZ6MgdROJ2inXK85z/q4WQKg==
X-IPAS-Result: =?us-ascii?q?A0CCBQAMrFJjhwwR49RagQmDfIEBVi4EC0WETpBxASUDk?=
 =?us-ascii?q?mmMLw8BAwENPQQBAgQBAT+BU4IuOwYCAgKEcgIdBwEENBMBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAETAQEBGQkXBw4QBSKFaA2CNSKDbAECAgEjH?=
 =?us-ascii?q?QEBEScECwUGGgImAgJXKoJsAYJsAQMNIwcMq3OBMoEBgggBAQaBQAEVQYI3H?=
 =?us-ascii?q?ywiU4FdAwaBESyHI4k3JxCBVUSBSAGCRjA+gmIBAQKBXk2DCoJmjxeGMjgDR?=
 =?us-ascii?q?B1AA3gNVBwxJw4JIBwOFw0FBhIDIG8FQQ8oL2krHBsHgQwqKBUDBAQDAgYTA?=
 =?us-ascii?q?yICDSkxFAQpBwwPLQcjcQkCAyFlBQMDBCgsAwlAByUkPAdYOgEEAwIQIjwGA?=
 =?us-ascii?q?wkDAiSBSzEmBQMNFyUIBTcbBAg6AgUGUxICChEDEg8GJ0cOSj45FgYneQ8OF?=
 =?us-ascii?q?gM+K5ZWgnktLCKBLwmiCqBpNAeCHYFIgUoMiWyVEjMDlmQGkhOXH41BmjOBe?=
 =?us-ascii?q?SOBWzMaJIM2TgMZD445g1kzgQuJIj80AgkwAgYBCgEBAwmFRwEBhREBAQ?=
IronPort-PHdr: A9a23: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
 nK6kw==
IronPort-Data: A9a23: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
 u3yNpE90tZdD32pqSsuCiSHvNpa
IronPort-HdrOrdr: A9a23:vyb8H64D3opchJCjGwPXwDTXdLJyesId70hD6qkXc20tTiX4rb
 HMoB1/73TJYVkqKRMdcLy7VpVoYEmskKKdpLNhWotKPzOLhILLFu5fBOLZqlWMJ8S9zJ866U
 +kGJIObOEYZmIbsS+V2miFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkzuRcTzraXGfX2N9dOAE/X
 enl7d6jgvlRVRSSsigHHEKU6z/t8TG/aiWGSLvjHMcgjWzsQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,202,1661810400"; 
   d="scan'208";a="66426526"
X-MGA-submission: =?us-ascii?q?MDGBfRwjxYtUEpjTLNtdy05N3cWhvzHq7k8N2t?=
 =?us-ascii?q?Lf1d1w28N/T7Ws1rGRUOk92opM6jPrmlGpRImiHIEEphLoOC7/HCM2eU?=
 =?us-ascii?q?b1r1Qv9oB2OgUheDOFuc/evQ3XRmiboCc1ZAtMpmYuA+onAm0Bsl9fIh?=
 =?us-ascii?q?zcTWE9Tkac8DmDptCgFVa1uA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 16:30:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1666362613; bh=2ETA3I8n5t/cRS7b3EEO4erg7K+6WwvbsM1BQhYpv+8=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=nvzoGzrN8gdjgCcjo5++NSIenv6FTQSCKJmJx1XLRieJolRPMJF4gTTL3GF9eZKRT
	 o2KcQBbONbXzYZ8RA0YOxvJqtr9oglewX11HtfXy2MPHX146sYSq+1wHA+vvF0MvSI
	 TvePmHBiF0a4lC5Cz0GblQfZPSmcwJBWOThpsm8TSDaRfyk3QAccxyw9HUqb36QiSo
	 WfmgcdgVwjXlJqc4Q1zOUSEtNj46wZavmj9UFFXLXZNfB3Z8QdPHAT+F6JrpyIdwWm
	 5gk2IIIbMTwsCiEeWPA0xpb4cnIxYuTZi5iiIYdq8gUFwNIFz0jJ4Yw3sBWxV14opQ
	 UBBiAdRqWmjlQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [94.31.86.160] ([94.31.86.160]) by web-mail.web.de
 (3c-app-webde-bap43.server.lan [172.19.172.43]) (via HTTP); Fri, 21 Oct
 2022 16:30:13 +0200
MIME-Version: 1.0
Message-ID: <trinity-290fce3d-ef39-4b6e-8235-e673d0979f97-1666362613347@3c-app-webde-bap43>
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Oct 2022 16:30:13 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <trinity-8d68c62b-e946-4ce2-b370-6555d910f65d-1666291236270@3c-app-webde-bap34>
References: <trinity-8d68c62b-e946-4ce2-b370-6555d910f65d-1666291236270@3c-app-webde-bap34>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:csbBHZT1JbLi/Plqe+3lNNbfDcv8D40+iaW1eGrp5GgW3blfkuAGp8k7E1kVgY4HSgbJP
 wuBqLAIuuC0lUxMU0bDr7GG+IGg7+Q3+BE9fg9lcf0Hczt11D9Krgv7Kt/NABznY/WxdKIN1KHk7
 JvPAm27UAujNCn09ngLHE3SVlFDIZKKmWWua/7eTc4EHlqMWqXxewaT+9Y+W0wNxBTM7oyS1h1ns
 eWs0GEazoX7JxJKh6VSwaGnN//gOVwUaLBK7f78Eszjz6HLiZs00+/MkdWOXnvOgDoZPD9kQuGXt
 M0=
UI-OutboundReport: notjunk:1;M01:P0:BXDpGHPH4uA=;KEuLl6abToS0ZVQGp+RdmQZECFn
 UNBsKUeNGoTi/Unl9sksefee7RYe360ArxNPV51aBkJqLddoPU/IsIh6DhrauTkmhYz8IomJj
 gOfrUoORR8jPyqHYB2qaZaNPzaNnl1j/bHrDID2jNQbr0/FlzIQMND3DFpnFFWJgDgVAV64Zj
 IRb5IEoccphaw7YjEVcZHHWrmc16SSXYtuNmq1r+cpjT/+7HFZVTYu3TuS9NWiheicwt64yh/
 O9wJm2nvqkA5X+5au2g+S8E2ynIT+CWeO8cKoYBiRx2htZ/MZtKslGZXl8jDZCZL3vQ5y2n/x
 MKFY+ODGJI+nf96KN/kJWbWvTKXtV5qryetxTHNFlICOw/gP3eAbwowx1jrDsahSo8u2rutSI
 72AYz2dOXtGRZPqBIeNOiBUwZtxiaeYxb2RXD/2bZUk9F7nZaE69IaBjtN+nxNCcJHgQB+P4Q
 Q2+TIeNGDNFt3pDq9qZt0k38BfDEluGrPa31RYAcV5zJ0ehlsTmvDB4rCY+JwZsiPWRivSQlz
 7x28l529Qd/P47PYOwde2IZmPr3/YCDqWHij8P2C1VnMJhd0Ms6B4No1IXjXglCcT5RDDFq1Z
 Oe4y2p3njTjXY0TnnGHOvGaNUb0XnuvU4JWSGnjtQ+j+6YHB0PLhhmczTx80GyKf18vm0Es/U
 1apCwSmD2gkceoKG4fiDS2QqoHShScoP4LRMIv4e0xnt6fXwqECFEguxjqcKnvHD5Du6Qkkum
 aGykg+GjPJt0gdD9SATmykzzw1r5WtOhJu4V5WVLblFYY12qwztGblxlIBQdgG+ReKwxCnSII
 Ifs0VfniKQmppiEgZBCCIvDFrM/BBbyvCMAh11ObwipG4=
Subject: Re: [cocci] Explaining related information for computation tree
 logic?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 660
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/trinity-290fce3d-ef39-4b6e-8235-e673d0979f97-1666362613347%403c-app-webde-bap43>

> Can the technology =E2=80=9Ccomputation tree logic=E2=80=9D provide inter=
esting hints
> for this aspect?

How many software developers or researchers can explain the data represent=
ation
which can be provided by the program options =E2=80=9C--show-ctl-tex=E2=80=
=9D and =E2=80=9C--show-ctl-text=E2=80=9D
for semantic matches and patches?
https://gitlab=2Einria=2Efr/coccinelle/coccinelle/-/blob/86486f01bb7e1c2af=
326bba302c45cd54719445c/docs/manual/spatch_options=2Etex#L122
https://github=2Ecom/coccinelle/coccinelle/blob/2b374187ace51a5569272642c4=
43dcf1f61a1204/docs/manual/spatch_options=2Etex#L122


Will the chances grow for a better understanding of shown formulae?

See also:
2019-01-09
Determination of CTL code without C file name
https://github=2Ecom/coccinelle/coccinelle/issues/156

Regards,
Markus
