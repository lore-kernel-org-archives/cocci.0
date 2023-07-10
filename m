Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCAFEB64DA
	for <cocci@archiver.kernel.org>; Mon, 10 Jul 2023 17:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=reply-to:date:mime-version:message-id:from:to:cc:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cdxQjPxsxT4ZUIAq6MKuRDh+6t1WoZs4Zh6c3B3tQR8=;
  b=GIMw35eEwVg1h6rvrpkJStsoJA0fTMMGt9fRgXKFbNINGP1EtSiRsSMW
   uMWd5cUiHeIxlx75gCdjjZCYoCiSmZsvHawBFMK4plM4TEnro+CI4e0hK
   kbypqVxNK2Eyq+I4DDvN/Jzs3TFYKWU2RUi5bI/P/9JCh34qg4zFME6D8
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@google.com
X-IronPort-AV: E=Sophos;i="6.01,195,1684792800"; 
   d="scan'208";a="116964801"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jul 2023 19:44:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 01BD4E00B7; Mon, 10 Jul 2023 19:44:30 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B6A76E00B6
	for <cocci@sympa.inria.fr>; Mon, 10 Jul 2023 19:07:00 +0200 (CEST)
IronPort-SDR: 64ac3ab3_AgXoZ6xvuY7DIPww1vvA3HhC9Fc20CC1o9ZelSO0QJ56WDr
 Jtptu0002iJmKedZcWnSkkqKL2whBgfJBLOJ0Iw==
X-IPAS-Result: =?us-ascii?q?A0EiAAB6OaxkhsqAVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIydVUxBAtHhFKIHYcagiSYG4QEgVYUgREDGE0BAwENOwkEAQEDB?=
 =?us-ascii?q?IR7AoYjAh0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECE?=
 =?us-ascii?q?AEBAQEgGQcQDieFaA2CNykBEWRQAzUBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QERAg06VxEdAQE3ATQCJgI2AQUBIgESIoJcAYJcAxEGnHaBBUKLOYEygQGCC?=
 =?us-ascii?q?QEBBoJOGK4wgV8DBhKBAy0BhUSCOwGBSoJdV0OCUoIKG4INgRWDaYJiAgKBI?=
 =?us-ascii?q?YQYgmeOJIVZBQIygxaKHoEnb4EeN2d6AgkCET8CDRmBCAhegW8+Ag1UCwtjg?=
 =?us-ascii?q?RyCTgICEToUU18ZGwMHA4EFEC8HBC8mBgkYLyUGUQcXFiQJExVBBHOCYgqBC?=
 =?us-ascii?q?T8OBw4RglYrNjsbTYJqCRcKBDVTWCgQMQQUHXQDCQMHBRsRHTcJAwsYDUsRL?=
 =?us-ascii?q?DUIDBsGJiAHTB0XFzIxgXgkJKJ1Az+CJ0MBgQ0BK1CBLZM/jxKCG6A4hBWIT?=
 =?us-ascii?q?oMvlQQaM6lYAS6HQJA4IItLgXSVU12EHxAjgUA6PIEgcBWCB4EbEzwDGQ+OI?=
 =?us-ascii?q?DeDPYUUiwUkMQIBOAIHCwEBAwmKal4BAQ?=
