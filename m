Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89D7CD3447
	for <cocci@archiver.kernel.org>; Sat,  9 May 2026 08:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=SBlONpVl22lLv+n3O2vGycB3jY+9fmqs6cdu2TvsFDk=;
  b=pWhPJjfxS30cnsQW2hhkJ751EoTUzXrqByJxueDPor+DGeDoxwlqXoI7
   4u3Z/hKMOPncQUWKjCGISJDhpe78qRnQYuYCQyU9Vz1MYOOnyP1+Uh351
   9fKU41L+Ok0CShV+5fXuSZC5TKIK/5D8lfaYOF8mP0Po582kr+BFnN2qI
   E=;
X-CSE-ConnectionGUID: NqDc0EQzR8KVmRJO9DI7bA==
X-CSE-MsgGUID: ClHq5l7ZQN+ffXxBgC6hJQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,225,1770591600"; 
   d="scan'208";a="275968221"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 May 2026 10:10:45 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7E7C880524; Sat,  9 May 2026 10:10:45 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7B1C480436
	for <cocci@sympa.inria.fr>; Sat,  9 May 2026 10:10:40 +0200 (CEST)
X-CSE-ConnectionGUID: VxtRKA+tT2WFG+1xWGclUw==
X-CSE-MsgGUID: sQjAZAGYTJyEpsSntRSymg==
IronPort-SDR: 69feec00_s0EiyB2tC6j7PT6JSxA9CFBfN4kf8PZc1zeF0sUQJBeqskP
 4gTPvBx6fi1FzpvaGSw3IuY+PXNof2dx4jGcW/Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FYBQCf6v5pgAQP49RahRqBCF40BAtJhFiPU4ZfjxGIe?=
 =?us-ascii?q?YMVPQIPAQMBDUoEAQIEAQEBAgMBgguQKQIeBwEENBMBAgQDAgMBAQEBAQEBA?=
 =?us-ascii?q?QEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQE7Bw4KMYZPDYJbgSxlCTgBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQI9Cm0dAQERJ?=
 =?us-ascii?q?zQCGA4CcwEBgn4BgiIBBhABAzYHDQa1LoEygQGCDAEBBoFYQVHXfB8sIlqBZ?=
 =?us-ascii?q?wMGgR8uhXKCSxwBBW6KJQ+BVUSBPIYiAQECAYIqgw6CaYImgQ6Oe4FKHANZL?=
 =?us-ascii?q?AFVExcLBwWBZgOBBm4yHYEjPhc0WBsHBYFLhBOBAQGEXngjLwNOgQcCAQttP?=
 =?us-ascii?q?TcJCxsEPYs9HQ+DEVmVeZE8oUU0B4I4gWcFgV8MiQiBJpU/BhMvg3EBk2AOk?=
 =?us-ascii?q?wuZBo4JlWCFWIF/I4FcMxokgzZQAxkPklaBC4NVvhdFMgIJMgIHAgcNAwuFR?=
 =?us-ascii?q?AEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:DA4jYa3TADh5lt4OpPbD5cp1kn2cJEfYwER7XKvMYLTBsI5bpzYEy
 mEeDWzUMqzbZ2D9edp3Odiyox8CuJTcm4JjGwE/qSg9HnlHgPSZOdnIdU2Y0wG6fpSSFho/h
 yk9QoCdd55sFie0SjOFaOWJQaxUjPnQLlbEILeafHg3GUk8EXlJZStLw4YRmpRvjcWyHzSDs
 Nbzp9y3EFK+0laYCEpNg064gE0p5q+aVA8w5ARkO6gW5A6GzhH5MbpGTU2PByugKmVrNrXiL
 wrz5OnR1n/U+R4rFuSknt7TGmUWQqTfNBS5kXFfXa6vmHBq/kTeBY5mXBa0QR4/ZwShx7id+
 v0U3XCDYV5B0pn3pQgoe0Uw/xdWbfQXouefSZSImZf7I0XuKxMAyhj1Za08FdVwFu1fWAmi+
 RGEQdykg9/qa++emdqGpudQassLEtn3BqA2+W1clw73IrV/Ua/sSKH3+ooNtNswrpgm8ff2Y
 s0EdXxwYR6GbxAn1lU/Ustk2r3y2T+mLnsEwL6WjfJfD2z76QVr06X2dvfRdMaLQ8p9gUuS4
 G7Ll4j8KktFaY3BmWDdoxpAgMfUpCHSaqs9JYGa59Nym2aV2lYoGRgZAA7TTf6R0RLuA4kPd
 CT44BEGpq85/02DVcj4RxT+oXievxdaVcA4LgEhwASK17aS/AuTQGQJJtJcVDA4nPEmWQYJ/
 xyVo4nWKxMs6a2qZnmZy6jB+FteJhMpwXk+iTgsYSZt3jUOiIQ0kw6JUdtpVqK45jEUJd0S6
 2HTxMTdr+9N5SLu60ld1Q6e695LjsaRJjPZHi2NAAqYAvpRPeZJnbBEFmQ3Hd4bcNbBFQne1
 JT1s8mZ6ucVRYqA/BGwrBE2NOjxvZ6taWWC6XY2RsVJ32r3pxaLI9oOiBkgfx0BGphfJlfUj
 Lr741M5CGl7ZivyNfcfjkPYI5hC8JUM4vy+B6qMNYQVPsYqHOJFlQk3DXOtM6nWuBBEuckC1
 V2zKK5A1F5DUf45ngmlDfwQy6EqzS0YzGbeD8KzhRe+3LbUIDbfRb4ZORHcJqo0/YGVkjXzq
 tx/DsqtzwkAcevcZiKMz5UfA2pXJlcGBLf3ifdtSMi9HiRcFloMNdrt0JI6Wok8n61qhubCp
 X68fUlDyWvAv37MKCTUS3U6dr/fZItz90w6GSkWOXepxHkRToK954gPd5YMXOcG9c4y6dVWX
 vU6a8G7LfAXcQv++hMZdovYgL15UQaC3CaiHnOCTmAkXphCQwfpxIfVTjH3/nNTMhvt5NoMn
 bKw8yj6H7wBfl1GJ+TLYquNy1iRgyAsqNhqVRGVHugJKVTey6k0GSnflfRtHtotLy/EzT6k1
 wq7JxcUiO3Ogo0t+unymqG2gNa1ItR6A3ZlMTHX3ZSuOQne21iT84tKfeKLXDLaDUff2qGpY
 8dLxPDdbtwDunt3sLRHLrU69pJmuuPTpIJbwD90Q1TNTVCgUY17Lle8gMJgi6xqx51igzWQZ
 H6hwNdhFI+yCJvXK2JJfAsBRcaf5M4QgQjXvKgUIl2lxSpZ/4incER1PjuquRx/NrdFFZ4f/
 vcks8sS9j7noEEYDfebvA9p9kCnDH8JY4M4vL40Xa7pjQsX9X9TaMfiGA7b3oq9bfdUOEwhI
 zGvm6vJgYpH9HfCa3YeEXvs3/JXoIYn4TRm7QYlCQySu9zngvQX4kVgwQ4vRF4I8iQdgvNBB
 Gd7EmZUe4OMxm5Mr+peVTmOHwphOkWoynbpwQFUqFyDHliabU2THmgTIu3XwVs49VhbdT1l/
 L217mbpfDLpXcPp1BsJRk9XhK3/fON16zH9tpirL+adE7k+RAjVsKukSG4LihngWOcapknMo
 8t09+dRN4z/EwMtoJMANorL7oRIFSi4J1FDT8pxo4IPP2XXIw+p1Ra0dkueR8JqJt7xy3GeN
 fBAHMx1akmB5H68lQxDXa8oCJ1orcEt/+sHK+/KJ3ZZkr6xrQhJkZP39wrYtV8JWdletNsHF
 ZPUfDeGD17IryBmpE7QnuZ5O06TQ9oNVCvj1s+brcQLEJMitrl3UEcQi7GbgVScADFFzTm14
 jzRQrDw9PNz77hsk6/HMLRxNy/tJfzdDO23oR2O6fJQZtbxAOLyngIyqGi/GT9JPLEUCu9Fp
 Z7UvPHZhEr67asLCUbHkJy8Fo5M18W4fMxTFunVdHB6vy+zaPXA0is52VKTCMJ2yYtGx8ydW
 QGHRtO6docVV/dj1XRlUXViPChHOZvnTJXLhH2blOuNOCg/wAacDdKA9F3VV095WBIMGaXDD
 l7Th67zyPFe9YhCPUpRTbUuSZp1O0TqVqYaZsX8/2vQRHWhhlSZ/KDuj1w84DXMEWOJC9v+/
 YmDfBXlaRCuo+vd+bm1aWCpUsE/Vx6RQNXcf37xP/ZzjC2mSnELJ6IRPP3qz32SfjPajPnFi
 PPlNQPOyhkRmRxbfB+67NmLssK3GLkVItmgTtA21xr8Vsp1bb9sxJN++y0m73oelv4PCg24A
 Yl2x0Ac9SRdDn2kqSj/KxB7bSpaKivm+081
