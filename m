Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6980AC433F5
	for <cocci@archiver.kernel.org>; Tue, 19 Apr 2022 15:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=hsIYTdMYpZPiXwEWJW1DqhM6DMAH+dTqFu/TCJc+yCI=;
  b=Hciv1/nN6QO3fMgXnM4Sbd9YPqa8LTPgElyQncS+UZPMU0VOD5kJd7qT
   GABMAvlJ7fQ2xo1kBcM44HnmtfbemrzVNLsDeld/nzu68E3XD1Si/ztUe
   BFIi7sjycVG8no97oGcX2/sqrmbQu4HaiBeJRitKZ57DEd/M0yGQzgb4G
   I=;
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
X-IronPort-AV: E=Sophos;i="5.90,273,1643670000"; 
   d="scan'208";a="32373905"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Apr 2022 17:55:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 89B84E034F; Tue, 19 Apr 2022 17:55:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 82C59E007E
	for <cocci@sympa.inria.fr>; Tue, 19 Apr 2022 16:22:21 +0200 (CEST)
IronPort-SDR: MWJhi+y1loF3eq+sHRPgg7PNrCBLriFCKoeZGdVHXIa+blXrb4f+T5DTmvt3vynv1yREkTa7j2
 gFqSZbNVPl/+Ud0IRZgv2PySXdem1it8TMcCpiF/V4V0ofrnG2AbSC264FIalhWB5DwQw8zRwv
 P1K0rcjI0VnJjUBpwlA4JpxrAlouA1ojGz6MSOVYXSdy5aSAExVjAwcgps/UfQZmu1T0Q2jRZ5
 IXL6YroSLjgcxU+DRumjMVHMbYlkhwHlsv5wLEUwsw7XCLZNt95LXJpOCihRQNGUbvQTji4CbY
 ORww2AwDWV9JSqmuqaX7qxO8
X-IPAS-Result: =?us-ascii?q?A0BhAQAMvV5ih7vU+S1agmOCKIFUAQEBKwQLQxeTL5k9h?=
 =?us-ascii?q?VaBfAsBAwEMAUMEAQGKDAIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQECBAQBEwEBAQELDQkFCAoHDhAFPGRogU+BdAtBgjUihCQBggQBEoMEg?=
 =?us-ascii?q?xqtMIEBiXyBPYk+hUCCKYR9hAyGdAScAnsTgkujAp4mB4NMn2kaM6hSAS2WM?=
 =?us-ascii?q?SCiJ4QmAgQCBAUCFoFhghUzGiODOU4BAgECDQECAgIBAQIBAgkBAQKONo16A?=
 =?us-ascii?q?Uk0AQEBMTgCBgsBAQMJkQaBNoESAQE?=
IronPort-PHdr: A9a23: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
 pv+9xqoPipjcdcqKK2WL61MnAA4uw==
IronPort-Data: A9a23:/nNe0qO0xOtpG8rvrR2DkcFynXyQoLVcMsEvi/4bfWQNrUonhTwPz
 TYfCGGDb/uLYTHxf90ia97g/UkPvZbUydBhQHM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/jgqoPUUIYoAAgoLeNfYHpn2EoLd9IR2NYy24DlWlLV4
 LsenuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2y2N8r9
 pJXiqefQFgTAZXCo9gPbCBXRnQW0a1uoNcrIFCko9ycxhWfNnrqhfVzBV47PMsT/eMf7WNmq
 aFecmxcKEra3aTvkO3TpupE3qzPKOH0PYcbu3hliyHEBPA0QIHKRari5cJRwzoxwMtJGJ4yY
 uJAMGoxNkmYM3WjPH8wUpYbrOyz2EXfXA1Kql7JnY4Y4kvcmVkZPL/FaoeJJoLTFK25hH2wo
 mvZ9mD9KgMbMdaFwHyE9Gitj6nBh0vTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTnBWiolWsS91Wc
 xVR+yxorbU760GqCNL6WnVUvUJooDYnHNUKLaog1zqiw/Xu3D6XPVQWcQdOPYlOWNANeRQm0
 VqAntXMDDNpsaGIRX/1yop4vQ9eKgBOcTBdPnVsoR8tuoC4/9tp1nojW/46SPbt5uAZDw0c1
 BihikADa1g7ltwb2KzjpBXGhXSsu5HWQw9z7QLSNo5E0u+bTNH+D2BLwQKBhRqlEGp/ZgXf1
 JTjs5TOhN3i9bnXyESwrBwlRdlFHcqtPjzGmkJIFJI87Tmr8HPLVdkOvWkkfxYxa5hdJ2eBj
 KrvVeV5ucQ70JyCMPMfXm5MI55ykfiI+SrND6y8giVyjmhZLlLboH83NCZ8LkjtjUEznKB3J
 ZqQccCrCXEVCKl8hDGxAY8gPUwDm0gDKZfobcmjlXyPiOLADFbMEOttGAbQMogRsf3VyC2Io
 o43H5bbkH13DbyuCgGJqtR7BQ5RchAG6WXe8JE/mhireVY9RwnMypb5ndscRmCSt/0MyLyZr
 y3nBxcwJZiWrSSvFDhmo0tLMNvHNauTZ1phY3JxVbpx83R8M4up8okFcJ47Iesu+OB5lKYmT
 +QMZMiBRP9IT22fqTgaaJD8qq1kdQiq1F7RYnv6MGRjcs4yXRHN9//lYhDrqHsEAB2xuJZsu
 LanzA7aHccOSl06XsbbYf6i1X2run0ZlL4gVkfEOIALKkXx+ZdnKmr6ifpue5MALhDKxz270
 QeKAEZE+rSc/N9prNSQ3PKKtYakFed6D3F2JWiD4ObkLzTe80qi3ZREDLSCcwfbWT6m466lf
 +hUk6zxPfBbzlZHt41wT+Riwa4kvYK9vK1KwQ08RTDKaRKrF7p/L3jA1s5K7/UfyrhcsAqwe
 0SO5tgLZerUaZy1TAIcdFg/c+CO9fAIgT2Ov/47F0P3uX1s972dXEQOYhSB1H5HIL1uPN93y
 OstopRPuRetmhUjao/DjyYS93mFMXEBFa4gs8hCUoPsjwMqzHBEYIDdW3OpvcDQO4kQPxl4O
 CKQiYrDm69YmhjIfU01GCWfxuFan5kP5E1HwVJqy45lQTYZaiLbHSG98AjbiixO3AVI2roqf
 2ltcU1oLLqD/nFjg80rs6VA3e1eLEXxx6Az4wJheK7lo42AVnHEM2A8f+2K+Sj1NkpCKyND8
 ujwJHnNCF7XkQKY4sf2cU54ouPuTJp68QiqdAVL2SiaN8FSXAcJSZNCqYbFR9ULzC/xaID6S
 TFWwdtN
