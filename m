Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5324DCA1013
	for <cocci@archiver.kernel.org>; Mon,  8 Sep 2025 06:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=aHaao9xAuSPKuiwEnvYwRe7gDOsSjqQthcNepo9HOk4=;
  b=SWl3Y3ixZOBQuH6QPtBKiP92JDz0u5tLt51YmJnuGp6xzP22TPw/oJE/
   E8aH/M8ROKw4ylo9XQUPdMdNxZT5WU6znMPBuVFjes0oAyFwR1rVNe2nc
   yqicofyRFfboh5PrDqWQOf0m067GbcfVJg4Iq4G12ORvR7O/PeGRpMeGI
   M=;
X-CSE-ConnectionGUID: ptKskgINT6yowaX9CRzY1g==
X-CSE-MsgGUID: q/biAuQmRdiHUl8csV6haA==
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
X-IronPort-AV: E=Sophos;i="6.18,247,1751234400"; 
   d="scan'208";a="237904881"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Sep 2025 08:15:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F0B13E0BE9; Mon,  8 Sep 2025 08:15:51 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E2DDEE0171
	for <cocci@sympa.inria.fr>; Mon,  8 Sep 2025 08:15:48 +0200 (CEST)
X-CSE-ConnectionGUID: GK3n8hgCRoGZrxDxk+AyEw==
X-CSE-MsgGUID: JY3hVuzCQ2KRj3mBedQGnw==
IronPort-SDR: 68be7494_xvivj+QM/cmMjYxRYGYNbmdrcPBEhCiImn/DeMCFspHdcYN
 u78+q6YmRmwTiVyhaI8NLJ0QpK582UmoGNr7nBQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EYAAAXc75ogAMP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYI/gQdUMwQLSYRViByHNIIkhDuHPIdViHmBVYF9Ag8BA?=
 =?us-ascii?q?wENTgECBAEBAwSFAAKMKQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABATsHDgoxhk8NgmIBgSSBJgEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARcCR0QBAQECASMdAQERJwQLCxoCJgICVgYBFAEBgn6CIwEGEAEDDyYHs?=
 =?us-ascii?q?DGBMoEBggwBAQaCadd2HywiWYFkCYEbLgGFa4JkAYYnhDwnD4FVRIE8gwM+h?=
 =?us-ascii?q?EODW4JpgiaBFoNYhleRPlJ4HANZLAFVExcLBwWBIEMDKjQxI0sFLR2BJ3mDB?=
 =?us-ascii?q?4ENhB4rT4IccoF0PhlAg1MeBmsPBoEVGUkCAgIFAkM+gW0iBh8SAgMBAgI6V?=
 =?us-ascii?q?xCBfQICBEtAAgELbT03CQsbBj2VdIcaDMY9NAeCOIFngWQMn2wGEy+DcQGTY?=
 =?us-ascii?q?A4GkwWZBiKpH4FoOoFcMxokgzZPAxkPjiGEM7lFQTU8AgcBCgEBAwmFRgEBj?=
 =?us-ascii?q?FaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:011RuKpwPMn1Qjw+e4IZ3sauenZeBmLHYRIvgKrLsJaIsI4StFCzt
 garIBmFPa3eYGTzLt5+O9nj8UgA78CEz4JnTFRppH8xRCsSp+PIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVaiZfHk3HVI5IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bNNwRcawr40Ird7ko/1BjOkGlA5AFmNKgU5AW2e0Q9VfrzG4nhdxMUfaEPRoZWd
 86bpJml82XQ+QsaC9/Nut7Tbk0QT7fOChOFg3xQVrLKqkAqSvsaj87XnNJFAatmo23hc+JZk
 L2hhrTsIesdBZAgrcxGO/Vu/46SCoUdkFPPCSDXXcV+VCQqeVO0qxllJBle0YH1Zo+bqIyBn
 BAVAGllU/yNuw656J2YEe88hssIFs7EDpkPlmFjjhjIIOlzFPgvQ42SjTNZ9DI3m9wIAvvUI
 cYUAdZtRE6ZOVsVYAhRUc94x49EhVGnG9FcgHecv6kq+C7+yAJr0b7iGMXYcJqGSK25m27C/
 T2XpzipXU1y2Nq36wve8kyxlMT2xwDBWtkXPrC0z9FsnwjGroAUIEZKBQPg8abRZlSFc9ZWN
 EUQ/gI8rK047kXtT9/nXhT+rmTslhUbUNFRO/Yr7RmEjKvS+QeQQGYeJgOtc/Qjs9IqAyMn3
 BmFkrsFGACDrpW6aimbprebhgm1FhoPPUMSZmwtXCYatoyLTJ4IsjrDSdNqEaiQh9LzGC3tz
 z3ikMTYr+pL5SLs//rjlW0rkw6RSo71ohkdyii/Y45IxgZ+eZLjeIGir1TWhRqhEGp7Zgjc1
 JTns5LChAzrMX1rvHLUKAnqNO/wj8tpyBWG3TZS82AJrlxBAUKLc4FK+y1ZL0x0KMsCcjKBS
 BaM5FwLus4DbCT7NPYfj2eN5yICkvaI+TPNCaC8UzaySsQhKlTvENxGPh/Jjjuz+KTSuftjZ
 8/AGSpTMZrqIf87nGLtF7h1PU4Dxyc4wnibXp2T8vhU+er2WZJhcp9caAHmRrlhssus+VyJm
 /4BbZfi40sFDoXWPHKNmaZNdg9iEJTOLcqmwyChXrTTelI+cIzgYteNqY4cl3tNxvQMybuSp
 SDsBie1CjPX3BX6FOlDUVg7AJuHYHq1hShT0fUEbAj2iUswK52i9rkefJYRdLwqvr4rh/1tQ
 vVPP43KDv1TQ36Vs34QfLvsnrxELR6LvAOpOzb6QT4de5U7eRfF1OW5dSTS9Q4PLBGNi+0An
 5Oa2Dj2f78/ViV5LcOPaPuQ31K75nccv+RpXnr3GNpYeWSy0Y0zNSDBt+I7ef8NDRD5whqby
 AekLhMKrsbdo4IO0YfohILVi6yLAudBDk5hMG2D1omPNA7e5XiG7b5bdfShJBTxdTrT1v25R
 ON3y/rcDqU2rGxSudAhL4cxnLMM2dT/gpR7kCJmJSzvRHa2AOpCJnKm45F+hpdVzOUEhTrsC
 1O9wfgEC7CnI8i/LUUwIjAiZeG91f05vDnewPA2AUfi7h9M47u1fhRODiaIlRBiAuN5AKE9z
 cclnfwm2Qi1px4pE9SB1wR/1WCHKF4eWKQG6LAeJqLWiTQQ91ITWqyEVxfK46yOZe5cbWgsA
 Duf35TZi5pmm0HtTnsUFFr259R7u6gggh5x4WU5Fwy7oead3v4T9z9NwAszVTVQn0lm0fosG
 21FNH9VBKSp/hUztvdiQlKDJgBlLz+a83zX1FEmujD4TU6pd2qVN0w7G7+H0344+lJmXApw3
 e+n2kP6dw31befN3icWcmx0mczJFNBe2FXLp5G6Ip6jAZI/XwvAvoavQmg58z3cHsI7gRz8l
 9lApepfR/XyCn8NnvcdFYKf6LU3TSKELkxkRdVK3vsAPUPYSQGI9Qm+EWKDUeITGKWS6m69M
 dJkGexXXRfn1CqukCESNZRRH5BKxswW9PgwUZK1A1UZsomvjCtj67PR0SncuFUFYftTleQFF
 4eAUA7aT0KxgyNPln7vvft0HDOyQeM5aT3W2MG39+Q0FKw/jtx8THFq7JyKuyS6DQg22TOVo
 wLJWIHOxcNA14lHvtXhA4dDNSqOOPLxU+WEqj6yl9F0afLOLsb8mAcHoXb3PwltHOUwWvYms
 Z+vodLIzEf+k7JuaF/gmr6FDLtsyfipeehqbvLMM3hRmBWdVP/W4xcs/36yLbpLmoh/4vaLa
 hSZaszqU/IoQPZYmWNobhZBHyYnC6jYarnqoQW/pa+uDjkfyQn2E8O1x0T2bG10dj46BLOmM
 1Xa482R39F/qJhAIDQmBPs8Wp9xHwLFaJscLtb0sWGVM3msjla8oYDdrBsH6wzQK3y6Ac3/s
 IPkRB//SUyIg5v27upl6q58gh5GK0xGo7gAThpIsZo+wTW3F3UPIukhII0LQMMc2DD70JbjI
 irBdi0+ACH6Ri5Jagj4/M+lZAqEG+gSIZ3sE1TFJa9Ph/ueX+tswYeN9xuMJ19zfSb/iv6qI
 5cS9xUc+/R3Lo5BHY4uCj6T2I+LBc82AloX9Eq7n8Ga79M2H+ARzHI4dOZSfXWvLiwO/Xkn4
 UAqSGoCTEzTpYsd1yp/UyY9JSz1dw8DA9nlgeljDTofV0imIDV89cDC
