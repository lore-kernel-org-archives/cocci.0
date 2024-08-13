Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3085EC52D7B
	for <cocci@archiver.kernel.org>; Tue, 13 Aug 2024 06:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3KYqCO05nh6hYks8s0W7RR6F8mCDuiymOaXkbv6QzZk=;
  b=FleZ8W3mOfAJQ/8dsJ+FmyUHmltK4SSjXTdEE9TLXxsCdMUbQuRSz+i7
   VIpTqXXKcWyBfB/IE3WpWgk0xdR8ggCvXZLSdmfQ9TnWJUCTbyrLXwFni
   15iCLc49fGtQE1sy5UEc13XVFI7pFovOVS4vfXNKGndfucm0q7+MoHUhM
   U=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208,217";a="178839182"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Aug 2024 08:28:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3D301E013D; Tue, 13 Aug 2024 08:28:01 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7C62FE0035
	for <cocci@sympa.inria.fr>; Tue, 13 Aug 2024 08:27:57 +0200 (CEST)
IronPort-SDR: 66bafceb_gUUmAJ68GPdKz3HDzpub7t12G9q6w8mJZVyBRt0bUfKhOh1
 cL75bHkuEU32qAuimELik1t6nNHQDN1n8hmAK8w==
X-IPAS-Result: =?us-ascii?q?A0EyAAAV/LpmhjLYVdFaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AYBAQsBgkN9WTQEC0iEVoEjjiqCJZc8hlYUgSw+DwEDAQ05CwQBAQMEhH8Ci?=
 =?us-ascii?q?WQCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBI?=
 =?us-ascii?q?RkHDjuFdQ2CYwGBImECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBBQINH14BAQEBAgESEQQZARsdAQMBCwYDAgQHCgMqAgIhAREBB?=
 =?us-ascii?q?QEcBhMigl4Bgi8BAw4jAxGSKI80gQVCikF6fxYFAhaBAYINBtpaChkoDWwDg?=
 =?us-ascii?q?WACAQYUgTQBhHIpW4I3HQGBXAIOh3V6J4FkRIFKgnU+gkqBP2eDLoJpBJIUh?=
 =?us-ascii?q?WNxhSAliWaIYyYIBxcDBwcJBQQJEwYFBQJCCQUBDxIDBAMEBAECCwkKCQMDA?=
 =?us-ascii?q?g4CCAMCCAYOEwE/EgQTCg0LAwYFHwgCBAcMEQoXAgMDAgIDAgUDAwUFBQIDB?=
 =?us-ascii?q?QMEAwUDAwIRAQYCBQ0IBgsFBQcCBgIECAUCAgMDAwIEEAMDAwIFAgIDAwECB?=
 =?us-ascii?q?g8GAgIDBQYDAwMDAwYDAwIGAwMCAgMCAwEDAgMBAgMCAgIIAgIDBQQFAgICB?=
 =?us-ascii?q?AgTAgICAgMDCAMDCgQCAgQBBAIEAgQCBgIEAgIBBgIDAwIDAgcCAgQCAgICA?=
 =?us-ascii?q?wIEBQIDAwMCAgIBCQIFAQEGAgMDAgMFAwkDBAUCAwgBAQICBwcDAwQDAQIBB?=
 =?us-ascii?q?QQCAgYFAgMCAgQCBAUDAgMGBgIBAwIKBgMFAwMDAwIDAgMDAgUCCAICBAQFB?=
 =?us-ascii?q?AIFBAIEAwMDAQoCBgMCAgUBAQICBQMCBAQHAgIHDwMCBwUCBQUFAgcBBgUCA?=
 =?us-ascii?q?gMCBgECAgYBBgIEAQINAQECAgMBAwMDBwIEAwIIAgMDDwEDAwkGBQQFBAMJB?=
 =?us-ascii?q?A8CBAEIAwEBBAgCBAMCDAICIAIFCwQEGggDAQEDAQECAgICDQMCAwICAwoCA?=
 =?us-ascii?q?wIKBgQCBAEBAQQEAQQCAQIHBA4JBQgIAQMCAQQGAQIQBRAJAwcEAhAGCgUDA?=
 =?us-ascii?q?gMFAQUVAwgDAgkCBAwDBQgCAwIGAwYCBgEGAwcLAQEHCAUDAwMCFwECAg8IB?=
 =?us-ascii?q?AYPCAIDAwMDCgMSAgYOAwMCAwIBAgICAwUEBQIHAwMKBQIIAwIIBQMHCQQKA?=
 =?us-ascii?q?goCBgMCAgICBQwBAQEBAgMCBQMHBwgIBAUEAwEBBgYMHgICAwQPAwkDBgsBB?=
 =?us-ascii?q?QUBAwICDgMGAgMGBgEJBAEFBAkCBQcGBQIBFAcPBwUCCgIHAgICAwECCAkIA?=
 =?us-ascii?q?gMCCgQBDgQZAgUBAgIDBwIDAhMDAwUEBgMCAgICAwIBCgsDAgIDAwMDBQUDA?=
 =?us-ascii?q?hkDAwIBCgUMBQQDBAICAR0DAQUCAwoBBQkBBgICAwIFAgMGBAIEAQ4BAQEDB?=
 =?us-ascii?q?gsJFAICAgkIAwgDBQ0CDQIDBQICCz0LBQEBBAMBCAEXLQIEAgYMAQEBAgMGA?=
 =?us-ascii?q?gICFQUHAwUDCAEDAQITCAYCAQMKCgICBAIGAwMCCgMBCAICAg8DCQIHAg0CA?=
 =?us-ascii?q?gMDDA8EAwMDAwgCAgIRCQoCAgIMBAoCCQICAwYBAgMDBQMCAQEBBC8CBAcBA?=
 =?us-ascii?q?wYKAwICAgkICgkDAwUDDAEGBAECAwwBAQITBAkDAgECAQEGCAEBAgQBBAIIB?=
 =?us-ascii?q?gICAgIKAwUDAgMFFQUEAgIZAwQFAwUDAwQHAQIFBAsJAgUDAgQDAwIEBAIIB?=
 =?us-ascii?q?QkEAwsGAQEBAwQDAQEIBwcDAgEBAwEBCgsIDQgDCAMGCQMBBgEBBRIIAgMOA?=
 =?us-ascii?q?gICAwIBCgYIBQIDBg0CBAIZAQwDAQMDBQ4EFAMEBQICDwwBAgMDBAUDBQICA?=
 =?us-ascii?q?gMCAgIFBAECBAIEAQgECQECAgIDAgEBAgIEBgUCAgIDAgcMBwMEAgYCBgIDA?=
 =?us-ascii?q?gcLCwIDBgUFAwUCHgIDAgIEAwMYAQEDAQIBAgMCAgMCAwQBAwMCAQEBAQEBA?=
 =?us-ascii?q?wcCAgIEAQEBBAYFAgIDDAIDAwEBBgEDAQIPBgUGBAEKAwIUAwMiAg8FCAEoA?=
 =?us-ascii?q?QQCAgECNwICAwQNCAUCAgcCBAwCBA8FAwMOBxYGAQQIBAUEBAwKAwYOBxcRA?=
 =?us-ascii?q?QEEBAIIBAICDQcCDAICBgQCAQMHIwYDBQkDAgUFEAICDQIEAwUUBAQbAwECC?=
 =?us-ascii?q?gICGAIBBwECFAICBwICARQCCgQCBwYHAh0CAgEDBwQEAQkfAwgCBwIBBQYFA?=
 =?us-ascii?q?QEEEgECAQIBAQIDAxEBAgIDAwICAQkCAgEBAg0IAQQDBgIFAwUDCgEBAQIBB?=
 =?us-ascii?q?AkEDwYDBQMDBwMEAgMCBgIEBAICAwMCAwEGAwIBAgMJAgEREQoPAgIDBAIGA?=
 =?us-ascii?q?gIBBC8EARUFAgMEAgIHAgIDAQIBAgICBAIFAgIGAwkIAQICCAMBAgICBRYCB?=
 =?us-ascii?q?QEECQMDBRUNIwMDAQICAgMHCgMFAgEBAgQDBQMDAwwNBwIDAQIBAwUDAQIBA?=
 =?us-ascii?q?gkDBwICAwMFEhkFAwILCQMCAQUEAgkUCwoBARIqHQIJAyMPAwsJCBM9AQsHM?=
 =?us-ascii?q?gQ0ARQUByshX6UjgVoBgjw+faVBoxcHhBeMFJU/M6pBmG+Ne5sMESMSgTQBN?=
 =?us-ascii?q?4FcMxojUDGCNk8DGQ+ISoVXGYNhhRTGfEQyOwIHAQoBAQMJix2BSwEB?=
