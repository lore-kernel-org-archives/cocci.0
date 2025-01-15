Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491C1C0218B
	for <cocci@archiver.kernel.org>; Fri, 17 Jan 2025 09:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=9b08T9kkUGxxdtLT2d/2QCfwETLMW4PUfxNyeoe2Bm4=;
  b=EyxGjoOrcNkHRVtdExmF1mUC4U1wkvaBSam76oRDoUmGDnepUVfVOrcH
   LtJ8t0Pvkx7d+m6F/gbRK3Gx/KBoyd4DeVUZdSDGgeyXm7IgV32LBDXoF
   b0TDAnNphOUcoqHjS0GSYpPwC5jhOcimqfwOi05iF9TgMJlgJVb9IeDyE
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.13,211,1732575600"; 
   d="scan'208,217";a="203646339"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Jan 2025 10:48:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 59921E0D21; Fri, 17 Jan 2025 10:48:57 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C5E72E0077
	for <cocci@sympa.inria.fr>; Wed, 15 Jan 2025 17:45:52 +0100 (CET)
IronPort-SDR: 6787e640_wqg3pMNQzsSnPiu/L/e8z3zG8XgzbpdKKkJrAJ35rKstPDt
 VR+z9Nm5Hp2e6MSzY7YKvoufViBiv35UliKq48w==
