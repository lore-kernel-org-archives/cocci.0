Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C900C4332F
	for <cocci@archiver.kernel.org>; Sun, 20 Nov 2022 04:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=to:references:cc:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MKu9oURNQtUxjJQbWBMMqqQ8SkyZh9/mHqi1UhAMA2w=;
  b=tE/jUePtlRt3X1z3bzPGCAEb/KOR8dGQGOil2CnOht2YXgTvmplcVCc6
   tUy6EK7Jp7M9KfUgw/vSlQ1EnNglN+DM/gFzgMidQDn+mQ2YnR3zf0pki
   JoYHAkUD5MXj8wUxz3OJCiN/sPM79qu9B8C3x1HYzAkrrf1zrfVWnqFRk
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.96,178,1665439200"; 
   d="scan'208";a="79101167"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Nov 2022 05:38:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CBF65E028F; Sun, 20 Nov 2022 05:38:33 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BC463E027C
	for <cocci@sympa.inria.fr>; Fri, 18 Nov 2022 09:43:58 +0100 (CET)
IronPort-SDR: 637745ce_DZqpwy09i6JJX+1H1g5V0s5RRi/65G9OKZ4LlRjFNu5GUoI
 3oD8+3OVG7kIMcUnVDfqsvI237F9CiaLWhYwT0A==
X-IPAS-Result: =?us-ascii?q?A0HTBgCtRHdjkKPO8nJaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?U8CgiuBWyoDBwiFFIh+jEiZCIF+DwEDASETGgECBAEBhQUChQAfBgEEMAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBAQEBHx4eJ4V1g?=
 =?us-ascii?q?jUihAcDAyMVQRALGgImAgJXEwgBAYJ5gyMCrwSBFhyBAYRwnE2BFCwBjEiER?=
 =?us-ascii?q?0OCDYE8gwM+hRGDCoJnBJdhJQQOAxkrHUACAQs7Mg1JG1gOCR8cCgQXDQUGE?=
 =?us-ascii?q?gMgbAUKNw8oL2crHBsHgQwqKBUDBAQDAgYTAyICDSkxFAQpEw0rJ28JAgMiZ?=
 =?us-ascii?q?QUDAwQoLAMJIR8HFhEkPAdWOgEEAwIPIDgGAwkDAiJTdS4RFQUDCxUlCAVLB?=
 =?us-ascii?q?Ag5BQZTEgIKEQMSDwYmRg5IPjkWBidCATEODhQDXoFpBDWBdcJMYJ8tg3KEP?=
 =?us-ascii?q?pwBBhMug2UBEoxUhjaSFJc0qVo6LoEuMxqDW04DGQ+OOY5ENW4CBwsBAQMJh?=
 =?us-ascii?q?UUBhRsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RwjFqXMAyWM
IronPort-HdrOrdr: A9a23:lyo9LaCM/HEcHBXlHemY55DYdb4zR+YMi2TDGXoedfUzSL3/qy
 nOpoV96faaskdzZJhNo7G90ey7MBfhHP1OkOws1NWZPDUO0VHAROoJ0WKh+VHd8kbFmdK1u5
 0MT0EzMqyTMbDy4PyKmDVRIbsbsaC6GGLEv5ak80tQ
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,173,1665439200"; 
   d="scan'208";a="78875236"
X-MGA-submission: =?us-ascii?q?MDExTGzGWbg92uKJ7UJaHT0dtx6KgkQ7IfJjBu?=
 =?us-ascii?q?vRDle3aXKseYaNyFerzq3kFvNhH3nXsD8LILD1LEbAOSygAjCF2l9fTd?=
 =?us-ascii?q?/V+b4FGLt9CLX0K7OokD5mpora20jqkN5BwWFrc2RjH2JRgUdb2mYTO1?=
 =?us-ascii?q?1fXAbgDFyJEjsirvlcY9SwOw=3D=3D?=
Received: from mail.loongson.cn (HELO loongson.cn) ([114.242.206.163])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 18 Nov 2022 09:43:57 +0100
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxTtvKRXdjZ5AIAA--.24310S3;
	Fri, 18 Nov 2022 16:43:54 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxR1fJRXdjGG0WAA--.40666S3;
	Fri, 18 Nov 2022 16:43:54 +0800 (CST)
To: julia.lawall@inria.fr
References: <alpine.DEB.2.22.394.2209212125590.2783@hadrien>
Cc: cocci@inria.fr, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 nicolas.palix@imag.fr
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <44c42da0-aa89-41ec-d539-8bc5ee168ddc@loongson.cn>
Date: Fri, 18 Nov 2022 16:43:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2209212125590.2783@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8AxR1fJRXdjGG0WAA--.40666S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E
	87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
	AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF
	0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jnUUUUUUUU=
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] scripts: coccicheck: use "grep -E" instead of
 "egrep"
Reply-To: Tiezhu Yang <yangtiezhu@loongson.cn>
X-Loop: cocci@inria.fr
X-Sequence: 749
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/44c42da0-aa89-41ec-d539-8bc5ee168ddc%40loongson.cn>


Hi,

This patch can not be found in the torvalds/linux.git or
next/linux-next.git tree, please take a look, thank you.

Thanks,
Tiezhu

