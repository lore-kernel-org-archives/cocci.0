Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB2FC47E49
	for <cocci@archiver.kernel.org>; Mon, 22 Jan 2024 07:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=1yOW40goW6rGJB8XHaIl7RBljtVlCtFDeIKimM5SiUg=;
  b=MQ13X9/s5n/QYJKi7Kl5bk6ur3ZHRVFxk32h8LGkCh6DP1QYVmoTUqDt
   RC5p2Xzzvlpn7wFMV20sBIUeKrRnT2nbHwKYi5hN8PU+x3wjmXEVhi9gg
   g0R9qJp+urrYRwWuxsO3RdjgdlRCS9pP3u9EA+dYGiGzYAJIXP9vJ8cQL
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.05,211,1701126000"; 
   d="scan'208";a="147851136"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jan 2024 08:50:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D9BB2E0CE7; Mon, 22 Jan 2024 08:50:52 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9555DE0035
	for <cocci@sympa.inria.fr>; Mon, 22 Jan 2024 04:28:16 +0100 (CET)
IronPort-SDR: 65ade0ce_VSkOYx+IzWHVEcDYOPyFMxFq34Q4Sq+YHl0VsL8X6Zj/ouU
 vqDE5OFzrCx1reFMFO7D1ldgqEK4TbAeR6shuAw==
X-IPAS-Result: =?us-ascii?q?A0GqAgDQ361l/zFaNs9aHgEBCxIMggQLgjkHgUwxBwhIj?=
 =?us-ascii?q?U+hFIVagX4PAQMBDUQEAQGFBodIAh8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBC?=
 =?us-ascii?q?AEBBQEBAQIBAQIEBgECgQYThXmCXAGDcBYgAUaBUCKCXoJgAgGmOAGBKz8CK?=
 =?us-ascii?q?AFAAQyBC4s+GgJlsy6BaoFIjGKGH4FJRIR9hAqBBoV2BIIWg0ORUkqBJgOBB?=
 =?us-ascii?q?W8bEB43ERAFDg0DCG4dAjE8AwUDBDIKEgwLIQUTQgNDBkkLAwIaBQMDBIEwB?=
 =?us-ascii?q?Q0aAhAsJgMDEkkCEBQDOAMDBgMKMTBVQQxQA2gfGhgJPA8MGgIbGw0nIwIsQ?=
 =?us-ascii?q?AMREgIWAyQWBDQRCQsmAyoGNwISDAYGCV0mFgkEJQMIBANUAyN0EQMECgMUB?=
 =?us-ascii?q?wsHeINSAwkDBwVJQAMLGA1IESw1FBsGPm8HmCoHgQ6CKaUtoGKEG4FhiQSWM?=
 =?us-ascii?q?k2XMx4Dkj8BLodVkFGkEYRcgWM9gVlNI4M3TwMZD6IeNTQ7AgcLAQEDCYhuN?=
 =?us-ascii?q?IFGAQE?=
IronPort-PHdr: A9a23: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
 8wkdhjNP30=
