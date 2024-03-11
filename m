Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75123C54E58
	for <cocci@archiver.kernel.org>; Mon, 11 Mar 2024 09:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8X4Dya4eclbMR+5i2aUxcK5qqbonQd7zPmILLlN9wUI=;
  b=PeoTWsps18rg0OwVZmUE3PlHm2ks5v1lTMAxx1JDco7gEGf+G7RgrcGU
   o9QTbhfnf5W0sMkyMuQxctHVE2BR36RcKUchZ5gsjshhCsP734nHNKblS
   /yJ6wrS6EPVScHcZ0PL1AliZsXWkndZb5QIBpT/hFJItsk1quK6VzyJCD
   w=;
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
X-IronPort-AV: E=Sophos;i="6.07,116,1708383600"; 
   d="scan'208";a="155960953"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2024 10:22:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 50743E0035; Mon, 11 Mar 2024 10:22:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0B975E0035
	for <cocci@sympa.inria.fr>; Mon, 11 Mar 2024 10:22:43 +0100 (CET)
IronPort-SDR: 65eecd62_CniepzPRYIT/CxidPV+imxd53Rd/S4sN0p2abLgrPbVpjsX
 eVt/CQPubG9L4dZVwrn/8nNmbUVQiw8Dk7lPsKw==
X-IPAS-Result: =?us-ascii?q?A0FXAADOzO5lhw4P49RQChwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IE9BQEBCwGCOHwDUzIEC0gshCmPRYF1MIQ7l3aBVoFAPg8BAwENOwYBAgQBA?=
 =?us-ascii?q?QMBAziBEUKCdAJrhxACHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBIxcHDhAnhWwNglwBEHcXdDACAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBFwINOkEBAgIBIx0BAREmAQQLCxoCJgICVgYBEgIBAYJ8AYIqAQMOIwcNB?=
 =?us-ascii?q?rB4gTKBAYIKAQEGgUYDgR6sdR8sIleBYQMGgRouAYglAYV1g0J6Jw+BVUSBP?=
 =?us-ascii?q?IMDPoJhBIExLYNbgmiCF4MSKZ1JVH8cA4EFBFoNGxAeNxEQEw0DCG4dAjE6A?=
 =?us-ascii?q?wUDBDIKEgwLHwVUA0MGSQsDAhoFAwMEgS4FDRoCEBoGDCgDAxJJAhAUAzgDA?=
 =?us-ascii?q?wYDCjEwVUEMUANkHzIJPA8MGgIbFA0kIwIsPgMJChACFgMdFgQwEQkLJgMqB?=
 =?us-ascii?q?jYCEgwGBgZdIAcPCQQlAwgEAysnAyB1EQMEGgcLB3iCAoE9BBNEAxCBNAaKG?=
 =?us-ascii?q?AyDDAIFIyqBdxaBAAMZKx1AAgELbT01BgMLGwYiAR0CokwBIoI2gRArKYE1l?=
 =?us-ascii?q?CuCYq8CNAeCNYFggWEMih2VIgYTL5c1DgaSZZhdIItZgXebDIFqATOBXDMaJ?=
 =?us-ascii?q?IM2EzwDGQ+OIBmDYTOEYYpmQjUCAQEBNgIHAQoBAQMJhUYBAYNagUcBAQ?=
IronPort-PHdr: A9a23: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
 oUDQPlXWQ5tfhv/IltoFpoOLcUvNg4=
