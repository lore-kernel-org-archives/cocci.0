Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21185C433F5
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 10:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lInJUjLPrV3jGdNk4ujgEjKI2Nk4oTqYmooA1d1t4vw=;
  b=dtM2kBNEFbG3S+nWvrF5qmR/YfqimwnpcVxDbNiu72NCb0GQ0m3m2weV
   UH/BoJ/JBKvOQTBLceJxBkCBb/6rwjpjCgdWCPKb6yFzzP9g4ngiN31uo
   VAy6QnNPBSZOeBKO9ccsmq168iRQLasZEaR2JBuzMasOGGD4sCRMw8Adb
   8=;
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
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="26991662"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 11:31:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2880EE020F; Sat, 19 Mar 2022 11:31:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 40075E0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 11:31:35 +0100 (CET)
IronPort-SDR: MQQF/DXNxNlkR1xD/YExSPu0FqIMXl7Otqylos45A1YszO1r0PFk0vc1in3AOgUqwsv2Epd3n3
 XMViMsz3GL2rsjSZJrbuW1qYI65PhO37KUBbZge0mYzT+Nle5fFXfSA3gaNkqX29Glk3lK5Qu8
 lGT0xp78nWb7fSEY/1LU07m1KI52bZGpPTWHqnoJnbIycp9lyktkHAwByt1pP0tPznyhnR+z1g
 mgH1cpwKE7e02tZPOfR+sRdYnJtIBPEyN+Yl3Q+qfyZ2lddEqKnd2hfJse+T019Vq24XC+tL4+
 6IyosGJQFiYIZlsDp/pypKzU
X-IPAS-Result: =?us-ascii?q?A0BsAQC1rzVihwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VoCgiaBVSsEC0SEVJEbiySHGIwjCwEDAQ0+AQIEAQGCEoJrAQkChDQCHQcBB?=
 =?us-ascii?q?DUFDQECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEMDQkFCAoHD?=
 =?us-ascii?q?hAFNgZeBmQEgUsEgXQLNA2CNSkBg2QBAgIBIx0BAREmAQQLCxoCJgICVwYNC?=
 =?us-ascii?q?AEBgwCCZQEDDSWtZIExgQGCCAEBBoRIHywiUoFbCYEQLAGOSCcQgVVEgTyDA?=
 =?us-ascii?q?z6EXoMBgmWZDoIZRaIMnkQ0B4ISgTqBQQyeEQYULoNiAZJaDgaRbZZbpwKBe?=
 =?us-ascii?q?YF9MxokgzhOAQIBAg0BAgIDAQIBAgkBAQKOHRmEDIosQDQ4AgYLAQEDCYVHA?=
 =?us-ascii?q?QGKBQEB?=
IronPort-PHdr: A9a23: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
 rDy
