Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737BCECAAD3
	for <cocci@archiver.kernel.org>; Mon,  5 Sep 2022 12:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=stjE8hV6IQXpnccW5n/Xg00woCgW/nhgQVOpl6jIVyo=;
  b=sB6EzvIORCuvCny5dY50b0lHoac/dLxBsL9WApFuz349fim+ThfPi/nu
   dPHMKUZOY7c8G/THs5uL+ZzqFyIeevwvwNzeWVcdMone1NKDeBQBDoNKp
   rQwpvxmCizK06ouYP/sdFIqjhVDIf5RPRtDn73EFCmrPcTcl/YFDMxhHM
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.93,291,1654552800"; 
   d="scan'208";a="51331251"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Sep 2022 14:04:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A4A65E779E; Mon,  5 Sep 2022 14:04:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0448DE7799
	for <cocci@sympa.inria.fr>; Mon,  5 Sep 2022 14:04:58 +0200 (CEST)
IronPort-SDR: 6t9+O53cu0a8Eq4o8Q8L9oKw3lhT39Ht6KIVZd3u+6ir+pHVOl0YkTXFxVERMgeS3KXKbChcU5
 Ar+3LCB+1/pFbdAXDJ7UDXx/KEBEBzLCCopSqDj0f63wmlMGIiHq8awFMhCAmm+xgQ7WrUp12I
 EaonLoDXyt8VJxIFQo+85HtdvmGROdzcZ49P3LWnVyyhVBGmebLMSM6/BRL2N6TTI32FDewwWW
 cixIl9IffdSb5hTAvhHJT5QB8lAAzQ66vh/jswvkbf1ro9r+IQ3fCHbrs2QZJIznQ1jt+8egc+
 7sxQ8kP0ZeipoGQE7VuASfxO
X-IPAS-Result: =?us-ascii?q?A0AwBQBV5RVjfzGgVdFaHQEBAQEJARIBBQUBQIFPgiQzA?=
 =?us-ascii?q?YEiLwQLRYROjmuCKIs5gQaGGowoCwEDAQ1CBAEBhQYChGUCHQcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBIRkHDg5lAWEDAUSBT4F0C?=
 =?us-ascii?q?wMxDYI1KQGDZAEBAQMSER0BGx0BAwwGBQsNAgImAgIiAREBBQEcBhMihUgBA?=
 =?us-ascii?q?zADmxyBBEKLMoEVBReBAYIJBoRPChkoDWcDgVkCBxJ/LIhChmN6JxyBSUSBS?=
 =?us-ascii?q?4JEMD6IGoJlBJMJhBgBAwcDBAYFDwMDAiEBAgFEHgIJAyMRAwsQCBQXJAYGA?=
 =?us-ascii?q?QQBAQwCAQQBBQMBBAUDBwIBBQYCCQMDCQMBAQUBAwQDAwMCBwMBAgwECAMDA?=
 =?us-ascii?q?gMEAgICAgEDAgcFCAQCBwICAgECAgIEAgEDCQECAwUCAgkLAQQCAgMBAwEBA?=
 =?us-ascii?q?ggECQQCAwQCAQEDAgECAgEFAg4FAQEBAQIFAQIDAQYHAggCHAoBAwMDAgIFA?=
 =?us-ascii?q?gIBAgMCDQEBBAIBAgECBgEDAQICAwEDAQICAwIGCQIEAQUDAwICAwEBBQ8FA?=
 =?us-ascii?q?gQCAQIGBQIBAQEEAQMEBAYCAgEDAwIOAgQBBAECAQEjAwQCAwEDFwECAQIDA?=
 =?us-ascii?q?wMEBgcFAgECEwECAQEBBQECAQEDBAQHCQMCAgQDAwUBAQIDAgEBAQcMAgICE?=
 =?us-ascii?q?gITAwEGAQ4FFAMCBAICAQICCgMBAgIBAwIJAgECAQUgAwEBDyQBAQICAgIDB?=
 =?us-ascii?q?AcCAQQGAw0CAgEBAQUGDQMCAwgBDAIHAwIBAwUCAgQBAgQKCQECAgECBAUHA?=
 =?us-ascii?q?gEIBAUNBQkLAQECAQMHBAMRAgUDBQUDAwIBCgUCAwECAQEDBAEDBAYBAQIDA?=
 =?us-ascii?q?gIBBgICAQEDAwQDAQIGAgIHAgMCAQQCAwMBAQEEAgECAgIDAwgDAggHBQEGA?=
 =?us-ascii?q?QIBBAMCAgECBwEEAQgCAQMDBQMEAQoPAwUDAQMDAhQKBQEDCAYJAgQFAgUDA?=
 =?us-ascii?q?gQCAwMCAggDAgQDAgsDBQQCBwQPBwIDAgIFAgICAgIFBAMBAgICAgICBQIDA?=
 =?us-ascii?q?gEFAQICAQICAgQBAgIHBAIDAQMEDgQDAgIHAQICAQYCBwMBAgEEAwEBBAIEA?=
 =?us-ascii?q?QIFAgQBAwECBgIEAwoCAwICAgYIAwMMCQIDBQIEAQECBwQCAgsBBgIHAgIDE?=
 =?us-ascii?q?AEDAQQFBQMDAwkCAgMCBAICCgEBAQECAgEFBQIEBw8CAgIEAgICAQMCAgEBA?=
 =?us-ascii?q?gIFBAkSAQECAwYEBgUDAggYAQYCAgEBAgIDAwIGAgECCAIEAQQFAgECAgICB?=
 =?us-ascii?q?AEDBgIDAQECAQICAwMCAwIEAwMBAgECAgIDAgICAwICARACBgYBAgICAgICA?=
 =?us-ascii?q?gIBAgEFAQIBAgQCBwIEAwIBAgIFAgICAwEBBgIECwEDAgcGAQMCBwUCAwEEA?=
 =?us-ascii?q?wQDAwsFDAgBBQEDASEDAgIIAgcCAQUDBQEPAwICAwICAQQKAgMFAgQCAQQJB?=
 =?us-ascii?q?wIEAQIJAwMGAgcFGAECAgcEDAoCAgIFBgIEAQEBAQMBAgIBAgMEAgMCBAUBB?=
 =?us-ascii?q?QIBAgUEAgIBAQIFAgwBAgEHBgIHAwICAgMBBAIBAgEDAwIDAQEBAwYGBQYEA?=
 =?us-ascii?q?gMDBgICAgYCAgMCEgMIAgYDAgQBDQ8FBAcIAQIBAQIHAgQCBwkCDgIBBgEHA?=
 =?us-ascii?q?gIDAgIBBQIBBgQHAQMCAgICAgIFCAUDBAUCAwZHl3sHexMBgXvCYmGCe6AoM?=
 =?us-ascii?q?qh2lweiKwGFJRAjEoFDI4FbTSMVbII2TgECAQEBDQECAQEDAQIBAgkBAQKOH?=
 =?us-ascii?q?YNyimBCMTsCBgsBAQMJilIBAQ?=