IronPort-Data: A9a23:36avf6rD8XGpdlwDlJlJSY8JwRZeBmI4YRIvgKrLsJaIsI4StFCzt
 garIBnXaPuJNmP8fdEkaNjnoBgAv8LWmtZhHQtspSxjHyJD8uPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKiefHoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSs/3rRC9H5qyo5GtD5wVmPJingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYj9yuuuTnuUiG9Y+DCDW4pZkc/DKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2k6M9U54cNbEFtrz
 uZDJDYcfxCqmfKPlefTpulE3qzPLeHuO54D/G5tx3fVAJ7KQ7iZGv+Mv4UHmm5twJkSdRrdT
 5JxhT5HSR3aYABUfHoTBog/muiAmXT1NTFVwL6QjfNqvjmNlF0tidABNvLIUd6nZuMLrnyJp
 zv94F+jHCs3HtymnG/tHnWE3bOfxXirB+r+DoaQ/flhi1y73X0WEBRQVF2hoPD/hFTWZj5EA
 0kT5zZosqU4skCmJjXgY/GmiHKK5j8HfvZBKcgB8lqBzLvF4y+HFlFRG1atd+canMMxQDUr0
 HqAkNXoGSFjvdWppZS1qOv8QdSaZ3Z9EIMSWRLoWzfp9PHPjekOYv/nS9F+DOiqg9ezFTyYL
 9G2QMoW1ux7YS0jjvvTEbX7b9SE+8Shoukdu1u/Y45dxlklDLNJnqTxgbQh0d5OLZyCUn6Kt
 2Uels6V4YgmVM7UzHTcHblTQevxvJ5p1QEwZ3YwQ/HNEBzypxaekXx4um8gdC+Fz+5fImGyM
 BO7Vf15tMYCZhNGkpObk6rqV5Rylvi/fTgUfvHTaN1VKoN8HDJrDwk+DXN8K1vFyRB2+YlmY
 cnzWZ/1UR4yV/47pBLoHL11+eFwmUgDKZb7Hs2TI+KPiubFOxZ4iN4tbDOzUwzOxPjV8V2Kr
 Y8GapviJtc2eLSWXxQ7OLU7dTgiRUXXz7ivwyCOXr/dfFhVCys6BuXPwLgsXYVgku4H3q3L5
 3yxEAsQglb2mXSNe03AZ2FBeYHfe891jUs6GigwYneu+XwoOri04IklKpAYQLgA9c5Y98BSc
 cUrQcu7L850emz1wAhFNZjZh65+RSuvnjOLbnaEYiBgXptORD7p297Dfym0xhYvExiYiMoai
 J+j3zP9XpAsaVlDDsHXSfT31HK3nyEXt9xTVnvyAOt4WRvT4q11DRfun9kLI80oAjfS9Auwj
 gq5L08RmrjQntUT7tLMu5Ghk66oNOlPRmxhAGjR6OeNBxnwp2aM79dJb7eVQGr7SmjxxaSFY
 NdVxdHaNNksvg5Dk6h4IoZR4ZMO3fndjJ4E8V08B1TOVUqhNZ14KHrf3cVviLxE9oUEhSSIA
 HCw6vtoEpTXHvj6EWwhBhsvNcWC8vA2pgP8z9oIJGfC2Ssm24bfDGtzOUGXhT1/PYlFFtov4
 d0ctf487y29jRsXMei6sB1EylTUEFs+V/QIi5JLJq7qlQsh9X9aa7P+FCLdwc+CevdMAGYQM
 x6Wg6vO3Ypd4k/4d1syCnn/8u5PjrseuB1x7QEjJnbYvvHnl/MIzBlq3jBvdTtszzJDyPBWF
 lVwEk9IeZW14DZjgfZcU1CWGw1uAAOT/mrzwQArkFL1YlaJVGuXCkEAIseIoV4k9lxDcghh/
 L23zHjvVRDodprT2gowQUtUlOzxf+du9wHtmNGVIOrdJsMUOQHau66JYXYEjzDFAslr3U3Om
 rRMzdZKMKb+MXYdnr0/B4ykzo8vcRGjJlFZYPRf7agMTHD9ejaz5GC0EHqPWPhxft7EzUzpL
 PZVBJNrdw+/3yOwvDwkFfYyA7trrsUIuvsGWJ3WfFAjjZXOjwBUoKrx9zf/jlAFW99Bs9gwA
 aKPeiOgEl6/v2p1mWjMpvYVY2aTPII2Wyzh7s+I8cEiNZEKgMdze24cj5q2uHS0NlN83hS25
 QnsWY7f/9ZA+69NwbT+N7plBhqmDP/OT8GKzVyDiMtPZtbxLsv+jQMZhV35NQBwP7FKedBIu
 ZmSkdzwhmXpga0XVj3Hppy/CKV538W+c+5JOMbRLnMBvy+jWtfp0iQT6VKDNp1Fv9NM1PaJH
 zLiRpOLSucUfNNByFl+SStUSU8dApuqSJbQn3q2qvDUByUN1QDCEsicykboSmNmbQ4NBYz1D
 17lmvSp5+0Alr92Oj0/O6hEDaN7cXjZYol3R+2p4HPcRiOtj0iZs7TvqQs45HuZQjOYGcL9+
 tTeSgK4aB22v7rSwcpEt5Bp+CcaF2t5nfJ6a3d1FwSaUNxmJDVuwSUh3ZQ65lV8lyvvyNfna
 TuLYGZK5eARm9hbWU2U3Tghdl736i8y1hPROTEjuU+ZA8tzLJ3VG6Nvr0+M/F8vEgYOD4ibx
 RU25XD6eBS8qn2sqSD/+dTj6dpaKjjmKr7kNKwzfwEew/rTPFnS6EFcIQ==
