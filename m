Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D3BCE8E9A
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2024 18:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hn0tATfy6OKn8CwtYHG7HqjcjOwJxshbIosmrvW0sVQ=;
  b=C5kVOzmF/ejuVdXbp2/OmcA+NWpr9aemNi+Zmibrs7vEXJbKa0pX5djf
   W9lQB3S6Z9LIoN6s166Ek6nTWCky5+g0DGdQqXOcyFrpMUsiZJs1fihL/
   DZaA3ez8FjRnKwxZOXwimvmvtivRke9IPCvE2HDHFGftE8lF4piZBplZm
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190618270"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2024 20:26:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B441CE0D1D; Thu, 24 Oct 2024 20:26:51 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B0BDBE0133
	for <cocci@sympa.inria.fr>; Thu, 24 Oct 2024 20:26:46 +0200 (CEST)
IronPort-SDR: 671a9155_hFQprs93YkOWzY1n59rNsiVp/rLud2AEEf1Xn8MUkAkf+23
 JXkcgeKojnrxBacM6udEyOBEwLw3i6YpuVntckw==
X-IPAS-Result: =?us-ascii?q?A0EnAAD7kBpn/w4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDB1t1MwQLSIRWiB2HMIF0MIQ7hzqHVIpLgX4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEhQACiiYCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QKBCggLhTVGDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBB?=
 =?us-ascii?q?AsLGgImAgJWBhUBAYJ9gjABAw4jB7AwgTKBAYIMAQEG2lsfLCJXgWMJgRouA?=
 =?us-ascii?q?YVpgmIBimAnD4FVRIE8gks4PogegmmSCYtqJYhBbpIjUnscA1khEwFVExcLC?=
 =?us-ascii?q?QWJNQqDHCmBRSaEEQiBKxODX4FnCWGIQoEMgT6BWQGDOEqDTIFhBThJgk1qT?=
 =?us-ascii?q?jcCDQI3giSBAIJPgSUEBYM8gVYdQAIBC209NQkLGwY9rjWFGaYFoTU0B4I4g?=
 =?us-ascii?q?WWBYwyfVQYTL4NyAZNNDgaSeJh3qSCBZz2BWTMaJIM2UgsOD44hDBaEC8ohQ?=
 =?us-ascii?q?TU7AgcLAQEDCYVGAQGNLYFLAQE?=
IronPort-PHdr: A9a23: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
 BBjfkkLorDCtUuwY916HHFdqGVoJ6+IlnTBh9Q=
IronPort-Data: A9a23:Mm9esa+Ya9sqq5DKVNOEDrUDl3+TJUtcMsCJ2f8bNWPcYEJGY0x3n
 GIaCz3Xa/+OZ2D9KYoia4yz8RgH75TTmNdrGwttqXhEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWctWo4ow/jb8k825K6u4GlwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TE/8xgFBwGGKwk57wrDGJl9
 /ZfcCEncUXW7w626OrTpuhEg8M+MI/0MYlZtnwIITPxV698B8qZHOOTuJkBgF/chegWdRraT
 +8Qczlyd1LtZxNVO1EYII0zlqGkixETdhUB+QrL/PptvTW7IApZ/v/QIIbySsKwecB4n32eg
 Trn2nToK0RPXDCY4X/fmp62vcfEmijwWaoJBbig/7hrhkeSzyodEnUruUCTpP6klgihVtgZJ
 0F8FjcSkJXePXeDFrHVNyBUalbY1vKxc4M4/zESgO1M9kbV3+pdLm0DUyIHd9Es8sM7LdDvO
 pllgPuxbQGDcpXMIZ5eyltQhSy/M24ZIAfuoAcaGBAd7YCLTJ4b13ryoxUKLEJxpsL4E3f8z
 lhmacT4a6o71aY26klwwbwLb/9AaHQEos7ZKzg7hl6Y0z4=
