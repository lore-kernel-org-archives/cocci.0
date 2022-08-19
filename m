Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBBEC32772
	for <cocci@archiver.kernel.org>; Fri, 19 Aug 2022 10:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:in-reply-to:date:cc:
   content-transfer-encoding:message-id:references:to:
   subject:reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=uXvtyZ35BCFXdaCU5E+oxCVgR5g4KA1kSbrJb5FE/Rs=;
  b=TyEXOlSeD5gZYvTaMw5s3vpD6radW5+rOtLlkohW0vU+r569TC2XVypI
   vBbfw1W9B2NGk80I74dKiesGNMECqgjJa5yzHCNjtoaIPdy13qpJwmqZN
   wXHyDgu2mtdy+X/uCkN9jbcKxzTu+9J09VRvI/H02yhBSsAPQjSRJf5O8
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.93,247,1654552800"; 
   d="scan'208";a="49210551"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Aug 2022 12:02:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 75261E0385; Fri, 19 Aug 2022 12:02:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 62AB8E0247
	for <cocci@sympa.inria.fr>; Fri, 19 Aug 2022 12:00:09 +0200 (CEST)
IronPort-SDR: NRrNwS8b2dSg30jgaxNW2QtFAlunrIicGxQYQjfNFWLxn9baL01qh7p7A5SVAWHyL+DCsmLpY8
 tlLjjMPqiCTrUKCix0749eHTJ2uOx424B+BApP285bgKLM4YO6H7RMJaz8iP4o8dL1C59KIdyI
 KgekM7VwvjCo6O9FDNWH6q/mXM+PX+wk3D5XDPcwgmtRPar6yEdUIzhXtL6Fz1srMQTn61/pY7
 iJcRH0byeuQdRQOmeuDzysA7D032znTr5+4FPDLqvCEYGIWg8jOcEh8Xgy605jTIz2dBHvoPIJ
 oCZEe8q/s6iv+e3bFsMkDhcb
