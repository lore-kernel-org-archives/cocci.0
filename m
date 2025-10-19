Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B11ACCD195
	for <cocci@archiver.kernel.org>; Sun, 19 Oct 2025 17:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:references:from:to:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kQAc0UibkOncRkKIvQcXYGUpA0pSKYWfAFZPX+lj44I=;
  b=hJ62iDq4Mhtgi3daEBWE+jxIcgWjThx38VzhWVYgcxjLoAl0IsOjaOwQ
   SpHPA1lsov6cOi94FiOF7wuGp/bVDnGsHTc43Fga+ytkwTMuYCXOS6Lhj
   1t1PkgIVJgwThokWXWC/Ji1ejlKZ12gvn9GzGm11EFaS9iukR3B+SUc7y
   M=;
X-CSE-ConnectionGUID: /96ETKLwTImb4etkvoWezQ==
X-CSE-MsgGUID: Whgo+yMqQqaAMWbt+OQm6w==
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
X-IronPort-AV: E=Sophos;i="6.19,241,1754949600"; 
   d="scan'208";a="245021816"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Oct 2025 19:46:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 882F0E0264; Sun, 19 Oct 2025 19:46:03 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6595FE0171
	for <cocci@sympa.inria.fr>; Sun, 19 Oct 2025 19:46:01 +0200 (CEST)
X-CSE-ConnectionGUID: 04/KVevLRpaJlP7D7plufw==
X-CSE-MsgGUID: Bd9JZSKyQHmXaroGvoe1iQ==
IronPort-SDR: 68f523d8_19hg2BF91dluaE5wYj9ubNqS+z8k0+AGQQCOjziiu243oxE
 aQXU5exojYZ9sEwmCtlH84mTqSWE6A0EVRdghqg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EdAAAFI/VogAwR49RaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8BAQEBAQELAYI/ZSNYMwQLSYRVj1KGX4c8h1WIe?=
 =?us-ascii?q?YNSAg8BAwENTgECBAEBAwSCDIJ0AoxMAh4HAQQzBg4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGTw2CYgGBJIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBHQJHRAIBAyMdAQERJgEPCxoCJgICVgYBFAEBgn6CIwEGEAEDNgetM?=
 =?us-ascii?q?IEygQGCDAEBBtpfHywiWYFkCYEcLgGFbIJkAYVsO4Q9Jw+BVUSBPAuCeD6EQ?=
 =?us-ascii?q?4NbgmmCJoEOhi6RLVJ4HANZLAFVExcLBwWBIBAzAyo0LSNLBS0dcwwoEhAfH?=
 =?us-ascii?q?BNgPRdAg0kbBmgPBoETGUkCAgIFAkI6gWkFARwGHxICAwECAjpXDYF3AgIEg?=
 =?us-ascii?q?jGBEIIpD4ZCAgELbT03BgMLGwY9kziECpYFgzWQRp8lNAeCOIFngWQMjQaSZ?=
 =?us-ascii?q?gYQAy+DcQESk04OBjOSUi6HZZBzIqkfgX4kgVwzGiSDNk8DGQ+OIYQzxxFBN?=
 =?us-ascii?q?TwCBwEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 vbXog55fPhr6zrmpVs6dAKimQ==
IronPort-Data: A9a23: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
 N0AUYf6NRjAYA==
IronPort-HdrOrdr: A9a23:7/OBj65jbVH7nRyqYAPXwBzXdLJyesId70hD6qm+c3xom7+j5q
 WTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h0AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAstD4bbLfDpHZKjBkW6FOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:KLqT+GEF6GDTNdnxqmI/qAk3JM07VkfFxVXUGxCUVn5tVbOKHAo=
X-Talos-MUID: 9a23:LbeSRwiSKY8OKy7Mv/52usMpHss5wZaVK1E0sZA2stODGjJ3Nm6ctWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,241,1754949600"; 
   d="scan'208";a="128615635"
