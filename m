Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AFAC433F5
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 18:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NS4uUgzl6z/4Fq7nEeo297qiJ3DiKLo4cf4HCEn9Y88=;
  b=UfOXgfaQLlaqtA0ZseywRZeyPJiIz30G+bf7Jpv0VOoFMBjbuj6QrbNp
   Hjrp6lh0e8ocmc14J50caEcLod6iZJ1K1wUurDSz76i8yXeSXw9iKEPOp
   DzSJCLO5W7XPN4ykiUPxzGxAPjxZ/Qapi1grTNzaRDZ/nIETbS68f1UK8
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.95,172,1661810400"; 
   d="scan'208";a="56689576"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 20:38:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5BAD4E0290; Sun,  9 Oct 2022 20:38:46 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9ABA7E0121
	for <cocci@sympa.inria.fr>; Sun,  9 Oct 2022 20:38:45 +0200 (CEST)
IronPort-SDR: 63431535_2vZQTv9O7/0C8NF6lEau8oTik12uaxtjVaX4cARnUnBtDMp
 A2LvgcnB48gbgHBoaZOmU8c/xV6f9BE59cUSFYw==
X-IPAS-Result: =?us-ascii?q?A0AeAACoE0NjhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIjgQFWLgQLRQKETIgfiHlpgz+OPYowgXwLAQMBDTINAQIEAQE/h?=
 =?us-ascii?q?AFFAoR0Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETA?=
 =?us-ascii?q?QEBGQkXBw4QBSKFaA2CNSkBg2QBAgIBIx0BAREmAQQLCxoCJgICVwYBDAgBA?=
 =?us-ascii?q?YJ5AYJsAQMNIwcMrAGBMoEBgggBAQaBQAGDDR8sIlOBXAMGgREsAYwGhCknE?=
 =?us-ascii?q?IFVRIE8gwM+gksXAgIYgUaDV4JEIpRuhUYmBA4DGSsdQAIBC0I2AxUDFAMFI?=
 =?us-ascii?q?QcDGQ8jDQ0EFgcMAwMFJQMCAhsHAgIDAgYTBQICFzY0CAQIBCskDwUCBy8FB?=
 =?us-ascii?q?C8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTGBsZAQUyJw4JIRYGCgQaDQUGE?=
 =?us-ascii?q?wMgSSYFCjgPKC9pKx0bB4EMKgkfFQMEBAMCBhMDIAINKTEUBCkSDy0HKXEJA?=
 =?us-ascii?q?gMiZQUDAwQoLAMJIR8HKCQ8B1gSKAEEAwIQIj0GAwkDAiQTRnUCCyYRFQUDD?=
 =?us-ascii?q?RkmCAU3GgQIPAIFBlMTAgoSAxIPBidJD0o+PZoGg02BTcJbNAeCG4FGgUkMi?=
 =?us-ascii?q?WmUaQYTLoNkkwQOBpIKLYRUkg8gjSCaL4FhOoFbMxokgzYTOwMZD44gGYNZM?=
 =?us-ascii?q?4RhhUw/NAIBCAQsAgYBCgEBAwmFRwEBhUwBAQ?=
IronPort-PHdr: A9a23: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
 /Qg3r7ya4geZNST5g==
IronPort-Data: A9a23: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
 vlGkkDN0tONLl2FiArdCjFXQQuq+x8C+k81xA==
IronPort-HdrOrdr: A9a23:etW1b6HNeUd5AOm+pLqEfseALOsnbusQ8zAXPhZKOGBom6uj5q
 aTdZUgpHjJYVMqM03I9urvBEDtexLhHLROkPMs1NWZLWvbURqTXeVfBOLZqlWNJ8SZzI5gPI
 hbHJSWY+eAaGSS4/yKgzVQOuxQv+WvweSHhfr6x3woZR12aqd6hj0JdzqzIwlZRBRiDZF8LY
 Gb5cZMulObCA0qR/X+KHkZeuDJ4+TRkpHrawNDJxNP0nj3sRqYrJD7Dj2R1VMmSDVNzb0+tV
 HMjg2R3NTZjxnyoiW364eYh646pOfc
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,172,1661810400"; 
   d="scan'208";a="56689575"
X-MGA-submission: =?us-ascii?q?MDEA5Eti/WLY8op50+9FVdj4aVel9mCQmYhi0L?=
 =?us-ascii?q?qtSOHp3EKFJG1yRifPd98b4GKygNeOPdg4NfAt6O4J7F6lo3XTYIEG/O?=
 =?us-ascii?q?caKMtAJVB1eWn6reM4Qr1lhrp6lsl4IWMo89RkqTDRYeqzMKL1rPSeuS?=
 =?us-ascii?q?pS0RkvlnpBw7PQWOHbe6yYXA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 20:38:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1665340724; bh=NS4uUgzl6z/4Fq7nEeo297qiJ3DiKLo4cf4HCEn9Y88=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=UnvFTWcOGUksOHvEwaNIWI5Ywa8JkEC0XURQZcGrd1IpsEuPaH52G1JaVp07xJN+X
	 sxGdFIt7NSByfTNdrL3pu3mvBEK42S/1ANy6sTk5gpeEcAkbxOvlRjkpUDlFPOJmvZ
	 En3nwwKPcvySDj0DNrFfrkY2vtBgYgNJ93mJdrah7mfSTk7axB8WTBNCy7FRkJgBMp
	 1VNMIIWxzzwRSlF47hPlF73x/tZvPtzvsT0fa5pY+yQppyRTUJwRPt9NseVAWe6uVu
	 efCu8sZXbGOvBUSOM3nF99k+IenZsROJNJYk1HyAhH+zTC7Fv0zce5V63Xf7KEMAZR
	 Ed4w3EwZcsTjg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.160]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqIFD-1pTKKt0LDv-00nJLX; Sun, 09
 Oct 2022 20:38:44 +0200