X-IPAS-Result: =?us-ascii?q?A0E5AQD25Idng3yFCqpaHQEBAQEJARIBBQUBggIFAQsBA?=
 =?us-ascii?q?YJCggoEC0iEVoEjjiuCIQOLc4tPiFQPAQMBCwEBRAQBAQMEhQACinQCHgcBB?=
 =?us-ascii?q?DMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBASAZBw47h?=
 =?us-ascii?q?XsNSQEQAYIHAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg19AQEBAQIBEhEEG?=
 =?us-ascii?q?QEBNwEECwkCCw0qAgIhEgEFARwGEyKCX4JCIwOYGo5RAW6BBUKKQwEBAXh/M?=
 =?us-ascii?q?4EBggwBAQbcH4FkCRSBNAGITQGBXAIOh3x6JxuBSUSBSoJ1PoFShkyCaYI2S?=
 =?us-ascii?q?3ougllnhlSDIYh6i28mJgMHBw4NHkkOASEDJjMsAVUTFwsHBYEpSAECAYETJ?=
 =?us-ascii?q?YEmBTVBOQGCDGlJNwINAjWCHnyCK4IhgjuCGIIvR4QMhWKCFIFlAwMWEAGBc?=
 =?us-ascii?q?4E1dx1AAwtiCz03FBtMmzsBaDyDcAJ6DgUBGycJglqPFpV0oQOEJaFgM6pTm?=
 =?us-ascii?q?HyjaoUZAgoHBhEjgVokgVxNIxU7MQaCME8DGQ+OIRmDYcAgJTU8AgcBCgEBA?=
 =?us-ascii?q?wmNYoJGgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:6zvMna0A/StsSOAttvbD5Zd6kn2cJEfYwER7XKvMYLTBsI5bp2BRn
 TQdWDrTa/+Ia2LxL4snPNjg8x8HsZHSyNE3TlBr3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOHNIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn8gFaYDkpOs/je8Eo24ayp0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJW3TS7dRkV2wIAbYJ0MpdIj5I2
 MA+DhlYO3hvh8ruqF66YvR3w98mMNGuMI4bu29t1yCcVKx6B5XCRqjB7MREmjw3g6iiH96HO
 JJfMGIpNU+bJUQVZj/7C7pm9AusrnDkaTxGoU6OjbA672ja0Ep6172F3N/9IITRHpwPzhnIz
 o7A10P6Cx0nOdu48iaiqluXod7PhR76fp1HQdVU8dYx3QTCmTxCYPEMbnOwpvKyi2alStdHI
 goV/DAvpO487iSWosLVQgb9u3uYplsQVt5RDeAg+UTUkPaS5gecC2MNVSIHY9sj3CMredA0/
 lC3sfLjXhFRjIaEY1631eiSgA+UHwFAeAfuehQ4ZQcC5tDipqQ6gRTOUstvHcaJYjvdRm+YL
 9ei83VWulkDsfPnwZlX6rwuvt5BjoXSCxUw+h2SUm+h7x10fp/gPtb0r13a6PtLJZ2FCFKGu
 RDoevRyDsheUPlhdwTUEY3h+Y1FAd7Ya1UwZnYyRvEcG8yFoSLLQGypyGgWyL1VGsgFYyT1R
 0TYpBlc4pReVFPzMvQpM9LuUpxxlPGwfTgAahwyRoUVCnSWXFDelByCmWbLt4wQuBF2y/FvU
 XtlWZ/3ViZy5VtbIMqeHLpEgOB7l0jSNEvWRJX2xB28zfKYY2SJSf8MNVaUb+swpKKCq23oH
 yV3aKO3J+FkeLSmOEH/qNZNRXhTdCRTLc6t8KR/KLXcSjeK7Ul6Upc9N5t6ItQ9x8y4V47go
 hmAZ6Ov4ACl3yWbcF/bOiwLhXGGdc8XkE/X9BcEZT6As0XPq671hEvGX8JvJOl1x/8p1vNuU
 fgOduOJB/kFGHyN+C0QYdO55MZufQiiz1DGdSe0QikNT7g5TSzw+/jgYlTO8gsKBXGJrscQm
 eCr+T7aZpshfD5cKvjqRsih9H6PmEQMuflTWhLIK+ZDeU+3/4lNLTfwv8ANIMoNCEviwAWI8
 zawHRs4jPX/jLEu+en7gauCrJuML8omOk8DB2Pk07SHBQ+C2m+F34V7cf2peArFXzje45SSZ
 uRyztD9PsYYnV1MjZFOLrZzwY865Prtv7V/zDk4OFn6NXKAFaFFDkid+MtApIlh5+R+h1Ote
 0St/tJ6B+24CPn9GgRMGDt/P/Wx6/4EvxLzs9EnK1rezw1q9uOlVU5yAUG9uBZFJuEoDLJ/k
 PYTg+9I2QmRkRFwD82niBpT/GGyLnAtdaUrm5UZIY3zgDoQ1VBwTs3AOxDy/a2wRY1AAmsyL
 h+QoZjytbBW607BUng0TFzm/+5Wg7YQsxFrkn4GAXm0meT+u/xm5y0JrAwLTTlUwC5XjMN1G
 GxgbHNuKYu0ojxHuclkXkKXIT9nOiG3wELK5mEypDXrdHXwDm3pB08hCNmJ53Ecoj59fCAE3
 bS2y1TFcDfNfePg7BQIXn9VkuHSF41t1wzdmfKIG9aOMIk6bAHE3I6vRzssgDn2DfwhgHboo
 bFRw99xTqngbwgCjrYeCbTG5Y8PSRuBGnNOccth8IwNA2vYXjO4ghqKFGycZeJPIKbs3XKjK
 skzOP9KaQuy5ByOoh8fG6QIBb1+x9wtxdgaf4LUNXw0iKSeohVpoaDv2HDH3kFzeOpXkOE5N
 o/1XBCBGDbJhXJrxkn8nPMdMW+8OdQ5dAnw2d6uy9owFrUBjfpNdH8j2b7lrlSXNwpapyivh
 j3hXJOP7eJeytVLpbDOQ4FjHAS/LO3hWNuYqD6Tt8t8VvKREMPsmT5MlHzZEVV4Ab8jVe5zt
 4yxi//s/UacvL8JQ2HTwJaAMK9S5PSNZulcM+OpDX94mRmtWM/gyEYB8TrgKLhistBU1u+4T
 SSWNeqyct80XY9G5Xt3MiJxLTcUO57VXIzB+xyvnq+pMQcM9zDHIPeM127bXUsCegAmY5TBW
 xLJ4dCw7dVmnaFwLR4jBcA+JaRnIVXmCJAUR/eouRa2VmCX006/4J38nh8d6BbOOHmOMOD+x
 bnnHhHeVhCDiJvk/eFjkb5Zn0MoVS5moOwKYEgi1cZ8iGm6AE44PO0tC8g6Ja8OoBPi9qPTR
 W/rV3QjOxXfTD4fUBTb4fbfZCm9KNEKGO/EIm0OwxvJRQawXY+OOe40vGMoqXJ7YSDqw+ybO
 MkTsC+4dAS4xpZyA/0f/LqniONg3enX3W8M5Vu7qcHpHhICGv8f4RSNxuaWufDvSKkhVXknJ
 FTZgUhZWwSgTFLpVMptf39LFQsI+Wq1k3MtbCKCy9/Ep8OQy+goJDgT/Q3s+uVrUSjIDOdmq
 bDLq6+l+W2a2nUP/6AuvrrFRIdqXOmTEJHSwLDLHGUvcmLZ1ojjF9kPkSoGUIcp/ws3/5YxU
 NWzyyBWOXlp43y9FFFbJcvlNn6xvr8x4+n1sTPC
