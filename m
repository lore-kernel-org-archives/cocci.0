Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC96C54E58
	for <cocci@archiver.kernel.org>; Mon, 25 Mar 2024 12:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fbowCaK1uV5aTj8SEBd7b4OV/lG44+S28x4uvT63qus=;
  b=HncQW1FIwJGpHnZIDbxiemduryGRfQj1LiQR+NI3k816RBGV46HOI2yb
   ZFixE/CwAsoGeQMsyuMuyqRC4tZ0VU/+I0P+pbFTuKhrOic48qFyGgfn/
   OaE7leFu4B1LkKkYwIBeG0/tr0eq07sa2lBK3tEvsn0Jgh2SPAAkF4fEK
   g=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.07,153,1708383600"; 
   d="scan'208";a="158303654"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2024 13:20:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A5A3BE0D9F; Mon, 25 Mar 2024 13:20:56 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A3A1AE192E
	for <cocci@sympa.inria.fr>; Mon, 25 Mar 2024 13:20:49 +0100 (CET)
IronPort-SDR: 66016c1f_/Q4M6OvH2ZLlqCjurxzSqj9cTN6JblRw1b3op77inSitDRA
 6reYmFwkiXvWqL23SlNFm6osMOs7z27h3qjmViw==
X-IPAS-Result: =?us-ascii?q?A0FbAABfawFmhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYI4fANTMgQLSIRWkTotA4Q7l3aBVoFAPg8BAwENOwYBAgQBAQMEO?=
 =?us-ascii?q?IFTgi5GAogFAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBASMXBw4QJ4VsDYJnARCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwINO?=
 =?us-ascii?q?kIBAQECASMdAQERJwQLCxoCJgICVgYBFAEBgnwBgioBAw4jBw2yLIEygQGCC?=
 =?us-ascii?q?gEBBq9cHywiV4FhAwaBGi4BiCUBhXWEPCcPgVVEgTwLgkcxPoJhAgKBXoNbg?=
 =?us-ascii?q?miCF4M3hT6DK4pLgmuBXIdwVH8cA4EFBFwNGxAeNxEQEw0DCG4dAjE6AwUDB?=
 =?us-ascii?q?DIKEgwLHwVUA0AGSAsDAhoFAwMEgS0FCxoCEBoGDCgDAxJJAhAUAzgDAwYDC?=
 =?us-ascii?q?jEuT0EMUANnHzEJPAsEDBoCGxQNJCMCLD4DCQoQAhYDHRYEMBEJCyYDKgY2A?=
 =?us-ascii?q?hIMBgYGXCAHDwkEIwMIBAMrJQMgcBEDBBoECwd2ggCBPQQTRAMQPnSKFgyBC?=
 =?us-ascii?q?IIrgXkphDwIAy8DGSsdQAIBC209NQkLGwYiAR0CpEABgl2BAj8gAi6BDl0CK?=
 =?us-ascii?q?5JhHbIRNAeCNoFggWEMih+VIgYTL4QFjHyGNQ4GkmWYYiCNU5V5hReBawUug?=
 =?us-ascii?q?VwzGiSDNhM8AxkPjiAZg2Ezj0dCNTsCBwEKAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VUIeA==
IronPort-HdrOrdr: A9a23:Ue8joqqn6/6t0B4R8tWAKtgaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3ANl0pEWkNgJWC7Z2Sr56QyN1KgBLXOVPTxmjKLVG?=
 =?us-ascii?q?qMiVGbYaldQC6/b1Ws9U7zg=3D=3D?=
X-Talos-MUID: 9a23:c4sarwXb06uIsdTq/DnzljZ9JeV337qvGBgxnMscvNiaMgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,153,1708383600"; 
   d="scan'208";a="158303484"
X-MGA-submission: =?us-ascii?q?MDHqPzNqRQJY+JOwMG0xq9aZVil2welq/0bxkp?=
 =?us-ascii?q?Unj6IBKnWqbDu7U8it8i7ug3lIU7Hb/smtftVrdFnarqm7c1hWEyX7EQ?=
 =?us-ascii?q?Ka8YwqS0NtizefoPWuso6lhpIUHctY6rqxlp0V3mSy9P3EW2TCLqHed+?=
 =?us-ascii?q?2qO9QKT27ZVmr2slb5B/T/vw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 13:20:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711369244; x=1711974044; i=markus.elfring@web.de;
	bh=fbowCaK1uV5aTj8SEBd7b4OV/lG44+S28x4uvT63qus=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=HjKgMrMvEtIO1OE09Nm1Z1E2yScl76Qf/vDJRNNOJyFCL6QYtigEIRtBWojgVTqK
	 KQDA+X1o3AbIzKMtYg9AFGZDmSX9wq+vACpmyB0iSg79MJ21SdJxoMiiamPrefzaF
	 kFy7yTfv4XtZWLN9UaOkzPXwXVbICmUA+gBjVkQF5mELPK8kYxKNoUinxusQuFLBf
	 2yFBFN9fjbYjGT2PrDOxG0bk/fVEOfKpm4GSaab6Eb6jEzXKqW8owZlkj+JLPWZvY
	 m5iNGCAVYGQOr8up647CBmMLdntkQbTS+0gAaOTna7VgswAuO8TPWm7SWek61XVBM
	 cDNW+/d8Mq03+57icw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MadzU-1sQoDu2d8E-00c99S; Mon, 25
 Mar 2024 13:20:44 +0100