IronPort-HdrOrdr: A9a23:tNvkkK8dcoimGpDCUO1uk+DbI+orL9Y04lQ7vn2ZKCYlEPBw+P
 rFoB1273LJYXMqNk3I+urwW5VoI0myyXcd2+B4VotKHjOGhILPFu1fBODZowEIbheOkNK1op
 0QFJSWcOeAaWSS2vyKhTWFLw==
X-Talos-CUID: =?us-ascii?q?9a23=3AQFJT+mt+TIEmym60N1ORdCbm6IspfCX811L8MnW?=
 =?us-ascii?q?dMnwyRLuEWF+55rNdxp8=3D?=
X-Talos-MUID: 9a23:v2HNBAq73W4SoJUcdVwezyxJNupLxfqeMlEMyK4ZgJOaDwFaOw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,116,1708383600"; 
   d="scan'208";a="155960941"
X-MGA-submission: =?us-ascii?q?MDFqhrEVvkBO+3d7OGBkk1nLRiHhJNElvcmyF4?=
 =?us-ascii?q?++TldE4N+FEpcb2reCbIo90byHNiP+sayINV1Mb7pFw17rGuCfQqgwWO?=
 =?us-ascii?q?G/YhWEhuTOWrRplEG/rwZw7g1QVTctepinJ4kMLNwenoZDysG0jPt7S+?=
 =?us-ascii?q?dWzsHQ9AZzl9HGu0jmx1sWWw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 10:22:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1710148938; x=1710753738; i=markus.elfring@web.de;
	bh=bmPneYWZYr5xD73kJBuCxjKs25l7SFeaq3285oeFlNY=;
	h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:
	 In-Reply-To;
	b=tkS48tPVw4WoFzUZCR+TBz6W86Nkp0vUV0fb2S/Nus507x2bhmJ7OzN5BY9oXIGi
	 y6geboloUcVlSkKC+zdC9710NqTMX9dU9E5VOM4SeKlUTQqTYMlcKJe5VtUbg34e7
	 RcdUMscvczHdK4Xhp4+wamb6UEB+5EiLiGUIDEamwNt/PBH5TpH9xPThvKF1sxJA9
	 ViunLG2WmpH+ifqwnoIueEBX3DXk0leY2wutj8IywN2bTnyjCexjvBWa0q02mdQ7S
	 sh1H8YYa+7ObSyHBY0X9ie8BrxQYUD++NbUq0hidmo7HwfVwaRe18p/5FgN0rnd4c
	 RaNNjsfUcPGmoN8yGQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyvB8-1qwTaS0TI2-00vycp; Mon, 11
 Mar 2024 10:22:18 +0100
Message-ID: <1c8532d7-ee40-41f3-92af-33eca0696834@web.de>
Date: Mon, 11 Mar 2024 10:21:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Alan Brady <alan.brady@intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Jacob E. Keller" <jacob.e.keller@intel.com>,
 Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Kees Cook <keescook@chromium.org>
References: <CO1PR11MB49149F1167679926A2917E0997202@CO1PR11MB4914.namprd11.prod.outlook.com>
Content-Language: en-GB
In-Reply-To: <CO1PR11MB49149F1167679926A2917E0997202@CO1PR11MB4914.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lIwfRe4HZ/mkWiwyaWhs/Xk6gQAlwmBnyTUIndmdVYuqs+nI8V8
 EjMG5MpnSOuRrG7eKgliN32tpvZbtxYXVgJLXeb2BHth1P7PNJ2xn6JvEkpMzwdOqamsyTZ
 Zl28WRFTqB1QTlNVxwGbc6LcsJ7Ipf7ShHILO9thP9sx4IJuINd9q4UOL8voQM8VniMQQJp
 u56qH32e4hRumHu7kRT4w==