IronPort-HdrOrdr: A9a23:SPcIHquVAubBZLWXSqv2wq437skD+dV00zEX/kB9WHVpmwKj5r
 +TdZUgpGzJYVMqM03I9urwQJVoLUmsjKKdpLNhW4tKPzOW3FdATrsSl7cKqgeIc0eQygce79
 YGT0EUMqyMMbEVt7eH3CCIV/glhPaK+L21nuvFpk0dNj1CWuVP60NWBG+gcnGehzMmOXP6Lv
 ShDwZ81lidkdl9VKmGL0hAe+jGq9fCjo+jRTEtQzYIxk2voFqThILSIly93hMTWTtU3PMH3k
 KAqjfezOGCnpiAu27hP+i51eUnpDM0oeEzevBkQ/JlSUSItjqV
X-Talos-CUID: =?us-ascii?q?9a23=3AG57rVWqf1Ofjk1l4rwQwWhrmUc8bXFzXl1ruH3S?=
 =?us-ascii?q?pI0pDa+KTZGO23ooxxg=3D=3D?=
X-Talos-MUID: 9a23:J645cwbHZmTxNOBTkDzliAxvM+BT/4P2IXsqoJUehsiiKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,206,1732575600"; 
   d="scan'208,217";a="203312878"
X-MGA-submission: =?us-ascii?q?MDHE0ea3r6ycQtKtpBfp5MFISJWUsmzBIp/Rqw?=
 =?us-ascii?q?H8aLLDtNCFS2Fxopt8GlctbEU8WtWRt3kv0Q+7SneE3hPhE68x8z1Le6?=
 =?us-ascii?q?qA4JJzgYlUOLQSaSfXiXBGJ1fSUQVo/oVY70MlZFdGT7HfSAYYBlgEIN?=
 =?us-ascii?q?lwiQEZWtcVpIV2CoBPLF3Qkg=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 17:45:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736959550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9b08T9kkUGxxdtLT2d/2QCfwETLMW4PUfxNyeoe2Bm4=;
	b=atQ6AeLZcwXwmQghM2BXX+Sx7+0o/U6uS6ARMp6GMVMHpQYo4ReiFLkEJnoEk4k6OFd1of
	VTN+c9hO/TN8EH9DYyvSBJKUwxlH8mut5zyHbm7hyKIjItfw68sT+ps2Nq8Zf4hpX1vLaF
	eO/QLZXbwr9gznfilGyRezM6mI2mJXA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-ytMrxy9rMDWKKxQtTi_4xw-1; Wed, 15 Jan 2025 11:45:48 -0500
X-MC-Unique: ytMrxy9rMDWKKxQtTi_4xw-1
X-Mimecast-MFC-AGG-ID: ytMrxy9rMDWKKxQtTi_4xw
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e549e7072fbso13110407276.2
        for <cocci@inria.fr>; Wed, 15 Jan 2025 08:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736959547; x=1737564347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9b08T9kkUGxxdtLT2d/2QCfwETLMW4PUfxNyeoe2Bm4=;
        b=e7jNs+4abahcEcdSXACr71F07S3s54X8/xH974OJfne0NAQFWPrI/tQ/dFIhMhHRk8
         uhKT4EyjIv0uFzIUNP4tFUSu5ywglb0wt4vpcIZcPIEUpCVfh7cycjDoW4wXFwRP0Rqk
         otsX+SBL6alYtV/iNTKc6jhKUe+CuQsFGI6uFBi5oAmJlEYuRQDvhGgi4y4wIEgOdzCF
         iNEW0LXaWxYCH9svmk8bglQuuVKkx5cHPTH4VYPMji45CD9q9dvMgMPfsJvrUjNOn0Yk
         /iysMFD5keOSgh4ccLj2vQrk2htn1w3A1NUP15mKhwtdiuHO7zysnaH5Cdb9u4h+NhPm
         I0Iw==
