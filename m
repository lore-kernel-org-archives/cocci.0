Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4203FC433EF
	for <cocci@archiver.kernel.org>; Wed, 11 May 2022 08:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=PFEaGXuUsmHzj0CB0XjDLH0EVE6rI82uSOBBqyeiXfk=;
  b=M8+MVeJOer8oXZpRGBZ1lSywqlSwc5nOEr3QLQJz4jOWDN7fyErGyC2V
   /A7pnqJZB1JiEU0ouz5ROkN3Xio85ookTpYF9i3rOCdHbA+6cfsIm7lwW
   Wdm816XPti6Z1pSXAc9hRQN+1g+6ojuc+YRnzjcsahlpOaGmxqUb6y/O0
   8=;
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
X-IronPort-AV: E=Sophos;i="5.91,216,1647298800"; 
   d="scan'208,217";a="35709688"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2022 10:36:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8D84EE0269; Wed, 11 May 2022 10:36:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 51A0AE0098
	for <cocci@sympa.inria.fr>; Wed, 11 May 2022 10:36:45 +0200 (CEST)
IronPort-SDR: TZbbox0wR5xMpp1x1jVPL49ul9Ezubd80+FQcGo/PytvNmbrsk12Aq94i+V4guUoaaBqz4Mtp3
 71d9txHr1a/T3eOWg9MoHL/LdMFfGF/TWgt/KBFOi1jrXpwDRVQMp5tCyv/tC/eDGcIP6hhsNQ
 3ivWg3gd40T98jKx7QmF0gd84RyK+cH/zg1+lkYl6Jx2T/LcU6FZcyGqGFlu16OPYXree/pi/Y
 nCdMzShxyTeq5TPDckyX8B8uFXIYe0/AjuCDe2KNoRG2ugxFJHF+oJMA0Ft/d/t7Y7VFYABmi6
 1/FvJxB3j8kudEUZmXdfjJz1
