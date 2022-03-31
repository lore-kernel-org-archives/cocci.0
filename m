Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEAFC43217
	for <cocci@archiver.kernel.org>; Thu, 31 Mar 2022 05:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=M+Y4Clr/KV3RmCQxfUTOx3L8tcl6/qhhWFZStvbs7AE=;
  b=cIFVGYVECUtyQzRLIbHbhr2tZ/4SEFXr22LOaYQFlaHTU+kTWsGheR8z
   G4EqBvRsHsRaVbPnqQUFgXleHw84BfNbeHr+Tgn6W/2dmEY5DjsJ1Ag08
   6ps/Xt2rzYpsklohpHY8nBKcFqids4sZOqHdS6545vGlSzxMczsDhZ2V8
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@google.com
X-IronPort-AV: E=Sophos;i="5.90,224,1643670000"; 
   d="scan'208";a="29209671"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Mar 2022 07:35:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A516DE1749; Thu, 31 Mar 2022 07:35:22 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7CBDFE00F6
	for <cocci@sympa.inria.fr>; Thu, 31 Mar 2022 04:10:01 +0200 (CEST)
IronPort-SDR: aTQsMmTiD0wFvumbBuSBvJYZ/vVJQY2AbnLQ8BT6JCBxzyv4SbRsMPgmyV5o0fQ450J/y92l7Z
 zQWn+66FsTtDXxWjgT9NWBKa2WNnffzCGTIZMb73pE/IDbPEh+fQNIWrSvzI1FMp/IPSyyqLKR
 0/oO62VKv9X48qKL7uADTOeB0phgd/OvcvXLze4sHAoiWucH1juY5kSwPlbuzTxMztun2S/vqi
 l7xIaXfxvpciGrTZnnguUdr+8kiFYbLE48N3KpMZcC3dTqYAsalzUN9lxgqNd6YewAtkEAmzKG
 77ZKnVDiiMj8m0PN3GIjGqTg
X-IPAS-Result: =?us-ascii?q?A0AsAAAMDUVifyqAVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UgFAQELAYIngVQsBAtEhFSRG4sSkVOBJQNUCwEDAQ1DBAEBhQcChFcCHQcBB?=
 =?us-ascii?q?DIHDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQ0LCQcICgcOC?=
 =?us-ascii?q?gEDBT5kaIFPgXQLNA2CNSkBg2QBAQEDEhEEGQEBNwEPCwsNAgImAgIhARIBB?=
 =?us-ascii?q?QEcBhMihUgDLqFugQQ9izJ/MoEBgggBAQaFEw1ngVwJEn4sAYYQgSeHEiccg?=
 =?us-ascii?q?UlEgUuCRDA+giFCAoR6gmWZIQFhLRylHp0xa4NTgUEMhh6SEIV7M6hMll2Qb?=
 =?us-ascii?q?JYMECOBRQOCCzMaCBsVbAaCMk4BAgECDQECAgMBAgECCQEBAo4dg3KKazcxO?=
 =?us-ascii?q?AIGCwEBAwmRYAEB?=
