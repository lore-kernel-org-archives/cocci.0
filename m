Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D853BC25B41
	for <cocci@archiver.kernel.org>; Mon, 23 Oct 2023 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TArumgklnFmt3ixPOVJYyOO/yKczZZnCXskPufDKay0=;
  b=ks4lAkyajddrdkbIYHn0xULdsjWlCda6pG7+txTFFhmRcI+U2OnqQ1x2
   K1xQbyNC5Jjk1BNQ2YcdX93vJ4kAOEZFnvHDPgN8kLzkr47dzRjBOos27
   fNFXhQJirgvT13+WCXkivWhy23R5ZfnWiMSmS2XbZ3axriP3PKO8e9cVa
   w=;
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
X-IronPort-AV: E=Sophos;i="6.03,244,1694728800"; 
   d="scan'208";a="132757365"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Oct 2023 18:09:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E5EAFE0CD5; Mon, 23 Oct 2023 18:09:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3071FE00B7
	for <cocci@sympa.inria.fr>; Mon, 23 Oct 2023 18:09:15 +0200 (CEST)
IronPort-SDR: 65369aaa_SzqyynDV50p0YNeqiJhJ/+sZ2vHYDVIGdLsEAP2HJCf3Ayk
 6rl86dRw937BBJYp8xFxI9bAbAQMYBWfr77FTgA==
X-IPAS-Result: =?us-ascii?q?A0HTAwATmTZl/wwR49RagQmBT4I5B3ZTMAQLSIRTjzyCI?=
 =?us-ascii?q?wOEO4czh0mKRRSBLD4PAQMBDUEBAgQBAQMEgguCdAKHGAIeBwEEMgcOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAoEGE4VoDYI3KwERgQyBHgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBARcCR0IBBAEjHQEBESYBBAsLGgIRFQICVwYVAQEXg?=
 =?us-ascii?q?mOCKgEDDiMHskGBMoEBggkBAQavVB8sIlWBXwmBGi6ICgGJDHonD4FVRIE8D?=
 =?us-ascii?q?IJHMT6DfIEGgxyCaIN1hUKRfl4iBUJwGwMHA4EDECsHBDAbBwYJFhgVJQZRB?=
 =?us-ascii?q?C0kCRMSPgSBZ4FRCoEGPw8OEYJDKzY2GUuCWwkVDDVNdhAqBBQXgREEah8VH?=
 =?us-ascii?q?jcREhcNAwh2HQIRIzwDBQMENAoVDQshBVcDRAZKCwMCGgUDAwSBNgUNHgIQG?=
 =?us-ascii?q?gYNJwMDGU0CEBQDOwMDBgMLMQMwV0cMWQNsHxgeCTwPDB8CGwUEDgMZKx1AA?=
 =?us-ascii?q?gELbT01CQsbBj4CJ512gXeDASeBJFijMaB5NAeCMYFegV8MnyMGEy+XHQ4Gk?=
 =?us-ascii?q?kaYPKhRgWoDM4FZMxokgzZPAxkPjUWFBo9IPzU7AgcLAQEDCYVGAQGDWoIpA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 YmwjQ==
IronPort-HdrOrdr: A9a23:12fZRaqnCcVkFX4yRcHQuMoaV5oweYIsimQD101hICG9E/bo9f
 xG88566faZslossRIb8+xoWpPwIk80nKQdieIs1NyZMzUO1lHHEGgb1+bfKkbbehHDyg==
X-Talos-CUID: 9a23:zOIhomFAKVtEHjEyqmJCxRUQOs4HaETYlnPoMWOCJ3YqRI+8HAo=
X-Talos-MUID: 9a23:0//lHgbGvSkzZuBTlwbz3GlybMRS7qmFKmAwuJYlg+imHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,244,1694728800"; 
   d="scan'208";a="132757354"
X-MGA-submission: =?us-ascii?q?MDGwi42Zs90w+8kqXynJMLcE+BoZ/DowliOgVH?=
 =?us-ascii?q?kGgmRBzvctiHKvnD6wBqIQLlxGSCrDjYE+bBu3FnVkh9CCoijrMbxiQE?=
 =?us-ascii?q?tzL3a1jOi+jYLO0NNdZ3W/1m/rs+Xii2/SRDMtI4315ml8QH3x58H1y6?=
 =?us-ascii?q?33+heBRLeSE9P2E0Dlgab+sA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 18:09:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698077344; x=1698682144; i=markus.elfring@web.de;
	bh=RHtib2Qgbk5jJu3GzzKbWcXBeHjMAGIOmcAfm0dtux8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=LZ4EfDLVLPDnz+G8bUQ5YDS1GlV7+4vITJic05eEm6ziQO+/9x6lLhvLFI/8nwpx
	 rjYgOgs0+aamELP81X0fALNXnWfQZIEV9zSwpF9NvVjjBo94dyxKy4OoEF9Ym63zQ
	 ws9e0uzRK8oXOvMvU5YOf2HkvAOtELL9BQE6axYceqw9cOaOi7w2frwy8nF+0TZjk
	 n/TExQYVdi740TO9qzxmGEe6nRy7mUUjnNR1xJ6Lo7Wiaa+riMzxG/5PVux6c+mRy
	 1yr8HeR55t/ZL5oT6olkPlIKI/TkhhDXOvN34uSgxUAK1xa7NvXZbvcha4eVYHtEi
	 tEWTMcyj1+Ie6dDzhA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnFyI-1rK9oq1lC8-00jCOL; Mon, 23
 Oct 2023 18:09:04 +0200