X-IPAS-Result: =?us-ascii?q?A0DKBwB0dHtif7DdVdFaHQEBPAEFBQECAQkBgWaCIoFSL?=
 =?us-ascii?q?gQLQ4ROgSONQ4ICBR4DiyeBBZIzCwEDAQ0SAS8EAQGFAgKFPgIdBwEENBMBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQENCwkHCAoHDg4FYAFhA?=
 =?us-ascii?q?wFEgU+BdAsDMQ2CNSkBg2QBAQECARIRHQEbHQEDAQsGAwILNwICIgERAQUBH?=
 =?us-ascii?q?AYTCBqFPgEDDSSQTo8agQRBizKBFQUXgQGCCQaESwoZKA1nA4FZAgcSgSoBh?=
 =?us-ascii?q?haBJAEBhyMnEIFVRIFLgnQ+hCIBAYN2gmUElSMEBwMEBgEGDgMDAhAUAQIBD?=
 =?us-ascii?q?CYkDw8IBRICAzQCAgEBCwIGBgQGAwEBBgMJAgQCEgICBAcYChIIFAMCBgIgB?=
 =?us-ascii?q?QEHBQEEAxIGDBEBCgYGAQQCCgECAgUFDAMBEQEEAgYCBAQEGBQEAgQEBQYCC?=
 =?us-ascii?q?QgHBRYLBAoCFgEdAgEGDAgCAgICAgQVBwENBQICBA8CBwYDCwIDBQcDAwQHD?=
 =?us-ascii?q?AYMDgEDAQcBBAUDDQQBAQYCCwMFCgIBAgMMAQEHBAgBAQICCgIBBAIHAQIFA?=
 =?us-ascii?q?wIDCAMCAwMCAgEBBBECAwQDBAIDAQYBAQUDAgUBAwMCAQMDAwIBBAMGCQoEC?=
 =?us-ascii?q?AEEBAEBARECBwcCBgMDAgICAgUBAg0BAgECBAMIBgIDFQECBAEKAQUCAwoCB?=
 =?us-ascii?q?wMBAQIHBQoCBwUCBwICAwIBBQMNAQMFAgMBAQMDAgQBAgEDAwkBAwIDAwICA?=
 =?us-ascii?q?gIFAgMCAgIJAwQBBwMCAQEEBQEEAwECCgQEAwQCBAIHAgcCBAcCAQQGAwcGA?=
 =?us-ascii?q?QMCAQcBAQQKBAMDAwEBBwECBQICAwIGEgYHAgQBAwQECgICDAIHAQECAQEBA?=
 =?us-ascii?q?QIDAgcFDgEBAQMCAwYCBQICAQEDCAgDAgEEAQUDAQQFAwcCAQUJAgkDAwEIA?=
 =?us-ascii?q?wEBBQEDAQkDAwMCCQMBAgICCwQDCAMDAgMEAgICAgEDAgcFCAQBBAoCAgIBA?=
 =?us-ascii?q?gICBAIBAxoBAgMFAgIJDAEEAgIDAQMBAQIIBAkEAgMEAgEBAwIBAgIBBQIDD?=
 =?us-ascii?q?QYBAQEBAgMDAQIDAQEGBwIIAjMWAQMDAgECAgICBQICAQIDAgINAQEBBAIBA?=
 =?us-ascii?q?gECBgEDAQICAwEDAQICBgIMAwkCAQcBBQMDAgIDAQEFEAIEAgEEAgECCQUCA?=
 =?us-ascii?q?QEBBAEDBAQIAgIBAwMCDgIEAQQBAgEBIwMEAgMCAgMXAQIBAgMDAwQGBwYCA?=
 =?us-ascii?q?QITAQIBAQEFAQIBAQQCBAQHCgMCAgIGAwMFAQECAwIBAQEHDAICAhMCBAoJA?=
 =?us-ascii?q?wEGAQoGBhUDAgQCAgECAgIKAwECAgEDAgkCAQIBBSUDAQEPJAEBAgIBAgIDB?=
 =?us-ascii?q?AcCAQQHAw0DAgEBAQUGDQMCAwgMAgMLAwIBAwMFAQICAgQBAgQMCgECAwECA?=
 =?us-ascii?q?gQFBQMDAgIIBgYnAQEFZwOXRTtMOIEmIVigI6AKNAeDTIE7BgyeNzGoU5Zjp?=
 =?us-ascii?q?xIQIxKBQ4F+TSNQMYI3TgECAQEBDQECAQEDAQIBAgkBAQKSD4pgQjE7AgYBC?=
 =?us-ascii?q?gEBAwmNBwEB?=
