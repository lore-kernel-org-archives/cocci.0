Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD15C00528
	for <cocci@archiver.kernel.org>; Tue,  1 Aug 2023 16:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=a3IDI+UmJxk9Br9Tugea/ZQPTWanAlLosdLxycqTVIg=;
  b=iHsVL046JN/t+kunu1CCA0gNczb7CNAhJSriVWqXnonVDt4N+42LhQeu
   mi6MxT5Eyb40J6tF44Hu98MAZ8Ieh1+FaNC7yay6ifKAEiIEUjGHxkbR8
   xJNNzugthcVDsHolR82/O57ticUk605pfZOH4DonBVNjhtsnRvH+cyHD+
   c=;
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
X-IronPort-AV: E=Sophos;i="6.01,247,1684792800"; 
   d="scan'208";a="119849237"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Aug 2023 18:02:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6C49FE0141; Tue,  1 Aug 2023 18:02:10 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AFD9BE004E
	for <cocci@sympa.inria.fr>; Tue,  1 Aug 2023 18:02:09 +0200 (CEST)
IronPort-SDR: 64c92c81_R3/bUJg9ouUZOVqzJrxBE0zzgDMlVKSfOUfVw6wRbCu24km
 gZkhVlyJI77Xg4XSELiHgR5iDylLvWS+o2/JtSA==
X-IPAS-Result: =?us-ascii?q?A0EOAQDgK8lkhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYIyeFMwBAtHhFKPOIF2MIQ4hzOHSYRphASDFj4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEhH8ChkgCHQcBBDMGDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFA?=
 =?us-ascii?q?QIQAQEBIxcHDhAnhWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEXAkc/A?=
 =?us-ascii?q?QICASMdAQERJgEECwsaAiYCAlcGAQwIAQGCeoIoAQMOIweudYEygQGCCQEBB?=
 =?us-ascii?q?q9UHywiVYFfCYEVLQGHfwGEf0ODO3onD4FVRIE8gwQ+hAs5g1uCZ4oChU0DB?=
 =?us-ascii?q?IJniU8rgQgIX4FvPQINVQsLY4EXgkgCAhEnExQFS3MbAwcDgQUQLwcEMh0HB?=
 =?us-ascii?q?gkYGBclBlEHLSQJExVABIF4gVYKgQY/FQ4Rgk8rNjgbS4JqCRUMNVB6EC4EF?=
 =?us-ascii?q?BiBFARLJh8aHj0REgUUDQUIfx0CESY/AwUDBDoMBwQOAxkrHUACAQtwPTUJC?=
 =?us-ascii?q?xsGQQInnjSCOAiDBoEqw3k0B4IxgV2BXQyfHQYTL5cVDgaSMS6HQJA6IKggg?=
 =?us-ascii?q?XkkgVwzGiSDNk8DGQ+OIBkeg3CPSD81OwIHCwEBAwmFRgEBgyaCWgEB?=
IronPort-PHdr: A9a23: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
 9KJmK+hcF+qHPrL8MFaC8WGcaq6
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:xW73mamGGAfijjFJQjEAlYnVy4/pDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AGeVo8WlsRMMTS81cnowBI6nmr6DXOUD74HnSH2G?=
 =?us-ascii?q?VMn5gd5STRByBp/1uueM7zg=3D=3D?=
X-Talos-MUID: 9a23:kVPb1Anx3H7ihk3IiLfxdnpsDdVhwr3+S3wtrowchPu9BxNCZR2k2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,247,1684792800"; 
   d="scan'208";a="62798889"
X-MGA-submission: =?us-ascii?q?MDGrLT9x2M/PAp23bVw9Ao6NcNKz6ynpXseQwK?=
 =?us-ascii?q?3uyTao2RzW7esBSISpFyIHTYfO0941h0bArO8xy9bLHIwhmXgOaHGUX2?=
 =?us-ascii?q?Q+iYQidJPmxQ0T7BUkygRtFI4fOu/HkZx4W39LZYzEugmj0xDvxbiqeL?=
 =?us-ascii?q?pIdudAdLUhADJbgyjVrUGfjg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 18:02:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690905715; x=1691510515; i=markus.elfring@web.de;
 bh=8Xjh5IMQIl3YvO2E7NX7sf9oiiUXQeIOB8oSE3S9vbU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=jVrpwrHriEv18Pk5dDkhspAxz9/FIXHFzgUFiGbx1PoIj4LskgOCHryWB/UT1GPrIfv2Emz
 scxqAJYuvDwEbDMGF4W5szLhIfHsLcjjCDmzrbGqo4XT7EvIaN7L23fIBfAKJ/ScrA+MCDknv
 JNnzCKfhzrkd1pJi/H9YWMnVxLM8WZMb8wce6yiZ1v3HMjWLvbMasVs8I7LeOvfoVO8/yjW2m
 K9YW00HRNJcqGY6dSIAHYBG6smb8WEC3kr0AWgtCPXA97vr+46YWNMwq5Exk3I5k0wWGmSSY6
 onGpDUaY/gpa1kj+vGUKqMBMLNGgS+IzkWR8gc9jdFI/rIpDw7Vw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeDQj-1ptBIL3fzr-00ayNN; Tue, 01
 Aug 2023 18:01:54 +0200