Message-ID: <5d916926-85b6-4cb3-8972-0417d6220cfa@web.de>
Date: Mon, 23 Oct 2023 18:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: =?UTF-8?Q?Martin_Schr=C3=B6der?= <info@swedishembedded.com>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <CAEqMKof5Ke4yV0KBZm2FW8z-Ct1UHZRDz5=Sd3gaO3a-f4+y_w@mail.gmail.com>
 <6213b47a-3ae7-d316-b1a4-8fb5d3bf9b5@inria.fr>
 <608e77e0-a36d-44ef-a2fd-9c0c50cf61b3@web.de>
 <CAEqMKoco-UjiPu4bwm69t1HexJi0y+cCPEH6NZ10xZCfn36=5w@mail.gmail.com>
 <0352f48a-47e2-492a-a263-1916a7065157@web.de>
 <CAEqMKoeoLmEsxFsTAmF2TQv1DE+SeYgXEYh1OZdfC=vL=q+BoA@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAEqMKoeoLmEsxFsTAmF2TQv1DE+SeYgXEYh1OZdfC=vL=q+BoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JwsMu7YcKdEk8W8+BHpXNixEaRgQP6GQ8c0Z8v4butg8wE3VUBl
 t4SrjHXjfBaU9fzjYk65beDmvKwBeWHYBrznV0mn2SimWWfLkSNU4l2ToxpQvpnV7+F1qoR
 DK7CEEvhHi6R5Xio8WzSYRkPtcBo9+Q5VQrftP7dce4ThT/uZB26v3WayL8ClgLBBt7tuPE
 Z2QicYWgTqa2Ka0lqvQCw==
UI-OutboundReport: notjunk:1;M01:P0:+DBIrkVWPBs=;jyWqavYMM80FQidNqowglcZJmgE
 nrSHTEx81PjweZ0qOfT5MmYwLFPXHxNp2eFe+5M14C49rrWm4EqaI1S3fDVVplcVMJxSCUXf7
 ZqXc7nq41GppnuoYw+f+nyRe2Uny2qo8eeSYbm748oMSrGeTGXXcJ9IdsMlQ52rWIutE73bF6
 T10lr12GyIQpZT4ZR1NB0helJGx1cJAdHd2BVnaU0s3+932g5HaudZ+wUjaMX9L80jeiOvnCJ
 8cUYzACLzeo3Z31ghhsRPmVfMbddLzxJITKfgw7XFnXZU1qddLs3hbtM69DLzuV1zUgcJDAUb
 9i671/6lrMXvV4gxzONVI0Ko7j2wCIvsnKNRwr2IP5lFmWmKDmcyvdXlR1OgS7VdiQvAM5TKA
 20TxZvmC0X/Y8vNu1qxvSnQyvTNjHpqEMISNEyrM+Fl2nFglDpZ5pxPlZNb83OdzXKXPVwbxJ
 MWdquBCJCJk1ZPy08teljx7f5+J9GewCYocIaPqEPBf5eOVjOKsPfTDlOXHNdolsJ6fUszinD
 GL+VBPBJWW5GGAYuLQfcMJZ1hh7mjX1Lyp01duVTlDdlLIFvAeMkKJeXHrnPsIwyurwA1Mj0C
 Cnd63KIYAw9wO2mdCpOUPnqKEJoozH3yTRNVGypN8oy78hlf4xMBa4UdaNXybi6JjROpLW9Jm
 EHDLzHZ2eGBapiObkrAZ2F0IjwKK5Jk9r1MrbGvX8wIiTlPmZ8wl0b5mt3MxJMaP+dJJ+bA+c
 aioh13H7ToUpFWkub4JAzVFID2QX/6b2rVQ/DMYyPLWfsAHRgRsn9DkOVRTZDYwR3GWK720I2
 up22P6g/tzVkg3omhol5yq2Nyy9CamOoeuUSqu7oXS4zhVmeqC5fp04GFnpXUpnrJt9JVWaKN
 n4a/TqVuIUEh3c7s1mVju0frrgo7HN3zdFhAzwNTjKyVNO1jzj+MKkDldV+s06Iu3+hKCsxaM
 cWjDBQ==
Subject: Re: [cocci] Finding functions that do not unlock mutex in the same
 function
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1269
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/5d916926-85b6-4cb3-8972-0417d6220cfa%40web.de>

> I explicitly want to disallow lock scopes that are distributed over multiple functions.

It seems that you are trying to restrict the desired control flow analysis
to intra-procedural means.


> Here is my slightly updated rule:

You would like to achieve something with a single SmPL rule so far.
I suggest to take additional software design options into account
for possible solution approaches.
How do you think about to work with more data processing steps?

The source code positions can be determined for lock and unlock function calls.

* Would you like to perform any advanced data processing by the means
  of supported programming languages?
  + OCaml
  + Python

* Can a corresponding report show how consistent the expected lock scopes would be?

Regards,
Markus