IronPort-HdrOrdr: A9a23:sx/RBa/wPiWT1hMiPPluk+AGI+orL9Y04lQ7vn2ZOiYlFvBw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhP1ICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtsJ
 uIGJIfNDSfNykZse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: =?us-ascii?q?9a23=3AYH/E82uPdc88Yw0hyjNlJae26IsKUSbbnHffCHW?=
 =?us-ascii?q?/JlRzWJGFShy56Y57xp8=3D?=
X-Talos-MUID: 9a23:RjMIdAlhyDoqO10D4w1WdnpABZxo3bm8I3lXsq8E4MyuOCBJFDGC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,247,1751234400"; 
   d="scan'208";a="237904874"
X-MGA-submission: =?us-ascii?q?MDGQbRKirTSCJlkNJ5UApmRukTp9Wn9xURAveM?=
 =?us-ascii?q?wFXAVmm9aZ48i4ywvLf8o+lbJjQUHv8LRZageGsEyv+1xJXTwaj1MIxE?=
 =?us-ascii?q?N2Iu7b57uQCtCJLkuo2q2OEWeYssawXVElwhgvSmpPuqvQrqRo+7wQ5C?=
 =?us-ascii?q?bOCYioJNjvazXguMMgD3ec4Q=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 08:15:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757312147; x=1757916947; i=markus.elfring@web.de;
	bh=aHaao9xAuSPKuiwEnvYwRe7gDOsSjqQthcNepo9HOk4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FsPB931me6ls6VIkecEMA9ExCkoPZgiZKyQyP2OtDL6onJvHtA/HsdtKlUG/A1Ho
	 hlDCR7E8tdD0/OAfIMsz0AT/vTtJggePvflD2CzdbotL40K4DpeTi5D3KE9u5kGDN
	 N86m2IAlRC6CZrzFr++qtoQawr/R+AAB2ltlAGpSsXihUypRZs6mp5Z0Uf38FRYOk
	 ktKSZXHWJvlJ0Fwqa4W5vDwB5EfaHVnm5GTu7R6uJjwUJ7PiRkSVqXzRlyMZILSyu
	 P5mhJAGZEetWoANwtzJvjjCRznsYNDQid6joneZ43oD7ihXT+Oly1UQvTQafEPb6y
	 YwaMTZb8n63g4fIr9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.229]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MD5jp-1umwao21D7-00GtJU; Mon, 08
 Sep 2025 08:15:47 +0200