Message-ID: <10a7e830-8cae-a687-156a-ed95ab4c7878@web.de>
Date: Tue, 1 Aug 2023 18:01:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Li Zetao <lizetao1@huawei.com>, Nicolas Palix <nicolas.palix@imag.fr>
References: <20230801094337.4145806-1-lizetao1@huawei.com>
 <526c2701-9659-85a4-aa10-4ce2bb499b18@web.de>
 <a22f1cd0-9a9c-7ef6-f36d-a04119591d2b@inria.fr>
 <7343e191-7775-dbec-265d-6bd67fe50cd5@web.de>
 <8a77bfa1-267a-4455-9614-ef3392e526ff@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8a77bfa1-267a-4455-9614-ef3392e526ff@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AcjMBRA2Enzi7hZyA+JogEwj11nOLID++5DnGgdtmvXjUVDZbdR
 hsblW+uR8UAkze24rCufinqT5T0HiXb+850YypSJzT/ky0WQTXDg5Cu9V9xsQ2bkmHrR6So
 qCrsBB8mTeTPQZ5ThOOLkD2lJ6R0+LsOU9E4tkoDGgGQX037sSKcDfhV5lwzfExPkvEc+PE
 EOF0P9N8dgnqIsZIES6aA==
UI-OutboundReport: notjunk:1;M01:P0:dN58JntkEVo=;1cXGRkfETzDuRlYxAGhS9x0KF5a
 SSmkv0cHUHO48GSWwxbCwnqR6Pb1Us4Hs3rH4lhtJcwUpoS/IVOBKcGfSImFgJ46sJjtF5zSL
 S+3wXkqMgpuFpySxKzZCaUCIJdZS4rqoUj0GpDza2IlQsheNTqSZ/er6DboiUQ4ujeAYjtzWu
 lpSaVtV7CQ+SFnL+f9zwE7UMPIS2Bqm0kjuB+jx7l42SahmU/S4wUr3dg7T8si9kJIqfaF1gG
 kBZGzcdCt7S5i2decWLzR0GTc79diZCU3Sqn+OUZsCkPcUM1Oxi2DaY8ohZVXOR0dE8b/c2bZ
 hNEFfpGvLL226rekxdZaQ60701yQWgmTexJH4AbAfplHudhaaHnQcHW3ooIag4hDSwbvw+iwy
 xyatnDHXC+TM19tYYrsu3Vrr5LB8MHVGrkErOaAC+ZoIFkO3jQJuoHyWFaKRuqcr+bNwdfhB/
 Wz/gQjtaSE9q4Nng0A78nw0FoXZbkhjlceqMiIB/d9Vrd1Ir/w6psL3EDP0LAxr30b6MoW33l
 zPGJ0hAHb8odXcc9vqHcFGZ1EI8yP90xkx1orQ9UUZT+fWHsmjQU0eypsf10Dhl9BEIoMxKRT
 7ppAZamIuXbHwJ5EU0Mou9WIk1cE2M6W369u4zlxNFS0t3IdCGpVhlnEURHxCKJTnyZsp+8e7
 cDefgRtnuF9iFMUQPd9TlpnehQvzspGxA6VZHfqyDZDQfgKWujrjP++Y4BHTshlz0AoXTtnuQ
 s8svTy0Ttp7wI2mWIvhS0g0q5eIYzQASpq0rMIwlKkDdwvT6fHgsHu2VZwMvDFq1f2kB/WfwE
 p1sEAhEsXSjZekyyoS5zSdE51dCngLQfmeqYBEa4qtdRfEPn6iGAbdl7JABID+OhGzv6pGqY4
 X2XDNTrYRXazl1LAPdUlMW4sy/bqBB1j82z3Ycyv1Q7cdhxv23EwSBQjQzuT+EflaxlLSUz3k
 fylSpA==
Subject: Re: [cocci] [PATCH -next] coccinelle: platform_get_irq: Add
 dev_err_probe() check
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1223
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-08/10a7e830-8cae-a687-156a-ed95ab4c7878%40web.de>

>>>> How do you think about to use the following code variant
>>>> for the adjusted SmPL disjunctions in the patch operation mode?
>>>>
>>>>  if ( \( ret < 0 \| ret <=3D 0 \) )
>>>> (
>>>> -dev_err_probe(...)
>>>> |
>>>> -return dev_err_probe(...)
>>>> )
>>>> +return ret
>>>>  ;
>>>
>>> If this style works here, it doesn't always work,
>>
>> I find this feedback not so clear.
>
> Normally, you can't put + code after a disjunction.  Because the two
> branches of the disjunction might cause the matching process to end up i=
n
> two different places.
>
> The fact that you are suggesting to do this seems to suggest that you
> think that the Coccinelle semantic patch parser accepts this code.

I would find it useful if a desired code deletion could be achieved
by a corresponding SmPL disjunction (without duplicate SmPL code).


> But I have no idea whether it does.  It should not in any case.

May it be expected that the matching process should determine appropriate
source code places?

Regards,
Markus