Message-ID: <9b5ecf64-a8c1-5c99-95da-6ae9c943a3b1@web.de>
Date: Sun, 9 Oct 2022 20:38:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, Kees Cook <keescook@chromium.org>,
 cocci@inria.fr
References: <20221009181603.3242176-1-keescook@chromium.org>
 <alpine.DEB.2.22.394.2210092021390.21609@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-hardening@vger.kernel.org
In-Reply-To: <alpine.DEB.2.22.394.2210092021390.21609@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6RjIaZMpOakgFThshKwnaPMP5PvwGjOrO9mDbz35vj+W6g8aUf3
 w8EAtk2QHPhwVY2OT7P9hr/zoM7pmaEqVD2CaPWf7rYF1tjmocKpiNZAaQ3z6LTWcrjzvHq
 sIk8vYWBd1HdENwWAeSkbhZn2lnv+l0fstYzGbOpZ4Rea9Rs+N7u+wCE2rxdo3WVUiZdALf
 j81XvS+XBVXX3fCghnhog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lH5lx1U31u4=:oi4WJaiPno71WL+OtI+ZAc
 JsLWMbyBhZoI7A8T72Utc0Iz2bKDXkrxfwjjku+3/jLcx8VMCd1QFYSaCUsF4dovIKbnaKQ68
 Kn2r8xv2eq3/lnWJcRhF2o9a+DQiq5J2ffPrRfi7fLjb0vLS4eAUYmOZTGlYG1J5sxciiqu0f
 EbTpjvjqRD7T44F/OmDuWYp7qNRpdF6pXFRwQ6WYPW1d9TtLmOAKLyqwNCsIPOQBkfd+IRrht
 MFacUypbwPgCwn+DfYCQvy/TRy938ZnWz//mk/cE5RDh3nMpfAN18Y7OfJ/+JYvUqwufcWCfg
 joMXMr74035eku0buulY9dmdFrOuQ9z6ipBANrj+m22/Aitpir1XWmpxWBrdLibXPoRqlcD/y
 EEFZNV9rDhRPTzCTwVClMs+gIeQ48S1KejXnj/fToRX0UqoIGuWSNP6ZT8Hi/HnYx+MKNUzgn
 4Fjl4v28Wl8o+ZsxL3j5/9Svo6ytZHs+N+JYF5Emc/avhjnQhs7XtOivMDbuC39WX2XzW4JeF
 uHQg7vvx/pbuya5RV2hLhmCuN/PLN7FZOwV84WTxw672oMiiVK02d8ssmZIVYaJRpr8JZzleM
 YCxmtQ1Dyp+mQFaxjwRMpnqIJfs8SjjPgj+I664n7LLFPc+8ofZ7bjLyxetHk/+yZgwUU7XmO
 RzVG+er8JT5zqiMXR4iQtGstzmedldXPjJbIcfI4/NBg3Nd1LIv8xImlY84F6h3d6Rxy56PjW
 DSnasTSxFBUx8BH2qUrfSzta90UJuklO3CxCi2JtOE5GBRkHfrMgSS9pOxK6naUua2LXWm7JX
 98Ho6OjILLgOyyeCR6kXGV/4zOkAbJMIYudOibYeZBi1uBoDrujcsmOfQ1a8CmzkJQ7lOzuDo
 FPmQXzvaF2V6iWD+2Tm5EPNCldtyRXj28GIA4qQVEH1zEizg2RmrVbLIaAZSpOyXGiAHbqw4q
 DQXTQkfW9s8Hl9EomNxOcpEXaLQ9sK1YE2HYtGtgeH7KnwbwDBCeq9UOWzjmg47lSBL2ypD0K
 36en3UzL9is8DBYJAJVfsxbmFkrYmG3OvizwtKQVG77BPFkIAuu0HxkXrAKWj+7iGtExexhgh
 vOCs+nWkfkWXFYwD+17MBiPvWRkRr0RJ1Ig8iqLONQjuXf9EOQt7yXQDq6BZ2x1lS76QC4XSt
 HaWC6bLptDp803NT+JhrGEdrKuZpgFAH6SOzEVk4vEeV4yXi//pfsTF6whG844qPiiAwLysxn
 EHDBZtFC4YrmEycjiYtECzed1MneG0WJuKKvjKvqHJsLdbxdifHBMTo8hz3Q2YKImxGmDJxB/
 cN6+HzCz6agAA0il7Ob6oDYT8CxW7U972o5U6KaPIApwECfPlwLSeDFI1ehJ01qD1GW3Tewkf
 1Dk7GbEozEOJ1JjPfm6gmyRk3Piog89LLh39GU4H+h/mbvwh7f0LNJBCMxCUp38+QfwzkEiTT
 01nhm1oHOWdSfqrB9L+X6miQiV57flmkkqtl3Ra+ByW4feuxBHSNWtSHXh08/xYmXdwu3Kncr
 ovPpzI4nqdiCo/+gBqw1WTuI2f11ktqLxtikJLlZ30x/G
Subject: Re: [cocci] [PATCH] python: Add make_expr and include_match
 documentation
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 641
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/9b5ecf64-a8c1-5c99-95da-6ae9c943a3b1%40web.de>

>> Add the 'make_expr' and 'include_match' helpers in the Python
>> documentation. Additionally cleans up a markdown-breaking line split.

=E2=80=A6

> Applied, thanks!


I wonder how such a response fits to known patch guidelines.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Dadb95582a09f24201e07173282=
4aef53593020e2#n81
https://github.com/coccinelle/coccinelle/pull/290#pullrequestreview-113537=
2979


Regards,
Markus

