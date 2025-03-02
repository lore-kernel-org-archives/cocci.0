Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA6FC282D6
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=w78AW+JcdaAE6GRO3Ac/koXaEdMi8GHrKoemWbN/WZQ=;
  b=hY56kccLX5HCzLXhefhMECuoshNIrrFULLjc5b0ntMOiYrXWqDuMB5zC
   ww0wtUYOs3aZAq6jjdn4KwXpDsgJcyyvd9ZvZhrNfs/J9tPxmTUpqZp9O
   Awl8cHYsgmifCiou5cFfA6BeixHiKn9W0y41Tkrmkf74ae0HArHg3e2Sp
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@googlemail.com
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211069227"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8F778E0E02; Tue,  4 Mar 2025 10:58:42 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C23ECE0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 19:36:08 +0100 (CET)
IronPort-SDR: 67c4a518_xb+ifuo8HmSmLLB3ZdrL8+j4bbnCxRZD/pnjuhiWXYjCwdU
 7K+0o2k3wuuVrPS518qYuZdnJtM7BNFSfB2EpKQ==
X-IPAS-Result: =?us-ascii?q?A0EbAAAdpMRngbSAVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCQoFWNAQLSIRWiB2HMoIhA4ETkDSMTRSBag8BAwENRAQBAQMEO?=
 =?us-ascii?q?IRIAosVAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBIhkHDjuFew1JAQwBggsBgSSBJgEBAQEBAQEBAQEBAR0CLD8BAR0BAQEBA?=
 =?us-ascii?q?xIRBBkBOAEDDAYFCwoDAgImAgIhEgEFARwGEwgahRABAzEDoieBBUKKRHp/M?=
 =?us-ascii?q?4EBgg0G2l0KQQ2BMYEgAgcUgQYuAYR0g1oBgWyDf4MUaXonG4INgRU1gQaBN?=
 =?us-ascii?q?zg+gh+BZxQpFYNGgmkEgi+BaQGDPZZrgxqOLSYJHQMHBw4NHkkPBRwDWSwBV?=
 =?us-ascii?q?RMXCwcFgSlIAQIBbCIjgSMFNAo3OoILaUk6Ag0CNYIefIIrgheCN4IXgiZEG?=
 =?us-ascii?q?C8DAwMDgymFUoIRgV0DAxEFDwGBbmFQdxyDfX+CMIFtTR1AAwtiCz03FBtMo?=
 =?us-ascii?q?WU6g1BqBwE8NwcTARMcHS5gFk8LDRyScS6zHguEJaFiM6pWiDCQTaN6ARiFD?=
 =?us-ascii?q?REjgUQ6gVw0PBU7MYI2TwMZD44hDBaDWMhnRTI8AgcBCgEBAwmCOYpkgks0g?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23:P91i9x/bwV8WHP9uWWW1ngc9DxPPW53KNwIYoqAql6hJOvz6uci5Z
 gqHvb493QSYFazgqNt6yMPu8JrcEVQa5piAtH1QOLdtbDQizfssogo7HcSeAlf6JvO5JwYzH
 cBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB1JuPoEYLOksi7ze+/9pPNbwlSmDaxfbx+I
 RayoAjfssQdnJdvJLs2xhbVrXREfPhby3lvKVyPgRj3+92+/IRk8yReuvIh89BPXKDndKkmT
 rJWESorPXkt6MLkqRfMQw2P5mABUmoNiRpHHxLF7BDhUZjvtCbxq/dw1zObPc3ySrA0RCii4
 qJ2QxLmlCsLKzg0+3zMh8dukKxUvg6upx1nw47Vfo6VMuZ+frjAdt8eXGZNQ9pdWzBEDo66c
 oABDfcOPfxAoobyqVsBrxuwCwevCu3y1DFFmGP506Ih3uQ9CAHLxhAsE84SvHnWqtj+KaccU
 fqyzKnN1TjOcfNW2S386IjTbhAhoOuDXbRtesTQz1EvCx/Fjk6MpozlITyey+MAvHSU7+thU
 uKvjXAoqxpqrzigwccsjYbJhoYLxVDB7yp5wYI1KcekR058ZN6pCZ1dvDyVOIVqWM0tWX1ou
 Dokxb0cv562ZCgHxYopyRPDd/CKd4uF7g/sWeueLjp2imxodbCiixi97UWt1uzxW8i13VhKo
 SRIktrBu3MR2xDO6sWKVvlw80Sn1D2S1A7T8vlJLV4omaffMZIswb49moAOvUjdHSL6glj6g
 ayKekgi5+Ol9eDnYqj9pp+AKYB0kBzwMqUvm8OhGek0Lg4DVHWB9+umzr3s50j5Ta1KjvIol
 qnZt4jXJcEBqa64Bw9Zy4Yi6hiiAzu/3tQUgHoKIE5fdBKIiIjpPF7OIPTmAvuln1uslzJry
 +jHPr3nHJrNMmDOnKn9cbt58UJRywo+wcpC655KCbwNOu//V0ztuNDACx82KQ20w+LpCNVn0
 YMeXHqCDbOWMKLTtl+I4PwgI/KXaY8avzb9LPcl5/rwgn88g1AdfK2p0YELZ3C/G/RqO0OZb
 mH0jdcbDWgKphY+TPDtiFCaTzJff2yyUL4k5jEnFIKmCp/ORoS3j72Pxii7GplWa3tHC1CNF
 HfnbJ+EVO0WZCKTJM9hiD0EWqK7R48vzxGirBX6xKZ/LurI5i0Ysoru28Ry5+LPiR4y9Cd5D
 9+d0mGIV2F7hHkERz4w3KBloExy0E2P0aZig68QKdsGzPpSXxZyDpXcxvF0D93oElbKd8yEW
 X69SdWvHD81Q8h0yNZIaEF4TYaMlBfGigGqGb4Oi72CAtQbbL7AxHPxKo4pwHnU068slHEpR
 cxAMWCjj697sQPUAtiawA2ii6+2ePFEj2b2/2CZwD/L5RkAOOYReaDMXHREI1DTscy8/UTaC
 bmnFbUgNAJFj8+EMKpDLNPz3h1dXPm2HtPYbiqqnnuoQw6Sz+aHY5jtfWgG9CraD0cAngUa/
 HLAPg87VW+6u2yLNDV1Dhr0Zl/0t+x3qXe1VEgxmgqFfUpn2qGd9RkSiviRTvoS2vQPvyJy4
 y5sEgOb2NTbQ8GFuxInfKhYZoYl50xb0GvCqwFnFpmpLqQnl0FHNgou7xuo2BJwBYFN18Mtq
 RvG1SJULqSVmBNEfjKchtXrP6HPb3L15FapYrLX3VfX1JCX/L0O4bI2sQerugbhDUck/3h9t
 rsdm3KB+pXHChYTWpPtQw428RZ9vbTTfig64cvdy3RtNaC+tjKK1cguAaMpzROpftEXN63hd
 ke6GMIIAM6jM8QlnF+mah8BNeFWsqUzOoLudveL3rKqIPc1hCiv3gElqMh21kOB8TY5S/adh
 c5UhaHFmFLdB3Gl3A/y16K/0ZpJbjwTAGelnC3tBYoKI7Z3YZ5OEmC2Zcu+2tR5gZfpHX9e7
 l+qQV0ci6rLMVKfaULw2QpI2AEZu3uizGGzwC5zlTwyhqWY2yPKzuHrdR5BMWlODjoH7x+kM
 c2vgtYWUVL9JQMmhhyj6F3SyK9cq6ByKmDSRQFDeC28fAQAGuOg87GFZcBI8pYhty5aBf+9b
 V6tQbn4uxIG0innEgOy3RgDfiqx8tX8lh1+0yeGKWpr6WHeYYd2zAve49rVQbhQ2CAHTW92k
 2ufCl+5NtivtdKa8vWL+uuxRWWnW4Z7fi7swoeNsSK64SthBhj3k/2om9LhGBQ3ymehj4gsB
 XiO9UysJNC7j+yzKqp/c1NtBUPg5sYfeMk2iYY2iJwKmDAbipiT4XsbgDL2ONRf17j5aSlFT
 joKztjJpQn9jRc7fzTZmsSgDCXbm5s5NLzYKisM1ykw7t5HEvKR5b1Axm5up0ag6BnWeb57l
 ysczv0n7DgbhfsIsUwj1Hb4YPhaEE9GMCjrjxnN4cq5qfAdb2m9dr69z2JxmteuCLyHqwBYH
 n3+f91xeE04ptU6K1/K3HDpv8vvd8vXa98InhKTlBjEgu1cKZZ3nf0Pz3kCWyq1rTguzOg1i
 gZr1Jexsd2cKmljy6m+BwZRKjz/Y85AsiGol6tVmdyampy+Bpg0UCteR4PmFLj7dVBa/eSiL
 QuFFycw72uWCaaKVxHK819o9jrOC8z5bCzRfShBi48+G1/FYxYDyAEMAGdkwthjTVvsnZK5N
 h8+v2F0hBawqwMQmLw2cUCnCCGH4l/vMG98SYDDfkQIqFsetgGFaYrGqbgrVyBAos/+9krUd
 irCNl4OVSZQCinmTxjiJuX8uoWGqrLFQLL4d7yXP/2PsbAMDq/Yg8vwjc02uW7LbJzHP2E+X
 aRkgQwaDCw/Q4KB3GxRLk5f3yPVM5zB/Eb6qnAx95rvtqysAV2n5JPTWeELb5Myq1bv0P3Fb
 6nJ1W54MWoKjMpSgyWTmf5EhhhKzHg/ElvlWaIJsSqHJE7JsolQCRNTKyZ6Nc8Tqrk5whEII
 snDzNX8yr9/iPcxTVZDT13o3M+zN4QMJCmmOVXLCVzuVvzOLCDXw8zxfaK3SKFBxORSuRqqv
 D+HEkjldj2dnjjtXhqrPKlCliaedBBZvYi8dF5qBw2BBJr+bQanNdZskTAs6bg9h3ePJHFFd
 DYlIxsLobqX4idVxP54Hi0J73ZoK/WFhzfM7+TcLcVz07MjCSB1muRGpXUinuENvWcUGbosw
 nuU94428DTE2qGVxzFqUQRDsGNOjYOP5gB5PLnBs4JHQTDC9Q4M6mOZD1ILocFkA5vhofM1q
 JCHmaTtJTNF69+R89EbAp2eI82VN3wsKjLmHznbCAYARD+vc2rYggYO9ZPavm3QtZU8ppX2z
 dAWTaRHUVUuCv4AIkFsHdhHMYguGz19webdg8kP6n6z6hLWQY8J2/KPHuLXCvLpJjGDiLBCb
 BZd2rL0I7MYMYjj0lBjYF139GwrM0/ZXNQIszI4KwFt8B0L/395QWk+nUnib1H1iJf8PfGzm
 REyhw53YOBr/zDpsQ5fzr/iqyw3n008nNzkhXaadzujdM+N