X-Gm-Message-State: AOJu0YwdGvwCypPNz/bOuuKyaSP3fbQRwwavixiJDhD7H2glzmg3zrF6
	C4goZJ3IRfJ0UdZJlq4tU4vHq/DWhyQ2/h0AVSS8yZ1DHm0XL0M2p/GbWKtAmRFTgOy2Aat0xfq
	4TciKAnm8UteRvh3hcGnYULsEdCGbPEJxRColO736NetlkLMOrmZF94RfuPbtY+N1pouL1bvnKM
	9K/StkaRH8aHDT+izmnzPRapwVphcI
X-Gm-Gg: ASbGnct2flmn4LuO9wpHrWBLzVDK5POzKISWjxWe/EWaqzRMDrn/lrLrGxo/C0y+WP7
	b+NQwn049HNpxQlZd+L96XowLnYXDsc01X7SM
X-Received: by 2002:a05:6902:2d06:b0:e2b:dbe5:851d with SMTP id 3f1490d57ef6-e54ee17fe5bmr20689827276.28.1736959547388;
        Wed, 15 Jan 2025 08:45:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbb4fBtqHTB9Z/nspMLxK8B0vi8cNR7+vmgCPqC8245mLVMtGOqAcrfAb7jYx6FC3w7MTQJp+FWsndnlFvy+I=
X-Received: by 2002:a05:6902:2d06:b0:e2b:dbe5:851d with SMTP id
 3f1490d57ef6-e54ee17fe5bmr20689789276.28.1736959547058; Wed, 15 Jan 2025
 08:45:47 -0800 (PST)
MIME-Version: 1.0
References: <CAN9Xe3T2LjcD9Xr8vAGQWu5MUvVjr-eEaMhB-JauL5DW0aA9QQ@mail.gmail.com>
 <dcaf63e4-78bf-3111-8494-6380e6118fd8@inria.fr> <CAN9Xe3TBb2GYNeqL1f1_GTPT2W5J78gniK0ZTZJyLwJL=KydoQ@mail.gmail.com>
 <fbdc13e1-d713-c4c0-35f0-f6a1de5a9e9@inria.fr> <CAN9Xe3Q99urpL68p8RxXta1xzHE6PCnfL7S3XktuLUK7KhMCXg@mail.gmail.com>
 <alpine.DEB.2.22.394.2501142337100.3510@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2501142337100.3510@hadrien>
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Wed, 15 Jan 2025 10:44:13 -0500
X-Gm-Features: AbW1kvZdIL9AyTKHL-mxZVKAW-JylDHMXaoGOMB1Hnyv7isJp0yMycRaZzp63pM
Message-ID: <CAN9Xe3TTjm3+J-TaKQv75Kbw_godfBxci-hV3MS0rh0y0jFD0w@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, Maxime Ripard <mripard@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 68115wKCgkOo9HpkDzmuE3ZnAI-MTvX9Bt-9l8t4OdE_1736959547
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000cae21c062bc16817"
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] Ellipses usage in line addition
Reply-To: Anusha Srivatsa <asrivats@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 2213
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/CAN9Xe3TTjm3%2BJ-TaKQv75Kbw_godfBxci-hV3MS0rh0y0jFD0w%40mail.gmail.com>

--000000000000cae21c062bc16817
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 5:37=E2=80=AFPM Julia Lawall <julia.lawall@inria.fr=
> wrote:

>
>
> On Tue, 14 Jan 2025, Anusha Srivatsa wrote:
>
> >
> >
> > On Tue, Jan 14, 2025 at 1:39=E2=80=AFPM Julia Lawall <julia.lawall@inri=
a.fr>
> wrote:
> >
> >
> >       On Tue, 14 Jan 2025, Anusha Srivatsa wrote:
> >
> >       > Julai, Thanks for the response. More info inline.
> >       >
> >       > On Tue, Jan 14, 2025 at 12:50=E2=80=AFPM Julia Lawall <
> julia.lawall@inria.fr> wrote:
> >       >
> >       >
> >       >       On Tue, 14 Jan 2025, Anusha Srivatsa wrote:
> >       >
> >       >       > Hi all,
> >       >       > Wanted to know if ellipses usage is not allowed in the
> lines that we want to add in the code. To be more precise,I want to repla=
ce
> mipi_dsi_generic_write_seq() usage with
> >       >       mipi_dsi_generic_write_seq_multi() .
> >       >       > the coccinelle semantic patch that I am using is:
> >       >       > //rule_1
> ->s/mipi_dsi_generic_write_seq/mipi_dsi_generic_write_seq_multi
> >       >       > @@
> >       >       > identifier dsi_var,dsi_device;
> >       >       > @@
> >       >       > struct mipi_dsi_device *dsi_var =3D dsi_device;
> >       >       > +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D
> dsi_var };
> >       >       > ...
> >       >       > -mipi_dsi_dcs_write_seq(dsi_var,...);
> >       >       > +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
> >       >       >
> >       >       > this throws:
> >       >       > init_defs_builtins: /usr/lib64/coccinelle/standard.h
> >       >       > lexical error: invalid in a + context: ...
> >       >       >   File "mipi.cocci", line 9, column 39, charpos =3D 298
> >       >       >   around =3D '...',
> >       >       >   whole content =3D
> +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
> >       >       >
> >       >       > Just commenting out the function replacing the snippet
> (i.e having only dsi_ctx being populated) works just fine. But the intend=
ed
> change is ofc the proper usage of the _multi API.
> >       >       >
> >       >       > Would be nice to know what is going wrong with this
> approach.
> >       >
> >       >       Add a metavariable declaration like:
> >       >
> >       >       expression list es;
> >       >
> >       >       And then your change can be:
> >       >
> >       >       -mipi_dsi_dcs_write_seq(dsi_var,es);
> >       >       +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
> >       >
> >       > This doesnt find any match ....skips through all files.
> >       >
> >       >       Another approach is to write:
> >       >
> >       >       -mipi_dsi_dcs_write_seq(dsi_var,
> >       >       +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,
> >       >          ...);
> >       >
> >       >
> >       > This again throws the error : init_defs_builtins:
> /usr/lib64/coccinelle/standard.h
> >       > lexical error: invalid in a + context: ...
> >       >   File "mipi_julia.cocci", line 8, column 39, charpos =3D 220
> >       >   around =3D '...',
> >       >   whole content =3D +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...)=
;
> >
> >       I'll have to check on this.  It all looks fine to me.
> >
> >       >
> >       >
> >       >       Another issue is that you may have many calls to
> mipi_dsi_dcs_write_seq,
> >       >       or taht some code paths might not contain such a call.
> You probably just
> >       >       want to make such a change whereever it occurs.  So you
> can write:
> >       >
> >       > Correct. Somehow the below approach : <...P...> ends up matchin=
g
> all mipi_dsi_device *dsi_var declaration and adds a mipi_dsi_multi_ctx
> declaration regardless of mipi_dsi_dcs_write_seq() being used ...
> >
> >       Ah, good point.  Just change <... ...> to <+... ...+>.
> >
> > Tried that. Results below.
> >
> > Code:
> >
> > @@
> >
> > identifier dsi_var,dsi_device;
> >
> > @@
> >
> > struct mipi_dsi_device *dsi_var =3D dsi_device;
> >
> > +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> >
> > <...
> >
> > -mipi_dsi_dcs_write_seq(dsi_var,...);
> >
> > +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
> >
> > ...>
> >
> >
> > Output:
> >
> > spatch mipi_expt.cocci --dir ~/linux/drivers/gpu/drm/
> >
> > init_defs_builtins: /usr/lib64/coccinelle/standard.h
> >
> > lexical error: invalid in a + context: ...
> >
> >   File "mipi_expt.cocci", line 8, column 39, charpos =3D 226
> >
> >   around =3D '...',
> >
> >   whole content =3D +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
> >
> >
> > Code:
> >
> > @@
> >
> > identifier dsi_var,dsi_device;
> >
> > @@
> >
> > struct mipi_dsi_device *dsi_var =3D dsi_device;
> >
> > +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> >
> > <+...
> >
> > -mipi_dsi_dcs_write_seq(dsi_var,...);
> >
> > +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
> >
> > ...+>
> >
> >
> > Output:
> >
> > spatch mipi_expt.cocci --dir ~/linux/drivers/gpu/drm/
> >
> > init_defs_builtins: /usr/lib64/coccinelle/standard.h
> >
> > lexical error: invalid in a + context: ...
> >
> >   File "mipi_expt.cocci", line 8, column 39, charpos =3D 227
> >
> >   around =3D '...',
> >
> >   whole content =3D +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
> >
> >
> > Code:
> >
> > @@
> >
> > identifier dsi_var,dsi_device;
> >
> > expression list es;
> >
> > @@
> >
> > struct mipi_dsi_device *dsi_var =3D dsi_device;
> >
> > +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> >
> > <+...
> >
> > -mipi_dsi_dcs_write_seq(dsi_var,es);
> >
> > +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
> >
> > ...+>
>
> This one looks fine.  Do you have a C file on which you expect it to do
> something?
>
> inside drivers/gpu/drm/
panel/panel-visionox-r66451.c
panel/panel-samsung-s6e88a0-ams452ef01.c
panel/panel-xinpeng-xpp055c272.c
panel/panel-sharp-ls060t1sx01.c
panel/panel-samsung-sofef00.c
panel/panel-sony-td4353-jdi.c

