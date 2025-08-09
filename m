Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCB5C87FCF
	for <cocci@archiver.kernel.org>; Sat,  9 Aug 2025 07:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Mou2/UurAAQ01WItj0UrzCc2DZp11ueyiWM39X3b6g8=;
  b=kgSeouQISUkia9rs6X+/TmX/0sMGAgRT4EV+E8EPM03rBzKEZf5I5cMD
   Bztt+SvxrhNl5MVPYcZ5PXAc/wyVm47G+seLP/uvJVzFvrVDgaWnQmYmC
   o3/7kAkiwa2BX9BsYtNa7VlZ5ZZWs+ySoZ4V4z7O9UMAx4Y13n9kD21Zd
   k=;
X-CSE-ConnectionGUID: jWOzWazqRc264n60frndaQ==
X-CSE-MsgGUID: cbzGtwtGQheEFtd7xtcuzQ==
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
X-IronPort-AV: E=Sophos;i="6.17,278,1747692000"; 
   d="scan'208";a="234598121"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Aug 2025 09:01:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AC573E0264; Sat,  9 Aug 2025 09:01:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DC866E0171
	for <cocci@sympa.inria.fr>; Sat,  9 Aug 2025 09:01:24 +0200 (CEST)
X-CSE-ConnectionGUID: THYq//GBRNm0Nl90F0g5xA==
X-CSE-MsgGUID: Lj/vR0JQSU2C7Y251nNKFg==
IronPort-SDR: 6896f244_2zdgC7LIl14lzKUy7LiopiXL9p54GfyaqI5M/QYhApIDt/g
 0OhMrnQwNC34d4brgYqbLR4S599FRhRGIodak0A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EeAgDi8JZogAQP49RaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDfgZUMwQLSYRVj1CCJIQ7jw+Id4J6A1YPAQMBDUoEAQIEAQEDBIQ6RgKMI?=
 =?us-ascii?q?gIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?TsHDgoxhXsNgmKBJYEmAQEBAQEBAQEBAQEBAQEBAQEBFwINOkQBAQECASMdA?=
 =?us-ascii?q?QERJgEECwsaAiYCAlYGARQBAYJ+AYIhARQBAw4kBw0Gs1WBMoEBggwBAQaCa?=
 =?us-ascii?q?dd1HywiV4FlAwaBGy4BhWyCYwGGJ4Q8Jw+BVUSBPIMDPoJhAgEBhTmCaYImg?=
 =?us-ascii?q?RaDY5Y0UngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEnfYMNgQ6EKCtPgiJ1g?=
 =?us-ascii?q?XlBGT+DUx4GbQ8GgRUaHi0CAgIFAkNFgWAZBh4GIhICAgICAhFAAgELbT03C?=
 =?us-ascii?q?QsbBj2TfYRhApU6JJFJoUE0B4I4gWaBZAyKLZU6BhMvg3EBk1gOBpMCmQMij?=
 =?us-ascii?q?WWbMIF+JIFJDAczGiSDNk8DGQ+OIYQzgjGCL7F1QTUCOgIHCwEBAwmFRgEBi?=
 =?us-ascii?q?naBSwEB?=