IronPort-Data: A9a23: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
 Q==
IronPort-HdrOrdr: A9a23:Qw3vF6Amcx5DGFvlHelc55DYdb4zR+YMi2TDGXoBMyC9Ffbo6/
 xG/c5rqCMc7Qx6ZJhOo6HmBEDtewK5yXcx2/h1AV7AZniEhILLFvAa0WKK+VSJcBEWtNQtt5
 uIGJIOcOEYY2IK9vrS0U2WFc0/yMKL/K3tqeDV1Gd1UA1mApsN0y5JTiieVmJ7TBRbHpYifa
 DsgPZvln6PfTA4YK2AaEXtnNKtmzQIrv/biNI9ZiLPITPvsQ+V
X-Talos-CUID: 9a23:iQFp+GwyZFZl1ZTqBO+lBgVMCIc1dESG6kyXOmS8NWB0cYKwam2PrfY=
X-Talos-MUID: 9a23:6h9GQgVpnoTP+NDq/D+z3GxuPcpT2aWFARtQzLJbl8zdMyMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,328,1732575600"; 
   d="scan'208";a="110434348"
X-MGA-submission: =?us-ascii?q?MDFcp5zWl/gjHPv0EilptNKGOAPj9L3GYmZUxX?=
 =?us-ascii?q?ji5lDuAWuMUXwoz+whQfjgWrrUjlGpiVHvQCQ/izK5SUPvfsExm+vzjO?=
 =?us-ascii?q?VcO1yPVb/yjIrPq6RLOSx77lgo52QIfXtnsqMftZq3PPUMW7/3WpoLEd?=
 =?us-ascii?q?lrek4KpGU28CvW/kZyKOviMQ=3D=3D?=