IronPort-PHdr: A9a23:rwuq1RUD8exIcVXkk7LAsK8+CNLV8KzKXzF92vMcY1JmTK2v8tzYM
 VDF4r011RmVB9+dsqwfwLaH+4nbGkU4qa6bt34DdJEeHzQksu4x2zIaPcieFEfgJ+TrZSFpV
 O5LVVti4m3peRMNQJW2aFLduGC94iAPERvjKwV1Ov71GonPhMiryuy+4ZLebxtWiDanfL9/L
 Ru7oQreu8QSnIBvNrs/xhzVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3Q
 rJEAjsmNXs15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRTiv6
 bpgRQT2gykbKTE27GDXitRxjK1FphKhuwd/yJPQbI2MKfZyYr/RcdYcSGFcXMheSjZBD5uzY
 IsBDeUPPehWoYrgqVUQsRSzHhWsCP/1xzNUmnP6wa833uI8Gg/GxgwgGNcOvWzaotrvKqcSU
 P26x7TJwzXEYfJdxDDw55XSfRA/oPGDQL1wcc3fyEQ0GAPFiVKQqYPhPzyLzOgCr2+b7+95W
 O+plmUopB1/rCK1yccwlonGmJgVylbc+Ch3wIs4JcC1RUx0bNOgEpZdtD2XO5V5TM8/TWxlu
 Dg3x74JtJO6YSQExogqyh3RZfGFcoWF7BDuWfuQLDpmhHxofq+0iRWq8UW41OHwSs253ExJo
 ydFiNXAq24B2h/J5sWIVPdw+Fqq1yyV2ADJ8O5EJFg5larFJJ4lxb49jp8Tvl7CHi/ygUn3g
 qqWelg99uim5OnrfK/qppCbN49zhQH+NrohltajDuQ/NwgCR2mb+eKi273/5UD1XqlGg/ksn
 qTasJ3WP9kXqrC6DgNP3Ysv9Q6zDzK839QZmXkHIkhFeBWCj4XxJl7BOu74DfaijFSjlzdqy
 evLPrLmApXKIXjDlKnucaxh5E5bzQo/1dZf6IlMBbEbPP3zQlPxtMDfDhIhLgC42/znB8ll1
 oMCRWKPBbeUP7/VsVCU+u0vIvKBZJQVuTb4M/gq/eTijX4/mV8HfKmmx4EbaH6iHqcuH0LMR
 HP2idoFFi8xtQo7TfD2wAmHWCRYanK1Gbk35jQ6FJ7/JYjGT4GpxreG2XHoMIdRYzVqA06NH
 T/HcJrMD/sFdiOeLch+ujMDUrelRskq0hT451yy8KZuMueBon5QjpnkztUgorSLzXnalBRxB
 sWZiSSWSn1s23kPTHkw1bx+pkp0zhGC17J5irpWD48b/OtHByE9M5OU1OlmE5bqQAuUct6XS
 VqpRcqODjY2QdY8hdQJZhU1AM2s2yjKxDHiGLoJj/qODZ0w/Ljb2i39Lth8x3nBy4EuiF4pR
 sYJPmqj1eZk7waGIYnPng2CkrqyM6QR2CmY7GCY0W+Hp11VSiZ1WKTBGG8aPw7Y8Y6/6UTFQ
 LujT78gN2Ot0OakLa1HIp3shFRCHrL4PcjGJni2kCG2DAqJwbWFaMzrfX8c1WPTEhpMlQdb5
 nuAOQUkY0Xp62vDEDxjE07uaELw4KF/rn28VEo90wCNaQVoybO0/hcfgfHURekU2/oIvyIoq
 jM8G1jYvZqeB9OepgZue7p0btQ671NKk2nesk01P5CtKbxjmk9Lax5+7Avl0xR6DJkFkNB/9
 it7ilovb/vCgBUdLWD9v9i4ILDcJ2js8Qr6bqfX3guby9OK4uIV7/9+rVz/vQavH05k8nN90
 tAT3WHPg/eCRAcUT5/1VV46shZgoLSPKCU0+YLY2npzGaaztTDG1pQiA+5vmXPCN59PdbiJE
 gP/CZhQC8GwKeAlnEeBYRUDM+RfsqUzOon1P+vD06mtMuF6mTughmkS+4Fx3HWH8C9kQ/LJ1
 ZIIqx2B9jOOTCy0zFKos8St3JtBeSlXBG20jy7tGI9WYKR2O4cNE2anZcOtlJ1ygJvkWngQ8
 1DGZRtO1Ma3eBadaEPV0gpX2kAa53egnGO0wid1nDcgsqeElHaWkqKyKVxeYD4NGDMqhEykO
 YWuitEGQEWkCmph3ACo40r33ekTpahyKXXSXVYdeiH3K294Va7j/rGGYsNJ9NYpqXANCLX6M
 Q3cE+St5UdAgEaBVyNEyTs2di+noMD8lh1+0ieGKWpr6WDecod2zAve49rVQbhQ2CAHTW92k
 2qyZBD0Mt+38NGTj5qGvPq5UjfrWpRNcCXkypyouyy86mlnRxa4mrrg/7+vWRh/yiL929RwA
 G/EpQj9bobsyIy1NuVoekQuD1j5oZkfeMk2gs47g5ce3mIfj5Oe8C8ckGv9Bt5c3Lr3cHsHQ
 TNYi86Q+gXu31dva26Y34+sHGvI2dNvPpPpBwFekjJ49c1BD72YqaBJjTcg6ETtthrfOLB8h
 mtPkqZosS9CxbtV50x1iX/BSrEKQRsGYWq2zE/Oto7m6v0QPTfKE/D41VIiz47/Suja+EcEH
 i6+IM9qHDcsvJshdgiQgTujsse8P4OIJdML6k/LyVGZ064Mech3zr1T1U8FcSr8pSF3lLJ91
 EYzm8n85M/edS1s5P7rW0YIcGSqOIVDvGmq1/8Wn97KjdnwRdM4S2lNBN2wCqv2dVBa/fX/a
 1TUSGx6+irdQOCPW1fYsRgurmqTQcryaTfKdD9AnI8kHF7EdQRemFxGBmxk2MRiR0bxnoq5N
 x4og1JZrkjxrh8Gog5xHz/4VGqX5AKhazNuDYOaMAIT9AZJoUHcLc2Z6Ot3WSBe5Jyo6gKXe
 CSdYExTAGcFV1bhZRirN6Sy5dTG7+mTB/avZ/rIb7KUrOVCVvCOjZux24pi9jyIO42BJH5nR
 /E830NCWzh+FaG7030XTDcLkivWc8OBjBK1+ykyscXmtfq3AkTg4oyAD7YUOtJquli3jaqFK
 ++MlXN5JDJfhfZujTfDzLkS2kJXijk7LWH8V+Rd83eXHOSMwPwybVZTcS54OcpW4rhp2wBMP
 ZSekdbpzvtiifVzDV5ZVFvnk8XvZMoQImj7OkmUYSTDfLmAOzDPxNn6JK2mTrgFxuldqRy8t
 jGEO0DkOTuHmn/iUBXlYoQuxGmLeQdTvo2waEMnEW/4UNfvcQG2KvdyhDwyhKIx3zbEaTRaP
 j97fEdA6LaX6GkL55c3U3wE5X1jI+6eni+f5OSNMZcav8xgBSFsnv5b6nA3o1O0xCRNRfgwh
 y6L69Ay+Reple6AzjchWx1L+G4jbGejskJlNqHUsJJHXCSclPrixWqXDBsOqp1uDdi94sht
