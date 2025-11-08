Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D11CCFA18
	for <cocci@archiver.kernel.org>; Sat,  8 Nov 2025 15:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=363Ly4pgM7AqjCgjMK5kr3htapw3pD7NI4HnYdZ4r8M=;
  b=Ii4ikluDTU/wNd+zuVpbNr5H61jxSLFN6l/zeo8XLfAKYUznDCC9qQAw
   ylnbf9Pio2zS1DopkRb8KaR4gxSw2/WJ/KwKYUjf9i2ziSddZx87/YdKr
   8fkKXTBS6tbZlSeXi/3NflIJjCmnO7u6/JCEu5OhToSgLVLFnXp0r0CVU
   8=;
X-CSE-ConnectionGUID: O0Tc0XTfQm67Oxl+uNCD4w==
X-CSE-MsgGUID: ILKdWQKYSkayHy+aL8fmPw==
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
X-IronPort-AV: E=Sophos;i="6.19,289,1754949600"; 
   d="scan'208";a="248310836"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2025 16:13:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 545A2E0B0D; Sat,  8 Nov 2025 16:13:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C3E7DE0171
	for <cocci@sympa.inria.fr>; Sat,  8 Nov 2025 16:13:18 +0100 (CET)
X-CSE-ConnectionGUID: Xbe4P2sHTa+ZlGTikI+uZg==
X-CSE-MsgGUID: LdBG3ho3QdW9Btn4+tSc5w==
IronPort-SDR: 690f5e0e_kk1Toz76ifozLMJMjlbKx7AjnVebexu9kdggKtL34BiwYM1
 PEbNnhUpgQdCcS5w5l2JYZlfzPZCr1GWvdBN2Ug==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HPBgB9XQ9pgAMP49RagQmBUIJAZSNYMwQLSYRVj1OCJ?=
 =?us-ascii?q?IQ7hzyHUgOKToF9Ag8BAwENTgECBAEBAwSEeAgCjFoCHgcBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPDYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBBAsJAhoCJgICVgYVAQGCf?=
 =?us-ascii?q?oIjAQYQAQMPJweSSZxGgTKBAYIMAQEG2l8fLCJZgWQJgRwuhW6CZQGJbHonD?=
 =?us-ascii?q?4FVRIE8C4JHMT6EQ4NbgmmCJoEOiRWQQVJ4HANZLAFVExcLBwWBIEMDgQsjS?=
 =?us-ascii?q?wUtHYEkIh8YEWA9F0CDSRwGaA8GgRIZSQICAgUCQDqBaAYcBhwSAgMBAgI6V?=
 =?us-ascii?q?w2BdwICBIIZfoIKD4QSgQWEb0ACAQttPTcJCxsGPZUGgnWDPsZ9NAeCOIFng?=
 =?us-ascii?q?WQMn2wGEy+DcQGTYA4GkwWZBqlBgWg6gVwzGiSDNk8DGQ+SVLwGQjU8AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:neE+PK5bl6SwqDQkN089OAxRtFXDchMFZxGqfqrLsTDasY5as4F+v
 mtKCzyBa6rZa2X1e9h2bNng/UtQu5XXxoVgGwc6risyZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjVAOe6UaicZ30ZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSsvPrRC9H5qyo5WpB5gxmPJingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYvu5kqz2e1E9WbXbOw6DkBJ+A8BOVTAfzsCa+v9T2Ms0MS+7uR3R9zxC4
 IklWaiLdOscFvakdNLx/PVvO3oW0aVuoNcrKJUk2CCZ5xWun3DEm52CAKyqVGGxFyke7Wxmr
 JQlxD4xgh+rt+i7nIrhUclQj4cRKObXPYA++WxSwmSMZRomacirr6Ti4NhFwHEvi8oIEfu2i
 8gxM2M1Kk6aPFsWZxFMYH49tL/Aan3XVjRCq0+O44cz7XLSygNZz7XndtbYEjCPbZ8Jzh3B/
 jKdpAwVBDk+OPawkjqCqUugub7lgSWnG54pH+Cno6sCbFq7nTBDUEZGCjNXu8KRgUm1UNN3M
 F0R4iNorK4o9UXtQMOVdxmxv3eAujYOWt9aCeR86QeXy6OS7RzxO4QfZjtGdcBgq8I8AzAnv
 rOUoz/3LQxlveGtE2m9yr7XnzedBSkWDCwfVyBRGGPp/OLfTJcPYgXnYvsLLUJYptjyBC223
 D2A6iQz71nysSLp//Tllbwkq2vyznQscuLTzliGNo5Cxl4pDLNJn6TytTDmAQ9ode51tGVtQ
 0Toa+DFsLBWVsHS/MB8aOQKGrayr+2IWADhbapUN8B5rVyFoib9FagJuW0WDBkzbq4sJ2W3C
 GeN4lk5zMEIYxOXgVpfOdLZ5zICl/i4TYyNuzG9RoYmX6WdgyfdoXs+Px7Mjzy3+KXu+IlmU
 aqmnQ+XJS5yIcxaIPCeHo/xCJd6mH5s9nCZXp3h0RWs3JyXYXPfG/9PM0KDYqp9pOmIqRncu
 YQXfcab6QRtYMunaAnu8KkXMQ8rK1o/DsvIsMB5TLOIDTdnP2ADMMXv540dVbZrpIlvrdeQz
 EqBAhdZ7HHdmUz4LR67byE/SbH3Ard6g3EJHQ0tGleKgEocQJudw5oeU7AVfrAX0vNp4tApb
 vsCeuSGWu9uTBae8RsjTJDNlq5QXzX1uhCrIAyefykZQ55sYyfr6+3UVFLj2wdWBxXmqPZkh
 aOr0z3qZKYqRiNgPZ7wU+2uxVbghkotsrt+cGWQK+YCZXi21pZhLhHwqfoFI8ssDxHn7RnC3
 ia0BSYon8X8k7UXwvLo25/d95yIFtFgFHV0B2PYtLa6FRfL91qZnLNvbry6QiD/ZkjVpoOZe
 uRn/9PtOqYmnXFLkbZGPZRF8KYc3+br9phmlllKPXOTdFm6KKJSEl/f1+l1i6B97Lt4uwy3Z
 0GxxudnKYi5YP3CLlpACzcmP8Ki1O4VkAb89f4aAlv3zw4p8aulUXd9BQitiitcIOFLMacg+
 +MAudEX2SO7mBEFItaLtQEK1mWuf1grcbQriYEeO6Dv0jEU81BlZYfOLwPL+7SNVol8CVYrK
 Tqqm6byvbRQ6U7ceX4VF3KW/+5iqbkRmRJNlnkuGk+on4fbu/oJwxFhyzQ7YQBLxBFh0egoG
 GxKNVVwFJqe7QVTm8lPcGC9KT5vXCTD1BTK9GIIs2nFQ22DdG/HdjQ9MNnQ2nEpyTtXezwD8
 YyIzGrgby3RQ/jw+SkPQm9gle3oSI1g1w/Fmf3/Jf+/IbsBXWPHjJOtNE0ykDm2JeMqhUbCm
 /tmw/YoV43/KhwrgvMaD6u06O0ubS6qdU14fOFZ3aIWHGvjVim49hqQJmuQJM5cBfz43nWpK
 s5pJ8hwBk2y/3vVnA86GJwjHr5Qt9wq7eokZbnECzMnsbyejzwxq7PW1HH0q1EKSuVUs/QWC
 93uZRedNG2Pl154pnTorvQYClGnYNIBWhLw7Nq1/MoNCZgHluNmKmM27ZeZoFSXN1FB0y+Pn
 QaeeZLT8fNu+b5sk6ToDK9HIQe+cvH3deaQ9TGMo8Z8VszOPejOpjEqhAHeZSoOBoQoWvNzi
 bipm/z01hmcvL8JDkboq6PYHKxNvciPTO5bN/zsF0ZjnAyAZdTN5iUS8GXpOL1Ll9JgvvOcf
 TWaU/fpV9ApWIZ6/kZ3OhhuS0NXT+y9a6r7viqyosidEhVXg0SNMNqj8mSvdm1BMDMBP5rlE
 ALvpvKy/ZZioZ9RAAMfTeRTa3OizIQPhYN9HzEwidWZMoVsqlaFp6ekihcqrz3GYpVB/AAW/
 rqdLiUStjzr0E0L8D2dm5N/tFsbAR6RRMEuK1kF9YceZy+SVQY7wCd0DXnCIo5ZmGr+2fkUo
 d0LgHQKUU3AYNiPTfkwDBkPkOtS6izi9+oV/gAUwn4=
