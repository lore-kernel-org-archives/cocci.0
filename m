Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06E9FE520C
	for <cocci@archiver.kernel.org>; Fri, 24 Apr 2026 11:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=aepPEFWjYMqiOK1SG+YVAva3wXTUYjMyhvzjC2RoGTI=;
  b=EwAlncO9Wvx8TYoDp+nhQNivNWMPrGT26JEn000W15cgRpjpUM5kf7Ld
   Y0eXBykLIh0Xnb+DkNtyYI/Y6n/JxhFIrnIaduEwyQttHUbJHxfduk6ht
   1sTvdlcJVYV3TfdwjfcN0xV8XCwBdIx99fS3XrcFOCESz5WYq0CBNc1FC
   Q=;
X-CSE-ConnectionGUID: bLDWnGPORuy/Js2tJlW0ag==
X-CSE-MsgGUID: 3TrgQB1ySqi40dtaHz+LHA==
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
X-IronPort-AV: E=Sophos;i="6.23,196,1770591600"; 
   d="scan'208";a="273979822"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Apr 2026 13:28:18 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 16039816E6; Fri, 24 Apr 2026 13:28:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 90543816E1
	for <cocci@sympa.inria.fr>; Fri, 24 Apr 2026 13:28:12 +0200 (CEST)
X-CSE-ConnectionGUID: 0DbHQO6/SN2egjMb29Hz/w==
X-CSE-MsgGUID: DPEk39HzT/C78KkwI8+TZQ==
IronPort-SDR: 69eb53cc_rXJRvqDTZo5BSRxRDcHHUURj79jMcCu92f459uqLDeNPsQr
 s1tHbBb7oU98Et4wzLyTQeqRvDiG1Ohl8G2smuA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GGAgBdU+tpgwsR49RahRqBZTQEC0mEWI9TgiSEO4c8h?=
 =?us-ascii?q?1WMSwIPAQMBDU4BAgQBAQEBAQSCC4J0Ao0uAh4HAQQ0EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBOgcOO4ZPDYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBDwsaAhgOAgJWBhUBAYJ+g?=
 =?us-ascii?q?iMBBhABAw8nB7VZgTKBAYIMAQEG2mUfLCJZgWcJgR8uhXKCZgGJdnonD4FVR?=
 =?us-ascii?q?IE8C4J4PogegmmCJoEOhj6Ia1J4HANZLAFVExcLBwWBI0MDgQYjSwUtHYEjI?=
 =?us-ascii?q?R0XFR5YGwcFEiEqboIMdCx2DiE1WUg4CgFJBYFwAmqBNhlfNgIBC209NwkLG?=
 =?us-ascii?q?wQ9i0AgD4JnqDKhRTQHgjiBZ4FkDJ9tBhMvg3EBk2AOkwuZBqlBgX8jgVwzG?=
 =?us-ascii?q?iSDNlADGQ+OOoQbyCFEMj0BAQcCBw0DC4Fog1wBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 V0EzOGhRWz2HpL20QpuZwsi9Lk=