IronPort-Data: A9a23:i3OvSqBi87oLBhVW/xblw5YqxClBgxIJ4kV8jS/XYbTApDgm1WAEn
 TRLWGHTM/mNMTHweNl1b9u28B8DscOEm9IwOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YPiWlvU0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYoyeWnM1S9
 Oh8j72TeCouE4STtskTdwYNRkmSPYUekFPGCX22sMjW0EifNnWwmbNhC0Y5OYBe8eFyaY1M3
 aZAeXZdM1ba3bLwnOjTpupE3qzPKOHnNZ0etn5n0hnWCvEpRZ2FSKLPjTNd9G1h35ESQa+DD
 yYfQQtvPC7abD5mBms8As5nlcevm0XlLjIN/Tp5ooJuuzSJpOBr65DmN9Hee/SRVMBNlwCZo
 HjH9iL3GHkn2Me3zDOE9jezg7aKk3+hHo0VE7K8+7hhh1j7KnEv5AM+R0S4vNqFt3+EevFuB
 ks503UAgKYW6xn+JjXiZCGQrHmBtx8aftNfFewm9Q2AopY4BS7JVgDoqRYROLQbWN8KqS8Ci
 gbUzoy3bdB7mPjKEiLNp+r8QSaaYHBNdQc/iTk4oRzpCjUJiL46lgrOSNluCrX9oNTxHSqYL
 9ui9XJj1u17YSIj8aiktWHAmTHEm3QkZgs85wGSQWf8qw0lPsiqYIun7VWd5vFFRGp4crVjl
 Cha8yR9xLpWZX1oqMBraLtUdF1Oz6jcWAAweXY1Q/EcG82FohZPh7x47jBkP1tOOc0ZYzLva
 0K7kVoPuM8NYibyNfcqOtvZ5yEWIU7IRYSNuhf8PoomX3SNXFLvENxGORbAjjm1ziDAb4lmY
 crGKa5A8kr2+Yw+lGbsLwvs+bAswS86yAvuqWPTnnyaPU6lTCfNE98taQPQBshgtf/siFiLr
 r53apTSoz0CAbWWSnSGquY7cAFaRVBlX8yeg5INKYarfFE9cEl/UK+5/F/UU9Y690ijvryYo
 C/Vt44x4AaXuEAr3i3RNCg5Mem/DMsnxZ/5VAR1VWuVN7EYSd7HxM8im1EfJ9HLLcRvkqx5S
 ecrYcKFDqgdQzjL4W1FP5b6q4NmeVKgggfXZ3ipZz02fphBQQ3V+4+7IlG+qnFWVifn59Ejp
 7CA1x/ARcZRTQpVCsuLOumkyEm8vCRAle8rBxnIL9BfdV/C6o9vLyCt3PY7L9tVcUfMwTyV0
 wvQChAd/LGfr4gw+djPpKaFs4b5TLckTxQCRzHWtO/kOzPb82yvxZ57fNyJJT2NBnnp/KiCZ
 PlOy62uOvMwmlsX4ZF3FKxmzP5j6tbi++1awwBjECmZZlinEOk7cHyP3M0KqagUg7EF4025X
 UWA/tQcMrKMYZu3HFkULQsjT+KCyfBExWWIvKpteB33tH1t4b6KcUROJB3Q2iZTG714bdE+y
 uA7tc9KtgGy1kgwPtCdgnwG/miANCZbAaAut5VfH4qyzwR3kBdNZpvTDiKw65aKMo0ePk4vK
 z6SpazDm7UMmRaYIiRrTSDAjbhHmJADmBFW11tedV6HrdzI260s1xpL/DVrEwlYw32rCQ6o1
 rSH6qG0GUmPw9usrM1KXmTpBAQYQRPFoAr+zFwGkGCfRE6tPoAIwKvRJs7VlH31MUoFFtSYw
 F1c4GniVjnucYf62S5atYtNtan4VdIonuHdsJnPIilGdqXWpRLqhaihYWdOoBziaS/0aIsru
 sEylNtNhWbH2eL8bkH150R2FVjddfxcGFF/fA==