IronPort-PHdr: A9a23:a8WzlR1dNTZPJNnpsmDO5A0yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BeHo6w11RSQBdqTwskHotSVmpijY1BI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDebRlEiCCgbb9uM
 Rm6ohjdutUUjIB/Nqs/1xzFr2dHdOhR2W5mP1WfkQri6Myt5pBj6SNQu/wg985ET6r3erkzQ
 KJbAjo7LW07/dXnuhbfQwSB4HscSXgWnQFTAwfZ9hH6X4z+vTX8u+FgxSSVJ8z2TbQzWTS/8
 6dmTQLjhSkbOzIl9mzcl9d9h7xHrh2/uxN/wpbUYICLO/p4YqPdZs4RSW5YUspMSyBNHoawY
 o0SBOQDIOlYtZHwqFQArRS8BQeiCuDhxCJWiHLowaI3yP4uHR3c0QE6A94CrHbZodPoP6kSS
 +C1y6zIwC3ZYfxIxTfy9pLIeQ08r/6SW7Jwd9DewlQxGQPeklqQqZHlMC6U1uQLrmOW6PJgW
 vyzi2E5sQF9uCOvydkqionPnI0Y0V/E9SBjz4Y0Id20UlJ0YdmhEJZJsSyRKoR5TN84TW5yp
 CY61qMJuYS9fCUSyZkqyR/SZv2JfoWV4h/uVeacLzdkiX97er+zmRK//0evx+PySMW5zkhGo
 zRGn9TNuX0A1hze58yHRPdg8Emv2TCC3B3d5OFDJEA7j6vbK5g5z74+jJocr1rMETLol0Xtj
 6+WakIk+vCy5+TgeLXmqZmRPJJ3hAHmKqkihNCzDOAiPgUNX2WX4/qw2KDi8EHjQLhGkvs7m
 bTHvZDeOMQbvbK5DBFP0og+6ha+Dimp3cwEkXQBMVlLYgiIj5LzNFHLOP34Demwg1CrkDpzw
 vDJJLzhApHUInjbkrftYK9x60BcxQYv19xf6JVUCrYOIPL3RED9rsDXDhg8MwCswubnDsty1
 p8GVG6RHqOUNLnevFyI6+41PeWAeY4YtCz9JvQ5//LuiGU2mV4Zfamnx5sXb3W4E+x+I0qHf
 XrjnM0BHX0RvgUgSuzqjkeNXCVcZ3a3Ra085zU7BJi6AofEQ4ChmLqB0zyjEZ1Mem9GEkyME
 Wvvd4icRfsAcDiSLdN5kjwYSbihTJcs1RW0uw700bVnKu7U9zYZtJLi0dh6/PfTmgso+Tx1C
 cSdyWCNQHtukmMGXT86xLp/rlBlylefzah4hORVGsBU5/xVTgg6NIXRz/d6CtD3QgLOZM2FS
 FegQtW8ADE+VMg9w9EUYxU1J9L3rA3H3iPiJ7YKnriPTMg276bd1j71Ltl0z3Lu1a87jlBgT
 NEZZkO8gasqzwXPCpSBqEifka/iSb8X3DPB9WHLmXKDoExCFhV9V6PMdX8ab0rS69/+4xWRH
 PeVFb07P14Zmoa5IaxQZ4is1A0eLB+CENHXYmbq3ny1GQ7N3bSUKozjZ2Qa2izZTkkCiQEau
 3icZkAlHin0hWXYAXR1EE73JVv2+LxmpW+2VAkvwgeMZmVu0rO0/lgegvnPA+gL0Oc8sTw64
 y5xAE772tvXD9SaoA80ZKhAbMl7+1pB02vxuAl0P5jmJKdn1RYFawoimUTo2l1sD5lY18gnq
 HR/1A1pNaeRy09MbRud1JH0f6XVcyz8oUjpZKnR1VXTlt2R/8/j8dwerFPu9EGsH0smqDB81
 sVNlmCb/tPMBRYTVpT4VgA28QJ7rvfUeHt14YScznBqPaSu112Kk9s0GOsozAqhdNZDIeuFE
 gH1CcgTG8mpLqQjhVGoahsOOO0a+rQzOouqcP6P2ajjO+gF/nrulWlb7Zo7yU+K8SNURevB3
 pJDyPadn0OGWzr6kFa9o5Xvg4kXLToWH2e51W3lHNsLPvw0LdtNUz7wZZDvlbAcz9b3VnVV9
 UCuHQYD0c6tIl+JakDlmBZXzQIRqGCmni2xy3p1lSsop+yRxn+roayqeRwZN2pMXGQng03rJ
 N3+l90GUVLudAUvkhKN6kPzxqwdr6N6ZTq2Iw8Ab23tImduX7Hl/KKPf8NVrogltyNeeOu5a
 FGeDLX6plFJtkGrV3sbzzc9eTawv5z/lBEvk2ORIkF4q3/BcN1xzxPSjDDFbcZYxSFOBCxxi
 D2MQ0O5I8Hs5tKM0ZHKruG5UWulEJxVayjii42a5mO34mhjABv3mP7W+JWvCQUm3DW9zNRsU
 yzgoxP1Y42t3KO/ee5qZUhnAlbg5tEyQNkv1NttwstJhz5H3t2c5jIfnH32MMlH1K6bDjJFX
 jMNz9PPoUDk1EBlMnOV1tf8X3SZzNFmYoryaWcX1yQhqsFSXf3MvfoUwG0v+wT+8FqCBJo11
 i0QwvYv9nMA1uQAuQ52iz6YHqhXBk5AeyrlixWP6dm66qRRfmemN7aqhy8c1ZisCq+PpgZEV
 TP3YJAnSGVo49lyKhTX3Xv146nrfdDRaZQYsRjewHKix6BFbYk8kPYHn38tIW/hsGdj0OM9i
 xVG0pSzvYzBIGJotvHcYFYQJnj+YMUd/SvohKBVk5ON3oyhKZ5mHy0CQJriSf/7WCJXr/nsM
 ByCVSEtsnrOU6SKBheRsQ01yhCHW4DuLXycI2MViMlvVAXIblIKmxgaBX07hsJrTV3snZ25N
 h0luXZJoQSk4hpUlrA2a1+lCTyZ/VnwLG9zEcn6TlIe7xketRmLd5XGtKQrWXkfpMXprRTRe
 DLFIV4UXCdZAgrcQAq7dri2uYufqa7BWqznfqGIOfLX+Yk8H7+J3c79jdcgpmzRcJ3JZj47U
 bU6whYRBCgpXZ2GxHNfDXRQzXuFbtbH9k7joWsu/5z5qLKzH1uxgOnHQ7pKbYc1o0Hw0frFb
 rTAwn4+cGkQ14tQlyWRlv5CjBhL2nsoL370QPwBrXKfFvuO3PUMXlhAMWUrc5IZisB0lh9EP
 cqR4j/s/ph/iPN9S1JMVFi639qsedRPOGalclXOGEeMMr2CYzzN2cD+J62mG/VWi61Puhu8t
 Cz+cQerNymflzTvSxGkMP1dxCCdMhtEvYihcxFrQWH9RdPiYxe/PZd5lzozibEzg3rLMyYbP
 10eOwtVqaaM6CpDnvhlM2lI734gNevd3ijEt6/XLZEZtfYtCSNx1qpb7Hk817pJ/XRESfhyy
 06w5pZlp1CrlPXKyyIyCkIf7GYWwtjS4wM/Yfa8lNEIQ3vP8RMT4H/FDh0Lo4AgEdjzo+VLz
 cCJkqvvKTBE+taS/M0GBsGSJtjUVRhpeRfvBjPQCxMICDCxMmSKzVRQjPyIsGaYqJ4zgpfpk
 ZsKDLRcURZmc5FSQlQgB9EELJptC3k8lqWHiccT+XekhBzYRcEfppKeE/zPWbPgLzGWibQCb
 BwNi+CdT8xbJsjw3EpsbUN/lYLBFh/LXNxDlSZmaxc9vERH9HUWpoIb1Efsawfr63gWR6fcd
 v8ejwJ/ZaE19m6p7QpvYFXNoyQ0nQ86ntC32Vh5lRb+Ka6xWcddDC+m7yAM