IronPort-PHdr: A9a23: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
 jfnm6f6KTME+NXRr5J0Og==
IronPort-Data: A9a23:ruriYaP+1sS2kPbvrR2MkcFynXyQoLVcMsEvi/4bfWQNrUp33jBVx
 jEdUW3TbPiPM2Xyf9AkaY2ypE8E7ZXQxtRlTXM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/vgqoPUUIYoAAgoLeNfYHpn2EkLd9IR2NYy24DoW17V4
 LsenuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2bm44ok
 OltpKCRai50FJ3ppOAsQgZhRnQW0a1uoNcrIFC6uM2XikrPKj7in6QoA0YxMokVvO1wBAmi9
 9RCcGFLPk3F3rzuhu7qIgVvrpxLwM3DPp8YuHdp1xnWCP8nRdbIRKCiCdpwhm1g2Z0RQqq2i
 8wxcTNlXUvSfkZ1CHAoS5Bjhvz4j2TiWmgNwL6SjfNvvzK7IBZK+LzkL9PRfvSYRMBfhE/ep
 2Tc/m2/DAtyHNeYwjGE2mm9g/fG2yL9QoMbUrOinsOGm3WWz20XTRofDB61/aj/hUm5VNZSb
 UcT/0LCsJTe6mS5SoekByGYsUKlnTdBcep1L+kL+R60n/+8DxmiOkAISTtIadoDvcAwRCA32
 lLhoz8PLWw/2FFyYSLNnop4vQ9eKgBOcjBfPX5soR8tpoi88Ntq33ojW/46SPbt5uAZDw0c1
 NxjkcTTr7AajMpO0KziuF6b0nSjoZ/GSgNz7QLSNo5E0u+bTN76D2BLwQKBhRqlEGp/Zgfc1
 JTjs5bFhN3i9bnXyESwrBwlRdlFHcqtPjzGmkJIFJI87Tmr8HPLVdkOvmslfRkzaJZeJ2OBj
 KrvVeV5tM870JyCPf8fXm5NI5lCIVXITom9DqiJNrKinLAoLVfapUmCmnJ8L0i0yBR2+U3OE
 ZicdsmoAB4n5VdPnVKLqxMm+eZznEgWnDuNLbiilkjP+eTEOBa9F+xeWHPQNbBR0U9xiF+Km
 zqpH5DalUs3vSyXSnW/zLP/2nhRcCdjXcyo9JEIHgNBSyI/cFwc5zbq6etJU+RYc259y48kJ
 1mxBR1VzkTRn3rCJVnYY3xvcuK9UpN2rHZ9NispZA76138maIepzaEea5pnJel9pLI/laZ5H
 6sfZsGNIvVTUTCYqTkQaJ/KqoY9JhmmgAS5OTWoPWokdJl6Sg2VodLpJ1O99CQHAietm9E5p
 rmsilHSTZYZFlZtCc/XbLSkyFbo5SoRn+d7Xk3pJNhPeRW0oNI6dXCp1vJuepMCMxTOwDeex
 j26OxZAqLmfuZIx/fnImbuA8NWkHu54KUxQQDvW4LOwAi/FpzbxzIJFVtGISjDTTmbD/quvO
 LdOxPbmPfxbxVtHvtYuE7tvyq5itdLjq6UAlVZhFXTPKlOiU/ZufijA0s5IualAgLRevFLuC
 E6I/9BbP5SPOd/kQAFNflt7Nrzb2KFGgCTW4NQ0PF7+uH198o2BXBgAJBKLkiFccOZ4Pd932
 +sno8JKuQWzhgBwaYSDhyFQsmOFdzkOD/RhuZYdD4vmzAEszwgaM5DbDyb35rCJaslNYhZ2e
 G7K3PKaiuQO3FfGfloyCWPJgbhXi6MItU0Y11QFPVmIxofIi/JfMMe9Ktjrotm5Dymr0t6f/
 kBuPkxxYKKHpnJm2JkFUGerFAVMQhae/yQdDrfPeHLxFyGVuq7ldQXR+tphOGgW9mtden5Q+
 7TwJKPNT2PxZM+otsctcRcNlhEgJOCdMiXNncmmG4KOGJxSjf8JREOxTTJgliYLyv/dSKEKS
 SeGMQqwhWDG2fYsnpAG
