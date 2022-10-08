Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8382AC433F5
	for <cocci@archiver.kernel.org>; Sat,  8 Oct 2022 11:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=aAVCRqCtVQuc6fFGk1yp7hF4oov2Bw0Q3HeLiWWVOl8=;
  b=dSo34DNmJsQR4j1synLeWMaZO8DKZ5J3mbXaALrnb1GgqpCaSZGqgs6Z
   le5RVVt/N3R4b1RH6+3W1mvzZQtk8wKwtqD1yio6IdV0grVGazZRH3YZ/
   si4krw5y7FZooAUh/J30Q0FAELWE1wH61yYuRIhmCDwpyKZ57Zl9/k6Sy
   w=;
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
X-IronPort-AV: E=Sophos;i="5.95,169,1661810400"; 
   d="scan'208";a="56605927"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Oct 2022 13:02:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5FD81E028F; Sat,  8 Oct 2022 13:02:49 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CEF30E0121
	for <cocci@sympa.inria.fr>; Sat,  8 Oct 2022 13:02:43 +0200 (CEST)
IronPort-SDR: 634158d3_8sQ8+IELVSjHrJz/N9yyt+z0aq57ZLFPK9ikoSN8PUWvsKc
 LIE3dr16jcKjrRZy6JN2RIqnXr9Z36HfwxsgTxA==
X-IPAS-Result: =?us-ascii?q?A0AfAABmWEFjhw4P49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPQQBAQELAYIjgVcuBAtFhE6QZzGEKIcYhyWKMIF8CwEDAQ0/AQIEA?=
 =?us-ascii?q?QGFBQKEdAIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBE?=
 =?us-ascii?q?wEBARkJFwcOBQsFIoVoDYI1KQGDZAECAgEjHQEBESYBBAsLGgImAgJXBgEMC?=
 =?us-ascii?q?AEBgnmCbQEDDSMHq0qBMoEBgggBAQaETh8sIlOBXAmBESwBi042hCknEIFVR?=
 =?us-ascii?q?IE8gkw3PogbgmaUcYVMJgQOAxkrHUECAQtCNQMVAxQDBSEHAxkPIw0NBBYHD?=
 =?us-ascii?q?AMDBSUDAgIbBwICAwIGEwUCAhc2NAgECAQrJA8FAgcvBQQvAh4EBQYRCAIWA?=
 =?us-ascii?q?gYEBAQEFQIQCAIIJhcHExgbGQEFMicOCSEWBgoEGg0FBhMDIEkmBQo4Dygva?=
 =?us-ascii?q?SsdGweBDCoJHxUDBAQDAgYTAyICDSkxFAQpEw8tBylxCQIDImYFAwMEKCwDC?=
 =?us-ascii?q?SEfBygkPAdYEigBBAMCECI9BgMJAwIiWHYCCyYRFQUDDRkmCAU3GwQIPAIFB?=
 =?us-ascii?q?lMTAgoSAxIPBidKD0pAPZsvUxkIgzwconKfFzQHghuBRoFJDJ5SBhMulmgOB?=
 =?us-ascii?q?pIKlxAgp0+BaAMwgVszGiSDNk4DGQ+OIBmEDIotPzQ7AgYLAQEDCYVHAQGFT?=
 =?us-ascii?q?AEB?=
IronPort-PHdr: A9a23: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
 PLmr5dEWVZzGv5IUixY
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:/4PfAqv2VGLmkt7q6efRHay77skDUtV00zEX/kB9WHVpmwKj5q
 STdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQouVvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,169,1661810400"; 
   d="scan'208";a="56605924"
X-MGA-submission: =?us-ascii?q?MDETEFOmLTSfFxmSsOCQ3u2jDbVtniiS/tr6dB?=
 =?us-ascii?q?KLrMmVveg0DrtjBFzCDp9QEploCQWSmZcDcOnZSiBOIpX0npT4IkNitW?=
 =?us-ascii?q?Qn/3sya5NzI8ittdREnapdtfgCN9PbD3/1MJ/b3NSUHwsAdaenVnUMZT?=
 =?us-ascii?q?+24n+Qzfd7t9aGLbab9updOw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 13:02:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1665226962; bh=CN4bzH1ASd/XRYAHGKmaNJJfNtB22swXryMS37LCTb8=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=eKv0pOfKU7VhHiStxoXB9P0daK5OCCxalaxgw+y081r7qlwwBDDilfUHj4KCR871j
	 MS7whPepybnVHvCL+o+Bgf3wNJCjTZVOS12eccxxxwvj4LYVmPWBo9xi05s3v5yuxp
	 rayS3kzyWw/0DGQ+CxK5y5FUNQpFM+bis9TeUrUPaw6qquY2tmrpFsPiPt4djr1y7S
	 wS01YSUfU95vzJ2U5D/JAYiw92kOk8dr6k1YVotbXQ5ePD/5LchYvMBSBDuWRErRbN
	 lRvYyUUGTXtM7WujPyVh6h+xIk3sX/OFyihppkw7ie7+79dEs3lQtC9YKwguOQ0QDd
	 pOj6nOTy1Rdzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.160]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYu16-1ocfbt35EG-00VAbn; Sat, 08
 Oct 2022 13:02:41 +0200
Message-ID: <6d1e1044-c4fe-2d86-67ba-0fad33103a3c@web.de>
Date: Sat, 8 Oct 2022 13:02:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, Kees Cook <keescook@chromium.org>,
 cocci@inria.fr