IronPort-Data: A9a23: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
 vVALpTw6Ilp6Kyc5VFO9Tg0xg==
IronPort-HdrOrdr: A9a23:Ktt+ya2Aj1Z11Mhjm2OncwqjBGgkLtp133Aq2lEZdPWaSL3hqy
 nOpoVh6faQslwssR4b6LS90cW7MBbhHNtOkOss1NSZPDUO2lHYS72KhLGKq1bd8m/Fh41gPM
 xbAs5D4bPLfCFHpPe/zw+iDd46zdWLtIyuj/zP1mpgQGhRB52ILD0XNu9YKCBLrcV9a6bR3a
 D82vZ6
X-Talos-CUID: 9a23:qElQtG5vqvGgcNlv+Nss8kE9IMI5aSPm7Vz+CGn7CjdKQu2FYArF
X-Talos-MUID: 9a23:2lYnGAV1+SRS8YXq/CfpuxU9NMZm35+zCRFdlZVXovK5CyMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208,217";a="93996435"
X-MGA-submission: =?us-ascii?q?MDHpy00d4AKvJ1Kq8k6cGPsJxtIvY6k8jLFBpG?=
 =?us-ascii?q?znRZLYS90E7WpmHZP0yUmkCDHCX2+WXw8iwtTlBcu+INEY/dm4sgFxj4?=
 =?us-ascii?q?jNY1/ckGfIjnJYSP2l3BurXARhMIIZFijFRe/UqpZBRfGJzy32eNXlAb?=
 =?us-ascii?q?yK5XeDCuxooCD53v8+aMt9WQ=3D=3D?=