IronPort-PHdr: A9a23:eKU+DxST29ADGyxiaEBYzOqtTNpsogKXAWYlg6HPa5pwe6iut67vI
 FbYra00ygOTA8OBu7kV1aKW6/mmBTZdp87Z8TgrS99laVwssY0uhQsuAcqIWwXQDcXBSGgEJ
 vlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+I
 A+5oAnPt8Qam5VuJ6U+xhbNo3ZDZuBayX91KV6JkBvw+Me98IR//yhMvv4q6tJNX7j9c6kkQ
 rNUCygrPXoo78PxrxnDSgWP5noYUmoIlxdDHhbI4hLnUJrvqyX2ruVy1jWUMs3wVrA0RC+t7
 7x3Rx/yiScILCA2/WfKgcFtlq1boRahpxtiw47IZYyeKfRzcr/Bcd4cWGFMRdhaWTBfDYygb
 osPF+sBMvher4nhvFsFsB+yCRCxCO/z1jNEg3n71rA43es8CwHLxBYgEdwBv3rTr9v7KaccX
 /6rwabU1jjDc+9a1C3h5IXSbhwso/eBVq9wf8rLzkkvEhvIgEiOpoP/OTOey/oAs2iB7+phT
 uKvl2knqxlxojex3McskY7JhoQIwV3D7iV23pw6Jdu6SEFnetOkH5xQtyaVN4tyXMwuWX1nu
 CE/yrAfv5OwYScFxog9yRHFd/yHb5aH4gjlVOuJPzt2hHZodby/ihuu7ESuyunxWtS03VhFr
 SdIjtjBuH8D2RHd9sWKSudx81mi1DuAyw3e9+VJLEA6mKTUL5MszLg9nYcdv0TEGy/5gkT2j
 KmOe0Un5Oeo8eLnbavippOGMI90kA7+P6IzkcK8GeQ1KhYCU3Sf9Oim17Du/Vf1TKhUgvA1i
 KXVrozWKdodq6WkGQFayJwj5Ay6Dzq+0NQXg30HLFVddRKClYfpOlXOLOn4DPaxnligiTlry
 +7aMrH/GJnNIX/DkLDufbZ59UFQ0hY8zdda555MC7EBJuz8WlPpudDGEhM0Nxa4zuXnBdlny
 48SR2GCDrWHPK/Or1OE/ucvLPONZI8Rtjb9Mf8l5/v2gHI3gl8Tc7Cp3YAUZ32kHPtoJliUb
 2HrjNcfEWcFoxM+TOnkiF2ASz5TfXSyX6U85j0hBoKmF5/DRo63gLyP0ie7GplWZnlbClCID
 HjkbYSEW+oXZSKcJs9ujDMFWaG4R486yx6hrgn6y7h7IebO4SIYso/j1N5p6OLNjhE+7zN0D
 8Oa02GCS2F7gHkESCMx3KB6uUB9zEyM3rBig/NEDdxT++9JUgAiOJLB1+B6Ecz9WhrdfteVT
 1arWsmpATYtQd0twt8DeF19GtWnjhDbxSWmGb4Vl7qRBJw16K3QxXbxJ9wug0rBgYs8i1gvC
 u9GKmSiguYr1RXXBoePt0yGnqKuXaUaxi/EsmmZmy7GmkBTVwp5Su39VHQedgOCq9Xy4UfLV
 Pm2ALAmIiNAzMeNbKVQPI7TgE1CVcvkbe/TamT5sGeqBA2UwauMYZDxfGNViD7QAU4GmCgc+
 nGJMQV4DSCk9THwFjtrQGniakWk2ulkqWinSVc0whuRaEspg6G48xgXjtSTTPQc2r9CsyAk/
 WYnVG2h1s7bXoLT7zFqe79RNJZkuA8vPQPxsgV8OsblNKV+nhsEdA8xuUry1hJxA4EGkM4wr
 XpswhAhYbmA3gZncDWVlYv1JqWRMnP7qQuiYqjU0XnR19GZ/qpJ4/M9+B34pA/8LkM56D181
 sVNlX6V55HEFg0XBMnqfl8sxTFLhJvjRzc965rR2392K6uzsnnMwconHuUrzhK5YtNTdqKZP
 AH2Ht1fQtOjIeookB6jaQ8CN+1JsqEzOMyier2N36v4dP14kmeAimJKqJt4zlrK9yd4TbvQ2
 I0ZxviDwgadfzL1jVPko9+u3I4ePWtUEW24xizpQoVWY8WeZK4tDmGja42yz9R63dv2XmJAs
 USkDBUA0dOofhybaxr82xdR3AIZuy7vnyzw1DFynzwzy8jXlCXT3+TvcgYGMW9XVSFji1nrO
 429k9EdWgChcQEokBKv4UuyybJcoexzKGzaQEEAeCaTTSkqSaa5sLiJS8FI75wsvGNcV+H9K
 VGWR7jhogcLhjv5FjgWzzQ6eje2/5ThykYi2STNcTAq9iqfI5kqlnK9rJTGSPVc3yQLXnx9g
 DjTXB2nOsWxuM+TnNHFu/y/UGSoUttSdzPqxMWOrnjehyUiDBuhkvS0gtCiHxI91HqxjMJGT
 D76hSffSLDOyaS2KOdpfFNyBlj8rcRgAo9knIU0gIgN3XRch4i9834KgSK2KthS36D1KnAKW
 DgAzsWT7w/i10luaHmOwsiqMxfVitskfNS8bm4Mj2gm4slMCqy847tDki945FG/qEiCKeg4l
 TAbx/w07XcciOxcowshwBKWBbUKFFVZNyjh//iRx+i3t74fJGOmcLzqkVF7gcjkFraJ5AdVR
 Hf+fJ4mWy529MR2dlzWgjX/7YTted+Yatx21FXcyAzslvNnAaMSvMMvmyprIGfzv2c/yek7y
 xJ0xZ+gsoaDL3xw+K7/AwNwODn4d4ZW4Tzki6RV2MyRwoakE44nFTIMU5/lC/mvFVdw/bzrO
 h2PHzs1tnqAUeCHTEnPtQE/9SKJScjxf3iMbGEU19BjWAWQKAREjQYYUS97+/xxXgGmycr9c
 VtoszUY51r2sBxJmapjMxjyVHuapR/9MG9lDsjCakMMvkcYvx2GVK7Wpvh+FCxZ4JC7+QmEK
 2jBIh9NEXlMQEuPQVbqIrip49DEtemeHOu3afXUMtDs4aRTUemFwZW3385o5TGJY4/UJVV7F
 M8S62lpZFVnG8jAnjsNUTYVkCKLYdSDqg2y9Clzt927/LLqRSrh4YafTv5JPNxp+Rvwi6CeM
 eWdn2B2LjFX0p5KznjNgut6vhZam2R1ej+hHK5V/3XWYLvLqIZmLDQiTj1zONJN4aAmxAtKO
 YjVkMv7zLB2ivosFlNJE138ss+taNxPZnqwPVXFDwCBM6mALjDQhc7wZqy4RPtbi+Ae5HjS8
 X6LVkTkODqEjTzgURuiZPpNgC+sNxtboIihcxxpBDurXJf8Zxa8KtMykSwuzOh+mCbRLWBFe
 2sZEQsFvviK4ChfmPk6B2FR8i8vM7yfgyjAp+jAdsRN7L0yU3wyzb4Fpix9kecd7TkYFqIp3
 nGJ9Zg3/Qngyq7Wm18FGFJPsmoZ2tzN5B04f/2frt4aAT7F5E5fszvWUUhb4Ys9TIWo4fgYy
 8CTxv2pbm4etYuFp41EQJGETaDPeHs5bUi2RHiNVlZDFXjzcjiBz01FzKPLri3T98dl7Miqw
 N1UE/daTABnT6xBTB00QJpaZs8wB21B8/bTjdZUtyDm/V+BGYMD5MCBDrXLXr3uMGrL1+AaI
 UZYh+qpd8JLcdSqk016NgsgxdqMQRGBG4sX5HUmN15Rwg0F5nF6SidbN1vNTASr7TdTEPe1m
 kRzkQ5ieaE38zyq5V4rJ13MrS92kU8rmNyjjyrDODj2ZLy9W41bEU+W/wA4L4/7TgBpbAazg
 V0sNTHKQKhUhqdhcmYjgRHVuJ9GE/pRBaNeZxpYyfaSbvQumVNSz0fvjVdA/vfAAIB+mRECd
 JetqzdRxFsmYoRtf+rfI61GylUWjaWL/2ep2u033A4CNhMN/WeVK0tq8AQDMrgrITbt//Q5s
 1TT3WsePjFWB7xw+qg5kyF1c/6NxC/hzbNZf0W4NujFaricp3CFj8mDBFU5ykIPkUBBu7lwy
 8YqNUSOBCVNhPOcEQoEMc3aJERbdc1XoTKIZgqXqtfk8LFfBqCjFuzxSOGMrrwWhULiEhwxE
 Z4C4MAFB4So3AfZMO/pKLMVjFA26Q3tJl7DBvNUfhmGi3EIpMawyJIx1o5YbGJ4Yy01IWCs6
 7DbqxV/yuKER8sza2wGU5EsM3s3XIirhHccsS4YVn+41eUWzAXE5Dj57He1bnG0f59oY/GaY
 glpAde99GAk8qS4vlXQ943XO2DwMdkKUj7n7Oobo9OWFKoRQ+Ml6QHTnI5XQ3HsWGnKQ4bdz
 33YZI4rYtj5TH29Vw7n49raZ8n1Mcboa7OFiAfqTsBet5Sd1z04c8C6ET4aFlF7oORRvcpB