IronPort-PHdr: A9a23:YZ5NzRwLENwEMVnXCzLEw1BlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 heZuagm1AaBHd2Cra4e0ayO6+GocFdDyK7JiGoFfp1IWk1NouQttCtkPvS4D1bmJuXhdS0wE
 ZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZrKeTpAI7SiNm82/yv95HJbAhEmjSwbal9I
 Ri2ogndqtQaipZmJqot1xfFuHRFd/pIyW9yOV6fgxPw7dqs8ZB+9Chdp+gv/NNaX6XgeKQ4Q
 71YDDA4PG0w+cbmqxrNQxaR63UFSmkZnQZGDAbD7BHhQ5f+qTD6ufZn2CmbJsL5U7Y5Uim/4
 qhxSR/ojCAHNyMl8GzSl8d9gr5XrA6nqhdi2IPffp2bO+RicaPcZdMaRHROXsBNVyxaH4iwa
 5IDA/cdMepEqoXwoUYFoxmjCgm2HO7gxTFIiX3206M00OovDB/I0xA7Et0UrHjZts/4OLsOX
 e23yqTD0DXNb+lR2Tf48IXFbhQhru+XXbJra8XRz1QgFxnCjl6Nt4HqJSmV1uEMs2id9eVgS
 eOvgHMgpg5rpjig2NwsipLTiYIT11/E7yJ5zJwpKtKiUk57ZN+kEJ1KuCGGNot7WcwiQ2Ryt
 yY7zr0Ko4K0fC8PyJk+wRPUdvOIfZSS7B35SOaRPSl3hGhjeL+niBu/81Stx/D+W8Sp31hEr
 iRLnNfDu30J1RHe5MaJR/p980mu2TuC1ALe5+FEL0wqkafVK4MtzqA0m5cPvkrOHyn7k1j1g
 q+Obkgo5PSk5uD9brjlppKQLZF4hh/jPqg0h8CyA+U1Pw4TVGaB4+u8zqfs/UjhTbVKkPI2l
 q7ZvYjfJcsBp665BxZZ0pgg6xqiFjum3skUkHsGIV5fdxKHiI/pO17KIP/mF/uwn1OskDJzy
 /DHOL3uHInNI2DdnLv9ebtx8U1RxQopwdxB+Z5YF6sNLO/xV0LwrNDYCwU2Mw2ww+bpEtV90
 YYeVHqVDa+dLqzSqkSI6fgpI+aRfo8VvyzxJOQ/6P70iH85mFkdcrO13ZsWc324EfFmLF+YY
 XromNsODWAKvg8mQOzsk1KNSSRTaGqqX6Ig+jE7D5qrAZnbSoC3nLOBxDu7HoFRZm1eDlCDC
 3npeJ+AW/cIcy+TI85hkjkfWri7UYAtzxCutAngy7pmNOXY4CMYtYj72Nhv++LTjQ0y9SBzD
 8mFz26NSH17kX8JRzItx6B+oUl9yk+Z3qRigvxYE8ZT5/JTXQsgO57c1b8yN9eneB/Ff97Bb
 F+5S9GiSWUzU9YwypkKall0H9GKjxbZ3iPsDaVDxJKRA5lh26bRxGP4IcpnzD7t3bMkjl8vX
 soHYWSii7Vk/g7fHYmPmEyDkqesfLgd9CHI/WaHi2GJuRcLA0ZLTazZUCVHNQPtptPj6xaHF
 uf2YVxGGg5IyMrZb7BPdsWsllJeAvHqJNXZZWu13Wa2HxeBgL2WP8LxY2tI+iLbBQAflhwLu
 26cPF03Aiq6uGvYACZpU1nmeUbt9+BiqVu0S0Y1y0eBaEgyn6Gt9EstjOeHA+gWwqpCvS4gr
 ztuG1Po1tbbEMGJoQZ7e+NXaMk44VFOyWPxuAl0P5jmJKdn1RYFawoimUTo2l1sD5lY18gnq
 HR/1A1pNaeRy09MbRud1JH0f6PUcyz8pU/xLaHR3V7a3ZCd/aJnBO0QjVLlsUnpE0Mj9y4iy
 NxJyz6H4Y2MCgMOUJX3W0Jx9h5gpricbDNvr4XTnWZhN6W5qFqgk5ogGfclxxC8ftxeLLLMF
 Qn8FNcfDtSvL+pikkagbxYNNuRfvKAuOMbue/yD0a+tdOFu+VDuxW1D7Ztm20SA7S06QefS2
 pcDyu2Z9gSCXjb4ylymt4G/mIxJYy0TAnvq0TLtV+szLuV5eYcGD3vrItXinI0vwc6wHSQCr
 Rj6WA1Vva3hMQCfZFH8wwBKgEEeoHj83DC90yQxiDYx6KyWwC3Jxe3mMhsBIG9CAmd43jKOa
 cC5ic4XWE+wYk0njhygsAzzw6VAv615I3PUB0xBZS33KWh+U4O/s7ODZ4hE75Zi4kA1GKysJ
 EuXTLLwuU5Q2ifuBHBXwjwhcHehs4/8nhpzlGO1I3N6rX6fcsZ1j0S6hpSUVbta2TwIQzN9g
 D/cCw2nPtWnyt6Tko/KruG0U2/JuoR7SSDw1svAsSK64TYvGhijh7WoncWhFwEm0Cj93t0sV
 CPSrR+6bJO5n6i9NOtmeAFvCjqeo4JzHoxliYI2iIsXn3MTnJCU+3MbkE/8NNxa3eT1a39FS
 TMQwtHT6RTowwU5diPPl9+/DC/EhJI+OZGzeQZ0kmol4tpPCbuI4bAMhiZzrlei7ErQbfV7g
 jYB2K4r4X8ejfsOvVlIrG3VCbQTEE9EeC30wk7Qvpbu8eMNPj/pKOfuhy8c1Zi7AbqPox9RQ
 iP8c5YmRmpr69lndUnLyDv1453lf9/ZaZQSsAeVmlHOlbswStp5m/wUiC5gIW+4s2cizrtxh
 BhjxoqzuoSdLCNm9bi8AxhRKjzdaMYa+zWrhqFb1JXzvcjnDtB6FzMHUYG9B/usHSkJvPLrL
 QHIGzQmr3adEKbeNQCa4UZi6XnIFtr4UhPfbGlcxtJkSh6HIUVZiw1BRzQ2kKkyEQWyzdDge
 kN0tXgBo0T1oRxWxqd0JgHyBy3B8RywZG5+G/39ZFJGqxtP7EDPPYmC4/JvSmtGq4a5olXFK
 3THNV8VSzhYAgreWw+lZv70uZHB67TKWLb4daCVJ+zQ8aoGEK7ZoPDnmop+o2TSaIPWZiMkV
 7tjnRAbFXFhR5aHxXNVF31Rx3qLN4nB/F+94nEl8Zr5qaitAVO1o9PIUus3U50n+gjq0/jfc
 bfK2WAhb24fj81ExGeUmuFHjBhL1H4oJ3/1Vu5Z/S/VEPCJxfQRVk9HLXs1bIwRscdelkFMI
 ZKJ0IukkO4lyKdvWxEdEgW+0sCxOZ5Qej/7aQOBXRfRcuzBfGyDwtmrM/nlF/sK17QS7Ef24
 XHCQiqBdnyVnj3tHXhDKMlqiyeWdFxbsYC5KVN2DHT7Ccnhclu9OcN2ijs/xfs1gGnLPCgSK
 2o0dUQFtbCW4S5C55c3U2Vc8npoK/WFkCeF/qHZLJgRq/5iHiVzkapT/n07z7Jf6CwMSuZyn
 WPeqdtnolfulefqqHIvSB1VtjNCn56Gp21nMKTds4dDADPKpU1Tq2qXDBsOqp1uDdiu86Fcx
 97Tlb7ifTdP99WHmKlUT8PQKc+BLD8gKU+zQG+SXFZDF2TycziA2R848rna7HCeo5kkp4K5n
 ZMPTuQeT1kpDrYBDVwjGtUeIZBxVzdikLiBjcdO62DtyXuZDMhcoJ3DUeqfRPv1LzPMx7BAa
 gATyLX0N4NVPYTh3k1kY0V7tIvPEkvUG9tKp2cyC2186FUI63V4QmApjgj9bRix5XYICfOut
 hs/iw87f+d0sTm1vAlxKV3Nqy891kI2nJ+25FLZOC60J6C2U4ZMDiPyvEVkKZL3TTF+agiql
 FBlPjPJL1q+p7RlfGFvzgTbvMkWcRa9ZahNYRtV2/LOIvtxjgoapSKgyktKo+DCDMk6/OPPW
 ZGppnNEnQlkaYxtTZE=
