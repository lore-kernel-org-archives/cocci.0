Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC2EC02193
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2025 20:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=75Sg6DJ0wuEgO5Nk9sCKBkm6E1RJzb3mKvvXTGVIBz4=;
  b=l6/wE/OcHqvhu392kX1GcEZyOqcLf8OXBkznYSEhsR7w1P72liKKQP8j
   3H5+p+Qh9kShsw1CbfnoIgJShumbRCe2TwDywiTN+5biO/S3ijVPexzgK
   JqqmPtGlRocvp7JbQj/ICzssK079kruD2uD51p9ncUkGjzRNGHTVVHtyT
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,259,1732575600"; 
   d="scan'208";a="206605575"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Feb 2025 21:24:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B96F9E0D1D; Tue,  4 Feb 2025 21:24:30 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5ABEDE0260
	for <cocci@sympa.inria.fr>; Tue,  4 Feb 2025 21:24:28 +0100 (CET)
IronPort-SDR: 67a2777b_gSujrRxAZxstp/Ypw+6b/yt2D1uSsDcjSpv/yS289f8jV8n
 K6nBWvXH7FEW18TTRnfF67vUo1OeWuZr5GsUooA==
X-IPAS-Result: =?us-ascii?q?A0EpHQCCdqJngAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRIFXMwQLSIRWj0+BdDCEO4c7h1WIdYNUDwEDAQ1BAQIEAQEDBIIMgnQCi?=
 =?us-ascii?q?n4CHgcBBDQTAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHD?=
 =?us-ascii?q?goxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJgEPCw4MA?=
 =?us-ascii?q?iYCAlYGARQBAYJ+gjABAw4jB7QFgTKBAYIMAQEG2lsfLCJXgWUJgRouhWuCY?=
 =?us-ascii?q?wGFazuDQnonD4FVRIE8C4J4PoRDg1uCaYIzhEpnonNSexwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SkQOAMgCjYUHQIUDRAPBhAEbQU1Cjc6gg1pSToCDQI1gh4kWIIrawQFgS2CP?=
 =?us-ascii?q?YRDhE6CSFSCRIISdG4DAxYQAYMleByDUR1AAgELbT03BgMLGwY9nn2HYZM3s?=
 =?us-ascii?q?ws0B4I4gWaBYwyfXAYTL4NxAZNSDgaSey6HZJBqIqkMgX4jgVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIYQtjwoBuG9CNTwCBwsBAQMJhUYBAYpugUsBAQ?=
IronPort-PHdr: A9a23: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
 UqdljEFdGVeD5LCR9p1+0l7N+nSl0rd