IronPort-Data: A9a23:iy7jA6DT3VwjsRVW/zjlw5YqxClBgxIJ4kV8jS/XYbTApG4mgT1Tz
 DZLWm/VOfuIMDH8LowkYIuy/RkA65OHx9Y1OVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YPgUlvX0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYo3LVzs4sw
 ctHjIetaRcFAPDlgL5GfAYNRkmSPYUekFPGCX24rNDV0EDMNXfhqxlsJBtvZ8tCoLkxWDwIr
 pT0KxhVBvyHr8e/2rGmUa9Bgso5Lc/kFJwSsDdswFk1CN53GcmcH/iQjTNe9Co8r/lRQ8blX
 pIQQhp2My/yIDNEGH5CXfrSm8/x2yWhKmQGwL6PnoI85GPYzSRqwb31OZzUfMaLTINbhC6wo
 mvZ9mD9KgMbMdaFwHyE9Gitj6nBh0vGtJk6Ebql6rh1jVfVymF75AAquUWT5qXolBO3RdhmM
 FE06gYQ8IEqrheEUYyoN/Gnm0KsshkZUttWNuQ17gCR16bZizqk6ng4oi1pNYR675VqLdA+/
 gDZxoOzbdB6mODNERqgGqGoQSSaFQV9wYUqQCgCUQIP6sT5yG3Ypk+REo87eEJZpuf1FDD2x
 zmMoG0GibwXn6Y2O0iT+Ffan3Szq5KPQgNdCuTrsoCNvl4RiG2NPtLABb3nARBoct/xor6p4
 iFspiRmxLpSZaxhbQTUKAn3IJmn5uyeLBrXikN1Ep8q+lyFoiD/It0OuGwgehc2bq7onAMFh
 meD4Wu9A7cMbROXgVNfON3Z5zkCkPSxS4+/PhwqRoATOcIrHON4wM2eTRfNgz60yRZEfVAXY
 NnCOceqEXsAD6l7hDO5L9rxIpd7rh3SMVj7HMihpzz+ieT2TCfMFd8tbQXSBshksvLsiFiEq
 753aprRoz0CAb2WSneMq+Y7cwtVRUXX8Lit9qS7gMbYflE5cIzgYteNqY4cl3tNxP0EyL2Xo
 injBie1CjPX3BX6FOlDUVg7AJuHYHq1hStT0fUEMQn61n49T5yo6atDJZI7caN5pvNux7h4Q
 qBdKcmHB/1OTBXB+igcNMWs8tY9KU7z3Q/ebTC4ZDUffoJ7Q1Kb8NHTfjzpqHsEAB2xuJZsu
 LanzA7aHcEOSl06XsbbYf6i1X2run0ZlL4gVkfEOIcBZ0jmtoRncnSjgvgyKsAKCBPC2jrDi
 1fIW0hF/7GVrtZsotfThK2Co4O4KMdEHxJXTzvB8LK7FSjG5W79k4VOZ+a/e2yPXm3D/qj/N
 /5eyOvxMaFckVtH79h8HrJswf5s7tfjveYDnAFjAWmNcFmhTL9teyHU0c5Kv6xL57lYpQrvB
 hPRoIYHY+3RNZO3CkMVKSokcv+Hi6MelA7S2vJpck/00yl6oeicWkJIMhjQ0yFQcOlvPIU+z
 btzscIa8VXm2B8tL8rAkS1esWiBdyRSX6Iiv5AcIYnqlgtylgAcO8OBUHeu7cHdcchIP2krP
 iSQ2vjIiYNc8UyeIXA9In7AgLhGjpMUtREWl1IPKjxlQDYeaiPbAfGQzdg2cuiR5hBAzv41J
 WVhcUF4TUlLE/GEm+AbN11A2SkYbPFaxqA140QEnivVQiFEk0TTeXYlN7/lEF8xqgphk/syw
 F1c4HnoW3DmcakdG8f0tVFN85TecDC6yuEOdA1L0ShI81nWrAcJWpOTWFc=
IronPort-HdrOrdr: A9a23:lFHo26P/HYkWo8BcTuWjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KTHCUWDcurJ27O8gduVbArlvg1QpTgBUdAc0+/zZzzwLnFL
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="9017452"
X-MGA-submission: =?us-ascii?q?MDFLQ2hidtT516GKyTVqijefAEIJICPB3v1AQH?=
 =?us-ascii?q?K7n4yJ4rWfwPnOUxclzgwyRNisj2ZGVdeROWu592ioJ0jVOBlhAUdpBx?=
 =?us-ascii?q?E8C6kK/jx3b48JsJzSJVK78/qshX9P+JM2XIw1CKl94LwBH37SAboIwM?=
 =?us-ascii?q?giE2QarIeKMw3/1S/ak4znvw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 11:31:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647685893;
	bh=yySlzb2zkt+quQ9I4F1lC1iYSK+8v/5e1AYwthlE3ro=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=oT3/EtE/W9Ymfy7JdU0lriXvQds9PXd4uf/ZMHA6KuQd9NUy9mzmQ9dFWgLYjPAWd
	 +0YrtfgbzaRxhrnKBhXP+ITN9thcPSknIpwYG9+oAP5WDyKNr5TFACvg6zeLPj7qc7
	 4FImFA8Cxv96GaJwOnFOxQ7N/3uPuxlyyhJ1JVNQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.182.172]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Icd-1oH0t81YM3-00wuGN; Sat, 19
 Mar 2022 11:31:33 +0100