X-MGA-submission: =?us-ascii?q?MDH85wgQz7BAyw0vWcT7w0eeLG8kuMkodD3gYB?=
 =?us-ascii?q?beVlYcteD8//mn5qq/gHCS1MmVwCG3ZRqKwjbku0EatEgkjlyIOwzrM/?=
 =?us-ascii?q?KI/AmREEAroR4+Epi3nHzlCw9Q3v0APIN1ehty327KxU5Rdj2gywBFeR?=
 =?us-ascii?q?IveAKqgU2/05tTtEta5T8iyQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 19:46:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760895953; x=1761500753; i=markus.elfring@web.de;
	bh=kQAc0UibkOncRkKIvQcXYGUpA0pSKYWfAFZPX+lj44I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Cc:References:
	 Subject:From:To:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AoYNu6Cz4U9DR/ZkC3SLCUGYLtm2epS47pj2a/LpqrVSmgfj2w1rX3W1LfHXPtuQ
	 0E8qnyEx+opHTbhjD7imNV+9e8P63Swu1Np9e5/fOylp3bE5qbuMZXNMZYijj+7U6
	 F0u6XFaD70fWOMB7PzYZOtmAz0lFfhStwKMCl5FtfLU5CXdu/oyUhBjaT/oG6CTKH
	 uWLYcUwjFs+PHxDdOMqXMsyN0dqGtjg4VeZp1+PtLkLGTM2+IMgGTNZA0FWFSMUv2
	 F3C0bvj+nOKTIitf16luC2r/dlq8+1m7k9sDhg3EKC0ziiGDb7zRB9wdAbqwVtD73
	 y/Kr2oCNe13pjRAmhg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.180]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ml4B4-1uTl1A3bDA-00aSSE; Sun, 19
 Oct 2025 19:45:52 +0200
Message-ID: <53826884-2772-4453-965e-037bf3c4b2ab@web.de>
Date: Sun, 19 Oct 2025 19:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <26975dab-9631-4661-aaf4-afa213104a13@wanadoo.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Anand Moon <linux.amoon@gmail.com>, kernel-janitors@vger.kernel.org
In-Reply-To: <26975dab-9631-4661-aaf4-afa213104a13@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OBDn8bnGKssNr77QFbAHY8RZK1BrBIYIrD/r90S0dn5UgtsTsF0
 Xj1Wz/ZJlcNyg5gPii8qG8W/BMdr183r89jmtSuqoTLk56AAi6KZnlyNUT3Wu9geH8uOCQ9
 JXlZ4aAwhE8AlHX8OmooofT7ndGQf0cjNBBcT3LH66S6l5YdzmJCr+s0ymaRshLkw6QDoXE
 +nGGgkvI6to1bsoJvm1oQ==