References: <202210071600.078A2101@keescook>
 <alpine.DEB.2.22.394.2210080942250.3287@hadrien>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2210080942250.3287@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:f5IcKGZIrCmVDX76kjNRJeFHugxOL5PUtQfOrJf4E+4esFCzyfx
 DGC2mj+9phhucmDhud8lmsM4b2QRnM7pJs92bhwDZvnCN2tzL7S+NYZx2q0bBB3ywK03VmT
 3vZhFYoNTHGb1v0KKF0jt9hV9MXeCuMzoa5wUnpmV7L71vVgMi/I3UAtB+5UWmB63ynXvBV
 c2i+xL9Thv8mnhI9ibQHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BP2rj84vlHo=:I7EdylND8LkstRoSVU0Z4F
 M/WuTm59QpiFzSASxyDrNxLqaZn+GXlU06g4KeBRYG4KukYCzk7CUpQv6s2kfrzK/74HwKfbA
 YI/X/jurk5jMU2//AoJhz+c4aAXWcMcb8xNijoXd38VUmlO71CnyibaEoGlqXumo50Y+q1LVi
 vOkXMM70JO2XD2+o4CVesxmh/iQYLOKv+2FZ+An2oG0B0icVNKD8ithXYFAaZ0pycWjeaYeR8
 TQcsnuVsSk4Wj3mrSusZ20VlHB5nQiClsvqz577LWP9BsoD+lhaBzcMCRtPSxFIjJEMp4mmMW
 gDtLqLuybfNyck4EX/E7+OwajTCQ2LM7Hn1PbL1n6oNZ8SPomHOgBb4cVsGV8/paIDyJYIwUr
 VQRjrDevlOEDFpDlFU7h75y17UetN5V5w0zRBQpbb57tkWL71HrAlwR2yjKZ22f/9RzekbWq1
 mRrMFbJGnQimH1PxLlrMq+D+h/ZJ6G8pbJ4muKBFGEBiWfIRakImk9dPTmpPgKnV6XNTcl1c6
 nrS+brhFwZKXTeeL+pZcHXyyXQL2p/Y5EZR97jZaxv+n7T2HKSqksuARfBZNbZejE8p8dulh7
 JXLA1Kw63qQ2RwJz2MpJWhK1s9OP+XcyivYAupMcgwqzliH8y15t0CMCL9YCS4azpGqzgRO0g
 +zBY/81wRpapWfqiFzsTw/Ckt+ScMVN2+LGZ5JQVio8DP+Xdz0uvm/T5h4eG29ADubE4jckBD
 yENFYYrSExAjWrn1dQsYFFm/An7D+vtN7GeirU85sCKL11ln1MKbGLOreSWezXFNIPRpttawx
 Vor4NGfthyUftzwm5/25Yklw5oGrPAsVZJqQI+HoEqoCqQR/cM/9EyWHNfXNyvlxpRmbl5Oci
 oh/PzYw0J8fY6OdPWKKwMfG7iU6dP3zvUJqVxrBrTbK7IIRnSRSU4dfix366/MpUS5B2RE1jP
 EQDkQbUWuA2OyIj2RUS6r2EAASabyMnY6IuTAIfC80KUxk8xXWkGJnXcYdzIMxK9rKRokRoNp
 QWIVKx1JvXsyOR5HvybTbcwl/C1GuH/5dRkgTuQIqsCD6kR7fyH90ml/7CAjfBfpc2gvTD+gQ
 EQZ2OJTfUIfLyZLZQPA2d+lDcah4eWQ7mIzR+FizK25jmiEc3jEOEEfeKn3j4drChgmykRFLw
 ZBtYRgvyxrTvk7ecYl2jMgcOkbi+qMZ9+jYVpJfFd1hTI97A4HTMD0mcIfp77+C5OIQLQZgjm
 hPEll3Qsa0KgdoH4ZZjVCrL8g/UBfhXWgfqMwgqIF20aYOWa6v3exTH6h9WFf6DBvTqz2iC7x
 VXwO3Y60/RPt2ehI4a5BIWcOamOn56mGwCkDoL0YXo5mkL8VraTSLUIhXFEpUOEWW+AXXF8wT
 +S3eVqqV+gf9o57dJHVUsWdG26bM38dUWeOGSPszTfi34J/bGdHY/35N0FiG866FN+Bp2/f+K
 4HpXIS91iBmICHQpFUd/+ip63Kej7ce5gB04akRspXL6XwonPK873qABxOCeVOL7w9X/NdUWR
 cmrtkdiLvzQ55MAZxctjc2E8LRG/rckMHfgbAkFX106k0
Subject: Re: [cocci] how to check a for "don't care" state of a variable?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 622
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/6d1e1044-c4fe-2d86-67ba-0fad33103a3c%40web.de>

> - x = e;
>   ... when != x
> ? x = e';
>
> The ? will stop the match if the thing is found,

You suggested to delete an assignment statement by a single SmPL rule.
I would miss the replacement then for the assignment target in
a macro/function call parameter.


> but won't require the presence of that thing for the match to be successful.

Thus I propose to reconsider the transformation approach in more detail.

I would expect that it needs to be determined if the assignment target
would be used at other places within a code block before a code modification
can be applied by a subsequent SmPL rule.
Will the algorithm require any additional case distinctions accordingly?

Regards,
Markus
