Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044D1C76196
	for <cocci@archiver.kernel.org>; Mon, 10 Apr 2023 12:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=taTA30M8izer4wqzLbgvdaS3i/Sq7nsG5LIV+QJgY0I=;
  b=ZPv0vb5kil+r6lKSMzV9sUZ5SL+c5olC9NaILrJqKKX6qn84j+SpcPNY
   qNR8jdGf1M4Yg6+QcFH7SMeCoGu7fmB3cz9cYZDqiJdmaaR5iJQ7W92NM
   FJs97e7OrYAmyjvpCk6kYvaMSTEUIJCjMuyCPYh8/rsjFk0u93VSivTrf
   g=;
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
X-IronPort-AV: E=Sophos;i="5.98,333,1673910000"; 
   d="scan'208";a="102270499"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Apr 2023 14:10:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E0EE1E7315; Mon, 10 Apr 2023 14:10:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4B299E72F8
	for <cocci@sympa.inria.fr>; Mon, 10 Apr 2023 14:10:15 +0200 (CEST)
IronPort-SDR: 6433fca6_B6pxNTtjbuGTuqTHe3xTVayAm+37apBg/ifQ1ovhqBeCTXP
 CI/p8TjPx8g8K+fhnrxavB3CDf3H/WkDLES3WDw==
X-IPAS-Result: =?us-ascii?q?A0EcAACB+zNkhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItdVYvBAtGhFOIHokShDCObIhrgVaBQD4PAQMBDT0EAQIEAQEDB?=
 =?us-ascii?q?IR/AoU9Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECE?=
 =?us-ascii?q?AEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RICDTo+AQICASMdAQERJw8LGgImAgJXBgEMCAEBgnoBgicBAw4jBwyrNYEyg?=
 =?us-ascii?q?QGCCAEBBoFAAZpKHywiVIFeAwaBFC0BjQmELgInD4FVRIE8glMwPoJiBYFdg?=
 =?us-ascii?q?1uCZ45hi02BNHSBIA6BPIEEAgkCEWuBEAhqgXlAAg1jCw5vgUljTIF7BAIUL?=
 =?us-ascii?q?SUEDgMZKx1AAgELdT81BgMLHwZYawIJIxETBQMLFSpHBAg4Bhw0EQIIDxIPB?=
 =?us-ascii?q?iZEDkI3MxMGgQYLDhEDUIFHBC9cfAoGS5wLgV2CLIFfgRjDCTQHgiqBVoFZD?=
 =?us-ascii?q?IoNlQAGEy+DapMfDgaSJZdzII0zlF+FbYFjOoFIDQczGiSDNk8DGQ+OIBkeg?=
 =?us-ascii?q?zszj0g/ND0CBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:VXd0xq7iu2ViYtXyGAPXwBbXdLJyesId70hD6qkDc203TiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ856U
 4KSchD4bPLfDpHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,333,1673910000"; 
   d="scan'208";a="102270496"
X-MGA-submission: =?us-ascii?q?MDF2fhZeM9hwTr5T2MxKA5nXQjMRYxL4Yyy1Dg?=
 =?us-ascii?q?FXrWMOG6b/iPBC9VEpN0Le0z+h2VhiYXRRqSLOeOPLKmViDJ0OayFBfd?=
 =?us-ascii?q?+b3tghHaqpKKcOCl0RDpuwH1P6wVVRYAuKvTbX9N1Mvh98r1KXTYOK3B?=
 =?us-ascii?q?2mAE36C8zJHIgME46A0dwRzg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 14:10:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681128614; i=markus.elfring@web.de;
	bh=bS8QjORlZKUZXsgSamZlzVdWrcxrv/z1xHV8t+z+COA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=CEsJGDrEWbugyIEw/l/wy8GvsacrwPZTxJ2kRdNSiOoBUvcEWtKTCdk8fIdLduvar
	 lVvS3pkTB4vkCRzGJ4hMBVpYQukdk15tPbkEsWo0nD6/+hWuV/EM1XZqUgUUtVwo8x
	 ZJWXfOnkz/7dOQFK99OqYfRCJXPdlxTA7cWl2hrcyImBf5Pue8htpOK7L1tX+vMXJN
	 F/e2Cmn4tXGb3HxH10C0XYAXJpKMaF47ZFZm79bXXKJqifZqCR8vjQYnASAjvLYzWj
	 jS8BMtuiyDKqQgEBHLR+SPno/cCblWEzJuvYu3V9Ld4VbokfIMpBZ4THlqDn2KFqah
	 KRf2vyB1maDig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNOQy-1q0bHg1Uza-00P5Lo; Mon, 10
 Apr 2023 14:10:14 +0200