Received: from mail-yw1-f180.google.com ([209.85.128.180])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 19:36:08 +0100
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6f77b9e0a34so28198907b3.2;
        Sun, 02 Mar 2025 10:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1740940566; x=1741545366; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w78AW+JcdaAE6GRO3Ac/koXaEdMi8GHrKoemWbN/WZQ=;
        b=NbDuYoBW9quYk3pjT1yKwzLbFCPCcoQPcbT1t87JRbaHn9ss2KaRkfw/wuvVEs+Ksg
         aMMPd67Zyw2dBh92g3H//Zt5aXvYHwgL1+0lI5wyhxckkCbF9zo8pUrrNd6jTxzCOXNq
         sUfyIqx2tU/OXK6pv7EhvX8hoGMg0vx9kSEU1CY4bJe9YQUaFI8Byna0oZlM/+LpzD6d
         Fj3ch8iJ9/pofkjgdwPEZa9S8Ud4voAORnzv8PKxjXNVXRXsPWqdEV3sVx+Fr9IpSk6I
         XL/M05XgWqtvU2rXv0cZBN6uBpWOdGj+TB6TLeOshsmupvaSYy6pZDU8hA3bkT+58+hq
         B2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740940566; x=1741545366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w78AW+JcdaAE6GRO3Ac/koXaEdMi8GHrKoemWbN/WZQ=;
        b=SlNIbLTp49O52kTsosvU/lALFW0SDxEn8k9WLoOeNGxfgIPcEJ/9YufgO7QC0zDo1i
         p/Lw2OF9GakKzwY2pjNavxwBfSmEP/HUGf50ooNwgdzBzbgpg+BtXNchUu3ulByhaPB3
         /VAMXEQ5PiiXhkt7NdMH/5z++2Rf+2iXNTo/7aqYVIf6O4Wg5MWouCMdkNdLZ2+hBcZ2
         axQTML0IP6/vXds0NtjgSygihkGFjDtGvIUgpFB5Hv9J3NdIfuMecIJab25jiBNjZHtM
         xjGTzQBgVda3L1gfgVpv4Pa3Vnew2DR9dyvZc/KlvAvsbDS05OUdalhI4emkZb8yFnTQ
         ER6w==