IronPort-Data: A9a23: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
 Xg9OcqGLCs=
IronPort-HdrOrdr: A9a23:BwJK0q0loKB5ADVqWoe2kQqjBI0kLtp133Aq2lEZdPWaSL3gqy
 nOpoVi6faQslwssR4b+exoVJPwJk80l6QFhLX5TI3SPzUO0VHAROpfBO3ZogEIcBeOktK1u5
 0QFZSWy+edMbG5t6vHCcWDfOrIuOP3kpxATN2x80tQ
X-Talos-CUID: 9a23:r4R2920UDYDkltgG4gx9sLxfNtkGKFLg6yjpE2DmLn5VSeSSFQOP5/Yx
X-Talos-MUID: 9a23:UVNEuwVHMgK1Y4zq/BPOrgtgDuo12Jm3EWAIkrdWou+JPjMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,195,1684792800"; 
   d="scan'208";a="116962042"
X-MGA-submission: =?us-ascii?q?MDFQ2+Ar3TfxWIaMQms3MaX7Kim/MA8Mmqz6tL?=
 =?us-ascii?q?OnQehq00FLS23qyLDvV4C1jNsD6jQ8u9jz7eTfWi+PfVvis4mrBkpwCG?=
 =?us-ascii?q?j2yz4Rbqj8bV/+RvCBzckgD3YQa2jzTUdV3/goPdfaPM3E9Lor/1EdEN?=
 =?us-ascii?q?F3+vFF/hlTaNKedur5RVTNzg=3D=3D?=
