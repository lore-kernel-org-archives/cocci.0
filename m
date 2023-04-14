Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160AFC77B6E
	for <cocci@archiver.kernel.org>; Fri, 14 Apr 2023 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7nD+hEQaPjnww32CWdc/UR1nStO0xW9DOusf4LVwQNQ=;
  b=YRPJV7wXZHTmWitte4kh2nM/qqZued1PbAqHwlwQWCYhgGvDgEPGFwoU
   PW0Sf+XbOnxt55BsMnnuoyR5CJa2idTHmfs5czZ9KGDxx9/KpYzEdJKDt
   gMZHOTVR0LU2gkIlA3aQOAFstyKZilQL2cWdHm3bJxCL9qL6jP7DI0DYT
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.99,197,1677538800"; 
   d="scan'208";a="103160701"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Apr 2023 18:51:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2322DE0B0D; Fri, 14 Apr 2023 18:51:51 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BE44FE0171
	for <cocci@sympa.inria.fr>; Fri, 14 Apr 2023 18:51:45 +0200 (CEST)
IronPort-SDR: 643984a0_l2WssAmSriMHRZ3O0FrE40DNqVLn9yVDsTPJyeZb5NkkSAY
 UdjLD+X4x/rUJe1N0dwhrIgT0uV/J9lMGuyNHGw==
X-IPAS-Result: =?us-ascii?q?A0FQBADMgzlkh07ASNlaHgEBCxIMQIFEC4IudVYvBAtGh?=
 =?us-ascii?q?FORAi4DhDCObIhqgxYWKA8BAwENPQQBAgQBAQMDAYILgnQChT0CHQcBBDMGD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBGAsXBw4QBSKFa?=
 =?us-ascii?q?A2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAg0HMz4BAgIBIx0BAREmAQQLCxoCJgICVwYBDAYCAQGCegGCJwEDD?=
 =?us-ascii?q?iMHDAavJoEygQGCCAEBBoFAAQMCDAJDmXQfLCJUgV4DBoEULQGNCoM2eicPg?=
 =?us-ascii?q?VVEgTwMgkcxPoJiAwEYgUaDW4JniXWFDYtRCoE0doEgDoE8gQQCCQIRa4EQC?=
 =?us-ascii?q?GqBeUACDWQLDm+BSWNMgXsEAhQ2Dg4VJQQOAxkrHUACAQs7Oj81BgMLIAZWa?=
 =?us-ascii?q?wIJIxETBQMLFSpHBAg4Bhs0EQIIDxIPBiZEDEI3MxMGXAEpCw4RA06BRwQvW?=
 =?us-ascii?q?oEBBgEmJJ4ocQJSBT4iAiCBc5JysQA0B4IrgVaBWQyKDZUABhMvlwkOBpIlL?=
 =?us-ascii?q?ocwkBcgi0SBb5pMgXkkgVwzGiSDNhM8AxkPjiAZHoNuN1SDVoooAT4/NAI7A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
 eOqhDZJPmQBBaNCShdC6U43feiNnXqI7g==
IronPort-Data: A9a23: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
 w0hoIfv5esRkNiEndjBDAzfYzqi
