Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1116AC678DB
	for <cocci@archiver.kernel.org>; Tue,  7 Mar 2023 11:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=bLZjGTICXf4/hYKVQNr2vIm2DlWjqIdxyxR5eg+xDFc=;
  b=bi6PHdIATluUFv6u83RnJ8ZviWb+NxOXEzYymOje3M87MueZd+zeYdkH
   boTXxYk/zPbJ+FZ23VW5WYEdayxaN7tOnN1dh5wunAH1gkOFthgHzTS3J
   BNG++uMHYuuYCYWd5BrGb2Ou4KGf9xk+Cjk116cBuM4iPBLMrDdyjfy/0
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.98,240,1673910000"; 
   d="scan'208";a="95844252"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2023 12:09:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D0CE3E4375; Tue,  7 Mar 2023 12:09:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9B066E0247
	for <cocci@sympa.inria.fr>; Tue,  7 Mar 2023 11:50:12 +0100 (CET)
IronPort-SDR: 640716e3_mg9yllIt8mLWSTZWz81MnWM9OKplYMTcPmiYhHriH6qlLmv
 oQfkdJITljN2yXFhoA7JQ/IjQZWyx2vaiAn2IIg==
X-IPAS-Result: =?us-ascii?q?A0GwAAD4FQdkf6zQVdFaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?gQBAQsBgi2BSy8EUY1RlAGHN4t/Pg8BAwELAQFCAgQBAQMEhH6FNAIdBwEEM?=
 =?us-ascii?q?wYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEZCRkHDg4FJ?=
 =?us-ascii?q?IVoDYI3In1NAzgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBBAJ+OQEBIBYgAQ0BGx0BAxIQClQRAQUBNSKCXIIpAQMxAwSlW4EEQoxHB?=
 =?us-ascii?q?QIWgQGCCQaBFYFOmSgKGSgNaAOBWwIHCQEIgS4BhDcjgmiEKYRKgSGCKIQPh?=
 =?us-ascii?q?HlOOIVyBJZKAQMCAgMCAgMGBAICAgUEAgEDBAIOBA4DAQECAgEBAgQIAgIDA?=
 =?us-ascii?q?wIIDxMDBwIBBgUBAwECBgQCBAELAgUCCgECBAECAgIBBQkBAwEDAQsCAgcCA?=
 =?us-ascii?q?wUGBAIDDQIBAQMCAg0DAgMCBAEFBQEBEAIGBAcBBgMLAgQBBAMBAgUHAwcDA?=
 =?us-ascii?q?gICAggEEgIDAgIEBQICAgECBAUCBwYCAQICAgQCAQMCBAICBAICBAMRCgIDB?=
 =?us-ascii?q?QMOAgICAgEJCwIDBwQCAwMBBwICDAEDGAMCAgICAgIBAwcKBAkEAgUBAgEEC?=
 =?us-ascii?q?wEFAQ0EAQICAgICAwIBAQMGCAYDCgIFBAMDBgkPDwgFAwEEAwIDAgEICwIDA?=
 =?us-ascii?q?gIECAIDAQICAQYCAwECAgECAgELAQECAwUCAhEBAgICAgIBAQIDAgMBBwECA?=
 =?us-ascii?q?hgGBAUDAwUCAgEEAQICBAQFCwIEAwEBAQICAgIDAgsDBQMBBgMDCgcEAQgCB?=
 =?us-ascii?q?gMEAgUEAwQEBgICAgICAQQBBgsDAgQEAwMGAwkCAgwCFAISBgEECwsEAQICA?=
 =?us-ascii?q?g4DBAYCAwMCAgUKBAICAgICAwYCCQQCAgMDAgIDAwcDAQICAgUBBAUGAwIEA?=
 =?us-ascii?q?gEDAgQCAgQDBAEBBwICAgICAwECAgMDAQIBBgMCAgIFAgIBCAIDAgICAgMDD?=
 =?us-ascii?q?wEBAQIJIwMDAiADCQMHBUkCCQMjDwMLCQgHDAEWKAYMBwwoBDQBFAcBDQcHB?=
 =?us-ascii?q?ioOBgIGAwQBCgsFBAUIAQIBAQYCBAIHCQwCAQYBBQICAwIBAwICAQYDAQICA?=
 =?us-ascii?q?gIFBgUDBAUDCgkDAQEEAwIBAgECAwIDBwMCBAIDAQIDBAYGAQkEBgUNAwQCA?=
 =?us-ascii?q?gECAQEDBAQEAgIBAgIDAQQCAgEBAwMDAgICAwQCAwMLBAoHAwMCAQULBAIDA?=
 =?us-ascii?q?gEDBwkEAgIGAQIEAgICAgICAwEBAwkEAgEDAgIEAwYCAQIBCQUCAQkDAQIBA?=
 =?us-ascii?q?wQBAwkBAgIECQIEBwUKAgICAggCAg4DAwIBAQQCAgQFCQECBwIFAQEDBQcCA?=
 =?us-ascii?q?gECAgEEAwEJBAECAwIBAQMSAwMBBAIFAwMNCQYCAgEDAgENAwECAQIDAQUFF?=
 =?us-ascii?q?wMIBxQDBQICBAQBBwICAwMDAgECCQYBAwEFAg4DAgIEBgECAQECAxAFAQEBA?=
 =?us-ascii?q?RcBAwQCAwEEAwEBAgECAw8EAQQFDAMQDAIEAQYCCAICAwMBAgMFAQIDBAIBC?=
 =?us-ascii?q?AoCAgICCQIKAwIDAQMFAQMCCQMBBQECBwIGAQEBAgIIAggCAwsBAwUGAgICA?=
 =?us-ascii?q?QUCAQICBQMFAgICAgQNAgUCAgIFAQIHBAICAgMBAgIGBQECBwcCBQICAgMDC?=
 =?us-ascii?q?gQEAgoEAQICAQEFAQIBAwMBAgQBAgECBQMGAgICAgECAgEBAQgCAgICAgIDB?=
 =?us-ascii?q?AIImlWBDqQ/oX4Hg32KRZYbGjKXBwySKQGXYKNDhCsCCgcGECMSgUMkgVwzG?=
 =?us-ascii?q?iOBAYI2TwMZD44gg3KPez80OwIHCwEBAwmFRT6CZ4JZAQE?=