IronPort-HdrOrdr: A9a23:yX+Hl6hS7T4/muLPRsTSE98q/nBQXtcji2hC6mlwRA09TyX4rb
 HIoB1/73XJYVkqKRIdcLy7WJVoIkm8yXcW2/hyAV7KZmCP01dAR7sSiLcKrQeQfxEWNdQw6U
 6jScVD4RHLYmSSRPyV3DWF
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,224,1643670000"; 
   d="scan'208";a="29194415"
X-MGA-submission: =?us-ascii?q?MDFCd7BnAyP0DKHZMMA4/jjb2CgcJ15c4RCQAH?=
 =?us-ascii?q?3aUU8uhO7ijuDl+S/yHg99yfrRzFipApMVwSKI0eWyVxI35N+DJ4sSet?=
 =?us-ascii?q?s9F9WcxzzN8EfwE+Jj+dbCBQ4fArZsKTMdh3J+KaD3zuN9AH1jwQzdPa?=
 =?us-ascii?q?vAUyTxi/3qiQyfznkHKQALsw=3D=3D?=
Received: from mail-wm1-f42.google.com ([209.85.128.42])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 04:10:00 +0200
Received: by mail-wm1-f42.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so922529wms.2
        for <cocci@inria.fr>; Wed, 30 Mar 2022 19:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+Y4Clr/KV3RmCQxfUTOx3L8tcl6/qhhWFZStvbs7AE=;
        b=IRNA4dtWN35P6LcruP2XmfFRfHUIeZxTdcIDZkazItppUyO19PVXKrjN6Z2gBpvYX9
         665wkXXe/8yk9G+1anKqrIDJHlX8Qofa7yWrcfbbHB67DcluoZdssOl8ENobi8QpTook
         qBWI9lD01RRhdNDJSeWenT2uFZtge5oqmhFLznMuDBI2q7uuDq/D9eKfakbGsbBcyEcc
         0VGTDUzy44vmSNXKfV5JmVrHwqtuJIBMyCFEJCAWhUmLDMUJedR6dMa989h9EjTJwS5Z
         R3uv/T+QNbGBmvbE3N4d/HawXTHp4k6ASz8e3xe/at7nFPK7ZV1/HUQzwktnoRP1xazv
         MtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+Y4Clr/KV3RmCQxfUTOx3L8tcl6/qhhWFZStvbs7AE=;
        b=LNj0Sh9jk16Vvq9sXTGsRS6uZuKStJFAEY7F4exkSFdXG1VKnexgKb8ZIpEWRYLmHs
         Nf6l8N64z5LYnrq3fXoV2sF0VUNtpYT7gZDZyH59cAvJivEtILVOSqvt+7XwJ8XbF2Oq
         pKo5oTXWe1AcsLZul/3uZoKonSq3w2OCkWoXqfaSfx9VNe5RIfoBQyBjzrVeCoZgW/Sk
         M095zikARddCqexPIogwo6bnBKA1EkcDYAk7XpwbH3pI7DJxDUsWsOi/TrAVHQehXZCn
         3qkU7jRdp7PA+W4ro2O3XKgu0HV/Nm3JHY0TWq95HzJsp/mx9IzwDe4tJ1stcnXklwBr
         o/Pw==