Received: from mail-pj1-f50.google.com ([209.85.216.50])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 08:27:56 +0200
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cfd1b25aaaso3375181a91.0;
        Mon, 12 Aug 2024 23:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723530472; x=1724135272; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3KYqCO05nh6hYks8s0W7RR6F8mCDuiymOaXkbv6QzZk=;
        b=fkjxJD7AZzTC4Ar/G6lQlz5/F0IRWY0NduBOyPD/h/Hey/rQjNksMhiRdeCDRchttD
         +GkV+bg0P6sRKQ2gKshaBzphGgduuU/IEWB0vR/T8m2Kw+vmfR6mCP+aa3TP/Zjp1gz6
         nZMhuviGRYAqw+tquWouXfG0/V/dirKmEaBYqMT3x/DEAtgNlH8miPoclSGahSPX7j0K
         f6pttZoMUzQsNxO4wLcciby2udNDvf979JqJEup3jtfmJBkbai/sL6wTFrD82DzxvfN4
         sMeLKGAIkEopfZy6ekAIjNZjHDjja13Yy2CAnSxgwuX3nuid6utTX2U6d41apZ9uJQ2h
         JqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723530472; x=1724135272;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KYqCO05nh6hYks8s0W7RR6F8mCDuiymOaXkbv6QzZk=;
        b=GLLtlygw/Iw9cRhfegc8+t8cRSrFli8JKmlRaDmgcMka4zYq2daBbbe3lkzQPM/Wls
         N+FfJBe/77Kg9DPEAfFxKYVrtFuw4i6h7fuzmYjTZLTSPKULZ+sAT5TEFibhEJRwEyQF
         tBqnGvn7VzRyOErow6wqmnSv7qbFbjTZKf48xOYfNzAg57b7LYEMRVNQW50XdSg+i2H4
         72qATWZDbDO2pGGB+bwSbo6v7zzEhaLI5EvK355UTS2R+oHwEI4Uz0ISp+YMVzUqxVcH
         pTlRtXoEoMIDf+ko/d8OsQlQTlo0g1rOLONxVyP37dUyskGf9iXzc9jNhJa478eJA4ce
         zKsw==