IronPort-Data: A9a23:l1qgc6ojHz4APPHv/jBw8FMbec1eBmLJYRIvgKrLsJaIsI4StFCzt
 garIBmAafzYNGanetl2OYyz8k5T6sCBx4ViGgE6ri1jFnwSpOPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKiefHoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSsvnrRC9H5qyo5WtC5gBmP5ingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYj9yuuuTnuUiG9Y+DCDW4pZkc/DKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2kIPqon3N1YE1hWt
 thIMW8xMTDc3vK5lefTpulE3qzPLeHuO54D/G5tx3fVAJ7KQ7iZGv+Mv4UHmm5vwJkUdRrdT
 5JxhT5HSR3aYABUfHoTBog/muiAmXT1NTFVwL6QjfNvszKKlVIvjdABNvLSZcaEQcd/gn/Fo
 0D/wn7LEhUYCfOQnG/tHnWE3bOfxXirB+r+DoaQ8vd1iVmX7n4SDRcMXB26p+O4gwiwQbp3I
 Esf8SsGtrk37EXtT9/nXhT+rmTsg/IHc99XDvF89wyHjKbZi+qEOoQaZgBCT+MAj+AkfCRp8
 g+QwO+2JWM2oLLAHBpx6YyohT+1PCEUK0oLaikFURYJ7rHfTGcb0UinojFLT/fdszHlJQwc1
 QxmuwASqt0uYSMj0qKm4RbYjjjqqpWhou8JCuf/DjLNAuBRPdDNi2mUBb7zs60owGGxEALpg
 ZT8s5LChN3i9LnU/MB3fM0DHauy+9GOOyDGjFhkEvEJrmv2qyD7It0IvW0vfC+F1/ronxe2M
 Cc/XisOtPdu0IeCNv4pPupd9uxxnPGxToqNug78N4YWPsgZmPC7ENFGPhLAhzu9zyDAYIk+P
 pGcao63AB4n5VdPnFKLqxMm+eZznEgWnDuNLbiilkjP+eTEOBa9F+1bWHPQNbpRxP3f/23oH
 yN3bZviJ+N3Cr2mOnG/HE96BQxiEEXX8ris95MNLbbZe1o6cIzjYteIqY4cl0Vet/w9vo/1E
 ruVAye0EXKu1SeVGhbAcX15drLkULB2qH9xb2RmPk+l1zJnKcyj5bsWPcl/N7Q21v1R/dgtR
 dk8euKEHqtuTBbD8G8jdpXTltFpWymqogOsBBCbRgYDUaRufCH33+P1XxDO8XAOBxWntMFlr
 LyH0BjacKU5RA9jLZj3bauxw2OIoHRHpuNWWnHMA9hMeXfD9JphBDzxg8QWfeANC0Tn7RmL2
 zmGBSw3obH2nLY0193Sl4WonpyPEeBuOmZ/AE/g8qeQCSnW2kGB0L1wer+EUh6FXVyl5Zj4Q
 /teys/NFcEunXFIgtJaKKlqx6dv3OnfjeZW4So8FUqacmnxLK1rJ0SH+sx9tqdt4Lt9kinuU
 2Kt/uhqA5m4CPnHInUwejV8Nv+i0MsKkAb89f42eUX2xBFm9Yq9DHl9AUO+tzx/HpBUbqUe3
 uYTiOwH4Veeiz0rEOq8oAJ6ymCuFkEEAoIb7sw0IYmzkQc66EBwUbqFAA/M3Zy/QdFtME4rH
 zyquJT/l4lsnkrvTn5iOkXOjMx8hIsPsi9k1FUtBUqEsfubi+4V3C9+yyUWTANUwk950sZ2A
 GxKNlJ0F4qK7TxHlMhOZEHyOgBjVTmy2F399EsNr0LdF3KXb23qKHZnH/Sg52UL2jt4UhkC2
 5/A00fjczLhXP+p7xsIQUQ/9sDSF41gxDPNiOWMPpqjHaBjRRHHn6X3R24DiyW/MPMLnEed+
 NVbprdhW5baaxwVjbYwUbSB9LIqTxuBGmxObNdh8I4NHkDeYDuC4iePGW/gZvJyI+H2zmHgB
 /xMPs5vUzGM5BSKpB0fBo8OJOZQt9wt79wgZLjqBDAnt52ykzlXi6/TpxPO3DITf9ZTkMgGO
 tzwcRCGGTeunnd6oTLGg/RFHWuaWuM6QjPA8tq7ythUKKJbgtpQKRkz9pCWo0SqNBBW+kPIn
 QHbOI7T4e9Q6aVtuIrOSZd8JhiGBu7ycM+q8wmDlctEQv2SEMXJtiIT8kLGOSYPN5Qvet1Hr
 5a/m/+p41H055MNTHL8t6SaMqt0ufWJQ+tcN/zoIElgnSetXNHm5z0B8TuaLaNlvcx85M79Y
 SeFc+q1KMAoXulCyE1vayRxFwgXD4L1ZPzCoQK/t/G9NQgP4zfYLd+I9W7bUk8DT3UmY6bBM
 w7Tv+qiwvt6r44WXR8NOKxAMq9CeVTmXfMrSs31uTymFVKXu1KluIb5tB8e+DrOW2ilEsH73
 Mr/fSLAVi+O4YPG8NIIlLZJnEwnPC4oy614NEcQ4MV/hD2GHXYLZ7ZVe4kPDpZP1Df+ztfkb
 TXKd3EvEjj5QS8CSxjn/dD/RU2KM4Ti4DsiyuABpCt4qhtaBb9sxJNk8Tp8pWh7cH3vwYlL7
 D3YFmLYZnCMLlNBHI7/JcBXRc94y/mcyn9gFYXVjZnpGxhHaVkV/CUJIeeOPBAr1+nSmU+NK
 WVdqaWohq2kYRaZLPuMsEK51P3UUP0DAtnogeqyLA7jhrim