Message-ID: <31b51efc-afbe-ec34-255e-9df60983ec3d@web.de>
Date: Mon, 10 Apr 2023 14:10:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <alpine.DEB.2.22.394.2304092044020.3028@hadrien>
 <95caa4c1-2455-2733-ef4b-3ab07783c725@web.de>
 <alpine.DEB.2.22.394.2304100824510.3387@hadrien>
 <2de88997-0732-d0dd-5178-f9d42b5a3be5@web.de>
 <alpine.DEB.2.22.394.2304100959310.3387@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2304100959310.3387@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+IgNVhuNpe9XLJIxBe6ElqT9GrAzijNAeCOgBVwUSTfVKAqAFGi
 lwWuf8RJShgzHTFitAJJlbPH3HSdW8qDblUvj2C9fysJf3MuhGi+ShHDwzNy7TLhZDc2VZj
 Fv8PY8BPmufeS/UO5bn27CAyCMYtjfzHPCXlLJBJ1jBAUVSDV+vqkZLVzYIwg6/gz7NrSEo
 TS52aw7FUsAIXb5EbcOmg==
UI-OutboundReport: notjunk:1;M01:P0:llR0x7g3G3Q=;4RtGs4EVnPKRTmysnorDXD/aztz
 4Gg3N2AuZWiNNjQZbyTsA7uKlJEaGpSg3YC+x1BwoQod5g0WTBmT3V1zqLdDZdriDMf5NflaY
 lHUo55McBG53L/beCzopnDBsuMpr7ykI+H/pbZLqkjZxd1jF0WLYHYu2beKiAbnzlHlZ+YKzH
 u8s/R9KQbKubUD3BwkLogxd8at1JkbwoYcs9H378X786lMoxmMoIipZifRtF5U+Y8zhGznG8I
 H++QcOYEZbCW2YrW8TKIY0cBZWVd/83YyA6a77QzwpMoiRIu/zDzofPFp8xUgA9xK0sWiDj0D
 dgOsNS4+xRsxHJuXDOXDnf9se8eJ3fVUW1LqFuIJIId/aVY3+Z9ZrGwXk4D++GzvFBgD9usxv
 mkEuzBEomDDgHum1UAK1ImpUQsr1aDAIoXbhwclSeQh3etbc1vQdKqN44LPC1zaT5kpxzLZ38
 qMQbVi8ceN6r1f7vXkahfAIcXjIG2ZgiPfAH8zlwFqjKshpJ0e/4m86RSO6m3VF3FZ1PHX4zz
 nINGHvpkQMt890ky9G/6WhoNU7YlaXcZEb82+Wd0b0JM8J0A4Vb75uVFjwTR2vjTnH5d0Gje3
 mJqDH6ZDFh0ppQtkmElo8WVZDV94f/nuwCj6Plm7KBSaSEoOqV6f/GJNXz/8tmWJJtzzBblbt
 Y9zJCAOkrRdTWyUJ/iRRIh1jGx18TeriUEDwyHG2sU96Hjf7M6RS/Tia1BA4lmQ2UfnY1bsMQ
 ovJTfsZzz43osFe62sZ+2jWXewtOaMCywAFq//PMxLsTx69HWP93aZ5ETeefYiEjm2+UpUChm
 G/79fWynXktQaUkx3cX2yC9YslimnpiY91mC94Wgu26MfXL4TJX0G3fNQ31w+ddYX14KODbp/
 JjwTLzPYflVMSXFVYT0+32p17oRZnHY7lHXC7PQ2gYrk8DyIKUrRVzFeS
Subject: Re: [cocci] Reconsidering pointer dereferences before null pointer
 checks (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1021
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/31b51efc-afbe-ec34-255e-9df60983ec3d%40web.de>

>> https://stackoverflow.com/questions/25725286/does-taking-address-of-mem=
ber-variable-through-a-null-pointer-yield-undefined-be
>> https://en.cppreference.com/w/c/language/behavior
>
> The statement:
>
> "... &((*ptr).second) which dereferences an object instance pointer"
>
> is not correct.  &((*ptr).second) does not dereference *ptr any more tha=
n
> &x deferences x.  The semantics of & doesn't work like that.

Does the usage of the operator =E2=80=9Cmember access through pointer=E2=
=80=9D (arrow) mean also
a dereference in comparison to the asterisk operator in the C programming =
language?

Regards,
Markus