IronPort-Data: A9a23:LMKRtqATFBV/lRVW/xbnw5YqxClBgxIJ4kV8jS/XYbTApDgg0jBUm
 GYdCDqEO/yJZjP3et4iaYmyoEwFupeAzoIyTANkpHpgZkwXlceUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOiTraCZmYpHFEMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMTdJ4RYtWo4vw/zF8kgHUMja4mtC4ARiP6wT5TcyqlFMZH4hDfHpR5fHatIMdgKKb
 76r5K20+Grf4yAsBruN+p7nclcHS6LlJgOHjHxbQcCK2nCucQRvukqTHKN0hXZ/011lrfgoo
 Dl+ncXYpTMSA0H5sLl1vy9wQ3gvZ/UekFPwCSPXXcS7lyUqepZ3qhlkJBle0YYwo46bDYzSn
 BCxxf9kgh2r3oqLLLyHpuZE3ugpDPDMYsQknCttwjP8B6x3YYKEXPCfjTNY9G9YasFmGPHDe
 4wGZDApYBmojx9nYA5NTshkw6Hx2T+mKlW0q3rNzUYzy03a1g9sy/7ANNTPe9qFbdpYlACUq
 woq+kyjXUpLa43PkWbtHnSEqtfinniqeJAuU5bnpt1pn3zDhVAhMUhDPbe8iaLl2hblC403x
 1Yv0iEppqMz3Fe6S8H0GRy+un+N+BAGM/JUGvIz7AWl2KvR6RyQQGkCVD9ILtI83PLaXhQv0
 UKV2czkD3pjvdV5VE5x6J/MgTmSAA9LalQkPyILTy4PuYjDssYs20enoslYLEKjsjHiMR3dq
 w1mQQA7gKgPy9EG3eO38DgrYg5ARLCYEGbZBS2OAApJCz+Vgqb7P+REDnCGvJ59wH6xFAXpg
 ZT9s5H2ABoy4W6xeNylG7ldROr5uJ5pwRXdhlhoBNE6+lyQxpJXRqgJuGsWDB4xbK4sIGa1C
 GeN4V45zMEJYBOCM/UpC6rvUJ5C5fa7SrzYugX8NYMmjm5ZL1bfpHkGiI/59zyFrXXAZoljY
 MzCK5v9UiZAYUmlpRLvL9ogPXYQ7nhW7QvuqVrTlnxLCJLHPCTLG4QWekCDdP44566iqQDYu
 YQXfciTxhkVFKW0biDL+MRBZRoHPFoqN6DQ8sZ3T++kJhY5OWcDD/SK/6gtVbY4lItol8DJ3
 EqHZGlm9HTFi0bqEz66MkJYVOu3XLJUj24KAig3DFP5h1khedmO6YkcRbsWfJ4m1spS/dxuQ
 8kgZv+/EvFETzDayWw3NqvCjZFQWymqoSmsPCOVRic1ULA9Zg7O++PbUBrmrxccLweJrvk4g
 aWq0wjaT6EcRg9kMt3kVfK3w361vlkfgOhXTWKRBvVyIWLCqJNLLQ71hd8Je/A8Ew3JnGam5
 lzHECUmqvnoiK5r1tvw3ISvjZqjSsl6FWpkR1jr1668b3TmzzDy0L17cbi6eB7GXznJ44SkX
 +Jeys/8PNAhnFpnt4ldEa5h/Zkh5unA9qNr8QB5IErlN1ibKKtsAn2j7/l9sqdgwrx4uwzvf
 mmt/tJcG6uCOeK7MVo3CTcmUN++1qAvqmGP1cg2HUT03z8o3bylVU4JAQKAphYAJ5RIMaQk4
 9wbhugo1yKFhCEHDPO6nwFP1mHVLnU/Q6Qt7Z4bJ4nwizsU8FJJYL2CKyqv/p2/UshAaHcrB
 jqugIvDmLVu6U7QeFUjFXX2/LR8hLZfnDto3VM9N1Cytd6dvcAO3TpV6iYSYjVO6wduisZfG
 zFMGRVuBKOs+zxIupByb1q0EVscOCzDq13D9VQZsUb4EW+qbzXpB08gM7+v+Es5zTptTgJD9
 uvF9Fe/ACfYR+Cv7C4cQkU/lufCS+Z2/Qj8mMyKOcSJMp05QDj9iJ+Vems6hEr7MPw1mXH4i
 7FmzMRoZY3/EBwgkakxJo2Z9LYXETSvBmhJR9N/96IoQ0DYXhyP2ga1FkPgQfMVesT28nK5B
 fd+eeNJdRC1jxiVoh4hWKUjHr5TndwS3uQkRI/FH2A8juagnmJbi66Irinar003cupqivc4e
 9/wdSrdM2m+hkl0um7qretiC1qae9U0QRDG4/Cw++ANCqBbmrpeTmAv4JSJvlG+EghuzzSLt
 iztOo7UyO1Dz9x3vo3OS69sOSS9GenRZs+prj+hlstoVszeF/vOuyc+iEjVDy4PMZQ/A91Ix
 Kmw6vjp10b7jZMKemH+majZMZJW5M+3DdFlAuiuIFZ0xSK9CdLRuT0d8GWFKLtMotNXxu+jY
 yCaMMKQV9oka+1x9U1vSRp1MkgiUvzsT6LauymCgeyGCUEd3Sz5PdqXzyLVQl8BRBAYGa/VK
 1HSgOmv1OB6vY4XJR4jBtNaObFaDmLne5Mbc4zWiWHFIEiu21+Mg+63315oozTGEWKNH8vG8
 IrIDEq2Pgi7vKbTispVqcputxkQF2xwmvQ0YllbwdNtljSmFyQTGIzx63nd5k18yUQeFa0UZ
 Q0hqEMnDjjhGytJe1Pw7bwPm+tZ6vMmYr/Eyv4Bpit4qBtawKufDbEn+ioID7JeZG741O/+Q
 T0B0iSYA/Vyq62Fgc4M6/b9jeoPKjY2AJ4X0RiVrvEeyCryzVnHOLKN0eaNueH6/xnxqXj2
