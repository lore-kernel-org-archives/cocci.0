Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F64C5DF92
	for <cocci@archiver.kernel.org>; Fri, 21 Aug 2026 08:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=2RRzTf15BWKNMGMt8MDiUuiFNGiUIoGkX1Ztk/Dh/Ck=;
  b=YxPFILYKVgfQhVYaWrYiD7918s3MW4JkJm2XHExpW0E6WAiOMmhO7alh
   7pRRtjif3V2rEATO6eQGUf8+uL6WuANMNYQJWH52jOwPplJfw2K6UJJA6
   GM2ywmyHheAA9rouy6WDaU/X/j7y8GudvLx3m13u99NNKlBwYVIWAY9Dy
   s=;
X-CSE-ConnectionGUID: HD2CRX8qR56gSQ1cWnBYyw==
X-CSE-MsgGUID: YfgLSpgVSP2/GgYLR4CiRQ==
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
X-IronPort-AV: E=Sophos;i="6.25,234,1779141600"; 
   d="scan'208";a="290933027"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Aug 2026 10:26:58 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8239581824; Fri, 21 Aug 2026 10:26:58 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 65B378174B
	for <cocci@sympa.inria.fr>; Thu, 20 Aug 2026 23:28:48 +0200 (CEST)
X-CSE-ConnectionGUID: sIMwuskmT3ue9JyVA+F4DQ==
X-CSE-MsgGUID: numYYmHgSGa1mx3s/6htnQ==
IronPort-SDR: 6a877190_N/Pjn9donKj7tGuMvhjq7/65sEs+YeJvGs28Q/LbkTLLR6T
 1fRtPf6B4Ywi5gNc97Y/byDh6JHnQEZviI1tuvw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FzAgByb4dqhQRV9rlaHgEBCxIMggULgkGBCgZaMgcIS?=
 =?us-ascii?q?ZZOMJwWgVWBfAIPAQMBDT0UBAEBAQIEhH4CjW0CHwYBBDIHDgECBAMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABAQEBQEmGTw2CW4EsgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEdAg1+AQEBAzoGAQE3AQ8LGC5WBgGDFAGCIgdLBw3CWoE0g?=
 =?us-ascii?q?QGCDAEBBtwzgWkDBhWBOIVxgm0BhXg7g0d6Jw+BVUSBR4J5PosIgRKBFIEMj?=
 =?us-ascii?q?WCFalJ4eCwBVRMXCwcFgSNDAyovLSNLBS0dgSMhHRcXHlgbBgUSICpBRCMDP?=
 =?us-ascii?q?jiBCEECgXU/Ixk2fIEJXoErKmEBAhAXRi4VggoCgl+BJ14CAUlDDgcuC209N?=
 =?us-ascii?q?xQZkAcggkeBOYEZZMcANAeEIYFgBgyKL5YHg3GTdpMFmQgjhTGINps5gW8LK?=
 =?us-ascii?q?IFcMxojgzdQAxkPjiEZJYNEhRPHCEM0PQEBBwIHDgMLgWiEXotWgUwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:SrnyoqAGcfZnKhVW/9bnw5YqxClBgxIJ4kV8jS/XYbTApD123zNTm
 DQYXWCHafbeMTD2fN5+YYqwpxhTuJPVz94yTANkpHpgZkwWlceUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOiTraCZmYpHFEMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMTdJ4RYtWo4vw/zF8k4HUMja4mtC4ARuP6gT5TcyqlFMZH4hDfHpR5fHatIMdgKKb
 76r5K20+Grf4yAsBruN+p7nclcHS6LlJgOHjHxbQcCK2nCucQRvukqTHKN0hXZ/011lrfgoo
 Dl+ncXYpTMSA0H5sLh1vy9wQ3gvZ/UekFPwCSPXXcS7lyUqepZ3qhlkJBle0YYwo46bDYzSn
 BCxxf9kgh2r3oqLLLyHpuZEneUGM9TwP4Yj4WxtnBPIM99lb8zvevCfjTNY9G9YasFmBvPCf
 80EdX83N1LPahlGNxERBY5WcOWA3ymiNWcE9hTF+Oxri4TQ5FQZPLzFOd7YatWMSd9Y2EyVo
 mbB+WXRCBYdKNiez3yO9XfEaurnx3KjCNJMRezjnhJsqFuOw10iDT0ZbnSy+Pyp0VX5BdJDL
 XVBr0LCqoBrrx33FYisN/Gim1aAtwEVX954Aew/4huEjKvS+QeQQGYeJhZKb9cttectVDky3
 xmImcnoDHphqtWopWm17bKItTSvJW1NdikNbCsNQE0D7sWLTJwPYgznVfdGD7OujdjJQiz9k
 hKbkgF9qek/tJtev0mkxmwrlQ5AsbDndGYICuj/RWe59gRkeMv9PMqn4FzS4LBGIZrxori9U
 JosxZX2AAMmV83leMmxrAMlR+rBCxGtbGa0vLKXN8N9nwlBAlb6FWyq3N2BGKuZGp9fKGOyM
 R67VfJ55ZxUIX+jJal6f8qqAt9C8JUM4e/ND6iOBvIXO8gZXFHcpklGOxXPt10BZWB3ysnTz
 7/AKp70VR73yM1PkFKLegvq+eV3mX1imTOIHfgWDX2PiNKjWZJccp9dWHPmUwzzxPrsTNz9q
 o4DaZm52F9EXffgYyLa14cWIBpYZTI4HJ364YgfPOKKPgMsSilrBu7z0IERXdVvv51UsePUo
 VC7eEtTk2TkiVP9dA6lV3FEaZHUZ6hZk04VByIXEGiN52kCeqeqtacWSIs2d+Io9ctl1v9Fc
 MMGcMShXNVJbCjL2x4DYanEsKlOUQmZ3yyVDhWYfTI6QcZBRhPIyPDgbADA5CkDNQvplMoc8
 pmL9BLXfooHfCtmVP3pUfOIy0+9mVM/idBCdRLEDfcLcXq97bUwDTL6i8EGBv0lKDLB92O87
 BmXCxJJntv9idY53/eRjJ/VsrrzNfV1G3dbOGzp7byWEy3+1Uj7yK9iVNe4RxzsZFnWyo6DO
 9oMl+rdNccZlmlkq4B/SrZn7Zwv7uvV+oN18F5WI2XpXX+KVJVbPXi07etevPZsx5hYmzeMd
 GChx914AYiNaeTZSAM/BQx9demS9+Amqh+L59QPHUjKzitW/r2GbEZsAyexmBFtdLtYDYd07
 toi6eg36hO+gCUEKtyprD5Z3EXSI20iU5cIjIA7AojquzU7zlxtT4HuKg3yxJStb99jIlcgJ
 zu9ta+Tmbhz1lLIcicxHyKV3M52p5cHiDZVxnAsenWLndv8ue8z0TJ/7AYXbAB04zdD2c1jJ
 GJuNEx7HrqP9DFWn/p+X3igNgVCJR+B8GrzwEstuEyAaGfwTU3LDmk2GdjVzXAj62gGIwRqp
 uCJ+ljqQRPBXZ/X3BJrfWVHtva6b9h61jOaqfCdB87fQqULO2v0sJSPO1gNhQDsW/4qpUv9o
 uJvwuZ8RIv7OQMUoIw5E4Oq7qsRej/VOF19Rexdw41REVH+YD2S3R28G3K1cO5JJN3I9hacI
 O5qLcRtSR+/9XivqhY2OK0yGIJ3zcUZvIc6RrDWJGA9o+S+qBhtu8nu7STQvjIgbOhvtscfE
 bnvUQy+PFaev0YJpF+VnvJ4YjK5RfImeDzD2PuE9bRVNpAb78BpX0IA8pq1mHS3MAFIwU6lg
 17AbKrr0t1n959msNrxG5hpBg/ueIv5e+CV1AWVrd51TMjuNP3WvFg/sWjXPAVxPJoQVe9ol
 L+LjsXF4UPdsJsyUEHbg5OnFaJZwemTBc15atnWKltelgu8AP7c2QMJoT2EGMYYgeFj6dmCb
 CrmTsmJLPo+ecpXnV9RYAhgSyctMbz9NPrclHnsvsa3K0Yv1CLcJ4ma7l7vV2ZQcxEIN7DYC
 gPZv/WP5MhSnL9TBS0rVu1XPJtlHGDNAacWVcX9lT29PFmahlmvvrjDlx15zRrpDnKCMtjx4
 LObZxzYWSmxhpr1z4Big9QvhiEUMXdzv7BhNAZVsdt7kCuzA2M6PPwQe8dOQI1dlivpkor0f
 nfRZW8lEj/wRilAbQ662tn4QwODHaYbD78V/NDyE5+8ME9axb9sAYeNMg975mtufSb/ibn8b
 94X/nT9eB683vmFgM4Ns+ejj74PKuzynxo1FYLVyqQewCryxZ0A03t9GAtLEyfAFqkhUW3Vc
 HMtSzksrF6TECbM/AUJR5KRMBseuy/rzjNuZiCKqDoaV0N308UYoMDC1yrPPnHvoSjEyHPih
 Z86eodV312r5w==