IronPort-PHdr: A9a23:EPZB8xFX41akBjvuqFe60p1Gfx9GhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k30RmTBN2QsqkMotGVmp6jcFRI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDffQVFiCCjbb9vM
 Bm6ohjdu8cLioZ+N6g9zQfErXRPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q
 6VAADspL2466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUjms8
 6tnVBnlgzoBOjUk8m/Yl9Zwgbpbrhy/uRFx3oDaboKSOvVxca3QZs8WSGlbU8pNTSFNHp+wY
 o0SBOQBJ+ZYqIz9qkMQoxu5AAmsAeLvwSJUiHDs2606z/4uEQXc0wc9GN8OrGjUoM/vNKgIV
 +C10LPHzTHZYP5N1jf97ZLHchElof2WQb1wds/RxFApGgjYgVqetZbrMCmJ1uQRrWeb9exgW
 PqthmMntQ18vjmiy9kth4XVmo4YxVDK+CtkzYs6JdO2Rk92bMC6HJZMqy2XNZV7T8MsTmxnt
 ys0yqMLtYK0ciQXzpks2h3Ra+SffoSW/h7uUPydLDR4iX5/Zr6zmxW//VK9xuD+SMW4yFVHo
 yRfntXSuX0A1wbf5tWIR/Zy5EutxDaC2xzV5+pZO047j7DbJIQkwrMolpocr0DDHijulUXzl
 qCWd0Ek9vGs6+Tlf7nqv5GcO5J2hw3gKKgulcu/AeM3MggKQWeX4/iz1Lrm/UHhQbVKiOM5k
 rXBvZzEOcgWorS1DgxV34o59RqzEzSr3M4FkXQFMl5JYBeHgJLoO1HKLvD4F/C/g1G0nTd32
 /DKJKfhDY/LLnjfirjheaxy5lVTyAo2199f5pZUBqsdL/L0X0/9rNrYAQQhPAyu3+nnEMl91
 p8ZWW+XH6OVKLnSvkOQ5uIzP+mMY5cYtyr6K/c5+/HujGQ0mUQdfKmsxZsYcmq0HvVgI0WDY
 HrjmM0NEWkQvll2cOu/g1qJWj97ZnCoXqt66CtoJpihCNL/QYWogfS71SGnF5lfLjRaFhaWG
 HH0foGNc/gJYSOWZMRml2pXBvCaV4Y92ET250fBwL19I7+MksV5nZfq1dwuovbWiQl37jtsS
 cKUz2CKSWhw2GIOXT4/mq5l8gRm0lnW969+jrRDEMBLoetTW1ImKdjGxupmAtT7cg3Ed9aND
 l2hR4buGik/G+o42MRGeENhA5OnhxHH0TCtBuoJi/qRDZoo+6bV93f0Lsd5jX3B0fpplEEoF
 +1IM2Dunatj707TCorOxl2ejLqvfL8A0TTl8W6CyS+KvhgdXlcvC+PKWncQYkaQptP8jq/bZ
 5mpD7lvcg5IyMrZb7BPdsWsllJeAvHqJNXZZWu13Wa2HxeBgL2WPsLsfC0G0SPRBVJh8Uhb9
 GuaNQU4Giaqon7PRD1oG1X1Zkrw8O544HqlR04wxguOYgVvzb2wshISgPWdTbsU0Ndm8G89t
 3NuFVCh1tbfI9WFrgtlOq5bZJJ14VtK037Yqx0oJoapfOhpgl8TdRgyvlu7jU0mTNUd15Jy/
 DVzk1AhTMDQmElMfD6Zw53qb7jeK22puQuqd7aTwVbGltCf5qYI7v087VTlpgCgUEQ4oBAFm
 5FY1WWR4pLSAU8cS5X0Bwwr615grrfGay00z4zR3Hxod6Kzt3WRvrBhTPtg0Rumc9pFZemYC
 EnoGssGDsynAOMvklmtKBkDOaoBkcx8d9PjfPyA1qmxOe9mlz/zlmVL7rd21UeU/jZ9QOrFt
 3oc68mRxRDPFzL1jVP699vyhZgBfjYKWGy21SnjAodVIKx0Z4cCT2m0cYW7wdB3hpilXHA9l
 hbrG09AwsavZROWZnTy2ARR0QIcpnnvlSajzjNymi0kteLFhH2Ik7mkLkJXfDcUHiFrlh/0L
 JKxjswGUUTNDUBhjxaj6UvghuBaqKl5M2jPUBJNdinyIXtlV/j4vb6DbshTrZIw5H8PAaLsP
 BbAEu67+kRAgEaBVyNEyTs2di+noMD8lh1+0yeGKWpr6WHeYYd2zAve49rVQbhQ2CAHTW92k
 2qyZBD0Mt+38NGTj5qGvPq5UjfrSoEVayDt0YqEvQO04GRrBVu0mPX5ybiFWUAqlDT20dVnT
 3CCsAq6eIDty62+OMpoe0BpABn37M8wSeQc2sMgwZoX33YdnJCc+3EKxHzyPdts0qX7dHMRR
 DQPzo2d8E3/1UZkNH7M25PhWyDX3J56f9fjKDBzuGp1/4VQBayT9rABgSZlvg/ys1fKefYk1
 jYFlal1tThD0rlP4lZyiH3aWOxaHFEEb3Kw0U7TtJbn8v0RPCH2IN3SnAJ/hYzzUu/E+1kGH
 i6/ItB4RWdx9pktbgyKiiGirNG8PoGXN4pbtwXIwUiaybEJbstgzLxSwnM3XAC19Xw9l7xk0
 Vo3h8z85M7fbDwztKOhXkwBbm2zPpxMvGGr1eEEx46Xx9z9R8o6XGxaAN2wC6rvSWx317yvN
 h7SQmdk+zHLRPyGR1/ZsAA/8DrOC8z5bSjJYiRJi4wzHl/FYxUOyAEMAGdgx8B/TFv7gpe7N
 h8+v2F0hBawvBJIzqgA2wDXdGDZqU/obz41TMPaNx9K9kRZ4F+TN8WC7+V1FiUe/5u7rQXLJ
 HbJLwJPRXoEXECJHTWBdvGn+MXA/u6EB+G/M+qGYLOArvZbXuuJwpTn25Vv/jKFPMGCdnd4C
 Phz1k1GVHF/U8PX/ldHAzQQjD7IZtWHqQ2U/yR2qoW78q2uVluwv82ADLxdNdgp8BezwO+CO
 +OWmCdlOGNY25cLlhqqgPAU2F8fjT0rdiH4S+xR836QCviIyukOUERIDkE7fNFF5K89wARXb
 MvSi9euk6V9kuZwEFBdE1rohsCuY8UOZWC7LlLOQkiRZ9HkbXXGxd/6ZaSkRPheluJR4lesp
 XCBGkn/NzCKvzbsXhGrd+pLiWvIWX4W8JH4aRtrBWX5GZj+bQanNdZskTAs6bg9h3ePMWxFd
 DYlLBkLobqX4idVxP54HiYSixgtZfnBkCGf4e7CL58QuvY+GSV4mdVR53EiwqdU5iVJLBSUs
 C7br9orp1P/1+fWlWAhXx1JpTJGwomMuBc6UU083pZFUHfAuhkK6DfIY/zlj9RgA9zr/atXz
 4qW/J8=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:WNfvJq/XW1IfMW6pjOduk+DvI+orL9Y04lQ7vn2ZESYlFvBw5P
 re+8jztCWE8wr5N0tBpTntAsS9qDbnhPtICOoqTM2ftWvdyQiVxehZhOOIqQEIWReOlNK1vp
 0OT0EKMrzN5C9B4/oSjjPVLz9q+qjgzEnhv5am855Cd3ATV51d
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,240,1673910000"; 
   d="scan'208";a="49438543"