IronPort-Data: A9a23:M5GvQ6D9q8hurBVW//Tlw5YqxClBgxIJ4kV8jS/XYbTApDlwhWRTz
 mRMCzrXaPuCZGKheo92at++oE9TvZKBx9JnOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6j8lkf5KkYAL+EnkZqTRMFWFw0HqPp8Zj2tQy2YXgWlvU0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYoxWXxvty0
 ulVjpiPeQZ5GbWcu8MgQgYNRkmSPYUekFPGCX22sMjW0U6fNnW1nKsoA0YxMokVvO1wBAmi9
 9RCcGFLPk3F3bjvhuvkFIGAhex7RCXvFIobt2p7xDfVF/FgSpnZRqTM7MNZ9Dg1j8FKW/3ZY
 qL1bBI2N0ueOEYSYT/7DrougN+svjqmaAFUg1WEhohu4HH+6xNuhe2F3N39I4TWH625hH2wo
 mvZ9mD9KgMbMdaFwHyE9Gitj6nBh0vTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTnBWioku3WtYaN
 U9NvyR38vZ0+0usQd3wGRa/pRZooyLwRfJwDbQR6xux0pHQ3DaYVk8cHh1mVc054ZpeqSMR6
 neFmNbgBDpKubKTSG6A+rr8kd9UEXhERYPlTX9UJTbp8+UPs6lo0U2SFocL/Lqdy4yqSWupk
 lhmuQBn3+1L5fPnwZlX6rwuvt5Bjp3ATwpw+AaOG2z8sV0/a4miaIilr1Pc6J6szbp1rHHR5
 xDoeODEtIji6K1hcgTTGI3h+5n3v5643MX02wIHInXY323FF4SfVY5R+ipiA0xiL9wJfzTkC
 GeK514LvscMYCD3N/4nC25UNyjM5fixfTgCfqCEBueinrAsHON61HozOhbPhz6FfLYEyPhna
 c/znTmQ4YYyUPw7llJats8S1rgkwi1W+I8gbcGT8vhT6pLHPCT9Ye5dbjOmN7llhIvZ/li92
 4sAb6OilkQHOMWjM3K/2dNCfTgicyJnbbio8Jc/XrDYcmJb9JQJUaC5LUUJINw7wcy4V47go
 hmAZ6Ov4ACh2iebeV7aOhiOqtrHBP5CkJ7yBgR0VX7A5pTpSd/HAH43e8RlcL852vZkyPIoH
 fAJd9/RUPtKQzXDvT8aaMCl/oBlcR2qgyOIPjakMGBvJc4+G1SR94+2ZBbr+QkPEjGz6pkzr
 rim4QXRHsgOSgFkO8DJZa/91Fi2p3UcxLl/UhKQcNlecUnh6qZwLCn1gqNlKs0AM0SRyT6T1
 gLQChAd/LGfr4gw+djPpKaFs4b5S7skThQGRzHWtO/kOzPb82yvxZ57fNyJJT2NBnnp/KiCZ
 PlOy66uPfACmmFMudUuHrtuy5U4+IKz9bJXywJTHELLYU6uPbVuLyTUxsJIrKBMmuZUtAbqC
 EKC/t5WZeeANM//SgJDIQMkaqGd1qhRlGCNs7I6J0L14CIx972CCB0AMx6JgS1bDb10LIJ1n
 rt76ZBOs1Sy2kgwL9KLriFI7GDQfHYOZKMq68MBC4jxhwt3l1xPPc7GBint7M3dYtlAKBN2c
 Dqdha6HmbcFg0SbLCR1Gn/K0u5Qw58JvUkSnlMFIl2InPvDh+M2jEINq2VpFlwNw0UVyf93N
 0hqK1ZxefeE8QBuiZURRGurAQxAWECU90GZJ4HlT4EFo5REl1AhLVHR/c6I9UEdtnxfJ31Vp
 e7GjmniVjnucYf62S5atYuJbRD8ZYQZy+EAsJnP8we5810Sbj/sg6vobm0Nw/ciKd1kn1XJ/
 IGG484pAZAW9kcsT2kTBIyT1LBWQxeBTICHrTeN44tRdVzhlPqONfRi5qx/lg6h5xAHzKNgN
 /FTGw==
