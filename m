Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184A2C4332F
	for <cocci@archiver.kernel.org>; Sat, 10 Dec 2022 09:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Iqzg7MxWv68kLP2wg8/6q9wPshwJJhJN+T3DuRgOko4=;
  b=qz61NO47p+La+xjroYVAUDNDJqeLL/p7yrHtppmAAEj2yJxIygeLazd+
   WndeQUojE9LAB9ABiDF/kY85H8XZxlQoRur79FMVwGRb21e/PtHqm2JvM
   K1gXUvDdtKUf7ixp4o60i6cYKGuP9VbU5SK7ma0gRw48h8y7MadOr/Szg
   E=;
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
X-IronPort-AV: E=Sophos;i="5.96,232,1665439200"; 
   d="scan'208";a="82734188"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Dec 2022 10:25:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DA0C1E0141; Sat, 10 Dec 2022 10:25:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 29D9BE0128
	for <cocci@sympa.inria.fr>; Sat, 10 Dec 2022 09:03:49 +0100 (CET)
IronPort-SDR: 63943d64_XGhvlJdvkN5yNWffujyQuFHJhRe3k4Atn1MGx420WCU/382
 vwEFpDOykUX96DFhSefeW2z4guehyqideLGQJyw==
X-IPAS-Result: =?us-ascii?q?A0ESEgClO5RjfzTZVdFaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?VGBQwIBAQFjNlFVLwQLRYRPjnieCIMWPg8BAwENFAEBJQkEAQEDBIQ5hVICH?=
 =?us-ascii?q?QcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEZCRkHD?=
 =?us-ascii?q?g4FJIVoDYI4IhlkTQMDNQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEEAg1SH3ERHQEbHgMSEA8CJgIkAREBBQFXgl2CbQEDMQMQoGmCH?=
 =?us-ascii?q?4EEQosygRUFAhaBAYIJBpwIChkoDWgDgVsCAQYSgQIqAgEBAQEBhzECHVheh?=
 =?us-ascii?q?xmBIRCBVUSBS4MygmICgi2DCoJnBIENlWYKAQEEAgIDAgIDBgEEAgICBQMDA?=
 =?us-ascii?q?gEDBAILBQQRAQECAgEBAgQIAgIGAwICCBEXAwcCAQMDBQEDAQIGBAIIAQsCA?=
 =?us-ascii?q?gEFAwEKAQIEAQICAgEFCgECAwEDAQwCBAgCAgMFCgEDBwMEBgUPAwMCIAECA?=
 =?us-ascii?q?UMdAgkDIw8DCwkIEz8GAQIBCgc4BDQBCg0IBQEEAQcDAwUFCQ8DBAIBAwMCF?=
 =?us-ascii?q?AoFAQMGBggCBAUCBQMCBAIDAgIIAwIEAwsDBQQCBwQPBwIDAgIFAgICAgIFB?=
 =?us-ascii?q?AMBAgICAgICBQIDAgEFAQICAQICAgQBAgIHBAIDAQMEDgQDAgICBQECAgEGA?=
 =?us-ascii?q?gcDAQIBBAMBAQQCBAECBQIEAQMGAgQDCgICAwICAgYFAwIKCAIDBQIEAQECB?=
 =?us-ascii?q?wQCAgsBBgIHAgIDEAEDAQQFBQMDAwkCAgMCBAICCgEBAQECAQcCBAcNAgICB?=
 =?us-ascii?q?AICAgEDAgECAgoRAQECAwYEBgUDBhgFAgEBAgIDAwIGAgECCAIEAQQFAgECA?=
 =?us-ascii?q?gICBAEIAgMBAQIBAgIDAwIBBAIEAwMBAgECAgMCAgIDAgIBDQIGBgECAgICA?=
 =?us-ascii?q?gICAgIGAQIBAgQCBwIEAwIBAgIFAgICAwEBBgIECwEDAgcIAgcFAgMBBAMEA?=
 =?us-ascii?q?wMLBQwIAQUBAwEfAwICCAIHAgEGBQEPAwICAwICAQQKAgMFAgQCAQQIBwIEA?=
 =?us-ascii?q?QIJAwIGAgYFGAECAgcEDAoBAgIFBgQBAQIDAQIBAQIDAwIDAgQFAQUCAQIFB?=
 =?us-ascii?q?AIBAQIFAgwBAQcGAgcCAgIDAQQCAQIBAwMCAwEBAQMGBgIGBAIDAwYCAgIGA?=
 =?us-ascii?q?gIDAhIGAgYDAgQBDQsFBAUIAQIBAQcCBAIHCQ4CAQQBBQICAwICAQUCAQYDA?=
 =?us-ascii?q?QICAgIFBwUDBAUDBg8DAQEEAwIBAgECAwIDBwMCBAIDAQIDBAYGAQkEBgUNA?=
 =?us-ascii?q?wQCAgECAQEDBAQEAgIBAgIDAQQCAgEBAwMDAgICAwQCAwMLBAoHAwMCAQULB?=
 =?us-ascii?q?AIDAgEDBgkEAgIGAQIEAgICAgICAgMBAQMKBAIBAgMCAgYDBgIBAgEJBQIBC?=
 =?us-ascii?q?QMBAgEDBAEDCQECAgQJAgMHBQoCAgICCAICDgMDAgEBBAICBAUJAQIHAgUBA?=
 =?us-ascii?q?QMFBwICAQICAQQDAQkEAQIDAgEBAxIDAwEEAgIFAwMNCQYCAgEDAgENAwECA?=
 =?us-ascii?q?QIDAQUFFwMIBxQDBQICBA0CAgMDAwIBAgkGAQMBBQIOAwICAwMGAQIBAQIDD?=
 =?us-ascii?q?gQFAQEBARcBAwQCAwEEAwEBAgECAwIOBAEEBQsDAQIdAgQBCAgCAgICAwEDA?=
 =?us-ascii?q?wUBAgMEAgEICgICAgIKAgoDAgMBAwUBAwIJAwEFAQIHAgYBAQECAggCCAIDC?=
 =?us-ascii?q?wEDBQYCAQICAQUCAQICBQMFAgICAgIEDQIFAgICBgECBwQCAgIEAQICBgIFA?=
 =?us-ascii?q?QIHBwQFAgICAwMKBAQCCgQBAgEBBgECAQMEAQIEAQIBAgUJAgICAgECAgECA?=
 =?us-ascii?q?QEIAgICAgICAgMEAgiYYoIZgQI7BIIfWAOSJ5BwnwM0B4NwBYFFBgyJd5UKM?=
 =?us-ascii?q?qkekgiFOY1FlHiFLhAjEoFEI4FcTSOBAYI2TwMZD1iNf4M7inwmMTsCBwsBA?=
 =?us-ascii?q?QMJih8BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:kGmmVKAZu6c6xBVW//vnw5YqxClBgxIJ4kV8jS/XYbTApGgghDMPn
 zQZXWmOaP+KY2ShcoggO9i0pklX7JbcydYwOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6jMlkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/ouOZjdJ5xYuajhOsvja8Es21BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc51bNS371/uh0Nx0zILIqxPpLH0Vx7
 fNNfVjhbjjb7w636LeyS+0pmN96ace2ZsUQvXZvyTyfBvEjKXzBa/+StJkIgXFq358IQKy2i
 8kxMVKDaDzCZBtGJlcQDtQkkeauhnDlbxVXrVuUoew85G27IAlZgOKyaoqOKoHiqcN9uFajj
 Xzt2HnCUzYFDueW1jmg/XK2v7qa9c/8cNtKSOfQGuRRqFaUzWcSIAYHUEOy5/i/kE+3HdxFQ
 3H44QIrpKk2sVKwF5zzAkf+r3mDsRoRHdFXFoXW9T1h1ILP6D6cH1UZVAUdbcEZhvEqeSIO6
 UeGyoaB6SNUjJWZTneU97GxpDy0ODQIIWJqWcPiZVtVizUEiNFj5i8jXuqPA4bu0YKoQWCYL
 ySi6Xlh1+9K3Kbnwo3ipQif6w9AsKQlWeLc2+k6dmes7wc8epX8IoL1sx7U6vFPKIvfRV6E1
 JTlpyR8xLBeZX1uvHbVKAnoIF1Pz6jfWNE7qQA0d6TNDxz3pxaekXl4uVmS3ntBPMceYiPOa
 0TOow5X75I7FCL0MvcpOtrvUZ9xl/CI+THZuhb8Poomjn9ZJF/vwc2STRP4M53Fyhlyz/lkZ
 f93j+79VC1BYUiY8NZGb75FjeVDKtEWymTUSpT2pylLIpLPDEN5vYwtaQPUBshgtP3siFyMr
 753apXXoz0CD7WWSneNreY7cwtRRVBlXsCeliCiXrTcSuaQMDpxVaG5LHJIU9ANopm5Yc+Ro
 y3tChMElAKh7ZAFQC3TAk1ehHrUdc4XhRoG0eYEZz5EAlByOt7937RVbJYtY7gs+cpqyPM+H
 bFPeNyNDr4LAn7L8igUJ8u15oFzVgWZtSTXNQqcYR87Y8FBQS7N8YTaZQfBznQFIRe2ksocm
 Iee8D3nb6ANfTk/M/aOWsmTlwuwmVM/hNNNW1D5J4gPWUf0r6lvBS/Drt42BMAuLx/86COQ/
 FuUC01ApM3mgYw8wP/Wj4+q8qarFOpfGBJBPm/5tLyZCwjTzlCB86RhDtmaXGn6f3zm3Ymff
 sNp9uHYHNxbuUdVoqx+Pq1Oz6lj1+DwprRf8BtoLE/LY3uvFLlkBHuMhutLiYFg2Z5bvhmQS
 GuU29wHJ4iMBtzpIGQRKCUhcO6H8/MewRvWzPYtJXTF9D1Fx6WGXWpSLiuzpnRkdpUtC7wcw
 MAlpMIywC68gEBzMt+50wZlx17VJXkEC6gappUWBbHwsTUSy3ZAX834KjT365SxedlzIhEUA
 juLtpHj2ZVY5GT/KkQWK1ac/NBglawvuQ9LxmAsP16muMTIrd5p0Qxz8QYYdBV0zBJG2d1dI
 mJAbhd+N4iSzTVVlexGU36mQQ1aNibE+Eark1otv0/aRnmOSWbiAjAcO+GM3UZB6ENaXGFR0
 4+5wVbfcwTBXZ/OzA4tf096utrfTdBV3S/TqvCNRsiqMcEzXmv4v/WIe2ENlSrCPeowo0/2/
 c9R4+d6bPzABx46+qEUJdGT6uUNdUqiOmdHfPBG+ZEJF0H6fBWZ+2CHC2K1S/N3C836y22KI
 O0wGZsXTDW77jiEkR4DD61VI7NUou8g1OBfRpzVf1w5o5mthRs3lqKI7SXvpn4Zc/M3m+YHF
 47hXTajEGuRuHhqp1HwvPR0YmqVXN1VSzD/jcaU8foIHa0tqOtDU18/+ZrqsmS3MDlIxQO1v
 gTCVfWPz+Vd1pldxdrwM6RcBjebLcH4e/SI/TuS7fVPT4LrGuXfuzwFrmLIO1xtAoIQfNBsh
 JKxv8XSzmqcmJoLC0XihIimO4xSwMeDTM57E5nQEiFBvC2gXMTM3UMyy1qgI8YUrOIHt9iVe
 QSoTeCRK/sHUMh5719IYXF8Fx09NfzGXp34r3ngk8XWWwkv6i2ZHtaJ7nSzUHp6cBUPMJjAC
 gPZnfaiy9RbjYZUDi8/GPBULM5kEWDnRJcZWYX9hRuAAkmsp2GyiL/ouB4jyDPMU3e6SZewp
 dqPQxXlbx29tZ3Z1NwT4cQ4ohQTC207muUqOF4U/9ltkT2hEWoaNqInPI4bDo1P2DnHvH0ii
 OohsEN5Yck8YdhFTfk4yNHqXwPaGPdXf9mkfHom+ESbbyrwD4SFaFekGuGM/F8uEgYPDsn+Q
 T3dxpE0Fhe0y5BtA+0U45RXRM95k+jCyCtgFV/VyqTP7tV3PVnO/HNkFQtJEyfAFqkhUakNy
 XcdHQh5fa1wdaI9/QuMtZKY9NH1cQ4DFwkVUBo=