IronPort-HdrOrdr: A9a23:wjCdDKnLjhxCGY5afaOBu4etOwfpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:9oY8d2H0m0F5uT2DqmJZ92krPPsKYETFj1OAOhCEVkY2Ea2aHAo=
X-Talos-MUID: 9a23:rTrL0AZYEJP3++BTsCD2ijVgHttRvqGMMX0Xo4UCufSrOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,259,1732575600"; 
   d="scan'208";a="108211665"
X-MGA-submission: =?us-ascii?q?MDHItyX8/qAlJJv+GhR1CNZXnWqswz/8IOw0eh?=
 =?us-ascii?q?LUhR51Prc1DVgzVt5LjX74xIPrI8znrMHGdEoKEwtqhEvvFwFqGuGOfF?=
 =?us-ascii?q?xUgUXivYvaihq4I4ps2ylTaxRvOHLOLsJIWU1teeyQ3V0F8PuLLiZUyF?=
 =?us-ascii?q?uORZ1aJ4ebIMlYFrB4y14pQQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 21:24:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738700647; x=1739305447; i=markus.elfring@web.de;
	bh=75Sg6DJ0wuEgO5Nk9sCKBkm6E1RJzb3mKvvXTGVIBz4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mWAnCFiBTGBHF0D8y22X/ofl161UVgRE/LZ4UAbz6KH++7JYgdAOxQiXpGChxE71
	 lTwc8apfhCZwGln7iXyX0wplZ3h9fo66V8uSM3Amk6Yl+8LCTGV7ZRQxy/fLrJ0Mi
	 VaDPQhPEbDn4bA3+RWVOdwdQOyxfvE3X0SAqdpGilsakkXZmE97ZAy6PCThXiz73E
	 oM5oPZp1m+St5d7xzecWbF9D6GTySqTDXhzF4uLJkQVlaooq67k9YQ/JInpZGcRbi
	 Yp/mBJlEL1bw5migda02nTksvwAXtTJz1Xq80N0G+A4g9pRY4JaDD0nx18p4xglq5
	 26KWq19O7RbJM3cusw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.16]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6JxT-1tLuXO1vbd-010G2q; Tue, 04
 Feb 2025 21:24:07 +0100
Message-ID: <a3b1ecdf-0bf0-4053-8bbf-ecaff4e8cb62@web.de>
Date: Tue, 4 Feb 2025 21:24:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>, cocci@inria.fr,
 Andrew Morton <akpm@linux-foundation.org>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 Ilya Dryomov <idryomov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Ricardo Ribalda <ribalda@chromium.org>, Xiubo Li <xiubli@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
References: <20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com>
 <20250203-converge-secs-to-jiffies-part-two-v2-1-d7058a01fd0e@linux.microsoft.com>
 <49533960-e437-4042-951a-0221164bfa3d@web.de>
 <974a03d2-3f3f-4be2-9dba-ece6dca8015e@linux.microsoft.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <974a03d2-3f3f-4be2-9dba-ece6dca8015e@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bHRRDUYNgzL2w5T+cBWnQvEzsyVC5tGhQ42pj//Hbr4WJXbt5Tx
 NmigUqbqJgStPgfqohv2o83whcM6RPacemDly0/uhpszNzDSw3IAGU2IJTNaWvTkb7j2QJo
 JxDWv833ZoIP8YHiW6/lT+xid70cxmorwByZZo2wrpkzHlXD5CJM6tPQN3DfzRA7YNRkajF
 qIjSyG47cUu91WN+pwj3g==