IronPort-HdrOrdr: A9a23:+2GaR6AVAWut2B3lHel455DYdb4zR+YMi2TDGXoBKyC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AmmqUK2ik50p5ckNAIT2TSqVVLjJuQnfQkE+KOG+?=
 =?us-ascii?q?EACVbTJKpSFyxu75WnJ87?=
X-Talos-MUID: 9a23:RaEcrQZ8dOkLbeBTkzPGq2piM5xR75v/IlwLzdYagMLZKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,289,1754949600"; 
   d="scan'208";a="248310833"
X-MGA-submission: =?us-ascii?q?MDGGEsC3UgLS6a7EWak3rP6fxMwV+DXv1hcswz?=
 =?us-ascii?q?QkJO+DTvFP9JKS/Txo+jz8I7AK+0AFEpNCyQ6/87HoGGh6cSMmSKXsUg?=
 =?us-ascii?q?Qx81uxPB/v0vCa4sR82gHhgBYt8Mcbb9NAf04vGTtPTJELiJnj/CJDs6?=
 =?us-ascii?q?NCvAqpsbv5QQdyM9VqSLAxGg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 16:13:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762614797; x=1763219597; i=markus.elfring@web.de;
	bh=363Ly4pgM7AqjCgjMK5kr3htapw3pD7NI4HnYdZ4r8M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cp2hhFzaY1vsNzRXLFMC1fXFQ4b20q6XAJ4IAPF8oaDI1Afi6O5pMHO4McufXD09
	 lkN4LzpdpHNBW9CJQf43dbgFzSg4vSIYOyIbOBQAS+9N+LuG6mU0CF0wUuCygXONL
	 7lj437aCuPvfVQ1keKDaeKumryqxp6EiZM/WbrfmpV6Q9k3n9crbpOSadKqX/qmVL
	 zjiMPFZqTsf+ne10rYBiz+hkBAGQVxnLdCLry6v/c6yEw7a34piAKgVtMCMWr7nMX
	 MX0UyEfgVRiTzM0lJE1noZbRWdQgrzDILIrh2MFe2jbHldf2/4OxRWPyZR1Lg43+K
	 kRjUYuQqKSaOmrn7sg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.239]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCogm-1vQaKb36fo-001My6; Sat, 08
 Nov 2025 16:13:17 +0100
