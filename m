Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFD8FEA82F
	for <cocci@archiver.kernel.org>; Wed, 25 Mar 2026 07:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9V5EMJE3hpoZhe0iEr4zYHi9h0MN384S4dHfJDnxyW4=;
  b=QFrM+6JZSu3TmUWOVjkld13kjgTi97PqagBufV9ZsZXflCGI/LTgFNUg
   prR0jFvKhLGAeF8y6B+EW3l2OPgEmbPqJkCTjspYi5YKgcM+yG7QtNy0v
   QgoX1VbWw1vLS+1BiRgOwxXDtGWbytKtzmln8e7tJfEIIpi6gDyNu4yju
   k=;
X-CSE-ConnectionGUID: B2dwCSZzRkGqGg89myeOZg==
X-CSE-MsgGUID: TdzUAYtRRyy8ZbwM78fzuw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,139,1770591600"; 
   d="scan'208";a="269364991"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2026 08:42:17 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 568C3812D1; Wed, 25 Mar 2026 08:42:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 809968129F
	for <cocci@sympa.inria.fr>; Wed, 25 Mar 2026 08:42:11 +0100 (CET)
X-CSE-ConnectionGUID: 3l/mYw72Ssqg1J0FNUrjNg==
X-CSE-MsgGUID: 2M0R3DGESo2wQwdYR0vkrw==
IronPort-SDR: 69c391d3_BWfGf//JcoQfAXbGTptj5DxpjMJIH7tM55PwPhHbDYDgIhT
 Fs2DwxV+l6BVwVnNNESP6GeC8gzH0Hfzpok3sZw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EXBgBTkMNpgAwR49RaglkCgj9oH140BAtJhFiPU4Ika?=
 =?us-ascii?q?YNSjxGMSwIPAQMBDUoEAQIEAQEDBIUAAo0kAh4HAQQzBg4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGTw1JARABggcBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CDTpEAQEBAgEjHQEBESYBBAsLGgIYDgICVgYVAQGCf?=
 =?us-ascii?q?gGCIgEGEAEDDycHDa8hgTKBAYIMAQEG2mQfLCJZgWcDBoEfLoVvgmYBiXV6J?=
 =?us-ascii?q?w+BVUSBPIJSMT6CShcEGIFGg1uCaYImgQ6IL4lGUngcA1ksAVUTFwsHBYEjQ?=
 =?us-ascii?q?wOBBiMPPAUtHYEjIR0XFR9YGwcFEiEqgQ8YD4ZleQMuXhoOIgI5XEo+CgFSB?=
 =?us-ascii?q?YIdAoE1AgELbT03CQsbBD2NSjOCLYEWK1CBYZMgnkaUYzQHgjiBZ4FkDIoul?=
 =?us-ascii?q?T8GEy+XUg6TC5kGjgmbOIF+JIFcMxokgzZPAxkPjl+DdYRgxCBFMgIJMgIHA?=
 =?us-ascii?q?gcNAwuFRAEBggaKUIFLAQE?=
IronPort-PHdr: A9a23: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
 BYCh7/1f9x73mLTxEFoLFV3zt2iJg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZmI+Gawpgbuvcca8htKEKrPw+L1zdoMgy1knxilNoNJuA66lfr
 OV7ZAmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: =?us-ascii?q?9a23=3AhmA8+2iWLRxsMtcoEGt1kKihIjJuKXmayUbPfBW?=
 =?us-ascii?q?DEn9mEZ/NZ3mt4qFCnJ87?=
X-Talos-MUID: 9a23:B+UUFwitHHJDo0NHL2Ru5cMpbuIw2f+CJ202ls8ZgtaIBBYoJTSHk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,139,1770591600"; 
   d="scan'208";a="269364973"