UI-OutboundReport: notjunk:1;M01:P0:DbQQtYyPZ6I=;sJuwzBVt1gI40su06Cew3fmv9DF
 0yscvhB9TBPZZaD+hrH/dv75nCECwI+XOn3y+8QVEkjnZzwJM7001M9CD4SM5pKc4E05LPwYh
 Q+xlYaTYX3HAoi6ecAOjcX10XB8thost4Gs+BXNOHAIQyNCweDhIm9BQnRjCRfBBcZJSlK4No
 /BiH1Ooub+CbUikqqxuQJZ3tIBBPPl4j6BJ1mdXquPPTSP4tkgnd0hFVthyeyCaEifFksKpvH
 +mQCrjGMOB7uJT44/cYwbd1aDGd7nkR79tldF/rUxyQQblnhxvPCLWYSY+pzofQbBPTjDMhJm
 BQ3XSpWZ1pOMIwRNk9lC4vFvL/XHNCngRi6agnAuuRWyx0CQczlFj8XGBcpaE0ncK7w8fwGto
 ea+eAAyXxWnoXczTE2O8N6Vm8z7D/V0TS4kLCAF/JUUExkoXiFyMgNHrD382RnWARg/EWMCYx
 6+bff71zpXUDXP98J7FkpMJr9lCw6FVtLpZNjkpzuhgUcsRVrFW+Zvh1N+kwOYTs2zKudZVry
 V/yCHYy86O9vkD9lePr81SPV6j1/59bLDTRU6u8VJn5Q5/+A78J2lEQQsZfQOJYMHC53sZazD
 JAdnBrrMngGTEKWDpGI1CL1twFIxOfCAt/ttGpPEVIHoA2wCB0kjE00rH7wi0RX/A3g35twMm
 XjZAghpSYpBu8JrXiAxap3ejOsRRqdoJJ6NFwjicWB/uwj8aRPecBGKnEzt4tiD3gxEk56oLN
 jIRbWq0yEmqRlaeyRv0e34AAJ2w/+h290ogAo0LoB6nbE69q2OO6DbnQFhgY6+Xk9VwD03EdT
 Lnkpj6Gmaz+p2igqegaRB4y4Pclwi9jRRPr5Jf8UwvOyA=
Subject: Re: [cocci] question about kernel cocci and cleanup.h
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1613
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/1c8532d7-ee40-41f3-92af-33eca0696834%40web.de>

> Hi Julia and team, I had a question about whether it=E2=80=99s possible =
to use coccinelle/spatch to start to identify functions which are able to =
use inline destructors (__free or DEFINE_FREE()) from include/linux/cleanu=
p.h

Some information can be determined for the discussed macro.
https://elixir.bootlin.com/linux/v6.8-rc7/source/include/linux/cleanup.h#L=
8
https://elixir.bootlin.com/linux/v6.8-rc7/A/ident/DEFINE_FREE

19 calls are performed for this macro so far in header and/or source files=
 of
the software =E2=80=9CLinux next-20240308=E2=80=9D.

I suggest to take another look also at algorithmic properties.
There are different development views involved for the implementation deta=
il
if the specification of repeated pointer checks would be needed for the th=
ird
macro parameter.

How do you think about to compare design decisions accordingly?

Examples:
* device property: Move fwnode_handle_put() into property.h
  Jonathan Cameron
  2024-02-17
  https://lore.kernel.org/r/20240217164249.921878-2-jic23@kernel.org

* locking: Introduce __cleanup() based infrastructure
  Peter Zijlstra
  2023-05-26
  https://lkml.kernel.org/r/20230612093537.614161713%40infradead.org

* platform/x86/intel/pmc: Cleanup SSRAM discovery
  David E. Box
  2023-11-29
  https://lore.kernel.org/r/20231129222132.2331261-14-david.e.box@linux.in=
tel.com

* pstore: inode: Use __free(pstore_iput) for inode allocations
  Kees Cook
  2023-12-05
  https://lore.kernel.org/r/20231205182622.1329923-3-keescook@chromium.org


Will any further change possibilities become clearer?

Regards,
Markus