X-Forwarded-Encrypted: i=1; AJvYcCUEn5qeIqqi2xyvDAzt813FR0iKg+rzQ4Ym7ejWcP5R7VOrfknccuf89ew13kj1O9j+SYS3DljrplrP/SE=@inria.fr, AJvYcCW6VSOyDRFS1JMIA+lHQjLKUpSzyaW/ACF4Z/m1jGNX02+gR6E/YlB8Cgb3cU3MqKi7Vcj+POM=@inria.fr
X-Gm-Message-State: AOJu0YyPDUG3xqcqo0SR1ablBA85e6cT/8m/bf/kUO2rZBjZ8dCDPMyA
	A9OvSlU1drPQ030pqEaXKjNttAGwLyGR7JncNwrHqjUP1X51rSDw8EddLCOeH7Yv/zFvhl3BGDC
	siIeKrd+OoR+QOmLH9JpqbbZDBNo=
X-Gm-Gg: ASbGncsEFOmieajr1mKQhUOlwYzpVrueikJkrKdYRcJhYE+jaahYB+UcmJOEx8KcEW7
	m/DLpirbIMW0eGUZx7mzFVRpV1hgMn/88jkAHMYRPIty3i8c5Umee/Q7cV1w/L0QTPHzE8aqOUM
	0LK5W2eWUFPvU+aT0Ki1P9VC7K