IronPort-HdrOrdr: A9a23:KqvWd6i3/GWzcdQtk3sMHhu+NHBQXtcji2hC6mlwRA09TyX4rb
 HIoB1/73XJYVkqKRIdcLy7WJVoIkm8yXcW2/hyAV7KZmCP01dAR7sSiLcKrQeQfxEWNdQw6U
 6jScVD4RHLYmSSRPyV3DWF
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,232,1665439200"; 
   d="scan'208";a="82728385"
X-MGA-submission: =?us-ascii?q?MDHzjb/fI0rb8Eoa7FdYy+Myo/COCWXQNsv7uY?=
 =?us-ascii?q?A7ZWx0gVUuCng1sSHeHpdsVu6TzUzArFOOJeN4oKhsCTrtpeKZDpKg3M?=
 =?us-ascii?q?T6v8sIObWFXLj88I21+QBDnmM5I5hMrhtqLGKRks2of9wRkJ/kTcr300?=
 =?us-ascii?q?FmXNLI9FDoNuqqFZagoMWORQ=3D=3D?=
Received: from mail-vs1-f52.google.com ([209.85.217.52])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 09:03:48 +0100
Received: by mail-vs1-f52.google.com with SMTP id 3so6606190vsq.7
        for <cocci@inria.fr>; Sat, 10 Dec 2022 00:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Iqzg7MxWv68kLP2wg8/6q9wPshwJJhJN+T3DuRgOko4=;
        b=Fpik5RoFarM6OhyrU2oiSy0wIIDCvQKAm5/A4xm7FWwNHe0XaDMxx1B9KHsYCnTmY7
         ogqRDOidom8Yz7AhZAmUwcGjQsXo9Ln1jHf3gj2HCIyn7CmHM+K7Xuzq+IgKc+WryvRP
         7PZmfuJ0R/E5FwS5GPkVGcbkErnPltpbike0Le1LPr4a2GU9/4bu3Q2WoUbIwvsUlVMD
         UuSuUrSTOxww59upkxrJ+itqOuY1CSeiTO1zd3awKVtlT3Z4cMvpcfI1GAN84RFfeJLi
         VChKqPoVdl1FxERTF3nn2eCKfid7cNPwmviylLXBMKITLi+WNYT/WuOwDvW/Tx4f+Ae9
         SiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iqzg7MxWv68kLP2wg8/6q9wPshwJJhJN+T3DuRgOko4=;
        b=Q+yYKYE28NmYreeVYt8qTWeloMV7qPFfQiuKSqD3REFSlZ6mKY0u1Ko9rXaBMbs/EG
         S6pW+Czf1fCwvyz94uKzO+nShNwJtePFwXvebvEEPFSPkyT0a0M5U3E0jPB5fQHe50lQ
         IXwm9wPJdp/huXVwbGNU2k9DfQpEZjhyxdp2JCnogtty26pAL5Bgf/cf1y+0NrOh2NU2
         re1kIOAdwp+O/NuzkGcyt3DFGrTZJz9Adg4DPXQO52fbHhlgMrW1pTTD6ORpCoI09ZOT
         JIHXv7AisZHjQTPLRdEMUQJs79T0GZK9ftkcpmZJUomvdp+ejqCM4c4x5yPWS7j2mlTy
         TaFg==