X-IPAS-Result: =?us-ascii?q?A0BrBwCTXv9iXULaVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CJAcqgScuBFCTNYIohCWHDgOBBoYZjCYLAQMBDAFAAgQBAYUHAoR6Ah0HA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQYcDAgHEhUOBWABY?=
 =?us-ascii?q?QMBRIFPgXQLAzENgjUpAYNjAQEBAQIBEigGARsdAQMBCwYFCwEMHBIjEQEFA?=
 =?us-ascii?q?QgUBhMigluCbQEDDSUDBJtfgQRCijh4gRcFF4EBggkGgmGBbgoZKA1nA1t+A?=
 =?us-ascii?q?gcJAQiBK4ZWiHongRmBEIE8DBCCZz6ERBWDeIIuBJk+BAUUDwMDAiEDCQQHB?=
 =?us-ascii?q?SweAgkDIxEDCxARBw4BFgEECAEEAwEBAQ4CBQcCBgMDAgICAgUBAgoCAQIEA?=
 =?us-ascii?q?wYGAgMQAQIEAQoEAgMIAgcDAgYECgQCCAIEBQMNAQMFAgMBAQMDAgQBAgEBA?=
 =?us-ascii?q?wgBAwIDAwICAgIFAgMCAgIJAwQBBwMCAwEEAwECCgQEAwQCAgcCBwIEBwIBA?=
 =?us-ascii?q?gYDBQYCAgEHAQEECgQDAwMDAgUCAgMCBhIGBgIEAQMEAgoCAgsCBwEBAgEBA?=
 =?us-ascii?q?QECAwIHBQsBAQEDAgMGBQIBAQMIBgIBBAEFAwEEBQMHAgEFBgIJAwMBCAMBA?=
 =?us-ascii?q?QUBAwQDAwMCBwMBAgwECAMDAgMEAgICAgEDAgcFCAQCCQICAgECAgIEAgEDG?=
 =?us-ascii?q?gECAwUCAgkLAQQCAgMBAwEBAggECQQCAwQCAQEDAgECAgEFAg4GAQEBAQIDA?=
 =?us-ascii?q?wECAwEGBwIIAg4OCgEDAwMCAgUCAgECAwICDAEBBAIBAgECBgEDAQICAwEDA?=
 =?us-ascii?q?QICAwIGCQIEAQUDAwICAwEBBQ4FAgQCAQIGBQIBAQEEAQMEBAYCAgEDAwIOA?=
 =?us-ascii?q?gQBBAECAQEjAwQCAwEDFwECAQIDAwMEBgcFAgECEwECAQEBBQECAQEDBAQHC?=
 =?us-ascii?q?QMCAgQDAwUBAQIDAgEBAQcMAgICEwITAwEGAQ4FFAMCBAICAQICCgMBAgIBA?=
 =?us-ascii?q?wIJAgECAQUgAwEBDyQBAQICAgIDBAcCAQQGAw0CAgEBAQUGDQMCAwgBDAIHA?=
 =?us-ascii?q?wIBAwUBAgICBAECBAoJAQICAQIEBQcCAQgGBQ0FCQsBAQIBAwcEAxECBQMFB?=
 =?us-ascii?q?QMDAgEGBAUCAwECAQEDBAEDBAYBAQIDAgIBBgICAQEDAwQDAQIGAgIHAgMCA?=
 =?us-ascii?q?QQCAwMBAQEEAgICAgIDAwgDAggHBQEGAQIBBAMCAgECBwEEAQgCAQMDBQMEA?=
 =?us-ascii?q?QoDDwMFAwEDAwIUCgUBBQgGCQIEBQIFAwIEAgMDAgIIAwIEAwILAwIGBAIHE?=
 =?us-ascii?q?wcCAwICBQICAgICBQQDAQICAgICAgUCBAIBBQECAgECAgIEAQICBwQCAwEDB?=
 =?us-ascii?q?A4EBAICBwECAgEGAgcDAQIBBAMBAQQCBAECBQIEAQMBAgYCBAMKAgIDAgICB?=
 =?us-ascii?q?ggDAwwJAgMFAgYBAQIHBAICCwEGAgcCAgECAxEBAwIBBAUFAwMDCQICAwIEA?=
 =?us-ascii?q?gIKAQEBAQICAQUFAgQHDwICAgQCAgIBAwICAQECAgUECRIBAQIDBgQGBQMCC?=
 =?us-ascii?q?BgBBgICAQECAgIDAwIGAgECCAIEAQQFAgECAgICBAEDBgIDAQECAQICAwMCA?=
 =?us-ascii?q?QQCBAMDAQECAQICAgMCAgIDAgIBEAIGBgECAgICAgMCAgECAQUBAgECBAIHA?=
 =?us-ascii?q?gQDAgECAgUCAgIDAQEGAgQLAQMCBwYBAwIHBQIDAQIDBAMDBQYFDAgBBQEDA?=
 =?us-ascii?q?QUfAwICCAIHAgEFAwUBDwMCAgMCAgEECgECAwUCBAIBAgEECQcCBAECCwMDB?=
 =?us-ascii?q?gIHBRgBAgIHBAwKAgICBQYCBAEBAQEDAQICAQIDBwIDAgQFAQUCAQIFBAICA?=
 =?us-ascii?q?QECBQIMAQIBBwYCBwMCAgIDAQQCAQIBAwMCAwEBAQMJBgUTTZstAXsrwywHA?=
 =?us-ascii?q?YNUoCQELpZjkg6XAqMQhCYCBAEBAQMHBhAjEoFDgX4zGiN6AQaCNj4QAQIBA?=
 =?us-ascii?q?QENAQIBAQMBAgECCQEBAo4dg3KKYD80OwIGCwEBAwmFRoUlAQE?=
IronPort-PHdr: A9a23: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
 yY=