IronPort-HdrOrdr: A9a23:UevylavOKJj+oixM8rjRuVeu7skCDoAji2hC6mlwRA09TyXGra
 GTdaUguyMc1gx/ZFgJgtqAOLaNTDf16PdOkNss1NeZPDUPuAOTXfpfBPjZskfd8kzFh4tgPM
 hbAs9D4ePLfB5HZKrBkXCF+zhJ+qjVzEiH7d2uk0uFZzsaNp2Jd2xCe1am+nQffngWOXLSfK
 Dsufav3gDQJ0j/Df7LekXtPdKzw+Ejz6iWOG9fO/dP0mDn5lnEhM+YYnqlN3ElInZyKJgZgD
 P4emfCl+eeWp+Au2fhPiPonvJrcIyL8Ko/OCXAsLljFt2q4TzYFLiIZde5zXQIidDqzGxvvM
 jHoh8mMcg2w3TNflutqR+o/wX7yj4h51Lr1Ffd2BLY0IXEbQN/L/AEqZNScxPf5UZllNZg0J
 hT12bck5ZMFxvPkAn0+tCNfRB3kUifp2YkjIco/gpieLpbTIUUgZ0U/UtTHptFNCXm6Lo/GO
 0rN83Y7OY+SyLpU1np+k1UhPC8VHU6GRmLBmIYvNaO7jRQlHdli2MF2c02hB47hdgAYqgBw9
 6BHrVjlblIQMNTR7l6Hv09Tcy+DXGIaQ7QMViVPU/sGMg8SjnwQqbMkfkIDdyRCdM1JMNYou
 WObLoYjx97R6vWM7zC4HURmSq9AVlUXlzWu7JjDtZCy/3BrYHQQFO+oWAV4rSdSsokc7zmst
 aISedr6qzYXB/T8MByrk7Ds5I5EwhYbOQl/tE8H1qUqMPKNYGCjJ2ATMru
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,291,1654552800"; 
   d="scan'208";a="22875774"
X-MGA-submission: =?us-ascii?q?MDH7otAjhrc+BDx0/t8INtCSOJbUdawWgzKxj0?=
 =?us-ascii?q?tayyKgDpA76QBY811chEitvemes306yDRvdOPOKPANGp4SKNzLKT+ORM?=
 =?us-ascii?q?15GuS8sd0GoPJHRmjZbhBMr4lgo4ulfaWWZa9tPGuYyf2w3Upauj5LOj?=
 =?us-ascii?q?aQHkI+ouhUllbvYz+/39sSpA=3D=3D?=