IronPort-HdrOrdr: A9a23:3nIQcKErqUia2mEypLqE18eALOsnbusQ8zAXPo5KOGVom62j5r
 iTdZEgvyMc5wxhPU3I9erwWpVoBEmslqKdgrNxAV7BZniDhILAFugLhrcKgQeBJ8SUzJ876U
 4PSdkZNDQyNzRHZATBjTVQ3+xO/DBPys6Vuds=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,216,1647298800"; 
   d="scan'208,217";a="13763353"
X-MGA-submission: =?us-ascii?q?MDH1EdEUqsns6vRmW5V5y2EH33GV6ZOrVvoluy?=
 =?us-ascii?q?teQ3A1zk6kjMg0Cok+EEB/AUZrBzZtxkb0VooIV/dhQAmE0CCL37HhGl?=
 =?us-ascii?q?qjXRXZjeQhQ+eXDG8DdVbdB58zXoVpjT5tPeB4053GjoRpOd0PuB7lr4?=
 =?us-ascii?q?BZaO6tE4bD4pn697hZfIqImw=3D=3D?=
Received: from mail-vk1-f176.google.com ([209.85.221.176])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 10:36:43 +0200
Received: by mail-vk1-f176.google.com with SMTP id t12so804364vkt.5;
        Wed, 11 May 2022 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PFEaGXuUsmHzj0CB0XjDLH0EVE6rI82uSOBBqyeiXfk=;
        b=OyWxSLwn6TJfVRS8oJfMn9f2NoTJ1V8K64vx0Guv9uaSYJiUIxZQG2xAW2dX77fLDj
         wyH1OmJKkLkzx0kAp0ZPLa8tikVvsMtzHH3/+4pzU67CKt9wl5pk0uTENPAJB0Tu/p8m
         Y/KIeU/dUlHia02ptulP6836RGE7jcd/Zjwkx0yMF3nEhDP+6AfEdqa+aX2OJN8XUaxe
         OaGIVdI66R4H/jsesRDZKeLycILsq2qPbqrMn+V7zdJAShHx84SCKcw+lHYuy0RpCyno
         nH6qlAXXriiH4YX0c5AZN03cLoDOtAY2rxUAvsdcJ92HqM37VKDKRtLa/AQkWv15+hMQ
         rv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFEaGXuUsmHzj0CB0XjDLH0EVE6rI82uSOBBqyeiXfk=;
        b=sfNvcFB6RrIPKyEn6h+MHmUQLxCf3OdvcOMHuHLRheetYftXT8rOHo2LFBM0HkFNWI
         3hq7GC5SPTtNOIxjbsrst9pR4iZaRTZVxmWOU3ppBSRzIZec039WpVPw4V24fBjqDUv1
         TDY5ycgQIB7LIc2n8AV68BEp80fT0M6yLCdY1JBgigcmwoUHNYKKjKZ2ar3Pfk6kMtqr
         ypHOX28WgHFNKEdTPZ1WefOz80par3fai+1NSYSwQYU1Jo5zSWc2qHDYX0INoZSiXqXl
         Jru+kQyt6OvIOPPY0OuCK+ohCWDgKWdRnW/Vij6mraxn9NNupyKQ5N+26OY1clPyNXZz
         GWhw==