UI-OutboundReport: notjunk:1;M01:P0:Ygu3d3nBFok=;Vgbi7VkznJIFuieA/BcpmXLJjxL
 ZFgf31MXADDmjwCBZKeq0yl1JBII2u3U2u8Vx8+pbqSy0KklvYP9lcAdklAoqsqwVjtL+JBoV
 +SASzap27bZKSMQsdsr17b/oxdCJhaFdKju02RLOqomK1EDDvoQqx09WuT40V1qGN31AoUjIf
 +ixzbHmKcndbO0Cy34Ij1VrICdux9x+1dWJrBTl8YC61yydkhNHEPgrTV4Yr9IL14OQXhIVlN
 AiwSIdSSdRCtjti1ydmx6G6frq9leAF14IgXBS4D/n03fON+72pfBM2fFQiLGPVXkwJZOvacX
 4e5g7DEFmy+KkO624irI+m1lJ4UhrT72Wongw6ntrbKbfDFwWSWvTYJIx/uQMOyw3+r2DRmZG
 dXwD0b4DbgR3xtpU8fClMj5auwcw+z0XusU0nrMII48inU5+WJ+0v1dYo5yHFq1ISwNL3z5yy
 HaTsFQ+EO3b6vJ9BkLmXHj+YidJHL4NeIU2mRaeBmjXtYFboite/t7iDVp/G5hgIy2h/K+gy6
 7oWBApvDevTxWTDOI7tS3tr1c+wQ77uSinvuZAdkL2YtwBLGsrcTsM9J7w5uVm9h/9PI8/Cyl
 2ma8d7e/lHRIWIqlzvQqmtpZO4nUjjyDRimvv0gCM2QP78zGVg6AnlMK7z1RW/x9r0Y6uFqKN
 kR6geHrfz53EsXgzuOZZgeBwnkU3dFmV8M6CAgPPGhGVdJoFu41sqhbR+2d18AKYVcU8XEDUL
 UnTsN46NB9io18/A0+lcQCPlU92MoBgxz/+GU5n2beuXX/BH9Z3SZukI9y/uowH0fEbby8rTP
 5M9rfmSjiWSnLHPKDXjCl4rq+8hfa0g24Ncp+NdvY6AfkiRSI0BBiyNJH/C/Jxtn0xJxRQTk9
 joL/em4JNuJM6UHv/LUZj1AMJGObMg5WZCbf/SCnu51nl2l9KAMvlE3fmbcwh3UlwspxjFgnf
 PMWmzNcyIp0HwWZSAWJklv39m+6iIm0PTWTErE6UdKntbCxOMDGUKyoAaEmE2P5jsYYGGpxaT
 lHIj40GfUwp2MnRbGyr+BJhd5jksqq9ai3ZNmpk6mHRiE99M+FSyJj0YtSaL8tgIWq4D8s50t
 dUZW1+ancQnbHj9uHdSGdexcqttgE0q1QGWlXqMmHqikYNdtHILvdaDhAAprPlMQ9MzZ5wDga
 y8OKxkI+12l48PRYLPfVXq9CP8FXicrc5GLs6DggMrK+yWaWRi29kgxLsu24e5K63NQlJvXsY
 iUsjmMiH0ES7wdQj5ylD501ectD1omCsyr1fj6JMBUZpCQmDKOOtDLH+S9GA9P4gZr8j65hmz
 EQGlolNigaM6VSGebRHE5FjOOKDkn6PlIlXVo9A85Wcn31BVr1x7LZpbNYplTMD4u5x
Subject: Re: [cocci] [v2 1/3] coccinelle: misc: secs_to_jiffies: Patch
 expressions too
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2345
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/a3b1ecdf-0bf0-4053-8bbf-ecaff4e8cb62%40web.de>

>> How do you imagine that the shown SmPL code fits ever to patch reviews?
>
> By the simple fact of accomplishing the same result despite differences =
in
> code style, as explicitly called out in the changelog.
Do any other contributors care more for the mentioned software development=
 concerns?

How do you think about helping to improve affected implementation details?

Regards,
Markus