Message-ID: <647a9e19-34da-41f2-9932-4d2cf367adec@web.de>
Date: Sat, 8 Nov 2025 16:13:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: cocci@inria.fr
References: <7e3a6e91-b89c-4fb6-91e3-cf43313b9e20@web.de>
 <BCA1262B-159B-480D-9FFD-CA6318D3BDDB@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <BCA1262B-159B-480D-9FFD-CA6318D3BDDB@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BGgjkqY4n1dF1rbKLh5dGH3sJ9V2qHKExDIXCCe0kaegb4K/HiS
 oFI+jmg5sqajWd9FhaoySAVGsWPpskS0n+3iSxNf5Hp5i//ZsP6PnMSpfXa5jh4o6bgBfzv
 +rw/Jv+AshGNCTEECNglVJeRbfhKpz6aMaYWZvQVBSTxeA7D3eEaIul9HVoXqa+LRkyMLzj
 bX4QwmKjUJ03W5FmvjdaQ==
UI-OutboundReport: notjunk:1;M01:P0:qCaGtnEqAdo=;12gaoc9RGx0HWMvYOMNSKuOiNK8
 SV5Pdv+mENRynqzn2V2BYC60xzqCElAZ1tVR9VoDKEjq8HozkJAL6gzghtfQOod63iGcUXuez
 uiDi8sid8TJwlbSbFr/owsYi8xNvxX8/Lws6cYoLswF2WDBzjWL05QZoRAKuGMUnYIM91Knhz
 JzRCYKBXv8HpreD26JE+RN55dpVdyMjNUknsVbQ+ZGd4UVcQ7bKUHvYLq0dBauhp/PSb48Y22
 nXRcKm1naxexvVNG75oMDiuzJHdPr1hpygK+tXe18c6XTLAR+u105uw8eLMF9VI131W1oGXeX
 jrcnMP6I/OELPNfELooprQSXW2XrKKQh/BGyo9GGkwQ//Osb7sYq5waT5bRqiQTD73z4gl6PL
 XLlwGcBJB7IIJUQubj5R90r3rAv3i+nHlhiFHfX3Rq5yfHQxZ5TmPGBhyeSl40Yx7CszBiYWg
 ZtEsJAr/2fRP3q9FnbFSO1oD1iiDXQX5CBEZSFrdYBeqzz0tk8xBSf23Lz6TEfF5/ZtRJPAzh
 BgKGiYVP6f5nJvuqqCbJVGig06qfZLcRSOIHVSxfPiqdK8VYPG4I+BQOX65aOyOYY/9cGCP8f
 2MgWR72PuG/84gVCtkFx2ZMU1fLs2+KGgcniaQv6ASuW3uHCKuMb2jrYVc5B5rXhochGy4AIX
 6bWjo8CRyK2pIeYvBcmScI1G0J75NGfTuXOrNcaTYWGV8WD2CEHZGCE9FpCLocPjn5DNVV0Sh
 d2Pf+hg89VERyxeRRn97NlVEha/M3aKkIlVBrqXZNp+T0G0+uLLFtPjsSfSf9EoWr8bf/Syie
 Ed7n0/1mTnJ2UgrcQUknoyPIKfNw191padh7CPMXON5EKdGiz/Eb8KGuuRH1RiTkHNnrGZtC7
 zHfN2Fms/TkyBw8uHfN4vODr5pVRRf4f0nX8Q/yjERRkpOb50wTFhtnDIkNY2mqArgelFJOMr
 HsMPF8QR8Dn26JQU6krErwW1IMw0HcaYDqrxXoOUNtXWQdnJiwzZc1hcwOE0o1w9vGxM4cKUx
 IATKwe2PQz89jpLWt/U5o8d1YWLGjTrtsWeRfNuQxHuWz2IPBHPWmIFongKS8KmsOCiHVspMr
 g7ZOlNqy6om3I5dHzbpzsxU5Qf+KFo+1Y7AOr8iiAXIPiG+YOd7Z9wLQUpLUEMaOsjMONLfcp
 2ECJ2x/pFHpPiekTyex4nu7smyez7UrT1MrdZEGSxw/tZ1/mpetTG6jvqKsiijP2MdVGNrQLn
 Vrp0s+vSSCzmsTRqBH9AZXKZcFU9+fHTthb5lePlmUSAvg+upXva3l1bFDk+gMaOiiFj92nL1
 CnPnRp1pkLTJneLiJtdI78vr7+E1ke09YyTJqUjAD8dOoBWoOgq0DR2jp3HRHEYOYCOkTAlba
 POTvWPlW3BRwEk+1mHHj2h+ZzgJ2Knpg8ocYlLsgyBoFdm4S39VVibrayfo0ZUdQGqNoXX87h
 ccrAwr0z/v4xeLMNOxmJPmHqPJx5LXAlB0Wo4INqu8VojVi/1xYbwzAaYmASkUM83HSRVsNZV
 9uc+5Lp5AejUmLcDzfufAZ0O0YU+/9WOxWBT3LjjwAFFSPC6gEC0kpG9b1jP5Oal7aqGYGKlL
 cRyaVbe96EGBaWbhf8fn+i/Wb2y7IVZKdWWq4DLOC2vPyz0rkzmR8b7UON1n5N47wxo6P5T4K
 i+d3CKOeqzNK0T53mygh2DL+CToUdUL67W9DViCmBZ/+VBZK6RytXCdrOexJPPYq4GMrAqx62
 rUY5YDh/YNrWgKGoxrrZF8hw7yTiAMQw/vV0EH/MY7YB7z53P6160PiV8sjG4HTknPow3CwFV
 wnSuqGbOknsk6qVR1maDz2iRbDhJZ7Ogn+dzEkTCGaPkBno29UUFCOBZ2LIvk7WvEc3icxxqm
 r4Q8AzCCFb39rCuv8VjAWHSvrrmOkqS3T6lslpmlwJxxiKZLWNn8s4rTE2AWMLm/SrCTi3ggm
 yDJyq2Xq8P7BauBX6VO8Nt2E86oHO2Up0ooQVvSEmVqcv6oW+9YZvEdyaqPA87g0FXiXuL/9H
 VjaNI+6s6eDI5JNCUzrdFboFXZa5xXm2+yZ4Bs3ThLILTrX0paggFHnbjCLw6MHJ2bk42ET0V
 p9F0yBEE3fcF8OyzZD2g5a4qQ2edPiEvOEt+e40ci4WL3+sva+bx1DoDc+Jw6EKlvyOK/e638
 DQ/9LObp9knHg0AsMujQ4oCjbohJeXPb7aBZwCHwzSMSp++FEW9VYX+JKBpbCnAtU0lLQxX2d
 gkq3KhcK2QS75hzNWw06NqHAvD4LDLkg0KvBwvAfsSn8n7DJYRYdG2hXjhy46VR3J6UipEtcm
 9gbTHN7mnOHwFdCrJa0wYJAkv/e4CNrHCc9x6u1YsZPpMRNrZGj/I2cAKzv23kps+yBOWh7bu
 sEQ+Y+lAEzadycvn4HzR2X+OD4yBVTeA04WnW+kR3id/7P8CNOZrAfMP2IfixCTzkDNrRsH65
 t5VC/AyyEkiMOxLGfKrql0uodcc072F6sWOiZqKmextZZqMDw8opQ8BCat6ehj/qm+bxQc+7o
 oC1lJ+4eiQ3KUggPudTTCPr+6PcHdp9cepGo1InvLF/qZmXcwyo47lHl03jhgHblJ2xiNkoIx
 aAXdESsk0JPWeGT0hXU6EaCIa44FzGYobuUrpjZ+E1/hKAejMQS0JsnE4j8mqJ/Ed6iF1DTN1
 maDsb+YLVJuy/tdXXPl7wVXTBa07C+1QhFx8zPBZwXXoGhOGRgLWnVkoj075fcVpNtGmASj3d
 eii9Yy3jYEcw1SdhC3rdFOlt6qKHFQ+GIGGRjNHnNugzU71ARXT6y3z6sevJWXaZFCe+BnWui
 LkLSFa3LgVCSDN11/XjcAnTpKElP+D37cYTBKgd7nAwD8IO7z561c1+7RS2XgodO0XJjINkwY
 0aQwNNMayKSn4FIvteqStdGDkYbo485goZhjdMJUzDHa4FfCtZRnVQb2U6cJCrrWtR/URDmjC
 GeMS7Imjme6GfEbEzOqvLvv27LdCSBu5DwHZRjbwFojQHWXIWXubuAl12+h87DpCXUFPfFpze
 dgg/HlVBc1WmOS5JXWqUgqsEiPvM3PZ9Se0UQ2Ct6Uwx14y4rL26AEKO7NosKmvNd1hiwLJMe
 voHy3Pu2wSvuttTrUll26bMpzgXLIu+HuE+WL6Ly3bHDjtQRqvMBOj21pQUFz7HosSaxxQbod
 VVuZlzgmcU0ig/Wm5jNEoaHpwj6vEXYPjBc6XtgFXJcOBPijnkYdvajp38qqOqncDRROZmBal
 IGQD7a/YfwyKcsSWyJ4sGfwxTFYITfAF6Xn7BYG7SSM0qPENWvexJd9gAumucvwX0/PU3gPQC
 JR4VodTqyh5JTZ/9NrmVS9tj5coL5TNuk1E1qztHUTObY0Wx5eRszxObkD7N7FEfjwDcheiab
 ELXg6A0i41H++MB30DKisLCFV6BkRkFxxWx5Aj/ABgq4XpY7+ATRM8orAw3qnGQpCGR8wFn7b
 Jey+Unu/ngvrpb8BF93E1vYBzOTGWAB71C9QvzPTaUb/1P3Cx8MBnn3D3p7wcHKNhWvbQ8hC6
 ZNA6ZOrMG+IrThi1eMmk81nzygYHsipcBQ1skD0WLRSOLYKTRtCTPJ2nXK6lgnkRi3ZSSEOnZ
 fPaKSdfb1PkP3ZJBWKtpgWpe6vCCRjXhoztMTHsjLTR/BXDeDJgXsBWNYtZlF7+BaPvzKUUcW
 todiY78JGXP9938jTvhtLZgQNgWipcmBSOVoWOYRdRPaPnOD6yWTIjNIC57/QZMWBLUDk9Ids
 e9yi5v/P3+xgco8veOV9xojCE/Q4lx7CufAtmhXqKLfFfCDqf9QlQq4n9fB7JwkfixU6D4GTa
 w2b6VgWI5SpEtDj2Gt6ART67CxIe8puUY3YmPlx876zvg8QpktJZydp75dsQ8R2OG735uHdBF
 tZVtogdDEUg0d5ceqzLmrK8kJqbkLJs3jCNM2Smc4GSXcSvCfyrr4ScVhjIvtsfJ1ixW0klWR
 9xfsjhQJje4dIfoyvZ992hG3V7V+lnGKcCe5Qlnysyc0oPppBZOybQRwcgdGBAI9q7wQikD3Y
 ol3yxHBfGwbkhRYKweiZkfhbzezwHtrFSB/vXWUK/HaaECGfWyJOnymkQ5f/PYnAMC2Z7Qr9g
 1kUWDpjH4sSiwI06JkjYIikJBeH1uAHldDdRnz3C+GSfzaSxowK6PlUL4fxJbQjY0jYRDhVxO
 MG71zPDf2RJX8QJ4CZGmur1QPHEsDj2qpN9jKioBLy7qBoCQhEzPyqBfaSs++NHTZs/MXBQ3z
 6l+Z6yK1QmhNISpBc819qebIeSgtiCYRSzvpHid2GO+KrDOdXjl+wYMiKLn2NFZntYPRon7bt
 37Xxbn+ANCJtLIZNbTZdCRzQpRVQmqW8BScE1pjhP7YVV1siLEyacloA8qfnADqB+qhMGlFiO
 C7k3noOeyTFbKkufRm3OaOTT+sKSmG5Djyr8jJWPZFwJInxiw/Ci6+IOFMlH23ScBY+3rUAmQ
 MbBMab0jkonev2Hb+0PtLI2tQvjfKeczsqmIgqnOon7GrZF9HPSvm/etirAMKbILTao8SMAqt
 7yGeQfBB4p7KijdWCHtm80wH4xAG6mmthvf+6T3BjvbcApDoRw3HoG3ym7hYIZnbqTVJu8b6S
 HKedKt4DqD5IcXokp0f5KEfcfqYT+dvw6f/fxAX4grOrcAeYkychzuMH71H2VfaCEnw+obUGN
 tGIcjUYWDc4pdLWBqoPQFU9ldgY+FX7nXxcz2I9aoKCCACCS9VeA012usEr3ectGmSatH2d4t
 qSxfWt4Y4Ew92hx/0zoCzomigCFxT/gLoVc2/Xa7G8DCM100dKFsAq9cHg6s/Q3nCHNb/w7SN
 y4r0xeOjF+kijCrQ7RQD6mMEzHtQ+Jqyr4H10kkvpkzcn9P7CA/qtastND0DhEZg0wy1tJUc8
 LXmdv/4MBgnkaBq7tluAC+gXsW7VGsNQUKWqDgOHEEcPCvUTSO84bDny9aDPri6ZragTR9i9m
 gCZguDNJILqTHqDWZdEFPkOLfTdy+M/GjMc=
Subject: Re: [cocci] Searching for switch statements with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3146
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/647a9e19-34da-41f2-9932-4d2cf367adec%40web.de>

> Just remove the <+=E2=80=A6 =E2=80=A6+>

Another interpretation:
Do you propose to restrict the source code search approach to a few known =
case distinctions?

Should the metavariable usage be adjusted any more accordingly?

Regards,
Markus
