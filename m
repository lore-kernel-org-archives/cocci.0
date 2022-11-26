Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E468C4332F
	for <cocci@archiver.kernel.org>; Sat, 26 Nov 2022 10:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Vs0FmpG+cxeu27JOaDyUD186n8JAXgTvQJFkkbqmK6c=;
  b=F1dOYRLVeSwzHQR2MLoWl1ae8tBBv3Tv6pRTUT4Tt7D9uSTgJ2BiRxE0
   9KuAmXpk0s0fcGJ/EyTUlCVbEdqut2EyG7AZO4ByZKHK3lcHx2g99qiKW
   HBKAdyOidqdvHBVkNMVq1lOOGjyH+5a0E0tQIqFc6ShdjEV68cHCOHYJl
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
X-IronPort-AV: E=Sophos;i="5.96,194,1665439200"; 
   d="scan'208";a="80172799"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Nov 2022 11:21:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 77979E00DA; Sat, 26 Nov 2022 11:21:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F41B4E0010
	for <cocci@sympa.inria.fr>; Sat, 26 Nov 2022 11:21:01 +0100 (CET)
IronPort-SDR: 6381e88d_0GTC5w4MeBIbwb8c1mdsX6t1eDvm3ynZ70YqUddh/dlirH1
 AF+7G1ZEvQ5Ex/P+V25INaj1h844SjBldEPUcGw==
X-IPAS-Result: =?us-ascii?q?A0EKCADa54FjhwQP49RaHgEBCxIMQIN8gVouBAtFhE+Od?=
 =?us-ascii?q?oF3MYQphyGHMIhig1QPAQMBDUEBAgQBAQMEgguCcwKFCAIdBwEENBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaCRcHDgULBSKFaA2CN?=
 =?us-ascii?q?SkBdYEIAQEBAQEBAQEBAQEBAQEBAQEBARYCR1M9AQICASMdAQERJw8LGgImA?=
 =?us-ascii?q?gJXBgEMCAEBgnmCbgEDDiMHrxyBMoEBgggBAQacBh8sIlOBXgmBFCyMZoQwJ?=
 =?us-ascii?q?xCBVUSBPAyCRzA+iBuCRSKOeIlnJQQOAxkrHUACAQttCkUbMScOCR8cCgQXD?=
 =?us-ascii?q?QUGEgMgbAUKNw8oL2QrHBsHgQwqKBUDBAQDAgYTAyACDSkxFAQpEw0rJ28JA?=
 =?us-ascii?q?gMhZQUDAwQoLAMJIR8HFhEkPAdWOgEEAwIPIDgGAwkDAiJVcwIuERUFAwsVJ?=
 =?us-ascii?q?QgFSwQIOQUGUhICChEDEg8GJEUOSD45FgYncw4OEwNdgWkENWaBCwpgniSlU?=
 =?us-ascii?q?p5cgQE0B4IfgU2BTwyeZwYTLoNlAZMJDgaSFh2XGiCnWIF5I4FcMxokgzZPA?=
 =?us-ascii?q?xkPjiAZhAyKLEA0OwIHCwEBAwmFRwEBhFYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:k8gm0KHOlREreVAcpLqENseALOsnbusQ8zAXPjNKOHlom6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK5yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4xgPM
 xbE5SWZueAbmRSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,194,1665439200"; 
   d="scan'208";a="40861018"
X-MGA-submission: =?us-ascii?q?MDEMsI+bndYHLwLq7kRLp2O2RwSZ52g5xqhpSs?=
 =?us-ascii?q?i98uvcIOPi66CmF7W50iH2jTJtcpcxbMHzMzfO73Tkdd0vLINwszWIDc?=
 =?us-ascii?q?d/v6pcIvn0DLddHO9ezJct7AIAQ+bdwaeD82YQaikJ/GdrGT0Xg1XoKl?=
 =?us-ascii?q?Vi+hIZt9opGXB+1dzuCBkpTw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 11:21:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1669458060; bh=Vs0FmpG+cxeu27JOaDyUD186n8JAXgTvQJFkkbqmK6c=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=or2sDrNQn9IzcgJbyKLFUIMInWfA4IySmG2G4zeV/2lGh9AIW6uymijHzzsOPVh2E
	 +OoMgMngdxNpkGWOycrLlk3JcMdCBB2FalG4guPuw7w5LneRyElvmkAxjZkmwy48X5
	 tSRcslmQwHW/HUPO5O+irSij/+5DcDD1bzzoxic+QzqwXpPo9aM69dA1bjY8j+HBt8
	 DU5PBBZ7xbd8dicJe+VMPwQyGp7E00ntTIQoYxA1sDt23LBFzLhtscZuVt/TykSxZC
	 +TacPYUsfoR7yAv7FM1/NdzCaIynR/nU3UzHF400/R/R0z+DvGo5cDn3OcvdkUBI7v
	 OF1W6jCFndEuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeUXg-1oQdwm1uNQ-00aXsO; Sat, 26
 Nov 2022 11:21:00 +0100
