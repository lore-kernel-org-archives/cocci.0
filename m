Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5708C87FC5
	for <cocci@archiver.kernel.org>; Mon, 21 Jul 2025 06:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=riECfsrLo1eTO1hsm7R8At4dsxRKg1Kwfd7SKUvE1ZE=;
  b=iFFO37jXyG0suaFrS+FOBwPUqNlwIB/3qvcoaZWUBLjUi91OcK7dLR72
   bHwVzslIc/DvLUDeI/B0zNVoVpwcpwrqiXYE6E3JqB6+fY8nKDsxk/urI
   4ILMOii9fc3LjSZmGtufZt6sXMUfwQ5rXlluD1QqVQVJD8VApFk7Y4UdR
   E=;
X-CSE-ConnectionGUID: w67jX11KSbuOfnO1o6n9KA==
X-CSE-MsgGUID: eydajo77ScG+4sdVA/N1qg==
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
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="232397432"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jul 2025 08:59:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C85E4E0264; Mon, 21 Jul 2025 08:59:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5802CE0172
	for <cocci@sympa.inria.fr>; Mon, 21 Jul 2025 08:59:00 +0200 (CEST)
X-CSE-ConnectionGUID: bLzVslubTO2aChhthBF3dw==
X-CSE-MsgGUID: 4XihNj6QRNule2+NgXykwg==
IronPort-SDR: 687de534_YDqE+qWBVKIej0aXVYGJ6hnrCMkLdpJ+aySZVCAjQ5GwqYj
 5hd5hG/uqi7u7+OF8O9OFFdaBB8z+A9TySS2e3A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H5AwDw431ogAwR49RaHQEBAQEJARIBBQUBQIFTgkSBB?=
 =?us-ascii?q?lQzBAtJhFWPUIZfhzyHVIh4gWmBaQIPAQMBDU4BAgQBAQMEhQACjBMCHgcBB?=
 =?us-ascii?q?DQTAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxh?=
 =?us-ascii?q?XsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QCAQMjHQEBEScPCxoCJgICVgYBF?=
 =?us-ascii?q?AEBgn6CIgEGEAEDMgevHYEygQGCDAEBBtpeHywiWYFkCYEbLoVtgmQBhieEP?=
 =?us-ascii?q?CcPgVVEgTwLgng+hAU+g1uCaYImRFKDZJUGUngcA1ksAVUTFwsHBYEgQwMqN?=
 =?us-ascii?q?DEjSwUtHYEnfYMKgQ6EJytPgiIBdYF5QRk/g1UeBm0PBoEYGkoCAgIFAkNFd?=
 =?us-ascii?q?0ACAQttPTcJCxsGPZJigkVag0Utxkc0B4I4gWeBZAyfawYTL4Nxk2AOBpMEm?=
 =?us-ascii?q?QYio0iFVYF/I4FcMxokgzZPAxkPjiGEM8EzQTU8AgcBCgEBAwmFRgEBiXyBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
 3PgJJvnII5VOoCpgySKhXFlkY6MF0eCBLhw
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZoC+EKNooffo5MBcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:Wm3bRG8Gv0H0aCKZlzKVv0QwCP4+dmDX8FCKKmS4CXppYpPORUDFrQ==
X-Talos-MUID: 9a23:XW62EwQUtZFeFVWqRXSwtDBiEsU22p6IFUQAy9YgtPmVNjN/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="232397418"
X-MGA-submission: =?us-ascii?q?MDFGvOxxEXMTao8R5lKo18e3Pa/8ZYTJdeVC0H?=
 =?us-ascii?q?V0k0zngYf33h4LGfpzzcfbbDh83V/vhysrLeAy6As9fLb/u0oIt3NQcp?=
 =?us-ascii?q?KNhkdglKv6cy4AZCEpDm3eB8u9REcs7oUucP8YgXrvR7E0S8di2c9HHQ?=
 =?us-ascii?q?Aja4MsG42JH5fFEEuLhOHrwQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 08:59:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753081139; x=1753685939; i=markus.elfring@web.de;
	bh=riECfsrLo1eTO1hsm7R8At4dsxRKg1Kwfd7SKUvE1ZE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lLStfvZlx78SZgGS5zYG54nQR/H+bqebqEOKYRlNQhabbGGRfI8yBcx0+G75sSq4
	 +nad1rsKmaltJvOq78u8dV0bfhAEHbnaTZ4k7V/jca9xknLq27LcARI6cOAZgp9xM
	 2NvbBL/hcyYcDCCDBSYpSBv2AVwGOJyyxGizPJzSrmhrVMHyaenNH6o906FY0AYUW
	 4gDRVPqDfL2iVWQ5BGFeKBIFiQVpSgJKNrfAJUZAnYP+kDbw5YgqXwSb/YcCmlUlv
	 7YpbhXPD/f5ms6oHCI5W0agLbQeT/CXdzWu3vNqmsTfXV/XpPiJCbuMAMgqadTKEK
	 EXdCrvNZCPIY52eKZg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melax-1vBQgA09Dx-00inFs; Mon, 21
 Jul 2025 08:58:59 +0200