X-Google-Smtp-Source: AGHT+IFEDFRSLDqxeBHjrQywmijhQmz1FQW1pOjODzRPNakiH9IUDfoup1MSTpVVFPDPENluYnSs00bxRiHrQPHXl9k=
X-Received: by 2002:a05:690c:3686:b0:6ef:57ad:9d6e with SMTP id
 00721157ae682-6fd4a0f7944mr148229247b3.15.1740940566042; Sun, 02 Mar 2025
 10:36:06 -0800 (PST)
MIME-Version: 1.0
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
 <20250302160657.127253-11-cgoettsche@seltendoof.de> <6f74f18f-ba64-4372-8307-efba97c03bf2@schaufler-ca.com>
In-Reply-To: <6f74f18f-ba64-4372-8307-efba97c03bf2@schaufler-ca.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Sun, 2 Mar 2025 19:35:55 +0100
X-Gm-Features: AQ5f1JpZICwtQ4pPwJ_9PnfHMp-YThZWlCGoAujw1thoqgj05siVdgKD2fL2hJM
Message-ID: <CAJ2a_DdrhV0pGj1WQ9N201KCY3bp_70zd1eSZ2PD1VOOd6SBrg@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Serge Hallyn <serge@hallyn.com>, Jan Kara <jack@suse.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 01/11] coccinelle: Add script to reorder
 capable() calls
Reply-To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2500
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/CAJ2a_DdrhV0pGj1WQ9N201KCY3bp_70zd1eSZ2PD1VOOd6SBrg%40mail.gmail.com>

On Sun, 2 Mar 2025 at 17:53, Casey Schaufler <casey@schaufler-ca.com> wrote=
:
>
> On 3/2/2025 8:06 AM, Christian G=C3=B6ttsche wrote:
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > capable() calls refer to enabled LSMs whether to permit or deny the
> > request.  This is relevant in connection with SELinux, where a
> > capability check results in a policy decision and by default a denial
> > message on insufficient permission is issued.
> > It can lead to three undesired cases:
> >   1. A denial message is generated, even in case the operation was an
> >      unprivileged one and thus the syscall succeeded, creating noise.
> >   2. To avoid the noise from 1. the policy writer adds a rule to ignore
> >      those denial messages, hiding future syscalls, where the task
> >      performs an actual privileged operation, leading to hidden limited
> >      functionality of that task.
> >   3. To avoid the noise from 1. the policy writer adds a rule to permit
> >      the task the requested capability, while it does not need it,
> >      violating the principle of least privilege.
>
> What steps are you taking to ensure that these changes do not
> negatively impact LSMs other than SELinux? At a glance, I don't
> see that there is likely to be a problem. I do see a possibility
> that changes in error returns could break test suites and, more
> importantly, applications that are careful about using privileged
> operations.

Checks are only reordered where the current right-hand side is
side-effect free, e.g. a comparison.
Whether a branch is taken or not (and thus possible return values)
should not be affected.

Here is the current output of the script with the false-positives not conve=
rted:


### begin ###
diff -u -p a/kernel/capability.c b/kernel/capability.c
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -491,8 +491,8 @@ bool capable_wrt_inode_uidgid(struct mnt
{
       struct user_namespace *ns =3D current_user_ns();

-       return ns_capable(ns, cap) &&
-              privileged_wrt_inode_uidgid(ns, idmap, inode);
+       return privileged_wrt_inode_uidgid(ns, idmap, inode) && ns_capable(=
ns,
+                                              cap);
}
EXPORT_SYMBOL(capable_wrt_inode_uidgid);

diff -u -p a/kernel/pid.c b/kernel/pid.c
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -662,8 +662,7 @@ static int pid_table_root_permissions(st
               container_of(head->set, struct pid_namespace, set);
       int mode =3D table->mode;

-       if (ns_capable(pidns->user_ns, CAP_SYS_ADMIN) ||
-           uid_eq(current_euid(), make_kuid(pidns->user_ns, 0)))
+       if (uid_eq(current_euid(), make_kuid(pidns->user_ns, 0)) ||
ns_capable(pidns->user_ns, CAP_SYS_ADMIN))
               mode =3D (mode & S_IRWXU) >> 6;
       else if (in_egroup_p(make_kgid(pidns->user_ns, 0)))
               mode =3D (mode & S_IRWXG) >> 3;
diff -u -p a/kernel/bpf/token.c b/kernel/bpf/token.c
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -10,7 +10,8 @@

static bool bpf_ns_capable(struct user_namespace *ns, int cap)
{
-       return ns_capable(ns, cap) || (cap !=3D CAP_SYS_ADMIN &&
ns_capable(ns, CAP_SYS_ADMIN));
+       return (cap !=3D CAP_SYS_ADMIN && ns_capable(ns, CAP_SYS_ADMIN))
|| ns_capable(ns,
+
              cap);
}

bool bpf_token_capable(const struct bpf_token *token, int cap)
diff -u -p a/debian/linux-headers-6.9.0-rc2+/usr/src/linux-headers-6.9.0-rc=
2+/include/linux/bpf.h
b/debian/linux-headers-6.9.0-rc2+/usr/src/linux-headers-6.9.0-rc2+/include/=
linux/bpf.h
--- a/debian/linux-headers-6.9.0-rc2+/usr/src/linux-headers-6.9.0-rc2+/incl=
ude/linux/bpf.h
+++ b/debian/linux-headers-6.9.0-rc2+/usr/src/linux-headers-6.9.0-rc2+/incl=
ude/linux/bpf.h
@@ -2715,7 +2715,7 @@ static inline int bpf_obj_get_user(const

static inline bool bpf_token_capable(const struct bpf_token *token, int cap=
)
{
-       return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_A=
DMIN));
+       return (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN)) || capabl=
e(cap);
}

static inline void bpf_token_inc(struct bpf_token *token)
diff -u -p a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1285,8 +1285,7 @@ static ssize_t scrub_show(struct device
               && !test_bit(ARS_CANCEL, &acpi_desc->scrub_flags);
       rc =3D sysfs_emit(buf, "%d%s", acpi_desc->scrub_count, busy ?
"+\n" : "\n");
       /* Allow an admin to poll the busy state at a higher rate */
-       if (busy && capable(CAP_SYS_RAWIO) && !test_and_set_bit(ARS_POLL,
-                               &acpi_desc->scrub_flags)) {
+       if (busy && !test_and_set_bit(ARS_POLL,
&acpi_desc->scrub_flags) && capable(CAP_SYS_RAWIO)) {
               acpi_desc->scrub_tmo =3D 1;
               mod_delayed_work(nfit_wq, &acpi_desc->dwork, HZ);
       }
diff -u -p a/include/linux/bpf.h b/include/linux/bpf.h
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2830,7 +2830,7 @@ static inline int bpf_obj_get_user(const

static inline bool bpf_token_capable(const struct bpf_token *token, int cap=
)
{
-       return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_A=
DMIN));
+       return (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN)) || capabl=
e(cap);
}

