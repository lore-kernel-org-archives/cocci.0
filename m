Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933EFC4321E
	for <cocci@archiver.kernel.org>; Sun,  4 Dec 2022 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6Q5XPHlm5P97MSyusg7SVTZmamQCzrKu91C9kQdLggA=;
  b=l0g+rpRuwXUdbAHY9BiwhZpTNI9wWFXSaTq70pFgWybKiW8zJa4EpUJq
   SalVh94jiPE6LSjW2kNc6Z4qnlVRcPJjABOdMfv5wVozCF0f7r4Vvql5I
   Uh4X3gvI9uo2Km3zYj8eUFYJtpPnaGrL9Pqs6hRNN9V9cV4re8MGtqlJ5
   I=;
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
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="81595757"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2022 15:00:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A188AE0235; Sun,  4 Dec 2022 15:00:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8C299E013A
	for <cocci@sympa.inria.fr>; Sun,  4 Dec 2022 15:00:13 +0100 (CET)
IronPort-SDR: 638ca7ed_RlBeImBrzx2O1fa79M6ntSjpgMezaw1RKSNeLJe2FfoyA0s
 S9+p0Y08aA98/iyaZ71t3g27Wqrdlv6kH2Pq0iA==
X-IPAS-Result: =?us-ascii?q?A0EEBAA2p4xjh07ASNlaHQEBAQEJARIBBQUBQIFPgi2BW?=
 =?us-ascii?q?y4EC0WET453giiEK4cihzCIYoMWPg8BAwENQQECBAEBAwSCC4JzAoUPAh0HA?=
 =?us-ascii?q?QRHAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGAsXBw4QB?=
 =?us-ascii?q?SKFaA2CNSkBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHUz0BAgIBI?=
 =?us-ascii?q?x0BAREnBAsLGgImAgJXBgEMCAEBgnqCbgEDDiMHrmKBMoEBgggBAQacBx8sI?=
 =?us-ascii?q?lOBXgmBFCyMaIQwJxCBVUSBPIMDPogbgmeMUoopYiUEDgMZKx1AAgELbQpDN?=
 =?us-ascii?q?QkCEUwrHBsHgQwqKBUDBAQDAgYTAyICDSgxFAQpEw0rJ28JAgMiYQUDAwQoL?=
 =?us-ascii?q?AMJIR8HFREkPAdWNwEEAwIPIDgGAwkDAiJUcwIuERUFAwsVJQgFSQQIOQUGU?=
 =?us-ascii?q?xICChEDEg8GJkUOSD45FgYncg4OEwNdgWkEM2aBCwpdwVWfZjQHgh+BTYFQD?=
 =?us-ascii?q?J5pBhMug2UBkwoOBpIWlz8gp1qCHIFcMxokgzZPAxkPjiAZhAyKLEA0OwIHC?=
 =?us-ascii?q?wEBAwmFRwEBhFYBAQ?=
IronPort-PHdr: A9a23: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
 iWcGN9qDWpq4854Kl6JzHDj9tSuZozLddxK/hyMz0Wa1rITcshu0KNQ22w+YzK65yBAqaZzj
 AQyj8vj5s7dcTorpf//WlkCa3X0f59BoGi3y/wEwYDPgMb3Wc8+UjQTAMmyFK3uT2hU7KW9c
 VzSQHpm+xL5UfLeBVPNuB0g9iySVcn2ZjfPYyNHhdR6GEvHfRMZ31pSBm1l2MZ+TF/ixdS9I
 h0guXZOvBih+0EKlL4vbUeaMC+XpR/0OGduDsHBcVwMtFAEvhyNec2GsrAjRWcBoMDn9lfVb
 DbBL0FBCWVDMqCdL3bkOLTmpdzJ8uzDQ/G7M+OLerKW7+pXS/aPw5urlIpg5TeFcMuVbDFkC
 LUg10xPUGoceYyRkigTSyERiyPGbtKK7Ba69Cptq8mj8fPtEAvx7IqLArFWPJ1h4RezyauEM
 ueRgm5+J1M6ntsUwmTUzbEEwFMIoyRpaiXrDrkK8yLADerRlqJREx8HenZzOc9PvMdelkFGP
 c/WjM+w16Yt1KdqTQgfEwWwwIf2NZ9vQSn1Ll7MCUeVOa7TIDTKx5qyeqagUfhLi/0SsRSsu
 DGdGkulPzKZljCvWQr8VIMExCydIhFav5mwNxh3Dm22BvfvcB6mK5laiTMswLs7rmzHPygQP
 HIvFiEF5q3V9i5ejvhlTiZZ6WF5KOCfhyuDx+zfN4pQrvZhRCh53bE/gjxy2/5e6ydKQ+Zwk
 S3Zo4t1ol2opeKIzyJuTBtErjsjbGOjuEJ/JePG+5MGVXuWpHrlCE2PBh5Mq9Y3UrUHVIhPx
 9KJmK+hcV9/
IronPort-Data: A9a23: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
 PrxgKfOxMkzsfmosfkx3Tg7YjqiOw==
IronPort-HdrOrdr: A9a23:KAYNM6+aWbDNhm1b5hxuk+AGI+orL9Y04lQ7vn2ZOiYlEfBw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtsJ
 uIGJIfNDSfNykZse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="41670430"