IronPort-HdrOrdr: A9a23:c/gNLqifW6lRtg/73AfbSyb1z3BQXu0ji2hC6mlwRA09TyX+rb
 HNoB17726WtN91YhodcL+7VZVoLUmxyXcN2/h1AV7BZmfbURqTTL2KhLGKq1fd8kbFl9K1u5
 0OT0FWMqyWMXFKyej7/SilGJIazNOG6aClgvqb53phVg1xcchbnmNENjo=
X-Talos-CUID: 9a23:I8tOIm8eV+AmnSFHs72Vv1U1P984aX7Y8CzNLh6aGFhAC5PJZWbFrQ==
X-Talos-MUID: 9a23:sLHXswvrNlZnYAQaeM2ngixnBfZtw6uVJ0lUlIVdoI7aNTB2AmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,233,1779141600"; 
   d="scan'208";a="290886993"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGysQiuIpI9jaW7VYN1gGtVR/jErhgtiMiaH0?=
 =?us-ascii?q?b/peunG/yRtq4VvIRREf28r7xIP8IxxMcgL26hbGe9wWOkgE6MeKFL9r?=
 =?us-ascii?q?Elwt4mBRtk1xejVdxRUKH+9MQcd5T/wte6SLbkHNtxnfQPJbXQSlz7kg?=
 =?us-ascii?q?vZkuosDgLrlNvInJMSGS/95Q=3D=3D?=
Received: from smtpout-03.galae.net ([185.246.85.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 23:28:48 +0200
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C65314E4130C;
	Thu, 20 Aug 2026 21:28:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 92F025FF59;
	Thu, 20 Aug 2026 21:28:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5544B11C7687F;
	Thu, 20 Aug 2026 23:28:41 +0200 (CEST)
Date: Thu, 20 Aug 2026 23:28:41 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Julia.Lawall@inria.fr, Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Message-ID: <178726066531.423710.3877565026736920974.b4-ty@b4>
References: <20260723184538.3888637-30-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723184538.3888637-30-ekffu200098@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] (subset) [PATCH 29/36] rtc: pcf2127: remove conditional
 return with no effect
Reply-To: Alexandre Belloni <alexandre.belloni@bootlin.com>
X-Loop: cocci@inria.fr
X-Sequence: 3689
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/L1tofO7-zF_KVTwqMAsD6A>

On Fri, 24 Jul 2026 03:45:31 +0900, Sang-Heon Jeon wrote:
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> 
> [...]

Applied, thanks!

[29/36] rtc: pcf2127: remove conditional return with no effect
        https://git.kernel.org/abelloni/c/b1407862fb57

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