X-Gm-Message-State: AOAM533jq0Zb21StuDww91yl8V75VgySuOuQ6yYCRGBvDs0li1gb8Hff
	71ErH4Gz68oP0Q6gdWwi7ISkjN7smX68BEgeOwVn8A==
X-Google-Smtp-Source: ABdhPJxX9ikYBf74niQggS4KpIrzIpWarfLSBLv4JdiFkCpZEqGhtcFVRLzgm1Hpstkt8udcLZoMEcwgyQ39Z6R2zz0=
X-Received: by 2002:a7b:c541:0:b0:38c:b0ed:31c4 with SMTP id
 j1-20020a7bc541000000b0038cb0ed31c4mr2624910wmk.141.1648692600105; Wed, 30
 Mar 2022 19:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648674305.git.marcelo.schmitt1@gmail.com>
In-Reply-To: <cover.1648674305.git.marcelo.schmitt1@gmail.com>
From: David Gow <davidgow@google.com>
Date: Thu, 31 Mar 2022 10:09:48 +0800
Message-ID: <CABVgOSkQFdGmBZsWqhFifzWAi2+1VOvYy3Q8F_umMa6AV85AQQ@mail.gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Daniel Latypov <dlatypov@google.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	linux-sparse@vger.kernel.org, cocci@inria.fr, smatch@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Dan Carpenter <dan.carpenter@oracle.com>, julia.lawall@inria.fr, 
	Hu Haowen <src.res@email.cn>
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v3 0/2] Add a section for static analysis tools
Reply-To: David Gow <davidgow@google.com>
X-Loop: cocci@inria.fr
X-Sequence: 320
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/CABVgOSkQFdGmBZsWqhFifzWAi2%2B1VOvYy3Q8F_umMa6AV85AQQ%40mail.gmail.com>

On Thu, Mar 31, 2022 at 5:49 AM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Hi all,
>
> This is the third patch version in the direction of complementing the
> testing guide documentation page with information about static analysis
> tools.
>
> Thank you for your suggestions and comments so far.
> These docs wouldn't get so helpful without them.
>
> Change log v2 -> v3:
> - Changed the paragraph about Sparse to make it sound better (hopefully)
> - Minor adjusts to make the considerations about Coccinelle sound better
>   and be precise
>
> Change log v1 -> v2:
> - New patch adding considerations on when to use each tool
> - Brought generic tool characteristics to the intro paragraph
> - Made explicit that these tools run at compile time
> - Added a note of caution about false positives
> - Updated Coccinelle info to make it sound better and be more skimmable
>
>
> Marcelo Schmitt (2):
>   Documentation: dev-tools: Add a section for static analysis tools
>   Documentation: dev-tools: Enhance static analysis section with
>     discussion
>
>  Documentation/dev-tools/testing-overview.rst | 63 ++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>

This is looking pretty good to me: thanks for helping to improve the
documentation!

CCing Hu Haowen as an FYI for the zh_CN translation.

-- David