X-MGA-submission: =?us-ascii?q?MDFQXB3OPJ4Pyw9LwOUTKBNEpg/iw26+Ae/Hxv?=
 =?us-ascii?q?M6uNO5eFunGApHCg0cX8wyrHV7ct/bj2gMUryMe16j39HzwDM6Z5zaQS?=
 =?us-ascii?q?33Zzts1ugZ5yAMxLk41Bu+i572OX+84+BV8eab4O4HuJqh3UkrBeOPrM?=
 =?us-ascii?q?ZOCx2lvU7x61SX/Oa3gsojqg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 15:00:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1670162412; bh=6Q5XPHlm5P97MSyusg7SVTZmamQCzrKu91C9kQdLggA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=USC7GlzCA526cX0sWAe7C4W1cUw8010zlNKjWJ5uFjoz5CvVIGvOC5Pjt1HqtsrE7
	 wAP+txtKwF1mlMcW6/a1skbF7qk6Gya1ay5sicvquBaBIyL8MHljKJdf0wSUiwP52d
	 tTuyd5E6kdkuCbBFvy2LgNHKXTfvR/w1OXpQhGhQSQe8Yiyf7CBkf1u2t+7UcBbnTD
	 quTz1/BxwmN0aUXD+c2odcbDaiH7UduN4kjo7J2SZ2r0NCZcpBQgkvwq6NIMFk9RT3
	 pJr/IJH34y/abAc8TGqZCQZTHfaxSrvOc+VXgH+Q6YHLjlrFWWGe076k81JAwWOgsn
	 zQ/GcIYfJojJQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1aDp-1p0Scp0g5j-003Bnk; Sun, 04
 Dec 2022 15:00:12 +0100
Message-ID: <74316d3b-51da-09ca-fc8d-8b5d1d020603@web.de>
Date: Sun, 4 Dec 2022 15:00:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-GB
To: "Derek M. Jones" <derek@knosof.co.uk>, cocci@inria.fr
References: <a9cad00c-ede3-338d-da7d-801dab7d51c2@knosof.co.uk>
 <alpine.DEB.2.22.394.2212040832050.3337@hadrien>
 <b404ba8b-df56-1f22-c0c4-a3d3be6aea30@web.de>
 <414c04de-1014-d41d-dfb6-774a8666f22e@knosof.co.uk>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <414c04de-1014-d41d-dfb6-774a8666f22e@knosof.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NY4HDt9TdNUFI+i+Cx3vIkZisPnv08IhvXoxBhqjwvS7uA2JaiF
 gpJj80MUrNr6LtHu7Yj3f16i3kRc35ArWtp4HCO98uNw+wWeY9rJLVncG5Lw2C3L5Bgow/X
 y7Sd52f6V2XzKVEV1+izY6IBcdzeqjUDJOLw/uw1uSQxo7ZkoOd9+o+YBdZs8xnTr92T1qj
 6/eIk+9JeKDDhHwfxrEXg==
UI-OutboundReport: notjunk:1;M01:P0:YPeJqqKf8RU=;3H4IKpwYsLAz9K9gkQctZP5y4K6
 j7NczT3jXqG/is/UzJUCmZWNHyt5uVlOX04vO10uk9nAXO5I2Lj9cn6MxYKW4unR+TmSJs9mc
 s2ZqLVE4dL+bwfd5XbzHr8JG4Peapsite6PEJzxvSlgRxP3CJzCVHSMA0OpDiR4vcVKWoEsP+
 Whi5ZpJslZU20Hb9AlQh0gzSaBmqrfs6swsHVNAlFbemSpNJZYz1YFy+P8sEvUxPtJF4+Rf4W
 nqwavgqiEXYCdvX5X/PpEfQcQNeUXjcf2zgmHcy1I93K5Q2qNQjrPzpf6llYJyK0mB1HESNME
 4uPtY5h5s40sGqpeznKjbqL+LJ4aszGIgljayR7wGn9tt6gRQruwy0wIEzb7TBwpkzRThrFJ/
 1D06Zj+k90eX+ToGfKzQWK1utBQxb7ZzzgOrPSmZYAmG2xA+JXn0Xb38U9d7SyIKUDLPd099D
 oazWSlLi1IUCFcADkjZz6CgT7JeR2OkxVyUDptgLJ4+LyqhSUE4k8NGEvo9eiEa+oNEAEyDHX
 plNhNRINPwtSISQ2dqctvEFx1lLxRIfuXoan0J9WDyy1V3c6FlYVufiBhuKZTsFjSeOazTE8w
 GFK4fKNYP5I/g0/oRej/euE+s9eIR6v2BqrLWkBX3Wd8yfRlxBMhvTgfhikUa6FaE/IE5s+IE
 R2HUApMtUAk39yOGINHILfeTch6PpOJIKaguggJ2+eA2aeK6kLtNa4bIv/q+DLU9S3kHTn+tX
 FXAPrXBxwNvU7XxKYJU865GirzXBw6qIoo+wl0pskEtLpU1noIL4Cv9iTliKAwip1CJm99M2j
 tKawaxYiVXqLuClq6R+pWxoRowep7kRXhR2G9D67lBCYhFoHaXlabZY8Jik0ZrIjHEe+CnPI/
 ojWinKIDG+3sfCR5nbPvcQihfBed+Woco4n8fF4I5kE0U7HtTGI+6H/HEgW3VswKRh4m055w5
 /c0ErA==
Subject: Re: [cocci] Clarification for SmPL search techniques
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 767
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/74316d3b-51da-09ca-fc8d-8b5d1d020603%40web.de>


> I think a lot more people would use Coccinelle


The application desire can vary according to various factors also for this software.


> if it had more documentation.

Do you see chances for increasing corresponding development resources?

Regards,
Markus