X-Forwarded-Encrypted: i=1; AJvYcCWDUTmdEVsgsqrmhdb0NnS930/1sqDIU2na2lydAPbDroIVryjmfJ4FnU5MsfWKNHUwI/wn+72ods+7TrPJZQ==
X-Gm-Message-State: AOJu0YxqRFhFIDDMP5ciA+3/dTZP3FppYwW4C6GMJ1ju2cbQNfIVNxbJ
	8O+7zfIQ8pvBMF8yuZE11zrKF8M26nt2r2ZuyGN8ajrkPE+e6L/8VhGY5+dbyQQNoYuXB9gqPuE
	pM2xDYvP8IPhV96xMYYvfL6lAtA+rKpup
X-Google-Smtp-Source: AGHT+IGXzjaXptu2NX6jA0e0Dngg8we8EFwj8R3+JSKFwqph8jAnqlVAuTWXK7y7VQc2qa4vnjEJOBMebfswYRww1ms=
X-Received: by 2002:a17:90b:4b90:b0:2c9:8b33:318f with SMTP id
 98e67ed59e1d1-2d3925110f8mr2619213a91.11.1723530472225; Mon, 12 Aug 2024
 23:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <25273c09-ded5-4f43-82ee-956f66a8cd0e@linux.intel.com> <a474269f-f8b9-e7eb-90c5-fdbc4f3495a4@inria.fr>