Anusha

> julia
>
> >
> > Output:
> >
> > Skipping=E2=80=A6..
> >
> >
> > Feel like  I am missing something fundamental ...
> >
> > Regards,
> > Anusha
> >       >
> >       > For the lexical error, should spatch be run with  some headers
> that I am notexplicitly adding? I wonder if I am running with wrong optio=
ns
> instead of the semantic patch needing a tweak.
> >
> >       I don't think so. Spatch doesn't care much about header files.
> >
> >       julia
> >
> >       >       @@
> >       >       identifier dsi_var,dsi_device;
> >       >       @@
> >       >       struct mipi_dsi_device *dsi_var =3D dsi_device;
> >       >       +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi=
_var
> };
> >       >       <...
> >       >       -mipi_dsi_dcs_write_seq(dsi_var,...);
> >       >       +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
> >       >       ...>
> >       >
> >       >       The <... P ...> notation is like ... but it makes the
> change whereever the
> >       >       pattern P occurs.
> >       >
> >       > Yes. spatch however disregarding the pattern ....not sure why
> >       >
> >       > Regards,
> >       > Anusha
> >       >       julia
> >       >
> >       >
> >       >
> >
> >
> >

--000000000000cae21c062bc16817
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 14,=
 2025 at 5:37=E2=80=AFPM Julia Lawall &lt;<a href=3D"mailto:julia.lawall@in=
ria.fr">julia.lawall@inria.fr</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><br>
<br>
On Tue, 14 Jan 2025, Anusha Srivatsa wrote:<br>
<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Jan 14, 2025 at 1:39=E2=80=AFPM Julia Lawall &lt;<a href=3D"ma=
ilto:julia.lawall@inria.fr" target=3D"_blank">julia.lawall@inria.fr</a>&gt;=
 wrote:<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0On Tue, 14 Jan 2025, Anusha Srivatsa wrote:<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Julai, Thanks for the response. More in=
fo inline.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; On Tue, Jan 14, 2025 at 12:50=E2=80=AFP=
M Julia Lawall &lt;<a href=3D"mailto:julia.lawall@inria.fr" target=3D"_blan=
k">julia.lawall@inria.fr</a>&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0On Tue, 14 Ja=
n 2025, Anusha Srivatsa wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Hi all,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Wanted t=
o know if ellipses usage is not allowed in the lines that we want to add in=
 the code. To be more precise,I want to replace mipi_dsi_generic_write_seq(=
) usage with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mipi_dsi_gene=
ric_write_seq_multi() .<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; the cocc=
inelle semantic patch that I am using is:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; //rule_1=
 -&gt;s/mipi_dsi_generic_write_seq/mipi_dsi_generic_write_seq_multi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; identifi=