IronPort-PHdr: A9a23:LdQQxxWQ09qXvnkUeFZHUotn/V3V8KykXDF92vMcY1JmTK2v8tzYM
 VDF4r011RmVBt6ds6kP0rCI6/mocFdDyKjCmUhKSIZLWR4BhJdetC0bK+nBJGvFadXHVGgEJ
 vlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+I
 A+5oAjfuMQam5duJ6g+xhfUvHdFevhayX51Ll+Pghjw4du985Fk/ylMofwq6tROUb/9f6Q2T
 LxYCCopPmUo78D1thfNUBWC6GIEXmsZihRHDBHJ4Q/1UJnsqif1ufZz1yecPc3tULA7Qi+i4
 LtxSB/pkygIKTg0+3zKh8NqjaJbpBWhpwFjw4PRfYqYOuZycr/bcNgHXmdKQNpfWDJdDYO9d
 4sPDvQOPeBEr4nmulACqQKyCRSwCO/zzzNFgHj507An0+Q6CQHJwhAvH84AvnTTqdX6LqYSU
 eaox6XMwjjOa/Za1DHg44bKbx8hu+mBU7F+f8Xex0YhCgPLgEuOpIzrPTyayusDvnOH7+diT
 ++jl3Irpx9zrzWp28wiipPJhoUQyl3c8it22pw1Jd6lSE5gfNWqH59Qty+AN4t3RMMiTHxjt
 SE9xLIco567fzUKyI89yxDQb/yHfZKI4hPlVOaeOjp5imxqd6mlixmv70et0+vxXdS731hWt
 CRKiMXMtmwT2BzJ7MiKUvtz80av1zqR2Q3e9u5KLVwpmabHKJMszLw9mJUcvEjfAyP6hFj6g
 LKZeEsk/uWl9vjrb7rkq5KfKoJ5lgHwP6ool8eiD+o4NQ0OUHKa+eS6zLDj+Un5QKtPjvEsl
 anZqp/aKdwUpq64Hw9V0psj5A2lAzen19QVm2QMIlFdeB+fkYTlJk/CLOrmAfuhgVmgiipny
 vDcMrDuGpnAKnfOnK3vcLpg8UJRyQ4+wcpC659QBbwMJu/4VFXru9zCFBA5NhS5w+b5B9V50
 YMTQWePAqiEMKPOq1OJ6PwgLPKWaIAIpjnxM/kl5/jwgn8lgVIRY7Sl0YUNZHymAPhrIV+Vb
 Wfsj9sbHmoGpg8+Q/briF2GXz5TfXGyX6ck6z88Eo2mF4TDRp22gLCb0ym7GpNWZnpHClCKH
 nflbIuFVOkXZy6IP8BujCQIVaK9RI85yRGuqAj6xqJ7IerT5iIXqZPj2cNu5+zTkBEy7SZ7A
 96c02GLVWF0n3kHSyU43KBluUB90EuM0bBkg/xEEtxe//dJXR00NJHGy+x6D8v/WwPAfteMU
 1mmWM+pDSswTtI32d8OYlxyF8+sjhDZxyaqBaQamKSRBJMo6qLcw2TxJ8FlxnrYzKUhgEcpQ
 sxMO2O8nqNx+QfdC5bTk0qHiaakdr4S0TbI9GeE0GqOoFtUUQBuXqreR3wQe1XZoczk6UPBT
 r+uDKwqPBNOx8GMNKVEdsHkg1NeSPj+PdTReXixlHuoCBiQ372CdIXkd30G3CXFBkgJixod8
 GqbOwYjHiuhuHreDDJ2GlLvfUzs9e5+pWujQEEt1w+EYB4p673g2AMRhPXUb/oM17YA8HMjt
 jF1FRC51s3fD96opgx7fawab8lrpB9M0mnStiR8OIahJuZsnA0waQNy6mbnzRZqEc1tlcYwr
 XUlhF5XILibzUgHWjeWx5H2NZXIJ2O08B35OP2e4U3XzNvDovRH0/8/sVi2+VzwfqJD23Bu0
 t0PlmCZ+o2PFg0ZF5T4Tkcw8RF+4bDceCg0oY3OhjV3KafhlDjE1poyAfc9jA66doJ6ObmHC
 RS0PskUHcmoJ8Q1llLvYh9XdPtK+vsMNti9P+CDxLbtOe9hmDy8imESxYln0V+XsQd4RPTJ2
 Zkt3PySmAeKBH/nlFn0lMfxlMhfYC0KWGqyzS+xHIlKeqh7ZpoGE0+rJNCrgMpzjdjhVha07
 XaFAFULkI+scBuWNRnm2BFIkF4QqjqhkDe5yDp9l3coqLCe1WrA2baqch1PIWNNSGR46DWka
 YGpk9AXWlSpZAk1hVOk40j93a1SuKV4KSHaX05JeyH8K2wqXLG3s/KOZMtG6ZVgtisyMqz0R
 FmASaPm5TYe3TniGWR22z0xMT2n+934kxF8lGOBPSNrtnOKMcp0xBrZ+JndXasLh2BAHnMnz
 2CKQATvWrvhtc+ZnJrCrO2kAmeoV5kJNDLu0ZvFriywo2tjHRy4mfm33NzhCwkzlyHhhLwIH
 W3FqgjxZo7z2uG0K+ViKwNNDUX/9tE8N4VwiIo2i7kP1HJcipjfrh9l2S/jdM5W367zdi9HY
 DcRwMPOpiXh1ldiKH2h2I/zEHmQiJgEBZHyciYd3SQz6NpPAaGf4elfnCd7lVG/qBrYffl3m
 jp1JeIG0HcBmKlJvQMsyn/YGbUOBQxCOieqkR2U7te4paERZWC1cLH22lAs1dymCbiDpElbV
 hObMt8HFDVz8945HVbCynz15an7ddOWYd9buhCPkhjGhvRYM9prz6BM33A4fzug+yFtwvVzl
 RF02JCmoIWLTgcltLm0BBJVLHy9Zs8e/C3skbcLm8+X2461GZAyUj4PXZbuUbepCGdI7K6hb
 VzRVmRh7CvIfNiXVRWS40pnsX/VRpWiNnXNYWIc0c0nXh6WYkpWnAETWjw+2J8/DAGjgsL7I
 yIbrngc4ED1rhxUx6dmLR76By36rR2rdyxyZZyRNhtQ4Sld6k2TPcHUvYcRV2lIu4asqgCAM
 DnRQg1SDnwSHGGACUriOLaG+tTKteSVTLnbTbOGcfCFrupQUO2NzJSk3959/jqCAc6IO2FrE
 /wx3kcQFWA8AcnSnC8DDjAGjy+YJdDOvw+yo2cky6L3uOSuQg/k4pGDTqdfIck6sQ7jmr+Nb
 qaZ1iN+NCoeyZ4Gg3PFgLFN2VkPl2R+eT63Dr0auWjSQaiWlqIybVZTYnF2M9ZUqqg7ww9GN
 IjEh9mz2rMwh6wwDEpZEFf6kNytZopTKmexbRXMA0PuVvzOLG/OxNzrJKinQrpKlKMNvhu84
 HCQFEqrKD2Hk3OBuwmHF+ZKgWnbORVfvNv4aRNxES35S9mgbBSnMdhxhDlwwLsuh3qMO3ROe
 T57O1hAqLGd90Y6yr12BnBB43x5LOKFhzfR7u/WLYwTuOdqBSI8nvxT4XAzwb9YpC9eQ/k9l
 CzXp99o61ao94vHgiJgSwZLoy1XiZijuEJ/JePG+5MGVXuFtBMB4GOMCggb8ttoDtq83sIYg
 tPLla/1NHJD64eOpJFaXZKLbpvadiZyVHihUCTZBwYEUzOxYGTWhkgH1eqX6mXQtJ8x7J7lh
 JsJTLZfEl0zDPITTEp/T7lgaN96WC0plbmDgYsG/327+VP0Td9Zo4uBe/acG/TpJx6GgLMCa
 xZCktaaZcwDc5b23UBvcAwwhIPRB0/ZRsxAuAVkaRIo5lpA+j5yQydgviCtIhPo63gVG/mum
 xcwgQYreuUh+gDn5FIvL0bLri89+KHescroi3adfWyoRE9VdZ5bAWz4uhppWnsaawNycBH0g
 kFucjvJFeo5sg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:QvdtcqmZtI5dhuhd7Z+GiDTXTlXpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE7wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQiVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:M33qNWP1bdrUYO5DZAlW7QlTNeofVHiF6nOBe2HgBjt5YejA
