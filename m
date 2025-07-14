Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF6CC83F1A
	for <cocci@archiver.kernel.org>; Mon, 14 Jul 2025 11:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=1ncF97qd46nlXeane094h9dNGW0lav9It6Siz0LRQtM=;
  b=XhIwC8cW4wM4zbljWt76asVcjithYoaqa+snKmHKfvn5hfnCEZdptTGJ
   Zg9t2bvh8ipc0gw2cfDQ/cd9ZgEjFvtGI5UKaiZLcPEH36sGFskccXBWD
   dpmlFZLuu9mOKAqn9wk4yqy7IdtN1NgtLjsETi1JQZY3/zLhXhlNWFqHb
   M=;
X-CSE-ConnectionGUID: Jtge3SdxTmO5GDHvBGDlxA==
X-CSE-MsgGUID: 75SOJuRST92O35GFsLvQrw==
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
X-IronPort-AV: E=Sophos;i="6.16,310,1744063200"; 
   d="scan'208";a="231562151"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jul 2025 13:34:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D321EE0CCF; Mon, 14 Jul 2025 13:34:09 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 63873E007A
	for <cocci@sympa.inria.fr>; Mon, 14 Jul 2025 13:34:05 +0200 (CEST)
X-CSE-ConnectionGUID: RAeHv+TGSwe67C/AfGx2Pg==
X-CSE-MsgGUID: 7V+zHwhmSxGkJdWbcOsj7A==
IronPort-SDR: 6874eb2d_52yH4du3Dvf6x+wCRv8b4MftLMsbpZwLy3Rgp9pGGp0aYaf
 eGD4ZfwwiG+kcsAnRfzDs8cfxdHCy/u+FbV4+mA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FpAAAM6nRogAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDgQZUMwQLSYRVj1CCJIQ7hzyHU4h4gVWBfQIPAQMBDU4BAgQBA?=
 =?us-ascii?q?QMEggyCdAKMAwIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABATsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECA?=
 =?us-ascii?q?SMdAQERJgEECwsaAiYCAlYGARQBAYJ+giIBBhABAw4kB64AgTKBAYIMAQEG2?=
 =?us-ascii?q?l4fLCJZgWUJgRsuAYVsgmQBhieDQnonD4FVRIE8C4J4PogegmmCJoEWg2SUM?=
 =?us-ascii?q?VJ4HANZLAFVExcLBwWBIEMDKjQxI0sFLR2BJ36DCoEOhCgrT4IidYF5QRk/g?=
 =?us-ascii?q?1MeBm0PBoEYG0oCAgIFAkNMQAIBC209NwkLGwY9kimDb4JOpVKhQzQHgjiBZ?=
 =?us-ascii?q?4FkDJ9rBhMvg3EBk10OBpMCmQYiqRuBbwYtgVwzGiSDNk8DGQ+OIYQzvA9BN?=
 =?us-ascii?q?TwCBwsBAQMJhUYBAYgggUsBAQ?=
IronPort-PHdr: A9a23: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
 gdO3r7ya4geZNWT5g==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:HqAVqa6EfXbJDUS2zgPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:i+IICWOU0sNsQO5DYgBq1FBXJu8ebXCDk1yXCkGXGTxRR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AlFbQNQ8f9qgpzOnudasPEYiQf5hWoLaOF0AIqoU?=
 =?us-ascii?q?puOuICiZ7HCyf0x3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,310,1744063200"; 
   d="scan'208";a="231562149"