X-MGA-submission: =?us-ascii?q?MDHZDnZAjexWqEJGLPdrfMSb/X95KPgIyGKujl?=
 =?us-ascii?q?A5CSKE43Q6e5eQx5XEJWqmygNqMgtVm/lCbJPeAVelr8gTKUAts/yt0P?=
 =?us-ascii?q?qr/jhMj4TGK8rg7ZAy7ke3zF0SGAzm375HMknJrCnPuNhqOl1DQofMoi?=
 =?us-ascii?q?2VNTHPhqJWgE4drDhsejqONg=3D=3D?=
Received: from mail-lj1-f172.google.com ([209.85.208.172])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 11:50:11 +0100
Received: by mail-lj1-f172.google.com with SMTP id i20so12604782lja.11
        for <cocci@inria.fr>; Tue, 07 Mar 2023 02:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678186210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bLZjGTICXf4/hYKVQNr2vIm2DlWjqIdxyxR5eg+xDFc=;
        b=HBxtvCtRXS0f/uCLj+r1NnFMwoskHZYh7p46U1jJcB8ZfSEDc8PdtbpfzjKJNe52n2
         mRf2/6rIibcf7Q7jOtASym88pw+8Z2ObBhWlokdY/uXHh8A/RgklcoEtIgSmqiOKwlG0
         7VkcUelGRxowkXTLd0Z+/TsxN624ZhYx5Owk1an3s4zbwsYQkeDZuXmNTwTq8M3aIN7G
         L+9ev77zFQfo2Gd3MAoAlh4N6tt3+1xcrqWCChmo5mknjZLfA7YUA2PNlnF+oRtTke74
         DK6KFVJOkejoRRcUNSQtICa345b53QBqQLPbq03c6lLE2Ko1UVTLD/UV5/42j2OKAYMa
         BlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678186210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLZjGTICXf4/hYKVQNr2vIm2DlWjqIdxyxR5eg+xDFc=;
        b=xtQYpZ5xr7x1GivYC826B3/1YEyKT4N5D60MJtJjOAtDbqfV4Fz6YZDndRKWGpxbzZ
         vPzh9KUGgMBboj13N50UM3JVtxuNhUoQveegz4/KJbxz0Vk2O89WNc/tA7pbZqCEo8WN
         QfM4Wbipfdsu8obigjclgCjf0x9IjZtL4BkJNSDZBGbh1j/OVK80HvT/fSI4vcBFDTD7
         V518NNPftO750d+4/RZK66eFPEUPG4C6aczRneIGemZp1x34pdUDUoW23P0MICWIRz5P
         PLMHsX7ToNj6PWiSGk9mOfYjx0UqeOjddvhPlE8i9fnj/VAehga9+28Kg8VtG4jwV5Z5
         TBcQ==