Message-ID: <e70fe389-2f68-432c-804d-e51fdc9ee9ad@web.de>
Date: Mon, 8 Sep 2025 08:15:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
 <f798ce14-0401-4116-bbee-2b78ad0f774b@web.de>
 <4c46da9-1fa9-9b4f-f0c7-6c7fd094e163@inria.fr>
 <5bea704c-e59f-4438-8729-e48afbcd6832@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <5bea704c-e59f-4438-8729-e48afbcd6832@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gBJW83kcA/F/x4a1tdcPfYMqwDhhgCY3CG+McahpRPqC9Xr9+BZ
 mC7gXoM9ee7v4kOo4mGlq7IE0grwTAnGN+bOnJ9vLF/R7+lWjeWQnxJ6kNs67bB5oKBfKmt
 HcycT3NmZfXOCpbIppwAAUeFXTnedmapZn3BCissC9QME1NLKqesASW55fpb3rlCJIkCUNG
 1ycSSH9IHN4EHLrRguQeA==
UI-OutboundReport: notjunk:1;M01:P0:QBFOeQPypjc=;aO7MDyYgnbrBlTV4dh61hFsdoQG
 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
 tplYOkLRPU
Subject: Re: [cocci] Searching for selected variable assignments (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3012
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/e70fe389-2f68-432c-804d-e51fdc9ee9ad%40web.de>

> Thus I hope that the following SmPL script variant can help also to achi=
eve
> a better common understanding.
=E2=80=A6

Would you like to support such source code search approaches by the means =
of
coccicheck scripts?

How many SmPL rules will become applicable?

Regards,
Markus