X-MGA-submission: =?us-ascii?q?MDGtpgrQQhHoZSuJZh99RHN71FIcxfFVcVTHeR?=
 =?us-ascii?q?2TDtybPg+1nDhvnfXluEn4LNa9QXSqOxWY8xhoLTniAzRjsJ5/w/+rIA?=
 =?us-ascii?q?Di8KQyZbvqV30cfqJMDzEgXsY/XBSFdwVUhe9obom9Y7NWlS7D+z9F3H?=
 =?us-ascii?q?uWtj5UvTfoPuT31GcK318ELg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 08:42:11 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mdf8F-1vVgwd2eWn-00fdjT; Wed, 25
 Mar 2026 08:42:10 +0100
Message-ID: <aedb870e-cd08-49ca-b546-0f5cd50d074c@web.de>
Date: Wed, 25 Mar 2026 08:42:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <d87a6e33-4c15-466d-b7a9-c7dac5d16146@web.de>
 <e290d8c5-93a-744b-66a3-57b1ee941da6@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e290d8c5-93a-744b-66a3-57b1ee941da6@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+s/Ef4BXHsni48BENbNtuS39pqMFnpmu+1lmxY4Kn18wAm7x1HC
 8eI2I/60yHB4+yIVMTxfy4/rPBf5plFl7q6KyGZncY9YhPFUClbPkMgGyPzqMGTPFL0ZLde
 HNWNuF0pQuVSRJsMK+LXE8SraTPZWXixzlvNi5Ww+wXqKlSg/Y4nW6ULtrIQ6h0J4WOXN2Q
 FjrkFdhkjlVg9k1YOqyow==