In-Reply-To: <a474269f-f8b9-e7eb-90c5-fdbc4f3495a4@inria.fr>
From: Peter Senna Tschudin <peter.senna@gmail.com>
Date: Tue, 13 Aug 2024 08:27:41 +0200
Message-ID: <CA+MoWDqM33yLEsm2YB8WJeGmUunHaHXDHsT56pEOhLWK5-RHAQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Peter Senna Tschudin <peter.senna@linux.intel.com>, cocci@inria.fr
Content-Type: multipart/alternative; boundary="0000000000008e85a6061f8ab5a0"
Subject: Re: [cocci] Iterator macros
Reply-To: Peter Senna Tschudin <peter.senna@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1849
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/CA%2BMoWDqM33yLEsm2YB8WJeGmUunHaHXDHsT56pEOhLWK5-RHAQ%40mail.gmail.com>

--0000000000008e85a6061f8ab5a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Julia,



On Tue, Aug 13, 2024 at 8:19=E2=80=AFAM Julia Lawall <julia.lawall@inria.fr=
> wrote:

>
>
> On Tue, 13 Aug 2024, Peter Senna Tschudin wrote:
>
> > Dear List,
> >
> > I am trying to make changes to a macro iterator from igt-gpu-tools*, an=
d
> I am failing to use Coccinelle. My current attempt only captures about 1/=
2
> of call sites, and I am not really sure how to ask Coccinelle to make the
> changes I want. Here is the pattern I am trying to change:
> >
> >
> > From:
> >
> > const struct intel_execution_engine2 *e2;
> > ...
> > for_each_ctx_engine(i915, ctx, e2) {
> >     execbuf.flags =3D e2->flags;
> >     gem_execbuf(i915, &execbuf);
> > }
> >
> >
> > To:
> >
> > struct intel_engine_data ied;
> > ...
> > for_each_ctx_engine(i915, ctx, ied) {
> >     execbuf.flags =3D ied.current_engine->flags;
> >     gem_execbuf(i915, &execbuf);
> > }
> >
> > Changes I want:
> > 1. From `const struct intel_execution_engine2 *e2` to `struct
> intel_engine_data ied`.
> > 2. Replace the last argument of for_each_ctx_engine() following the
> change on previous step.
> > 3. Change references from `e2` to `ied.current_engine` inside the
> iterator statement.
> >
> > Here is my starting point that finds about half of the call sites:
> >
> > @r1@
> > iterator I =3D~ "for_each_ctx_engine";
> > statement S;
> > @@
> > * I(...)
> > S
> >
> > I assume that I should create other rules and import I from r1 as the
> > core of the changes I want. Can you point me to an example to help me
> > here?
>
> Are you just looking for
>
> iterator r.I;
>
> If you have only one iterator name, you don't need the regexp.  Just put
>
> iterator name for_each_ctx_engine;
>
Thank you! This is much faster but captures one instance less.