IronPort-HdrOrdr: A9a23:LenTgawSZPD34G8Qy1cUKrPwLb1zdoMgy1knxilNoHtuA66lfq
 GV7ZEmPHDP5gr5NEtMpTniAtjifZq/z/9ICOAqVN/INjUO01HGEGgN1+ffK+GJIVyZygYLvp
 0QFJSWcOeRMbEst7ef3DWF
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,272,1643670000"; 
   d="scan'208";a="11862508"
X-MGA-submission: =?us-ascii?q?MDGBPDb8YQDYQ2EUZJn//gWfIXYik1oVJmatBY?=
 =?us-ascii?q?Hcr8194SMSg0z8/OdOuobk3hkv5kw/4PXdDBHwuceRskCVYpANG0Gdtk?=
 =?us-ascii?q?4EimvmnRinHAeaNAhQgVaWYAe+26g16JeMsXnPO/rMTADOLOwLxbwwJ+?=
 =?us-ascii?q?QEFUCnVtP5afDLyfc2+bvOWQ=3D=3D?=
Received: from szxga01-in.huawei.com ([45.249.212.187])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 13:52:26 +0200
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KjMbF2F0vzfYt2;
	Tue, 19 Apr 2022 19:51:37 +0800 (CST)
Received: from container.huawei.com (10.175.104.82) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 19:52:20 +0800
From: Ziyang Xuan <william.xuanziyang@huawei.com>
To: <Julia.Lawall@inria.fr>, <nicolas.palix@imag.fr>,
	<daniel.thompson@linaro.org>, <cocci@inria.fr>,
	<linux-kernel@vger.kernel.org>
Date: Tue, 19 Apr 2022 20:10:13 +0800
Message-ID: <20220419121013.1290398-1-william.xuanziyang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] cocinelle: iterators: optimize device_node_continue
 rule
Reply-To: Ziyang Xuan <william.xuanziyang@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 362
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/20220419121013.1290398-1-william.xuanziyang%40huawei.com>

Execute the device_node_continue.cocci for kernel source. Get an error
report as following:
./drivers/pci/hotplug/pnv_php.c:161:2-13: ERROR: probable double put.

After analysis, we can find that it is false positive, because it is to
detach the node from device tree. And we can abstract out an exception.

Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
 scripts/coccinelle/iterators/device_node_continue.cocci | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/coccinelle/iterators/device_node_continue.cocci b/scripts/coccinelle/iterators/device_node_continue.cocci
index f8cd14dfa604..4b8ee3316a8c 100644
--- a/scripts/coccinelle/iterators/device_node_continue.cocci
+++ b/scripts/coccinelle/iterators/device_node_continue.cocci
@@ -49,9 +49,11 @@ for_each_node_with_property(n,e1) S
 &
 i@p1(...) {
    ... when != of_node_get(n)
+       when != of_detach_node(n)
        when any
    of_node_put@p2(n);
-   ... when any
+   ... when != of_detach_node(n)
+       when any
 }
 )
 
-- 
2.25.1