IronPort-Data: A9a23:kCG3K6Le9mVlaTgCFE+RC5AlxSXFcZb7ZxGr2PjKsXjdYENS3zRRm
 zdJWmmEOK2CYzT8eNgnbYixpkwHsJfdnddkSwEd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgf4s9JIGjhMsf7b8Uk25K+aVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LuV2q1gNRLXXoPH4Qpo8RlWEtf0
 sEKN2VYBvyDr7reLLOTR/Jl3YIjJ5C3Yd5a5TdrliqDS/c+QZXTBa7N4Le03h9q3p8IQKqYN
 pJfNWsHgBfoO3WjPn8TCYA+neWpj3/XfSBaqU6OuOw85G27IAlZieSyYICKJoPaLSlTthnC+
 2zK43zbO04LafzP0xDZ0i+DivCayEsXX6pXTtVU7MVChFSMz2gXIA8XUFGhqL+4jFS/UpRRM
 SQ88S0lpqka712uVtC7XhuioXfCsAR0ZjZLO+Ah4VrLyqGNv1vEQzdCRWVaMponrM8zVXoh0
 Vrhc87VOAGDeYa9ERq1nop4ZxvrUcTMBTZaPXVWfhhP+NT5voA4gzTGS9spQub/jcT4FXu0i
 3qGpTQ3zedbx8Ma9bSJzXaeiRKVp7/NUlEU4CfTVTmb9Q9XXtOuSLGpzln51sx+CrilYGOPh
 kVZpPjG3tsyVcmMsAevXNQyGKqY4qfZET/E3n9qMZoT1xWs3H+BeIxv+ClyBGEwFsMiZzXSQ
 VTyvDlJ78R5J0qabq5QYqOwBf81zKPmK8/Xa/DMYvdKYblzbAWi/hwyVXWP3mvorlcgoZs/N
 bifb8yoK3QQUoZj8xabWMYf1uUN6h0l5GaOW63+8Qur4YCeaFGRV70BFlmENcI9zaGcpTTq4
 8RtDNSLxzpfQd/BTHHuq6BLFm8zLF8/GZzSgO5UfLTaIgNZRUcQO8WIyrYlI4FYj6BZk9nTx
 U6EW2ha9UHegEPWIgDbe1Fhb7LSBaxEl0wZBhB1H1iU2CkEW72NvYM/bJo8eIc1+NNzlcBUS
 +Y3QOTeI/BtZAmexREjQ8jclrFyTDWqmgOEAAS9ahcdYZNLZlLE6/3kTCTV5QgMCSuFhe0+h
 qz90TLJbMIlezl+KteLatf06kKVuHwCkc0rA2/NBMdZQ2T30Y1QMyeqpOQGE8INDhTixzWhy
 AedBykDl9TNu4MY9Nroh7iOioWUT89SO1V8HnbKypqTLgzI13uH7a4bd9jQZhHbdmf/2Jv6V
 NVv1/umbcE2xgdbgbRzA5NA7Pwb9dDwg5R40w49PnHAT2rzO4NaOnPcgPV+7Pxc9IR45zmzd
 FmEoORBGLOzP8jgLl4dCSwlYsmH1tAWgjPi1us0Emqr+B5I+Ke7bmsKMymukCB9KJ5HALEhy
 8olu+8U7FWboTguOdCkkCtV1jqtKlotbqYZjawZUbTb0lcT9lJ/YJLnGnDX5rOLYI5yKUUEG
 GKfq5fDoLV+/XD8VUQPO0LD5sdnvqRWiit2lAcDA3+rhuv6guQG2UwN0DYvESVQ4BZ188NyH
 WlJMkFKPb2C3xExoM1lQWqXOhpgASeB8Rfb0Go5l2z+TmipWFfSLWY7B/2/wUAB/09YfRlZ5
 Lu9ylu5YQ31fcr04DQ+aXRlp9PnU9Z10A/Iw+KjIOioALg4ZmDDrpK1RG9VtSbiP9w9tHfHq
 cZu4ux0T6/xbgwUgq8jDrilxaYicw+FKENCUMNe0vswR0+EQw6L2B+KN0yVUeFOLaaT8UaHV
 upfFvgWXBG6jCuzvjQXAJAXGIBNndkr2cEjf436LmtXopqdqTtU6KjrzBbcv1NyYdtSkpcaE
 LjzJgKySjnawTMenmLWt8BLN1apedRONkW2wOmx9/5PDJ4Z9v1ldUYpyLavonGJK01d8gmJu
 B/YLbrjpwC4JV+AQ6O3ekmCO+m1FT83fOmT+Vv1s98XMY6SdJiIvFgO8B/mJwRTLf0aXNEfe
 XGlrovsxE2c1FopezmxpnVDP/AhCQaOsC5/PN/1LWVBgG2JX8qED94r5TWjMZIQ+D9CzpDPe
 uZ7AfdcsfYbRtVc2GZILSNZFn7xzkgxgrjI/UuAkhhHNvTRPcEr4j9qGb8FoFy3rhM1BqA=