IronPort-HdrOrdr: A9a23:fvxALa496zDzEYZeAQPXwRGBI+orL9Y04lQ7vn1ZYQdec8yGm8
 3rtOlz726xtN9wYhodcAu7Se69qBbnn6KdjrNhQYtKNjOGhIKXFvAr0WKP+UyQJ8URntQtkJ
 uJXcBFeZPN5HJB/InHCJHSKadj/DG/mJrYxts3JR9WPEBXgthbnkdE42WgYzJLrWt9dOcE/c
 Gnl4E37QZIEE5/BqnWaRl1PJmg1ri77eOfEGV2fSLPjjP++g9Ax4SKXiRwtS1uJw+nr41SgV
 Qt3zaJmJlKPJyAu2yspVM60f5t6a3cIg0pPr3LtiF5EFvRozftX555U7mO+Bg+veGo7z8R4Y
 DxiiZlBN5r43fdOlmorQfgnynsuQxesEPK+Buim2LqpcG8fj4gFMZb7LgpKicw4CAbzZhBOU
 9wrgakXoBsfEn9tRW43cHBU1VRnEyurRMZ4IkuZmJkIO0jQY4Ul5UW+E4QK5sbACfmgbpXTd
 VGPYXi7PNXfFuGb3bf+mJ+qebcK0gbL1OARAwLocaV0ydb9UoJg3cl+A==