X-MGA-submission: =?us-ascii?q?MDG021a5R8iCLtxjjz6rGEtSXdkgE4b/6s2+Dw?=
 =?us-ascii?q?G0Ktcy10eiyvJAXb92wBQMmGksJS8CdbUmlpUXtFRDJNkbumr7XmaBuX?=
 =?us-ascii?q?jsjmhdcV1cvC5QPY5Jfp2p94iqXu/kGrMEzNz28/dlecmuEHXlZNsEBb?=
 =?us-ascii?q?qR5re9Haskxg721pSd2IonMA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 13:34:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752492843; x=1753097643; i=markus.elfring@web.de;
	bh=1ncF97qd46nlXeane094h9dNGW0lav9It6Siz0LRQtM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kcATz50tpjySwtP/1d2AOkx+J2tcItRUKxMbS9+ZU0IlVARf3pi1nI/+LGu6GW1D
	 laWL8TZZMn63rNoLef3N6a6kQ2Qa8ZVFBpt+KTdS1uqw67VtYSwecJoDw+nV4bOmX
	 67dKVxBO5NESSUZLprhGSjpirNQKKnFK+2H994Dwb41UOh5vmQ7wWkIyO/Ow1ntq2
	 vnmUu+X/pZgkfuDP1p12pbCqOVHGcE9loEsAVOEeHZQ2TI1WAjuifFmoo40NvI/UB
	 +oitlo+Jtj/ZsThaKhLMardpMONG2j1JQQHwi1+rMxdrWgk9oZwUGVvvLOlYsXk7O
	 b2G33H0C67sLVqBBEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.184]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7ell-1uYGdp31DB-00CrWW; Mon, 14
 Jul 2025 13:34:00 +0200
Message-ID: <c3d8cb0f-e46c-4453-b025-154e5ddcd4ba@web.de>
Date: Mon, 14 Jul 2025 13:33:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Yue Haibing <yuehaibing@huawei.com>, Kuniyuki Iwashima <kuniyu@google.com>
References: <8b094c79-c6e5-4398-a2a9-37e9d46a46e8@web.de>
 <BBB485D5-F5B1-493D-BDD1-FF8A1FD38BF7@inria.fr>
 <9305a7cb-f54f-4655-8802-be7475b6b3ee@web.de>
 <9aaaaa9f-51d-7476-3032-3f76f9e7cc9@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9aaaaa9f-51d-7476-3032-3f76f9e7cc9@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Xga2BHGl9GPHk2oouz5YHSmbfzAa9S+MVUp5FVmL4NYHRWX4wZ4
 puDru9X5506wSjLl9NpAXejiWCBTjCaDjeEQ/Zo27cGLIBYcWvRJZPTPb5I59qoyL8ZslOL
 M8lnX4bd8Cwa8WTWqQ+TZPPI5GzvuHUTUScYZf2lbqkUefQxWiwBa6QlRAw4zrXlXcrn7tF
 05r+ezvUHlZS36BC31eKA==