IronPort-HdrOrdr: A9a23:XtqdWKwUPBIYrLQ4oBiwKrPw971zdoMgy1knxilNoNJuA66lfq
 eV7YwmPHDP+VIssR0b+exoW5PwOE80i6QFhrX5VI3KNGSL1wXIEGgI1/qG/9SPIVycygda78
 wLT0EHMqyXMbGst7eA3OFze+xQuuVuisqT9JrjJ7IEd3AVV0mlhz0JdTpyuCVNNXh77V1QLu
 vh2vZ6
X-Talos-CUID: =?us-ascii?q?9a23=3AgicKQWkflQGE4sNt9eX05nCBb6jXOVnMlTTxBh6?=
 =?us-ascii?q?DMERgeeS3Wwa66YRZgdU7zg=3D=3D?=
X-Talos-MUID: 9a23:n/+P/gbnNe/YbuBT6GWxij1+LOVRvLXzKBAXu8km5uaIKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,211,1701126000"; 
   d="scan'208";a="147827478"
X-MGA-submission: =?us-ascii?q?MDHkBnsSADlQPvdU7vP3xFrhft/hej5gLJH7IA?=
 =?us-ascii?q?nBSLxEMSJWCwd0mEcIKFspi2qAE0D69omo32bL8eWg+z8WWh/TRADQ1C?=
 =?us-ascii?q?0dzAQoop17+XziYQ3RWiSMI7iWkWNgosmDCgRo9F91TqoqH29MuHA8iL?=
 =?us-ascii?q?9VCDOWHPoavoSHnbAHIFHqLw=3D=3D?=
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:28:15 +0100
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="146822596"
X-IronPort-AV: E=Sophos;i="6.05,211,1701097200"; 
   d="scan'208";a="146822596"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 12:28:07 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 80405D6189;
	Mon, 22 Jan 2024 12:28:04 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id C30CFF812;
	Mon, 22 Jan 2024 12:28:03 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 53CD92007C3F2;
	Mon, 22 Jan 2024 12:28:03 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B6A441A0072;
	Mon, 22 Jan 2024 11:28:02 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr
Date: Mon, 22 Jan 2024 11:28:00 +0800
Message-Id: <20240122032800.33026-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28134.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28134.004
X-TMASE-Result: 10--0.455700-10.000000
X-TMASE-MatchedRID: MqppGi75AUV0AdYYTJWxRBFbgtHjUWLy1QQ6Jx/fflaZtziFUn+D+VDO
	mRheGpIyFyzfcBR8wcvmn3xyPJAJoh2P280ZiGmRGYJhRh6ssevRW9GSMIeErpsoi2XrUn/Js98
	n9dYnJNNQSFbL1bvQASdET58jp62SAhVVB5z0sflF+IsnUJfkL1RCd8l/HzOb8aPI9eQYwt4pe8
	xpRQnWIVnW9zbTJCbj37LvzsUFnIDWyJ18TBwTnsDKJLsrHxQRwGC8e6520fKw0PJt06oJaHpaQ
	l5xviY7wxgWdRvK9Un9g+oMf9KM6Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] coccinelle: device_attr_show: Remove useless
 expression STR
Reply-To: Li Zhijian <lizhijian@fujitsu.com>
X-Loop: cocci@inria.fr
X-Sequence: 1471
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/20240122032800.33026-1-lizhijian%40fujitsu.com>

Commit ff82e84e80fc ("coccinelle: device_attr_show: simplify patch case")
simplifies the patch case, as a result, STR is no longer needed.

CC: Julia Lawall <Julia.Lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: cocci@inria.fr
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 scripts/coccinelle/api/device_attr_show.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
index 550d1d2fc02a..dfcf9304195f 100644
--- a/scripts/coccinelle/api/device_attr_show.cocci
+++ b/scripts/coccinelle/api/device_attr_show.cocci
@@ -28,7 +28,7 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
 
 @rp depends on patch@
 identifier show, dev, attr, buf;
-expression BUF, SZ, FORMAT, STR;
+expression BUF, SZ, FORMAT;
 @@
 
 ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
-- 
2.29.2