UI-OutboundReport: notjunk:1;M01:P0:eJj1V8s1uIo=;hhrsl/doOk2iLBxkNnnEtnlFm5B
 gtSdhuWyrjwws5uJs/sNguntPU+rZWok/51+ELB2au/St6q43F1diGEWbpLvBaW/4ihiRRjIm
 Fon/dYL+xEHyRb6+MIxEb5U665FM3edgINXDYFsE74WVeq9RWPmz7eDqt+UN0Rs0rHsxlMIRa
 5bObEhcCAWMnJ/NzM2MDLgezeCORIK2Z8SRi7GwRhQBe6ccSodDlesGGPF5sM0VXSkj5nyJBF
 N1WNs1IChPJ8GIPPK2Q1nukShSUVg1/CNTGUgkKU0Mt8BwET/1HCZJls1qZLaXYdELJib3OSp
 WkS70S51ADnRNp2HezwsoCmtxNFANWeV38ZeRzA6HkUhDXN3kMCvMd8kePOnEpro6OgAOaks9
 bpimTcG41AQk/PklMJ71xWLoI49azVInD65hK8ChnjR55VFpvwGxB2bGwb9lpXESRvV2yENJ8
 3cb7rZd9DbFSOf4qFFa86xx0fX+uG335zBGKg1wA8EMGCl0alyimBMgUqbDweUt7nq8tDl+l4
 FpoCVvDVa9TZkjmSwh6bGNrLzeqpjULov1lyEqgC/aa7wgkP9PB/r3VHLQ0PpbcEppiyEh0nD
 pdmRX70kisHhYwnvE29U4P2+FqEmhTZApVj32y4gpT86Cy6oF6lrLXga4HgUfYk67YwYAlncA
 SrfkxEI83P8ud0CbYvm5YsPSCdFYzgp04Q2xXkR25t5kmVvrr7Aj68d0iXHiiqdOEsYBbXoVt
 wBon04PsZMMyCE4AHz2kuP+ZVdh9jHHR11jTKAQ87WrwHsM1sBwp0Ias1AoHnedIvUSV+oCK2
 8iIJ+OuO7rL1q18i56encwKahtgAVmruWXHE3JOznQZc9os3xVHdm66GZKWsXojBdksD12A1U
 hkxFntHm/PyShtj9iXDF4ArR5ze8KUNdC6avnoxmiM6zX8rQKEwzD5rva1IGcgu6usjod9ysc
 tfG689FKRvXAIeDZFLdvyXgAqyBsTE5Fjsv3TPIvJTcO3f1qLNINCSHpWaWed88V7XWvp7GtC
 1TLf/Dt3RNMsE9CkKSD6lHai58rC102H/Ek7pvpxIvi6f+ERtgl/TTo8UiZcxzmvEMxqwuHov
 KaLb/kiWEq8MTw1wl4Ah26oYv3yYRkCrgS88HPWoSqYQC4i+mfcee7fWjtPn29bNoHUgr7Qp0
 AJYcREjYZXZc3RNBdwWKP4AO2/IBUHdG/T6iiIyHxRkImtdJVtX4zFhgsaflJtY9TbG0w++OD
 5jZ1V41Hueo0XR2rC9mCKL4SulxTKvWFk3BcvKS3GTqT6+ZY2LdqUSc2nSdq5XKmVaDmkbIeA
 DLorJ2JZy8y4z8bDyU/5BSI9w2Avd1C9CF7xgBJJidFxpkW02kge9p1BrCcjbaDAEsBBwincJ
 GmiSDBNA3tfQq5b1zuE23tdmv6l7jLQmOz8zSzgtWqM8CglsTxExnX7KUntZFZ37YEjUF9QgR
 gUpyuT6nRG75ALsBJ0JVJEPxYYug5Nped/Ae4uJOmw8IQOZ2z5Zca247lk6lkdF7zl01Y5i8D
 w0Lre/ZL+/eAXe6RD39WLxJFmHmpcWjVHdrzvajelyXT+Z8qUwSfbO0yAx25syYsnb92AewiW
 AQMjBcZ6RJ2II71Sjjj8p5krjGP/b/66+2prn3YBF+A256mR25WJxTUxm+6cq2BI08DYS6/Np
 IddPohr8Am0psk8Rb0NdJJ/BehZn03LzjBKPL3AYrKV3oWfKbM+H2XeqfIN0ak6uboSDR19YM
 6fOOAT0MwsFQoYVZN/LrTDUn44iF2YF2Qq9hStyyAbeqNzEkkGOEmPhOy8IVnyeuTQLcWW7mK
 hcV8+RVAdSBbVmxYqXzTXzxkKop9kLz4KRba8lEt0IjW9vSCM0m22Bnwj+shdq6+MuaE2ki07
 ZmQN/hoJFgdvLOGfFaqZBhfy/oJCMdImYEqcvdv6TabB6gYaBWCsETK7d+/5H0vaLWltVh0sX
 fRZB5q4klhLc4OqXttloBmetLSFyYe28UZTvZEUt1hiEii8ihRixnmUC0cj/YLuoNFKq0wlJt
 Aj1DTAnmzj2DmRyHOs/tiUoGgsmZuT6tjg09FN7i6razD1j/PrSI3e/o5uVs3R8lONgMMGkhE
 CaPHcku9qX+qiDUX9wF8NiKz6oj+23V+5N0f9E+4lTuPT0ZsPdXYr1/O3PV4YHfs5N6LHJ+xl
 rUc/wVha/Q1wXOXjmjASlaGIs3cYYbeH1/weVXsZ+KlHrmn/++oIhuDRADgIckC7PZ0ps4N6F
 FYLpNlu3fGRmVPFMIWzmzxNlQ8xFRn7nEARd5SfzZXloWkRMYk2rN580f4TzRE02XBYmdeMHG
 wMknLc1P1/8q8RklolQxsXbI/5mQiquMlrW5b+KExJYkx+L2+Y96NLQ3M8u1zZ53jqdHcKAMh
 XRuU7JkEGn7c4F4HeIVfQFDYM6DzRwuwv1bdsA+quNihFJ7695gWP+7WT/sI7z7pK3FT6XQAS
 aCqr/pTGcABkVhZDPRCMkIdeAw0K86Vlw08/yzBuqyhhtoa0veXC4u6KjZ1pn+LRC56cBDkEm
 93NTG4pUyxKy6z7fAIqt6tjSnp+6+IyosMr11N2PkkdrXa042JnR55DX62ULxbUKDhw3GZMtJ
 mB/9zG6HoN5iq6wne9nX9pejQrSpImwE6hdcnl+dhbk1cPdUhI/4BgDrR/DUuyR2JKk+ldTRE
 U4DasSrQHeFy/Ce+8m1TE/25ZZa4xUSsIuSFRdv9Wy4Sr6y+AKFAVAcn1nIh6KsV1Bk7wW8Fi
 96nKW9Io+yodNHu/w3GTO2+7iJMoG73/2Bu/GSTDbHQjwN22gQUx/YyTl99L/u7O4BkkaXF3y
 5W0Od+oM+l1zloY6Leq90I+a/cZOVuGj9MgD6k7NjHG8nO62Jx54/osCAGV3jIk5OYZFd14a5
 GeBpRGobmkC7Gh1Bnhf+TQsJcOpn8B729iZNy98tY1xZDOHxbg9BdmMtCtiXDXAHIU9OrlSyK
 QbVDsQspE5enHfysUeSNdRU1m/07P5gqz75QzRx6pCJXkBJztkUNip6w6TGOhlkANJmALNEG0
 YOa8Dvt6rxSlOHt7q9yfgDD+H9mc69yho+As8mHLahhtRWvYjS6hIUl9NZMr43CsqyBZ6F55W
 gWKmzwgV7+2wA3w5GRVOOdBbHzSaUpNEk03CN3xnBqPCN3cy8ABNxNCEya07DUiFH10aoP75M
 cDpf3LmH+RcQnFMfTouVBGB7VhUjAY8+7nRp//wKJtkS94jywGgqWjoZ+eRb6NP65mol1Iip0
 /B1I5uEPJQbOwc/QlG8EDGpRR13MFl+s8kkqr21dIgeKAgRrE6Alq4OkG1MMnB0O/bOGhqLSn
 bXH39fnvk8Pr/Lc/lfXpabesfcOYpwsJpL34ii1bjUClD4UVceMqs66K88NudS9/fVwxM1OHU
 cLYmR1Kn9ujHiiByVlbCC3LLAnayhx167fWXWUVHV1y1Kj/u1xMJQ+zY6k1gu7bfrLrMoNuSu
 pIwzzhJupXPWviQ0wQvMFhTmKckpQmWBDE9Ofjl+6FGyFLUM5xw2uURq7UNfWYRzjbC6cnVBx
 BCFRQkGwuvmo0ipRG1GZCUEr5nEYWlMY8POcljHJPWfmlgEItmzIYYrVflxbsMKHOmR7iOEGf
 PzY2Rza28SC6fQxc9PdSpPwads20fhe0ZI6pz9YgOJhibMyL7tOULwyMZt6j6eVgVRStIx+7U
 T29oslsEm3tkacSxr1dBJuxjeeN3+7+ZAhx9fN7nq/fR0c+CFlk6UoNeLUnCV8sR4wGD28h0/
 5nrrsTMDApy1/PKAoGCBSenF47iy1wUHOe3GUsDQjWe6oAPRB07jMEiYy+zD0b1ir24h7QMAk
 D7Si0WtMoWnX9pKivzdtOyOv1IWQfeBORHVGdMCCD4Vh21gUSQoXEOUSnbMUmAj5zHV8Efhjn
 6T39EQHg67J1FqtfyZkE7Saaq9s4UQ4KVNY7rQc0lAvrJ6hzXWsl7Q/SkPOY2Q4dC/AYpBzRP
 enmpF5PUQWnkTSZKiPcTjBA9hkr/HbqBzPn/Nz+whLaCh9Gq2d0O9hP/mZ5G382JRMo6sl+ei
 i7PyLqO9De4v+bz5vqolt+O/d0JfSiHI4mPypW1DwdIb2GDWO82mzGHVAtSiAzzbkvtFSqEWu
 bLtGhxkY3Pya57MaCKahtnAV8cYfQjnQQNG4GWjE5NpbnfNVOf9XMkV33F3EjiBCYDNYdaKY7
 YX5DEDTGv3ZJknKq0OsxIr0USYxSJnTtixGHt1YiWzymdJx+NRWXvkaMfcFi3CnmHHcGODQLc
 2BCjZkApZZjmSsQBbjOF5XzDCv+PuCR8jsTjLUkwJyCdlq3GyX8GphmsZoXMRAMjxBBwyx1lD
 lb/BKM80AGTUjZSO/637sWTImD3BgUAOJtqAyBgzKCVEcRVPHSVbgBNm6x5mp+ZVQGce7yh0W
 yJ30llRH+Aj7pbAoDMAM5B9dEjVhUWvF4rpKOTpttH03YYPgIXRaCRecU9N0fwEEAlHaKWwIH
 vtnbRqYbLgwewDUhPY5ISgi3ML6Z2su6HSSZ8U6TaSrDarPeJD9Cg+5iBDGDVn6Pd1o7S6wdS
 GRH6MhpppJBsV8EWzqgUTgI0qys7zmRu9gbscP3jlS3+UienyepZ4mPoazy77qR1wxltnCN48
 Xq9vzBoOqa+ZL/X0XDvDPJzHUsj9qSi6JKdfy6aH1R649i4XiGuP5KCdfVDUjb6vbIoIgwjWX
 jJBjPz901cb8IHr6uUcoplHsMk6An7PMQx3YNNN6oU4gboeS4D6nfghkRJO5LTgm+G8yV5na2
 O4bRSXzyzZM8aDtx37hew96u6oCV8KuP6xq7N++Vz9Q+LrKIC9y+lfJartJAEUTI9k0y5Bklp
 uuesGRr2+IV0DrXxZ2jAUX7vBniLuQ+80YCG58+twosYF2eGd9p+WcfYvHCOIGFI5LKeAP547
 TCjaQKEQT1vwHsJjDkjiPOtK6T9R0RYjDSE7WxwI6mGQ4J3F34zXMztJvgjKaFjYDyUa4xB5f
 QxQ6lcXoIh8JWCmQUlNvf+6bY+9aIoWCebc=
Subject: Re: [cocci] [1/3] PCI: j721e: Propagate dev_err_probe return value
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3085
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/53826884-2772-4453-965e-037bf3c4b2ab%40web.de>

=E2=80=A6
> Using:
> 	ret =3D dev_err_probe(dev, cdns_pcie_init_phy(dev, cdns_pcie), "Failed =
to=20
> init phy\n");
>=20
> 1) is hard to read and understand.
=E2=80=A6

I would like to inform you that it can be determined with the help of anot=
her
small SmPL script that variations of such assignment expressions are used =
in
108 source files of the software =E2=80=9CLinux next-20251017=E2=80=9D.
How will development imaginations evolve further then?

Regards,
Markus