UI-OutboundReport: notjunk:1;M01:P0:JMClE3MCD/o=;CgU2slAhAHekhYd6rasd81jX27i
 QdcMg7lPY7YuxcDkPKY+Py6gYB8LoI6HKQGJmu5q5DFZ9KpaKkgAjBiAk04VSGQaX8wtfbYE8
 d/7QBpsdJSrbkUitKY4yNa+E+cuzeN65CGbZwMMomKtpdfMhCst5/d0TvOXyPKgDFOosaxFkb
 krXqArFcjzXJH06VSzaE9hy1LWxRzJDE6Rz0lhOlOgsARatecdg1mp8+Uos8I0QC7hpOo1kwm
 pvEA115GPQG78EiboMGtjCS/aGMU4Zp2O9puLVJpdl0C+3o9j4QGELsLk1DY3Nby+1zlYB2Te
 djP74zsOrKG/oEtybeJz3+gtwRdVGsWGChkW2ePhDUcMgbGmBOVqCiHTfXIt9ZuXnirgjHNjS
 2D9Eq2wDakQon2NnNHTe1Be4BvODwPzBAQWzz0dKkjVebRM/5EuhjenMTRC7lrgrpZFNNDFQQ
 cJRjXoQfqCW8949r8j2J2ghJFyKAsxRkomJirF0AuYfTrpT/AJ0us2YghvdCov4keFsaoEBhl
 jtUvfY8lKTUEf/CJ5oqtuDbDQczVbP7nHsD5nZ2y+4c0WGqBOGzJTpcOTyhBze3ssKm+8OYO1
 f8cAxIfKZJmuJoXFHh/6VPj9HHoDmDlKepgDrE4xEx/Ae716KHzI6loyrBfouTnSjShxvDINc
 DWkN5FMeHvpob7JJySeuqOm5hkpQv9T9110P+dfviJTh2+wL/zPiIHLS4Z0JtG9+L0IuiNeAU
 IKnbBWiYMxLyroxaj0GeFq6W5HPKYo5hshL//AtumkwGNYVv9/PhhckKDzswZiq1ySbPHOwSt
 c7ODWZVlxWaOkH7n915RRB+jjhshZi4OJp5LvuWxUOSx9NfcoPsz7srT5UtVZisO/cL4H5jtT
 yCKIi9FB2mZbfIG5OYTPnn4tzb3d+159tRfg73mMKrwnv5Bt+jCrCEjMdRJcqEuUo86k4J9r9
 Rxtd1AFKYXTjCS0gglKX7+GIqYgSL9toV56ggaZwcMX8+PBNBi/4kyQ2BLg0HTMoIeYJjfL3V
 xcv2Iu7ngGbKg2Z1t7Vqw7OsVWAPVJwrBtrl2vXq0RjO17IagrmxcBkv1lvNsYq5CzrnnZ1JP
 7pObyB7e9XxDO3UlmOeHwM//if0NNx0g+ZQqdHNgJtbDQBVmlkSDH2+8twdV4L4VoMK92O3fx
 HrT53NIwcpnR1PHgIcBOT/XJWUNdqpcc0+oL7hHiwmTAVBSUNMcTTTZ2DTEchXCMk8oFmois7
 lmgOJx7usCqEvkvUkwLJJ7quZsE1Fa9b3J2m8cC2Pfy65LSudZKZa1QC/ZdME/hEtkpeWMOuZ
 jd12tkMVc5+961+9g0DD0zuiro6dANK+HTlDazCkoWPREvJDhS2J/3Ch49IF7diFYPjSSofLN
 lKSiNT/Sm+K9KYP6WHBZs+QCSJ6Mev6VdipcqqdrNShrZA9Je9J05VtEcPry4xClai7W6R0UY
 BmJuAXJDxRm+RvnIqINKBODUWL4hyG8+GDiAnjX5Rvfzj53D3eNFJrt5PmiOre36GJGjZ96J2
 hlaoR7Zf9EIQQ/NeFVGJihimEvaNlIsc9gUyi91Hdklo8onouTntWFkwAXZuDTUBvaZMnc5WN
 +HFKK89vdkp2Jiq3VhL5Y+fl/wqloZAt6FyJ++1CZvIlJidIZEPGahm18wuDmSW+xf0q8LZOM
 M8rlHgCDiRinuzMiKG7FmarsPy31XkBtUWfhv6/4M0Hja2btMK/IDk0oQ1qbChlGWlnVdTASr
 DuAc6VnlGqa7GnD19SXeOECGZzhnsdoIT267JJ3t0d/zGCNegGxEZzTgH3/XO/NK2vNVjjUjF
 GzfcCEUdFC+OVkwm6uTP+pPOsJ5V+pvzj1YSrAHqs5xDWi4KIJ9tnpXR4XLaTRgOD2BskxEGN
 jCBr51wofUX4jf+h1nnZtK3C3BmJSCWvxMkRfcs1FPeAbOlLYbLydc6ZU6hRSOXw7tvo/l+e2
 eDxVjI9MUq4f0UpKuSiSC10f9fUClsqnB5WStqVQzJSdtudRYxKhRzK1gJeqcL+EyxkyYi7kz
 1dmA9U6Ggx/fnHt7BoMQxwCQ2pYnfkElxEDAzj9Z1PVULsWZjfhRUhUdW8JHALy7yziCPN3iV
 Jm5o3wMbOlZT9krE0F4x8hQgflEF+kIj4obtWLrdqnysh44ctEYkUbz3SH7CeNo26XeCxDjgY
 45WJkAYM9q+dgReDaTU3rBCYtaYRLqw7tERTfQGXkhGffWC5QqzW3qbneYaMfn50M+8oubGGI
 5OKaEp354GNQs7jH/hSIpLaMdDkbdy6KJjxzZg4OuTXk+7ZliaY/jeP/pSVqEajaWNTqTalhz
 K8WUdU8f9BEI0REoSGAN+A2J16XBU9i2EJNUwAjMBtEUdzYY0t9jDcNBTPaZ80ahsMtPZYQS9
 6kZ2zkfh9O8WK1WxkcykdiYLiwTmWoO16jO3ava/RZObvm/V3DguzyoMrM6twBbRfAOY1rmoj
 VHxaQjehCed+sOHK+v57YhgjHyo+shSMaijViGey7vXIKhZtZPhBwT/ezu19MsFeudUizHZDN
 yjHjo/BkF2Ta/n3s/pq0dDZg4dYrjakiB9W2LWUwG0jhtYX5FQGL3ch6Fk4aKn+0R296KY+2P
 9Ua5tAyxApPuci5xiCuf3gc2lyM5F3ZtkEutmBK61qNvgAxLlVRLDKBw2MMVrlU3XQHixSJb4
 iWiCM9tU4iAwwg88CcoyLdCYO1fhHG4VExTDjJqIk1TXq/qmKzOsxiHRhwyt9XfaMaKy7GDz3
 72Ovd/sRNlcuIFOpNiSJdrggKm1HygHHakL2M/hCl+fG1JcHPfOxL819kehfmlmng/3gVQqSK
 RGLBq7lnTXwdnTGN0SIel8Q18K4zYSG5GJz1TOFZ0OPIyT9YfGEzFcWAqeXXK/VlsdrYz1Jlu
 BHB28IAhFIV+l1XEvlRhdakS5ETVoXCQ2DUqBaBtyiMkX4OLyhlvQyT6s1ZHUC4UNK5ksMjKm
 6MejAB6NvCAV6vjJiuxQX+/s/FlYwl855iLkv8dkU7WbSypuTflYj6E7AolkLncnID203ACEa
 SCbpiyG7n1ignv4NtNJJoA3DX5F/l0Q12WfD+ivvr4xxiHBKLctAf97fZVaABap0wa2oJ3Ijx
 BSVFxhj7ERFN4a9XS2lY1zlTKEMsMKKGPjhLmUcZgas5BIcqy1cBanmVyyYwS2gK2Iiw7tnnf
 Z0ZlUTNaVv0wwltBBLcqPFUoZk+YXO1NEdlP2zQNj6JsabuXazsCA6/HGPRLEs2r/KYtCrcY9
 6Cer500LXMSiltUzzjOxTLNi1x3pL9hQPz/pSar4pCiMsJ+9L2Ban4ga9adO3o/0yXAYdebZH
 tqLw9zPxIcmxY6VxggsYqppInk7tuM+OvKyvjnn+Zgvp8SK36M3edXf04jk7cZWMDkDG3V8RV
 1rJcdCanCeTTotXNEidBuG2Vn11EmU+YDBBRT6b9Ytuc+UvzOCX3EPhDiI8oa+WiIHxqDV3Xv
 FnNOCJN/cibO4cdrgntfNFfL/ADYZiTg1I0iLdY32S88ldb7EarR9jwcovRuERj6q0mSpPUBD
 j0zTeBQkKi0iklViW5VqBs4X8euOVDk9M9YZvcK4mXTxJtsF6ejLzTXQRGS37LrFtTuzTAClR
 HNFqSSCOAo/7Gk=
Subject: Re: [cocci] Deleting duplicate condition checks (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2871
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/c3d8cb0f-e46c-4453-b025-154e5ddcd4ba%40web.de>

> I still have no idea what the question is.

Can you reproduce my observations in your software test environment?

Regards,
Markus