X-Talos-MUID: =?us-ascii?q?9a23=3AcyP5hg7i8MOkG6c3xyRX1xAwxoxM4eOwMhgvqK4?=
 =?us-ascii?q?74eLbBHYtYjG7rxq4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,278,1747692000"; 
   d="scan'208";a="234598119"
X-MGA-submission: =?us-ascii?q?MDG112QKsW9SeT72a67hdtQCr3eW08Jf9J7mt9?=
 =?us-ascii?q?N2uOltVzoGOUUrNH0A/GLWwLryeYbSzxi52oB+AQyIQPQN758mfQxG2u?=
 =?us-ascii?q?nQQvf7DzK6tFzAdTT/v9LX4bPOWV6vswO7atX0NJeuS8TF1r6Ni/fnVz?=
 =?us-ascii?q?C5PKKqWtmDsWatCe5d1E17FA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2025 09:01:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754722884; x=1755327684; i=markus.elfring@web.de;
	bh=Mou2/UurAAQ01WItj0UrzCc2DZp11ueyiWM39X3b6g8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JKr2Z0b5Akjdi77fVmr/4jjRXvmdpqz4DUW/GpZRWPNXZG++6ErZR4JxZ1HKU6YE
	 b8GoAJfxfty/wzFtokcEnipuO4tPpa5pOE2y4/et+OtMALQAtzJ1b6NXM1RgzJzaa
	 RrluB9a/IgaWTM5yqii95U564o8s8P12Tu7FdCQek2EhpGRu26WnEj5OvRg+YA9DY
	 6wXhy9weLL1baNyhw3/uVMkSxVpDF9rz3heqE9yT4PXNqTDCZZzuNj+yIb+X/6Ik7
	 ceVwT76gQKWVsqIeFaCZjZ8CQuYZfez1H9FGmenKHpSbo48ilMBtUImEof753lZ9X
	 xtAuG47mJKbgE9apXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.194]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mf3qY-1u8XgE0R90-00m2tf; Sat, 09
 Aug 2025 09:01:24 +0200