UI-OutboundReport: notjunk:1;M01:P0:HhRnpd+VRcc=;1uTaczLVnEx3GD0/zDt5xZsYFi9
 Tuuzplx9tgb1bpITeXBpio5xvC1u2iX69KZrUTgbYWPepW7lzhWNF9IDyT5tYnkTmGuSfmhfj
 oLZ9Fbn6J6VyiSYhYn6F6FJoBgrGORQD7O70DUmpwZp0I+Xq28mPa34UODamF4jx42lu+gFSp
 5vi9foRhmi9YrrolqQ4TTPbgFZBvtlR4LqkKiD6R6aISD4jCIzyzuVQD72pEMrhUwRz+ba7pg
 tzjgpuY99NOwzZwEuKMHWeSuv45s2f8MauCA2P6bnag9g4oV+XtktGHF0yM6yC3/Ox4OTRjP/
 UCvQfLynyem0XxhvD26zfvUXmjCe2p/QJU/VFqq8ygQYXJkvhKIy12jmuHHx/zIaEKJ2RYv3G
 km7NXXmcvYn6mhcpC4T8EEnsikIKjsFq6UPo3a0F/rGAnjgR5QaDpbQxip27CGJdKltGoVH/N
 TPOQjgdpHv22GXhEOY+BZk+NgksA8onIZmp8o9337AJjhByy8Vmcu8hGCfcRe0R1MlHh4ZZbf
 ZIW4G/egYQAyvHqbAX7cPr1ixKaRGQjW82/t4WtT7Xcs2sY/8wesDaOOFAafFr9jqyohG8vgE
 qcsbH9c1Q23eKCk5iGUHzzoxgFnZf63Owl2qUBteSQR7VuNSGVZtPpJZRjX6Y0mQmqnBvSs+E
 MgW3B2HW7zhWfPhC9PaD7bU2RJmt1xfY1cF51t7moSE1Ol1N5ehtsD7/kech9GZpGT6iVV7YO
 6se0pSQ32edr2CHHiQhiq2pDKT6Cr2DR4/gO+w/xS4Wp1SIUjYpMjq+rsqd9AHGLnB8w1ZeK8
 19Ee+mFEgHu6OOhuJLi9U+fh/CRhMJac/Z91nIdt230b7FgRXLDuyxJ+hCMPJYmAEnNqQiZwh
 4dAwAw85xGPvTg+jK10f/BVLiFJ8XwAk9F9twbqc7JWT5/a4cZUJdZHGHEd3jbDaYg6swHgPZ
 uwwtI8Z2J0yotC5Wc74W7+spOY0qEAXE/bYDFe+TLumEOoaAcOE9tkoFw7z991Wvp79KW3hl8
 p81G3I0PO+1eOpssDCV0ySDL/vH/u5WkCfBjIV+/qOKBszS7zJdkfz5WviYO//U46Pfqlb2m+
 UU/KaTRsqibrCUzY9g4FJHx4QXIzCk8NFAYFZXs+iGQK+n5hCauk6Cw7ItV7WePZe9vo/SZRj
 UHGG561VHS7A4T2C3cPAV3JmwiTScX1Otu6ChxFdE17y8XeVQtMpHscLXuPbDPHah+3tfCmyx
 mUqHv+R+mEF62kQ7ZwC93ZaOga+q/w+g4qxZ1HYjWPs0GUGV+C36XN++TdCUUhx8tc1t7GfqX
 pJy5IOLlQ5ctYWiFj5RjX7i+l0pNMkJHOVv7tH2V8gLhmLRi4dPAt8nDorQEQ9KQ8MuPl5LAa
 WJNiF3nTwCMaunjzi+9+kjqredSfsKg91f2X7Q5GL3wqXmr+aPoDv/Rxp8IUJ1/qSzZYOyBGA
 PTIIuOGQZ6B08teUYBm6I/seCuJMXUXKYVbSJuuyzZki78UR2x8rErbWzVvxQjmfBn89q02Cj
 wPsjwviVNRw1WMRnJ0f7V9ZDZUAOqoO713F7/ROdsmAxFw/R9YfKImnZdjC8p7dce2PcyX3Se
 U9WVu+waQtKYE5EGT80aT3FA+hdK9Ascc09afnR+ccoet9TGs34FMFCUKFn52tQ7S7IO/nT/A
 78VIsawuw6S8foZVcXB5VGZOCCWKNHhHqMUHVMtYH+TniCzQWpj3Q7Rm9wp9EVFOti52BBKjv
 kqZjNyb2mBlMC99hDTdWXHOvhZq6qUhpzy+UMVW893Kg5d4bRnRcgnKgwcGJs17mdZQ4WHc8D
 goctA93yAaA72/Suwy/Hza3One7uuuKj9yxqsQTBab6rFQZLdH0WcY2q6y27loiWcM5q1qCcP
 S1vrvadIBd+n6Sx7/J6sHu7hKtZ3PekKD0ArTt3XESrhl4mZcs5AEuXZW3p2yrfD2NEgzALpj
 zI04+7tO+lV4D+z20CeSIXiVtNUQFFN2SmSTvMT3PWnhv9q2Aw6JSM+vkndpDpRFVWHU8sOdv
 LiTivAeZTD8tHx2bq3w6ehDhGvjbTphnvOaD6G7/f3iRLML60yzWWhxyxsdHP04jO24TJ4mEY
 rcVfx1Ie5M5G3otXG4fPisizJ7HWT9mGYkPz74VSmhPsGwtSQTG7f67pnQzGL4Qvs2Wdbbx2x
 58yVCeJcSXaNiQVIux0r9z2WFfO0RvaAE4O1UJvgSoPyrcgTKqUSXoaRNQ0F5eiax47s7TOwo
 6i/4NqamW2ulp3zfquO//ObVWB0AYi867N+lY/PgIjYVOu7J9vBF7N4edj4beifMiTJU3r4BE
 2G+DkasJxBH1RrfTk/SOV87r2e1NbRcs46Ml/edqpfYrhNvblnQz6xJ4PN8P6/zYT5RklttHH
 Qv7U7+DlIFQz7oK3zVw0KHLOucQBqkBMeOOmERdH0yKLVmUHBuoz0orF3lmxdjNUQT6dqgI2I
 DG/V2AsTaLwBDtDL/QCu2OHbmaGh/pnUgEaHKTjr+ldmUmOSCCXW5/yWPoGtNzcR9yA3UEwaj
 8KGrcI4T9qvRuf1qMqnRAnajLV/B7OeFsvmHvfRNoAsHKHNDJUqgKZtMbes+mMyCOonBmuPv6
 LPnT1Clf5nPQgPXg1j9gfLnZn5GnKYpeAu8iNl6r/8P+zM61EnSJ21zF9DFitnJKXi5d4Xhvv
 kp07+BuWEVZPm2pJDfyl8RgnGnGZkSXUBV0L6YabsAM++vvPkU/4WXHYT7kNeG2goPTgUa2Js
 aM8xP/7uianXBOm9Ait1k8AsZkTsdElKonvayRqSE+HwfuN+N0PAu769yEmce5ylP1AbEknka
 X7fwScxkIsPJG1bGcqK6EBzpBYPPbLmZBSau/hTZ/u+j7chiom6G0JnHsXe4msuR7k+yARTYE
 bOqV/9/ynFnEUIiyma0isnzXus7uWSzJQxNvwrbRptE9n5lDTfLEk1FdhqoaBQF+qRjZFnCql
 Ul4z9i/3iZl4OwXf9Fc9fgR3Fm+sg03QBBYbT6iLueJeI5bHxIkwKiAVgepDckvmJKImcyrtn
 tP4w0t+pAL+T7lW4Lofwv0V78Fecb3giTJ2Gy92ERZY0UUAkGM0fwQxHNsPqbaaVT4OLWeA3O
 qpMNYs+OJMn/UHj38ndY+Bv9Qmu1iC/iAYvWC23yG2MbZ4B/4lY6TsRP873dUgSWtlmLbYta2
 6Ofw9K4xvVOePhduPiUPRWcheAZV1wse3yKl8qtTKqn5H47vk677GGIcIZ9xfYfPgOBhk80kI
 5OYJng5Vfc5OqoIUhJqnVVlqGQ53+k6mCUiyz9iPLoirRewrPSLnOs8fcWmzR2sJCFV5/Z8O6
 +MeV0MpyHSr9U+yXnea9PwnvthbsFu974K0zhNdWYEhmzc4Vb7ET3DjdLWznz/28vKk/K2vgl
 hbrN7pOh4T4oMPV7FgiDB6/8EOytNahYujbQQ0Md5pGWyG0TjRCf08ROGCEcwedNvcD9cLBmJ
 kA5LuqWyrUFajh0JYV9mJmthnTBlCJBLeDax2doKEy6HAi1rsSkF4BXKymizYHqZ0UC3LOHgu
 LBSmBYK/Kfhj6U7yHOF0N0zgsaVQe/1OmeVKhre2pvDrkQZ7Aj6BRuNIhiwzg8T3N2eVyEESn
 1HClH6Jx7LkOE+669ap6BN6KH/Uiel6XjsJX7+Lu3oo05+gVBB4S3h0kfw1CJi7xITDcNSrTb
 FZNOyI/EHHYNEnVNRr/0bSfowe/cgAKn8u+0xUTGmsmjeHetU2dPzLGYnfv5zwzgODH1PFKRa
 +aMyu34ibcBdu+9MXex7oESHJwu0m8IPdfM3AwAxP3u5Cbc9j1vCxYtlCB7xmguvrhK/stZ67
 d9aYEoK76ejC8niG6wAH7sI1NC/2wAWQMtT+q+kjwBHyBG3xB7Veye1HVHGs06RNYQUMLtUKT
 9m3WD4xYv33ERvFORe9U04/Ck6V/OhnF/JBKf1H4silTDHnW18TN258E5GY8VFl0wxIFvOP8x
 lkgxd27YY9kBaRr1fIcx/Fxfa2bdrGxRVNL9SFmZPXM6HuObfnvSopD33b0OFGlu/HJcJwA74
 HuLS9ZrAYrC1S1tashp9q15gPqgAA0mj7SBQhqECU/x8KGItKeIqdEvHMhYxWs+Ao/tH7SC4n
 4B/gKq4TCFotbPjZptz6GeN9/Qsp9e+xPyOXjWgrmr00SkD+6TZ84kFeyv8S/fENHq2AuYIvE
 OCtKhD9nAIYC3cDPqPCuO7g3Td9DqMPxj6T07gnJcfpxirv/GhjjRoNcPlJPRfeU4/8M+CPV8
 vVMGrT9lkQlthy+2cMuLVYFKA7QqN1heqjE8KlGbou1dO7BnVM4HzVw45Wk2xhUcZHIQBEhOR
 lWZ8HLoJjnIQdOLFNXljTKsSMmH/mY1gWnkjW0bBkHAiQKMKYtDQHPzQJ2sb3m5gM1UR+tFBu
 LnMTwKoyBx5BP4UPxo7lLiSh8L/NtijGyvc7X820P080N+H8fig4QqXngbUb/xuKHVk4z3Hmj
 juw4bf5gaIt+8LS4iVHnJnwFhpDrB6YXmtjKcpEIA+6A9g6NZ4u+suO3cNz++L/Jc/2qf/RYJ
 dquyOotAEN9c7wgp2tKQqlnRtXvwNFD55xb//DokWMr3aVLYfkVICdt8hLKvnRZDuHYVQpNX3
 ZaWkrqjLMJ4vmmd1LTbvW9COFfu3c9N7ZTCt5861gldstepI/DtrnFXXkmZwZeGHxuhdWhsGR
 EdWrGixxjfsCYaCDd2xHV8m/ffqsXHdJYaMNzBWzkTUTBH7/Xdy6/bYPWuWUctuQS3PfboXWM
 yx7jil6PK4cmKMGoAfU4o8eJRsxdZsxLYQo3dn/Vrva+kS8j86QsMnwZSoY7QMVuD7r5awZMV
 d3aKkUJ6zx9n64xDsyZyepzvSnDxYh8iX8AjoLFkbr1wG9EADe37JGY8xat1J0xCZdHL4CRCU
 Vqk6ydAPrukv2YK1QdxKiSlZ8/Mcz4/ZNl5fFBc/vgjiTXBJPurOC3FF0AaeTbXMEHK88qzGt
 r8qHvN/bbdppcMgAYbk46fcRSNlkhHE3alPLT5J0E0/p2W4BTqrRpPrXXKwoyJF949t4/p3LH
 4bzuIpFTWf5HfitdmaQ0dcJdNogbMK4BGhOnZRHwu41l0/NV261uD+Mlr6tn9cUmyJmbj3hhY
 0XNaAHDKclO7Nxz8J93j7l+G7UUvLueTA9XMmUa4JDoKpmTOSKi3mGfNjJBs433iA0yyMKWx/
 MwarLxII9NGW5MSISs+cR+Vmd+jLqnVBEapvnb5Uc9wJ7lkMVU5SbugfpB1+ic4JZwMLqh3WV
 WVB5A5aHbQ6g+RsHvbKUkh4xzw5LBrkFCJYaGrWC+P+ovuzfwWvzJ3xCZFaiRJO9sF6w3O4gG
 MyC8B2MNpEJwsvDx+Up5BVx49aqdDYILZjcfZDT7S+wgCDNiuXZPrw+qq4bPsXaNvSUKTf/tT
 Vb
Subject: Re: [cocci] Adjustments for first statements from selected function
 implementations?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3448
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/eWs06MhvifAEiiKtxqM6_w>

>> A contribution like the following shows how a statement can occasionall=
y be added
>> to the beginning of a function implementation.
>>
>> PM: runtime: Mark last busy stamp in pm_request_autosuspend()
>> 2025-06-18
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D18c1fe53d186867243f4cf17f4eef60737a16c4c
=E2=80=A6
> I looked at the link, but I really have no idea what any of this means.

I wonder about such a feedback.
Would we like to achieve a better common understanding once more also for
mentioned implementation details?


> As long as inline functions are parseable,

This is mostly the case.


>                                            it doesn't matter about the
> other contents of header files.

I got other impressions through the years.

Regards,
Markus