X-Gm-Message-State: ANoB5pkQmJ6DjszHeoDRnL2GkUl5A0uHSv4221FUqdBeiyN9rDwOru4q
	XwmmEKjrFteoqpURVQ3yMeRnoez+bptlpec7QFsYd/Doel8=
X-Google-Smtp-Source: AA0mqf4er/J1Fs4MLVwJODjRbZ45UwyDbzgkT3XXeFlQo+/vGzp5YvcpQuO4YL6TaNKOw/F1XNUTUi808Jlo8C9iEZI=
X-Received: by 2002:a67:f04d:0:b0:3b2:fc81:48bb with SMTP id
 q13-20020a67f04d000000b003b2fc8148bbmr3509348vsm.39.1670659427140; Sat, 10
 Dec 2022 00:03:47 -0800 (PST)
MIME-Version: 1.0
From: Jonathon Reinhart <jonathon.reinhart@gmail.com>
Date: Sat, 10 Dec 2022 03:03:21 -0500
Message-ID: <CAPFHKzf2pDTK_O9_m23D4R0ryFknAy_bjSSdLsu+ujJcZYCcdg@mail.gmail.com>
To: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Converting strncmp() to strcmp(): constraint on variable
 cannot be evaluated due to disjunction
Reply-To: Jonathon Reinhart <jonathon.reinhart@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 772
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/CAPFHKzf2pDTK_O9_m23D4R0ryFknAy_bjSSdLsu%2BujJcZYCcdg%40mail.gmail.com>