IronPort-Data: A9a23:xEJz0qsHnFyUq7LdjbCrKpt1XOfnVJtYMUV32f8akzHdYApBsoF/q
 tZmKTuBPPuKZWf2Lt1zbdux8RhTuMXWmtJgSQY4pC9jHygSgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTraCYEidfCc8IMsboUsLd9UR38g52rBVPyvX4
 Ymo+52GaAf+s9JJGjt8B5yr+EsHUMva42twUmwWPZina3eD/5W9JMt3yZCZdxMUcKEMdgKJb
 7qrIIWCw4/s10xF5uVJPVrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCnbiWRhY5G/3hpMYUA1pAGHF0PLYc1LCSdBBTseTLp6HHW37lwvErAUNveINGpKB4BmZB8
 fFeIzcIBvyBr7jukfTrF68235RlcpeD0IA34hmMyRnbDvJ2G8iFTKTWzdBd1TY0wMtJGJ4yY
 uJFOGA2NE6eMnWjPH8SUrIupuuKpUPnLSNar1eZn+k7+TbcmVkZPL/FaYKJILRmX/59mk+Hr
 2bC13b4BxsAPZqezyCE+zSinIfnliTwU4M6D6y97vcsgVuJx2VVBgd+aLegifywi0r7VtAGb
 kJKpGwhqq898EHtRd74N/GlnJKaljo6VMtANr0X1COEmunM6FaTB3NeYjEUPbTKq/QKbTAt0
 1aImfbgCjpurKCZRBqhGlG8/WPa1c89fT9qWMMUcecWy4K8/9xr33ojWv4mQfHl1ISkcd3l6
 2nS9HBWulkFsSIcO0yGEb3vhjutot3ETFdw6FuJGG2i6Qx9aciuYInABbnnARRofNzxorqp5
 iBsdy2iAAYmUMHleMulHbVlIV1Rz6zZWAAweHY2d3Xbyxyj+mS4Yadb6yxkKUFiP64sIGG3O
 B+P5l8Kv8YMYRNGiJObharhW6zGKoCwRbzYugz8M7Kin7AqKVHZpHA+DaJu9zm8zRBy+U3AB
 XtrWZ/0USxy5VVPwz2xSOMQuYLHNQhvrV4/savTlkz/uZLHPCD9Ye5cbDOmM75khIvZ/1y92
 4sOb6OilkQCOMWjM3m/2dBJcTgicyNgbbio8Jw/SwJ2Ck85cI3XI6GBke9Jlk0Mt/89q9okC
 VnkChEAlQqh3iGcQehIA1g6AI7SsV9EhSpTFUQR0ZyAghDPuK6js/UScYUZZ74i+LAxxPJ4V
 ahXdMCJA/AJQTPComxPYZ74pY1kVRKqmQPeZ3r/MGZjJ8ZtF17T59vpXgrz7y1RXCe6sM0Jp
 bf/hA7WRJw0QRtvUZTNY/W1wlLt5nUQwbogX0bBLtRJVl/r9Yxmd374gvMtcpMDLBzCwn2R0
 APPWUUUouzEookU9tjVhPDc/935TbcmRkcDRjvV97e7MyXe71GP+44YXbbaZy3ZWUP15L6mO
 rdYwvT6B/sNwwRHvo96JLB0lP5s6tbqoYha+QRqBnD8aVqmV+F7KX6c0MgT76BAy+MLuQayX
 U7TqNBWNa/TY5HgGV8VYQcnN6GNi69SlT7V4vA4Zk794XYvrraAVExTOTiKiTBcfOQpatJ7m
 b95tZ5E8RG7hzorLs2C0nJe+VOKIyFSSK4grJwbXNLmh1Z50F1EepCAWCb67IvVMIdJO0guZ
 zKW3e/M2eoayU3FfH4+U3PK2LMF15gJvRlLyn4EJkiIyoWZ3K5phEUJ/GRlVBlRwzVGz/l3Z
 jphOXpzKPjc5DxvnsVCAz2hFgwp6Md1IaAtJ4blVVE1TnVEkkTIJWw5fOuPpQUXrTwacT9c8
 7WVjm3iVF4GuS03MjQaASZYRz7LFLSdNTEuXOioGs2EG98xZj+NbmqGez8TsxW+aS8urBSvm
 ASpldqcrYX0MCcRp+swDIzyOXH8jvybDDQqfMyNN5/l0Y0RlP9eFNROx42MlhtxGsH3
IronPort-HdrOrdr: A9a23:rfmB6ay0K9i4EJ8WSppjKrPw0b1zdoMgy1knxilNoHtuA6ulfq
 GV7ZAmPHDP+VUssU8b6KG90cW7Lk81G/ZOkPQs1ZnLZniYhIKDFvAY0WPaqweQZxEXHIZmpN
 ldmtFFeafN5DtB/KPHCWuDYrQdKYK8gdiVbI7lph8HIG1XgsdbjzuRJTzrYnGeLzMpOXNWLv
 uhDgsunUvHRV0nKuCALj0+f9Grnbf2fB2PW29+O/ZKhTP+/g+V1A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,247,1654552800"; 
   d="scan'208";a="49210269"
X-MGA-submission: =?us-ascii?q?MDEush01jzpzGF5dB6K2gNoT5G5T3mUM7fYjhb?=
 =?us-ascii?q?hlV/HukGZ9XSD5eNWhIZ887SQanQbE6/feECqPWQA+jn6quosHIDlqkD?=
 =?us-ascii?q?FBoM4tv3cP6murno+F7wLfKttEGU9FE1dIlKjh+I0jDceEg7yVkcBjTc?=
 =?us-ascii?q?WeTt1OaKYxitj9GFoQ+QGVag=3D=3D?=