Message-ID: <cf2d5224-3690-4e80-895f-b0a950a5d7ed@web.de>
Date: Mon, 25 Mar 2024 13:20:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <d5250894-dab4-4729-8165-a9b70844c8d4@web.de>
 <9f199353-3997-858-3858-893848adbf9d@inria.fr>
 <bd02498e-a97c-443f-b2b7-a77e932079c7@web.de>
 <52f9f4a8-ba34-f6ec-9bb5-1b96d5fb2674@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <52f9f4a8-ba34-f6ec-9bb5-1b96d5fb2674@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RbtOOD+WjAqrNJNZkP0SANeM2HqgoqJQ8V9HSsxN1sv9URYb20O
 sdY9qZWaOYID4AWmlrTLfv7PYsQqwTl0btaLPodIVLLIc9LWjc6Wq87uK6NKenyGWjc9aHV
 AuUkJKqZH6vnZZVVQwgpWAsaPv30zHQSRD4X1haLhmGUGTIpLiraeSsip2obC1dcldSSVeK
 E2CyILYiA61KQZBhlXQug==
UI-OutboundReport: notjunk:1;M01:P0:oKEV0JEzhY0=;4eWJr2w4P7UdgY3kJAXPZd/3BYL
 20dobnnhoL59k/YqkHcJVDQ3SaPQm++6fe0jNLTzebbZ+nIzwJQkhLzWT28rmw+fFQhkTNa54
 zzJRm0002Dcla0rfcm7F3KdZ1kz7ETu+E1zlDBEnVpwcvb1f3Qxv/OuNKSeGaQHcY3hmZYiWF
 DANJxpHzcEJk5wZ2R4tepz5Js5Rvbmr5FfDMcnhnzZHnNcZ9bPv0aMw359nb2vSdKn6T3F2uM
 10yVOwOkJzSA6RaxqMpUUnGodZ7WSfDmZUHbWOLFFkRjbY5tXXMBE/lr6nxtN7LZQX48Ij0Db
 yaLsHCP5jYhN7R1iD7XTvXeSgUcZy+m2QSUi2QJsS4jRGMcIvNLlt3ou0zm1cOvbL6EwCbIxw
 9jfrzSQlAK2kWpgwmzaAAYtSXYetxr3SvFhQ2Oiu62JuGkmCcjacTJYkV5v3ofgGscub8JqO8
 rTjPWGuH4xRyfN+pXQvfF+eTyYDDPYvj8njBqxGPsgj8iY/lCAZCLcapw6fYm0mgRz4d2LiWi
 tg4wQLeqJJi+Drp407exbpJUdwJVFPY4Dy/N0JG7sxC5fmYpcl9TmQ2hrcKsVLfXNyPYTtvrU
 UOevpxiIjsoePNJ5GebuP3JI43rzUaDVYSgpJXWOJOccdVORRw1H8H1NRVo4wa8HjnkKhYC5W
 V+caC5oc4d6C4WBTJdkaMm08/ooE63Sp5nQScMIsb9fUsbEjomMcfclHeHJExZs5TQkRkNtkt
 UwBSuV1zF4BtKliegZjuSy+9tAaPL1SdwHcD9eZdEzKsqag0X4FybCAzF+P+SY7ehIKK+UKIg
 wpY0V51GVbfi8hh6pnUnIWwbUK8InphTHrQfLALR6WLy8=
Subject: Re: [cocci] Improving support for argument lists with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1619
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/cf2d5224-3690-4e80-895f-b0a950a5d7ed%40web.de>

>>>>   Improve support for handling arguments of function-like macros
>>>>   2024-03-14
>>>>   https://github.com/coccinelle/coccinelle/issues/362
=E2=80=A6
>> How many programming interfaces can be shared by the Coccinelle softwar=
e for
>> data processing according to macro calls and handling of attributes wit=
h arguments?
>
> Coccinelle makes no distinction between macro calls and function calls.

I got the impression that case distinctions should be enhanced here.


> But if this is again about your question about non-expressions in macro
> arguments, nothing is going to happen.  The issue is rare

I suggest to reconsider such a view.


> and is not a priority.

Further improvements would be nice for several issues.


>> See also another related clarification approach (from yesterday):
>> Fix a parse error for the addition of a special variable declaration
>> https://github.com/coccinelle/coccinelle/issues/363#issuecomment-201679=
4266
>
> I don't see what that has to do with macro arguments.

How would you like to handle argument lists for attributes?


>                                                        Please don't mix
> issues in a single message, especially when the message doesn't even mak=
e
> clear what the issue is (giving a link dones't count as making it clear)=
.

Do you find a referenced message more interesting for further clarificatio=
ns?


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --parse=
-cocci reduce_scope_for_smart_pointers_in_ice-9-20240324.cocci
=E2=80=A6
warning: find: metavariable release not used in the - or context code
=E2=80=A6


Regards,
Markus