X-Talos-CUID: =?us-ascii?q?9a23=3A6RSH02nZc/TJhvt4P+V2QBZabOvXOUPN0E3zCgy?=
 =?us-ascii?q?kNTxWZpLWEE+v16hgrtU7zg=3D=3D?=
X-Talos-MUID: 9a23:weIKewqoxjtVETiPGEgezypbNu5ayoufNGIcvI0dgM+YDxdhPjjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,225,1770591600"; 
   d="scan'208";a="275968209"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGdLV/ctQ1DuWSygyCFnvMHp0rbq1dkJrQlRW?=
 =?us-ascii?q?Tin3KXu6KludLjJxtEpAf0GG3Si7BQ6L/c+BX4OLNKgJEmhwHH1uxtrf?=
 =?us-ascii?q?zrMo3nXBZQAbfrStWsytH/zQRgpySjkcqoAKTSO0gxvT1M9aTyFCPVD+?=
 =?us-ascii?q?m+XwhsU1Nb/CJZ6b6UbXKA8A=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 10:10:40 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc8y-1vfhIt1aXI-00iZ1G for
 <cocci@inria.fr>; Sat, 09 May 2026 10:10:39 +0200
Message-ID: <f359b285-ca10-4f06-afcd-00c6aea0025f@web.de>
Date: Sat, 9 May 2026 10:10:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KCR23HyeQZy+ZIkwZj1NRX0x4P47xXatYh9rKHyRub460DMJ5vK
 tBHMnyzh7PETmt4vNvkA8V2x2WEYwRAjQ7EzExfzl2Od69XPIg3DM+d23ByoKZtFlgb9kke
 D0iIH3Kd8cUKjHg9ADNWsqP5a7XlCvLFjaSE0Ns8yKf54cfVkvAs0Uan0q67N0O8A8tEoQb
 Mf0HFSw/CR0bVFjuraIlQ==
UI-OutboundReport: notjunk:1;M01:P0:peS/qE6OYSM=;Q/sM/yc5pYd3kktdG5emVBT6yFj
 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
Subject: [cocci] Improving profiling with Coccinelle?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3488
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/fplCH1w7YbkeUFRpDvtcbA>

Hello,

Run time analyses are supported also by the Coccinelle software to some degree.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b54d827b8b9627a841c85c9/docs/manual/spatch_options.tex#L762-766
https://en.wikipedia.org/wiki/Profiling_(computer_programming)

I am still looking for detailed information on more helpful data formats
and corresponding documentation.

Regards,
Markus