X-Gm-Message-State: AOAM5326dquZ/sjn1LAzPNe1lfYihwaK32W/UA1nRMDCbVtim/k7rCEc
	fXVKIJuR5CCqpAUY/eZslqxNuW6wFhQnmPa4rudBsz9e8ec=
X-Google-Smtp-Source: ABdhPJwU7KZjCbvDNtD3ZyT1RwE9Z83XwT2E5BJwhI2BTxdNvYYRqiaKCCGgjcFwBGinkScd4nb6gbUFBPhgns7Z6+s=
X-Received: by 2002:a05:6122:910:b0:352:720e:de05 with SMTP id
 j16-20020a056122091000b00352720ede05mr13579772vka.7.1652258202499; Wed, 11
 May 2022 01:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2205091216530.2394@hadrien> <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com>
 <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
 <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de> <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com>
 <alpine.DEB.2.22.394.2205100957160.2667@hadrien> <CAPp5cGS+4snNh+8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101123120.2667@hadrien> <CAPp5cGQMuy3aM5cLYk4HH8Ny=uH_t2yhWasfmT2AS7M12YDiWA@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101236050.2667@hadrien> <CAPp5cGQzYtDVjE-K_Vpt3cbqYW-cwNTLmt_KwdpMdds9L7rXug@mail.gmail.com>
 <alpine.DEB.2.22.394.2205111011380.2811@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2205111011380.2811@hadrien>