Received: from mail-oa1-f49.google.com ([209.85.160.49])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 14:04:57 +0200
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-11eab59db71so20853130fac.11;
        Mon, 05 Sep 2022 05:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=stjE8hV6IQXpnccW5n/Xg00woCgW/nhgQVOpl6jIVyo=;
        b=UcRV/t/LopJ1Tf3VodoNIUxkzrBA+c7iP/YUrqhWQ76mQhx3vEinboHgiEJWc+hOjY
         slnqDSmlwBT1L0dPBBJz8EZlYack65YMiKNZXSVf+0m1rZ/p2RY66lbUPpoCWsw+hCLW
         ivzlj/Hvfav2d7LVTmApEYIUG5Z3MuS0d6jNbw+y6ybrGJl5OKjXKSpMLNMdRenXvrmU
         m/ZDss+VLMcmM8lDIvcBN5vv8pT88qwaOYjsCXriP+S0iYX1pnmLLvot3evgqus+H+xX
         AWoBt5OTuvw0x6KAhp9JWMxgWJwbsa+2jDZgj+momV3dq5/HaoSMjM0E5cADFzTW2t+p
         a1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=stjE8hV6IQXpnccW5n/Xg00woCgW/nhgQVOpl6jIVyo=;
        b=a8epi3YrtM1f5vsmynC2bQjzJDTojw2PHIud0dGHE2Ku65OujAoi2FbV4lcN1YY9bG
         p8//RsnnMw3dvofB5vM+mLdsqhC3QQBvIktg3kKgw6+5YKUT7239aVstXgpWJj74swP8
         /c1xUe/8ioQpP2GDFLPTzvtWvXfsBbWQBScUcvsUDy232Ies4z36TqLyS7ztkJjbOEM8
         yCDkuTOJhhLZApUpXEvxu4O/wSgbwApSYUtQRvQ3e/+AMs1TEOuKbInKMbJOI3TnCTCa
         ce9kSqLeb/hotk8fg+PfTiPk4hHXxr2tcBQ7TaITMIqjz+MmmxjDZF6GNQZ1rtQV2zEw
         4mbA==
X-Gm-Message-State: ACgBeo34c7WbEyqLBp0pnEltiVO+O8cLkw0TPXltTRQ3kYGhQx/Plalq
	6h9zgDBAT6qLdamdUEfx3sYY1TN+eutU2yBX5mrjUqVTHVw=
X-Google-Smtp-Source: AA6agR4P7xZd25HFHo2OK82+KCWTGdL6Gytiv8tkv2awRhzRZ/frlS54MVqbDaChnDQHabAbc+89NWczJdTEmoz5QTw=
X-Received: by 2002:a54:4405:0:b0:343:23df:4ac5 with SMTP id
 k5-20020a544405000000b0034323df4ac5mr7079274oiw.69.1662379495079; Mon, 05 Sep
 2022 05:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2209050952300.2731@hadrien>
 <20220905090915.3569051-1-jtojnar@gmail.com> <alpine.DEB.2.22.394.2209051246490.2731@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2209051246490.2731@hadrien>
From: Jan Tojnar <jtojnar@gmail.com>
Date: Mon, 5 Sep 2022 14:04:43 +0200
Message-ID: <CAFGSp1ud+X_xHa4zwhwPEzOvoC+4zwmONLi5HCQn76WHzfwoHQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [cocci] [PATCH v2] Exit with non-zero status when spatch on a
 directory fails
Reply-To: Jan Tojnar <jtojnar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 541
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/CAFGSp1ud%2BX_xHa4zwhwPEzOvoC%2B4zwmONLi5HCQn76WHzfwoHQ%40mail.gmail.com>

On Mon, 5 Sept 2022 at 12:48, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
> I'm not sure to understand the point.  --bench and --compare-with expected
> don't mean at all the same thing as just keep going.  --bench prints some
> statistics about the CTL mating, and --compare-with-expected checks that
> the result is the same as the one indicated in a .res file.

I would expect that when an error occurs during transforming one of the files,
transforming any other files does not make sense since the SmPL patch
probably makes incorrect assumptions about the source code.

In my case, I made the Python script inside the semantic patch raise
an Exception
when the source code does not meet certain preconditions, to detect that
the underlying code changed in a way that the .cocci file needs adjusting.

I guess that failures might make sense for tests (--compare-with-expected
seems to only be relevant for tests as far as I can tell). But I would expect
benchmarking to be useful for people creating patches and there, silently
suppressing failures could be unexpected.

But you are more knowledgeable about the use cases so I will leave it up to you.
to profile failing