X-Gm-Message-State: AO0yUKU4auv6jwrloKqZEY2wpQ8xGCFJs8KN9ekWYclbWmdsBhNNJNY4
	GIGHCSLvAtAQ/yhJIVTGHbUfdzHLMNE=
X-Google-Smtp-Source: AK7set8nKTMHfSk7OzS9/BySeeFtNBA0CkosxWyPKn9CgGX1NmzrjlK+vnm7ew5LYn8pRoAAsR6Rbw==
X-Received: by 2002:a2e:7c07:0:b0:295:a2d0:57ed with SMTP id x7-20020a2e7c07000000b00295a2d057edmr5162723ljc.4.1678186209998;
        Tue, 07 Mar 2023 02:50:09 -0800 (PST)
Received: from localhost.localdomain (83-245-144-150.elisa-laajakaista.fi. [83.245.144.150])
        by smtp.gmail.com with ESMTPSA id r2-20020ac25a42000000b004db00b4c671sm1974072lfn.7.2023.03.07.02.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 02:50:09 -0800 (PST)
From: Tommi Rantala <tt.rantala@gmail.com>
To: cocci@inria.fr
Cc: Tommi Rantala <tommi.rantala@cujo.com>
Date: Tue,  7 Mar 2023 12:49:45 +0200
Message-Id: <20230307104945.3125611-1-tt.rantala@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] Fix find -name flag when combining --c++ and
 --include-headers
Reply-To: Tommi Rantala <tt.rantala@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 875
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/20230307104945.3125611-1-tt.rantala%40gmail.com>

From: Tommi Rantala <tommi.rantala@cujo.com>

Should be "-name" not "name".

Signed-off-by: Tommi Rantala <tommi.rantala@cujo.com>
---
 parsing_c/test_parsing_c.ml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parsing_c/test_parsing_c.ml b/parsing_c/test_parsing_c.ml
index 97842072..2d30eda4 100644
--- a/parsing_c/test_parsing_c.ml
+++ b/parsing_c/test_parsing_c.ml
@@ -35,7 +35,7 @@ let get_files path =
       (if !Flag.include_headers
       then
         "find "^ path ^" -name \"*.cpp\" -o -name \"*.cxx\" -o -name \"*.cc\""
-        ^"-o name \"*.h\" -o -name \"*.hpp\" -o -name \"*.hxx\""
+        ^"-o -name \"*.h\" -o -name \"*.hpp\" -o -name \"*.hxx\""
       else
         "find "^ path ^" -name \"*.cpp\" -o -name \"*.cxx\" -o -name \"*.cc\"")
   else
-- 
2.39.2

