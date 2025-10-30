Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31A0CCF9F0
	for <cocci@archiver.kernel.org>; Thu, 30 Oct 2025 10:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=T4mdMIYJD64rI3SfecthJkyL4hRE4/9i+B2hh7U0c8g=;
  b=b8HXBwHFlgflGFFQt9tT/aycBOyfkdk5BNWckbtRYC5oRXamwIbbseBB
   7sD+s1LoLZBVkjZ9g/DQ7hluxYH99LbgwoB1/hJTImUzTYylTp/zfUTwq
   8kiKzIrejFc5pipEW8O7kYvoRSNSu7SZOjdhkJX36Bl2S7GHW1ihSmoSW
   A=;
X-CSE-ConnectionGUID: cHDX20JFTROI51z+eJS9GQ==
X-CSE-MsgGUID: 3mXrgztYR7yTVRn+Oks/zw==
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
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246829289"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2025 11:19:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 59F0AE0BE9; Thu, 30 Oct 2025 11:19:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0138BE0171
	for <cocci@sympa.inria.fr>; Thu, 30 Oct 2025 11:19:17 +0100 (CET)
X-CSE-ConnectionGUID: +bVg5d9/SLKfR9066Hno0w==
X-CSE-MsgGUID: L2ajStadTwy97dTkvdkNqA==
IronPort-SDR: 69033ba5_rn/doYmbZ0iCn6PGujQiIG5kUxJuOA4ciTsiVOo1vsd7Lwb
 eqGaQVaaV7G9tEpkaMDCRT2zgNS1GOFyIAp18PQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FBAAAwOwNpgwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0GAQELAYI/ZSNYMwQLSYRVj1KCJIQ7hzyHVYh5gVWBfQIPAQMBDU4BAgQBA?=
 =?us-ascii?q?QMEhQACjFMCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBOgcOCjGGTw2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBI?=
 =?us-ascii?q?x0BAREmAQ8LGgImAgJWBgEUAQGCfoIjAQYQAQMPJwewY4EygQGCDAEBBtpfH?=
 =?us-ascii?q?ywiWYFkCYEcLgGFbIJkAYYng0N6Jw+BVUSBPAuCQAcxPoRDg1uCaYImgQ6GK?=
 =?us-ascii?q?ZI9UngcA1ksAVUTFwsHBYEgQwMqNC0jDzwFLR2BJCIfGBFgPRdAg0kbBmgPB?=
 =?us-ascii?q?oESGUkCAgIFAkA6gWgGHAYfEgIDAQICOlcNgXcCAgSCG36CDw+JEAIBC209N?=
 =?us-ascii?q?wkLGwY9lDODVIJgSpZGr2w0B4I4gWeBZAyfbAYTL5dSDgaTBZkGIqkfgWoCN?=
 =?us-ascii?q?oFcMxokgzZPAxkPjiEZJYN1yyJCNTwCBwEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 TYphwE4bel/rV/R
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:KqGBBaqqA7USww/reaqwjjwaV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: 9a23:TWxaLWOzD39cdu5DGyNZ+xMYS4ceVl7T9iaIfRGYD2ExV+jA
X-Talos-MUID: 9a23:ExhRXQZu+oLGQeBTk2Xlhgp+PctU/LX/V0wxkosKuO+dHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="129482931"
X-MGA-submission: =?us-ascii?q?MDG77W2is+NN26HSy1kEXTcbckBVE8DN16/ZXV?=
 =?us-ascii?q?gvph0PPTY5cn61cTkc6fujaeLYJqFBV9Y0LDYoKApV4GRKuT38+XXino?=
 =?us-ascii?q?PbCjOjv3Hz7cPwf8I8pH4O9P0j4aqnWTGSh82u77B92PHyEq4mu20y/L?=
 =?us-ascii?q?pCFj4R9bB+Z8CSRxCAZNQfGw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 11:19:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761819551; x=1762424351; i=markus.elfring@web.de;
	bh=T4mdMIYJD64rI3SfecthJkyL4hRE4/9i+B2hh7U0c8g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uGbNo7GP6vxBRJN78XTbio7edtpwA+YEsWB/M4CS4+Lf3i0lyTr0MjxZMQI4b5ND
	 45I9S1B5CvX8TpuoXmtn0Qx5GVL2UmOq3BHCrYebj3NCkqKHyv8wuJwy1twdSCe4p
	 0XZa28rxqqTdo/XEDGkeuBd9K3DbcR3QHkl0YKv7j0ryTDN5Ia6mWWfkcYHpamPhr
	 Utnpss+Ik8JxyH7/9zsXksMWn+fyBNr4zzKIl1T6E0O5pPicTEGQBk+v17SARS3zL
	 2p0mE+VKRId+ibBie7UsdhjjTOvJapLDuNAnqWvkUYapC6HaVlDIJsh8itF9bJx+V
	 xSzj74WVMYgU05om/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbCDq-1vpwM31wF6-00lKI8; Thu, 30
 Oct 2025 11:19:11 +0100
Message-ID: <d227e982-d69d-45b7-9388-9082f86af69c@web.de>
Date: Thu, 30 Oct 2025 11:19:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
 <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
 <62441255-45fc-4edb-a8e5-c208b36ca2c2@web.de>
 <53e91f9f-bfe5-5c57-157c-fc456bd430ca@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <53e91f9f-bfe5-5c57-157c-fc456bd430ca@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ywwLXbduOsoW06QN+pXnwIKTCrW+Kfv4OD6ahjFYhG5aJ/X+JeQ
 r8zxsg9Ep3c38PiFcWU3vUkT/fdofAYSJi5EOFMjfIdzbl8JKEZ8zcmCFIZ0ep2vRiSFMNk
 6w/U+Mn3sVYNmhx5s3/+7ZhONaeKFsUa8WojqFFmZjyxkgvc1GqD6/rsk1j2U9aULUL9bqV
 rdE9agOzeoRmmfLLYqJhg==
UI-OutboundReport: notjunk:1;M01:P0:tiqaCECiz8k=;TOFJyoQYE2tdwcd979yiMfRIucW
 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
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3117
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/d227e982-d69d-45b7-9388-9082f86af69c%40web.de>

=E2=80=A6> I think you would get a more satisfactory result by just removi=
ng all of
> the code and adding it back. Then Coccinelle would take charge of laying
> out the whole thing.
=E2=80=A6

See also once more:

>> Another SmPL script example might become helpful.
>>
>> @replacement2@
>> expression object, size, source, target;
>> @@
>>  target =3D
>> -         object; memcpy(target, source, size)
>> +         memcpy(object, source, size)
>>  ;
>>
>>
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/=
bin/spatch --max-width 100 --no-loops =E2=80=A6/Projekte/Coccinelle/janito=
r/use_memcpy_assignment2.cocci arch/arm64/kvm/arm.c
=E2=80=A6>> real    0m0,626s
>> user    0m0,588s
>> sys     0m0,037s


Regards,
Markus