Message-ID: <52ce78f5-8141-46dc-9ad0-5cbfedfd92a1@web.de>
Date: Mon, 21 Jul 2025 08:58:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de>
 <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr>
 <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de>
 <alpine.DEB.2.22.394.2507201608390.3477@hadrien>
 <bf7d6619-92c5-4471-a6fd-df4af8b97e39@web.de>
 <alpine.DEB.2.22.394.2507210747070.18950@hadrien>
 <6fa377f7-0612-42aa-afbc-cdeab8bea314@web.de>
 <8a4b47e2-725e-769e-6bb-43e01113f9fa@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8a4b47e2-725e-769e-6bb-43e01113f9fa@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EduyRpgt45zG082gCjG65uPFdqlOtlTfaiBbsZ+BOZXrK1qxGwt
 erDxZFlBY35d/UGjcizb7wDguWOSRSP7WCyLtzP9OnsGvcTl87KOfiQlmi8aCtWYZiUZGMt
 47oUJIf0iCJ/Do2KMmlSgnjDr2ko6N3qi5TsCApTlshd05xv12NBS/X+DWgh6Gyl8z3KaBg
 3EB6L6tBlIDtOmm67NaAA==
UI-OutboundReport: notjunk:1;M01:P0:0fwaZC8Z3Ko=;Eh112tLMY6RmQDIYxIE8kpd/Mkd
 9ahKHJshxH6UWe7VuoZjV/97L7N1lMX9aeXAaYs7DWZ0pmDf6O0PdHmcTRez8Cpxhx82TxZBt
 WU2esdCtSfcAJxzDUush24T9UY0HvJ0/Uq11yD/p8ME+ko5yjdI8csCxlvP+pocc3kfXAdcp/
 eiL7cfO2lxu/Wq5UOrplLzI5RbPRxxg6n4qVCeXES4nEAleuZg/cP8W7NupowowlI/q2TaIwF
 hQajXpHrvMagYaUTCmPM3gOgnlsWEihr/pQVgXL3rp1mOo89S1Ih1EGNnAnw1bpdqcnwcvaxm
 qMhZHRGIA+M4BX3z5pqlGqXFsH9GvA/cqNfUJlmkK1pvYGmQhGXTh51eDcwNQyjoAPIIGgEpL
 nI8gFbp6bJvPEf8U2damS/v/R/0InVJ74QDn0f1URUCx0u9dUAC2/vd6h172BajhcQbrywxzs
 loyHGLU2s1gPiD9JJGqtgIen8BcE1QC7x8nxezwJfusRBjy/8TtvG+olx2UccQjFr0bZeGw6f
 BdgH15zMcRpmgifr7H1ubMUu0XjLWkavnBESIWrEFSCDzXdSI2dVGAj+tKcwmZRnOaL0jB5i3
 FoGA9y1PKqdAXDQyz2TUT2gQuEWFcueL5NLLAlVJbSfxIOkbkk7H6R/X5TBB6/x9qf3n5DEZF
 jIUPz9bDdMhB/gpiFDmBvMkLII6H5339Qh7lRdS/ciwxHMF8o6Vrgo9ZHf1TgpuH+7aGm6XzX
 EUq6+wUhB4bUvFig+JvXkLol1TDFogDe/7JS93RCFUvq8i/nGbVTS7ng4bhTw0RaK5qibvUqE
 GgTn+ii9IW6jp/MQ9fW2TBdNwZPMxVerV4shyGL9QXFr4+ZolJZi4h4+58jY6evdGNUKKVef9
 698JcxAnDuAFNZjmAr67L4X2dFn6/9/DrC7QmiMSS0cxuSOh6jFBhZsTXYOjZoRqG5N+jE/jj
 TOZjejj76AnOqP+zsL1KDQpJmjM/GKIbQSlbzRcmpBS2rjLhEFpz++WKbkvDQCc7aOHsSrTa8
 Fh8WUNqJCGQ2yK0o+ZQZiCwyzQ9lMG6OLfz+k2jLFtZzkXLJx6mK5azKqG7SNdxgivF/87jmq
 T5fJwdf8UQ8KaxGYUCoUT2fs1RmyOPsRf1pI5MISZY883QSbirZeOa0wGhudqWyEsjxxCUkI8
 TJcJyrF0XE96incbwKamTnt2/8q01i9C15XT1NBwGB1wfctvGlPgLyypPzsgihDay7q7ig4pq
 KPUHh9DhifeTbzCwsa7PnBdN+XW3jN83x6L6XY27IXnm6HHaHYTJ7BCRyCG9NoJrsNPgc76Wv
 GzlJrKcITroj4WDOUjVAgQTf1WMY+8W83QyWenQmGt48lZ+xgNQ1ILu0wHX3F43kmIRNvnOzh
 njD1K9fNsnlJ242j7LLnqz4ncr8jGPLU98zN0Ij8JKIdAwV+4h44m0MQnMdr8BC75DDDONGi8
 2ZEtAZ6RjWMGbIqDNRIlGztO67Z2mPGtK2RC/07k29vcJ/MaN4TGz9TEId+R5yBrG6fiFEAgX
 dT8AJwRVEEFjfjcqBl5XymSV7KFrB0Sf+hz7ccDIldejRLsvOXvPM2YpA9Nb7avoqwNvlbux7
 k9KIMqUn8BedvgJ3297qXIAcm6LpUoHU5XCEcvVeL7KUZCcpYOCEjXdL7qh0GsBgd2psTsXA4
 JK8scrlnWjGMAeO+kgcftpU3D6Pg0+pgIZ1UeDaLheKOkPG2cEpDUfrBD3LUT6mpYu5NxI4uk
 3NOuxK5H2JFhb12aea883xeGKHWzzCJvV7go8MGwrAyLx8+uYjLKu27Pk0OojV6EizHsOJdnx
 ZzTJ9CA8DnoMNrzPVLHXIFYt7bP+AgzMztWI7XboMvG+MrL4OywkWr2oy/gulDq03WWWIr05O
 ovDPGvRZPxq+kxGS3UuBCy+45njI3BwhcHzhyVjVHyB8FExp1EvCsVDBWu8XSzUzosQ3DcGAI
 IyMD3BATZg1EcosIf/Qo6EmEL47VHx9koQkepaCWQdCGRMkSzUPxYM5m/Y+CCuyDnAIMHIcQ6
 gsRw1pcwimC3Zo7wE26J8T3/q9t/0VVDyEn0Q/RVww0JkGH87J6TWDkfqyco3Fb3b0RDXKDjt
 CX3xQFjauHk7tX7xylk9IDkSebYic6kqICDjAOI77pTbTEOhk1hgwWbU/oat2rjlKUIt2nCWD
 bziZqX2qAyBi3UJNQIs0bncojW+tBmmAD/NzTC5H1lxAmwD5JRAcK1Ad/6TmJpNsPaIIyLms2
 Xh0itA9kbIm6Qup1jH7P8BXRA852oJgCtq9j5PtPzWb3Y0mb5VqblmWGjIrnt9/EC9D8ZCHqG
 CciqOLp7EqJyyNcAz1kIk4XEOJJbBmpmcuAydYEDYe7V/2XuIIXFU+SgLzHSrVL3KKj9bDaSF
 lfHVs/rDJpcxkNVMHQocW9nHM7SwO7H2n/ra2peJJ5c6a6MKDFuPltpqDzN6gOXEW7aJvitGp
 STNoThsG891MNRKqIc4RrFtJX7FjSGP8e+Yruigjtw49FsXBJarsElDC3nWpWKabjKIPFmxPU
 uivxOJUXdhulypjqBreqgEXWRNPdcW2P80zt/vbQqE7oPvKYaxBltufy5m2N/Xf6nd9OzoNrk
 Kb2Xhr51Uw1wtRRW6OOCe+vaZICeXyscoHGO02qbm3oGlp2oVMEqUUkcJWxRTb2EtswblTu0o
 wsnYcjGvp+NLthTB8d8JZqX0QlNoFbLzwjfwo4V+Kdy3u0/e1H3E2iDgjNDddZ7OnrCJJ+5bF
 yVEuxX9CbmnXbQ6iSinHwH7/sR81OIv8S4PFlxyoTFEIGBMKakcdcHIQEEmD7CQfUKDmjPMCB
 Y1Txz1D8DJA1vkJSy7woeVh6HLcMuAl5HCa/N/4ZRqnIIjbo3/TB/G0fRwHEoT11a6ZlCOYhv
 yfpEvgDnLtoaca5/B/wGBwx18iIc7rPooBcJlzy6IX6Hc3fE2YdDDq9tIU/icZ5bRs3iI6yTi
 K49cVtpDjijE1b/+hU7N5DnrEvRP06iAUyYuZUtmgtf8ZWKTgog1XWqSz88/dHf9plTUh/rue
 Zb3ipu7MHTXnPxBPL1GnKSVSR7eQL8/f80N4mrZhngScOKg5xawXRtUVnb7Mp8Bynv6GuE9cP
 9/0PguGuSNKHp6oFuRPuAOiwdC9IbVmuuU+mJitPzyPVLUsPJ8eb9Iy7mhSfPd3AzHQF4nUPr
 ET75L0FW3sUMUV9SVNwc+T0rZ8BtUheWdoZ6uw0uPNfsr203pW+3Qrm/5+jYz1mAha9bHK0ER
 vWeva7zikGSCZUIxsBEzPIOtEKiKPXFZmAVMjPnraJW7qvpVNBHwJ67wSA+Z3yZunx7NldEKV
 ZaRiruQYrIsZzKy6XOLZzHxd65RPY34dSKiIC01JrlGn6ylXkxm5+VaXlVMleUUCeILIcev5k
 mZqi7IzRnZC1PttpBJ1l0Hs+3Vkmvui+d2NjNjwyyLE2nI+D8a/baqDyUqahZDXteVvaEmutp
 eUAK/rKN9XbxJF5XWodbYaeX4KbPHQ0f469akTljLOX+44YGezrGs/y8pVj+piwUCAwbDAnWs
 1fmimnbyjFqRPVSuAJfgtIk=
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2885
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/52ce78f5-8141-46dc-9ad0-5cbfedfd92a1%40web.de>

>> * We would occasionally like to transform selected expressions
>>   (which were captured by instances of the metavariable type =E2=80=9Ce=
xpression=E2=80=9D),
>>   don't we?
> Yes.

Thanks for an agreement on this use case.


>> * Do we care then if it would be needed to specify extra parentheses (o=
r not)
>>   for plus slice specifications?
> No.

I interpret this feedback in the way that it indicates another communicati=
on difficulty.

I am trying to develop adjustments that are consistent and modify source c=
ode
places in a minimal and required way.
I find the influence of the data handling for parentheses important someho=
w.

Regards,
Markus