IronPort-HdrOrdr: A9a23:kauXu62JXDUznLnBjwYN8QqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3Av09BtWpq1i21S3Bfn1wkz1fmUZgJeF3k6ymXGGn?=
 =?us-ascii?q?iBGlrbbfPGH+Cv7wxxg=3D=3D?=
X-Talos-MUID: 9a23:SgNJyQpA/lt6EEd5CMQezx1aGcQzsoS8NAcmzsUluNalZW9MCQ7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,196,1770591600"; 
   d="scan'208";a="273979804"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGz5rxNgZ2MsNvKDnmX/8pIzfEBFqBf+TGwfI?=
 =?us-ascii?q?cZQTF6DqVDl5ZDvkjWC6LBNkRIjN+MQQ109MIlsvJTHn+mkVg+20d3f0?=
 =?us-ascii?q?8IyiW0m8q0YTx5jkiPSzTDgLcqa4dQZUMdXYouJGIKYAHyDOFMStFO5u?=
 =?us-ascii?q?mxTgijmuKOr1tkZMgmGByAAQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 13:28:12 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzCA5-1vT3to2jTf-013aZH; Fri, 24
 Apr 2026 13:28:11 +0200
Message-ID: <6c49e2a9-4b69-4366-b33b-7950da6fc28d@web.de>
Date: Fri, 24 Apr 2026 13:28:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <138f6f86-b875-42fd-bc00-f0ad5e1f6f6b@web.de>
 <f93c2682-64ef-7a25-239b-5e7e98144a6@inria.fr>
 <366d74af-0552-4c90-9ea4-4f201f5493e8@web.de>
 <e15b34a2-eeae-893-8b60-928e5abd963b@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e15b34a2-eeae-893-8b60-928e5abd963b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:IeI4/x1hPtfZGzuOAMzsN41OJvd4BmpaxdDxYqfsQ+5AByPLRf3
 Eh3oYiTjD44JoGEq0YtTGhCAIrACdGzt87WEAmeVir+6Fd4c2QnMz+jsnCmj6DrFFA1q9K/
 byCAQtMlOAiRb6c1XeVBX57fbKQ3+GKkOpPYi0cFf+snvqKrx1/yyyx1JlbR+zAFYE+ixqQ
 NM8J81Rp/pnvHlQT+KP9Q==
UI-OutboundReport: notjunk:1;M01:P0:zSNbGxjxqZY=;gaOKApFFtzYcTQ9EdHooNz6Jn20
 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
Subject: Re: [cocci] Planning the next software release?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3485
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-04/vvgty4OnWeEZkOjmfoaL-A>

>> Which activities would eventually be picked up before?
> There is a current bug that needs to be fixed.  The time range is the
> total of the time for fixing that bug.

How do you think about to share further background information
also for such a development challenge?

Regards,
Markus