From: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Wed, 11 May 2022 10:36:06 +0200
Message-ID: <CAPp5cGSVQ5YjQjfvjt3UwHmnRyJsrDEvt92bQoGyNewkAkNLEA@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: multipart/alternative; boundary="0000000000003cc62e05deb857ff"
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Alessandro Carminati <alessandro.carminati@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 382
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/CAPp5cGSVQ5YjQjfvjt3UwHmnRyJsrDEvt92bQoGyNewkAkNLEA%40mail.gmail.com>

--0000000000003cc62e05deb857ff
Content-Type: text/plain; charset="UTF-8"

Alessandro



Il giorno mer 11 mag 2022 alle ore 10:14 Julia Lawall <julia.lawall@inria.fr>
ha scritto:

> > It is a suboptimal version of Julia's last proposition.
> > It happens that in a file a statement I expect to be matched is not
> detected.
> > Troubleshooting the issue, I see a behavior that does not fit the model
> I have in my mind. This suggests to me that things (coccinelle under the
> hood mechanisms) are more complicated than I think.
> > back to the point:
> > Running the script and printing only the rule "rr", which is the same as
> "r" without positions, the results presents a set of entries containing the
> entry I'm interested in.
> > Running the same script but printing only the rule "excluded", I see
> that the result is an empty set.
> > Finally, running the script using only the "r" rule, the entry I'm
> interested in is not there.
> > Surprisingly (for me), removing the position constraints coming from the
> rule "excluded" (position q != excluded.p;) from the rule "r", the entry
> appears.
>
> You haven't provided tihs semantic patch, so I don't know in detail what
> it does.
>
It appears I do not know what a semantic patch is.
I was convinced that what I called the "script" included inline in the mail
I sent was the semantic patch.


> In my opinion, the rule excluded is completely irrelevant for this
> example.  The code that you want to detect is:
>
> const struct snd_soc_component_driver mtk_afe_pcm_platform = {
>         .name           = AFE_PCM_NAME,
>         .pointer        = mtk_afe_pcm_pointer,
>         .pcm_construct  = mtk_afe_pcm_new,
> };
>
> {
>         .name           = AFE_PCM_NAME,
>         .pointer        = mtk_afe_pcm_pointer,
>         .pcm_construct  = mtk_afe_pcm_new,
> }
>
> is not considered to be an ordinary expression, but rather as an
> initializer.  Everything should work find if you just replace E by ...
>

Indeed, replacing the E with ... solves the issue.
The explanation makes sense to me,  but why does the rule rr in the
following context matches mtk_afe_pcm_platform and presents the following
resulting set?
```
$ spatch  -sp_file  simple.cocci mtk-afe-platform-driver.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
HANDLING: mtk-afe-platform-driver.c
afe
dai
dai_idx
dev
hw_base
hw_ptr
memif
memif_data
mtk_afe_pcm_platform
num_dai_drivers
pcm
pcm_ptr_bytes
reg_ofs_base
reg_ofs_cur
regmap
ret
rtd
size
```
and simple.cocci is
```
@rr@
type T;
identifier i;
expression E;
attribute name __randomize_layout;
@@

(
 T i;
|
 T i=E;
)

@script:python@
i << rr.i;
@@
print (i)
```


> julia