Received: from mail-yw1-f202.google.com ([209.85.128.202])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 19:06:58 +0200
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-579e9b95b86so58714657b3.1
        for <cocci@inria.fr>; Mon, 10 Jul 2023 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689008816; x=1691600816;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdxQjPxsxT4ZUIAq6MKuRDh+6t1WoZs4Zh6c3B3tQR8=;
        b=OFuWj9SV3PmArz6QEQllNHpVHH32v6/TFZ9FJ3PKrmZG0wUO3ReJPL3AgALj1B3fpS
         0geMi7k78DsZi1fS9ToHQaXRSW7J++GxEDXoCB45wd1h/kb1Yd8ZdphJDfm/lQK4iJCb
         5eRTVRSyGP63UOIBxBTW38vXyMWnnGbBu1HQ2h/BUfVC+jAoh8J/q6jpILRL1bQBzEpJ
         2gtbHzh6hIfb7dsd1gyMJosn2SVgBjfyMyKG3bKvrABEQ18ia/hsj2LndzGi+NfW7BJR
         xT3qSyH3c5RxtXswODb7ZAgsAubg+ZZt28VcCk8akEjrwbpPXU+YRm5jRbmFc5utaPCV
         jArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689008816; x=1691600816;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdxQjPxsxT4ZUIAq6MKuRDh+6t1WoZs4Zh6c3B3tQR8=;
        b=BAC6x+WmnrGNO5p4f9C2B+idcojbffNL7EEKZlve6pFKiFbCyO1rUU2FVPj5GjRyKm
         mg0Kx+Ge2K4acluPF24MPK8MYiD5ibmzel4u1JwpvKUpdnv5rYRM6Ay/Rq7B2BWTqIBf
         iAqv4VoxJi+tpV3cioObZyQ3UaHxgan70NexPlQOZ3V5GDRx0B/OEmx/r4BiY57cHGrk
         lQFb8oWbpFcsv0TG73NPwmlTcEAbw89Fi0CECcsoT0bo5LyNx0AMFshs/2NwepTT5HEg
         NOvoYlQs6iTEQdHMKussNKZIGkA8HAeaCs7bwYfZ6ylDDTO8xQMJeUtq8o0QV6uirHga
         sAAA==
X-Gm-Message-State: ABy/qLarxecM56JJpEbmeMga8BNOTgo7U9jeeWDUHMI2WA91XNvilM4w
	bvXL5j0F6cHIA9Vyia1TzO20PmItiNA=
X-Google-Smtp-Source: APBJJlGIxea52O/BNfe71d4id0JtsnykVInVT971JKTz9K81ig6huDPetrDvciuAkgFFhYgCyXcq8TZjtBc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:54b:0:b0:c4e:27df:1a0f with SMTP id
 r11-20020a5b054b000000b00c4e27df1a0fmr98387ybp.13.1689008816742; Mon, 10 Jul
 2023 10:06:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Jul 2023 10:06:52 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230710170652.473788-1-seanjc@google.com>