static inline void bpf_token_inc(struct bpf_token *token)
diff -u -p a/kernel/user_namespace.c b/kernel/user_namespace.c
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1194,8 +1194,7 @@ static bool new_idmap_permitted(const st
        * (CAP_SETUID or CAP_SETGID) over the parent user namespace.
        * And the opener of the id file also has the appropriate capability=
.
        */
-       if (ns_capable(ns->parent, cap_setid) &&
-           file_ns_capable(file, ns->parent, cap_setid))
+       if (file_ns_capable(file, ns->parent, cap_setid) &&
ns_capable(ns->parent, cap_setid))
               return true;

       return false;
### end ###

>
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > ---
> >  MAINTAINERS                                |  1 +
> >  scripts/coccinelle/api/capable_order.cocci | 98 ++++++++++++++++++++++
> >  2 files changed, 99 insertions(+)
> >  create mode 100644 scripts/coccinelle/api/capable_order.cocci
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8e0736dc2ee0..b1d1c801765b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5196,6 +5196,7 @@ F:      include/linux/capability.h
> >  F:   include/trace/events/capability.h
> >  F:   include/uapi/linux/capability.h
> >  F:   kernel/capability.c
> > +F:   scripts/coccinelle/api/capable_order.cocci
> >  F:   security/commoncap.c
> >
> >  CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
> > diff --git a/scripts/coccinelle/api/capable_order.cocci b/scripts/cocci=
nelle/api/capable_order.cocci
> > new file mode 100644
> > index 000000000000..4150d91b0f33
> > --- /dev/null
> > +++ b/scripts/coccinelle/api/capable_order.cocci
> > @@ -0,0 +1,98 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +///
> > +/// Checks for capable() calls of the left side of a binary expression=
.
> > +/// Reordering might avoid needless checks, LSM log messages, and more
> > +/// restrictive LSM security policies (e.g. SELinux).
> > +/// Can report false positives if the righthand side contains a nested
> > +/// capability check or has side effects.
> > +///
> > +// Confidence: Moderate
> > +// Copyright: (C) 2024 Christian G=C3=B6ttsche.
> > +// Options: --no-includes --include-headers
> > +// Keywords: capable, ns_capable, sockopt_ns_capable
> > +//
> > +
> > +virtual patch
> > +virtual context
> > +virtual org
> > +virtual report
> > +
> > +//----------------------------------------------------------
> > +//  Pattern to ignore
> > +//----------------------------------------------------------
> > +
> > +@ignore@
> > +identifier F1 =3D { capable, ns_capable, sockopt_ns_capable };
> > +identifier F2 =3D { capable, ns_capable, sockopt_ns_capable };
> > +binary operator op,op1,op2;
> > +expression E;
> > +position p;
> > +@@
> > +
> > +(
> > +F1@p(...) op F2(...)
> > +|
> > +E op1 F1@p(...) op2 F2(...)
> > +)
> > +
> > +
> > +//----------------------------------------------------------
> > +//  For patch mode
> > +//----------------------------------------------------------
> > +
> > +@ depends on patch@
> > +identifier F =3D { capable, ns_capable, sockopt_ns_capable };
> > +binary operator op,op1,op2;
> > +expression E,E1,E2;
> > +expression list EL;
> > +position p !=3D ignore.p;
> > +@@
> > +
> > +(
> > +-  F@p(EL) op E
> > ++  E op F(EL)
> > +|
> > +-  E1 op1 F@p(EL) op2 E2
> > ++  E1 op1 E2 op2 F(EL)
> > +)
> > +
> > +
> > +//----------------------------------------------------------
> > +//  For context mode
> > +//----------------------------------------------------------
> > +
> > +@r1 depends on !patch exists@
> > +identifier F =3D { capable, ns_capable, sockopt_ns_capable };
> > +binary operator op,op1,op2;
> > +expression E, E1, E2;
> > +position p !=3D ignore.p;
> > +@@
> > +
> > +(
> > +*  F@p(...) op E
> > +|
> > +*  E1 op1 F@p(...) op2 E2
> > +)
> > +
> > +
> > +//----------------------------------------------------------
> > +//  For org mode
> > +//----------------------------------------------------------
> > +
> > +@script:python depends on org@
> > +p << r1.p;
> > +@@
> > +
> > +cocci.print_main("WARNING opportunity for capable reordering",p)
> > +
> > +
> > +//----------------------------------------------------------
> > +//  For report mode
> > +//----------------------------------------------------------
> > +
> > +@script:python depends on report@
> > +p << r1.p;
> > +@@
> > +
> > +msg =3D "WARNING opportunity for capable reordering"
> > +coccilib.report.print_report(p[0], msg)
