Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38551CA1002
	for <cocci@archiver.kernel.org>; Sat,  6 Sep 2025 13:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xgtY101swBKU1Zmo0ggFvBJix3LV/L0eQO37N6iPmM8=;
  b=J+cDdnencQmcJR3ibDPqe5CJzAQ0++GjwOTsQ7Enj2lagBjVWDrFM3NV
   NK7UHEfThwpj5w/PLmKZKK6jgOwIcPuAMig2S9qhzJlJHX4r4bU6XzTgg
   vESmyp+VX6f+VOgisRjqilZERfJZ7DUH3myuxiHTtFsgHLRf+vewg+Naz
   4=;
X-CSE-ConnectionGUID: eZkjmCOAScy3cRFHiznSlg==
X-CSE-MsgGUID: TJrlO7pOQjWtyaTchcsqyQ==
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
X-IronPort-AV: E=Sophos;i="6.18,244,1751234400"; 
   d="scan'208";a="237816252"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Sep 2025 15:20:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A2CA9E0172; Sat,  6 Sep 2025 15:20:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 62883E0171
	for <cocci@sympa.inria.fr>; Sat,  6 Sep 2025 15:20:35 +0200 (CEST)
X-CSE-ConnectionGUID: JFk54jyFQnG/PgHeGwH1JQ==
X-CSE-MsgGUID: Q5CP2/eiRAWBtaV7imSQ/g==
IronPort-SDR: 68bc3523_KfWBlnCiu7QYZQPid4L1zoHZmHdqMOI7O/BJj/jFsazRx6t
 bYTzFgmmw8gWqc2/z/4YTXyQsQs6sh5svmgZNpw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EVAACBNLxogAwR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYI/gQdUMwQLSYRViByHNIIkhDuHPIdViHmBVYF9Ag8BA?=
 =?us-ascii?q?wENTgECBAEBAwSFAAKMKQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABATsHDgoxhk8NgmIBgSSBJgEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARcCR0QBAQECASMdAQERJw8LGgImAgJWBgEUAQGCfoIjAQYQAQMPJgexQ?=
 =?us-ascii?q?YEygQGCDAEBBtpfHywiWYFkCYEbLgGFa4JkAYYnCYQzJw+BVUSBPAuCeD6IH?=
 =?us-ascii?q?oJpgiaBFoNYhlaIeYhFUngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEneYMHg?=
 =?us-ascii?q?Q2EHStPghxygXQ+GUCDUx4Gaw8GgRUZSQICAgUCQz6BbSIGHxICAwECAjpXE?=
 =?us-ascii?q?IF9AgIES0ACAQttPTcJCxsGPZVzhxqlBKFFNAeCOIFngWQMn2wGEy+XUg4Gk?=
 =?us-ascii?q?wWZBiKpH4FoOoFcMxokgzZPAxkPjiGEM7ocQTU8AgcLAQEDCYVGAQGMVoFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 iM=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:YQ/qlql6dAUl57N46th2K0ZUQa3pDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:cZbfDm+MZZuILmpoOEyVv2w6GZ15cGzz9XH/ZHe3KWtGV53Ma2bFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A5Wu28wzF3mLVgFNaKFO43ENoNfyaqJ3zI3hX1pg?=
 =?us-ascii?q?HgeC7HzB5BWiciQ+OBYByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,244,1751234400"; 
   d="scan'208";a="237816250"
X-MGA-submission: =?us-ascii?q?MDENVp67FbVaJ/1Oqai4VTGgbJ2XBzFgFjaSTu?=
 =?us-ascii?q?04hrlwKfjghVR7nK2Y6+0y/Rdl7mr422je/sCSYAoYLvAMFLZjjmyMp/?=
 =?us-ascii?q?a81xvF8sFXC4IKmAZrCxfdedZM7lRiO1oAUM3Q4bJeW5twWxPn/wtyTb?=
 =?us-ascii?q?kZHXMM+GtJ51mmABNhyxDPAA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 15:20:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757164834; x=1757769634; i=markus.elfring@web.de;
	bh=xgtY101swBKU1Zmo0ggFvBJix3LV/L0eQO37N6iPmM8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aeHOGF2R8u50fLLj75yczW0lROziDfptFHQ52svCAkVYeU8LnzLdKJV/5Vog3WBT
	 PvFQn1e2wJrfocorFketVrssJGeJpPu3fLSxW0ne5TFKTG+gzxRIiZ7UlhdjB63Ck
	 RUdztbxrX87mAWiIuNmglisqKvjoJAvg0MSsVtLoaihzEmgT7qvGatvHlCHs84z03
	 WYiQ9GVdXd2mvPSkYi6PJrU6TsU0moaJS8meWrJqfJ4Nuy9hLRGmUYn9nQV6SjZb5
	 GlhqyP3JwDzoBOo+BLsgN3TW0XXPoHpOhupMgK3PK25B8oZlWJIXpcPQu5QdUgS+W
	 /bLAGSqtyBTFEmYJHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbCDq-1uJdHe0CM4-00dJvl; Sat, 06
 Sep 2025 15:20:34 +0200
Message-ID: <5bea704c-e59f-4438-8729-e48afbcd6832@web.de>
Date: Sat, 6 Sep 2025 15:20:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
 <f798ce14-0401-4116-bbee-2b78ad0f774b@web.de>
 <4c46da9-1fa9-9b4f-f0c7-6c7fd094e163@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4c46da9-1fa9-9b4f-f0c7-6c7fd094e163@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YVlvx9ZLKMRSYWUmIVfcF43ieY5vyhgeVL1KChZ/dmck3LziSq+
 DK3qgMDHkIbQZGlVSDz0cTKoDt5uBIkLjCAm3FDxBTBLUudBm3WGjVoVc+MSA3Ope4xZ3aI
 o4Hb7ww5v2I0Uh85GZRMXQW3V3Nk8EHel7Yat+3V44ANI5a2SfBgHbHeMfVUTqcG29wvxg5
 +S80eNOJy6J3+HXIlFYlA==
UI-OutboundReport: notjunk:1;M01:P0:iO13TIJg7rA=;VmzEbIgSJJBE8zR01FIzjfhyIVh
 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
Subject: Re: [cocci] Searching for selected variable assignments (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3011
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/5bea704c-e59f-4438-8729-e48afbcd6832%40web.de>

>> How can be achieved that the search for variable assignments will be repeated
>> after such a statement was found?
> There is no after.  Such variable assignments are matched throughout the
> entire function.

The awareness grew for another implementation detail somehow.
Thus I hope that the following SmPL script variant can help also to achieve
a better common understanding.

@find1@
expression e;
position place;
type t;
t * pointer;
@@
 pointer = e(...);@place

@display1@
expression x;
position find1.place;
statement s;
type find1.t;
t * find1.pointer;
@@
*x;@place
 if (!pointer)
    s
 ... when != pointer

@find2@
expression e, x;
position find1.place, place2;
type t;
t * pointer;
@@
 x;@place
 ... when != pointer
 pointer = e(...);@place2

@display2@
expression x;
position find2.place2;
statement s;
type find2.t;
t * find2.pointer;
@@
*x;@place2
 if (!pointer)
    s
 ... when != pointer


Regards,
Markus