From: Sean Christopherson <seanjc@google.com>
To: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
Cc: linux-kernel@vger.kernel.org, cocci@inria.fr, 
	Paolo Bonzini <pbonzini@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] Revert "debugfs, coccinelle: check for obsolete
 DEFINE_SIMPLE_ATTRIBUTE() usage"
X-Loop: cocci@inria.fr
X-Sequence: 1213
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-07/20230710170652.473788-1-seanjc%40google.com>

Remove coccinelle's recommendation to use DEFINE_SIMPLE_ATTRIBUTE()
instead of DEFINE_SIMPLE_ATTRIBUTE().  Regardless of whether or not the
"significant overhead" incurred by debugfs_create_file() is actually
meaningful, warnings from the script have led to a rash of low-quality
patches that have sowed confusion and consumed maintainer time for little
to no benefit.  There have been no less than four attempts to "fix" KVM,
and a quick search on lore shows that KVM is not alone.

This reverts commit 5103068eaca290f890a30aae70085fac44cecaf6.

Link: https://lore.kernel.org/all/87tu2nbnz3.fsf@mpe.ellerman.id.au
Link: https://lore.kernel.org/all/c0b98151-16b6-6d8f-1765-0f7d46682d60@redhat.com
Link: https://lkml.kernel.org/r/20230706072954.4881-1-duminjie%40vivo.com
Link: https://lore.kernel.org/all/Y2FsbufV00jbyF0B@google.com
Link: https://lore.kernel.org/all/Y2ENJJ1YiSg5oHiy@orome
Link: https://lore.kernel.org/all/7560b350e7b23786ce712118a9a504356ff1cca4.camel@kernel.org
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../api/debugfs/debugfs_simple_attr.cocci     | 68 -------------------
 1 file changed, 68 deletions(-)
 delete mode 100644 scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci

diff --git a/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci b/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
deleted file mode 100644
index 7c312310547c..000000000000
--- a/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
+++ /dev/null
@@ -1,68 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/// Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
-/// for debugfs files.
-///
-//# Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
-//# imposes some significant overhead as compared to
-//# DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().
-//
-// Copyright (C): 2016 Nicolai Stange
-// Options: --no-includes
-//
-
-virtual context
-virtual patch
-virtual org
-virtual report
-
-@dsa@
-declarer name DEFINE_SIMPLE_ATTRIBUTE;
-identifier dsa_fops;
-expression dsa_get, dsa_set, dsa_fmt;
-position p;
-@@
-DEFINE_SIMPLE_ATTRIBUTE@p(dsa_fops, dsa_get, dsa_set, dsa_fmt);
-
-@dcf@
-expression name, mode, parent, data;
-identifier dsa.dsa_fops;
-@@
-debugfs_create_file(name, mode, parent, data, &dsa_fops)
-
-
-@context_dsa depends on context && dcf@
-declarer name DEFINE_DEBUGFS_ATTRIBUTE;
-identifier dsa.dsa_fops;
-expression dsa.dsa_get, dsa.dsa_set, dsa.dsa_fmt;
-@@
-* DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
-
-
-@patch_dcf depends on patch expression@
-expression name, mode, parent, data;
-identifier dsa.dsa_fops;
-@@
-- debugfs_create_file(name, mode, parent, data, &dsa_fops)
-+ debugfs_create_file_unsafe(name, mode, parent, data, &dsa_fops)
-
-@patch_dsa depends on patch_dcf && patch@
-identifier dsa.dsa_fops;
-expression dsa.dsa_get, dsa.dsa_set, dsa.dsa_fmt;
-@@
-- DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
-+ DEFINE_DEBUGFS_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
-
-
-@script:python depends on org && dcf@
-fops << dsa.dsa_fops;
-p << dsa.p;
-@@
-msg="%s should be defined with DEFINE_DEBUGFS_ATTRIBUTE" % (fops)
-coccilib.org.print_todo(p[0], msg)
-
-@script:python depends on report && dcf@
-fops << dsa.dsa_fops;
-p << dsa.p;
-@@
-msg="WARNING: %s should be defined with DEFINE_DEBUGFS_ATTRIBUTE" % (fops)
-coccilib.report.print_report(p[0], msg)

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.41.0.255.g8b1d071c50-goog