Message-ID: <79bb70c9-3257-504c-7d52-55ccaf51f640@web.de>
Date: Sat, 26 Nov 2022 11:20:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <dce20c86-de6b-92ef-3bc3-af39ca99b5c4@web.de>
 <alpine.DEB.2.22.394.2211201641340.40755@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2211201641340.40755@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1Bc4EWRF7rYlCGyByumiJSnPLt96t4ShpZ57eFX9jNjeInpERWh
 MLQAgnM/RGvuZLPIJ3TMHuNAaLYEVXSeYJ+5+xW67tDv/wdaHTNtRefKJ1cE6xx78H77Ycx
 XWLgOuSab1FzLCepRkBHxcV+Q7YgCDEdLkjOEuMp9omxsns4C5pvbyFFtlZUipzG2/dQYPe
 cN2SW0i36K+mZ6fd7RqwQ==
UI-OutboundReport: notjunk:1;M01:P0:h/1Kj7TpwF4=;dDdARSCi+FW/NKM5Vpxfp0wEGRU
 ZuDyx1OZkOs+kk9kFyI3OM0hc+kBLabQkx6NO3Gggm2LQoI4AgMQqlWxPPnaW4oS949lwpOXq
 3j3TuYbmkiql30qlu0j3Oz3wWl4Zen5Q2SC4C4ofp56zaf/MSHUa1PGqDDuRgM52BW+C5/Uss
 vXcBg3Cd2ZHIemjT4i/A3kfN6yXj/Fhv8SZMeEel3RCeMRrG3cl1jQws5c+BkmkTkg7mcvkVz
 6nEmnYPXywc/wRAe6jzDzhzSZD6ySy81Hxcgnb79ApX7g5wGj2PrtoaX7y0ZYwcUkMGDCq0/C
 h8k1XvzWJ/qvX0pfbgJekB/SJNUBgw2f5ygketd1aNvxmVlF5+uBcwUdT/K8tA+L6iVkDksyi
 K7VgygZxqzqldwkpCtZG1HQwu/r8ag5VFWAQ43iUwXQBY9Zwh2T+mfEM9IvtXOlFh0Fh0/8xY
 zfn+R5pM0BYobtIC2KV55YkvcNhQJbTbDdnyRRdjrapg2bEHY7ssp1/yYOPNMZ/Cb65RLtaB7
 nuTUKsBgzVq0meMxprn7r4OVPrq6SS5nT0S2nmuCp9jIGctrht8N2bgKrto9XRFkfIcJNc1Y6
 J9tUnmDelgw2dCD+TDeGfx/aoUUDw2/KlARg2xkVI6m+NUdpaJnWYqf88WcqA+lMjHqmd0Uji
 skJS9iPBJZfFjiIzjW2HqtpXp6ny5DOkyvdZJ0HBbOd+uGBo2FzapUBqazuIgW+ulqwD1hNtA
 nEjpKPD7Yi8sDhKkzTUiwS+X7l8o7SMSusi7/dROG9oKzzBfoFwLQeFquwpWurZgCjHIIYdif
 nuYz8xTxNjGpP6U+fR8sAsyhW5dSA8Y/zv1aZV/FkPTvwdJUsinJ8ABpu2TzRkJqCzdOLW9dt
 Les0dfEf1YvUeQvcZmlQs5e5ljB4JF9Xdb8OlrHzw4cuWLkf4ZQ8FhXbidSFOkGExiU6usPGE
 aMObGw==
Subject: Re: [cocci] Data structures for source file analyses
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 755
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/79bb70c9-3257-504c-7d52-55ccaf51f640%40web.de>

>> How do you call the intermediate data representations according to the involved
>> processing pipelines?
> Abstrat syntax tree? Control-flow graph?


How are preprocessor directives (for example) integrated into the taxonomy of
the Coccinelle software?

Regards,
Markus