Message-ID: <66b66e5a-c024-7d0b-c84c-d780d5ce41f6@web.de>
Date: Sat, 19 Mar 2022 11:31:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
References: <30124bde-34e-65ca-d5bc-fc3255ccda3@ewheeler.net>
 <alpine.DEB.2.22.394.2203190922070.3204@hadrien>
Cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203190922070.3204@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ev6NwdIlGUVicm9xMxrd4LbpxLgNO9s52oNjMdtGODS65J/Zpgp
 LssMJA9x3izz1ZaVv99W1PJo4DdeWvkVIS1MB7i0+lDuywVdZ/IYcXOiIkGZ/7LMndsikN2
 7HlGwLQVlRG7KVigqAzk7P7uAKWARap3Z7DEH5kg7oub8pW/vuFUzrW5uhP/bdIk87Qojaz
 dql3Ea0zFH1BuyqYkQ4aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EHGBtLcMD1o=:Tlb1nj0Z3tRWCMDeEqL5NQ
 TrXBbU/erg/VHwBMET3pGJfrAOeCQfIEzeUFZfOT8dgsx2GGJWcHXkGjN/ccjluD7tYESEbVR
 Sq+exJFkBnKMbISYlGFvodFOyI1whPcGuZtgrrH/f1vcBlN25H1FvKGFMqIKXNCJNg2Lt5ix8
 R/P4yTVK9csxsKeP6cfsuhrMPjcGJQkYdGDnUiE7G5bVUqBjXQhy/YeupkdFjmDTfZQPiaN8K
 FMsDm0C8nzLQdVoGXkPdaDN51JMNMKWmetEutOJjpa2VB2mFtRqDKYqRrcIZ+m8GOO/iEvaRr
 yHQMECF1QZoI43Kh3LNCCk9eak15TZmWO2sowAV4J3kEgJnNZajGtFQDpDEs6w4/1UGhsZKsO
 GAS2TLXF/bmPpVhmyIE7Sdu4/WUdtZlK9UdbJLsZcgfzA9GbTj7OgPGbg/zUpzUTLMo9RFi/z
 7p5rgjbKYsDu0x2/kvnu+2BdzLG8PFr5bY0ro9ag3eoLUTUPQL2TiOyL+z47+qIHhPRQWJ9CX
 iy090Nr7ifUUeXI9MlROkk+Co92ngbsjh5gOkNzt+j/PCm5lez055Ls7cs89JcIdYK+BakP4k
 3wlZv0bjIJmXRGSDPVLSRLs6lMAdWaPLQIP2MyA3HEa+SogGk8Cqij1reUvhmxg4cFvo0Lgmn
 DkDuOHRZnxnjkSbHFYjEPUpyE/fsDSqvvBPA97OFNeBhMMnn8NKqqijlSvmom1lPa0yKDp3R3
 bK/RCX+H8g2q6/Lu9XSkEPhQxqavLNGCkyOkHbzDNt4f+z/sTKEQR0u1vMyJjpzBTVolP6iBg
 6qKf/2xincw9ix7JoBnP4xSRz3hQ6O0boo2+lC/ZLvQZAXCoo2Q+T44rplcYhuafBMctR2quZ
 opnpPHQaJrYLgMqUjRF8zetaAy9f7NpR4dVKztE73roeqsEfeUEzoBgm1bQ4AzNgQQ7iLFRZB
 0yErmsiTbzz7L5jdY2/nz4fwDwceFoRL3Qb6i7wnlbNb1ym9D3T4Puy562lGVUOfZq4ySx8Md
 1cAu1tPSl4KRsbzaDZ13EST6kybED+p4z6Kcv+FU8Al1WdEvH2wSRl3YyHpwNMN3HAWcS+/5F
 K6e+g+++J6l11Y=
Subject: Re: [cocci] Bug with '*' to display a match on the subsequent rule.
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 238
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/66b66e5a-c024-7d0b-c84c-d780d5ce41f6%40web.de>


> You can't mix * and + in a single semantic patch.  The patch you get would
> be strange.  There would be a + for the code that you want to add and a -
> for the code that you want to highlight.


How do you think to provide a better error message from the Coccinelle software
for a questionable mixture of SmPL data processing indicators?

Regards,
Markus