er dsi_var,dsi_device;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; struct m=
ipi_dsi_device *dsi_var =3D dsi_device;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; +struct =
mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; ...<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; -mipi_ds=
i_dcs_write_seq(dsi_var,...);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; +mipi_ds=
i_dcs_write_seq_multi(&amp;dsi_ctx,...);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; this thr=
ows:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; init_def=
s_builtins: /usr/lib64/coccinelle/standard.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; lexical =
error: invalid in a + context: ...<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 F=
ile &quot;mipi.cocci&quot;, line 9, column 39, charpos =3D 298<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 a=
round =3D &#39;...&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 w=
hole content =3D +mipi_dsi_dcs_write_seq_multi(&amp;dsi_ctx,...);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Just com=
menting out the function replacing the snippet (i.e having only dsi_ctx bei=
ng populated) works just fine. But the intended change is ofc the proper us=
age of the _multi API.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Would be=
 nice to know what is going wrong with this approach.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Add a metavar=
iable declaration like:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0expression li=
st es;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0And then your=
 change can be:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-mipi_dsi_dcs=
_write_seq(dsi_var,es);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+mipi_dsi_dcs=
_write_seq_multi(&amp;dsi_ctx,es);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; This doesnt find any match ....skips th=
rough all files.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Another appro=
ach is to write:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-mipi_dsi_dcs=
_write_seq(dsi_var,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+mipi_dsi_dcs=
_write_seq_multi(&amp;dsi_ctx,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=
...);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; This again throws the error : init_defs=
_builtins: /usr/lib64/coccinelle/standard.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; lexical error: invalid in a + context: =
...<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 File &quot;mipi_julia.cocci&quot=
;, line 8, column 39, charpos =3D 220<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 around =3D &#39;...&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 whole content =3D +mipi_dsi_dcs_=
write_seq_multi(&amp;dsi_ctx,...);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0I&#39;ll have to check on this.=C2=A0 It all=
 looks fine to me.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Another issue=
 is that you may have many calls to mipi_dsi_dcs_write_seq,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0or taht some =
code paths might not contain such a call.=C2=A0 You probably just<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0want to make =
such a change whereever it occurs.=C2=A0 So you can write:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Correct. Somehow the below approach : &=
lt;...P...&gt; ends up matching all mipi_dsi_device *dsi_var declaration an=
d adds a mipi_dsi_multi_ctx declaration regardless of mipi_dsi_dcs_write_se=
q() being used ...<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Ah, good point.=C2=A0 Just change &lt;... ..=
.&gt; to &lt;+... ...+&gt;.<br>
&gt;<br>
&gt; Tried that. Results below.<br>
&gt;<br>
&gt; Code:<br>
&gt;<br>
&gt; @@<br>
&gt;<br>
&gt; identifier dsi_var,dsi_device;<br>
&gt;<br>
&gt; @@<br>
&gt;<br>
&gt; struct mipi_dsi_device *dsi_var =3D dsi_device;<br>
&gt;<br>
&gt; +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };<br>
&gt;<br>
&gt; &lt;...<br>
&gt;<br>
&gt; -mipi_dsi_dcs_write_seq(dsi_var,...);<br>
&gt;<br>
&gt; +mipi_dsi_dcs_write_seq_multi(&amp;dsi_ctx,...);<br>
&gt;<br>
&gt; ...&gt;<br>
&gt;<br>
&gt;<br>
&gt; Output:<br>
&gt;<br>
&gt; spatch mipi_expt.cocci --dir ~/linux/drivers/gpu/drm/<br>
&gt;<br>
&gt; init_defs_builtins: /usr/lib64/coccinelle/standard.h<br>
&gt;<br>
&gt; lexical error: invalid in a + context: ...<br>
&gt;<br>
&gt; =C2=A0=C2=A0File &quot;mipi_expt.cocci&quot;, line 8, column 39, charp=
os =3D 226<br>
&gt;<br>
&gt; =C2=A0=C2=A0around =3D &#39;...&#39;,<br>
&gt;<br>
&gt; =C2=A0=C2=A0whole content =3D +mipi_dsi_dcs_write_seq_multi(&amp;dsi_c=
tx,...);<br>
&gt;<br>
&gt;<br>
&gt; Code:<br>
&gt;<br>
&gt; @@<br>
&gt;<br>
&gt; identifier dsi_var,dsi_device;<br>
&gt;<br>
&gt; @@<br>
&gt;<br>
&gt; struct mipi_dsi_device *dsi_var =3D dsi_device;<br>
&gt;<br>
&gt; +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };<br>
&gt;<br>
&gt; &lt;+...<br>
&gt;<br>
&gt; -mipi_dsi_dcs_write_seq(dsi_var,...);<br>
&gt;<br>
&gt; +mipi_dsi_dcs_write_seq_multi(&amp;dsi_ctx,...);<br>
&gt;<br>
&gt; ...+&gt;<br>
&gt;<br>
&gt;<br>
&gt; Output:<br>
&gt;<br>
&gt; spatch mipi_expt.cocci --dir ~/linux/drivers/gpu/drm/<br>
&gt;<br>
&gt; init_defs_builtins: /usr/lib64/coccinelle/standard.h<br>
&gt;<br>
&gt; lexical error: invalid in a + context: ...<br>
&gt;<br>
&gt; =C2=A0=C2=A0File &quot;mipi_expt.cocci&quot;, line 8, column 39, charp=
os =3D 227<br>
&gt;<br>
&gt; =C2=A0=C2=A0around =3D &#39;...&#39;,<br>
&gt;<br>
&gt; =C2=A0=C2=A0whole content =3D +mipi_dsi_dcs_write_seq_multi(&amp;dsi_c=
tx,...);<br>
&gt;<br>
&gt;<br>
&gt; Code:<br>
&gt;<br>
&gt; @@<br>
&gt;<br>
&gt; identifier dsi_var,dsi_device;<br>
&gt;<br>
&gt; expression list es;<br>
&gt;<br>
&gt; @@<br>
&gt;<br>
&gt; struct mipi_dsi_device *dsi_var =3D dsi_device;<br>
&gt;<br>
&gt; +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };<br>
&gt;<br>
&gt; &lt;+...<br>
&gt;<br>
&gt; -mipi_dsi_dcs_write_seq(dsi_var,es);<br>
&gt;<br>
&gt; +mipi_dsi_dcs_write_seq_multi(&amp;dsi_ctx,es);<br>
&gt;<br>
&gt; ...+&gt;<br>
<br>
This one looks fine.=C2=A0 Do you have a C file on which you expect it to d=
o<br>
something?<br>
<br></blockquote><div>inside drivers/gpu/drm/<br></div><div>panel/panel-vis=
ionox-r66451.c</div><div>panel/panel-samsung-s6e88a0-ams452ef01.c</div><div=
>panel/panel-xinpeng-xpp055c272.c</div><div>panel/panel-sharp-ls060t1sx01.c=
</div><div>panel/panel-samsung-sofef00.c</div><div>panel/panel-sony-td4353-=
jdi.c</div><div>=C2=A0</div><div>Anusha<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
julia<br>
<br>
&gt;<br>
&gt; Output:<br>
&gt;<br>
&gt; Skipping=E2=80=A6..=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;<br>
&gt; =C2=A0<br>
&gt; Feel like=C2=A0 I am missing something fundamental ...<br>
&gt;<br>
&gt; Regards,<br>
&gt; Anusha<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; For the lexical error, should spatch be=
 run with=C2=A0 some headers that I am notexplicitly adding? I wonder if I =
am running with wrong options instead of the semantic patch needing a tweak=
.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0I don&#39;t think so. Spatch doesn&#39;t car=
e much about header files.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0julia<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0identifier ds=
i_var,dsi_device;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mipi_d=
si_device *dsi_var =3D dsi_device;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+struct mipi_=
dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;...<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-mipi_dsi_dcs=
_write_seq(dsi_var,...);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+mipi_dsi_dcs=
_write_seq_multi(&amp;dsi_ctx,...);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0...&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0The &lt;... P=
 ...&gt; notation is like ... but it makes the change whereever the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pattern P occ=
urs.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Yes. spatch however disregarding the pa=
ttern ....not sure why<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Anusha<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0julia<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;<br>
&gt;<br>
&gt;</blockquote></div></div>

--000000000000cae21c062bc16817--