>
> julia
>
> >
> > Thank you,
> >
> > Peter
> >
> > * - https://gitlab.freedesktop.org/drm/igt-gpu-tools
> >
>


--=20
                         Peter

--0000000000008e85a6061f8ab5a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Julia,<br><div><br></div><div><br></di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Tue, Aug 13, 2024 at 8:19=E2=80=AFAM Julia Lawall &lt;<a href=3D"mailt=
o:julia.lawall@inria.fr">julia.lawall@inria.fr</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On Tue, 13 Aug 2024, Peter Senna Tschudin wrote:<br>
<br>
&gt; Dear List,<br>
&gt;<br>
&gt; I am trying to make changes to a macro iterator from igt-gpu-tools*, a=
nd I am failing to use Coccinelle. My current attempt only captures about 1=
/2 of call sites, and I am not really sure how to ask Coccinelle to make th=
e changes I want. Here is the pattern I am trying to change:<br>
&gt;<br>
&gt;<br>
&gt; From:<br>
&gt;<br>
&gt; const struct intel_execution_engine2 *e2;<br>
&gt; ...<br>
&gt; for_each_ctx_engine(i915, ctx, e2) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0execbuf.flags =3D e2-&gt;flags;<br>
&gt;=C2=A0 =C2=A0 =C2=A0gem_execbuf(i915, &amp;execbuf);<br>
&gt; }<br>
&gt;<br>
&gt;<br>
&gt; To:<br>
&gt;<br>
&gt; struct intel_engine_data ied;<br>
&gt; ...<br>
&gt; for_each_ctx_engine(i915, ctx, ied) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0execbuf.flags =3D ied.current_engine-&gt;flags;<br>
&gt;=C2=A0 =C2=A0 =C2=A0gem_execbuf(i915, &amp;execbuf);<br>
&gt; }<br>
&gt;<br>
&gt; Changes I want:<br>
&gt; 1. From `const struct intel_execution_engine2 *e2` to `struct intel_en=
gine_data ied`.<br>
&gt; 2. Replace the last argument of for_each_ctx_engine() following the ch=
ange on previous step.<br>
&gt; 3. Change references from `e2` to `ied.current_engine` inside the iter=
ator statement.<br>
&gt;<br>
&gt; Here is my starting point that finds about half of the call sites:<br>
&gt;<br>
&gt; @r1@<br>
&gt; iterator I =3D~ &quot;for_each_ctx_engine&quot;;<br>
&gt; statement S;<br>
&gt; @@<br>
&gt; * I(...)<br>
&gt; S<br>
&gt;<br>
&gt; I assume that I should create other rules and import I from r1 as the<=
br>
&gt; core of the changes I want. Can you point me to an example to help me<=
br>
&gt; here?<br>
<br>
Are you just looking for<br>
<br>
iterator r.I;<br>
<br>
If you have only one iterator name, you don&#39;t need the regexp.=C2=A0 Ju=
st put<br>
<br>
iterator name for_each_ctx_engine;<br></blockquote><div>Thank you! This is =
much faster but captures one instance less.<br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
julia<br>
<br>
&gt;<br>
&gt; Thank you,<br>
&gt;<br>
&gt; Peter<br>
&gt;<br>
&gt; * - <a href=3D"https://gitlab.freedesktop.org/drm/igt-gpu-tools" rel=
=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/drm/igt-gp=
u-tools</a><br>
&gt;<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0Peter</div></div></div>

--0000000000008e85a6061f8ab5a0--