Message-ID: <2e148620-fa5f-43cd-b17f-edbc292d0bf5@web.de>
Date: Sat, 9 Aug 2025 09:01:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Michele Martone <michelemartone@users.sourceforge.net>
References: <0bf5c015-bb4b-42ff-9734-d7de549417e1@web.de>
 <3a88b6dc-cdca-79d1-9a4-72ca8c465c5@inria.fr>
 <0618c7d1-e0b8-459d-a94e-06446e26593e@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <0618c7d1-e0b8-459d-a94e-06446e26593e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:AgJU4CcV9OJixUKmdRbKNM6q9HUUXXFBJ+TQtoPW2ygFrB8xMv/
 p5teBoc8cbmh5soWmHe470h0iRAXzxlK9qBY4ZGWMdn8Yf/cCGSG0FTyhFNKt7s4caR4Ffj
 tsHDft1qYuEwMVJ//LpMcP8CDOdFZGYPP8Fo4A+GUNgZ+WZCGRP7ff6eWgXveWVbHuNrrxZ
 5FpXMrBA7LHPJkunQzk7Q==
UI-OutboundReport: notjunk:1;M01:P0:0DfEyPXb4pE=;OANzqi24bQ6+L7OUEfrqEp0rKKj
 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
Subject: Re: [cocci] Searching for C++ delete expressions (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2973
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/2e148620-fa5f-43cd-b17f-edbc292d0bf5%40web.de>

> Will another SmPL script example trigger further collateral evolution?

Would you be looking for SmPL script variations which can handle known
C++ source code transformation patterns to some degree?

* https://clang.llvm.org/extra/clang-tidy/checks/readability/delete-null-pointer.html

* https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines#r11-avoid-calling-new-and-delete-explicitly


Regards,
Markus