Hello, I've been using Coccinelle for about 2 hours :-)

I'm trying to write a patch to convert strncmp() to strcmp() in the case where
the author didn't actually want "starts with" behavior, e.g.:

    - strncmp(foo, "literal", 7)
    + strcmp(foo, "literal")

(In fact I was quite excited to find
https://github.com/coccinelle/coccinellery/blob/master/strsize/strsizeof.cocci
but it didn't actually do what it claimed.)

I was pleased to get something like this to work:

    @initialize:python@
    @@
    def string_literal_len(sl):
        if not (sl.startswith('"') and sl.endswith('"')):
            raise Exception('String literal not enclosed with double quotes')
        return len(sl) - 2


    @@
    expression x;
    constant char[] literal;
    constant int n : script:python(literal) { string_literal_len(literal) > 0 };
    @@

    - strncmp(x, literal, n)
    + strcmp(x, literal)

However, when I tried to adjust this to also handle the case where the literal
is in the first argument:

    (
    - strncmp(x, literal, n)
    + strcmp(x, literal)
    |
    - strncmp(literal, x, n)
    + strcmp(literal, x)
    )

I get the following error which I can't really understand:

    init_defs_builtins: /usr/lib/coccinelle/standard.h
    rule starting on line 9: constraint on variable n cannot be evaluated in
    line 15 due to disjunction

    (
    -strncmp
      >>> strcmp(x, literal)
    -(-x-, -literal-, -n-)
    |
    -strncmp
      >>> strcmp(literal, x)
    -(-literal-, -x-, -n-)
    )

Why can't the constraint apply to n in both cases?

Can someone let me know if I'm on the right path here? Examples with
constraints are scarce, and I haven't found any examples of using Python script
constraints on a normal (non-position) metavariable.

I also have some other patches to handle arguments like strlen("foo") and
sizeof("foo") (which is wrong).

Thank you,
Jonathon