IronPort-HdrOrdr: A9a23://JiUalxDL1a+HFhFHgVC6xr8x/pDfONimdD5ihNYBxZY6Wkfp
 +V8sjzhCWatN9OYh0dcIi7SdS9qXO1z+8R3WBjB8bfYOCAghrmEGgC1/qv/9SOIVyGygcw79
 YCT0E6MqyLMbEYt7e13ODbKadZ/DDvysnB7o2yrhdQpENRGtpdBm9Ce16m+yZNNW177O8CZf
 yhD7181l2dkBosH6aGL0hAe9KGi8zAlZrgbxJDLQUg8hOygTSh76O/OwSE3z8FOgk/gIsKwC
 zgqUjU96+ju/a0xlv3zGnI9albn9Pn159qGNGMsM4IMT/h4zzYJLiJGofy/wzdktvfrWrCo+
 O85yvI+P4DrE85S1vF4ycFHTOQlgrGpUWSkGNwykGT3vARDAhKdfapw7gpKScxonBQzO2V3M
 9wrhOknosSAhXakCvn4d/UExlsi0qvuHIn1fUelnpFTOIlGfRsRKEkjQpo+a07bWrHwZFiFP
 MrANDX5f5Qf1/fZ3fFvnN3yNjpWngoBB+JTkULp8TQilFt7T1E5lpdwNZakmYL9Zo7RZUB7+
 PYMr5wnLULSsMNd6pyCOoIXMPyAG3QRhDHNn6UPD3cZes6EmOIr4Sy7KQ+5emsdpBNxJwumI
 7ZWFcdrmI2c1KGM7z54HSKyGG7fIyQZ0WZ9igF3ekLhlTVfsuYDQSTflw+mcqppPsSNMrWXZ
 +ISeZrP8M=
X-Talos-CUID: 9a23:iII4BG/pAbhAft8KMhGVv39IKp0eL1zv9nDzIGudJE1sZZ+cQ0DFrQ==
X-Talos-MUID: 9a23:0C1T2ApykyUvpiEE7XwezwsyPudszLyQMhoIjbQbhu2qMHVABTjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,197,1677538800"; 
   d="scan'208";a="103160698"
X-MGA-submission: =?us-ascii?q?MDHFP01c7km6nvFK3rRr5kw1dBT10Y4H1BTZi7?=
 =?us-ascii?q?+dMZVZafJRttTG6S+f9QrW5iUlDzZb/y6eTTlfEG3WTTZDXUUL5Hh7x4?=
 =?us-ascii?q?NYQeIAZ62B1xStbgGcbGKp7gTXBS266MR2S5CdbeXJLZtZVdTWQFU2IX?=
 =?us-ascii?q?m4SePtmIdArcarrpgyXGVF4w=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 18:51:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681491079; i=markus.elfring@web.de;
	bh=7nD+hEQaPjnww32CWdc/UR1nStO0xW9DOusf4LVwQNQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=M6OsQoz23eBPz/1N7QpvDOsXXtowmrywPuLVamntpVSNVfxzcd8+Y9hpdZzoWD48T
	 kjrqc8k+8LoPdexeRC915pgmgVQrXSloqKYkAL/WK1D2tk4mj9QXEiRr31WaQl+lkC
	 LAJLjQwepL4oQMPlnzPq7QjtpkzTccsAGM+PMCq+DApVry0n+hOeDSONCy2sI1OO0C
	 +ycSh1Bf5xs7HO/L8jA7vTWgf+p7xoZNHM48UQHFW3ibYmwd/UGOlLz89TspuuWRf6
	 GoHVX1JrPr6HXw7DSv8rFAS2sGTy6aqp5cFXjocwRQ9Y5fxQq0VANRl2FD0gG4zGQy
	 sWUSKHwavsQBw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3m5B-1pndtE2Oyh-000c7R; Fri, 14
 Apr 2023 18:51:19 +0200
Message-ID: <88f4dd20-4159-2b66-3adc-9a5a68f9eec7@web.de>
Date: Fri, 14 Apr 2023 18:50:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Alison Schofield <alison.schofield@intel.com>,
 kernel-janitors@vger.kernel.org, nvdimm@lists.linux.dev,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <d2403b7a-c6cd-4ee9-2a35-86ea57554eec@web.de>
 <ZDlvunCNe9yWykIE@aschofie-mobl2>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZDlvunCNe9yWykIE@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Th2Vsng4IBnqMEGxDs5NLMWicod2yCw5AlSUK1+Qflo/78XeEFv
 7Psgibs+exN0g0PXs1R94UkZbO24fUu9ZoFj06lqWa6eEeAbqxyRg20tKPNrME6RVLl3pNr
 iOgDclbyPinwzJOtXK5xjVegSIP10k/LOjrHbzF305U4y/dxNkupkFikGuIpjSnmHIRqBqK
 I2IuvDFCGKFgrO9zZnemA==