IronPort-HdrOrdr: A9a23:H9qlxa4rxbitfJu86APXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HKoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:r0yzUGCRO991ADX6ExVe+lZJKuUETmCHkHrTCE2yTj54YqLAHA==
X-Talos-MUID: 9a23:xGUDuQQefSXonFzlRXTCwwxyaOBY/Z6SDW0MqpMh4+ihJT1ZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190618265"
X-MGA-submission: =?us-ascii?q?MDFWtLl/hzZOF4aDG0EWrRXjFYPpz8SAd07HJB?=
 =?us-ascii?q?qGdzfRQJQ/6iENUqcJkRlFIat8I74x4QErI8KEdDTvvk3+FOyaFUYiYy?=
 =?us-ascii?q?kJwxSD3PACrr8q1DD8JcpOI2Xmwo7dQ1tesZQLd3I21iPt23kcQK1lbF?=
 =?us-ascii?q?cy8o6JzBSbhGrm34RzuJk9Ag=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:26:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729794378; x=1730399178; i=markus.elfring@web.de;
	bh=hn0tATfy6OKn8CwtYHG7HqjcjOwJxshbIosmrvW0sVQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mXfbC3ckGBBDtcEF8ydkD88hd+R6/C7Ps2Y6ba3VIl9/bBM5yL783HSThoAnfZjP
	 EtIeuyikEZOsMcxmrjIAAd4j77awRf3PQKvGhiiZ3lIFyBoT7r3Rp8WuielZbxbBz
	 eH/PE303SqnDb1JYSN/EuaxQ0Kp42I1qlO1zxgcpE7xMBNM03ChzpaQ1Ui3WqtQLU
	 UuWjoUpR120ZutE/WUm6llnK4TVnBXjYlAYJmDjaQZq8d6vVaDiyfw9teJ3TJqqWY
	 j+j+vyH8VgZPYDRTmr63DMc6FazbnAraI9vaKbcPOECCNJGEqQIyzuV0nujI3xM4o
	 Z6x+O4/BWKyL2g3P6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5j5y-1swsro15Gk-00AANm; Thu, 24
 Oct 2024 20:26:18 +0200
Message-ID: <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de>
Date: Thu, 24 Oct 2024 20:26:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Derek M. Jones" <derek@knosof.co.uk>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
 <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk>
Content-Language: en-GB
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:oGrrTskhAH8H8+e+y5Mgy094YZINm/3vMnic4+hlAPSwne2W7UF
 Eqy882D0+1GX/8Xwb/8tHzcB8lq6nfHHsbPYiqVlrn81EFBjSwyWLfM1pIX5NAnCR9AO1+a
 CRk7vNy5tcTI/LwE1OP3qgfAX4mociTyWcaXiQBluMBVpFVLxTPpdWWjfJ9xA8eovaYOKPE
 EhJQjscTrD28LgXEs6fBQ==
UI-OutboundReport: notjunk:1;M01:P0:Wp84ic/f7H0=;r7O9z7XndiggUABt1pjjDtruHq+
 rEUTmRTVjvCmne3JpO2PgZC/KUVMxFDnMA6COzJn23XXBQVmdpNgDwuiUr8wGEKj3Zwkqz1oH
 rV8Dyf7EDotM1Z9m38zhWw+zBhONGc/LHq5lxZL8b5t4VJxkNcCZ9dHYEwDCHOks4MdbaZMx1
 9SWweqwmD6QHqRJYc6WvzJXSF6QVtoMQ20/CP8jARkKhDiXi673ubHG3lb1iklxm6g/5E3kIN
 nCppEFgnmXyqvFGxjxBM3XaGmiy3lL2ww1JNqOZ0fafc1zg8asfBYgZ16BMZvDyzsa6Zh80wi
 7iJYVo0n86ux2aFFBFw6dCdXkby7WkNHc9GtPIC29qCZfEjylpi37Yeg528oCCjyAj+Srd8P3
 wLnvwPdzcAMTFXn5NUOs6rAuz7e74a15Kry/KV3FUg2mmCt69PgZgfeq3Im1cGdVsoChebBNN
 Kbhm9ORtrVhstTP7Bg5oltaulJQn+7CgcnCp+9xxrFfZzC9ekZqjMlw7ahDTkkI8N7wJaxulU
 WaupdNQmqAFrbC9FMxf5wge17oJYs265dV2DgmhmdKMKfjt6xGw15bmfmaO2JAOJWPe5GM/U9
 UEnf/YRSoEe31WSdxbUdBYyUt8a4mIw4ykw/WHR04t++twBffuZ0oBXbxzmk1UK+MUMKrFeqW
 boCsI9YWtfEgV+kLUAVkUdSiBVTdRfPEypFOoVbHIYKW/olvJsvVotx3mB/HeiQtlBaeCGozi
 5wHkV++eGlFZKnQaBXwl4fUzkSByj/jnptygK1mS1wq/eFzc+u3JR3UgSp8ItoodHP1o0bzjZ
 x8e0XjqD8PZ7gfmxcVjiKlSA==
Subject: Re: [cocci] Multiple returns significant performance impact
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1935
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/ce176aaa-4ce2-4cd3-a943-527724957f9c%40web.de>

> For the linux-6.11.2 kernel
Which analysis goals did you try to achieve by extracting source code
position information from function implementations?

Regards,
Markus