Received: from mail-ej1-f66.google.com ([209.85.218.66])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 12:00:09 +0200
Received: by mail-ej1-f66.google.com with SMTP id qn6so7833447ejc.11;
        Fri, 19 Aug 2022 03:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=uXvtyZ35BCFXdaCU5E+oxCVgR5g4KA1kSbrJb5FE/Rs=;
        b=hds+vNqfj1scn3hglf9JZSO7he+04ofnU18g3qYMMXFZuUECuhAqoIHEHa00Ynzxxp
         muvlQFzkAA4huN9Nqb8F93BhEftaTs125MYLQtgP2ZSRKqSSem/BOD0LXUpJOSJGvP6q
         i715pXbCkJXL3WVNLa0AJJ3fJKOgmEVhx31xg6y78/GZokUdZnJ3NlyYctClbLqgC465
         2hli6V/62T/tia+xywhtG9z/nyIIrgOgX/ekIqv0eg3OFdvcB6Trjg9J2ik8f+GlwpDV
         tsuDjJkgu4q9i/hH2K8CfolK/J/GSxaufstgGsSXK6l0CU77rfZD8slVy0EUc8+DSW3N
         d68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=uXvtyZ35BCFXdaCU5E+oxCVgR5g4KA1kSbrJb5FE/Rs=;
        b=Hklx7byNJCDgrtarkG1CQPVh1RXb0JLEVICm5W60qBoHyLoOgprIiIJ5cdOnnAXQvK
         mVgegiIpdxklrhDBPHYdRwv2w0Ltag5lXJOWNwn/n4o3euKG/WG1dQ5/GGgatkGMrMhc
         wl3eViPkoYvUBNt+4NEIJWXODbacc1EiXsamqIchvVlL0NvPsd2H3b6EKgK6TekJK05i
         J5l2tIsBK07MhOEMR9zmsFST22TeaSz8WCO/hfcteI8eOJn8m4bowFj62cfCcmts6Uzl
         q0Q9awB2Le6vMTJzT0AU/TiEHEytjs8K2m+kCaIF/FYJa+kybnmGNZM7KFb0PF75fr0z
         oSwg==
X-Gm-Message-State: ACgBeo0h57wntALDF9Ffhb6Mgp2RXFVVDcXn24XqY3EPLhDRphu9vNHZ
	CvLEJ/8jC3ZQYnxnOPpBVyVfwVdNKE4=
X-Google-Smtp-Source: AA6agR7UHwLouxLgxdDQ3p1KrTTud0YiIE4GBZChy9YrrpNSxPxbrA+Wo4EQgPpBcQDvkNDm9uJaXw==
X-Received: by 2002:a17:907:2c4a:b0:73d:1d15:4a8f with SMTP id hf10-20020a1709072c4a00b0073d1d154a8fmr1145181ejc.573.1660903208304;
        Fri, 19 Aug 2022 03:00:08 -0700 (PDT)
Received: from smtpclient.apple ([46.183.103.8])
        by smtp.gmail.com with ESMTPSA id q19-20020a17090676d300b0072af930cf97sm2052284ejn.115.2022.08.19.03.00.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Aug 2022 03:00:07 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
From: Jakob Koschel <jkl820.git@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2208191156210.2971@hadrien>
Date: Fri, 19 Aug 2022 12:00:02 +0200
Cc: Markus Elfring <Markus.Elfring@web.de>,
 cocci@inria.fr
Content-Transfer-Encoding: quoted-printable
Message-Id: <8E577ED0-4A6D-4136-925B-C7A79689E936@gmail.com>
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
 <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
 <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
 <alpine.DEB.2.22.394.2208162306410.2625@hadrien>
 <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
 <alpine.DEB.2.22.394.2208171631050.2482@hadrien>
 <92b5eb33-9c76-7e45-7651-6296c9795a67@web.de>
 <88152C77-84AD-4515-A403-71F827180FD9@gmail.com>
 <cf4058d8-13ca-0637-fe0c-d9d8582c5673@web.de>
 <17A83354-2406-47E5-94EE-4955E09819DA@gmail.com>
 <alpine.DEB.2.22.394.2208191156210.2971@hadrien>
To: Julia Lawall <julia.lawall@inria.fr>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Working with parameter/expression lists by SmPL
Reply-To: Jakob Koschel <jkl820.git@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 523
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/8E577ED0-4A6D-4136-925B-C7A79689E936%40gmail.com>



> On 19. Aug 2022, at 11:57, Julia Lawall <julia.lawall@inria.fr> wrote:
>=20
>> I've found this [Link], suggesting to use '--file-groups' or =
'--kbuild-info' to
>> o analysis across multiple files. I've managed to get '--file-groups' =
working
>> on a small example but it will get challenging to do on the entire =
kernel.
>> The '--kbuild-info' option *looks* outdated at least I couldn't find =
an easy way to get
>> it running on the kernel.
>=20
> --file-groups is a better option.
>=20
> The other option is to use iteration, and collect information on one
> iteration and use it on the next one.  That would give a completely =
global
> analysis that might not scale.  You can see an example in
> demos/iteration.cocci

The option to collection information and then do a separate run, is =
precisely
what I was intending to do now. Since I don't see an easy way to use =
'--file-groups'
on the entire kernel.

thanks for the pointer to the suitable example.

- jakob

>=20
> julia