UI-OutboundReport: notjunk:1;M01:P0:M/nWoDIxv50=;0mCNXib4bKkw1/b34M049Hi5goY
 KihL+6gd2Et/8D5yYeBqaPetLLxzfvh8rYXh3ddMmRdGRlAhijTAYaBZ7/5wlCy+Gu6lgjEgM
 v3wQ+6Tsf89bHi3KigVp/GNJVYJzITFJa7ex++rDgvMRI4wTEmTv3cg9Sta7osGtrBvDCRzi7
 dEDrmG4KVjKzrsD6jsJS3XfTKLyp26aCfAA+7Cj7iXvGwSDxOIV+y0lOs3KLgCZ5zwwARjf7y
 InXwNPFEMxvLs4p3nk6MzKrZ5wKbm3v6a7FOx2Y38tVnhBB7119VWSPLHHgDdmIbMpgwkD6C/
 clwLx09v0OxLqrZRUT0pMOXUw0rlhNdPdunsq5eBvG8H/TjEdNKEOh6Q5TBgkLWlOm6pQyx0o
 mDT2J8z8Tzp9q9l2X+QAVkEn1e9WjOfmsZ6nP5sT4JWmeRBpg/gXu6V1XvJSnPN12JqZ0J/Zy
 xQCmodR3oBgMy8q2Y+zqOru8GTQBeNWGuKcjgzqeG7jGIuRGGyCtR5eh8jILRTr6din4JUIrR
 ssNFdBoPL4umqL2uN83ba7mqnV6DgoYQD13BP4XxDdFJ47ixdv/JaeqFLCbAt3UyJ35SPr2gU
 BO7hZSFHGfHFKS9jYKD3YJT+av8T3nK5A1eOZo8VTZ5UDteNSIXLdA/l9Hl9Un/Uk3IIKQqcx
 2UsOxshok+SlTN20DKZt3bWFc9TYqgDXBEPD5TXMOBcoAVSZ+tgEJ1rZNVypvGOHFP1kd61eV
 sE2y3xqmqG3EPNzjlx1u37u03HiE1q3QrW5EALi+MEiDaAUOJCES27Ck4KdT+CemXPvEhFcLy
 FpMvEYVihEnPwM9wpjPuq7w5pdR+tGU/u1LNHz0YK8Ojk7Rf57Pl3itwYEJwkCm1CPbsFSOeE
 PKpao394P/keV1kVc5cnp4/ShjmYkCqoHmjwV3Wz/ugZ3qfgZlmnnrUel
Subject: Re: [cocci] [PATCH] nvdimm: Replace the usage of a variable by a
 direct function call in nd_pfn_validate()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1049
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/88f4dd20-4159-2b66-3adc-9a5a68f9eec7%40web.de>

>> The address of a data structure member was determined before
>> a corresponding null pointer check in the implementation of
>> the function =E2=80=9Cnd_pfn_validate=E2=80=9D.
>>
>> Thus avoid the risk for undefined behaviour by replacing the usage of
>> the local variable =E2=80=9Cparent_uuid=E2=80=9D by a direct function c=
all within
>> a later condition check.
>
> Hi Markus,
>
> I think I understand what you are saying above, but I don't follow
> how that applies here. This change seems to be a nice simplification,
> parent_uuid, is used once, just grab it when needed.

Thanks for your positive feedback.


> What is the risk of undefined behavior?

See also:
https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+=
null+pointers?focusedCommentId=3D405504137#comment-405504137


>> This issue was detected by using the Coccinelle software.
> Which cocci script?

See also:
Reconsidering pointer dereferences before null pointer checks (with SmPL)
https://lore.kernel.org/cocci/1a11455f-ab57-dce0-1677-6beb8492a257@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-04/msg00021.html


How do you think about to review and improve any similarly affected softwa=
re components?

Regards,
Markus