--0000000000003cc62e05deb857ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" d=
ata-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><d=
iv><div dir=3D"ltr">Alessandro<br><br><div style=3D"display:inline"></div><=
/div></div></div></div></div></div></div><br></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">Il giorno mer 11 mag 2022 alle=
 ore 10:14 Julia Lawall &lt;<a href=3D"mailto:julia.lawall@inria.fr" target=
=3D"_blank">julia.lawall@inria.fr</a>&gt; ha scritto:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">&gt; It is a suboptimal version of Ju=
lia&#39;s last proposition.<br>
&gt; It happens that in a file a statement=C2=A0I expect to be matched is n=
ot detected.<br>
&gt; Troubleshooting the issue, I see a behavior that does not fit the mode=
l I have in my mind. This suggests to me that things (coccinelle under the =
hood mechanisms) are more complicated than I think.<br>
&gt; back to the point:<br>
&gt; Running the script and printing only the rule &quot;rr&quot;, which is=
 the same as &quot;r&quot; without positions, the results presents a set of=
 entries containing the entry I&#39;m interested in.<br>
&gt; Running the same script but printing only the rule &quot;excluded&quot=
;, I see that the result is an empty set.<br>
&gt; Finally, running the script using only the &quot;r&quot; rule, the ent=
ry I&#39;m interested in is not there.<br>
&gt; Surprisingly (for me), removing the position constraints coming from t=
he rule &quot;excluded&quot; (position q !=3D excluded.p;) from the rule &q=
uot;r&quot;, the entry appears.<br>
<br>
You haven&#39;t provided tihs semantic patch, so I don&#39;t know in detail=
 what<br>
it does.<br></blockquote><div>It appears I do not know what a semantic patc=
h is.</div>I was convinced that what I called the &quot;script&quot; includ=
ed inline in the mail I sent was the semantic patch.</div><div class=3D"gma=
il_quote"><br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
In my opinion, the rule excluded is completely irrelevant for this<br>
example.=C2=A0 The code that you want to detect is:<br>
<br>
const struct snd_soc_component_driver mtk_afe_pcm_platform =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D AFE_PCM_NAME,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .pointer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D mtk_afe=
_pcm_pointer,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .pcm_construct=C2=A0 =3D mtk_afe_pcm_new,<br>
};<br>
<br>
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D AFE_PCM_NAME,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .pointer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D mtk_afe=
_pcm_pointer,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .pcm_construct=C2=A0 =3D mtk_afe_pcm_new,<br>
}<br>
<br>
is not considered to be an ordinary expression, but rather as an<br>
initializer.=C2=A0 Everything should work find if you just replace E by ...=
<br></blockquote><div><br></div><div>Indeed, replacing the E with ... solve=
s the issue.<br>The explanation makes sense to me, =C2=A0but why does the r=
ule rr in=C2=A0the following context matches mtk_afe_pcm_platform and prese=
nts=C2=A0the following resulting set?<br>```<br>$ spatch =C2=A0-sp_file =C2=
=A0simple.cocci mtk-afe-platform-driver.c<br>init_defs_builtins: /usr/local=
/lib/coccinelle/standard.h<br>HANDLING: mtk-afe-platform-driver.c<br>afe<br=
>dai<br>dai_idx<br>dev<br>hw_base<br>hw_ptr<br>memif<br>memif_data<br>mtk_a=
fe_pcm_platform<br>num_dai_drivers<br>pcm<br>pcm_ptr_bytes<br>reg_ofs_base<=
br>reg_ofs_cur<br>regmap<br>ret<br>rtd<br>size<br>```<br>and simple.cocci i=
s<br>```<br>@rr@<br>type T;<br>identifier i;<br>expression E;<br>attribute =
name __randomize_layout;<br>@@<br><br>(<br>=C2=A0T i;<br>|<br>=C2=A0T i=3DE=
;<br>)<br><br>@script:python@<br>i &lt;&lt; rr.i;<br>@@<br>print (i)<br>```=
<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
julia</blockquote></div></div>

--0000000000003cc62e05deb857ff--
